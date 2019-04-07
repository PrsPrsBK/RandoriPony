if(Test-Path -Path HKCU:\SOFTWARE\Mozilla\NativeMessagingHosts\pony_side) {
  Write-Host 'Key already exists.'
  Get-ItemProperty -Path HKCU:\SOFTWARE\Mozilla\NativeMessagingHosts\pony_side
}
else {
  Write-Host 'create key: pony_side'
  New-Item -Path HKCU:\SOFTWARE\Mozilla\NativeMessagingHosts\pony_side
  $script_path =  (Split-Path -Parent $MyInvocation.MyCommand.Path)
  $json_path = Join-Path -Path $script_path -ChildPath 'pony_side.json'

  New-ItemProperty -Path HKCU:\SOFTWARE\Mozilla\NativeMessagingHosts\pony_side `
    -Name '(default)' `
    -PropertyType String `
    -Value $json_path
}
