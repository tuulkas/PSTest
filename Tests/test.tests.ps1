
Describe "Module testing!" {
    BeforeAll { 
#        . $PSScriptRoot/test.ps1
    }

    It "should return Hello World!" {
        . $PSScriptRoot\test.ps1 | Should -Be "Hello World!"
    }
}