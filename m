Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1JIHBGS008213
	for <selinux@tycho.nsa.gov>; Fri, 19 Feb 2010 13:17:11 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1JIGtZA027472
	for <selinux@tycho.nsa.gov>; Fri, 19 Feb 2010 18:16:56 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id o1JIHdx0021795
	for <selinux@tycho.nsa.gov>; Fri, 19 Feb 2010 13:17:39 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id o1JIHd0h021793
	for selinux@tycho.nsa.gov; Fri, 19 Feb 2010 13:17:39 -0500
From: Alan Rouse <alan.rouse@ericsson.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Fri, 19 Feb 2010 10:29:27 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A780DE6@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7C47DB.40602@gmail.com>
	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780280@EUSAACMS0703.eamcs.ericsson.se>
	 <1266437939.4945.132.camel@moss-pluto.epoch.ncsc.mil>
	 <1266438301.4945.134.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A7802A0@EUSAACMS0703.eamcs.ericsson.se>
	 <1266438910.4945.137.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A7802D6@EUSAACMS0703.eamcs.ericsson.se>
	 <1266440973.4945.142.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780310@EUSAACMS0703.eamcs.ericsson.se>
	 <1266442158.4945.144.camel@moss-pluto.epoch.ncsc.mil>
	 <1266442637.4945.147.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78036F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266508987.21209.45.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780863@EUSAACMS0703.eamcs.ericsson.se>
	 <1266515620.21209.47.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A7808E8@EUSAACMS0703.eamcs.ericsson.se>
 <1266590959.32011.43.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266590959.32011.43.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wrote:
>> Now "getsebool init_upstart" returns "off" again.
And Stephen replied:
> We need to figure out why that is happening.
> Can you do this?
>
> . /etc/selinux/config
> ls -lR /etc/selinux/$SELINUXTYPE
> strace load_policy

=======================================================================
. /etc/selinux/config
ls -lR /etc/selinux/$SELINUXTYPE
=======================================================================
/etc/selinux/refpolicy-standard:
total 28
-rw-r--r--. 1 root root 2029 Oct 19 17:09 booleans
drwxr-xr-x. 4 root root 4096 Feb 18 16:36 contexts
drwx------. 3 root root 4096 Feb 18 16:36 modules
drwxr-xr-x. 2 root root 4096 Feb 18 16:48 policy
-rw-r--r--. 1 root root   47 Feb 18 16:36 seusers
drwxr-xr-x. 3 root root 4096 Feb 18 15:07 src
drwxr-xr-x. 2 root root 4096 Feb 18 14:46 users

/etc/selinux/refpolicy-standard/contexts:
total 48
-rw-r--r--. 1 root root    0 Feb 18 16:25 customizable_types
-rw-r--r--. 1 root root  195 Feb 18 16:18 dbus_contexts
-rw-r--r--. 1 root root  875 Feb 18 16:18 default_contexts
-rw-r--r--. 1 root root  114 Feb 18 16:18 default_type
-rw-r--r--. 1 root root   18 Feb 18 16:18 failsafe_context
drwxr-xr-x. 2 root root 4096 Feb 18 16:36 files
-rw-r--r--. 1 root root   27 Feb 18 16:18 initrc_context
-rw-r--r--. 1 root root    0 Feb 18 16:36 netfilter_contexts
-rw-r--r--. 1 root root   30 Feb 18 16:18 removable_context
-rw-r--r--. 1 root root  123 Feb 18 16:18 securetty_types
-rw-r--r--. 1 root root   27 Feb 18 16:18 userhelper_context
drwxr-xr-x. 2 root root 4096 Feb 18 16:18 users
-rw-r--r--. 1 root root 7051 Feb 18 16:18 x_contexts

/etc/selinux/refpolicy-standard/contexts/files:
total 152
-rw-r--r--. 1 root root 139886 Feb 18 16:36 file_contexts
-rw-r--r--. 1 root root   2663 Feb 18 16:36 file_contexts.homedirs
-rw-r--r--. 1 root root   2527 Oct 19 17:09 homedir_template
-rw-r--r--. 1 root root    130 Feb 18 16:18 media

/etc/selinux/refpolicy-standard/contexts/users:
total 16
-rw-r--r--. 1 root root 630 Feb 18 16:18 root
-rw-r--r--. 1 root root 378 Feb 18 16:18 staff_u
-rw-r--r--. 1 root root 452 Feb 18 16:18 unconfined_u
-rw-r--r--. 1 root root 242 Feb 18 16:18 user_u

/etc/selinux/refpolicy-standard/modules:
total 4
drwx------. 3 root root 4096 Feb 18 16:36 active
-rw-------. 1 root root    0 Feb 18 15:07 semanage.read.LOCK
-rw-------. 1 root root    0 Feb 18 15:07 semanage.trans.LOCK

/etc/selinux/refpolicy-standard/modules/active:
total 3936
-rw-r--r--. 1 root root   20377 Feb 18 16:36 base.pp
-rw-------. 1 root root      32 Feb 18 16:36 commit_num
-rw-------. 1 root root  139886 Feb 18 16:36 file_contexts
-rw-r--r--. 1 root root    2663 Feb 18 16:36 file_contexts.homedirs
-rw-------. 1 root root  142369 Feb 18 16:36 file_contexts.template
-rw-------. 1 root root    2483 Feb 18 16:36 homedir_template
drwx------. 2 root root   12288 Feb 18 16:36 modules
-rw-------. 1 root root       0 Feb 18 16:36 netfilter_contexts
-rw-r--r--. 1 root root 3687284 Feb 18 16:36 policy.kern
-rw-------. 1 root root      47 Feb 18 16:36 seusers.final
-rw-------. 1 root root     143 Feb 18 16:36 users_extra

/etc/selinux/refpolicy-standard/modules/active/modules:
total 2380
-rw-r--r--. 1 root root  6057 Feb 18 16:36 acct.pp
-rw-r--r--. 1 root root  5951 Feb 18 16:36 ada.pp
-rw-r--r--. 1 root root  7520 Feb 18 16:36 afs.pp
-rw-r--r--. 1 root root  5283 Feb 18 16:36 aide.pp
-rw-r--r--. 1 root root  6562 Feb 18 16:36 alsa.pp
-rw-r--r--. 1 root root  8311 Feb 18 16:36 amanda.pp
-rw-r--r--. 1 root root  7308 Feb 18 16:36 amavis.pp
-rw-r--r--. 1 root root  5114 Feb 18 16:36 amtu.pp
-rw-r--r--. 1 root root  6670 Feb 18 16:36 anaconda.pp
-rw-r--r--. 1 root root 14679 Feb 18 16:36 apache.pp
-rw-r--r--. 1 root root  8846 Feb 18 16:36 apcupsd.pp
-rw-r--r--. 1 root root  8482 Feb 18 16:36 apm.pp
-rw-r--r--. 1 root root  4571 Feb 18 16:36 application.pp
-rw-r--r--. 1 root root  7799 Feb 18 16:36 apt.pp
-rw-r--r--. 1 root root  6964 Feb 18 16:36 arpwatch.pp
-rw-r--r--. 1 root root  6877 Feb 18 16:36 asterisk.pp
-rw-r--r--. 1 root root  5778 Feb 18 16:36 audioentropy.pp
-rw-r--r--. 1 root root 25101 Feb 18 16:36 auditadm.pp
-rw-r--r--. 1 root root  5088 Feb 18 16:36 authbind.pp
-rw-r--r--. 1 root root 10256 Feb 18 16:36 authlogin.pp
-rw-r--r--. 1 root root  7767 Feb 18 16:36 automount.pp
-rw-r--r--. 1 root root  7134 Feb 18 16:36 avahi.pp
-rw-r--r--. 1 root root  7942 Feb 18 16:36 awstats.pp
-rw-r--r--. 1 root root  6199 Feb 18 16:36 backup.pp
-rw-r--r--. 1 root root  8655 Feb 18 16:36 bind.pp
-rw-r--r--. 1 root root  6265 Feb 18 16:36 bitlbee.pp
-rw-r--r--. 1 root root  9473 Feb 18 16:36 bluetooth.pp
-rw-r--r--. 1 root root  6881 Feb 18 16:36 bootloader.pp
-rw-r--r--. 1 root root  5358 Feb 18 16:36 brctl.pp
-rw-r--r--. 1 root root  6323 Feb 18 16:36 calamaris.pp
-rw-r--r--. 1 root root  6694 Feb 18 16:36 canna.pp
-rw-r--r--. 1 root root  6336 Feb 18 16:36 ccs.pp
-rw-r--r--. 1 root root  5812 Feb 18 16:36 cdrecord.pp
-rw-r--r--. 1 root root  5466 Feb 18 16:36 certwatch.pp
-rw-r--r--. 1 root root  6241 Feb 18 16:36 cipe.pp
-rw-r--r--. 1 root root  7380 Feb 18 16:36 clamav.pp
-rw-r--r--. 1 root root  5864 Feb 18 16:36 clock.pp
-rw-r--r--. 1 root root  6074 Feb 18 16:36 clockspeed.pp
-rw-r--r--. 1 root root  6851 Feb 18 16:36 comsat.pp
-rw-r--r--. 1 root root  6772 Feb 18 16:36 consolekit.pp
-rw-r--r--. 1 root root  6377 Feb 18 16:36 consoletype.pp
-rw-r--r--. 1 root root  9222 Feb 18 16:36 courier.pp
-rw-r--r--. 1 root root  6124 Feb 18 16:36 cpucontrol.pp
-rw-r--r--. 1 root root 12970 Feb 18 16:36 cron.pp
-rw-r--r--. 1 root root 12252 Feb 18 16:36 cups.pp
-rw-r--r--. 1 root root  9506 Feb 18 16:36 cvs.pp
-rw-r--r--. 1 root root  6666 Feb 18 16:36 cyphesis.pp
-rw-r--r--. 1 root root  7921 Feb 18 16:36 cyrus.pp
-rw-r--r--. 1 root root  5941 Feb 18 16:36 daemontools.pp
-rw-r--r--. 1 root root  5993 Feb 18 16:36 dante.pp
-rw-r--r--. 1 root root  6821 Feb 18 16:36 dbskk.pp
-rw-r--r--. 1 root root  7235 Feb 18 16:36 dbus.pp
-rw-r--r--. 1 root root  9925 Feb 18 16:36 dcc.pp
-rw-r--r--. 1 root root  6579 Feb 18 16:36 ddclient.pp
-rw-r--r--. 1 root root  5374 Feb 18 16:36 ddcprobe.pp
-rw-r--r--. 1 root root  7327 Feb 18 16:36 dhcp.pp
-rw-r--r--. 1 root root  6505 Feb 18 16:36 dictd.pp
-rw-r--r--. 1 root root  6484 Feb 18 16:36 distcc.pp
-rw-r--r--. 1 root root  5851 Feb 18 16:36 djbdns.pp
-rw-r--r--. 1 root root  5476 Feb 18 16:36 dmesg.pp
-rw-r--r--. 1 root root  5079 Feb 18 16:36 dmidecode.pp
-rw-r--r--. 1 root root  6626 Feb 18 16:36 dnsmasq.pp
-rw-r--r--. 1 root root  8646 Feb 18 16:36 dovecot.pp
-rw-r--r--. 1 root root  9839 Feb 18 16:36 dpkg.pp
-rw-r--r--. 1 root root  7720 Feb 18 16:36 ethereal.pp
-rw-r--r--. 1 root root 11778 Feb 18 16:36 evolution.pp
-rw-r--r--. 1 root root  6993 Feb 18 16:36 exim.pp
-rw-r--r--. 1 root root  7013 Feb 18 16:36 fail2ban.pp
-rw-r--r--. 1 root root  6416 Feb 18 16:36 fetchmail.pp
-rw-r--r--. 1 root root  7011 Feb 18 16:36 finger.pp
-rw-r--r--. 1 root root  7751 Feb 18 16:36 firstboot.pp
-rw-r--r--. 1 root root  7353 Feb 18 16:36 fstools.pp
-rw-r--r--. 1 root root  9265 Feb 18 16:36 ftp.pp
-rw-r--r--. 1 root root  8329 Feb 18 16:36 games.pp
-rw-r--r--. 1 root root  6543 Feb 18 16:36 gatekeeper.pp
-rw-r--r--. 1 root root  6463 Feb 18 16:36 getty.pp
-rw-r--r--. 1 root root  7463 Feb 18 16:36 gift.pp
-rw-r--r--. 1 root root  5758 Feb 18 16:36 gnome.pp
-rw-r--r--. 1 root root  7317 Feb 18 16:36 gpg.pp
-rw-r--r--. 1 root root  5960 Feb 18 16:36 gpm.pp
-rw-r--r--. 1 root root 11220 Feb 18 16:36 hal.pp
-rw-r--r--. 1 root root  5716 Feb 18 16:36 hostname.pp
-rw-r--r--. 1 root root  7918 Feb 18 16:36 hotplug.pp
-rw-r--r--. 1 root root  6354 Feb 18 16:36 howl.pp
-rw-r--r--. 1 root root  6657 Feb 18 16:36 i18n_input.pp
-rw-r--r--. 1 root root  6483 Feb 18 16:36 imaze.pp
-rw-r--r--. 1 root root  9313 Feb 18 16:36 inetd.pp
-rw-r--r--. 1 root root 13836 Feb 18 16:36 init.pp
-rw-r--r--. 1 root root  7409 Feb 18 16:36 inn.pp
-rw-r--r--. 1 root root  8415 Feb 18 16:36 ipsec.pp
-rw-r--r--. 1 root root  7206 Feb 18 16:36 iptables.pp
-rw-r--r--. 1 root root  6286 Feb 18 16:36 irc.pp
-rw-r--r--. 1 root root  6489 Feb 18 16:36 ircd.pp
-rw-r--r--. 1 root root  5773 Feb 18 16:36 irqbalance.pp
-rw-r--r--. 1 root root  6134 Feb 18 16:36 iscsi.pp
-rw-r--r--. 1 root root  6632 Feb 18 16:36 jabber.pp
-rw-r--r--. 1 root root  8906 Feb 18 16:36 java.pp
-rw-r--r--. 1 root root  8537 Feb 18 16:36 kerberos.pp
-rw-r--r--. 1 root root  5968 Feb 18 16:36 kerneloops.pp
-rw-r--r--. 1 root root  6355 Feb 18 16:36 kismet.pp
-rw-r--r--. 1 root root  6904 Feb 18 16:36 ktalk.pp
-rw-r--r--. 1 root root  7695 Feb 18 16:36 kudzu.pp
-rw-r--r--. 1 root root  7455 Feb 18 16:36 ldap.pp
-rw-r--r--. 1 root root  6633 Feb 18 16:36 libraries.pp
-rw-r--r--. 1 root root  5283 Feb 18 16:36 loadkeys.pp
-rw-r--r--. 1 root root 10343 Feb 18 16:36 locallogin.pp
-rw-r--r--. 1 root root  5271 Feb 18 16:36 lockdev.pp
-rw-r--r--. 1 root root 10172 Feb 18 16:36 logging.pp
-rw-r--r--. 1 root root  7922 Feb 18 16:36 logrotate.pp
-rw-r--r--. 1 root root  7392 Feb 18 16:36 logwatch.pp
-rw-r--r--. 1 root root  9024 Feb 18 16:36 lpd.pp
-rw-r--r--. 1 root root  8679 Feb 18 16:36 lvm.pp
-rw-r--r--. 1 root root  9142 Feb 18 16:36 mailman.pp
-rw-r--r--. 1 root root  5834 Feb 18 16:36 memcached.pp
-rw-r--r--. 1 root root  6904 Feb 18 16:36 milter.pp
-rw-r--r--. 1 root root  5008 Feb 18 16:36 miscfiles.pp
-rw-r--r--. 1 root root  7806 Feb 18 16:36 modutils.pp
-rw-r--r--. 1 root root  6118 Feb 18 16:36 mono.pp
-rw-r--r--. 1 root root  6323 Feb 18 16:36 monop.pp
-rw-r--r--. 1 root root  8396 Feb 18 16:36 mount.pp
-rw-r--r--. 1 root root  8756 Feb 18 16:36 mozilla.pp
-rw-r--r--. 1 root root  7751 Feb 18 16:36 mplayer.pp
-rw-r--r--. 1 root root  7328 Feb 18 16:36 mrtg.pp
-rw-r--r--. 1 root root  9064 Feb 18 16:36 mta.pp
-rw-r--r--. 1 root root  6848 Feb 18 16:36 munin.pp
-rw-r--r--. 1 root root  7318 Feb 18 16:36 mysql.pp
-rw-r--r--. 1 root root  8125 Feb 18 16:36 nagios.pp
-rw-r--r--. 1 root root  6627 Feb 18 16:36 nessus.pp
-rw-r--r--. 1 root root  5037 Feb 18 16:36 netlabel.pp
-rw-r--r--. 1 root root  8167 Feb 18 16:36 netutils.pp
-rw-r--r--. 1 root root  8264 Feb 18 16:36 networkmanager.pp
-rw-r--r--. 1 root root  7820 Feb 18 16:36 nis.pp
-rw-r--r--. 1 root root  6995 Feb 18 16:36 nscd.pp
-rw-r--r--. 1 root root  7138 Feb 18 16:36 nsd.pp
-rw-r--r--. 1 root root  6284 Feb 18 16:36 ntop.pp
-rw-r--r--. 1 root root  7638 Feb 18 16:36 ntp.pp
-rw-r--r--. 1 root root  7453 Feb 18 16:36 nx.pp
-rw-r--r--. 1 root root  6739 Feb 18 16:36 oav.pp
-rw-r--r--. 1 root root  6281 Feb 18 16:36 oddjob.pp
-rw-r--r--. 1 root root  6422 Feb 18 16:36 oident.pp
-rw-r--r--. 1 root root  5311 Feb 18 16:36 openca.pp
-rw-r--r--. 1 root root  5806 Feb 18 16:36 openct.pp
-rw-r--r--. 1 root root  6880 Feb 18 16:36 openvpn.pp
-rw-r--r--. 1 root root  6796 Feb 18 16:36 pcmcia.pp
-rw-r--r--. 1 root root  6032 Feb 18 16:36 pcscd.pp
-rw-r--r--. 1 root root  7912 Feb 18 16:36 pegasus.pp
-rw-r--r--. 1 root root  5971 Feb 18 16:36 perdition.pp
-rw-r--r--. 1 root root  5244 Feb 18 16:36 podsleuth.pp
-rw-r--r--. 1 root root  8851 Feb 18 16:36 portage.pp
-rw-r--r--. 1 root root  6945 Feb 18 16:36 portmap.pp
-rw-r--r--. 1 root root  7678 Feb 18 16:36 portslave.pp
-rw-r--r--. 1 root root 17478 Feb 18 16:36 postfix.pp
-rw-r--r--. 1 root root  5921 Feb 18 16:36 postfixpolicyd.pp
-rw-r--r--. 1 root root  9350 Feb 18 16:36 postgresql.pp
-rw-r--r--. 1 root root  6716 Feb 18 16:36 postgrey.pp
-rw-r--r--. 1 root root  8809 Feb 18 16:36 ppp.pp
-rw-r--r--. 1 root root  5887 Feb 18 16:36 prelink.pp
-rw-r--r--. 1 root root  9230 Feb 18 16:36 prelude.pp
-rw-r--r--. 1 root root  6800 Feb 18 16:36 privoxy.pp
-rw-r--r--. 1 root root  7482 Feb 18 16:36 procmail.pp
-rw-r--r--. 1 root root  5542 Feb 18 16:36 publicfile.pp
-rw-r--r--. 1 root root  5841 Feb 18 16:36 pxe.pp
-rw-r--r--. 1 root root  7829 Feb 18 16:36 pyzor.pp
-rw-r--r--. 1 root root  7154 Feb 18 16:36 qemu.pp
-rw-r--r--. 1 root root 10224 Feb 18 16:36 qmail.pp
-rw-r--r--. 1 root root  5886 Feb 18 16:36 quota.pp
-rw-r--r--. 1 root root  8162 Feb 18 16:36 radius.pp
-rw-r--r--. 1 root root  6440 Feb 18 16:36 radvd.pp
-rw-r--r--. 1 root root  7113 Feb 18 16:36 raid.pp
-rw-r--r--. 1 root root  7515 Feb 18 16:36 razor.pp
-rw-r--r--. 1 root root  5753 Feb 18 16:36 rdisc.pp
-rw-r--r--. 1 root root  6201 Feb 18 16:36 readahead.pp
-rw-r--r--. 1 root root  9167 Feb 18 16:36 remotelogin.pp
-rw-r--r--. 1 root root  5842 Feb 18 16:36 resmgr.pp
-rw-r--r--. 1 root root  6961 Feb 18 16:36 rhgb.pp
-rw-r--r--. 1 root root 11578 Feb 18 16:36 ricci.pp
-rw-r--r--. 1 root root  7638 Feb 18 16:36 rlogin.pp
-rw-r--r--. 1 root root  6363 Feb 18 16:36 roundup.pp
-rw-r--r--. 1 root root  9554 Feb 18 16:36 rpc.pp
-rw-r--r--. 1 root root  6127 Feb 18 16:36 rpcbind.pp
-rw-r--r--. 1 root root 10826 Feb 18 16:36 rpm.pp
-rw-r--r--. 1 root root  8149 Feb 18 16:36 rshd.pp
-rw-r--r--. 1 root root  6196 Feb 18 16:36 rssh.pp
-rw-r--r--. 1 root root  7535 Feb 18 16:36 rsync.pp
-rw-r--r--. 1 root root  5943 Feb 18 16:36 rwho.pp
-rw-r--r--. 1 root root 15271 Feb 18 16:36 samba.pp
-rw-r--r--. 1 root root  7763 Feb 18 16:36 sasl.pp
-rw-r--r--. 1 root root  4973 Feb 18 16:36 screen.pp
-rw-r--r--. 1 root root 25271 Feb 18 16:36 secadm.pp
-rw-r--r--. 1 root root 12046 Feb 18 16:36 selinuxutil.pp
-rw-r--r--. 1 root root  7537 Feb 18 16:36 sendmail.pp
-rw-r--r--. 1 root root  5902 Feb 18 16:36 setrans.pp
-rw-r--r--. 1 root root  7274 Feb 18 16:36 setroubleshoot.pp
-rw-r--r--. 1 root root  6467 Feb 18 16:36 slocate.pp
-rw-r--r--. 1 root root  5977 Feb 18 16:36 slrnpull.pp
-rw-r--r--. 1 root root  6628 Feb 18 16:36 smartmon.pp
-rw-r--r--. 1 root root  7907 Feb 18 16:36 snmp.pp
-rw-r--r--. 1 root root  6384 Feb 18 16:36 snort.pp
-rw-r--r--. 1 root root  6545 Feb 18 16:36 soundserver.pp
-rw-r--r--. 1 root root  9528 Feb 18 16:36 spamassassin.pp
-rw-r--r--. 1 root root  5823 Feb 18 16:36 speedtouch.pp
-rw-r--r--. 1 root root 10291 Feb 18 16:36 squid.pp
-rw-r--r--. 1 root root 12933 Feb 18 16:36 ssh.pp
-rw-r--r--. 1 root root 24422 Feb 18 16:36 staff.pp
-rw-r--r--. 1 root root  5223 Feb 18 16:36 storage.pp
-rw-r--r--. 1 root root  6924 Feb 18 16:36 stunnel.pp
-rw-r--r--. 1 root root  4567 Feb 18 16:36 su.pp
-rw-r--r--. 1 root root  4533 Feb 18 16:36 sudo.pp
-rw-r--r--. 1 root root  6136 Feb 18 16:36 sxid.pp
-rw-r--r--. 1 root root 29684 Feb 18 16:36 sysadm.pp
-rw-r--r--. 1 root root  8864 Feb 18 16:36 sysnetwork.pp
-rw-r--r--. 1 root root  5811 Feb 18 16:36 sysstat.pp
-rw-r--r--. 1 root root  5767 Feb 18 16:36 tcpd.pp
-rw-r--r--. 1 root root  7262 Feb 18 16:36 telnet.pp
-rw-r--r--. 1 root root  7066 Feb 18 16:36 tftp.pp
-rw-r--r--. 1 root root  8786 Feb 18 16:36 thunderbird.pp
-rw-r--r--. 1 root root  6073 Feb 18 16:36 timidity.pp
-rw-r--r--. 1 root root  5415 Feb 18 16:36 tmpreaper.pp
-rw-r--r--. 1 root root  6829 Feb 18 16:36 tor.pp
-rw-r--r--. 1 root root  5911 Feb 18 16:36 transproxy.pp
-rw-r--r--. 1 root root  6439 Feb 18 16:36 tripwire.pp
-rw-r--r--. 1 root root  6827 Feb 18 16:36 tvtime.pp
-rw-r--r--. 1 root root  5559 Feb 18 16:36 tzdata.pp
-rw-r--r--. 1 root root  5839 Feb 18 16:36 ucspitcp.pp
-rw-r--r--. 1 root root  8928 Feb 18 16:36 udev.pp
-rw-r--r--. 1 root root  7407 Feb 18 16:36 uml.pp
-rw-r--r--. 1 root root 11422 Feb 18 16:36 unconfined.pp
-rw-r--r--. 1 root root 24283 Feb 18 16:36 unprivuser.pp
-rw-r--r--. 1 root root  6482 Feb 18 16:36 updfstab.pp
-rw-r--r--. 1 root root  5994 Feb 18 16:36 uptime.pp
-rw-r--r--. 1 root root  5324 Feb 18 16:36 usbmodules.pp
-rw-r--r--. 1 root root  5326 Feb 18 16:36 userdomain.pp
-rw-r--r--. 1 root root  4631 Feb 18 16:36 userhelper.pp
-rw-r--r--. 1 root root 11006 Feb 18 16:36 usermanage.pp
-rw-r--r--. 1 root root  6500 Feb 18 16:36 usernetctl.pp
-rw-r--r--. 1 root root  7482 Feb 18 16:36 uucp.pp
-rw-r--r--. 1 root root  7399 Feb 18 16:36 uwimap.pp
-rw-r--r--. 1 root root  5276 Feb 18 16:36 vbetool.pp
-rw-r--r--. 1 root root  8917 Feb 18 16:36 virt.pp
-rw-r--r--. 1 root root  8875 Feb 18 16:36 vmware.pp
-rw-r--r--. 1 root root  7120 Feb 18 16:36 vpn.pp
-rw-r--r--. 1 root root  7574 Feb 18 16:36 w3c.pp
-rw-r--r--. 1 root root  6699 Feb 18 16:36 watchdog.pp
-rw-r--r--. 1 root root  6560 Feb 18 16:36 webalizer.pp
-rw-r--r--. 1 root root  5970 Feb 18 16:36 wine.pp
-rw-r--r--. 1 root root  6498 Feb 18 16:36 wireshark.pp
-rw-r--r--. 1 root root  8691 Feb 18 16:36 xen.pp
-rw-r--r--. 1 root root  6905 Feb 18 16:36 xfs.pp
-rw-r--r--. 1 root root  6412 Feb 18 16:36 xprint.pp
-rw-r--r--. 1 root root 16921 Feb 18 16:36 xserver.pp
-rw-r--r--. 1 root root  6743 Feb 18 16:36 yam.pp
-rw-r--r--. 1 root root  5762 Feb 18 16:36 zabbix.pp
-rw-r--r--. 1 root root  6993 Feb 18 16:36 zebra.pp

/etc/selinux/refpolicy-standard/policy:
total 3604
-rw-r--r--. 1 root root 3687284 Feb 18 16:36 policy.24

/etc/selinux/refpolicy-standard/src:
total 12
drwxr-xr-x. 8 root root 12288 Feb 18 16:24 policy

/etc/selinux/refpolicy-standard/src/policy:
total 29996
-rw-r--r--. 1 root root  18009 Feb 18 15:07 COPYING
-rw-r--r--. 1 root root  24498 Feb 18 15:07 Changelog
-rw-r--r--. 1 root root   1170 Feb 18 15:07 INSTALL
-rw-r--r--. 1 root root  21735 Feb 18 15:07 Makefile
-rw-r--r--. 1 root root  10206 Feb 18 15:07 README
-rw-r--r--. 1 root root   8093 Feb 18 15:07 Rules.modular
-rw-r--r--. 1 root root   8559 Feb 18 15:07 Rules.monolithic
-rw-r--r--. 1 root root     11 Feb 18 15:07 VERSION
-rw-r--r--. 1 root root  60867 Feb 18 16:22 acct.pp
-rw-r--r--. 1 root root  59016 Feb 18 16:22 ada.pp
-rw-r--r--. 1 root root 116935 Feb 18 16:22 afs.pp
-rw-r--r--. 1 root root  42452 Feb 18 16:22 aide.pp
-rw-r--r--. 1 root root  70472 Feb 18 16:22 alsa.pp
-rw-r--r--. 1 root root 127092 Feb 18 16:22 amanda.pp
-rw-r--r--. 1 root root  88814 Feb 18 16:22 amavis.pp
-rw-r--r--. 1 root root  43550 Feb 18 16:22 amtu.pp
-rw-r--r--. 1 root root  77830 Feb 18 16:22 anaconda.pp
-rw-r--r--. 1 root root 354987 Feb 18 16:22 apache.pp
-rw-r--r--. 1 root root 125824 Feb 18 16:22 apcupsd.pp
-rw-r--r--. 1 root root 125726 Feb 18 16:22 apm.pp
-rw-r--r--. 1 root root  31212 Feb 18 16:22 application.pp
-rw-r--r--. 1 root root  94086 Feb 18 16:22 apt.pp
-rw-r--r--. 1 root root  81567 Feb 18 16:22 arpwatch.pp
-rw-r--r--. 1 root root  73292 Feb 18 16:22 asterisk.pp
-rw-r--r--. 1 root root  53740 Feb 18 16:22 audioentropy.pp
-rw-r--r--. 1 root root 753878 Feb 18 16:22 auditadm.pp
-rw-r--r--. 1 root root  40076 Feb 18 16:22 authbind.pp
-rw-r--r--. 1 root root 221019 Feb 18 16:22 authlogin.pp
-rw-r--r--. 1 root root 102626 Feb 18 16:23 automount.pp
-rw-r--r--. 1 root root  85569 Feb 18 16:23 avahi.pp
-rw-r--r--. 1 root root 107027 Feb 18 16:23 awstats.pp
-rw-r--r--. 1 root root  62329 Feb 18 16:23 backup.pp
-rw-r--r--. 1 root root 399695 Feb 18 16:22 base.conf
-rw-r--r--. 1 root root  18796 Feb 18 16:22 base.fc
-rw-r--r--. 1 root root 216829 Feb 18 16:22 base.pp
-rw-r--r--. 1 root root 140207 Feb 18 16:23 bind.pp
-rw-r--r--. 1 root root  66225 Feb 18 16:23 bitlbee.pp
-rw-r--r--. 1 root root 139368 Feb 18 16:23 bluetooth.pp
-rw-r--r--. 1 root root  80937 Feb 18 16:23 bootloader.pp
-rw-r--r--. 1 root root  52367 Feb 18 16:23 brctl.pp
-rw-r--r--. 1 root root   1876 Feb 18 15:07 build.conf
-rw-r--r--. 1 root root  65172 Feb 18 16:23 calamaris.pp
-rw-r--r--. 1 root root  67655 Feb 18 16:23 canna.pp
-rw-r--r--. 1 root root  61204 Feb 18 16:23 ccs.pp
-rw-r--r--. 1 root root  55858 Feb 18 16:23 cdrecord.pp
-rw-r--r--. 1 root root  50845 Feb 18 16:23 certwatch.pp
-rw-r--r--. 1 root root  64046 Feb 18 16:23 cipe.pp
-rw-r--r--. 1 root root 103605 Feb 18 16:23 clamav.pp
-rw-r--r--. 1 root root  59601 Feb 18 16:23 clock.pp
-rw-r--r--. 1 root root  63339 Feb 18 16:23 clockspeed.pp
-rw-r--r--. 1 root root  78906 Feb 18 16:23 comsat.pp
drwxr-xr-x. 5 root root   4096 Feb 18 15:07 config
-rw-r--r--. 1 root root  78754 Feb 18 16:23 consolekit.pp
-rw-r--r--. 1 root root  79723 Feb 18 16:23 consoletype.pp
-rw-r--r--. 1 root root 195175 Feb 18 16:23 courier.pp
-rw-r--r--. 1 root root  74398 Feb 18 16:23 cpucontrol.pp
-rw-r--r--. 1 root root 322765 Feb 18 16:23 cron.pp
-rw-r--r--. 1 root root 329577 Feb 18 16:23 cups.pp
-rw-r--r--. 1 root root 163792 Feb 18 16:23 cvs.pp
-rw-r--r--. 1 root root  69304 Feb 18 16:23 cyphesis.pp
-rw-r--r--. 1 root root 106686 Feb 18 16:23 cyrus.pp
-rw-r--r--. 1 root root  74198 Feb 18 16:23 daemontools.pp
-rw-r--r--. 1 root root  56714 Feb 18 16:23 dante.pp
-rw-r--r--. 1 root root  79827 Feb 18 16:23 dbskk.pp
-rw-r--r--. 1 root root  85897 Feb 18 16:23 dbus.pp
-rw-r--r--. 1 root root 272791 Feb 18 16:23 dcc.pp
-rw-r--r--. 1 root root  65441 Feb 18 16:23 ddclient.pp
-rw-r--r--. 1 root root  47878 Feb 18 16:23 ddcprobe.pp
-rw-r--r--. 1 root root  90148 Feb 18 16:23 dhcp.pp
-rw-r--r--. 1 root root  69008 Feb 18 16:23 dictd.pp
-rw-r--r--. 1 root root  66681 Feb 18 16:23 distcc.pp
-rw-r--r--. 1 root root  71355 Feb 18 16:23 djbdns.pp
-rw-r--r--. 1 root root  50208 Feb 18 16:23 dmesg.pp
-rw-r--r--. 1 root root  40065 Feb 18 16:23 dmidecode.pp
-rw-r--r--. 1 root root  68387 Feb 18 16:23 dnsmasq.pp
drwxr-xr-x. 3 root root   4096 Feb 18 15:07 doc
-rw-r--r--. 1 root root 162926 Feb 18 16:23 dovecot.pp
-rw-r--r--. 1 root root 182116 Feb 18 16:23 dpkg.pp
-rw-r--r--. 1 root root  88687 Feb 18 16:23 ethereal.pp
-rw-r--r--. 1 root root 224088 Feb 18 16:23 evolution.pp
-rw-r--r--. 1 root root  80311 Feb 18 16:23 exim.pp
-rw-r--r--. 1 root root  83356 Feb 18 16:23 fail2ban.pp
-rw-r--r--. 1 root root  64211 Feb 18 16:23 fetchmail.pp
-rw-r--r--. 1 root root  86742 Feb 18 16:23 finger.pp
-rw-r--r--. 1 root root  99547 Feb 18 16:23 firstboot.pp
-rw-r--r--. 1 root root  81899 Feb 18 16:23 fstools.pp
-rw-r--r--. 1 root root 158768 Feb 18 16:23 ftp.pp
-rw-r--r--. 1 root root  93012 Feb 18 16:23 games.pp
-rw-r--r--. 1 root root  66196 Feb 18 16:23 gatekeeper.pp
-rw-r--r--. 1 root root  74271 Feb 18 16:23 getty.pp
-rw-r--r--. 1 root root  78777 Feb 18 16:23 gift.pp
-rw-r--r--. 1 root root  50256 Feb 18 16:23 gnome.pp
-rw-r--r--. 1 root root 100423 Feb 18 16:23 gpg.pp
-rw-r--r--. 1 root root  55431 Feb 18 16:23 gpm.pp
-rw-r--r--. 1 root root 251392 Feb 18 16:23 hal.pp
-rw-r--r--. 1 root root  55456 Feb 18 16:23 hostname.pp
-rw-r--r--. 1 root root 120056 Feb 18 16:23 hotplug.pp
-rw-r--r--. 1 root root  64416 Feb 18 16:23 howl.pp
-rw-r--r--. 1 root root  70466 Feb 18 16:23 i18n_input.pp
-rw-r--r--. 1 root root  65292 Feb 18 16:23 imaze.pp
-rw-r--r--. 1 root root 143501 Feb 18 16:23 inetd.pp
-rw-r--r--. 1 root root 350464 Feb 18 16:23 init.pp
-rw-r--r--. 1 root root  80386 Feb 18 16:23 inn.pp
-rw-r--r--. 1 root root 136329 Feb 18 16:23 ipsec.pp
-rw-r--r--. 1 root root  95237 Feb 18 16:23 iptables.pp
-rw-r--r--. 1 root root  59437 Feb 18 16:23 irc.pp
-rw-r--r--. 1 root root  66059 Feb 18 16:23 ircd.pp
-rw-r--r--. 1 root root  54736 Feb 18 16:23 irqbalance.pp
-rw-r--r--. 1 root root  62424 Feb 18 16:23 iscsi.pp
-rw-r--r--. 1 root root  67208 Feb 18 16:23 jabber.pp
-rw-r--r--. 1 root root 112129 Feb 18 16:23 java.pp
-rw-r--r--. 1 root root 137581 Feb 18 16:23 kerberos.pp
-rw-r--r--. 1 root root  55757 Feb 18 16:23 kerneloops.pp
-rw-r--r--. 1 root root  65653 Feb 18 16:23 kismet.pp
-rw-r--r--. 1 root root  79367 Feb 18 16:23 ktalk.pp
-rw-r--r--. 1 root root  98201 Feb 18 16:23 kudzu.pp
-rw-r--r--. 1 root root  92449 Feb 18 16:23 ldap.pp
-rw-r--r--. 1 root root  60657 Feb 18 16:23 libraries.pp
-rw-r--r--. 1 root root  46017 Feb 18 16:23 loadkeys.pp
-rw-r--r--. 1 root root 196440 Feb 18 16:23 locallogin.pp
-rw-r--r--. 1 root root  42047 Feb 18 16:23 lockdev.pp
-rw-r--r--. 1 root root 199269 Feb 18 16:23 logging.pp
-rw-r--r--. 1 root root 108028 Feb 18 16:23 logrotate.pp
-rw-r--r--. 1 root root  98264 Feb 18 16:23 logwatch.pp
-rw-r--r--. 1 root root 149090 Feb 18 16:23 lpd.pp
-rw-r--r--. 1 root root 129311 Feb 18 16:23 lvm.pp
-rw-r--r--. 1 root root 198209 Feb 18 16:23 mailman.pp
drwxr-xr-x. 4 root root   4096 Feb 18 15:07 man
-rw-r--r--. 1 root root  51908 Feb 18 16:23 memcached.pp
-rw-r--r--. 1 root root  86439 Feb 18 16:23 milter.pp
-rw-r--r--. 1 root root  31851 Feb 18 16:23 miscfiles.pp
-rw-r--r--. 1 root root 115111 Feb 18 16:23 modutils.pp
-rw-r--r--. 1 root root  68509 Feb 18 16:23 mono.pp
-rw-r--r--. 1 root root  63488 Feb 18 16:23 monop.pp
-rw-r--r--. 1 root root 120983 Feb 18 16:23 mount.pp
-rw-r--r--. 1 root root 108633 Feb 18 16:23 mozilla.pp
-rw-r--r--. 1 root root  96700 Feb 18 16:23 mplayer.pp
-rw-r--r--. 1 root root  93972 Feb 18 16:23 mrtg.pp
-rw-r--r--. 1 root root 168313 Feb 18 16:23 mta.pp
-rw-r--r--. 1 root root  73212 Feb 18 16:23 munin.pp
-rw-r--r--. 1 root root  87041 Feb 18 16:23 mysql.pp
-rw-r--r--. 1 root root 137366 Feb 18 16:23 nagios.pp
-rw-r--r--. 1 root root  67814 Feb 18 16:23 nessus.pp
-rw-r--r--. 1 root root  39973 Feb 18 16:23 netlabel.pp
-rw-r--r--. 1 root root 157555 Feb 18 16:23 netutils.pp
-rw-r--r--. 1 root root 115159 Feb 18 16:23 networkmanager.pp
-rw-r--r--. 1 root root 134665 Feb 18 16:23 nis.pp
-rw-r--r--. 1 root root  84959 Feb 18 16:23 nscd.pp
-rw-r--r--. 1 root root  95238 Feb 18 16:23 nsd.pp
-rw-r--r--. 1 root root  66496 Feb 18 16:23 ntop.pp
-rw-r--r--. 1 root root 102060 Feb 18 16:23 ntp.pp
-rw-r--r--. 1 root root  92837 Feb 18 16:23 nx.pp
-rw-r--r--. 1 root root  77674 Feb 18 16:23 oav.pp
-rw-r--r--. 1 root root  82852 Feb 18 16:23 oddjob.pp
-rw-r--r--. 1 root root  61117 Feb 18 16:23 oident.pp
-rw-r--r--. 1 root root  42834 Feb 18 16:23 openca.pp
-rw-r--r--. 1 root root  54539 Feb 18 16:23 openct.pp
-rw-r--r--. 1 root root  70448 Feb 18 16:23 openvpn.pp
-rw-r--r--. 1 root root  78864 Feb 18 16:23 pcmcia.pp
-rw-r--r--. 1 root root  65014 Feb 18 16:23 pcscd.pp
-rw-r--r--. 1 root root 116613 Feb 18 16:24 pegasus.pp
-rw-r--r--. 1 root root  56203 Feb 18 16:24 perdition.pp
-rw-r--r--. 1 root root  43502 Feb 18 16:24 podsleuth.pp
drwxr-xr-x. 5 root root   4096 Feb 18 16:36 policy
-rw-r--r--. 1 root root 148288 Feb 18 16:24 portage.pp
-rw-r--r--. 1 root root  90102 Feb 18 16:24 portmap.pp
-rw-r--r--. 1 root root 115728 Feb 18 16:24 portslave.pp
-rw-r--r--. 1 root root 714170 Feb 18 16:24 postfix.pp
-rw-r--r--. 1 root root  53386 Feb 18 16:24 postfixpolicyd.pp
-rw-r--r--. 1 root root 130088 Feb 18 16:24 postgresql.pp
-rw-r--r--. 1 root root  70444 Feb 18 16:24 postgrey.pp
-rw-r--r--. 1 root root 139258 Feb 18 16:24 ppp.pp
-rw-r--r--. 1 root root  55264 Feb 18 16:24 prelink.pp
-rw-r--r--. 1 root root 155082 Feb 18 16:24 prelude.pp
-rw-r--r--. 1 root root  72238 Feb 18 16:24 privoxy.pp
-rw-r--r--. 1 root root  95161 Feb 18 16:24 procmail.pp
-rw-r--r--. 1 root root  54352 Feb 18 16:24 publicfile.pp
-rw-r--r--. 1 root root  53870 Feb 18 16:24 pxe.pp
-rw-r--r--. 1 root root 116164 Feb 18 16:24 pyzor.pp
-rw-r--r--. 1 root root  93642 Feb 18 16:24 qemu.pp
-rw-r--r--. 1 root root 264774 Feb 18 16:24 qmail.pp
-rw-r--r--. 1 root root  55902 Feb 18 16:24 quota.pp
-rw-r--r--. 1 root root 122131 Feb 18 16:24 radius.pp
-rw-r--r--. 1 root root  65765 Feb 18 16:24 radvd.pp
-rw-r--r--. 1 root root  82274 Feb 18 16:24 raid.pp
-rw-r--r--. 1 root root 108144 Feb 18 16:24 razor.pp
-rw-r--r--. 1 root root  54359 Feb 18 16:24 rdisc.pp
-rw-r--r--. 1 root root  66150 Feb 18 16:24 readahead.pp
-rw-r--r--. 1 root root 151191 Feb 18 16:24 remotelogin.pp
-rw-r--r--. 1 root root  55738 Feb 18 16:24 resmgr.pp
-rw-r--r--. 1 root root  80366 Feb 18 16:24 rhgb.pp
-rw-r--r--. 1 root root 278922 Feb 18 16:24 ricci.pp
-rw-r--r--. 1 root root 113168 Feb 18 16:24 rlogin.pp
-rw-r--r--. 1 root root  62661 Feb 18 16:24 roundup.pp
-rw-r--r--. 1 root root 222357 Feb 18 16:24 rpc.pp
-rw-r--r--. 1 root root  57311 Feb 18 16:24 rpcbind.pp
-rw-r--r--. 1 root root 208833 Feb 18 16:24 rpm.pp
-rw-r--r--. 1 root root 132869 Feb 18 16:24 rshd.pp
-rw-r--r--. 1 root root  56752 Feb 18 16:24 rssh.pp
-rw-r--r--. 1 root root 100247 Feb 18 16:24 rsync.pp
-rw-r--r--. 1 root root  53794 Feb 18 16:24 rwho.pp
-rw-r--r--. 1 root root 501041 Feb 18 16:24 samba.pp
-rw-r--r--. 1 root root 116865 Feb 18 16:24 sasl.pp
-rw-r--r--. 1 root root  32153 Feb 18 16:24 screen.pp
-rw-r--r--. 1 root root 758738 Feb 18 16:24 secadm.pp
-rw-r--r--. 1 root root 316588 Feb 18 16:24 selinuxutil.pp
-rw-r--r--. 1 root root  96940 Feb 18 16:24 sendmail.pp
-rw-r--r--. 1 root root  54132 Feb 18 16:24 setrans.pp
-rw-r--r--. 1 root root  94235 Feb 18 16:24 setroubleshoot.pp
-rw-r--r--. 1 root root  69886 Feb 18 16:24 slocate.pp
-rw-r--r--. 1 root root  57287 Feb 18 16:24 slrnpull.pp
-rw-r--r--. 1 root root  68831 Feb 18 16:24 smartmon.pp
-rw-r--r--. 1 root root 108741 Feb 18 16:24 snmp.pp
-rw-r--r--. 1 root root  60989 Feb 18 16:24 snort.pp
-rw-r--r--. 1 root root  64634 Feb 18 16:24 soundserver.pp
-rw-r--r--. 1 root root 171492 Feb 18 16:24 spamassassin.pp
-rw-r--r--. 1 root root  54698 Feb 18 16:24 speedtouch.pp
-rw-r--r--. 1 root root 180578 Feb 18 16:24 squid.pp
-rw-r--r--. 1 root root 279950 Feb 18 16:24 ssh.pp
-rw-r--r--. 1 root root 720590 Feb 18 16:24 staff.pp
-rw-r--r--. 1 root root  34192 Feb 18 16:24 storage.pp
-rw-r--r--. 1 root root  85508 Feb 18 16:24 stunnel.pp
-rw-r--r--. 1 root root  29824 Feb 18 16:24 su.pp
-rw-r--r--. 1 root root  29768 Feb 18 16:24 sudo.pp
drwxr-xr-x. 2 root root   4096 Feb 18 16:15 support
-rw-r--r--. 1 root root  59783 Feb 18 16:24 sxid.pp
-rw-r--r--. 1 root root 957005 Feb 18 16:24 sysadm.pp
-rw-r--r--. 1 root root 144933 Feb 18 16:24 sysnetwork.pp
-rw-r--r--. 1 root root  54729 Feb 18 16:24 sysstat.pp
-rw-r--r--. 1 root root  52775 Feb 18 16:24 tcpd.pp
-rw-r--r--. 1 root root  86646 Feb 18 16:24 telnet.pp
-rw-r--r--. 1 root root  90348 Feb 18 16:24 tftp.pp
-rw-r--r--. 1 root root 113471 Feb 18 16:24 thunderbird.pp
-rw-r--r--. 1 root root  63905 Feb 18 16:24 timidity.pp
drwxr-xr-x. 2 root root  36864 Feb 18 16:25 tmp
-rw-r--r--. 1 root root  47763 Feb 18 16:24 tmpreaper.pp
-rw-r--r--. 1 root root  77128 Feb 18 16:24 tor.pp
-rw-r--r--. 1 root root  55189 Feb 18 16:24 transproxy.pp
-rw-r--r--. 1 root root  89792 Feb 18 16:24 tripwire.pp
-rw-r--r--. 1 root root  62480 Feb 18 16:24 tvtime.pp
-rw-r--r--. 1 root root  55602 Feb 18 16:24 tzdata.pp
-rw-r--r--. 1 root root  68207 Feb 18 16:24 ucspitcp.pp
-rw-r--r--. 1 root root 132495 Feb 18 16:24 udev.pp
-rw-r--r--. 1 root root  84610 Feb 18 16:24 uml.pp
-rw-r--r--. 1 root root 242448 Feb 18 16:24 unconfined.pp
-rw-r--r--. 1 root root 715268 Feb 18 16:24 unprivuser.pp
-rw-r--r--. 1 root root  74784 Feb 18 16:24 updfstab.pp
-rw-r--r--. 1 root root  57820 Feb 18 16:24 uptime.pp
-rw-r--r--. 1 root root  48374 Feb 18 16:24 usbmodules.pp
-rw-r--r--. 1 root root  35738 Feb 18 16:24 userdomain.pp
-rw-r--r--. 1 root root  30046 Feb 18 16:24 userhelper.pp
-rw-r--r--. 1 root root 295491 Feb 18 16:24 usermanage.pp
-rw-r--r--. 1 root root  78414 Feb 18 16:24 usernetctl.pp
-rw-r--r--. 1 root root 100071 Feb 18 16:24 uucp.pp
-rw-r--r--. 1 root root  97364 Feb 18 16:24 uwimap.pp
-rw-r--r--. 1 root root  45186 Feb 18 16:24 vbetool.pp
-rw-r--r--. 1 root root 130978 Feb 18 16:24 virt.pp
-rw-r--r--. 1 root root 108071 Feb 18 16:24 vmware.pp
-rw-r--r--. 1 root root  83858 Feb 18 16:24 vpn.pp
-rw-r--r--. 1 root root  89388 Feb 18 16:24 w3c.pp
-rw-r--r--. 1 root root  69752 Feb 18 16:24 watchdog.pp
-rw-r--r--. 1 root root  67982 Feb 18 16:24 webalizer.pp
-rw-r--r--. 1 root root  60854 Feb 18 16:24 wine.pp
-rw-r--r--. 1 root root  65013 Feb 18 16:24 wireshark.pp
-rw-r--r--. 1 root root 151169 Feb 18 16:24 xen.pp
-rw-r--r--. 1 root root  79747 Feb 18 16:24 xfs.pp
-rw-r--r--. 1 root root  68048 Feb 18 16:24 xprint.pp
-rw-r--r--. 1 root root 404586 Feb 18 16:24 xserver.pp
-rw-r--r--. 1 root root  72176 Feb 18 16:24 yam.pp
-rw-r--r--. 1 root root  52302 Feb 18 16:24 zabbix.pp
-rw-r--r--. 1 root root  76147 Feb 18 16:24 zebra.pp

/etc/selinux/refpolicy-standard/src/policy/config:
total 16
drwxr-xr-x. 2 root root 4096 Feb 18 15:07 appconfig-mcs
drwxr-xr-x. 2 root root 4096 Feb 18 15:07 appconfig-mls
drwxr-xr-x. 2 root root 4096 Feb 18 16:11 appconfig-standard
-rw-r--r--. 1 root root  722 Feb 18 15:07 local.users

/etc/selinux/refpolicy-standard/src/policy/config/appconfig-mcs:
total 64
-rw-r--r--. 1 root root  195 Feb 18 15:07 dbus_contexts
-rw-r--r--. 1 root root 1018 Feb 18 15:07 default_contexts
-rw-r--r--. 1 root root  114 Feb 18 15:07 default_type
-rw-r--r--. 1 root root   21 Feb 18 15:07 failsafe_context
-rw-r--r--. 1 root root   30 Feb 18 15:07 initrc_context
-rw-r--r--. 1 root root  139 Feb 18 15:07 media
-rw-r--r--. 1 root root   33 Feb 18 15:07 removable_context
-rw-r--r--. 1 root root  724 Feb 18 15:07 root_default_contexts
-rw-r--r--. 1 root root  123 Feb 18 15:07 securetty_types
-rw-r--r--. 1 root root   86 Feb 18 15:07 seusers
-rw-r--r--. 1 root root  433 Feb 18 15:07 staff_u_default_contexts
-rw-r--r--. 1 root root  503 Feb 18 15:07 unconfined_u_default_contexts
-rw-r--r--. 1 root root  280 Feb 18 15:07 user_u_default_contexts
-rw-r--r--. 1 root root   30 Feb 18 15:07 userhelper_context
-rw-r--r--. 1 root root 7327 Feb 18 15:07 x_contexts

/etc/selinux/refpolicy-standard/src/policy/config/appconfig-mls:
total 64
-rw-r--r--. 1 root root  195 Feb 18 15:07 dbus_contexts
-rw-r--r--. 1 root root 1018 Feb 18 15:07 default_contexts
-rw-r--r--. 1 root root  114 Feb 18 15:07 default_type
-rw-r--r--. 1 root root   21 Feb 18 15:07 failsafe_context
-rw-r--r--. 1 root root   45 Feb 18 15:07 initrc_context
-rw-r--r--. 1 root root  139 Feb 18 15:07 media
-rw-r--r--. 1 root root   33 Feb 18 15:07 removable_context
-rw-r--r--. 1 root root  724 Feb 18 15:07 root_default_contexts
-rw-r--r--. 1 root root  123 Feb 18 15:07 securetty_types
-rw-r--r--. 1 root root   86 Feb 18 15:07 seusers
-rw-r--r--. 1 root root  433 Feb 18 15:07 staff_u_default_contexts
-rw-r--r--. 1 root root  503 Feb 18 15:07 unconfined_u_default_contexts
-rw-r--r--. 1 root root  280 Feb 18 15:07 user_u_default_contexts
-rw-r--r--. 1 root root   30 Feb 18 15:07 userhelper_context
-rw-r--r--. 1 root root 7327 Feb 18 15:07 x_contexts

/etc/selinux/refpolicy-standard/src/policy/config/appconfig-standard:
total 64
-rw-r--r--. 1 root root  195 Feb 18 15:07 dbus_contexts
-rw-r--r--. 1 root root  875 Feb 18 15:07 default_contexts
-rw-r--r--. 1 root root  114 Feb 18 15:07 default_type
-rw-r--r--. 1 root root   18 Feb 18 15:07 failsafe_context
-rw-r--r--. 1 root root   27 Feb 18 15:07 initrc_context
-rw-r--r--. 1 root root  130 Feb 18 15:07 media
-rw-r--r--. 1 root root   30 Feb 18 15:07 removable_context
-rw-r--r--. 1 root root  630 Feb 18 15:07 root_default_contexts
-rw-r--r--. 1 root root  123 Feb 18 15:07 securetty_types
-rw-r--r--. 1 root root   47 Feb 18 15:07 seusers
-rw-r--r--. 1 root root  378 Feb 18 15:07 staff_u_default_contexts
-rw-r--r--. 1 root root  452 Feb 18 15:07 unconfined_u_default_contexts
-rw-r--r--. 1 root root  242 Feb 18 15:07 user_u_default_contexts
-rw-r--r--. 1 root root   27 Feb 18 15:07 userhelper_context
-rw-r--r--. 1 root root 7051 Feb 18 15:07 x_contexts

/etc/selinux/refpolicy-standard/src/policy/doc:
total 1436
-rw-r--r--. 1 root root     195 Feb 18 15:07 Makefile.example
-rw-r--r--. 1 root root     185 Feb 18 15:07 example.fc
-rw-r--r--. 1 root root    1033 Feb 18 15:07 example.if
-rw-r--r--. 1 root root     516 Feb 18 15:07 example.te
-rw-r--r--. 1 root root     550 Feb 18 15:07 global_booleans.xml
-rw-r--r--. 1 root root    2654 Feb 18 15:07 global_tunables.xml
-rw-r--r--. 1 root root    1393 Feb 18 15:07 policy.dtd
-rw-r--r--. 1 root root 1435250 Feb 18 16:22 policy.xml
drwxr-xr-x. 2 root root    4096 Feb 18 15:07 templates

/etc/selinux/refpolicy-standard/src/policy/doc/templates:
total 64
-rw-r--r--. 1 root root  531 Feb 18 15:07 bool_list.html
-rw-r--r--. 1 root root  296 Feb 18 15:07 boolean.html
-rw-r--r--. 1 root root  281 Feb 18 15:07 global_bool_list.html
-rw-r--r--. 1 root root  275 Feb 18 15:07 global_tun_list.html
-rw-r--r--. 1 root root  280 Feb 18 15:07 header.html
-rw-r--r--. 1 root root  705 Feb 18 15:07 int_list.html
-rw-r--r--. 1 root root  997 Feb 18 15:07 interface.html
-rw-r--r--. 1 root root  806 Feb 18 15:07 menu.html
-rw-r--r--. 1 root root 1062 Feb 18 15:07 module.html
-rw-r--r--. 1 root root  492 Feb 18 15:07 module_list.html
-rw-r--r--. 1 root root 4282 Feb 18 15:07 style.css
-rw-r--r--. 1 root root  708 Feb 18 15:07 temp_list.html
-rw-r--r--. 1 root root  998 Feb 18 15:07 template.html
-rw-r--r--. 1 root root  517 Feb 18 15:07 tun_list.html
-rw-r--r--. 1 root root  288 Feb 18 15:07 tunable.html

/etc/selinux/refpolicy-standard/src/policy/man:
total 8
drwxr-xr-x. 2 root root 4096 Feb 18 15:07 man8
drwxr-xr-x. 3 root root 4096 Feb 18 15:07 ru

/etc/selinux/refpolicy-standard/src/policy/man/man8:
total 40
-rw-r--r--. 1 root root 2022 Feb 18 15:07 ftpd_selinux.8
-rw-r--r--. 1 root root 5100 Feb 18 15:07 httpd_selinux.8
-rw-r--r--. 1 root root  870 Feb 18 15:07 kerberos_selinux.8
-rw-r--r--. 1 root root  891 Feb 18 15:07 named_selinux.8
-rw-r--r--. 1 root root 1075 Feb 18 15:07 nfs_selinux.8
-rw-r--r--. 1 root root   26 Feb 18 15:07 nis_selinux.8
-rw-r--r--. 1 root root 1676 Feb 18 15:07 rsync_selinux.8
-rw-r--r--. 1 root root 2178 Feb 18 15:07 samba_selinux.8
-rw-r--r--. 1 root root  746 Feb 18 15:07 ypbind_selinux.8

/etc/selinux/refpolicy-standard/src/policy/man/ru:
total 4
drwxr-xr-x. 2 root root 4096 Feb 18 15:07 man8

/etc/selinux/refpolicy-standard/src/policy/man/ru/man8:
total 44
-rw-r--r--. 1 root root 4020 Feb 18 15:07 ftpd_selinux.8
-rw-r--r--. 1 root root 9266 Feb 18 15:07 httpd_selinux.8
-rw-r--r--. 1 root root 1513 Feb 18 15:07 kerberos_selinux.8
-rw-r--r--. 1 root root 1562 Feb 18 15:07 named_selinux.8
-rw-r--r--. 1 root root 1936 Feb 18 15:07 nfs_selinux.8
-rw-r--r--. 1 root root 3122 Feb 18 15:07 rsync_selinux.8
-rw-r--r--. 1 root root 4181 Feb 18 15:07 samba_selinux.8
-rw-r--r--. 1 root root 1300 Feb 18 15:07 ypbind_selinux.8

/etc/selinux/refpolicy-standard/src/policy/policy:
total 108
-rw-r--r--. 1 root root  9044 Feb 18 16:22 booleans.conf
-rw-r--r--. 1 root root  6072 Feb 18 15:07 constraints
drwxr-xr-x. 2 root root  4096 Feb 18 15:07 flask
-rw-r--r--. 1 root root   692 Feb 18 15:07 global_booleans
-rw-r--r--. 1 root root  2717 Feb 18 15:07 global_tunables
-rw-r--r--. 1 root root  3789 Feb 18 15:07 mcs
-rw-r--r--. 1 root root 22208 Feb 18 15:07 mls
drwxr-xr-x. 8 root root  4096 Feb 18 15:07 modules
-rw-r--r--. 1 root root 26074 Feb 18 16:22 modules.conf
-rw-r--r--. 1 root root   661 Feb 18 15:07 policy_capabilities
-rw-r--r--. 1 root root   331 Feb 18 15:07 rolemap
drwxr-xr-x. 2 root root  4096 Feb 18 15:07 support
-rw-r--r--. 1 root root  1809 Feb 18 15:07 users

/etc/selinux/refpolicy-standard/src/policy/policy/flask:
total 40
-rw-r--r--. 1 root root  1615 Feb 18 15:07 Makefile
-rw-r--r--. 1 root root  8270 Feb 18 15:07 access_vectors
-rw-r--r--. 1 root root 14532 Feb 18 15:07 flask.py
-rw-r--r--. 1 root root   417 Feb 18 15:07 initial_sids
-rw-r--r--. 1 root root  2136 Feb 18 15:07 security_classes

/etc/selinux/refpolicy-standard/src/policy/policy/modules:
total 40
drwxr-xr-x. 2 root root  4096 Feb 18 15:07 admin
drwxr-xr-x. 2 root root  4096 Feb 18 15:07 apps
drwxr-xr-x. 2 root root  4096 Feb 18 15:07 kernel
drwxr-xr-x. 2 root root  4096 Feb 18 15:07 roles
drwxr-xr-x. 2 root root 20480 Feb 18 15:07 services
drwxr-xr-x. 2 root root  4096 Feb 18 15:07 system

/etc/selinux/refpolicy-standard/src/policy/policy/modules/admin:
total 536
-rw-r--r--. 1 root root   280 Feb 18 15:07 acct.fc
-rw-r--r--. 1 root root  1659 Feb 18 15:07 acct.if
-rw-r--r--. 1 root root  1799 Feb 18 15:07 acct.te
-rw-r--r--. 1 root root   615 Feb 18 15:07 alsa.fc
-rw-r--r--. 1 root root  1812 Feb 18 15:07 alsa.if
-rw-r--r--. 1 root root  1543 Feb 18 15:07 alsa.te
-rw-r--r--. 1 root root  1687 Feb 18 15:07 amanda.fc
-rw-r--r--. 1 root root  3190 Feb 18 15:07 amanda.if
-rw-r--r--. 1 root root  7567 Feb 18 15:07 amanda.te
-rw-r--r--. 1 root root    63 Feb 18 15:07 amtu.fc
-rw-r--r--. 1 root root   849 Feb 18 15:07 amtu.if
-rw-r--r--. 1 root root   558 Feb 18 15:07 amtu.te
-rw-r--r--. 1 root root   164 Feb 18 15:07 anaconda.fc
-rw-r--r--. 1 root root    57 Feb 18 15:07 anaconda.if
-rw-r--r--. 1 root root  1076 Feb 18 15:07 anaconda.te
-rw-r--r--. 1 root root   685 Feb 18 15:07 apt.fc
-rw-r--r--. 1 root root  3843 Feb 18 15:07 apt.if
-rw-r--r--. 1 root root  3645 Feb 18 15:07 apt.te
-rw-r--r--. 1 root root   535 Feb 18 15:07 backup.fc
-rw-r--r--. 1 root root   886 Feb 18 15:07 backup.if
-rw-r--r--. 1 root root  2056 Feb 18 15:07 backup.te
-rw-r--r--. 1 root root   353 Feb 18 15:07 bootloader.fc
-rw-r--r--. 1 root root  2680 Feb 18 15:07 bootloader.if
-rw-r--r--. 1 root root  6026 Feb 18 15:07 bootloader.te
-rw-r--r--. 1 root root    67 Feb 18 15:07 brctl.fc
-rw-r--r--. 1 root root   414 Feb 18 15:07 brctl.if
-rw-r--r--. 1 root root   919 Feb 18 15:07 brctl.te
-rw-r--r--. 1 root root    73 Feb 18 15:07 certwatch.fc
-rw-r--r--. 1 root root  1787 Feb 18 15:07 certwatch.if
-rw-r--r--. 1 root root   946 Feb 18 15:07 certwatch.te
-rw-r--r--. 1 root root    75 Feb 18 15:07 consoletype.fc
-rw-r--r--. 1 root root  1430 Feb 18 15:07 consoletype.if
-rw-r--r--. 1 root root  2882 Feb 18 15:07 consoletype.te
-rw-r--r--. 1 root root    83 Feb 18 15:07 ddcprobe.fc
-rw-r--r--. 1 root root   978 Feb 18 15:07 ddcprobe.if
-rw-r--r--. 1 root root  1156 Feb 18 15:07 ddcprobe.te
-rw-r--r--. 1 root root    64 Feb 18 15:07 dmesg.fc
-rw-r--r--. 1 root root   775 Feb 18 15:07 dmesg.if
-rw-r--r--. 1 root root  1152 Feb 18 15:07 dmesg.te
-rw-r--r--. 1 root root   223 Feb 18 15:07 dmidecode.fc
-rw-r--r--. 1 root root  1094 Feb 18 15:07 dmidecode.if
-rw-r--r--. 1 root root   565 Feb 18 15:07 dmidecode.te
-rw-r--r--. 1 root root   629 Feb 18 15:07 dpkg.fc
-rw-r--r--. 1 root root  4772 Feb 18 15:07 dpkg.if
-rw-r--r--. 1 root root 10091 Feb 18 15:07 dpkg.te
-rw-r--r--. 1 root root   165 Feb 18 15:07 firstboot.fc
-rw-r--r--. 1 root root  3196 Feb 18 15:07 firstboot.if
-rw-r--r--. 1 root root  3192 Feb 18 15:07 firstboot.te
-rw-r--r--. 1 root root   296 Feb 18 15:07 kismet.fc
-rw-r--r--. 1 root root  4932 Feb 18 15:07 kismet.if
-rw-r--r--. 1 root root  1435 Feb 18 15:07 kismet.te
-rw-r--r--. 1 root root   194 Feb 18 15:07 kudzu.fc
-rw-r--r--. 1 root root  1288 Feb 18 15:07 kudzu.if
-rw-r--r--. 1 root root  3913 Feb 18 15:07 kudzu.te
-rw-r--r--. 1 root root   361 Feb 18 15:07 logrotate.fc
-rw-r--r--. 1 root root  2344 Feb 18 15:07 logrotate.if
-rw-r--r--. 1 root root  4992 Feb 18 15:07 logrotate.te
-rw-r--r--. 1 root root   397 Feb 18 15:07 logwatch.fc
-rw-r--r--. 1 root root   737 Feb 18 15:07 logwatch.if
-rw-r--r--. 1 root root  2949 Feb 18 15:07 logwatch.te
-rw-r--r--. 1 root root    95 Feb 18 15:07 metadata.xml
-rw-r--r--. 1 root root   499 Feb 18 15:07 mrtg.fc
-rw-r--r--. 1 root root   420 Feb 18 15:07 mrtg.if
-rw-r--r--. 1 root root  3589 Feb 18 15:07 mrtg.te
-rw-r--r--. 1 root root   712 Feb 18 15:07 netutils.fc
-rw-r--r--. 1 root root  5644 Feb 18 15:07 netutils.if
-rw-r--r--. 1 root root  5671 Feb 18 15:07 netutils.te
-rw-r--r--. 1 root root  1544 Feb 18 15:07 portage.fc
-rw-r--r--. 1 root root  6484 Feb 18 15:07 portage.if
-rw-r--r--. 1 root root  7444 Feb 18 15:07 portage.te
-rw-r--r--. 1 root root   302 Feb 18 15:07 prelink.fc
-rw-r--r--. 1 root root  2317 Feb 18 15:07 prelink.if
-rw-r--r--. 1 root root  2446 Feb 18 15:07 prelink.te
-rw-r--r--. 1 root root   782 Feb 18 15:07 quota.fc
-rw-r--r--. 1 root root  1672 Feb 18 15:07 quota.if
-rw-r--r--. 1 root root  1943 Feb 18 15:07 quota.te
-rw-r--r--. 1 root root   152 Feb 18 15:07 readahead.fc
-rw-r--r--. 1 root root    85 Feb 18 15:07 readahead.if
-rw-r--r--. 1 root root  2390 Feb 18 15:07 readahead.te
-rw-r--r--. 1 root root  1816 Feb 18 15:07 rpm.fc
-rw-r--r--. 1 root root  5768 Feb 18 15:07 rpm.if
-rw-r--r--. 1 root root 10101 Feb 18 15:07 rpm.te
-rw-r--r--. 1 root root   191 Feb 18 15:07 su.fc
-rw-r--r--. 1 root root  7482 Feb 18 15:07 su.if
-rw-r--r--. 1 root root   166 Feb 18 15:07 su.te
-rw-r--r--. 1 root root    71 Feb 18 15:07 sudo.fc
-rw-r--r--. 1 root root  3386 Feb 18 15:07 sudo.if
-rw-r--r--. 1 root root   147 Feb 18 15:07 sudo.te
-rw-r--r--. 1 root root   350 Feb 18 15:07 sxid.fc
-rw-r--r--. 1 root root   421 Feb 18 15:07 sxid.if
-rw-r--r--. 1 root root  2191 Feb 18 15:07 sxid.te
-rw-r--r--. 1 root root   149 Feb 18 15:07 tmpreaper.fc
-rw-r--r--. 1 root root   453 Feb 18 15:07 tmpreaper.if
-rw-r--r--. 1 root root   939 Feb 18 15:07 tmpreaper.te
-rw-r--r--. 1 root root   521 Feb 18 15:07 tripwire.fc
-rw-r--r--. 1 root root  3991 Feb 18 15:07 tripwire.if
-rw-r--r--. 1 root root  3991 Feb 18 15:07 tripwire.te
-rw-r--r--. 1 root root    75 Feb 18 15:07 tzdata.fc
-rw-r--r--. 1 root root   826 Feb 18 15:07 tzdata.if
-rw-r--r--. 1 root root   691 Feb 18 15:07 tzdata.te
-rw-r--r--. 1 root root   147 Feb 18 15:07 updfstab.fc
-rw-r--r--. 1 root root   478 Feb 18 15:07 updfstab.if
-rw-r--r--. 1 root root  2725 Feb 18 15:07 updfstab.te
-rw-r--r--. 1 root root   173 Feb 18 15:07 usbmodules.fc
-rw-r--r--. 1 root root   993 Feb 18 15:07 usbmodules.if
-rw-r--r--. 1 root root   918 Feb 18 15:07 usbmodules.te
-rw-r--r--. 1 root root  1887 Feb 18 15:07 usermanage.fc
-rw-r--r--. 1 root root  5722 Feb 18 15:07 usermanage.if
-rw-r--r--. 1 root root 15057 Feb 18 15:07 usermanage.te
-rw-r--r--. 1 root root    70 Feb 18 15:07 vbetool.fc
-rw-r--r--. 1 root root   452 Feb 18 15:07 vbetool.if
-rw-r--r--. 1 root root   647 Feb 18 15:07 vbetool.te
-rw-r--r--. 1 root root   291 Feb 18 15:07 vpn.fc
-rw-r--r--. 1 root root  1552 Feb 18 15:07 vpn.if
-rw-r--r--. 1 root root  3099 Feb 18 15:07 vpn.te

/etc/selinux/refpolicy-standard/src/policy/policy/modules/apps:
total 484
-rw-r--r--. 1 root root   285 Feb 18 15:07 ada.fc
-rw-r--r--. 1 root root   836 Feb 18 15:07 ada.if
-rw-r--r--. 1 root root   384 Feb 18 15:07 ada.te
-rw-r--r--. 1 root root   155 Feb 18 15:07 authbind.fc
-rw-r--r--. 1 root root   487 Feb 18 15:07 authbind.if
-rw-r--r--. 1 root root   660 Feb 18 15:07 authbind.te
-rw-r--r--. 1 root root   359 Feb 18 15:07 awstats.fc
-rw-r--r--. 1 root root   976 Feb 18 15:07 awstats.if
-rw-r--r--. 1 root root  1659 Feb 18 15:07 awstats.te
-rw-r--r--. 1 root root   254 Feb 18 15:07 calamaris.fc
-rw-r--r--. 1 root root   498 Feb 18 15:07 calamaris.if
-rw-r--r--. 1 root root  2149 Feb 18 15:07 calamaris.te
-rw-r--r--. 1 root root    83 Feb 18 15:07 cdrecord.fc
-rw-r--r--. 1 root root   747 Feb 18 15:07 cdrecord.if
-rw-r--r--. 1 root root  3562 Feb 18 15:07 cdrecord.te
-rw-r--r--. 1 root root   231 Feb 18 15:07 ethereal.fc
-rw-r--r--. 1 root root  2159 Feb 18 15:07 ethereal.if
-rw-r--r--. 1 root root  5349 Feb 18 15:07 ethereal.te
-rw-r--r--. 1 root root   800 Feb 18 15:07 evolution.fc
-rw-r--r--. 1 root root  3939 Feb 18 15:07 evolution.if
-rw-r--r--. 1 root root 23678 Feb 18 15:07 evolution.te
-rw-r--r--. 1 root root  3886 Feb 18 15:07 games.fc
-rw-r--r--. 1 root root   678 Feb 18 15:07 games.if
-rw-r--r--. 1 root root  5282 Feb 18 15:07 games.te
-rw-r--r--. 1 root root   373 Feb 18 15:07 gift.fc
-rw-r--r--. 1 root root  1111 Feb 18 15:07 gift.if
-rw-r--r--. 1 root root  4356 Feb 18 15:07 gift.te
-rw-r--r--. 1 root root   356 Feb 18 15:07 gnome.fc
-rw-r--r--. 1 root root  1972 Feb 18 15:07 gnome.if
-rw-r--r--. 1 root root  2101 Feb 18 15:07 gnome.te
-rw-r--r--. 1 root root   493 Feb 18 15:07 gpg.fc
-rw-r--r--. 1 root root  2051 Feb 18 15:07 gpg.if
-rw-r--r--. 1 root root  7621 Feb 18 15:07 gpg.te
-rw-r--r--. 1 root root   285 Feb 18 15:07 irc.fc
-rw-r--r--. 1 root root   593 Feb 18 15:07 irc.if
-rw-r--r--. 1 root root  2882 Feb 18 15:07 irc.te
-rw-r--r--. 1 root root  1280 Feb 18 15:07 java.fc
-rw-r--r--. 1 root root  1457 Feb 18 15:07 java.if
-rw-r--r--. 1 root root  4293 Feb 18 15:07 java.te
-rw-r--r--. 1 root root   136 Feb 18 15:07 loadkeys.fc
-rw-r--r--. 1 root root  1279 Feb 18 15:07 loadkeys.if
-rw-r--r--. 1 root root   983 Feb 18 15:07 loadkeys.te
-rw-r--r--. 1 root root    71 Feb 18 15:07 lockdev.fc
-rw-r--r--. 1 root root   709 Feb 18 15:07 lockdev.if
-rw-r--r--. 1 root root   991 Feb 18 15:07 lockdev.te
-rw-r--r--. 1 root root    51 Feb 18 15:07 metadata.xml
-rw-r--r--. 1 root root    63 Feb 18 15:07 mono.fc
-rw-r--r--. 1 root root   764 Feb 18 15:07 mono.if
-rw-r--r--. 1 root root   762 Feb 18 15:07 mono.te
-rw-r--r--. 1 root root  1583 Feb 18 15:07 mozilla.fc
-rw-r--r--. 1 root root  3298 Feb 18 15:07 mozilla.if
-rw-r--r--. 1 root root  7917 Feb 18 15:07 mozilla.te
-rw-r--r--. 1 root root   380 Feb 18 15:07 mplayer.fc
-rw-r--r--. 1 root root  1973 Feb 18 15:07 mplayer.if
-rw-r--r--. 1 root root  8807 Feb 18 15:07 mplayer.te
-rw-r--r--. 1 root root    74 Feb 18 15:07 podsleuth.fc
-rw-r--r--. 1 root root   455 Feb 18 15:07 podsleuth.if
-rw-r--r--. 1 root root   712 Feb 18 15:07 podsleuth.te
-rw-r--r--. 1 root root   130 Feb 18 15:07 qemu.fc
-rw-r--r--. 1 root root  4108 Feb 18 15:07 qemu.if
-rw-r--r--. 1 root root  1011 Feb 18 15:07 qemu.te
-rw-r--r--. 1 root root    63 Feb 18 15:07 rssh.fc
-rw-r--r--. 1 root root  1250 Feb 18 15:07 rssh.if
-rw-r--r--. 1 root root  2399 Feb 18 15:07 rssh.te
-rw-r--r--. 1 root root   292 Feb 18 15:07 screen.fc
-rw-r--r--. 1 root root  4912 Feb 18 15:07 screen.if
-rw-r--r--. 1 root root   974 Feb 18 15:07 screen.te
-rw-r--r--. 1 root root   149 Feb 18 15:07 slocate.fc
-rw-r--r--. 1 root root   873 Feb 18 15:07 slocate.if
-rw-r--r--. 1 root root  1495 Feb 18 15:07 slocate.te
-rw-r--r--. 1 root root   177 Feb 18 15:07 thunderbird.fc
-rw-r--r--. 1 root root  1766 Feb 18 15:07 thunderbird.if
-rw-r--r--. 1 root root  7475 Feb 18 15:07 thunderbird.te
-rw-r--r--. 1 root root    80 Feb 18 15:07 tvtime.fc
-rw-r--r--. 1 root root  1041 Feb 18 15:07 tvtime.if
-rw-r--r--. 1 root root  3087 Feb 18 15:07 tvtime.te
-rw-r--r--. 1 root root   264 Feb 18 15:07 uml.fc
-rw-r--r--. 1 root root  3010 Feb 18 15:07 uml.if
-rw-r--r--. 1 root root  5533 Feb 18 15:07 uml.te
-rw-r--r--. 1 root root   187 Feb 18 15:07 userhelper.fc
-rw-r--r--. 1 root root  7020 Feb 18 15:07 userhelper.if
-rw-r--r--. 1 root root   250 Feb 18 15:07 userhelper.te
-rw-r--r--. 1 root root    77 Feb 18 15:07 usernetctl.fc
-rw-r--r--. 1 root root  1252 Feb 18 15:07 usernetctl.if
-rw-r--r--. 1 root root  1833 Feb 18 15:07 usernetctl.te
-rw-r--r--. 1 root root  4074 Feb 18 15:07 vmware.fc
-rw-r--r--. 1 root root  1704 Feb 18 15:07 vmware.if
-rw-r--r--. 1 root root  8466 Feb 18 15:07 vmware.te
-rw-r--r--. 1 root root   176 Feb 18 15:07 webalizer.fc
-rw-r--r--. 1 root root   958 Feb 18 15:07 webalizer.if
-rw-r--r--. 1 root root  2939 Feb 18 15:07 webalizer.te
-rw-r--r--. 1 root root   214 Feb 18 15:07 wine.fc
-rw-r--r--. 1 root root   913 Feb 18 15:07 wine.if
-rw-r--r--. 1 root root   458 Feb 18 15:07 wine.te
-rw-r--r--. 1 root root   155 Feb 18 15:07 wireshark.fc
-rw-r--r--. 1 root root  1388 Feb 18 15:07 wireshark.if
-rw-r--r--. 1 root root  4147 Feb 18 15:07 wireshark.te
-rw-r--r--. 1 root root   260 Feb 18 15:07 yam.fc
-rw-r--r--. 1 root root  1250 Feb 18 15:07 yam.if
-rw-r--r--. 1 root root  3289 Feb 18 15:07 yam.te

/etc/selinux/refpolicy-standard/src/policy/policy/modules/kernel:
total 1864
-rw-r--r--. 1 root root   15457 Feb 18 15:07 corecommands.fc
-rw-r--r--. 1 root root   22048 Feb 18 15:07 corecommands.if
-rw-r--r--. 1 root root     506 Feb 18 15:07 corecommands.te
-rw-r--r--. 1 root root     317 Feb 18 15:07 corenetwork.fc
-rw-r--r--. 1 root root 1171858 Feb 18 16:14 corenetwork.if
-rw-r--r--. 1 root root   57247 Feb 18 15:07 corenetwork.if.in
-rw-r--r--. 1 root root   14791 Feb 18 15:07 corenetwork.if.m4
-rw-r--r--. 1 root root   56418 Feb 18 16:14 corenetwork.te
-rw-r--r--. 1 root root   10665 Feb 18 15:07 corenetwork.te.in
-rw-r--r--. 1 root root    2065 Feb 18 15:07 corenetwork.te.m4
-rw-r--r--. 1 root root    7599 Feb 18 15:07 devices.fc
-rw-r--r--. 1 root root   66332 Feb 18 15:07 devices.if
-rw-r--r--. 1 root root    4025 Feb 18 15:07 devices.te
-rw-r--r--. 1 root root      57 Feb 18 15:07 domain.fc
-rw-r--r--. 1 root root   26494 Feb 18 15:07 domain.if
-rw-r--r--. 1 root root    4527 Feb 18 15:07 domain.te
-rw-r--r--. 1 root root    7708 Feb 18 15:07 files.fc
-rw-r--r--. 1 root root   96187 Feb 18 15:07 files.if
-rw-r--r--. 1 root root    4792 Feb 18 15:07 files.te
-rw-r--r--. 1 root root      57 Feb 18 15:07 filesystem.fc
-rw-r--r--. 1 root root   67951 Feb 18 15:07 filesystem.if
-rw-r--r--. 1 root root    8219 Feb 18 15:07 filesystem.te
-rw-r--r--. 1 root root      57 Feb 18 15:07 kernel.fc
-rw-r--r--. 1 root root   52521 Feb 18 15:07 kernel.if
-rw-r--r--. 1 root root   11359 Feb 18 15:07 kernel.te
-rw-r--r--. 1 root root      23 Feb 18 15:07 mcs.fc
-rw-r--r--. 1 root root    1294 Feb 18 15:07 mcs.if
-rw-r--r--. 1 root root     157 Feb 18 15:07 mcs.te
-rw-r--r--. 1 root root      56 Feb 18 15:07 metadata.xml
-rw-r--r--. 1 root root      24 Feb 18 15:07 mls.fc
-rw-r--r--. 1 root root   18660 Feb 18 15:07 mls.if
-rw-r--r--. 1 root root    1349 Feb 18 15:07 mls.te
-rw-r--r--. 1 root root      57 Feb 18 15:07 selinux.fc
-rw-r--r--. 1 root root   11263 Feb 18 15:07 selinux.if
-rw-r--r--. 1 root root    1503 Feb 18 15:07 selinux.te
-rw-r--r--. 1 root root    4783 Feb 18 15:07 storage.fc
-rw-r--r--. 1 root root   17186 Feb 18 15:07 storage.if
-rw-r--r--. 1 root root    1552 Feb 18 15:07 storage.te
-rw-r--r--. 1 root root    1935 Feb 18 15:07 terminal.fc
-rw-r--r--. 1 root root   22106 Feb 18 15:07 terminal.if
-rw-r--r--. 1 root root    1092 Feb 18 15:07 terminal.te
-rw-r--r--. 1 root root      24 Feb 18 15:07 ubac.fc
-rw-r--r--. 1 root root    3305 Feb 18 15:07 ubac.if
-rw-r--r--. 1 root root     299 Feb 18 15:07 ubac.te

/etc/selinux/refpolicy-standard/src/policy/policy/modules/roles:
total 68
-rw-r--r--. 1 root root   56 Feb 18 15:07 auditadm.fc
-rw-r--r--. 1 root root  917 Feb 18 15:07 auditadm.if
-rw-r--r--. 1 root root 3089 Feb 18 15:07 auditadm.te
-rw-r--r--. 1 root root   50 Feb 18 15:07 metadata.xml
-rw-r--r--. 1 root root   56 Feb 18 15:07 secadm.fc
-rw-r--r--. 1 root root  927 Feb 18 15:07 secadm.if
-rw-r--r--. 1 root root 3099 Feb 18 15:07 secadm.te
-rw-r--r--. 1 root root   56 Feb 18 15:07 staff.fc
-rw-r--r--. 1 root root  871 Feb 18 15:07 staff.if
-rw-r--r--. 1 root root 2392 Feb 18 15:07 staff.te
-rw-r--r--. 1 root root   56 Feb 18 15:07 sysadm.fc
-rw-r--r--. 1 root root 4033 Feb 18 15:07 sysadm.if
-rw-r--r--. 1 root root 7365 Feb 18 15:07 sysadm.te
-rw-r--r--. 1 root root   56 Feb 18 15:07 unprivuser.fc
-rw-r--r--. 1 root root  890 Feb 18 15:07 unprivuser.if
-rw-r--r--. 1 root root 2148 Feb 18 15:07 unprivuser.te

/etc/selinux/refpolicy-standard/src/policy/policy/modules/services:
total 2284
-rw-r--r--. 1 root root  1199 Feb 18 15:07 afs.fc
-rw-r--r--. 1 root root    47 Feb 18 15:07 afs.if
-rw-r--r--. 1 root root  9986 Feb 18 15:07 afs.te
-rw-r--r--. 1 root root   312 Feb 18 15:07 aide.fc
-rw-r--r--. 1 root root  1325 Feb 18 15:07 aide.if
-rw-r--r--. 1 root root   707 Feb 18 15:07 aide.te
-rw-r--r--. 1 root root   940 Feb 18 15:07 amavis.fc
-rw-r--r--. 1 root root  4874 Feb 18 15:07 amavis.if
-rw-r--r--. 1 root root  5080 Feb 18 15:07 amavis.te
-rw-r--r--. 1 root root  4453 Feb 18 15:07 apache.fc
-rw-r--r--. 1 root root 27358 Feb 18 15:07 apache.if
-rw-r--r--. 1 root root 22330 Feb 18 15:07 apache.te
-rw-r--r--. 1 root root   892 Feb 18 15:07 apcupsd.fc
-rw-r--r--. 1 root root  3066 Feb 18 15:07 apcupsd.if
-rw-r--r--. 1 root root  3441 Feb 18 15:07 apcupsd.te
-rw-r--r--. 1 root root   754 Feb 18 15:07 apm.fc
-rw-r--r--. 1 root root  2091 Feb 18 15:07 apm.if
-rw-r--r--. 1 root root  5226 Feb 18 15:07 apm.te
-rw-r--r--. 1 root root   330 Feb 18 15:07 arpwatch.fc
-rw-r--r--. 1 root root  2743 Feb 18 15:07 arpwatch.if
-rw-r--r--. 1 root root  2638 Feb 18 15:07 arpwatch.te
-rw-r--r--. 1 root root   539 Feb 18 15:07 asterisk.fc
-rw-r--r--. 1 root root  1262 Feb 18 15:07 asterisk.if
-rw-r--r--. 1 root root  4554 Feb 18 15:07 asterisk.te
-rw-r--r--. 1 root root   175 Feb 18 15:07 audioentropy.fc
-rw-r--r--. 1 root root    56 Feb 18 15:07 audioentropy.if
-rw-r--r--. 1 root root  1393 Feb 18 15:07 audioentropy.te
-rw-r--r--. 1 root root   349 Feb 18 15:07 automount.fc
-rw-r--r--. 1 root root  3189 Feb 18 15:07 automount.if
-rw-r--r--. 1 root root  5384 Feb 18 15:07 automount.te
-rw-r--r--. 1 root root   471 Feb 18 15:07 avahi.fc
-rw-r--r--. 1 root root  2972 Feb 18 15:07 avahi.if
-rw-r--r--. 1 root root  2790 Feb 18 15:07 avahi.te
-rw-r--r--. 1 root root  3194 Feb 18 15:07 bind.fc
-rw-r--r--. 1 root root  6021 Feb 18 15:07 bind.if
-rw-r--r--. 1 root root  6680 Feb 18 15:07 bind.te
-rw-r--r--. 1 root root   299 Feb 18 15:07 bitlbee.fc
-rw-r--r--. 1 root root  1291 Feb 18 15:07 bitlbee.if
-rw-r--r--. 1 root root  2570 Feb 18 15:07 bitlbee.te
-rw-r--r--. 1 root root  1256 Feb 18 15:07 bluetooth.fc
-rw-r--r--. 1 root root  4875 Feb 18 15:07 bluetooth.if
-rw-r--r--. 1 root root  7812 Feb 18 15:07 bluetooth.te
-rw-r--r--. 1 root root   895 Feb 18 15:07 canna.fc
-rw-r--r--. 1 root root  1381 Feb 18 15:07 canna.if
-rw-r--r--. 1 root root  2402 Feb 18 15:07 canna.te
-rw-r--r--. 1 root root   412 Feb 18 15:07 ccs.fc
-rw-r--r--. 1 root root  1482 Feb 18 15:07 ccs.if
-rw-r--r--. 1 root root  3075 Feb 18 15:07 ccs.te
-rw-r--r--. 1 root root    79 Feb 18 15:07 cipe.fc
-rw-r--r--. 1 root root    46 Feb 18 15:07 cipe.if
-rw-r--r--. 1 root root  1653 Feb 18 15:07 cipe.te
-rw-r--r--. 1 root root  1052 Feb 18 15:07 clamav.fc
-rw-r--r--. 1 root root  1788 Feb 18 15:07 clamav.if
-rw-r--r--. 1 root root  6529 Feb 18 15:07 clamav.te
-rw-r--r--. 1 root root   494 Feb 18 15:07 clockspeed.fc
-rw-r--r--. 1 root root   952 Feb 18 15:07 clockspeed.if
-rw-r--r--. 1 root root  2238 Feb 18 15:07 clockspeed.te
-rw-r--r--. 1 root root    73 Feb 18 15:07 comsat.fc
-rw-r--r--. 1 root root    45 Feb 18 15:07 comsat.if
-rw-r--r--. 1 root root  1844 Feb 18 15:07 comsat.te
-rw-r--r--. 1 root root   168 Feb 18 15:07 consolekit.fc
-rw-r--r--. 1 root root   853 Feb 18 15:07 consolekit.if
-rw-r--r--. 1 root root  1579 Feb 18 15:07 consolekit.te
-rw-r--r--. 1 root root  1537 Feb 18 15:07 courier.fc
-rw-r--r--. 1 root root  4525 Feb 18 15:07 courier.if
-rw-r--r--. 1 root root  3883 Feb 18 15:07 courier.te
-rw-r--r--. 1 root root   447 Feb 18 15:07 cpucontrol.fc
-rw-r--r--. 1 root root   382 Feb 18 15:07 cpucontrol.if
-rw-r--r--. 1 root root  2692 Feb 18 15:07 cpucontrol.te
-rw-r--r--. 1 root root  2292 Feb 18 15:07 cron.fc
-rw-r--r--. 1 root root 10623 Feb 18 15:07 cron.if
-rw-r--r--. 1 root root 17145 Feb 18 15:07 cron.te
-rw-r--r--. 1 root root  2950 Feb 18 15:07 cups.fc
-rw-r--r--. 1 root root  4812 Feb 18 15:07 cups.if
-rw-r--r--. 1 root root 17536 Feb 18 15:07 cups.te
-rw-r--r--. 1 root root   389 Feb 18 15:07 cvs.fc
-rw-r--r--. 1 root root  1592 Feb 18 15:07 cvs.if
-rw-r--r--. 1 root root  2798 Feb 18 15:07 cvs.te
-rw-r--r--. 1 root root    71 Feb 18 15:07 cyphesis.fc
-rw-r--r--. 1 root root   412 Feb 18 15:07 cyphesis.if
-rw-r--r--. 1 root root  2270 Feb 18 15:07 cyphesis.te
-rw-r--r--. 1 root root   247 Feb 18 15:07 cyrus.fc
-rw-r--r--. 1 root root  1805 Feb 18 15:07 cyrus.if
-rw-r--r--. 1 root root  3911 Feb 18 15:07 cyrus.te
-rw-r--r--. 1 root root   208 Feb 18 15:07 dante.fc
-rw-r--r--. 1 root root    62 Feb 18 15:07 dante.if
-rw-r--r--. 1 root root  1898 Feb 18 15:07 dante.te
-rw-r--r--. 1 root root    73 Feb 18 15:07 dbskk.fc
-rw-r--r--. 1 root root    82 Feb 18 15:07 dbskk.if
-rw-r--r--. 1 root root  1772 Feb 18 15:07 dbskk.te
-rw-r--r--. 1 root root   558 Feb 18 15:07 dbus.fc
-rw-r--r--. 1 root root  7636 Feb 18 15:07 dbus.if
-rw-r--r--. 1 root root  4122 Feb 18 15:07 dbus.te
-rw-r--r--. 1 root root   993 Feb 18 15:07 dcc.fc
-rw-r--r--. 1 root root  3430 Feb 18 15:07 dcc.if
-rw-r--r--. 1 root root 10908 Feb 18 15:07 dcc.te
-rw-r--r--. 1 root root   756 Feb 18 15:07 ddclient.fc
-rw-r--r--. 1 root root  1550 Feb 18 15:07 ddclient.if
-rw-r--r--. 1 root root  3063 Feb 18 15:07 ddclient.te
-rw-r--r--. 1 root root   384 Feb 18 15:07 dhcp.fc
-rw-r--r--. 1 root root  1342 Feb 18 15:07 dhcp.if
-rw-r--r--. 1 root root  3248 Feb 18 15:07 dhcp.te
-rw-r--r--. 1 root root   364 Feb 18 15:07 dictd.fc
-rw-r--r--. 1 root root  1269 Feb 18 15:07 dictd.if
-rw-r--r--. 1 root root  2335 Feb 18 15:07 dictd.te
-rw-r--r--. 1 root root    70 Feb 18 15:07 distcc.fc
-rw-r--r--. 1 root root    50 Feb 18 15:07 distcc.if
-rw-r--r--. 1 root root  2410 Feb 18 15:07 distcc.te
-rw-r--r--. 1 root root   480 Feb 18 15:07 djbdns.fc
-rw-r--r--. 1 root root  1714 Feb 18 15:07 djbdns.if
-rw-r--r--. 1 root root  1197 Feb 18 15:07 djbdns.te
-rw-r--r--. 1 root root   395 Feb 18 15:07 dnsmasq.fc
-rw-r--r--. 1 root root  1951 Feb 18 15:07 dnsmasq.if
-rw-r--r--. 1 root root  2651 Feb 18 15:07 dnsmasq.te
-rw-r--r--. 1 root root  1136 Feb 18 15:07 dovecot.fc
-rw-r--r--. 1 root root   838 Feb 18 15:07 dovecot.if
-rw-r--r--. 1 root root  5287 Feb 18 15:07 dovecot.te
-rw-r--r--. 1 root root   400 Feb 18 15:07 exim.fc
-rw-r--r--. 1 root root  2907 Feb 18 15:07 exim.if
-rw-r--r--. 1 root root  2874 Feb 18 15:07 exim.te
-rw-r--r--. 1 root root   387 Feb 18 15:07 fail2ban.fc
-rw-r--r--. 1 root root  2554 Feb 18 15:07 fail2ban.if
-rw-r--r--. 1 root root  2178 Feb 18 15:07 fail2ban.te
-rw-r--r--. 1 root root   357 Feb 18 15:07 fetchmail.fc
-rw-r--r--. 1 root root   658 Feb 18 15:07 fetchmail.if
-rw-r--r--. 1 root root  2693 Feb 18 15:07 fetchmail.te
-rw-r--r--. 1 root root   423 Feb 18 15:07 finger.fc
-rw-r--r--. 1 root root   747 Feb 18 15:07 finger.if
-rw-r--r--. 1 root root  3021 Feb 18 15:07 finger.te
-rw-r--r--. 1 root root  1241 Feb 18 15:07 ftp.fc
-rw-r--r--. 1 root root  3311 Feb 18 15:07 ftp.if
-rw-r--r--. 1 root root  7544 Feb 18 15:07 ftp.te
-rw-r--r--. 1 root root   443 Feb 18 15:07 gatekeeper.fc
-rw-r--r--. 1 root root    57 Feb 18 15:07 gatekeeper.if
-rw-r--r--. 1 root root  2760 Feb 18 15:07 gatekeeper.te
-rw-r--r--. 1 root root   247 Feb 18 15:07 gpm.fc
-rw-r--r--. 1 root root  1554 Feb 18 15:07 gpm.if
-rw-r--r--. 1 root root  1661 Feb 18 15:07 gpm.te
-rw-r--r--. 1 root root  1607 Feb 18 15:07 hal.fc
-rw-r--r--. 1 root root  6059 Feb 18 15:07 hal.if
-rw-r--r--. 1 root root 10330 Feb 18 15:07 hal.te
-rw-r--r--. 1 root root   209 Feb 18 15:07 howl.fc
-rw-r--r--. 1 root root   352 Feb 18 15:07 howl.if
-rw-r--r--. 1 root root  1839 Feb 18 15:07 howl.te
-rw-r--r--. 1 root root   623 Feb 18 15:07 i18n_input.fc
-rw-r--r--. 1 root root   327 Feb 18 15:07 i18n_input.if
-rw-r--r--. 1 root root  2877 Feb 18 15:07 i18n_input.te
-rw-r--r--. 1 root root   230 Feb 18 15:07 imaze.fc
-rw-r--r--. 1 root root    40 Feb 18 15:07 imaze.if
-rw-r--r--. 1 root root  2845 Feb 18 15:07 imaze.te
-rw-r--r--. 1 root root   594 Feb 18 15:07 inetd.fc
-rw-r--r--. 1 root root  4360 Feb 18 15:07 inetd.if
-rw-r--r--. 1 root root  6658 Feb 18 15:07 inetd.te
-rw-r--r--. 1 root root  3958 Feb 18 15:07 inn.fc
-rw-r--r--. 1 root root  4430 Feb 18 15:07 inn.if
-rw-r--r--. 1 root root  3328 Feb 18 15:07 inn.te
-rw-r--r--. 1 root root   374 Feb 18 15:07 ircd.fc
-rw-r--r--. 1 root root    33 Feb 18 15:07 ircd.if
-rw-r--r--. 1 root root  2138 Feb 18 15:07 ircd.te
-rw-r--r--. 1 root root    77 Feb 18 15:07 irqbalance.fc
-rw-r--r--. 1 root root    43 Feb 18 15:07 irqbalance.if
-rw-r--r--. 1 root root  1345 Feb 18 15:07 irqbalance.te
-rw-r--r--. 1 root root   303 Feb 18 15:07 jabber.fc
-rw-r--r--. 1 root root  1299 Feb 18 15:07 jabber.if
-rw-r--r--. 1 root root  2464 Feb 18 15:07 jabber.te
-rw-r--r--. 1 root root  1710 Feb 18 15:07 kerberos.fc
-rw-r--r--. 1 root root  7605 Feb 18 15:07 kerberos.if
-rw-r--r--. 1 root root  8340 Feb 18 15:07 kerberos.te
-rw-r--r--. 1 root root   169 Feb 18 15:07 kerneloops.fc
-rw-r--r--. 1 root root  2027 Feb 18 15:07 kerneloops.if
-rw-r--r--. 1 root root  1271 Feb 18 15:07 kerneloops.te
-rw-r--r--. 1 root root   281 Feb 18 15:07 ktalk.fc
-rw-r--r--. 1 root root    38 Feb 18 15:07 ktalk.if
-rw-r--r--. 1 root root  1985 Feb 18 15:07 ktalk.te
-rw-r--r--. 1 root root   750 Feb 18 15:07 ldap.fc
-rw-r--r--. 1 root root  2442 Feb 18 15:07 ldap.if
-rw-r--r--. 1 root root  3479 Feb 18 15:07 ldap.te
-rw-r--r--. 1 root root  1595 Feb 18 15:07 lpd.fc
-rw-r--r--. 1 root root  4043 Feb 18 15:07 lpd.if
-rw-r--r--. 1 root root  9186 Feb 18 15:07 lpd.te
-rw-r--r--. 1 root root  1488 Feb 18 15:07 mailman.fc
-rw-r--r--. 1 root root  7505 Feb 18 15:07 mailman.if
-rw-r--r--. 1 root root  2782 Feb 18 15:07 mailman.te
-rw-r--r--. 1 root root   246 Feb 18 15:07 memcached.fc
-rw-r--r--. 1 root root  1569 Feb 18 15:07 memcached.if
-rw-r--r--. 1 root root  1433 Feb 18 15:07 memcached.te
-rw-r--r--. 1 root root   103 Feb 18 15:07 metadata.xml
-rw-r--r--. 1 root root   436 Feb 18 15:07 milter.fc
-rw-r--r--. 1 root root  2103 Feb 18 15:07 milter.if
-rw-r--r--. 1 root root  1512 Feb 18 15:07 milter.te
-rw-r--r--. 1 root root   216 Feb 18 15:07 monop.fc
-rw-r--r--. 1 root root    38 Feb 18 15:07 monop.if
-rw-r--r--. 1 root root  2042 Feb 18 15:07 monop.te
-rw-r--r--. 1 root root  1289 Feb 18 15:07 mta.fc
-rw-r--r--. 1 root root 17792 Feb 18 15:07 mta.if
-rw-r--r--. 1 root root  5853 Feb 18 15:07 mta.te
-rw-r--r--. 1 root root   646 Feb 18 15:07 munin.fc
-rw-r--r--. 1 root root  1661 Feb 18 15:07 munin.if
-rw-r--r--. 1 root root  3101 Feb 18 15:07 munin.te
-rw-r--r--. 1 root root   712 Feb 18 15:07 mysql.fc
-rw-r--r--. 1 root root  4627 Feb 18 15:07 mysql.if
-rw-r--r--. 1 root root  3496 Feb 18 15:07 mysql.te
-rw-r--r--. 1 root root   770 Feb 18 15:07 nagios.fc
-rw-r--r--. 1 root root  1587 Feb 18 15:07 nagios.if
-rw-r--r--. 1 root root  5101 Feb 18 15:07 nagios.te
-rw-r--r--. 1 root root   377 Feb 18 15:07 nessus.fc
-rw-r--r--. 1 root root   349 Feb 18 15:07 nessus.if
-rw-r--r--. 1 root root  2825 Feb 18 15:07 nessus.te
-rw-r--r--. 1 root root   770 Feb 18 15:07 networkmanager.fc
-rw-r--r--. 1 root root  2777 Feb 18 15:07 networkmanager.if
-rw-r--r--. 1 root root  6435 Feb 18 15:07 networkmanager.te
-rw-r--r--. 1 root root   485 Feb 18 15:07 nis.fc
-rw-r--r--. 1 root root  5330 Feb 18 15:07 nis.if
-rw-r--r--. 1 root root  9272 Feb 18 15:07 nis.te
-rw-r--r--. 1 root root   424 Feb 18 15:07 nscd.fc
-rw-r--r--. 1 root root  4218 Feb 18 15:07 nscd.if
-rw-r--r--. 1 root root  3203 Feb 18 15:07 nscd.te
-rw-r--r--. 1 root root   740 Feb 18 15:07 nsd.fc
-rw-r--r--. 1 root root   634 Feb 18 15:07 nsd.if
-rw-r--r--. 1 root root  4450 Feb 18 15:07 nsd.te
-rw-r--r--. 1 root root   351 Feb 18 15:07 ntop.fc
-rw-r--r--. 1 root root    34 Feb 18 15:07 ntop.if
-rw-r--r--. 1 root root  2577 Feb 18 15:07 ntop.te
-rw-r--r--. 1 root root  1080 Feb 18 15:07 ntp.fc
-rw-r--r--. 1 root root  2040 Feb 18 15:07 ntp.if
-rw-r--r--. 1 root root  3478 Feb 18 15:07 ntp.te
-rw-r--r--. 1 root root   316 Feb 18 15:07 nx.fc
-rw-r--r--. 1 root root   386 Feb 18 15:07 nx.if
-rw-r--r--. 1 root root  2683 Feb 18 15:07 nx.te
-rw-r--r--. 1 root root   588 Feb 18 15:07 oav.fc
-rw-r--r--. 1 root root   973 Feb 18 15:07 oav.if
-rw-r--r--. 1 root root  4172 Feb 18 15:07 oav.te
-rw-r--r--. 1 root root   234 Feb 18 15:07 oddjob.fc
-rw-r--r--. 1 root root  1796 Feb 18 15:07 oddjob.if
-rw-r--r--. 1 root root  2090 Feb 18 15:07 oddjob.te
-rw-r--r--. 1 root root   393 Feb 18 15:07 oident.fc
-rw-r--r--. 1 root root  1501 Feb 18 15:07 oident.if
-rw-r--r--. 1 root root  2029 Feb 18 15:07 oident.te
-rw-r--r--. 1 root root   557 Feb 18 15:07 openca.fc
-rw-r--r--. 1 root root  1401 Feb 18 15:07 openca.if
-rw-r--r--. 1 root root  2281 Feb 18 15:07 openca.te
-rw-r--r--. 1 root root   246 Feb 18 15:07 openct.fc
-rw-r--r--. 1 root root  1819 Feb 18 15:07 openct.if
-rw-r--r--. 1 root root  1281 Feb 18 15:07 openct.te
-rw-r--r--. 1 root root   407 Feb 18 15:07 openvpn.fc
-rw-r--r--. 1 root root  2662 Feb 18 15:07 openvpn.if
-rw-r--r--. 1 root root  3300 Feb 18 15:07 openvpn.te
-rw-r--r--. 1 root root   288 Feb 18 15:07 pcscd.fc
-rw-r--r--. 1 root root  1139 Feb 18 15:07 pcscd.if
-rw-r--r--. 1 root root  1612 Feb 18 15:07 pcscd.te
-rw-r--r--. 1 root root   579 Feb 18 15:07 pegasus.fc
-rw-r--r--. 1 root root    62 Feb 18 15:07 pegasus.if
-rw-r--r--. 1 root root  4006 Feb 18 15:07 pegasus.te
-rw-r--r--. 1 root root   147 Feb 18 15:07 perdition.fc
-rw-r--r--. 1 root root   378 Feb 18 15:07 perdition.if
-rw-r--r--. 1 root root  1957 Feb 18 15:07 perdition.te
-rw-r--r--. 1 root root   497 Feb 18 15:07 portmap.fc
-rw-r--r--. 1 root root  1970 Feb 18 15:07 portmap.if
-rw-r--r--. 1 root root  4526 Feb 18 15:07 portmap.te
-rw-r--r--. 1 root root   224 Feb 18 15:07 portslave.fc
-rw-r--r--. 1 root root   419 Feb 18 15:07 portslave.if
-rw-r--r--. 1 root root  3582 Feb 18 15:07 portslave.te
-rw-r--r--. 1 root root  4041 Feb 18 15:07 postfix.fc
-rw-r--r--. 1 root root 11275 Feb 18 15:07 postfix.if
-rw-r--r--. 1 root root 17838 Feb 18 15:07 postfix.te
-rw-r--r--. 1 root root   350 Feb 18 15:07 postfixpolicyd.fc
-rw-r--r--. 1 root root  1022 Feb 18 15:07 postfixpolicyd.if
-rw-r--r--. 1 root root  1728 Feb 18 15:07 postfixpolicyd.te
-rw-r--r--. 1 root root  1676 Feb 18 15:07 postgresql.fc
-rw-r--r--. 1 root root  8742 Feb 18 15:07 postgresql.if
-rw-r--r--. 1 root root 13146 Feb 18 15:07 postgresql.te
-rw-r--r--. 1 root root   555 Feb 18 15:07 postgrey.fc
-rw-r--r--. 1 root root  1842 Feb 18 15:07 postgrey.if
-rw-r--r--. 1 root root  2898 Feb 18 15:07 postgrey.te
-rw-r--r--. 1 root root  1347 Feb 18 15:07 ppp.fc
-rw-r--r--. 1 root root  6490 Feb 18 15:07 ppp.if
-rw-r--r--. 1 root root  7513 Feb 18 15:07 ppp.te
-rw-r--r--. 1 root root   582 Feb 18 15:07 prelude.fc
-rw-r--r--. 1 root root  2026 Feb 18 15:07 prelude.if
-rw-r--r--. 1 root root  3788 Feb 18 15:07 prelude.te
-rw-r--r--. 1 root root   394 Feb 18 15:07 privoxy.fc
-rw-r--r--. 1 root root   980 Feb 18 15:07 privoxy.if
-rw-r--r--. 1 root root  2474 Feb 18 15:07 privoxy.te
-rw-r--r--. 1 root root   225 Feb 18 15:07 procmail.fc
-rw-r--r--. 1 root root  1496 Feb 18 15:07 procmail.if
-rw-r--r--. 1 root root  4276 Feb 18 15:07 procmail.te
-rw-r--r--. 1 root root   295 Feb 18 15:07 publicfile.fc
-rw-r--r--. 1 root root    83 Feb 18 15:07 publicfile.if
-rw-r--r--. 1 root root   743 Feb 18 15:07 publicfile.te
-rw-r--r--. 1 root root   200 Feb 18 15:07 pxe.fc
-rw-r--r--. 1 root root    63 Feb 18 15:07 pxe.if
-rw-r--r--. 1 root root  1216 Feb 18 15:07 pxe.te
-rw-r--r--. 1 root root   417 Feb 18 15:07 pyzor.fc
-rw-r--r--. 1 root root  1767 Feb 18 15:07 pyzor.if
-rw-r--r--. 1 root root  4099 Feb 18 15:07 pyzor.te
-rw-r--r--. 1 root root  2733 Feb 18 15:07 qmail.fc
-rw-r--r--. 1 root root  3041 Feb 18 15:07 qmail.if
-rw-r--r--. 1 root root  8454 Feb 18 15:07 qmail.te
-rw-r--r--. 1 root root  1315 Feb 18 15:07 radius.fc
-rw-r--r--. 1 root root  1412 Feb 18 15:07 radius.if
-rw-r--r--. 1 root root  4098 Feb 18 15:07 radius.te
-rw-r--r--. 1 root root   362 Feb 18 15:07 radvd.fc
-rw-r--r--. 1 root root   866 Feb 18 15:07 radvd.if
-rw-r--r--. 1 root root  2088 Feb 18 15:07 radvd.te
-rw-r--r--. 1 root root   352 Feb 18 15:07 razor.fc
-rw-r--r--. 1 root root  4416 Feb 18 15:07 razor.if
-rw-r--r--. 1 root root  3533 Feb 18 15:07 razor.te
-rw-r--r--. 1 root root    63 Feb 18 15:07 rdisc.fc
-rw-r--r--. 1 root root    54 Feb 18 15:07 rdisc.if
-rw-r--r--. 1 root root  1287 Feb 18 15:07 rdisc.te
-rw-r--r--. 1 root root    48 Feb 18 15:07 remotelogin.fc
-rw-r--r--. 1 root root   779 Feb 18 15:07 remotelogin.if
-rw-r--r--. 1 root root  4054 Feb 18 15:07 remotelogin.te
-rw-r--r--. 1 root root   295 Feb 18 15:07 resmgr.fc
-rw-r--r--. 1 root root   495 Feb 18 15:07 resmgr.if
-rw-r--r--. 1 root root  1585 Feb 18 15:07 resmgr.te
-rw-r--r--. 1 root root    75 Feb 18 15:07 rhgb.fc
-rw-r--r--. 1 root root  3656 Feb 18 15:07 rhgb.if
-rw-r--r--. 1 root root  3603 Feb 18 15:07 rhgb.te
-rw-r--r--. 1 root root  1005 Feb 18 15:07 ricci.fc
-rw-r--r--. 1 root root  3646 Feb 18 15:07 ricci.if
-rw-r--r--. 1 root root 12684 Feb 18 15:07 ricci.te
-rw-r--r--. 1 root root   235 Feb 18 15:07 rlogin.fc
-rw-r--r--. 1 root root   429 Feb 18 15:07 rlogin.if
-rw-r--r--. 1 root root  2638 Feb 18 15:07 rlogin.te
-rw-r--r--. 1 root root   265 Feb 18 15:07 roundup.fc
-rw-r--r--. 1 root root   938 Feb 18 15:07 roundup.if
-rw-r--r--. 1 root root  2501 Feb 18 15:07 roundup.te
-rw-r--r--. 1 root root   812 Feb 18 15:07 rpc.fc
-rw-r--r--. 1 root root  7420 Feb 18 15:07 rpc.if
-rw-r--r--. 1 root root  4316 Feb 18 15:07 rpc.te
-rw-r--r--. 1 root root   467 Feb 18 15:07 rpcbind.fc
-rw-r--r--. 1 root root  2638 Feb 18 15:07 rpcbind.if
-rw-r--r--. 1 root root  2218 Feb 18 15:07 rpcbind.te
-rw-r--r--. 1 root root   213 Feb 18 15:07 rshd.fc
-rw-r--r--. 1 root root   428 Feb 18 15:07 rshd.if
-rw-r--r--. 1 root root  2273 Feb 18 15:07 rshd.te
-rw-r--r--. 1 root root   223 Feb 18 15:07 rsync.fc
-rw-r--r--. 1 root root  2153 Feb 18 15:07 rsync.if
-rw-r--r--. 1 root root  3087 Feb 18 15:07 rsync.te
-rw-r--r--. 1 root root   287 Feb 18 15:07 rwho.fc
-rw-r--r--. 1 root root  2956 Feb 18 15:07 rwho.if
-rw-r--r--. 1 root root  1463 Feb 18 15:07 rwho.te
-rw-r--r--. 1 root root  2413 Feb 18 15:07 samba.fc
-rw-r--r--. 1 root root  9072 Feb 18 15:07 samba.if
-rw-r--r--. 1 root root 22421 Feb 18 15:07 samba.te
-rw-r--r--. 1 root root   262 Feb 18 15:07 sasl.fc
-rw-r--r--. 1 root root  1284 Feb 18 15:07 sasl.if
-rw-r--r--. 1 root root  3001 Feb 18 15:07 sasl.te
-rw-r--r--. 1 root root   309 Feb 18 15:07 sendmail.fc
-rw-r--r--. 1 root root  2856 Feb 18 15:07 sendmail.if
-rw-r--r--. 1 root root  4173 Feb 18 15:07 sendmail.te
-rw-r--r--. 1 root root   359 Feb 18 15:07 setroubleshoot.fc
-rw-r--r--. 1 root root  1016 Feb 18 15:07 setroubleshoot.if
-rw-r--r--. 1 root root  3838 Feb 18 15:07 setroubleshoot.te
-rw-r--r--. 1 root root   172 Feb 18 15:07 slrnpull.fc
-rw-r--r--. 1 root root   978 Feb 18 15:07 slrnpull.if
-rw-r--r--. 1 root root  1632 Feb 18 15:07 slrnpull.te
-rw-r--r--. 1 root root   258 Feb 18 15:07 smartmon.fc
-rw-r--r--. 1 root root  1277 Feb 18 15:07 smartmon.if
-rw-r--r--. 1 root root  2522 Feb 18 15:07 smartmon.te
-rw-r--r--. 1 root root   848 Feb 18 15:07 snmp.fc
-rw-r--r--. 1 root root  2820 Feb 18 15:07 snmp.if
-rw-r--r--. 1 root root  4169 Feb 18 15:07 snmp.te
-rw-r--r--. 1 root root   427 Feb 18 15:07 snort.fc
-rw-r--r--. 1 root root  1306 Feb 18 15:07 snort.if
-rw-r--r--. 1 root root  2736 Feb 18 15:07 snort.te
-rw-r--r--. 1 root root   648 Feb 18 15:07 soundserver.fc
-rw-r--r--. 1 root root  1331 Feb 18 15:07 soundserver.if
-rw-r--r--. 1 root root  3256 Feb 18 15:07 soundserver.te
-rw-r--r--. 1 root root   741 Feb 18 15:07 spamassassin.fc
-rw-r--r--. 1 root root  4817 Feb 18 15:07 spamassassin.if
-rw-r--r--. 1 root root 13863 Feb 18 15:07 spamassassin.te
-rw-r--r--. 1 root root    75 Feb 18 15:07 speedtouch.fc
-rw-r--r--. 1 root root    56 Feb 18 15:07 speedtouch.if
-rw-r--r--. 1 root root  1465 Feb 18 15:07 speedtouch.te
-rw-r--r--. 1 root root   758 Feb 18 15:07 squid.fc
-rw-r--r--. 1 root root  4144 Feb 18 15:07 squid.if
-rw-r--r--. 1 root root  5537 Feb 18 15:07 squid.te
-rw-r--r--. 1 root root   804 Feb 18 15:07 ssh.fc
-rw-r--r--. 1 root root 14735 Feb 18 15:07 ssh.if
-rw-r--r--. 1 root root 11055 Feb 18 15:07 ssh.te
-rw-r--r--. 1 root root   226 Feb 18 15:07 stunnel.fc
-rw-r--r--. 1 root root   577 Feb 18 15:07 stunnel.if
-rw-r--r--. 1 root root  2938 Feb 18 15:07 stunnel.te
-rw-r--r--. 1 root root   447 Feb 18 15:07 sysstat.fc
-rw-r--r--. 1 root root   440 Feb 18 15:07 sysstat.if
-rw-r--r--. 1 root root  1428 Feb 18 15:07 sysstat.te
-rw-r--r--. 1 root root    66 Feb 18 15:07 tcpd.fc
-rw-r--r--. 1 root root   903 Feb 18 15:07 tcpd.if
-rw-r--r--. 1 root root  1115 Feb 18 15:07 tcpd.te
-rw-r--r--. 1 root root   157 Feb 18 15:07 telnet.fc
-rw-r--r--. 1 root root    36 Feb 18 15:07 telnet.if
-rw-r--r--. 1 root root  2619 Feb 18 15:07 telnet.te
-rw-r--r--. 1 root root   326 Feb 18 15:07 tftp.fc
-rw-r--r--. 1 root root   625 Feb 18 15:07 tftp.if
-rw-r--r--. 1 root root  2683 Feb 18 15:07 tftp.te
-rw-r--r--. 1 root root    72 Feb 18 15:07 timidity.fc
-rw-r--r--. 1 root root    79 Feb 18 15:07 timidity.if
-rw-r--r--. 1 root root  2568 Feb 18 15:07 timidity.te
-rw-r--r--. 1 root root   470 Feb 18 15:07 tor.fc
-rw-r--r--. 1 root root  1349 Feb 18 15:07 tor.if
-rw-r--r--. 1 root root  2672 Feb 18 15:07 tor.te
-rw-r--r--. 1 root root   152 Feb 18 15:07 transproxy.fc
-rw-r--r--. 1 root root    45 Feb 18 15:07 transproxy.if
-rw-r--r--. 1 root root  1677 Feb 18 15:07 transproxy.te
-rw-r--r--. 1 root root   144 Feb 18 15:07 ucspitcp.fc
-rw-r--r--. 1 root root   766 Feb 18 15:07 ucspitcp.if
-rw-r--r--. 1 root root  2561 Feb 18 15:07 ucspitcp.te
-rw-r--r--. 1 root root   225 Feb 18 15:07 uptime.fc
-rw-r--r--. 1 root root    36 Feb 18 15:07 uptime.if
-rw-r--r--. 1 root root  1636 Feb 18 15:07 uptime.te
-rw-r--r--. 1 root root   348 Feb 18 15:07 uucp.fc
-rw-r--r--. 1 root root  2066 Feb 18 15:07 uucp.if
-rw-r--r--. 1 root root  2953 Feb 18 15:07 uucp.te
-rw-r--r--. 1 root root    69 Feb 18 15:07 uwimap.fc
-rw-r--r--. 1 root root   461 Feb 18 15:07 uwimap.if
-rw-r--r--. 1 root root  2503 Feb 18 15:07 uwimap.te
-rw-r--r--. 1 root root   716 Feb 18 15:07 virt.fc
-rw-r--r--. 1 root root  6481 Feb 18 15:07 virt.if
-rw-r--r--. 1 root root  4548 Feb 18 15:07 virt.te
-rw-r--r--. 1 root root   312 Feb 18 15:07 w3c.fc
-rw-r--r--. 1 root root    43 Feb 18 15:07 w3c.if
-rw-r--r--. 1 root root   670 Feb 18 15:07 w3c.te
-rw-r--r--. 1 root root   227 Feb 18 15:07 watchdog.fc
-rw-r--r--. 1 root root    40 Feb 18 15:07 watchdog.if
-rw-r--r--. 1 root root  2891 Feb 18 15:07 watchdog.te
-rw-r--r--. 1 root root   335 Feb 18 15:07 xfs.fc
-rw-r--r--. 1 root root  1099 Feb 18 15:07 xfs.if
-rw-r--r--. 1 root root  2005 Feb 18 15:07 xfs.te
-rw-r--r--. 1 root root    65 Feb 18 15:07 xprint.fc
-rw-r--r--. 1 root root    37 Feb 18 15:07 xprint.if
-rw-r--r--. 1 root root  1870 Feb 18 15:07 xprint.te
-rw-r--r--. 1 root root  4238 Feb 18 15:07 xserver.fc
-rw-r--r--. 1 root root 26924 Feb 18 15:07 xserver.if
-rw-r--r--. 1 root root 30899 Feb 18 15:07 xserver.te
-rw-r--r--. 1 root root   305 Feb 18 15:07 zabbix.fc
-rw-r--r--. 1 root root  2369 Feb 18 15:07 zabbix.if
-rw-r--r--. 1 root root  1083 Feb 18 15:07 zabbix.te
-rw-r--r--. 1 root root  1247 Feb 18 15:07 zebra.fc
-rw-r--r--. 1 root root  1528 Feb 18 15:07 zebra.if
-rw-r--r--. 1 root root  3687 Feb 18 15:07 zebra.te

/etc/selinux/refpolicy-standard/src/policy/policy/modules/system:
total 664
-rw-r--r--. 1 root root    32 Feb 18 15:07 application.fc
-rw-r--r--. 1 root root  2139 Feb 18 15:07 application.if
-rw-r--r--. 1 root root   278 Feb 18 15:07 application.te
-rw-r--r--. 1 root root  2139 Feb 18 15:07 authlogin.fc
-rw-r--r--. 1 root root 26493 Feb 18 15:07 authlogin.if
-rw-r--r--. 1 root root  9195 Feb 18 15:07 authlogin.te
-rw-r--r--. 1 root root   131 Feb 18 15:07 clock.fc
-rw-r--r--. 1 root root  1945 Feb 18 15:07 clock.if
-rw-r--r--. 1 root root  1793 Feb 18 15:07 clock.te
-rw-r--r--. 1 root root  2502 Feb 18 15:07 daemontools.fc
-rw-r--r--. 1 root root  3094 Feb 18 15:07 daemontools.if
-rw-r--r--. 1 root root  2544 Feb 18 15:07 daemontools.te
-rw-r--r--. 1 root root  2708 Feb 18 15:07 fstools.fc
-rw-r--r--. 1 root root  3017 Feb 18 15:07 fstools.if
-rw-r--r--. 1 root root  4779 Feb 18 15:07 fstools.te
-rw-r--r--. 1 root root   503 Feb 18 15:07 getty.fc
-rw-r--r--. 1 root root  1759 Feb 18 15:07 getty.if
-rw-r--r--. 1 root root  3035 Feb 18 15:07 getty.te
-rw-r--r--. 1 root root    69 Feb 18 15:07 hostname.fc
-rw-r--r--. 1 root root  1266 Feb 18 15:07 hostname.if
-rw-r--r--. 1 root root  1494 Feb 18 15:07 hostname.te
-rw-r--r--. 1 root root   507 Feb 18 15:07 hotplug.fc
-rw-r--r--. 1 root root  3353 Feb 18 15:07 hotplug.if
-rw-r--r--. 1 root root  4769 Feb 18 15:07 hotplug.te
-rw-r--r--. 1 root root  2402 Feb 18 15:07 init.fc
-rw-r--r--. 1 root root 29476 Feb 18 15:07 init.if
-rw-r--r--. 1 root root 18996 Feb 18 15:07 init.te
-rw-r--r--. 1 root root  1995 Feb 18 15:07 ipsec.fc
-rw-r--r--. 1 root root  4560 Feb 18 15:07 ipsec.if
-rw-r--r--. 1 root root 10637 Feb 18 15:07 ipsec.te
-rw-r--r--. 1 root root   438 Feb 18 15:07 iptables.fc
-rw-r--r--. 1 root root  1344 Feb 18 15:07 iptables.if
-rw-r--r--. 1 root root  2437 Feb 18 15:07 iptables.te
-rw-r--r--. 1 root root   282 Feb 18 15:07 iscsi.fc
-rw-r--r--. 1 root root   405 Feb 18 15:07 iscsi.if
-rw-r--r--. 1 root root  2206 Feb 18 15:07 iscsi.te
-rw-r--r--. 1 root root 19549 Feb 18 15:07 libraries.fc
-rw-r--r--. 1 root root 10003 Feb 18 15:07 libraries.if
-rw-r--r--. 1 root root  2686 Feb 18 15:07 libraries.te
-rw-r--r--. 1 root root    68 Feb 18 15:07 locallogin.fc
-rw-r--r--. 1 root root  2519 Feb 18 15:07 locallogin.if
-rw-r--r--. 1 root root  8030 Feb 18 15:07 locallogin.te
-rw-r--r--. 1 root root  3640 Feb 18 15:07 logging.fc
-rw-r--r--. 1 root root 19448 Feb 18 15:07 logging.if
-rw-r--r--. 1 root root 12767 Feb 18 15:07 logging.te
-rw-r--r--. 1 root root  4705 Feb 18 15:07 lvm.fc
-rw-r--r--. 1 root root  1686 Feb 18 15:07 lvm.if
-rw-r--r--. 1 root root  8090 Feb 18 15:07 lvm.te
-rw-r--r--. 1 root root    89 Feb 18 15:07 metadata.xml
-rw-r--r--. 1 root root  2678 Feb 18 15:07 miscfiles.fc
-rw-r--r--. 1 root root  9928 Feb 18 15:07 miscfiles.if
-rw-r--r--. 1 root root   895 Feb 18 15:07 miscfiles.te
-rw-r--r--. 1 root root  1166 Feb 18 15:07 modutils.fc
-rw-r--r--. 1 root root  5895 Feb 18 15:07 modutils.if
-rw-r--r--. 1 root root  6713 Feb 18 15:07 modutils.te
-rw-r--r--. 1 root root   203 Feb 18 15:07 mount.fc
-rw-r--r--. 1 root root  3303 Feb 18 15:07 mount.if
-rw-r--r--. 1 root root  4894 Feb 18 15:07 mount.te
-rw-r--r--. 1 root root    76 Feb 18 15:07 netlabel.fc
-rw-r--r--. 1 root root  1011 Feb 18 15:07 netlabel.if
-rw-r--r--. 1 root root   651 Feb 18 15:07 netlabel.te
-rw-r--r--. 1 root root   437 Feb 18 15:07 pcmcia.fc
-rw-r--r--. 1 root root  3075 Feb 18 15:07 pcmcia.if
-rw-r--r--. 1 root root  4035 Feb 18 15:07 pcmcia.te
-rw-r--r--. 1 root root   200 Feb 18 15:07 raid.fc
-rw-r--r--. 1 root root  1076 Feb 18 15:07 raid.if
-rw-r--r--. 1 root root  2028 Feb 18 15:07 raid.te
-rw-r--r--. 1 root root  2207 Feb 18 15:07 selinuxutil.fc
-rw-r--r--. 1 root root 24478 Feb 18 15:07 selinuxutil.if
-rw-r--r--. 1 root root 16009 Feb 18 15:07 selinuxutil.te
-rw-r--r--. 1 root root   246 Feb 18 15:07 setrans.fc
-rw-r--r--. 1 root root   589 Feb 18 15:07 setrans.if
-rw-r--r--. 1 root root  2150 Feb 18 15:07 setrans.te
-rw-r--r--. 1 root root  2278 Feb 18 15:07 sysnetwork.fc
-rw-r--r--. 1 root root 12182 Feb 18 15:07 sysnetwork.if
-rw-r--r--. 1 root root  8431 Feb 18 15:07 sysnetwork.te
-rw-r--r--. 1 root root   947 Feb 18 15:07 udev.fc
-rw-r--r--. 1 root root  2576 Feb 18 15:07 udev.if
-rw-r--r--. 1 root root  6168 Feb 18 15:07 udev.te
-rw-r--r--. 1 root root   921 Feb 18 15:07 unconfined.fc
-rw-r--r--. 1 root root 11905 Feb 18 15:07 unconfined.if
-rw-r--r--. 1 root root  4518 Feb 18 15:07 unconfined.te
-rw-r--r--. 1 root root   202 Feb 18 15:07 userdomain.fc
-rw-r--r--. 1 root root 65478 Feb 18 15:07 userdomain.if
-rw-r--r--. 1 root root  2855 Feb 18 15:07 userdomain.te
-rw-r--r--. 1 root root  1800 Feb 18 15:07 xen.fc
-rw-r--r--. 1 root root  3777 Feb 18 15:07 xen.if
-rw-r--r--. 1 root root  9866 Feb 18 15:07 xen.te

/etc/selinux/refpolicy-standard/src/policy/policy/support:
total 52
-rw-r--r--. 1 root root 12662 Feb 18 15:07 file_patterns.spt
-rw-r--r--. 1 root root   341 Feb 18 15:07 ipc_patterns.spt
-rw-r--r--. 1 root root  3335 Feb 18 15:07 loadable_module.spt
-rw-r--r--. 1 root root  1723 Feb 18 15:07 misc_macros.spt
-rw-r--r--. 1 root root  1370 Feb 18 15:07 misc_patterns.spt
-rw-r--r--. 1 root root  1385 Feb 18 15:07 mls_mcs_macros.spt
-rw-r--r--. 1 root root 12395 Feb 18 15:07 obj_perm_sets.spt

/etc/selinux/refpolicy-standard/src/policy/support:
total 168
-rw-r--r--. 1 root root  7236 Feb 18 15:07 Makefile.devel
-rw-r--r--. 1 root root   672 Feb 18 15:07 comment_move_decl.sed
-rw-r--r--. 1 root root 13623 Feb 18 15:07 fc_sort.c
-rw-r--r--. 1 root root  9504 Feb 18 15:07 genclassperms.py
-rw-r--r--. 1 root root 17017 Feb 18 15:07 genhomedircon
-rw-r--r--. 1 root root  4374 Feb 18 15:07 gennetfilter.py
-rw-r--r--. 1 root root   266 Feb 18 15:07 get_type_attr_decl.sed
-rw-r--r--. 1 root root    32 Feb 18 15:07 iferror.m4
-rw-r--r--. 1 root root 10492 Feb 18 15:07 pyplate.py
-rw-r--r--. 1 root root 16303 Feb 18 16:15 pyplate.pyc
-rw-r--r--. 1 root root 25444 Feb 18 15:07 sedoctool.py
-rw-r--r--. 1 root root 10766 Feb 18 15:07 segenxml.py
-rw-r--r--. 1 root root 14846 Feb 18 15:07 selinux-policy-refpolicy.spec
-rw-r--r--. 1 root root  1177 Feb 18 15:07 selinux-refpolicy-sources.spec.skel
-rw-r--r--. 1 root root   209 Feb 18 15:07 set_bools_tuns.awk

/etc/selinux/refpolicy-standard/src/policy/tmp:
total 80000
-rw-r--r--. 1 root root   48063 Feb 18 16:22 acct.mod
-rw-r--r--. 1 root root   12780 Feb 18 16:22 acct.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:22 acct.mod.role
-rw-r--r--. 1 root root   50977 Feb 18 16:22 acct.tmp
-rw-r--r--. 1 root root   46207 Feb 18 16:22 ada.mod
-rw-r--r--. 1 root root   12785 Feb 18 16:22 ada.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:22 ada.mod.role
-rw-r--r--. 1 root root   38395 Feb 18 16:22 ada.tmp
-rw-r--r--. 1 root root   49151 Feb 18 16:22 admin.xml
-rw-r--r--. 1 root root  103420 Feb 18 16:22 afs.mod
-rw-r--r--. 1 root root   13491 Feb 18 16:22 afs.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:22 afs.mod.role
-rw-r--r--. 1 root root  162583 Feb 18 16:22 afs.tmp
-rw-r--r--. 1 root root   29664 Feb 18 16:22 aide.mod
-rw-r--r--. 1 root root   12764 Feb 18 16:22 aide.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:22 aide.mod.role
-rw-r--r--. 1 root root   31550 Feb 18 16:22 aide.tmp
-rw-r--r--. 1 root root   24675 Feb 18 16:22 all_attrs_types.conf
-rw-r--r--. 1 root root 3874465 Feb 18 16:22 all_interfaces.conf
-rw-r--r--. 1 root root 3974239 Feb 18 16:22 all_interfaces.conf.tmp
-rw-r--r--. 1 root root   49969 Feb 18 16:22 all_post.conf
-rw-r--r--. 1 root root  251506 Feb 18 16:22 all_te_files.conf
-rw-r--r--. 1 root root   57413 Feb 18 16:22 alsa.mod
-rw-r--r--. 1 root root   13035 Feb 18 16:22 alsa.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:22 alsa.mod.role
-rw-r--r--. 1 root root   84230 Feb 18 16:22 alsa.tmp
-rw-r--r--. 1 root root  113141 Feb 18 16:22 amanda.mod
-rw-r--r--. 1 root root   13927 Feb 18 16:22 amanda.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:22 amanda.mod.role
-rw-r--r--. 1 root root  206411 Feb 18 16:22 amanda.tmp
-rw-r--r--. 1 root root   75569 Feb 18 16:22 amavis.mod
-rw-r--r--. 1 root root   13221 Feb 18 16:22 amavis.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:22 amavis.mod.role
-rw-r--r--. 1 root root  100760 Feb 18 16:22 amavis.tmp
-rw-r--r--. 1 root root   30915 Feb 18 16:22 amtu.mod
-rw-r--r--. 1 root root   12611 Feb 18 16:22 amtu.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:22 amtu.mod.role
-rw-r--r--. 1 root root   27375 Feb 18 16:22 amtu.tmp
-rw-r--r--. 1 root root   65078 Feb 18 16:22 anaconda.mod
-rw-r--r--. 1 root root   12728 Feb 18 16:22 anaconda.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:22 anaconda.mod.role
-rw-r--r--. 1 root root   54456 Feb 18 16:22 anaconda.tmp
-rw-r--r--. 1 root root  338963 Feb 18 16:22 apache.mod
-rw-r--r--. 1 root root   16000 Feb 18 16:22 apache.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:22 apache.mod.role
-rw-r--r--. 1 root root  585639 Feb 18 16:22 apache.tmp
-rw-r--r--. 1 root root  112582 Feb 18 16:22 apcupsd.mod
-rw-r--r--. 1 root root   13218 Feb 18 16:22 apcupsd.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:22 apcupsd.mod.role
-rw-r--r--. 1 root root  202793 Feb 18 16:22 apcupsd.tmp
-rw-r--r--. 1 root root  112567 Feb 18 16:22 apm.mod
-rw-r--r--. 1 root root   13135 Feb 18 16:22 apm.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:22 apm.mod.role
-rw-r--r--. 1 root root  115097 Feb 18 16:22 apm.tmp
-rw-r--r--. 1 root root   18592 Feb 18 16:22 application.mod
-rw-r--r--. 1 root root   12596 Feb 18 16:22 application.mod.fc
-rw-r--r--. 1 root root     227 Feb 18 16:22 application.mod.role
-rw-r--r--. 1 root root   17398 Feb 18 16:22 application.tmp
-rw-r--r--. 1 root root   24976 Feb 18 16:22 apps.xml
-rw-r--r--. 1 root root   80941 Feb 18 16:22 apt.mod
-rw-r--r--. 1 root root   13121 Feb 18 16:22 apt.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:22 apt.mod.role
-rw-r--r--. 1 root root  106491 Feb 18 16:22 apt.tmp
-rw-r--r--. 1 root root   68713 Feb 18 16:22 arpwatch.mod
-rw-r--r--. 1 root root   12830 Feb 18 16:22 arpwatch.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:22 arpwatch.mod.role
-rw-r--r--. 1 root root  105721 Feb 18 16:22 arpwatch.tmp
-rw-r--r--. 1 root root   60277 Feb 18 16:22 asterisk.mod
-rw-r--r--. 1 root root   12991 Feb 18 16:22 asterisk.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:22 asterisk.mod.role
-rw-r--r--. 1 root root   94419 Feb 18 16:22 asterisk.tmp
-rw-r--r--. 1 root root   41009 Feb 18 16:22 audioentropy.mod
-rw-r--r--. 1 root root   12707 Feb 18 16:22 audioentropy.mod.fc
-rw-r--r--. 1 root root     230 Feb 18 16:22 audioentropy.mod.role
-rw-r--r--. 1 root root   43609 Feb 18 16:22 audioentropy.tmp
-rw-r--r--. 1 root root  741234 Feb 18 16:22 auditadm.mod
-rw-r--r--. 1 root root   12620 Feb 18 16:22 auditadm.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:22 auditadm.mod.role
-rw-r--r--. 1 root root 1182985 Feb 18 16:22 auditadm.tmp
-rw-r--r--. 1 root root   27365 Feb 18 16:22 authbind.mod
-rw-r--r--. 1 root root   12687 Feb 18 16:22 authbind.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:22 authbind.mod.role
-rw-r--r--. 1 root root   28603 Feb 18 16:22 authbind.tmp
-rw-r--r--. 1 root root  206880 Feb 18 16:22 authlogin.mod
-rw-r--r--. 1 root root   14115 Feb 18 16:22 authlogin.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:22 authlogin.mod.role
-rw-r--r--. 1 root root  364620 Feb 18 16:22 authlogin.tmp
-rw-r--r--. 1 root root   89753 Feb 18 16:23 automount.mod
-rw-r--r--. 1 root root   12849 Feb 18 16:23 automount.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:22 automount.mod.role
-rw-r--r--. 1 root root  140505 Feb 18 16:22 automount.tmp
-rw-r--r--. 1 root root   72606 Feb 18 16:23 avahi.mod
-rw-r--r--. 1 root root   12939 Feb 18 16:23 avahi.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 avahi.mod.role
-rw-r--r--. 1 root root  107690 Feb 18 16:23 avahi.tmp
-rw-r--r--. 1 root root   94144 Feb 18 16:23 awstats.mod
-rw-r--r--. 1 root root   12859 Feb 18 16:23 awstats.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 awstats.mod.role
-rw-r--r--. 1 root root  149814 Feb 18 16:23 awstats.tmp
-rw-r--r--. 1 root root   49400 Feb 18 16:23 backup.mod
-rw-r--r--. 1 root root   12905 Feb 18 16:23 backup.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 backup.mod.role
-rw-r--r--. 1 root root   70340 Feb 18 16:23 backup.tmp
-rw-r--r--. 1 root root   26248 Feb 18 16:22 base.fc.tmp
-rw-r--r--. 1 root root  197803 Feb 18 16:22 base.mod
-rw-r--r--. 1 root root  127016 Feb 18 16:23 bind.mod
-rw-r--r--. 1 root root   13167 Feb 18 16:23 bind.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 bind.mod.role
-rw-r--r--. 1 root root  211284 Feb 18 16:23 bind.tmp
-rw-r--r--. 1 root root   53402 Feb 18 16:23 bitlbee.mod
-rw-r--r--. 1 root root   12799 Feb 18 16:23 bitlbee.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 bitlbee.mod.role
-rw-r--r--. 1 root root   73042 Feb 18 16:23 bitlbee.tmp
-rw-r--r--. 1 root root  125780 Feb 18 16:23 bluetooth.mod
-rw-r--r--. 1 root root   13564 Feb 18 16:23 bluetooth.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 bluetooth.mod.role
-rw-r--r--. 1 root root  203157 Feb 18 16:23 bluetooth.tmp
-rw-r--r--. 1 root root   68076 Feb 18 16:23 bootloader.mod
-rw-r--r--. 1 root root   12837 Feb 18 16:23 bootloader.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:23 bootloader.mod.role
-rw-r--r--. 1 root root   90960 Feb 18 16:23 bootloader.tmp
-rw-r--r--. 1 root root   39728 Feb 18 16:23 brctl.mod
-rw-r--r--. 1 root root   12615 Feb 18 16:23 brctl.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 brctl.mod.role
-rw-r--r--. 1 root root   38832 Feb 18 16:23 brctl.tmp
-rw-r--r--. 1 root root   52378 Feb 18 16:23 calamaris.mod
-rw-r--r--. 1 root root   12770 Feb 18 16:23 calamaris.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 calamaris.mod.role
-rw-r--r--. 1 root root   73991 Feb 18 16:23 calamaris.tmp
-rw-r--r--. 1 root root   54364 Feb 18 16:23 canna.mod
-rw-r--r--. 1 root root   13267 Feb 18 16:23 canna.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 canna.mod.role
-rw-r--r--. 1 root root   75543 Feb 18 16:23 canna.tmp
-rw-r--r--. 1 root root   48300 Feb 18 16:23 ccs.mod
-rw-r--r--. 1 root root   12880 Feb 18 16:23 ccs.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 ccs.mod.role
-rw-r--r--. 1 root root   70096 Feb 18 16:23 ccs.tmp
-rw-r--r--. 1 root root   43203 Feb 18 16:23 cdrecord.mod
-rw-r--r--. 1 root root   12631 Feb 18 16:23 cdrecord.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 cdrecord.mod.role
-rw-r--r--. 1 root root   63130 Feb 18 16:23 cdrecord.tmp
-rw-r--r--. 1 root root   38200 Feb 18 16:23 certwatch.mod
-rw-r--r--. 1 root root   12621 Feb 18 16:23 certwatch.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 certwatch.mod.role
-rw-r--r--. 1 root root   38666 Feb 18 16:23 certwatch.tmp
-rw-r--r--. 1 root root   51395 Feb 18 16:23 cipe.mod
-rw-r--r--. 1 root root   12627 Feb 18 16:23 cipe.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 cipe.mod.role
-rw-r--r--. 1 root root   69016 Feb 18 16:23 cipe.tmp
-rw-r--r--. 1 root root   90189 Feb 18 16:23 clamav.mod
-rw-r--r--. 1 root root   13392 Feb 18 16:23 clamav.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 clamav.mod.role
-rw-r--r--. 1 root root  136716 Feb 18 16:23 clamav.tmp
-rw-r--r--. 1 root root   46914 Feb 18 16:23 clock.mod
-rw-r--r--. 1 root root   12663 Feb 18 16:23 clock.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 clock.mod.role
-rw-r--r--. 1 root root   49601 Feb 18 16:23 clock.tmp
-rw-r--r--. 1 root root   50353 Feb 18 16:23 clockspeed.mod
-rw-r--r--. 1 root root   12962 Feb 18 16:23 clockspeed.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:23 clockspeed.mod.role
-rw-r--r--. 1 root root   65706 Feb 18 16:23 clockspeed.tmp
-rw-r--r--. 1 root root   66261 Feb 18 16:23 comsat.mod
-rw-r--r--. 1 root root   12621 Feb 18 16:23 comsat.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 comsat.mod.role
-rw-r--r--. 1 root root  107851 Feb 18 16:23 comsat.tmp
-rw-r--r--. 1 root root   66030 Feb 18 16:23 consolekit.mod
-rw-r--r--. 1 root root   12700 Feb 18 16:23 consolekit.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:23 consolekit.mod.role
-rw-r--r--. 1 root root   92134 Feb 18 16:23 consolekit.tmp
-rw-r--r--. 1 root root   67076 Feb 18 16:23 consoletype.mod
-rw-r--r--. 1 root root   12623 Feb 18 16:23 consoletype.mod.fc
-rw-r--r--. 1 root root     227 Feb 18 16:23 consoletype.mod.role
-rw-r--r--. 1 root root   76604 Feb 18 16:23 consoletype.tmp
-rw-r--r--. 1 root root  181338 Feb 18 16:23 courier.mod
-rw-r--r--. 1 root root   13813 Feb 18 16:23 courier.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 courier.mod.role
-rw-r--r--. 1 root root  284314 Feb 18 16:23 courier.tmp
-rw-r--r--. 1 root root   61459 Feb 18 16:23 cpucontrol.mod
-rw-r--r--. 1 root root   12915 Feb 18 16:23 cpucontrol.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:23 cpucontrol.mod.role
-rw-r--r--. 1 root root   67873 Feb 18 16:23 cpucontrol.tmp
-rw-r--r--. 1 root root  308435 Feb 18 16:23 cron.mod
-rw-r--r--. 1 root root   14306 Feb 18 16:23 cron.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 cron.mod.role
-rw-r--r--. 1 root root  486093 Feb 18 16:23 cron.tmp
-rw-r--r--. 1 root root  314675 Feb 18 16:23 cups.mod
-rw-r--r--. 1 root root   14878 Feb 18 16:23 cups.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 cups.mod.role
-rw-r--r--. 1 root root  510533 Feb 18 16:23 cups.tmp
-rw-r--r--. 1 root root       0 Feb 18 16:25 customizable_types
-rw-r--r--. 1 root root  150895 Feb 18 16:23 cvs.mod
-rw-r--r--. 1 root root   12873 Feb 18 16:23 cvs.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 cvs.mod.role
-rw-r--r--. 1 root root  275289 Feb 18 16:23 cvs.tmp
-rw-r--r--. 1 root root   56661 Feb 18 16:23 cyphesis.mod
-rw-r--r--. 1 root root   12619 Feb 18 16:23 cyphesis.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 cyphesis.mod.role
-rw-r--r--. 1 root root   81410 Feb 18 16:23 cyphesis.tmp
-rw-r--r--. 1 root root   93899 Feb 18 16:23 cyrus.mod
-rw-r--r--. 1 root root   12763 Feb 18 16:23 cyrus.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 cyrus.mod.role
-rw-r--r--. 1 root root  141448 Feb 18 16:23 cyrus.tmp
-rw-r--r--. 1 root root   59668 Feb 18 16:23 daemontools.mod
-rw-r--r--. 1 root root   14506 Feb 18 16:23 daemontools.mod.fc
-rw-r--r--. 1 root root     227 Feb 18 16:23 daemontools.mod.role
-rw-r--r--. 1 root root   65675 Feb 18 16:23 daemontools.tmp
-rw-r--r--. 1 root root   43966 Feb 18 16:23 dante.mod
-rw-r--r--. 1 root root   12724 Feb 18 16:23 dante.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 dante.mod.role
-rw-r--r--. 1 root root   51616 Feb 18 16:23 dante.tmp
-rw-r--r--. 1 root root   67182 Feb 18 16:23 dbskk.mod
-rw-r--r--. 1 root root   12621 Feb 18 16:23 dbskk.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 dbskk.mod.role
-rw-r--r--. 1 root root  106133 Feb 18 16:23 dbskk.tmp
-rw-r--r--. 1 root root   72951 Feb 18 16:23 dbus.mod
-rw-r--r--. 1 root root   12922 Feb 18 16:23 dbus.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 dbus.mod.role
-rw-r--r--. 1 root root  115099 Feb 18 16:23 dbus.tmp
-rw-r--r--. 1 root root  259434 Feb 18 16:23 dcc.mod
-rw-r--r--. 1 root root   13333 Feb 18 16:23 dcc.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 dcc.mod.role
-rw-r--r--. 1 root root  485842 Feb 18 16:23 dcc.tmp
-rw-r--r--. 1 root root   52257 Feb 18 16:23 ddclient.mod
-rw-r--r--. 1 root root   13160 Feb 18 16:23 ddclient.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 ddclient.mod.role
-rw-r--r--. 1 root root   68036 Feb 18 16:23 ddclient.tmp
-rw-r--r--. 1 root root   35223 Feb 18 16:23 ddcprobe.mod
-rw-r--r--. 1 root root   12631 Feb 18 16:23 ddcprobe.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 ddcprobe.mod.role
-rw-r--r--. 1 root root   41460 Feb 18 16:23 ddcprobe.tmp
-rw-r--r--. 1 root root   77256 Feb 18 16:23 dhcp.mod
-rw-r--r--. 1 root root   12868 Feb 18 16:23 dhcp.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 dhcp.mod.role
-rw-r--r--. 1 root root  116386 Feb 18 16:23 dhcp.tmp
-rw-r--r--. 1 root root   56136 Feb 18 16:23 dictd.mod
-rw-r--r--. 1 root root   12848 Feb 18 16:23 dictd.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 dictd.mod.role
-rw-r--r--. 1 root root   78940 Feb 18 16:23 dictd.tmp
-rw-r--r--. 1 root root   54039 Feb 18 16:23 distcc.mod
-rw-r--r--. 1 root root   12618 Feb 18 16:23 distcc.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 distcc.mod.role
-rw-r--r--. 1 root root   78550 Feb 18 16:23 distcc.tmp
-rw-r--r--. 1 root root   58383 Feb 18 16:23 djbdns.mod
-rw-r--r--. 1 root root   12948 Feb 18 16:23 djbdns.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 djbdns.mod.role
-rw-r--r--. 1 root root   77837 Feb 18 16:23 djbdns.tmp
-rw-r--r--. 1 root root   37572 Feb 18 16:23 dmesg.mod
-rw-r--r--. 1 root root   12612 Feb 18 16:23 dmesg.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 dmesg.mod.role
-rw-r--r--. 1 root root   41683 Feb 18 16:23 dmesg.tmp
-rw-r--r--. 1 root root   27302 Feb 18 16:23 dmidecode.mod
-rw-r--r--. 1 root root   12739 Feb 18 16:23 dmidecode.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 dmidecode.mod.role
-rw-r--r--. 1 root root   28334 Feb 18 16:23 dmidecode.tmp
-rw-r--r--. 1 root root   55484 Feb 18 16:23 dnsmasq.mod
-rw-r--r--. 1 root root   12879 Feb 18 16:23 dnsmasq.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 dnsmasq.mod.role
-rw-r--r--. 1 root root   80300 Feb 18 16:23 dnsmasq.tmp
-rw-r--r--. 1 root root  149595 Feb 18 16:23 dovecot.mod
-rw-r--r--. 1 root root   13307 Feb 18 16:23 dovecot.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 dovecot.mod.role
-rw-r--r--. 1 root root  280063 Feb 18 16:23 dovecot.tmp
-rw-r--r--. 1 root root  169011 Feb 18 16:23 dpkg.mod
-rw-r--r--. 1 root root   13081 Feb 18 16:23 dpkg.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 dpkg.mod.role
-rw-r--r--. 1 root root  250104 Feb 18 16:23 dpkg.tmp
-rw-r--r--. 1 root root   75916 Feb 18 16:23 ethereal.mod
-rw-r--r--. 1 root root   12747 Feb 18 16:23 ethereal.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 ethereal.mod.role
-rw-r--r--. 1 root root  109543 Feb 18 16:23 ethereal.tmp
-rw-r--r--. 1 root root  210828 Feb 18 16:23 evolution.mod
-rw-r--r--. 1 root root   13236 Feb 18 16:23 evolution.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 evolution.mod.role
-rw-r--r--. 1 root root  388488 Feb 18 16:23 evolution.tmp
-rw-r--r--. 1 root root   67489 Feb 18 16:23 exim.mod
-rw-r--r--. 1 root root   12798 Feb 18 16:23 exim.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 exim.mod.role
-rw-r--r--. 1 root root  113458 Feb 18 16:23 exim.tmp
-rw-r--r--. 1 root root   70461 Feb 18 16:23 fail2ban.mod
-rw-r--r--. 1 root root   12871 Feb 18 16:23 fail2ban.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 fail2ban.mod.role
-rw-r--r--. 1 root root  102770 Feb 18 16:23 fail2ban.tmp
-rwxr-xr-x. 1 root root   14750 Feb 18 16:22 fc_sort
-rw-r--r--. 1 root root   51330 Feb 18 16:23 fetchmail.mod
-rw-r--r--. 1 root root   12857 Feb 18 16:23 fetchmail.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 fetchmail.mod.role
-rw-r--r--. 1 root root   62258 Feb 18 16:23 fetchmail.tmp
-rw-r--r--. 1 root root   73811 Feb 18 16:23 finger.mod
-rw-r--r--. 1 root root   12907 Feb 18 16:23 finger.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 finger.mod.role
-rw-r--r--. 1 root root   94430 Feb 18 16:23 finger.tmp
-rw-r--r--. 1 root root   86826 Feb 18 16:23 firstboot.mod
-rw-r--r--. 1 root root   12697 Feb 18 16:23 firstboot.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 firstboot.mod.role
-rw-r--r--. 1 root root  113494 Feb 18 16:23 firstboot.tmp
-rw-r--r--. 1 root root   67259 Feb 18 16:23 fstools.mod
-rw-r--r--. 1 root root   14616 Feb 18 16:23 fstools.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 fstools.mod.role
-rw-r--r--. 1 root root  103148 Feb 18 16:23 fstools.tmp
-rw-r--r--. 1 root root  145211 Feb 18 16:23 ftp.mod
-rw-r--r--. 1 root root   13533 Feb 18 16:23 ftp.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 ftp.mod.role
-rw-r--r--. 1 root root  239237 Feb 18 16:23 ftp.tmp
-rw-r--r--. 1 root root   77487 Feb 18 16:23 games.mod
-rw-r--r--. 1 root root   15501 Feb 18 16:23 games.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 games.mod.role
-rw-r--r--. 1 root root  109589 Feb 18 16:23 games.tmp
-rw-r--r--. 1 root root   53261 Feb 18 16:23 gatekeeper.mod
-rw-r--r--. 1 root root   12911 Feb 18 16:23 gatekeeper.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:23 gatekeeper.mod.role
-rw-r--r--. 1 root root   80045 Feb 18 16:23 gatekeeper.tmp
-rw-r--r--. 1 root root   20572 Feb 18 16:22 generated_definitions.conf
-rw-r--r--. 1 root root   61292 Feb 18 16:23 getty.mod
-rw-r--r--. 1 root root   12955 Feb 18 16:23 getty.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 getty.mod.role
-rw-r--r--. 1 root root   71209 Feb 18 16:23 getty.tmp
-rw-r--r--. 1 root root   65896 Feb 18 16:23 gift.mod
-rw-r--r--. 1 root root   12857 Feb 18 16:23 gift.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 gift.mod.role
-rw-r--r--. 1 root root   95105 Feb 18 16:23 gift.tmp
-rw-r--r--. 1 root root    9797 Feb 18 16:22 global_bools.conf
-rw-r--r--. 1 root root   37392 Feb 18 16:23 gnome.mod
-rw-r--r--. 1 root root   12840 Feb 18 16:23 gnome.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 gnome.mod.role
-rw-r--r--. 1 root root   43363 Feb 18 16:23 gnome.tmp
-rw-r--r--. 1 root root   87454 Feb 18 16:23 gpg.mod
-rw-r--r--. 1 root root   12945 Feb 18 16:23 gpg.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 gpg.mod.role
-rw-r--r--. 1 root root  139359 Feb 18 16:23 gpg.tmp
-rw-r--r--. 1 root root   42660 Feb 18 16:23 gpm.mod
-rw-r--r--. 1 root root   12747 Feb 18 16:23 gpm.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 gpm.mod.role
-rw-r--r--. 1 root root   46798 Feb 18 16:23 gpm.tmp
-rw-r--r--. 1 root root  237602 Feb 18 16:23 hal.mod
-rw-r--r--. 1 root root   13766 Feb 18 16:23 hal.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 hal.mod.role
-rw-r--r--. 1 root root  342571 Feb 18 16:23 hal.tmp
-rw-r--r--. 1 root root   42815 Feb 18 16:23 hostname.mod
-rw-r--r--. 1 root root   12617 Feb 18 16:23 hostname.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 hostname.mod.role
-rw-r--r--. 1 root root   54984 Feb 18 16:23 hostname.tmp
-rw-r--r--. 1 root root  107073 Feb 18 16:23 hotplug.mod
-rw-r--r--. 1 root root   12959 Feb 18 16:23 hotplug.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 hotplug.mod.role
-rw-r--r--. 1 root root  127600 Feb 18 16:23 hotplug.tmp
-rw-r--r--. 1 root root   51667 Feb 18 16:23 howl.mod
-rw-r--r--. 1 root root   12725 Feb 18 16:23 howl.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 howl.mod.role
-rw-r--r--. 1 root root   72249 Feb 18 16:23 howl.tmp
-rw-r--r--. 1 root root   57383 Feb 18 16:23 i18n_input.mod
-rw-r--r--. 1 root root   13059 Feb 18 16:23 i18n_input.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:23 i18n_input.mod.role
-rw-r--r--. 1 root root   81420 Feb 18 16:23 i18n_input.tmp
-rw-r--r--. 1 root root   52522 Feb 18 16:23 imaze.mod
-rw-r--r--. 1 root root   12746 Feb 18 16:23 imaze.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 imaze.mod.role
-rw-r--r--. 1 root root   76090 Feb 18 16:23 imaze.tmp
-rw-r--r--. 1 root root  130447 Feb 18 16:23 inetd.mod
-rw-r--r--. 1 root root   13030 Feb 18 16:23 inetd.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 inetd.mod.role
-rw-r--r--. 1 root root  204091 Feb 18 16:23 inetd.tmp
-rw-r--r--. 1 root root  336568 Feb 18 16:23 init.mod
-rw-r--r--. 1 root root   13872 Feb 18 16:23 init.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 init.mod.role
-rw-r--r--. 1 root root  478075 Feb 18 16:23 init.tmp
-rw-r--r--. 1 root root   64640 Feb 18 16:23 inn.mod
-rw-r--r--. 1 root root   15722 Feb 18 16:23 inn.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 inn.mod.role
-rw-r--r--. 1 root root   89515 Feb 18 16:23 inn.tmp
-rw-r--r--. 1 root root  122162 Feb 18 16:23 ipsec.mod
-rw-r--r--. 1 root root   14143 Feb 18 16:23 ipsec.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 ipsec.mod.role
-rw-r--r--. 1 root root  178659 Feb 18 16:23 ipsec.tmp
-rw-r--r--. 1 root root   82307 Feb 18 16:23 iptables.mod
-rw-r--r--. 1 root root   12906 Feb 18 16:23 iptables.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 iptables.mod.role
-rw-r--r--. 1 root root  130237 Feb 18 16:23 iptables.tmp
-rw-r--r--. 1 root root   46628 Feb 18 16:23 irc.mod
-rw-r--r--. 1 root root   12785 Feb 18 16:23 irc.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 irc.mod.role
-rw-r--r--. 1 root root   75408 Feb 18 16:23 irc.tmp
-rw-r--r--. 1 root root   53177 Feb 18 16:23 ircd.mod
-rw-r--r--. 1 root root   12858 Feb 18 16:23 ircd.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 ircd.mod.role
-rw-r--r--. 1 root root   74961 Feb 18 16:23 ircd.tmp
-rw-r--r--. 1 root root   42087 Feb 18 16:23 irqbalance.mod
-rw-r--r--. 1 root root   12625 Feb 18 16:23 irqbalance.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:23 irqbalance.mod.role
-rw-r--r--. 1 root root   43881 Feb 18 16:23 irqbalance.tmp
-rw-r--r--. 1 root root   49618 Feb 18 16:23 iscsi.mod
-rw-r--r--. 1 root root   12782 Feb 18 16:23 iscsi.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 iscsi.mod.role
-rw-r--r--. 1 root root   62551 Feb 18 16:23 iscsi.tmp
-rw-r--r--. 1 root root   54381 Feb 18 16:23 jabber.mod
-rw-r--r--. 1 root root   12803 Feb 18 16:23 jabber.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 jabber.mod.role
-rw-r--r--. 1 root root   80007 Feb 18 16:23 jabber.tmp
-rw-r--r--. 1 root root   98533 Feb 18 16:23 java.mod
-rw-r--r--. 1 root root   13572 Feb 18 16:23 java.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 java.mod.role
-rw-r--r--. 1 root root  135211 Feb 18 16:23 java.tmp
-rw-r--r--. 1 root root  123619 Feb 18 16:23 kerberos.mod
-rw-r--r--. 1 root root   13938 Feb 18 16:23 kerberos.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 kerberos.mod.role
-rw-r--r--. 1 root root  228555 Feb 18 16:23 kerberos.tmp
-rw-r--r--. 1 root root 1010513 Feb 18 16:22 kernel.xml
-rw-r--r--. 1 root root   43032 Feb 18 16:23 kerneloops.mod
-rw-r--r--. 1 root root   12701 Feb 18 16:23 kerneloops.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:23 kerneloops.mod.role
-rw-r--r--. 1 root root   57034 Feb 18 16:23 kerneloops.tmp
-rw-r--r--. 1 root root   52833 Feb 18 16:23 kismet.mod
-rw-r--r--. 1 root root   12796 Feb 18 16:23 kismet.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 kismet.mod.role
-rw-r--r--. 1 root root   80489 Feb 18 16:23 kismet.tmp
-rw-r--r--. 1 root root   66562 Feb 18 16:23 ktalk.mod
-rw-r--r--. 1 root root   12781 Feb 18 16:23 ktalk.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 ktalk.mod.role
-rw-r--r--. 1 root root  109336 Feb 18 16:23 ktalk.tmp
-rw-r--r--. 1 root root   85467 Feb 18 16:23 kudzu.mod
-rw-r--r--. 1 root root   12710 Feb 18 16:23 kudzu.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 kudzu.mod.role
-rw-r--r--. 1 root root  102827 Feb 18 16:23 kudzu.tmp
-rw-r--r--. 1 root root   79347 Feb 18 16:23 ldap.mod
-rw-r--r--. 1 root root   13078 Feb 18 16:23 ldap.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 ldap.mod.role
-rw-r--r--. 1 root root  127924 Feb 18 16:23 ldap.tmp
-rw-r--r--. 1 root root   43449 Feb 18 16:23 libraries.mod
-rw-r--r--. 1 root root   17184 Feb 18 16:23 libraries.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 libraries.mod.role
-rw-r--r--. 1 root root   49119 Feb 18 16:23 libraries.tmp
-rw-r--r--. 1 root root   33325 Feb 18 16:23 loadkeys.mod
-rw-r--r--. 1 root root   12668 Feb 18 16:23 loadkeys.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 loadkeys.mod.role
-rw-r--r--. 1 root root   35471 Feb 18 16:23 loadkeys.tmp
-rw-r--r--. 1 root root  183800 Feb 18 16:23 locallogin.mod
-rw-r--r--. 1 root root   12616 Feb 18 16:23 locallogin.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:23 locallogin.mod.role
-rw-r--r--. 1 root root  313846 Feb 18 16:23 locallogin.tmp
-rw-r--r--. 1 root root   29404 Feb 18 16:23 lockdev.mod
-rw-r--r--. 1 root root   12619 Feb 18 16:23 lockdev.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 lockdev.mod.role
-rw-r--r--. 1 root root   31473 Feb 18 16:23 lockdev.tmp
-rw-r--r--. 1 root root  184069 Feb 18 16:23 logging.mod
-rw-r--r--. 1 root root   15176 Feb 18 16:23 logging.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 logging.mod.role
-rw-r--r--. 1 root root  301791 Feb 18 16:23 logging.tmp
-rw-r--r--. 1 root root   95237 Feb 18 16:23 logrotate.mod
-rw-r--r--. 1 root root   12767 Feb 18 16:23 logrotate.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 logrotate.mod.role
-rw-r--r--. 1 root root  129325 Feb 18 16:23 logrotate.tmp
-rw-r--r--. 1 root root   85361 Feb 18 16:23 logwatch.mod
-rw-r--r--. 1 root root   12879 Feb 18 16:23 logwatch.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 logwatch.mod.role
-rw-r--r--. 1 root root  119336 Feb 18 16:23 logwatch.tmp
-rw-r--r--. 1 root root  135283 Feb 18 16:23 lpd.mod
-rw-r--r--. 1 root root   13783 Feb 18 16:23 lpd.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 lpd.mod.role
-rw-r--r--. 1 root root  234488 Feb 18 16:23 lpd.tmp
-rw-r--r--. 1 root root  113181 Feb 18 16:23 lvm.mod
-rw-r--r--. 1 root root   16106 Feb 18 16:23 lvm.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 lvm.mod.role
-rw-r--r--. 1 root root  175115 Feb 18 16:23 lvm.tmp
-rw-r--r--. 1 root root  185194 Feb 18 16:23 mailman.mod
-rw-r--r--. 1 root root   12991 Feb 18 16:23 mailman.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 mailman.mod.role
-rw-r--r--. 1 root root  355663 Feb 18 16:23 mailman.tmp
-rw-r--r--. 1 root root   39122 Feb 18 16:23 memcached.mod
-rw-r--r--. 1 root root   12762 Feb 18 16:23 memcached.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 memcached.mod.role
-rw-r--r--. 1 root root   55332 Feb 18 16:23 memcached.tmp
-rw-r--r--. 1 root root   73495 Feb 18 16:23 milter.mod
-rw-r--r--. 1 root root   12920 Feb 18 16:23 milter.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 milter.mod.role
-rw-r--r--. 1 root root  107094 Feb 18 16:23 milter.tmp
-rw-r--r--. 1 root root   17772 Feb 18 16:23 miscfiles.mod
-rw-r--r--. 1 root root   14055 Feb 18 16:23 miscfiles.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:23 miscfiles.mod.role
-rw-r--r--. 1 root root   21748 Feb 18 16:23 miscfiles.tmp
-rw-r--r--. 1 root root  101733 Feb 18 16:23 modutils.mod
-rw-r--r--. 1 root root   13354 Feb 18 16:23 modutils.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 modutils.mod.role
-rw-r--r--. 1 root root  141989 Feb 18 16:23 modutils.tmp
-rw-r--r--. 1 root root   55874 Feb 18 16:23 mono.mod
-rw-r--r--. 1 root root   12611 Feb 18 16:23 mono.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 mono.mod.role
-rw-r--r--. 1 root root   43292 Feb 18 16:23 mono.tmp
-rw-r--r--. 1 root root   50732 Feb 18 16:23 monop.mod
-rw-r--r--. 1 root root   12732 Feb 18 16:23 monop.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 monop.mod.role
-rw-r--r--. 1 root root   71416 Feb 18 16:23 monop.tmp
-rw-r--r--. 1 root root  108240 Feb 18 16:23 mount.mod
-rw-r--r--. 1 root root   12719 Feb 18 16:23 mount.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 mount.mod.role
-rw-r--r--. 1 root root  162223 Feb 18 16:23 mount.tmp
-rw-r--r--. 1 root root   94766 Feb 18 16:23 mozilla.mod
-rw-r--r--. 1 root root   13843 Feb 18 16:23 mozilla.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 mozilla.mod.role
-rw-r--r--. 1 root root  146417 Feb 18 16:23 mozilla.tmp
-rw-r--r--. 1 root root   83812 Feb 18 16:23 mplayer.mod
-rw-r--r--. 1 root root   12864 Feb 18 16:23 mplayer.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 mplayer.mod.role
-rw-r--r--. 1 root root  139622 Feb 18 16:23 mplayer.tmp
-rw-r--r--. 1 root root   80997 Feb 18 16:23 mrtg.mod
-rw-r--r--. 1 root root   12951 Feb 18 16:23 mrtg.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 mrtg.mod.role
-rw-r--r--. 1 root root  117701 Feb 18 16:23 mrtg.tmp
-rw-r--r--. 1 root root  154774 Feb 18 16:23 mta.mod
-rw-r--r--. 1 root root   13515 Feb 18 16:23 mta.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 mta.mod.role
-rw-r--r--. 1 root root  235058 Feb 18 16:23 mta.tmp
-rw-r--r--. 1 root root   60122 Feb 18 16:23 munin.mod
-rw-r--r--. 1 root root   13066 Feb 18 16:23 munin.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 munin.mod.role
-rw-r--r--. 1 root root   81590 Feb 18 16:23 munin.tmp
-rw-r--r--. 1 root root   73885 Feb 18 16:23 mysql.mod
-rw-r--r--. 1 root root   13132 Feb 18 16:23 mysql.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 mysql.mod.role
-rw-r--r--. 1 root root  113056 Feb 18 16:23 mysql.tmp
-rw-r--r--. 1 root root  124313 Feb 18 16:23 nagios.mod
-rw-r--r--. 1 root root   13029 Feb 18 16:23 nagios.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 nagios.mod.role
-rw-r--r--. 1 root root  163797 Feb 18 16:23 nagios.tmp
-rw-r--r--. 1 root root   54929 Feb 18 16:23 nessus.mod
-rw-r--r--. 1 root root   12861 Feb 18 16:23 nessus.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 nessus.mod.role
-rw-r--r--. 1 root root   81389 Feb 18 16:23 nessus.tmp
-rw-r--r--. 1 root root   27325 Feb 18 16:23 netlabel.mod
-rw-r--r--. 1 root root   12624 Feb 18 16:23 netlabel.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 netlabel.mod.role
-rw-r--r--. 1 root root   28187 Feb 18 16:23 netlabel.tmp
-rw-r--r--. 1 root root  144415 Feb 18 16:23 netutils.mod
-rw-r--r--. 1 root root   13116 Feb 18 16:23 netutils.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:23 netutils.mod.role
-rw-r--r--. 1 root root  278916 Feb 18 16:23 netutils.tmp
-rw-r--r--. 1 root root  101945 Feb 18 16:23 networkmanager.mod
-rw-r--r--. 1 root root   13190 Feb 18 16:23 networkmanager.mod.fc
-rw-r--r--. 1 root root     236 Feb 18 16:23 networkmanager.mod.role
-rw-r--r--. 1 root root  144201 Feb 18 16:23 networkmanager.tmp
-rw-r--r--. 1 root root  121704 Feb 18 16:23 nis.mod
-rw-r--r--. 1 root root   12937 Feb 18 16:23 nis.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 nis.mod.role
-rw-r--r--. 1 root root  185190 Feb 18 16:23 nis.tmp
-rw-r--r--. 1 root root   72043 Feb 18 16:23 nscd.mod
-rw-r--r--. 1 root root   12892 Feb 18 16:23 nscd.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 nscd.mod.role
-rw-r--r--. 1 root root  110418 Feb 18 16:23 nscd.tmp
-rw-r--r--. 1 root root   82086 Feb 18 16:23 nsd.mod
-rw-r--r--. 1 root root   13128 Feb 18 16:23 nsd.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 nsd.mod.role
-rw-r--r--. 1 root root  124682 Feb 18 16:23 nsd.tmp
-rw-r--r--. 1 root root   53637 Feb 18 16:23 ntop.mod
-rw-r--r--. 1 root root   12835 Feb 18 16:23 ntop.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:23 ntop.mod.role
-rw-r--r--. 1 root root   64795 Feb 18 16:23 ntop.tmp
-rw-r--r--. 1 root root   88632 Feb 18 16:23 ntp.mod
-rw-r--r--. 1 root root   13404 Feb 18 16:23 ntp.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 ntp.mod.role
-rw-r--r--. 1 root root  124955 Feb 18 16:23 ntp.tmp
-rw-r--r--. 1 root root   79997 Feb 18 16:23 nx.mod
-rw-r--r--. 1 root root   12816 Feb 18 16:23 nx.mod.fc
-rw-r--r--. 1 root root     200 Feb 18 16:23 nx.mod.role
-rw-r--r--. 1 root root  136934 Feb 18 16:23 nx.tmp
-rw-r--r--. 1 root root   64610 Feb 18 16:23 oav.mod
-rw-r--r--. 1 root root   13040 Feb 18 16:23 oav.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:23 oav.mod.role
-rw-r--r--. 1 root root   87969 Feb 18 16:23 oav.tmp
-rw-r--r--. 1 root root   70078 Feb 18 16:23 oddjob.mod
-rw-r--r--. 1 root root   12750 Feb 18 16:23 oddjob.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 oddjob.mod.role
-rw-r--r--. 1 root root   71445 Feb 18 16:23 oddjob.tmp
-rw-r--r--. 1 root root   48221 Feb 18 16:23 oident.mod
-rw-r--r--. 1 root root   12872 Feb 18 16:23 oident.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 oident.mod.role
-rw-r--r--. 1 root root   70050 Feb 18 16:23 oident.tmp
-rw-r--r--. 1 root root  297486 Feb 18 16:22 only_te_rules.conf
-rw-r--r--. 1 root root   29801 Feb 18 16:23 openca.mod
-rw-r--r--. 1 root root   13009 Feb 18 16:23 openca.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 openca.mod.role
-rw-r--r--. 1 root root   33051 Feb 18 16:23 openca.tmp
-rw-r--r--. 1 root root   41753 Feb 18 16:23 openct.mod
-rw-r--r--. 1 root root   12762 Feb 18 16:23 openct.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 openct.mod.role
-rw-r--r--. 1 root root   43694 Feb 18 16:23 openct.tmp
-rw-r--r--. 1 root root   57533 Feb 18 16:23 openvpn.mod
-rw-r--r--. 1 root root   12891 Feb 18 16:23 openvpn.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:23 openvpn.mod.role
-rw-r--r--. 1 root root   83631 Feb 18 16:23 openvpn.tmp
-rw-r--r--. 1 root root   65935 Feb 18 16:23 pcmcia.mod
-rw-r--r--. 1 root root   12905 Feb 18 16:23 pcmcia.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:23 pcmcia.mod.role
-rw-r--r--. 1 root root   82957 Feb 18 16:23 pcmcia.tmp
-rw-r--r--. 1 root root   52202 Feb 18 16:23 pcscd.mod
-rw-r--r--. 1 root root   12788 Feb 18 16:23 pcscd.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:23 pcscd.mod.role
-rw-r--r--. 1 root root   61132 Feb 18 16:23 pcscd.tmp
-rw-r--r--. 1 root root  103558 Feb 18 16:24 pegasus.mod
-rw-r--r--. 1 root root   13031 Feb 18 16:24 pegasus.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 pegasus.mod.role
-rw-r--r--. 1 root root  178033 Feb 18 16:24 pegasus.tmp
-rw-r--r--. 1 root root   43500 Feb 18 16:24 perdition.mod
-rw-r--r--. 1 root root   12679 Feb 18 16:24 perdition.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:24 perdition.mod.role
-rw-r--r--. 1 root root   53045 Feb 18 16:24 perdition.tmp
-rw-r--r--. 1 root root   30856 Feb 18 16:24 podsleuth.mod
-rw-r--r--. 1 root root   12622 Feb 18 16:24 podsleuth.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:24 podsleuth.mod.role
-rw-r--r--. 1 root root   33002 Feb 18 16:24 podsleuth.tmp
-rw-r--r--. 1 root root  134476 Feb 18 16:24 portage.mod
-rw-r--r--. 1 root root   13788 Feb 18 16:24 portage.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 portage.mod.role
-rw-r--r--. 1 root root  228729 Feb 18 16:24 portage.tmp
-rw-r--r--. 1 root root   77262 Feb 18 16:24 portmap.mod
-rw-r--r--. 1 root root   12816 Feb 18 16:24 portmap.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 portmap.mod.role
-rw-r--r--. 1 root root  132971 Feb 18 16:24 portmap.tmp
-rw-r--r--. 1 root root  102964 Feb 18 16:24 portslave.mod
-rw-r--r--. 1 root root   12740 Feb 18 16:24 portslave.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:24 portslave.mod.role
-rw-r--r--. 1 root root  161989 Feb 18 16:24 portslave.tmp
-rw-r--r--. 1 root root   28769 Feb 18 16:22 post_te_files.conf
-rw-r--r--. 1 root root  699323 Feb 18 16:24 postfix.mod
-rw-r--r--. 1 root root   14823 Feb 18 16:24 postfix.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 postfix.mod.role
-rw-r--r--. 1 root root 1298407 Feb 18 16:24 postfix.tmp
-rw-r--r--. 1 root root   40515 Feb 18 16:24 postfixpolicyd.mod
-rw-r--r--. 1 root root   12847 Feb 18 16:24 postfixpolicyd.mod.fc
-rw-r--r--. 1 root root     236 Feb 18 16:24 postfixpolicyd.mod.role
-rw-r--r--. 1 root root   56950 Feb 18 16:24 postfixpolicyd.tmp
-rw-r--r--. 1 root root  116403 Feb 18 16:24 postgresql.mod
-rw-r--r--. 1 root root   13661 Feb 18 16:24 postgresql.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 postgresql.mod.role
-rw-r--r--. 1 root root  174621 Feb 18 16:24 postgresql.tmp
-rw-r--r--. 1 root root   57413 Feb 18 16:24 postgrey.mod
-rw-r--r--. 1 root root   13007 Feb 18 16:24 postgrey.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 postgrey.mod.role
-rw-r--r--. 1 root root   79135 Feb 18 16:24 postgrey.tmp
-rw-r--r--. 1 root root  125595 Feb 18 16:24 ppp.mod
-rw-r--r--. 1 root root   13639 Feb 18 16:24 ppp.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 ppp.mod.role
-rw-r--r--. 1 root root  179605 Feb 18 16:24 ppp.tmp
-rw-r--r--. 1 root root   17768 Feb 18 16:22 pre_te_files.conf
-rw-r--r--. 1 root root   42438 Feb 18 16:24 prelink.mod
-rw-r--r--. 1 root root   12802 Feb 18 16:24 prelink.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 prelink.mod.role
-rw-r--r--. 1 root root   52339 Feb 18 16:24 prelink.tmp
-rw-r--r--. 1 root root  142024 Feb 18 16:24 prelude.mod
-rw-r--r--. 1 root root   13034 Feb 18 16:24 prelude.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 prelude.mod.role
-rw-r--r--. 1 root root  230508 Feb 18 16:24 prelude.tmp
-rw-r--r--. 1 root root   59336 Feb 18 16:24 privoxy.mod
-rw-r--r--. 1 root root   12878 Feb 18 16:24 privoxy.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 privoxy.mod.role
-rw-r--r--. 1 root root   91898 Feb 18 16:24 privoxy.tmp
-rw-r--r--. 1 root root   82396 Feb 18 16:24 procmail.mod
-rw-r--r--. 1 root root   12741 Feb 18 16:24 procmail.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 procmail.mod.role
-rw-r--r--. 1 root root  128453 Feb 18 16:24 procmail.tmp
-rw-r--r--. 1 root root   41501 Feb 18 16:24 publicfile.mod
-rw-r--r--. 1 root root   12827 Feb 18 16:24 publicfile.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 publicfile.mod.role
-rw-r--r--. 1 root root   36291 Feb 18 16:24 publicfile.tmp
-rw-r--r--. 1 root root   41130 Feb 18 16:24 pxe.mod
-rw-r--r--. 1 root root   12716 Feb 18 16:24 pxe.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 pxe.mod.role
-rw-r--r--. 1 root root   43098 Feb 18 16:24 pxe.tmp
-rw-r--r--. 1 root root  103256 Feb 18 16:24 pyzor.mod
-rw-r--r--. 1 root root   12884 Feb 18 16:24 pyzor.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 pyzor.mod.role
-rw-r--r--. 1 root root  172176 Feb 18 16:24 pyzor.tmp
-rw-r--r--. 1 root root   80956 Feb 18 16:24 qemu.mod
-rw-r--r--. 1 root root   12662 Feb 18 16:24 qemu.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 qemu.mod.role
-rw-r--r--. 1 root root   87312 Feb 18 16:24 qemu.tmp
-rw-r--r--. 1 root root  251075 Feb 18 16:24 qmail.mod
-rw-r--r--. 1 root root   13675 Feb 18 16:24 qmail.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 qmail.mod.role
-rw-r--r--. 1 root root  311441 Feb 18 16:24 qmail.tmp
-rw-r--r--. 1 root root   42779 Feb 18 16:24 quota.mod
-rw-r--r--. 1 root root   13099 Feb 18 16:24 quota.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 quota.mod.role
-rw-r--r--. 1 root root   50753 Feb 18 16:24 quota.tmp
-rw-r--r--. 1 root root  108500 Feb 18 16:24 radius.mod
-rw-r--r--. 1 root root   13607 Feb 18 16:24 radius.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 radius.mod.role
-rw-r--r--. 1 root root  186479 Feb 18 16:24 radius.tmp
-rw-r--r--. 1 root root   52895 Feb 18 16:24 radvd.mod
-rw-r--r--. 1 root root   12846 Feb 18 16:24 radvd.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 radvd.mod.role
-rw-r--r--. 1 root root   74920 Feb 18 16:24 radvd.tmp
-rw-r--r--. 1 root root   69534 Feb 18 16:24 raid.mod
-rw-r--r--. 1 root root   12716 Feb 18 16:24 raid.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 raid.mod.role
-rw-r--r--. 1 root root   67391 Feb 18 16:24 raid.tmp
-rw-r--r--. 1 root root   95284 Feb 18 16:24 razor.mod
-rw-r--r--. 1 root root   12836 Feb 18 16:24 razor.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 razor.mod.role
-rw-r--r--. 1 root root  174533 Feb 18 16:24 razor.tmp
-rw-r--r--. 1 root root   41724 Feb 18 16:24 rdisc.mod
-rw-r--r--. 1 root root   12611 Feb 18 16:24 rdisc.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 rdisc.mod.role
-rw-r--r--. 1 root root   47274 Feb 18 16:24 rdisc.tmp
-rw-r--r--. 1 root root   53442 Feb 18 16:24 readahead.mod
-rw-r--r--. 1 root root   12684 Feb 18 16:24 readahead.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:24 readahead.mod.role
-rw-r--r--. 1 root root   63235 Feb 18 16:24 readahead.tmp
-rw-r--r--. 1 root root  138555 Feb 18 16:24 remotelogin.mod
-rw-r--r--. 1 root root   12612 Feb 18 16:24 remotelogin.mod.fc
-rw-r--r--. 1 root root     227 Feb 18 16:24 remotelogin.mod.role
-rw-r--r--. 1 root root  247044 Feb 18 16:24 remotelogin.tmp
-rw-r--r--. 1 root root   42919 Feb 18 16:24 resmgr.mod
-rw-r--r--. 1 root root   12795 Feb 18 16:24 resmgr.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 resmgr.mod.role
-rw-r--r--. 1 root root   46890 Feb 18 16:24 resmgr.tmp
-rw-r--r--. 1 root root   67719 Feb 18 16:24 rhgb.mod
-rw-r--r--. 1 root root   12623 Feb 18 16:24 rhgb.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 rhgb.mod.role
-rw-r--r--. 1 root root   99132 Feb 18 16:24 rhgb.tmp
-rw-r--r--. 1 root root  265521 Feb 18 16:24 ricci.mod
-rw-r--r--. 1 root root   13377 Feb 18 16:24 ricci.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 ricci.mod.role
-rw-r--r--. 1 root root  339210 Feb 18 16:24 ricci.tmp
-rw-r--r--. 1 root root  100393 Feb 18 16:24 rlogin.mod
-rw-r--r--. 1 root root   12751 Feb 18 16:24 rlogin.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 rlogin.mod.role
-rw-r--r--. 1 root root  179486 Feb 18 16:24 rlogin.tmp
-rw-r--r--. 1 root root       1 Feb 18 16:22 rolemap.conf
-rw-r--r--. 1 root root    5720 Feb 18 16:22 roles.xml
-rw-r--r--. 1 root root   49856 Feb 18 16:24 roundup.mod
-rw-r--r--. 1 root root   12781 Feb 18 16:24 roundup.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 roundup.mod.role
-rw-r--r--. 1 root root   62968 Feb 18 16:24 roundup.tmp
-rw-r--r--. 1 root root  209133 Feb 18 16:24 rpc.mod
-rw-r--r--. 1 root root   13200 Feb 18 16:24 rpc.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 rpc.mod.role
-rw-r--r--. 1 root root  375496 Feb 18 16:24 rpc.tmp
-rw-r--r--. 1 root root   44352 Feb 18 16:24 rpcbind.mod
-rw-r--r--. 1 root root   12935 Feb 18 16:24 rpcbind.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 rpcbind.mod.role
-rw-r--r--. 1 root root   62923 Feb 18 16:24 rpcbind.tmp
-rw-r--r--. 1 root root  195270 Feb 18 16:24 rpm.mod
-rw-r--r--. 1 root root   13539 Feb 18 16:24 rpm.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 rpm.mod.role
-rw-r--r--. 1 root root  295553 Feb 18 16:24 rpm.tmp
-rw-r--r--. 1 root root  120116 Feb 18 16:24 rshd.mod
-rw-r--r--. 1 root root   12729 Feb 18 16:24 rshd.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 rshd.mod.role
-rw-r--r--. 1 root root  212054 Feb 18 16:24 rshd.tmp
-rw-r--r--. 1 root root   44117 Feb 18 16:24 rssh.mod
-rw-r--r--. 1 root root   12611 Feb 18 16:24 rssh.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 rssh.mod.role
-rw-r--r--. 1 root root   61210 Feb 18 16:24 rssh.tmp
-rw-r--r--. 1 root root   87484 Feb 18 16:24 rsync.mod
-rw-r--r--. 1 root root   12739 Feb 18 16:24 rsync.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 rsync.mod.role
-rw-r--r--. 1 root root  130269 Feb 18 16:24 rsync.tmp
-rw-r--r--. 1 root root   40983 Feb 18 16:24 rwho.mod
-rw-r--r--. 1 root root   12787 Feb 18 16:24 rwho.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 rwho.mod.role
-rw-r--r--. 1 root root   56698 Feb 18 16:24 rwho.tmp
-rw-r--r--. 1 root root  486536 Feb 18 16:24 samba.mod
-rw-r--r--. 1 root root   14481 Feb 18 16:24 samba.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 samba.mod.role
-rw-r--r--. 1 root root  939626 Feb 18 16:24 samba.tmp
-rw-r--r--. 1 root root  104063 Feb 18 16:24 sasl.mod
-rw-r--r--. 1 root root   12778 Feb 18 16:24 sasl.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 sasl.mod.role
-rw-r--r--. 1 root root  185710 Feb 18 16:24 sasl.tmp
-rw-r--r--. 1 root root   19321 Feb 18 16:24 screen.mod
-rw-r--r--. 1 root root   12808 Feb 18 16:24 screen.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 screen.mod.role
-rw-r--r--. 1 root root   23483 Feb 18 16:24 screen.tmp
-rw-r--r--. 1 root root  746094 Feb 18 16:24 secadm.mod
-rw-r--r--. 1 root root   12620 Feb 18 16:24 secadm.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 secadm.mod.role
-rw-r--r--. 1 root root 1147777 Feb 18 16:24 secadm.tmp
-rw-r--r--. 1 root root  302241 Feb 18 16:24 selinuxutil.mod
-rw-r--r--. 1 root root   14323 Feb 18 16:24 selinuxutil.mod.fc
-rw-r--r--. 1 root root     227 Feb 18 16:24 selinuxutil.mod.role
-rw-r--r--. 1 root root  581292 Feb 18 16:24 selinuxutil.tmp
-rw-r--r--. 1 root root   84107 Feb 18 16:24 sendmail.mod
-rw-r--r--. 1 root root   12809 Feb 18 16:24 sendmail.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 sendmail.mod.role
-rw-r--r--. 1 root root  122738 Feb 18 16:24 sendmail.tmp
-rw-r--r--. 1 root root  200407 Feb 18 16:22 services.xml
-rw-r--r--. 1 root root   41358 Feb 18 16:24 setrans.mod
-rw-r--r--. 1 root root   12750 Feb 18 16:24 setrans.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 setrans.mod.role
-rw-r--r--. 1 root root   49506 Feb 18 16:24 setrans.tmp
-rw-r--r--. 1 root root   81352 Feb 18 16:24 setroubleshoot.mod
-rw-r--r--. 1 root root   12859 Feb 18 16:24 setroubleshoot.mod.fc
-rw-r--r--. 1 root root     236 Feb 18 16:24 setroubleshoot.mod.role
-rw-r--r--. 1 root root  123527 Feb 18 16:24 setroubleshoot.tmp
-rw-r--r--. 1 root root      47 Feb 18 16:22 seusers
-rw-r--r--. 1 root root   57182 Feb 18 16:24 slocate.mod
-rw-r--r--. 1 root root   12680 Feb 18 16:24 slocate.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 slocate.mod.role
-rw-r--r--. 1 root root   84013 Feb 18 16:24 slocate.tmp
-rw-r--r--. 1 root root   44559 Feb 18 16:24 slrnpull.mod
-rw-r--r--. 1 root root   12704 Feb 18 16:24 slrnpull.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 slrnpull.mod.role
-rw-r--r--. 1 root root   46927 Feb 18 16:24 slrnpull.tmp
-rw-r--r--. 1 root root   56033 Feb 18 16:24 smartmon.mod
-rw-r--r--. 1 root root   12774 Feb 18 16:24 smartmon.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 smartmon.mod.role
-rw-r--r--. 1 root root   75073 Feb 18 16:24 smartmon.tmp
-rw-r--r--. 1 root root   95481 Feb 18 16:24 snmp.mod
-rw-r--r--. 1 root root   13236 Feb 18 16:24 snmp.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 snmp.mod.role
-rw-r--r--. 1 root root  132139 Feb 18 16:24 snmp.tmp
-rw-r--r--. 1 root root   48070 Feb 18 16:24 snort.mod
-rw-r--r--. 1 root root   12895 Feb 18 16:24 snort.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 snort.mod.role
-rw-r--r--. 1 root root   63149 Feb 18 16:24 snort.tmp
-rw-r--r--. 1 root root   51542 Feb 18 16:24 soundserver.mod
-rw-r--r--. 1 root root   13068 Feb 18 16:24 soundserver.mod.fc
-rw-r--r--. 1 root root     227 Feb 18 16:24 soundserver.mod.role
-rw-r--r--. 1 root root   64664 Feb 18 16:24 soundserver.tmp
-rw-r--r--. 1 root root  158323 Feb 18 16:24 spamassassin.mod
-rw-r--r--. 1 root root   13145 Feb 18 16:24 spamassassin.mod.fc
-rw-r--r--. 1 root root     230 Feb 18 16:24 spamassassin.mod.role
-rw-r--r--. 1 root root  273810 Feb 18 16:24 spamassassin.tmp
-rw-r--r--. 1 root root   42051 Feb 18 16:24 speedtouch.mod
-rw-r--r--. 1 root root   12623 Feb 18 16:24 speedtouch.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 speedtouch.mod.role
-rw-r--r--. 1 root root   45639 Feb 18 16:24 speedtouch.tmp
-rw-r--r--. 1 root root  167392 Feb 18 16:24 squid.mod
-rw-r--r--. 1 root root   13162 Feb 18 16:24 squid.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 squid.mod.role
-rw-r--r--. 1 root root  313205 Feb 18 16:24 squid.tmp
-rw-r--r--. 1 root root  266734 Feb 18 16:24 ssh.mod
-rw-r--r--. 1 root root   13192 Feb 18 16:24 ssh.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 ssh.mod.role
-rw-r--r--. 1 root root  418451 Feb 18 16:24 ssh.tmp
-rw-r--r--. 1 root root  707946 Feb 18 16:24 staff.mod
-rw-r--r--. 1 root root   12620 Feb 18 16:24 staff.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 staff.mod.role
-rw-r--r--. 1 root root 1085118 Feb 18 16:24 staff.tmp
-rw-r--r--. 1 root root   18252 Feb 18 16:24 storage.mod
-rw-r--r--. 1 root root   15916 Feb 18 16:24 storage.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 storage.mod.role
-rw-r--r--. 1 root root   19487 Feb 18 16:24 storage.tmp
-rw-r--r--. 1 root root   72742 Feb 18 16:24 stunnel.mod
-rw-r--r--. 1 root root   12742 Feb 18 16:24 stunnel.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 stunnel.mod.role
-rw-r--r--. 1 root root  113812 Feb 18 16:24 stunnel.tmp
-rw-r--r--. 1 root root   17093 Feb 18 16:24 su.mod
-rw-r--r--. 1 root root   12707 Feb 18 16:24 su.mod.fc
-rw-r--r--. 1 root root     200 Feb 18 16:24 su.mod.role
-rw-r--r--. 1 root root   17103 Feb 18 16:24 su.tmp
-rw-r--r--. 1 root root   17125 Feb 18 16:24 sudo.mod
-rw-r--r--. 1 root root   12619 Feb 18 16:24 sudo.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 sudo.mod.role
-rw-r--r--. 1 root root   17479 Feb 18 16:24 sudo.tmp
-rw-r--r--. 1 root root   46925 Feb 18 16:24 sxid.mod
-rw-r--r--. 1 root root   12834 Feb 18 16:24 sxid.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 sxid.mod.role
-rw-r--r--. 1 root root   59002 Feb 18 16:24 sxid.tmp
-rw-r--r--. 1 root root  944361 Feb 18 16:24 sysadm.mod
-rw-r--r--. 1 root root   12620 Feb 18 16:24 sysadm.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 sysadm.mod.role
-rw-r--r--. 1 root root 1381603 Feb 18 16:24 sysadm.tmp
-rw-r--r--. 1 root root  130830 Feb 18 16:24 sysnetwork.mod
-rw-r--r--. 1 root root   14079 Feb 18 16:24 sysnetwork.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 sysnetwork.mod.role
-rw-r--r--. 1 root root  176323 Feb 18 16:24 sysnetwork.tmp
-rw-r--r--. 1 root root   41790 Feb 18 16:24 sysstat.mod
-rw-r--r--. 1 root root   12915 Feb 18 16:24 sysstat.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 sysstat.mod.role
-rw-r--r--. 1 root root   46358 Feb 18 16:24 sysstat.tmp
-rw-r--r--. 1 root root  140978 Feb 18 16:22 system.xml
-rw-r--r--. 1 root root   40137 Feb 18 16:24 tcpd.mod
-rw-r--r--. 1 root root   12614 Feb 18 16:24 tcpd.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 tcpd.mod.role
-rw-r--r--. 1 root root   57481 Feb 18 16:24 tcpd.tmp
-rw-r--r--. 1 root root   73933 Feb 18 16:24 telnet.mod
-rw-r--r--. 1 root root   12689 Feb 18 16:24 telnet.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 telnet.mod.role
-rw-r--r--. 1 root root  119868 Feb 18 16:24 telnet.tmp
-rw-r--r--. 1 root root   77514 Feb 18 16:24 tftp.mod
-rw-r--r--. 1 root root   12810 Feb 18 16:24 tftp.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 tftp.mod.role
-rw-r--r--. 1 root root  108226 Feb 18 16:24 tftp.tmp
-rw-r--r--. 1 root root  100738 Feb 18 16:24 thunderbird.mod
-rw-r--r--. 1 root root   12709 Feb 18 16:24 thunderbird.mod.fc
-rw-r--r--. 1 root root     227 Feb 18 16:24 thunderbird.mod.role
-rw-r--r--. 1 root root  174027 Feb 18 16:24 thunderbird.tmp
-rw-r--r--. 1 root root   51261 Feb 18 16:24 timidity.mod
-rw-r--r--. 1 root root   12620 Feb 18 16:24 timidity.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 timidity.mod.role
-rw-r--r--. 1 root root   59342 Feb 18 16:24 timidity.tmp
-rw-r--r--. 1 root root   35058 Feb 18 16:24 tmpreaper.mod
-rw-r--r--. 1 root root   12681 Feb 18 16:24 tmpreaper.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:24 tmpreaper.mod.role
-rw-r--r--. 1 root root   37993 Feb 18 16:24 tmpreaper.tmp
-rw-r--r--. 1 root root   64182 Feb 18 16:24 tor.mod
-rw-r--r--. 1 root root   12922 Feb 18 16:24 tor.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 tor.mod.role
-rw-r--r--. 1 root root   96881 Feb 18 16:24 tor.tmp
-rw-r--r--. 1 root root   42481 Feb 18 16:24 transproxy.mod
-rw-r--r--. 1 root root   12684 Feb 18 16:24 transproxy.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 transproxy.mod.role
-rw-r--r--. 1 root root   49026 Feb 18 16:24 transproxy.tmp
-rw-r--r--. 1 root root   76795 Feb 18 16:24 tripwire.mod
-rw-r--r--. 1 root root   12973 Feb 18 16:24 tripwire.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 tripwire.mod.role
-rw-r--r--. 1 root root   95150 Feb 18 16:24 tripwire.tmp
-rw-r--r--. 1 root root   49828 Feb 18 16:24 tvtime.mod
-rw-r--r--. 1 root root   12628 Feb 18 16:24 tvtime.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 tvtime.mod.role
-rw-r--r--. 1 root root   67326 Feb 18 16:24 tvtime.tmp
-rw-r--r--. 1 root root   42955 Feb 18 16:24 tzdata.mod
-rw-r--r--. 1 root root   12623 Feb 18 16:24 tzdata.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 tzdata.mod.role
-rw-r--r--. 1 root root   43969 Feb 18 16:24 tzdata.tmp
-rw-r--r--. 1 root root   55507 Feb 18 16:24 ucspitcp.mod
-rw-r--r--. 1 root root   12676 Feb 18 16:24 ucspitcp.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 ucspitcp.mod.role
-rw-r--r--. 1 root root   72964 Feb 18 16:24 ucspitcp.tmp
-rw-r--r--. 1 root root  119184 Feb 18 16:24 udev.mod
-rw-r--r--. 1 root root   13287 Feb 18 16:24 udev.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 udev.mod.role
-rw-r--r--. 1 root root  161990 Feb 18 16:24 udev.tmp
-rw-r--r--. 1 root root   71806 Feb 18 16:24 uml.mod
-rw-r--r--. 1 root root   12780 Feb 18 16:24 uml.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 uml.mod.role
-rw-r--r--. 1 root root  105266 Feb 18 16:24 uml.tmp
-rw-r--r--. 1 root root  229165 Feb 18 16:24 unconfined.mod
-rw-r--r--. 1 root root   13259 Feb 18 16:24 unconfined.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 unconfined.mod.role
-rw-r--r--. 1 root root  225803 Feb 18 16:24 unconfined.tmp
-rw-r--r--. 1 root root  702624 Feb 18 16:24 unprivuser.mod
-rw-r--r--. 1 root root   12620 Feb 18 16:24 unprivuser.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 unprivuser.mod.role
-rw-r--r--. 1 root root 1075113 Feb 18 16:24 unprivuser.tmp
-rw-r--r--. 1 root root   62081 Feb 18 16:24 updfstab.mod
-rw-r--r--. 1 root root   12679 Feb 18 16:24 updfstab.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 updfstab.mod.role
-rw-r--r--. 1 root root   71657 Feb 18 16:24 updfstab.tmp
-rw-r--r--. 1 root root   45055 Feb 18 16:24 uptime.mod
-rw-r--r--. 1 root root   12741 Feb 18 16:24 uptime.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 uptime.mod.role
-rw-r--r--. 1 root root   45765 Feb 18 16:24 uptime.tmp
-rw-r--r--. 1 root root   35645 Feb 18 16:24 usbmodules.mod
-rw-r--r--. 1 root root   12705 Feb 18 16:24 usbmodules.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 usbmodules.mod.role
-rw-r--r--. 1 root root   38208 Feb 18 16:24 usbmodules.tmp
-rw-r--r--. 1 root root   23011 Feb 18 16:24 userdomain.mod
-rw-r--r--. 1 root root   12703 Feb 18 16:24 userdomain.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 userdomain.mod.role
-rw-r--r--. 1 root root   34868 Feb 18 16:24 userdomain.tmp
-rw-r--r--. 1 root root   17303 Feb 18 16:24 userhelper.mod
-rw-r--r--. 1 root root   12719 Feb 18 16:24 userhelper.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 userhelper.mod.role
-rw-r--r--. 1 root root   18094 Feb 18 16:24 userhelper.tmp
-rw-r--r--. 1 root root  281506 Feb 18 16:24 usermanage.mod
-rw-r--r--. 1 root root   13961 Feb 18 16:24 usermanage.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 usermanage.mod.role
-rw-r--r--. 1 root root  523890 Feb 18 16:24 usermanage.tmp
-rw-r--r--. 1 root root   65765 Feb 18 16:24 usernetctl.mod
-rw-r--r--. 1 root root   12625 Feb 18 16:24 usernetctl.mod.fc
-rw-r--r--. 1 root root     224 Feb 18 16:24 usernetctl.mod.role
-rw-r--r--. 1 root root  108071 Feb 18 16:24 usernetctl.tmp
-rw-r--r--. 1 root root     143 Feb 18 16:22 users_extra
-rw-r--r--. 1 root root   87215 Feb 18 16:24 uucp.mod
-rw-r--r--. 1 root root   12832 Feb 18 16:24 uucp.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 uucp.mod.role
-rw-r--r--. 1 root root  133077 Feb 18 16:24 uucp.tmp
-rw-r--r--. 1 root root   84723 Feb 18 16:24 uwimap.mod
-rw-r--r--. 1 root root   12617 Feb 18 16:24 uwimap.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 uwimap.mod.role
-rw-r--r--. 1 root root  126789 Feb 18 16:24 uwimap.tmp
-rw-r--r--. 1 root root   32544 Feb 18 16:24 vbetool.mod
-rw-r--r--. 1 root root   12618 Feb 18 16:24 vbetool.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 vbetool.mod.role
-rw-r--r--. 1 root root   34957 Feb 18 16:24 vbetool.tmp
-rw-r--r--. 1 root root  117834 Feb 18 16:24 virt.mod
-rw-r--r--. 1 root root   13120 Feb 18 16:24 virt.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 virt.mod.role
-rw-r--r--. 1 root root  149003 Feb 18 16:24 virt.tmp
-rw-r--r--. 1 root root   93427 Feb 18 16:24 vmware.mod
-rw-r--r--. 1 root root   14620 Feb 18 16:24 vmware.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 vmware.mod.role
-rw-r--r--. 1 root root  151182 Feb 18 16:24 vmware.tmp
-rw-r--r--. 1 root root   71043 Feb 18 16:24 vpn.mod
-rw-r--r--. 1 root root   12791 Feb 18 16:24 vpn.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 vpn.mod.role
-rw-r--r--. 1 root root  113282 Feb 18 16:24 vpn.tmp
-rw-r--r--. 1 root root   76536 Feb 18 16:24 w3c.mod
-rw-r--r--. 1 root root   12828 Feb 18 16:24 w3c.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 w3c.mod.role
-rw-r--r--. 1 root root  132969 Feb 18 16:24 w3c.tmp
-rw-r--r--. 1 root root   56985 Feb 18 16:24 watchdog.mod
-rw-r--r--. 1 root root   12743 Feb 18 16:24 watchdog.mod.fc
-rw-r--r--. 1 root root     218 Feb 18 16:24 watchdog.mod.role
-rw-r--r--. 1 root root   82062 Feb 18 16:24 watchdog.tmp
-rw-r--r--. 1 root root   55250 Feb 18 16:24 webalizer.mod
-rw-r--r--. 1 root root   12708 Feb 18 16:24 webalizer.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:24 webalizer.mod.role
-rw-r--r--. 1 root root   85220 Feb 18 16:24 webalizer.tmp
-rw-r--r--. 1 root root   48100 Feb 18 16:24 wine.mod
-rw-r--r--. 1 root root   12730 Feb 18 16:24 wine.mod.fc
-rw-r--r--. 1 root root     206 Feb 18 16:24 wine.mod.role
-rw-r--r--. 1 root root   39493 Feb 18 16:24 wine.tmp
-rw-r--r--. 1 root root   52302 Feb 18 16:24 wireshark.mod
-rw-r--r--. 1 root root   12687 Feb 18 16:24 wireshark.mod.fc
-rw-r--r--. 1 root root     221 Feb 18 16:24 wireshark.mod.role
-rw-r--r--. 1 root root   68804 Feb 18 16:24 wireshark.tmp
-rw-r--r--. 1 root root  137458 Feb 18 16:24 xen.mod
-rw-r--r--. 1 root root   13687 Feb 18 16:24 xen.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 xen.mod.role
-rw-r--r--. 1 root root  198872 Feb 18 16:24 xen.tmp
-rw-r--r--. 1 root root   66904 Feb 18 16:24 xfs.mod
-rw-r--r--. 1 root root   12819 Feb 18 16:24 xfs.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 xfs.mod.role
-rw-r--r--. 1 root root   96769 Feb 18 16:24 xfs.tmp
-rw-r--r--. 1 root root   55411 Feb 18 16:24 xprint.mod
-rw-r--r--. 1 root root   12613 Feb 18 16:24 xprint.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 xprint.mod.role
-rw-r--r--. 1 root root   74382 Feb 18 16:24 xprint.tmp
-rw-r--r--. 1 root root  388884 Feb 18 16:24 xserver.mod
-rw-r--r--. 1 root root   15678 Feb 18 16:24 xserver.mod.fc
-rw-r--r--. 1 root root     215 Feb 18 16:24 xserver.mod.role
-rw-r--r--. 1 root root  558332 Feb 18 16:24 xserver.tmp
-rw-r--r--. 1 root root   59392 Feb 18 16:24 yam.mod
-rw-r--r--. 1 root root   12760 Feb 18 16:24 yam.mod.fc
-rw-r--r--. 1 root root     203 Feb 18 16:24 yam.mod.role
-rw-r--r--. 1 root root   87605 Feb 18 16:24 yam.tmp
-rw-r--r--. 1 root root   39473 Feb 18 16:24 zabbix.mod
-rw-r--r--. 1 root root   12805 Feb 18 16:24 zabbix.mod.fc
-rw-r--r--. 1 root root     212 Feb 18 16:24 zabbix.mod.role
-rw-r--r--. 1 root root   40385 Feb 18 16:24 zabbix.tmp
-rw-r--r--. 1 root root   62584 Feb 18 16:24 zebra.mod
-rw-r--r--. 1 root root   13539 Feb 18 16:24 zebra.mod.fc
-rw-r--r--. 1 root root     209 Feb 18 16:24 zebra.mod.role
-rw-r--r--. 1 root root   91783 Feb 18 16:24 zebra.tmp

/etc/selinux/refpolicy-standard/users:
total 8
-rw-r--r--. 1 root root 722 Oct 19 17:09 local.users
-rw-r--r--. 1 root root 355 Oct 19 17:09 system.users

=======================================================================
strace load_policy:
=======================================================================
execve("/usr/sbin/load_policy", ["load_policy"], [/* 53 vars */]) = 0
brk(0)                                  = 0xb77bc000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7797000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=75566, ...}) = 0
mmap2(NULL, 75566, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7784000
close(3)                                = 0
open("/lib/libsepol.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P6\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=239596, ...}) = 0
mmap2(NULL, 243712, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7748000
fadvise64(3, 0, 243712, POSIX_FADV_WILLNEED) = 0
mmap2(0xb7782000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x39) = 0xb7782000
close(3)                                = 0
open("/lib/libselinux.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000J\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=116764, ...}) = 0
mmap2(NULL, 121836, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb772a000
fadvise64(3, 0, 121836, POSIX_FADV_WILLNEED) = 0
mmap2(0xb7746000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b) = 0xb7746000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 l\1\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1430104, ...}) = 0
mmap2(NULL, 1440072, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb75ca000
fadvise64(3, 0, 1440072, POSIX_FADV_WILLNEED) = 0
mprotect(0xb7723000, 4096, PROT_NONE)   = 0
mmap2(0xb7724000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x159) = 0xb7724000
mmap2(0xb7727000, 10568, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7727000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\n\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=14016, ...}) = 0
mmap2(NULL, 16504, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb75c5000
fadvise64(3, 0, 16504, POSIX_FADV_WILLNEED) = 0
mmap2(0xb75c8000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2) = 0xb75c8000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb75c4000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb75c3000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb75c3720, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0xb75c8000, 4096, PROT_READ)   = 0
mprotect(0xb7724000, 8192, PROT_READ)   = 0
mprotect(0xb7746000, 4096, PROT_READ)   = 0
mprotect(0xb7782000, 4096, PROT_READ)   = 0
mprotect(0xb77ba000, 4096, PROT_READ)   = 0
mprotect(0xb77b6000, 4096, PROT_READ)   = 0
munmap(0xb7784000, 75566)               = 0
brk(0)                                  = 0xb77bc000
brk(0xb77dd000)                         = 0xb77dd000
open("/etc/selinux/config", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0600, st_size=50, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7796000
read(3, "SELINUX=permissive\nSELINUXTYPE=r"..., 4096) = 50
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7796000, 4096)                = 0
statfs64("/selinux", 84, {f_type=0xf97cff8c, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) = 0
stat64("/selinux/class", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/selinux/mls", O_RDONLY|O_LARGEFILE) = 3
read(3, "0", 19)                        = 1
close(3)                                = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2512, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7796000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2512
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7796000, 4096)                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_CTYPE", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_CTYPE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=256316, ...}) = 0
mmap2(NULL, 256316, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7584000
close(3)                                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=26048, ...}) = 0
mmap2(NULL, 26048, PROT_READ, MAP_SHARED, 3, 0) = 0xb7790000
close(3)                                = 0
open("/selinux/policyvers", O_RDONLY|O_LARGEFILE) = 3
read(3, "24", 19)                       = 2
close(3)                                = 0
access("/etc/selinux/refpolicy-standard/booleans", F_OK) = 0
uname({sys="Linux", node="linux-f8dr", ...}) = 0
open("/etc/selinux/refpolicy-standard/policy/policy.24", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3687284, ...}) = 0
mmap2(NULL, 3687284, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xb71ff000
brk(0xb77fe000)                         = 0xb77fe000
brk(0xb781f000)                         = 0xb781f000
brk(0xb7840000)                         = 0xb7840000
brk(0xb7861000)                         = 0xb7861000
brk(0xb7882000)                         = 0xb7882000
brk(0xb78a3000)                         = 0xb78a3000
brk(0xb78c4000)                         = 0xb78c4000
brk(0xb78e5000)                         = 0xb78e5000
brk(0xb7906000)                         = 0xb7906000
brk(0xb7927000)                         = 0xb7927000
brk(0xb7948000)                         = 0xb7948000
brk(0xb7969000)                         = 0xb7969000
brk(0xb798a000)                         = 0xb798a000
brk(0xb79ab000)                         = 0xb79ab000
brk(0xb79cc000)                         = 0xb79cc000
brk(0xb79ed000)                         = 0xb79ed000
brk(0xb7a0e000)                         = 0xb7a0e000
brk(0xb7a2f000)                         = 0xb7a2f000
brk(0xb7a50000)                         = 0xb7a50000
brk(0xb7a71000)                         = 0xb7a71000
brk(0xb7a92000)                         = 0xb7a92000
brk(0xb7ab3000)                         = 0xb7ab3000
brk(0xb7ad4000)                         = 0xb7ad4000
brk(0xb7af5000)                         = 0xb7af5000
brk(0xb7b16000)                         = 0xb7b16000
brk(0xb7b37000)                         = 0xb7b37000
brk(0xb7b58000)                         = 0xb7b58000
brk(0xb7b79000)                         = 0xb7b79000
brk(0xb7b9a000)                         = 0xb7b9a000
brk(0xb7bbb000)                         = 0xb7bbb000
brk(0xb7bdc000)                         = 0xb7bdc000
brk(0xb7bfd000)                         = 0xb7bfd000
brk(0xb7c1e000)                         = 0xb7c1e000
brk(0xb7c3f000)                         = 0xb7c3f000
brk(0xb7c60000)                         = 0xb7c60000
brk(0xb7c81000)                         = 0xb7c81000
brk(0xb7ca2000)                         = 0xb7ca2000
brk(0xb7cc3000)                         = 0xb7cc3000
brk(0xb7ce4000)                         = 0xb7ce4000
brk(0xb7d05000)                         = 0xb7d05000
brk(0xb7d26000)                         = 0xb7d26000
brk(0xb7d47000)                         = 0xb7d47000
brk(0xb7d68000)                         = 0xb7d68000
brk(0xb7d89000)                         = 0xb7d89000
brk(0xb7daa000)                         = 0xb7daa000
brk(0xb7dcb000)                         = 0xb7dcb000
brk(0xb7dec000)                         = 0xb7dec000
brk(0xb7e0d000)                         = 0xb7e0d000
brk(0xb7e2e000)                         = 0xb7e2e000
brk(0xb7e4f000)                         = 0xb7e4f000
brk(0xb7e70000)                         = 0xb7e70000
brk(0xb7e91000)                         = 0xb7e91000
brk(0xb7eb2000)                         = 0xb7eb2000
brk(0xb7ed3000)                         = 0xb7ed3000
brk(0xb7ef4000)                         = 0xb7ef4000
brk(0xb7f15000)                         = 0xb7f15000
brk(0xb7f36000)                         = 0xb7f36000
brk(0xb7f57000)                         = 0xb7f57000
brk(0xb7f78000)                         = 0xb7f78000
brk(0xb7f99000)                         = 0xb7f99000
brk(0xb7fba000)                         = 0xb7fba000
brk(0xb7fdb000)                         = 0xb7fdb000
brk(0xb7ffc000)                         = 0xb7ffc000
brk(0xb801d000)                         = 0xb801d000
brk(0xb803e000)                         = 0xb803e000
brk(0xb805f000)                         = 0xb805f000
brk(0xb8080000)                         = 0xb8080000
brk(0xb80a1000)                         = 0xb80a1000
brk(0xb80c2000)                         = 0xb80c2000
brk(0xb80e3000)                         = 0xb80e3000
brk(0xb8104000)                         = 0xb8104000
brk(0xb8125000)                         = 0xb8125000
brk(0xb8146000)                         = 0xb8146000
brk(0xb8167000)                         = 0xb8167000
brk(0xb8188000)                         = 0xb8188000
brk(0xb81a9000)                         = 0xb81a9000
brk(0xb81ca000)                         = 0xb81ca000
brk(0xb81eb000)                         = 0xb81eb000
brk(0xb820c000)                         = 0xb820c000
brk(0xb822d000)                         = 0xb822d000
brk(0xb824e000)                         = 0xb824e000
brk(0xb826f000)                         = 0xb826f000
brk(0xb8290000)                         = 0xb8290000
brk(0xb82b1000)                         = 0xb82b1000
brk(0xb82d2000)                         = 0xb82d2000
brk(0xb82f3000)                         = 0xb82f3000
brk(0xb8314000)                         = 0xb8314000
open("/etc/selinux/refpolicy-standard/users//local.users", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=722, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb778f000
read(4, "################################"..., 4096) = 722
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb778f000, 4096)                = 0
mmap2(NULL, 3690496, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6e7a000
brk(0xb8335000)                         = 0xb8335000
brk(0xb8356000)                         = 0xb8356000
brk(0xb8377000)                         = 0xb8377000
brk(0xb8398000)                         = 0xb8398000
brk(0xb83b9000)                         = 0xb83b9000
brk(0xb83da000)                         = 0xb83da000
brk(0xb83fb000)                         = 0xb83fb000
brk(0xb841c000)                         = 0xb841c000
brk(0xb843d000)                         = 0xb843d000
brk(0xb845e000)                         = 0xb845e000
brk(0xb847f000)                         = 0xb847f000
brk(0xb84a0000)                         = 0xb84a0000
brk(0xb84c1000)                         = 0xb84c1000
brk(0xb84e2000)                         = 0xb84e2000
brk(0xb8503000)                         = 0xb8503000
brk(0xb8524000)                         = 0xb8524000
brk(0xb8545000)                         = 0xb8545000
brk(0xb8566000)                         = 0xb8566000
brk(0xb8587000)                         = 0xb8587000
brk(0xb85a8000)                         = 0xb85a8000
brk(0xb85c9000)                         = 0xb85c9000
brk(0xb85ea000)                         = 0xb85ea000
brk(0xb860b000)                         = 0xb860b000
brk(0xb862c000)                         = 0xb862c000
brk(0xb864d000)                         = 0xb864d000
brk(0xb866e000)                         = 0xb866e000
brk(0xb868f000)                         = 0xb868f000
brk(0xb86b0000)                         = 0xb86b0000
brk(0xb86d1000)                         = 0xb86d1000
brk(0xb86f2000)                         = 0xb86f2000
brk(0xb8713000)                         = 0xb8713000
brk(0xb8734000)                         = 0xb8734000
brk(0xb8755000)                         = 0xb8755000
brk(0xb8776000)                         = 0xb8776000
brk(0xb8797000)                         = 0xb8797000
brk(0xb87b8000)                         = 0xb87b8000
brk(0xb87d9000)                         = 0xb87d9000
brk(0xb87fa000)                         = 0xb87fa000
brk(0xb881b000)                         = 0xb881b000
brk(0xb883c000)                         = 0xb883c000
brk(0xb885d000)                         = 0xb885d000
brk(0xb887e000)                         = 0xb887e000
brk(0xb889f000)                         = 0xb889f000
brk(0xb88c0000)                         = 0xb88c0000
brk(0xb88e1000)                         = 0xb88e1000
brk(0xb8902000)                         = 0xb8902000
brk(0xb8923000)                         = 0xb8923000
brk(0xb8944000)                         = 0xb8944000
brk(0xb8965000)                         = 0xb8965000
brk(0xb8986000)                         = 0xb8986000
brk(0xb89a7000)                         = 0xb89a7000
brk(0xb89c8000)                         = 0xb89c8000
brk(0xb89e9000)                         = 0xb89e9000
brk(0xb8a0a000)                         = 0xb8a0a000
brk(0xb8a2b000)                         = 0xb8a2b000
brk(0xb8a4c000)                         = 0xb8a4c000
brk(0xb8a6d000)                         = 0xb8a6d000
brk(0xb8a8e000)                         = 0xb8a8e000
brk(0xb8aaf000)                         = 0xb8aaf000
brk(0xb8ad0000)                         = 0xb8ad0000
brk(0xb8af1000)                         = 0xb8af1000
brk(0xb8b12000)                         = 0xb8b12000
brk(0xb8b33000)                         = 0xb8b33000
brk(0xb8b54000)                         = 0xb8b54000
brk(0xb8b75000)                         = 0xb8b75000
brk(0xb8b96000)                         = 0xb8b96000
brk(0xb8bb7000)                         = 0xb8bb7000
brk(0xb8bd8000)                         = 0xb8bd8000
brk(0xb8bf9000)                         = 0xb8bf9000
brk(0xb8c1a000)                         = 0xb8c1a000
brk(0xb8c3b000)                         = 0xb8c3b000
brk(0xb8c5c000)                         = 0xb8c5c000
brk(0xb8c7d000)                         = 0xb8c7d000
brk(0xb8c9e000)                         = 0xb8c9e000
brk(0xb8cbf000)                         = 0xb8cbf000
brk(0xb8ce0000)                         = 0xb8ce0000
brk(0xb8d01000)                         = 0xb8d01000
brk(0xb8d22000)                         = 0xb8d22000
brk(0xb8d43000)                         = 0xb8d43000
brk(0xb8d64000)                         = 0xb8d64000
brk(0xb8d85000)                         = 0xb8d85000
brk(0xb8da6000)                         = 0xb8da6000
brk(0xb8dc7000)                         = 0xb8dc7000
brk(0xb8de8000)                         = 0xb8de8000
brk(0xb8e09000)                         = 0xb8e09000
brk(0xb8e2a000)                         = 0xb8e2a000
brk(0xb8e4b000)                         = 0xb8e4b000
brk(0xb8e6c000)                         = 0xb8e6c000
open("/etc/selinux/refpolicy-standard/booleans", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=2029, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6e79000
read(4, "allow_cvs_read_shadow = 0\nallow_"..., 4096) = 2029
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb6e79000, 4096)                = 0
open("/etc/selinux/refpolicy-standard/booleans.local", O_RDONLY) = -1 ENOENT (No such file or directory)
brk(0xb832b000)                         = 0xb832b000
open("/selinux/load", O_RDWR|O_LARGEFILE) = 4
write(4, "\214\377|\371\10\0\0\0SE Linux\30\0\0\0\0\0\0\0\10\0\0\0\7\0\0\0"..., 3687284) = 3687284
close(4)                                = 0
munmap(0xb6e7a000, 3690496)             = 0
munmap(0xb71ff000, 3687284)             = 0
close(3)                                = 0
exit_group(0)                           = ?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
