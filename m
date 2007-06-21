Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5MC1K79029951
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 08:01:20 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5MC1CIG021370
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 12:01:12 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l5MBvuFH020458
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 07:57:56 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l5MBvuIx020457
	for selinux@tycho.nsa.gov; Fri, 22 Jun 2007 07:57:56 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LNLFx8002516
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 19:21:15 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5LNLDnL019179
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 23:21:13 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070621232052.409003014@hp.com>
References: <20070621231507.402982591@hp.com>
Date: Thu, 21 Jun 2007 19:15:10 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCHv2 3/5] Add NetLabel labeled and unlabeled support to the service domains
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds calls to the NetLabel corenet policy interfaces to grant the
relevant service domains access to NetLabel labeled and unlabeled packets.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/services/afs.te            |   15 ++++++++++-----
 policy/modules/services/amavis.te         |    3 ++-
 policy/modules/services/apache.if         |    6 ++++--
 policy/modules/services/apache.te         |    6 ++++--
 policy/modules/services/apcupsd.te        |    3 ++-
 policy/modules/services/arpwatch.te       |    3 ++-
 policy/modules/services/asterisk.te       |    3 ++-
 policy/modules/services/automount.te      |    3 ++-
 policy/modules/services/avahi.te          |    3 ++-
 policy/modules/services/bind.te           |    4 ++--
 policy/modules/services/bluetooth.te      |    3 ++-
 policy/modules/services/canna.te          |    3 ++-
 policy/modules/services/ccs.te            |    3 ++-
 policy/modules/services/cipe.te           |    3 ++-
 policy/modules/services/clamav.te         |    6 ++++--
 policy/modules/services/clockspeed.te     |    6 ++++--
 policy/modules/services/comsat.te         |    3 ++-
 policy/modules/services/courier.if        |    3 ++-
 policy/modules/services/cron.if           |    3 ++-
 policy/modules/services/cron.te           |    3 ++-
 policy/modules/services/cups.te           |   16 +++++++++++-----
 policy/modules/services/cvs.te            |    3 ++-
 policy/modules/services/cyrus.te          |    3 ++-
 policy/modules/services/dante.te          |    3 ++-
 policy/modules/services/dbskk.te          |    3 ++-
 policy/modules/services/dbus.if           |    4 ++--
 policy/modules/services/dcc.te            |   18 ++++++++++++------
 policy/modules/services/ddclient.te       |    3 ++-
 policy/modules/services/dhcp.te           |    3 ++-
 policy/modules/services/dictd.te          |    3 ++-
 policy/modules/services/distcc.te         |    3 ++-
 policy/modules/services/djbdns.if         |    3 ++-
 policy/modules/services/dnsmasq.te        |    3 ++-
 policy/modules/services/dovecot.te        |    3 ++-
 policy/modules/services/fetchmail.te      |    3 ++-
 policy/modules/services/finger.te         |    3 ++-
 policy/modules/services/ftp.te            |    3 ++-
 policy/modules/services/gatekeeper.te     |    3 ++-
 policy/modules/services/hal.te            |    3 ++-
 policy/modules/services/howl.te           |    3 ++-
 policy/modules/services/i18n_input.te     |    3 ++-
 policy/modules/services/imaze.te          |    3 ++-
 policy/modules/services/inetd.te          |   12 ++++--------
 policy/modules/services/inn.te            |    3 ++-
 policy/modules/services/ircd.te           |    3 ++-
 policy/modules/services/jabber.te         |    3 ++-
 policy/modules/services/kerberos.if       |    3 ++-
 policy/modules/services/kerberos.te       |    6 ++++--
 policy/modules/services/ktalk.te          |    3 ++-
 policy/modules/services/ldap.te           |    3 ++-
 policy/modules/services/lpd.if            |    3 ++-
 policy/modules/services/lpd.te            |    6 ++++--
 policy/modules/services/mailman.if        |    3 ++-
 policy/modules/services/monop.te          |    3 ++-
 policy/modules/services/mta.if            |    3 ++-
 policy/modules/services/munin.te          |    3 ++-
 policy/modules/services/mysql.te          |    3 ++-
 policy/modules/services/nagios.te         |    3 ++-
 policy/modules/services/nessus.te         |    3 ++-
 policy/modules/services/networkmanager.te |    3 ++-
 policy/modules/services/nis.if            |    3 ++-
 policy/modules/services/nis.te            |   15 ++++++++-------
 policy/modules/services/nscd.te           |    3 ++-
 policy/modules/services/nsd.te            |    6 ++++--
 policy/modules/services/ntop.te           |    3 ++-
 policy/modules/services/nx.te             |    3 ++-
 policy/modules/services/oav.te            |    6 ++++--
 policy/modules/services/openvpn.te        |    3 ++-
 policy/modules/services/pcscd.te          |    3 ++-
 policy/modules/services/pegasus.te        |    3 ++-
 policy/modules/services/perdition.te      |    3 ++-
 policy/modules/services/portmap.te        |    6 ++++--
 policy/modules/services/portslave.te      |    3 ++-
 policy/modules/services/postfix.if        |    3 ++-
 policy/modules/services/postfix.te        |    6 ++++--
 policy/modules/services/postgresql.te     |    3 ++-
 policy/modules/services/postgrey.te       |    3 ++-
 policy/modules/services/ppp.te            |    6 ++++--
 policy/modules/services/privoxy.te        |    3 ++-
 policy/modules/services/procmail.te       |    3 ++-
 policy/modules/services/pyzor.te          |    3 ++-
 policy/modules/services/qmail.te          |    3 ++-
 policy/modules/services/radius.te         |    3 ++-
 policy/modules/services/radvd.te          |    3 ++-
 policy/modules/services/razor.if          |    3 ++-
 policy/modules/services/razor.te          |    3 ++-
 policy/modules/services/rdisc.te          |    3 ++-
 policy/modules/services/rhgb.te           |    3 ++-
 policy/modules/services/ricci.te          |    4 ++--
 policy/modules/services/rlogin.te         |    3 ++-
 policy/modules/services/roundup.te        |    3 ++-
 policy/modules/services/rpc.if            |    4 ++--
 policy/modules/services/rshd.te           |    3 ++-
 policy/modules/services/rsync.te          |    3 ++-
 policy/modules/services/rwho.te           |    3 ++-
 policy/modules/services/samba.te          |   18 ++++++++++++------
 policy/modules/services/sasl.te           |    3 ++-
 policy/modules/services/sendmail.te       |    3 ++-
 policy/modules/services/setroubleshoot.te |    3 ++-
 policy/modules/services/smartmon.te       |    3 ++-
 policy/modules/services/snmp.te           |    3 ++-
 policy/modules/services/snort.te          |    3 ++-
 policy/modules/services/soundserver.te    |    3 ++-
 policy/modules/services/spamassassin.if   |    6 ++++--
 policy/modules/services/spamassassin.te   |    3 ++-
 policy/modules/services/squid.te          |    3 ++-
 policy/modules/services/ssh.if            |    6 ++++--
 policy/modules/services/stunnel.te        |    3 ++-
 policy/modules/services/tcpd.te           |    3 ++-
 policy/modules/services/telnet.te         |    3 ++-
 policy/modules/services/tftp.te           |    3 ++-
 policy/modules/services/timidity.te       |    3 ++-
 policy/modules/services/tor.te            |    3 ++-
 policy/modules/services/transproxy.te     |    3 ++-
 policy/modules/services/ucspitcp.te       |    6 ++++--
 policy/modules/services/uucp.te           |    3 ++-
 policy/modules/services/uwimap.te         |    3 ++-
 policy/modules/services/watchdog.te       |    3 ++-
 policy/modules/services/xprint.te         |    3 ++-
 policy/modules/services/xserver.if        |    3 ++-
 policy/modules/services/xserver.te        |    3 ++-
 policy/modules/services/zebra.te          |    3 ++-
 122 files changed, 317 insertions(+), 171 deletions(-)

Index: refpolicy_svn_repo/policy/modules/services/afs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/afs.te
+++ refpolicy_svn_repo/policy/modules/services/afs.te
@@ -89,7 +89,8 @@ domtrans_pattern(afs_bosserver_t, afs_vl
 
 kernel_read_kernel_sysctls(afs_bosserver_t)
 
-corenet_non_ipsec_sendrecv(afs_bosserver_t)
+corenet_all_recvfrom_unlabeled(afs_bosserver_t)
+corenet_all_recvfrom_netlabel(afs_bosserver_t)
 corenet_tcp_sendrecv_generic_if(afs_bosserver_t)
 corenet_udp_sendrecv_generic_if(afs_bosserver_t)
 corenet_tcp_sendrecv_all_nodes(afs_bosserver_t)
@@ -153,7 +154,8 @@ corenet_tcp_sendrecv_all_nodes(afs_fsser
 corenet_udp_sendrecv_all_nodes(afs_fsserver_t)
 corenet_tcp_sendrecv_all_ports(afs_fsserver_t)
 corenet_udp_sendrecv_all_ports(afs_fsserver_t)
-corenet_non_ipsec_sendrecv(afs_fsserver_t)
+corenet_all_recvfrom_unlabeled(afs_fsserver_t)
+corenet_all_recvfrom_netlabel(afs_fsserver_t)
 corenet_tcp_bind_all_nodes(afs_fsserver_t)
 corenet_udp_bind_all_nodes(afs_fsserver_t)
 corenet_tcp_bind_afs_fs_port(afs_fsserver_t)
@@ -206,7 +208,8 @@ manage_files_pattern(afs_kaserver_t,afs_
 
 kernel_read_kernel_sysctls(afs_kaserver_t)
 
-corenet_non_ipsec_sendrecv(afs_kaserver_t)
+corenet_all_recvfrom_unlabeled(afs_kaserver_t)
+corenet_all_recvfrom_netlabel(afs_kaserver_t)
 corenet_tcp_sendrecv_generic_if(afs_kaserver_t)
 corenet_udp_sendrecv_generic_if(afs_kaserver_t)
 corenet_tcp_sendrecv_all_nodes(afs_kaserver_t)
@@ -253,7 +256,8 @@ manage_files_pattern(afs_ptserver_t,afs_
 manage_files_pattern(afs_ptserver_t,afs_dbdir_t,afs_pt_db_t)
 filetrans_pattern(afs_ptserver_t,afs_dbdir_t,afs_pt_db_t,file)
 
-corenet_non_ipsec_sendrecv(afs_ptserver_t)
+corenet_all_recvfrom_unlabeled(afs_ptserver_t)
+corenet_all_recvfrom_netlabel(afs_ptserver_t)
 corenet_tcp_sendrecv_generic_if(afs_ptserver_t)
 corenet_udp_sendrecv_generic_if(afs_ptserver_t)
 corenet_tcp_sendrecv_all_nodes(afs_ptserver_t)
@@ -294,7 +298,8 @@ manage_files_pattern(afs_vlserver_t,afs_
 manage_files_pattern(afs_vlserver_t,afs_dbdir_t,afs_vl_db_t)
 filetrans_pattern(afs_vlserver_t,afs_dbdir_t,afs_vl_db_t,file)
 
-corenet_non_ipsec_sendrecv(afs_vlserver_t)
+corenet_all_recvfrom_unlabeled(afs_vlserver_t)
+corenet_all_recvfrom_netlabel(afs_vlserver_t)
 corenet_tcp_sendrecv_generic_if(afs_vlserver_t)
 corenet_udp_sendrecv_generic_if(afs_vlserver_t)
 corenet_tcp_sendrecv_all_nodes(afs_vlserver_t)
Index: refpolicy_svn_repo/policy/modules/services/amavis.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/amavis.te
+++ refpolicy_svn_repo/policy/modules/services/amavis.te
@@ -100,7 +100,8 @@ kernel_dontaudit_read_system_state(amavi
 # find perl
 corecmd_exec_bin(amavis_t)
 
-corenet_non_ipsec_sendrecv(amavis_t)
+corenet_all_recvfrom_unlabeled(amavis_t)
+corenet_all_recvfrom_netlabel(amavis_t)
 corenet_tcp_sendrecv_all_if(amavis_t)
 corenet_tcp_sendrecv_all_nodes(amavis_t)
 corenet_tcp_bind_all_nodes(amavis_t)
Index: refpolicy_svn_repo/policy/modules/services/apache.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/apache.if
+++ refpolicy_svn_repo/policy/modules/services/apache.if
@@ -181,7 +181,8 @@ template(`apache_content_template',`
 		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
 
-		corenet_non_ipsec_sendrecv(httpd_$1_script_t)
+		corenet_all_recvfrom_unlabeled(httpd_$1_script_t)
+		corenet_all_recvfrom_netlabel(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
 		corenet_udp_sendrecv_all_if(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_nodes(httpd_$1_script_t)
@@ -200,7 +201,8 @@ template(`apache_content_template',`
 		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
 
-		corenet_non_ipsec_sendrecv(httpd_$1_script_t)
+		corenet_all_recvfrom_unlabeled(httpd_$1_script_t)
+		corenet_all_recvfrom_netlabel(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
 		corenet_udp_sendrecv_all_if(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_nodes(httpd_$1_script_t)
Index: refpolicy_svn_repo/policy/modules/services/apache.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/apache.te
+++ refpolicy_svn_repo/policy/modules/services/apache.te
@@ -298,7 +298,8 @@ kernel_read_kernel_sysctls(httpd_t)
 # for modules that want to access /proc/meminfo
 kernel_read_system_state(httpd_t)
 
-corenet_non_ipsec_sendrecv(httpd_t)
+corenet_all_recvfrom_unlabeled(httpd_t)
+corenet_all_recvfrom_netlabel(httpd_t)
 corenet_tcp_sendrecv_all_if(httpd_t)
 corenet_udp_sendrecv_all_if(httpd_t)
 corenet_tcp_sendrecv_all_nodes(httpd_t)
@@ -641,7 +642,8 @@ tunable_policy(`httpd_can_network_connec
 	allow httpd_suexec_t self:tcp_socket create_stream_socket_perms;
 	allow httpd_suexec_t self:udp_socket create_socket_perms;
 
-	corenet_non_ipsec_sendrecv(httpd_suexec_t)
+	corenet_all_recvfrom_unlabeled(httpd_suexec_t)
+	corenet_all_recvfrom_netlabel(httpd_suexec_t)
 	corenet_tcp_sendrecv_all_if(httpd_suexec_t)
 	corenet_udp_sendrecv_all_if(httpd_suexec_t)
 	corenet_tcp_sendrecv_all_nodes(httpd_suexec_t)
Index: refpolicy_svn_repo/policy/modules/services/apcupsd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/apcupsd.te
+++ refpolicy_svn_repo/policy/modules/services/apcupsd.te
@@ -39,7 +39,8 @@ logging_log_filetrans(apcupsd_t,apcupsd_
 manage_files_pattern(apcupsd_t,apcupsd_var_run_t,apcupsd_var_run_t)
 files_pid_filetrans(apcupsd_t,apcupsd_var_run_t, file)
 
-corenet_non_ipsec_sendrecv(apcupsd_t)
+corenet_all_recvfrom_unlabeled(apcupsd_t)
+corenet_all_recvfrom_netlabel(apcupsd_t)
 corenet_tcp_sendrecv_generic_if(apcupsd_t)
 corenet_tcp_sendrecv_all_nodes(apcupsd_t)
 corenet_tcp_sendrecv_all_ports(apcupsd_t)
Index: refpolicy_svn_repo/policy/modules/services/arpwatch.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/arpwatch.te
+++ refpolicy_svn_repo/policy/modules/services/arpwatch.te
@@ -47,7 +47,8 @@ kernel_read_kernel_sysctls(arpwatch_t)
 kernel_list_proc(arpwatch_t)
 kernel_read_proc_symlinks(arpwatch_t)
 
-corenet_non_ipsec_sendrecv(arpwatch_t)
+corenet_all_recvfrom_unlabeled(arpwatch_t)
+corenet_all_recvfrom_netlabel(arpwatch_t)
 corenet_tcp_sendrecv_all_if(arpwatch_t)
 corenet_udp_sendrecv_all_if(arpwatch_t)
 corenet_raw_sendrecv_all_if(arpwatch_t)
Index: refpolicy_svn_repo/policy/modules/services/asterisk.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/asterisk.te
+++ refpolicy_svn_repo/policy/modules/services/asterisk.te
@@ -82,7 +82,8 @@ kernel_read_kernel_sysctls(asterisk_t)
 corecmd_exec_bin(asterisk_t)
 corecmd_search_bin(asterisk_t)
 
-corenet_non_ipsec_sendrecv(asterisk_t)
+corenet_all_recvfrom_unlabeled(asterisk_t)
+corenet_all_recvfrom_netlabel(asterisk_t)
 corenet_tcp_sendrecv_generic_if(asterisk_t)
 corenet_udp_sendrecv_generic_if(asterisk_t)
 corenet_tcp_sendrecv_all_nodes(asterisk_t)
Index: refpolicy_svn_repo/policy/modules/services/automount.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/automount.te
+++ refpolicy_svn_repo/policy/modules/services/automount.te
@@ -76,7 +76,8 @@ fs_unmount_all_fs(automount_t)
 corecmd_exec_bin(automount_t)
 corecmd_exec_shell(automount_t)
 
-corenet_non_ipsec_sendrecv(automount_t)
+corenet_all_recvfrom_unlabeled(automount_t)
+corenet_all_recvfrom_netlabel(automount_t)
 corenet_tcp_sendrecv_generic_if(automount_t)
 corenet_udp_sendrecv_generic_if(automount_t)
 corenet_tcp_sendrecv_all_nodes(automount_t)
Index: refpolicy_svn_repo/policy/modules/services/avahi.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/avahi.te
+++ refpolicy_svn_repo/policy/modules/services/avahi.te
@@ -37,7 +37,8 @@ kernel_list_proc(avahi_t)
 kernel_read_proc_symlinks(avahi_t)
 kernel_read_network_state(avahi_t)
 
-corenet_non_ipsec_sendrecv(avahi_t)
+corenet_all_recvfrom_unlabeled(avahi_t)
+corenet_all_recvfrom_netlabel(avahi_t)
 corenet_tcp_sendrecv_all_if(avahi_t)
 corenet_udp_sendrecv_all_if(avahi_t)
 corenet_tcp_sendrecv_all_nodes(avahi_t)
Index: refpolicy_svn_repo/policy/modules/services/bind.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/bind.te
+++ refpolicy_svn_repo/policy/modules/services/bind.te
@@ -101,7 +101,8 @@ kernel_read_kernel_sysctls(named_t)
 kernel_read_system_state(named_t)
 kernel_read_network_state(named_t)
 
-corenet_non_ipsec_sendrecv(named_t)
+corenet_all_recvfrom_unlabeled(named_t)
+corenet_all_recvfrom_netlabel(named_t)
 corenet_tcp_sendrecv_all_if(named_t)
 corenet_udp_sendrecv_all_if(named_t)
 corenet_tcp_sendrecv_all_nodes(named_t)
@@ -231,7 +232,6 @@ allow ndc_t named_zone_t:dir search;
 
 kernel_read_kernel_sysctls(ndc_t)
 
-corenet_non_ipsec_sendrecv(ndc_t)
 corenet_tcp_sendrecv_all_if(ndc_t)
 corenet_tcp_sendrecv_all_nodes(ndc_t)
 corenet_tcp_sendrecv_all_ports(ndc_t)
Index: refpolicy_svn_repo/policy/modules/services/bluetooth.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/bluetooth.te
+++ refpolicy_svn_repo/policy/modules/services/bluetooth.te
@@ -81,7 +81,8 @@ files_pid_filetrans(bluetooth_t, bluetoo
 kernel_read_kernel_sysctls(bluetooth_t)
 kernel_read_system_state(bluetooth_t)
 
-corenet_non_ipsec_sendrecv(bluetooth_t)
+corenet_all_recvfrom_unlabeled(bluetooth_t)
+corenet_all_recvfrom_netlabel(bluetooth_t)
 corenet_tcp_sendrecv_all_if(bluetooth_t)
 corenet_udp_sendrecv_all_if(bluetooth_t)
 corenet_raw_sendrecv_all_if(bluetooth_t)
Index: refpolicy_svn_repo/policy/modules/services/canna.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/canna.te
+++ refpolicy_svn_repo/policy/modules/services/canna.te
@@ -47,7 +47,8 @@ files_pid_filetrans(canna_t, canna_var_r
 kernel_read_kernel_sysctls(canna_t)
 kernel_read_system_state(canna_t)
 
-corenet_non_ipsec_sendrecv(canna_t)
+corenet_all_recvfrom_unlabeled(canna_t)
+corenet_all_recvfrom_netlabel(canna_t)
 corenet_tcp_sendrecv_all_if(canna_t)
 corenet_tcp_sendrecv_all_nodes(canna_t)
 corenet_tcp_sendrecv_all_ports(canna_t)
Index: refpolicy_svn_repo/policy/modules/services/ccs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ccs.te
+++ refpolicy_svn_repo/policy/modules/services/ccs.te
@@ -77,7 +77,8 @@ kernel_read_kernel_sysctls(ccs_t)
 corecmd_list_bin(ccs_t)
 corecmd_exec_bin(ccs_t)
 
-corenet_non_ipsec_sendrecv(ccs_t)
+corenet_all_recvfrom_unlabeled(ccs_t)
+corenet_all_recvfrom_netlabel(ccs_t)
 corenet_tcp_sendrecv_all_if(ccs_t)
 corenet_udp_sendrecv_all_if(ccs_t)
 corenet_tcp_sendrecv_all_nodes(ccs_t)
Index: refpolicy_svn_repo/policy/modules/services/cipe.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cipe.te
+++ refpolicy_svn_repo/policy/modules/services/cipe.te
@@ -29,7 +29,8 @@ kernel_read_system_state(ciped_t)
 corecmd_exec_shell(ciped_t)
 corecmd_exec_bin(ciped_t)
 
-corenet_non_ipsec_sendrecv(ciped_t)
+corenet_all_recvfrom_unlabeled(ciped_t)
+corenet_all_recvfrom_netlabel(ciped_t)
 corenet_udp_sendrecv_generic_if(ciped_t)
 corenet_udp_sendrecv_all_nodes(ciped_t)
 corenet_udp_sendrecv_all_ports(ciped_t)
Index: refpolicy_svn_repo/policy/modules/services/clamav.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/clamav.te
+++ refpolicy_svn_repo/policy/modules/services/clamav.te
@@ -86,7 +86,8 @@ files_pid_filetrans(clamd_t,clamd_var_ru
 kernel_dontaudit_list_proc(clamd_t)
 kernel_read_sysctl(clamd_t)
 
-corenet_non_ipsec_sendrecv(clamd_t)
+corenet_all_recvfrom_unlabeled(clamd_t)
+corenet_all_recvfrom_netlabel(clamd_t)
 corenet_tcp_sendrecv_all_if(clamd_t)
 corenet_tcp_sendrecv_all_nodes(clamd_t)
 corenet_tcp_sendrecv_all_ports(clamd_t)
@@ -159,7 +160,8 @@ allow freshclam_t freshclam_var_log_t:di
 allow freshclam_t clamd_var_log_t:dir search_dir_perms;
 logging_log_filetrans(freshclam_t,freshclam_var_log_t,file)
 
-corenet_non_ipsec_sendrecv(freshclam_t)
+corenet_all_recvfrom_unlabeled(freshclam_t)
+corenet_all_recvfrom_netlabel(freshclam_t)
 corenet_tcp_sendrecv_all_if(freshclam_t)
 corenet_tcp_sendrecv_all_nodes(freshclam_t)
 corenet_tcp_sendrecv_all_ports(freshclam_t)
Index: refpolicy_svn_repo/policy/modules/services/clockspeed.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/clockspeed.te
+++ refpolicy_svn_repo/policy/modules/services/clockspeed.te
@@ -28,7 +28,8 @@ allow clockspeed_cli_t self:udp_socket c
 
 read_files_pattern(clockspeed_cli_t,clockspeed_var_lib_t,clockspeed_var_lib_t)
 
-corenet_non_ipsec_sendrecv(clockspeed_cli_t)
+corenet_all_recvfrom_unlabeled(clockspeed_cli_t)
+corenet_all_recvfrom_netlabel(clockspeed_cli_t)
 corenet_udp_sendrecv_generic_if(clockspeed_cli_t)
 corenet_udp_sendrecv_generic_node(clockspeed_cli_t)
 corenet_udp_sendrecv_ntp_port(clockspeed_cli_t)
@@ -55,7 +56,8 @@ allow clockspeed_srv_t self:unix_stream_
 manage_files_pattern(clockspeed_srv_t,clockspeed_var_lib_t,clockspeed_var_lib_t)
 manage_fifo_files_pattern(clockspeed_srv_t,clockspeed_var_lib_t,clockspeed_var_lib_t)
 
-corenet_non_ipsec_sendrecv(clockspeed_srv_t)
+corenet_all_recvfrom_unlabeled(clockspeed_srv_t)
+corenet_all_recvfrom_netlabel(clockspeed_srv_t)
 corenet_udp_sendrecv_generic_if(clockspeed_srv_t)
 corenet_udp_sendrecv_generic_node(clockspeed_srv_t)
 corenet_udp_sendrecv_ntp_port(clockspeed_srv_t)
Index: refpolicy_svn_repo/policy/modules/services/comsat.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/comsat.te
+++ refpolicy_svn_repo/policy/modules/services/comsat.te
@@ -40,7 +40,8 @@ kernel_read_kernel_sysctls(comsat_t)
 kernel_read_network_state(comsat_t)
 kernel_read_system_state(comsat_t)
 
-corenet_non_ipsec_sendrecv(comsat_t)
+corenet_all_recvfrom_unlabeled(comsat_t)
+corenet_all_recvfrom_netlabel(comsat_t)
 corenet_tcp_sendrecv_all_if(comsat_t)
 corenet_udp_sendrecv_all_if(comsat_t)
 corenet_tcp_sendrecv_all_nodes(comsat_t)
Index: refpolicy_svn_repo/policy/modules/services/courier.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/courier.if
+++ refpolicy_svn_repo/policy/modules/services/courier.if
@@ -48,7 +48,8 @@ template(`courier_domain_template',`
 
 	corecmd_exec_bin(courier_$1_t)
 
-	corenet_non_ipsec_sendrecv(courier_$1_t)
+	corenet_all_recvfrom_unlabeled(courier_$1_t)
+	corenet_all_recvfrom_netlabel(courier_$1_t)
 	corenet_tcp_sendrecv_generic_if(courier_$1_t)
 	corenet_udp_sendrecv_generic_if(courier_$1_t)
 	corenet_tcp_sendrecv_all_nodes(courier_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/cron.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cron.if
+++ refpolicy_svn_repo/policy/modules/services/cron.if
@@ -94,7 +94,8 @@ template(`cron_per_role_template',`
 	# ps does not need to access /boot when run from cron
 	files_dontaudit_search_boot($1_crond_t)
 
-	corenet_non_ipsec_sendrecv($1_crond_t)
+	corenet_all_recvfrom_unlabeled($1_crond_t)
+	corenet_all_recvfrom_netlabel($1_crond_t)
 	corenet_tcp_sendrecv_all_if($1_crond_t)
 	corenet_udp_sendrecv_all_if($1_crond_t)
 	corenet_tcp_sendrecv_all_nodes($1_crond_t)
Index: refpolicy_svn_repo/policy/modules/services/cron.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cron.te
+++ refpolicy_svn_repo/policy/modules/services/cron.te
@@ -327,7 +327,8 @@ ifdef(`targeted_policy',`
 
 	corecmd_exec_all_executables(system_crond_t)
 
-	corenet_non_ipsec_sendrecv(system_crond_t)
+	corenet_all_recvfrom_unlabeled(system_crond_t)
+	corenet_all_recvfrom_netlabel(system_crond_t)
 	corenet_tcp_sendrecv_all_if(system_crond_t)
 	corenet_udp_sendrecv_all_if(system_crond_t)
 	corenet_tcp_sendrecv_all_nodes(system_crond_t)
Index: refpolicy_svn_repo/policy/modules/services/cups.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cups.te
+++ refpolicy_svn_repo/policy/modules/services/cups.te
@@ -133,7 +133,9 @@ kernel_read_system_state(cupsd_t)
 kernel_read_network_state(cupsd_t)
 kernel_read_all_sysctls(cupsd_t)
 
-corenet_non_ipsec_sendrecv(cupsd_t)
+corenet_all_recvfrom_unlabeled(cupsd_t)
+corenet_all_recvfrom_netlabel(cupsd_t)
+corenet_all_recvfrom_unlabeled(cupsd_t)
 corenet_tcp_sendrecv_all_if(cupsd_t)
 corenet_udp_sendrecv_all_if(cupsd_t)
 corenet_raw_sendrecv_all_if(cupsd_t)
@@ -340,7 +342,8 @@ files_pid_filetrans(cupsd_config_t,cupsd
 kernel_read_system_state(cupsd_config_t)
 kernel_read_kernel_sysctls(cupsd_config_t)
 
-corenet_non_ipsec_sendrecv(cupsd_config_t)
+corenet_all_recvfrom_unlabeled(cupsd_config_t)
+corenet_all_recvfrom_netlabel(cupsd_config_t)
 corenet_tcp_sendrecv_all_if(cupsd_config_t)
 corenet_tcp_sendrecv_all_nodes(cupsd_config_t)
 corenet_tcp_sendrecv_all_ports(cupsd_config_t)
@@ -491,7 +494,8 @@ kernel_read_kernel_sysctls(cupsd_lpd_t)
 kernel_read_system_state(cupsd_lpd_t)
 kernel_read_network_state(cupsd_lpd_t)
 
-corenet_non_ipsec_sendrecv(cupsd_lpd_t)
+corenet_all_recvfrom_unlabeled(cupsd_lpd_t)
+corenet_all_recvfrom_netlabel(cupsd_lpd_t)
 corenet_tcp_sendrecv_all_if(cupsd_lpd_t)
 corenet_udp_sendrecv_all_if(cupsd_lpd_t)
 corenet_tcp_sendrecv_all_nodes(cupsd_lpd_t)
@@ -564,7 +568,8 @@ files_pid_filetrans(hplip_t,hplip_var_ru
 kernel_read_system_state(hplip_t)
 kernel_read_kernel_sysctls(hplip_t)
 
-corenet_non_ipsec_sendrecv(hplip_t)
+corenet_all_recvfrom_unlabeled(hplip_t)
+corenet_all_recvfrom_netlabel(hplip_t)
 corenet_tcp_sendrecv_all_if(hplip_t)
 corenet_udp_sendrecv_all_if(hplip_t)
 corenet_raw_sendrecv_all_if(hplip_t)
@@ -661,7 +666,8 @@ kernel_read_kernel_sysctls(ptal_t)
 kernel_list_proc(ptal_t)
 kernel_read_proc_symlinks(ptal_t)
 
-corenet_non_ipsec_sendrecv(ptal_t)
+corenet_all_recvfrom_unlabeled(ptal_t)
+corenet_all_recvfrom_netlabel(ptal_t)
 corenet_tcp_sendrecv_all_if(ptal_t)
 corenet_tcp_sendrecv_all_nodes(ptal_t)
 corenet_tcp_sendrecv_all_ports(ptal_t)
Index: refpolicy_svn_repo/policy/modules/services/cvs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cvs.te
+++ refpolicy_svn_repo/policy/modules/services/cvs.te
@@ -54,7 +54,8 @@ kernel_read_kernel_sysctls(cvs_t)
 kernel_read_system_state(cvs_t)
 kernel_read_network_state(cvs_t)
 
-corenet_non_ipsec_sendrecv(cvs_t)
+corenet_all_recvfrom_unlabeled(cvs_t)
+corenet_all_recvfrom_netlabel(cvs_t)
 corenet_tcp_sendrecv_all_if(cvs_t)
 corenet_udp_sendrecv_all_if(cvs_t)
 corenet_tcp_sendrecv_all_nodes(cvs_t)
Index: refpolicy_svn_repo/policy/modules/services/cyrus.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cyrus.te
+++ refpolicy_svn_repo/policy/modules/services/cyrus.te
@@ -61,7 +61,8 @@ kernel_read_kernel_sysctls(cyrus_t)
 kernel_read_system_state(cyrus_t)
 kernel_read_all_sysctls(cyrus_t)
 
-corenet_non_ipsec_sendrecv(cyrus_t)
+corenet_all_recvfrom_unlabeled(cyrus_t)
+corenet_all_recvfrom_netlabel(cyrus_t)
 corenet_tcp_sendrecv_all_if(cyrus_t)
 corenet_udp_sendrecv_all_if(cyrus_t)
 corenet_tcp_sendrecv_all_nodes(cyrus_t)
Index: refpolicy_svn_repo/policy/modules/services/dante.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dante.te
+++ refpolicy_svn_repo/policy/modules/services/dante.te
@@ -38,7 +38,8 @@ kernel_read_kernel_sysctls(dante_t)
 kernel_list_proc(dante_t)
 kernel_read_proc_symlinks(dante_t)
 
-corenet_non_ipsec_sendrecv(dante_t)
+corenet_all_recvfrom_unlabeled(dante_t)
+corenet_all_recvfrom_netlabel(dante_t)
 corenet_tcp_sendrecv_generic_if(dante_t)
 corenet_udp_sendrecv_generic_if(dante_t)
 corenet_tcp_sendrecv_all_nodes(dante_t)
Index: refpolicy_svn_repo/policy/modules/services/dbskk.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dbskk.te
+++ refpolicy_svn_repo/policy/modules/services/dbskk.te
@@ -48,7 +48,8 @@ kernel_read_kernel_sysctls(dbskkd_t)
 kernel_read_system_state(dbskkd_t)
 kernel_read_network_state(dbskkd_t)
 
-corenet_non_ipsec_sendrecv(dbskkd_t)
+corenet_all_recvfrom_unlabeled(dbskkd_t)
+corenet_all_recvfrom_netlabel(dbskkd_t)
 corenet_tcp_sendrecv_all_if(dbskkd_t)
 corenet_udp_sendrecv_all_if(dbskkd_t)
 corenet_tcp_sendrecv_all_nodes(dbskkd_t)
Index: refpolicy_svn_repo/policy/modules/services/dbus.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dbus.if
+++ refpolicy_svn_repo/policy/modules/services/dbus.if
@@ -107,7 +107,8 @@ template(`dbus_per_role_template',`
 	corecmd_read_bin_pipes($1_dbusd_t)
 	corecmd_read_bin_sockets($1_dbusd_t)
 
-	corenet_non_ipsec_sendrecv($1_dbusd_t)
+	corenet_all_recvfrom_unlabeled($1_dbusd_t)
+	corenet_all_recvfrom_netlabel($1_dbusd_t)
 	corenet_tcp_sendrecv_all_if($1_dbusd_t)
 	corenet_tcp_sendrecv_all_nodes($1_dbusd_t)
 	corenet_tcp_sendrecv_all_ports($1_dbusd_t)
@@ -269,7 +270,6 @@ template(`dbus_send_user_bus',`
 	allow $2 $1_dbusd_t:dbus send_msg;
 ')
 
-
 ########################################
 ## <summary>
 ##	Read dbus configuration.
Index: refpolicy_svn_repo/policy/modules/services/dcc.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dcc.te
+++ refpolicy_svn_repo/policy/modules/services/dcc.te
@@ -99,7 +99,8 @@ allow cdcc_t dcc_var_t:dir list_dir_perm
 read_files_pattern(cdcc_t,dcc_var_t,dcc_var_t)
 read_lnk_files_pattern(cdcc_t,dcc_var_t,dcc_var_t)
 
-corenet_non_ipsec_sendrecv(cdcc_t)
+corenet_all_recvfrom_unlabeled(cdcc_t)
+corenet_all_recvfrom_netlabel(cdcc_t)
 corenet_udp_sendrecv_generic_if(cdcc_t)
 corenet_udp_sendrecv_all_nodes(cdcc_t)
 corenet_udp_sendrecv_all_ports(cdcc_t)
@@ -141,7 +142,8 @@ allow dcc_client_t dcc_var_t:dir list_di
 read_files_pattern(dcc_client_t,dcc_var_t,dcc_var_t)
 read_lnk_files_pattern(dcc_client_t,dcc_var_t,dcc_var_t)
 
-corenet_non_ipsec_sendrecv(dcc_client_t)
+corenet_all_recvfrom_unlabeled(dcc_client_t)
+corenet_all_recvfrom_netlabel(dcc_client_t)
 corenet_udp_sendrecv_generic_if(dcc_client_t)
 corenet_udp_sendrecv_all_nodes(dcc_client_t)
 corenet_udp_sendrecv_all_ports(dcc_client_t)
@@ -183,7 +185,8 @@ manage_lnk_files_pattern(dcc_dbclean_t,d
 
 kernel_read_system_state(dcc_dbclean_t)
 
-corenet_non_ipsec_sendrecv(dcc_dbclean_t)
+corenet_all_recvfrom_unlabeled(dcc_dbclean_t)
+corenet_all_recvfrom_netlabel(dcc_dbclean_t)
 corenet_udp_sendrecv_generic_if(dcc_dbclean_t)
 corenet_udp_sendrecv_all_nodes(dcc_dbclean_t)
 corenet_udp_sendrecv_all_ports(dcc_dbclean_t)
@@ -243,7 +246,8 @@ files_pid_filetrans(dccd_t,dccd_var_run_
 kernel_read_system_state(dccd_t)
 kernel_read_kernel_sysctls(dccd_t)
 
-corenet_non_ipsec_sendrecv(dccd_t)
+corenet_all_recvfrom_unlabeled(dccd_t)
+corenet_all_recvfrom_netlabel(dccd_t)
 corenet_udp_sendrecv_generic_if(dccd_t)
 corenet_udp_sendrecv_all_nodes(dccd_t)
 corenet_udp_sendrecv_all_ports(dccd_t)
@@ -324,7 +328,8 @@ files_pid_filetrans(dccifd_t,dccifd_var_
 kernel_read_system_state(dccifd_t)
 kernel_read_kernel_sysctls(dccifd_t)
 
-corenet_non_ipsec_sendrecv(dccifd_t)
+corenet_all_recvfrom_unlabeled(dccifd_t)
+corenet_all_recvfrom_netlabel(dccifd_t)
 corenet_udp_sendrecv_generic_if(dccifd_t)
 corenet_udp_sendrecv_all_nodes(dccifd_t)
 corenet_udp_sendrecv_all_ports(dccifd_t)
@@ -401,7 +406,8 @@ files_pid_filetrans(dccm_t,dccm_var_run_
 kernel_read_system_state(dccm_t)
 kernel_read_kernel_sysctls(dccm_t)
 
-corenet_non_ipsec_sendrecv(dccm_t)
+corenet_all_recvfrom_unlabeled(dccm_t)
+corenet_all_recvfrom_netlabel(dccm_t)
 corenet_udp_sendrecv_generic_if(dccm_t)
 corenet_udp_sendrecv_all_nodes(dccm_t)
 corenet_udp_sendrecv_all_ports(dccm_t)
Index: refpolicy_svn_repo/policy/modules/services/ddclient.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ddclient.te
+++ refpolicy_svn_repo/policy/modules/services/ddclient.te
@@ -64,7 +64,8 @@ kernel_read_kernel_sysctls(ddclient_t)
 corecmd_exec_shell(ddclient_t)
 corecmd_exec_bin(ddclient_t)
 
-corenet_non_ipsec_sendrecv(ddclient_t)
+corenet_all_recvfrom_unlabeled(ddclient_t)
+corenet_all_recvfrom_netlabel(ddclient_t)
 corenet_tcp_sendrecv_generic_if(ddclient_t)
 corenet_udp_sendrecv_generic_if(ddclient_t)
 corenet_tcp_sendrecv_all_nodes(ddclient_t)
Index: refpolicy_svn_repo/policy/modules/services/dhcp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dhcp.te
+++ refpolicy_svn_repo/policy/modules/services/dhcp.te
@@ -52,7 +52,8 @@ files_pid_filetrans(dhcpd_t,dhcpd_var_ru
 kernel_read_system_state(dhcpd_t)
 kernel_read_kernel_sysctls(dhcpd_t)
 
-corenet_non_ipsec_sendrecv(dhcpd_t)
+corenet_all_recvfrom_unlabeled(dhcpd_t)
+corenet_all_recvfrom_netlabel(dhcpd_t)
 corenet_tcp_sendrecv_all_if(dhcpd_t)
 corenet_udp_sendrecv_all_if(dhcpd_t)
 corenet_raw_sendrecv_all_if(dhcpd_t)
Index: refpolicy_svn_repo/policy/modules/services/dictd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dictd.te
+++ refpolicy_svn_repo/policy/modules/services/dictd.te
@@ -37,7 +37,8 @@ allow dictd_t dictd_var_lib_t:file read_
 kernel_read_system_state(dictd_t)
 kernel_read_kernel_sysctls(dictd_t)
 
-corenet_non_ipsec_sendrecv(dictd_t)
+corenet_all_recvfrom_unlabeled(dictd_t)
+corenet_all_recvfrom_netlabel(dictd_t)
 corenet_tcp_sendrecv_all_if(dictd_t)
 corenet_raw_sendrecv_all_if(dictd_t)
 corenet_udp_sendrecv_all_if(dictd_t)
Index: refpolicy_svn_repo/policy/modules/services/distcc.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/distcc.te
+++ refpolicy_svn_repo/policy/modules/services/distcc.te
@@ -44,7 +44,8 @@ files_pid_filetrans(distccd_t,distccd_va
 kernel_read_system_state(distccd_t)
 kernel_read_kernel_sysctls(distccd_t)
 
-corenet_non_ipsec_sendrecv(distccd_t)
+corenet_all_recvfrom_unlabeled(distccd_t)
+corenet_all_recvfrom_netlabel(distccd_t)
 corenet_tcp_sendrecv_all_if(distccd_t)
 corenet_udp_sendrecv_all_if(distccd_t)
 corenet_tcp_sendrecv_all_nodes(distccd_t)
Index: refpolicy_svn_repo/policy/modules/services/djbdns.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/djbdns.if
+++ refpolicy_svn_repo/policy/modules/services/djbdns.if
@@ -32,7 +32,8 @@ template(`djbdns_daemontools_domain_temp
 	allow djbdns_$1_t djbdns_$1_conf_t:dir list_dir_perms;
 	allow djbdns_$1_t djbdns_$1_conf_t:file read_file_perms;
 
-	corenet_non_ipsec_sendrecv(djbdns_$1_t)
+	corenet_all_recvfrom_unlabeled(djbdns_$1_t)
+	corenet_all_recvfrom_netlabel(djbdns_$1_t)
 	corenet_tcp_sendrecv_all_if(djbdns_$1_t)
 	corenet_udp_sendrecv_all_if(djbdns_$1_t)
 	corenet_tcp_sendrecv_all_nodes(djbdns_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/dnsmasq.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dnsmasq.te
+++ refpolicy_svn_repo/policy/modules/services/dnsmasq.te
@@ -42,7 +42,8 @@ kernel_read_kernel_sysctls(dnsmasq_t)
 kernel_list_proc(dnsmasq_t)
 kernel_read_proc_symlinks(dnsmasq_t)
 
-corenet_non_ipsec_sendrecv(dnsmasq_t)
+corenet_all_recvfrom_unlabeled(dnsmasq_t)
+corenet_all_recvfrom_netlabel(dnsmasq_t)
 corenet_tcp_sendrecv_generic_if(dnsmasq_t)
 corenet_udp_sendrecv_generic_if(dnsmasq_t)
 corenet_raw_sendrecv_generic_if(dnsmasq_t)
Index: refpolicy_svn_repo/policy/modules/services/dovecot.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dovecot.te
+++ refpolicy_svn_repo/policy/modules/services/dovecot.te
@@ -70,7 +70,8 @@ files_pid_filetrans(dovecot_t,dovecot_va
 kernel_read_kernel_sysctls(dovecot_t)
 kernel_read_system_state(dovecot_t)
 
-corenet_non_ipsec_sendrecv(dovecot_t)
+corenet_all_recvfrom_unlabeled(dovecot_t)
+corenet_all_recvfrom_netlabel(dovecot_t)
 corenet_tcp_sendrecv_all_if(dovecot_t)
 corenet_tcp_sendrecv_all_nodes(dovecot_t)
 corenet_tcp_sendrecv_all_ports(dovecot_t)
Index: refpolicy_svn_repo/policy/modules/services/fetchmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/fetchmail.te
+++ refpolicy_svn_repo/policy/modules/services/fetchmail.te
@@ -46,7 +46,8 @@ kernel_getattr_proc_files(fetchmail_t)
 kernel_read_proc_symlinks(fetchmail_t)
 kernel_dontaudit_read_system_state(fetchmail_t)
 
-corenet_non_ipsec_sendrecv(fetchmail_t)
+corenet_all_recvfrom_unlabeled(fetchmail_t)
+corenet_all_recvfrom_netlabel(fetchmail_t)
 corenet_tcp_sendrecv_generic_if(fetchmail_t)
 corenet_udp_sendrecv_generic_if(fetchmail_t)
 corenet_tcp_sendrecv_all_nodes(fetchmail_t)
Index: refpolicy_svn_repo/policy/modules/services/finger.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/finger.te
+++ refpolicy_svn_repo/policy/modules/services/finger.te
@@ -47,7 +47,8 @@ logging_log_filetrans(fingerd_t,fingerd_
 kernel_read_kernel_sysctls(fingerd_t)
 kernel_read_system_state(fingerd_t)
 
-corenet_non_ipsec_sendrecv(fingerd_t)
+corenet_all_recvfrom_unlabeled(fingerd_t)
+corenet_all_recvfrom_netlabel(fingerd_t)
 corenet_tcp_sendrecv_all_if(fingerd_t)
 corenet_udp_sendrecv_all_if(fingerd_t)
 corenet_tcp_sendrecv_all_nodes(fingerd_t)
Index: refpolicy_svn_repo/policy/modules/services/ftp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ftp.te
+++ refpolicy_svn_repo/policy/modules/services/ftp.te
@@ -128,7 +128,8 @@ dev_read_urand(ftpd_t)
 
 corecmd_exec_bin(ftpd_t)
 
-corenet_non_ipsec_sendrecv(ftpd_t)
+corenet_all_recvfrom_unlabeled(ftpd_t)
+corenet_all_recvfrom_netlabel(ftpd_t)
 corenet_tcp_sendrecv_all_if(ftpd_t)
 corenet_udp_sendrecv_all_if(ftpd_t)
 corenet_tcp_sendrecv_all_nodes(ftpd_t)
Index: refpolicy_svn_repo/policy/modules/services/gatekeeper.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/gatekeeper.te
+++ refpolicy_svn_repo/policy/modules/services/gatekeeper.te
@@ -53,7 +53,8 @@ kernel_read_kernel_sysctls(gatekeeper_t)
 
 corecmd_list_bin(gatekeeper_t)
 
-corenet_non_ipsec_sendrecv(gatekeeper_t)
+corenet_all_recvfrom_unlabeled(gatekeeper_t)
+corenet_all_recvfrom_netlabel(gatekeeper_t)
 corenet_tcp_sendrecv_generic_if(gatekeeper_t)
 corenet_udp_sendrecv_generic_if(gatekeeper_t)
 corenet_tcp_sendrecv_all_nodes(gatekeeper_t)
Index: refpolicy_svn_repo/policy/modules/services/hal.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/hal.te
+++ refpolicy_svn_repo/policy/modules/services/hal.te
@@ -91,7 +91,8 @@ auth_read_pam_console_data(hald_t)
 
 corecmd_exec_all_executables(hald_t)
 
-corenet_non_ipsec_sendrecv(hald_t)
+corenet_all_recvfrom_unlabeled(hald_t)
+corenet_all_recvfrom_netlabel(hald_t)
 corenet_tcp_sendrecv_all_if(hald_t)
 corenet_udp_sendrecv_all_if(hald_t)
 corenet_tcp_sendrecv_all_nodes(hald_t)
Index: refpolicy_svn_repo/policy/modules/services/howl.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/howl.te
+++ refpolicy_svn_repo/policy/modules/services/howl.te
@@ -34,7 +34,8 @@ kernel_load_module(howl_t)
 kernel_list_proc(howl_t)
 kernel_read_proc_symlinks(howl_t)
 
-corenet_non_ipsec_sendrecv(howl_t)
+corenet_all_recvfrom_unlabeled(howl_t)
+corenet_all_recvfrom_netlabel(howl_t)
 corenet_tcp_sendrecv_all_if(howl_t)
 corenet_udp_sendrecv_all_if(howl_t)
 corenet_tcp_sendrecv_all_nodes(howl_t)
Index: refpolicy_svn_repo/policy/modules/services/i18n_input.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/i18n_input.te
+++ refpolicy_svn_repo/policy/modules/services/i18n_input.te
@@ -37,7 +37,8 @@ can_exec(i18n_input_t, i18n_input_exec_t
 kernel_read_kernel_sysctls(i18n_input_t)
 kernel_read_system_state(i18n_input_t)
 
-corenet_non_ipsec_sendrecv(i18n_input_t)
+corenet_all_recvfrom_unlabeled(i18n_input_t)
+corenet_all_recvfrom_netlabel(i18n_input_t)
 corenet_tcp_sendrecv_generic_if(i18n_input_t)
 corenet_udp_sendrecv_generic_if(i18n_input_t)
 corenet_tcp_sendrecv_all_nodes(i18n_input_t)
Index: refpolicy_svn_repo/policy/modules/services/imaze.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/imaze.te
+++ refpolicy_svn_repo/policy/modules/services/imaze.te
@@ -55,7 +55,8 @@ kernel_read_kernel_sysctls(imazesrv_t)
 kernel_list_proc(imazesrv_t)
 kernel_read_proc_symlinks(imazesrv_t)
 
-corenet_non_ipsec_sendrecv(imazesrv_t)
+corenet_all_recvfrom_unlabeled(imazesrv_t)
+corenet_all_recvfrom_netlabel(imazesrv_t)
 corenet_tcp_sendrecv_generic_if(imazesrv_t)
 corenet_udp_sendrecv_generic_if(imazesrv_t)
 corenet_tcp_sendrecv_all_nodes(imazesrv_t)
Index: refpolicy_svn_repo/policy/modules/services/inetd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/inetd.te
+++ refpolicy_svn_repo/policy/modules/services/inetd.te
@@ -60,7 +60,8 @@ kernel_read_system_state(inetd_t)
 kernel_tcp_recvfrom_unlabeled(inetd_t)
 
 # base networking:
-corenet_non_ipsec_sendrecv(inetd_t)
+corenet_all_recvfrom_unlabeled(inetd_t)
+corenet_all_recvfrom_netlabel(inetd_t)
 corenet_tcp_sendrecv_all_if(inetd_t)
 corenet_udp_sendrecv_all_if(inetd_t)
 corenet_tcp_sendrecv_all_nodes(inetd_t)
@@ -81,7 +82,6 @@ corenet_tcp_bind_dbskkd_port(inetd_t)
 corenet_udp_bind_dbskkd_port(inetd_t)
 corenet_udp_bind_ftp_port(inetd_t)
 corenet_tcp_bind_inetd_child_port(inetd_t)
-corenet_tcp_bind_inetd_child_port(inetd_t)
 corenet_udp_bind_ktalkd_port(inetd_t)
 corenet_tcp_bind_printer_port(inetd_t)
 corenet_udp_bind_rsh_port(inetd_t)
@@ -143,11 +143,6 @@ sysnet_read_config(inetd_t)
 userdom_dontaudit_use_unpriv_user_fds(inetd_t)
 userdom_dontaudit_search_sysadm_home_dirs(inetd_t)
 
-ifdef(`enable_mls',`
- 	corenet_tcp_recv_netlabel(inetd_t)
-  	corenet_udp_recv_netlabel(inetd_t)
-')
-
 ifdef(`targeted_policy',`
 	term_dontaudit_use_unallocated_ttys(inetd_t)
 	term_dontaudit_use_generic_ptys(inetd_t)
@@ -200,7 +195,8 @@ kernel_read_kernel_sysctls(inetd_child_t
 kernel_read_system_state(inetd_child_t)
 kernel_read_network_state(inetd_child_t)
 
-corenet_non_ipsec_sendrecv(inetd_child_t)
+corenet_all_recvfrom_unlabeled(inetd_child_t)
+corenet_all_recvfrom_netlabel(inetd_child_t)
 corenet_tcp_sendrecv_all_if(inetd_child_t)
 corenet_udp_sendrecv_all_if(inetd_child_t)
 corenet_tcp_sendrecv_all_nodes(inetd_child_t)
Index: refpolicy_svn_repo/policy/modules/services/inn.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/inn.te
+++ refpolicy_svn_repo/policy/modules/services/inn.te
@@ -63,7 +63,8 @@ manage_lnk_files_pattern(innd_t,news_spo
 kernel_read_kernel_sysctls(innd_t)
 kernel_read_system_state(innd_t)
 
-corenet_non_ipsec_sendrecv(innd_t)
+corenet_all_recvfrom_unlabeled(innd_t)
+corenet_all_recvfrom_netlabel(innd_t)
 corenet_tcp_sendrecv_all_if(innd_t)
 corenet_udp_sendrecv_all_if(innd_t)
 corenet_tcp_sendrecv_all_nodes(innd_t)
Index: refpolicy_svn_repo/policy/modules/services/ircd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ircd.te
+++ refpolicy_svn_repo/policy/modules/services/ircd.te
@@ -50,7 +50,8 @@ kernel_read_kernel_sysctls(ircd_t)
 
 corecmd_search_bin(ircd_t)
 
-corenet_non_ipsec_sendrecv(ircd_t)
+corenet_all_recvfrom_unlabeled(ircd_t)
+corenet_all_recvfrom_netlabel(ircd_t)
 corenet_tcp_sendrecv_generic_if(ircd_t)
 corenet_udp_sendrecv_generic_if(ircd_t)
 corenet_tcp_sendrecv_all_nodes(ircd_t)
Index: refpolicy_svn_repo/policy/modules/services/jabber.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/jabber.te
+++ refpolicy_svn_repo/policy/modules/services/jabber.te
@@ -44,7 +44,8 @@ kernel_read_kernel_sysctls(jabberd_t)
 kernel_list_proc(jabberd_t)
 kernel_read_proc_symlinks(jabberd_t)
 
-corenet_non_ipsec_sendrecv(jabberd_t)
+corenet_all_recvfrom_unlabeled(jabberd_t)
+corenet_all_recvfrom_netlabel(jabberd_t)
 corenet_tcp_sendrecv_generic_if(jabberd_t)
 corenet_udp_sendrecv_generic_if(jabberd_t)
 corenet_tcp_sendrecv_all_nodes(jabberd_t)
Index: refpolicy_svn_repo/policy/modules/services/kerberos.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/kerberos.if
+++ refpolicy_svn_repo/policy/modules/services/kerberos.if
@@ -47,7 +47,8 @@ interface(`kerberos_use',`
 		allow $1 self:tcp_socket create_socket_perms;
 		allow $1 self:udp_socket create_socket_perms;
 
-		corenet_non_ipsec_sendrecv($1)
+		corenet_all_recvfrom_unlabeled($1)
+		corenet_all_recvfrom_netlabel($1)
 		corenet_tcp_sendrecv_all_if($1)
 		corenet_udp_sendrecv_all_if($1)
 		corenet_tcp_sendrecv_all_nodes($1)
Index: refpolicy_svn_repo/policy/modules/services/kerberos.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/kerberos.te
+++ refpolicy_svn_repo/policy/modules/services/kerberos.te
@@ -92,7 +92,8 @@ kernel_read_kernel_sysctls(kadmind_t)
 kernel_list_proc(kadmind_t)
 kernel_read_proc_symlinks(kadmind_t)
 
-corenet_non_ipsec_sendrecv(kadmind_t)
+corenet_all_recvfrom_unlabeled(kadmind_t)
+corenet_all_recvfrom_netlabel(kadmind_t)
 corenet_tcp_sendrecv_all_if(kadmind_t)
 corenet_udp_sendrecv_all_if(kadmind_t)
 corenet_tcp_sendrecv_all_nodes(kadmind_t)
@@ -192,7 +193,8 @@ kernel_search_network_sysctl(krb5kdc_t)
 
 corecmd_exec_bin(krb5kdc_t)
 
-corenet_non_ipsec_sendrecv(krb5kdc_t)
+corenet_all_recvfrom_unlabeled(krb5kdc_t)
+corenet_all_recvfrom_netlabel(krb5kdc_t)
 corenet_tcp_sendrecv_all_if(krb5kdc_t)
 corenet_udp_sendrecv_all_if(krb5kdc_t)
 corenet_tcp_sendrecv_all_nodes(krb5kdc_t)
Index: refpolicy_svn_repo/policy/modules/services/ktalk.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ktalk.te
+++ refpolicy_svn_repo/policy/modules/services/ktalk.te
@@ -53,7 +53,8 @@ kernel_read_kernel_sysctls(ktalkd_t)
 kernel_read_system_state(ktalkd_t)
 kernel_read_network_state(ktalkd_t)
 
-corenet_non_ipsec_sendrecv(ktalkd_t)
+corenet_all_recvfrom_unlabeled(ktalkd_t)
+corenet_all_recvfrom_netlabel(ktalkd_t)
 corenet_tcp_sendrecv_all_if(ktalkd_t)
 corenet_udp_sendrecv_all_if(ktalkd_t)
 corenet_tcp_sendrecv_all_nodes(ktalkd_t)
Index: refpolicy_svn_repo/policy/modules/services/ldap.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ldap.te
+++ refpolicy_svn_repo/policy/modules/services/ldap.te
@@ -77,7 +77,8 @@ files_pid_filetrans(slapd_t,slapd_var_ru
 kernel_read_system_state(slapd_t)
 kernel_read_kernel_sysctls(slapd_t)
 
-corenet_non_ipsec_sendrecv(slapd_t)
+corenet_all_recvfrom_unlabeled(slapd_t)
+corenet_all_recvfrom_netlabel(slapd_t)
 corenet_tcp_sendrecv_all_if(slapd_t)
 corenet_udp_sendrecv_all_if(slapd_t)
 corenet_tcp_sendrecv_all_nodes(slapd_t)
Index: refpolicy_svn_repo/policy/modules/services/lpd.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/lpd.if
+++ refpolicy_svn_repo/policy/modules/services/lpd.if
@@ -104,7 +104,8 @@ template(`lpd_per_role_template',`
 
 	kernel_read_kernel_sysctls($1_lpr_t)
 
-	corenet_non_ipsec_sendrecv($1_lpr_t)
+	corenet_all_recvfrom_unlabeled($1_lpr_t)
+	corenet_all_recvfrom_netlabel($1_lpr_t)
 	corenet_tcp_sendrecv_generic_if($1_lpr_t)
 	corenet_udp_sendrecv_generic_if($1_lpr_t)
 	corenet_tcp_sendrecv_all_nodes($1_lpr_t)
Index: refpolicy_svn_repo/policy/modules/services/lpd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/lpd.te
+++ refpolicy_svn_repo/policy/modules/services/lpd.te
@@ -72,7 +72,8 @@ allow checkpc_t printconf_t:dir { getatt
 
 kernel_read_system_state(checkpc_t)
 
-corenet_non_ipsec_sendrecv(checkpc_t)
+corenet_all_recvfrom_unlabeled(checkpc_t)
+corenet_all_recvfrom_netlabel(checkpc_t)
 corenet_tcp_sendrecv_all_if(checkpc_t)
 corenet_udp_sendrecv_all_if(checkpc_t)
 corenet_tcp_sendrecv_all_nodes(checkpc_t)
@@ -157,7 +158,8 @@ kernel_read_kernel_sysctls(lpd_t)
 # bash wants access to /proc/meminfo
 kernel_read_system_state(lpd_t)
 
-corenet_non_ipsec_sendrecv(lpd_t)
+corenet_all_recvfrom_unlabeled(lpd_t)
+corenet_all_recvfrom_netlabel(lpd_t)
 corenet_tcp_sendrecv_all_if(lpd_t)
 corenet_udp_sendrecv_all_if(lpd_t)
 corenet_tcp_sendrecv_all_nodes(lpd_t)
Index: refpolicy_svn_repo/policy/modules/services/mailman.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/mailman.if
+++ refpolicy_svn_repo/policy/modules/services/mailman.if
@@ -48,7 +48,8 @@ template(`mailman_domain_template', `
 	kernel_read_kernel_sysctls(mailman_$1_t)
 	kernel_read_system_state(mailman_$1_t)
 
-	corenet_non_ipsec_sendrecv(mailman_$1_t)
+	corenet_all_recvfrom_unlabeled(mailman_$1_t)
+	corenet_all_recvfrom_netlabel(mailman_$1_t)
 	corenet_tcp_sendrecv_all_if(mailman_$1_t)
 	corenet_udp_sendrecv_all_if(mailman_$1_t)
 	corenet_raw_sendrecv_all_if(mailman_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/monop.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/monop.te
+++ refpolicy_svn_repo/policy/modules/services/monop.te
@@ -43,7 +43,8 @@ kernel_read_kernel_sysctls(monopd_t)
 kernel_list_proc(monopd_t)
 kernel_read_proc_symlinks(monopd_t)
 
-corenet_non_ipsec_sendrecv(monopd_t)
+corenet_all_recvfrom_unlabeled(monopd_t)
+corenet_all_recvfrom_netlabel(monopd_t)
 corenet_tcp_sendrecv_generic_if(monopd_t)
 corenet_udp_sendrecv_generic_if(monopd_t)
 corenet_tcp_sendrecv_all_nodes(monopd_t)
Index: refpolicy_svn_repo/policy/modules/services/mta.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/mta.if
+++ refpolicy_svn_repo/policy/modules/services/mta.if
@@ -72,7 +72,8 @@ template(`mta_base_mail_template',`
 
 	kernel_read_kernel_sysctls($1_mail_t)
 
-	corenet_non_ipsec_sendrecv($1_mail_t)
+	corenet_all_recvfrom_unlabeled($1_mail_t)
+	corenet_all_recvfrom_netlabel($1_mail_t)
 	corenet_tcp_sendrecv_all_if($1_mail_t)
 	corenet_tcp_sendrecv_all_nodes($1_mail_t)
 	corenet_tcp_sendrecv_all_ports($1_mail_t)
Index: refpolicy_svn_repo/policy/modules/services/munin.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/munin.te
+++ refpolicy_svn_repo/policy/modules/services/munin.te
@@ -65,7 +65,8 @@ kernel_read_kernel_sysctls(munin_t)
 
 corecmd_exec_bin(munin_t)
 
-corenet_non_ipsec_sendrecv(munin_t)
+corenet_all_recvfrom_unlabeled(munin_t)
+corenet_all_recvfrom_netlabel(munin_t)
 corenet_tcp_sendrecv_generic_if(munin_t)
 corenet_udp_sendrecv_generic_if(munin_t)
 corenet_tcp_sendrecv_all_nodes(munin_t)
Index: refpolicy_svn_repo/policy/modules/services/mysql.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/mysql.te
+++ refpolicy_svn_repo/policy/modules/services/mysql.te
@@ -61,7 +61,8 @@ files_pid_filetrans(mysqld_t,mysqld_var_
 kernel_read_system_state(mysqld_t)
 kernel_read_kernel_sysctls(mysqld_t)
 
-corenet_non_ipsec_sendrecv(mysqld_t)
+corenet_all_recvfrom_unlabeled(mysqld_t)
+corenet_all_recvfrom_netlabel(mysqld_t)
 corenet_tcp_sendrecv_all_if(mysqld_t)
 corenet_udp_sendrecv_all_if(mysqld_t)
 corenet_tcp_sendrecv_all_nodes(mysqld_t)
Index: refpolicy_svn_repo/policy/modules/services/nagios.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nagios.te
+++ refpolicy_svn_repo/policy/modules/services/nagios.te
@@ -66,7 +66,8 @@ kernel_read_kernel_sysctls(nagios_t)
 corecmd_exec_bin(nagios_t)
 corecmd_exec_shell(nagios_t)
 
-corenet_non_ipsec_sendrecv(nagios_t)
+corenet_all_recvfrom_unlabeled(nagios_t)
+corenet_all_recvfrom_netlabel(nagios_t)
 corenet_tcp_sendrecv_generic_if(nagios_t)
 corenet_udp_sendrecv_generic_if(nagios_t)
 corenet_tcp_sendrecv_all_nodes(nagios_t)
Index: refpolicy_svn_repo/policy/modules/services/nessus.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nessus.te
+++ refpolicy_svn_repo/policy/modules/services/nessus.te
@@ -57,7 +57,8 @@ kernel_read_kernel_sysctls(nessusd_t)
 # for nmap etc
 corecmd_exec_bin(nessusd_t)
 
-corenet_non_ipsec_sendrecv(nessusd_t)
+corenet_all_recvfrom_unlabeled(nessusd_t)
+corenet_all_recvfrom_netlabel(nessusd_t)
 corenet_tcp_sendrecv_generic_if(nessusd_t)
 corenet_udp_sendrecv_generic_if(nessusd_t)
 corenet_raw_sendrecv_generic_if(nessusd_t)
Index: refpolicy_svn_repo/policy/modules/services/networkmanager.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/networkmanager.te
+++ refpolicy_svn_repo/policy/modules/services/networkmanager.te
@@ -41,7 +41,8 @@ kernel_read_network_state(NetworkManager
 kernel_read_kernel_sysctls(NetworkManager_t)
 kernel_load_module(NetworkManager_t)
 
-corenet_non_ipsec_sendrecv(NetworkManager_t)
+corenet_all_recvfrom_unlabeled(NetworkManager_t)
+corenet_all_recvfrom_netlabel(NetworkManager_t)
 corenet_tcp_sendrecv_all_if(NetworkManager_t)
 corenet_udp_sendrecv_all_if(NetworkManager_t)
 corenet_raw_sendrecv_all_if(NetworkManager_t)
Index: refpolicy_svn_repo/policy/modules/services/nis.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nis.if
+++ refpolicy_svn_repo/policy/modules/services/nis.if
@@ -37,7 +37,8 @@ interface(`nis_use_ypbind_uncond',`
 	allow $1 var_yp_t:lnk_file { getattr read };
 	allow $1 var_yp_t:file read_file_perms;
 
-	corenet_non_ipsec_sendrecv($1)
+	corenet_all_recvfrom_unlabeled($1)
+	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_udp_sendrecv_all_if($1)
 	corenet_tcp_sendrecv_all_nodes($1)
Index: refpolicy_svn_repo/policy/modules/services/nis.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nis.te
+++ refpolicy_svn_repo/policy/modules/services/nis.te
@@ -69,7 +69,8 @@ kernel_read_kernel_sysctls(ypbind_t)
 kernel_list_proc(ypbind_t)
 kernel_read_proc_symlinks(ypbind_t)
 
-corenet_non_ipsec_sendrecv(ypbind_t)
+corenet_all_recvfrom_unlabeled(ypbind_t)
+corenet_all_recvfrom_netlabel(ypbind_t)
 corenet_tcp_sendrecv_all_if(ypbind_t)
 corenet_udp_sendrecv_all_if(ypbind_t)
 corenet_tcp_sendrecv_all_nodes(ypbind_t)
@@ -112,7 +113,6 @@ sysnet_read_config(ypbind_t)
 userdom_dontaudit_use_unpriv_user_fds(ypbind_t)
 userdom_dontaudit_search_sysadm_home_dirs(ypbind_t)
 
-
 ifdef(`targeted_policy', `
 	term_dontaudit_use_unallocated_ttys(ypbind_t)
 	term_dontaudit_use_generic_ptys(ypbind_t)
@@ -152,7 +152,8 @@ kernel_read_proc_symlinks(yppasswdd_t)
 kernel_getattr_proc_files(yppasswdd_t)
 kernel_read_kernel_sysctls(yppasswdd_t)
 
-corenet_non_ipsec_sendrecv(yppasswdd_t)
+corenet_all_recvfrom_unlabeled(yppasswdd_t)
+corenet_all_recvfrom_netlabel(yppasswdd_t)
 corenet_tcp_sendrecv_generic_if(yppasswdd_t)
 corenet_udp_sendrecv_generic_if(yppasswdd_t)
 corenet_tcp_sendrecv_all_nodes(yppasswdd_t)
@@ -199,7 +200,6 @@ sysnet_read_config(yppasswdd_t)
 userdom_dontaudit_use_unpriv_user_fds(yppasswdd_t)
 userdom_dontaudit_search_sysadm_home_dirs(yppasswdd_t)
 
-
 ifdef(`targeted_policy',`
         term_dontaudit_use_unallocated_ttys(yppasswdd_t)
         term_dontaudit_use_generic_ptys(yppasswdd_t)
@@ -247,7 +247,8 @@ kernel_read_kernel_sysctls(ypserv_t)
 kernel_list_proc(ypserv_t)
 kernel_read_proc_symlinks(ypserv_t)
 
-corenet_non_ipsec_sendrecv(ypserv_t)
+corenet_all_recvfrom_unlabeled(ypserv_t)
+corenet_all_recvfrom_netlabel(ypserv_t)
 corenet_tcp_sendrecv_all_if(ypserv_t)
 corenet_udp_sendrecv_all_if(ypserv_t)
 corenet_tcp_sendrecv_all_nodes(ypserv_t)
@@ -288,7 +289,6 @@ sysnet_read_config(ypserv_t)
 userdom_dontaudit_use_unpriv_user_fds(ypserv_t)
 userdom_dontaudit_search_sysadm_home_dirs(ypserv_t)
 
-
 ifdef(`targeted_policy',`
 	term_dontaudit_use_unallocated_ttys(ypserv_t)
 	term_dontaudit_use_generic_ptys(ypserv_t)
@@ -321,7 +321,8 @@ allow ypxfr_t ypserv_t:udp_socket { read
 
 allow ypxfr_t ypserv_conf_t:file { getattr read };
 
-corenet_non_ipsec_sendrecv(ypxfr_t)
+corenet_all_recvfrom_unlabeled(ypxfr_t)
+corenet_all_recvfrom_netlabel(ypxfr_t)
 corenet_tcp_sendrecv_all_if(ypxfr_t)
 corenet_udp_sendrecv_all_if(ypxfr_t)
 corenet_tcp_sendrecv_all_nodes(ypxfr_t)
Index: refpolicy_svn_repo/policy/modules/services/nscd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nscd.te
+++ refpolicy_svn_repo/policy/modules/services/nscd.te
@@ -65,7 +65,8 @@ fs_search_auto_mountpoints(nscd_t)
 auth_getattr_shadow(nscd_t)
 auth_use_nsswitch(nscd_t)
 
-corenet_non_ipsec_sendrecv(nscd_t)
+corenet_all_recvfrom_unlabeled(nscd_t)
+corenet_all_recvfrom_netlabel(nscd_t)
 corenet_tcp_sendrecv_all_if(nscd_t)
 corenet_udp_sendrecv_all_if(nscd_t)
 corenet_tcp_sendrecv_all_nodes(nscd_t)
Index: refpolicy_svn_repo/policy/modules/services/nsd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nsd.te
+++ refpolicy_svn_repo/policy/modules/services/nsd.te
@@ -62,7 +62,8 @@ kernel_read_kernel_sysctls(nsd_t)
 
 corecmd_exec_bin(nsd_t)
 
-corenet_non_ipsec_sendrecv(nsd_t)
+corenet_all_recvfrom_unlabeled(nsd_t)
+corenet_all_recvfrom_netlabel(nsd_t)
 corenet_tcp_sendrecv_generic_if(nsd_t)
 corenet_udp_sendrecv_generic_if(nsd_t)
 corenet_tcp_sendrecv_all_nodes(nsd_t)
@@ -148,7 +149,8 @@ kernel_read_system_state(nsd_crond_t)
 corecmd_exec_bin(nsd_crond_t)
 corecmd_exec_shell(nsd_crond_t)
 
-corenet_non_ipsec_sendrecv(nsd_crond_t)
+corenet_all_recvfrom_unlabeled(nsd_crond_t)
+corenet_all_recvfrom_netlabel(nsd_crond_t)
 corenet_tcp_sendrecv_generic_if(nsd_crond_t)
 corenet_udp_sendrecv_generic_if(nsd_crond_t)
 corenet_tcp_sendrecv_all_nodes(nsd_crond_t)
Index: refpolicy_svn_repo/policy/modules/services/ntop.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ntop.te
+++ refpolicy_svn_repo/policy/modules/services/ntop.te
@@ -61,7 +61,8 @@ kernel_read_kernel_sysctls(ntop_t)
 kernel_list_proc(ntop_t)
 kernel_read_proc_symlinks(ntop_t)
 
-corenet_non_ipsec_sendrecv(ntop_t)
+corenet_all_recvfrom_unlabeled(ntop_t)
+corenet_all_recvfrom_netlabel(ntop_t)
 corenet_tcp_sendrecv_generic_if(ntop_t)
 corenet_udp_sendrecv_generic_if(ntop_t)
 corenet_raw_sendrecv_generic_if(ntop_t)
Index: refpolicy_svn_repo/policy/modules/services/nx.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nx.te
+++ refpolicy_svn_repo/policy/modules/services/nx.te
@@ -51,7 +51,8 @@ kernel_read_kernel_sysctls(nx_server_t)
 corecmd_exec_shell(nx_server_t)
 corecmd_exec_bin(nx_server_t)
 
-corenet_non_ipsec_sendrecv(nx_server_t)
+corenet_all_recvfrom_unlabeled(nx_server_t)
+corenet_all_recvfrom_netlabel(nx_server_t)
 corenet_tcp_sendrecv_generic_if(nx_server_t)
 corenet_udp_sendrecv_generic_if(nx_server_t)
 corenet_tcp_sendrecv_all_nodes(nx_server_t)
Index: refpolicy_svn_repo/policy/modules/services/oav.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/oav.te
+++ refpolicy_svn_repo/policy/modules/services/oav.te
@@ -50,7 +50,8 @@ read_lnk_files_pattern(oav_update_t,oav_
 
 corecmd_exec_all_executables(oav_update_t)
 
-corenet_non_ipsec_sendrecv(oav_update_t)
+corenet_all_recvfrom_unlabeled(oav_update_t)
+corenet_all_recvfrom_netlabel(oav_update_t)
 corenet_tcp_sendrecv_generic_if(oav_update_t)
 corenet_udp_sendrecv_generic_if(oav_update_t)
 corenet_tcp_sendrecv_all_nodes(oav_update_t)
@@ -104,7 +105,8 @@ kernel_read_kernel_sysctls(scannerdaemon
 # Can run kaffe
 corecmd_exec_all_executables(scannerdaemon_t)
 
-corenet_non_ipsec_sendrecv(scannerdaemon_t)
+corenet_all_recvfrom_unlabeled(scannerdaemon_t)
+corenet_all_recvfrom_netlabel(scannerdaemon_t)
 corenet_tcp_sendrecv_generic_if(scannerdaemon_t)
 corenet_udp_sendrecv_generic_if(scannerdaemon_t)
 corenet_tcp_sendrecv_all_nodes(scannerdaemon_t)
Index: refpolicy_svn_repo/policy/modules/services/openvpn.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/openvpn.te
+++ refpolicy_svn_repo/policy/modules/services/openvpn.te
@@ -53,7 +53,8 @@ kernel_read_system_state(openvpn_t)
 corecmd_exec_bin(openvpn_t)
 corecmd_exec_shell(openvpn_t)
 
-corenet_non_ipsec_sendrecv(openvpn_t)
+corenet_all_recvfrom_unlabeled(openvpn_t)
+corenet_all_recvfrom_netlabel(openvpn_t)
 corenet_tcp_sendrecv_all_if(openvpn_t)
 corenet_udp_sendrecv_all_if(openvpn_t)
 corenet_tcp_sendrecv_generic_node(openvpn_t)
Index: refpolicy_svn_repo/policy/modules/services/pcscd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/pcscd.te
+++ refpolicy_svn_repo/policy/modules/services/pcscd.te
@@ -31,10 +31,11 @@ manage_files_pattern(pcscd_t,pcscd_var_r
 manage_sock_files_pattern(pcscd_t,pcscd_var_run_t,pcscd_var_run_t)
 files_pid_filetrans(pcscd_t,pcscd_var_run_t, { file sock_file })
 
+corenet_all_recvfrom_unlabeled(pcscd_t)
+corenet_all_recvfrom_netlabel(pcscd_t)
 corenet_tcp_sendrecv_all_if(pcscd_t)
 corenet_tcp_sendrecv_all_nodes(pcscd_t)
 corenet_tcp_sendrecv_all_ports(pcscd_t)
-corenet_non_ipsec_sendrecv(pcscd_t)
 corenet_tcp_connect_http_port(pcscd_t)
 
 dev_rw_generic_usb_dev(pcscd_t)
Index: refpolicy_svn_repo/policy/modules/services/pegasus.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/pegasus.te
+++ refpolicy_svn_repo/policy/modules/services/pegasus.te
@@ -66,7 +66,8 @@ kernel_read_system_state(pegasus_t)
 kernel_search_vm_sysctl(pegasus_t)
 kernel_read_net_sysctls(pegasus_t)
 
-corenet_non_ipsec_sendrecv(pegasus_t)
+corenet_all_recvfrom_unlabeled(pegasus_t)
+corenet_all_recvfrom_netlabel(pegasus_t)
 corenet_tcp_sendrecv_all_if(pegasus_t)
 corenet_tcp_sendrecv_all_nodes(pegasus_t)
 corenet_tcp_sendrecv_all_ports(pegasus_t)
Index: refpolicy_svn_repo/policy/modules/services/perdition.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/perdition.te
+++ refpolicy_svn_repo/policy/modules/services/perdition.te
@@ -37,7 +37,8 @@ kernel_read_kernel_sysctls(perdition_t)
 kernel_list_proc(perdition_t)
 kernel_read_proc_symlinks(perdition_t)
 
-corenet_non_ipsec_sendrecv(perdition_t)
+corenet_all_recvfrom_unlabeled(perdition_t)
+corenet_all_recvfrom_netlabel(perdition_t)
 corenet_tcp_sendrecv_generic_if(perdition_t)
 corenet_udp_sendrecv_generic_if(perdition_t)
 corenet_tcp_sendrecv_all_nodes(perdition_t)
Index: refpolicy_svn_repo/policy/modules/services/portmap.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/portmap.te
+++ refpolicy_svn_repo/policy/modules/services/portmap.te
@@ -45,7 +45,8 @@ kernel_read_kernel_sysctls(portmap_t)
 kernel_list_proc(portmap_t)
 kernel_read_proc_symlinks(portmap_t)
 
-corenet_non_ipsec_sendrecv(portmap_t)
+corenet_all_recvfrom_unlabeled(portmap_t)
+corenet_all_recvfrom_netlabel(portmap_t)
 corenet_tcp_sendrecv_all_if(portmap_t)
 corenet_udp_sendrecv_all_if(portmap_t)
 corenet_tcp_sendrecv_all_nodes(portmap_t)
@@ -123,6 +124,8 @@ allow portmap_helper_t self:udp_socket c
 allow portmap_helper_t portmap_var_run_t:file manage_file_perms;
 files_pid_filetrans(portmap_helper_t,portmap_var_run_t,file)
 
+corenet_all_recvfrom_unlabeled(portmap_helper_t)
+corenet_all_recvfrom_netlabel(portmap_helper_t)
 corenet_tcp_sendrecv_all_if(portmap_helper_t)
 corenet_udp_sendrecv_all_if(portmap_helper_t)
 corenet_raw_sendrecv_all_if(portmap_helper_t)
@@ -131,7 +134,6 @@ corenet_udp_sendrecv_all_nodes(portmap_h
 corenet_raw_sendrecv_all_nodes(portmap_helper_t)
 corenet_tcp_sendrecv_all_ports(portmap_helper_t)
 corenet_udp_sendrecv_all_ports(portmap_helper_t)
-corenet_non_ipsec_sendrecv(portmap_helper_t)
 corenet_tcp_bind_all_nodes(portmap_helper_t)
 corenet_udp_bind_all_nodes(portmap_helper_t)
 corenet_tcp_bind_reserved_port(portmap_helper_t)
Index: refpolicy_svn_repo/policy/modules/services/portslave.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/portslave.te
+++ refpolicy_svn_repo/policy/modules/services/portslave.te
@@ -55,7 +55,8 @@ kernel_read_kernel_sysctls(portslave_t)
 corecmd_exec_bin(portslave_t)
 corecmd_exec_shell(portslave_t)
 
-corenet_non_ipsec_sendrecv(portslave_t)
+corenet_all_recvfrom_unlabeled(portslave_t)
+corenet_all_recvfrom_netlabel(portslave_t)
 corenet_tcp_sendrecv_generic_if(portslave_t)
 corenet_udp_sendrecv_generic_if(portslave_t)
 corenet_tcp_sendrecv_all_nodes(portslave_t)
Index: refpolicy_svn_repo/policy/modules/services/postfix.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postfix.if
+++ refpolicy_svn_repo/policy/modules/services/postfix.if
@@ -125,7 +125,8 @@ template(`postfix_server_domain_template
 
 	domtrans_pattern(postfix_master_t, postfix_$1_exec_t, postfix_$1_t)
 
-	corenet_non_ipsec_sendrecv(postfix_$1_t)
+	corenet_all_recvfrom_unlabeled(postfix_$1_t)
+	corenet_all_recvfrom_netlabel(postfix_$1_t)
 	corenet_tcp_sendrecv_all_if(postfix_$1_t)
 	corenet_udp_sendrecv_all_if(postfix_$1_t)
 	corenet_tcp_sendrecv_all_nodes(postfix_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/postfix.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postfix.te
+++ refpolicy_svn_repo/policy/modules/services/postfix.te
@@ -133,7 +133,8 @@ rename_files_pattern(postfix_master_t,po
 
 kernel_read_all_sysctls(postfix_master_t)
 
-corenet_non_ipsec_sendrecv(postfix_master_t)
+corenet_all_recvfrom_unlabeled(postfix_master_t)
+corenet_all_recvfrom_netlabel(postfix_master_t)
 corenet_tcp_sendrecv_all_if(postfix_master_t)
 corenet_udp_sendrecv_all_if(postfix_master_t)
 corenet_tcp_sendrecv_all_nodes(postfix_master_t)
@@ -309,7 +310,8 @@ kernel_read_kernel_sysctls(postfix_map_t
 kernel_dontaudit_list_proc(postfix_map_t)
 kernel_dontaudit_read_system_state(postfix_map_t)
 
-corenet_non_ipsec_sendrecv(postfix_map_t)
+corenet_all_recvfrom_unlabeled(postfix_map_t)
+corenet_all_recvfrom_netlabel(postfix_map_t)
 corenet_tcp_sendrecv_all_if(postfix_map_t)
 corenet_udp_sendrecv_all_if(postfix_map_t)
 corenet_tcp_sendrecv_all_nodes(postfix_map_t)
Index: refpolicy_svn_repo/policy/modules/services/postgresql.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postgresql.te
+++ refpolicy_svn_repo/policy/modules/services/postgresql.te
@@ -82,7 +82,8 @@ kernel_list_proc(postgresql_t)
 kernel_read_all_sysctls(postgresql_t)
 kernel_read_proc_symlinks(postgresql_t)
 
-corenet_non_ipsec_sendrecv(postgresql_t)
+corenet_all_recvfrom_unlabeled(postgresql_t)
+corenet_all_recvfrom_netlabel(postgresql_t)
 corenet_tcp_sendrecv_all_if(postgresql_t)
 corenet_udp_sendrecv_all_if(postgresql_t)
 corenet_tcp_sendrecv_all_nodes(postgresql_t)
Index: refpolicy_svn_repo/policy/modules/services/postgrey.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postgrey.te
+++ refpolicy_svn_repo/policy/modules/services/postgrey.te
@@ -46,7 +46,8 @@ kernel_read_kernel_sysctls(postgrey_t)
 # for perl
 corecmd_search_bin(postgrey_t)
 
-corenet_non_ipsec_sendrecv(postgrey_t)
+corenet_all_recvfrom_unlabeled(postgrey_t)
+corenet_all_recvfrom_netlabel(postgrey_t)
 corenet_tcp_sendrecv_generic_if(postgrey_t)
 corenet_tcp_sendrecv_all_nodes(postgrey_t)
 corenet_tcp_sendrecv_all_ports(postgrey_t)
Index: refpolicy_svn_repo/policy/modules/services/ppp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ppp.te
+++ refpolicy_svn_repo/policy/modules/services/ppp.te
@@ -126,7 +126,8 @@ dev_read_urand(pppd_t)
 dev_search_sysfs(pppd_t)
 dev_read_sysfs(pppd_t)
 
-corenet_non_ipsec_sendrecv(pppd_t)
+corenet_all_recvfrom_unlabeled(pppd_t)
+corenet_all_recvfrom_netlabel(pppd_t)
 corenet_tcp_sendrecv_all_if(pppd_t)
 corenet_raw_sendrecv_all_if(pppd_t)
 corenet_udp_sendrecv_all_if(pppd_t)
@@ -261,7 +262,8 @@ kernel_read_proc_symlinks(pptp_t)
 
 dev_read_sysfs(pptp_t)
 
-corenet_non_ipsec_sendrecv(pptp_t)
+corenet_all_recvfrom_unlabeled(pptp_t)
+corenet_all_recvfrom_netlabel(pptp_t)
 corenet_tcp_sendrecv_all_if(pptp_t)
 corenet_raw_sendrecv_all_if(pptp_t)
 corenet_tcp_sendrecv_all_nodes(pptp_t)
Index: refpolicy_svn_repo/policy/modules/services/privoxy.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/privoxy.te
+++ refpolicy_svn_repo/policy/modules/services/privoxy.te
@@ -40,7 +40,8 @@ kernel_read_kernel_sysctls(privoxy_t)
 kernel_list_proc(privoxy_t)
 kernel_read_proc_symlinks(privoxy_t)
 
-corenet_non_ipsec_sendrecv(privoxy_t)
+corenet_all_recvfrom_unlabeled(privoxy_t)
+corenet_all_recvfrom_netlabel(privoxy_t)
 corenet_tcp_sendrecv_all_if(privoxy_t)
 corenet_tcp_sendrecv_all_nodes(privoxy_t)
 corenet_tcp_sendrecv_all_ports(privoxy_t)
Index: refpolicy_svn_repo/policy/modules/services/procmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/procmail.te
+++ refpolicy_svn_repo/policy/modules/services/procmail.te
@@ -34,7 +34,8 @@ files_tmp_filetrans(procmail_t, procmail
 kernel_read_system_state(procmail_t)
 kernel_read_kernel_sysctls(procmail_t)
 
-corenet_non_ipsec_sendrecv(procmail_t)
+corenet_all_recvfrom_unlabeled(procmail_t)
+corenet_all_recvfrom_netlabel(procmail_t)
 corenet_tcp_sendrecv_all_if(procmail_t)
 corenet_udp_sendrecv_all_if(procmail_t)
 corenet_tcp_sendrecv_all_nodes(procmail_t)
Index: refpolicy_svn_repo/policy/modules/services/pyzor.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/pyzor.te
+++ refpolicy_svn_repo/policy/modules/services/pyzor.te
@@ -107,7 +107,8 @@ dev_read_urand(pyzord_t)
 
 corecmd_exec_bin(pyzord_t)
 
-corenet_non_ipsec_sendrecv(pyzord_t)
+corenet_all_recvfrom_unlabeled(pyzord_t)
+corenet_all_recvfrom_netlabel(pyzord_t)
 corenet_udp_sendrecv_all_if(pyzord_t)
 corenet_udp_sendrecv_all_nodes(pyzord_t)
 corenet_udp_sendrecv_all_ports(pyzord_t)
Index: refpolicy_svn_repo/policy/modules/services/qmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/qmail.te
+++ refpolicy_svn_repo/policy/modules/services/qmail.te
@@ -171,7 +171,8 @@ allow qmail_remote_t self:udp_socket cre
 
 rw_files_pattern(qmail_remote_t,qmail_spool_t,qmail_spool_t)
 
-corenet_non_ipsec_sendrecv(qmail_remote_t)
+corenet_all_recvfrom_unlabeled(qmail_remote_t)
+corenet_all_recvfrom_netlabel(qmail_remote_t)
 corenet_tcp_sendrecv_generic_if(qmail_remote_t)
 corenet_udp_sendrecv_generic_if(qmail_remote_t)
 corenet_tcp_sendrecv_generic_node(qmail_remote_t)
Index: refpolicy_svn_repo/policy/modules/services/radius.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/radius.te
+++ refpolicy_svn_repo/policy/modules/services/radius.te
@@ -58,7 +58,8 @@ files_pid_filetrans(radiusd_t,radiusd_va
 kernel_read_kernel_sysctls(radiusd_t)
 kernel_read_system_state(radiusd_t)
 
-corenet_non_ipsec_sendrecv(radiusd_t)
+corenet_all_recvfrom_unlabeled(radiusd_t)
+corenet_all_recvfrom_netlabel(radiusd_t)
 corenet_tcp_sendrecv_all_if(radiusd_t)
 corenet_udp_sendrecv_all_if(radiusd_t)
 corenet_tcp_sendrecv_all_nodes(radiusd_t)
Index: refpolicy_svn_repo/policy/modules/services/radvd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/radvd.te
+++ refpolicy_svn_repo/policy/modules/services/radvd.te
@@ -38,7 +38,8 @@ kernel_read_net_sysctls(radvd_t)
 kernel_read_network_state(radvd_t)
 kernel_read_system_state(radvd_t)
 
-corenet_non_ipsec_sendrecv(radvd_t)
+corenet_all_recvfrom_unlabeled(radvd_t)
+corenet_all_recvfrom_netlabel(radvd_t)
 corenet_tcp_sendrecv_all_if(radvd_t)
 corenet_udp_sendrecv_all_if(radvd_t)
 corenet_raw_sendrecv_all_if(radvd_t)
Index: refpolicy_svn_repo/policy/modules/services/razor.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/razor.if
+++ refpolicy_svn_repo/policy/modules/services/razor.if
@@ -67,7 +67,8 @@ template(`razor_common_domain_template',
 
 	corecmd_exec_bin($1_t)
 
-	corenet_non_ipsec_sendrecv($1_t)
+	corenet_all_recvfrom_unlabeled($1_t)
+	corenet_all_recvfrom_netlabel($1_t)
 	corenet_tcp_sendrecv_generic_if($1_t)
 	corenet_raw_sendrecv_generic_if($1_t)
 	corenet_tcp_sendrecv_all_nodes($1_t)
Index: refpolicy_svn_repo/policy/modules/services/razor.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/razor.te
+++ refpolicy_svn_repo/policy/modules/services/razor.te
@@ -41,7 +41,8 @@ logging_log_filetrans(razor_t,razor_log_
 manage_files_pattern(razor_t,razor_var_lib_t,razor_var_lib_t)
 files_var_lib_filetrans(razor_t,razor_var_lib_t,file)
 
-corenet_non_ipsec_sendrecv(razor_t)
+corenet_all_recvfrom_unlabeled(razor_t)
+corenet_all_recvfrom_netlabel(razor_t)
 corenet_tcp_sendrecv_generic_if(razor_t)
 corenet_raw_sendrecv_generic_if(razor_t)
 corenet_tcp_sendrecv_all_nodes(razor_t)
Index: refpolicy_svn_repo/policy/modules/services/rdisc.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rdisc.te
+++ refpolicy_svn_repo/policy/modules/services/rdisc.te
@@ -26,7 +26,8 @@ kernel_list_proc(rdisc_t)
 kernel_read_proc_symlinks(rdisc_t)
 kernel_read_kernel_sysctls(rdisc_t)
 
-corenet_non_ipsec_sendrecv(rdisc_t)
+corenet_all_recvfrom_unlabeled(rdisc_t)
+corenet_all_recvfrom_netlabel(rdisc_t)
 corenet_udp_sendrecv_generic_if(rdisc_t)
 corenet_raw_sendrecv_generic_if(rdisc_t)
 corenet_udp_sendrecv_all_nodes(rdisc_t)
Index: refpolicy_svn_repo/policy/modules/services/rhgb.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rhgb.te
+++ refpolicy_svn_repo/policy/modules/services/rhgb.te
@@ -44,7 +44,8 @@ kernel_read_system_state(rhgb_t)
 corecmd_exec_bin(rhgb_t)
 corecmd_exec_shell(rhgb_t)
 
-corenet_non_ipsec_sendrecv(rhgb_t)
+corenet_all_recvfrom_unlabeled(rhgb_t)
+corenet_all_recvfrom_netlabel(rhgb_t)
 corenet_tcp_sendrecv_generic_if(rhgb_t)
 corenet_udp_sendrecv_generic_if(rhgb_t)
 corenet_tcp_sendrecv_all_nodes(rhgb_t)
Index: refpolicy_svn_repo/policy/modules/services/ricci.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ricci.te
+++ refpolicy_svn_repo/policy/modules/services/ricci.te
@@ -120,7 +120,8 @@ kernel_read_kernel_sysctls(ricci_t)
 
 corecmd_exec_bin(ricci_t)
 
-corenet_non_ipsec_sendrecv(ricci_t)
+corenet_all_recvfrom_unlabeled(ricci_t)
+corenet_all_recvfrom_netlabel(ricci_t)
 corenet_tcp_sendrecv_all_if(ricci_t)
 corenet_tcp_sendrecv_all_nodes(ricci_t)
 corenet_tcp_sendrecv_all_ports(ricci_t)
@@ -356,7 +357,6 @@ logging_read_generic_logs(ricci_modlog_t
 
 miscfiles_read_localization(ricci_modlog_t)
 
-
 optional_policy(`
 	nscd_dontaudit_search_pid(ricci_modlog_t)
 ')
Index: refpolicy_svn_repo/policy/modules/services/rlogin.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rlogin.te
+++ refpolicy_svn_repo/policy/modules/services/rlogin.te
@@ -50,7 +50,8 @@ kernel_read_kernel_sysctls(rlogind_t)
 kernel_read_system_state(rlogind_t)
 kernel_read_network_state(rlogind_t)
 
-corenet_non_ipsec_sendrecv(rlogind_t)
+corenet_all_recvfrom_unlabeled(rlogind_t)
+corenet_all_recvfrom_netlabel(rlogind_t)
 corenet_tcp_sendrecv_all_if(rlogind_t)
 corenet_udp_sendrecv_all_if(rlogind_t)
 corenet_tcp_sendrecv_all_nodes(rlogind_t)
Index: refpolicy_svn_repo/policy/modules/services/roundup.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/roundup.te
+++ refpolicy_svn_repo/policy/modules/services/roundup.te
@@ -43,7 +43,8 @@ dev_read_sysfs(roundup_t)
 # execute python
 corecmd_exec_bin(roundup_t)
 
-corenet_non_ipsec_sendrecv(roundup_t)
+corenet_all_recvfrom_unlabeled(roundup_t)
+corenet_all_recvfrom_netlabel(roundup_t)
 corenet_tcp_sendrecv_generic_if(roundup_t)
 corenet_udp_sendrecv_generic_if(roundup_t)
 corenet_raw_sendrecv_generic_if(roundup_t)
Index: refpolicy_svn_repo/policy/modules/services/rpc.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rpc.if
+++ refpolicy_svn_repo/policy/modules/services/rpc.if
@@ -70,7 +70,8 @@ template(`rpc_domain_template', `
 	dev_read_urand($1_t)
 	dev_read_rand($1_t)
 
-	corenet_non_ipsec_sendrecv($1_t)
+	corenet_all_recvfrom_unlabeled($1_t)
+	corenet_all_recvfrom_netlabel($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
 	corenet_tcp_sendrecv_all_nodes($1_t)
@@ -80,7 +81,6 @@ template(`rpc_domain_template', `
 	corenet_tcp_bind_all_nodes($1_t)
 	corenet_udp_bind_all_nodes($1_t)
 	corenet_tcp_bind_reserved_port($1_t)
-	corenet_tcp_bind_reserved_port($1_t)
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_portmap_client_packets($1_t)
 	# do not log when it tries to bind to a port belonging to another domain
Index: refpolicy_svn_repo/policy/modules/services/rshd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rshd.te
+++ refpolicy_svn_repo/policy/modules/services/rshd.te
@@ -23,7 +23,8 @@ allow rshd_t self:tcp_socket create_stre
 
 kernel_read_kernel_sysctls(rshd_t)
 
-corenet_non_ipsec_sendrecv(rshd_t)
+corenet_all_recvfrom_unlabeled(rshd_t)
+corenet_all_recvfrom_netlabel(rshd_t)
 corenet_tcp_sendrecv_generic_if(rshd_t)
 corenet_udp_sendrecv_generic_if(rshd_t)
 corenet_tcp_sendrecv_all_nodes(rshd_t)
Index: refpolicy_svn_repo/policy/modules/services/rsync.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rsync.te
+++ refpolicy_svn_repo/policy/modules/services/rsync.te
@@ -61,7 +61,8 @@ kernel_read_kernel_sysctls(rsync_t)
 kernel_read_system_state(rsync_t)
 kernel_read_network_state(rsync_t)
 
-corenet_non_ipsec_sendrecv(rsync_t)
+corenet_all_recvfrom_unlabeled(rsync_t)
+corenet_all_recvfrom_netlabel(rsync_t)
 corenet_tcp_sendrecv_all_if(rsync_t)
 corenet_udp_sendrecv_all_if(rsync_t)
 corenet_tcp_sendrecv_all_nodes(rsync_t)
Index: refpolicy_svn_repo/policy/modules/services/rwho.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rwho.te
+++ refpolicy_svn_repo/policy/modules/services/rwho.te
@@ -32,7 +32,8 @@ files_spool_filetrans(rwho_t,rwho_spool_
 
 kernel_read_system_state(rwho_t)
 
-corenet_non_ipsec_sendrecv(rwho_t)
+corenet_all_recvfrom_unlabeled(rwho_t)
+corenet_all_recvfrom_netlabel(rwho_t)
 corenet_udp_sendrecv_all_if(rwho_t)
 corenet_udp_sendrecv_all_nodes(rwho_t)
 corenet_udp_sendrecv_all_ports(rwho_t)
Index: refpolicy_svn_repo/policy/modules/services/samba.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/samba.te
+++ refpolicy_svn_repo/policy/modules/services/samba.te
@@ -133,6 +133,8 @@ manage_lnk_files_pattern(samba_net_t,sam
 
 kernel_read_proc_symlinks(samba_net_t)
 
+corenet_all_recvfrom_unlabeled(samba_net_t)
+corenet_all_recvfrom_netlabel(samba_net_t)
 corenet_tcp_sendrecv_all_if(samba_net_t)
 corenet_udp_sendrecv_all_if(samba_net_t)
 corenet_raw_sendrecv_all_if(samba_net_t)
@@ -141,7 +143,6 @@ corenet_udp_sendrecv_all_nodes(samba_net
 corenet_raw_sendrecv_all_nodes(samba_net_t)
 corenet_tcp_sendrecv_all_ports(samba_net_t)
 corenet_udp_sendrecv_all_ports(samba_net_t)
-corenet_non_ipsec_sendrecv(samba_net_t)
 corenet_tcp_bind_all_nodes(samba_net_t)
 corenet_udp_bind_all_nodes(samba_net_t)
 corenet_tcp_connect_smbd_port(samba_net_t)
@@ -241,6 +242,8 @@ kernel_read_kernel_sysctls(smbd_t)
 kernel_read_software_raid_state(smbd_t)
 kernel_read_system_state(smbd_t)
 
+corenet_all_recvfrom_unlabeled(smbd_t)
+corenet_all_recvfrom_netlabel(smbd_t)
 corenet_tcp_sendrecv_all_if(smbd_t)
 corenet_udp_sendrecv_all_if(smbd_t)
 corenet_raw_sendrecv_all_if(smbd_t)
@@ -249,7 +252,6 @@ corenet_udp_sendrecv_all_nodes(smbd_t)
 corenet_raw_sendrecv_all_nodes(smbd_t)
 corenet_tcp_sendrecv_all_ports(smbd_t)
 corenet_udp_sendrecv_all_ports(smbd_t)
-corenet_non_ipsec_sendrecv(smbd_t)
 corenet_tcp_bind_all_nodes(smbd_t)
 corenet_udp_bind_all_nodes(smbd_t)
 corenet_tcp_bind_smbd_port(smbd_t)
@@ -380,7 +382,8 @@ kernel_read_network_state(nmbd_t)
 kernel_read_software_raid_state(nmbd_t)
 kernel_read_system_state(nmbd_t)
 
-corenet_non_ipsec_sendrecv(nmbd_t)
+corenet_all_recvfrom_unlabeled(nmbd_t)
+corenet_all_recvfrom_netlabel(nmbd_t)
 corenet_tcp_sendrecv_all_if(nmbd_t)
 corenet_udp_sendrecv_all_if(nmbd_t)
 corenet_tcp_sendrecv_all_nodes(nmbd_t)
@@ -463,6 +466,8 @@ manage_lnk_files_pattern(smbmount_t,samb
 
 kernel_read_system_state(smbmount_t)
 
+corenet_all_recvfrom_unlabeled(smbmount_t)
+corenet_all_recvfrom_netlabel(smbmount_t)
 corenet_tcp_sendrecv_all_if(smbmount_t)
 corenet_raw_sendrecv_all_if(smbmount_t)
 corenet_udp_sendrecv_all_if(smbmount_t)
@@ -471,7 +476,6 @@ corenet_raw_sendrecv_all_nodes(smbmount_
 corenet_udp_sendrecv_all_nodes(smbmount_t)
 corenet_tcp_sendrecv_all_ports(smbmount_t)
 corenet_udp_sendrecv_all_ports(smbmount_t)
-corenet_non_ipsec_sendrecv(smbmount_t)
 corenet_tcp_bind_all_nodes(smbmount_t)
 corenet_udp_bind_all_nodes(smbmount_t)
 corenet_tcp_connect_all_ports(smbmount_t)
@@ -566,7 +570,8 @@ kernel_read_network_state(swat_t)
 
 corecmd_search_bin(swat_t)
 
-corenet_non_ipsec_sendrecv(swat_t)
+corenet_all_recvfrom_unlabeled(swat_t)
+corenet_all_recvfrom_netlabel(swat_t)
 corenet_tcp_sendrecv_generic_if(swat_t)
 corenet_udp_sendrecv_generic_if(swat_t)
 corenet_raw_sendrecv_generic_if(swat_t)
@@ -663,6 +668,8 @@ kernel_read_kernel_sysctls(winbind_t)
 kernel_list_proc(winbind_t)
 kernel_read_proc_symlinks(winbind_t)
 
+corenet_all_recvfrom_unlabeled(winbind_t)
+corenet_all_recvfrom_netlabel(winbind_t)
 corenet_tcp_sendrecv_all_if(winbind_t)
 corenet_udp_sendrecv_all_if(winbind_t)
 corenet_raw_sendrecv_all_if(winbind_t)
@@ -671,7 +678,6 @@ corenet_udp_sendrecv_all_nodes(winbind_t
 corenet_raw_sendrecv_all_nodes(winbind_t)
 corenet_tcp_sendrecv_all_ports(winbind_t)
 corenet_udp_sendrecv_all_ports(winbind_t)
-corenet_non_ipsec_sendrecv(winbind_t)
 corenet_tcp_bind_all_nodes(winbind_t)
 corenet_udp_bind_all_nodes(winbind_t)
 corenet_tcp_connect_smbd_port(winbind_t)
Index: refpolicy_svn_repo/policy/modules/services/sasl.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/sasl.te
+++ refpolicy_svn_repo/policy/modules/services/sasl.te
@@ -47,7 +47,8 @@ files_pid_filetrans(saslauthd_t,saslauth
 kernel_read_kernel_sysctls(saslauthd_t)
 kernel_read_system_state(saslauthd_t)
 
-corenet_non_ipsec_sendrecv(saslauthd_t)
+corenet_all_recvfrom_unlabeled(saslauthd_t)
+corenet_all_recvfrom_netlabel(saslauthd_t)
 corenet_tcp_sendrecv_all_if(saslauthd_t)
 corenet_tcp_sendrecv_all_nodes(saslauthd_t)
 corenet_tcp_sendrecv_all_ports(saslauthd_t)
Index: refpolicy_svn_repo/policy/modules/services/sendmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/sendmail.te
+++ refpolicy_svn_repo/policy/modules/services/sendmail.te
@@ -49,7 +49,8 @@ kernel_read_kernel_sysctls(sendmail_t)
 # for piping mail to a command
 kernel_read_system_state(sendmail_t)
 
-corenet_non_ipsec_sendrecv(sendmail_t)
+corenet_all_recvfrom_unlabeled(sendmail_t)
+corenet_all_recvfrom_netlabel(sendmail_t)
 corenet_tcp_sendrecv_all_if(sendmail_t)
 corenet_tcp_sendrecv_all_nodes(sendmail_t)
 corenet_tcp_sendrecv_all_ports(sendmail_t)
Index: refpolicy_svn_repo/policy/modules/services/setroubleshoot.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/setroubleshoot.te
+++ refpolicy_svn_repo/policy/modules/services/setroubleshoot.te
@@ -58,7 +58,8 @@ kernel_read_network_state(setroubleshoot
 corecmd_exec_bin(setroubleshootd_t)
 corecmd_exec_shell(setroubleshootd_t)
 
-corenet_non_ipsec_sendrecv(setroubleshootd_t)
+corenet_all_recvfrom_unlabeled(setroubleshootd_t)
+corenet_all_recvfrom_netlabel(setroubleshootd_t)
 corenet_tcp_sendrecv_generic_if(setroubleshootd_t)
 corenet_tcp_sendrecv_all_nodes(setroubleshootd_t)
 corenet_tcp_sendrecv_all_ports(setroubleshootd_t)
Index: refpolicy_svn_repo/policy/modules/services/smartmon.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/smartmon.te
+++ refpolicy_svn_repo/policy/modules/services/smartmon.te
@@ -42,7 +42,8 @@ kernel_read_system_state(fsdaemon_t)
 
 corecmd_exec_all_executables(fsdaemon_t)
 
-corenet_non_ipsec_sendrecv(fsdaemon_t)
+corenet_all_recvfrom_unlabeled(fsdaemon_t)
+corenet_all_recvfrom_netlabel(fsdaemon_t)
 corenet_udp_sendrecv_generic_if(fsdaemon_t)
 corenet_udp_sendrecv_all_nodes(fsdaemon_t)
 corenet_udp_sendrecv_all_ports(fsdaemon_t)
Index: refpolicy_svn_repo/policy/modules/services/snmp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/snmp.te
+++ refpolicy_svn_repo/policy/modules/services/snmp.te
@@ -58,7 +58,8 @@ kernel_read_network_state(snmpd_t)
 corecmd_exec_bin(snmpd_t)
 corecmd_exec_shell(snmpd_t)
 
-corenet_non_ipsec_sendrecv(snmpd_t)
+corenet_all_recvfrom_unlabeled(snmpd_t)
+corenet_all_recvfrom_netlabel(snmpd_t)
 corenet_tcp_sendrecv_all_if(snmpd_t)
 corenet_udp_sendrecv_all_if(snmpd_t)
 corenet_tcp_sendrecv_all_nodes(snmpd_t)
Index: refpolicy_svn_repo/policy/modules/services/snort.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/snort.te
+++ refpolicy_svn_repo/policy/modules/services/snort.te
@@ -55,7 +55,8 @@ kernel_list_proc(snort_t)
 kernel_read_proc_symlinks(snort_t)
 kernel_dontaudit_read_system_state(snort_t)
 
-corenet_non_ipsec_sendrecv(snort_t)
+corenet_all_recvfrom_unlabeled(snort_t)
+corenet_all_recvfrom_netlabel(snort_t)
 corenet_tcp_sendrecv_generic_if(snort_t)
 corenet_udp_sendrecv_generic_if(snort_t)
 corenet_raw_sendrecv_generic_if(snort_t)
Index: refpolicy_svn_repo/policy/modules/services/soundserver.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/soundserver.te
+++ refpolicy_svn_repo/policy/modules/services/soundserver.te
@@ -62,7 +62,8 @@ kernel_read_kernel_sysctls(soundd_t)
 kernel_list_proc(soundd_t)
 kernel_read_proc_symlinks(soundd_t)
 
-corenet_non_ipsec_sendrecv(soundd_t)
+corenet_all_recvfrom_unlabeled(soundd_t)
+corenet_all_recvfrom_netlabel(soundd_t)
 corenet_tcp_sendrecv_generic_if(soundd_t)
 corenet_udp_sendrecv_generic_if(soundd_t)
 corenet_tcp_sendrecv_all_nodes(soundd_t)
Index: refpolicy_svn_repo/policy/modules/services/spamassassin.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/spamassassin.if
+++ refpolicy_svn_repo/policy/modules/services/spamassassin.if
@@ -97,7 +97,8 @@ template(`spamassassin_per_role_template
 
 	kernel_read_kernel_sysctls($1_spamc_t)
 
-	corenet_non_ipsec_sendrecv($1_spamc_t)
+	corenet_all_recvfrom_unlabeled($1_spamc_t)
+	corenet_all_recvfrom_netlabel($1_spamc_t)
 	corenet_tcp_sendrecv_generic_if($1_spamc_t)
 	corenet_udp_sendrecv_generic_if($1_spamc_t)
 	corenet_tcp_sendrecv_all_nodes($1_spamc_t)
@@ -267,7 +268,8 @@ template(`spamassassin_per_role_template
 		allow $1_spamassassin_t self:tcp_socket create_stream_socket_perms;
 		allow $1_spamassassin_t self:udp_socket create_socket_perms;
 
-		corenet_non_ipsec_sendrecv($1_spamassassin_t)
+		corenet_all_recvfrom_unlabeled($1_spamassassin_t)
+		corenet_all_recvfrom_netlabel($1_spamassassin_t)
 		corenet_tcp_sendrecv_generic_if($1_spamassassin_t)
 		corenet_udp_sendrecv_generic_if($1_spamassassin_t)
 		corenet_tcp_sendrecv_all_nodes($1_spamassassin_t)
Index: refpolicy_svn_repo/policy/modules/services/spamassassin.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/spamassassin.te
+++ refpolicy_svn_repo/policy/modules/services/spamassassin.te
@@ -93,7 +93,8 @@ files_pid_filetrans(spamd_t,spamd_var_ru
 kernel_read_all_sysctls(spamd_t)
 kernel_read_system_state(spamd_t)
 
-corenet_non_ipsec_sendrecv(spamd_t)
+corenet_all_recvfrom_unlabeled(spamd_t)
+corenet_all_recvfrom_netlabel(spamd_t)
 corenet_tcp_sendrecv_all_if(spamd_t)
 corenet_udp_sendrecv_all_if(spamd_t)
 corenet_tcp_sendrecv_all_nodes(spamd_t)
Index: refpolicy_svn_repo/policy/modules/services/squid.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/squid.te
+++ refpolicy_svn_repo/policy/modules/services/squid.te
@@ -75,7 +75,8 @@ kernel_read_system_state(squid_t)
 
 files_dontaudit_getattr_boot_dirs(squid_t)
 
-corenet_non_ipsec_sendrecv(squid_t)
+corenet_all_recvfrom_unlabeled(squid_t)
+corenet_all_recvfrom_netlabel(squid_t)
 corenet_tcp_sendrecv_all_if(squid_t)
 corenet_udp_sendrecv_all_if(squid_t)
 corenet_tcp_sendrecv_all_nodes(squid_t)
Index: refpolicy_svn_repo/policy/modules/services/ssh.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ssh.if
+++ refpolicy_svn_repo/policy/modules/services/ssh.if
@@ -109,7 +109,8 @@ template(`ssh_basic_client_template',`
 
 	kernel_read_kernel_sysctls($1_ssh_t)
 
-	corenet_non_ipsec_sendrecv($1_ssh_t)
+	corenet_all_recvfrom_unlabeled($1_ssh_t)
+	corenet_all_recvfrom_netlabel($1_ssh_t)
 	corenet_tcp_sendrecv_all_if($1_ssh_t)
 	corenet_tcp_sendrecv_all_nodes($1_ssh_t)
 	corenet_tcp_sendrecv_all_ports($1_ssh_t)
@@ -466,6 +467,8 @@ template(`ssh_server_template', `
 
 	kernel_read_kernel_sysctls($1_t)
 
+	corenet_all_recvfrom_unlabeled($1_t)
+	corenet_all_recvfrom_netlabel($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
 	corenet_raw_sendrecv_all_if($1_t)
@@ -474,7 +477,6 @@ template(`ssh_server_template', `
 	corenet_raw_sendrecv_all_nodes($1_t)
 	corenet_udp_sendrecv_all_ports($1_t)
 	corenet_tcp_sendrecv_all_ports($1_t)
-	corenet_non_ipsec_sendrecv($1_t)
 	corenet_tcp_bind_all_nodes($1_t)
 	corenet_udp_bind_all_nodes($1_t)
 	corenet_tcp_bind_ssh_port($1_t)
Index: refpolicy_svn_repo/policy/modules/services/stunnel.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/stunnel.te
+++ refpolicy_svn_repo/policy/modules/services/stunnel.te
@@ -55,7 +55,8 @@ kernel_read_kernel_sysctls(stunnel_t)
 kernel_read_system_state(stunnel_t)
 kernel_read_network_state(stunnel_t)
 
-corenet_non_ipsec_sendrecv(stunnel_t)
+corenet_all_recvfrom_unlabeled(stunnel_t)
+corenet_all_recvfrom_netlabel(stunnel_t)
 corenet_tcp_sendrecv_all_if(stunnel_t)
 corenet_udp_sendrecv_all_if(stunnel_t)
 corenet_tcp_sendrecv_all_nodes(stunnel_t)
Index: refpolicy_svn_repo/policy/modules/services/tcpd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/tcpd.te
+++ refpolicy_svn_repo/policy/modules/services/tcpd.te
@@ -23,7 +23,8 @@ manage_dirs_pattern(tcpd_t,tcpd_tmp_t,tc
 manage_files_pattern(tcpd_t,tcpd_tmp_t,tcpd_tmp_t)
 files_tmp_filetrans(tcpd_t, tcpd_tmp_t, { file dir })
 
-corenet_non_ipsec_sendrecv(tcpd_t)
+corenet_all_recvfrom_unlabeled(tcpd_t)
+corenet_all_recvfrom_netlabel(tcpd_t)
 corenet_tcp_sendrecv_all_if(tcpd_t)
 corenet_tcp_sendrecv_all_nodes(tcpd_t)
 corenet_tcp_sendrecv_all_ports(tcpd_t)
Index: refpolicy_svn_repo/policy/modules/services/telnet.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/telnet.te
+++ refpolicy_svn_repo/policy/modules/services/telnet.te
@@ -49,7 +49,8 @@ kernel_read_kernel_sysctls(telnetd_t)
 kernel_read_system_state(telnetd_t)
 kernel_read_network_state(telnetd_t)
 
-corenet_non_ipsec_sendrecv(telnetd_t)
+corenet_all_recvfrom_unlabeled(telnetd_t)
+corenet_all_recvfrom_netlabel(telnetd_t)
 corenet_tcp_sendrecv_all_if(telnetd_t)
 corenet_udp_sendrecv_all_if(telnetd_t)
 corenet_tcp_sendrecv_all_nodes(telnetd_t)
Index: refpolicy_svn_repo/policy/modules/services/tftp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/tftp.te
+++ refpolicy_svn_repo/policy/modules/services/tftp.te
@@ -39,7 +39,8 @@ kernel_read_kernel_sysctls(tftpd_t)
 kernel_list_proc(tftpd_t)
 kernel_read_proc_symlinks(tftpd_t)
 
-corenet_non_ipsec_sendrecv(tftpd_t)
+corenet_all_recvfrom_unlabeled(tftpd_t)
+corenet_all_recvfrom_netlabel(tftpd_t)
 corenet_tcp_sendrecv_all_if(tftpd_t)
 corenet_udp_sendrecv_all_if(tftpd_t)
 corenet_tcp_sendrecv_all_nodes(tftpd_t)
Index: refpolicy_svn_repo/policy/modules/services/timidity.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/timidity.te
+++ refpolicy_svn_repo/policy/modules/services/timidity.te
@@ -39,7 +39,8 @@ kernel_read_kernel_sysctls(timidity_t)
 # read /proc/cpuinfo
 kernel_read_system_state(timidity_t)
 
-corenet_non_ipsec_sendrecv(timidity_t)
+corenet_all_recvfrom_unlabeled(timidity_t)
+corenet_all_recvfrom_netlabel(timidity_t)
 corenet_tcp_sendrecv_generic_if(timidity_t)
 corenet_udp_sendrecv_generic_if(timidity_t)
 corenet_tcp_sendrecv_all_nodes(timidity_t)
Index: refpolicy_svn_repo/policy/modules/services/tor.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/tor.te
+++ refpolicy_svn_repo/policy/modules/services/tor.te
@@ -63,7 +63,8 @@ files_pid_filetrans(tor_t,tor_var_run_t,
 kernel_read_system_state(tor_t)
 
 # networking basics
-corenet_non_ipsec_sendrecv(tor_t)
+corenet_all_recvfrom_unlabeled(tor_t)
+corenet_all_recvfrom_netlabel(tor_t)
 corenet_tcp_sendrecv_all_if(tor_t)
 corenet_tcp_sendrecv_all_nodes(tor_t)
 corenet_tcp_sendrecv_all_ports(tor_t)
Index: refpolicy_svn_repo/policy/modules/services/transproxy.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/transproxy.te
+++ refpolicy_svn_repo/policy/modules/services/transproxy.te
@@ -30,7 +30,8 @@ kernel_read_kernel_sysctls(transproxy_t)
 kernel_list_proc(transproxy_t)
 kernel_read_proc_symlinks(transproxy_t)
 
-corenet_non_ipsec_sendrecv(transproxy_t)
+corenet_all_recvfrom_unlabeled(transproxy_t)
+corenet_all_recvfrom_netlabel(transproxy_t)
 corenet_tcp_sendrecv_generic_if(transproxy_t)
 corenet_tcp_sendrecv_all_nodes(transproxy_t)
 corenet_tcp_sendrecv_all_ports(transproxy_t)
Index: refpolicy_svn_repo/policy/modules/services/ucspitcp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ucspitcp.te
+++ refpolicy_svn_repo/policy/modules/services/ucspitcp.te
@@ -25,13 +25,14 @@ ucspitcp_service_domain(rblsmtpd_t, rbls
 
 corecmd_search_bin(rblsmtpd_t)
 
+corenet_all_recvfrom_unlabeled(rblsmtpd_t)
+corenet_all_recvfrom_netlabel(rblsmtpd_t)
 corenet_tcp_sendrecv_all_if(rblsmtpd_t)
 corenet_udp_sendrecv_all_if(rblsmtpd_t)
 corenet_tcp_sendrecv_all_nodes(rblsmtpd_t)
 corenet_udp_sendrecv_all_nodes(rblsmtpd_t)
 corenet_tcp_sendrecv_all_ports(rblsmtpd_t)
 corenet_udp_sendrecv_all_ports(rblsmtpd_t)
-corenet_non_ipsec_sendrecv(rblsmtpd_t)
 corenet_tcp_bind_all_nodes(rblsmtpd_t)
 corenet_udp_bind_generic_port(rblsmtpd_t)
 
@@ -58,7 +59,8 @@ allow ucspitcp_t self:udp_socket create_
 corecmd_search_bin(ucspitcp_t)
 
 # base networking:
-corenet_non_ipsec_sendrecv(ucspitcp_t)
+corenet_all_recvfrom_unlabeled(ucspitcp_t)
+corenet_all_recvfrom_netlabel(ucspitcp_t)
 corenet_tcp_sendrecv_all_if(ucspitcp_t)
 corenet_udp_sendrecv_all_if(ucspitcp_t)
 corenet_tcp_sendrecv_all_nodes(ucspitcp_t)
Index: refpolicy_svn_repo/policy/modules/services/uucp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/uucp.te
+++ refpolicy_svn_repo/policy/modules/services/uucp.te
@@ -70,7 +70,8 @@ kernel_read_kernel_sysctls(uucpd_t)
 kernel_read_system_state(uucpd_t)
 kernel_read_network_state(uucpd_t)
 
-corenet_non_ipsec_sendrecv(uucpd_t)
+corenet_all_recvfrom_unlabeled(uucpd_t)
+corenet_all_recvfrom_netlabel(uucpd_t)
 corenet_tcp_sendrecv_all_if(uucpd_t)
 corenet_udp_sendrecv_all_if(uucpd_t)
 corenet_tcp_sendrecv_all_nodes(uucpd_t)
Index: refpolicy_svn_repo/policy/modules/services/uwimap.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/uwimap.te
+++ refpolicy_svn_repo/policy/modules/services/uwimap.te
@@ -39,7 +39,8 @@ kernel_read_kernel_sysctls(imapd_t)
 kernel_list_proc(imapd_t)
 kernel_read_proc_symlinks(imapd_t)
 
-corenet_non_ipsec_sendrecv(imapd_t)
+corenet_all_recvfrom_unlabeled(imapd_t)
+corenet_all_recvfrom_netlabel(imapd_t)
 corenet_tcp_sendrecv_generic_if(imapd_t)
 corenet_tcp_sendrecv_all_nodes(imapd_t)
 corenet_tcp_sendrecv_all_ports(imapd_t)
Index: refpolicy_svn_repo/policy/modules/services/watchdog.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/watchdog.te
+++ refpolicy_svn_repo/policy/modules/services/watchdog.te
@@ -43,7 +43,8 @@ kernel_unmount_proc(watchdog_t)
 corecmd_exec_shell(watchdog_t)
 
 # cjp: why networking?
-corenet_non_ipsec_sendrecv(watchdog_t)
+corenet_all_recvfrom_unlabeled(watchdog_t)
+corenet_all_recvfrom_netlabel(watchdog_t)
 corenet_tcp_sendrecv_generic_if(watchdog_t)
 corenet_udp_sendrecv_generic_if(watchdog_t)
 corenet_tcp_sendrecv_all_nodes(watchdog_t)
Index: refpolicy_svn_repo/policy/modules/services/xprint.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xprint.te
+++ refpolicy_svn_repo/policy/modules/services/xprint.te
@@ -33,7 +33,8 @@ kernel_read_kernel_sysctls(xprint_t)
 corecmd_exec_bin(xprint_t)
 corecmd_exec_shell(xprint_t)
 
-corenet_non_ipsec_sendrecv(xprint_t)
+corenet_all_recvfrom_unlabeled(xprint_t)
+corenet_all_recvfrom_netlabel(xprint_t)
 corenet_tcp_sendrecv_generic_if(xprint_t)
 corenet_udp_sendrecv_generic_if(xprint_t)
 corenet_tcp_sendrecv_all_nodes(xprint_t)
Index: refpolicy_svn_repo/policy/modules/services/xserver.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xserver.if
+++ refpolicy_svn_repo/policy/modules/services/xserver.if
@@ -94,7 +94,8 @@ template(`xserver_common_domain_template
 	corecmd_exec_bin($1_xserver_t)
 	corecmd_exec_shell($1_xserver_t)
 
-	corenet_non_ipsec_sendrecv($1_xserver_t)
+	corenet_all_recvfrom_unlabeled($1_xserver_t)
+	corenet_all_recvfrom_netlabel($1_xserver_t)
 	corenet_tcp_sendrecv_generic_if($1_xserver_t)
 	corenet_udp_sendrecv_generic_if($1_xserver_t)
 	corenet_tcp_sendrecv_all_nodes($1_xserver_t)
Index: refpolicy_svn_repo/policy/modules/services/xserver.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xserver.te
+++ refpolicy_svn_repo/policy/modules/services/xserver.te
@@ -177,7 +177,8 @@ kernel_read_network_state(xdm_t)
 corecmd_exec_shell(xdm_t)
 corecmd_exec_bin(xdm_t)
 
-corenet_non_ipsec_sendrecv(xdm_t)
+corenet_all_recvfrom_unlabeled(xdm_t)
+corenet_all_recvfrom_netlabel(xdm_t)
 corenet_tcp_sendrecv_generic_if(xdm_t)
 corenet_udp_sendrecv_generic_if(xdm_t)
 corenet_tcp_sendrecv_all_nodes(xdm_t)
Index: refpolicy_svn_repo/policy/modules/services/zebra.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/zebra.te
+++ refpolicy_svn_repo/policy/modules/services/zebra.te
@@ -67,7 +67,8 @@ kernel_read_system_state(zebra_t)
 kernel_read_kernel_sysctls(zebra_t)
 kernel_rw_net_sysctls(zebra_t)
 
-corenet_non_ipsec_sendrecv(zebra_t)
+corenet_all_recvfrom_unlabeled(zebra_t)
+corenet_all_recvfrom_netlabel(zebra_t)
 corenet_tcp_sendrecv_all_if(zebra_t)
 corenet_udp_sendrecv_all_if(zebra_t)
 corenet_raw_sendrecv_all_if(zebra_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
