Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p23EXOtF005629
	for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2011 09:33:24 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p23EXNUW014333
	for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2011 14:33:23 GMT
Message-ID: <4D6FA6A7.8070506@itechfrontiers.com>
Date: Thu, 03 Mar 2011 09:33:11 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: waqar afridi <afridi.waqar@gmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: Need Help Compiling Reference Policy on Mobile Device
References: <AANLkTinhRsFY0V-tjXCfsVz2D4kc5AK9MytnBzdh6Qk3@mail.gmail.com>
In-Reply-To: <AANLkTinhRsFY0V-tjXCfsVz2D4kc5AK9MytnBzdh6Qk3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Just adding my 2 cents,

I assume from Openmoko you meant the Linux distro for cellphones/mobiles

Please check message log to see if you get vmap failure or vmalloc 
failed messages, then adjust valloc size during boot time , I don't know 
what boot loader you use but in example you can change it (depending on 
the structure) by vmalloc=128m  in boot loader at the kernel line, 
standard kenel vmalloc size is 128m

you may need to use vmalloc=256m

see this page for more details: 
http://wiki.openmoko.org/wiki/Userspace_root_image


Best,


Patrick K.

On 3/3/2011 5:28 AM, waqar afridi wrote:
> Hello All
>
> Its Me Again, Now I am compiling the Reference Policy on a mobile Device
> (Openmoko), I have also done this Before and that time it was successful
> but Now when I "make load" it, The Following happens
>
>
> Sorry I wasn't Able to Scroll up as it all went away...
>
> .
> .
> .
> .
> .
> .
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms -s policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> tmp/generated_definitions.conf tmp/all_interfaces.conf
> policy/modules/admin/vbetool.te tmp/vbetool.mod.role > tmp/vbetool.tmp
> /usr/bin/checkmodule -m tmp/vbetool.tmp -o tmp/vbetool.mod
> /usr/bin/checkmodule:  loading policy configuration from tmp/vbetool.tmp
> /usr/bin/checkmodule:  policy configuration loaded
> /usr/bin/checkmodule:  writing binary representation (version 6) to
> tmp/vbetool.mod
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> policy/support/file_patterns.spt policy/support/ipc_patterns.spt
> policy/support/loadable_module.spt policy/support/misc_macros.spt
> policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
> policy/support/obj_perm_sets.spt policy/modules/admin/vbetool.fc >
> tmp/vbetool.mod.fc
> Compliling refpolicy vmware.mod module
> echo "ifdef(\`""vmware""_per_role_template',\`" > tmp/vmware.mod.role
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{
> print "gen_require(type " $3 "; role " $1
> ";)\nvmware_per_role_template(" $2 "," $3 "," $1 ")" }' >>
> tmp/vmware.mod.role
> echo "')" >> tmp/vmware.mod.role
> echo "ifdef(\`""vmware""_per_userdomain_template',\`" >> tmp/vmware.mod.role
> echo "errprint(\`Warning: per_userdomain_templates have been renamed to
> per_role_templates (""vmware""_per_userdomain_template)'__endline__)" >>
> tmp/vmware.mod.role
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{
> print "gen_require(type " $3 "; role " $1
> ";)\nvmware_per_userdomain_template(" $2 "," $3 "," $1 ")" }' >>
> tmp/vmware.mod.role
> echo "')" >> tmp/vmware.mod.role
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms -s policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> tmp/generated_definitions.conf tmp/all_interfaces.conf
> policy/modules/apps/vmware.te tmp/vmware.mod.role > tmp/vmware.tmp
> /usr/bin/checkmodule -m tmp/vmware.tmp -o tmp/vmware.mod
> /usr/bin/checkmodule:  loading policy configuration from tmp/vmware.tmp
> /usr/bin/checkmodule:  policy configuration loaded
> /usr/bin/checkmodule:  writing binary representation (version 6) to
> tmp/vmware.mod
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> policy/support/file_patterns.spt policy/support/ipc_patterns.spt
> policy/support/loadable_module.spt policy/support/misc_macros.spt
> policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
> policy/support/obj_perm_sets.spt policy/modules/apps/vmware.fc >
> tmp/vmware.mod.fc
> Compliling refpolicy vpn.mod module
> echo "ifdef(\`""vpn""_per_role_template',\`" > tmp/vpn.mod.role
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{
> print "gen_require(type " $3 "; role " $1 ";)\nvpn_per_role_template("
> $2 "," $3 "," $1 ")" }' >> tmp/vpn.mod.role
> echo "')" >> tmp/vpn.mod.role
> echo "ifdef(\`""vpn""_per_userdomain_template',\`" >> tmp/vpn.mod.role
> echo "errprint(\`Warning: per_userdomain_templates have been renamed to
> per_role_templates (""vpn""_per_userdomain_template)'__endline__)" >>
> tmp/vpn.mod.role
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{
> print "gen_require(type " $3 "; role " $1
> ";)\nvpn_per_userdomain_template(" $2 "," $3 "," $1 ")" }' >>
> tmp/vpn.mod.role
> echo "')" >> tmp/vpn.mod.role
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms -s policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> tmp/generated_definitions.conf tmp/all_interfaces.conf
> policy/modules/admin/vpn.te tmp/vpn.mod.role > tmp/vpn.tmp
> /usr/bin/checkmodule -m tmp/vpn.tmp -o tmp/vpn.mod
> /usr/bin/checkmodule:  loading policy configuration from tmp/vpn.tmp
> /usr/bin/checkmodule:  policy configuration loaded
> /usr/bin/checkmodule:  writing binary representation (version 6) to
> tmp/vpn.mod
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> policy/support/file_patterns.spt policy/support/ipc_patterns.spt
> policy/support/loadable_module.spt policy/support/misc_macros.spt
> policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
> policy/support/obj_perm_sets.spt policy/modules/admin/vpn.fc >
> tmp/vpn.mod.fc
> Compliling refpolicy watchdog.mod module
> echo "ifdef(\`""watchdog""_per_role_template',\`" > tmp/watchdog.mod.role
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{
> print "gen_require(type " $3 "; role " $1
> ";)\nwatchdog_per_role_template(" $2 "," $3 "," $1 ")" }' >>
> tmp/watchdog.mod.role
> echo "')" >> tmp/watchdog.mod.role
> echo "ifdef(\`""watchdog""_per_userdomain_template',\`" >>
> tmp/watchdog.mod.role
> echo "errprint(\`Warning: per_userdomain_templates have been renamed to
> per_role_templates (""watchdog""_per_userdomain_template)'__endline__)"
>  >> tmp/watchdog.mod.role
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/rolemap | gawk '/^[[:blank:]]*[A-Za-z]/{
> print "gen_require(type " $3 "; role " $1
> ";)\nwatchdog_per_userdomain_template(" $2 "," $3 "," $1 ")" }' >>
> tmp/watchdog.mod.role
> echo "')" >> tmp/watchdog.mod.role
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms -s policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> tmp/generated_definitions.conf tmp/all_interfaces.conf
> policy/modules/services/watchdog.te tmp/watchdog.mod.role > tmp/watchdog.tmp
> /usr/bin/checkmodule -m tmp/watchdog.tmp -o tmp/watchdog.mod
> /usr/bin/checkmodule:  loading policy configuration from tmp/watchdog.tmp
> /usr/bin/checkmodule:  policy configuration loaded
> /usr/bin/checkmodule:  writing binary representation (version 6) to
> tmp/watchdog.mod
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> policy/support/file_patterns.spt policy/support/ipc_patterns.spt
> policy/support/loadable_module.spt policy/support/misc_macros.spt
> policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
> policy/support/obj_perm_sets.spt policy/modules/services/watchdog.fc >
> tmp/watchdog.mod.fc
> Compliling refpolicy webalizer.mod module
> echo "ifdef(\`""webalizer""_per_role_template',\`" > tmp/webalizer.mod.role
> .
> .
> .
> .
> .
> .
> .
> m4 -D mls_num_sens=16 -D mls_num_cats=256 -D mcs_num_cats=256 -D
> hide_broken_symptoms policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> policy/support/file_patterns.spt policy/support/ipc_patterns.spt
> policy/support/loadable_module.spt policy/support/misc_macros.spt
> policy/support/misc_patterns.spt policy/support/mls_mcs_macros.spt
> policy/support/obj_perm_sets.spt policy/modules/services/zebra.fc >
> tmp/zebra.mod.fc
> Loading configured modules.
> /usr/sbin/semodule -s refpolicy -b /usr/share/selinux/refpolicy/base.pp
> -i /usr/share/selinux/refpolicy/acct.pp -i
> /usr/share/selinux/refpolicy/ada.pp -i
> /usr/share/selinux/refpolicy/afs.pp -i
> /usr/share/selinux/refpolicy/aide.pp -i
> /usr/share/selinux/refpolicy/alsa.pp -i
> /usr/share/selinux/refpolicy/amanda.pp -i
> /usr/share/selinux/refpolicy/amavis.pp -i
> /usr/share/selinux/refpolicy/amtu.pp -i
> /usr/share/selinux/refpolicy/anaconda.pp -i
> /usr/share/selinux/refpolicy/apache.pp -i
> /usr/share/selinux/refpolicy/apcupsd.pp -i
> /usr/share/selinux/refpolicy/apm.pp -i
> /usr/share/selinux/refpolicy/application.pp -i
> /usr/share/selinux/refpolicy/apt.pp -i
> /usr/share/selinux/refpolicy/arpwatch.pp -i
> /usr/share/selinux/refpolicy/asterisk.pp -i
> /usr/share/selinux/refpolicy/audioentropy.pp -i
> /usr/share/selinux/refpolicy/authbind.pp -i
> /usr/share/selinux/refpolicy/authlogin.pp -i
> /usr/share/selinux/refpolicy/automount.pp -i
> /usr/share/selinux/refpolicy/avahi.pp -i
> /usr/share/selinux/refpolicy/awstats.pp -i
> /usr/share/selinux/refpolicy/backup.pp -i
> /usr/share/selinux/refpolicy/bind.pp -i
> /usr/share/selinux/refpolicy/bitlbee.pp -i
> /usr/share/selinux/refpolicy/bluetooth.pp -i
> /usr/share/selinux/refpolicy/bootloader.pp -i
> /usr/share/selinux/refpolicy/brctl.pp -i
> /usr/share/selinux/refpolicy/calamaris.pp -i
> /usr/share/selinux/refpolicy/canna.pp -i
> /usr/share/selinux/refpolicy/ccs.pp -i
> /usr/share/selinux/refpolicy/cdrecord.pp -i
> /usr/share/selinux/refpolicy/certwatch.pp -i
> /usr/share/selinux/refpolicy/cipe.pp -i
> /usr/share/selinux/refpolicy/clamav.pp -i
> /usr/share/selinux/refpolicy/clock.pp -i
> /usr/share/selinux/refpolicy/clockspeed.pp -i
> /usr/share/selinux/refpolicy/comsat.pp -i
> /usr/share/selinux/refpolicy/consolekit.pp -i
> /usr/share/selinux/refpolicy/consoletype.pp -i
> /usr/share/selinux/refpolicy/courier.pp -i
> /usr/share/selinux/refpolicy/cpucontrol.pp -i
> /usr/share/selinux/refpolicy/cron.pp -i
> /usr/share/selinux/refpolicy/cups.pp -i
> /usr/share/selinux/refpolicy/cvs.pp -i
> /usr/share/selinux/refpolicy/cyrus.pp -i
> /usr/share/selinux/refpolicy/daemontools.pp -i
> /usr/share/selinux/refpolicy/dante.pp -i
> /usr/share/selinux/refpolicy/dbskk.pp -i
> /usr/share/selinux/refpolicy/dbus.pp -i
> /usr/share/selinux/refpolicy/dcc.pp -i
> /usr/share/selinux/refpolicy/ddclient.pp -i
> /usr/share/selinux/refpolicy/ddcprobe.pp -i
> /usr/share/selinux/refpolicy/dhcp.pp -i
> /usr/share/selinux/refpolicy/dictd.pp -i
> /usr/share/selinux/refpolicy/distcc.pp -i
> /usr/share/selinux/refpolicy/djbdns.pp -i
> /usr/share/selinux/refpolicy/dmesg.pp -i
> /usr/share/selinux/refpolicy/dmidecode.pp -i
> /usr/share/selinux/refpolicy/dnsmasq.pp -i
> /usr/share/selinux/refpolicy/dovecot.pp -i
> /usr/share/selinux/refpolicy/dpkg.pp -i
> /usr/share/selinux/refpolicy/ethereal.pp -i
> /usr/share/selinux/refpolicy/evolution.pp -i
> /usr/share/selinux/refpolicy/exim.pp -i
> /usr/share/selinux/refpolicy/fail2ban.pp -i
> /usr/share/selinux/refpolicy/fetchmail.pp -i
> /usr/share/selinux/refpolicy/finger.pp -i
> /usr/share/selinux/refpolicy/firstboot.pp -i
> /usr/share/selinux/refpolicy/fstools.pp -i
> /usr/share/selinux/refpolicy/ftp.pp -i
> /usr/share/selinux/refpolicy/games.pp -i
> /usr/share/selinux/refpolicy/gatekeeper.pp -i
> /usr/share/selinux/refpolicy/getty.pp -i
> /usr/share/selinux/refpolicy/gift.pp -i
> /usr/share/selinux/refpolicy/gnome.pp -i
> /usr/share/selinux/refpolicy/gpg.pp -i
> /usr/share/selinux/refpolicy/gpm.pp -i
> /usr/share/selinux/refpolicy/hal.pp -i
> /usr/share/selinux/refpolicy/hostname.pp -i
> /usr/share/selinux/refpolicy/hotplug.pp -i
> /usr/share/selinux/refpolicy/howl.pp -i
> /usr/share/selinux/refpolicy/i18n_input.pp -i
> /usr/share/selinux/refpolicy/imaze.pp -i
> /usr/share/selinux/refpolicy/inetd.pp -i
> /usr/share/selinux/refpolicy/init.pp -i
> /usr/share/selinux/refpolicy/inn.pp -i
> /usr/share/selinux/refpolicy/ipsec.pp -i
> /usr/share/selinux/refpolicy/iptables.pp -i
> /usr/share/selinux/refpolicy/irc.pp -i
> /usr/share/selinux/refpolicy/ircd.pp -i
> /usr/share/selinux/refpolicy/irqbalance.pp -i
> /usr/share/selinux/refpolicy/iscsi.pp -i
> /usr/share/selinux/refpolicy/jabber.pp -i
> /usr/share/selinux/refpolicy/java.pp -i
> /usr/share/selinux/refpolicy/kerberos.pp -i
> /usr/share/selinux/refpolicy/ktalk.pp -i
> /usr/share/selinux/refpolicy/kudzu.pp -i
> /usr/share/selinux/refpolicy/ldap.pp -i
> /usr/share/selinux/refpolicy/libraries.pp -i
> /usr/share/selinux/refpolicy/loadkeys.pp -i
> /usr/share/selinux/refpolicy/locallogin.pp -i
> /usr/share/selinux/refpolicy/lockdev.pp -i
> /usr/share/selinux/refpolicy/logging.pp -i
> /usr/share/selinux/refpolicy/logrotate.pp -i
> /usr/share/selinux/refpolicy/logwatch.pp -i
> /usr/share/selinux/refpolicy/lpd.pp -i
> /usr/share/selinux/refpolicy/lvm.pp -i
> /usr/share/selinux/refpolicy/mailman.pp -i
> /usr/share/selinux/refpolicy/miscfiles.pp -i
> /usr/share/selinux/refpolicy/modutils.pp -i
> /usr/share/selinux/refpolicy/mono.pp -i
> /usr/share/selinux/refpolicy/monop.pp -i
> /usr/share/selinux/refpolicy/mount.pp -i
> /usr/share/selinux/refpolicy/mozilla.pp -i
> /usr/share/selinux/refpolicy/mplayer.pp -i
> /usr/share/selinux/refpolicy/mrtg.pp -i
> /usr/share/selinux/refpolicy/mta.pp -i
> /usr/share/selinux/refpolicy/munin.pp -i
> /usr/share/selinux/refpolicy/mysql.pp -i
> /usr/share/selinux/refpolicy/nagios.pp -i
> /usr/share/selinux/refpolicy/nessus.pp -i
> /usr/share/selinux/refpolicy/netlabel.pp -i
> /usr/share/selinux/refpolicy/netutils.pp -i
> /usr/share/selinux/refpolicy/networkmanager.pp -i
> /usr/share/selinux/refpolicy/nis.pp -i
> /usr/share/selinux/refpolicy/nscd.pp -i
> /usr/share/selinux/refpolicy/nsd.pp -i
> /usr/share/selinux/refpolicy/ntop.pp -i
> /usr/share/selinux/refpolicy/ntp.pp -i
> /usr/share/selinux/refpolicy/nx.pp -i
> /usr/share/selinux/refpolicy/oav.pp -i
> /usr/share/selinux/refpolicy/oddjob.pp -i
> /usr/share/selinux/refpolicy/openca.pp -i
> /usr/share/selinux/refpolicy/openct.pp -i
> /usr/share/selinux/refpolicy/openvpn.pp -i
> /usr/share/selinux/refpolicy/pcmcia.pp -i
> /usr/share/selinux/refpolicy/pcscd.pp -i
> /usr/share/selinux/refpolicy/pegasus.pp -i
> /usr/share/selinux/refpolicy/perdition.pp -i
> /usr/share/selinux/refpolicy/portage.pp -i
> /usr/share/selinux/refpolicy/portmap.pp -i
> /usr/share/selinux/refpolicy/portslave.pp -i
> /usr/share/selinux/refpolicy/postfix.pp -i
> /usr/share/selinux/refpolicy/postfixpolicyd.pp -i
> /usr/share/selinux/refpolicy/postgresql.pp -i
> /usr/share/selinux/refpolicy/postgrey.pp -i
> /usr/share/selinux/refpolicy/ppp.pp -i
> /usr/share/selinux/refpolicy/prelink.pp -i
> /usr/share/selinux/refpolicy/privoxy.pp -i
> /usr/share/selinux/refpolicy/procmail.pp -i
> /usr/share/selinux/refpolicy/publicfile.pp -i
> /usr/share/selinux/refpolicy/pxe.pp -i
> /usr/share/selinux/refpolicy/pyzor.pp -i
> /usr/share/selinux/refpolicy/qmail.pp -i
> /usr/share/selinux/refpolicy/quota.pp -i
> /usr/share/selinux/refpolicy/radius.pp -i
> /usr/share/selinux/refpolicy/radvd.pp -i
> /usr/share/selinux/refpolicy/raid.pp -i
> /usr/share/selinux/refpolicy/razor.pp -i
> /usr/share/selinux/refpolicy/rdisc.pp -i
> /usr/share/selinux/refpolicy/readahead.pp -i
> /usr/share/selinux/refpolicy/remotelogin.pp -i
> /usr/share/selinux/refpolicy/resmgr.pp -i
> /usr/share/selinux/refpolicy/rhgb.pp -i
> /usr/share/selinux/refpolicy/ricci.pp -i
> /usr/share/selinux/refpolicy/rlogin.pp -i
> /usr/share/selinux/refpolicy/roundup.pp -i
> /usr/share/selinux/refpolicy/rpc.pp -i
> /usr/share/selinux/refpolicy/rpcbind.pp -i
> /usr/share/selinux/refpolicy/rpm.pp -i
> /usr/share/selinux/refpolicy/rshd.pp -i
> /usr/share/selinux/refpolicy/rssh.pp -i
> /usr/share/selinux/refpolicy/rsync.pp -i
> /usr/share/selinux/refpolicy/rwho.pp -i
> /usr/share/selinux/refpolicy/samba.pp -i
> /usr/share/selinux/refpolicy/sasl.pp -i
> /usr/share/selinux/refpolicy/screen.pp -i
> /usr/share/selinux/refpolicy/selinuxutil.pp -i
> /usr/share/selinux/refpolicy/sendmail.pp -i
> /usr/share/selinux/refpolicy/setrans.pp -i
> /usr/share/selinux/refpolicy/setroubleshoot.pp -i
> /usr/share/selinux/refpolicy/slocate.pp -i
> /usr/share/selinux/refpolicy/slrnpull.pp -i
> /usr/share/selinux/refpolicy/smartmon.pp -i
> /usr/share/selinux/refpolicy/snmp.pp -i
> /usr/share/selinux/refpolicy/snort.pp -i
> /usr/share/selinux/refpolicy/soundserver.pp -i
> /usr/share/selinux/refpolicy/spamassassin.pp -i
> /usr/share/selinux/refpolicy/speedtouch.pp -i
> /usr/share/selinux/refpolicy/squid.pp -i
> /usr/share/selinux/refpolicy/ssh.pp -i
> /usr/share/selinux/refpolicy/storage.pp -i
> /usr/share/selinux/refpolicy/stunnel.pp -i
> /usr/share/selinux/refpolicy/su.pp -i
> /usr/share/selinux/refpolicy/sudo.pp -i
> /usr/share/selinux/refpolicy/sxid.pp -i
> /usr/share/selinux/refpolicy/sysnetwork.pp -i
> /usr/share/selinux/refpolicy/sysstat.pp -i
> /usr/share/selinux/refpolicy/tcpd.pp -i
> /usr/share/selinux/refpolicy/telnet.pp -i
> /usr/share/selinux/refpolicy/tftp.pp -i
> /usr/share/selinux/refpolicy/thunderbird.pp -i
> /usr/share/selinux/refpolicy/timidity.pp -i
> /usr/share/selinux/refpolicy/tmpreaper.pp -i
> /usr/share/selinux/refpolicy/tor.pp -i
> /usr/share/selinux/refpolicy/transproxy.pp -i
> /usr/share/selinux/refpolicy/tripwire.pp -i
> /usr/share/selinux/refpolicy/tvtime.pp -i
> /usr/share/selinux/refpolicy/tzdata.pp -i
> /usr/share/selinux/refpolicy/ucspitcp.pp -i
> /usr/share/selinux/refpolicy/udev.pp -i
> /usr/share/selinux/refpolicy/uml.pp -i
> /usr/share/selinux/refpolicy/unconfined.pp -i
> /usr/share/selinux/refpolicy/updfstab.pp -i
> /usr/share/selinux/refpolicy/uptime.pp -i
> /usr/share/selinux/refpolicy/usbmodules.pp -i
> /usr/share/selinux/refpolicy/userdomain.pp -i
> /usr/share/selinux/refpolicy/userhelper.pp -i
> /usr/share/selinux/refpolicy/usermanage.pp -i
> /usr/share/selinux/refpolicy/usernetctl.pp -i
> /usr/share/selinux/refpolicy/uucp.pp -i
> /usr/share/selinux/refpolicy/uwimap.pp -i
> /usr/share/selinux/refpolicy/vbetool.pp -i
> /usr/share/selinux/refpolicy/vmware.pp -i
> /usr/share/selinux/refpolicy/vpn.pp -i
> /usr/share/selinux/refpolicy/watchdog.pp -i
> /usr/share/selinux/refpolicy/webalizer.pp -i
> /usr/share/selinux/refpolicy/wine.pp -i
> /usr/share/selinux/refpolicy/wireshark.pp -i
> /usr/share/selinux/refpolicy/xen.pp -i
> /usr/share/selinux/refpolicy/xfs.pp -i
> /usr/share/selinux/refpolicy/xprint.pp -i
> /usr/share/selinux/refpolicy/xserver.pp -i
> /usr/share/selinux/refpolicy/yam.pp -i
> /usr/share/selinux/refpolicy/zabbix.pp -i
> /usr/share/selinux/refpolicy/zebra.pp
> *libsemanage.semanage_reload_policy: load_policy returned error code 1.
> (No such file or directory).
> libsemanage.semanage_reload_policy: load_policy returned error code 1.
> (No such file or directory).
> /usr/sbin/semodule:  Failed!
> make: *** [load] Error 1
> *
> the semodule exists and also the libsemodule, First i thought It has
> something to do with low memory on Device so I created Swap and did
> other precautions but still :(
>
> Any kind of Help would be appreciated.
>
> Thanx in Advance
>
> --
> *Waqar Afridi*
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
