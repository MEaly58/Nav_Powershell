#requires -version 5.0
<#!
.SYNOPSIS
	Find least used Nav application server and send users to that server
.DESCRIPTION
	This script was written using Nav 16 as the base.DESCRIPTION
	It will query sql server for the least used server and change the shortcut to point to that server
.INPUTS
  None
.NOTES
  Version:  1.0
  File Name: Nav Load balancer
	Author:
  This script copies in a shortcut that points towards:
  "C:\Program Files (x86)\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Client.exe" -settings:\\path\to\shortcuts\nav16a-ClientUserSettings.config

  The config file looks like this:

  <?xml version="1.0" encoding="utf-8"?>
  <configuration>
    <appSettings>
      <add key="Server" value="nav16c.full.domain" />
      <add key="ClientServicesPort" value="7046" />
      <add key="ServerInstance" value="DynamicsNAV90" />
      <add key="TenantId" value="" />
      <add key="ClientServicesProtectionLevel" value="EncryptAndSign" />
      <add key="UrlHistory" value="nav16c.full.domain:7046/DynamicsNAV90" />
      <add key="ClientServicesCompressionThreshold" value="64" />
      <add key="ClientServicesChunkSize" value="28" />
      <add key="ClientServicesKeepAliveInterval" value="120" />
      <add key="MaxNoOfXMLRecordsToSend" value="5000" />
      <add key="MaxImageSize" value="26214400" />
      <add key="ClientServicesCredentialType" value="Windows" />
      <add key="ACSUri" value="" />
      <add key="AllowNtlm" value="true" />
      <add key="ServicePrincipalNameRequired" value="False" />
      <add key="ServicesCertificateValidationEnabled" value="true" />
      <add key="DnsIdentity" value="" />
      <add key="HelpServer" value="nav16c.full.domain" />
      <add key="HelpServerPort" value="49000" />
      <add key="ProductName" value="" />
      <add key="UnknownSpnHint" value="(net.tcp://nav16c.full.domain:7046/DynamicsNAV90/Service)=Spn;" />
    </appSettings>
  </configuration>
.LINK
	https://github.com/MEaly58
#>
#variables
$SqlServer = “IP Address of SQL Server”
$SqlCatalog = “databaseName”
$SqlQuery = @"

SELECT TOP 1 COUNT(*) as [Active Sessions], act.[Server Computer Name], act.[Server Instance Name] FROM [navdb].[dbo].[Active Session] as act
INNER JOIN [navdb].[dbo].[Server Instance] as si
  ON act.[Server Computer Name] = si.[Server Computer Name]
WHERE act.[Server Instance Name] = 'dynamicsnav90'
  AND act.[Server Computer Name] <> 'nav16services.full.domain.name'
  AND si.[Status] = 0
GROUP BY act.[Server Computer Name], act.[Server Instance Name]
ORDER BY [Active Sessions] ASC, act.[Server Computer Name] ASC;
"@

#Run SQL Command
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = “Server = $SqlServer; Database = $SqlCatalog; Integrated Security = True”
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$table = $DataSet.Tables[0]
$DataSet.Tables | Format-Table -Auto
$dte = Get-Date -date $(Get-Date).AddMinutes(15) -format t
$timestamp = $(Get-Date).toString("hh:mmtt on M/d/yyyy");
$serverName = '';
$resultCount = 0;

for ($j = 0; $j -lt $table.Rows.Count; $j++)
{
  $serverName = $table.Rows[$j][1].ToString();
  if ($serverName.IndexOf('l')) {
    $serverName = $serverName.Substring(0,$serverName.IndexOf('.'));
  }
  $resultCount++;
}

if($resultCount -gt 0)
{
    Copy-Item -Path $("\\path\to\shortcuts\$serverName-ClientUserSettings.lnk") -Destination "\\path\to\link\Dynamics NAV 2016.lnk"
    #write-host $serverName;
}
else
{
    #write-host 'No Server Name';
}
