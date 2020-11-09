#MicrosoftDynamicsNavServer$DynamicsNAV110
$Service = 'MicrosoftDynamicsNavServer$DynamicsNAV110'
$Computers = Get-Content "C:\Path\File.txt"
Invoke-Command -ComputerName $Computers {Restart-Service $Service}
