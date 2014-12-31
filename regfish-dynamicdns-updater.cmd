@ECHO OFF
CLS
:: RegfishDnsUpdater.cmd
::
:: This script will update a Regfish DNS A record
:: with the IPv4 address of this host
::
:: Reference: https://www.regfish.de/domains/dyndns/dokumentation
::
:: Note: Instead of using %VAR1% to process variables we use !VAR1! (% vs !)
::       This makes the variables expand in %URL%. ;-)
::
:: 20140109 ASC Initial release 
::
SETLOCAL

SET MYSELF=%~dp0
SET "URL=https://dyndns.regfish.de/?fqdn=!REGFISH_FQDN!.&ipv4=!REGFISH_IPV4!&token=!REGFISH_TOKEN!"
SET "IPV4=127.0.0.1"

:: Change to the directory the script is in...
:: DOES NOT WORK FOR UNC PATH
:: Ref: http://www.microsoft.com/resources/documentation/windows/xp/all/proddocs/en-us/percent.mspx?mfr=true
%~d0
CD %~p0


:::::::::::::::::::::::::::::::::::::::::::::::::::::
::       PUT YOUR OWN SETTINGS HERE BELOW!!
::       See Regfish dynamic dns configuration setting
::       and use your dyn dns password as TOKEN
:::::::::::::::::::::::::::::::::::::::::::::::::::::
SET CURL=curl.exe
SET "TOKEN=MY_SECRET_TOKEN_FROM_THE_REGFISH_DYNAMIC_DNS_UPDATE_CONFIGURATION_PAGE"
SET "FQDN=HOSTNAME.MYDOMAIN.COM"
SET "HTTP_PROXY="
::SET "HTTP_PROXY=192.168.12.2:8080"
:::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::

CALL :getIpAddress "%COMPUTERNAME%" IPv4
CALL :updateRegfishDNS "%FQDN%" "%IPv4%" "%TOKEN%" "%HTTP_PROXY%"

GOTO EOBATCH

::::::::::::::::::::::::::::::::::::::::::::::::
:getIpAddress HOST IPADDRESS
::::::::::::::::::::::::::::::::::::::::::::::::
SETLOCAL ENABLEDELAYEDEXPANSION
for /f "delims=[] tokens=2" %%a in ('ping -4 %1 -n 1 ^| findstr "["') do (set THISIP=%%a)
( ENDLOCAL
  SET "%2=%THISIP%"
)
EXIT /B 0

::::::::::::::::::::::::::::::::::::::::::::::::
:updateRegfishDNS FQDN IPv4 TOKEN PROXY
::::::::::::::::::::::::::::::::::::::::::::::::
SETLOCAL ENABLEDELAYEDEXPANSION
SET REGFISH_FQDN=%~1
SET REGFISH_IPV4=%~2
SET REGFISH_TOKEN=%~3
IF "XX" EQU "X%~4X" (
  ECHO Updating host %REGFISH_FQDN% with IP %REGFISH_IPV4%...
  %CURL% --insecure "%URL%"
) ELSE ( 
  ECHO Updating host %REGFISH_FQDN% with IP %REGFISH_IPV4% via proxy %~4...
  CURL --proxy "%~4"--insecure "%URL%"
)
EXIT /B 0

:EOBATCH
ENDLOCAL
CHOICE /N /T 10 /D X /C X /M "Press a key [X] to continue."
