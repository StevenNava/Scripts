$serverList = Get-Content C:\Scripts\serverList.txt
$results = @()
$CCMSetupProgress = @()

Write-Host "####################################################"
Write-Host "# Starting log check on $($serverList.count) machines."
Write-Host "####################################################"
# Loop to Check Logs
forEach ($server in $serverList) {
    try {
    # Ping servers

    # If pings, Get last line in CCM Log
    Write-Host "`tProcessing $server..."
    $log = "\\$server\C$\Windows\ccmsetup\Logs\ccmsetup.log"
    $logLastLine = Get-Content $log -Tail 1 -ErrorAction Stop
    $logLastLine = ($logLastLine -split "LOG")[1]

    If ($logLastLine -like "*CcmSetup is exiting*") {
        $results += [pscustomobject] @{
            "Server Name" = $server
            "Exit Code" = if ($logLastLine -like "*7*") { 7 } elseif ($logLastLine -like "*0*") { 0 } else { "Undefined" }
        }
    } Else {
        $CCMSetupProgress += [pscustomobject] @{
            "Server Name" = $server
            "Last Line" = $logLastLine
        }
    }
    } catch {
        Write-Host "`tError connecting to $($server): $($Error[0])" -ForegroundColor Red
    }
}

Write-Host "####################################################"
Write-Host "# Generating reports for machines."
Write-Host "####################################################"
$results | Where { $_."Exit Code" -eq 7 } | Export-Csv C:\Scripts\CCMSetupError7.csv -NoTypeInformation
$results | Where { $_."Exit Code" -eq 0 } | Export-Csv C:\Scripts\CCMSetupSuccess.csv -NoTypeInformation
$CCMSetupProgress | Export-Csv C:\Scripts\CCMSetupNoExitCode.csv -NoTypeInformation

Write-Host "`tThere are $(($results | Where { $_."Exit Code" -eq 7 }).count) machines with exit code 7."
Write-Host "`tThere are $(($results | Where { $_."Exit Code" -eq 0 }).count) machines with exit code 0."
Write-Host "`tThere are $($CCMSetupProgress.count) machines with no proper exit code."

Write-Host "####################################################"
Write-Host "# Log check completed successfully."
Write-Host "####################################################"