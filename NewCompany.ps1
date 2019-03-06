#Import the NavAdmin Module
Import-Module “${env:ProgramFiles}\Microsoft Dynamics NAV\110\Service\NAVAdminTool.ps1”
#Nav version changes the 110 to a differnt number
#Replace $instanceName with your service instance name 
New-NAVCompany -ServerInstance '$instanceName' -Tenant CRONUS -CompanyName 'CRONUS Subsidiary'
