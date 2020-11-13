param([string]$ComputerName = 'localhost' ,[datetime]$StartTimestamp, [datetime]$EndTimestamp,[string]$LogfileExtension = 'log')

## Define drives to look for log Logfiles
if($ComputerName -eq 'localhost'){
  $Location = (Get-CimInstance -ClassName Win32_LogicalDisk - Filter "DriveType = '3'").DeviceID
}
else {
  ##Shares
  $Share = Get-CimInstance -CmoputerName $ComputerName -Class Win32_Share | where $_.Path -math '^\w{1}:\\$'
  [System.Collections.ArrayList]$Locations =@()
  foreach($Share in $Shares){
    $Share = "\\$ComputerName\$($Share.Name)"
      if(!(Test-Path $Share)){
        Write-Warning "Unable to access '$Share' share on '$ComputerName'"
      }
      else{
        $Lcoations.Add($Share) | Out-Null
      }
  }
}

#Build hash table
$GciParams = @{
  Path = $Lcoations
  Filters =''".LogFileExtension"
  Recurse = $true
  Force = $true
  ErrorAction = 'SilentlyContinue'
  File = $true
}

##Building the where-Object
$WhereFilter = {($_.LastWriteTime -ge $StartTimestamp) -and ($_$LastWriteTime -le $EndTimestamp) -and ($_.Length -ne 0)}

##Find our Log Filters
Get-ChildItem @GciParams | Where-Object $WhereFilter
