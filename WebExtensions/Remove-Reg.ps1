if(Test-Path -Path HKCU:\SOFTWARE\Mozilla\NativeMessagingHosts\pony_side) {
  Write-Host 'Remove Key'
  Remove-Item -Path HKCU:\SOFTWARE\Mozilla\NativeMessagingHosts\pony_side
}
else {
  Write-Host 'Key does not exist: pony_side'
}
