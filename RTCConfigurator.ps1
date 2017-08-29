#Open the Configureator for RTC
#Varaiables
#Promt user for Role to edit
$Profile = Read-Host -Promt "What Role would you llike to edit?"
#Change to the Dynamics Nav dirctory
cd "C:\Program Files\Microsoft Dynamics NAV\60\RoleTailored Client"
cd ./Microsoft.Dynamics.Nav.Client.exe -configure -profile:"$profile"
#Make your changes to the profile
#https://msdn.microsoft.com/en-us/library/dd354992.aspx
