$keypath = 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client'
$key = (Get-ItemProperty -Path $keypath -Name Release).Release

if ($key -eq 378389) {
  $version     = '4.5'
} elseif ($key -eq 378675) {
  $version = '4.5.1'
} elseif ($key -eq 378758) {
  $version = '4.5.1'
}
elseif ($key -eq 379893) {
  $version = '4.5.2'
}
elseif ($key -eq 393295) {
  $version = '4.6'
}
elseif ($key -eq 393297) {
  $version = '4.6'
}
elseif ($key -eq 394254) {
  $version = '4.6.1'
}
elseif ($key -eq 394271) {
  $version = '4.6.1'
}
elseif ($key -eq 394802) {
  $version = '4.6.2'
}
elseif ($key -eq 394806) {
  $version = '4.6.2'
}

Write-Host "dotnet_version=${version}"