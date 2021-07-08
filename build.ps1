if (!(Get-Module -Name psake -ListAvailable)) { Install-Module -Name psake -Scope CurrentUser }

Invoke-psake -buildFile "$PSScriptRoot\psake.ps1" -taskList Build

exit ( [int]( -not $psake.build_success ) )