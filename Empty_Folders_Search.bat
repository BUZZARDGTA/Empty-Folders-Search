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
::     @Grub4K - Helped reducing variables plural algorithm.
::     @Grub4K - Helped me fixing "System Volume Information" false positives.
::     @Sintrode - Helped me encoding the CLI.
::     A project created in the "server.bat" Discord: https://discord.gg/GSVrHag
::------------------------------------------------------------------------------
cls
>nul chcp 65001
setlocal DisableDelayedExpansion
cd /d "%~dp0"
set "@TITLE=title [!Percentage!/100%%]  ^|  [!Results! empty folder!s_Results! found from !Index_1! indexed folder!s_Index_1!] - Empty Folders Search"
set "@SET_S=if !?! gtr 1 (set s_?=s) else (set s_?=)"
setlocal EnableDelayedExpansion
for /f "tokens=4,5delims=. " %%A in ('ver') do (
    if "%%A.%%B"=="10.0" (
        set CYAN=[36m
        set YELLOW=[33m
    )
)
for %%A in (s_Index s_Result s_Second) do set %%A=
set /a Percentage=0, Results=0, Index_1=0, Index_2=0
%@TITLE%
echo.
echo  !CYAN!■ Searching for empty folders in "%~dp0" ...
echo  ├──────────────────────────────────────────────────────────────────────────────
for /f "tokens=1-4delims=:.," %%A in ("!time: =0!") do set /a "t1=(((1%%A*60)+1%%B)*60+1%%C)*100+1%%D-36610100"
for /f %%A in ('2^>nul dir /a:d /b /s') do (
    set /a Index_1+=1
    %@SET_S:?=Index_1%
    %@TITLE%
)
for /f "delims=" %%A in ('2^>nul dir /a:d /b /s') do (
    set /a Index_2+=1, Percentage=Index_2*100/Index_1
    set "x=%%A"
    if not "!x:~-27!"==":\System Volume Information" (
        set x=
        for /f %%B in ('2^>nul dir "%%A" /a /b /s') do if not defined x set "x=%%B"
        if not defined x (
            set /a Results+=1
            %@SET_S:?=Results%
            echo  ├ Folder !YELLOW!"%%A"!CYAN! is empty.
        )
    %@TITLE%
    )
)
if !Results!==0 echo  │ No empty folder found.
for /f "tokens=1-4delims=:.," %%A in ("!time: =0!") do set /a "t2=(((1%%A*60)+1%%B)*60+1%%C)*100+1%%D-36610100, tDiff=t2-t1, tDiff+=((~(tDiff&(1<<31))>>31)+1)*8640000, Seconds=tDiff/100"
echo  └──────────────────────────────────────────────────────────────────────────────
set Percentage=100
%@TITLE%
%@SET_S:?=Index_1%
%@SET_S:?=Seconds%
echo.
echo  ■ Scan complited with !Results! empty folder!s_Results! found from !Index_1! indexed folder!s_Index_1! in !Seconds! second!s_Seconds!.
echo.
<nul set /p= ■ Press {ANY KEY} to exit...
>nul pause
exit