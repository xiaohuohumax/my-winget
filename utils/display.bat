:: dispaly info
:: params: is_use_color types msg
::      is_use_color: is use color [true/false]
::      types: define,pimary,success,warning,error
::      msg: ...
:: return 0 success

setlocal enabledelayedexpansion
:: params
set is_use_color=%1
set types=%2
set msg=%~3

if "%types%" equ "define" (
    call :display_call 30 "%msg%"
) else if "%types%" equ "primary" (
    call :display_call 34 "%msg%"
) else if "%types%" equ "success" (
    call :display_call 32 "%msg%"
) else if "%types%" equ "warning" (
    call :display_call 33 "%msg%"
) else if "%types%" equ "error" (
    call :display_call 31 "%msg%"
)
goto :eof

:display_call
if "!ESC!" equ "" (
    for /f %%a in ('"prompt $E & echo on & for %%i in (1) do rem"') do (
        set ESC=%%a
    )
)
set info=%~2
if /i %is_use_color% equ true (
    set info=!ESC![%1;1m%info%!ESC![0m
)
echo %info%
goto :eof
endlocal