:: extract parameters
:: for example:
::  use
::      call extract_param pre params1 "other info"
::  restult
::      create var => pre1=params1 pre2=other info
:: params: key_pre ...
:: return 0 success

:: params
set key_pre=%1

set /a index=0
for /d %%i in (%*) do ( 
    set "!key_pre!!index!=%%~i"
    set /a index+=1
)