:: config
:: params: main_program_name
::      main_program_name: main program name
:: return 0 success

:: args
set arg_apps=.\app\apps-default.txt
set arg_color=true
set /a arg_thread=4
set arg_winget_show=-e
set arg_winget_install=-e --interactive
set arg_exit=true
set arg_license=true
set arg_minimum=true

:: args backup
set arg_apps_backup=%arg_apps%
set arg_color_backup=%arg_color%
set /a arg_thread_backup=%arg_thread%
set arg_winget_show_backup=%arg_winget_show%
set arg_winget_install_backup=%arg_winget_install%
set arg_exit_backup=%arg_exit%
set arg_license_backup=%arg_license%
set arg_minimum_backup=%arg_minimum%

:: file
set banner_file=.\data\banner.txt
set install_file=.\data\install.txt
set result_file=.\data\result.txt
set task_file=.\data\task.txt
set report_file=.\report.txt

:: stat
set /a apps_count=0
set /a app_ignore_count=0
set /a app_install_success_count=0
set /a app_install_fail_count=0
set /a app_install_unprocessed_count=0
set app_install_success_ids=
set app_install_fail_ids=
set app_install_unprocessed_ids=

:: other
set main_program_name=%~1
set winget_git_url=https://github.com/microsoft/winget-cli
set my_winget=my-winget
set install_start_params=