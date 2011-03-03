Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p23ASsZf022105
	for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2011 05:28:54 -0500
Received: from mail-qy0-f174.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p23ASrhX007259
	for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2011 10:28:53 GMT
Received: by qyk7 with SMTP id 7so4870804qyk.12
        for <selinux@tycho.nsa.gov>; Thu, 03 Mar 2011 02:28:53 -0800 (PST)
MIME-Version: 1.0
From: waqar afridi <afridi.waqar@gmail.com>
Date: Thu, 3 Mar 2011 15:28:33 +0500
Message-ID: <AANLkTinhRsFY0V-tjXCfsVz2D4kc5AK9MytnBzdh6Qk3@mail.gmail.com>
Subject: Need Help Compiling Reference Policy on Mobile Device
To: selinux-mailing-list <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=00163630ebaffc0e88049d917e2b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00163630ebaffc0e88049d917e2b
Content-Type: text/plain; charset=ISO-8859-1

Hello All

Its Me Again, Now I am compiling the Reference Policy on a mobile Device
(Openmoko), I have also done this Before and that time it was successful but
Now when I "make load" it, The Following happens


Sorry I wasn't Able to Scroll up as it all went away...

.
.
.
.
.
.
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms -s policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
tmp/generated_definitions.conf tmp/all_interfaces.conf
policy/modules/admin/vbetool.te tmp/vbetool.mod.role > tmp/vbetool.tmp
/usr/bin/checkmodule -m tmp/vbetool.tmp -o tmp/vbetool.mod
/usr/bin/checkmodule:  loading policy configuration from tmp/vbetool.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 6) to
tmp/vbetool.mod
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
policy/support/file_patterns.spt policy/support/ipc_patterns.spt
policy/support/loadable_module.spt policy/support/misc_macros.spt
policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
policy/support/obj_perm_sets.spt policy/modules/admin/vbetool.fc >
tmp/vbetool.mod.fc
Compliling refpolicy vmware.mod module
echo "ifdef(\`""vmware""_per_role_template',\`" > tmp/vmware.mod.role
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{ print
"gen_require(type " $3 "; role " $1 ";)\nvmware_per_role_template(" $2 ","
$3 "," $1 ")" }' >> tmp/vmware.mod.role
echo "')" >> tmp/vmware.mod.role
echo "ifdef(\`""vmware""_per_userdomain_template',\`" >> tmp/vmware.mod.role
echo "errprint(\`Warning: per_userdomain_templates have been renamed to
per_role_templates (""vmware""_per_userdomain_template)'__endline__)" >>
tmp/vmware.mod.role
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{ print
"gen_require(type " $3 "; role " $1 ";)\nvmware_per_userdomain_template(" $2
"," $3 "," $1 ")" }' >> tmp/vmware.mod.role
echo "')" >> tmp/vmware.mod.role
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms -s policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
tmp/generated_definitions.conf tmp/all_interfaces.conf
policy/modules/apps/vmware.te tmp/vmware.mod.role > tmp/vmware.tmp
/usr/bin/checkmodule -m tmp/vmware.tmp -o tmp/vmware.mod
/usr/bin/checkmodule:  loading policy configuration from tmp/vmware.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 6) to
tmp/vmware.mod
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
policy/support/file_patterns.spt policy/support/ipc_patterns.spt
policy/support/loadable_module.spt policy/support/misc_macros.spt
policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
policy/support/obj_perm_sets.spt policy/modules/apps/vmware.fc >
tmp/vmware.mod.fc
Compliling refpolicy vpn.mod module
echo "ifdef(\`""vpn""_per_role_template',\`" > tmp/vpn.mod.role
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{ print
"gen_require(type " $3 "; role " $1 ";)\nvpn_per_role_template(" $2 "," $3
"," $1 ")" }' >> tmp/vpn.mod.role
echo "')" >> tmp/vpn.mod.role
echo "ifdef(\`""vpn""_per_userdomain_template',\`" >> tmp/vpn.mod.role
echo "errprint(\`Warning: per_userdomain_templates have been renamed to
per_role_templates (""vpn""_per_userdomain_template)'__endline__)" >>
tmp/vpn.mod.role
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{ print
"gen_require(type " $3 "; role " $1 ";)\nvpn_per_userdomain_template(" $2
"," $3 "," $1 ")" }' >> tmp/vpn.mod.role
echo "')" >> tmp/vpn.mod.role
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms -s policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
tmp/generated_definitions.conf tmp/all_interfaces.conf
policy/modules/admin/vpn.te tmp/vpn.mod.role > tmp/vpn.tmp
/usr/bin/checkmodule -m tmp/vpn.tmp -o tmp/vpn.mod
/usr/bin/checkmodule:  loading policy configuration from tmp/vpn.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 6) to
tmp/vpn.mod
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
policy/support/file_patterns.spt policy/support/ipc_patterns.spt
policy/support/loadable_module.spt policy/support/misc_macros.spt
policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
policy/support/obj_perm_sets.spt policy/modules/admin/vpn.fc >
tmp/vpn.mod.fc
Compliling refpolicy watchdog.mod module
echo "ifdef(\`""watchdog""_per_role_template',\`" > tmp/watchdog.mod.role
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{ print
"gen_require(type " $3 "; role " $1 ";)\nwatchdog_per_role_template(" $2 ","
$3 "," $1 ")" }' >> tmp/watchdog.mod.role
echo "')" >> tmp/watchdog.mod.role
echo "ifdef(\`""watchdog""_per_userdomain_template',\`" >>
tmp/watchdog.mod.role
echo "errprint(\`Warning: per_userdomain_templates have been renamed to
per_role_templates (""watchdog""_per_userdomain_template)'__endline__)" >>
tmp/watchdog.mod.role
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{ print
"gen_require(type " $3 "; role " $1 ";)\nwatchdog_per_userdomain_template("
$2 "," $3 "," $1 ")" }' >> tmp/watchdog.mod.role
echo "')" >> tmp/watchdog.mod.role
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms -s policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
tmp/generated_definitions.conf tmp/all_interfaces.conf
policy/modules/services/watchdog.te tmp/watchdog.mod.role > tmp/watchdog.tmp
/usr/bin/checkmodule -m tmp/watchdog.tmp -o tmp/watchdog.mod
/usr/bin/checkmodule:  loading policy configuration from tmp/watchdog.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 6) to
tmp/watchdog.mod
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
policy/support/file_patterns.spt policy/support/ipc_patterns.spt
policy/support/loadable_module.spt policy/support/misc_macros.spt
policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
policy/support/obj_perm_sets.spt policy/modules/services/watchdog.fc >
tmp/watchdog.mod.fc
Compliling refpolicy webalizer.mod module
echo "ifdef(\`""webalizer""_per_role_template',\`" > tmp/webalizer.mod.role
.
.
.
.
.
.
.
m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
hide_broken_symptoms policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
policy/support/file_patterns.spt policy/support/ipc_patterns.spt
policy/support/loadable_module.spt policy/support/misc_macros.spt
policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
policy/support/obj_perm_sets.spt policy/modules/services/zebra.fc >
tmp/zebra.mod.fc
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
*libsemanage.semanage_reload_policy: load_policy returned error code 1. (No
such file or directory).
libsemanage.semanage_reload_policy: load_policy returned error code 1. (No
such file or directory).
/usr/sbin/semodule:  Failed!
make: *** [load] Error 1
*
the semodule exists and also the libsemodule, First i thought It has
something to do with low memory on Device so I created Swap and did other
precautions but still :(

Any kind of Help would be appreciated.

Thanx in Advance

-- 
*Waqar Afridi*

--00163630ebaffc0e88049d917e2b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All<br><br>Its Me Again, Now I am compiling the Refe=
rence Policy on a mobile Device (Openmoko), I have also done this Before an=
d that time it was successful but Now when I &quot;make load&quot; it, The =
Following happens<br>


<br><br>Sorry I wasn&#39;t Able to Scroll up as it all went away...<br><br>=
.<br>.<br>.<br>.<br>.<br>.<br>m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256=
 -D mcs_num_cats=3D256 -D hide_broken_symptoms -s policy/support/file_patte=
rns.spt policy/support/ipc_patterns.spt policy/support/loadable_module.spt =
policy/support/misc_macros.spt policy/support/misc_patterns.spt policy/supp=
ort/mls_mcs_macros.spt policy/support/obj_perm_sets.spt tmp/generated_defin=
itions.conf tmp/all_interfaces.conf policy/modules/admin/vbetool.te tmp/vbe=
tool.mod.role &gt; tmp/vbetool.tmp<br>


/usr/bin/checkmodule -m tmp/vbetool.tmp -o tmp/vbetool.mod<br>/usr/bin/chec=
kmodule:=A0 loading policy configuration from tmp/vbetool.tmp<br>/usr/bin/c=
heckmodule:=A0 policy configuration loaded<br>/usr/bin/checkmodule:=A0 writ=
ing binary representation (version 6) to tmp/vbetool.mod<br>


m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide=
_broken_symptoms policy/support/file_patterns.spt policy/support/ipc_patter=
ns.spt policy/support/loadable_module.spt policy/support/misc_macros.spt po=
licy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt policy/sup=
port/obj_perm_sets.spt policy/support/file_patterns.spt policy/support/ipc_=
patterns.spt policy/support/loadable_module.spt policy/support/misc_macros.=
spt policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt poli=
cy/support/obj_perm_sets.spt policy/modules/admin/vbetool.fc &gt; tmp/vbeto=
ol.mod.fc<br>


Compliling refpolicy vmware.mod module<br>echo &quot;ifdef(\`&quot;&quot;vm=
ware&quot;&quot;_per_role_template&#39;,\`&quot; &gt; tmp/vmware.mod.role<b=
r>m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hi=
de_broken_symptoms policy/rolemap | gawk &#39;/^[[:blank:]]*[A-Za-z]/{ prin=
t &quot;gen_require(type &quot; $3 &quot;; role &quot; $1 &quot;;)\nvmware_=
per_role_template(&quot; $2 &quot;,&quot; $3 &quot;,&quot; $1 &quot;)&quot;=
 }&#39; &gt;&gt; tmp/vmware.mod.role<br>


echo &quot;&#39;)&quot; &gt;&gt; tmp/vmware.mod.role<br>echo &quot;ifdef(\`=
&quot;&quot;vmware&quot;&quot;_per_userdomain_template&#39;,\`&quot; &gt;&g=
t; tmp/vmware.mod.role<br>echo &quot;errprint(\`Warning: per_userdomain_tem=
plates have been renamed to per_role_templates (&quot;&quot;vmware&quot;&qu=
ot;_per_userdomain_template)&#39;__endline__)&quot; &gt;&gt; tmp/vmware.mod=
.role<br>


m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide=
_broken_symptoms policy/rolemap | gawk &#39;/^[[:blank:]]*[A-Za-z]/{ print =
&quot;gen_require(type &quot; $3 &quot;; role &quot; $1 &quot;;)\nvmware_pe=
r_userdomain_template(&quot; $2 &quot;,&quot; $3 &quot;,&quot; $1 &quot;)&q=
uot; }&#39; &gt;&gt; tmp/vmware.mod.role<br>


echo &quot;&#39;)&quot; &gt;&gt; tmp/vmware.mod.role<br>m4 -D mls_num_sens=
=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide_broken_symptoms -=
s policy/support/file_patterns.spt policy/support/ipc_patterns.spt policy/s=
upport/loadable_module.spt policy/support/misc_macros.spt policy/support/mi=
sc_patterns.spt policy/support/mls_mcs_macros.spt policy/support/obj_perm_s=
ets.spt tmp/generated_definitions.conf tmp/all_interfaces.conf policy/modul=
es/apps/vmware.te tmp/vmware.mod.role &gt; tmp/vmware.tmp<br>


/usr/bin/checkmodule -m tmp/vmware.tmp -o tmp/vmware.mod<br>/usr/bin/checkm=
odule:=A0 loading policy configuration from tmp/vmware.tmp<br>/usr/bin/chec=
kmodule:=A0 policy configuration loaded<br>/usr/bin/checkmodule:=A0 writing=
 binary representation (version 6) to tmp/vmware.mod<br>


m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide=
_broken_symptoms policy/support/file_patterns.spt policy/support/ipc_patter=
ns.spt policy/support/loadable_module.spt policy/support/misc_macros.spt po=
licy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt policy/sup=
port/obj_perm_sets.spt policy/support/file_patterns.spt policy/support/ipc_=
patterns.spt policy/support/loadable_module.spt policy/support/misc_macros.=
spt policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt poli=
cy/support/obj_perm_sets.spt policy/modules/apps/vmware.fc &gt; tmp/vmware.=
mod.fc<br>


Compliling refpolicy vpn.mod module<br>echo &quot;ifdef(\`&quot;&quot;vpn&q=
uot;&quot;_per_role_template&#39;,\`&quot; &gt; tmp/vpn.mod.role<br>m4 -D m=
ls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide_broken=
_symptoms policy/rolemap | gawk &#39;/^[[:blank:]]*[A-Za-z]/{ print &quot;g=
en_require(type &quot; $3 &quot;; role &quot; $1 &quot;;)\nvpn_per_role_tem=
plate(&quot; $2 &quot;,&quot; $3 &quot;,&quot; $1 &quot;)&quot; }&#39; &gt;=
&gt; tmp/vpn.mod.role<br>


echo &quot;&#39;)&quot; &gt;&gt; tmp/vpn.mod.role<br>echo &quot;ifdef(\`&qu=
ot;&quot;vpn&quot;&quot;_per_userdomain_template&#39;,\`&quot; &gt;&gt; tmp=
/vpn.mod.role<br>echo &quot;errprint(\`Warning: per_userdomain_templates ha=
ve been renamed to per_role_templates (&quot;&quot;vpn&quot;&quot;_per_user=
domain_template)&#39;__endline__)&quot; &gt;&gt; tmp/vpn.mod.role<br>


m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide=
_broken_symptoms policy/rolemap | gawk &#39;/^[[:blank:]]*[A-Za-z]/{ print =
&quot;gen_require(type &quot; $3 &quot;; role &quot; $1 &quot;;)\nvpn_per_u=
serdomain_template(&quot; $2 &quot;,&quot; $3 &quot;,&quot; $1 &quot;)&quot=
; }&#39; &gt;&gt; tmp/vpn.mod.role<br>


echo &quot;&#39;)&quot; &gt;&gt; tmp/vpn.mod.role<br>m4 -D mls_num_sens=3D1=
6 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide_broken_symptoms -s po=
licy/support/file_patterns.spt policy/support/ipc_patterns.spt policy/suppo=
rt/loadable_module.spt policy/support/misc_macros.spt policy/support/misc_p=
atterns.spt policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.=
spt tmp/generated_definitions.conf tmp/all_interfaces.conf policy/modules/a=
dmin/vpn.te tmp/vpn.mod.role &gt; tmp/vpn.tmp<br>


/usr/bin/checkmodule -m tmp/vpn.tmp -o tmp/vpn.mod<br>/usr/bin/checkmodule:=
=A0 loading policy configuration from tmp/vpn.tmp<br>/usr/bin/checkmodule:=
=A0 policy configuration loaded<br>/usr/bin/checkmodule:=A0 writing binary =
representation (version 6) to tmp/vpn.mod<br>


m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide=
_broken_symptoms policy/support/file_patterns.spt policy/support/ipc_patter=
ns.spt policy/support/loadable_module.spt policy/support/misc_macros.spt po=
licy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt policy/sup=
port/obj_perm_sets.spt policy/support/file_patterns.spt policy/support/ipc_=
patterns.spt policy/support/loadable_module.spt policy/support/misc_macros.=
spt policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt poli=
cy/support/obj_perm_sets.spt policy/modules/admin/vpn.fc &gt; tmp/vpn.mod.f=
c<br>


Compliling refpolicy watchdog.mod module<br>echo &quot;ifdef(\`&quot;&quot;=
watchdog&quot;&quot;_per_role_template&#39;,\`&quot; &gt; tmp/watchdog.mod.=
role<br>m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256=
 -D hide_broken_symptoms policy/rolemap | gawk &#39;/^[[:blank:]]*[A-Za-z]/=
{ print &quot;gen_require(type &quot; $3 &quot;; role &quot; $1 &quot;;)\nw=
atchdog_per_role_template(&quot; $2 &quot;,&quot; $3 &quot;,&quot; $1 &quot=
;)&quot; }&#39; &gt;&gt; tmp/watchdog.mod.role<br>


echo &quot;&#39;)&quot; &gt;&gt; tmp/watchdog.mod.role<br>echo &quot;ifdef(=
\`&quot;&quot;watchdog&quot;&quot;_per_userdomain_template&#39;,\`&quot; &g=
t;&gt; tmp/watchdog.mod.role<br>echo &quot;errprint(\`Warning: per_userdoma=
in_templates have been renamed to per_role_templates (&quot;&quot;watchdog&=
quot;&quot;_per_userdomain_template)&#39;__endline__)&quot; &gt;&gt; tmp/wa=
tchdog.mod.role<br>


m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide=
_broken_symptoms policy/rolemap | gawk &#39;/^[[:blank:]]*[A-Za-z]/{ print =
&quot;gen_require(type &quot; $3 &quot;; role &quot; $1 &quot;;)\nwatchdog_=
per_userdomain_template(&quot; $2 &quot;,&quot; $3 &quot;,&quot; $1 &quot;)=
&quot; }&#39; &gt;&gt; tmp/watchdog.mod.role<br>


echo &quot;&#39;)&quot; &gt;&gt; tmp/watchdog.mod.role<br>m4 -D mls_num_sen=
s=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide_broken_symptoms =
-s policy/support/file_patterns.spt policy/support/ipc_patterns.spt policy/=
support/loadable_module.spt policy/support/misc_macros.spt policy/support/m=
isc_patterns.spt policy/support/mls_mcs_macros.spt policy/support/obj_perm_=
sets.spt tmp/generated_definitions.conf tmp/all_interfaces.conf policy/modu=
les/services/watchdog.te tmp/watchdog.mod.role &gt; tmp/watchdog.tmp<br>


/usr/bin/checkmodule -m tmp/watchdog.tmp -o tmp/watchdog.mod<br>/usr/bin/ch=
eckmodule:=A0 loading policy configuration from tmp/watchdog.tmp<br>/usr/bi=
n/checkmodule:=A0 policy configuration loaded<br>/usr/bin/checkmodule:=A0 w=
riting binary representation (version 6) to tmp/watchdog.mod<br>


m4 -D mls_num_sens=3D16 -D mls_num_cats=3D256 -D mcs_num_cats=3D256 -D hide=
_broken_symptoms policy/support/file_patterns.spt policy/support/ipc_patter=
ns.spt policy/support/loadable_module.spt policy/support/misc_macros.spt po=
licy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt policy/sup=
port/obj_perm_sets.spt policy/support/file_patterns.spt policy/support/ipc_=
patterns.spt policy/support/loadable_module.spt policy/support/misc_macros.=
spt policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt poli=
cy/support/obj_perm_sets.spt policy/modules/services/watchdog.fc &gt; tmp/w=
atchdog.mod.fc<br>


Compliling refpolicy webalizer.mod module<br>echo &quot;ifdef(\`&quot;&quot=
;webalizer&quot;&quot;_per_role_template&#39;,\`&quot; &gt; tmp/webalizer.m=
od.role<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>m4 -D mls_num_sens=3D16 -D ml=
s_num_cats=3D256 -D mcs_num_cats=3D256 -D hide_broken_symptoms policy/suppo=
rt/file_patterns.spt policy/support/ipc_patterns.spt policy/support/loadabl=
e_module.spt policy/support/misc_macros.spt policy/support/misc_patterns.sp=
t policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt policy=
/support/file_patterns.spt policy/support/ipc_patterns.spt policy/support/l=
oadable_module.spt policy/support/misc_macros.spt policy/support/misc_patte=
rns.spt policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt =
policy/modules/services/zebra.fc &gt; tmp/zebra.mod.fc<br>


Loading configured modules.<br>/usr/sbin/semodule -s refpolicy -b /usr/shar=
e/selinux/refpolicy/base.pp -i /usr/share/selinux/refpolicy/acct.pp -i /usr=
/share/selinux/refpolicy/ada.pp -i /usr/share/selinux/refpolicy/afs.pp -i /=
usr/share/selinux/refpolicy/aide.pp -i /usr/share/selinux/refpolicy/alsa.pp=
 -i /usr/share/selinux/refpolicy/amanda.pp -i /usr/share/selinux/refpolicy/=
amavis.pp -i /usr/share/selinux/refpolicy/amtu.pp -i /usr/share/selinux/ref=
policy/anaconda.pp -i /usr/share/selinux/refpolicy/apache.pp -i /usr/share/=
selinux/refpolicy/apcupsd.pp -i /usr/share/selinux/refpolicy/apm.pp -i /usr=
/share/selinux/refpolicy/application.pp -i /usr/share/selinux/refpolicy/apt=
.pp -i /usr/share/selinux/refpolicy/arpwatch.pp -i /usr/share/selinux/refpo=
licy/asterisk.pp -i /usr/share/selinux/refpolicy/audioentropy.pp -i /usr/sh=
are/selinux/refpolicy/authbind.pp -i /usr/share/selinux/refpolicy/authlogin=
.pp -i /usr/share/selinux/refpolicy/automount.pp -i /usr/share/selinux/refp=
olicy/avahi.pp -i /usr/share/selinux/refpolicy/awstats.pp -i /usr/share/sel=
inux/refpolicy/backup.pp -i /usr/share/selinux/refpolicy/bind.pp -i /usr/sh=
are/selinux/refpolicy/bitlbee.pp -i /usr/share/selinux/refpolicy/bluetooth.=
pp -i /usr/share/selinux/refpolicy/bootloader.pp -i /usr/share/selinux/refp=
olicy/brctl.pp -i /usr/share/selinux/refpolicy/calamaris.pp -i /usr/share/s=
elinux/refpolicy/canna.pp -i /usr/share/selinux/refpolicy/ccs.pp -i /usr/sh=
are/selinux/refpolicy/cdrecord.pp -i /usr/share/selinux/refpolicy/certwatch=
.pp -i /usr/share/selinux/refpolicy/cipe.pp -i /usr/share/selinux/refpolicy=
/clamav.pp -i /usr/share/selinux/refpolicy/clock.pp -i /usr/share/selinux/r=
efpolicy/clockspeed.pp -i /usr/share/selinux/refpolicy/comsat.pp -i /usr/sh=
are/selinux/refpolicy/consolekit.pp -i /usr/share/selinux/refpolicy/console=
type.pp -i /usr/share/selinux/refpolicy/courier.pp -i /usr/share/selinux/re=
fpolicy/cpucontrol.pp -i /usr/share/selinux/refpolicy/cron.pp -i /usr/share=
/selinux/refpolicy/cups.pp -i /usr/share/selinux/refpolicy/cvs.pp -i /usr/s=
hare/selinux/refpolicy/cyrus.pp -i /usr/share/selinux/refpolicy/daemontools=
.pp -i /usr/share/selinux/refpolicy/dante.pp -i /usr/share/selinux/refpolic=
y/dbskk.pp -i /usr/share/selinux/refpolicy/dbus.pp -i /usr/share/selinux/re=
fpolicy/dcc.pp -i /usr/share/selinux/refpolicy/ddclient.pp -i /usr/share/se=
linux/refpolicy/ddcprobe.pp -i /usr/share/selinux/refpolicy/dhcp.pp -i /usr=
/share/selinux/refpolicy/dictd.pp -i /usr/share/selinux/refpolicy/distcc.pp=
 -i /usr/share/selinux/refpolicy/djbdns.pp -i /usr/share/selinux/refpolicy/=
dmesg.pp -i /usr/share/selinux/refpolicy/dmidecode.pp -i /usr/share/selinux=
/refpolicy/dnsmasq.pp -i /usr/share/selinux/refpolicy/dovecot.pp -i /usr/sh=
are/selinux/refpolicy/dpkg.pp -i /usr/share/selinux/refpolicy/ethereal.pp -=
i /usr/share/selinux/refpolicy/evolution.pp -i /usr/share/selinux/refpolicy=
/exim.pp -i /usr/share/selinux/refpolicy/fail2ban.pp -i /usr/share/selinux/=
refpolicy/fetchmail.pp -i /usr/share/selinux/refpolicy/finger.pp -i /usr/sh=
are/selinux/refpolicy/firstboot.pp -i /usr/share/selinux/refpolicy/fstools.=
pp -i /usr/share/selinux/refpolicy/ftp.pp -i /usr/share/selinux/refpolicy/g=
ames.pp -i /usr/share/selinux/refpolicy/gatekeeper.pp -i /usr/share/selinux=
/refpolicy/getty.pp -i /usr/share/selinux/refpolicy/gift.pp -i /usr/share/s=
elinux/refpolicy/gnome.pp -i /usr/share/selinux/refpolicy/gpg.pp -i /usr/sh=
are/selinux/refpolicy/gpm.pp -i /usr/share/selinux/refpolicy/hal.pp -i /usr=
/share/selinux/refpolicy/hostname.pp -i /usr/share/selinux/refpolicy/hotplu=
g.pp -i /usr/share/selinux/refpolicy/howl.pp -i /usr/share/selinux/refpolic=
y/i18n_input.pp -i /usr/share/selinux/refpolicy/imaze.pp -i /usr/share/seli=
nux/refpolicy/inetd.pp -i /usr/share/selinux/refpolicy/init.pp -i /usr/shar=
e/selinux/refpolicy/inn.pp -i /usr/share/selinux/refpolicy/ipsec.pp -i /usr=
/share/selinux/refpolicy/iptables.pp -i /usr/share/selinux/refpolicy/irc.pp=
 -i /usr/share/selinux/refpolicy/ircd.pp -i /usr/share/selinux/refpolicy/ir=
qbalance.pp -i /usr/share/selinux/refpolicy/iscsi.pp -i /usr/share/selinux/=
refpolicy/jabber.pp -i /usr/share/selinux/refpolicy/java.pp -i /usr/share/s=
elinux/refpolicy/kerberos.pp -i /usr/share/selinux/refpolicy/ktalk.pp -i /u=
sr/share/selinux/refpolicy/kudzu.pp -i /usr/share/selinux/refpolicy/ldap.pp=
 -i /usr/share/selinux/refpolicy/libraries.pp -i /usr/share/selinux/refpoli=
cy/loadkeys.pp -i /usr/share/selinux/refpolicy/locallogin.pp -i /usr/share/=
selinux/refpolicy/lockdev.pp -i /usr/share/selinux/refpolicy/logging.pp -i =
/usr/share/selinux/refpolicy/logrotate.pp -i /usr/share/selinux/refpolicy/l=
ogwatch.pp -i /usr/share/selinux/refpolicy/lpd.pp -i /usr/share/selinux/ref=
policy/lvm.pp -i /usr/share/selinux/refpolicy/mailman.pp -i /usr/share/seli=
nux/refpolicy/miscfiles.pp -i /usr/share/selinux/refpolicy/modutils.pp -i /=
usr/share/selinux/refpolicy/mono.pp -i /usr/share/selinux/refpolicy/monop.p=
p -i /usr/share/selinux/refpolicy/mount.pp -i /usr/share/selinux/refpolicy/=
mozilla.pp -i /usr/share/selinux/refpolicy/mplayer.pp -i /usr/share/selinux=
/refpolicy/mrtg.pp -i /usr/share/selinux/refpolicy/mta.pp -i /usr/share/sel=
inux/refpolicy/munin.pp -i /usr/share/selinux/refpolicy/mysql.pp -i /usr/sh=
are/selinux/refpolicy/nagios.pp -i /usr/share/selinux/refpolicy/nessus.pp -=
i /usr/share/selinux/refpolicy/netlabel.pp -i /usr/share/selinux/refpolicy/=
netutils.pp -i /usr/share/selinux/refpolicy/networkmanager.pp -i /usr/share=
/selinux/refpolicy/nis.pp -i /usr/share/selinux/refpolicy/nscd.pp -i /usr/s=
hare/selinux/refpolicy/nsd.pp -i /usr/share/selinux/refpolicy/ntop.pp -i /u=
sr/share/selinux/refpolicy/ntp.pp -i /usr/share/selinux/refpolicy/nx.pp -i =
/usr/share/selinux/refpolicy/oav.pp -i /usr/share/selinux/refpolicy/oddjob.=
pp -i /usr/share/selinux/refpolicy/openca.pp -i /usr/share/selinux/refpolic=
y/openct.pp -i /usr/share/selinux/refpolicy/openvpn.pp -i /usr/share/selinu=
x/refpolicy/pcmcia.pp -i /usr/share/selinux/refpolicy/pcscd.pp -i /usr/shar=
e/selinux/refpolicy/pegasus.pp -i /usr/share/selinux/refpolicy/perdition.pp=
 -i /usr/share/selinux/refpolicy/portage.pp -i /usr/share/selinux/refpolicy=
/portmap.pp -i /usr/share/selinux/refpolicy/portslave.pp -i /usr/share/seli=
nux/refpolicy/postfix.pp -i /usr/share/selinux/refpolicy/postfixpolicyd.pp =
-i /usr/share/selinux/refpolicy/postgresql.pp -i /usr/share/selinux/refpoli=
cy/postgrey.pp -i /usr/share/selinux/refpolicy/ppp.pp -i /usr/share/selinux=
/refpolicy/prelink.pp -i /usr/share/selinux/refpolicy/privoxy.pp -i /usr/sh=
are/selinux/refpolicy/procmail.pp -i /usr/share/selinux/refpolicy/publicfil=
e.pp -i /usr/share/selinux/refpolicy/pxe.pp -i /usr/share/selinux/refpolicy=
/pyzor.pp -i /usr/share/selinux/refpolicy/qmail.pp -i /usr/share/selinux/re=
fpolicy/quota.pp -i /usr/share/selinux/refpolicy/radius.pp -i /usr/share/se=
linux/refpolicy/radvd.pp -i /usr/share/selinux/refpolicy/raid.pp -i /usr/sh=
are/selinux/refpolicy/razor.pp -i /usr/share/selinux/refpolicy/rdisc.pp -i =
/usr/share/selinux/refpolicy/readahead.pp -i /usr/share/selinux/refpolicy/r=
emotelogin.pp -i /usr/share/selinux/refpolicy/resmgr.pp -i /usr/share/selin=
ux/refpolicy/rhgb.pp -i /usr/share/selinux/refpolicy/ricci.pp -i /usr/share=
/selinux/refpolicy/rlogin.pp -i /usr/share/selinux/refpolicy/roundup.pp -i =
/usr/share/selinux/refpolicy/rpc.pp -i /usr/share/selinux/refpolicy/rpcbind=
.pp -i /usr/share/selinux/refpolicy/rpm.pp -i /usr/share/selinux/refpolicy/=
rshd.pp -i /usr/share/selinux/refpolicy/rssh.pp -i /usr/share/selinux/refpo=
licy/rsync.pp -i /usr/share/selinux/refpolicy/rwho.pp -i /usr/share/selinux=
/refpolicy/samba.pp -i /usr/share/selinux/refpolicy/sasl.pp -i /usr/share/s=
elinux/refpolicy/screen.pp -i /usr/share/selinux/refpolicy/selinuxutil.pp -=
i /usr/share/selinux/refpolicy/sendmail.pp -i /usr/share/selinux/refpolicy/=
setrans.pp -i /usr/share/selinux/refpolicy/setroubleshoot.pp -i /usr/share/=
selinux/refpolicy/slocate.pp -i /usr/share/selinux/refpolicy/slrnpull.pp -i=
 /usr/share/selinux/refpolicy/smartmon.pp -i /usr/share/selinux/refpolicy/s=
nmp.pp -i /usr/share/selinux/refpolicy/snort.pp -i /usr/share/selinux/refpo=
licy/soundserver.pp -i /usr/share/selinux/refpolicy/spamassassin.pp -i /usr=
/share/selinux/refpolicy/speedtouch.pp -i /usr/share/selinux/refpolicy/squi=
d.pp -i /usr/share/selinux/refpolicy/ssh.pp -i /usr/share/selinux/refpolicy=
/storage.pp -i /usr/share/selinux/refpolicy/stunnel.pp -i /usr/share/selinu=
x/refpolicy/su.pp -i /usr/share/selinux/refpolicy/sudo.pp -i /usr/share/sel=
inux/refpolicy/sxid.pp -i /usr/share/selinux/refpolicy/sysnetwork.pp -i /us=
r/share/selinux/refpolicy/sysstat.pp -i /usr/share/selinux/refpolicy/tcpd.p=
p -i /usr/share/selinux/refpolicy/telnet.pp -i /usr/share/selinux/refpolicy=
/tftp.pp -i /usr/share/selinux/refpolicy/thunderbird.pp -i /usr/share/selin=
ux/refpolicy/timidity.pp -i /usr/share/selinux/refpolicy/tmpreaper.pp -i /u=
sr/share/selinux/refpolicy/tor.pp -i /usr/share/selinux/refpolicy/transprox=
y.pp -i /usr/share/selinux/refpolicy/tripwire.pp -i /usr/share/selinux/refp=
olicy/tvtime.pp -i /usr/share/selinux/refpolicy/tzdata.pp -i /usr/share/sel=
inux/refpolicy/ucspitcp.pp -i /usr/share/selinux/refpolicy/udev.pp -i /usr/=
share/selinux/refpolicy/uml.pp -i /usr/share/selinux/refpolicy/unconfined.p=
p -i /usr/share/selinux/refpolicy/updfstab.pp -i /usr/share/selinux/refpoli=
cy/uptime.pp -i /usr/share/selinux/refpolicy/usbmodules.pp -i /usr/share/se=
linux/refpolicy/userdomain.pp -i /usr/share/selinux/refpolicy/userhelper.pp=
 -i /usr/share/selinux/refpolicy/usermanage.pp -i /usr/share/selinux/refpol=
icy/usernetctl.pp -i /usr/share/selinux/refpolicy/uucp.pp -i /usr/share/sel=
inux/refpolicy/uwimap.pp -i /usr/share/selinux/refpolicy/vbetool.pp -i /usr=
/share/selinux/refpolicy/vmware.pp -i /usr/share/selinux/refpolicy/vpn.pp -=
i /usr/share/selinux/refpolicy/watchdog.pp -i /usr/share/selinux/refpolicy/=
webalizer.pp -i /usr/share/selinux/refpolicy/wine.pp -i /usr/share/selinux/=
refpolicy/wireshark.pp -i /usr/share/selinux/refpolicy/xen.pp -i /usr/share=
/selinux/refpolicy/xfs.pp -i /usr/share/selinux/refpolicy/xprint.pp -i /usr=
/share/selinux/refpolicy/xserver.pp -i /usr/share/selinux/refpolicy/yam.pp =
-i /usr/share/selinux/refpolicy/zabbix.pp -i /usr/share/selinux/refpolicy/z=
ebra.pp<br>


<b>libsemanage.semanage_reload_policy: load_policy returned error code 1. (=
No such file or directory).<br>libsemanage.semanage_reload_policy: load_pol=
icy returned error code 1. (No such file or directory).<br>/usr/sbin/semodu=
le:=A0 Failed!<br>


make: *** [load] Error 1<br></b><br>the semodule exists and also the libsem=
odule, First i thought It has something to do with low memory on Device so =
I created Swap and did other precautions but still :(<br><br>Any kind of He=
lp would be appreciated.<br>


<br>Thanx in Advance<br>=A0<br>-- <br><div dir=3D"ltr"><b><font face=3D"&#3=
9;comic sans ms&#39;, sans-serif"><font color=3D"#000099"><span style=3D"ba=
ckground-color: rgb(255, 255, 255);">Waqar Afridi</span></font></font></b><=
font color=3D"#000099"><span style=3D"background-color: rgb(255, 255, 255);=
"><br>


</span></font><br>
</div></div>

--00163630ebaffc0e88049d917e2b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
