Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4H7OMM4019471
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 03:24:22 -0400
Received: from mail-qy0-f189.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4H7PYfx020272
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 07:25:34 GMT
Received: by qyk27 with SMTP id 27so6393810qyk.23
        for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 00:24:20 -0700 (PDT)
MIME-Version: 1.0
From: waqar afridi <afridi.waqar@gmail.com>
Date: Mon, 17 May 2010 12:24:00 +0500
Message-ID: <AANLkTinBSFB6IQCU2BEbYIu1NY_fGSVDwD0BNLZJXC7x@mail.gmail.com>
Subject: Need Help with security: ebitmap: map size 0 does not match my size
	64 (high bit was 4)
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016e64dda7800df890486c51dc7
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e64dda7800df890486c51dc7
Content-Type: text/plain; charset=ISO-8859-1

Hello All

I am trying to port trisys reference policy on my Openmoko Software Stack,
When ever I try to load it I get the Following error

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*root@om-gta02 ~/refpolicy $ make load*
Loading configured modules.
/usr/sbin/semodule -s refpolicy -b /usr/share/selinux/refpolicy/base.pp -i
/usr/share/selinux/refpolicy/acct.pp -i /usr/share/selinux/refpolicy/ada.pp
-i /usr/share/selinux/refpolicy/afs.pp -i
/usr/share/selinux/refpolicy/aide.pp -i /usr/share/selinux/refpolicy/alsa.pp
-i /usr/share/selinux/refpolicy/amanda.pp -i
/usr/share/selinux/refpolicy/amavis.pp -i
/usr/share/selinux/refpolicy/amtu.pp -i
/usr/share/selinux/refpolicy/anaconda.pp -i
/usr/share/selinux/refpolicy/apache.pp -i
/usr/share/selinux/refpolicy/apcupsd.pp -i
/usr/share/selinux/refpolicy/apm.pp -i
/usr/share/selinux/refpolicy/application.pp -i
/usr/share/selinux/refpolicy/apt.pp -i
/usr/share/selinux/refpolicy/arpwatch.pp -i
/usr/share/selinux/refpolicy/asterisk.pp -i
/usr/share/selinux/refpolicy/audioentropy.pp -i
/usr/share/selinux/refpolicy/authbind.pp -i
/usr/share/selinux/refpolicy/authlogin.pp -i
/usr/share/selinux/refpolicy/automount.pp -i
/usr/share/selinux/refpolicy/avahi.pp -i
/usr/share/selinux/refpolicy/awstats.pp -i
/usr/share/selinux/refpolicy/backup.pp -i
/usr/share/selinux/refpolicy/bind.pp -i
/usr/share/selinux/refpolicy/bitlbee.pp -i
/usr/share/selinux/refpolicy/bluetooth.pp -i
/usr/share/selinux/refpolicy/bootloader.pp -i
/usr/share/selinux/refpolicy/brctl.pp -i
/usr/share/selinux/refpolicy/calamaris.pp -i
/usr/share/selinux/refpolicy/canna.pp -i /usr/share/selinux/refpolicy/ccs.pp
-i /usr/share/selinux/refpolicy/cdrecord.pp -i
/usr/share/selinux/refpolicy/certwatch.pp -i
/usr/share/selinux/refpolicy/cipe.pp -i
/usr/share/selinux/refpolicy/clamav.pp -i
/usr/share/selinux/refpolicy/clock.pp -i
/usr/share/selinux/refpolicy/clockspeed.pp -i
/usr/share/selinux/refpolicy/comsat.pp -i
/usr/share/selinux/refpolicy/consolekit.pp -i
/usr/share/selinux/refpolicy/consoletype.pp -i
/usr/share/selinux/refpolicy/courier.pp -i
/usr/share/selinux/refpolicy/cpucontrol.pp -i
/usr/share/selinux/refpolicy/cron.pp -i /usr/share/selinux/refpolicy/cups.pp
-i /usr/share/selinux/refpolicy/cvs.pp -i
/usr/share/selinux/refpolicy/cyrus.pp -i
/usr/share/selinux/refpolicy/daemontools.pp -i
/usr/share/selinux/refpolicy/dante.pp -i
/usr/share/selinux/refpolicy/dbskk.pp -i
/usr/share/selinux/refpolicy/dbus.pp -i /usr/share/selinux/refpolicy/dcc.pp
-i /usr/share/selinux/refpolicy/ddclient.pp -i
/usr/share/selinux/refpolicy/ddcprobe.pp -i
/usr/share/selinux/refpolicy/dhcp.pp -i
/usr/share/selinux/refpolicy/dictd.pp -i
/usr/share/selinux/refpolicy/distcc.pp -i
/usr/share/selinux/refpolicy/djbdns.pp -i
/usr/share/selinux/refpolicy/dmesg.pp -i
/usr/share/selinux/refpolicy/dmidecode.pp -i
/usr/share/selinux/refpolicy/dnsmasq.pp -i
/usr/share/selinux/refpolicy/dovecot.pp -i
/usr/share/selinux/refpolicy/dpkg.pp -i
/usr/share/selinux/refpolicy/ethereal.pp -i
/usr/share/selinux/refpolicy/evolution.pp -i
/usr/share/selinux/refpolicy/exim.pp -i
/usr/share/selinux/refpolicy/fail2ban.pp -i
/usr/share/selinux/refpolicy/fetchmail.pp -i
/usr/share/selinux/refpolicy/finger.pp -i
/usr/share/selinux/refpolicy/firstboot.pp -i
/usr/share/selinux/refpolicy/fstools.pp -i
/usr/share/selinux/refpolicy/ftp.pp -i /usr/share/selinux/refpolicy/games.pp
-i /usr/share/selinux/refpolicy/gatekeeper.pp -i
/usr/share/selinux/refpolicy/getty.pp -i
/usr/share/selinux/refpolicy/gift.pp -i
/usr/share/selinux/refpolicy/gnome.pp -i /usr/share/selinux/refpolicy/gpg.pp
-i /usr/share/selinux/refpolicy/gpm.pp -i
/usr/share/selinux/refpolicy/hal.pp -i
/usr/share/selinux/refpolicy/hostname.pp -i
/usr/share/selinux/refpolicy/hotplug.pp -i
/usr/share/selinux/refpolicy/howl.pp -i
/usr/share/selinux/refpolicy/i18n_input.pp -i
/usr/share/selinux/refpolicy/imaze.pp -i
/usr/share/selinux/refpolicy/inetd.pp -i
/usr/share/selinux/refpolicy/init.pp -i /usr/share/selinux/refpolicy/inn.pp
-i /usr/share/selinux/refpolicy/ipsec.pp -i
/usr/share/selinux/refpolicy/iptables.pp -i
/usr/share/selinux/refpolicy/irc.pp -i /usr/share/selinux/refpolicy/ircd.pp
-i /usr/share/selinux/refpolicy/irqbalance.pp -i
/usr/share/selinux/refpolicy/iscsi.pp -i
/usr/share/selinux/refpolicy/jabber.pp -i
/usr/share/selinux/refpolicy/java.pp -i
/usr/share/selinux/refpolicy/kerberos.pp -i
/usr/share/selinux/refpolicy/ktalk.pp -i
/usr/share/selinux/refpolicy/kudzu.pp -i
/usr/share/selinux/refpolicy/ldap.pp -i
/usr/share/selinux/refpolicy/libraries.pp -i
/usr/share/selinux/refpolicy/loadkeys.pp -i
/usr/share/selinux/refpolicy/locallogin.pp -i
/usr/share/selinux/refpolicy/lockdev.pp -i
/usr/share/selinux/refpolicy/logging.pp -i
/usr/share/selinux/refpolicy/logrotate.pp -i
/usr/share/selinux/refpolicy/logwatch.pp -i
/usr/share/selinux/refpolicy/lpd.pp -i /usr/share/selinux/refpolicy/lvm.pp
-i /usr/share/selinux/refpolicy/mailman.pp -i
/usr/share/selinux/refpolicy/miscfiles.pp -i
/usr/share/selinux/refpolicy/modutils.pp -i
/usr/share/selinux/refpolicy/mono.pp -i
/usr/share/selinux/refpolicy/monop.pp -i
/usr/share/selinux/refpolicy/mount.pp -i
/usr/share/selinux/refpolicy/mozilla.pp -i
/usr/share/selinux/refpolicy/mplayer.pp -i
/usr/share/selinux/refpolicy/mrtg.pp -i /usr/share/selinux/refpolicy/mta.pp
-i /usr/share/selinux/refpolicy/munin.pp -i
/usr/share/selinux/refpolicy/mysql.pp -i
/usr/share/selinux/refpolicy/nagios.pp -i
/usr/share/selinux/refpolicy/nessus.pp -i
/usr/share/selinux/refpolicy/netlabel.pp -i
/usr/share/selinux/refpolicy/netutils.pp -i
/usr/share/selinux/refpolicy/networkmanager.pp -i
/usr/share/selinux/refpolicy/nis.pp -i /usr/share/selinux/refpolicy/nscd.pp
-i /usr/share/selinux/refpolicy/nsd.pp -i
/usr/share/selinux/refpolicy/ntop.pp -i /usr/share/selinux/refpolicy/ntp.pp
-i /usr/share/selinux/refpolicy/nx.pp -i /usr/share/selinux/refpolicy/oav.pp
-i /usr/share/selinux/refpolicy/oddjob.pp -i
/usr/share/selinux/refpolicy/openca.pp -i
/usr/share/selinux/refpolicy/openct.pp -i
/usr/share/selinux/refpolicy/openvpn.pp -i
/usr/share/selinux/refpolicy/pcmcia.pp -i
/usr/share/selinux/refpolicy/pcscd.pp -i
/usr/share/selinux/refpolicy/pegasus.pp -i
/usr/share/selinux/refpolicy/perdition.pp -i
/usr/share/selinux/refpolicy/portage.pp -i
/usr/share/selinux/refpolicy/portmap.pp -i
/usr/share/selinux/refpolicy/portslave.pp -i
/usr/share/selinux/refpolicy/postfix.pp -i
/usr/share/selinux/refpolicy/postfixpolicyd.pp -i
/usr/share/selinux/refpolicy/postgresql.pp -i
/usr/share/selinux/refpolicy/postgrey.pp -i
/usr/share/selinux/refpolicy/ppp.pp -i
/usr/share/selinux/refpolicy/prelink.pp -i
/usr/share/selinux/refpolicy/privoxy.pp -i
/usr/share/selinux/refpolicy/procmail.pp -i
/usr/share/selinux/refpolicy/publicfile.pp -i
/usr/share/selinux/refpolicy/pxe.pp -i /usr/share/selinux/refpolicy/pyzor.pp
-i /usr/share/selinux/refpolicy/qmail.pp -i
/usr/share/selinux/refpolicy/quota.pp -i
/usr/share/selinux/refpolicy/radius.pp -i
/usr/share/selinux/refpolicy/radvd.pp -i
/usr/share/selinux/refpolicy/raid.pp -i
/usr/share/selinux/refpolicy/razor.pp -i
/usr/share/selinux/refpolicy/rdisc.pp -i
/usr/share/selinux/refpolicy/readahead.pp -i
/usr/share/selinux/refpolicy/remotelogin.pp -i
/usr/share/selinux/refpolicy/resmgr.pp -i
/usr/share/selinux/refpolicy/rhgb.pp -i
/usr/share/selinux/refpolicy/ricci.pp -i
/usr/share/selinux/refpolicy/rlogin.pp -i
/usr/share/selinux/refpolicy/roundup.pp -i
/usr/share/selinux/refpolicy/rpc.pp -i
/usr/share/selinux/refpolicy/rpcbind.pp -i
/usr/share/selinux/refpolicy/rpm.pp -i /usr/share/selinux/refpolicy/rshd.pp
-i /usr/share/selinux/refpolicy/rssh.pp -i
/usr/share/selinux/refpolicy/rsync.pp -i
/usr/share/selinux/refpolicy/rwho.pp -i
/usr/share/selinux/refpolicy/samba.pp -i
/usr/share/selinux/refpolicy/sasl.pp -i
/usr/share/selinux/refpolicy/screen.pp -i
/usr/share/selinux/refpolicy/selinuxutil.pp -i
/usr/share/selinux/refpolicy/sendmail.pp -i
/usr/share/selinux/refpolicy/setrans.pp -i
/usr/share/selinux/refpolicy/setroubleshoot.pp -i
/usr/share/selinux/refpolicy/slocate.pp -i
/usr/share/selinux/refpolicy/slrnpull.pp -i
/usr/share/selinux/refpolicy/smartmon.pp -i
/usr/share/selinux/refpolicy/snmp.pp -i
/usr/share/selinux/refpolicy/snort.pp -i
/usr/share/selinux/refpolicy/soundserver.pp -i
/usr/share/selinux/refpolicy/spamassassin.pp -i
/usr/share/selinux/refpolicy/speedtouch.pp -i
/usr/share/selinux/refpolicy/squid.pp -i /usr/share/selinux/refpolicy/ssh.pp
-i /usr/share/selinux/refpolicy/storage.pp -i
/usr/share/selinux/refpolicy/stunnel.pp -i
/usr/share/selinux/refpolicy/su.pp -i /usr/share/selinux/refpolicy/sudo.pp
-i /usr/share/selinux/refpolicy/sxid.pp -i
/usr/share/selinux/refpolicy/sysnetwork.pp -i
/usr/share/selinux/refpolicy/sysstat.pp -i
/usr/share/selinux/refpolicy/tcpd.pp -i
/usr/share/selinux/refpolicy/telnet.pp -i
/usr/share/selinux/refpolicy/tftp.pp -i
/usr/share/selinux/refpolicy/thunderbird.pp -i
/usr/share/selinux/refpolicy/timidity.pp -i
/usr/share/selinux/refpolicy/tmpreaper.pp -i
/usr/share/selinux/refpolicy/tor.pp -i
/usr/share/selinux/refpolicy/transproxy.pp -i
/usr/share/selinux/refpolicy/tripwire.pp -i
/usr/share/selinux/refpolicy/tvtime.pp -i
/usr/share/selinux/refpolicy/tzdata.pp -i
/usr/share/selinux/refpolicy/ucspitcp.pp -i
/usr/share/selinux/refpolicy/udev.pp -i /usr/share/selinux/refpolicy/uml.pp
-i /usr/share/selinux/refpolicy/unconfined.pp -i
/usr/share/selinux/refpolicy/updfstab.pp -i
/usr/share/selinux/refpolicy/uptime.pp -i
/usr/share/selinux/refpolicy/usbmodules.pp -i
/usr/share/selinux/refpolicy/userdomain.pp -i
/usr/share/selinux/refpolicy/userhelper.pp -i
/usr/share/selinux/refpolicy/usermanage.pp -i
/usr/share/selinux/refpolicy/usernetctl.pp -i
/usr/share/selinux/refpolicy/uucp.pp -i
/usr/share/selinux/refpolicy/uwimap.pp -i
/usr/share/selinux/refpolicy/vbetool.pp -i
/usr/share/selinux/refpolicy/vmware.pp -i
/usr/share/selinux/refpolicy/vpn.pp -i
/usr/share/selinux/refpolicy/watchdog.pp -i
/usr/share/selinux/refpolicy/webalizer.pp -i
/usr/share/selinux/refpolicy/wine.pp -i
/usr/share/selinux/refpolicy/wireshark.pp -i
/usr/share/selinux/refpolicy/xen.pp -i /usr/share/selinux/refpolicy/xfs.pp
-i /usr/share/selinux/refpolicy/xprint.pp -i
/usr/share/selinux/refpolicy/xserver.pp -i
/usr/share/selinux/refpolicy/yam.pp -i
/usr/share/selinux/refpolicy/zabbix.pp -i
/usr/share/selinux/refpolicy/zebra.pp
security: ebitmap: map size 0 does not match my size 64 (high bit was 4)
libsepol.sepol_module_package_read: invalid module in module package (at
section 0)
libsemanage.semanage_load_module: Error while reading from module file
/etc/selinux/refpolicy/modules/tmp/modules/unconfined.pp.
/usr/sbin/semodule:  Failed!

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Reference Policy Version: 2008 04 02

semodule from: policycoreutils-2.0.55

Any Suggestion what could be the Problem???

-- 
Waqar Afridi

--0016e64dda7800df890486c51dc7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All<br><div class=3D"gmail_quote"><div dir=3D"ltr"><=
br>I am trying to port trisys reference policy on my Openmoko Software Stac=
k, When ever I try to load it I get the Following error<br><br>++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++<br>


<br><b>root@om-gta02 ~/refpolicy $ make load</b><br>Loading configured modu=
les.<br>/usr/sbin/semodule -s refpolicy -b /usr/share/selinux/refpolicy/bas=
e.pp -i /usr/share/selinux/refpolicy/acct.pp -i /usr/share/selinux/refpolic=
y/ada.pp -i /usr/share/selinux/refpolicy/afs.pp -i /usr/share/selinux/refpo=
licy/aide.pp -i /usr/share/selinux/refpolicy/alsa.pp -i /usr/share/selinux/=
refpolicy/amanda.pp -i /usr/share/selinux/refpolicy/amavis.pp -i /usr/share=
/selinux/refpolicy/amtu.pp -i /usr/share/selinux/refpolicy/anaconda.pp -i /=
usr/share/selinux/refpolicy/apache.pp -i /usr/share/selinux/refpolicy/apcup=
sd.pp -i /usr/share/selinux/refpolicy/apm.pp -i /usr/share/selinux/refpolic=
y/application.pp -i /usr/share/selinux/refpolicy/apt.pp -i /usr/share/selin=
ux/refpolicy/arpwatch.pp -i /usr/share/selinux/refpolicy/asterisk.pp -i /us=
r/share/selinux/refpolicy/audioentropy.pp -i /usr/share/selinux/refpolicy/a=
uthbind.pp -i /usr/share/selinux/refpolicy/authlogin.pp -i /usr/share/selin=
ux/refpolicy/automount.pp -i /usr/share/selinux/refpolicy/avahi.pp -i /usr/=
share/selinux/refpolicy/awstats.pp -i /usr/share/selinux/refpolicy/backup.p=
p -i /usr/share/selinux/refpolicy/bind.pp -i /usr/share/selinux/refpolicy/b=
itlbee.pp -i /usr/share/selinux/refpolicy/bluetooth.pp -i /usr/share/selinu=
x/refpolicy/bootloader.pp -i /usr/share/selinux/refpolicy/brctl.pp -i /usr/=
share/selinux/refpolicy/calamaris.pp -i /usr/share/selinux/refpolicy/canna.=
pp -i /usr/share/selinux/refpolicy/ccs.pp -i /usr/share/selinux/refpolicy/c=
drecord.pp -i /usr/share/selinux/refpolicy/certwatch.pp -i /usr/share/selin=
ux/refpolicy/cipe.pp -i /usr/share/selinux/refpolicy/clamav.pp -i /usr/shar=
e/selinux/refpolicy/clock.pp -i /usr/share/selinux/refpolicy/clockspeed.pp =
-i /usr/share/selinux/refpolicy/comsat.pp -i /usr/share/selinux/refpolicy/c=
onsolekit.pp -i /usr/share/selinux/refpolicy/consoletype.pp -i /usr/share/s=
elinux/refpolicy/courier.pp -i /usr/share/selinux/refpolicy/cpucontrol.pp -=
i /usr/share/selinux/refpolicy/cron.pp -i /usr/share/selinux/refpolicy/cups=
.pp -i /usr/share/selinux/refpolicy/cvs.pp -i /usr/share/selinux/refpolicy/=
cyrus.pp -i /usr/share/selinux/refpolicy/daemontools.pp -i /usr/share/selin=
ux/refpolicy/dante.pp -i /usr/share/selinux/refpolicy/dbskk.pp -i /usr/shar=
e/selinux/refpolicy/dbus.pp -i /usr/share/selinux/refpolicy/dcc.pp -i /usr/=
share/selinux/refpolicy/ddclient.pp -i /usr/share/selinux/refpolicy/ddcprob=
e.pp -i /usr/share/selinux/refpolicy/dhcp.pp -i /usr/share/selinux/refpolic=
y/dictd.pp -i /usr/share/selinux/refpolicy/distcc.pp -i /usr/share/selinux/=
refpolicy/djbdns.pp -i /usr/share/selinux/refpolicy/dmesg.pp -i /usr/share/=
selinux/refpolicy/dmidecode.pp -i /usr/share/selinux/refpolicy/dnsmasq.pp -=
i /usr/share/selinux/refpolicy/dovecot.pp -i /usr/share/selinux/refpolicy/d=
pkg.pp -i /usr/share/selinux/refpolicy/ethereal.pp -i /usr/share/selinux/re=
fpolicy/evolution.pp -i /usr/share/selinux/refpolicy/exim.pp -i /usr/share/=
selinux/refpolicy/fail2ban.pp -i /usr/share/selinux/refpolicy/fetchmail.pp =
-i /usr/share/selinux/refpolicy/finger.pp -i /usr/share/selinux/refpolicy/f=
irstboot.pp -i /usr/share/selinux/refpolicy/fstools.pp -i /usr/share/selinu=
x/refpolicy/ftp.pp -i /usr/share/selinux/refpolicy/games.pp -i /usr/share/s=
elinux/refpolicy/gatekeeper.pp -i /usr/share/selinux/refpolicy/getty.pp -i =
/usr/share/selinux/refpolicy/gift.pp -i /usr/share/selinux/refpolicy/gnome.=
pp -i /usr/share/selinux/refpolicy/gpg.pp -i /usr/share/selinux/refpolicy/g=
pm.pp -i /usr/share/selinux/refpolicy/hal.pp -i /usr/share/selinux/refpolic=
y/hostname.pp -i /usr/share/selinux/refpolicy/hotplug.pp -i /usr/share/seli=
nux/refpolicy/howl.pp -i /usr/share/selinux/refpolicy/i18n_input.pp -i /usr=
/share/selinux/refpolicy/imaze.pp -i /usr/share/selinux/refpolicy/inetd.pp =
-i /usr/share/selinux/refpolicy/init.pp -i /usr/share/selinux/refpolicy/inn=
.pp -i /usr/share/selinux/refpolicy/ipsec.pp -i /usr/share/selinux/refpolic=
y/iptables.pp -i /usr/share/selinux/refpolicy/irc.pp -i /usr/share/selinux/=
refpolicy/ircd.pp -i /usr/share/selinux/refpolicy/irqbalance.pp -i /usr/sha=
re/selinux/refpolicy/iscsi.pp -i /usr/share/selinux/refpolicy/jabber.pp -i =
/usr/share/selinux/refpolicy/java.pp -i /usr/share/selinux/refpolicy/kerber=
os.pp -i /usr/share/selinux/refpolicy/ktalk.pp -i /usr/share/selinux/refpol=
icy/kudzu.pp -i /usr/share/selinux/refpolicy/ldap.pp -i /usr/share/selinux/=
refpolicy/libraries.pp -i /usr/share/selinux/refpolicy/loadkeys.pp -i /usr/=
share/selinux/refpolicy/locallogin.pp -i /usr/share/selinux/refpolicy/lockd=
ev.pp -i /usr/share/selinux/refpolicy/logging.pp -i /usr/share/selinux/refp=
olicy/logrotate.pp -i /usr/share/selinux/refpolicy/logwatch.pp -i /usr/shar=
e/selinux/refpolicy/lpd.pp -i /usr/share/selinux/refpolicy/lvm.pp -i /usr/s=
hare/selinux/refpolicy/mailman.pp -i /usr/share/selinux/refpolicy/miscfiles=
.pp -i /usr/share/selinux/refpolicy/modutils.pp -i /usr/share/selinux/refpo=
licy/mono.pp -i /usr/share/selinux/refpolicy/monop.pp -i /usr/share/selinux=
/refpolicy/mount.pp -i /usr/share/selinux/refpolicy/mozilla.pp -i /usr/shar=
e/selinux/refpolicy/mplayer.pp -i /usr/share/selinux/refpolicy/mrtg.pp -i /=
usr/share/selinux/refpolicy/mta.pp -i /usr/share/selinux/refpolicy/munin.pp=
 -i /usr/share/selinux/refpolicy/mysql.pp -i /usr/share/selinux/refpolicy/n=
agios.pp -i /usr/share/selinux/refpolicy/nessus.pp -i /usr/share/selinux/re=
fpolicy/netlabel.pp -i /usr/share/selinux/refpolicy/netutils.pp -i /usr/sha=
re/selinux/refpolicy/networkmanager.pp -i /usr/share/selinux/refpolicy/nis.=
pp -i /usr/share/selinux/refpolicy/nscd.pp -i /usr/share/selinux/refpolicy/=
nsd.pp -i /usr/share/selinux/refpolicy/ntop.pp -i /usr/share/selinux/refpol=
icy/ntp.pp -i /usr/share/selinux/refpolicy/nx.pp -i /usr/share/selinux/refp=
olicy/oav.pp -i /usr/share/selinux/refpolicy/oddjob.pp -i /usr/share/selinu=
x/refpolicy/openca.pp -i /usr/share/selinux/refpolicy/openct.pp -i /usr/sha=
re/selinux/refpolicy/openvpn.pp -i /usr/share/selinux/refpolicy/pcmcia.pp -=
i /usr/share/selinux/refpolicy/pcscd.pp -i /usr/share/selinux/refpolicy/peg=
asus.pp -i /usr/share/selinux/refpolicy/perdition.pp -i /usr/share/selinux/=
refpolicy/portage.pp -i /usr/share/selinux/refpolicy/portmap.pp -i /usr/sha=
re/selinux/refpolicy/portslave.pp -i /usr/share/selinux/refpolicy/postfix.p=
p -i /usr/share/selinux/refpolicy/postfixpolicyd.pp -i /usr/share/selinux/r=
efpolicy/postgresql.pp -i /usr/share/selinux/refpolicy/postgrey.pp -i /usr/=
share/selinux/refpolicy/ppp.pp -i /usr/share/selinux/refpolicy/prelink.pp -=
i /usr/share/selinux/refpolicy/privoxy.pp -i /usr/share/selinux/refpolicy/p=
rocmail.pp -i /usr/share/selinux/refpolicy/publicfile.pp -i /usr/share/seli=
nux/refpolicy/pxe.pp -i /usr/share/selinux/refpolicy/pyzor.pp -i /usr/share=
/selinux/refpolicy/qmail.pp -i /usr/share/selinux/refpolicy/quota.pp -i /us=
r/share/selinux/refpolicy/radius.pp -i /usr/share/selinux/refpolicy/radvd.p=
p -i /usr/share/selinux/refpolicy/raid.pp -i /usr/share/selinux/refpolicy/r=
azor.pp -i /usr/share/selinux/refpolicy/rdisc.pp -i /usr/share/selinux/refp=
olicy/readahead.pp -i /usr/share/selinux/refpolicy/remotelogin.pp -i /usr/s=
hare/selinux/refpolicy/resmgr.pp -i /usr/share/selinux/refpolicy/rhgb.pp -i=
 /usr/share/selinux/refpolicy/ricci.pp -i /usr/share/selinux/refpolicy/rlog=
in.pp -i /usr/share/selinux/refpolicy/roundup.pp -i /usr/share/selinux/refp=
olicy/rpc.pp -i /usr/share/selinux/refpolicy/rpcbind.pp -i /usr/share/selin=
ux/refpolicy/rpm.pp -i /usr/share/selinux/refpolicy/rshd.pp -i /usr/share/s=
elinux/refpolicy/rssh.pp -i /usr/share/selinux/refpolicy/rsync.pp -i /usr/s=
hare/selinux/refpolicy/rwho.pp -i /usr/share/selinux/refpolicy/samba.pp -i =
/usr/share/selinux/refpolicy/sasl.pp -i /usr/share/selinux/refpolicy/screen=
.pp -i /usr/share/selinux/refpolicy/selinuxutil.pp -i /usr/share/selinux/re=
fpolicy/sendmail.pp -i /usr/share/selinux/refpolicy/setrans.pp -i /usr/shar=
e/selinux/refpolicy/setroubleshoot.pp -i /usr/share/selinux/refpolicy/sloca=
te.pp -i /usr/share/selinux/refpolicy/slrnpull.pp -i /usr/share/selinux/ref=
policy/smartmon.pp -i /usr/share/selinux/refpolicy/snmp.pp -i /usr/share/se=
linux/refpolicy/snort.pp -i /usr/share/selinux/refpolicy/soundserver.pp -i =
/usr/share/selinux/refpolicy/spamassassin.pp -i /usr/share/selinux/refpolic=
y/speedtouch.pp -i /usr/share/selinux/refpolicy/squid.pp -i /usr/share/seli=
nux/refpolicy/ssh.pp -i /usr/share/selinux/refpolicy/storage.pp -i /usr/sha=
re/selinux/refpolicy/stunnel.pp -i /usr/share/selinux/refpolicy/su.pp -i /u=
sr/share/selinux/refpolicy/sudo.pp -i /usr/share/selinux/refpolicy/sxid.pp =
-i /usr/share/selinux/refpolicy/sysnetwork.pp -i /usr/share/selinux/refpoli=
cy/sysstat.pp -i /usr/share/selinux/refpolicy/tcpd.pp -i /usr/share/selinux=
/refpolicy/telnet.pp -i /usr/share/selinux/refpolicy/tftp.pp -i /usr/share/=
selinux/refpolicy/thunderbird.pp -i /usr/share/selinux/refpolicy/timidity.p=
p -i /usr/share/selinux/refpolicy/tmpreaper.pp -i /usr/share/selinux/refpol=
icy/tor.pp -i /usr/share/selinux/refpolicy/transproxy.pp -i /usr/share/seli=
nux/refpolicy/tripwire.pp -i /usr/share/selinux/refpolicy/tvtime.pp -i /usr=
/share/selinux/refpolicy/tzdata.pp -i /usr/share/selinux/refpolicy/ucspitcp=
.pp -i /usr/share/selinux/refpolicy/udev.pp -i /usr/share/selinux/refpolicy=
/uml.pp -i /usr/share/selinux/refpolicy/unconfined.pp -i /usr/share/selinux=
/refpolicy/updfstab.pp -i /usr/share/selinux/refpolicy/uptime.pp -i /usr/sh=
are/selinux/refpolicy/usbmodules.pp -i /usr/share/selinux/refpolicy/userdom=
ain.pp -i /usr/share/selinux/refpolicy/userhelper.pp -i /usr/share/selinux/=
refpolicy/usermanage.pp -i /usr/share/selinux/refpolicy/usernetctl.pp -i /u=
sr/share/selinux/refpolicy/uucp.pp -i /usr/share/selinux/refpolicy/uwimap.p=
p -i /usr/share/selinux/refpolicy/vbetool.pp -i /usr/share/selinux/refpolic=
y/vmware.pp -i /usr/share/selinux/refpolicy/vpn.pp -i /usr/share/selinux/re=
fpolicy/watchdog.pp -i /usr/share/selinux/refpolicy/webalizer.pp -i /usr/sh=
are/selinux/refpolicy/wine.pp -i /usr/share/selinux/refpolicy/wireshark.pp =
-i /usr/share/selinux/refpolicy/xen.pp -i /usr/share/selinux/refpolicy/xfs.=
pp -i /usr/share/selinux/refpolicy/xprint.pp -i /usr/share/selinux/refpolic=
y/xserver.pp -i /usr/share/selinux/refpolicy/yam.pp -i /usr/share/selinux/r=
efpolicy/zabbix.pp -i /usr/share/selinux/refpolicy/zebra.pp<br>


security: ebitmap: map size 0 does not match my size 64 (high bit was 4)<br=
>libsepol.sepol_module_package_read: invalid module in module package (at s=
ection 0)<br>libsemanage.semanage_load_module: Error while reading from mod=
ule file /etc/selinux/refpolicy/modules/tmp/modules/unconfined.pp.<br>


/usr/sbin/semodule:=A0 Failed!<br>=A0<br>++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++<br clear=3D"all"><=
br>Reference Policy Version: 2008 04 02<br><br>semodule from: policycoreuti=
ls-2.0.55<br>

<br>Any Suggestion what could be the Problem???<br>
<br></div></div>-- <br>Waqar Afridi<br>
</div>

--0016e64dda7800df890486c51dc7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
