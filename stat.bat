:: show stat info
:: params:
:: return 0 success

set result_app_id_list=

for /f "eol=# tokens=*" %%a in (!result_file!) do (

    call .\utils\extract_params pr %%a
    set r_app_ip=!pr2!
    set r_status=!pr3!

    if "!r_status!" equ "success" (
        set /a app_install_success_count+=1
        set app_install_success_ids=!r_app_ip!,!app_install_success_ids!
    ) else if "!r_status!" equ "fail" (
        set /a app_install_fail_count+=1
        set app_install_fail_ids=!r_app_ip!,!app_install_fail_ids!
    )
    set result_app_id_list=!result_app_id_list!,!r_app_ip!
)

for /f "eol=# tokens=*" %%i in (!install_file!) do (

    call .\utils\extract_params pi %%i
    set i_app_id=!pi3!
    set i_app_status=!pi5!

    if "!i_app_status!" equ "install" (
        echo !result_app_id_list!, | findstr /c:",!i_app_id!," > nul

        if !errorlevel! neq 0 (
            set /a app_install_unprocessed_count+=1
            set app_install_unprocessed_ids=!i_app_id!,!app_install_unprocessed_ids!
        )
    )
)

echo.
call .\utils\display !arg_color! success "stat infos:"
call .\utils\display !arg_color! primary "apps count: !apps_count!"
echo apps count: !apps_count!>> !report_file!

call .\utils\display !arg_color! warning "ignore install app count: !app_ignore_count!"
echo ignore install app count: !app_ignore_count!>> !report_file!

call .\utils\display !arg_color! success "insatll app success count: !app_install_success_count!"
echo insatll app success count: !app_install_success_count!>> !report_file!
if defined app_install_success_ids (
    call .\utils\display !arg_color! error "insatll app success list: !app_install_success_ids:~0,-1!"
    echo insatll app success list: !app_install_success_ids:~0,-1!>> !report_file!
)

call .\utils\display !arg_color! error "insatll app fail count: !app_install_fail_count!"
echo insatll app fail count: !app_install_fail_count!>> !report_file!
if defined app_install_fail_ids (
    call .\utils\display !arg_color! error "insatll app fail list: !app_install_fail_ids:~0,-1!"
    echo insatll app fail list: !app_install_fail_ids:~0,-1!>> !report_file!
)

call .\utils\display !arg_color! error "insatll app unprocessed count: !app_install_unprocessed_count!"
echo insatll app unprocessed count: !app_install_unprocessed_count!>> !report_file!
if defined app_install_unprocessed_ids (
    call .\utils\display !arg_color! error "insatll app unprocessed list: !app_install_unprocessed_ids:~0,-1!"
    echo insatll app unprocessed list: !app_install_unprocessed_ids:~0,-1!>> !report_file!
)
echo.
call .\utils\display !arg_color! warning "report: !report_file!"
echo.