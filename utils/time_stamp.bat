:: time stamp
:: for example:
::  use
::      call time_stamp time_key
::      echo !time_key!
:: params: key_name
:: return 0 success

:: params
set key_name=%1

set "%key_name%=%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%.%time:~9,2%"