REM ####START SYSTEM SET####
@echo off
color 1f
MODE con COLS=21 LINES=9
REM ####END SYSTEM SET####


REM ####START SCRIPT SET####
set net=192.168.1
set int=0xc
set start=1
set end=255
REM ####END SCRIPT SET####

set /a "x = %start%"
:while1
if %x% LSS %end% (
        ping %net%.%x% -n 1 -w 1000 | find "TTL=" >nul
		if errorlevel 1 ( 
				echo host %net%.%x% not reachable >> down.txt
				arp -a %net%.%x% | find "%int%" >nul
				if errorlevel 1 ( 
    					echo no record
				) else (
					arp -a %net%.%x% >> down.txt
				)
		) else (
			echo host %net%.%x% reachable >> up.txt
		)
	cls        
	set /a "x = x + 1"
	echo ====================
	echo ^|     CheckIP      ^|
	echo ====================
	echo      %net%.%x%  
	echo ====================
	echo ^|      v0.1        ^|
    echo ====================
	goto :while1
    )
endlocal
pause


