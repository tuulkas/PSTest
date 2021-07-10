$items = Get-ChildItem -Path $PSScriptRoot\functions\* -Include *.ps1

foreach ($item in $items)
{
    . $item.FullName
}