task Build -depends Init, Test {
    . $PSScriptRoot\test.ps1
    if (-not(Get-Module Pester)) { Import-Module Pester }
    Get-Module Pester
}

task Test -depends Init {
    Invoke-Pester -Path $PSScriptRoot\Tests -OutputFile $PSScriptRoot\Tests\Nunit.xml -OutputFormat NUnitXml
}

task Init {
    "Init"
}