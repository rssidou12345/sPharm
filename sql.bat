echo off
sqlcmd -E -S localhost\sidali -i maj.sql
set /p delExit=Press the ENTER key to exit...: