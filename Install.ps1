import-module \\InstallMediaShare\NavInstallationTools.psm1
#Install Nav
install-navcomponent -configfile \\Share\navinstallmedia\ConfigFile.xml

#Copy Over short cut
$TargetFile = "\\Shortcut\Nav16\"
$ShortcutFile = "$env:Public\Desktop\nav16.lnk"
$Icon = "C:\Program Files (x86)\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Client.exe"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.IconLocation = $Icon
$Shortcut.Save()
