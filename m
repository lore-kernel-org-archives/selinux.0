Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EKNtIB030782
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 16:23:55 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EKNrtB002318
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 20:23:53 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l5EKLuWO005967
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 16:21:56 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l5EKLuCD005966
	for selinux@tycho.nsa.gov; Thu, 14 Jun 2007 16:21:56 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EK31CR029454
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 16:03:01 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EK2rtB027847
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 20:02:54 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070614200100.885758728@hp.com>
References: <20070614195502.420663549@hp.com>
Date: Thu, 14 Jun 2007 15:55:05 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 3/5] Add NetLabel labeled and unlabeled support to the service domains
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds calls to the NetLabel corenet policy interfaces to grant the
relevant service domains access to NetLabel labeled and unlabeled packets.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/services/afs.te            |   20 ++++++++++++++++++
 policy/modules/services/amavis.te         |    4 +++
 policy/modules/services/apache.if         |    8 +++++++
 policy/modules/services/apache.te         |    8 +++++++
 policy/modules/services/apcupsd.te        |    4 +++
 policy/modules/services/arpwatch.te       |    4 +++
 policy/modules/services/asterisk.te       |    4 +++
 policy/modules/services/automount.te      |    4 +++
 policy/modules/services/avahi.te          |    4 +++
 policy/modules/services/bind.te           |    4 +++
 policy/modules/services/bluetooth.te      |    4 +++
 policy/modules/services/canna.te          |    2 +
 policy/modules/services/ccs.te            |    4 +++
 policy/modules/services/cipe.te           |    2 +
 policy/modules/services/clamav.te         |    4 +++
 policy/modules/services/clockspeed.te     |    4 +++
 policy/modules/services/comsat.te         |    4 +++
 policy/modules/services/courier.if        |    4 +++
 policy/modules/services/cron.if           |    4 +++
 policy/modules/services/cron.te           |    4 +++
 policy/modules/services/cups.te           |   18 ++++++++++++++++
 policy/modules/services/cvs.te            |    4 +++
 policy/modules/services/cyrus.te          |    4 +++
 policy/modules/services/dante.te          |    4 +++
 policy/modules/services/dbskk.te          |    4 +++
 policy/modules/services/dbus.if           |    4 +++
 policy/modules/services/dcc.te            |   12 +++++++++++
 policy/modules/services/ddclient.te       |    4 +++
 policy/modules/services/dhcp.te           |    6 +++++
 policy/modules/services/dictd.te          |    6 +++++
 policy/modules/services/distcc.te         |    4 +++
 policy/modules/services/djbdns.if         |    4 +++
 policy/modules/services/dnsmasq.te        |    6 +++++
 policy/modules/services/dovecot.te        |    2 +
 policy/modules/services/fetchmail.te      |    4 +++
 policy/modules/services/finger.te         |    4 +++
 policy/modules/services/ftp.te            |    4 +++
 policy/modules/services/gatekeeper.te     |    4 +++
 policy/modules/services/hal.te            |    4 +++
 policy/modules/services/howl.te           |    4 +++
 policy/modules/services/i18n_input.te     |    4 +++
 policy/modules/services/imaze.te          |    4 +++
 policy/modules/services/inetd.te          |   13 +++++++-----
 policy/modules/services/inn.te            |    4 +++
 policy/modules/services/ircd.te           |    4 +++
 policy/modules/services/jabber.te         |    4 +++
 policy/modules/services/kerberos.if       |    4 +++
 policy/modules/services/kerberos.te       |    8 +++++++
 policy/modules/services/ktalk.te          |    4 +++
 policy/modules/services/ldap.te           |    4 +++
 policy/modules/services/lpd.if            |    4 +++
 policy/modules/services/lpd.te            |    8 +++++++
 policy/modules/services/mailman.if        |    4 +++
 policy/modules/services/monop.te          |    4 +++
 policy/modules/services/mta.if            |    2 +
 policy/modules/services/munin.te          |    4 +++
 policy/modules/services/mysql.te          |    4 +++
 policy/modules/services/nagios.te         |    4 +++
 policy/modules/services/nessus.te         |    6 +++++
 policy/modules/services/networkmanager.te |    6 +++++
 policy/modules/services/nis.if            |    4 +++
 policy/modules/services/nis.te            |   16 +++++++++++++++
 policy/modules/services/nscd.te           |    4 +++
 policy/modules/services/nsd.te            |    8 +++++++
 policy/modules/services/ntop.te           |    6 +++++
 policy/modules/services/nx.te             |    4 +++
 policy/modules/services/oav.te            |    8 +++++++
 policy/modules/services/openvpn.te        |    4 +++
 policy/modules/services/pcscd.te          |    4 ++-
 policy/modules/services/pegasus.te        |    2 +
 policy/modules/services/perdition.te      |    4 +++
 policy/modules/services/portmap.te        |   10 ++++++++-
 policy/modules/services/portslave.te      |    4 +++
 policy/modules/services/postfix.if        |    4 +++
 policy/modules/services/postfix.te        |    8 +++++++
 policy/modules/services/postgresql.te     |    4 +++
 policy/modules/services/postgrey.te       |    2 +
 policy/modules/services/ppp.te            |   12 +++++++++++
 policy/modules/services/privoxy.te        |    2 +
 policy/modules/services/procmail.te       |    4 +++
 policy/modules/services/pyzor.te          |    2 +
 policy/modules/services/qmail.te          |    4 +++
 policy/modules/services/radius.te         |    4 +++
 policy/modules/services/radvd.te          |    6 +++++
 policy/modules/services/razor.if          |    4 +++
 policy/modules/services/razor.te          |    4 +++
 policy/modules/services/rdisc.te          |    4 +++
 policy/modules/services/rhgb.te           |    4 +++
 policy/modules/services/ricci.te          |    4 +++
 policy/modules/services/rlogin.te         |    4 +++
 policy/modules/services/roundup.te        |    6 +++++
 policy/modules/services/rpc.if            |    4 +++
 policy/modules/services/rshd.te           |    4 +++
 policy/modules/services/rsync.te          |    4 +++
 policy/modules/services/rwho.te           |    2 +
 policy/modules/services/samba.te          |   32 ++++++++++++++++++++++++++----
 policy/modules/services/sasl.te           |    2 +
 policy/modules/services/sendmail.te       |    2 +
 policy/modules/services/setroubleshoot.te |    2 +
 policy/modules/services/smartmon.te       |    2 +
 policy/modules/services/snmp.te           |    4 +++
 policy/modules/services/snort.te          |    6 +++++
 policy/modules/services/soundserver.te    |    4 +++
 policy/modules/services/spamassassin.if   |    8 +++++++
 policy/modules/services/spamassassin.te   |    4 +++
 policy/modules/services/squid.te          |    4 +++
 policy/modules/services/ssh.if            |    8 ++++++-
 policy/modules/services/stunnel.te        |    4 +++
 policy/modules/services/tcpd.te           |    2 +
 policy/modules/services/telnet.te         |    4 +++
 policy/modules/services/tftp.te           |    4 +++
 policy/modules/services/timidity.te       |    4 +++
 policy/modules/services/tor.te            |    2 +
 policy/modules/services/transproxy.te     |    2 +
 policy/modules/services/ucspitcp.te       |   10 ++++++++-
 policy/modules/services/uucp.te           |    4 +++
 policy/modules/services/uwimap.te         |    2 +
 policy/modules/services/watchdog.te       |    4 +++
 policy/modules/services/xprint.te         |    4 +++
 policy/modules/services/xserver.if        |    4 +++
 policy/modules/services/xserver.te        |    4 +++
 policy/modules/services/zebra.te          |    6 +++++
 122 files changed, 604 insertions(+), 13 deletions(-)

Index: refpolicy_svn_repo/policy/modules/services/afs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/afs.te
+++ refpolicy_svn_repo/policy/modules/services/afs.te
@@ -89,6 +89,10 @@ domtrans_pattern(afs_bosserver_t, afs_vl
 
 kernel_read_kernel_sysctls(afs_bosserver_t)
 
+corenet_tcp_recv_unlabeled(afs_bosserver_t)
+corenet_udp_recv_unlabeled(afs_bosserver_t)
+corenet_tcp_recv_netlabel(afs_bosserver_t)
+corenet_udp_recv_netlabel(afs_bosserver_t)
 corenet_non_ipsec_sendrecv(afs_bosserver_t)
 corenet_tcp_sendrecv_generic_if(afs_bosserver_t)
 corenet_udp_sendrecv_generic_if(afs_bosserver_t)
@@ -153,6 +157,10 @@ corenet_tcp_sendrecv_all_nodes(afs_fsser
 corenet_udp_sendrecv_all_nodes(afs_fsserver_t)
 corenet_tcp_sendrecv_all_ports(afs_fsserver_t)
 corenet_udp_sendrecv_all_ports(afs_fsserver_t)
+corenet_tcp_recv_unlabeled(afs_fsserver_t)
+corenet_udp_recv_unlabeled(afs_fsserver_t)
+corenet_tcp_recv_netlabel(afs_fsserver_t)
+corenet_udp_recv_netlabel(afs_fsserver_t)
 corenet_non_ipsec_sendrecv(afs_fsserver_t)
 corenet_tcp_bind_all_nodes(afs_fsserver_t)
 corenet_udp_bind_all_nodes(afs_fsserver_t)
@@ -206,6 +214,10 @@ manage_files_pattern(afs_kaserver_t,afs_
 
 kernel_read_kernel_sysctls(afs_kaserver_t)
 
+corenet_tcp_recv_unlabeled(afs_kaserver_t)
+corenet_udp_recv_unlabeled(afs_kaserver_t)
+corenet_tcp_recv_netlabel(afs_kaserver_t)
+corenet_udp_recv_netlabel(afs_kaserver_t)
 corenet_non_ipsec_sendrecv(afs_kaserver_t)
 corenet_tcp_sendrecv_generic_if(afs_kaserver_t)
 corenet_udp_sendrecv_generic_if(afs_kaserver_t)
@@ -253,6 +265,10 @@ manage_files_pattern(afs_ptserver_t,afs_
 manage_files_pattern(afs_ptserver_t,afs_dbdir_t,afs_pt_db_t)
 filetrans_pattern(afs_ptserver_t,afs_dbdir_t,afs_pt_db_t,file)
 
+corenet_tcp_recv_unlabeled(afs_ptserver_t)
+corenet_udp_recv_unlabeled(afs_ptserver_t)
+corenet_tcp_recv_netlabel(afs_ptserver_t)
+corenet_udp_recv_netlabel(afs_ptserver_t)
 corenet_non_ipsec_sendrecv(afs_ptserver_t)
 corenet_tcp_sendrecv_generic_if(afs_ptserver_t)
 corenet_udp_sendrecv_generic_if(afs_ptserver_t)
@@ -294,6 +310,10 @@ manage_files_pattern(afs_vlserver_t,afs_
 manage_files_pattern(afs_vlserver_t,afs_dbdir_t,afs_vl_db_t)
 filetrans_pattern(afs_vlserver_t,afs_dbdir_t,afs_vl_db_t,file)
 
+corenet_tcp_recv_unlabeled(afs_vlserver_t)
+corenet_udp_recv_unlabeled(afs_vlserver_t)
+corenet_tcp_recv_netlabel(afs_vlserver_t)
+corenet_udp_recv_netlabel(afs_vlserver_t)
 corenet_non_ipsec_sendrecv(afs_vlserver_t)
 corenet_tcp_sendrecv_generic_if(afs_vlserver_t)
 corenet_udp_sendrecv_generic_if(afs_vlserver_t)
Index: refpolicy_svn_repo/policy/modules/services/amavis.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/amavis.te
+++ refpolicy_svn_repo/policy/modules/services/amavis.te
@@ -100,6 +100,10 @@ kernel_dontaudit_read_system_state(amavi
 # find perl
 corecmd_exec_bin(amavis_t)
 
+corenet_tcp_recv_unlabeled(amavis_t)
+corenet_udp_recv_unlabeled(amavis_t)
+corenet_tcp_recv_netlabel(amavis_t)
+corenet_udp_recv_netlabel(amavis_t)
 corenet_non_ipsec_sendrecv(amavis_t)
 corenet_tcp_sendrecv_all_if(amavis_t)
 corenet_tcp_sendrecv_all_nodes(amavis_t)
Index: refpolicy_svn_repo/policy/modules/services/apache.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/apache.if
+++ refpolicy_svn_repo/policy/modules/services/apache.if
@@ -181,6 +181,10 @@ template(`apache_content_template',`
 		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
 
+		corenet_tcp_recv_unlabeled(httpd_$1_script_t)
+		corenet_udp_recv_unlabeled(httpd_$1_script_t)
+		corenet_tcp_recv_netlabel(httpd_$1_script_t)
+		corenet_udp_recv_netlabel(httpd_$1_script_t)
 		corenet_non_ipsec_sendrecv(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
 		corenet_udp_sendrecv_all_if(httpd_$1_script_t)
@@ -200,6 +204,10 @@ template(`apache_content_template',`
 		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
 
+		corenet_tcp_recv_unlabeled(httpd_$1_script_t)
+		corenet_udp_recv_unlabeled(httpd_$1_script_t)
+		corenet_tcp_recv_netlabel(httpd_$1_script_t)
+		corenet_udp_recv_netlabel(httpd_$1_script_t)
 		corenet_non_ipsec_sendrecv(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
 		corenet_udp_sendrecv_all_if(httpd_$1_script_t)
Index: refpolicy_svn_repo/policy/modules/services/apache.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/apache.te
+++ refpolicy_svn_repo/policy/modules/services/apache.te
@@ -298,6 +298,10 @@ kernel_read_kernel_sysctls(httpd_t)
 # for modules that want to access /proc/meminfo
 kernel_read_system_state(httpd_t)
 
+corenet_tcp_recv_unlabeled(httpd_t)
+corenet_udp_recv_unlabeled(httpd_t)
+corenet_tcp_recv_netlabel(httpd_t)
+corenet_udp_recv_netlabel(httpd_t)
 corenet_non_ipsec_sendrecv(httpd_t)
 corenet_tcp_sendrecv_all_if(httpd_t)
 corenet_udp_sendrecv_all_if(httpd_t)
@@ -641,6 +645,10 @@ tunable_policy(`httpd_can_network_connec
 	allow httpd_suexec_t self:tcp_socket create_stream_socket_perms;
 	allow httpd_suexec_t self:udp_socket create_socket_perms;
 
+	corenet_tcp_recv_unlabeled(httpd_suexec_t)
+	corenet_udp_recv_unlabeled(httpd_suexec_t)
+	corenet_tcp_recv_netlabel(httpd_suexec_t)
+	corenet_udp_recv_netlabel(httpd_suexec_t)
 	corenet_non_ipsec_sendrecv(httpd_suexec_t)
 	corenet_tcp_sendrecv_all_if(httpd_suexec_t)
 	corenet_udp_sendrecv_all_if(httpd_suexec_t)
Index: refpolicy_svn_repo/policy/modules/services/apcupsd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/apcupsd.te
+++ refpolicy_svn_repo/policy/modules/services/apcupsd.te
@@ -39,6 +39,10 @@ logging_log_filetrans(apcupsd_t,apcupsd_
 manage_files_pattern(apcupsd_t,apcupsd_var_run_t,apcupsd_var_run_t)
 files_pid_filetrans(apcupsd_t,apcupsd_var_run_t, file)
 
+corenet_tcp_recv_unlabeled(apcupsd_t)
+corenet_udp_recv_unlabeled(apcupsd_t)
+corenet_tcp_recv_netlabel(apcupsd_t)
+corenet_udp_recv_netlabel(apcupsd_t)
 corenet_non_ipsec_sendrecv(apcupsd_t)
 corenet_tcp_sendrecv_generic_if(apcupsd_t)
 corenet_tcp_sendrecv_all_nodes(apcupsd_t)
Index: refpolicy_svn_repo/policy/modules/services/arpwatch.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/arpwatch.te
+++ refpolicy_svn_repo/policy/modules/services/arpwatch.te
@@ -47,6 +47,10 @@ kernel_read_kernel_sysctls(arpwatch_t)
 kernel_list_proc(arpwatch_t)
 kernel_read_proc_symlinks(arpwatch_t)
 
+corenet_tcp_recv_unlabeled(arpwatch_t)
+corenet_udp_recv_unlabeled(arpwatch_t)
+corenet_tcp_recv_netlabel(arpwatch_t)
+corenet_udp_recv_netlabel(arpwatch_t)
 corenet_non_ipsec_sendrecv(arpwatch_t)
 corenet_tcp_sendrecv_all_if(arpwatch_t)
 corenet_udp_sendrecv_all_if(arpwatch_t)
Index: refpolicy_svn_repo/policy/modules/services/asterisk.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/asterisk.te
+++ refpolicy_svn_repo/policy/modules/services/asterisk.te
@@ -82,6 +82,10 @@ kernel_read_kernel_sysctls(asterisk_t)
 corecmd_exec_bin(asterisk_t)
 corecmd_search_bin(asterisk_t)
 
+corenet_tcp_recv_unlabeled(asterisk_t)
+corenet_udp_recv_unlabeled(asterisk_t)
+corenet_tcp_recv_netlabel(asterisk_t)
+corenet_udp_recv_netlabel(asterisk_t)
 corenet_non_ipsec_sendrecv(asterisk_t)
 corenet_tcp_sendrecv_generic_if(asterisk_t)
 corenet_udp_sendrecv_generic_if(asterisk_t)
Index: refpolicy_svn_repo/policy/modules/services/automount.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/automount.te
+++ refpolicy_svn_repo/policy/modules/services/automount.te
@@ -76,6 +76,10 @@ fs_unmount_all_fs(automount_t)
 corecmd_exec_bin(automount_t)
 corecmd_exec_shell(automount_t)
 
+corenet_tcp_recv_unlabeled(automount_t)
+corenet_udp_recv_unlabeled(automount_t)
+corenet_tcp_recv_netlabel(automount_t)
+corenet_udp_recv_netlabel(automount_t)
 corenet_non_ipsec_sendrecv(automount_t)
 corenet_tcp_sendrecv_generic_if(automount_t)
 corenet_udp_sendrecv_generic_if(automount_t)
Index: refpolicy_svn_repo/policy/modules/services/avahi.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/avahi.te
+++ refpolicy_svn_repo/policy/modules/services/avahi.te
@@ -37,6 +37,10 @@ kernel_list_proc(avahi_t)
 kernel_read_proc_symlinks(avahi_t)
 kernel_read_network_state(avahi_t)
 
+corenet_tcp_recv_unlabeled(avahi_t)
+corenet_udp_recv_unlabeled(avahi_t)
+corenet_tcp_recv_netlabel(avahi_t)
+corenet_udp_recv_netlabel(avahi_t)
 corenet_non_ipsec_sendrecv(avahi_t)
 corenet_tcp_sendrecv_all_if(avahi_t)
 corenet_udp_sendrecv_all_if(avahi_t)
Index: refpolicy_svn_repo/policy/modules/services/bind.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/bind.te
+++ refpolicy_svn_repo/policy/modules/services/bind.te
@@ -101,6 +101,10 @@ kernel_read_kernel_sysctls(named_t)
 kernel_read_system_state(named_t)
 kernel_read_network_state(named_t)
 
+corenet_tcp_recv_unlabeled(named_t)
+corenet_udp_recv_unlabeled(named_t)
+corenet_tcp_recv_netlabel(named_t)
+corenet_udp_recv_netlabel(named_t)
 corenet_non_ipsec_sendrecv(named_t)
 corenet_tcp_sendrecv_all_if(named_t)
 corenet_udp_sendrecv_all_if(named_t)
Index: refpolicy_svn_repo/policy/modules/services/bluetooth.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/bluetooth.te
+++ refpolicy_svn_repo/policy/modules/services/bluetooth.te
@@ -81,6 +81,10 @@ files_pid_filetrans(bluetooth_t, bluetoo
 kernel_read_kernel_sysctls(bluetooth_t)
 kernel_read_system_state(bluetooth_t)
 
+corenet_tcp_recv_unlabeled(bluetooth_t)
+corenet_udp_recv_unlabeled(bluetooth_t)
+corenet_tcp_recv_netlabel(bluetooth_t)
+corenet_udp_recv_netlabel(bluetooth_t)
 corenet_non_ipsec_sendrecv(bluetooth_t)
 corenet_tcp_sendrecv_all_if(bluetooth_t)
 corenet_udp_sendrecv_all_if(bluetooth_t)
Index: refpolicy_svn_repo/policy/modules/services/canna.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/canna.te
+++ refpolicy_svn_repo/policy/modules/services/canna.te
@@ -47,6 +47,8 @@ files_pid_filetrans(canna_t, canna_var_r
 kernel_read_kernel_sysctls(canna_t)
 kernel_read_system_state(canna_t)
 
+corenet_tcp_recv_unlabeled(canna_t)
+corenet_tcp_recv_netlabel(canna_t)
 corenet_non_ipsec_sendrecv(canna_t)
 corenet_tcp_sendrecv_all_if(canna_t)
 corenet_tcp_sendrecv_all_nodes(canna_t)
Index: refpolicy_svn_repo/policy/modules/services/ccs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ccs.te
+++ refpolicy_svn_repo/policy/modules/services/ccs.te
@@ -77,6 +77,10 @@ kernel_read_kernel_sysctls(ccs_t)
 corecmd_list_bin(ccs_t)
 corecmd_exec_bin(ccs_t)
 
+corenet_tcp_recv_unlabeled(ccs_t)
+corenet_udp_recv_unlabeled(ccs_t)
+corenet_tcp_recv_netlabel(ccs_t)
+corenet_udp_recv_netlabel(ccs_t)
 corenet_non_ipsec_sendrecv(ccs_t)
 corenet_tcp_sendrecv_all_if(ccs_t)
 corenet_udp_sendrecv_all_if(ccs_t)
Index: refpolicy_svn_repo/policy/modules/services/cipe.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cipe.te
+++ refpolicy_svn_repo/policy/modules/services/cipe.te
@@ -29,6 +29,8 @@ kernel_read_system_state(ciped_t)
 corecmd_exec_shell(ciped_t)
 corecmd_exec_bin(ciped_t)
 
+corenet_udp_recv_unlabeled(ciped_t)
+corenet_udp_recv_netlabel(ciped_t)
 corenet_non_ipsec_sendrecv(ciped_t)
 corenet_udp_sendrecv_generic_if(ciped_t)
 corenet_udp_sendrecv_all_nodes(ciped_t)
Index: refpolicy_svn_repo/policy/modules/services/clamav.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/clamav.te
+++ refpolicy_svn_repo/policy/modules/services/clamav.te
@@ -86,6 +86,8 @@ files_pid_filetrans(clamd_t,clamd_var_ru
 kernel_dontaudit_list_proc(clamd_t)
 kernel_read_sysctl(clamd_t)
 
+corenet_tcp_recv_unlabeled(clamd_t)
+corenet_tcp_recv_netlabel(clamd_t)
 corenet_non_ipsec_sendrecv(clamd_t)
 corenet_tcp_sendrecv_all_if(clamd_t)
 corenet_tcp_sendrecv_all_nodes(clamd_t)
@@ -159,6 +161,8 @@ allow freshclam_t freshclam_var_log_t:di
 allow freshclam_t clamd_var_log_t:dir search_dir_perms;
 logging_log_filetrans(freshclam_t,freshclam_var_log_t,file)
 
+corenet_tcp_recv_unlabeled(freshclam_t)
+corenet_tcp_recv_netlabel(freshclam_t)
 corenet_non_ipsec_sendrecv(freshclam_t)
 corenet_tcp_sendrecv_all_if(freshclam_t)
 corenet_tcp_sendrecv_all_nodes(freshclam_t)
Index: refpolicy_svn_repo/policy/modules/services/clockspeed.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/clockspeed.te
+++ refpolicy_svn_repo/policy/modules/services/clockspeed.te
@@ -28,6 +28,8 @@ allow clockspeed_cli_t self:udp_socket c
 
 read_files_pattern(clockspeed_cli_t,clockspeed_var_lib_t,clockspeed_var_lib_t)
 
+corenet_udp_recv_unlabeled(clockspeed_cli_t)
+corenet_udp_recv_netlabel(clockspeed_cli_t)
 corenet_non_ipsec_sendrecv(clockspeed_cli_t)
 corenet_udp_sendrecv_generic_if(clockspeed_cli_t)
 corenet_udp_sendrecv_generic_node(clockspeed_cli_t)
@@ -55,6 +57,8 @@ allow clockspeed_srv_t self:unix_stream_
 manage_files_pattern(clockspeed_srv_t,clockspeed_var_lib_t,clockspeed_var_lib_t)
 manage_fifo_files_pattern(clockspeed_srv_t,clockspeed_var_lib_t,clockspeed_var_lib_t)
 
+corenet_udp_recv_unlabeled(clockspeed_srv_t)
+corenet_udp_recv_netlabel(clockspeed_srv_t)
 corenet_non_ipsec_sendrecv(clockspeed_srv_t)
 corenet_udp_sendrecv_generic_if(clockspeed_srv_t)
 corenet_udp_sendrecv_generic_node(clockspeed_srv_t)
Index: refpolicy_svn_repo/policy/modules/services/comsat.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/comsat.te
+++ refpolicy_svn_repo/policy/modules/services/comsat.te
@@ -40,6 +40,10 @@ kernel_read_kernel_sysctls(comsat_t)
 kernel_read_network_state(comsat_t)
 kernel_read_system_state(comsat_t)
 
+corenet_tcp_recv_unlabeled(comsat_t)
+corenet_udp_recv_unlabeled(comsat_t)
+corenet_tcp_recv_netlabel(comsat_t)
+corenet_udp_recv_netlabel(comsat_t)
 corenet_non_ipsec_sendrecv(comsat_t)
 corenet_tcp_sendrecv_all_if(comsat_t)
 corenet_udp_sendrecv_all_if(comsat_t)
Index: refpolicy_svn_repo/policy/modules/services/courier.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/courier.if
+++ refpolicy_svn_repo/policy/modules/services/courier.if
@@ -48,6 +48,10 @@ template(`courier_domain_template',`
 
 	corecmd_exec_bin(courier_$1_t)
 
+	corenet_tcp_recv_unlabeled(courier_$1_t)
+	corenet_udp_recv_unlabeled(courier_$1_t)
+	corenet_tcp_recv_netlabel(courier_$1_t)
+	corenet_udp_recv_netlabel(courier_$1_t)
 	corenet_non_ipsec_sendrecv(courier_$1_t)
 	corenet_tcp_sendrecv_generic_if(courier_$1_t)
 	corenet_udp_sendrecv_generic_if(courier_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/cron.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cron.if
+++ refpolicy_svn_repo/policy/modules/services/cron.if
@@ -94,6 +94,10 @@ template(`cron_per_role_template',`
 	# ps does not need to access /boot when run from cron
 	files_dontaudit_search_boot($1_crond_t)
 
+	corenet_tcp_recv_unlabeled($1_crond_t)
+	corenet_udp_recv_unlabeled($1_crond_t)
+	corenet_tcp_recv_netlabel($1_crond_t)
+	corenet_udp_recv_netlabel($1_crond_t)
 	corenet_non_ipsec_sendrecv($1_crond_t)
 	corenet_tcp_sendrecv_all_if($1_crond_t)
 	corenet_udp_sendrecv_all_if($1_crond_t)
Index: refpolicy_svn_repo/policy/modules/services/cron.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cron.te
+++ refpolicy_svn_repo/policy/modules/services/cron.te
@@ -327,6 +327,10 @@ ifdef(`targeted_policy',`
 
 	corecmd_exec_all_executables(system_crond_t)
 
+	corenet_tcp_recv_unlabeled(system_crond_t)
+	corenet_udp_recv_unlabeled(system_crond_t)
+	corenet_tcp_recv_netlabel(system_crond_t)
+	corenet_udp_recv_netlabel(system_crond_t)
 	corenet_non_ipsec_sendrecv(system_crond_t)
 	corenet_tcp_sendrecv_all_if(system_crond_t)
 	corenet_udp_sendrecv_all_if(system_crond_t)
Index: refpolicy_svn_repo/policy/modules/services/cups.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cups.te
+++ refpolicy_svn_repo/policy/modules/services/cups.te
@@ -133,6 +133,12 @@ kernel_read_system_state(cupsd_t)
 kernel_read_network_state(cupsd_t)
 kernel_read_all_sysctls(cupsd_t)
 
+corenet_tcp_recv_unlabeled(cupsd_t)
+corenet_udp_recv_unlabeled(cupsd_t)
+corenet_raw_recv_unlabeled(cupsd_t)
+corenet_tcp_recv_netlabel(cupsd_t)
+corenet_udp_recv_netlabel(cupsd_t)
+corenet_raw_recv_unlabeled(cupsd_t)
 corenet_non_ipsec_sendrecv(cupsd_t)
 corenet_tcp_sendrecv_all_if(cupsd_t)
 corenet_udp_sendrecv_all_if(cupsd_t)
@@ -340,6 +346,8 @@ files_pid_filetrans(cupsd_config_t,cupsd
 kernel_read_system_state(cupsd_config_t)
 kernel_read_kernel_sysctls(cupsd_config_t)
 
+corenet_tcp_recv_unlabeled(cupsd_config_t)
+corenet_tcp_recv_netlabel(cupsd_config_t)
 corenet_non_ipsec_sendrecv(cupsd_config_t)
 corenet_tcp_sendrecv_all_if(cupsd_config_t)
 corenet_tcp_sendrecv_all_nodes(cupsd_config_t)
@@ -491,6 +499,10 @@ kernel_read_kernel_sysctls(cupsd_lpd_t)
 kernel_read_system_state(cupsd_lpd_t)
 kernel_read_network_state(cupsd_lpd_t)
 
+corenet_tcp_recv_unlabeled(cupsd_lpd_t)
+corenet_udp_recv_unlabeled(cupsd_lpd_t)
+corenet_tcp_recv_netlabel(cupsd_lpd_t)
+corenet_udp_recv_netlabel(cupsd_lpd_t)
 corenet_non_ipsec_sendrecv(cupsd_lpd_t)
 corenet_tcp_sendrecv_all_if(cupsd_lpd_t)
 corenet_udp_sendrecv_all_if(cupsd_lpd_t)
@@ -564,6 +576,10 @@ files_pid_filetrans(hplip_t,hplip_var_ru
 kernel_read_system_state(hplip_t)
 kernel_read_kernel_sysctls(hplip_t)
 
+corenet_tcp_recv_unlabeled(hplip_t)
+corenet_udp_recv_unlabeled(hplip_t)
+corenet_tcp_recv_netlabel(hplip_t)
+corenet_udp_recv_netlabel(hplip_t)
 corenet_non_ipsec_sendrecv(hplip_t)
 corenet_tcp_sendrecv_all_if(hplip_t)
 corenet_udp_sendrecv_all_if(hplip_t)
@@ -661,6 +677,8 @@ kernel_read_kernel_sysctls(ptal_t)
 kernel_list_proc(ptal_t)
 kernel_read_proc_symlinks(ptal_t)
 
+corenet_tcp_recv_unlabeled(ptal_t)
+corenet_tcp_recv_netlabel(ptal_t)
 corenet_non_ipsec_sendrecv(ptal_t)
 corenet_tcp_sendrecv_all_if(ptal_t)
 corenet_tcp_sendrecv_all_nodes(ptal_t)
Index: refpolicy_svn_repo/policy/modules/services/cvs.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cvs.te
+++ refpolicy_svn_repo/policy/modules/services/cvs.te
@@ -54,6 +54,10 @@ kernel_read_kernel_sysctls(cvs_t)
 kernel_read_system_state(cvs_t)
 kernel_read_network_state(cvs_t)
 
+corenet_tcp_recv_unlabeled(cvs_t)
+corenet_udp_recv_unlabeled(cvs_t)
+corenet_tcp_recv_netlabel(cvs_t)
+corenet_udp_recv_netlabel(cvs_t)
 corenet_non_ipsec_sendrecv(cvs_t)
 corenet_tcp_sendrecv_all_if(cvs_t)
 corenet_udp_sendrecv_all_if(cvs_t)
Index: refpolicy_svn_repo/policy/modules/services/cyrus.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/cyrus.te
+++ refpolicy_svn_repo/policy/modules/services/cyrus.te
@@ -61,6 +61,10 @@ kernel_read_kernel_sysctls(cyrus_t)
 kernel_read_system_state(cyrus_t)
 kernel_read_all_sysctls(cyrus_t)
 
+corenet_tcp_recv_unlabeled(cyrus_t)
+corenet_udp_recv_unlabeled(cyrus_t)
+corenet_tcp_recv_netlabel(cyrus_t)
+corenet_udp_recv_netlabel(cyrus_t)
 corenet_non_ipsec_sendrecv(cyrus_t)
 corenet_tcp_sendrecv_all_if(cyrus_t)
 corenet_udp_sendrecv_all_if(cyrus_t)
Index: refpolicy_svn_repo/policy/modules/services/dante.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dante.te
+++ refpolicy_svn_repo/policy/modules/services/dante.te
@@ -38,6 +38,10 @@ kernel_read_kernel_sysctls(dante_t)
 kernel_list_proc(dante_t)
 kernel_read_proc_symlinks(dante_t)
 
+corenet_tcp_recv_unlabeled(dante_t)
+corenet_udp_recv_unlabeled(dante_t)
+corenet_tcp_recv_netlabel(dante_t)
+corenet_udp_recv_netlabel(dante_t)
 corenet_non_ipsec_sendrecv(dante_t)
 corenet_tcp_sendrecv_generic_if(dante_t)
 corenet_udp_sendrecv_generic_if(dante_t)
Index: refpolicy_svn_repo/policy/modules/services/dbskk.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dbskk.te
+++ refpolicy_svn_repo/policy/modules/services/dbskk.te
@@ -48,6 +48,10 @@ kernel_read_kernel_sysctls(dbskkd_t)
 kernel_read_system_state(dbskkd_t)
 kernel_read_network_state(dbskkd_t)
 
+corenet_tcp_recv_unlabeled(dbskkd_t)
+corenet_udp_recv_unlabeled(dbskkd_t)
+corenet_tcp_recv_netlabel(dbskkd_t)
+corenet_udp_recv_netlabel(dbskkd_t)
 corenet_non_ipsec_sendrecv(dbskkd_t)
 corenet_tcp_sendrecv_all_if(dbskkd_t)
 corenet_udp_sendrecv_all_if(dbskkd_t)
Index: refpolicy_svn_repo/policy/modules/services/dbus.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dbus.if
+++ refpolicy_svn_repo/policy/modules/services/dbus.if
@@ -107,6 +107,10 @@ template(`dbus_per_role_template',`
 	corecmd_read_bin_pipes($1_dbusd_t)
 	corecmd_read_bin_sockets($1_dbusd_t)
 
+	corenet_tcp_recv_unlabeled($1_dbusd_t)
+	corenet_udp_recv_unlabeled($1_dbusd_t)
+	corenet_tcp_recv_netlabel($1_dbusd_t)
+	corenet_udp_recv_netlabel($1_dbusd_t)
 	corenet_non_ipsec_sendrecv($1_dbusd_t)
 	corenet_tcp_sendrecv_all_if($1_dbusd_t)
 	corenet_tcp_sendrecv_all_nodes($1_dbusd_t)
Index: refpolicy_svn_repo/policy/modules/services/dcc.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dcc.te
+++ refpolicy_svn_repo/policy/modules/services/dcc.te
@@ -99,6 +99,8 @@ allow cdcc_t dcc_var_t:dir list_dir_perm
 read_files_pattern(cdcc_t,dcc_var_t,dcc_var_t)
 read_lnk_files_pattern(cdcc_t,dcc_var_t,dcc_var_t)
 
+corenet_udp_recv_unlabeled(cdcc_t)
+corenet_udp_recv_netlabel(cdcc_t)
 corenet_non_ipsec_sendrecv(cdcc_t)
 corenet_udp_sendrecv_generic_if(cdcc_t)
 corenet_udp_sendrecv_all_nodes(cdcc_t)
@@ -141,6 +143,8 @@ allow dcc_client_t dcc_var_t:dir list_di
 read_files_pattern(dcc_client_t,dcc_var_t,dcc_var_t)
 read_lnk_files_pattern(dcc_client_t,dcc_var_t,dcc_var_t)
 
+corenet_udp_recv_unlabeled(dcc_client_t)
+corenet_udp_recv_netlabel(dcc_client_t)
 corenet_non_ipsec_sendrecv(dcc_client_t)
 corenet_udp_sendrecv_generic_if(dcc_client_t)
 corenet_udp_sendrecv_all_nodes(dcc_client_t)
@@ -183,6 +187,8 @@ manage_lnk_files_pattern(dcc_dbclean_t,d
 
 kernel_read_system_state(dcc_dbclean_t)
 
+corenet_udp_recv_unlabeled(dcc_dbclean_t)
+corenet_udp_recv_netlabel(dcc_dbclean_t)
 corenet_non_ipsec_sendrecv(dcc_dbclean_t)
 corenet_udp_sendrecv_generic_if(dcc_dbclean_t)
 corenet_udp_sendrecv_all_nodes(dcc_dbclean_t)
@@ -243,6 +249,8 @@ files_pid_filetrans(dccd_t,dccd_var_run_
 kernel_read_system_state(dccd_t)
 kernel_read_kernel_sysctls(dccd_t)
 
+corenet_udp_recv_unlabeled(dccd_t)
+corenet_udp_recv_netlabel(dccd_t)
 corenet_non_ipsec_sendrecv(dccd_t)
 corenet_udp_sendrecv_generic_if(dccd_t)
 corenet_udp_sendrecv_all_nodes(dccd_t)
@@ -324,6 +332,8 @@ files_pid_filetrans(dccifd_t,dccifd_var_
 kernel_read_system_state(dccifd_t)
 kernel_read_kernel_sysctls(dccifd_t)
 
+corenet_udp_recv_unlabeled(dccifd_t)
+corenet_udp_recv_netlabel(dccifd_t)
 corenet_non_ipsec_sendrecv(dccifd_t)
 corenet_udp_sendrecv_generic_if(dccifd_t)
 corenet_udp_sendrecv_all_nodes(dccifd_t)
@@ -401,6 +411,8 @@ files_pid_filetrans(dccm_t,dccm_var_run_
 kernel_read_system_state(dccm_t)
 kernel_read_kernel_sysctls(dccm_t)
 
+corenet_udp_recv_unlabeled(dccm_t)
+corenet_udp_recv_netlabel(dccm_t)
 corenet_non_ipsec_sendrecv(dccm_t)
 corenet_udp_sendrecv_generic_if(dccm_t)
 corenet_udp_sendrecv_all_nodes(dccm_t)
Index: refpolicy_svn_repo/policy/modules/services/ddclient.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ddclient.te
+++ refpolicy_svn_repo/policy/modules/services/ddclient.te
@@ -64,6 +64,10 @@ kernel_read_kernel_sysctls(ddclient_t)
 corecmd_exec_shell(ddclient_t)
 corecmd_exec_bin(ddclient_t)
 
+corenet_tcp_recv_unlabeled(ddclient_t)
+corenet_udp_recv_unlabeled(ddclient_t)
+corenet_tcp_recv_netlabel(ddclient_t)
+corenet_udp_recv_netlabel(ddclient_t)
 corenet_non_ipsec_sendrecv(ddclient_t)
 corenet_tcp_sendrecv_generic_if(ddclient_t)
 corenet_udp_sendrecv_generic_if(ddclient_t)
Index: refpolicy_svn_repo/policy/modules/services/dhcp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dhcp.te
+++ refpolicy_svn_repo/policy/modules/services/dhcp.te
@@ -52,6 +52,12 @@ files_pid_filetrans(dhcpd_t,dhcpd_var_ru
 kernel_read_system_state(dhcpd_t)
 kernel_read_kernel_sysctls(dhcpd_t)
 
+corenet_tcp_recv_unlabeled(dhcpd_t)
+corenet_udp_recv_unlabeled(dhcpd_t)
+corenet_raw_recv_unlabeled(dhcpd_t)
+corenet_tcp_recv_netlabel(dhcpd_t)
+corenet_udp_recv_netlabel(dhcpd_t)
+corenet_raw_recv_netlabel(dhcpd_t)
 corenet_non_ipsec_sendrecv(dhcpd_t)
 corenet_tcp_sendrecv_all_if(dhcpd_t)
 corenet_udp_sendrecv_all_if(dhcpd_t)
Index: refpolicy_svn_repo/policy/modules/services/dictd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dictd.te
+++ refpolicy_svn_repo/policy/modules/services/dictd.te
@@ -37,6 +37,12 @@ allow dictd_t dictd_var_lib_t:file read_
 kernel_read_system_state(dictd_t)
 kernel_read_kernel_sysctls(dictd_t)
 
+corenet_tcp_recv_unlabeled(dictd_t)
+corenet_udp_recv_unlabeled(dictd_t)
+corenet_raw_recv_unlabeled(dictd_t)
+corenet_tcp_recv_netlabel(dictd_t)
+corenet_udp_recv_netlabel(dictd_t)
+corenet_raw_recv_netlabel(dictd_t)
 corenet_non_ipsec_sendrecv(dictd_t)
 corenet_tcp_sendrecv_all_if(dictd_t)
 corenet_raw_sendrecv_all_if(dictd_t)
Index: refpolicy_svn_repo/policy/modules/services/distcc.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/distcc.te
+++ refpolicy_svn_repo/policy/modules/services/distcc.te
@@ -44,6 +44,10 @@ files_pid_filetrans(distccd_t,distccd_va
 kernel_read_system_state(distccd_t)
 kernel_read_kernel_sysctls(distccd_t)
 
+corenet_tcp_recv_unlabeled(distccd_t)
+corenet_udp_recv_unlabeled(distccd_t)
+corenet_tcp_recv_netlabel(distccd_t)
+corenet_udp_recv_netlabel(distccd_t)
 corenet_non_ipsec_sendrecv(distccd_t)
 corenet_tcp_sendrecv_all_if(distccd_t)
 corenet_udp_sendrecv_all_if(distccd_t)
Index: refpolicy_svn_repo/policy/modules/services/djbdns.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/djbdns.if
+++ refpolicy_svn_repo/policy/modules/services/djbdns.if
@@ -32,6 +32,10 @@ template(`djbdns_daemontools_domain_temp
 	allow djbdns_$1_t djbdns_$1_conf_t:dir list_dir_perms;
 	allow djbdns_$1_t djbdns_$1_conf_t:file read_file_perms;
 
+	corenet_tcp_recv_unlabeled(djbdns_$1_t)
+	corenet_udp_recv_unlabeled(djbdns_$1_t)
+	corenet_tcp_recv_netlabel(djbdns_$1_t)
+	corenet_udp_recv_netlabel(djbdns_$1_t)
 	corenet_non_ipsec_sendrecv(djbdns_$1_t)
 	corenet_tcp_sendrecv_all_if(djbdns_$1_t)
 	corenet_udp_sendrecv_all_if(djbdns_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/dnsmasq.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dnsmasq.te
+++ refpolicy_svn_repo/policy/modules/services/dnsmasq.te
@@ -42,6 +42,12 @@ kernel_read_kernel_sysctls(dnsmasq_t)
 kernel_list_proc(dnsmasq_t)
 kernel_read_proc_symlinks(dnsmasq_t)
 
+corenet_tcp_recv_unlabeled(dnsmasq_t)
+corenet_udp_recv_unlabeled(dnsmasq_t)
+corenet_raw_recv_unlabeled(dnsmasq_t)
+corenet_tcp_recv_netlabel(dnsmasq_t)
+corenet_udp_recv_netlabel(dnsmasq_t)
+corenet_raw_recv_netlabel(dnsmasq_t)
 corenet_non_ipsec_sendrecv(dnsmasq_t)
 corenet_tcp_sendrecv_generic_if(dnsmasq_t)
 corenet_udp_sendrecv_generic_if(dnsmasq_t)
Index: refpolicy_svn_repo/policy/modules/services/dovecot.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/dovecot.te
+++ refpolicy_svn_repo/policy/modules/services/dovecot.te
@@ -70,6 +70,8 @@ files_pid_filetrans(dovecot_t,dovecot_va
 kernel_read_kernel_sysctls(dovecot_t)
 kernel_read_system_state(dovecot_t)
 
+corenet_tcp_recv_unlabeled(dovecot_t)
+corenet_tcp_recv_netlabel(dovecot_t)
 corenet_non_ipsec_sendrecv(dovecot_t)
 corenet_tcp_sendrecv_all_if(dovecot_t)
 corenet_tcp_sendrecv_all_nodes(dovecot_t)
Index: refpolicy_svn_repo/policy/modules/services/fetchmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/fetchmail.te
+++ refpolicy_svn_repo/policy/modules/services/fetchmail.te
@@ -46,6 +46,10 @@ kernel_getattr_proc_files(fetchmail_t)
 kernel_read_proc_symlinks(fetchmail_t)
 kernel_dontaudit_read_system_state(fetchmail_t)
 
+corenet_tcp_recv_unlabeled(fetchmail_t)
+corenet_udp_recv_unlabeled(fetchmail_t)
+corenet_tcp_recv_netlabel(fetchmail_t)
+corenet_udp_recv_netlabel(fetchmail_t)
 corenet_non_ipsec_sendrecv(fetchmail_t)
 corenet_tcp_sendrecv_generic_if(fetchmail_t)
 corenet_udp_sendrecv_generic_if(fetchmail_t)
Index: refpolicy_svn_repo/policy/modules/services/finger.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/finger.te
+++ refpolicy_svn_repo/policy/modules/services/finger.te
@@ -47,6 +47,10 @@ logging_log_filetrans(fingerd_t,fingerd_
 kernel_read_kernel_sysctls(fingerd_t)
 kernel_read_system_state(fingerd_t)
 
+corenet_tcp_recv_unlabeled(fingerd_t)
+corenet_udp_recv_unlabeled(fingerd_t)
+corenet_tcp_recv_netlabel(fingerd_t)
+corenet_udp_recv_netlabel(fingerd_t)
 corenet_non_ipsec_sendrecv(fingerd_t)
 corenet_tcp_sendrecv_all_if(fingerd_t)
 corenet_udp_sendrecv_all_if(fingerd_t)
Index: refpolicy_svn_repo/policy/modules/services/ftp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ftp.te
+++ refpolicy_svn_repo/policy/modules/services/ftp.te
@@ -128,6 +128,10 @@ dev_read_urand(ftpd_t)
 
 corecmd_exec_bin(ftpd_t)
 
+corenet_tcp_recv_unlabeled(ftpd_t)
+corenet_udp_recv_unlabeled(ftpd_t)
+corenet_tcp_recv_netlabel(ftpd_t)
+corenet_udp_recv_netlabel(ftpd_t)
 corenet_non_ipsec_sendrecv(ftpd_t)
 corenet_tcp_sendrecv_all_if(ftpd_t)
 corenet_udp_sendrecv_all_if(ftpd_t)
Index: refpolicy_svn_repo/policy/modules/services/gatekeeper.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/gatekeeper.te
+++ refpolicy_svn_repo/policy/modules/services/gatekeeper.te
@@ -53,6 +53,10 @@ kernel_read_kernel_sysctls(gatekeeper_t)
 
 corecmd_list_bin(gatekeeper_t)
 
+corenet_tcp_recv_unlabeled(gatekeeper_t)
+corenet_udp_recv_unlabeled(gatekeeper_t)
+corenet_tcp_recv_netlabel(gatekeeper_t)
+corenet_udp_recv_netlabel(gatekeeper_t)
 corenet_non_ipsec_sendrecv(gatekeeper_t)
 corenet_tcp_sendrecv_generic_if(gatekeeper_t)
 corenet_udp_sendrecv_generic_if(gatekeeper_t)
Index: refpolicy_svn_repo/policy/modules/services/hal.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/hal.te
+++ refpolicy_svn_repo/policy/modules/services/hal.te
@@ -91,6 +91,10 @@ auth_read_pam_console_data(hald_t)
 
 corecmd_exec_all_executables(hald_t)
 
+corenet_tcp_recv_unlabeled(hald_t)
+corenet_udp_recv_unlabeled(hald_t)
+corenet_tcp_recv_netlabel(hald_t)
+corenet_udp_recv_netlabel(hald_t)
 corenet_non_ipsec_sendrecv(hald_t)
 corenet_tcp_sendrecv_all_if(hald_t)
 corenet_udp_sendrecv_all_if(hald_t)
Index: refpolicy_svn_repo/policy/modules/services/howl.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/howl.te
+++ refpolicy_svn_repo/policy/modules/services/howl.te
@@ -34,6 +34,10 @@ kernel_load_module(howl_t)
 kernel_list_proc(howl_t)
 kernel_read_proc_symlinks(howl_t)
 
+corenet_tcp_recv_unlabeled(howl_t)
+corenet_udp_recv_unlabeled(howl_t)
+corenet_tcp_recv_netlabel(howl_t)
+corenet_udp_recv_netlabel(howl_t)
 corenet_non_ipsec_sendrecv(howl_t)
 corenet_tcp_sendrecv_all_if(howl_t)
 corenet_udp_sendrecv_all_if(howl_t)
Index: refpolicy_svn_repo/policy/modules/services/i18n_input.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/i18n_input.te
+++ refpolicy_svn_repo/policy/modules/services/i18n_input.te
@@ -37,6 +37,10 @@ can_exec(i18n_input_t, i18n_input_exec_t
 kernel_read_kernel_sysctls(i18n_input_t)
 kernel_read_system_state(i18n_input_t)
 
+corenet_tcp_recv_unlabeled(i18n_input_t)
+corenet_udp_recv_unlabeled(i18n_input_t)
+corenet_tcp_recv_netlabel(i18n_input_t)
+corenet_udp_recv_netlabel(i18n_input_t)
 corenet_non_ipsec_sendrecv(i18n_input_t)
 corenet_tcp_sendrecv_generic_if(i18n_input_t)
 corenet_udp_sendrecv_generic_if(i18n_input_t)
Index: refpolicy_svn_repo/policy/modules/services/imaze.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/imaze.te
+++ refpolicy_svn_repo/policy/modules/services/imaze.te
@@ -55,6 +55,10 @@ kernel_read_kernel_sysctls(imazesrv_t)
 kernel_list_proc(imazesrv_t)
 kernel_read_proc_symlinks(imazesrv_t)
 
+corenet_tcp_recv_unlabeled(imazesrv_t)
+corenet_udp_recv_unlabeled(imazesrv_t)
+corenet_tcp_recv_netlabel(imazesrv_t)
+corenet_udp_recv_netlabel(imazesrv_t)
 corenet_non_ipsec_sendrecv(imazesrv_t)
 corenet_tcp_sendrecv_generic_if(imazesrv_t)
 corenet_udp_sendrecv_generic_if(imazesrv_t)
Index: refpolicy_svn_repo/policy/modules/services/inetd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/inetd.te
+++ refpolicy_svn_repo/policy/modules/services/inetd.te
@@ -60,6 +60,10 @@ kernel_read_system_state(inetd_t)
 kernel_tcp_recvfrom_unlabeled(inetd_t)
 
 # base networking:
+corenet_tcp_recv_unlabeled(inetd_t)
+corenet_udp_recv_unlabeled(inetd_t)
+corenet_tcp_recv_netlabel(inetd_t)
+corenet_udp_recv_netlabel(inetd_t)
 corenet_non_ipsec_sendrecv(inetd_t)
 corenet_tcp_sendrecv_all_if(inetd_t)
 corenet_udp_sendrecv_all_if(inetd_t)
@@ -143,11 +147,6 @@ sysnet_read_config(inetd_t)
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
@@ -200,6 +199,10 @@ kernel_read_kernel_sysctls(inetd_child_t
 kernel_read_system_state(inetd_child_t)
 kernel_read_network_state(inetd_child_t)
 
+corenet_tcp_recv_unlabeled(inetd_child_t)
+corenet_udp_recv_unlabeled(inetd_child_t)
+corenet_tcp_recv_netlabel(inetd_child_t)
+corenet_udp_recv_netlabel(inetd_child_t)
 corenet_non_ipsec_sendrecv(inetd_child_t)
 corenet_tcp_sendrecv_all_if(inetd_child_t)
 corenet_udp_sendrecv_all_if(inetd_child_t)
Index: refpolicy_svn_repo/policy/modules/services/inn.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/inn.te
+++ refpolicy_svn_repo/policy/modules/services/inn.te
@@ -63,6 +63,10 @@ manage_lnk_files_pattern(innd_t,news_spo
 kernel_read_kernel_sysctls(innd_t)
 kernel_read_system_state(innd_t)
 
+corenet_tcp_recv_unlabeled(innd_t)
+corenet_udp_recv_unlabeled(innd_t)
+corenet_tcp_recv_netlabel(innd_t)
+corenet_udp_recv_netlabel(innd_t)
 corenet_non_ipsec_sendrecv(innd_t)
 corenet_tcp_sendrecv_all_if(innd_t)
 corenet_udp_sendrecv_all_if(innd_t)
Index: refpolicy_svn_repo/policy/modules/services/ircd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ircd.te
+++ refpolicy_svn_repo/policy/modules/services/ircd.te
@@ -50,6 +50,10 @@ kernel_read_kernel_sysctls(ircd_t)
 
 corecmd_search_bin(ircd_t)
 
+corenet_tcp_recv_unlabeled(ircd_t)
+corenet_udp_recv_unlabeled(ircd_t)
+corenet_tcp_recv_netlabel(ircd_t)
+corenet_udp_recv_netlabel(ircd_t)
 corenet_non_ipsec_sendrecv(ircd_t)
 corenet_tcp_sendrecv_generic_if(ircd_t)
 corenet_udp_sendrecv_generic_if(ircd_t)
Index: refpolicy_svn_repo/policy/modules/services/jabber.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/jabber.te
+++ refpolicy_svn_repo/policy/modules/services/jabber.te
@@ -44,6 +44,10 @@ kernel_read_kernel_sysctls(jabberd_t)
 kernel_list_proc(jabberd_t)
 kernel_read_proc_symlinks(jabberd_t)
 
+corenet_tcp_recv_unlabeled(jabberd_t)
+corenet_udp_recv_unlabeled(jabberd_t)
+corenet_tcp_recv_netlabel(jabberd_t)
+corenet_udp_recv_netlabel(jabberd_t)
 corenet_non_ipsec_sendrecv(jabberd_t)
 corenet_tcp_sendrecv_generic_if(jabberd_t)
 corenet_udp_sendrecv_generic_if(jabberd_t)
Index: refpolicy_svn_repo/policy/modules/services/kerberos.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/kerberos.if
+++ refpolicy_svn_repo/policy/modules/services/kerberos.if
@@ -47,6 +47,10 @@ interface(`kerberos_use',`
 		allow $1 self:tcp_socket create_socket_perms;
 		allow $1 self:udp_socket create_socket_perms;
 
+		corenet_tcp_recv_unlabeled($1)
+		corenet_udp_recv_unlabeled($1)
+		corenet_tcp_recv_netlabel($1)
+		corenet_udp_recv_netlabel($1)
 		corenet_non_ipsec_sendrecv($1)
 		corenet_tcp_sendrecv_all_if($1)
 		corenet_udp_sendrecv_all_if($1)
Index: refpolicy_svn_repo/policy/modules/services/kerberos.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/kerberos.te
+++ refpolicy_svn_repo/policy/modules/services/kerberos.te
@@ -92,6 +92,10 @@ kernel_read_kernel_sysctls(kadmind_t)
 kernel_list_proc(kadmind_t)
 kernel_read_proc_symlinks(kadmind_t)
 
+corenet_tcp_recv_unlabeled(kadmind_t)
+corenet_udp_recv_unlabeled(kadmind_t)
+corenet_tcp_recv_netlabel(kadmind_t)
+corenet_udp_recv_netlabel(kadmind_t)
 corenet_non_ipsec_sendrecv(kadmind_t)
 corenet_tcp_sendrecv_all_if(kadmind_t)
 corenet_udp_sendrecv_all_if(kadmind_t)
@@ -192,6 +196,10 @@ kernel_search_network_sysctl(krb5kdc_t)
 
 corecmd_exec_bin(krb5kdc_t)
 
+corenet_tcp_recv_unlabeled(krb5kdc_t)
+corenet_udp_recv_unlabeled(krb5kdc_t)
+corenet_tcp_recv_netlabel(krb5kdc_t)
+corenet_udp_recv_netlabel(krb5kdc_t)
 corenet_non_ipsec_sendrecv(krb5kdc_t)
 corenet_tcp_sendrecv_all_if(krb5kdc_t)
 corenet_udp_sendrecv_all_if(krb5kdc_t)
Index: refpolicy_svn_repo/policy/modules/services/ktalk.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ktalk.te
+++ refpolicy_svn_repo/policy/modules/services/ktalk.te
@@ -53,6 +53,10 @@ kernel_read_kernel_sysctls(ktalkd_t)
 kernel_read_system_state(ktalkd_t)
 kernel_read_network_state(ktalkd_t)
 
+corenet_tcp_recv_unlabeled(ktalkd_t)
+corenet_udp_recv_unlabeled(ktalkd_t)
+corenet_tcp_recv_netlabel(ktalkd_t)
+corenet_udp_recv_netlabel(ktalkd_t)
 corenet_non_ipsec_sendrecv(ktalkd_t)
 corenet_tcp_sendrecv_all_if(ktalkd_t)
 corenet_udp_sendrecv_all_if(ktalkd_t)
Index: refpolicy_svn_repo/policy/modules/services/ldap.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ldap.te
+++ refpolicy_svn_repo/policy/modules/services/ldap.te
@@ -77,6 +77,10 @@ files_pid_filetrans(slapd_t,slapd_var_ru
 kernel_read_system_state(slapd_t)
 kernel_read_kernel_sysctls(slapd_t)
 
+corenet_tcp_recv_unlabeled(slapd_t)
+corenet_udp_recv_unlabeled(slapd_t)
+corenet_tcp_recv_netlabel(slapd_t)
+corenet_udp_recv_netlabel(slapd_t)
 corenet_non_ipsec_sendrecv(slapd_t)
 corenet_tcp_sendrecv_all_if(slapd_t)
 corenet_udp_sendrecv_all_if(slapd_t)
Index: refpolicy_svn_repo/policy/modules/services/lpd.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/lpd.if
+++ refpolicy_svn_repo/policy/modules/services/lpd.if
@@ -104,6 +104,10 @@ template(`lpd_per_role_template',`
 
 	kernel_read_kernel_sysctls($1_lpr_t)
 
+	corenet_tcp_recv_unlabeled($1_lpr_t)
+	corenet_udp_recv_unlabeled($1_lpr_t)
+	corenet_tcp_recv_netlabel($1_lpr_t)
+	corenet_udp_recv_netlabel($1_lpr_t)
 	corenet_non_ipsec_sendrecv($1_lpr_t)
 	corenet_tcp_sendrecv_generic_if($1_lpr_t)
 	corenet_udp_sendrecv_generic_if($1_lpr_t)
Index: refpolicy_svn_repo/policy/modules/services/lpd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/lpd.te
+++ refpolicy_svn_repo/policy/modules/services/lpd.te
@@ -72,6 +72,10 @@ allow checkpc_t printconf_t:dir { getatt
 
 kernel_read_system_state(checkpc_t)
 
+corenet_tcp_recv_unlabeled(checkpc_t)
+corenet_udp_recv_unlabeled(checkpc_t)
+corenet_tcp_recv_netlabel(checkpc_t)
+corenet_udp_recv_netlabel(checkpc_t)
 corenet_non_ipsec_sendrecv(checkpc_t)
 corenet_tcp_sendrecv_all_if(checkpc_t)
 corenet_udp_sendrecv_all_if(checkpc_t)
@@ -157,6 +161,10 @@ kernel_read_kernel_sysctls(lpd_t)
 # bash wants access to /proc/meminfo
 kernel_read_system_state(lpd_t)
 
+corenet_tcp_recv_unlabeled(lpd_t)
+corenet_udp_recv_unlabeled(lpd_t)
+corenet_tcp_recv_netlabel(lpd_t)
+corenet_udp_recv_netlabel(lpd_t)
 corenet_non_ipsec_sendrecv(lpd_t)
 corenet_tcp_sendrecv_all_if(lpd_t)
 corenet_udp_sendrecv_all_if(lpd_t)
Index: refpolicy_svn_repo/policy/modules/services/mailman.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/mailman.if
+++ refpolicy_svn_repo/policy/modules/services/mailman.if
@@ -48,6 +48,10 @@ template(`mailman_domain_template', `
 	kernel_read_kernel_sysctls(mailman_$1_t)
 	kernel_read_system_state(mailman_$1_t)
 
+	corenet_tcp_recv_unlabeled(mailman_$1_t)
+	corenet_udp_recv_unlabeled(mailman_$1_t)
+	corenet_tcp_recv_netlabel(mailman_$1_t)
+	corenet_udp_recv_netlabel(mailman_$1_t)
 	corenet_non_ipsec_sendrecv(mailman_$1_t)
 	corenet_tcp_sendrecv_all_if(mailman_$1_t)
 	corenet_udp_sendrecv_all_if(mailman_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/monop.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/monop.te
+++ refpolicy_svn_repo/policy/modules/services/monop.te
@@ -43,6 +43,10 @@ kernel_read_kernel_sysctls(monopd_t)
 kernel_list_proc(monopd_t)
 kernel_read_proc_symlinks(monopd_t)
 
+corenet_tcp_recv_unlabeled(monopd_t)
+corenet_udp_recv_unlabeled(monopd_t)
+corenet_tcp_recv_netlabel(monopd_t)
+corenet_udp_recv_netlabel(monopd_t)
 corenet_non_ipsec_sendrecv(monopd_t)
 corenet_tcp_sendrecv_generic_if(monopd_t)
 corenet_udp_sendrecv_generic_if(monopd_t)
Index: refpolicy_svn_repo/policy/modules/services/mta.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/mta.if
+++ refpolicy_svn_repo/policy/modules/services/mta.if
@@ -72,6 +72,8 @@ template(`mta_base_mail_template',`
 
 	kernel_read_kernel_sysctls($1_mail_t)
 
+	corenet_tcp_recv_unlabeled($1_mail_t)
+	corenet_tcp_recv_netlabel($1_mail_t)
 	corenet_non_ipsec_sendrecv($1_mail_t)
 	corenet_tcp_sendrecv_all_if($1_mail_t)
 	corenet_tcp_sendrecv_all_nodes($1_mail_t)
Index: refpolicy_svn_repo/policy/modules/services/munin.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/munin.te
+++ refpolicy_svn_repo/policy/modules/services/munin.te
@@ -65,6 +65,10 @@ kernel_read_kernel_sysctls(munin_t)
 
 corecmd_exec_bin(munin_t)
 
+corenet_tcp_recv_unlabeled(munin_t)
+corenet_udp_recv_unlabeled(munin_t)
+corenet_tcp_recv_netlabel(munin_t)
+corenet_udp_recv_netlabel(munin_t)
 corenet_non_ipsec_sendrecv(munin_t)
 corenet_tcp_sendrecv_generic_if(munin_t)
 corenet_udp_sendrecv_generic_if(munin_t)
Index: refpolicy_svn_repo/policy/modules/services/mysql.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/mysql.te
+++ refpolicy_svn_repo/policy/modules/services/mysql.te
@@ -61,6 +61,10 @@ files_pid_filetrans(mysqld_t,mysqld_var_
 kernel_read_system_state(mysqld_t)
 kernel_read_kernel_sysctls(mysqld_t)
 
+corenet_tcp_recv_unlabeled(mysqld_t)
+corenet_udp_recv_unlabeled(mysqld_t)
+corenet_tcp_recv_netlabel(mysqld_t)
+corenet_udp_recv_netlabel(mysqld_t)
 corenet_non_ipsec_sendrecv(mysqld_t)
 corenet_tcp_sendrecv_all_if(mysqld_t)
 corenet_udp_sendrecv_all_if(mysqld_t)
Index: refpolicy_svn_repo/policy/modules/services/nagios.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nagios.te
+++ refpolicy_svn_repo/policy/modules/services/nagios.te
@@ -66,6 +66,10 @@ kernel_read_kernel_sysctls(nagios_t)
 corecmd_exec_bin(nagios_t)
 corecmd_exec_shell(nagios_t)
 
+corenet_tcp_recv_unlabeled(nagios_t)
+corenet_udp_recv_unlabeled(nagios_t)
+corenet_tcp_recv_netlabel(nagios_t)
+corenet_udp_recv_netlabel(nagios_t)
 corenet_non_ipsec_sendrecv(nagios_t)
 corenet_tcp_sendrecv_generic_if(nagios_t)
 corenet_udp_sendrecv_generic_if(nagios_t)
Index: refpolicy_svn_repo/policy/modules/services/nessus.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nessus.te
+++ refpolicy_svn_repo/policy/modules/services/nessus.te
@@ -57,6 +57,12 @@ kernel_read_kernel_sysctls(nessusd_t)
 # for nmap etc
 corecmd_exec_bin(nessusd_t)
 
+corenet_tcp_recv_unlabeled(nessusd_t)
+corenet_udp_recv_unlabeled(nessusd_t)
+corenet_raw_recv_unlabeled(nessusd_t)
+corenet_tcp_recv_netlabel(nessusd_t)
+corenet_udp_recv_netlabel(nessusd_t)
+corenet_raw_recv_netlabel(nessusd_t)
 corenet_non_ipsec_sendrecv(nessusd_t)
 corenet_tcp_sendrecv_generic_if(nessusd_t)
 corenet_udp_sendrecv_generic_if(nessusd_t)
Index: refpolicy_svn_repo/policy/modules/services/networkmanager.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/networkmanager.te
+++ refpolicy_svn_repo/policy/modules/services/networkmanager.te
@@ -41,6 +41,12 @@ kernel_read_network_state(NetworkManager
 kernel_read_kernel_sysctls(NetworkManager_t)
 kernel_load_module(NetworkManager_t)
 
+corenet_tcp_recv_unlabeled(NetworkManager_t)
+corenet_udp_recv_unlabeled(NetworkManager_t)
+corenet_raw_recv_unlabeled(NetworkManager_t)
+corenet_tcp_recv_netlabel(NetworkManager_t)
+corenet_udp_recv_netlabel(NetworkManager_t)
+corenet_raw_recv_netlabel(NetworkManager_t)
 corenet_non_ipsec_sendrecv(NetworkManager_t)
 corenet_tcp_sendrecv_all_if(NetworkManager_t)
 corenet_udp_sendrecv_all_if(NetworkManager_t)
Index: refpolicy_svn_repo/policy/modules/services/nis.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nis.if
+++ refpolicy_svn_repo/policy/modules/services/nis.if
@@ -37,6 +37,10 @@ interface(`nis_use_ypbind_uncond',`
 	allow $1 var_yp_t:lnk_file { getattr read };
 	allow $1 var_yp_t:file read_file_perms;
 
+	corenet_tcp_recv_unlabeled($1)
+	corenet_udp_recv_unlabeled($1)
+	corenet_tcp_recv_netlabel($1)
+	corenet_udp_recv_netlabel($1)
 	corenet_non_ipsec_sendrecv($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_udp_sendrecv_all_if($1)
Index: refpolicy_svn_repo/policy/modules/services/nis.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nis.te
+++ refpolicy_svn_repo/policy/modules/services/nis.te
@@ -69,6 +69,10 @@ kernel_read_kernel_sysctls(ypbind_t)
 kernel_list_proc(ypbind_t)
 kernel_read_proc_symlinks(ypbind_t)
 
+corenet_tcp_recv_unlabeled(ypbind_t)
+corenet_udp_recv_unlabeled(ypbind_t)
+corenet_tcp_recv_netlabel(ypbind_t)
+corenet_udp_recv_netlabel(ypbind_t)
 corenet_non_ipsec_sendrecv(ypbind_t)
 corenet_tcp_sendrecv_all_if(ypbind_t)
 corenet_udp_sendrecv_all_if(ypbind_t)
@@ -152,6 +156,10 @@ kernel_read_proc_symlinks(yppasswdd_t)
 kernel_getattr_proc_files(yppasswdd_t)
 kernel_read_kernel_sysctls(yppasswdd_t)
 
+corenet_tcp_recv_unlabeled(yppasswdd_t)
+corenet_udp_recv_unlabeled(yppasswdd_t)
+corenet_tcp_recv_netlabel(yppasswdd_t)
+corenet_udp_recv_netlabel(yppasswdd_t)
 corenet_non_ipsec_sendrecv(yppasswdd_t)
 corenet_tcp_sendrecv_generic_if(yppasswdd_t)
 corenet_udp_sendrecv_generic_if(yppasswdd_t)
@@ -247,6 +255,10 @@ kernel_read_kernel_sysctls(ypserv_t)
 kernel_list_proc(ypserv_t)
 kernel_read_proc_symlinks(ypserv_t)
 
+corenet_tcp_recv_unlabeled(ypserv_t)
+corenet_udp_recv_unlabeled(ypserv_t)
+corenet_tcp_recv_netlabel(ypserv_t)
+corenet_udp_recv_netlabel(ypserv_t)
 corenet_non_ipsec_sendrecv(ypserv_t)
 corenet_tcp_sendrecv_all_if(ypserv_t)
 corenet_udp_sendrecv_all_if(ypserv_t)
@@ -321,6 +333,10 @@ allow ypxfr_t ypserv_t:udp_socket { read
 
 allow ypxfr_t ypserv_conf_t:file { getattr read };
 
+corenet_tcp_recv_unlabeled(ypxfr_t)
+corenet_udp_recv_unlabeled(ypxfr_t)
+corenet_tcp_recv_netlabel(ypxfr_t)
+corenet_udp_recv_netlabel(ypxfr_t)
 corenet_non_ipsec_sendrecv(ypxfr_t)
 corenet_tcp_sendrecv_all_if(ypxfr_t)
 corenet_udp_sendrecv_all_if(ypxfr_t)
Index: refpolicy_svn_repo/policy/modules/services/nscd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nscd.te
+++ refpolicy_svn_repo/policy/modules/services/nscd.te
@@ -65,6 +65,10 @@ fs_search_auto_mountpoints(nscd_t)
 auth_getattr_shadow(nscd_t)
 auth_use_nsswitch(nscd_t)
 
+corenet_tcp_recv_unlabeled(nscd_t)
+corenet_udp_recv_unlabeled(nscd_t)
+corenet_tcp_recv_netlabel(nscd_t)
+corenet_udp_recv_netlabel(nscd_t)
 corenet_non_ipsec_sendrecv(nscd_t)
 corenet_tcp_sendrecv_all_if(nscd_t)
 corenet_udp_sendrecv_all_if(nscd_t)
Index: refpolicy_svn_repo/policy/modules/services/nsd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nsd.te
+++ refpolicy_svn_repo/policy/modules/services/nsd.te
@@ -62,6 +62,10 @@ kernel_read_kernel_sysctls(nsd_t)
 
 corecmd_exec_bin(nsd_t)
 
+corenet_tcp_recv_unlabeled(nsd_t)
+corenet_udp_recv_unlabeled(nsd_t)
+corenet_tcp_recv_netlabel(nsd_t)
+corenet_udp_recv_netlabel(nsd_t)
 corenet_non_ipsec_sendrecv(nsd_t)
 corenet_tcp_sendrecv_generic_if(nsd_t)
 corenet_udp_sendrecv_generic_if(nsd_t)
@@ -148,6 +152,10 @@ kernel_read_system_state(nsd_crond_t)
 corecmd_exec_bin(nsd_crond_t)
 corecmd_exec_shell(nsd_crond_t)
 
+corenet_tcp_recv_unlabeled(nsd_crond_t)
+corenet_udp_recv_unlabeled(nsd_crond_t)
+corenet_tcp_recv_netlabel(nsd_crond_t)
+corenet_udp_recv_netlabel(nsd_crond_t)
 corenet_non_ipsec_sendrecv(nsd_crond_t)
 corenet_tcp_sendrecv_generic_if(nsd_crond_t)
 corenet_udp_sendrecv_generic_if(nsd_crond_t)
Index: refpolicy_svn_repo/policy/modules/services/ntop.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ntop.te
+++ refpolicy_svn_repo/policy/modules/services/ntop.te
@@ -61,6 +61,12 @@ kernel_read_kernel_sysctls(ntop_t)
 kernel_list_proc(ntop_t)
 kernel_read_proc_symlinks(ntop_t)
 
+corenet_tcp_recv_unlabeled(ntop_t)
+corenet_udp_recv_unlabeled(ntop_t)
+corenet_raw_recv_unlabeled(ntop_t)
+corenet_tcp_recv_netlabel(ntop_t)
+corenet_udp_recv_netlabel(ntop_t)
+corenet_raw_recv_netlabel(ntop_t)
 corenet_non_ipsec_sendrecv(ntop_t)
 corenet_tcp_sendrecv_generic_if(ntop_t)
 corenet_udp_sendrecv_generic_if(ntop_t)
Index: refpolicy_svn_repo/policy/modules/services/nx.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/nx.te
+++ refpolicy_svn_repo/policy/modules/services/nx.te
@@ -51,6 +51,10 @@ kernel_read_kernel_sysctls(nx_server_t)
 corecmd_exec_shell(nx_server_t)
 corecmd_exec_bin(nx_server_t)
 
+corenet_tcp_recv_unlabeled(nx_server_t)
+corenet_udp_recv_unlabeled(nx_server_t)
+corenet_tcp_recv_netlabel(nx_server_t)
+corenet_udp_recv_netlabel(nx_server_t)
 corenet_non_ipsec_sendrecv(nx_server_t)
 corenet_tcp_sendrecv_generic_if(nx_server_t)
 corenet_udp_sendrecv_generic_if(nx_server_t)
Index: refpolicy_svn_repo/policy/modules/services/oav.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/oav.te
+++ refpolicy_svn_repo/policy/modules/services/oav.te
@@ -50,6 +50,10 @@ read_lnk_files_pattern(oav_update_t,oav_
 
 corecmd_exec_all_executables(oav_update_t)
 
+corenet_tcp_recv_unlabeled(oav_update_t)
+corenet_udp_recv_unlabeled(oav_update_t)
+corenet_tcp_recv_netlabel(oav_update_t)
+corenet_udp_recv_netlabel(oav_update_t)
 corenet_non_ipsec_sendrecv(oav_update_t)
 corenet_tcp_sendrecv_generic_if(oav_update_t)
 corenet_udp_sendrecv_generic_if(oav_update_t)
@@ -104,6 +108,10 @@ kernel_read_kernel_sysctls(scannerdaemon
 # Can run kaffe
 corecmd_exec_all_executables(scannerdaemon_t)
 
+corenet_tcp_recv_unlabeled(scannerdaemon_t)
+corenet_udp_recv_unlabeled(scannerdaemon_t)
+corenet_tcp_recv_netlabel(scannerdaemon_t)
+corenet_udp_recv_netlabel(scannerdaemon_t)
 corenet_non_ipsec_sendrecv(scannerdaemon_t)
 corenet_tcp_sendrecv_generic_if(scannerdaemon_t)
 corenet_udp_sendrecv_generic_if(scannerdaemon_t)
Index: refpolicy_svn_repo/policy/modules/services/openvpn.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/openvpn.te
+++ refpolicy_svn_repo/policy/modules/services/openvpn.te
@@ -53,6 +53,10 @@ kernel_read_system_state(openvpn_t)
 corecmd_exec_bin(openvpn_t)
 corecmd_exec_shell(openvpn_t)
 
+corenet_tcp_recv_unlabeled(openvpn_t)
+corenet_udp_recv_unlabeled(openvpn_t)
+corenet_tcp_recv_netlabel(openvpn_t)
+corenet_udp_recv_netlabel(openvpn_t)
 corenet_non_ipsec_sendrecv(openvpn_t)
 corenet_tcp_sendrecv_all_if(openvpn_t)
 corenet_udp_sendrecv_all_if(openvpn_t)
Index: refpolicy_svn_repo/policy/modules/services/pcscd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/pcscd.te
+++ refpolicy_svn_repo/policy/modules/services/pcscd.te
@@ -31,10 +31,12 @@ manage_files_pattern(pcscd_t,pcscd_var_r
 manage_sock_files_pattern(pcscd_t,pcscd_var_run_t,pcscd_var_run_t)
 files_pid_filetrans(pcscd_t,pcscd_var_run_t, { file sock_file })
 
+corenet_tcp_recv_unlabeled(pcscd_t)
+corenet_tcp_recv_netlabel(pcscd_t)
+corenet_non_ipsec_sendrecv(pcscd_t)
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
@@ -66,6 +66,8 @@ kernel_read_system_state(pegasus_t)
 kernel_search_vm_sysctl(pegasus_t)
 kernel_read_net_sysctls(pegasus_t)
 
+corenet_tcp_recv_unlabeled(pegasus_t)
+corenet_tcp_recv_netlabel(pegasus_t)
 corenet_non_ipsec_sendrecv(pegasus_t)
 corenet_tcp_sendrecv_all_if(pegasus_t)
 corenet_tcp_sendrecv_all_nodes(pegasus_t)
Index: refpolicy_svn_repo/policy/modules/services/perdition.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/perdition.te
+++ refpolicy_svn_repo/policy/modules/services/perdition.te
@@ -37,6 +37,10 @@ kernel_read_kernel_sysctls(perdition_t)
 kernel_list_proc(perdition_t)
 kernel_read_proc_symlinks(perdition_t)
 
+corenet_tcp_recv_unlabeled(perdition_t)
+corenet_udp_recv_unlabeled(perdition_t)
+corenet_tcp_recv_netlabel(perdition_t)
+corenet_udp_recv_netlabel(perdition_t)
 corenet_non_ipsec_sendrecv(perdition_t)
 corenet_tcp_sendrecv_generic_if(perdition_t)
 corenet_udp_sendrecv_generic_if(perdition_t)
Index: refpolicy_svn_repo/policy/modules/services/portmap.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/portmap.te
+++ refpolicy_svn_repo/policy/modules/services/portmap.te
@@ -45,6 +45,10 @@ kernel_read_kernel_sysctls(portmap_t)
 kernel_list_proc(portmap_t)
 kernel_read_proc_symlinks(portmap_t)
 
+corenet_tcp_recv_unlabeled(portmap_t)
+corenet_udp_recv_unlabeled(portmap_t)
+corenet_tcp_recv_netlabel(portmap_t)
+corenet_udp_recv_netlabel(portmap_t)
 corenet_non_ipsec_sendrecv(portmap_t)
 corenet_tcp_sendrecv_all_if(portmap_t)
 corenet_udp_sendrecv_all_if(portmap_t)
@@ -123,6 +127,11 @@ allow portmap_helper_t self:udp_socket c
 allow portmap_helper_t portmap_var_run_t:file manage_file_perms;
 files_pid_filetrans(portmap_helper_t,portmap_var_run_t,file)
 
+corenet_tcp_recv_unlabeled(portmap_helper_t)
+corenet_udp_recv_unlabeled(portmap_helper_t)
+corenet_tcp_recv_netlabel(portmap_helper_t)
+corenet_udp_recv_netlabel(portmap_helper_t)
+corenet_non_ipsec_sendrecv(portmap_helper_t)
 corenet_tcp_sendrecv_all_if(portmap_helper_t)
 corenet_udp_sendrecv_all_if(portmap_helper_t)
 corenet_raw_sendrecv_all_if(portmap_helper_t)
@@ -131,7 +140,6 @@ corenet_udp_sendrecv_all_nodes(portmap_h
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
@@ -55,6 +55,10 @@ kernel_read_kernel_sysctls(portslave_t)
 corecmd_exec_bin(portslave_t)
 corecmd_exec_shell(portslave_t)
 
+corenet_tcp_recv_unlabeled(portslave_t)
+corenet_udp_recv_unlabeled(portslave_t)
+corenet_tcp_recv_netlabel(portslave_t)
+corenet_udp_recv_netlabel(portslave_t)
 corenet_non_ipsec_sendrecv(portslave_t)
 corenet_tcp_sendrecv_generic_if(portslave_t)
 corenet_udp_sendrecv_generic_if(portslave_t)
Index: refpolicy_svn_repo/policy/modules/services/postfix.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postfix.if
+++ refpolicy_svn_repo/policy/modules/services/postfix.if
@@ -125,6 +125,10 @@ template(`postfix_server_domain_template
 
 	domtrans_pattern(postfix_master_t, postfix_$1_exec_t, postfix_$1_t)
 
+	corenet_tcp_recv_unlabeled(postfix_$1_t)
+	corenet_udp_recv_unlabeled(postfix_$1_t)
+	corenet_tcp_recv_netlabel(postfix_$1_t)
+	corenet_udp_recv_netlabel(postfix_$1_t)
 	corenet_non_ipsec_sendrecv(postfix_$1_t)
 	corenet_tcp_sendrecv_all_if(postfix_$1_t)
 	corenet_udp_sendrecv_all_if(postfix_$1_t)
Index: refpolicy_svn_repo/policy/modules/services/postfix.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postfix.te
+++ refpolicy_svn_repo/policy/modules/services/postfix.te
@@ -133,6 +133,10 @@ rename_files_pattern(postfix_master_t,po
 
 kernel_read_all_sysctls(postfix_master_t)
 
+corenet_tcp_recv_unlabeled(postfix_master_t)
+corenet_udp_recv_unlabeled(postfix_master_t)
+corenet_tcp_recv_netlabel(postfix_master_t)
+corenet_udp_recv_netlabel(postfix_master_t)
 corenet_non_ipsec_sendrecv(postfix_master_t)
 corenet_tcp_sendrecv_all_if(postfix_master_t)
 corenet_udp_sendrecv_all_if(postfix_master_t)
@@ -309,6 +313,10 @@ kernel_read_kernel_sysctls(postfix_map_t
 kernel_dontaudit_list_proc(postfix_map_t)
 kernel_dontaudit_read_system_state(postfix_map_t)
 
+corenet_tcp_recv_unlabeled(postfix_map_t)
+corenet_udp_recv_unlabeled(postfix_map_t)
+corenet_tcp_recv_netlabel(postfix_map_t)
+corenet_udp_recv_netlabel(postfix_map_t)
 corenet_non_ipsec_sendrecv(postfix_map_t)
 corenet_tcp_sendrecv_all_if(postfix_map_t)
 corenet_udp_sendrecv_all_if(postfix_map_t)
Index: refpolicy_svn_repo/policy/modules/services/postgresql.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postgresql.te
+++ refpolicy_svn_repo/policy/modules/services/postgresql.te
@@ -82,6 +82,10 @@ kernel_list_proc(postgresql_t)
 kernel_read_all_sysctls(postgresql_t)
 kernel_read_proc_symlinks(postgresql_t)
 
+corenet_tcp_recv_unlabeled(postgresql_t)
+corenet_udp_recv_unlabeled(postgresql_t)
+corenet_tcp_recv_netlabel(postgresql_t)
+corenet_udp_recv_netlabel(postgresql_t)
 corenet_non_ipsec_sendrecv(postgresql_t)
 corenet_tcp_sendrecv_all_if(postgresql_t)
 corenet_udp_sendrecv_all_if(postgresql_t)
Index: refpolicy_svn_repo/policy/modules/services/postgrey.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/postgrey.te
+++ refpolicy_svn_repo/policy/modules/services/postgrey.te
@@ -46,6 +46,8 @@ kernel_read_kernel_sysctls(postgrey_t)
 # for perl
 corecmd_search_bin(postgrey_t)
 
+corenet_tcp_recv_unlabeled(postgrey_t)
+corenet_tcp_recv_netlabel(postgrey_t)
 corenet_non_ipsec_sendrecv(postgrey_t)
 corenet_tcp_sendrecv_generic_if(postgrey_t)
 corenet_tcp_sendrecv_all_nodes(postgrey_t)
Index: refpolicy_svn_repo/policy/modules/services/ppp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ppp.te
+++ refpolicy_svn_repo/policy/modules/services/ppp.te
@@ -126,6 +126,12 @@ dev_read_urand(pppd_t)
 dev_search_sysfs(pppd_t)
 dev_read_sysfs(pppd_t)
 
+corenet_tcp_recv_unlabeled(pppd_t)
+corenet_udp_recv_unlabeled(pppd_t)
+corenet_raw_recv_unlabeled(pppd_t)
+corenet_tcp_recv_netlabel(pppd_t)
+corenet_udp_recv_netlabel(pppd_t)
+corenet_raw_recv_netlabel(pppd_t)
 corenet_non_ipsec_sendrecv(pppd_t)
 corenet_tcp_sendrecv_all_if(pppd_t)
 corenet_raw_sendrecv_all_if(pppd_t)
@@ -261,6 +267,12 @@ kernel_read_proc_symlinks(pptp_t)
 
 dev_read_sysfs(pptp_t)
 
+corenet_tcp_recv_unlabeled(pptp_t)
+corenet_udp_recv_unlabeled(pptp_t)
+corenet_raw_recv_unlabeled(pptp_t)
+corenet_tcp_recv_netlabel(pptp_t)
+corenet_udp_recv_netlabel(pptp_t)
+corenet_raw_recv_unlabeled(pptp_t)
 corenet_non_ipsec_sendrecv(pptp_t)
 corenet_tcp_sendrecv_all_if(pptp_t)
 corenet_raw_sendrecv_all_if(pptp_t)
Index: refpolicy_svn_repo/policy/modules/services/privoxy.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/privoxy.te
+++ refpolicy_svn_repo/policy/modules/services/privoxy.te
@@ -40,6 +40,8 @@ kernel_read_kernel_sysctls(privoxy_t)
 kernel_list_proc(privoxy_t)
 kernel_read_proc_symlinks(privoxy_t)
 
+corenet_tcp_recv_unlabeled(privoxy_t)
+corenet_tcp_recv_netlabel(privoxy_t)
 corenet_non_ipsec_sendrecv(privoxy_t)
 corenet_tcp_sendrecv_all_if(privoxy_t)
 corenet_tcp_sendrecv_all_nodes(privoxy_t)
Index: refpolicy_svn_repo/policy/modules/services/procmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/procmail.te
+++ refpolicy_svn_repo/policy/modules/services/procmail.te
@@ -34,6 +34,10 @@ files_tmp_filetrans(procmail_t, procmail
 kernel_read_system_state(procmail_t)
 kernel_read_kernel_sysctls(procmail_t)
 
+corenet_tcp_recv_unlabeled(procmail_t)
+corenet_udp_recv_unlabeled(procmail_t)
+corenet_tcp_recv_netlabel(procmail_t)
+corenet_udp_recv_netlabel(procmail_t)
 corenet_non_ipsec_sendrecv(procmail_t)
 corenet_tcp_sendrecv_all_if(procmail_t)
 corenet_udp_sendrecv_all_if(procmail_t)
Index: refpolicy_svn_repo/policy/modules/services/pyzor.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/pyzor.te
+++ refpolicy_svn_repo/policy/modules/services/pyzor.te
@@ -107,6 +107,8 @@ dev_read_urand(pyzord_t)
 
 corecmd_exec_bin(pyzord_t)
 
+corenet_udp_recv_unlabeled(pyzord_t)
+corenet_udp_recv_netlabel(pyzord_t)
 corenet_non_ipsec_sendrecv(pyzord_t)
 corenet_udp_sendrecv_all_if(pyzord_t)
 corenet_udp_sendrecv_all_nodes(pyzord_t)
Index: refpolicy_svn_repo/policy/modules/services/qmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/qmail.te
+++ refpolicy_svn_repo/policy/modules/services/qmail.te
@@ -171,6 +171,10 @@ allow qmail_remote_t self:udp_socket cre
 
 rw_files_pattern(qmail_remote_t,qmail_spool_t,qmail_spool_t)
 
+corenet_tcp_recv_unlabeled(qmail_remote_t)
+corenet_udp_recv_unlabeled(qmail_remote_t)
+corenet_tcp_recv_netlabel(qmail_remote_t)
+corenet_udp_recv_netlabel(qmail_remote_t)
 corenet_non_ipsec_sendrecv(qmail_remote_t)
 corenet_tcp_sendrecv_generic_if(qmail_remote_t)
 corenet_udp_sendrecv_generic_if(qmail_remote_t)
Index: refpolicy_svn_repo/policy/modules/services/radius.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/radius.te
+++ refpolicy_svn_repo/policy/modules/services/radius.te
@@ -58,6 +58,10 @@ files_pid_filetrans(radiusd_t,radiusd_va
 kernel_read_kernel_sysctls(radiusd_t)
 kernel_read_system_state(radiusd_t)
 
+corenet_tcp_recv_unlabeled(radiusd_t)
+corenet_udp_recv_unlabeled(radiusd_t)
+corenet_tcp_recv_netlabel(radiusd_t)
+corenet_udp_recv_netlabel(radiusd_t)
 corenet_non_ipsec_sendrecv(radiusd_t)
 corenet_tcp_sendrecv_all_if(radiusd_t)
 corenet_udp_sendrecv_all_if(radiusd_t)
Index: refpolicy_svn_repo/policy/modules/services/radvd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/radvd.te
+++ refpolicy_svn_repo/policy/modules/services/radvd.te
@@ -38,6 +38,12 @@ kernel_read_net_sysctls(radvd_t)
 kernel_read_network_state(radvd_t)
 kernel_read_system_state(radvd_t)
 
+corenet_tcp_recv_unlabeled(radvd_t)
+corenet_udp_recv_unlabeled(radvd_t)
+corenet_raw_recv_unlabeled(radvd_t)
+corenet_tcp_recv_netlabel(radvd_t)
+corenet_udp_recv_netlabel(radvd_t)
+corenet_raw_recv_netlabel(radvd_t)
 corenet_non_ipsec_sendrecv(radvd_t)
 corenet_tcp_sendrecv_all_if(radvd_t)
 corenet_udp_sendrecv_all_if(radvd_t)
Index: refpolicy_svn_repo/policy/modules/services/razor.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/razor.if
+++ refpolicy_svn_repo/policy/modules/services/razor.if
@@ -67,6 +67,10 @@ template(`razor_common_domain_template',
 
 	corecmd_exec_bin($1_t)
 
+	corenet_tcp_recv_unlabeled($1_t)
+	corenet_raw_recv_unlabeled($1_t)
+	corenet_tcp_recv_netlabel($1_t)
+	corenet_raw_recv_netlabel($1_t)
 	corenet_non_ipsec_sendrecv($1_t)
 	corenet_tcp_sendrecv_generic_if($1_t)
 	corenet_raw_sendrecv_generic_if($1_t)
Index: refpolicy_svn_repo/policy/modules/services/razor.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/razor.te
+++ refpolicy_svn_repo/policy/modules/services/razor.te
@@ -41,6 +41,10 @@ logging_log_filetrans(razor_t,razor_log_
 manage_files_pattern(razor_t,razor_var_lib_t,razor_var_lib_t)
 files_var_lib_filetrans(razor_t,razor_var_lib_t,file)
 
+corenet_tcp_recv_unlabeled(razor_t)
+corenet_raw_recv_unlabeled(razor_t)
+corenet_tcp_recv_netlabel(razor_t)
+corenet_raw_recv_netlabel(razor_t)
 corenet_non_ipsec_sendrecv(razor_t)
 corenet_tcp_sendrecv_generic_if(razor_t)
 corenet_raw_sendrecv_generic_if(razor_t)
Index: refpolicy_svn_repo/policy/modules/services/rdisc.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rdisc.te
+++ refpolicy_svn_repo/policy/modules/services/rdisc.te
@@ -26,6 +26,10 @@ kernel_list_proc(rdisc_t)
 kernel_read_proc_symlinks(rdisc_t)
 kernel_read_kernel_sysctls(rdisc_t)
 
+corenet_udp_recv_unlabeled(rdisc_t)
+corenet_raw_recv_unlabeled(rdisc_t)
+corenet_udp_recv_netlabel(rdisc_t)
+corenet_raw_recv_netlabel(rdisc_t)
 corenet_non_ipsec_sendrecv(rdisc_t)
 corenet_udp_sendrecv_generic_if(rdisc_t)
 corenet_raw_sendrecv_generic_if(rdisc_t)
Index: refpolicy_svn_repo/policy/modules/services/rhgb.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rhgb.te
+++ refpolicy_svn_repo/policy/modules/services/rhgb.te
@@ -44,6 +44,10 @@ kernel_read_system_state(rhgb_t)
 corecmd_exec_bin(rhgb_t)
 corecmd_exec_shell(rhgb_t)
 
+corenet_tcp_recv_unlabeled(rhgb_t)
+corenet_udp_recv_unlabeled(rhgb_t)
+corenet_tcp_recv_netlabel(rhgb_t)
+corenet_udp_recv_netlabel(rhgb_t)
 corenet_non_ipsec_sendrecv(rhgb_t)
 corenet_tcp_sendrecv_generic_if(rhgb_t)
 corenet_udp_sendrecv_generic_if(rhgb_t)
Index: refpolicy_svn_repo/policy/modules/services/ricci.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ricci.te
+++ refpolicy_svn_repo/policy/modules/services/ricci.te
@@ -120,6 +120,10 @@ kernel_read_kernel_sysctls(ricci_t)
 
 corecmd_exec_bin(ricci_t)
 
+corenet_tcp_recv_unlabeled(ricci_t)
+corenet_udp_recv_unlabeled(ricci_t)
+corenet_tcp_recv_netlabel(ricci_t)
+corenet_udp_recv_netlabel(ricci_t)
 corenet_non_ipsec_sendrecv(ricci_t)
 corenet_tcp_sendrecv_all_if(ricci_t)
 corenet_tcp_sendrecv_all_nodes(ricci_t)
Index: refpolicy_svn_repo/policy/modules/services/rlogin.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rlogin.te
+++ refpolicy_svn_repo/policy/modules/services/rlogin.te
@@ -50,6 +50,10 @@ kernel_read_kernel_sysctls(rlogind_t)
 kernel_read_system_state(rlogind_t)
 kernel_read_network_state(rlogind_t)
 
+corenet_tcp_recv_unlabeled(rlogind_t)
+corenet_udp_recv_unlabeled(rlogind_t)
+corenet_tcp_recv_netlabel(rlogind_t)
+corenet_udp_recv_netlabel(rlogind_t)
 corenet_non_ipsec_sendrecv(rlogind_t)
 corenet_tcp_sendrecv_all_if(rlogind_t)
 corenet_udp_sendrecv_all_if(rlogind_t)
Index: refpolicy_svn_repo/policy/modules/services/roundup.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/roundup.te
+++ refpolicy_svn_repo/policy/modules/services/roundup.te
@@ -43,6 +43,12 @@ dev_read_sysfs(roundup_t)
 # execute python
 corecmd_exec_bin(roundup_t)
 
+corenet_tcp_recv_unlabeled(roundup_t)
+corenet_udp_recv_unlabeled(roundup_t)
+corenet_raw_recv_unlabeled(roundup_t)
+corenet_tcp_recv_netlabel(roundup_t)
+corenet_udp_recv_netlabel(roundup_t)
+corenet_raw_recv_netlabel(roundup_t)
 corenet_non_ipsec_sendrecv(roundup_t)
 corenet_tcp_sendrecv_generic_if(roundup_t)
 corenet_udp_sendrecv_generic_if(roundup_t)
Index: refpolicy_svn_repo/policy/modules/services/rpc.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rpc.if
+++ refpolicy_svn_repo/policy/modules/services/rpc.if
@@ -70,6 +70,10 @@ template(`rpc_domain_template', `
 	dev_read_urand($1_t)
 	dev_read_rand($1_t)
 
+	corenet_tcp_recv_unlabeled($1_t)
+	corenet_udp_recv_unlabeled($1_t)
+	corenet_tcp_recv_netlabel($1_t)
+	corenet_udp_recv_netlabel($1_t)
 	corenet_non_ipsec_sendrecv($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
Index: refpolicy_svn_repo/policy/modules/services/rshd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rshd.te
+++ refpolicy_svn_repo/policy/modules/services/rshd.te
@@ -23,6 +23,10 @@ allow rshd_t self:tcp_socket create_stre
 
 kernel_read_kernel_sysctls(rshd_t)
 
+corenet_tcp_recv_unlabeled(rshd_t)
+corenet_udp_recv_unlabeled(rshd_t)
+corenet_tcp_recv_netlabel(rshd_t)
+corenet_udp_recv_netlabel(rshd_t)
 corenet_non_ipsec_sendrecv(rshd_t)
 corenet_tcp_sendrecv_generic_if(rshd_t)
 corenet_udp_sendrecv_generic_if(rshd_t)
Index: refpolicy_svn_repo/policy/modules/services/rsync.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rsync.te
+++ refpolicy_svn_repo/policy/modules/services/rsync.te
@@ -61,6 +61,10 @@ kernel_read_kernel_sysctls(rsync_t)
 kernel_read_system_state(rsync_t)
 kernel_read_network_state(rsync_t)
 
+corenet_tcp_recv_unlabeled(rsync_t)
+corenet_udp_recv_unlabeled(rsync_t)
+corenet_tcp_recv_netlabel(rsync_t)
+corenet_udp_recv_netlabel(rsync_t)
 corenet_non_ipsec_sendrecv(rsync_t)
 corenet_tcp_sendrecv_all_if(rsync_t)
 corenet_udp_sendrecv_all_if(rsync_t)
Index: refpolicy_svn_repo/policy/modules/services/rwho.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/rwho.te
+++ refpolicy_svn_repo/policy/modules/services/rwho.te
@@ -32,6 +32,8 @@ files_spool_filetrans(rwho_t,rwho_spool_
 
 kernel_read_system_state(rwho_t)
 
+corenet_udp_recv_unlabeled(rwho_t)
+corenet_udp_recv_netlabel(rwho_t)
 corenet_non_ipsec_sendrecv(rwho_t)
 corenet_udp_sendrecv_all_if(rwho_t)
 corenet_udp_sendrecv_all_nodes(rwho_t)
Index: refpolicy_svn_repo/policy/modules/services/samba.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/samba.te
+++ refpolicy_svn_repo/policy/modules/services/samba.te
@@ -133,6 +133,11 @@ manage_lnk_files_pattern(samba_net_t,sam
 
 kernel_read_proc_symlinks(samba_net_t)
 
+corenet_tcp_recv_unlabeled(samba_net_t)
+corenet_udp_recv_unlabeled(samba_net_t)
+corenet_tcp_recv_netlabel(samba_net_t)
+corenet_udp_recv_netlabel(samba_net_t)
+corenet_non_ipsec_sendrecv(samba_net_t)
 corenet_tcp_sendrecv_all_if(samba_net_t)
 corenet_udp_sendrecv_all_if(samba_net_t)
 corenet_raw_sendrecv_all_if(samba_net_t)
@@ -141,7 +146,6 @@ corenet_udp_sendrecv_all_nodes(samba_net
 corenet_raw_sendrecv_all_nodes(samba_net_t)
 corenet_tcp_sendrecv_all_ports(samba_net_t)
 corenet_udp_sendrecv_all_ports(samba_net_t)
-corenet_non_ipsec_sendrecv(samba_net_t)
 corenet_tcp_bind_all_nodes(samba_net_t)
 corenet_udp_bind_all_nodes(samba_net_t)
 corenet_tcp_connect_smbd_port(samba_net_t)
@@ -241,6 +245,11 @@ kernel_read_kernel_sysctls(smbd_t)
 kernel_read_software_raid_state(smbd_t)
 kernel_read_system_state(smbd_t)
 
+corenet_tcp_recv_unlabeled(smbd_t)
+corenet_udp_recv_unlabeled(smbd_t)
+corenet_tcp_recv_netlabel(smbd_t)
+corenet_udp_recv_netlabel(smbd_t)
+corenet_non_ipsec_sendrecv(smbd_t)
 corenet_tcp_sendrecv_all_if(smbd_t)
 corenet_udp_sendrecv_all_if(smbd_t)
 corenet_raw_sendrecv_all_if(smbd_t)
@@ -249,7 +258,6 @@ corenet_udp_sendrecv_all_nodes(smbd_t)
 corenet_raw_sendrecv_all_nodes(smbd_t)
 corenet_tcp_sendrecv_all_ports(smbd_t)
 corenet_udp_sendrecv_all_ports(smbd_t)
-corenet_non_ipsec_sendrecv(smbd_t)
 corenet_tcp_bind_all_nodes(smbd_t)
 corenet_udp_bind_all_nodes(smbd_t)
 corenet_tcp_bind_smbd_port(smbd_t)
@@ -380,6 +388,10 @@ kernel_read_network_state(nmbd_t)
 kernel_read_software_raid_state(nmbd_t)
 kernel_read_system_state(nmbd_t)
 
+corenet_tcp_recv_unlabeled(nmbd_t)
+corenet_udp_recv_unlabeled(nmbd_t)
+corenet_tcp_recv_netlabel(nmbd_t)
+corenet_udp_recv_netlabel(nmbd_t)
 corenet_non_ipsec_sendrecv(nmbd_t)
 corenet_tcp_sendrecv_all_if(nmbd_t)
 corenet_udp_sendrecv_all_if(nmbd_t)
@@ -463,6 +475,11 @@ manage_lnk_files_pattern(smbmount_t,samb
 
 kernel_read_system_state(smbmount_t)
 
+corenet_tcp_recv_unlabeled(smbmount_t)
+corenet_udp_recv_unlabeled(smbmount_t)
+corenet_tcp_recv_netlabel(smbmount_t)
+corenet_udp_recv_netlabel(smbmount_t)
+corenet_non_ipsec_sendrecv(smbmount_t)
 corenet_tcp_sendrecv_all_if(smbmount_t)
 corenet_raw_sendrecv_all_if(smbmount_t)
 corenet_udp_sendrecv_all_if(smbmount_t)
@@ -471,7 +488,6 @@ corenet_raw_sendrecv_all_nodes(smbmount_
 corenet_udp_sendrecv_all_nodes(smbmount_t)
 corenet_tcp_sendrecv_all_ports(smbmount_t)
 corenet_udp_sendrecv_all_ports(smbmount_t)
-corenet_non_ipsec_sendrecv(smbmount_t)
 corenet_tcp_bind_all_nodes(smbmount_t)
 corenet_udp_bind_all_nodes(smbmount_t)
 corenet_tcp_connect_all_ports(smbmount_t)
@@ -566,6 +582,10 @@ kernel_read_network_state(swat_t)
 
 corecmd_search_bin(swat_t)
 
+corenet_tcp_recv_unlabeled(swat_t)
+corenet_udp_recv_unlabeled(swat_t)
+corenet_tcp_recv_netlabel(swat_t)
+corenet_udp_recv_netlabel(swat_t)
 corenet_non_ipsec_sendrecv(swat_t)
 corenet_tcp_sendrecv_generic_if(swat_t)
 corenet_udp_sendrecv_generic_if(swat_t)
@@ -663,6 +683,11 @@ kernel_read_kernel_sysctls(winbind_t)
 kernel_list_proc(winbind_t)
 kernel_read_proc_symlinks(winbind_t)
 
+corenet_tcp_recv_unlabeled(winbind_t)
+corenet_udp_recv_unlabeled(winbind_t)
+corenet_tcp_recv_netlabel(winbind_t)
+corenet_udp_recv_netlabel(winbind_t)
+corenet_non_ipsec_sendrecv(winbind_t)
 corenet_tcp_sendrecv_all_if(winbind_t)
 corenet_udp_sendrecv_all_if(winbind_t)
 corenet_raw_sendrecv_all_if(winbind_t)
@@ -671,7 +696,6 @@ corenet_udp_sendrecv_all_nodes(winbind_t
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
@@ -47,6 +47,8 @@ files_pid_filetrans(saslauthd_t,saslauth
 kernel_read_kernel_sysctls(saslauthd_t)
 kernel_read_system_state(saslauthd_t)
 
+corenet_tcp_recv_unlabeled(saslauthd_t)
+corenet_tcp_recv_netlabel(saslauthd_t)
 corenet_non_ipsec_sendrecv(saslauthd_t)
 corenet_tcp_sendrecv_all_if(saslauthd_t)
 corenet_tcp_sendrecv_all_nodes(saslauthd_t)
Index: refpolicy_svn_repo/policy/modules/services/sendmail.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/sendmail.te
+++ refpolicy_svn_repo/policy/modules/services/sendmail.te
@@ -49,6 +49,8 @@ kernel_read_kernel_sysctls(sendmail_t)
 # for piping mail to a command
 kernel_read_system_state(sendmail_t)
 
+corenet_tcp_recv_unlabeled(sendmail_t)
+corenet_tcp_recv_netlabel(sendmail_t)
 corenet_non_ipsec_sendrecv(sendmail_t)
 corenet_tcp_sendrecv_all_if(sendmail_t)
 corenet_tcp_sendrecv_all_nodes(sendmail_t)
Index: refpolicy_svn_repo/policy/modules/services/setroubleshoot.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/setroubleshoot.te
+++ refpolicy_svn_repo/policy/modules/services/setroubleshoot.te
@@ -58,6 +58,8 @@ kernel_read_network_state(setroubleshoot
 corecmd_exec_bin(setroubleshootd_t)
 corecmd_exec_shell(setroubleshootd_t)
 
+corenet_tcp_recv_unlabeled(setroubleshootd_t)
+corenet_tcp_recv_netlabel(setroubleshootd_t)
 corenet_non_ipsec_sendrecv(setroubleshootd_t)
 corenet_tcp_sendrecv_generic_if(setroubleshootd_t)
 corenet_tcp_sendrecv_all_nodes(setroubleshootd_t)
Index: refpolicy_svn_repo/policy/modules/services/smartmon.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/smartmon.te
+++ refpolicy_svn_repo/policy/modules/services/smartmon.te
@@ -42,6 +42,8 @@ kernel_read_system_state(fsdaemon_t)
 
 corecmd_exec_all_executables(fsdaemon_t)
 
+corenet_udp_recv_unlabeled(fsdaemon_t)
+corenet_udp_recv_netlabel(fsdaemon_t)
 corenet_non_ipsec_sendrecv(fsdaemon_t)
 corenet_udp_sendrecv_generic_if(fsdaemon_t)
 corenet_udp_sendrecv_all_nodes(fsdaemon_t)
Index: refpolicy_svn_repo/policy/modules/services/snmp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/snmp.te
+++ refpolicy_svn_repo/policy/modules/services/snmp.te
@@ -58,6 +58,10 @@ kernel_read_network_state(snmpd_t)
 corecmd_exec_bin(snmpd_t)
 corecmd_exec_shell(snmpd_t)
 
+corenet_tcp_recv_unlabeled(snmpd_t)
+corenet_udp_recv_unlabeled(snmpd_t)
+corenet_tcp_recv_netlabel(snmpd_t)
+corenet_udp_recv_netlabel(snmpd_t)
 corenet_non_ipsec_sendrecv(snmpd_t)
 corenet_tcp_sendrecv_all_if(snmpd_t)
 corenet_udp_sendrecv_all_if(snmpd_t)
Index: refpolicy_svn_repo/policy/modules/services/snort.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/snort.te
+++ refpolicy_svn_repo/policy/modules/services/snort.te
@@ -55,6 +55,12 @@ kernel_list_proc(snort_t)
 kernel_read_proc_symlinks(snort_t)
 kernel_dontaudit_read_system_state(snort_t)
 
+corenet_tcp_recv_unlabeled(snort_t)
+corenet_udp_recv_unlabeled(snort_t)
+corenet_raw_recv_unlabeled(snort_t)
+corenet_tcp_recv_netlabel(snort_t)
+corenet_udp_recv_netlabel(snort_t)
+corenet_raw_recv_netlabel(snort_t)
 corenet_non_ipsec_sendrecv(snort_t)
 corenet_tcp_sendrecv_generic_if(snort_t)
 corenet_udp_sendrecv_generic_if(snort_t)
Index: refpolicy_svn_repo/policy/modules/services/soundserver.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/soundserver.te
+++ refpolicy_svn_repo/policy/modules/services/soundserver.te
@@ -62,6 +62,10 @@ kernel_read_kernel_sysctls(soundd_t)
 kernel_list_proc(soundd_t)
 kernel_read_proc_symlinks(soundd_t)
 
+corenet_tcp_recv_unlabeled(soundd_t)
+corenet_udp_recv_unlabeled(soundd_t)
+corenet_tcp_recv_netlabel(soundd_t)
+corenet_udp_recv_netlabel(soundd_t)
 corenet_non_ipsec_sendrecv(soundd_t)
 corenet_tcp_sendrecv_generic_if(soundd_t)
 corenet_udp_sendrecv_generic_if(soundd_t)
Index: refpolicy_svn_repo/policy/modules/services/spamassassin.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/spamassassin.if
+++ refpolicy_svn_repo/policy/modules/services/spamassassin.if
@@ -97,6 +97,10 @@ template(`spamassassin_per_role_template
 
 	kernel_read_kernel_sysctls($1_spamc_t)
 
+	corenet_tcp_recv_unlabeled($1_spamc_t)
+	corenet_udp_recv_unlabeled($1_spamc_t)
+	corenet_tcp_recv_netlabel($1_spamc_t)
+	corenet_udp_recv_netlabel($1_spamc_t)
 	corenet_non_ipsec_sendrecv($1_spamc_t)
 	corenet_tcp_sendrecv_generic_if($1_spamc_t)
 	corenet_udp_sendrecv_generic_if($1_spamc_t)
@@ -267,6 +271,10 @@ template(`spamassassin_per_role_template
 		allow $1_spamassassin_t self:tcp_socket create_stream_socket_perms;
 		allow $1_spamassassin_t self:udp_socket create_socket_perms;
 
+		corenet_tcp_recv_unlabeled($1_spamassassin_t)
+		corenet_udp_recv_unlabeled($1_spamassassin_t)
+		corenet_tcp_recv_netlabel($1_spamassassin_t)
+		corenet_udp_recv_netlabel($1_spamassassin_t)
 		corenet_non_ipsec_sendrecv($1_spamassassin_t)
 		corenet_tcp_sendrecv_generic_if($1_spamassassin_t)
 		corenet_udp_sendrecv_generic_if($1_spamassassin_t)
Index: refpolicy_svn_repo/policy/modules/services/spamassassin.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/spamassassin.te
+++ refpolicy_svn_repo/policy/modules/services/spamassassin.te
@@ -93,6 +93,10 @@ files_pid_filetrans(spamd_t,spamd_var_ru
 kernel_read_all_sysctls(spamd_t)
 kernel_read_system_state(spamd_t)
 
+corenet_tcp_recv_unlabeled(spamd_t)
+corenet_udp_recv_unlabeled(spamd_t)
+corenet_tcp_recv_netlabel(spamd_t)
+corenet_udp_recv_netlabel(spamd_t)
 corenet_non_ipsec_sendrecv(spamd_t)
 corenet_tcp_sendrecv_all_if(spamd_t)
 corenet_udp_sendrecv_all_if(spamd_t)
Index: refpolicy_svn_repo/policy/modules/services/squid.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/squid.te
+++ refpolicy_svn_repo/policy/modules/services/squid.te
@@ -75,6 +75,10 @@ kernel_read_system_state(squid_t)
 
 files_dontaudit_getattr_boot_dirs(squid_t)
 
+corenet_tcp_recv_unlabeled(squid_t)
+corenet_udp_recv_unlabeled(squid_t)
+corenet_tcp_recv_netlabel(squid_t)
+corenet_udp_recv_netlabel(squid_t)
 corenet_non_ipsec_sendrecv(squid_t)
 corenet_tcp_sendrecv_all_if(squid_t)
 corenet_udp_sendrecv_all_if(squid_t)
Index: refpolicy_svn_repo/policy/modules/services/ssh.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ssh.if
+++ refpolicy_svn_repo/policy/modules/services/ssh.if
@@ -109,6 +109,8 @@ template(`ssh_basic_client_template',`
 
 	kernel_read_kernel_sysctls($1_ssh_t)
 
+	corenet_tcp_recv_unlabeled($1_ssh_t)
+	corenet_tcp_recv_netlabel($1_ssh_t)
 	corenet_non_ipsec_sendrecv($1_ssh_t)
 	corenet_tcp_sendrecv_all_if($1_ssh_t)
 	corenet_tcp_sendrecv_all_nodes($1_ssh_t)
@@ -466,6 +468,11 @@ template(`ssh_server_template', `
 
 	kernel_read_kernel_sysctls($1_t)
 
+	corenet_tcp_recv_unlabeled($1_t)
+	corenet_udp_recv_unlabeled($1_t)
+	corenet_tcp_recv_netlabel($1_t)
+	corenet_udp_recv_netlabel($1_t)
+	corenet_non_ipsec_sendrecv($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
 	corenet_raw_sendrecv_all_if($1_t)
@@ -474,7 +481,6 @@ template(`ssh_server_template', `
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
@@ -55,6 +55,10 @@ kernel_read_kernel_sysctls(stunnel_t)
 kernel_read_system_state(stunnel_t)
 kernel_read_network_state(stunnel_t)
 
+corenet_tcp_recv_unlabeled(stunnel_t)
+corenet_udp_recv_unlabeled(stunnel_t)
+corenet_tcp_recv_netlabel(stunnel_t)
+corenet_udp_recv_netlabel(stunnel_t)
 corenet_non_ipsec_sendrecv(stunnel_t)
 corenet_tcp_sendrecv_all_if(stunnel_t)
 corenet_udp_sendrecv_all_if(stunnel_t)
Index: refpolicy_svn_repo/policy/modules/services/tcpd.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/tcpd.te
+++ refpolicy_svn_repo/policy/modules/services/tcpd.te
@@ -23,6 +23,8 @@ manage_dirs_pattern(tcpd_t,tcpd_tmp_t,tc
 manage_files_pattern(tcpd_t,tcpd_tmp_t,tcpd_tmp_t)
 files_tmp_filetrans(tcpd_t, tcpd_tmp_t, { file dir })
 
+corenet_tcp_recv_unlabeled(tcpd_t)
+corenet_tcp_recv_netlabel(tcpd_t)
 corenet_non_ipsec_sendrecv(tcpd_t)
 corenet_tcp_sendrecv_all_if(tcpd_t)
 corenet_tcp_sendrecv_all_nodes(tcpd_t)
Index: refpolicy_svn_repo/policy/modules/services/telnet.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/telnet.te
+++ refpolicy_svn_repo/policy/modules/services/telnet.te
@@ -49,6 +49,10 @@ kernel_read_kernel_sysctls(telnetd_t)
 kernel_read_system_state(telnetd_t)
 kernel_read_network_state(telnetd_t)
 
+corenet_tcp_recv_unlabeled(telnetd_t)
+corenet_udp_recv_unlabeled(telnetd_t)
+corenet_tcp_recv_netlabel(telnetd_t)
+corenet_udp_recv_netlabel(telnetd_t)
 corenet_non_ipsec_sendrecv(telnetd_t)
 corenet_tcp_sendrecv_all_if(telnetd_t)
 corenet_udp_sendrecv_all_if(telnetd_t)
Index: refpolicy_svn_repo/policy/modules/services/tftp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/tftp.te
+++ refpolicy_svn_repo/policy/modules/services/tftp.te
@@ -39,6 +39,10 @@ kernel_read_kernel_sysctls(tftpd_t)
 kernel_list_proc(tftpd_t)
 kernel_read_proc_symlinks(tftpd_t)
 
+corenet_tcp_recv_unlabeled(tftpd_t)
+corenet_udp_recv_unlabeled(tftpd_t)
+corenet_tcp_recv_netlabel(tftpd_t)
+corenet_udp_recv_netlabel(tftpd_t)
 corenet_non_ipsec_sendrecv(tftpd_t)
 corenet_tcp_sendrecv_all_if(tftpd_t)
 corenet_udp_sendrecv_all_if(tftpd_t)
Index: refpolicy_svn_repo/policy/modules/services/timidity.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/timidity.te
+++ refpolicy_svn_repo/policy/modules/services/timidity.te
@@ -39,6 +39,10 @@ kernel_read_kernel_sysctls(timidity_t)
 # read /proc/cpuinfo
 kernel_read_system_state(timidity_t)
 
+corenet_tcp_recv_unlabeled(timidity_t)
+corenet_udp_recv_unlabeled(timidity_t)
+corenet_tcp_recv_netlabel(timidity_t)
+corenet_udp_recv_netlabel(timidity_t)
 corenet_non_ipsec_sendrecv(timidity_t)
 corenet_tcp_sendrecv_generic_if(timidity_t)
 corenet_udp_sendrecv_generic_if(timidity_t)
Index: refpolicy_svn_repo/policy/modules/services/tor.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/tor.te
+++ refpolicy_svn_repo/policy/modules/services/tor.te
@@ -63,6 +63,8 @@ files_pid_filetrans(tor_t,tor_var_run_t,
 kernel_read_system_state(tor_t)
 
 # networking basics
+corenet_tcp_recv_unlabeled(tor_t)
+corenet_tcp_recv_netlabel(tor_t)
 corenet_non_ipsec_sendrecv(tor_t)
 corenet_tcp_sendrecv_all_if(tor_t)
 corenet_tcp_sendrecv_all_nodes(tor_t)
Index: refpolicy_svn_repo/policy/modules/services/transproxy.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/transproxy.te
+++ refpolicy_svn_repo/policy/modules/services/transproxy.te
@@ -30,6 +30,8 @@ kernel_read_kernel_sysctls(transproxy_t)
 kernel_list_proc(transproxy_t)
 kernel_read_proc_symlinks(transproxy_t)
 
+corenet_tcp_recv_unlabeled(transproxy_t)
+corenet_tcp_recv_netlabel(transproxy_t)
 corenet_non_ipsec_sendrecv(transproxy_t)
 corenet_tcp_sendrecv_generic_if(transproxy_t)
 corenet_tcp_sendrecv_all_nodes(transproxy_t)
Index: refpolicy_svn_repo/policy/modules/services/ucspitcp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/ucspitcp.te
+++ refpolicy_svn_repo/policy/modules/services/ucspitcp.te
@@ -25,13 +25,17 @@ ucspitcp_service_domain(rblsmtpd_t, rbls
 
 corecmd_search_bin(rblsmtpd_t)
 
+corenet_tcp_recv_unlabeled(rblsmtpd_t)
+corenet_udp_recv_unlabeled(rblsmtpd_t)
+corenet_tcp_recv_netlabel(rblsmtpd_t)
+corenet_udp_recv_netlabel(rblsmtpd_t)
+corenet_non_ipsec_sendrecv(rblsmtpd_t)
 corenet_tcp_sendrecv_all_if(rblsmtpd_t)
 corenet_udp_sendrecv_all_if(rblsmtpd_t)
 corenet_tcp_sendrecv_all_nodes(rblsmtpd_t)
 corenet_udp_sendrecv_all_nodes(rblsmtpd_t)
 corenet_tcp_sendrecv_all_ports(rblsmtpd_t)
 corenet_udp_sendrecv_all_ports(rblsmtpd_t)
-corenet_non_ipsec_sendrecv(rblsmtpd_t)
 corenet_tcp_bind_all_nodes(rblsmtpd_t)
 corenet_udp_bind_generic_port(rblsmtpd_t)
 
@@ -58,6 +62,10 @@ allow ucspitcp_t self:udp_socket create_
 corecmd_search_bin(ucspitcp_t)
 
 # base networking:
+corenet_tcp_recv_unlabeled(ucspitcp_t)
+corenet_udp_recv_unlabeled(ucspitcp_t)
+corenet_tcp_recv_netlabel(ucspitcp_t)
+corenet_udp_recv_netlabel(ucspitcp_t)
 corenet_non_ipsec_sendrecv(ucspitcp_t)
 corenet_tcp_sendrecv_all_if(ucspitcp_t)
 corenet_udp_sendrecv_all_if(ucspitcp_t)
Index: refpolicy_svn_repo/policy/modules/services/uucp.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/uucp.te
+++ refpolicy_svn_repo/policy/modules/services/uucp.te
@@ -70,6 +70,10 @@ kernel_read_kernel_sysctls(uucpd_t)
 kernel_read_system_state(uucpd_t)
 kernel_read_network_state(uucpd_t)
 
+corenet_tcp_recv_unlabeled(uucpd_t)
+corenet_udp_recv_unlabeled(uucpd_t)
+corenet_tcp_recv_netlabel(uucpd_t)
+corenet_udp_recv_netlabel(uucpd_t)
 corenet_non_ipsec_sendrecv(uucpd_t)
 corenet_tcp_sendrecv_all_if(uucpd_t)
 corenet_udp_sendrecv_all_if(uucpd_t)
Index: refpolicy_svn_repo/policy/modules/services/uwimap.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/uwimap.te
+++ refpolicy_svn_repo/policy/modules/services/uwimap.te
@@ -39,6 +39,8 @@ kernel_read_kernel_sysctls(imapd_t)
 kernel_list_proc(imapd_t)
 kernel_read_proc_symlinks(imapd_t)
 
+corenet_tcp_recv_unlabeled(imapd_t)
+corenet_tcp_recv_netlabel(imapd_t)
 corenet_non_ipsec_sendrecv(imapd_t)
 corenet_tcp_sendrecv_generic_if(imapd_t)
 corenet_tcp_sendrecv_all_nodes(imapd_t)
Index: refpolicy_svn_repo/policy/modules/services/watchdog.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/watchdog.te
+++ refpolicy_svn_repo/policy/modules/services/watchdog.te
@@ -43,6 +43,10 @@ kernel_unmount_proc(watchdog_t)
 corecmd_exec_shell(watchdog_t)
 
 # cjp: why networking?
+corenet_tcp_recv_unlabeled(watchdog_t)
+corenet_udp_recv_unlabeled(watchdog_t)
+corenet_tcp_recv_netlabel(watchdog_t)
+corenet_udp_recv_netlabel(watchdog_t)
 corenet_non_ipsec_sendrecv(watchdog_t)
 corenet_tcp_sendrecv_generic_if(watchdog_t)
 corenet_udp_sendrecv_generic_if(watchdog_t)
Index: refpolicy_svn_repo/policy/modules/services/xprint.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xprint.te
+++ refpolicy_svn_repo/policy/modules/services/xprint.te
@@ -33,6 +33,10 @@ kernel_read_kernel_sysctls(xprint_t)
 corecmd_exec_bin(xprint_t)
 corecmd_exec_shell(xprint_t)
 
+corenet_tcp_recv_unlabeled(xprint_t)
+corenet_udp_recv_unlabeled(xprint_t)
+corenet_tcp_recv_netlabel(xprint_t)
+corenet_udp_recv_netlabel(xprint_t)
 corenet_non_ipsec_sendrecv(xprint_t)
 corenet_tcp_sendrecv_generic_if(xprint_t)
 corenet_udp_sendrecv_generic_if(xprint_t)
Index: refpolicy_svn_repo/policy/modules/services/xserver.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xserver.if
+++ refpolicy_svn_repo/policy/modules/services/xserver.if
@@ -94,6 +94,10 @@ template(`xserver_common_domain_template
 	corecmd_exec_bin($1_xserver_t)
 	corecmd_exec_shell($1_xserver_t)
 
+	corenet_tcp_recv_unlabeled($1_xserver_t)
+	corenet_udp_recv_unlabeled($1_xserver_t)
+	corenet_tcp_recv_netlabel($1_xserver_t)
+	corenet_udp_recv_netlabel($1_xserver_t)
 	corenet_non_ipsec_sendrecv($1_xserver_t)
 	corenet_tcp_sendrecv_generic_if($1_xserver_t)
 	corenet_udp_sendrecv_generic_if($1_xserver_t)
Index: refpolicy_svn_repo/policy/modules/services/xserver.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/xserver.te
+++ refpolicy_svn_repo/policy/modules/services/xserver.te
@@ -177,6 +177,10 @@ kernel_read_network_state(xdm_t)
 corecmd_exec_shell(xdm_t)
 corecmd_exec_bin(xdm_t)
 
+corenet_tcp_recv_unlabeled(xdm_t)
+corenet_udp_recv_unlabeled(xdm_t)
+corenet_tcp_recv_netlabel(xdm_t)
+corenet_udp_recv_netlabel(xdm_t)
 corenet_non_ipsec_sendrecv(xdm_t)
 corenet_tcp_sendrecv_generic_if(xdm_t)
 corenet_udp_sendrecv_generic_if(xdm_t)
Index: refpolicy_svn_repo/policy/modules/services/zebra.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/services/zebra.te
+++ refpolicy_svn_repo/policy/modules/services/zebra.te
@@ -67,6 +67,12 @@ kernel_read_system_state(zebra_t)
 kernel_read_kernel_sysctls(zebra_t)
 kernel_rw_net_sysctls(zebra_t)
 
+corenet_tcp_recv_unlabeled(zebra_t)
+corenet_udp_recv_unlabeled(zebra_t)
+corenet_raw_recv_unlabeled(zebra_t)
+corenet_tcp_recv_netlabel(zebra_t)
+corenet_udp_recv_netlabel(zebra_t)
+corenet_raw_recv_netlabel(zebra_t)
 corenet_non_ipsec_sendrecv(zebra_t)
 corenet_tcp_sendrecv_all_if(zebra_t)
 corenet_udp_sendrecv_all_if(zebra_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
