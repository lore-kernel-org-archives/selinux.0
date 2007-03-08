Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28EQdVI003913
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:26:39 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28EQcko001650
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:26:38 GMT
Message-ID: <45F01D15.4010201@redhat.com>
Date: Thu, 08 Mar 2007 09:26:29 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Squid changes
Content-Type: multipart/mixed;
 boundary="------------040608060605020403080207"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040608060605020403080207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Use a http_squid_script_exec_t to /usr/lib/squid/cachemgr

squid_read_conf needs to read directories also.

New squid ports.



--------------040608060605020403080207
Content-Type: text/x-patch;
 name="squid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="squid.patch"

--- nsaserefpolicy/policy/modules/services/squid.fc	2006-11-16 17:15:21.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/squid.fc	2007-03-08 08:42:37.000000000 -0500
@@ -12,3 +12,4 @@
 /var/run/squid\.pid	--	gen_context(system_u:object_r:squid_var_run_t,s0)
 
 /var/spool/squid(/.*)?		gen_context(system_u:object_r:squid_cache_t,s0)
+/usr/lib/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_squid_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/squid.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/squid.if	2007-03-08 08:42:37.000000000 -0500
@@ -36,7 +36,7 @@
 	')
 
 	files_search_etc($1)
-	allow $1 squid_conf_t:file read_file_perms;
+	read_files_pattern($1, squid_conf_t, squid_conf_t)
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/services/squid.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/squid.te	2007-03-08 08:42:37.000000000 -0500
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
@@ -178,3 +181,12 @@
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
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/kernel/corenetwork.te.in	2007-03-08 08:42:36.000000000 -0500
@@ -140,6 +145,7 @@
 network_port(soundd, tcp,8000,s0, tcp,9433,s0)
 type socks_port_t, port_type; dnl network_port(socks) # no defined portcon
 type stunnel_port_t, port_type; dnl network_port(stunnel) # no defined portcon in current strict
+network_port(squid, udp,3401,s0, tcp,3401,s0, udp,4827,s0, tcp,4827,s0, )
 network_port(swat, tcp,901,s0)
 network_port(syslogd, udp,514,s0)
 network_port(telnetd, tcp,23,s0)

--------------040608060605020403080207--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
