REM ####START SYSTEM SET####
@echo off
color 1f
MODE con COLS=21 LINES=9
REM ####END SYSTEM SET####


REM ####START SCRIPT SET####
set ip=192.168.1
set int=0xc
set start=1
set end=255
REM ####END SCRIPT SET####

set /a "x = %start%"
:while1
if %x% LSS %end% (
        ping %ip%.%x% -n 1 -w 1000 | find "TTL=" >nul
		if errorlevel 1 ( 
				echo host %ip%.%x% not reachable >> down.txt
				arp -a %ip%.%x% | find "%int%" >nul
				if errorlevel 1 ( 
    					echo no record
				) else (
					arp -a %ip%.%x% >> down.txt
				)
		) else (
			echo host %ip%.%x% reachable >> up.txt
			nmap --open %ip%.%x%  | find "PORT     STATE SERVICE" >>1.txt
		)
	cls        
	set /a "x = x + 1"
	echo ====================
	echo ^|     CheckIP      ^|
	echo ====================
	echo      %ip%.%x%  
	echo ====================
	echo ^|      v0.1        ^|
    echo ====================
	goto :while1
    )
endlocal
pause


