﻿############################################################################
###             Create a PDF Report Using Microsoft Edge                 ###
############################################################################

$path = "$env:temp\report.html"

# get data from any cmdlet you wish
$data = Get-Service | Sort-Object -Property Status, Name

# helper function to convert arrays to string lists
function Convert-ArrayToStringList
{
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        $PipelineObject
    )
    process
    {
        $Property = $PipelineObject.psobject.Properties |
                        Where-Object { $_.Value -is [Array] } |
                        Select-Object -ExpandProperty Name

        foreach ($item in $Property)
        {
            $PipelineObject.$item = $PipelineObject.$item -join ','


        }

        return $PipelineObject
    }
}


# compose style sheet
$stylesheet = "
    <style>
    body { background-color:#AAEEEE;
    font-family:Monospace;
    font-size:10pt; }
    table,td, th { border:1px solid blue;}
    th { color:#00008B;
    background-color:#EEEEAA;
    font-size: 12pt;}
    table { margin-left:30px; }
    h2 {
    font-family:Tahoma;
    color:#6D7B8D;
    }
    h1{color:#DC143C;}
    h5{color:#DC143C;}
    </style>
"

# output to HTML
$data |
# make sure you use Select-Object to copy the objects
Select-Object -Property * |
Convert-ArrayToStringList |
ConvertTo-Html -Title Report -Head $stylesheet |
Set-Content -Path $path -Encoding UTF8

Invoke-Item -Path $path
C:\Scripts> # path to existing HTML file
$path = "$env:temp\report.html"

# determine installation path for Chrome
$Edge = ${env:ProgramFiles(x86)}, $env:ProgramFiles |
ForEach-Object { "$_\Microsoft\Edge\Application\msedge.exe" } |
Where-Object { Test-Path -Path $_ -PathType Leaf } |
Select-Object -First 1

$destinationPath = [System.IO.Path]::ChangeExtension($Path, '.pdf')
& $Edge -argumentlist --headless --print-to-pdf="$destinationPath" "$Path"

do
{
   Write-Host '.' -NoNewLine
   Start-Sleep -Seconds 1
} Until (Test-Path -Path $destinationPath)

Invoke-Item -path $destinationPath

# path to existing HTML file
$path = "$env:temp\report.html"

# determine installation path for Chrome
$Edge = ${env:ProgramFiles(x86)}, $env:ProgramFiles |
ForEach-Object { "$_\Microsoft\Edge\Application\msedge.exe" } |
Where-Object { Test-Path -Path $_ -PathType Leaf } |
Select-Object -First 1

$destinationPath = [System.IO.Path]::ChangeExtension($Path, '.pdf')
& $Edge -argumentlist --headless --print-to-pdf="$destinationPath" "$Path"

do
{
   Write-Host '.' -NoNewLine
   Start-Sleep -Seconds 1
} Until (Test-Path -Path $destinationPath)

Invoke-Item -path $destinationPath