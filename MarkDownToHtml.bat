@echo off

set BatRootPath=C:\Users\HQ\Desktop\test\md-to-HTML\
chcp 65001
SET oriFile=%~n1

echo "rename target file"
SET file=youreoiuwoeiru
move %oriFile%.md %file%.md

echo "delete preview dir and %oriFile% dir"
if exist "preview" (
	rd "preview" /s /q
)
if exist "%BatRootPath%%oriFile%" (
	rd "%BatRootPath%%oriFile%" /s /q
)

echo "md to html ..."
call i5ting_toc -f %file%.md
md "%BatRootPath%%oriFile%"
xcopy "%BatRootPath%selftype" "%BatRootPath%%oriFile%" /s /q /h /c /y
copy "preview\%file%.html"  "%BatRootPath%%oriFile%\%file%.html"
rd preview /s /q

echo "rename back md"
move %file%.md %oriFile%.md

echo "change title"
set str1="    ^<title^>大家养老标准中台第三方对接文档^</title^>"
set str2="		^<link rel="shortcut icon" href="./toc/favicon.png"^>"
set roothtml=%BatRootPath%%oriFile%\%file%.html
set rootresult=%BatRootPath%%oriFile%\%oriFile%.html
(
	for /f "tokens=1* delims=" %%a in (%roothtml%) do (
		echo=%%a
		goto:A
	)
)>%rootresult%
:A
(
	for /f "skip=1 tokens=1* delims=" %%a in (%roothtml%) do (
		echo=%%a
		goto:B
	)
)>>%rootresult%
:B
(
	for /f "skip=2 tokens=1* delims=" %%a in (%roothtml%) do (
		echo=%%a
		goto:C
	)
)>>%rootresult%
:C
(echo=%str1:~1, -1%)>>%rootresult%
(echo=%str2:~1, -1%)>>%rootresult%
(
	for /f "skip=4 tokens=1* delims=" %%a in (%roothtml%) do (
		echo=%%a
	)
)>>%rootresult%

del %roothtml%

echo "copy result to current file"
if exist "%oriFile%" (
	rd "%oriFile%" /s /q
)
md "%oriFile%"
xcopy "%BatRootPath%%oriFile%" "%oriFile%" /s /q /h /c /y

echo "complete"

pause

rem for 用法
rem 标准格式 for %%i in (*.*) do echo %%i
rem 参数
rem 无参 只搜索文件
rem /d 只搜索目录
rem /r 递归遍历文件
rem /f 打开文件，遍历行
rem 	第二层参数
rem 		skip=1 跳过开头行
rem 		tokens=x,y,m-n 
rem 		tokens=m 提取第m列
rem 		tokens=m,n 提取第m列和第n列
rem 		tokens=m-n 提取第m列到第n列
rem 		tokens=m* 提取m列之后的所有列
rem 		tokens=* 忽略行首所有空格
rem			delims= 分隔符默认是空格
rem /l (1,1,5) 遍历1~5 中间1是步长

rem 字符串截取
rem echo %str:~0,5% ::截取前5个字符
rem echo %str:~-5% ::截取最后5个字符
rem echo %str:~0,-5% ::截取第一个到倒数第6个字符
rem echo %str:~3,5% ::从第四个字符开始，截取5个字符
rem echo %str:~-14,5% ::从倒数14个字符开始，截取5个字符
rem echo %str:a=b% ::将a替换为b

rem for循环中变量精简
rem ~I - 删除任何引号(")，扩展 %I
rem %~fI - 将 %I 扩展到一个完全合格的路径名
rem %~dI - 仅将 %I 扩展到一个驱动器号
rem %~pI - 仅将 %I 扩展到一个路径
rem %~nI - 仅将 %I 扩展到一个文件名
rem %~xI - 仅将 %I 扩展到一个文件扩展名
rem %~sI - 扩展的路径只含有短名
rem %~aI - 将 %I 扩展到文件的文件属性
rem %~tI - 将 %I 扩展到文件的日期/时间
rem %~zI - 将 %I 扩展到文件的大小
rem %~$PATH:I - 查找列在路径环境变量的目录，并将 %I 扩展

rem 运算
rem set /a 1+3

rem 重定向运算
rem type a.txt 查看文本
rem 符号
rem 	>  创建并写入
rem 	>> 添加
rem 	<  右边创建到左边
rem 	<< 右边添加到左边
rem 	< > 逻辑判断中用
