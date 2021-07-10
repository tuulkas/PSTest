function Get-RecycleBin
{
    [cmdletbinding()]
    param(
    )
    $shell = New-Object -ComObject shell.application

    return $shell.Namespace(10)
}