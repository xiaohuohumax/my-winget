:: check config and env
:: params:
:: return 0 success -1 fail

:: check winget
for %%i in (winget.exe) do (
    if "%%~$PATH:i" equ "" (
        call .\utils\display !arg_color! error "winget is not found!"
        call .\utils\display !arg_color! error "winget github link: !winget_git_url!"
        exit /B -1
    )
)

:: check apps file
if not exist !arg_apps! (
    call .\utils\display !arg_color! error "apps file [!arg_apps!] is not exist!"
    exit /B -1
)

call .\utils\display !arg_color! success "check over"