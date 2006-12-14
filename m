Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBEKBXLT004441
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 15:11:33 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBEKC6Kl006800
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:12:06 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kBEK8RW7023746
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 15:08:27 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kBEK8RQs023745
	for selinux@tycho.nsa.gov; Thu, 14 Dec 2006 15:08:27 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBEJSfMO002428
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 14:28:41 -0500
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBEJTBSS011083
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 19:29:12 GMT
Message-Id: <20061214192903.427348000@hp.com>
References: <20061214192414.551708000@hp.com>
Date: Thu, 14 Dec 2006 14:24:15 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/4] Policy patches to add NetLabel to support to various domains
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

The original NetLabel policy patch added the ability to receive NetLabel
packets to normal user domains but it forgot to give that ability to all of the
various other application domains.  This patch adds that support, mostly
through the use of some variation on the following code snippet:

 ifdef(`enable_mls',`
	corenet_tcp_recv_netlabel(<domain>)
	corenet_udp_recv_netlabel(<domain>)
 ')

Which was chosen as it seemed to be inline with the current policy.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/admin/amanda.te            |    8 ++++++++
 policy/modules/admin/apt.te               |    4 ++++
 policy/modules/admin/backup.te            |    4 ++++
 policy/modules/admin/dpkg.te              |    4 ++++
 policy/modules/admin/mrtg.te              |    4 ++++
 policy/modules/admin/netutils.te          |    4 ++++
 policy/modules/admin/portage.if           |    4 ++++
 policy/modules/admin/rpm.te               |    4 ++++
 policy/modules/admin/sxid.te              |    4 ++++
 policy/modules/apps/calamaris.te          |    4 ++++
 policy/modules/apps/evolution.if          |   10 ++++++++++
 policy/modules/apps/games.if              |    4 ++++
 policy/modules/apps/gift.if               |    8 ++++++++
 policy/modules/apps/gpg.if                |    8 ++++++++
 policy/modules/apps/irc.if                |    4 ++++
 policy/modules/apps/java.if               |    4 ++++
 policy/modules/apps/mozilla.if            |    3 +++
 policy/modules/apps/screen.if             |    4 ++++
 policy/modules/apps/thunderbird.if        |    3 +++
 policy/modules/apps/uml.if                |    4 ++++
 policy/modules/apps/vmware.te             |    4 ++++
 policy/modules/apps/webalizer.te          |    3 +++
 policy/modules/apps/yam.te                |    3 +++
 policy/modules/services/afs.te            |   20 ++++++++++++++++++++
 policy/modules/services/amavis.te         |    3 +++
 policy/modules/services/apache.if         |    8 ++++++++
 policy/modules/services/apache.te         |    8 ++++++++
 policy/modules/services/arpwatch.te       |    4 ++++
 policy/modules/services/asterisk.te       |    4 ++++
 policy/modules/services/automount.te      |    4 ++++
 policy/modules/services/avahi.te          |    4 ++++
 policy/modules/services/bind.te           |    7 +++++++
 policy/modules/services/bluetooth.te      |    4 ++++
 policy/modules/services/canna.te          |    3 +++
 policy/modules/services/ccs.te            |    4 ++++
 policy/modules/services/cipe.te           |    3 +++
 policy/modules/services/clamav.te         |    6 ++++++
 policy/modules/services/clockspeed.te     |    6 ++++++
 policy/modules/services/comsat.te         |    4 ++++
 policy/modules/services/courier.if        |    4 ++++
 policy/modules/services/courier.te        |    3 +++
 policy/modules/services/cron.if           |    4 ++++
 policy/modules/services/cron.te           |    4 ++++
 policy/modules/services/cups.te           |   19 +++++++++++++++++++
 policy/modules/services/cvs.te            |    4 ++++
 policy/modules/services/cyrus.te          |    4 ++++
 policy/modules/services/dante.te          |    4 ++++
 policy/modules/services/dbskk.te          |    4 ++++
 policy/modules/services/dbus.if           |    3 +++
 policy/modules/services/dcc.te            |   18 ++++++++++++++++++
 policy/modules/services/ddclient.te       |    4 ++++
 policy/modules/services/dictd.te          |    4 ++++
 policy/modules/services/distcc.te         |    4 ++++
 policy/modules/services/djbdns.if         |    4 ++++
 policy/modules/services/dnsmasq.te        |    4 ++++
 policy/modules/services/dovecot.te        |    3 +++
 policy/modules/services/fetchmail.te      |    4 ++++
 policy/modules/services/finger.te         |    4 ++++
 policy/modules/services/ftp.te            |    4 ++++
 policy/modules/services/gatekeeper.te     |    4 ++++
 policy/modules/services/hal.te            |    4 ++++
 policy/modules/services/howl.te           |    4 ++++
 policy/modules/services/i18n_input.te     |    4 ++++
 policy/modules/services/imaze.te          |    4 ++++
 policy/modules/services/inetd.te          |    4 ++++
 policy/modules/services/inn.te            |    4 ++++
 policy/modules/services/ircd.te           |    4 ++++
 policy/modules/services/jabber.te         |    4 ++++
 policy/modules/services/kerberos.if       |    4 ++++
 policy/modules/services/kerberos.te       |    8 ++++++++
 policy/modules/services/ktalk.te          |    4 ++++
 policy/modules/services/ldap.te           |    4 ++++
 policy/modules/services/lpd.if            |    4 ++++
 policy/modules/services/lpd.te            |    8 ++++++++
 policy/modules/services/mailman.if        |    4 ++++
 policy/modules/services/monop.te          |    4 ++++
 policy/modules/services/mta.if            |    3 +++
 policy/modules/services/munin.te          |    4 ++++
 policy/modules/services/mysql.te          |    4 ++++
 policy/modules/services/nagios.te         |    4 ++++
 policy/modules/services/nessus.te         |    4 ++++
 policy/modules/services/networkmanager.te |    4 ++++
 policy/modules/services/nis.if            |    4 ++++
 policy/modules/services/nis.te            |   16 ++++++++++++++++
 policy/modules/services/nscd.te           |    4 ++++
 policy/modules/services/nsd.te            |    8 ++++++++
 policy/modules/services/ntop.te           |    4 ++++
 policy/modules/services/ntp.te            |    4 ++++
 policy/modules/services/nx.te             |    4 ++++
 policy/modules/services/oav.te            |    8 ++++++++
 policy/modules/services/pegasus.te        |    3 +++
 policy/modules/services/perdition.te      |    4 ++++
 policy/modules/services/portmap.te        |    8 ++++++++
 policy/modules/services/portslave.te      |    4 ++++
 policy/modules/services/postfix.if        |    4 ++++
 policy/modules/services/postfix.te        |   11 +++++++++++
 policy/modules/services/postgresql.te     |    4 ++++
 policy/modules/services/postgrey.te       |    3 +++
 policy/modules/services/ppp.te            |    7 +++++++
 policy/modules/services/privoxy.te        |    3 +++
 policy/modules/services/procmail.te       |    4 ++++
 policy/modules/services/pyzor.te          |    6 ++++++
 policy/modules/services/qmail.te          |    4 ++++
 policy/modules/services/radius.te         |    4 ++++
 policy/modules/services/radvd.te          |    4 ++++
 policy/modules/services/razor.if          |    3 +++
 policy/modules/services/razor.te          |    3 +++
 policy/modules/services/rdisc.te          |    3 +++
 policy/modules/services/rhgb.te           |    4 ++++
 policy/modules/services/ricci.te          |    7 +++++++
 policy/modules/services/rlogin.te         |    4 ++++
 policy/modules/services/roundup.te        |    4 ++++
 policy/modules/services/rpc.if            |    4 ++++
 policy/modules/services/rshd.te           |    4 ++++
 policy/modules/services/rsync.te          |    4 ++++
 policy/modules/services/samba.te          |   24 ++++++++++++++++++++++++
 policy/modules/services/sasl.te           |    3 +++
 policy/modules/services/sendmail.te       |    3 +++
 policy/modules/services/setroubleshoot.te |    3 +++
 policy/modules/services/smartmon.te       |    3 +++
 policy/modules/services/snmp.te           |    4 ++++
 policy/modules/services/snort.te          |    4 ++++
 policy/modules/services/soundserver.te    |    4 ++++
 policy/modules/services/spamassassin.if   |    4 ++++
 policy/modules/services/spamassassin.te   |    4 ++++
 policy/modules/services/squid.te          |    4 ++++
 policy/modules/services/ssh.if            |    7 +++++++
 policy/modules/services/stunnel.te        |    4 ++++
 policy/modules/services/tcpd.te           |    3 +++
 policy/modules/services/telnet.te         |    4 ++++
 policy/modules/services/tftp.te           |    4 ++++
 policy/modules/services/timidity.te       |    4 ++++
 policy/modules/services/tor.te            |    3 +++
 policy/modules/services/transproxy.te     |    3 +++
 policy/modules/services/ucspitcp.te       |    8 ++++++++
 policy/modules/services/uucp.te           |    4 ++++
 policy/modules/services/uwimap.te         |    3 +++
 policy/modules/services/watchdog.te       |    4 ++++
 policy/modules/services/xprint.te         |    4 ++++
 policy/modules/services/xserver.if        |    4 ++++
 policy/modules/services/xserver.te        |    4 ++++
 policy/modules/services/zebra.te          |    4 ++++
 policy/modules/system/hotplug.te          |    4 ++++
 policy/modules/system/iscsi.te            |    3 +++
 policy/modules/system/lvm.te              |    5 +++++
 policy/modules/system/mount.te            |    4 ++++
 policy/modules/system/sysnetwork.if       |   12 ++++++++++++
 147 files changed, 723 insertions(+)

Index: refpolicy/policy/modules/admin/amanda.te
===================================================================
--- refpolicy.orig/policy/modules/admin/amanda.te
+++ refpolicy/policy/modules/admin/amanda.te
@@ -125,6 +125,10 @@ corenet_udp_sendrecv_all_ports(amanda_t)
 corenet_tcp_bind_all_nodes(amanda_t)
 corenet_udp_bind_all_nodes(amanda_t)
 corenet_tcp_bind_all_rpc_ports(amanda_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(amanda_t)
+	corenet_udp_recv_netlabel(amanda_t)
+')
 
 dev_getattr_all_blk_files(amanda_t)
 dev_getattr_all_chr_files(amanda_t)
@@ -213,6 +217,10 @@ corenet_udp_bind_all_nodes(amanda_recove
 corenet_tcp_bind_reserved_port(amanda_recover_t)
 corenet_tcp_connect_amanda_port(amanda_recover_t)
 corenet_sendrecv_amanda_client_packets(amanda_recover_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(amanda_recover_t)
+	corenet_udp_recv_netlabel(amanda_recover_t)
+')
 
 corecmd_exec_shell(amanda_recover_t)
 corecmd_exec_bin(amanda_recover_t)
Index: refpolicy/policy/modules/admin/apt.te
===================================================================
--- refpolicy.orig/policy/modules/admin/apt.te
+++ refpolicy/policy/modules/admin/apt.te
@@ -80,6 +80,10 @@ corenet_tcp_sendrecv_all_nodes(apt_t)
 corenet_udp_sendrecv_all_nodes(apt_t)
 corenet_tcp_sendrecv_all_ports(apt_t)
 corenet_udp_sendrecv_all_ports(apt_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(apt_t)
+	corenet_udp_recv_netlabel(apt_t)
+')
 # TODO: reall allow all these?
 corenet_tcp_bind_all_nodes(apt_t)
 corenet_udp_bind_all_nodes(apt_t)
Index: refpolicy/policy/modules/admin/backup.te
===================================================================
--- refpolicy.orig/policy/modules/admin/backup.te
+++ refpolicy/policy/modules/admin/backup.te
@@ -47,6 +47,10 @@ corenet_tcp_sendrecv_all_ports(backup_t)
 corenet_udp_sendrecv_all_ports(backup_t)
 corenet_tcp_connect_all_ports(backup_t)
 corenet_sendrecv_all_client_packets(backup_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(backup_t)
+	corenet_udp_recv_netlabel(backup_t)
+')
 
 dev_getattr_all_blk_files(backup_t)
 dev_getattr_all_chr_files(backup_t)
Index: refpolicy/policy/modules/admin/dpkg.te
===================================================================
--- refpolicy.orig/policy/modules/admin/dpkg.te
+++ refpolicy/policy/modules/admin/dpkg.te
@@ -101,6 +101,10 @@ corenet_tcp_sendrecv_all_ports(dpkg_t)
 corenet_udp_sendrecv_all_ports(dpkg_t)
 corenet_tcp_connect_all_ports(dpkg_t)
 corenet_sendrecv_all_client_packets(dpkg_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(dpkg_t)
+	corenet_udp_recv_netlabel(dpkg_t)
+')
 
 dev_list_sysfs(dpkg_t)
 dev_list_usbfs(dpkg_t)
Index: refpolicy/policy/modules/admin/mrtg.te
===================================================================
--- refpolicy.orig/policy/modules/admin/mrtg.te
+++ refpolicy/policy/modules/admin/mrtg.te
@@ -73,6 +73,10 @@ corenet_tcp_sendrecv_all_ports(mrtg_t)
 corenet_udp_sendrecv_all_ports(mrtg_t)
 corenet_tcp_connect_all_ports(mrtg_t)
 corenet_sendrecv_all_client_packets(mrtg_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(mrtg_t)
+	corenet_udp_recv_netlabel(mrtg_t)
+')
 
 dev_read_sysfs(mrtg_t)
 dev_read_urand(mrtg_t)
Index: refpolicy/policy/modules/admin/netutils.te
===================================================================
--- refpolicy.orig/policy/modules/admin/netutils.te
+++ refpolicy/policy/modules/admin/netutils.te
@@ -55,6 +55,10 @@ corenet_udp_sendrecv_all_ports(netutils_
 corenet_tcp_connect_all_ports(netutils_t)
 corenet_sendrecv_all_client_packets(netutils_t)
 corenet_udp_bind_generic_node(netutils_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(netutils_t)
+	corenet_udp_recv_netlabel(netutils_t)
+')
 
 fs_getattr_xattr_fs(netutils_t)
 
Index: refpolicy/policy/modules/admin/portage.if
===================================================================
--- refpolicy.orig/policy/modules/admin/portage.if
+++ refpolicy/policy/modules/admin/portage.if
@@ -163,6 +163,10 @@ interface(`portage_compile_domain',`
 	corenet_udp_sendrecv_all_ports($1)
 	corenet_tcp_connect_all_reserved_ports($1)
 	corenet_tcp_connect_distccd_port($1)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1)
+		corenet_udp_recv_netlabel($1)
+	')
 
 	dev_read_sysfs($1)
 	dev_read_rand($1)
Index: refpolicy/policy/modules/admin/rpm.te
===================================================================
--- refpolicy.orig/policy/modules/admin/rpm.te
+++ refpolicy/policy/modules/admin/rpm.te
@@ -102,6 +102,10 @@ corenet_tcp_sendrecv_all_ports(rpm_t)
 corenet_udp_sendrecv_all_ports(rpm_t)
 corenet_tcp_connect_all_ports(rpm_t)
 corenet_sendrecv_all_client_packets(rpm_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(rpm_t)
+	corenet_udp_recv_netlabel(rpm_t)
+')
 
 dev_list_sysfs(rpm_t)
 dev_list_usbfs(rpm_t)
Index: refpolicy/policy/modules/admin/sxid.te
===================================================================
--- refpolicy.orig/policy/modules/admin/sxid.te
+++ refpolicy/policy/modules/admin/sxid.te
@@ -50,6 +50,10 @@ corenet_tcp_sendrecv_all_nodes(sxid_t)
 corenet_udp_sendrecv_all_nodes(sxid_t)
 corenet_tcp_sendrecv_all_ports(sxid_t)
 corenet_udp_sendrecv_all_ports(sxid_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(sxid_t)
+	corenet_udp_recv_netlabel(sxid_t)
+')
 
 dev_read_sysfs(sxid_t)
 dev_getattr_all_blk_files(sxid_t)
Index: refpolicy/policy/modules/apps/calamaris.te
===================================================================
--- refpolicy.orig/policy/modules/apps/calamaris.te
+++ refpolicy/policy/modules/apps/calamaris.te
@@ -47,6 +47,10 @@ corenet_tcp_sendrecv_all_nodes(calamaris
 corenet_udp_sendrecv_all_nodes(calamaris_t)
 corenet_tcp_sendrecv_all_ports(calamaris_t)
 corenet_udp_sendrecv_all_ports(calamaris_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(calamaris_t)
+	corenet_udp_recv_netlabel(calamaris_t)
+')
 
 dev_read_urand(calamaris_t)
 
Index: refpolicy/policy/modules/apps/evolution.if
===================================================================
--- refpolicy.orig/policy/modules/apps/evolution.if
+++ refpolicy/policy/modules/apps/evolution.if
@@ -209,6 +209,10 @@ template(`evolution_per_role_template',`
 	corenet_sendrecv_innd_client_packets($1_evolution_t)
 	corenet_sendrecv_ldap_client_packets($1_evolution_t)
 	corenet_sendrecv_ipp_client_packets($1_evolution_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_evolution_t)
+		corenet_udp_recv_netlabel($1_evolution_t)
+	')
 	# not sure about this bind
 	corenet_udp_bind_all_nodes($1_evolution_t)
 	corenet_udp_bind_generic_port($1_evolution_t)
@@ -642,6 +646,9 @@ template(`evolution_per_role_template',`
 	corenet_tcp_connect_http_port($1_evolution_server_t)
 	corenet_sendrecv_http_client_packets($1_evolution_server_t)
 	corenet_sendrecv_http_cache_client_packets($1_evolution_server_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_evolution_server_t)
+	')
 
 	files_read_etc_files($1_evolution_server_t)
 	# Obtain weather data via http (read server name from xml file in /usr)
@@ -719,6 +726,9 @@ template(`evolution_per_role_template',`
 	corenet_tcp_connect_http_port($1_evolution_webcal_t)
 	corenet_sendrecv_http_client_packets($1_evolution_webcal_t)
 	corenet_sendrecv_http_cache_client_packets($1_evolution_webcal_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_evolution_webcal_t)
+	')
 
 	# Networking capability - connect to website and handle ics link
 	sysnet_read_config($1_evolution_webcal_t)
Index: refpolicy/policy/modules/apps/games.if
===================================================================
--- refpolicy.orig/policy/modules/apps/games.if
+++ refpolicy/policy/modules/apps/games.if
@@ -100,6 +100,10 @@ template(`games_per_role_template',`
 	corenet_tcp_connect_generic_port($1_games_t)
 	corenet_sendrecv_generic_client_packets($1_games_t)
 	corenet_sendrecv_generic_server_packets($1_games_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_games_t)
+		corenet_udp_recv_netlabel($1_games_t)
+	')
 
 	dev_read_sound($1_games_t)
 	dev_write_sound($1_games_t)
Index: refpolicy/policy/modules/apps/gift.if
===================================================================
--- refpolicy.orig/policy/modules/apps/gift.if
+++ refpolicy/policy/modules/apps/gift.if
@@ -102,6 +102,10 @@ template(`gift_per_role_template',`
 	corenet_tcp_sendrecv_giftd_port($1_gift_t)
 	corenet_tcp_connect_giftd_port($1_gift_t)
 	corenet_sendrecv_giftd_client_packets($1_gift_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_gift_t)
+		corenet_udp_recv_netlabel($1_gift_t)
+	')
 
 	fs_search_auto_mountpoints($1_gift_t)
 
@@ -168,6 +172,10 @@ template(`gift_per_role_template',`
 	corenet_udp_bind_all_ports($1_giftd_t)
 	corenet_tcp_connect_all_ports($1_giftd_t)
 	corenet_sendrecv_all_client_packets($1_giftd_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_giftd_t)
+		corenet_udp_recv_netlabel($1_giftd_t)
+	')
 
 	files_read_usr_files($1_giftd_t)
 	# Read /etc/mtab
Index: refpolicy/policy/modules/apps/gpg.if
===================================================================
--- refpolicy.orig/policy/modules/apps/gpg.if
+++ refpolicy/policy/modules/apps/gpg.if
@@ -105,6 +105,10 @@ template(`gpg_per_role_template',`
 	corenet_udp_sendrecv_all_ports($1_gpg_t)
 	corenet_tcp_connect_all_ports($1_gpg_t)
 	corenet_sendrecv_all_client_packets($1_gpg_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_gpg_t)
+		corenet_udp_recv_netlabel($1_gpg_t)
+	')
 
 	dev_read_rand($1_gpg_t)
 	dev_read_urand($1_gpg_t)
@@ -171,6 +175,10 @@ template(`gpg_per_role_template',`
 	corenet_tcp_bind_all_nodes($1_gpg_helper_t)
 	corenet_udp_bind_all_nodes($1_gpg_helper_t)
 	corenet_tcp_connect_all_ports($1_gpg_helper_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_gpg_helper_t)
+		corenet_udp_recv_netlabel($1_gpg_helper_t)
+	')
 
 	dev_read_urand($1_gpg_helper_t)
 
Index: refpolicy/policy/modules/apps/irc.if
===================================================================
--- refpolicy.orig/policy/modules/apps/irc.if
+++ refpolicy/policy/modules/apps/irc.if
@@ -98,6 +98,10 @@ template(`irc_per_role_template',`
 	corenet_tcp_sendrecv_all_ports($1_irc_t)
 	corenet_udp_sendrecv_all_ports($1_irc_t)
 	corenet_sendrecv_ircd_client_packets($1_irc_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_irc_t)
+		corenet_udp_recv_netlabel($1_irc_t)
+	')
 	# cjp: this seems excessive:
 	corenet_tcp_connect_all_ports($1_irc_t)
 	corenet_sendrecv_all_client_packets($1_irc_t)
Index: refpolicy/policy/modules/apps/java.if
===================================================================
--- refpolicy.orig/policy/modules/apps/java.if
+++ refpolicy/policy/modules/apps/java.if
@@ -106,6 +106,10 @@ template(`java_per_role_template',`
 	corenet_udp_sendrecv_all_ports($1_javaplugin_t)
 	corenet_tcp_connect_all_ports($1_javaplugin_t)
 	corenet_sendrecv_all_client_packets($1_javaplugin_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_javaplugin_t)
+		corenet_udp_recv_netlabel($1_javaplugin_t)
+	')
 
 	dev_read_sound($1_javaplugin_t)
 	dev_write_sound($1_javaplugin_t)
Index: refpolicy/policy/modules/apps/mozilla.if
===================================================================
--- refpolicy.orig/policy/modules/apps/mozilla.if
+++ refpolicy/policy/modules/apps/mozilla.if
@@ -142,6 +142,9 @@ template(`mozilla_per_role_template',`
 	corenet_sendrecv_ftp_client_packets($1_mozilla_t)
 	corenet_sendrecv_ipp_client_packets($1_mozilla_t)
 	corenet_sendrecv_generic_client_packets($1_mozilla_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_mozilla_t)
+	')
 	# Should not need other ports
 	corenet_dontaudit_tcp_sendrecv_generic_port($1_mozilla_t)
 	corenet_dontaudit_tcp_bind_generic_port($1_mozilla_t)
Index: refpolicy/policy/modules/apps/screen.if
===================================================================
--- refpolicy.orig/policy/modules/apps/screen.if
+++ refpolicy/policy/modules/apps/screen.if
@@ -124,6 +124,10 @@ template(`screen_per_role_template',`
 	corenet_tcp_sendrecv_all_ports($1_screen_t)
 	corenet_udp_sendrecv_all_ports($1_screen_t)
 	corenet_tcp_connect_all_ports($1_screen_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_screen_t)
+		corenet_udp_recv_netlabel($1_screen_t)
+	')
 
 	dev_dontaudit_getattr_all_chr_files($1_screen_t)
 	dev_dontaudit_getattr_all_blk_files($1_screen_t)
Index: refpolicy/policy/modules/apps/thunderbird.if
===================================================================
--- refpolicy.orig/policy/modules/apps/thunderbird.if
+++ refpolicy/policy/modules/apps/thunderbird.if
@@ -121,6 +121,9 @@ template(`thunderbird_per_role_template'
 	corenet_sendrecv_smtp_client_packets($1_thunderbird_t)
 	corenet_sendrecv_pop_client_packets($1_thunderbird_t)
 	corenet_sendrecv_http_client_packets($1_thunderbird_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_thunderbird_t)
+	')
 
 	files_list_tmp($1_thunderbird_t)
 	files_read_usr_files($1_thunderbird_t)
Index: refpolicy/policy/modules/apps/uml.if
===================================================================
--- refpolicy.orig/policy/modules/apps/uml.if
+++ refpolicy/policy/modules/apps/uml.if
@@ -159,6 +159,10 @@ template(`uml_per_role_template',`
 	corenet_tcp_connect_all_ports($1_uml_t)
 	corenet_sendrecv_all_client_packets($1_uml_t)
 	corenet_rw_tun_tap_dev($1_uml_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_uml_t)
+		corenet_udp_recv_netlabel($1_uml_t)
+	')
 	
 	domain_use_interactive_fds($1_uml_t)
 
Index: refpolicy/policy/modules/apps/vmware.te
===================================================================
--- refpolicy.orig/policy/modules/apps/vmware.te
+++ refpolicy/policy/modules/apps/vmware.te
@@ -58,6 +58,10 @@ corenet_raw_bind_all_nodes(vmware_host_t
 corenet_tcp_connect_all_ports(vmware_host_t)
 corenet_sendrecv_all_client_packets(vmware_host_t)
 corenet_sendrecv_all_server_packets(vmware_host_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(vmware_host_t)
+	corenet_udp_recv_netlabel(vmware_host_t)
+')
 
 dev_read_sysfs(vmware_host_t)
 dev_rw_vmware(vmware_host_t)
Index: refpolicy/policy/modules/apps/webalizer.te
===================================================================
--- refpolicy.orig/policy/modules/apps/webalizer.te
+++ refpolicy/policy/modules/apps/webalizer.te
@@ -65,6 +65,9 @@ corenet_non_ipsec_sendrecv(webalizer_t)
 corenet_tcp_sendrecv_all_if(webalizer_t)
 corenet_tcp_sendrecv_all_nodes(webalizer_t)
 corenet_tcp_sendrecv_all_ports(webalizer_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(webalizer_t)
+')
 
 fs_search_auto_mountpoints(webalizer_t)
 
Index: refpolicy/policy/modules/apps/yam.te
===================================================================
--- refpolicy.orig/policy/modules/apps/yam.te
+++ refpolicy/policy/modules/apps/yam.te
@@ -68,6 +68,9 @@ corenet_tcp_connect_http_port(yam_t)
 corenet_tcp_connect_rsync_port(yam_t)
 corenet_sendrecv_http_client_packets(yam_t)
 corenet_sendrecv_rsync_client_packets(yam_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(yam_t)
+')
 
 # mktemp
 dev_read_urand(yam_t)
Index: refpolicy/policy/modules/services/afs.te
===================================================================
--- refpolicy.orig/policy/modules/services/afs.te
+++ refpolicy/policy/modules/services/afs.te
@@ -99,6 +99,10 @@ corenet_udp_sendrecv_all_ports(afs_bosse
 corenet_udp_bind_all_nodes(afs_bosserver_t)
 corenet_udp_bind_afs_bos_port(afs_bosserver_t)
 corenet_sendrecv_afs_bos_server_packets(afs_bosserver_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(afs_bosserver_t)
+	corenet_udp_recv_netlabel(afs_bosserver_t)
+')
 
 files_read_etc_files(afs_bosserver_t)
 files_list_home(afs_bosserver_t)
@@ -159,6 +163,10 @@ corenet_udp_bind_all_nodes(afs_fsserver_
 corenet_tcp_bind_afs_fs_port(afs_fsserver_t)
 corenet_udp_bind_afs_fs_port(afs_fsserver_t)
 corenet_sendrecv_afs_fs_server_packets(afs_fsserver_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(afs_fsserver_t)
+	corenet_udp_recv_netlabel(afs_fsserver_t)
+')
 
 files_read_etc_files(afs_fsserver_t)
 files_read_etc_runtime_files(afs_fsserver_t)
@@ -218,6 +226,10 @@ corenet_udp_bind_afs_ka_port(afs_kaserve
 corenet_udp_bind_kerberos_port(afs_kaserver_t)
 corenet_sendrecv_afs_ka_server_packets(afs_kaserver_t)
 corenet_sendrecv_kerberos_server_packets(afs_kaserver_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(afs_kaserver_t)
+	corenet_udp_recv_netlabel(afs_kaserver_t)
+')
 
 files_read_etc_files(afs_kaserver_t)
 files_list_home(afs_kaserver_t)
@@ -263,6 +275,10 @@ corenet_udp_sendrecv_all_ports(afs_ptser
 corenet_udp_bind_all_nodes(afs_ptserver_t)
 corenet_udp_bind_afs_pt_port(afs_ptserver_t)
 corenet_sendrecv_afs_pt_server_packets(afs_ptserver_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(afs_ptserver_t)
+	corenet_udp_recv_netlabel(afs_ptserver_t)
+')
 
 files_read_etc_files(afs_ptserver_t)
 
@@ -304,6 +320,10 @@ corenet_udp_sendrecv_all_ports(afs_vlser
 corenet_udp_bind_all_nodes(afs_vlserver_t)
 corenet_udp_bind_afs_vl_port(afs_vlserver_t)
 corenet_sendrecv_afs_vl_server_packets(afs_vlserver_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(afs_vlserver_t)
+	corenet_udp_recv_netlabel(afs_vlserver_t)
+')
 
 files_read_etc_files(afs_vlserver_t)
 
Index: refpolicy/policy/modules/services/amavis.te
===================================================================
--- refpolicy.orig/policy/modules/services/amavis.te
+++ refpolicy/policy/modules/services/amavis.te
@@ -104,6 +104,9 @@ corenet_tcp_sendrecv_all_if(amavis_t)
 corenet_tcp_sendrecv_all_nodes(amavis_t)
 corenet_tcp_bind_all_nodes(amavis_t)
 corenet_udp_bind_all_nodes(amavis_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(amavis_t)
+')
 # amavis uses well-defined ports
 corenet_tcp_sendrecv_amavisd_recv_port(amavis_t)
 corenet_tcp_sendrecv_amavisd_send_port(amavis_t)
Index: refpolicy/policy/modules/services/apache.if
===================================================================
--- refpolicy.orig/policy/modules/services/apache.if
+++ refpolicy/policy/modules/services/apache.if
@@ -192,6 +192,10 @@ template(`apache_content_template',`
 		corenet_tcp_connect_mysqld_port(httpd_$1_script_t)
 		corenet_sendrecv_postgresql_client_packets(httpd_$1_script_t)
 		corenet_sendrecv_mysqld_client_packets(httpd_$1_script_t)
+		ifdef(`enable_mls',`
+			corenet_tcp_recv_netlabel(httpd_$1_script_t)
+			corenet_udp_recv_netlabel(httpd_$1_script_t)
+		')
 
 		sysnet_read_config(httpd_$1_script_t)
 	')
@@ -209,6 +213,10 @@ template(`apache_content_template',`
 		corenet_udp_sendrecv_all_ports(httpd_$1_script_t)
 		corenet_tcp_connect_all_ports(httpd_$1_script_t)
 		corenet_sendrecv_all_client_packets(httpd_$1_script_t)
+		ifdef(`enable_mls',`
+			corenet_tcp_recv_netlabel(httpd_$1_script_t)
+			corenet_udp_recv_netlabel(httpd_$1_script_t)
+		')
 
 		sysnet_read_config(httpd_$1_script_t)
 	')
Index: refpolicy/policy/modules/services/apache.te
===================================================================
--- refpolicy.orig/policy/modules/services/apache.te
+++ refpolicy/policy/modules/services/apache.te
@@ -223,6 +223,10 @@ corenet_tcp_bind_all_nodes(httpd_t)
 corenet_tcp_bind_http_port(httpd_t)
 corenet_tcp_bind_http_cache_port(httpd_t)
 corenet_sendrecv_http_server_packets(httpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(httpd_t)
+	corenet_udp_recv_netlabel(httpd_t)
+')
 # Signal self for shutdown
 corenet_tcp_connect_http_port(httpd_t)
 
@@ -570,6 +574,10 @@ tunable_policy(`httpd_can_network_connec
 	corenet_udp_sendrecv_all_ports(httpd_suexec_t)
 	corenet_tcp_connect_all_ports(httpd_suexec_t)
 	corenet_sendrecv_all_client_packets(httpd_suexec_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel(httpd_suexec_t)
+		corenet_udp_recv_netlabel(httpd_suexec_t)
+	')
 
 	sysnet_read_config(httpd_suexec_t)
 ')
Index: refpolicy/policy/modules/services/arpwatch.te
===================================================================
--- refpolicy.orig/policy/modules/services/arpwatch.te
+++ refpolicy/policy/modules/services/arpwatch.te
@@ -57,6 +57,10 @@ corenet_udp_sendrecv_all_nodes(arpwatch_
 corenet_raw_sendrecv_all_nodes(arpwatch_t)
 corenet_tcp_sendrecv_all_ports(arpwatch_t)
 corenet_udp_sendrecv_all_ports(arpwatch_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(arpwatch_t)
+	corenet_udp_recv_netlabel(arpwatch_t)
+')
 
 dev_read_sysfs(arpwatch_t)
 
Index: refpolicy/policy/modules/services/asterisk.te
===================================================================
--- refpolicy.orig/policy/modules/services/asterisk.te
+++ refpolicy/policy/modules/services/asterisk.te
@@ -94,6 +94,10 @@ corenet_udp_bind_all_nodes(asterisk_t)
 corenet_tcp_bind_asterisk_port(asterisk_t)
 corenet_udp_bind_asterisk_port(asterisk_t)
 corenet_sendrecv_asterisk_server_packets(asterisk_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(asterisk_t)
+	corenet_udp_recv_netlabel(asterisk_t)
+')
 # for VOIP voice channels.
 corenet_tcp_bind_generic_port(asterisk_t)
 corenet_udp_bind_generic_port(asterisk_t)
Index: refpolicy/policy/modules/services/automount.te
===================================================================
--- refpolicy.orig/policy/modules/services/automount.te
+++ refpolicy/policy/modules/services/automount.te
@@ -96,6 +96,10 @@ corenet_tcp_connect_portmap_port(automou
 corenet_tcp_connect_all_ports(automount_t)
 corenet_dontaudit_tcp_connect_all_reserved_ports(automount_t)
 corenet_sendrecv_all_client_packets(automount_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(automount_t)
+	corenet_udp_recv_netlabel(automount_t)
+')
 # Automount execs showmount when you browse /net.  This is required until
 # Someone writes a showmount policy
 corenet_tcp_bind_reserved_port(automount_t)
Index: refpolicy/policy/modules/services/avahi.te
===================================================================
--- refpolicy.orig/policy/modules/services/avahi.te
+++ refpolicy/policy/modules/services/avahi.te
@@ -51,6 +51,10 @@ corenet_tcp_bind_howl_port(avahi_t)
 corenet_udp_bind_howl_port(avahi_t)
 corenet_send_howl_client_packets(avahi_t)
 corenet_receive_howl_server_packets(avahi_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(avahi_t)
+	corenet_udp_recv_netlabel(avahi_t)
+')
 
 dev_read_sysfs(avahi_t)
 dev_read_urand(avahi_t)
Index: refpolicy/policy/modules/services/bind.te
===================================================================
--- refpolicy.orig/policy/modules/services/bind.te
+++ refpolicy/policy/modules/services/bind.te
@@ -110,6 +110,10 @@ corenet_sendrecv_dns_server_packets(name
 corenet_sendrecv_dns_client_packets(named_t)
 corenet_sendrecv_rndc_server_packets(named_t)
 corenet_sendrecv_rndc_client_packets(named_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(named_t)
+	corenet_udp_recv_netlabel(named_t)
+')
 
 dev_read_sysfs(named_t)
 dev_read_rand(named_t)
@@ -234,6 +238,9 @@ corenet_tcp_sendrecv_all_nodes(ndc_t)
 corenet_tcp_sendrecv_all_ports(ndc_t)
 corenet_tcp_connect_rndc_port(ndc_t)
 corenet_sendrecv_rndc_client_packets(ndc_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ndc_t)
+')
 
 fs_getattr_xattr_fs(ndc_t)
 
Index: refpolicy/policy/modules/services/bluetooth.te
===================================================================
--- refpolicy.orig/policy/modules/services/bluetooth.te
+++ refpolicy/policy/modules/services/bluetooth.te
@@ -90,6 +90,10 @@ corenet_udp_sendrecv_all_nodes(bluetooth
 corenet_raw_sendrecv_all_nodes(bluetooth_t)
 corenet_tcp_sendrecv_all_ports(bluetooth_t)
 corenet_udp_sendrecv_all_ports(bluetooth_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(bluetooth_t)
+	corenet_udp_recv_netlabel(bluetooth_t)
+')
 
 dev_read_sysfs(bluetooth_t)
 dev_rw_usbfs(bluetooth_t)
Index: refpolicy/policy/modules/services/canna.te
===================================================================
--- refpolicy.orig/policy/modules/services/canna.te
+++ refpolicy/policy/modules/services/canna.te
@@ -53,6 +53,9 @@ corenet_tcp_sendrecv_all_nodes(canna_t)
 corenet_tcp_sendrecv_all_ports(canna_t)
 corenet_tcp_connect_all_ports(canna_t)
 corenet_sendrecv_all_client_packets(canna_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(canna_t)
+')
 
 dev_read_sysfs(canna_t)
 
Index: refpolicy/policy/modules/services/ccs.te
===================================================================
--- refpolicy.orig/policy/modules/services/ccs.te
+++ refpolicy/policy/modules/services/ccs.te
@@ -69,6 +69,10 @@ corenet_udp_bind_all_nodes(ccs_t)
 corenet_tcp_bind_cluster_port(ccs_t)
 corenet_udp_bind_cluster_port(ccs_t)
 corenet_udp_bind_netsupport_port(ccs_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ccs_t)
+	corenet_udp_recv_netlabel(ccs_t)
+')
 
 dev_read_urand(ccs_t)
 
Index: refpolicy/policy/modules/services/cipe.te
===================================================================
--- refpolicy.orig/policy/modules/services/cipe.te
+++ refpolicy/policy/modules/services/cipe.te
@@ -35,6 +35,9 @@ corenet_udp_sendrecv_generic_if(ciped_t)
 corenet_udp_sendrecv_all_nodes(ciped_t)
 corenet_udp_sendrecv_all_ports(ciped_t)
 corenet_udp_bind_all_nodes(ciped_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(ciped_t)
+')
 # cipe uses the afs3-bos port (udp 7007)
 corenet_udp_bind_afs_bos_port(ciped_t)
 corenet_sendrecv_afs_bos_server_packets(ciped_t)
Index: refpolicy/policy/modules/services/clamav.te
===================================================================
--- refpolicy.orig/policy/modules/services/clamav.te
+++ refpolicy/policy/modules/services/clamav.te
@@ -94,6 +94,9 @@ corenet_tcp_sendrecv_clamd_port(clamd_t)
 corenet_tcp_bind_all_nodes(clamd_t)
 corenet_tcp_bind_clamd_port(clamd_t)
 corenet_sendrecv_clamd_server_packets(clamd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(clamd_t)
+')
 
 dev_read_rand(clamd_t)
 dev_read_urand(clamd_t)
@@ -169,6 +172,9 @@ corenet_tcp_sendrecv_all_ports(freshclam
 corenet_tcp_sendrecv_clamd_port(freshclam_t)
 corenet_tcp_connect_http_port(freshclam_t)
 corenet_sendrecv_http_client_packets(freshclam_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(freshclam_t)
+')
 
 dev_read_rand(freshclam_t)
 dev_read_urand(freshclam_t)
Index: refpolicy/policy/modules/services/clockspeed.te
===================================================================
--- refpolicy.orig/policy/modules/services/clockspeed.te
+++ refpolicy/policy/modules/services/clockspeed.te
@@ -33,6 +33,9 @@ corenet_udp_sendrecv_generic_if(clockspe
 corenet_udp_sendrecv_generic_node(clockspeed_cli_t)
 corenet_udp_sendrecv_ntp_port(clockspeed_cli_t)
 corenet_sendrecv_ntp_client_packets(clockspeed_cli_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(clockspeed_cli_t)
+')
 
 files_list_var_lib(clockspeed_cli_t)
 files_read_etc_files(clockspeed_cli_t)
@@ -62,6 +65,9 @@ corenet_udp_sendrecv_ntp_port(clockspeed
 corenet_udp_bind_all_nodes(clockspeed_srv_t)
 corenet_udp_bind_clockspeed_port(clockspeed_srv_t)
 corenet_sendrecv_clockspeed_server_packets(clockspeed_srv_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(clockspeed_srv_t)
+')
 
 files_read_etc_files(clockspeed_srv_t)
 files_list_var_lib(clockspeed_srv_t)
Index: refpolicy/policy/modules/services/comsat.te
===================================================================
--- refpolicy.orig/policy/modules/services/comsat.te
+++ refpolicy/policy/modules/services/comsat.te
@@ -46,6 +46,10 @@ corenet_udp_sendrecv_all_if(comsat_t)
 corenet_tcp_sendrecv_all_nodes(comsat_t)
 corenet_udp_sendrecv_all_nodes(comsat_t)
 corenet_udp_sendrecv_all_ports(comsat_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(comsat_t)
+	corenet_udp_recv_netlabel(comsat_t)
+')
 
 dev_read_urand(comsat_t)
 
Index: refpolicy/policy/modules/services/courier.if
===================================================================
--- refpolicy.orig/policy/modules/services/courier.if
+++ refpolicy/policy/modules/services/courier.if
@@ -55,6 +55,10 @@ template(`courier_domain_template',`
 	corenet_udp_sendrecv_all_nodes(courier_$1_t)
 	corenet_tcp_sendrecv_all_ports(courier_$1_t)
 	corenet_udp_sendrecv_all_ports(courier_$1_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel(courier_$1_t)
+		corenet_udp_recv_netlabel(courier_$1_t)
+	')
 
 	dev_read_sysfs(courier_$1_t)
 
Index: refpolicy/policy/modules/services/courier.te
===================================================================
--- refpolicy.orig/policy/modules/services/courier.te
+++ refpolicy/policy/modules/services/courier.te
@@ -121,6 +121,9 @@ corecmd_search_sbin(courier_tcpd_t)
 corenet_tcp_bind_all_nodes(courier_tcpd_t)
 corenet_tcp_bind_pop_port(courier_tcpd_t)
 corenet_sendrecv_pop_server_packets(courier_tcpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(courier_tcpd_t)
+')
 
 # for TLS
 dev_read_rand(courier_tcpd_t)
Index: refpolicy/policy/modules/services/cron.if
===================================================================
--- refpolicy.orig/policy/modules/services/cron.if
+++ refpolicy/policy/modules/services/cron.if
@@ -103,6 +103,10 @@ template(`cron_per_role_template',`
 	corenet_udp_sendrecv_all_ports($1_crond_t)
 	corenet_tcp_connect_all_ports($1_crond_t)
 	corenet_sendrecv_all_client_packets($1_crond_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_crond_t)
+		corenet_udp_recv_netlabel($1_crond_t)
+	')
 
 	dev_read_urand($1_crond_t)
 
Index: refpolicy/policy/modules/services/cron.te
===================================================================
--- refpolicy.orig/policy/modules/services/cron.te
+++ refpolicy/policy/modules/services/cron.te
@@ -321,6 +321,10 @@ ifdef(`targeted_policy',`
 	corenet_udp_sendrecv_all_nodes(system_crond_t)
 	corenet_tcp_sendrecv_all_ports(system_crond_t)
 	corenet_udp_sendrecv_all_ports(system_crond_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel(system_crond_t)
+		corenet_udp_recv_netlabel(system_crond_t)
+	')
 
 	dev_getattr_all_blk_files(system_crond_t)
 	dev_getattr_all_chr_files(system_crond_t)
Index: refpolicy/policy/modules/services/cups.te
===================================================================
--- refpolicy.orig/policy/modules/services/cups.te
+++ refpolicy/policy/modules/services/cups.te
@@ -156,6 +156,10 @@ corenet_tcp_connect_all_ports(cupsd_t)
 corenet_sendrecv_hplip_client_packets(cupsd_t)
 corenet_sendrecv_ipp_client_packets(cupsd_t)
 corenet_sendrecv_ipp_server_packets(cupsd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(cupsd_t)
+	corenet_udp_recv_netlabel(cupsd_t)
+')
 
 dev_rw_printer(cupsd_t)
 dev_read_urand(cupsd_t)
@@ -349,6 +353,10 @@ corenet_tcp_sendrecv_all_nodes(cupsd_con
 corenet_tcp_sendrecv_all_ports(cupsd_config_t)
 corenet_tcp_connect_all_ports(cupsd_config_t)
 corenet_sendrecv_all_client_packets(cupsd_config_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(cupsd_config_t)
+	corenet_udp_recv_netlabel(cupsd_config_t)
+')
 
 dev_read_sysfs(cupsd_config_t)
 dev_read_urand(cupsd_config_t)
@@ -509,6 +517,10 @@ corenet_udp_sendrecv_all_ports(cupsd_lpd
 corenet_tcp_bind_all_nodes(cupsd_lpd_t)
 corenet_udp_bind_all_nodes(cupsd_lpd_t)
 corenet_tcp_connect_ipp_port(cupsd_lpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(cupsd_lpd_t)
+	corenet_udp_recv_netlabel(cupsd_lpd_t)
+')
 
 dev_read_urand(cupsd_lpd_t)
 dev_read_rand(cupsd_lpd_t)
@@ -588,6 +600,10 @@ corenet_tcp_connect_hplip_port(hplip_t)
 corenet_tcp_connect_ipp_port(hplip_t)
 corenet_sendrecv_hplip_client_packets(hplip_t)
 corenet_receive_hplip_server_packets(hplip_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(hplip_t)
+	corenet_udp_recv_netlabel(hplip_t)
+')
 
 dev_read_sysfs(hplip_t)
 dev_rw_printer(hplip_t)
@@ -681,6 +697,9 @@ corenet_tcp_sendrecv_all_nodes(ptal_t)
 corenet_tcp_sendrecv_all_ports(ptal_t)
 corenet_tcp_bind_all_nodes(ptal_t)
 corenet_tcp_bind_ptal_port(ptal_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ptal_t)
+')
 
 dev_read_sysfs(ptal_t)
 dev_read_usbfs(ptal_t)
Index: refpolicy/policy/modules/services/cvs.te
===================================================================
--- refpolicy.orig/policy/modules/services/cvs.te
+++ refpolicy/policy/modules/services/cvs.te
@@ -54,6 +54,10 @@ corenet_tcp_sendrecv_all_nodes(cvs_t)
 corenet_udp_sendrecv_all_nodes(cvs_t)
 corenet_tcp_sendrecv_all_ports(cvs_t)
 corenet_udp_sendrecv_all_ports(cvs_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(cvs_t)
+	corenet_udp_recv_netlabel(cvs_t)
+')
 
 dev_read_urand(cvs_t)
 
Index: refpolicy/policy/modules/services/cyrus.te
===================================================================
--- refpolicy.orig/policy/modules/services/cyrus.te
+++ refpolicy/policy/modules/services/cyrus.te
@@ -77,6 +77,10 @@ corenet_sendrecv_mail_server_packets(cyr
 corenet_sendrecv_pop_server_packets(cyrus_t)
 corenet_sendrecv_lmtp_server_packets(cyrus_t)
 corenet_sendrecv_all_client_packets(cyrus_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(cyrus_t)
+	corenet_udp_recv_netlabel(cyrus_t)
+')
 
 dev_read_rand(cyrus_t)
 dev_read_urand(cyrus_t)
Index: refpolicy/policy/modules/services/dante.te
===================================================================
--- refpolicy.orig/policy/modules/services/dante.te
+++ refpolicy/policy/modules/services/dante.te
@@ -46,6 +46,10 @@ corenet_udp_sendrecv_all_nodes(dante_t)
 corenet_tcp_sendrecv_all_ports(dante_t)
 corenet_udp_sendrecv_all_ports(dante_t)
 corenet_tcp_bind_all_nodes(dante_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(dante_t)
+	corenet_udp_recv_netlabel(dante_t)
+')
 #TODO: no portcons for this type
 #allow dante_t socks_port_t:tcp_socket name_bind;
 
Index: refpolicy/policy/modules/services/dbskk.te
===================================================================
--- refpolicy.orig/policy/modules/services/dbskk.te
+++ refpolicy/policy/modules/services/dbskk.te
@@ -55,6 +55,10 @@ corenet_tcp_sendrecv_all_nodes(dbskkd_t)
 corenet_udp_sendrecv_all_nodes(dbskkd_t)
 corenet_tcp_sendrecv_all_ports(dbskkd_t)
 corenet_udp_sendrecv_all_ports(dbskkd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(dbskkd_t)
+	corenet_udp_recv_netlabel(dbskkd_t)
+')
 
 dev_read_urand(dbskkd_t)
 
Index: refpolicy/policy/modules/services/dbus.if
===================================================================
--- refpolicy.orig/policy/modules/services/dbus.if
+++ refpolicy/policy/modules/services/dbus.if
@@ -108,6 +108,9 @@ template(`dbus_per_role_template',`
 	corenet_tcp_sendrecv_all_ports($1_dbusd_t)
 	corenet_tcp_bind_all_nodes($1_dbusd_t)
 	corenet_tcp_bind_reserved_port($1_dbusd_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_dbusd_t)
+	')
 
 	dev_read_urand($1_dbusd_t)
 
Index: refpolicy/policy/modules/services/dcc.te
===================================================================
--- refpolicy.orig/policy/modules/services/dcc.te
+++ refpolicy/policy/modules/services/dcc.te
@@ -103,6 +103,9 @@ corenet_non_ipsec_sendrecv(cdcc_t)
 corenet_udp_sendrecv_generic_if(cdcc_t)
 corenet_udp_sendrecv_all_nodes(cdcc_t)
 corenet_udp_sendrecv_all_ports(cdcc_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(cdcc_t)
+')
 
 files_read_etc_files(cdcc_t)
 files_read_etc_runtime_files(cdcc_t)
@@ -145,6 +148,9 @@ corenet_non_ipsec_sendrecv(dcc_client_t)
 corenet_udp_sendrecv_generic_if(dcc_client_t)
 corenet_udp_sendrecv_all_nodes(dcc_client_t)
 corenet_udp_sendrecv_all_ports(dcc_client_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(dcc_client_t)
+')
 
 files_read_etc_files(dcc_client_t)
 files_read_etc_runtime_files(dcc_client_t)
@@ -187,6 +193,9 @@ corenet_non_ipsec_sendrecv(dcc_dbclean_t
 corenet_udp_sendrecv_generic_if(dcc_dbclean_t)
 corenet_udp_sendrecv_all_nodes(dcc_dbclean_t)
 corenet_udp_sendrecv_all_ports(dcc_dbclean_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(dcc_dbclean_t)
+')
 
 files_read_etc_files(dcc_dbclean_t)
 files_read_etc_runtime_files(dcc_dbclean_t)
@@ -250,6 +259,9 @@ corenet_udp_sendrecv_all_ports(dccd_t)
 corenet_udp_bind_all_nodes(dccd_t)
 corenet_udp_bind_dcc_port(dccd_t)
 corenet_sendrecv_dcc_server_packets(dccd_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(dccd_t)
+')
 
 dev_read_sysfs(dccd_t)
 
@@ -333,6 +345,9 @@ corenet_non_ipsec_sendrecv(dccifd_t)
 corenet_udp_sendrecv_generic_if(dccifd_t)
 corenet_udp_sendrecv_all_nodes(dccifd_t)
 corenet_udp_sendrecv_all_ports(dccifd_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(dccifd_t)
+')
 
 dev_read_sysfs(dccifd_t)
 
@@ -415,6 +430,9 @@ corenet_non_ipsec_sendrecv(dccm_t)
 corenet_udp_sendrecv_generic_if(dccm_t)
 corenet_udp_sendrecv_all_nodes(dccm_t)
 corenet_udp_sendrecv_all_ports(dccm_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(dccm_t)
+')
 
 dev_read_sysfs(dccm_t)
 
Index: refpolicy/policy/modules/services/ddclient.te
===================================================================
--- refpolicy.orig/policy/modules/services/ddclient.te
+++ refpolicy/policy/modules/services/ddclient.te
@@ -73,6 +73,10 @@ corenet_tcp_sendrecv_all_ports(ddclient_
 corenet_udp_sendrecv_all_ports(ddclient_t)
 corenet_tcp_connect_all_ports(ddclient_t)
 corenet_sendrecv_all_client_packets(ddclient_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ddclient_t)
+	corenet_udp_recv_netlabel(ddclient_t)
+')
 
 dev_read_sysfs(ddclient_t)
 dev_read_urand(ddclient_t)
Index: refpolicy/policy/modules/services/dictd.te
===================================================================
--- refpolicy.orig/policy/modules/services/dictd.te
+++ refpolicy/policy/modules/services/dictd.te
@@ -49,6 +49,10 @@ corenet_udp_sendrecv_all_ports(dictd_t)
 corenet_tcp_bind_all_nodes(dictd_t)
 corenet_tcp_bind_dict_port(dictd_t)
 corenet_sendrecv_dict_server_packets(dictd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(dictd_t)
+	corenet_udp_recv_netlabel(dictd_t)
+')
 
 dev_read_sysfs(dictd_t)
 
Index: refpolicy/policy/modules/services/distcc.te
===================================================================
--- refpolicy.orig/policy/modules/services/distcc.te
+++ refpolicy/policy/modules/services/distcc.te
@@ -54,6 +54,10 @@ corenet_udp_sendrecv_all_ports(distccd_t
 corenet_tcp_bind_all_nodes(distccd_t)
 corenet_tcp_bind_distccd_port(distccd_t)
 corenet_sendrecv_distccd_server_packets(distccd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(distccd_t)
+	corenet_udp_recv_netlabel(distccd_t)
+')
 
 dev_read_sysfs(distccd_t)
 
Index: refpolicy/policy/modules/services/djbdns.if
===================================================================
--- refpolicy.orig/policy/modules/services/djbdns.if
+++ refpolicy/policy/modules/services/djbdns.if
@@ -46,6 +46,10 @@ template(`djbdns_daemontools_domain_temp
 	corenet_udp_bind_generic_port(djbdns_$1_t)
 	corenet_sendrecv_dns_server_packets(djbdns_$1_t)
 	corenet_sendrecv_generic_server_packets(djbdns_$1_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel(djbdns_$1_t)
+		corenet_udp_recv_netlabel(djbdns_$1_t)
+	')
 
 	files_search_var(djbdns_$1_t)
 
Index: refpolicy/policy/modules/services/dnsmasq.te
===================================================================
--- refpolicy.orig/policy/modules/services/dnsmasq.te
+++ refpolicy/policy/modules/services/dnsmasq.te
@@ -58,6 +58,10 @@ corenet_udp_bind_dns_port(dnsmasq_t)
 corenet_udp_bind_dhcpd_port(dnsmasq_t)
 corenet_sendrecv_dns_server_packets(dnsmasq_t)
 corenet_sendrecv_dhcpd_server_packets(dnsmasq_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(dnsmasq_t)
+	corenet_udp_recv_netlabel(dnsmasq_t)
+')
 
 dev_read_sysfs(dnsmasq_t)
 dev_read_urand(dnsmasq_t)
Index: refpolicy/policy/modules/services/dovecot.te
===================================================================
--- refpolicy.orig/policy/modules/services/dovecot.te
+++ refpolicy/policy/modules/services/dovecot.te
@@ -79,6 +79,9 @@ corenet_tcp_connect_all_ports(dovecot_t)
 corenet_tcp_connect_postgresql_port(dovecot_t)
 corenet_sendrecv_pop_server_packets(dovecot_t)
 corenet_sendrecv_all_client_packets(dovecot_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(dovecot_t)
+')
 
 dev_read_sysfs(dovecot_t)
 dev_read_urand(dovecot_t)
Index: refpolicy/policy/modules/services/fetchmail.te
===================================================================
--- refpolicy.orig/policy/modules/services/fetchmail.te
+++ refpolicy/policy/modules/services/fetchmail.te
@@ -57,6 +57,10 @@ corenet_tcp_sendrecv_pop_port(fetchmail_
 corenet_tcp_sendrecv_smtp_port(fetchmail_t)
 corenet_tcp_connect_all_ports(fetchmail_t)
 corenet_sendrecv_all_client_packets(fetchmail_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(fetchmail_t)
+	corenet_udp_recv_netlabel(fetchmail_t)
+')
 
 dev_read_sysfs(fetchmail_t)
 dev_read_rand(fetchmail_t)
Index: refpolicy/policy/modules/services/finger.te
===================================================================
--- refpolicy.orig/policy/modules/services/finger.te
+++ refpolicy/policy/modules/services/finger.te
@@ -56,6 +56,10 @@ corenet_tcp_sendrecv_all_ports(fingerd_t
 corenet_udp_sendrecv_all_ports(fingerd_t)
 corenet_tcp_bind_all_nodes(fingerd_t)
 corenet_tcp_bind_fingerd_port(fingerd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(fingerd_t)
+	corenet_udp_recv_netlabel(fingerd_t)
+')
 
 dev_read_sysfs(fingerd_t)
 
Index: refpolicy/policy/modules/services/ftp.te
===================================================================
--- refpolicy.orig/policy/modules/services/ftp.te
+++ refpolicy/policy/modules/services/ftp.te
@@ -104,6 +104,10 @@ corenet_tcp_bind_ftp_data_port(ftpd_t)
 corenet_tcp_bind_generic_port(ftpd_t)
 corenet_tcp_connect_all_ports(ftpd_t)
 corenet_sendrecv_ftp_server_packets(ftpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ftpd_t)
+	corenet_udp_recv_netlabel(ftpd_t)
+')
 
 domain_use_interactive_fds(ftpd_t)
 
Index: refpolicy/policy/modules/services/gatekeeper.te
===================================================================
--- refpolicy.orig/policy/modules/services/gatekeeper.te
+++ refpolicy/policy/modules/services/gatekeeper.te
@@ -65,6 +65,10 @@ corenet_udp_bind_all_nodes(gatekeeper_t)
 corenet_tcp_bind_gatekeeper_port(gatekeeper_t)
 corenet_udp_bind_gatekeeper_port(gatekeeper_t)
 corenet_sendrecv_gatekeeper_server_packets(gatekeeper_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(gatekeeper_t)
+	corenet_udp_recv_netlabel(gatekeeper_t)
+')
 
 dev_read_sysfs(gatekeeper_t)
 # for SSP
Index: refpolicy/policy/modules/services/hal.te
===================================================================
--- refpolicy.orig/policy/modules/services/hal.te
+++ refpolicy/policy/modules/services/hal.te
@@ -70,6 +70,10 @@ corenet_tcp_sendrecv_all_nodes(hald_t)
 corenet_udp_sendrecv_all_nodes(hald_t)
 corenet_tcp_sendrecv_all_ports(hald_t)
 corenet_udp_sendrecv_all_ports(hald_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(hald_t)
+	corenet_udp_recv_netlabel(hald_t)
+')
 
 dev_rw_usbfs(hald_t)
 dev_read_urand(hald_t)
Index: refpolicy/policy/modules/services/howl.te
===================================================================
--- refpolicy.orig/policy/modules/services/howl.te
+++ refpolicy/policy/modules/services/howl.te
@@ -46,6 +46,10 @@ corenet_udp_bind_all_nodes(howl_t)
 corenet_tcp_bind_howl_port(howl_t)
 corenet_udp_bind_howl_port(howl_t)
 corenet_sendrecv_howl_server_packets(howl_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(howl_t)
+	corenet_udp_recv_netlabel(howl_t)
+')
 
 dev_read_sysfs(howl_t)
 
Index: refpolicy/policy/modules/services/i18n_input.te
===================================================================
--- refpolicy.orig/policy/modules/services/i18n_input.te
+++ refpolicy/policy/modules/services/i18n_input.te
@@ -49,6 +49,10 @@ corenet_tcp_bind_i18n_input_port(i18n_in
 corenet_tcp_connect_all_ports(i18n_input_t)
 corenet_sendrecv_i18n_input_server_packets(i18n_input_t)
 corenet_sendrecv_all_client_packets(i18n_input_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(i18n_input_t)
+	corenet_udp_recv_netlabel(i18n_input_t)
+')
 
 dev_read_sysfs(i18n_input_t)
 
Index: refpolicy/policy/modules/services/imaze.te
===================================================================
--- refpolicy.orig/policy/modules/services/imaze.te
+++ refpolicy/policy/modules/services/imaze.te
@@ -67,6 +67,10 @@ corenet_udp_bind_all_nodes(imazesrv_t)
 corenet_tcp_bind_imaze_port(imazesrv_t)
 corenet_udp_bind_imaze_port(imazesrv_t)
 corenet_sendrecv_imaze_server_packets(imazesrv_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(imazesrv_t)
+	corenet_udp_recv_netlabel(imazesrv_t)
+')
 
 dev_read_sysfs(imazesrv_t)
 
Index: refpolicy/policy/modules/services/inetd.te
===================================================================
--- refpolicy.orig/policy/modules/services/inetd.te
+++ refpolicy/policy/modules/services/inetd.te
@@ -68,6 +68,10 @@ corenet_tcp_bind_all_nodes(inetd_t)
 corenet_udp_bind_all_nodes(inetd_t)
 corenet_tcp_connect_all_ports(inetd_t)
 corenet_sendrecv_all_client_packets(inetd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(inetd_t)
+	corenet_udp_recv_netlabel(inetd_t)
+')
 
 # listen on service ports:
 corenet_tcp_bind_amanda_port(inetd_t)
Index: refpolicy/policy/modules/services/inn.te
===================================================================
--- refpolicy.orig/policy/modules/services/inn.te
+++ refpolicy/policy/modules/services/inn.te
@@ -75,6 +75,10 @@ corenet_tcp_bind_innd_port(innd_t)
 corenet_tcp_connect_all_ports(innd_t)
 corenet_sendrecv_innd_server_packets(innd_t)
 corenet_sendrecv_all_client_packets(innd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(innd_t)
+	corenet_udp_recv_netlabel(innd_t)
+')
 
 dev_read_sysfs(innd_t)
 dev_read_urand(innd_t)
Index: refpolicy/policy/modules/services/ircd.te
===================================================================
--- refpolicy.orig/policy/modules/services/ircd.te
+++ refpolicy/policy/modules/services/ircd.te
@@ -60,6 +60,10 @@ corenet_udp_sendrecv_all_ports(ircd_t)
 corenet_tcp_bind_all_nodes(ircd_t)
 corenet_tcp_bind_ircd_port(ircd_t)
 corenet_sendrecv_ircd_server_packets(ircd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ircd_t)
+	corenet_udp_recv_netlabel(ircd_t)
+')
 
 dev_read_sysfs(ircd_t)
 
Index: refpolicy/policy/modules/services/jabber.te
===================================================================
--- refpolicy.orig/policy/modules/services/jabber.te
+++ refpolicy/policy/modules/services/jabber.te
@@ -56,6 +56,10 @@ corenet_tcp_bind_jabber_client_port(jabb
 corenet_tcp_bind_jabber_interserver_port(jabberd_t)
 corenet_sendrecv_jabber_client_server_packets(jabberd_t)
 corenet_sendrecv_jabber_interserver_server_packets(jabberd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(jabberd_t)
+	corenet_udp_recv_netlabel(jabberd_t)
+')
 
 dev_read_sysfs(jabberd_t)
 # For SSL
Index: refpolicy/policy/modules/services/kerberos.if
===================================================================
--- refpolicy.orig/policy/modules/services/kerberos.if
+++ refpolicy/policy/modules/services/kerberos.if
@@ -59,6 +59,10 @@ interface(`kerberos_use',`
 		corenet_tcp_connect_ocsp_port($1)
 		corenet_sendrecv_kerberos_client_packets($1)
 		corenet_sendrecv_ocsp_client_packets($1)
+		ifdef(`enable_mls',`
+			corenet_tcp_recv_netlabel($1)
+			corenet_udp_recv_netlabel($1)
+		')
 
 		sysnet_read_config($1)
 		sysnet_dns_name_resolve($1)
Index: refpolicy/policy/modules/services/kerberos.te
===================================================================
--- refpolicy.orig/policy/modules/services/kerberos.te
+++ refpolicy/policy/modules/services/kerberos.te
@@ -99,6 +99,10 @@ corenet_udp_bind_kerberos_admin_port(kad
 corenet_tcp_bind_reserved_port(kadmind_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(kadmind_t)
 corenet_sendrecv_kerberos_admin_server_packets(kadmind_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(kadmind_t)
+	corenet_udp_recv_netlabel(kadmind_t)
+')
 
 dev_read_sysfs(kadmind_t)
 dev_read_rand(kadmind_t)
@@ -203,6 +207,10 @@ corenet_udp_bind_kerberos_port(krb5kdc_t
 corenet_tcp_connect_ocsp_port(krb5kdc_t)
 corenet_sendrecv_kerberos_server_packets(krb5kdc_t)
 corenet_sendrecv_ocsp_client_packets(krb5kdc_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(krb5kdc_t)
+	corenet_udp_recv_netlabel(krb5kdc_t)
+')
 
 dev_read_sysfs(krb5kdc_t)
 dev_read_urand(krb5kdc_t)
Index: refpolicy/policy/modules/services/ktalk.te
===================================================================
--- refpolicy.orig/policy/modules/services/ktalk.te
+++ refpolicy/policy/modules/services/ktalk.te
@@ -60,6 +60,10 @@ corenet_tcp_sendrecv_all_nodes(ktalkd_t)
 corenet_udp_sendrecv_all_nodes(ktalkd_t)
 corenet_tcp_sendrecv_all_ports(ktalkd_t)
 corenet_udp_sendrecv_all_ports(ktalkd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ktalkd_t)
+	corenet_udp_recv_netlabel(ktalkd_t)
+')
 
 dev_read_urand(ktalkd_t)
 
Index: refpolicy/policy/modules/services/ldap.te
===================================================================
--- refpolicy.orig/policy/modules/services/ldap.te
+++ refpolicy/policy/modules/services/ldap.te
@@ -89,6 +89,10 @@ corenet_tcp_bind_ldap_port(slapd_t)
 corenet_tcp_connect_all_ports(slapd_t)
 corenet_sendrecv_ldap_server_packets(slapd_t)
 corenet_sendrecv_all_client_packets(slapd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(slapd_t)
+	corenet_udp_recv_netlabel(slapd_t)
+')
 
 dev_read_urand(slapd_t)
 dev_read_sysfs(slapd_t)
Index: refpolicy/policy/modules/services/lpd.if
===================================================================
--- refpolicy.orig/policy/modules/services/lpd.if
+++ refpolicy/policy/modules/services/lpd.if
@@ -111,6 +111,10 @@ template(`lpd_per_role_template',`
 	corenet_udp_sendrecv_all_ports($1_lpr_t)
 	corenet_tcp_connect_all_ports($1_lpr_t)
 	corenet_sendrecv_all_client_packets($1_lpr_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_lpr_t)
+		corenet_udp_recv_netlabel($1_lpr_t)
+	')
 
 	dev_read_rand($1_lpr_t)
 	dev_read_urand($1_lpr_t)
Index: refpolicy/policy/modules/services/lpd.te
===================================================================
--- refpolicy.orig/policy/modules/services/lpd.te
+++ refpolicy/policy/modules/services/lpd.te
@@ -74,6 +74,10 @@ corenet_tcp_sendrecv_all_ports(checkpc_t
 corenet_udp_sendrecv_all_ports(checkpc_t)
 corenet_tcp_connect_all_ports(checkpc_t)
 corenet_sendrecv_all_client_packets(checkpc_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(checkpc_t)
+	corenet_udp_recv_netlabel(checkpc_t)
+')
 
 dev_append_printer(checkpc_t)
 
@@ -161,6 +165,10 @@ corenet_udp_sendrecv_all_ports(lpd_t)
 corenet_tcp_bind_all_nodes(lpd_t)
 corenet_tcp_bind_printer_port(lpd_t)
 corenet_sendrecv_printer_server_packets(lpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(lpd_t)
+	corenet_udp_recv_netlabel(lpd_t)
+')
 
 dev_read_sysfs(lpd_t)
 dev_rw_printer(lpd_t)
Index: refpolicy/policy/modules/services/mailman.if
===================================================================
--- refpolicy.orig/policy/modules/services/mailman.if
+++ refpolicy/policy/modules/services/mailman.if
@@ -61,6 +61,10 @@ template(`mailman_domain_template', `
 	corenet_udp_bind_all_nodes(mailman_$1_t)
 	corenet_tcp_connect_smtp_port(mailman_$1_t)
 	corenet_sendrecv_smtp_client_packets(mailman_$1_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel(mailman_$1_t)
+		corenet_udp_recv_netlabel(mailman_$1_t)
+	')
 
 	fs_getattr_xattr_fs(mailman_$1_t)
 
Index: refpolicy/policy/modules/services/monop.te
===================================================================
--- refpolicy.orig/policy/modules/services/monop.te
+++ refpolicy/policy/modules/services/monop.te
@@ -53,6 +53,10 @@ corenet_udp_sendrecv_all_ports(monopd_t)
 corenet_tcp_bind_all_nodes(monopd_t)
 corenet_tcp_bind_monopd_port(monopd_t)
 corenet_sendrecv_monopd_server_packets(monopd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(monopd_t)
+	corenet_udp_recv_netlabel(monopd_t)
+')
 
 dev_read_sysfs(monopd_t)
 
Index: refpolicy/policy/modules/services/mta.if
===================================================================
--- refpolicy.orig/policy/modules/services/mta.if
+++ refpolicy/policy/modules/services/mta.if
@@ -74,6 +74,9 @@ template(`mta_base_mail_template',`
 	corenet_tcp_connect_all_ports($1_mail_t)
 	corenet_tcp_connect_smtp_port($1_mail_t)
 	corenet_sendrecv_smtp_client_packets($1_mail_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_mail_t)
+	')
 
 	corecmd_exec_bin($1_mail_t)
 	corecmd_search_sbin($1_mail_t)
Index: refpolicy/policy/modules/services/munin.te
===================================================================
--- refpolicy.orig/policy/modules/services/munin.te
+++ refpolicy/policy/modules/services/munin.te
@@ -72,6 +72,10 @@ corenet_tcp_sendrecv_all_nodes(munin_t)
 corenet_udp_sendrecv_all_nodes(munin_t)
 corenet_tcp_sendrecv_all_ports(munin_t)
 corenet_udp_sendrecv_all_ports(munin_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(munin_t)
+	corenet_udp_recv_netlabel(munin_t)
+')
 
 dev_read_sysfs(munin_t)
 dev_read_urand(munin_t)
Index: refpolicy/policy/modules/services/mysql.te
===================================================================
--- refpolicy.orig/policy/modules/services/mysql.te
+++ refpolicy/policy/modules/services/mysql.te
@@ -73,6 +73,10 @@ corenet_tcp_bind_mysqld_port(mysqld_t)
 corenet_tcp_connect_mysqld_port(mysqld_t)
 corenet_sendrecv_mysqld_client_packets(mysqld_t)
 corenet_sendrecv_mysqld_server_packets(mysqld_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(mysqld_t)
+	corenet_udp_recv_netlabel(mysqld_t)
+')
 
 dev_read_sysfs(mysqld_t)
 
Index: refpolicy/policy/modules/services/nagios.te
===================================================================
--- refpolicy.orig/policy/modules/services/nagios.te
+++ refpolicy/policy/modules/services/nagios.te
@@ -73,6 +73,10 @@ corenet_tcp_sendrecv_all_nodes(nagios_t)
 corenet_udp_sendrecv_all_nodes(nagios_t)
 corenet_tcp_sendrecv_all_ports(nagios_t)
 corenet_udp_sendrecv_all_ports(nagios_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(nagios_t)
+	corenet_udp_recv_netlabel(nagios_t)
+')
 
 dev_read_sysfs(nagios_t)
 
Index: refpolicy/policy/modules/services/nessus.te
===================================================================
--- refpolicy.orig/policy/modules/services/nessus.te
+++ refpolicy/policy/modules/services/nessus.te
@@ -71,6 +71,10 @@ corenet_tcp_bind_nessus_port(nessusd_t)
 corenet_tcp_connect_all_ports(nessusd_t)
 corenet_sendrecv_all_client_packets(nessusd_t)
 corenet_sendrecv_nessus_server_packets(nessusd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(nessusd_t)
+	corenet_udp_recv_netlabel(nessusd_t)
+')
 
 dev_read_sysfs(nessusd_t)
 dev_read_urand(nessusd_t)
Index: refpolicy/policy/modules/services/networkmanager.te
===================================================================
--- refpolicy.orig/policy/modules/services/networkmanager.te
+++ refpolicy/policy/modules/services/networkmanager.te
@@ -57,6 +57,10 @@ corenet_tcp_connect_all_ports(NetworkMan
 corenet_sendrecv_isakmp_server_packets(NetworkManager_t)
 corenet_sendrecv_dhcpc_server_packets(NetworkManager_t)
 corenet_sendrecv_all_client_packets(NetworkManager_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(NetworkManager_t)
+	corenet_udp_recv_netlabel(NetworkManager_t)
+')
 
 dev_read_sysfs(NetworkManager_t)
 dev_read_rand(NetworkManager_t)
Index: refpolicy/policy/modules/services/nis.if
===================================================================
--- refpolicy.orig/policy/modules/services/nis.if
+++ refpolicy/policy/modules/services/nis.if
@@ -59,6 +59,10 @@ interface(`nis_use_ypbind_uncond',`
 	corenet_sendrecv_portmap_client_packets($1)
 	corenet_sendrecv_generic_client_packets($1)
 	corenet_sendrecv_generic_server_packets($1)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1)
+		corenet_udp_recv_netlabel($1)
+	')
 
 	sysnet_read_config($1)
 ')
Index: refpolicy/policy/modules/services/nis.te
===================================================================
--- refpolicy.orig/policy/modules/services/nis.te
+++ refpolicy/policy/modules/services/nis.te
@@ -89,6 +89,10 @@ corenet_dontaudit_tcp_bind_all_reserved_
 corenet_dontaudit_udp_bind_all_reserved_ports(ypbind_t)
 corenet_sendrecv_all_client_packets(ypbind_t)
 corenet_sendrecv_generic_server_packets(ypbind_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ypbind_t)
+	corenet_udp_recv_netlabel(ypbind_t)
+')
 
 dev_read_sysfs(ypbind_t)
 
@@ -171,6 +175,10 @@ corenet_udp_bind_reserved_port(yppasswdd
 corenet_dontaudit_tcp_bind_all_reserved_ports(yppasswdd_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(yppasswdd_t)
 corenet_sendrecv_generic_server_packets(yppasswdd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(yppasswdd_t)
+	corenet_udp_recv_netlabel(yppasswdd_t)
+')
 
 dev_read_sysfs(yppasswdd_t)
 
@@ -272,6 +280,10 @@ corenet_udp_bind_reserved_port(ypserv_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(ypserv_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(ypserv_t)
 corenet_sendrecv_generic_server_packets(ypserv_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ypserv_t)
+	corenet_udp_recv_netlabel(ypserv_t)
+')
 
 dev_read_sysfs(ypserv_t)
 
@@ -346,6 +358,10 @@ corenet_dontaudit_udp_bind_all_reserved_
 corenet_tcp_connect_all_ports(ypxfr_t)
 corenet_sendrecv_generic_server_packets(ypxfr_t)
 corenet_sendrecv_all_client_packets(ypxfr_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ypxfr_t)
+	corenet_udp_recv_netlabel(ypxfr_t)
+')
 
 files_read_etc_files(ypxfr_t)
 files_search_usr(ypxfr_t)
Index: refpolicy/policy/modules/services/nscd.te
===================================================================
--- refpolicy.orig/policy/modules/services/nscd.te
+++ refpolicy/policy/modules/services/nscd.te
@@ -77,6 +77,10 @@ corenet_udp_sendrecv_all_ports(nscd_t)
 corenet_tcp_connect_all_ports(nscd_t)
 corenet_sendrecv_all_client_packets(nscd_t)
 corenet_rw_tun_tap_dev(nscd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(nscd_t)
+	corenet_udp_recv_netlabel(nscd_t)
+')
 
 selinux_get_fs_mount(nscd_t)
 selinux_validate_context(nscd_t)
Index: refpolicy/policy/modules/services/nsd.te
===================================================================
--- refpolicy.orig/policy/modules/services/nsd.te
+++ refpolicy/policy/modules/services/nsd.te
@@ -74,6 +74,10 @@ corenet_udp_bind_all_nodes(nsd_t)
 corenet_tcp_bind_dns_port(nsd_t)
 corenet_udp_bind_dns_port(nsd_t)
 corenet_sendrecv_dns_server_packets(nsd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(nsd_t)
+	corenet_udp_recv_netlabel(nsd_t)
+')
 
 dev_read_sysfs(nsd_t)
 
@@ -163,6 +167,10 @@ corenet_tcp_sendrecv_all_ports(nsd_crond
 corenet_udp_sendrecv_all_ports(nsd_crond_t)
 corenet_tcp_connect_all_ports(nsd_crond_t)
 corenet_sendrecv_all_client_packets(nsd_crond_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(nsd_crond_t)
+	corenet_udp_recv_netlabel(nsd_crond_t)
+')
 
 # for SSP
 dev_read_urand(nsd_crond_t)
Index: refpolicy/policy/modules/services/ntop.te
===================================================================
--- refpolicy.orig/policy/modules/services/ntop.te
+++ refpolicy/policy/modules/services/ntop.te
@@ -70,6 +70,10 @@ corenet_udp_sendrecv_all_nodes(ntop_t)
 corenet_raw_sendrecv_all_nodes(ntop_t)
 corenet_tcp_sendrecv_all_ports(ntop_t)
 corenet_udp_sendrecv_all_ports(ntop_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ntop_t)
+	corenet_udp_recv_netlabel(ntop_t)
+')
 
 dev_read_sysfs(ntop_t)
 
Index: refpolicy/policy/modules/services/ntp.te
===================================================================
--- refpolicy.orig/policy/modules/services/ntp.te
+++ refpolicy/policy/modules/services/ntp.te
@@ -74,6 +74,10 @@ corenet_udp_bind_ntp_port(ntpd_t)
 corenet_tcp_connect_ntp_port(ntpd_t)
 corenet_sendrecv_ntp_server_packets(ntpd_t)
 corenet_sendrecv_ntp_client_packets(ntpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ntpd_t)
+	corenet_udp_recv_netlabel(ntpd_t)
+')
 
 dev_read_sysfs(ntpd_t)
 # for SSP
Index: refpolicy/policy/modules/services/nx.te
===================================================================
--- refpolicy.orig/policy/modules/services/nx.te
+++ refpolicy/policy/modules/services/nx.te
@@ -60,6 +60,10 @@ corenet_tcp_sendrecv_all_ports(nx_server
 corenet_udp_sendrecv_all_ports(nx_server_t)
 corenet_tcp_connect_all_ports(nx_server_t)
 corenet_sendrecv_all_client_packets(nx_server_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(nx_server_t)
+	corenet_udp_recv_netlabel(nx_server_t)
+')
 
 dev_read_urand(nx_server_t)
 
Index: refpolicy/policy/modules/services/oav.te
===================================================================
--- refpolicy.orig/policy/modules/services/oav.te
+++ refpolicy/policy/modules/services/oav.te
@@ -57,6 +57,10 @@ corenet_tcp_sendrecv_all_nodes(oav_updat
 corenet_udp_sendrecv_all_nodes(oav_update_t)
 corenet_tcp_sendrecv_all_ports(oav_update_t)
 corenet_udp_sendrecv_all_ports(oav_update_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(oav_update_t)
+	corenet_udp_recv_netlabel(oav_update_t)
+')
 
 files_exec_etc_files(oav_update_t)
 
@@ -111,6 +115,10 @@ corenet_tcp_sendrecv_all_nodes(scannerda
 corenet_udp_sendrecv_all_nodes(scannerdaemon_t)
 corenet_tcp_sendrecv_all_ports(scannerdaemon_t)
 corenet_udp_sendrecv_all_ports(scannerdaemon_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(scannerdaemon_t)
+	corenet_udp_recv_netlabel(scannerdaemon_t)
+')
 
 dev_read_sysfs(scannerdaemon_t)
 
Index: refpolicy/policy/modules/services/pegasus.te
===================================================================
--- refpolicy.orig/policy/modules/services/pegasus.te
+++ refpolicy/policy/modules/services/pegasus.te
@@ -83,6 +83,9 @@ corenet_sendrecv_pegasus_http_client_pac
 corenet_sendrecv_pegasus_http_server_packets(pegasus_t)
 corenet_sendrecv_pegasus_https_client_packets(pegasus_t)
 corenet_sendrecv_pegasus_https_server_packets(pegasus_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(pegasus_t)
+')
 
 corecmd_exec_sbin(pegasus_t)
 corecmd_exec_bin(pegasus_t)
Index: refpolicy/policy/modules/services/perdition.te
===================================================================
--- refpolicy.orig/policy/modules/services/perdition.te
+++ refpolicy/policy/modules/services/perdition.te
@@ -47,6 +47,10 @@ corenet_udp_sendrecv_all_ports(perdition
 corenet_tcp_bind_all_nodes(perdition_t)
 corenet_tcp_bind_pop_port(perdition_t)
 corenet_sendrecv_pop_server_packets(perdition_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(perdition_t)
+	corenet_udp_recv_netlabel(perdition_t)
+')
 
 dev_read_sysfs(perdition_t)
 
Index: refpolicy/policy/modules/services/portmap.te
===================================================================
--- refpolicy.orig/policy/modules/services/portmap.te
+++ refpolicy/policy/modules/services/portmap.te
@@ -59,6 +59,10 @@ corenet_udp_bind_portmap_port(portmap_t)
 corenet_tcp_connect_all_ports(portmap_t)
 corenet_sendrecv_portmap_client_packets(portmap_t)
 corenet_sendrecv_portmap_server_packets(portmap_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(portmap_t)
+	corenet_udp_recv_netlabel(portmap_t)
+')
 # portmap binds to arbitary ports
 corenet_tcp_bind_generic_port(portmap_t)
 corenet_udp_bind_generic_port(portmap_t)
@@ -144,6 +148,10 @@ corenet_udp_bind_reserved_port(portmap_h
 corenet_dontaudit_tcp_bind_all_reserved_ports(portmap_helper_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(portmap_helper_t)
 corenet_tcp_connect_all_ports(portmap_helper_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(portmap_helper_t)
+	corenet_udp_recv_netlabel(portmap_helper_t)
+')
 
 domain_dontaudit_use_interactive_fds(portmap_helper_t)
 
Index: refpolicy/policy/modules/services/portslave.te
===================================================================
--- refpolicy.orig/policy/modules/services/portslave.te
+++ refpolicy/policy/modules/services/portslave.te
@@ -63,6 +63,10 @@ corenet_udp_sendrecv_all_nodes(portslave
 corenet_tcp_sendrecv_all_ports(portslave_t)
 corenet_udp_sendrecv_all_ports(portslave_t)
 corenet_rw_ppp_dev(portslave_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(portslave_t)
+	corenet_udp_recv_netlabel(portslave_t)
+')
 
 dev_read_sysfs(portslave_t)
 # for ssh
Index: refpolicy/policy/modules/services/postfix.if
===================================================================
--- refpolicy.orig/policy/modules/services/postfix.if
+++ refpolicy/policy/modules/services/postfix.if
@@ -140,6 +140,10 @@ template(`postfix_server_domain_template
 	corenet_udp_bind_all_nodes(postfix_$1_t)
 	corenet_tcp_connect_all_ports(postfix_$1_t)
 	corenet_sendrecv_all_client_packets(postfix_$1_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel(postfix_$1_t)
+		corenet_udp_recv_netlabel(postfix_$1_t)
+	')
 
 	sysnet_read_config(postfix_$1_t)
 
Index: refpolicy/policy/modules/services/postfix.te
===================================================================
--- refpolicy.orig/policy/modules/services/postfix.te
+++ refpolicy/policy/modules/services/postfix.te
@@ -147,6 +147,10 @@ corenet_tcp_connect_all_ports(postfix_ma
 corenet_sendrecv_amavisd_send_server_packets(postfix_master_t)
 corenet_sendrecv_smtp_server_packets(postfix_master_t)
 corenet_sendrecv_all_client_packets(postfix_master_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(postfix_master_t)
+	corenet_udp_recv_netlabel(postfix_master_t)
+')
 
 # for a find command
 selinux_dontaudit_search_fs(postfix_master_t)
@@ -322,6 +326,10 @@ corenet_tcp_sendrecv_all_ports(postfix_m
 corenet_udp_sendrecv_all_ports(postfix_map_t)
 corenet_tcp_connect_all_ports(postfix_map_t)
 corenet_sendrecv_all_client_packets(postfix_map_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(postfix_map_t)
+	corenet_udp_recv_netlabel(postfix_map_t)
+')
 
 corecmd_list_bin(postfix_map_t)
 corecmd_read_bin_symlinks(postfix_map_t)
@@ -431,6 +439,9 @@ manage_files_pattern(postfix_postdrop_t,
 
 corenet_udp_sendrecv_all_if(postfix_postdrop_t)
 corenet_udp_sendrecv_all_nodes(postfix_postdrop_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(postfix_postdrop_t)
+')
 
 term_dontaudit_use_all_user_ptys(postfix_postdrop_t)
 term_dontaudit_use_all_user_ttys(postfix_postdrop_t)
Index: refpolicy/policy/modules/services/postgresql.te
===================================================================
--- refpolicy.orig/policy/modules/services/postgresql.te
+++ refpolicy/policy/modules/services/postgresql.te
@@ -94,6 +94,10 @@ corenet_tcp_bind_postgresql_port(postgre
 corenet_tcp_connect_auth_port(postgresql_t)
 corenet_sendrecv_postgresql_server_packets(postgresql_t)
 corenet_sendrecv_auth_client_packets(postgresql_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(postgresql_t)
+	corenet_udp_recv_netlabel(postgresql_t)
+')
 
 dev_read_sysfs(postgresql_t)
 dev_read_urand(postgresql_t)
Index: refpolicy/policy/modules/services/postgrey.te
===================================================================
--- refpolicy.orig/policy/modules/services/postgrey.te
+++ refpolicy/policy/modules/services/postgrey.te
@@ -54,6 +54,9 @@ corenet_tcp_sendrecv_all_ports(postgrey_
 corenet_tcp_bind_all_nodes(postgrey_t)
 corenet_tcp_bind_postgrey_port(postgrey_t)
 corenet_sendrecv_postgrey_server_packets(postgrey_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(postgrey_t)
+')
 
 dev_read_urand(postgrey_t)
 dev_read_sysfs(postgrey_t)
Index: refpolicy/policy/modules/services/ppp.te
===================================================================
--- refpolicy.orig/policy/modules/services/ppp.te
+++ refpolicy/policy/modules/services/ppp.te
@@ -119,6 +119,10 @@ corenet_raw_sendrecv_all_nodes(pppd_t)
 corenet_udp_sendrecv_all_nodes(pppd_t)
 corenet_tcp_sendrecv_all_ports(pppd_t)
 corenet_udp_sendrecv_all_ports(pppd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(pppd_t)
+	corenet_udp_recv_netlabel(pppd_t)
+')
 # Access /dev/ppp.
 corenet_rw_ppp_dev(pppd_t)
 
@@ -270,6 +274,9 @@ corenet_tcp_bind_all_nodes(pptp_t)
 corenet_tcp_connect_generic_port(pptp_t)
 corenet_tcp_connect_all_reserved_ports(pptp_t)
 corenet_sendrecv_generic_client_packets(pptp_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(pptp_t)
+')
 
 fs_getattr_all_fs(pptp_t)
 fs_search_auto_mountpoints(pptp_t)
Index: refpolicy/policy/modules/services/privoxy.te
===================================================================
--- refpolicy.orig/policy/modules/services/privoxy.te
+++ refpolicy/policy/modules/services/privoxy.te
@@ -55,6 +55,9 @@ corenet_sendrecv_http_cache_server_packe
 corenet_sendrecv_http_client_packets(privoxy_t)
 corenet_sendrecv_ftp_client_packets(privoxy_t)
 corenet_sendrecv_tor_client_packets(privoxy_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(privoxy_t)
+')
 
 dev_read_sysfs(privoxy_t)
 
Index: refpolicy/policy/modules/services/procmail.te
===================================================================
--- refpolicy.orig/policy/modules/services/procmail.te
+++ refpolicy/policy/modules/services/procmail.te
@@ -39,6 +39,10 @@ corenet_udp_bind_all_nodes(procmail_t)
 corenet_tcp_connect_spamd_port(procmail_t)
 corenet_sendrecv_spamd_client_packets(procmail_t)
 corenet_sendrecv_comsat_client_packets(procmail_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(procmail_t)
+	corenet_udp_recv_netlabel(procmail_t)
+')
 
 dev_read_urand(procmail_t)
 
Index: refpolicy/policy/modules/services/pyzor.te
===================================================================
--- refpolicy.orig/policy/modules/services/pyzor.te
+++ refpolicy/policy/modules/services/pyzor.te
@@ -46,6 +46,9 @@ corecmd_getattr_bin_files(pyzor_t)
 corenet_udp_sendrecv_all_if(pyzor_t)
 corenet_udp_sendrecv_all_nodes(pyzor_t)
 corenet_udp_sendrecv_all_ports(pyzor_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(pyzor_t)
+')
 
 dev_read_urand(pyzor_t)
 
@@ -103,6 +106,9 @@ corenet_udp_sendrecv_all_ports(pyzord_t)
 corenet_udp_bind_all_nodes(pyzord_t)
 corenet_udp_bind_pyzor_port(pyzord_t)
 corenet_sendrecv_pyzor_server_packets(pyzord_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(pyzord_t)
+')
 
 files_read_etc_files(pyzord_t)
 
Index: refpolicy/policy/modules/services/qmail.te
===================================================================
--- refpolicy.orig/policy/modules/services/qmail.te
+++ refpolicy/policy/modules/services/qmail.te
@@ -182,6 +182,10 @@ corenet_tcp_sendrecv_smtp_port(qmail_rem
 corenet_udp_sendrecv_dns_port(qmail_remote_t)
 corenet_tcp_connect_smtp_port(qmail_remote_t)
 corenet_sendrecv_smtp_client_packets(qmail_remote_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(qmail_remote_t)
+	corenet_udp_recv_netlabel(qmail_remote_t)
+')
 
 dev_read_rand(qmail_remote_t)
 dev_read_urand(qmail_remote_t)
Index: refpolicy/policy/modules/services/radius.te
===================================================================
--- refpolicy.orig/policy/modules/services/radius.te
+++ refpolicy/policy/modules/services/radius.te
@@ -69,6 +69,10 @@ corenet_udp_bind_radacct_port(radiusd_t)
 corenet_udp_bind_radius_port(radiusd_t)
 corenet_sendrecv_radius_server_packets(radiusd_t)
 corenet_sendrecv_radacct_server_packets(radiusd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(radiusd_t)
+	corenet_udp_recv_netlabel(radiusd_t)
+')
 # for RADIUS proxy port
 corenet_udp_bind_generic_port(radiusd_t)
 corenet_sendrecv_generic_server_packets(radiusd_t)
Index: refpolicy/policy/modules/services/radvd.te
===================================================================
--- refpolicy.orig/policy/modules/services/radvd.te
+++ refpolicy/policy/modules/services/radvd.te
@@ -47,6 +47,10 @@ corenet_udp_sendrecv_all_nodes(radvd_t)
 corenet_raw_sendrecv_all_nodes(radvd_t)
 corenet_tcp_sendrecv_all_ports(radvd_t)
 corenet_udp_sendrecv_all_ports(radvd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(radvd_t)
+	corenet_udp_recv_netlabel(radvd_t)
+')
 
 dev_read_sysfs(radvd_t)
 
Index: refpolicy/policy/modules/services/razor.if
===================================================================
--- refpolicy.orig/policy/modules/services/razor.if
+++ refpolicy/policy/modules/services/razor.if
@@ -70,6 +70,9 @@ template(`razor_common_domain_template',
 	corenet_tcp_sendrecv_all_nodes($1_t)
 	corenet_raw_sendrecv_all_nodes($1_t)
 	corenet_tcp_sendrecv_razor_port($1_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_t)
+	')
 
 	# mktemp and other randoms
 	dev_read_rand($1_t)
Index: refpolicy/policy/modules/services/razor.te
===================================================================
--- refpolicy.orig/policy/modules/services/razor.te
+++ refpolicy/policy/modules/services/razor.te
@@ -48,6 +48,9 @@ corenet_raw_sendrecv_all_nodes(razor_t)
 corenet_tcp_sendrecv_razor_port(razor_t)
 corenet_tcp_connect_razor_port(razor_t)
 corenet_sendrecv_razor_client_packets(razor_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(razor_t)
+')
 
 sysnet_read_config(razor_t)
 
Index: refpolicy/policy/modules/services/rdisc.te
===================================================================
--- refpolicy.orig/policy/modules/services/rdisc.te
+++ refpolicy/policy/modules/services/rdisc.te
@@ -32,6 +32,9 @@ corenet_raw_sendrecv_generic_if(rdisc_t)
 corenet_udp_sendrecv_all_nodes(rdisc_t)
 corenet_raw_sendrecv_all_nodes(rdisc_t)
 corenet_udp_sendrecv_all_ports(rdisc_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(rdisc_t)
+')
 
 dev_read_sysfs(rdisc_t)
 
Index: refpolicy/policy/modules/services/rhgb.te
===================================================================
--- refpolicy.orig/policy/modules/services/rhgb.te
+++ refpolicy/policy/modules/services/rhgb.te
@@ -54,6 +54,10 @@ corenet_tcp_sendrecv_all_ports(rhgb_t)
 corenet_udp_sendrecv_all_ports(rhgb_t)
 corenet_tcp_connect_all_ports(rhgb_t)
 corenet_sendrecv_all_client_packets(rhgb_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(rhgb_t)
+	corenet_udp_recv_netlabel(rhgb_t)
+')
 
 dev_read_sysfs(rhgb_t)
 
Index: refpolicy/policy/modules/services/ricci.te
===================================================================
--- refpolicy.orig/policy/modules/services/ricci.te
+++ refpolicy/policy/modules/services/ricci.te
@@ -127,6 +127,10 @@ corenet_udp_bind_all_nodes(ricci_t)
 corenet_tcp_bind_ricci_port(ricci_t)
 corenet_udp_bind_ricci_port(ricci_t)
 corenet_tcp_connect_http_port(ricci_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ricci_t)
+	corenet_udp_recv_netlabel(ricci_t)
+')
 
 dev_read_urand(ricci_t)
 
@@ -296,6 +300,9 @@ corenet_tcp_sendrecv_all_ports(ricci_mod
 corenet_tcp_bind_all_nodes(ricci_modclusterd_t)
 corenet_tcp_bind_ricci_modcluster_port(ricci_modclusterd_t)
 corenet_tcp_connect_ricci_modcluster_port(ricci_modclusterd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ricci_modclusterd_t)
+')
 
 domain_dontaudit_read_all_domains_state(ricci_modclusterd_t)
 
Index: refpolicy/policy/modules/services/rlogin.te
===================================================================
--- refpolicy.orig/policy/modules/services/rlogin.te
+++ refpolicy/policy/modules/services/rlogin.te
@@ -57,6 +57,10 @@ corenet_tcp_sendrecv_all_nodes(rlogind_t
 corenet_udp_sendrecv_all_nodes(rlogind_t)
 corenet_tcp_sendrecv_all_ports(rlogind_t)
 corenet_udp_sendrecv_all_ports(rlogind_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(rlogind_t)
+	corenet_udp_recv_netlabel(rlogind_t)
+')
 
 dev_read_urand(rlogind_t)
 
Index: refpolicy/policy/modules/services/roundup.te
===================================================================
--- refpolicy.orig/policy/modules/services/roundup.te
+++ refpolicy/policy/modules/services/roundup.te
@@ -57,6 +57,10 @@ corenet_tcp_bind_http_cache_port(roundup
 corenet_tcp_connect_smtp_port(roundup_t)
 corenet_sendrecv_http_cache_server_packets(roundup_t)
 corenet_sendrecv_smtp_client_packets(roundup_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(roundup_t)
+	corenet_udp_recv_netlabel(roundup_t)
+')
 
 # /usr/share/mysql/charsets/Index.xml
 dev_read_urand(roundup_t)
Index: refpolicy/policy/modules/services/rpc.if
===================================================================
--- refpolicy.orig/policy/modules/services/rpc.if
+++ refpolicy/policy/modules/services/rpc.if
@@ -83,6 +83,10 @@ template(`rpc_domain_template', `
 	corenet_tcp_bind_reserved_port($1_t)
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_portmap_client_packets($1_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_t)
+		corenet_udp_recv_netlabel($1_t)
+	')
 	# do not log when it tries to bind to a port belonging to another domain
 	corenet_dontaudit_tcp_bind_all_reserved_ports($1_t)
 	corenet_dontaudit_udp_bind_all_reserved_ports($1_t)
Index: refpolicy/policy/modules/services/rshd.te
===================================================================
--- refpolicy.orig/policy/modules/services/rshd.te
+++ refpolicy/policy/modules/services/rshd.te
@@ -33,6 +33,10 @@ corenet_udp_sendrecv_all_ports(rshd_t)
 corenet_tcp_bind_all_nodes(rshd_t)
 corenet_tcp_bind_rsh_port(rshd_t)
 corenet_sendrecv_rsh_server_packets(rshd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(rshd_t)
+	corenet_udp_recv_netlabel(rshd_t)
+')
 
 dev_read_urand(rshd_t)
 
Index: refpolicy/policy/modules/services/rsync.te
===================================================================
--- refpolicy.orig/policy/modules/services/rsync.te
+++ refpolicy/policy/modules/services/rsync.te
@@ -63,6 +63,10 @@ corenet_udp_sendrecv_all_ports(rsync_t)
 corenet_tcp_bind_all_nodes(rsync_t)
 corenet_tcp_bind_rsync_port(rsync_t)
 corenet_sendrecv_rsync_server_packets(rsync_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(rsync_t)
+	corenet_udp_recv_netlabel(rsync_t)
+')
 
 dev_read_urand(rsync_t)
 
Index: refpolicy/policy/modules/services/samba.te
===================================================================
--- refpolicy.orig/policy/modules/services/samba.te
+++ refpolicy/policy/modules/services/samba.te
@@ -123,6 +123,10 @@ corenet_non_ipsec_sendrecv(samba_net_t)
 corenet_tcp_bind_all_nodes(samba_net_t)
 corenet_udp_bind_all_nodes(samba_net_t)
 corenet_tcp_connect_smbd_port(samba_net_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(samba_net_t)
+	corenet_udp_recv_netlabel(samba_net_t)
+')
 
 dev_read_urand(samba_net_t)
 
@@ -233,6 +237,10 @@ corenet_udp_bind_all_nodes(smbd_t)
 corenet_tcp_bind_smbd_port(smbd_t)
 corenet_tcp_connect_ipp_port(smbd_t)
 corenet_tcp_connect_smbd_port(smbd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(smbd_t)
+	corenet_udp_recv_netlabel(smbd_t)
+')
 
 dev_read_sysfs(smbd_t)
 dev_read_urand(smbd_t)
@@ -373,6 +381,10 @@ corenet_udp_bind_all_nodes(nmbd_t)
 corenet_udp_bind_nmbd_port(nmbd_t)
 corenet_sendrecv_nmbd_server_packets(nmbd_t)
 corenet_sendrecv_nmbd_client_packets(nmbd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(nmbd_t)
+	corenet_udp_recv_netlabel(nmbd_t)
+')
 
 dev_read_sysfs(nmbd_t)
 dev_getattr_mtrr_dev(nmbd_t)
@@ -462,6 +474,10 @@ corenet_non_ipsec_sendrecv(smbmount_t)
 corenet_tcp_bind_all_nodes(smbmount_t)
 corenet_udp_bind_all_nodes(smbmount_t)
 corenet_tcp_connect_all_ports(smbmount_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(smbmount_t)
+	corenet_udp_recv_netlabel(smbmount_t)
+')
 
 fs_getattr_cifs(smbmount_t)
 fs_mount_cifs(smbmount_t)
@@ -566,6 +582,10 @@ corenet_tcp_connect_smbd_port(swat_t)
 corenet_tcp_connect_ipp_port(swat_t)
 corenet_sendrecv_smbd_client_packets(swat_t)
 corenet_sendrecv_ipp_client_packets(swat_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(swat_t)
+	corenet_udp_recv_netlabel(swat_t)
+')
 
 dev_read_urand(swat_t)
 
@@ -662,6 +682,10 @@ corenet_non_ipsec_sendrecv(winbind_t)
 corenet_tcp_bind_all_nodes(winbind_t)
 corenet_udp_bind_all_nodes(winbind_t)
 corenet_tcp_connect_smbd_port(winbind_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(winbind_t)
+	corenet_udp_recv_netlabel(winbind_t)
+')
 
 dev_read_sysfs(winbind_t)
 dev_read_urand(winbind_t)
Index: refpolicy/policy/modules/services/sasl.te
===================================================================
--- refpolicy.orig/policy/modules/services/sasl.te
+++ refpolicy/policy/modules/services/sasl.te
@@ -39,6 +39,9 @@ corenet_tcp_sendrecv_all_nodes(saslauthd
 corenet_tcp_sendrecv_all_ports(saslauthd_t)
 corenet_tcp_connect_pop_port(saslauthd_t)
 corenet_sendrecv_pop_client_packets(saslauthd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(saslauthd_t)
+')
 
 dev_read_sysfs(saslauthd_t)
 dev_read_urand(saslauthd_t)
Index: refpolicy/policy/modules/services/sendmail.te
===================================================================
--- refpolicy.orig/policy/modules/services/sendmail.te
+++ refpolicy/policy/modules/services/sendmail.te
@@ -58,6 +58,9 @@ corenet_tcp_bind_smtp_port(sendmail_t)
 corenet_tcp_connect_all_ports(sendmail_t)
 corenet_sendrecv_smtp_server_packets(sendmail_t)
 corenet_sendrecv_smtp_client_packets(sendmail_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(sendmail_t)
+')
 
 dev_read_urand(sendmail_t)
 dev_read_sysfs(sendmail_t)
Index: refpolicy/policy/modules/services/setroubleshoot.te
===================================================================
--- refpolicy.orig/policy/modules/services/setroubleshoot.te
+++ refpolicy/policy/modules/services/setroubleshoot.te
@@ -65,6 +65,9 @@ corenet_tcp_sendrecv_all_ports(setrouble
 corenet_tcp_bind_all_nodes(setroubleshootd_t)
 corenet_tcp_connect_smtp_port(setroubleshootd_t)
 corenet_sendrecv_smtp_client_packets(setroubleshootd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(setroubleshootd_t)
+')
 
 dev_read_urand(setroubleshootd_t)
 
Index: refpolicy/policy/modules/services/smartmon.te
===================================================================
--- refpolicy.orig/policy/modules/services/smartmon.te
+++ refpolicy/policy/modules/services/smartmon.te
@@ -46,6 +46,9 @@ corenet_non_ipsec_sendrecv(fsdaemon_t)
 corenet_udp_sendrecv_generic_if(fsdaemon_t)
 corenet_udp_sendrecv_all_nodes(fsdaemon_t)
 corenet_udp_sendrecv_all_ports(fsdaemon_t)
+ifdef(`enable_mls',`
+	corenet_udp_recv_netlabel(fsdaemon_t)
+')
 
 dev_read_sysfs(fsdaemon_t)
 
Index: refpolicy/policy/modules/services/snmp.te
===================================================================
--- refpolicy.orig/policy/modules/services/snmp.te
+++ refpolicy/policy/modules/services/snmp.te
@@ -71,6 +71,10 @@ corenet_udp_bind_all_nodes(snmpd_t)
 corenet_tcp_bind_snmp_port(snmpd_t)
 corenet_udp_bind_snmp_port(snmpd_t)
 corenet_sendrecv_snmp_server_packets(snmpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(snmpd_t)
+	corenet_udp_recv_netlabel(snmpd_t)
+')
 
 dev_list_sysfs(snmpd_t)
 dev_read_sysfs(snmpd_t)
Index: refpolicy/policy/modules/services/snort.te
===================================================================
--- refpolicy.orig/policy/modules/services/snort.te
+++ refpolicy/policy/modules/services/snort.te
@@ -64,6 +64,10 @@ corenet_udp_sendrecv_all_nodes(snort_t)
 corenet_raw_sendrecv_all_nodes(snort_t)
 corenet_tcp_sendrecv_all_ports(snort_t)
 corenet_udp_sendrecv_all_ports(snort_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(snort_t)
+	corenet_udp_recv_netlabel(snort_t)
+')
 
 dev_read_sysfs(snort_t)
 
Index: refpolicy/policy/modules/services/soundserver.te
===================================================================
--- refpolicy.orig/policy/modules/services/soundserver.te
+++ refpolicy/policy/modules/services/soundserver.te
@@ -72,6 +72,10 @@ corenet_udp_sendrecv_all_ports(soundd_t)
 corenet_tcp_bind_all_nodes(soundd_t)
 corenet_tcp_bind_soundd_port(soundd_t)
 corenet_sendrecv_soundd_server_packets(soundd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(soundd_t)
+	corenet_udp_recv_netlabel(soundd_t)
+')
 
 dev_read_sysfs(soundd_t)
 dev_read_sound(soundd_t)
Index: refpolicy/policy/modules/services/spamassassin.if
===================================================================
--- refpolicy.orig/policy/modules/services/spamassassin.if
+++ refpolicy/policy/modules/services/spamassassin.if
@@ -101,6 +101,10 @@ template(`spamassassin_per_role_template
 	corenet_udp_sendrecv_all_ports($1_spamc_t)
 	corenet_tcp_connect_all_ports($1_spamc_t)
 	corenet_sendrecv_all_client_packets($1_spamc_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_spamc_t)
+		corenet_udp_recv_netlabel($1_spamc_t)
+	')
 
 	fs_search_auto_mountpoints($1_spamc_t)
 
Index: refpolicy/policy/modules/services/spamassassin.te
===================================================================
--- refpolicy.orig/policy/modules/services/spamassassin.te
+++ refpolicy/policy/modules/services/spamassassin.te
@@ -79,6 +79,10 @@ corenet_tcp_bind_spamd_port(spamd_t)
 corenet_tcp_connect_razor_port(spamd_t)
 corenet_sendrecv_razor_client_packets(spamd_t)
 corenet_sendrecv_spamd_server_packets(spamd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(spamd_t)
+	corenet_udp_recv_netlabel(spamd_t)
+')
 # spamassassin 3.1 needs this for its
 # DnsResolver.pm module which binds to
 # random ports >= 1024.
Index: refpolicy/policy/modules/services/squid.te
===================================================================
--- refpolicy.orig/policy/modules/services/squid.te
+++ refpolicy/policy/modules/services/squid.te
@@ -90,6 +90,10 @@ corenet_sendrecv_ftp_client_packets(squi
 corenet_sendrecv_gopher_client_packets(squid_t)
 corenet_sendrecv_http_cache_server_packets(squid_t)
 corenet_sendrecv_http_cache_client_packets(squid_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(squid_t)
+	corenet_udp_recv_netlabel(squid_t)
+')
 
 dev_read_sysfs(squid_t)
 dev_read_urand(squid_t)
Index: refpolicy/policy/modules/services/ssh.if
===================================================================
--- refpolicy.orig/policy/modules/services/ssh.if
+++ refpolicy/policy/modules/services/ssh.if
@@ -114,6 +114,9 @@ template(`ssh_basic_client_template',`
 	corenet_tcp_sendrecv_all_ports($1_ssh_t)
 	corenet_tcp_connect_ssh_port($1_ssh_t)
 	corenet_sendrecv_ssh_client_packets($1_ssh_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_ssh_t)
+	')
 
 	dev_read_urand($1_ssh_t)
 
@@ -483,6 +486,10 @@ template(`ssh_server_template', `
 	corenet_udp_bind_all_nodes($1_t)
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_ssh_server_packets($1_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_t)
+		corenet_udp_recv_netlabel($1_t)
+	')
 
 	fs_dontaudit_getattr_all_fs($1_t)
 
Index: refpolicy/policy/modules/services/stunnel.te
===================================================================
--- refpolicy.orig/policy/modules/services/stunnel.te
+++ refpolicy/policy/modules/services/stunnel.te
@@ -64,6 +64,10 @@ corenet_tcp_sendrecv_all_ports(stunnel_t
 corenet_udp_sendrecv_all_ports(stunnel_t)
 corenet_tcp_bind_all_nodes(stunnel_t)
 corenet_tcp_connect_all_ports(stunnel_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(stunnel_t)
+	corenet_udp_recv_netlabel(stunnel_t)
+')
 
 fs_getattr_all_fs(stunnel_t)
 
Index: refpolicy/policy/modules/services/tcpd.te
===================================================================
--- refpolicy.orig/policy/modules/services/tcpd.te
+++ refpolicy/policy/modules/services/tcpd.te
@@ -27,6 +27,9 @@ corenet_non_ipsec_sendrecv(tcpd_t)
 corenet_tcp_sendrecv_all_if(tcpd_t)
 corenet_tcp_sendrecv_all_nodes(tcpd_t)
 corenet_tcp_sendrecv_all_ports(tcpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(tcpd_t)
+')
 
 fs_getattr_xattr_fs(tcpd_t)
 
Index: refpolicy/policy/modules/services/telnet.te
===================================================================
--- refpolicy.orig/policy/modules/services/telnet.te
+++ refpolicy/policy/modules/services/telnet.te
@@ -56,6 +56,10 @@ corenet_tcp_sendrecv_all_nodes(telnetd_t
 corenet_udp_sendrecv_all_nodes(telnetd_t)
 corenet_tcp_sendrecv_all_ports(telnetd_t)
 corenet_udp_sendrecv_all_ports(telnetd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(telnetd_t)
+	corenet_udp_recv_netlabel(telnetd_t)
+')
 
 dev_read_urand(telnetd_t)
 
Index: refpolicy/policy/modules/services/tftp.te
===================================================================
--- refpolicy.orig/policy/modules/services/tftp.te
+++ refpolicy/policy/modules/services/tftp.te
@@ -50,6 +50,10 @@ corenet_tcp_bind_all_nodes(tftpd_t)
 corenet_udp_bind_all_nodes(tftpd_t)
 corenet_udp_bind_tftp_port(tftpd_t)
 corenet_sendrecv_tftp_server_packets(tftpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(tftpd_t)
+	corenet_udp_recv_netlabel(tftpd_t)
+')
 
 dev_read_sysfs(tftpd_t)
 
Index: refpolicy/policy/modules/services/timidity.te
===================================================================
--- refpolicy.orig/policy/modules/services/timidity.te
+++ refpolicy/policy/modules/services/timidity.te
@@ -46,6 +46,10 @@ corenet_tcp_sendrecv_all_nodes(timidity_
 corenet_udp_sendrecv_all_nodes(timidity_t)
 corenet_tcp_sendrecv_all_ports(timidity_t)
 corenet_udp_sendrecv_all_ports(timidity_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(timidity_t)
+	corenet_udp_recv_netlabel(timidity_t)
+')
 
 dev_read_sysfs(timidity_t)
 dev_read_sound(timidity_t)
Index: refpolicy/policy/modules/services/tor.te
===================================================================
--- refpolicy.orig/policy/modules/services/tor.te
+++ refpolicy/policy/modules/services/tor.te
@@ -71,6 +71,9 @@ corenet_tcp_sendrecv_all_reserved_ports(
 corenet_tcp_bind_all_nodes(tor_t)
 corenet_tcp_bind_tor_port(tor_t)
 corenet_sendrecv_tor_server_packets(tor_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(tor_t)
+')
 # TOR will need to connect to various ports
 corenet_tcp_connect_all_ports(tor_t)
 corenet_sendrecv_all_client_packets(tor_t)
Index: refpolicy/policy/modules/services/transproxy.te
===================================================================
--- refpolicy.orig/policy/modules/services/transproxy.te
+++ refpolicy/policy/modules/services/transproxy.te
@@ -37,6 +37,9 @@ corenet_tcp_sendrecv_all_ports(transprox
 corenet_tcp_bind_all_nodes(transproxy_t)
 corenet_tcp_bind_transproxy_port(transproxy_t)
 corenet_sendrecv_transproxy_server_packets(transproxy_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(transproxy_t)
+')
 
 dev_read_sysfs(transproxy_t)
 
Index: refpolicy/policy/modules/services/ucspitcp.te
===================================================================
--- refpolicy.orig/policy/modules/services/ucspitcp.te
+++ refpolicy/policy/modules/services/ucspitcp.te
@@ -34,6 +34,10 @@ corenet_udp_sendrecv_all_ports(rblsmtpd_
 corenet_non_ipsec_sendrecv(rblsmtpd_t)
 corenet_tcp_bind_all_nodes(rblsmtpd_t)
 corenet_udp_bind_generic_port(rblsmtpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(rblsmtpd_t)
+	corenet_udp_recv_netlabel(rblsmtpd_t)
+')
 
 files_read_etc_files(rblsmtpd_t)
 files_search_var(rblsmtpd_t)
@@ -68,6 +72,10 @@ corenet_tcp_sendrecv_all_ports(ucspitcp_
 corenet_udp_sendrecv_all_ports(ucspitcp_t)
 corenet_tcp_bind_all_nodes(ucspitcp_t)
 corenet_udp_bind_all_nodes(ucspitcp_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(ucspitcp_t)
+	corenet_udp_recv_netlabel(ucspitcp_t)
+')
 
 # server ports:
 corenet_tcp_bind_ftp_port(ucspitcp_t)
Index: refpolicy/policy/modules/services/uucp.te
===================================================================
--- refpolicy.orig/policy/modules/services/uucp.te
+++ refpolicy/policy/modules/services/uucp.te
@@ -77,6 +77,10 @@ corenet_tcp_sendrecv_all_nodes(uucpd_t)
 corenet_udp_sendrecv_all_nodes(uucpd_t)
 corenet_tcp_sendrecv_all_ports(uucpd_t)
 corenet_udp_sendrecv_all_ports(uucpd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(uucpd_t)
+	corenet_udp_recv_netlabel(uucpd_t)
+')
 
 dev_read_urand(uucpd_t)
 
Index: refpolicy/policy/modules/services/uwimap.te
===================================================================
--- refpolicy.orig/policy/modules/services/uwimap.te
+++ refpolicy/policy/modules/services/uwimap.te
@@ -48,6 +48,9 @@ corenet_tcp_bind_pop_port(imapd_t)
 corenet_tcp_connect_all_ports(imapd_t)
 corenet_sendrecv_pop_server_packets(imapd_t)
 corenet_sendrecv_all_client_packets(imapd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(imapd_t)
+')
 
 dev_read_sysfs(imapd_t)
 #urandom, for ssl
Index: refpolicy/policy/modules/services/watchdog.te
===================================================================
--- refpolicy.orig/policy/modules/services/watchdog.te
+++ refpolicy/policy/modules/services/watchdog.te
@@ -53,6 +53,10 @@ corenet_tcp_sendrecv_all_ports(watchdog_
 corenet_udp_sendrecv_all_ports(watchdog_t)
 corenet_tcp_connect_all_ports(watchdog_t)
 corenet_sendrecv_all_client_packets(watchdog_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(watchdog_t)
+	corenet_udp_recv_netlabel(watchdog_t)
+')
 
 dev_read_sysfs(watchdog_t)
 dev_write_watchdog(watchdog_t)
Index: refpolicy/policy/modules/services/xprint.te
===================================================================
--- refpolicy.orig/policy/modules/services/xprint.te
+++ refpolicy/policy/modules/services/xprint.te
@@ -42,6 +42,10 @@ corenet_tcp_sendrecv_all_nodes(xprint_t)
 corenet_udp_sendrecv_all_nodes(xprint_t)
 corenet_tcp_sendrecv_all_ports(xprint_t)
 corenet_udp_sendrecv_all_ports(xprint_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(xprint_t)
+	corenet_udp_recv_netlabel(xprint_t)
+')
 
 dev_read_sysfs(xprint_t)
 dev_read_urand(xprint_t)
Index: refpolicy/policy/modules/services/xserver.if
===================================================================
--- refpolicy.orig/policy/modules/services/xserver.if
+++ refpolicy/policy/modules/services/xserver.if
@@ -107,6 +107,10 @@ template(`xserver_common_domain_template
 	corenet_tcp_connect_all_ports($1_xserver_t)
 	corenet_sendrecv_xserver_server_packets($1_xserver_t)
 	corenet_sendrecv_all_client_packets($1_xserver_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1_xserver_t)
+		corenet_udp_recv_netlabel($1_xserver_t)
+	')
 
 	dev_rw_sysfs($1_xserver_t)
 	dev_rw_mouse($1_xserver_t)
Index: refpolicy/policy/modules/services/xserver.te
===================================================================
--- refpolicy.orig/policy/modules/services/xserver.te
+++ refpolicy/policy/modules/services/xserver.te
@@ -132,6 +132,10 @@ corenet_tcp_bind_all_nodes(xdm_t)
 corenet_udp_bind_all_nodes(xdm_t)
 corenet_tcp_connect_all_ports(xdm_t)
 corenet_sendrecv_all_client_packets(xdm_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(xdm_t)
+	corenet_udp_recv_netlabel(xdm_t)
+')
 # xdm tries to bind to biff_port_t
 corenet_dontaudit_tcp_bind_all_ports(xdm_t)
 
Index: refpolicy/policy/modules/services/zebra.te
===================================================================
--- refpolicy.orig/policy/modules/services/zebra.te
+++ refpolicy/policy/modules/services/zebra.te
@@ -76,6 +76,10 @@ corenet_udp_bind_router_port(zebra_t)
 corenet_tcp_connect_bgp_port(zebra_t)
 corenet_sendrecv_zebra_server_packets(zebra_t)
 corenet_sendrecv_router_server_packets(zebra_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(zebra_t)
+	corenet_udp_recv_netlabel(zebra_t)
+')
 
 dev_associate_usbfs(zebra_var_run_t)
 dev_list_all_dev_nodes(zebra_t)
Index: refpolicy/policy/modules/system/hotplug.te
===================================================================
--- refpolicy.orig/policy/modules/system/hotplug.te
+++ refpolicy/policy/modules/system/hotplug.te
@@ -58,6 +58,10 @@ corenet_tcp_sendrecv_all_nodes(hotplug_t
 corenet_udp_sendrecv_all_nodes(hotplug_t)
 corenet_tcp_sendrecv_all_ports(hotplug_t)
 corenet_udp_sendrecv_all_ports(hotplug_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(hotplug_t)
+	corenet_udp_recv_netlabel(hotplug_t)
+')
 
 dev_rw_sysfs(hotplug_t)
 dev_read_usbfs(hotplug_t)
Index: refpolicy/policy/modules/system/iscsi.te
===================================================================
--- refpolicy.orig/policy/modules/system/iscsi.te
+++ refpolicy/policy/modules/system/iscsi.te
@@ -60,6 +60,9 @@ corenet_tcp_sendrecv_all_nodes(iscsid_t)
 corenet_tcp_sendrecv_all_ports(iscsid_t)
 corenet_tcp_connect_http_port(iscsid_t)
 corenet_tcp_connect_iscsi_port(iscsid_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(iscsid_t)
+')
 
 dev_rw_sysfs(iscsid_t)
 
Index: refpolicy/policy/modules/system/lvm.te
===================================================================
--- refpolicy.orig/policy/modules/system/lvm.te
+++ refpolicy/policy/modules/system/lvm.te
@@ -80,6 +80,11 @@ corenet_tcp_bind_all_nodes(clvmd_t)
 corenet_tcp_bind_reserved_port(clvmd_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(clvmd_t)
 corenet_sendrecv_generic_server_packets(clvmd_t)
+ifdef(`enable_mls',`
+	corenet_tcp_recv_netlabel(clvmd_t)
+	corenet_udp_recv_netlabel(clvmd_t)
+')
+
 
 dev_read_sysfs(clvmd_t)
 dev_manage_generic_chr_files(clvmd_t)
Index: refpolicy/policy/modules/system/mount.te
===================================================================
--- refpolicy.orig/policy/modules/system/mount.te
+++ refpolicy/policy/modules/system/mount.te
@@ -151,6 +151,10 @@ optional_policy(`
 	corenet_dontaudit_tcp_bind_all_reserved_ports(mount_t)
 	corenet_dontaudit_udp_bind_all_reserved_ports(mount_t)
 	corenet_tcp_connect_all_ports(mount_t)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel(mount_t)
+		corenet_udp_recv_netlabel(mount_t)
+	')
 
 	fs_search_rpc(mount_t)
 
Index: refpolicy/policy/modules/system/sysnetwork.if
===================================================================
--- refpolicy.orig/policy/modules/system/sysnetwork.if
+++ refpolicy/policy/modules/system/sysnetwork.if
@@ -489,6 +489,10 @@ interface(`sysnet_dns_name_resolve',`
 	corenet_udp_sendrecv_dns_port($1)
 	corenet_tcp_connect_dns_port($1)
 	corenet_sendrecv_dns_client_packets($1)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1)
+		corenet_udp_recv_netlabel($1)
+	')
 
 	files_search_etc($1)
 	allow $1 net_conf_t:file read_file_perms;
@@ -517,6 +521,10 @@ interface(`sysnet_use_ldap',`
 	corenet_tcp_sendrecv_ldap_port($1)
 	corenet_tcp_connect_ldap_port($1)
 	corenet_sendrecv_ldap_client_packets($1)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1)
+		corenet_udp_recv_netlabel($1)
+	')
 
 	files_search_etc($1)
 	allow $1 net_conf_t:file read_file_perms;
@@ -549,6 +557,10 @@ interface(`sysnet_use_portmap',`
 	corenet_udp_sendrecv_portmap_port($1)
 	corenet_tcp_connect_portmap_port($1)
 	corenet_sendrecv_portmap_client_packets($1)
+	ifdef(`enable_mls',`
+		corenet_tcp_recv_netlabel($1)
+		corenet_udp_recv_netlabel($1)
+	')
 
 	files_search_etc($1)
 	allow $1 net_conf_t:file read_file_perms;

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
