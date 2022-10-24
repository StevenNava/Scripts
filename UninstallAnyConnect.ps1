$AnyConnectApps = Get-WmiObject -Class Win32_Product | Select -Property name | Where { $_.Name -like '*AnyConnect*' }
$AnyConnectApps | ForEach {
    $_.Uninstall()
}