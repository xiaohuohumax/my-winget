:: install apps
:: params:
:: return 0 success

call .\utils\display !arg_color! success "start install apps:"

set install_id_list=

echo.
for /f "eol=# tokens=*" %%a in (!arg_apps!) do (
    call .\utils\extract_params pa %%a
    set app_flag=!pa1!
    set app_name=!pa2!
    set app_id=!pa3!

    :: ignore repeat app id
    echo !install_id_list!, | findstr /c:",!app_id!," > nul

    if !errorlevel! equ 0 (
        :: app id repeat
        call .\utils\display !arg_color! error "app repeat ignore install [!app_name!] [!app_id!]"
    ) else (
        call .\utils\time_stamp time_stamp

        set task_name=install !app_name! [!app_id!] !time_stamp!

        set install_line=!apps_count! "!app_name!" "!app_id!" "!task_name!"

        if /i "!app_flag!" equ "true" (
            set install_line=!install_line! install

            echo !task_name!>> !task_file!

            call .\utils\display !arg_color! success "ready install [!app_name!] [!app_id!]"
            :: run thread start download
            start "!task_name!" !install_start_params! cmd /c .\thread\download "!app_name!" "!app_id!" !arg_color! !arg_license! !arg_exit! "!result_file!" "!arg_winget_show!" "!arg_winget_install!"
            :: wait task start
            call .\utils\wait_task_start "!task_name!"
            :: wait task idle
            call .\utils\wait_task_idle !arg_thread! "!task_file!"
        ) else (
            set install_line=!install_line! ignore

            call .\utils\display !arg_color! warning "ignore install [!app_name!] [!app_id!]"
            set /a app_ignore_count+=1
        )
        set /a apps_count+=1
        echo !install_line!>> !install_file!
        set install_id_list=!install_id_list!,!app_id!
    )

)
echo.

call .\utils\display !arg_color! success "create task finish, wait install apps finish"

:: wait task idle finish
call .\utils\wait_task_idle 1 "!task_file!"

call .\utils\display !arg_color! success "install apps finish"