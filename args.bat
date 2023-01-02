:: init args
:: params: %*
:: return 0 success -1 fail

:init_mark
set is_match=false
:: help
if "%1" equ "-h" set is_match=true
if "%1" equ "--help" set is_match=true
if "%is_match%" equ "true" (
    goto :help_mark
)
:: apps
if "%1" equ "-a" set is_match=true
if "%1" equ "--apps" set is_match=true
if "%is_match%" equ "true" (
    set arg_apps=%~2
    if not defined arg_apps (
        call :need_arg_call %1
        goto :try_help_mark
    )
    shift & shift & goto :init_mark
)
:: color
if "%1" equ "-c" set is_match=true
if "%1" equ "--color" set is_match=true
if "%is_match%" equ "true" (
    set arg_color=%~2
    if not defined arg_color (
        call :need_arg_call %1
        goto :try_help_mark
    )
    shift & shift & goto :init_mark
)
:: thread
if "%1" equ "-t" set is_match=true
if "%1" equ "--thread" set is_match=true
if "%is_match%" equ "true" (
    set arg_thread=%~2
    if not defined arg_thread (
        call :need_arg_call %1
        goto :try_help_mark
    )
    set /a arg_thread=%~2
    if !arg_thread! leq 0 (
        call :need_arg_call %1
        echo value must be greater than 0
        goto :try_help_mark
    )
    shift & shift & goto :init_mark
)
:: exit
if "%1" equ "-e" set is_match=true
if "%1" equ "--exit" set is_match=true
if "%is_match%" equ "true" (
    set arg_exit=%~2
    if not defined arg_exit (
        call :need_arg_call %1
        goto :try_help_mark
    )
    shift & shift & goto :init_mark
)
:: license
if "%1" equ "-l" set is_match=true
if "%1" equ "--license" set is_match=true
if "%is_match%" equ "true" (
    set arg_license=%~2
    if not defined arg_license (
        call :need_arg_call %1
        goto :try_help_mark
    )
    shift & shift & goto :init_mark
)
:: minimum
if "%1" equ "-m" set is_match=true
if "%1" equ "--minimum" set is_match=true
if "%is_match%" equ "true" (
    set arg_minimum=%~2
    if not defined arg_minimum (
        call :need_arg_call %1
        goto :try_help_mark
    )
    shift & shift & goto :init_mark
)
:: winget show
if "%1" equ "-s" set is_match=true
if "%1" equ "--winget-show" set is_match=true
if "%is_match%" equ "true" (
    set arg_winget_show=%~2
    if not defined arg_winget_show (
        call :need_arg_call %1
        goto :try_help_mark
    )
    shift & shift & goto :init_mark
)
:: winget install
if "%1" equ "-i" set is_match=true
if "%1" equ "--winget-install" set is_match=true
if "%is_match%" equ "true" (
    set arg_winget_install=%~2
    if not defined arg_winget_install (
        call :need_arg_call %1
        goto :try_help_mark
    )
    shift & shift & goto :init_mark
)
:: unknown args
if "%1" neq "" (
    echo unknown command [%1]
    goto :try_help_mark
)
:: install start params
if "!arg_minimum!" equ "true" (
    set install_start_params=!install_start_params! /min
)
exit /B 0


:help_mark
echo welcome use my-winget
echo.
echo command: main.bat [...]
echo.
echo    -a, --apps               app list file (default: %arg_apps_backup%)
echo    -c, --color              echo color font (default: %arg_color_backup%)
echo    -t, --thread             install max thread (default: %arg_thread_backup%)
echo    -e, --exit               exit the cmd after the install complete (default: %arg_exit_backup%)
echo    -m, --minimum            minimum window run install thread (default: %arg_minimum_backup%)
echo    -l, --license            search app license info (default: %arg_license_backup%)
echo.
echo winget params:
echo.
echo    -s, --winget-show        winget show params (default: %arg_winget_show_backup%)
echo    -i, --winget-install     wingit install params (default: %arg_winget_install_backup%)
echo.
echo other:
echo.
echo    -h, --help               help info
echo.
exit /B -1

:try_help_mark
echo try '%main_program_name% --help' for more information
exit /B -1

:need_arg_call
echo option requires an argument -- '%~1'
goto :eof