
Describe "Module testing!" {
    BeforeAll { 
#        . $PSScriptRoot/test.ps1
    }

    It "should return Hello World!" {
        . $PSScriptRoot\..\test.ps1 | Should -Be "Hello World! What will happen now ?"
    }

    Context -Name "Linting for the functions" {
        $items = Get-Childitem -Path $PSScriptRoot\..\functions\* -Include *.ps1
        foreach ($item in $items)
        {
            It -Name "$($item.name) should follow coding standards and dont have any errors" {
                Invoke-ScriptAnalyzer -Path $item.FullName | Should -BeNullOrEmpty
            }

        }
    }
}