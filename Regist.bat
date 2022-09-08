@echo off

echo "get administer power"
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"

echo "get bat"
echo %cd%
echo %1
for %%a in (*.bat) do (
	if not %%~na==Regist (
		echo "register right click"
		echo \"%cd%\%%a\"\"%%1\"
		REG ADD HKEY_CLASSES_ROOT\SystemFileAssociations\.md\shell\md_to_html\command /f  /d \"%cd%\%%a\"\"%%1\";%cd%
		echo "check"
		REG QUERY HKEY_CLASSES_ROOT\SystemFileAssociations\.md\shell\md_to_html\command
	)
)

pause

rem 注册表
rem 	REG Operation [Parameter List]
rem 操作
rem 	QUERY
rem 	ADD
rem 	DELETE
rem 	COPY
rem 	SAVE
rem 	RESTORE
rem 	LOAD
rem 	UNLOAD
rem 	COMPARE
rem 	EXPORT
rem 	IMPORT
rem 	FLAGS