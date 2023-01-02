:: wait task idle finish
:: params: max_task task_list_file
::      max_task: max allow task
::      task_list_file: task list file
:: return 0 success

:: params
set /a max_task=%1
set task_list_file=%~2

:wait_mark
set /a task_run_count=0

for /f "tokens=*" %%i in (%task_list_file%) do (

    set task_name=%%i

    tasklist /fi "IMAGENAME eq cmd.exe" /v /fo csv | findstr /c:"!task_name!" > nul

    if !errorlevel! equ 0 (
        set /a task_run_count+=1
    )
)

if !task_run_count! geq !max_task! (
    call .\utils\wait 1
    goto :wait_mark
)