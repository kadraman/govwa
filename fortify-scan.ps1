
$AppName = (Split-Path -Path (Get-Location) -Leaf)
$AppVersion = "1.0"
<#
# $ScanSwitches = @"
...
#>
$ScanSwitches = ""

Write-Host Running translation...
& sourceanalyzer '-Dcom.fortify.sca.ProjectRoot=.fortify' $ScanSwitches -b "$AppName" -verbose `
-exclude ".\config" "."

Write-Host Running scan...
& sourceanalyzer '-Dcom.fortify.sca.ProjectRoot=.fortify' $ScanSwitches -b "$AppName" -verbose `
   -build-project "$AppName" -build-version "$AppVersion" -build-label "SNAPSHOT" -scan `
   -f "$($AppName).fpr"

Write-Host Generating PDF report...
& ReportGenerator '-Dcom.fortify.sca.ProjectRoot=.fortify' -user "Demo User" -format pdf -f "$($AppName).pdf" -source "$($AppName).fpr"

Write-Host Done.
