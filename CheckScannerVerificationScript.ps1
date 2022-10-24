
#  _____   ___  _____       _            _____           
# |  __ \ /   |/  ___|     | |          |  _  |          
# | |  \// /| |\ `--.    __| | _____   _| | | |_ __  ___ 
# | | __/ /_| | `--. \  / _` |/ _ \ \ / / | | | '_ \/ __|
# | |_\ \___  |/\__/ / | (_| |  __/\ V /\ \_/ / |_) \__ \
#  \____/   |_/\____/   \__,_|\___| \_/  \___/| .__/|___/
#                                             | |        
#                                             |_| 
#
# https://meet.google.com/linkredirect?authuser=0&dest=https%3A%2F%2Fdigitalcheck.sharefile.com%2Fd-sb77b333626c459d9
# 
# Customized by Brian Morrison, Kroger Enterprise Desktop Engineering
$logfilepath="C:\ProgramData\DSE\logs\DigitalCheckScanner.log"
$scannerIP = "192.168.2.1"
$scannerName = "SSE100000001"
Start-Transcript -Force -IncludeInvocationHeader -Path $logfilepath
Write-Output (Get-Date)
Write-Output "Install and configuration starting..."


## ===============================
## Check for Scanner if USB
## ===============================
if( $scannerIP -eq "192.168.2.1" ) {
    Write-Output "USB scanner - Verifying RNDIS driver is present."
    $scannerDeviceName = "USB Ethernet/RNDIS Gadget"
    $scannerNetworkAdapterName = $(Get-NetAdapter -Physical | select Name,Status,InterfaceDescription | where { $_.InterfaceDescription -match $scannerDeviceName }).Name
    if( $scannerNetworkAdapterName )
    {
        Write-Output "Adapter detected successfully."
        Write-Host("   ...adapter detected @ $scannerNetworkAdapterName")
    } else { 
        PowerShell -Command {exit} -WindowStyle Normal # Unhide the window
        write-host "... no RDNIS adapters detected."
        Write-Host ""
        Write-Host "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Yellow
        Write-Host "                    !!! WARNING !!!                      " -ForegroundColor Yellow
        Write-Host "   Scanner was not detected via USB, install may fail.   " -ForegroundColor Yellow
        Write-Host "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Yellow
        Write-Host ""
    }
} else {
    Write-Output "Network Scanner configuration detected."
}


## ===============================
## Validate Scanner Connectivity
## ===============================
Write-Output "Validating Network Connectivity to Scanner"
$connectionTestResult = "Error"

try {
    $result = Invoke-WebRequest -ErrorAction Stop 
                                -Uri "https://$scannerIP/securelink"`
                                -Method "POST" `
                                -Headers @{"Authorization"="Basic YWRtaW46MzZaOFJoNnRUQm4="} `
                                -ContentType "text/plain" `
                                -UseBasicParsing `
                                -Body "`"Command`": `"Connect`",    `"Callback`": `"Callback`",    `"MessageId`": `"42`",    `"Exclusive`": `"false`"}" 

    Write-Output "   ...Scanner is already configured for SSL and HTTPs. Skipping SSL configuration. Scanner is already properly setup."
    Write-Output (Get-Date)
    Write-Output "Install and configuration successful!"        
    Write-Output "   ...stopping transcript"
    Stop-Transcript
    exit 0
} catch {
    try {
        $result = Invoke-WebRequest -Uri "http://$scannerIP/securelink"`
                                    -Method "POST" `
                                    -Headers @{"Authorization"="Basic YWRtaW46MzZaOFJoNnRUQm4="} `
                                    -ContentType "text/plain" `
                                    -UseBasicParsing `
                                    -Body ([System.Text.Encoding]::UTF8.GetBytes("{$([char]10)    `"Command`": `"Connect`",$([char]10)    `"Callback`": `"Callback`",$([char]10)    `"MessageId`": `"42`",$([char]10)    `"Exclusive`": `"false`"$([char]10)}"))

        $connectionTestResult = $($result.Content | ConvertFrom-Json).ScannerModel
    }
    catch {
        $connectionTestResult = "Error"
    }
    if( $connectionTestResult -ne "Error") {
        Write-Output "   ...found $connectionTestResult @ $scannerIP"
        Write-Output "   ...success"
    } else {
        Write-Output "   !!! Error connecting to $scannerIP, cannot continue"
	    Stop-Transcript
	    exit
    }
}

## ===============================
## Verify scanner connectivity
## ===============================
# TODO: test for existing https if no http?
Write-Output "Testing for scanner at $scannerIP is accessable."
$scannerURL = "http://$scannerIP/securelink"
$messageObject = [PSCustomObject]@{
    Command = 'GetNetworkInfo'
}
$messageJSON = ConvertTo-Json -Depth 5 $messageObject -compress

try {
    $result = ""
    $result = Invoke-RestMethod -Method POST `
                                -Uri $scannerURL `
                                -Body $messageJSON `
                                -ContentType application/json `
                                -ErrorAction SilentlyContinue
}
catch {}
#validate
if( $result.Copyright -like "Digital Check Corp*") {
    Write-Output "   ...success($($result.DeviceName))"
}
else {
    Write-Output "   !!! Error communicating with the scanner at $scannerIP, cannot continue."
	Stop-Transcript
	exit
} 

## =============================
## Reboot Scanner.
## =============================
##
Write-Output "Restarting the scanner."
Start-Sleep -Seconds 5  #implementing a delay to let scanner settle.
$scannerURL = "http://$scannerIP/admin/reboot"
try {
$result = ""
    $result = Invoke-WebRequest -Uri $scannerURL `
                    -Method "GET" `
                    -UseBasicParsing
}
catch {}

if( $result.Content -like "*Rebooting HTTPS.*" ) {
    Write-Output "   ...success"
}
else {
    Write-Output "   !!! Error restarting the scanner at $scannerIP, cannot continue."
	Stop-Transcript
	exit
}

## =============================
## Complete!!
## =============================
##
Write-Output ""
Write-Output (Get-Date)
Write-Output "Install and configuration successful!"
Stop-Transcript
Exit






# SIG # Begin signature block
# MIIMSQYJKoZIhvcNAQcCoIIMOjCCDDYCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUmZeRAlLj+BId/9PDv7fDnoAU
# Xo6gggmoMIIElDCCA3ygAwIBAgIOSBtqBybS6D8mAtSCWs0wDQYJKoZIhvcNAQEL
# BQAwTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoT
# Ckdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAw
# WhcNMjQwNjE1MDAwMDAwWjBaMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
# U2lnbiBudi1zYTEwMC4GA1UEAxMnR2xvYmFsU2lnbiBDb2RlU2lnbmluZyBDQSAt
# IFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjYVV
# I6kfU6/J7TbCKbVu2PlC9SGLh/BDoS/AP5fjGEfUlk6Iq8Zj6bZJFYXx2Zt7G/3Y
# SsxtToZAF817ukcotdYUQAyG7h5LM/MsVe4hjNq2wf6wTjquUZ+lFOMQ5pPK+vld
# sZCH7/g1LfyiXCbuexWLH9nDoZc1QbMw/XITrZGXOs5ynQYKdTwfmOPLGC+MnwhK
# kQrZ2TXZg5J2Yl7fg67k1gFOzPM8cGFYNx8U42qgr2v02dJsLBkwXaBvUt/RnMng
# Ddl1EWWW2UO0p5A5rkccVMuxlW4l3o7xEhzw127nFE2zGmXWhEpX7gSvYjjFEJtD
# jlK4PrauniyX/4507wIDAQABo4IBZDCCAWAwDgYDVR0PAQH/BAQDAgEGMB0GA1Ud
# JQQWMBQGCCsGAQUFBwMDBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
# A1UdDgQWBBQPOueslJF0LZYCc4OtnC5JPxmqVDAfBgNVHSMEGDAWgBSP8Et/qC5F
# JK5NUPpjmove4t0bvDA+BggrBgEFBQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6
# Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMwNgYDVR0fBC8wLTAroCmgJ4Yl
# aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBjBgNVHSAEXDBa
# MAsGCSsGAQQBoDIBMjAIBgZngQwBBAEwQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUH
# AgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMA0GCSqG
# SIb3DQEBCwUAA4IBAQAVhCgM7aHDGYLbYydB18xjfda8zzabz9JdTAKLWBoWCHqx
# mJl/2DOKXJ5iCprqkMLFYwQL6IdYBgAHglnDqJQy2eAUTaDVI+DH3brwaeJKRWUt
# TUmQeGYyDrBowLCIsI7tXAb4XBBIPyNzujtThFKAzfCzFcgRCosFeEZZCNS+t/9L
# 9ZxqTJx2ohGFRYzUN+5Q3eEzNKmhHzoL8VZEim+zM9CxjtEMYAfuMsLwJG+/r/uB
# AXZnxKPo4KvcM1Uo42dHPOtqpN+U6fSmwIHRUphRptYCtzzqSu/QumXSN4NTS35n
# fIxA9gccsK8EBtz4bEaIcpzrTp3DsLlUo7lOl8oUMIIFDDCCA/SgAwIBAgIMfXTZ
# UtA7p5SOMQ+8MA0GCSqGSIb3DQEBCwUAMFoxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
# ExBHbG9iYWxTaWduIG52LXNhMTAwLgYDVQQDEydHbG9iYWxTaWduIENvZGVTaWdu
# aW5nIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwNzI0MTgyNTQzWhcNMjEwNzI1MTgy
# NTQzWjCBhTELMAkGA1UEBhMCVVMxEDAOBgNVBAgTB0Zsb3JpZGExEDAOBgNVBAcT
# B0p1cGl0ZXIxKDAmBgNVBAoTH0c0UyBSZXRhaWwgU29sdXRpb25zIChVU0EpIElu
# Yy4xKDAmBgNVBAMTH0c0UyBSZXRhaWwgU29sdXRpb25zIChVU0EpIEluYy4wggEi
# MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCXL5d8QwXjzIamGQMbfPQ5Pa18
# tywnEsIQVLwFiyV1BIskf2tBTYHSxTCVVEjspi6D21tdIUHohhdUVLHdNMVJyLtT
# lAC43m7iftdFjV0t1KocMa2Wk+RiSRq2gnJAmvv03pEYF5byWwh0De4+znJhWEYZ
# nSmk7u/VNhnvjzAsiRm+L3+jPcLZHeGmyVJoxiwKu2YOLhvR8XbV54GarM7geOEc
# Etad/OtnsogZHK6UByVHqVy01SdFiDE8LPyjy5W7+MiVnYEQN/3cDEjZjX9WJxLG
# h+UqqTY42jjOqYl4CFer5CYdbvnqN1W0WsPs3PDfmgeDse6mEji0oHyWyKc9AgMB
# AAGjggGkMIIBoDAOBgNVHQ8BAf8EBAMCB4AwgZQGCCsGAQUFBwEBBIGHMIGEMEgG
# CCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9n
# c2NvZGVzaWduc2hhMmczb2NzcC5jcnQwOAYIKwYBBQUHMAGGLGh0dHA6Ly9vY3Nw
# Mi5nbG9iYWxzaWduLmNvbS9nc2NvZGVzaWduc2hhMmczMFYGA1UdIARPME0wQQYJ
# KwYBBAGgMgEyMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24u
# Y29tL3JlcG9zaXRvcnkvMAgGBmeBDAEEATAJBgNVHRMEAjAAMD8GA1UdHwQ4MDYw
# NKAyoDCGLmh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3Njb2Rlc2lnbnNoYTJn
# My5jcmwwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHwYDVR0jBBgwFoAUDzrnrJSRdC2W
# AnODrZwuST8ZqlQwHQYDVR0OBBYEFO8rLmzUObunIUxPF1sfYGdF/9AoMA0GCSqG
# SIb3DQEBCwUAA4IBAQAfBvfwLcSwXJk7iDnMpKQGGOX92cKj3JbI5Rq00mLuPIv8
# bAf5urvn9i+lVXbSWLvi4q4QmT7POOperaTGwlZWCFS1HCANFT++RcNl/UqsmEGd
# NKRWOHOtUw5tcCvn0pF53iI0dJhYbaSdGotmrt6c5rmH3CoDL0NMWUn6ehT/KumN
# NYyx2bigF+s0kl1OSICADVYD3z+gzwfi0A1aQeCX5iYUVL6cvqpGsZZ/cRzapaof
# jaL7RFLO8YDZqnlZAOmbk/eFC9Wnew3ezbtfQnq15gJt+i4LvPzjS+d0iL8fMy8y
# Qf8ikLkHZMQ96mSKWWuufhi1nP+pK+E6FxPmld7WMYICCzCCAgcCAQEwajBaMQsw
# CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEwMC4GA1UEAxMn
# R2xvYmFsU2lnbiBDb2RlU2lnbmluZyBDQSAtIFNIQTI1NiAtIEczAgx9dNlS0Dun
# lI4xD7wwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJ
# KoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQB
# gjcCARUwIwYJKoZIhvcNAQkEMRYEFH8PBTRbzj0zwY8qZ2w0/b+ERsoQMA0GCSqG
# SIb3DQEBAQUABIIBAHzOzbmmYbFWuDrmwRxsryKYAHxGXqdpL4ZiEU6yXllRcV87
# 4vm+FPqRtIy8pffkPIIUT04PkDDU4gmefTveh1lkXIGTvWUJIXa+9sT0le6Aje0L
# /oA3uq0KJDFNmoVoej+F+fB5qY3UnvM9ZN+h0M+tDWrNGIjwWY6E7tzYVdp5moKE
# flCWsnYl/JnH6rNdj022wOKrJAi7lcnWZPFKI0h87RMOW7HYLeBLSTxsS48DULmr
# SS820z0waqz3x2rRkklq41vRgVJ3ZnAiDav883zbizuIbq6fsIO9MwC28tplMNHb
# mtMiOoNiGx7kg6knynvSmnFDSfiyAUR3LsWyX74=
# SIG # End signature block
