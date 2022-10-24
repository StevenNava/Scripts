## ===============================
## Log Info
## ===============================
$logfilepath="C:\ProgramData\DSE\logs\DigitalCheckScanner.log"
Start-Transcript -Force -IncludeInvocationHeader -Path $logfilepath
Write-Output (Get-Date)
Write-Output "Certificate install and configuration starting..."

## ===============================
## Certificate Info
## ===============================
$certName = "United_20210202"
$certPubKey = "-----BEGIN CERTIFICATE-----MIIDpDCCAoygAwIBAgIUNwz5s1fK2Oq+fHHudgU6RRWNhq4wDQYJKoZIhvcNAQELBQAwUDEQMA4GA1UEAwwHRzRTIFVTQTELMAkGA1UEBhMCVVMxCzAJBgNVBAgMAkZMMRAwDgYDVQQHDAdKdXBpdGVyMRAwDgYDVQQKDAdHNFMgVVNBMB4XDTIxMDIwMjIwMDczMVoXDTMxMDEzMTIwMDczMVowUDEQMA4GA1UEAwwHRzRTIFVTQTELMAkGA1UEBhMCVVMxCzAJBgNVBAgMAkZMMRAwDgYDVQQHDAdKdXBpdGVyMRAwDgYDVQQKDAdHNFMgVVNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA02gR8NjpBD/M1b1n2SOUucbIFCaLS1oyjrmhIjQcdkSphz6ZQLn7RQ2+SzlivwnN7JHcDecdDiZDav5F93rnNzPxS6b3ZmMLlFQPk/a5hLzhGa37oYS/yjkkFyzgLg6QAKqC36rM+GR4e4OphsRCVNYvPgAw4YaifdZmIvfo31GEIVS98IKGeAsU9sc8Ys73GiZJMfYLjhGb+1xsJmLzc6/dLZIRJc5KeOWHZnismhV4VD/W6E67g1ADohhy98Wd/fElfA+YZk7sPrJ6F534zJ9QQZipkAUR+fdejeDn+BMLumK9KuIUGrWWUXrs6ENemKJGxvpfbZHBh47+tcZcaQIDAQABo3YwdDAdBgNVHQ4EFgQUonJpuJCT+k7hseh/CyYSMK8TdVowHwYDVR0jBBgwFoAUonJpuJCT+k7hseh/CyYSMK8TdVowDAYDVR0TAQH/BAIwADAkBgNVHREEHTAbhwTAqAIBhwQKCgABgg1TU0UwMDAwMDAwMDAwMA0GCSqGSIb3DQEBCwUAA4IBAQADuZWFF7LoM9dV7NwGJEQTbf1x4ZMb4Nk0ppnxO6WfKx8NT6rVGhi2wH989Ek2ikF785FBQaGI5CXyob4tLws+DfFPqTzX2tfpP12dk+1pwQVdLC/SpnmfU30MjhXx7wncXknambK/Fv5r2u9qdg+Y3zkMmWMbslqwH8kjHYxIqB9R1FRv3dOHpvIP+CMFJQ6SGKDHVA9wWHr1gef+E9pLuQ9Azx6UYpkiuC16OJM8FK7QwZPRbDKq5N6HNbBcTEgtb+xboYELOyc/PNCDoMHVHqN5YvPIxWFNwI8YiSMMRYEVIVjASgDIZeAsWZUykqDNbd4hmEHk7PXi0PUSsNgB-----END CERTIFICATE-----"
$certPrivKey = "-----BEGIN RSA PRIVATE KEY-----MIIEowIBAAKCAQEA02gR8NjpBD/M1b1n2SOUucbIFCaLS1oyjrmhIjQcdkSphz6ZQLn7RQ2+SzlivwnN7JHcDecdDiZDav5F93rnNzPxS6b3ZmMLlFQPk/a5hLzhGa37oYS/yjkkFyzgLg6QAKqC36rM+GR4e4OphsRCVNYvPgAw4YaifdZmIvfo31GEIVS98IKGeAsU9sc8Ys73GiZJMfYLjhGb+1xsJmLzc6/dLZIRJc5KeOWHZnismhV4VD/W6E67g1ADohhy98Wd/fElfA+YZk7sPrJ6F534zJ9QQZipkAUR+fdejeDn+BMLumK9KuIUGrWWUXrs6ENemKJGxvpfbZHBh47+tcZcaQIDAQABAoIBAF3aevSI59H6HQ7a+oqc0D81r8e6YObAEWfpo06TAfvDedvP/6uLpbC/bDbrMBqN2Lzo+F+3td99Pzr1zcwT5ShNyBcE9hqfaBmexBe1ViFG1UxYQDkxvQ+jFJGxW4k279lL2bRAmKTBvfdfuVhaMvSE7g5BeXH2GpdxIoDtvJW/RTA+Jto/SVBizjV/+HXpBRfjJST/rVYWGnupaaZEWRv8x66tygP3GI9ILlLnFdRKv6A1We7GUz6r2vFq+SpdM9Gh+AL5rhFMQA/EiWL5PGOx1G6xFLz9XWSsvXjHQskJqyjx29M8LAfqzVtK6l3Q25GGnJwzsBhDC78JVRqHCjECgYEA6fj4NUm5rq5g77XnhT8fjjFte73EaGX4pTVe6wMB9C9EfLj/f5gKV5nuYibPcFLmFeaMSn4j24hWZ8k2txuDkYXc9JLfAvXg0GMSv2AWoHQD7IHjX3wEEkqi9EN1XaLudnpW+aV7npJcioMACmUHPCKOay6e6/cPjO6GzKjj+mUCgYEA5087PQpMHZLY59ycQ7Ee/uTCpek10FThHPrNJMoJSaqpeznYbvWN/XYaombLXAMK2k2hTHJUmTZCnZHA2QQ6QFtYDx2HDH7UtUFgWbuCUVxKr6+3XvK8IKLKU30Rb6JvoDwEFZ8cOLt82svvTeLkoKZUEelbI/Uu49DMQdGmV7UCgYAvDb79GIKbOr6L9s1E4tj5w77878EcLcW/k+gu4z/1V7wySRI5Gt6Zl391hdCaClHzfZYhNRUJBXY7ESBL2uCu13kERrVK5x/7SLFwg2aJhktzuPt9LHe1JgV3kkl8N1Q1x4zOUBV4Yn7x7D6J2J+H3Hs/2vRjCCC8ewvpBN40cQKBgDapG4eWKlyGuik4kdjRP1DewDyyupvLoxLVFatO7xjwcnKDPekir/YodazQ+9d3hJYH6EkHb4RxNRbFPbxK6nUQ4ONZh/Nk+WEH3Pv3epk9ZQzVSlDurZRMw+Es2fT2fshvxktRuTqS27Nco+VU69Am3hEJgxchNn5xdgNLxrJNAoGBAMs81MVcm3SCXaj4uWL8ExmjVuwh/WyOUnVk7fE/BIZmYiurgmHLbMhEyYzkCvMay34vWa9WE5rZ4dHwkcjX3CpHUpWG807MCk9I8iyBI51nHiG6eHaGIdKpuLRkNxsKcyfXvV19b90x1WGbN458buSmakQtnd3xBEGVZvU/fLhY-----END RSA PRIVATE KEY-----"
$certPubKeyUTF8 = "-----BEGIN CERTIFICATE-----$([char]13)$([char]10)MIIDpDCCAoygAwIBAgIUNwz5s1fK2Oq+fHHudgU6RRWNhq4wDQYJKoZIhvcNAQEL$([char]13)$([char]10)BQAwUDEQMA4GA1UEAwwHRzRTIFVTQTELMAkGA1UEBhMCVVMxCzAJBgNVBAgMAkZM$([char]13)$([char]10)MRAwDgYDVQQHDAdKdXBpdGVyMRAwDgYDVQQKDAdHNFMgVVNBMB4XDTIxMDIwMjIw$([char]13)$([char]10)MDczMVoXDTMxMDEzMTIwMDczMVowUDEQMA4GA1UEAwwHRzRTIFVTQTELMAkGA1UE$([char]13)$([char]10)BhMCVVMxCzAJBgNVBAgMAkZMMRAwDgYDVQQHDAdKdXBpdGVyMRAwDgYDVQQKDAdH$([char]13)$([char]10)NFMgVVNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA02gR8NjpBD/M$([char]13)$([char]10)1b1n2SOUucbIFCaLS1oyjrmhIjQcdkSphz6ZQLn7RQ2+SzlivwnN7JHcDecdDiZD$([char]13)$([char]10)av5F93rnNzPxS6b3ZmMLlFQPk/a5hLzhGa37oYS/yjkkFyzgLg6QAKqC36rM+GR4$([char]13)$([char]10)e4OphsRCVNYvPgAw4YaifdZmIvfo31GEIVS98IKGeAsU9sc8Ys73GiZJMfYLjhGb$([char]13)$([char]10)+1xsJmLzc6/dLZIRJc5KeOWHZnismhV4VD/W6E67g1ADohhy98Wd/fElfA+YZk7s$([char]13)$([char]10)PrJ6F534zJ9QQZipkAUR+fdejeDn+BMLumK9KuIUGrWWUXrs6ENemKJGxvpfbZHB$([char]13)$([char]10)h47+tcZcaQIDAQABo3YwdDAdBgNVHQ4EFgQUonJpuJCT+k7hseh/CyYSMK8TdVow$([char]13)$([char]10)HwYDVR0jBBgwFoAUonJpuJCT+k7hseh/CyYSMK8TdVowDAYDVR0TAQH/BAIwADAk$([char]13)$([char]10)BgNVHREEHTAbhwTAqAIBhwQKCgABgg1TU0UwMDAwMDAwMDAwMA0GCSqGSIb3DQEB$([char]13)$([char]10)CwUAA4IBAQADuZWFF7LoM9dV7NwGJEQTbf1x4ZMb4Nk0ppnxO6WfKx8NT6rVGhi2$([char]13)$([char]10)wH989Ek2ikF785FBQaGI5CXyob4tLws+DfFPqTzX2tfpP12dk+1pwQVdLC/Spnmf$([char]13)$([char]10)U30MjhXx7wncXknambK/Fv5r2u9qdg+Y3zkMmWMbslqwH8kjHYxIqB9R1FRv3dOH$([char]13)$([char]10)pvIP+CMFJQ6SGKDHVA9wWHr1gef+E9pLuQ9Azx6UYpkiuC16OJM8FK7QwZPRbDKq$([char]13)$([char]10)5N6HNbBcTEgtb+xboYELOyc/PNCDoMHVHqN5YvPIxWFNwI8YiSMMRYEVIVjASgDI$([char]13)$([char]10)ZeAsWZUykqDNbd4hmEHk7PXi0PUSsNgB$([char]13)$([char]10)-----END CERTIFICATE-----$([char]13)$([char]10)"
$certPrivKeyUTF8 = "-----BEGIN RSA PRIVATE KEY-----$([char]13)$([char]10)MIIEowIBAAKCAQEA02gR8NjpBD/M1b1n2SOUucbIFCaLS1oyjrmhIjQcdkSphz6Z$([char]13)$([char]10)QLn7RQ2+SzlivwnN7JHcDecdDiZDav5F93rnNzPxS6b3ZmMLlFQPk/a5hLzhGa37$([char]13)$([char]10)oYS/yjkkFyzgLg6QAKqC36rM+GR4e4OphsRCVNYvPgAw4YaifdZmIvfo31GEIVS9$([char]13)$([char]10)8IKGeAsU9sc8Ys73GiZJMfYLjhGb+1xsJmLzc6/dLZIRJc5KeOWHZnismhV4VD/W$([char]13)$([char]10)6E67g1ADohhy98Wd/fElfA+YZk7sPrJ6F534zJ9QQZipkAUR+fdejeDn+BMLumK9$([char]13)$([char]10)KuIUGrWWUXrs6ENemKJGxvpfbZHBh47+tcZcaQIDAQABAoIBAF3aevSI59H6HQ7a$([char]13)$([char]10)+oqc0D81r8e6YObAEWfpo06TAfvDedvP/6uLpbC/bDbrMBqN2Lzo+F+3td99Pzr1$([char]13)$([char]10)zcwT5ShNyBcE9hqfaBmexBe1ViFG1UxYQDkxvQ+jFJGxW4k279lL2bRAmKTBvfdf$([char]13)$([char]10)uVhaMvSE7g5BeXH2GpdxIoDtvJW/RTA+Jto/SVBizjV/+HXpBRfjJST/rVYWGnup$([char]13)$([char]10)aaZEWRv8x66tygP3GI9ILlLnFdRKv6A1We7GUz6r2vFq+SpdM9Gh+AL5rhFMQA/E$([char]13)$([char]10)iWL5PGOx1G6xFLz9XWSsvXjHQskJqyjx29M8LAfqzVtK6l3Q25GGnJwzsBhDC78J$([char]13)$([char]10)VRqHCjECgYEA6fj4NUm5rq5g77XnhT8fjjFte73EaGX4pTVe6wMB9C9EfLj/f5gK$([char]13)$([char]10)V5nuYibPcFLmFeaMSn4j24hWZ8k2txuDkYXc9JLfAvXg0GMSv2AWoHQD7IHjX3wE$([char]13)$([char]10)Ekqi9EN1XaLudnpW+aV7npJcioMACmUHPCKOay6e6/cPjO6GzKjj+mUCgYEA5087$([char]13)$([char]10)PQpMHZLY59ycQ7Ee/uTCpek10FThHPrNJMoJSaqpeznYbvWN/XYaombLXAMK2k2h$([char]13)$([char]10)THJUmTZCnZHA2QQ6QFtYDx2HDH7UtUFgWbuCUVxKr6+3XvK8IKLKU30Rb6JvoDwE$([char]13)$([char]10)FZ8cOLt82svvTeLkoKZUEelbI/Uu49DMQdGmV7UCgYAvDb79GIKbOr6L9s1E4tj5$([char]13)$([char]10)w77878EcLcW/k+gu4z/1V7wySRI5Gt6Zl391hdCaClHzfZYhNRUJBXY7ESBL2uCu$([char]13)$([char]10)13kERrVK5x/7SLFwg2aJhktzuPt9LHe1JgV3kkl8N1Q1x4zOUBV4Yn7x7D6J2J+H$([char]13)$([char]10)3Hs/2vRjCCC8ewvpBN40cQKBgDapG4eWKlyGuik4kdjRP1DewDyyupvLoxLVFatO$([char]13)$([char]10)7xjwcnKDPekir/YodazQ+9d3hJYH6EkHb4RxNRbFPbxK6nUQ4ONZh/Nk+WEH3Pv3$([char]13)$([char]10)epk9ZQzVSlDurZRMw+Es2fT2fshvxktRuTqS27Nco+VU69Am3hEJgxchNn5xdgNL$([char]13)$([char]10)xrJNAoGBAMs81MVcm3SCXaj4uWL8ExmjVuwh/WyOUnVk7fE/BIZmYiurgmHLbMhE$([char]13)$([char]10)yYzkCvMay34vWa9WE5rZ4dHwkcjX3CpHUpWG807MCk9I8iyBI51nHiG6eHaGIdKp$([char]13)$([char]10)uLRkNxsKcyfXvV19b90x1WGbN458buSmakQtnd3xBEGVZvU/fLhY$([char]13)$([char]10)-----END RSA PRIVATE KEY-----$([char]13)$([char]10)"
$scannerIP = "192.168.2.1"
$scannerName = "SSE100000001"

## ===============================
## Create Temp Folder
## ===============================
## %TEMP%\$RandomFolder
Write-Output "Creating temp folder - $temp_folder"
$temp_folder = Join-Path $env:TEMP $([System.IO.Path]::GetRandomFileName())
$result = New-Item -ItemType Directory -Path $temp_folder
#validate
if (Test-Path -Path $temp_folder) {
    Write-Output "   ...success"
}
else {
    Write-Output "   !!! Error creating temp folder $temp_folder, cannot continue"
    Stop-Transcript
    exit
}


## ===============================
## Create Certificate Files
## ===============================
## %TEMP%\$RandomFolder\customerX_locationY.crt
Write-Output "Creating public key file - $temp_folder\$certName.crt"
$result = new-item -Path "$temp_folder\$certName.crt" `
                   -ItemType File -Value $certPubKey `
                   -ErrorAction SilentlyContinue
#validate
if($(Test-Path -Path "$temp_folder\$certName.crt" -ErrorAction SilentlyContinue)) {
    Start-Sleep -Seconds 1
    Write-Output "   ...success"
}
else {
    Write-Output "   !!! Public key file not created, cannot continue."
	Stop-Transcript
	exit
}

## %TEMP%\$RandomFolder\customerX_locationY.key
Write-Output "Creating private key file - $temp_folder\$certName.key"
$result = new-item -Path "$temp_folder\$certName.key" `
                   -ItemType File -Value $certPrivKey `
                   -ErrorAction SilentlyContinue
#validate
if($(Test-Path -Path "$temp_folder\$certName.key" -ErrorAction SilentlyContinue)) {
    Write-Output "   ...success"
}
else {
    Write-Output "   !!! Private key file not created, cannot continue."
	Stop-Transcript
	exit
}


## ===============================
## Install Certificate  
##    to Trusted Root (Windows PC)
## ===============================
Write-Output "Importing public key into local trust keystore - $temp_folder\$certName.crt"
try {
    $result1 = Import-Certificate -FilePath "$temp_folder\$certName.crt" `
                                  -CertStoreLocation cert:\LocalMachine\Root `
                                  -ErrorAction SilentlyContinue
}
catch {
    Write-Output "   !!! Certificate import failed, cannot continue."
	Stop-Transcript
	exit
}
#validate
if ( $([bool](dir cert:\LocalMachine\Root | ? { $_.subject -like "*cn=G4S USA*" })) ) {
    Write-Output "   ...success"
}
else {
    Write-Output "   !!! Certificate not found, cannot continue."
	Stop-Transcript
	exit
} 

## ===============================
## Install Certificate  
##    to Trusted Root (Windows PC)
## ===============================
Write-Output "Importing public key into local trust keystore - $temp_folder\$certName.crt"
try {
    $result1 = Import-Certificate -FilePath "$temp_folder\$certName.crt" `
                                  -CertStoreLocation cert:\LocalMachine\Root `
                                  -ErrorAction SilentlyContinue
}
catch {
    Write-Output "   !!! Certificate import failed, cannot continue."
	Stop-Transcript
	exit
}
#validate
if ( $([bool](dir cert:\LocalMachine\Root | ? { $_.subject -like "*cn=G4S USA*" })) ) {
    Write-Output "   ...success"
}
else {
    Write-Output "   !!! Certificate not found, cannot continue."
	Stop-Transcript
	exit
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


## ===============================
## Enable SSL and set to use 
##   Custom Certificate on 
##   the Scanner
## ===============================
## TODO:: "http://%SECURELINK%/securelink_mtr" vs. "http://%SECURELINK%/securelink", which is better?
Write-Output "Enabling SSL/TLS flag on the scanner."
$scannerURL = "http://$scannerIP/securelink"
$messageObject = [PSCustomObject]@{
    Command = 'SetNetworkInfo';
    Save_Network_Settings = 'true';
    EnableUnsecureConnections = 'false';
    UseCustomSslCertificate = 'true';
    RequireAuthorizationAdminApi = 'false';
    AllowUnsignedTellerHex = 'true';

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

if( $result.EnableUnsecureConnections -eq "false" -and $result.UseCustomSslCertificate -eq "true") {
    Write-Output "   ...success"
}
else {
    Write-Output "   !!! Error communicating with the scanner at $scannerIP, cannot continue."
	Stop-Transcript
	exit
}


## =============================
## Convert public key UTF8
## =============================
$certPubKey_utf8 = ([System.Text.Encoding]::UTF8.GetBytes($certPubKeyUTF8))


## =============================
## Upload public key file
## =============================
## curl "http://%SECURELINK%/securelink_uploadCertificate"
Write-Output "Uploading certificate PUBLIC key to the scanner."
$scannerURL = "http://$scannerIP/securelink_uploadCertificate"
try {
    $result = ""
    $result = Invoke-RestMethod -Uri $scannerURL `
                                -Method Post `
                                -Body $certPubKey_utf8
}
catch {}

if( $($result) -like "* Custom Certificate FLASH SUCCESSFUL" ) {
    Write-Output "   ...success"
}
else {
    Write-Output "   !!! Error uploading public key to the scanner at $scannerIP, cannot continue."
	Stop-Transcript
	exit
}


## =============================
## Convert private key UTF8
## =============================
$certPrivKey_utf8 = ([System.Text.Encoding]::UTF8.GetBytes($certPrivKeyUTF8))


## =============================
## Upload private key file
## =============================
## curl "http://%SECURELINK%/securelink_uploadKey" 
Write-Output "Uploading certificate PRIVATE key to the scanner."
$scannerURL = "http://$scannerIP/securelink_uploadKey"
try {
    $result = ""
    $result = Invoke-RestMethod -Uri $scannerURL `
                                -Method Post `
                                -Body $certPrivKey_utf8
}
catch {}

if( $($result) -like "* Custom Private Key FLASH SUCCESSFUL" ) {
    Write-Output "   ...success"
}
else {
    Write-Output "   !!! Error uploading private key to the scanner at $scannerIP, cannot continue."
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

Stop-Transcript
Exit 0