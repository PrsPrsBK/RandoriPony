$env:C_INCLUDE_PATH=''
Remove-Item winterm.dll | Out-Null
Remove-Item winterm.exp | Out-Null
Remove-Item winterm.lib | Out-Null
<#
# ckl is clang-cl.exe
# ``-implib:winterm.lib`` does not work.
# use ``__declspec(dllexport)``
#>
ckl /OUT:winterm.dll /LD winterm.c -v
