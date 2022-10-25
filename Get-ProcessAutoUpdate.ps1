Clear-Host
$RefreshSeconds = 3

While ($true) {
    $Output = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 25 -Property ProcessName, CPU, Id, WS | Out-String
    [Console]::CursorVisible = $false
    $host.UI.RawUI.CursorPosition = @{X=0; Y=0}
    $Output
    [Console]::CursorVisible = $true
    Start-Sleep -Seconds $RefreshSeconds
}
Clear-Host
