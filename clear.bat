:: clear dev
:: params:
:: return 0 success

echo # id    app_name    app_id    task_name    status> !install_file!
echo # app_name    app_id    status> !result_file!
echo # task_name(cmd title)> !task_file!
echo # !my_winget! install apps stat info> !report_file!

call .\utils\display !arg_color! success "clear over"