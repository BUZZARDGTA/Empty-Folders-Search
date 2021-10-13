@echo off
::------------------------------------------------------------------------------
:: NAME
::     Empty_Folders_Search.bat - Empty Folders Search
::
:: DESCRIPTION
::     Scan for empty folders in the current folder and it's subfolders.
::
:: AUTHOR
::     IB_U_Z_Z_A_R_Dl
::
:: CREDITS
::     @Grub4K - Creator of the timer algorithm.
::     @Sintrode - Helped me encoding the CLI.
::     A project created in the "server.bat" Discord: https://discord.gg/GSVrHag
::------------------------------------------------------------------------------
cd /d "%~dp0"
>nul chcp 65001
set "title=title [!percentage!/100%%]  ^|  [!result! empty folder!s_result! found from !index_1! indexed folder!s_index!] - Empty Folders Search"
Setlocal EnableDelayedExpansion
set /a percentage=0, result=0, index_1=0, index_2=0
set s_result=
set s_index=
for /f "tokens=4,5delims=. " %%a in ('ver') do (
    if "%%a.%%b"=="10.0" (
        set cyan=[36m
        set yellow=[33m
    )
)
%title%
echo.
echo  !cyan!■ Searching for empty folders in "%~dp0" ...
echo  ├──────────────────────────────────────────────────────────────────────────────
for /f "tokens=1-4delims=:.," %%a in ("!time: =0!") do set /a "t1=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100"
for /f %%a in ('2^>nul dir /a:d /b /s') do (
    set /a index_1+=1
    if !index_1! gtr 1 set s_index=s
    %title%
)
for /f "delims=" %%a in ('2^>nul dir /a:d /b /s') do (
    set /a index_2+=1, percentage=index_2*100/index_1
    set x=
    for /f %%b in ('2^>nul dir "%%a" /a /b /s') do if not defined x set "x=%%b"
    if not defined x (
        set /a result+=1
        if !result! gtr 1 set s_result=s
        echo  ├ Folder !yellow!"%%a"!cyan! is empty.
    )
    %title%
)
if !result!==0 echo  │ No empty folder found.
echo  └──────────────────────────────────────────────────────────────────────────────
for /f "tokens=1-4delims=:.," %%a in ("!time: =0!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, tDiff=t2-t1, tDiff+=((~(tDiff&(1<<31))>>31)+1)*8640000, seconds=tDiff/100"
if !seconds! gtr 1 set s_second=s
set percentage=100
%title%
echo.
echo  ■ Scan complited with !result! empty folder!s_result! found from !index_1! indexed folder!s_index! in !seconds! second!s_second!.
echo.
<nul set /p= ■ Press {ANY KEY} to exit...
>nul pause
exit