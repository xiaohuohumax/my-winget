:: sleep thread
:: params: sleep_time
::      sleep_time: sleep time s
:: return 0 success

setlocal
:: params
set sleep_time=%1

ping 127.1 -n !sleep_time! > nul

endlocal