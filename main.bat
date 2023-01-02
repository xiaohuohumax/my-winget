:: auto install by winget
:: params:
:: return 0 success

@echo off
setlocal enabledelayedexpansion

:: load config
call config "%~n0"

:: show banner
call banner

:: init args
call args %*

if !errorlevel! neq 0 goto :eof

:: clear dev
call clear

:: check config and env
call check

if !errorlevel! neq 0 goto :eof

:: install app
call install

:: show stat info
call stat

@REM pause > nul
endlocal