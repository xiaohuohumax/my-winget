:: wait task start
:: params: task_name
::      task_name: task name
:: return 0 success

:: params
set task_name=%~1
:wait_mark
tasklist /fi "IMAGENAME eq cmd.exe" /v /fo csv | findstr /c:"%task_name%" > nul

if !errorlevel! neq 0 (
    call .\utils\wait 1
    goto :wait_mark
)