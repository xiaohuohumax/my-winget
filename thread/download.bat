:: download app and install
:: params: app_name app_id is_use_color is_search_first result_file winget_show_params winget_show_install
::      app_name: app name
::      app_id: app winget id
::      is_use_color: is use color [true/false]
::      is_search_first: is search first [true/fals]
::      install_complete_exit: install complete exit [true/fals]
::      result_file: result file
::      winget_show_params: winget show params
::      winget_show_install: winget show install
:: return 0 success

@echo off
setlocal

set app_name=%~1
set app_id=%~2
set is_use_color=%3
set is_search_first=%4
set install_complete_exit=%5
set result_file=%~6
set winget_show_params=%~7
set winget_show_install=%~8
set result_flag=fail

call .\utils\display %is_use_color% success "start install"

if /i "%is_search_first%" equ "true" (
    goto :search_mark
) else (
    goto :install_mark
)

:search_mark
call .\utils\display %is_use_color% success "start search app [!app_name!] info"

call .\utils\display %is_use_color% warning "command: winget show --id=%app_id% %winget_show_params%"

winget show --id=%app_id% %winget_show_params%

if %errorlevel% equ 0 (
    :: search success
    call .\utils\display %is_use_color% success "search success"
    goto :install_mark
) else (
    :: search fail
    call .\utils\display %is_use_color% error "search fail"
    goto :end_mark
)

:install_mark
call .\utils\display %is_use_color% success "start install app [%app_name%]"

call .\utils\display %is_use_color% warning "command: winget install --id=%app_id% %winget_show_install%"

winget install --id=%app_id% %winget_show_install%

if %errorlevel% equ 0 (
    :: install success
    call .\utils\display %is_use_color% success "install success"
    set result_flag=success
) else (
    :: install fail
    call .\utils\display %is_use_color% error "install fail"
)

:end_mark
echo "%app_name%" "%app_id%" "%result_flag%">> %result_file%

call .\utils\display %is_use_color% success "install task finish"
if "%install_complete_exit%" neq "true" (
    pause
)

endlocal