Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QJ8n2n000449
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 14:08:49 -0500
Received: from g4t0014.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QJ8bQG013501
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 19:08:38 GMT
Received: from g4t0014.houston.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 1844B240B5
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:09 +0000 (UTC)
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0014.houston.hp.com (Postfix) with ESMTP id 1420A24031
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:09 +0000 (UTC)
Message-Id: <20080226184408.017821550@hp.com>
References: <20080226184032.834798290@hp.com>
Date: Tue, 26 Feb 2008 13:40:36 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 4/5] REFPOL: Allow network service domains to receive unlabeled traffic
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the corenet_recvfrom_unlabeled_peer() interface call to
all of the service modules which need to receive data over the network.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/services/afs.te            |    5 +++++
 policy/modules/services/amavis.te         |    1 +
 policy/modules/services/apache.if         |    2 ++
 policy/modules/services/apache.te         |    2 ++
 policy/modules/services/apcupsd.te        |    2 ++
 policy/modules/services/arpwatch.te       |    1 +
 policy/modules/services/asterisk.te       |    1 +
 policy/modules/services/automount.te      |    1 +
 policy/modules/services/avahi.te          |    1 +
 policy/modules/services/bind.te           |    2 ++
 policy/modules/services/bitlbee.te        |    1 +
 policy/modules/services/bluetooth.te      |    1 +
 policy/modules/services/canna.te          |    1 +
 policy/modules/services/ccs.te            |    1 +
 policy/modules/services/cipe.te           |    1 +
 policy/modules/services/clamav.te         |    2 ++
 policy/modules/services/clockspeed.te     |    2 ++
 policy/modules/services/comsat.te         |    1 +
 policy/modules/services/courier.if        |    1 +
 policy/modules/services/cron.if           |    1 +
 policy/modules/services/cron.te           |    1 +
 policy/modules/services/cups.te           |    5 +++++
 policy/modules/services/cvs.te            |    1 +
 policy/modules/services/cyrus.te          |    1 +
 policy/modules/services/dante.te          |    1 +
 policy/modules/services/dbskk.te          |    1 +
 policy/modules/services/dbus.if           |    1 +
 policy/modules/services/dcc.te            |    6 ++++++
 policy/modules/services/ddclient.te       |    1 +
 policy/modules/services/dhcp.te           |    1 +
 policy/modules/services/dictd.te          |    1 +
 policy/modules/services/distcc.te         |    1 +
 policy/modules/services/djbdns.if         |    1 +
 policy/modules/services/dnsmasq.te        |    1 +
 policy/modules/services/dovecot.te        |    1 +
 policy/modules/services/exim.te           |    1 +
 policy/modules/services/fetchmail.te      |    1 +
 policy/modules/services/finger.te         |    1 +
 policy/modules/services/ftp.te            |    1 +
 policy/modules/services/gatekeeper.te     |    1 +
 policy/modules/services/hal.te            |    1 +
 policy/modules/services/howl.te           |    1 +
 policy/modules/services/i18n_input.te     |    1 +
 policy/modules/services/imaze.te          |    1 +
 policy/modules/services/inetd.te          |    2 ++
 policy/modules/services/inn.te            |    1 +
 policy/modules/services/ircd.te           |    1 +
 policy/modules/services/jabber.te         |    1 +
 policy/modules/services/kerberos.if       |    1 +
 policy/modules/services/kerberos.te       |    2 ++
 policy/modules/services/ktalk.te          |    1 +
 policy/modules/services/ldap.te           |    1 +
 policy/modules/services/lpd.if            |    1 +
 policy/modules/services/lpd.te            |    2 ++
 policy/modules/services/mailman.if        |    1 +
 policy/modules/services/monop.te          |    1 +
 policy/modules/services/mta.if            |    1 +
 policy/modules/services/munin.te          |    1 +
 policy/modules/services/mysql.te          |    1 +
 policy/modules/services/nagios.te         |    1 +
 policy/modules/services/nessus.te         |    1 +
 policy/modules/services/networkmanager.te |    1 +
 policy/modules/services/nis.if            |    1 +
 policy/modules/services/nis.te            |    4 ++++
 policy/modules/services/nscd.te           |    1 +
 policy/modules/services/nsd.te            |    2 ++
 policy/modules/services/ntop.te           |    1 +
 policy/modules/services/ntp.te            |    1 +
 policy/modules/services/nx.te             |    1 +
 policy/modules/services/oav.te            |    2 ++
 policy/modules/services/openvpn.te        |    1 +
 policy/modules/services/pcscd.te          |    1 +
 policy/modules/services/pegasus.te        |    1 +
 policy/modules/services/perdition.te      |    1 +
 policy/modules/services/portmap.te        |    2 ++
 policy/modules/services/portslave.te      |    1 +
 policy/modules/services/postfix.if        |    1 +
 policy/modules/services/postfix.te        |    2 ++
 policy/modules/services/postfixpolicyd.te |    1 +
 policy/modules/services/postgresql.te     |    1 +
 policy/modules/services/postgrey.te       |    1 +
 policy/modules/services/ppp.te            |    2 ++
 policy/modules/services/privoxy.te        |    1 +
 policy/modules/services/procmail.te       |    1 +
 policy/modules/services/pyzor.te          |    1 +
 policy/modules/services/qmail.te          |    1 +
 policy/modules/services/radius.te         |    1 +
 policy/modules/services/radvd.te          |    1 +
 policy/modules/services/razor.if          |    1 +
 policy/modules/services/razor.te          |    1 +
 policy/modules/services/rdisc.te          |    1 +
 policy/modules/services/rhgb.te           |    1 +
 policy/modules/services/ricci.te          |    1 +
 policy/modules/services/rlogin.te         |    1 +
 policy/modules/services/roundup.te        |    1 +
 policy/modules/services/rpc.if            |    1 +
 policy/modules/services/rpcbind.te        |    1 +
 policy/modules/services/rshd.te           |    1 +
 policy/modules/services/rsync.te          |    1 +
 policy/modules/services/rwho.te           |    1 +
 policy/modules/services/samba.te          |    6 ++++++
 policy/modules/services/sasl.te           |    1 +
 policy/modules/services/sendmail.te       |    1 +
 policy/modules/services/setroubleshoot.te |    1 +
 policy/modules/services/smartmon.te       |    1 +
 policy/modules/services/snmp.te           |    1 +
 policy/modules/services/snort.te          |    1 +
 policy/modules/services/soundserver.te    |    1 +
 policy/modules/services/spamassassin.if   |    2 ++
 policy/modules/services/spamassassin.te   |    1 +
 policy/modules/services/squid.te          |    1 +
 policy/modules/services/ssh.if            |    2 ++
 policy/modules/services/stunnel.te        |    1 +
 policy/modules/services/tcpd.te           |    1 +
 policy/modules/services/telnet.te         |    1 +
 policy/modules/services/tftp.te           |    1 +
 policy/modules/services/timidity.te       |    1 +
 policy/modules/services/tor.te            |    1 +
 policy/modules/services/transproxy.te     |    1 +
 policy/modules/services/ucspitcp.te       |    2 ++
 policy/modules/services/uucp.te           |    1 +
 policy/modules/services/uwimap.te         |    1 +
 policy/modules/services/watchdog.te       |    1 +
 policy/modules/services/xfs.te            |    1 +
 policy/modules/services/xprint.te         |    1 +
 policy/modules/services/xserver.if        |    1 +
 policy/modules/services/xserver.te        |    1 +
 policy/modules/services/zebra.te          |    1 +
 128 files changed, 166 insertions(+)

Index: refpolicy_svn_repo/policy/modules/services/afs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/afs.te
+++ refpolicy_svn_repo/policy/modules/services/afs.te
@@ -90,6 +90,7 @@ domtrans_pattern(afs_bosserver_t, afs_vl
 kernel_read_kernel_sysctls(afs_bosserver_t)
 
 corenet_all_recvfrom_unlabeled(afs_bosserver_t)
+corenet_recvfrom_unlabeled_peer(afs_bosserver_t)
 corenet_all_recvfrom_netlabel(afs_bosserver_t)
 corenet_tcp_sendrecv_generic_if(afs_bosserver_t)
 corenet_udp_sendrecv_generic_if(afs_bosserver_t)
@@ -155,6 +156,7 @@ corenet_udp_sendrecv_all_nodes(afs_fsser
 corenet_tcp_sendrecv_all_ports(afs_fsserver_t)
 corenet_udp_sendrecv_all_ports(afs_fsserver_t)
 corenet_all_recvfrom_unlabeled(afs_fsserver_t)
+corenet_recvfrom_unlabeled_peer(afs_fsserver_t)
 corenet_all_recvfrom_netlabel(afs_fsserver_t)
 corenet_tcp_bind_all_nodes(afs_fsserver_t)
 corenet_udp_bind_all_nodes(afs_fsserver_t)
@@ -209,6 +211,7 @@ manage_files_pattern(afs_kaserver_t,afs_
 kernel_read_kernel_sysctls(afs_kaserver_t)
 
 corenet_all_recvfrom_unlabeled(afs_kaserver_t)
+corenet_recvfrom_unlabeled_peer(afs_kaserver_t)
 corenet_all_recvfrom_netlabel(afs_kaserver_t)
 corenet_tcp_sendrecv_generic_if(afs_kaserver_t)
 corenet_udp_sendrecv_generic_if(afs_kaserver_t)
@@ -257,6 +260,7 @@ manage_files_pattern(afs_ptserver_t,afs_
 filetrans_pattern(afs_ptserver_t,afs_dbdir_t,afs_pt_db_t,file)
 
 corenet_all_recvfrom_unlabeled(afs_ptserver_t)
+corenet_recvfrom_unlabeled_peer(afs_ptserver_t)
 corenet_all_recvfrom_netlabel(afs_ptserver_t)
 corenet_tcp_sendrecv_generic_if(afs_ptserver_t)
 corenet_udp_sendrecv_generic_if(afs_ptserver_t)
@@ -299,6 +303,7 @@ manage_files_pattern(afs_vlserver_t,afs_
 filetrans_pattern(afs_vlserver_t,afs_dbdir_t,afs_vl_db_t,file)
 
 corenet_all_recvfrom_unlabeled(afs_vlserver_t)
+corenet_recvfrom_unlabeled_peer(afs_vlserver_t)
 corenet_all_recvfrom_netlabel(afs_vlserver_t)
 corenet_tcp_sendrecv_generic_if(afs_vlserver_t)
 corenet_udp_sendrecv_generic_if(afs_vlserver_t)
Index: refpolicy_svn_repo/policy/modules/services/amavis.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/amavis.te
+++ refpolicy_svn_repo/policy/modules/services/amavis.te
@@ -102,6 +102,7 @@ kernel_dontaudit_read_system_state(amavi
 corecmd_exec_bin(amavis_t)
 
 corenet_all_recvfrom_unlabeled(amavis_t)
+corenet_recvfrom_unlabeled_peer(amavis_t)
 corenet_all_recvfrom_netlabel(amavis_t)
 corenet_tcp_sendrecv_all_if(amavis_t)
 corenet_tcp_sendrecv_all_nodes(amavis_t)
Index: refpolicy_svn_repo/policy/modules/services/apache.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/apache.if
+++ refpolicy_svn_repo/policy/modules/services/apache.if
@@ -182,6 +182,7 @@ template(`apache_content_template',`
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
 
 		corenet_all_recvfrom_unlabeled(httpd_$1_script_t)
+		corenet_recvfrom_unlabeled_peer(httpd_$1_script_t)
 		corenet_all_recvfrom_netlabel(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
 		corenet_udp_sendrecv_all_if(httpd_$1_script_t)
@@ -202,6 +203,7 @@ template(`apache_content_template',`
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
 
 		corenet_all_recvfrom_unlabeled(httpd_$1_script_t)
+		corenet_recvfrom_unlabeled_peer(httpd_$1_script_t)
 		corenet_all_recvfrom_netlabel(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
 		corenet_udp_sendrecv_all_if(httpd_$1_script_t)
Index: refpolicy_svn_repo/policy/modules/services/apache.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/apache.te
+++ refpolicy_svn_repo/policy/modules/services/apache.te
@@ -291,6 +291,7 @@ kernel_read_kernel_sysctls(httpd_t)
 kernel_read_system_state(httpd_t)
 
 corenet_all_recvfrom_unlabeled(httpd_t)
+corenet_recvfrom_unlabeled_peer(httpd_t)
 corenet_all_recvfrom_netlabel(httpd_t)
 corenet_tcp_sendrecv_all_if(httpd_t)
 corenet_udp_sendrecv_all_if(httpd_t)
@@ -617,6 +618,7 @@ tunable_policy(`httpd_can_network_connec
 	allow httpd_suexec_t self:udp_socket create_socket_perms;
 
 	corenet_all_recvfrom_unlabeled(httpd_suexec_t)
+	corenet_recvfrom_unlabeled_peer(httpd_suexec_t)
 	corenet_all_recvfrom_netlabel(httpd_suexec_t)
 	corenet_tcp_sendrecv_all_if(httpd_suexec_t)
 	corenet_udp_sendrecv_all_if(httpd_suexec_t)
Index: refpolicy_svn_repo/policy/modules/services/apcupsd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/apcupsd.te
+++ refpolicy_svn_repo/policy/modules/services/apcupsd.te
@@ -52,6 +52,7 @@ corecmd_exec_bin(apcupsd_t)
 corecmd_exec_shell(apcupsd_t)
 
 corenet_all_recvfrom_unlabeled(apcupsd_t)
+corenet_recvfrom_unlabeled_peer(apcupsd_t)
 corenet_all_recvfrom_netlabel(apcupsd_t)
 corenet_tcp_sendrecv_generic_if(apcupsd_t)
 corenet_tcp_sendrecv_all_nodes(apcupsd_t)
@@ -106,6 +107,7 @@ optional_policy(`
 	allow httpd_apcupsd_cgi_script_t self:udp_socket create_socket_perms;
 	
 	corenet_all_recvfrom_unlabeled(httpd_apcupsd_cgi_script_t)
+	corenet_recvfrom_unlabeled_peer(httpd_apcupsd_cgi_script_t)
 	corenet_all_recvfrom_netlabel(httpd_apcupsd_cgi_script_t)
 	corenet_tcp_sendrecv_all_if(httpd_apcupsd_cgi_script_t)
 	corenet_tcp_sendrecv_all_nodes(httpd_apcupsd_cgi_script_t)
Index: refpolicy_svn_repo/policy/modules/services/arpwatch.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/arpwatch.te
+++ refpolicy_svn_repo/policy/modules/services/arpwatch.te
@@ -48,6 +48,7 @@ kernel_list_proc(arpwatch_t)
 kernel_read_proc_symlinks(arpwatch_t)
 
 corenet_all_recvfrom_unlabeled(arpwatch_t)
+corenet_recvfrom_unlabeled_peer(arpwatch_t)
 corenet_all_recvfrom_netlabel(arpwatch_t)
 corenet_tcp_sendrecv_all_if(arpwatch_t)
 corenet_udp_sendrecv_all_if(arpwatch_t)
Index: refpolicy_svn_repo/policy/modules/services/asterisk.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/asterisk.te
+++ refpolicy_svn_repo/policy/modules/services/asterisk.te
@@ -83,6 +83,7 @@ corecmd_exec_bin(asterisk_t)
 corecmd_search_bin(asterisk_t)
 
 corenet_all_recvfrom_unlabeled(asterisk_t)
+corenet_recvfrom_unlabeled_peer(asterisk_t)
 corenet_all_recvfrom_netlabel(asterisk_t)
 corenet_tcp_sendrecv_generic_if(asterisk_t)
 corenet_udp_sendrecv_generic_if(asterisk_t)
Index: refpolicy_svn_repo/policy/modules/services/automount.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/automount.te
+++ refpolicy_svn_repo/policy/modules/services/automount.te
@@ -77,6 +77,7 @@ corecmd_exec_bin(automount_t)
 corecmd_exec_shell(automount_t)
 
 corenet_all_recvfrom_unlabeled(automount_t)
+corenet_recvfrom_unlabeled_peer(automount_t)
 corenet_all_recvfrom_netlabel(automount_t)
 corenet_tcp_sendrecv_generic_if(automount_t)
 corenet_udp_sendrecv_generic_if(automount_t)
Index: refpolicy_svn_repo/policy/modules/services/avahi.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/avahi.te
+++ refpolicy_svn_repo/policy/modules/services/avahi.te
@@ -38,6 +38,7 @@ kernel_read_proc_symlinks(avahi_t)
 kernel_read_network_state(avahi_t)
 
 corenet_all_recvfrom_unlabeled(avahi_t)
+corenet_recvfrom_unlabeled_peer(avahi_t)
 corenet_all_recvfrom_netlabel(avahi_t)
 corenet_tcp_sendrecv_all_if(avahi_t)
 corenet_udp_sendrecv_all_if(avahi_t)
Index: refpolicy_svn_repo/policy/modules/services/bind.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/bind.te
+++ refpolicy_svn_repo/policy/modules/services/bind.te
@@ -103,6 +103,7 @@ kernel_read_network_state(named_t)
 corecmd_search_bin(named_t)
 
 corenet_all_recvfrom_unlabeled(named_t)
+corenet_recvfrom_unlabeled_peer(named_t)
 corenet_all_recvfrom_netlabel(named_t)
 corenet_tcp_sendrecv_all_if(named_t)
 corenet_udp_sendrecv_all_if(named_t)
@@ -217,6 +218,7 @@ allow ndc_t named_zone_t:dir search;
 kernel_read_kernel_sysctls(ndc_t)
 
 corenet_all_recvfrom_unlabeled(ndc_t)
+corenet_recvfrom_unlabeled_peer(ndc_t)
 corenet_all_recvfrom_netlabel(ndc_t)
 corenet_tcp_sendrecv_all_if(ndc_t)
 corenet_tcp_sendrecv_all_nodes(ndc_t)
Index: refpolicy_svn_repo/policy/modules/services/bitlbee.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/bitlbee.te
+++ refpolicy_svn_repo/policy/modules/services/bitlbee.te
@@ -35,6 +35,7 @@ manage_files_pattern(bitlbee_t, bitlbee_
 files_var_lib_filetrans(bitlbee_t, bitlbee_var_t, file)
 
 corenet_all_recvfrom_unlabeled(bitlbee_t)
+corenet_recvfrom_unlabeled_peer(bitlbee_t)
 corenet_udp_sendrecv_generic_if(bitlbee_t)
 corenet_udp_sendrecv_generic_node(bitlbee_t)
 corenet_udp_sendrecv_lo_node(bitlbee_t)
Index: refpolicy_svn_repo/policy/modules/services/bluetooth.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/bluetooth.te
+++ refpolicy_svn_repo/policy/modules/services/bluetooth.te
@@ -78,6 +78,7 @@ kernel_read_kernel_sysctls(bluetooth_t)
 kernel_read_system_state(bluetooth_t)
 
 corenet_all_recvfrom_unlabeled(bluetooth_t)
+corenet_recvfrom_unlabeled_peer(bluetooth_t)
 corenet_all_recvfrom_netlabel(bluetooth_t)
 corenet_tcp_sendrecv_all_if(bluetooth_t)
 corenet_udp_sendrecv_all_if(bluetooth_t)
Index: refpolicy_svn_repo/policy/modules/services/canna.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/canna.te
+++ refpolicy_svn_repo/policy/modules/services/canna.te
@@ -48,6 +48,7 @@ kernel_read_kernel_sysctls(canna_t)
 kernel_read_system_state(canna_t)
 
 corenet_all_recvfrom_unlabeled(canna_t)
+corenet_recvfrom_unlabeled_peer(canna_t)
 corenet_all_recvfrom_netlabel(canna_t)
 corenet_tcp_sendrecv_all_if(canna_t)
 corenet_tcp_sendrecv_all_nodes(canna_t)
Index: refpolicy_svn_repo/policy/modules/services/ccs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ccs.te
+++ refpolicy_svn_repo/policy/modules/services/ccs.te
@@ -78,6 +78,7 @@ corecmd_list_bin(ccs_t)
 corecmd_exec_bin(ccs_t)
 
 corenet_all_recvfrom_unlabeled(ccs_t)
+corenet_recvfrom_unlabeled_peer(ccs_t)
 corenet_all_recvfrom_netlabel(ccs_t)
 corenet_tcp_sendrecv_all_if(ccs_t)
 corenet_udp_sendrecv_all_if(ccs_t)
Index: refpolicy_svn_repo/policy/modules/services/cipe.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cipe.te
+++ refpolicy_svn_repo/policy/modules/services/cipe.te
@@ -30,6 +30,7 @@ corecmd_exec_shell(ciped_t)
 corecmd_exec_bin(ciped_t)
 
 corenet_all_recvfrom_unlabeled(ciped_t)
+corenet_recvfrom_unlabeled_peer(ciped_t)
 corenet_all_recvfrom_netlabel(ciped_t)
 corenet_udp_sendrecv_generic_if(ciped_t)
 corenet_udp_sendrecv_all_nodes(ciped_t)
Index: refpolicy_svn_repo/policy/modules/services/clamav.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/clamav.te
+++ refpolicy_svn_repo/policy/modules/services/clamav.te
@@ -89,6 +89,7 @@ kernel_read_sysctl(clamd_t)
 kernel_read_kernel_sysctls(clamd_t)
 
 corenet_all_recvfrom_unlabeled(clamd_t)
+corenet_recvfrom_unlabeled_peer(clamd_t)
 corenet_all_recvfrom_netlabel(clamd_t)
 corenet_tcp_sendrecv_all_if(clamd_t)
 corenet_tcp_sendrecv_all_nodes(clamd_t)
@@ -159,6 +160,7 @@ allow freshclam_t clamd_var_log_t:dir se
 logging_log_filetrans(freshclam_t,freshclam_var_log_t,file)
 
 corenet_all_recvfrom_unlabeled(freshclam_t)
+corenet_recvfrom_unlabeled_peer(freshclam_t)
 corenet_all_recvfrom_netlabel(freshclam_t)
 corenet_tcp_sendrecv_all_if(freshclam_t)
 corenet_tcp_sendrecv_all_nodes(freshclam_t)
Index: refpolicy_svn_repo/policy/modules/services/clockspeed.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/clockspeed.te
+++ refpolicy_svn_repo/policy/modules/services/clockspeed.te
@@ -28,6 +28,7 @@ allow clockspeed_cli_t self:udp_socket c
 read_files_pattern(clockspeed_cli_t,clockspeed_var_lib_t,clockspeed_var_lib_t)
 
 corenet_all_recvfrom_unlabeled(clockspeed_cli_t)
+corenet_recvfrom_unlabeled_peer(clockspeed_cli_t)
 corenet_all_recvfrom_netlabel(clockspeed_cli_t)
 corenet_udp_sendrecv_generic_if(clockspeed_cli_t)
 corenet_udp_sendrecv_generic_node(clockspeed_cli_t)
@@ -56,6 +57,7 @@ manage_files_pattern(clockspeed_srv_t,cl
 manage_fifo_files_pattern(clockspeed_srv_t,clockspeed_var_lib_t,clockspeed_var_lib_t)
 
 corenet_all_recvfrom_unlabeled(clockspeed_srv_t)
+corenet_recvfrom_unlabeled_peer(clockspeed_srv_t)
 corenet_all_recvfrom_netlabel(clockspeed_srv_t)
 corenet_udp_sendrecv_generic_if(clockspeed_srv_t)
 corenet_udp_sendrecv_generic_node(clockspeed_srv_t)
Index: refpolicy_svn_repo/policy/modules/services/comsat.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/comsat.te
+++ refpolicy_svn_repo/policy/modules/services/comsat.te
@@ -41,6 +41,7 @@ kernel_read_network_state(comsat_t)
 kernel_read_system_state(comsat_t)
 
 corenet_all_recvfrom_unlabeled(comsat_t)
+corenet_recvfrom_unlabeled_peer(comsat_t)
 corenet_all_recvfrom_netlabel(comsat_t)
 corenet_tcp_sendrecv_all_if(comsat_t)
 corenet_udp_sendrecv_all_if(comsat_t)
Index: refpolicy_svn_repo/policy/modules/services/courier.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/courier.if
+++ refpolicy_svn_repo/policy/modules/services/courier.if
@@ -49,6 +49,7 @@ template(`courier_domain_template',`
 	corecmd_exec_bin(courier_$1_t)
 
 	corenet_all_recvfrom_unlabeled(courier_$1_t)
+	corenet_recvfrom_unlabeled_peer(courier_$1_t)
 	corenet_all_recvfrom_netlabel(courier_$1_t)
 	corenet_tcp_sendrecv_generic_if(courier_$1_t)
 	corenet_udp_sendrecv_generic_if(courier_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/cron.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cron.if
+++ refpolicy_svn_repo/policy/modules/services/cron.if
@@ -94,6 +94,7 @@ template(`cron_per_role_template',`
 	files_dontaudit_search_boot($1_crond_t)
 
 	corenet_all_recvfrom_unlabeled($1_crond_t)
+	corenet_recvfrom_unlabeled_peer($1_crond_t)
 	corenet_all_recvfrom_netlabel($1_crond_t)
 	corenet_tcp_sendrecv_all_if($1_crond_t)
 	corenet_udp_sendrecv_all_if($1_crond_t)
Index: refpolicy_svn_repo/policy/modules/services/cron.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cron.te
+++ refpolicy_svn_repo/policy/modules/services/cron.te
@@ -281,6 +281,7 @@ files_dontaudit_search_boot(system_crond
 corecmd_exec_all_executables(system_crond_t)
 
 corenet_all_recvfrom_unlabeled(system_crond_t)
+corenet_recvfrom_unlabeled_peer(system_crond_t)
 corenet_all_recvfrom_netlabel(system_crond_t)
 corenet_tcp_sendrecv_all_if(system_crond_t)
 corenet_udp_sendrecv_all_if(system_crond_t)
Index: refpolicy_svn_repo/policy/modules/services/cups.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cups.te
+++ refpolicy_svn_repo/policy/modules/services/cups.te
@@ -133,6 +133,7 @@ kernel_read_network_state(cupsd_t)
 kernel_read_all_sysctls(cupsd_t)
 
 corenet_all_recvfrom_unlabeled(cupsd_t)
+corenet_recvfrom_unlabeled_peer(cupsd_t)
 corenet_all_recvfrom_netlabel(cupsd_t)
 corenet_tcp_sendrecv_all_if(cupsd_t)
 corenet_udp_sendrecv_all_if(cupsd_t)
@@ -316,6 +317,7 @@ kernel_read_system_state(cupsd_config_t)
 kernel_read_kernel_sysctls(cupsd_config_t)
 
 corenet_all_recvfrom_unlabeled(cupsd_config_t)
+corenet_recvfrom_unlabeled_peer(cupsd_config_t)
 corenet_all_recvfrom_netlabel(cupsd_config_t)
 corenet_tcp_sendrecv_all_if(cupsd_config_t)
 corenet_tcp_sendrecv_all_nodes(cupsd_config_t)
@@ -449,6 +451,7 @@ kernel_read_system_state(cupsd_lpd_t)
 kernel_read_network_state(cupsd_lpd_t)
 
 corenet_all_recvfrom_unlabeled(cupsd_lpd_t)
+corenet_recvfrom_unlabeled_peer(cupsd_lpd_t)
 corenet_all_recvfrom_netlabel(cupsd_lpd_t)
 corenet_tcp_sendrecv_all_if(cupsd_lpd_t)
 corenet_udp_sendrecv_all_if(cupsd_lpd_t)
@@ -515,6 +518,7 @@ kernel_read_system_state(hplip_t)
 kernel_read_kernel_sysctls(hplip_t)
 
 corenet_all_recvfrom_unlabeled(hplip_t)
+corenet_recvfrom_unlabeled_peer(hplip_t)
 corenet_all_recvfrom_netlabel(hplip_t)
 corenet_tcp_sendrecv_all_if(hplip_t)
 corenet_udp_sendrecv_all_if(hplip_t)
@@ -607,6 +611,7 @@ kernel_list_proc(ptal_t)
 kernel_read_proc_symlinks(ptal_t)
 
 corenet_all_recvfrom_unlabeled(ptal_t)
+corenet_recvfrom_unlabeled_peer(ptal_t)
 corenet_all_recvfrom_netlabel(ptal_t)
 corenet_tcp_sendrecv_all_if(ptal_t)
 corenet_tcp_sendrecv_all_nodes(ptal_t)
Index: refpolicy_svn_repo/policy/modules/services/cvs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cvs.te
+++ refpolicy_svn_repo/policy/modules/services/cvs.te
@@ -56,6 +56,7 @@ kernel_read_system_state(cvs_t)
 kernel_read_network_state(cvs_t)
 
 corenet_all_recvfrom_unlabeled(cvs_t)
+corenet_recvfrom_unlabeled_peer(cvs_t)
 corenet_all_recvfrom_netlabel(cvs_t)
 corenet_tcp_sendrecv_all_if(cvs_t)
 corenet_udp_sendrecv_all_if(cvs_t)
Index: refpolicy_svn_repo/policy/modules/services/cyrus.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cyrus.te
+++ refpolicy_svn_repo/policy/modules/services/cyrus.te
@@ -61,6 +61,7 @@ kernel_read_system_state(cyrus_t)
 kernel_read_all_sysctls(cyrus_t)
 
 corenet_all_recvfrom_unlabeled(cyrus_t)
+corenet_recvfrom_unlabeled_peer(cyrus_t)
 corenet_all_recvfrom_netlabel(cyrus_t)
 corenet_tcp_sendrecv_all_if(cyrus_t)
 corenet_udp_sendrecv_all_if(cyrus_t)
Index: refpolicy_svn_repo/policy/modules/services/dante.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dante.te
+++ refpolicy_svn_repo/policy/modules/services/dante.te
@@ -39,6 +39,7 @@ kernel_list_proc(dante_t)
 kernel_read_proc_symlinks(dante_t)
 
 corenet_all_recvfrom_unlabeled(dante_t)
+corenet_recvfrom_unlabeled_peer(dante_t)
 corenet_all_recvfrom_netlabel(dante_t)
 corenet_tcp_sendrecv_generic_if(dante_t)
 corenet_udp_sendrecv_generic_if(dante_t)
Index: refpolicy_svn_repo/policy/modules/services/dbskk.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dbskk.te
+++ refpolicy_svn_repo/policy/modules/services/dbskk.te
@@ -49,6 +49,7 @@ kernel_read_system_state(dbskkd_t)
 kernel_read_network_state(dbskkd_t)
 
 corenet_all_recvfrom_unlabeled(dbskkd_t)
+corenet_recvfrom_unlabeled_peer(dbskkd_t)
 corenet_all_recvfrom_netlabel(dbskkd_t)
 corenet_tcp_sendrecv_all_if(dbskkd_t)
 corenet_udp_sendrecv_all_if(dbskkd_t)
Index: refpolicy_svn_repo/policy/modules/services/dbus.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dbus.if
+++ refpolicy_svn_repo/policy/modules/services/dbus.if
@@ -121,6 +121,7 @@ template(`dbus_per_role_template',`
 	corecmd_read_bin_sockets($1_dbusd_t)
 
 	corenet_all_recvfrom_unlabeled($1_dbusd_t)
+	corenet_recvfrom_unlabeled_peer($1_dbusd_t)
 	corenet_all_recvfrom_netlabel($1_dbusd_t)
 	corenet_tcp_sendrecv_all_if($1_dbusd_t)
 	corenet_tcp_sendrecv_all_nodes($1_dbusd_t)
Index: refpolicy_svn_repo/policy/modules/services/dcc.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dcc.te
+++ refpolicy_svn_repo/policy/modules/services/dcc.te
@@ -97,6 +97,7 @@ read_files_pattern(cdcc_t,dcc_var_t,dcc_
 read_lnk_files_pattern(cdcc_t,dcc_var_t,dcc_var_t)
 
 corenet_all_recvfrom_unlabeled(cdcc_t)
+corenet_recvfrom_unlabeled_peer(cdcc_t)
 corenet_all_recvfrom_netlabel(cdcc_t)
 corenet_udp_sendrecv_generic_if(cdcc_t)
 corenet_udp_sendrecv_all_nodes(cdcc_t)
@@ -140,6 +141,7 @@ read_files_pattern(dcc_client_t,dcc_var_
 read_lnk_files_pattern(dcc_client_t,dcc_var_t,dcc_var_t)
 
 corenet_all_recvfrom_unlabeled(dcc_client_t)
+corenet_recvfrom_unlabeled_peer(dcc_client_t)
 corenet_all_recvfrom_netlabel(dcc_client_t)
 corenet_udp_sendrecv_generic_if(dcc_client_t)
 corenet_udp_sendrecv_all_nodes(dcc_client_t)
@@ -183,6 +185,7 @@ manage_lnk_files_pattern(dcc_dbclean_t,d
 kernel_read_system_state(dcc_dbclean_t)
 
 corenet_all_recvfrom_unlabeled(dcc_dbclean_t)
+corenet_recvfrom_unlabeled_peer(dcc_dbclean_t)
 corenet_all_recvfrom_netlabel(dcc_dbclean_t)
 corenet_udp_sendrecv_generic_if(dcc_dbclean_t)
 corenet_udp_sendrecv_all_nodes(dcc_dbclean_t)
@@ -244,6 +247,7 @@ kernel_read_system_state(dccd_t)
 kernel_read_kernel_sysctls(dccd_t)
 
 corenet_all_recvfrom_unlabeled(dccd_t)
+corenet_recvfrom_unlabeled_peer(dccd_t)
 corenet_all_recvfrom_netlabel(dccd_t)
 corenet_udp_sendrecv_generic_if(dccd_t)
 corenet_udp_sendrecv_all_nodes(dccd_t)
@@ -320,6 +324,7 @@ kernel_read_system_state(dccifd_t)
 kernel_read_kernel_sysctls(dccifd_t)
 
 corenet_all_recvfrom_unlabeled(dccifd_t)
+corenet_recvfrom_unlabeled_peer(dccifd_t)
 corenet_all_recvfrom_netlabel(dccifd_t)
 corenet_udp_sendrecv_generic_if(dccifd_t)
 corenet_udp_sendrecv_all_nodes(dccifd_t)
@@ -392,6 +397,7 @@ kernel_read_system_state(dccm_t)
 kernel_read_kernel_sysctls(dccm_t)
 
 corenet_all_recvfrom_unlabeled(dccm_t)
+corenet_recvfrom_unlabeled_peer(dccm_t)
 corenet_all_recvfrom_netlabel(dccm_t)
 corenet_udp_sendrecv_generic_if(dccm_t)
 corenet_udp_sendrecv_all_nodes(dccm_t)
Index: refpolicy_svn_repo/policy/modules/services/ddclient.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ddclient.te
+++ refpolicy_svn_repo/policy/modules/services/ddclient.te
@@ -65,6 +65,7 @@ corecmd_exec_shell(ddclient_t)
 corecmd_exec_bin(ddclient_t)
 
 corenet_all_recvfrom_unlabeled(ddclient_t)
+corenet_recvfrom_unlabeled_peer(ddclient_t)
 corenet_all_recvfrom_netlabel(ddclient_t)
 corenet_tcp_sendrecv_generic_if(ddclient_t)
 corenet_udp_sendrecv_generic_if(ddclient_t)
Index: refpolicy_svn_repo/policy/modules/services/dhcp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dhcp.te
+++ refpolicy_svn_repo/policy/modules/services/dhcp.te
@@ -53,6 +53,7 @@ kernel_read_system_state(dhcpd_t)
 kernel_read_kernel_sysctls(dhcpd_t)
 
 corenet_all_recvfrom_unlabeled(dhcpd_t)
+corenet_recvfrom_unlabeled_peer(dhcpd_t)
 corenet_all_recvfrom_netlabel(dhcpd_t)
 corenet_tcp_sendrecv_all_if(dhcpd_t)
 corenet_udp_sendrecv_all_if(dhcpd_t)
Index: refpolicy_svn_repo/policy/modules/services/dictd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dictd.te
+++ refpolicy_svn_repo/policy/modules/services/dictd.te
@@ -38,6 +38,7 @@ kernel_read_system_state(dictd_t)
 kernel_read_kernel_sysctls(dictd_t)
 
 corenet_all_recvfrom_unlabeled(dictd_t)
+corenet_recvfrom_unlabeled_peer(dictd_t)
 corenet_all_recvfrom_netlabel(dictd_t)
 corenet_tcp_sendrecv_all_if(dictd_t)
 corenet_raw_sendrecv_all_if(dictd_t)
Index: refpolicy_svn_repo/policy/modules/services/distcc.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/distcc.te
+++ refpolicy_svn_repo/policy/modules/services/distcc.te
@@ -46,6 +46,7 @@ kernel_read_system_state(distccd_t)
 kernel_read_kernel_sysctls(distccd_t)
 
 corenet_all_recvfrom_unlabeled(distccd_t)
+corenet_recvfrom_unlabeled_peer(distccd_t)
 corenet_all_recvfrom_netlabel(distccd_t)
 corenet_tcp_sendrecv_all_if(distccd_t)
 corenet_udp_sendrecv_all_if(distccd_t)
Index: refpolicy_svn_repo/policy/modules/services/djbdns.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/djbdns.if
+++ refpolicy_svn_repo/policy/modules/services/djbdns.if
@@ -33,6 +33,7 @@ template(`djbdns_daemontools_domain_temp
 	allow djbdns_$1_t djbdns_$1_conf_t:file read_file_perms;
 
 	corenet_all_recvfrom_unlabeled(djbdns_$1_t)
+	corenet_recvfrom_unlabeled_peer(djbdns_$1_t)
 	corenet_all_recvfrom_netlabel(djbdns_$1_t)
 	corenet_tcp_sendrecv_all_if(djbdns_$1_t)
 	corenet_udp_sendrecv_all_if(djbdns_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/dnsmasq.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dnsmasq.te
+++ refpolicy_svn_repo/policy/modules/services/dnsmasq.te
@@ -43,6 +43,7 @@ kernel_list_proc(dnsmasq_t)
 kernel_read_proc_symlinks(dnsmasq_t)
 
 corenet_all_recvfrom_unlabeled(dnsmasq_t)
+corenet_recvfrom_unlabeled_peer(dnsmasq_t)
 corenet_all_recvfrom_netlabel(dnsmasq_t)
 corenet_tcp_sendrecv_generic_if(dnsmasq_t)
 corenet_udp_sendrecv_generic_if(dnsmasq_t)
Index: refpolicy_svn_repo/policy/modules/services/dovecot.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dovecot.te
+++ refpolicy_svn_repo/policy/modules/services/dovecot.te
@@ -70,6 +70,7 @@ kernel_read_kernel_sysctls(dovecot_t)
 kernel_read_system_state(dovecot_t)
 
 corenet_all_recvfrom_unlabeled(dovecot_t)
+corenet_recvfrom_unlabeled_peer(dovecot_t)
 corenet_all_recvfrom_netlabel(dovecot_t)
 corenet_tcp_sendrecv_all_if(dovecot_t)
 corenet_tcp_sendrecv_all_nodes(dovecot_t)
Index: refpolicy_svn_repo/policy/modules/services/exim.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/exim.te
+++ refpolicy_svn_repo/policy/modules/services/exim.te
@@ -70,6 +70,7 @@ kernel_read_kernel_sysctls(exim_t)
 corecmd_search_bin(exim_t)
 
 corenet_all_recvfrom_unlabeled(exim_t)
+corenet_recvfrom_unlabeled_peer(exim_t)
 corenet_tcp_sendrecv_all_if(exim_t)
 corenet_tcp_sendrecv_all_nodes(exim_t)
 corenet_tcp_sendrecv_all_ports(exim_t)
Index: refpolicy_svn_repo/policy/modules/services/fetchmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/fetchmail.te
+++ refpolicy_svn_repo/policy/modules/services/fetchmail.te
@@ -47,6 +47,7 @@ kernel_read_proc_symlinks(fetchmail_t)
 kernel_dontaudit_read_system_state(fetchmail_t)
 
 corenet_all_recvfrom_unlabeled(fetchmail_t)
+corenet_recvfrom_unlabeled_peer(fetchmail_t)
 corenet_all_recvfrom_netlabel(fetchmail_t)
 corenet_tcp_sendrecv_generic_if(fetchmail_t)
 corenet_udp_sendrecv_generic_if(fetchmail_t)
Index: refpolicy_svn_repo/policy/modules/services/finger.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/finger.te
+++ refpolicy_svn_repo/policy/modules/services/finger.te
@@ -48,6 +48,7 @@ kernel_read_kernel_sysctls(fingerd_t)
 kernel_read_system_state(fingerd_t)
 
 corenet_all_recvfrom_unlabeled(fingerd_t)
+corenet_recvfrom_unlabeled_peer(fingerd_t)
 corenet_all_recvfrom_netlabel(fingerd_t)
 corenet_tcp_sendrecv_all_if(fingerd_t)
 corenet_udp_sendrecv_all_if(fingerd_t)
Index: refpolicy_svn_repo/policy/modules/services/ftp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ftp.te
+++ refpolicy_svn_repo/policy/modules/services/ftp.te
@@ -130,6 +130,7 @@ dev_read_urand(ftpd_t)
 corecmd_exec_bin(ftpd_t)
 
 corenet_all_recvfrom_unlabeled(ftpd_t)
+corenet_recvfrom_unlabeled_peer(ftpd_t)
 corenet_all_recvfrom_netlabel(ftpd_t)
 corenet_tcp_sendrecv_all_if(ftpd_t)
 corenet_udp_sendrecv_all_if(ftpd_t)
Index: refpolicy_svn_repo/policy/modules/services/gatekeeper.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/gatekeeper.te
+++ refpolicy_svn_repo/policy/modules/services/gatekeeper.te
@@ -54,6 +54,7 @@ kernel_read_kernel_sysctls(gatekeeper_t)
 corecmd_list_bin(gatekeeper_t)
 
 corenet_all_recvfrom_unlabeled(gatekeeper_t)
+corenet_recvfrom_unlabeled_peer(gatekeeper_t)
 corenet_all_recvfrom_netlabel(gatekeeper_t)
 corenet_tcp_sendrecv_generic_if(gatekeeper_t)
 corenet_udp_sendrecv_generic_if(gatekeeper_t)
Index: refpolicy_svn_repo/policy/modules/services/hal.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/hal.te
+++ refpolicy_svn_repo/policy/modules/services/hal.te
@@ -99,6 +99,7 @@ auth_read_pam_console_data(hald_t)
 corecmd_exec_all_executables(hald_t)
 
 corenet_all_recvfrom_unlabeled(hald_t)
+corenet_recvfrom_unlabeled_peer(hald_t)
 corenet_all_recvfrom_netlabel(hald_t)
 corenet_tcp_sendrecv_all_if(hald_t)
 corenet_udp_sendrecv_all_if(hald_t)
Index: refpolicy_svn_repo/policy/modules/services/howl.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/howl.te
+++ refpolicy_svn_repo/policy/modules/services/howl.te
@@ -35,6 +35,7 @@ kernel_list_proc(howl_t)
 kernel_read_proc_symlinks(howl_t)
 
 corenet_all_recvfrom_unlabeled(howl_t)
+corenet_recvfrom_unlabeled_peer(howl_t)
 corenet_all_recvfrom_netlabel(howl_t)
 corenet_tcp_sendrecv_all_if(howl_t)
 corenet_udp_sendrecv_all_if(howl_t)
Index: refpolicy_svn_repo/policy/modules/services/i18n_input.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/i18n_input.te
+++ refpolicy_svn_repo/policy/modules/services/i18n_input.te
@@ -38,6 +38,7 @@ kernel_read_kernel_sysctls(i18n_input_t)
 kernel_read_system_state(i18n_input_t)
 
 corenet_all_recvfrom_unlabeled(i18n_input_t)
+corenet_recvfrom_unlabeled_peer(i18n_input_t)
 corenet_all_recvfrom_netlabel(i18n_input_t)
 corenet_tcp_sendrecv_generic_if(i18n_input_t)
 corenet_udp_sendrecv_generic_if(i18n_input_t)
Index: refpolicy_svn_repo/policy/modules/services/imaze.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/imaze.te
+++ refpolicy_svn_repo/policy/modules/services/imaze.te
@@ -56,6 +56,7 @@ kernel_list_proc(imazesrv_t)
 kernel_read_proc_symlinks(imazesrv_t)
 
 corenet_all_recvfrom_unlabeled(imazesrv_t)
+corenet_recvfrom_unlabeled_peer(imazesrv_t)
 corenet_all_recvfrom_netlabel(imazesrv_t)
 corenet_tcp_sendrecv_generic_if(imazesrv_t)
 corenet_udp_sendrecv_generic_if(imazesrv_t)
Index: refpolicy_svn_repo/policy/modules/services/inetd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/inetd.te
+++ refpolicy_svn_repo/policy/modules/services/inetd.te
@@ -61,6 +61,7 @@ kernel_tcp_recvfrom_unlabeled(inetd_t)
 
 # base networking:
 corenet_all_recvfrom_unlabeled(inetd_t)
+corenet_recvfrom_unlabeled_peer(inetd_t)
 corenet_all_recvfrom_netlabel(inetd_t)
 corenet_tcp_sendrecv_all_if(inetd_t)
 corenet_udp_sendrecv_all_if(inetd_t)
@@ -194,6 +195,7 @@ kernel_read_system_state(inetd_child_t)
 kernel_read_network_state(inetd_child_t)
 
 corenet_all_recvfrom_unlabeled(inetd_child_t)
+corenet_recvfrom_unlabeled_peer(inetd_child_t)
 corenet_all_recvfrom_netlabel(inetd_child_t)
 corenet_tcp_sendrecv_all_if(inetd_child_t)
 corenet_udp_sendrecv_all_if(inetd_child_t)
Index: refpolicy_svn_repo/policy/modules/services/inn.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/inn.te
+++ refpolicy_svn_repo/policy/modules/services/inn.te
@@ -64,6 +64,7 @@ kernel_read_kernel_sysctls(innd_t)
 kernel_read_system_state(innd_t)
 
 corenet_all_recvfrom_unlabeled(innd_t)
+corenet_recvfrom_unlabeled_peer(innd_t)
 corenet_all_recvfrom_netlabel(innd_t)
 corenet_tcp_sendrecv_all_if(innd_t)
 corenet_udp_sendrecv_all_if(innd_t)
Index: refpolicy_svn_repo/policy/modules/services/ircd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ircd.te
+++ refpolicy_svn_repo/policy/modules/services/ircd.te
@@ -51,6 +51,7 @@ kernel_read_kernel_sysctls(ircd_t)
 corecmd_search_bin(ircd_t)
 
 corenet_all_recvfrom_unlabeled(ircd_t)
+corenet_recvfrom_unlabeled_peer(ircd_t)
 corenet_all_recvfrom_netlabel(ircd_t)
 corenet_tcp_sendrecv_generic_if(ircd_t)
 corenet_udp_sendrecv_generic_if(ircd_t)
Index: refpolicy_svn_repo/policy/modules/services/jabber.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/jabber.te
+++ refpolicy_svn_repo/policy/modules/services/jabber.te
@@ -45,6 +45,7 @@ kernel_list_proc(jabberd_t)
 kernel_read_proc_symlinks(jabberd_t)
 
 corenet_all_recvfrom_unlabeled(jabberd_t)
+corenet_recvfrom_unlabeled_peer(jabberd_t)
 corenet_all_recvfrom_netlabel(jabberd_t)
 corenet_tcp_sendrecv_generic_if(jabberd_t)
 corenet_udp_sendrecv_generic_if(jabberd_t)
Index: refpolicy_svn_repo/policy/modules/services/kerberos.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/kerberos.if
+++ refpolicy_svn_repo/policy/modules/services/kerberos.if
@@ -48,6 +48,7 @@ interface(`kerberos_use',`
 		allow $1 self:udp_socket create_socket_perms;
 
 		corenet_all_recvfrom_unlabeled($1)
+		corenet_recvfrom_unlabeled_peer($1)
 		corenet_all_recvfrom_netlabel($1)
 		corenet_tcp_sendrecv_all_if($1)
 		corenet_udp_sendrecv_all_if($1)
Index: refpolicy_svn_repo/policy/modules/services/kerberos.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/kerberos.te
+++ refpolicy_svn_repo/policy/modules/services/kerberos.te
@@ -93,6 +93,7 @@ kernel_list_proc(kadmind_t)
 kernel_read_proc_symlinks(kadmind_t)
 
 corenet_all_recvfrom_unlabeled(kadmind_t)
+corenet_recvfrom_unlabeled_peer(kadmind_t)
 corenet_all_recvfrom_netlabel(kadmind_t)
 corenet_tcp_sendrecv_all_if(kadmind_t)
 corenet_udp_sendrecv_all_if(kadmind_t)
@@ -188,6 +189,7 @@ kernel_search_network_sysctl(krb5kdc_t)
 corecmd_exec_bin(krb5kdc_t)
 
 corenet_all_recvfrom_unlabeled(krb5kdc_t)
+corenet_recvfrom_unlabeled_peer(krb5kdc_t)
 corenet_all_recvfrom_netlabel(krb5kdc_t)
 corenet_tcp_sendrecv_all_if(krb5kdc_t)
 corenet_udp_sendrecv_all_if(krb5kdc_t)
Index: refpolicy_svn_repo/policy/modules/services/ktalk.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ktalk.te
+++ refpolicy_svn_repo/policy/modules/services/ktalk.te
@@ -54,6 +54,7 @@ kernel_read_system_state(ktalkd_t)
 kernel_read_network_state(ktalkd_t)
 
 corenet_all_recvfrom_unlabeled(ktalkd_t)
+corenet_recvfrom_unlabeled_peer(ktalkd_t)
 corenet_all_recvfrom_netlabel(ktalkd_t)
 corenet_tcp_sendrecv_all_if(ktalkd_t)
 corenet_udp_sendrecv_all_if(ktalkd_t)
Index: refpolicy_svn_repo/policy/modules/services/ldap.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ldap.te
+++ refpolicy_svn_repo/policy/modules/services/ldap.te
@@ -77,6 +77,7 @@ kernel_read_system_state(slapd_t)
 kernel_read_kernel_sysctls(slapd_t)
 
 corenet_all_recvfrom_unlabeled(slapd_t)
+corenet_recvfrom_unlabeled_peer(slapd_t)
 corenet_all_recvfrom_netlabel(slapd_t)
 corenet_tcp_sendrecv_all_if(slapd_t)
 corenet_udp_sendrecv_all_if(slapd_t)
Index: refpolicy_svn_repo/policy/modules/services/lpd.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/lpd.if
+++ refpolicy_svn_repo/policy/modules/services/lpd.if
@@ -104,6 +104,7 @@ template(`lpd_per_role_template',`
 	kernel_read_kernel_sysctls($1_lpr_t)
 
 	corenet_all_recvfrom_unlabeled($1_lpr_t)
+	corenet_recvfrom_unlabeled_peer($1_lpr_t)
 	corenet_all_recvfrom_netlabel($1_lpr_t)
 	corenet_tcp_sendrecv_generic_if($1_lpr_t)
 	corenet_udp_sendrecv_generic_if($1_lpr_t)
Index: refpolicy_svn_repo/policy/modules/services/lpd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/lpd.te
+++ refpolicy_svn_repo/policy/modules/services/lpd.te
@@ -73,6 +73,7 @@ allow checkpc_t printconf_t:dir { getatt
 kernel_read_system_state(checkpc_t)
 
 corenet_all_recvfrom_unlabeled(checkpc_t)
+corenet_recvfrom_unlabeled_peer(checkpc_t)
 corenet_all_recvfrom_netlabel(checkpc_t)
 corenet_tcp_sendrecv_all_if(checkpc_t)
 corenet_udp_sendrecv_all_if(checkpc_t)
@@ -154,6 +155,7 @@ kernel_read_kernel_sysctls(lpd_t)
 kernel_read_system_state(lpd_t)
 
 corenet_all_recvfrom_unlabeled(lpd_t)
+corenet_recvfrom_unlabeled_peer(lpd_t)
 corenet_all_recvfrom_netlabel(lpd_t)
 corenet_tcp_sendrecv_all_if(lpd_t)
 corenet_udp_sendrecv_all_if(lpd_t)
Index: refpolicy_svn_repo/policy/modules/services/mailman.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/mailman.if
+++ refpolicy_svn_repo/policy/modules/services/mailman.if
@@ -49,6 +49,7 @@ template(`mailman_domain_template', `
 	kernel_read_system_state(mailman_$1_t)
 
 	corenet_all_recvfrom_unlabeled(mailman_$1_t)
+	corenet_recvfrom_unlabeled_peer(mailman_$1_t)
 	corenet_all_recvfrom_netlabel(mailman_$1_t)
 	corenet_tcp_sendrecv_all_if(mailman_$1_t)
 	corenet_udp_sendrecv_all_if(mailman_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/monop.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/monop.te
+++ refpolicy_svn_repo/policy/modules/services/monop.te
@@ -44,6 +44,7 @@ kernel_list_proc(monopd_t)
 kernel_read_proc_symlinks(monopd_t)
 
 corenet_all_recvfrom_unlabeled(monopd_t)
+corenet_recvfrom_unlabeled_peer(monopd_t)
 corenet_all_recvfrom_netlabel(monopd_t)
 corenet_tcp_sendrecv_generic_if(monopd_t)
 corenet_udp_sendrecv_generic_if(monopd_t)
Index: refpolicy_svn_repo/policy/modules/services/mta.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/mta.if
+++ refpolicy_svn_repo/policy/modules/services/mta.if
@@ -72,6 +72,7 @@ template(`mta_base_mail_template',`
 	kernel_read_kernel_sysctls($1_mail_t)
 
 	corenet_all_recvfrom_unlabeled($1_mail_t)
+	corenet_recvfrom_unlabeled_peer($1_mail_t)
 	corenet_all_recvfrom_netlabel($1_mail_t)
 	corenet_tcp_sendrecv_all_if($1_mail_t)
 	corenet_tcp_sendrecv_all_nodes($1_mail_t)
Index: refpolicy_svn_repo/policy/modules/services/munin.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/munin.te
+++ refpolicy_svn_repo/policy/modules/services/munin.te
@@ -66,6 +66,7 @@ kernel_read_kernel_sysctls(munin_t)
 corecmd_exec_bin(munin_t)
 
 corenet_all_recvfrom_unlabeled(munin_t)
+corenet_recvfrom_unlabeled_peer(munin_t)
 corenet_all_recvfrom_netlabel(munin_t)
 corenet_tcp_sendrecv_generic_if(munin_t)
 corenet_udp_sendrecv_generic_if(munin_t)
Index: refpolicy_svn_repo/policy/modules/services/mysql.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/mysql.te
+++ refpolicy_svn_repo/policy/modules/services/mysql.te
@@ -62,6 +62,7 @@ kernel_read_system_state(mysqld_t)
 kernel_read_kernel_sysctls(mysqld_t)
 
 corenet_all_recvfrom_unlabeled(mysqld_t)
+corenet_recvfrom_unlabeled_peer(mysqld_t)
 corenet_all_recvfrom_netlabel(mysqld_t)
 corenet_tcp_sendrecv_all_if(mysqld_t)
 corenet_udp_sendrecv_all_if(mysqld_t)
Index: refpolicy_svn_repo/policy/modules/services/nagios.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nagios.te
+++ refpolicy_svn_repo/policy/modules/services/nagios.te
@@ -67,6 +67,7 @@ corecmd_exec_bin(nagios_t)
 corecmd_exec_shell(nagios_t)
 
 corenet_all_recvfrom_unlabeled(nagios_t)
+corenet_recvfrom_unlabeled_peer(nagios_t)
 corenet_all_recvfrom_netlabel(nagios_t)
 corenet_tcp_sendrecv_generic_if(nagios_t)
 corenet_udp_sendrecv_generic_if(nagios_t)
Index: refpolicy_svn_repo/policy/modules/services/nessus.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nessus.te
+++ refpolicy_svn_repo/policy/modules/services/nessus.te
@@ -58,6 +58,7 @@ kernel_read_kernel_sysctls(nessusd_t)
 corecmd_exec_bin(nessusd_t)
 
 corenet_all_recvfrom_unlabeled(nessusd_t)
+corenet_recvfrom_unlabeled_peer(nessusd_t)
 corenet_all_recvfrom_netlabel(nessusd_t)
 corenet_tcp_sendrecv_generic_if(nessusd_t)
 corenet_udp_sendrecv_generic_if(nessusd_t)
Index: refpolicy_svn_repo/policy/modules/services/networkmanager.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/networkmanager.te
+++ refpolicy_svn_repo/policy/modules/services/networkmanager.te
@@ -44,6 +44,7 @@ kernel_read_kernel_sysctls(NetworkManage
 kernel_load_module(NetworkManager_t)
 
 corenet_all_recvfrom_unlabeled(NetworkManager_t)
+corenet_recvfrom_unlabeled_peer(NetworkManager_t)
 corenet_all_recvfrom_netlabel(NetworkManager_t)
 corenet_tcp_sendrecv_all_if(NetworkManager_t)
 corenet_udp_sendrecv_all_if(NetworkManager_t)
Index: refpolicy_svn_repo/policy/modules/services/nis.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nis.if
+++ refpolicy_svn_repo/policy/modules/services/nis.if
@@ -38,6 +38,7 @@ interface(`nis_use_ypbind_uncond',`
 	allow $1 var_yp_t:file read_file_perms;
 
 	corenet_all_recvfrom_unlabeled($1)
+	corenet_recvfrom_unlabeled_peer($1)
 	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_udp_sendrecv_all_if($1)
Index: refpolicy_svn_repo/policy/modules/services/nis.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nis.te
+++ refpolicy_svn_repo/policy/modules/services/nis.te
@@ -70,6 +70,7 @@ kernel_list_proc(ypbind_t)
 kernel_read_proc_symlinks(ypbind_t)
 
 corenet_all_recvfrom_unlabeled(ypbind_t)
+corenet_recvfrom_unlabeled_peer(ypbind_t)
 corenet_all_recvfrom_netlabel(ypbind_t)
 corenet_tcp_sendrecv_all_if(ypbind_t)
 corenet_udp_sendrecv_all_if(ypbind_t)
@@ -147,6 +148,7 @@ kernel_getattr_proc_files(yppasswdd_t)
 kernel_read_kernel_sysctls(yppasswdd_t)
 
 corenet_all_recvfrom_unlabeled(yppasswdd_t)
+corenet_recvfrom_unlabeled_peer(yppasswdd_t)
 corenet_all_recvfrom_netlabel(yppasswdd_t)
 corenet_tcp_sendrecv_generic_if(yppasswdd_t)
 corenet_udp_sendrecv_generic_if(yppasswdd_t)
@@ -236,6 +238,7 @@ kernel_list_proc(ypserv_t)
 kernel_read_proc_symlinks(ypserv_t)
 
 corenet_all_recvfrom_unlabeled(ypserv_t)
+corenet_recvfrom_unlabeled_peer(ypserv_t)
 corenet_all_recvfrom_netlabel(ypserv_t)
 corenet_tcp_sendrecv_all_if(ypserv_t)
 corenet_udp_sendrecv_all_if(ypserv_t)
@@ -304,6 +307,7 @@ allow ypxfr_t ypserv_t:udp_socket { read
 allow ypxfr_t ypserv_conf_t:file { getattr read };
 
 corenet_all_recvfrom_unlabeled(ypxfr_t)
+corenet_recvfrom_unlabeled_peer(ypxfr_t)
 corenet_all_recvfrom_netlabel(ypxfr_t)
 corenet_tcp_sendrecv_all_if(ypxfr_t)
 corenet_udp_sendrecv_all_if(ypxfr_t)
Index: refpolicy_svn_repo/policy/modules/services/nscd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nscd.te
+++ refpolicy_svn_repo/policy/modules/services/nscd.te
@@ -66,6 +66,7 @@ auth_getattr_shadow(nscd_t)
 auth_use_nsswitch(nscd_t)
 
 corenet_all_recvfrom_unlabeled(nscd_t)
+corenet_recvfrom_unlabeled_peer(nscd_t)
 corenet_all_recvfrom_netlabel(nscd_t)
 corenet_tcp_sendrecv_all_if(nscd_t)
 corenet_udp_sendrecv_all_if(nscd_t)
Index: refpolicy_svn_repo/policy/modules/services/nsd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nsd.te
+++ refpolicy_svn_repo/policy/modules/services/nsd.te
@@ -63,6 +63,7 @@ kernel_read_kernel_sysctls(nsd_t)
 corecmd_exec_bin(nsd_t)
 
 corenet_all_recvfrom_unlabeled(nsd_t)
+corenet_recvfrom_unlabeled_peer(nsd_t)
 corenet_all_recvfrom_netlabel(nsd_t)
 corenet_tcp_sendrecv_generic_if(nsd_t)
 corenet_udp_sendrecv_generic_if(nsd_t)
@@ -144,6 +145,7 @@ corecmd_exec_bin(nsd_crond_t)
 corecmd_exec_shell(nsd_crond_t)
 
 corenet_all_recvfrom_unlabeled(nsd_crond_t)
+corenet_recvfrom_unlabeled_peer(nsd_crond_t)
 corenet_all_recvfrom_netlabel(nsd_crond_t)
 corenet_tcp_sendrecv_generic_if(nsd_crond_t)
 corenet_udp_sendrecv_generic_if(nsd_crond_t)
Index: refpolicy_svn_repo/policy/modules/services/ntop.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ntop.te
+++ refpolicy_svn_repo/policy/modules/services/ntop.te
@@ -63,6 +63,7 @@ kernel_list_proc(ntop_t)
 kernel_read_proc_symlinks(ntop_t)
 
 corenet_all_recvfrom_unlabeled(ntop_t)
+corenet_recvfrom_unlabeled_peer(ntop_t)
 corenet_all_recvfrom_netlabel(ntop_t)
 corenet_tcp_sendrecv_generic_if(ntop_t)
 corenet_udp_sendrecv_generic_if(ntop_t)
Index: refpolicy_svn_repo/policy/modules/services/ntp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ntp.te
+++ refpolicy_svn_repo/policy/modules/services/ntp.te
@@ -62,6 +62,7 @@ kernel_read_system_state(ntpd_t)
 kernel_read_network_state(ntpd_t)
 
 corenet_all_recvfrom_unlabeled(ntpd_t)
+corenet_recvfrom_unlabeled_peer(ntpd_t)
 corenet_all_recvfrom_netlabel(ntpd_t)
 corenet_tcp_sendrecv_all_if(ntpd_t)
 corenet_udp_sendrecv_all_if(ntpd_t)
Index: refpolicy_svn_repo/policy/modules/services/nx.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nx.te
+++ refpolicy_svn_repo/policy/modules/services/nx.te
@@ -52,6 +52,7 @@ corecmd_exec_shell(nx_server_t)
 corecmd_exec_bin(nx_server_t)
 
 corenet_all_recvfrom_unlabeled(nx_server_t)
+corenet_recvfrom_unlabeled_peer(nx_server_t)
 corenet_all_recvfrom_netlabel(nx_server_t)
 corenet_tcp_sendrecv_generic_if(nx_server_t)
 corenet_udp_sendrecv_generic_if(nx_server_t)
Index: refpolicy_svn_repo/policy/modules/services/oav.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/oav.te
+++ refpolicy_svn_repo/policy/modules/services/oav.te
@@ -50,6 +50,7 @@ read_lnk_files_pattern(oav_update_t,oav_
 corecmd_exec_all_executables(oav_update_t)
 
 corenet_all_recvfrom_unlabeled(oav_update_t)
+corenet_recvfrom_unlabeled_peer(oav_update_t)
 corenet_all_recvfrom_netlabel(oav_update_t)
 corenet_tcp_sendrecv_generic_if(oav_update_t)
 corenet_udp_sendrecv_generic_if(oav_update_t)
@@ -105,6 +106,7 @@ kernel_read_kernel_sysctls(scannerdaemon
 corecmd_exec_all_executables(scannerdaemon_t)
 
 corenet_all_recvfrom_unlabeled(scannerdaemon_t)
+corenet_recvfrom_unlabeled_peer(scannerdaemon_t)
 corenet_all_recvfrom_netlabel(scannerdaemon_t)
 corenet_tcp_sendrecv_generic_if(scannerdaemon_t)
 corenet_udp_sendrecv_generic_if(scannerdaemon_t)
Index: refpolicy_svn_repo/policy/modules/services/openvpn.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/openvpn.te
+++ refpolicy_svn_repo/policy/modules/services/openvpn.te
@@ -63,6 +63,7 @@ corecmd_exec_bin(openvpn_t)
 corecmd_exec_shell(openvpn_t)
 
 corenet_all_recvfrom_unlabeled(openvpn_t)
+corenet_recvfrom_unlabeled_peer(openvpn_t)
 corenet_all_recvfrom_netlabel(openvpn_t)
 corenet_tcp_sendrecv_all_if(openvpn_t)
 corenet_udp_sendrecv_all_if(openvpn_t)
Index: refpolicy_svn_repo/policy/modules/services/pcscd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/pcscd.te
+++ refpolicy_svn_repo/policy/modules/services/pcscd.te
@@ -32,6 +32,7 @@ manage_sock_files_pattern(pcscd_t,pcscd_
 files_pid_filetrans(pcscd_t,pcscd_var_run_t, { file sock_file })
 
 corenet_all_recvfrom_unlabeled(pcscd_t)
+corenet_recvfrom_unlabeled_peer(pcscd_t)
 corenet_all_recvfrom_netlabel(pcscd_t)
 corenet_tcp_sendrecv_all_if(pcscd_t)
 corenet_tcp_sendrecv_all_nodes(pcscd_t)
Index: refpolicy_svn_repo/policy/modules/services/pegasus.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/pegasus.te
+++ refpolicy_svn_repo/policy/modules/services/pegasus.te
@@ -67,6 +67,7 @@ kernel_search_vm_sysctl(pegasus_t)
 kernel_read_net_sysctls(pegasus_t)
 
 corenet_all_recvfrom_unlabeled(pegasus_t)
+corenet_recvfrom_unlabeled_peer(pegasus_t)
 corenet_all_recvfrom_netlabel(pegasus_t)
 corenet_tcp_sendrecv_all_if(pegasus_t)
 corenet_tcp_sendrecv_all_nodes(pegasus_t)
Index: refpolicy_svn_repo/policy/modules/services/perdition.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/perdition.te
+++ refpolicy_svn_repo/policy/modules/services/perdition.te
@@ -38,6 +38,7 @@ kernel_list_proc(perdition_t)
 kernel_read_proc_symlinks(perdition_t)
 
 corenet_all_recvfrom_unlabeled(perdition_t)
+corenet_recvfrom_unlabeled_peer(perdition_t)
 corenet_all_recvfrom_netlabel(perdition_t)
 corenet_tcp_sendrecv_generic_if(perdition_t)
 corenet_udp_sendrecv_generic_if(perdition_t)
Index: refpolicy_svn_repo/policy/modules/services/portmap.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/portmap.te
+++ refpolicy_svn_repo/policy/modules/services/portmap.te
@@ -46,6 +46,7 @@ kernel_list_proc(portmap_t)
 kernel_read_proc_symlinks(portmap_t)
 
 corenet_all_recvfrom_unlabeled(portmap_t)
+corenet_recvfrom_unlabeled_peer(portmap_t)
 corenet_all_recvfrom_netlabel(portmap_t)
 corenet_tcp_sendrecv_all_if(portmap_t)
 corenet_udp_sendrecv_all_if(portmap_t)
@@ -119,6 +120,7 @@ allow portmap_helper_t portmap_var_run_t
 files_pid_filetrans(portmap_helper_t,portmap_var_run_t,file)
 
 corenet_all_recvfrom_unlabeled(portmap_helper_t)
+corenet_recvfrom_unlabeled_peer(portmap_helper_t)
 corenet_all_recvfrom_netlabel(portmap_helper_t)
 corenet_tcp_sendrecv_all_if(portmap_helper_t)
 corenet_udp_sendrecv_all_if(portmap_helper_t)
Index: refpolicy_svn_repo/policy/modules/services/portslave.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/portslave.te
+++ refpolicy_svn_repo/policy/modules/services/portslave.te
@@ -56,6 +56,7 @@ corecmd_exec_bin(portslave_t)
 corecmd_exec_shell(portslave_t)
 
 corenet_all_recvfrom_unlabeled(portslave_t)
+corenet_recvfrom_unlabeled_peer(portslave_t)
 corenet_all_recvfrom_netlabel(portslave_t)
 corenet_tcp_sendrecv_generic_if(portslave_t)
 corenet_udp_sendrecv_generic_if(portslave_t)
Index: refpolicy_svn_repo/policy/modules/services/postfix.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postfix.if
+++ refpolicy_svn_repo/policy/modules/services/postfix.if
@@ -121,6 +121,7 @@ template(`postfix_server_domain_template
 	domtrans_pattern(postfix_master_t, postfix_$1_exec_t, postfix_$1_t)
 
 	corenet_all_recvfrom_unlabeled(postfix_$1_t)
+	corenet_recvfrom_unlabeled_peer(postfix_$1_t)
 	corenet_all_recvfrom_netlabel(postfix_$1_t)
 	corenet_tcp_sendrecv_all_if(postfix_$1_t)
 	corenet_udp_sendrecv_all_if(postfix_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/postfix.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postfix.te
+++ refpolicy_svn_repo/policy/modules/services/postfix.te
@@ -139,6 +139,7 @@ rename_files_pattern(postfix_master_t,po
 kernel_read_all_sysctls(postfix_master_t)
 
 corenet_all_recvfrom_unlabeled(postfix_master_t)
+corenet_recvfrom_unlabeled_peer(postfix_master_t)
 corenet_all_recvfrom_netlabel(postfix_master_t)
 corenet_tcp_sendrecv_all_if(postfix_master_t)
 corenet_udp_sendrecv_all_if(postfix_master_t)
@@ -315,6 +316,7 @@ kernel_dontaudit_list_proc(postfix_map_t
 kernel_dontaudit_read_system_state(postfix_map_t)
 
 corenet_all_recvfrom_unlabeled(postfix_map_t)
+corenet_recvfrom_unlabeled_peer(postfix_map_t)
 corenet_all_recvfrom_netlabel(postfix_map_t)
 corenet_tcp_sendrecv_all_if(postfix_map_t)
 corenet_udp_sendrecv_all_if(postfix_map_t)
Index: refpolicy_svn_repo/policy/modules/services/postfixpolicyd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postfixpolicyd.te
+++ refpolicy_svn_repo/policy/modules/services/postfixpolicyd.te
@@ -34,6 +34,7 @@ manage_files_pattern(postfix_policyd_t, 
 files_pid_filetrans(postfix_policyd_t, postfix_policyd_var_run_t, file)
 
 corenet_all_recvfrom_unlabeled(postfix_policyd_t)
+corenet_recvfrom_unlabeled_peer(postfix_policyd_t)
 corenet_tcp_sendrecv_generic_if(postfix_policyd_t)
 corenet_tcp_sendrecv_all_nodes(postfix_policyd_t)
 corenet_tcp_sendrecv_all_ports(postfix_policyd_t)
Index: refpolicy_svn_repo/policy/modules/services/postgresql.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postgresql.te
+++ refpolicy_svn_repo/policy/modules/services/postgresql.te
@@ -82,6 +82,7 @@ kernel_read_all_sysctls(postgresql_t)
 kernel_read_proc_symlinks(postgresql_t)
 
 corenet_all_recvfrom_unlabeled(postgresql_t)
+corenet_recvfrom_unlabeled_peer(postgresql_t)
 corenet_all_recvfrom_netlabel(postgresql_t)
 corenet_tcp_sendrecv_all_if(postgresql_t)
 corenet_udp_sendrecv_all_if(postgresql_t)
Index: refpolicy_svn_repo/policy/modules/services/postgrey.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postgrey.te
+++ refpolicy_svn_repo/policy/modules/services/postgrey.te
@@ -47,6 +47,7 @@ kernel_read_kernel_sysctls(postgrey_t)
 corecmd_search_bin(postgrey_t)
 
 corenet_all_recvfrom_unlabeled(postgrey_t)
+corenet_recvfrom_unlabeled_peer(postgrey_t)
 corenet_all_recvfrom_netlabel(postgrey_t)
 corenet_tcp_sendrecv_generic_if(postgrey_t)
 corenet_tcp_sendrecv_all_nodes(postgrey_t)
Index: refpolicy_svn_repo/policy/modules/services/ppp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ppp.te
+++ refpolicy_svn_repo/policy/modules/services/ppp.te
@@ -125,6 +125,7 @@ dev_search_sysfs(pppd_t)
 dev_read_sysfs(pppd_t)
 
 corenet_all_recvfrom_unlabeled(pppd_t)
+corenet_recvfrom_unlabeled_peer(pppd_t)
 corenet_all_recvfrom_netlabel(pppd_t)
 corenet_tcp_sendrecv_all_if(pppd_t)
 corenet_raw_sendrecv_all_if(pppd_t)
@@ -250,6 +251,7 @@ kernel_read_proc_symlinks(pptp_t)
 dev_read_sysfs(pptp_t)
 
 corenet_all_recvfrom_unlabeled(pptp_t)
+corenet_recvfrom_unlabeled_peer(pptp_t)
 corenet_all_recvfrom_netlabel(pptp_t)
 corenet_tcp_sendrecv_all_if(pptp_t)
 corenet_raw_sendrecv_all_if(pptp_t)
Index: refpolicy_svn_repo/policy/modules/services/privoxy.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/privoxy.te
+++ refpolicy_svn_repo/policy/modules/services/privoxy.te
@@ -41,6 +41,7 @@ kernel_list_proc(privoxy_t)
 kernel_read_proc_symlinks(privoxy_t)
 
 corenet_all_recvfrom_unlabeled(privoxy_t)
+corenet_recvfrom_unlabeled_peer(privoxy_t)
 corenet_all_recvfrom_netlabel(privoxy_t)
 corenet_tcp_sendrecv_all_if(privoxy_t)
 corenet_tcp_sendrecv_all_nodes(privoxy_t)
Index: refpolicy_svn_repo/policy/modules/services/procmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/procmail.te
+++ refpolicy_svn_repo/policy/modules/services/procmail.te
@@ -36,6 +36,7 @@ kernel_read_system_state(procmail_t)
 kernel_read_kernel_sysctls(procmail_t)
 
 corenet_all_recvfrom_unlabeled(procmail_t)
+corenet_recvfrom_unlabeled_peer(procmail_t)
 corenet_all_recvfrom_netlabel(procmail_t)
 corenet_tcp_sendrecv_all_if(procmail_t)
 corenet_udp_sendrecv_all_if(procmail_t)
Index: refpolicy_svn_repo/policy/modules/services/pyzor.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/pyzor.te
+++ refpolicy_svn_repo/policy/modules/services/pyzor.te
@@ -108,6 +108,7 @@ dev_read_urand(pyzord_t)
 corecmd_exec_bin(pyzord_t)
 
 corenet_all_recvfrom_unlabeled(pyzord_t)
+corenet_recvfrom_unlabeled_peer(pyzord_t)
 corenet_all_recvfrom_netlabel(pyzord_t)
 corenet_udp_sendrecv_all_if(pyzord_t)
 corenet_udp_sendrecv_all_nodes(pyzord_t)
Index: refpolicy_svn_repo/policy/modules/services/qmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/qmail.te
+++ refpolicy_svn_repo/policy/modules/services/qmail.te
@@ -171,6 +171,7 @@ allow qmail_remote_t self:udp_socket cre
 rw_files_pattern(qmail_remote_t,qmail_spool_t,qmail_spool_t)
 
 corenet_all_recvfrom_unlabeled(qmail_remote_t)
+corenet_recvfrom_unlabeled_peer(qmail_remote_t)
 corenet_all_recvfrom_netlabel(qmail_remote_t)
 corenet_tcp_sendrecv_generic_if(qmail_remote_t)
 corenet_udp_sendrecv_generic_if(qmail_remote_t)
Index: refpolicy_svn_repo/policy/modules/services/radius.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/radius.te
+++ refpolicy_svn_repo/policy/modules/services/radius.te
@@ -64,6 +64,7 @@ kernel_read_kernel_sysctls(radiusd_t)
 kernel_read_system_state(radiusd_t)
 
 corenet_all_recvfrom_unlabeled(radiusd_t)
+corenet_recvfrom_unlabeled_peer(radiusd_t)
 corenet_all_recvfrom_netlabel(radiusd_t)
 corenet_tcp_sendrecv_all_if(radiusd_t)
 corenet_udp_sendrecv_all_if(radiusd_t)
Index: refpolicy_svn_repo/policy/modules/services/radvd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/radvd.te
+++ refpolicy_svn_repo/policy/modules/services/radvd.te
@@ -39,6 +39,7 @@ kernel_read_network_state(radvd_t)
 kernel_read_system_state(radvd_t)
 
 corenet_all_recvfrom_unlabeled(radvd_t)
+corenet_recvfrom_unlabeled_peer(radvd_t)
 corenet_all_recvfrom_netlabel(radvd_t)
 corenet_tcp_sendrecv_all_if(radvd_t)
 corenet_udp_sendrecv_all_if(radvd_t)
Index: refpolicy_svn_repo/policy/modules/services/razor.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/razor.if
+++ refpolicy_svn_repo/policy/modules/services/razor.if
@@ -68,6 +68,7 @@ template(`razor_common_domain_template',
 	corecmd_exec_bin($1_t)
 
 	corenet_all_recvfrom_unlabeled($1_t)
+	corenet_recvfrom_unlabeled_peer($1_t)
 	corenet_all_recvfrom_netlabel($1_t)
 	corenet_tcp_sendrecv_generic_if($1_t)
 	corenet_raw_sendrecv_generic_if($1_t)
Index: refpolicy_svn_repo/policy/modules/services/razor.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/razor.te
+++ refpolicy_svn_repo/policy/modules/services/razor.te
@@ -42,6 +42,7 @@ manage_files_pattern(razor_t,razor_var_l
 files_var_lib_filetrans(razor_t,razor_var_lib_t,file)
 
 corenet_all_recvfrom_unlabeled(razor_t)
+corenet_recvfrom_unlabeled_peer(razor_t)
 corenet_all_recvfrom_netlabel(razor_t)
 corenet_tcp_sendrecv_generic_if(razor_t)
 corenet_raw_sendrecv_generic_if(razor_t)
Index: refpolicy_svn_repo/policy/modules/services/rdisc.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rdisc.te
+++ refpolicy_svn_repo/policy/modules/services/rdisc.te
@@ -27,6 +27,7 @@ kernel_read_proc_symlinks(rdisc_t)
 kernel_read_kernel_sysctls(rdisc_t)
 
 corenet_all_recvfrom_unlabeled(rdisc_t)
+corenet_recvfrom_unlabeled_peer(rdisc_t)
 corenet_all_recvfrom_netlabel(rdisc_t)
 corenet_udp_sendrecv_generic_if(rdisc_t)
 corenet_raw_sendrecv_generic_if(rdisc_t)
Index: refpolicy_svn_repo/policy/modules/services/rhgb.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rhgb.te
+++ refpolicy_svn_repo/policy/modules/services/rhgb.te
@@ -48,6 +48,7 @@ corecmd_exec_bin(rhgb_t)
 corecmd_exec_shell(rhgb_t)
 
 corenet_all_recvfrom_unlabeled(rhgb_t)
+corenet_recvfrom_unlabeled_peer(rhgb_t)
 corenet_all_recvfrom_netlabel(rhgb_t)
 corenet_tcp_sendrecv_generic_if(rhgb_t)
 corenet_udp_sendrecv_generic_if(rhgb_t)
Index: refpolicy_svn_repo/policy/modules/services/ricci.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ricci.te
+++ refpolicy_svn_repo/policy/modules/services/ricci.te
@@ -121,6 +121,7 @@ kernel_read_kernel_sysctls(ricci_t)
 corecmd_exec_bin(ricci_t)
 
 corenet_all_recvfrom_unlabeled(ricci_t)
+corenet_recvfrom_unlabeled_peer(ricci_t)
 corenet_all_recvfrom_netlabel(ricci_t)
 corenet_tcp_sendrecv_all_if(ricci_t)
 corenet_tcp_sendrecv_all_nodes(ricci_t)
Index: refpolicy_svn_repo/policy/modules/services/rlogin.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rlogin.te
+++ refpolicy_svn_repo/policy/modules/services/rlogin.te
@@ -51,6 +51,7 @@ kernel_read_system_state(rlogind_t)
 kernel_read_network_state(rlogind_t)
 
 corenet_all_recvfrom_unlabeled(rlogind_t)
+corenet_recvfrom_unlabeled_peer(rlogind_t)
 corenet_all_recvfrom_netlabel(rlogind_t)
 corenet_tcp_sendrecv_all_if(rlogind_t)
 corenet_udp_sendrecv_all_if(rlogind_t)
Index: refpolicy_svn_repo/policy/modules/services/roundup.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/roundup.te
+++ refpolicy_svn_repo/policy/modules/services/roundup.te
@@ -44,6 +44,7 @@ dev_read_sysfs(roundup_t)
 corecmd_exec_bin(roundup_t)
 
 corenet_all_recvfrom_unlabeled(roundup_t)
+corenet_recvfrom_unlabeled_peer(roundup_t)
 corenet_all_recvfrom_netlabel(roundup_t)
 corenet_tcp_sendrecv_generic_if(roundup_t)
 corenet_udp_sendrecv_generic_if(roundup_t)
Index: refpolicy_svn_repo/policy/modules/services/rpc.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rpc.if
+++ refpolicy_svn_repo/policy/modules/services/rpc.if
@@ -70,6 +70,7 @@ template(`rpc_domain_template', `
 	dev_read_rand($1_t)
 
 	corenet_all_recvfrom_unlabeled($1_t)
+	corenet_recvfrom_unlabeled_peer($1_t)
 	corenet_all_recvfrom_netlabel($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
Index: refpolicy_svn_repo/policy/modules/services/rpcbind.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rpcbind.te
+++ refpolicy_svn_repo/policy/modules/services/rpcbind.te
@@ -40,6 +40,7 @@ files_var_lib_filetrans(rpcbind_t,rpcbin
 kernel_read_network_state(rpcbind_t)
 
 corenet_all_recvfrom_unlabeled(rpcbind_t)
+corenet_recvfrom_unlabeled_peer(rpcbind_t)
 corenet_all_recvfrom_netlabel(rpcbind_t)
 corenet_tcp_sendrecv_all_if(rpcbind_t)
 corenet_udp_sendrecv_all_if(rpcbind_t)
Index: refpolicy_svn_repo/policy/modules/services/rshd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rshd.te
+++ refpolicy_svn_repo/policy/modules/services/rshd.te
@@ -24,6 +24,7 @@ allow rshd_t self:tcp_socket create_stre
 kernel_read_kernel_sysctls(rshd_t)
 
 corenet_all_recvfrom_unlabeled(rshd_t)
+corenet_recvfrom_unlabeled_peer(rshd_t)
 corenet_all_recvfrom_netlabel(rshd_t)
 corenet_tcp_sendrecv_generic_if(rshd_t)
 corenet_udp_sendrecv_generic_if(rshd_t)
Index: refpolicy_svn_repo/policy/modules/services/rsync.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rsync.te
+++ refpolicy_svn_repo/policy/modules/services/rsync.te
@@ -71,6 +71,7 @@ kernel_read_system_state(rsync_t)
 kernel_read_network_state(rsync_t)
 
 corenet_all_recvfrom_unlabeled(rsync_t)
+corenet_recvfrom_unlabeled_peer(rsync_t)
 corenet_all_recvfrom_netlabel(rsync_t)
 corenet_tcp_sendrecv_all_if(rsync_t)
 corenet_udp_sendrecv_all_if(rsync_t)
Index: refpolicy_svn_repo/policy/modules/services/rwho.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rwho.te
+++ refpolicy_svn_repo/policy/modules/services/rwho.te
@@ -38,6 +38,7 @@ files_spool_filetrans(rwho_t,rwho_spool_
 kernel_read_system_state(rwho_t)
 
 corenet_all_recvfrom_unlabeled(rwho_t)
+corenet_recvfrom_unlabeled_peer(rwho_t)
 corenet_all_recvfrom_netlabel(rwho_t)
 corenet_udp_sendrecv_all_if(rwho_t)
 corenet_udp_sendrecv_all_nodes(rwho_t)
Index: refpolicy_svn_repo/policy/modules/services/samba.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/samba.te
+++ refpolicy_svn_repo/policy/modules/services/samba.te
@@ -165,6 +165,7 @@ manage_lnk_files_pattern(samba_net_t,sam
 kernel_read_proc_symlinks(samba_net_t)
 
 corenet_all_recvfrom_unlabeled(samba_net_t)
+corenet_recvfrom_unlabeled_peer(samba_net_t)
 corenet_all_recvfrom_netlabel(samba_net_t)
 corenet_tcp_sendrecv_all_if(samba_net_t)
 corenet_udp_sendrecv_all_if(samba_net_t)
@@ -265,6 +266,7 @@ corecmd_exec_shell(smbd_t)
 corecmd_exec_bin(smbd_t)
 
 corenet_all_recvfrom_unlabeled(smbd_t)
+corenet_recvfrom_unlabeled_peer(smbd_t)
 corenet_all_recvfrom_netlabel(smbd_t)
 corenet_tcp_sendrecv_all_if(smbd_t)
 corenet_udp_sendrecv_all_if(smbd_t)
@@ -422,6 +424,7 @@ kernel_read_software_raid_state(nmbd_t)
 kernel_read_system_state(nmbd_t)
 
 corenet_all_recvfrom_unlabeled(nmbd_t)
+corenet_recvfrom_unlabeled_peer(nmbd_t)
 corenet_all_recvfrom_netlabel(nmbd_t)
 corenet_tcp_sendrecv_all_if(nmbd_t)
 corenet_udp_sendrecv_all_if(nmbd_t)
@@ -498,6 +501,7 @@ files_list_var_lib(smbmount_t)
 kernel_read_system_state(smbmount_t)
 
 corenet_all_recvfrom_unlabeled(smbmount_t)
+corenet_recvfrom_unlabeled_peer(smbmount_t)
 corenet_all_recvfrom_netlabel(smbmount_t)
 corenet_tcp_sendrecv_all_if(smbmount_t)
 corenet_raw_sendrecv_all_if(smbmount_t)
@@ -586,6 +590,7 @@ kernel_read_network_state(swat_t)
 corecmd_search_bin(swat_t)
 
 corenet_all_recvfrom_unlabeled(swat_t)
+corenet_recvfrom_unlabeled_peer(swat_t)
 corenet_all_recvfrom_netlabel(swat_t)
 corenet_tcp_sendrecv_generic_if(swat_t)
 corenet_udp_sendrecv_generic_if(swat_t)
@@ -684,6 +689,7 @@ kernel_list_proc(winbind_t)
 kernel_read_proc_symlinks(winbind_t)
 
 corenet_all_recvfrom_unlabeled(winbind_t)
+corenet_recvfrom_unlabeled_peer(winbind_t)
 corenet_all_recvfrom_netlabel(winbind_t)
 corenet_tcp_sendrecv_all_if(winbind_t)
 corenet_udp_sendrecv_all_if(winbind_t)
Index: refpolicy_svn_repo/policy/modules/services/sasl.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/sasl.te
+++ refpolicy_svn_repo/policy/modules/services/sasl.te
@@ -48,6 +48,7 @@ kernel_read_kernel_sysctls(saslauthd_t)
 kernel_read_system_state(saslauthd_t)
 
 corenet_all_recvfrom_unlabeled(saslauthd_t)
+corenet_recvfrom_unlabeled_peer(saslauthd_t)
 corenet_all_recvfrom_netlabel(saslauthd_t)
 corenet_tcp_sendrecv_all_if(saslauthd_t)
 corenet_tcp_sendrecv_all_nodes(saslauthd_t)
Index: refpolicy_svn_repo/policy/modules/services/sendmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/sendmail.te
+++ refpolicy_svn_repo/policy/modules/services/sendmail.te
@@ -49,6 +49,7 @@ kernel_read_kernel_sysctls(sendmail_t)
 kernel_read_system_state(sendmail_t)
 
 corenet_all_recvfrom_unlabeled(sendmail_t)
+corenet_recvfrom_unlabeled_peer(sendmail_t)
 corenet_all_recvfrom_netlabel(sendmail_t)
 corenet_tcp_sendrecv_all_if(sendmail_t)
 corenet_tcp_sendrecv_all_nodes(sendmail_t)
Index: refpolicy_svn_repo/policy/modules/services/setroubleshoot.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/setroubleshoot.te
+++ refpolicy_svn_repo/policy/modules/services/setroubleshoot.te
@@ -58,6 +58,7 @@ corecmd_exec_bin(setroubleshootd_t)
 corecmd_exec_shell(setroubleshootd_t)
 
 corenet_all_recvfrom_unlabeled(setroubleshootd_t)
+corenet_recvfrom_unlabeled_peer(setroubleshootd_t)
 corenet_all_recvfrom_netlabel(setroubleshootd_t)
 corenet_tcp_sendrecv_generic_if(setroubleshootd_t)
 corenet_tcp_sendrecv_all_nodes(setroubleshootd_t)
Index: refpolicy_svn_repo/policy/modules/services/smartmon.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/smartmon.te
+++ refpolicy_svn_repo/policy/modules/services/smartmon.te
@@ -43,6 +43,7 @@ kernel_read_system_state(fsdaemon_t)
 corecmd_exec_all_executables(fsdaemon_t)
 
 corenet_all_recvfrom_unlabeled(fsdaemon_t)
+corenet_recvfrom_unlabeled_peer(fsdaemon_t)
 corenet_all_recvfrom_netlabel(fsdaemon_t)
 corenet_udp_sendrecv_generic_if(fsdaemon_t)
 corenet_udp_sendrecv_all_nodes(fsdaemon_t)
Index: refpolicy_svn_repo/policy/modules/services/snmp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/snmp.te
+++ refpolicy_svn_repo/policy/modules/services/snmp.te
@@ -54,6 +54,7 @@ corecmd_exec_bin(snmpd_t)
 corecmd_exec_shell(snmpd_t)
 
 corenet_all_recvfrom_unlabeled(snmpd_t)
+corenet_recvfrom_unlabeled_peer(snmpd_t)
 corenet_all_recvfrom_netlabel(snmpd_t)
 corenet_tcp_sendrecv_all_if(snmpd_t)
 corenet_udp_sendrecv_all_if(snmpd_t)
Index: refpolicy_svn_repo/policy/modules/services/snort.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/snort.te
+++ refpolicy_svn_repo/policy/modules/services/snort.te
@@ -56,6 +56,7 @@ kernel_read_proc_symlinks(snort_t)
 kernel_dontaudit_read_system_state(snort_t)
 
 corenet_all_recvfrom_unlabeled(snort_t)
+corenet_recvfrom_unlabeled_peer(snort_t)
 corenet_all_recvfrom_netlabel(snort_t)
 corenet_tcp_sendrecv_generic_if(snort_t)
 corenet_udp_sendrecv_generic_if(snort_t)
Index: refpolicy_svn_repo/policy/modules/services/soundserver.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/soundserver.te
+++ refpolicy_svn_repo/policy/modules/services/soundserver.te
@@ -63,6 +63,7 @@ kernel_list_proc(soundd_t)
 kernel_read_proc_symlinks(soundd_t)
 
 corenet_all_recvfrom_unlabeled(soundd_t)
+corenet_recvfrom_unlabeled_peer(soundd_t)
 corenet_all_recvfrom_netlabel(soundd_t)
 corenet_tcp_sendrecv_generic_if(soundd_t)
 corenet_udp_sendrecv_generic_if(soundd_t)
Index: refpolicy_svn_repo/policy/modules/services/spamassassin.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/spamassassin.if
+++ refpolicy_svn_repo/policy/modules/services/spamassassin.if
@@ -96,6 +96,7 @@ template(`spamassassin_per_role_template
 	kernel_read_kernel_sysctls($1_spamc_t)
 
 	corenet_all_recvfrom_unlabeled($1_spamc_t)
+	corenet_recvfrom_unlabeled_peer($1_spamc_t)
 	corenet_all_recvfrom_netlabel($1_spamc_t)
 	corenet_tcp_sendrecv_generic_if($1_spamc_t)
 	corenet_udp_sendrecv_generic_if($1_spamc_t)
@@ -267,6 +268,7 @@ template(`spamassassin_per_role_template
 		allow $1_spamassassin_t self:udp_socket create_socket_perms;
 
 		corenet_all_recvfrom_unlabeled($1_spamassassin_t)
+		corenet_recvfrom_unlabeled_peer($1_spamassassin_t)
 		corenet_all_recvfrom_netlabel($1_spamassassin_t)
 		corenet_tcp_sendrecv_generic_if($1_spamassassin_t)
 		corenet_udp_sendrecv_generic_if($1_spamassassin_t)
Index: refpolicy_svn_repo/policy/modules/services/spamassassin.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/spamassassin.te
+++ refpolicy_svn_repo/policy/modules/services/spamassassin.te
@@ -91,6 +91,7 @@ kernel_read_all_sysctls(spamd_t)
 kernel_read_system_state(spamd_t)
 
 corenet_all_recvfrom_unlabeled(spamd_t)
+corenet_recvfrom_unlabeled_peer(spamd_t)
 corenet_all_recvfrom_netlabel(spamd_t)
 corenet_tcp_sendrecv_all_if(spamd_t)
 corenet_udp_sendrecv_all_if(spamd_t)
Index: refpolicy_svn_repo/policy/modules/services/squid.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/squid.te
+++ refpolicy_svn_repo/policy/modules/services/squid.te
@@ -76,6 +76,7 @@ kernel_read_system_state(squid_t)
 files_dontaudit_getattr_boot_dirs(squid_t)
 
 corenet_all_recvfrom_unlabeled(squid_t)
+corenet_recvfrom_unlabeled_peer(squid_t)
 corenet_all_recvfrom_netlabel(squid_t)
 corenet_tcp_sendrecv_all_if(squid_t)
 corenet_udp_sendrecv_all_if(squid_t)
Index: refpolicy_svn_repo/policy/modules/services/ssh.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ssh.if
+++ refpolicy_svn_repo/policy/modules/services/ssh.if
@@ -109,6 +109,7 @@ template(`ssh_basic_client_template',`
 	kernel_read_kernel_sysctls($1_ssh_t)
 
 	corenet_all_recvfrom_unlabeled($1_ssh_t)
+	corenet_recvfrom_unlabeled_peer($1_ssh_t)
 	corenet_all_recvfrom_netlabel($1_ssh_t)
 	corenet_tcp_sendrecv_all_if($1_ssh_t)
 	corenet_tcp_sendrecv_all_nodes($1_ssh_t)
@@ -465,6 +466,7 @@ template(`ssh_server_template', `
 	kernel_read_kernel_sysctls($1_t)
 
 	corenet_all_recvfrom_unlabeled($1_t)
+	corenet_recvfrom_unlabeled_peer($1_t)
 	corenet_all_recvfrom_netlabel($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
Index: refpolicy_svn_repo/policy/modules/services/stunnel.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/stunnel.te
+++ refpolicy_svn_repo/policy/modules/services/stunnel.te
@@ -55,6 +55,7 @@ kernel_read_system_state(stunnel_t)
 kernel_read_network_state(stunnel_t)
 
 corenet_all_recvfrom_unlabeled(stunnel_t)
+corenet_recvfrom_unlabeled_peer(stunnel_t)
 corenet_all_recvfrom_netlabel(stunnel_t)
 corenet_tcp_sendrecv_all_if(stunnel_t)
 corenet_udp_sendrecv_all_if(stunnel_t)
Index: refpolicy_svn_repo/policy/modules/services/tcpd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/tcpd.te
+++ refpolicy_svn_repo/policy/modules/services/tcpd.te
@@ -24,6 +24,7 @@ manage_files_pattern(tcpd_t, tcpd_tmp_t,
 files_tmp_filetrans(tcpd_t, tcpd_tmp_t, { file dir })
 
 corenet_all_recvfrom_unlabeled(tcpd_t)
+corenet_recvfrom_unlabeled_peer(tcpd_t)
 corenet_all_recvfrom_netlabel(tcpd_t)
 corenet_tcp_sendrecv_all_if(tcpd_t)
 corenet_tcp_sendrecv_all_nodes(tcpd_t)
Index: refpolicy_svn_repo/policy/modules/services/telnet.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/telnet.te
+++ refpolicy_svn_repo/policy/modules/services/telnet.te
@@ -49,6 +49,7 @@ kernel_read_system_state(telnetd_t)
 kernel_read_network_state(telnetd_t)
 
 corenet_all_recvfrom_unlabeled(telnetd_t)
+corenet_recvfrom_unlabeled_peer(telnetd_t)
 corenet_all_recvfrom_netlabel(telnetd_t)
 corenet_tcp_sendrecv_all_if(telnetd_t)
 corenet_udp_sendrecv_all_if(telnetd_t)
Index: refpolicy_svn_repo/policy/modules/services/tftp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/tftp.te
+++ refpolicy_svn_repo/policy/modules/services/tftp.te
@@ -56,6 +56,7 @@ kernel_list_proc(tftpd_t)
 kernel_read_proc_symlinks(tftpd_t)
 
 corenet_all_recvfrom_unlabeled(tftpd_t)
+corenet_recvfrom_unlabeled_peer(tftpd_t)
 corenet_all_recvfrom_netlabel(tftpd_t)
 corenet_tcp_sendrecv_all_if(tftpd_t)
 corenet_udp_sendrecv_all_if(tftpd_t)
Index: refpolicy_svn_repo/policy/modules/services/timidity.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/timidity.te
+++ refpolicy_svn_repo/policy/modules/services/timidity.te
@@ -41,6 +41,7 @@ kernel_read_kernel_sysctls(timidity_t)
 kernel_read_system_state(timidity_t)
 
 corenet_all_recvfrom_unlabeled(timidity_t)
+corenet_recvfrom_unlabeled_peer(timidity_t)
 corenet_all_recvfrom_netlabel(timidity_t)
 corenet_tcp_sendrecv_generic_if(timidity_t)
 corenet_udp_sendrecv_generic_if(timidity_t)
Index: refpolicy_svn_repo/policy/modules/services/tor.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/tor.te
+++ refpolicy_svn_repo/policy/modules/services/tor.te
@@ -64,6 +64,7 @@ kernel_read_system_state(tor_t)
 
 # networking basics
 corenet_all_recvfrom_unlabeled(tor_t)
+corenet_recvfrom_unlabeled_peer(tor_t)
 corenet_all_recvfrom_netlabel(tor_t)
 corenet_tcp_sendrecv_all_if(tor_t)
 corenet_tcp_sendrecv_all_nodes(tor_t)
Index: refpolicy_svn_repo/policy/modules/services/transproxy.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/transproxy.te
+++ refpolicy_svn_repo/policy/modules/services/transproxy.te
@@ -31,6 +31,7 @@ kernel_list_proc(transproxy_t)
 kernel_read_proc_symlinks(transproxy_t)
 
 corenet_all_recvfrom_unlabeled(transproxy_t)
+corenet_recvfrom_unlabeled_peer(transproxy_t)
 corenet_all_recvfrom_netlabel(transproxy_t)
 corenet_tcp_sendrecv_generic_if(transproxy_t)
 corenet_tcp_sendrecv_all_nodes(transproxy_t)
Index: refpolicy_svn_repo/policy/modules/services/ucspitcp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ucspitcp.te
+++ refpolicy_svn_repo/policy/modules/services/ucspitcp.te
@@ -26,6 +26,7 @@ ucspitcp_service_domain(rblsmtpd_t, rbls
 corecmd_search_bin(rblsmtpd_t)
 
 corenet_all_recvfrom_unlabeled(rblsmtpd_t)
+corenet_recvfrom_unlabeled_peer(rblsmtpd_t)
 corenet_all_recvfrom_netlabel(rblsmtpd_t)
 corenet_tcp_sendrecv_all_if(rblsmtpd_t)
 corenet_udp_sendrecv_all_if(rblsmtpd_t)
@@ -60,6 +61,7 @@ corecmd_search_bin(ucspitcp_t)
 
 # base networking:
 corenet_all_recvfrom_unlabeled(ucspitcp_t)
+corenet_recvfrom_unlabeled_peer(ucspitcp_t)
 corenet_all_recvfrom_netlabel(ucspitcp_t)
 corenet_tcp_sendrecv_all_if(ucspitcp_t)
 corenet_udp_sendrecv_all_if(ucspitcp_t)
Index: refpolicy_svn_repo/policy/modules/services/uucp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/uucp.te
+++ refpolicy_svn_repo/policy/modules/services/uucp.te
@@ -70,6 +70,7 @@ kernel_read_system_state(uucpd_t)
 kernel_read_network_state(uucpd_t)
 
 corenet_all_recvfrom_unlabeled(uucpd_t)
+corenet_recvfrom_unlabeled_peer(uucpd_t)
 corenet_all_recvfrom_netlabel(uucpd_t)
 corenet_tcp_sendrecv_all_if(uucpd_t)
 corenet_udp_sendrecv_all_if(uucpd_t)
Index: refpolicy_svn_repo/policy/modules/services/uwimap.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/uwimap.te
+++ refpolicy_svn_repo/policy/modules/services/uwimap.te
@@ -40,6 +40,7 @@ kernel_list_proc(imapd_t)
 kernel_read_proc_symlinks(imapd_t)
 
 corenet_all_recvfrom_unlabeled(imapd_t)
+corenet_recvfrom_unlabeled_peer(imapd_t)
 corenet_all_recvfrom_netlabel(imapd_t)
 corenet_tcp_sendrecv_generic_if(imapd_t)
 corenet_tcp_sendrecv_all_nodes(imapd_t)
Index: refpolicy_svn_repo/policy/modules/services/watchdog.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/watchdog.te
+++ refpolicy_svn_repo/policy/modules/services/watchdog.te
@@ -44,6 +44,7 @@ corecmd_exec_shell(watchdog_t)
 
 # cjp: why networking?
 corenet_all_recvfrom_unlabeled(watchdog_t)
+corenet_recvfrom_unlabeled_peer(watchdog_t)
 corenet_all_recvfrom_netlabel(watchdog_t)
 corenet_tcp_sendrecv_generic_if(watchdog_t)
 corenet_udp_sendrecv_generic_if(watchdog_t)
Index: refpolicy_svn_repo/policy/modules/services/xfs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xfs.te
+++ refpolicy_svn_repo/policy/modules/services/xfs.te
@@ -39,6 +39,7 @@ kernel_read_kernel_sysctls(xfs_t)
 kernel_read_system_state(xfs_t)
 
 corenet_all_recvfrom_unlabeled(xfs_t)
+corenet_recvfrom_unlabeled_peer(xfs_t)
 corenet_all_recvfrom_netlabel(xfs_t)
 corenet_tcp_sendrecv_generic_if(xfs_t)
 corenet_tcp_sendrecv_all_nodes(xfs_t)
Index: refpolicy_svn_repo/policy/modules/services/xprint.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xprint.te
+++ refpolicy_svn_repo/policy/modules/services/xprint.te
@@ -34,6 +34,7 @@ corecmd_exec_bin(xprint_t)
 corecmd_exec_shell(xprint_t)
 
 corenet_all_recvfrom_unlabeled(xprint_t)
+corenet_recvfrom_unlabeled_peer(xprint_t)
 corenet_all_recvfrom_netlabel(xprint_t)
 corenet_tcp_sendrecv_generic_if(xprint_t)
 corenet_udp_sendrecv_generic_if(xprint_t)
Index: refpolicy_svn_repo/policy/modules/services/xserver.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xserver.if
+++ refpolicy_svn_repo/policy/modules/services/xserver.if
@@ -95,6 +95,7 @@ template(`xserver_common_domain_template
 	corecmd_exec_shell($1_xserver_t)
 
 	corenet_all_recvfrom_unlabeled($1_xserver_t)
+	corenet_recvfrom_unlabeled_peer($1_xserver_t)
 	corenet_all_recvfrom_netlabel($1_xserver_t)
 	corenet_tcp_sendrecv_generic_if($1_xserver_t)
 	corenet_udp_sendrecv_generic_if($1_xserver_t)
Index: refpolicy_svn_repo/policy/modules/services/xserver.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xserver.te
+++ refpolicy_svn_repo/policy/modules/services/xserver.te
@@ -175,6 +175,7 @@ corecmd_exec_shell(xdm_t)
 corecmd_exec_bin(xdm_t)
 
 corenet_all_recvfrom_unlabeled(xdm_t)
+corenet_recvfrom_unlabeled_peer(xdm_t)
 corenet_all_recvfrom_netlabel(xdm_t)
 corenet_tcp_sendrecv_generic_if(xdm_t)
 corenet_udp_sendrecv_generic_if(xdm_t)
Index: refpolicy_svn_repo/policy/modules/services/zebra.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/zebra.te
+++ refpolicy_svn_repo/policy/modules/services/zebra.te
@@ -68,6 +68,7 @@ kernel_read_kernel_sysctls(zebra_t)
 kernel_rw_net_sysctls(zebra_t)
 
 corenet_all_recvfrom_unlabeled(zebra_t)
+corenet_recvfrom_unlabeled_peer(zebra_t)
 corenet_all_recvfrom_netlabel(zebra_t)
 corenet_tcp_sendrecv_all_if(zebra_t)
 corenet_udp_sendrecv_all_if(zebra_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
