A batch script for automatically connecting to an MS VPN. Designed to be used as a Startup script (and maybe, if you like, as a "scheduled" task upon workstation unlock).

The script will exit within seconds if you're already on the "remote" LAN. Good for laptops that are always working, but only sometimes inside the office.

The script requires two user environment variables:

AUTOVPN_REMOTE_LAN_IP: the IP address the script should ping to prove remote LAN connectivity

AUTOVPN_VPN_NAME: the name of the VPN profile the script should dial

Disable two settings in the properties of the VPN profile identified in your AUTOVPN_VPN_NAME user environment variable:

- Display progress while connecting (disable this; the script gives status information)

- Prompt for name and password, certificate, etc (optional; this script runs seamlessly when your Windows and VPN credentials match)

If you find, when your VPN connection drops, that re-running the script gives you a better experience than the VPN profile's out-of-the-box redial offering, optionally consider disabling the following setting in your VPN profile's properties, and re-run the batch script instead whenever your VPN connection drops:

VPN Profile Properties > Options > Redialing options > Redial if line is dropped
