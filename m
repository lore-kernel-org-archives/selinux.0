Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA00926
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 09:57:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h23EvlI18764
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 14:57:47 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h23Evjf18759 for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 14:57:46 GMT
Received: from localhost (wsalamon@localhost)
	by vox.gw.tislabs.com (8.11.2/8.11.2) with ESMTP id h23EPFT14761
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 09:25:15 -0500
Date: Mon, 3 Mar 2003 09:25:15 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Core policy, third pass
Message-ID: <Pine.LNX.4.33.0303030916220.14620-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


  I've built another policy based on the feedback to the list (thanks to
all who commented). Here's 'core':

checkpolicy.te  getty.te     ldconfig.te     netutils.te  su.te
chkpwd.te       ifconfig.te  load_policy.te  newrole.te   syslogd.te
crond.te        inetd.te     login.te        passwd.te    tmpreaper.te
crontab.te      initrc.te    logrotate.te    portmap.te
init.te         modutil.te   setfiles.te     useradd.te
fsadm.te        klogd.te     mount.te        ssh.te

  This policy will build as long as the recent su_macros.te and
lpr_macros.te files are used.

  We plan on tagging the current Sourceforge selinux tree 'preCore', then
moving non-core .te files to domains/program/unused. The next phase is to
then audit/reduce the core policy.

  Comments?

  The Tresys 'sepcut' tool is very useful when experimenting with the
policy builds.

  For reference, here's the list of non-core:

acct.te        ftpd.te              ntpd.te           sendmail.te
amanda.te      games.te             oav-update.te     slapd.te
amavis.te      gatekeeper.te        openca-ca.te      snmpd.te
apache.te      gnome-pty-helper.te  pamconsole.te     snort.te
apmd.te        gpg.te               perdition.te      sound.te
atd.te         gpm.te               ping.te           speedmgmt.te
authbind.te    hotplug.te           portslave.te      squid.te
automount.te   hwclock.te           postfix.te        sxid.te
backup.te      ipchains.te          postgresql.te     sysstat.te
bootloader.te  ipsec.te             pppd.te           tcpd.te
calamaris.te   ircd.te              procmail.te       tftpd.te
cardmgr.te     irc.te               pump.te           traceroute.te
chroot.te      kcheckpass.te        qmail.te          transproxy.te
clamav.te      lpd.te               quota.te          uml_net.te
courier.te     lpr.te               radius.te         uml.te
crack.te       mailman.te           radvd.te          usbmodules.te
cups.te        mrtg.te              rlogind.te        utempter.te
ddt-client.te  mta.te               rpcd.te           vmware.te
devfsd.te      mysqld.te            rpm.te            watchdog.te
dhcpc.te       named.te             rshd.te           xauth.te
dhcpd.te       nessusd.te           samba.te          xdm.te
dictd.te       netscape.te          scannerdaemon.te  xfs.te
dpkg.te        nscd.te              screen.te         xserver.te
fingerd.te     nsd.te               selopt.te         ypbind.te

-- 
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
