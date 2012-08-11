@echo off

if "%AUTOVPN_VPN_NAME%"=="" goto Instructions
if "%AUTOVPN_REMOTE_LAN_IP%"=="" goto Instructions

set IP_ADDRESS_ACCESSIBLE_FROM_ALL_NETWORKS=8.8.8.8
set VPN_NAME=%AUTOVPN_VPN_NAME%
set IP_ADDRESS_ACCESSIBLE_ON_REMOTE_LAN=%AUTOVPN_REMOTE_LAN_IP%

:VerifyNetworkAvailable
cls
echo Verifying we're on the local LAN now...
timeout 1 >NUL 2>&1
ping -n 1 %IP_ADDRESS_ACCESSIBLE_FROM_ALL_NETWORKS% | find "TTL" >NUL 2>&1
if %errorlevel%==1 goto VerifyNetworkAvailable
goto TestVpnConnection


:ConnectToVpn
echo.
echo Connecting us to the VPN now...
rasdial /disconnect >NUL 2>&1
rasdial %VPN_NAME% | find /v "completed"


:TestVpnConnection
echo Checking if we can access the remote LAN now...
ping -n 2 %IP_ADDRESS_ACCESSIBLE_ON_REMOTE_LAN% | find "TTL" >NUL 2>&1
if %errorlevel%==1 goto ConnectToVpn

echo We can access the remote LAN!
echo We'll close this window in a few seconds...
timeout 3
goto End


:Instructions
echo ENVIRONMENT VARIABLES NOT FOUND!
echo Create two environment variables before running this script:
echo AUTOVPN_VPN_NAME: the name of the MS VPN profile this script should connect to
echo AUTOVPN_REMOTE_LAN_IP: the IP address on the remote lan that's pingable upon successful VPN connection
pause


:End