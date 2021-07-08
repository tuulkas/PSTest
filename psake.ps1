task Build -depends Init, Test {
    . $PSScriptRoot\test.ps1
}

task Test -depends Init {
    Invoke-Pester -Path $PSScriptRoot\Tests
}

task Init {
    "Init"
}