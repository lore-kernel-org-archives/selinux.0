Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JF8x67027209
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 11:08:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JF8wUG021392
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 15:08:58 GMT
Message-ID: <46278600.2010806@redhat.com>
Date: Thu, 19 Apr 2007 11:08:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: squid patch
Content-Type: multipart/mixed;
 boundary="------------040304020504000201010706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040304020504000201010706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added httpd_squid_script_t

squid_conf_t can be a directory
Squid also needs additional ports to communicate with

dovecot and snmp try to read squid files.  (Snuck in a couple of other 
fixes for dovecot and snmp)

--------------040304020504000201010706
Content-Type: text/x-patch;
 name="squid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="squid.patch"

--- nsaserefpolicy/policy/modules/services/squid.fc	2006-11-16 17:15:21.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/squid.fc	2007-04-11 17:07:34.000000000 -0400
@@ -12,3 +12,5 @@
 /var/run/squid\.pid	--	gen_context(system_u:object_r:squid_var_run_t,s0)
 
 /var/spool/squid(/.*)?		gen_context(system_u:object_r:squid_cache_t,s0)
+/usr/lib/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_squid_script_exec_t,s0)
+/usr/lib64/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_squid_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/squid.if	2007-03-26 10:39:04.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/squid.if	2007-04-11 17:07:34.000000000 -0400
@@ -36,7 +36,7 @@
 	')
 
 	files_search_etc($1)
-	allow $1 squid_conf_t:file read_file_perms;
+	read_files_pattern($1, squid_conf_t, squid_conf_t)
 ')
 
 ########################################
@@ -112,3 +112,23 @@
 interface(`squid_use',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+########################################
+## <summary>
+##	dontaudit search squid cache dirs
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`squid_dontaudit_search_squid_cache',`
+	gen_require(`
+		type squid_cache_t;
+	')
+
+	dontaudit $1 squid_cache_t:dir search_dir_perms;
+')
+
--- nsaserefpolicy/policy/modules/services/squid.te	2007-03-26 16:24:12.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/squid.te	2007-04-11 17:07:34.000000000 -0400
@@ -89,6 +89,8 @@
 corenet_tcp_bind_ftp_port(squid_t)
 corenet_tcp_bind_gopher_port(squid_t)
 corenet_udp_bind_gopher_port(squid_t)
+corenet_tcp_bind_squid_port(squid_t)
+corenet_udp_bind_squid_port(squid_t)
 corenet_tcp_connect_ftp_port(squid_t)
 corenet_tcp_connect_gopher_port(squid_t)
 corenet_tcp_connect_http_port(squid_t)
@@ -98,6 +100,7 @@
 corenet_sendrecv_gopher_client_packets(squid_t)
 corenet_sendrecv_http_cache_server_packets(squid_t)
 corenet_sendrecv_http_cache_client_packets(squid_t)
+corenet_sendrecv_squid_client_packets(squid_t)
 
 dev_read_sysfs(squid_t)
 dev_read_urand(squid_t)
@@ -181,3 +184,12 @@
 #squid requires the following when run in diskd mode, the recommended setting
 allow squid_t tmpfs_t:file { read write };
 ') dnl end TODO
+
+optional_policy(`
+	apache_content_template(squid)
+	corenet_tcp_connect_http_cache_port(httpd_squid_script_t)
+	squid_read_config(httpd_squid_script_t)
+	allow httpd_squid_script_t self:tcp_socket create_socket_perms;
+	sysnet_read_config(httpd_squid_script_t)
+	corenet_non_ipsec_sendrecv(httpd_squid_script_t)
+')
--- nsaserefpolicy/policy/modules/services/snmp.te	2007-03-26 10:39:04.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/snmp.te	2007-04-11 17:07:34.000000000 -0400
@@ -134,6 +134,11 @@
 ')
 
 optional_policy(`
+	mta_read_config(snmpd_t)
+	mta_search_queue(snmpd_t)
+')
+
+optional_policy(`
 	nis_use_ypbind(snmpd_t)
 ')
 
@@ -146,9 +151,19 @@
 ')
 
 optional_policy(`
+	sendmail_read_log(snmpd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(snmpd_t)
 ')
 
 optional_policy(`
+	squid_read_config(snmpd_t)
+')
+
+optional_policy(`
 	udev_read_db(snmpd_t)
 ')
+
+
--- nsaserefpolicy/policy/modules/services/dovecot.te	2007-03-20 23:38:12.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/dovecot.te	2007-04-11 17:07:34.000000000 -0400
@@ -46,6 +46,7 @@
 allow dovecot_t self:tcp_socket create_stream_socket_perms;
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket { create_stream_socket_perms connectto };
+allow dovecot_t self:netlink_route_socket r_netlink_socket_perms;
 
 domtrans_pattern(dovecot_t, dovecot_auth_exec_t, dovecot_auth_t)
 
@@ -140,6 +141,10 @@
 	udev_read_db(dovecot_t)
 ')
 
+optional_policy(`
+	squid_dontaudit_search_squid_cache(dovecot_t)
+')
+
 ########################################
 #
 # dovecot auth local policy
--- nsaserefpolicy/policy/modules/services/apache.fc	2007-02-23 16:50:01.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/apache.fc	2007-04-11 17:07:34.000000000 -0400
@@ -21,7 +16,6 @@
 
 /usr/lib/apache-ssl/.+		--	gen_context(system_u:object_r:httpd_exec_t,s0)
 /usr/lib/cgi-bin(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
-/usr/lib/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_exec_t,s0)
 /usr/lib(64)?/apache(/.*)?		gen_context(system_u:object_r:httpd_modules_t,s0)
 /usr/lib(64)?/apache2/modules(/.*)?	gen_context(system_u:object_r:httpd_modules_t,s0)
 /usr/lib(64)?/apache(2)?/suexec(2)? --	gen_context(system_u:object_r:httpd_suexec_exec_t,s0)
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2007-04-11 15:52:53.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/kernel/corenetwork.te.in	2007-04-17 15:19:50.000000000 -0400
@@ -140,6 +147,7 @@
 network_port(soundd, tcp,8000,s0, tcp,9433,s0)
 type socks_port_t, port_type; dnl network_port(socks) # no defined portcon
 type stunnel_port_t, port_type; dnl network_port(stunnel) # no defined portcon in current strict
+network_port(squid, udp,3401,s0, tcp,3401,s0, udp,4827,s0, tcp,4827,s0, )
 network_port(swat, tcp,901,s0)
 network_port(syslogd, udp,514,s0)
 network_port(telnetd, tcp,23,s0)
 

--------------040304020504000201010706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
