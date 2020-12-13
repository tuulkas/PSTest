Write-Host "Hello World!"

if (-not (Test-Path "Test.txt"))
{
  New-Item Test.txt
}
Add-Content -Path Test.txt -Value "Testtesteestst" 
