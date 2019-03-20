#Open the Configureator for RTC
#Varaiables
#Promt user for Role to edit
$Profile = Read-Host -Promt "What Role would you like to edit?"
#Change to the Dynamics Nav dirctory
cd "${env:ProgramFiles}\Microsoft Dynamics NAV\110\RoleTailored Client"
./Microsoft.Dynamics.Nav.Client.exe -configure -profile:"$profile"
#Make your changes to the profile
#https://msdn.microsoft.com/en-us/library/dd354992.aspx
