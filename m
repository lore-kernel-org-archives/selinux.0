Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJhsuI007129
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:43:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJhmU1005759
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:43:49 GMT
Message-ID: <46042DD8.4090608@redhat.com>
Date: Fri, 23 Mar 2007 15:43:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Not sure if I sent this patch before.
Content-Type: multipart/mixed;
 boundary="------------030305060002020201050109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030305060002020201050109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add http_squid_script_t policy,  Also added new ports for squid to talk 
to, sent in previous patch

--------------030305060002020201050109
Content-Type: text/x-patch;
 name="squid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="squid.patch"

--- nsaserefpolicy/policy/modules/services/squid.fc	2006-11-16 17:15:21.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/services/squid.fc	2007-03-22 15:06:59.000000000 -0400
@@ -12,3 +12,5 @@
 /var/run/squid\.pid	--	gen_context(system_u:object_r:squid_var_run_t,s0)
 
 /var/spool/squid(/.*)?		gen_context(system_u:object_r:squid_cache_t,s0)
+/usr/lib/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_squid_script_exec_t,s0)
+/usr/lib64/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_squid_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/squid.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/services/squid.if	2007-03-22 15:06:59.000000000 -0400
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
--- nsaserefpolicy/policy/modules/services/squid.te	2007-03-20 23:38:14.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/squid.te	2007-03-22 15:06:59.000000000 -0400
@@ -81,6 +81,8 @@
 corenet_tcp_bind_ftp_port(squid_t)
 corenet_tcp_bind_gopher_port(squid_t)
 corenet_udp_bind_gopher_port(squid_t)
+corenet_tcp_bind_squid_port(squid_t)
+corenet_udp_bind_squid_port(squid_t)
 corenet_tcp_connect_ftp_port(squid_t)
 corenet_tcp_connect_gopher_port(squid_t)
 corenet_tcp_connect_http_port(squid_t)
@@ -90,6 +92,7 @@
 corenet_sendrecv_gopher_client_packets(squid_t)
 corenet_sendrecv_http_cache_server_packets(squid_t)
 corenet_sendrecv_http_cache_client_packets(squid_t)
+corenet_sendrecv_squid_client_packets(squid_t)
 
 dev_read_sysfs(squid_t)
 dev_read_urand(squid_t)
@@ -174,3 +177,12 @@
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

--------------030305060002020201050109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
