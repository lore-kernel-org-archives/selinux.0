Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KGZecm000399
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 11:35:40 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KGavQc015472
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 16:36:57 GMT
Message-ID: <45DB23A7.1040507@redhat.com>
Date: Tue, 20 Feb 2007 11:36:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Updates to squid policy and corenet policy
Content-Type: multipart/mixed;
 boundary="------------050803090809000802020907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050803090809000802020907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add policy to handle  /usr/lib/squid/cachemgr\.cgi  

Additional squid ports.

Also changed corenetworks to handle hi_reserved_port_t for name_bind only.





--------------050803090809000802020907
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_squid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_services_squid.patch"

--- nsaserefpolicy/policy/modules/services/squid.fc	2006-11-16 17:15:21.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/squid.fc	2007-02-19 16:01:52.000000000 -0500
@@ -12,3 +12,4 @@
 /var/run/squid\.pid	--	gen_context(system_u:object_r:squid_var_run_t,s0)
 
 /var/spool/squid(/.*)?		gen_context(system_u:object_r:squid_cache_t,s0)
+/usr/lib/squid/cachemgr\.cgi	--	gen_context(system_u:object_r:httpd_squid_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/squid.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/squid.if	2007-02-19 16:01:52.000000000 -0500
@@ -36,7 +36,7 @@
 	')
 
 	files_search_etc($1)
-	allow $1 squid_conf_t:file read_file_perms;
+	read_files_pattern($1, squid_conf_t, squid_conf_t)
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/services/squid.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/squid.te	2007-02-19 16:01:52.000000000 -0500
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

--------------050803090809000802020907
Content-Type: text/plain;
 name="nsaserefpolicy_policy_modules_kernel_corenetwork.if.in"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_kernel_corenetwork.if.in"

--- nsaserefpolicy/policy/modules/kernel/corenetwork.if.in	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/kernel/corenetwork.if.in	2007-02-20 10:34:05.000000000 -0500
@@ -1034,10 +1034,10 @@
 #
 interface(`corenet_tcp_sendrecv_reserved_port',`
 	gen_require(`
-		type reserved_port_t;
+		attribute reserved_port_type;
 	')
 
-	allow $1 reserved_port_t:tcp_socket { send_msg recv_msg };
+	allow $1 reserved_port_type:tcp_socket { send_msg recv_msg };
 ')
 
 ########################################
@@ -1052,10 +1052,10 @@
 #
 interface(`corenet_udp_send_reserved_port',`
 	gen_require(`
-		type reserved_port_t;
+		attribute reserved_port_type;
 	')
 
-	allow $1 reserved_port_t:udp_socket send_msg;
+	allow $1 reserved_port_type:udp_socket send_msg;
 ')
 
 ########################################
@@ -1070,10 +1070,10 @@
 #
 interface(`corenet_udp_receive_reserved_port',`
 	gen_require(`
-		type reserved_port_t;
+		attribute reserved_port_type;
 	')
 
-	allow $1 reserved_port_t:udp_socket recv_msg;
+	allow $1 reserved_port_type:udp_socket recv_msg;
 ')
 
 ########################################
@@ -1103,10 +1103,10 @@
 #
 interface(`corenet_tcp_bind_reserved_port',`
 	gen_require(`
-		type reserved_port_t;
+		type hi_reserved_port_t;
 	')
 
-	allow $1 reserved_port_t:tcp_socket name_bind;
+	allow $1 hi_reserved_port_t:tcp_socket name_bind;
 	allow $1 self:capability net_bind_service;
 ')
 
@@ -1122,10 +1122,10 @@
 #
 interface(`corenet_udp_bind_reserved_port',`
 	gen_require(`
-		type reserved_port_t;
+		type hi_reserved_port_t;
 	')
 
-	allow $1 reserved_port_t:udp_socket name_bind;
+	allow $1 hi_reserved_port_t:udp_socket name_bind;
 	allow $1 self:capability net_bind_service;
 ')
 
@@ -1141,10 +1141,10 @@
 #
 interface(`corenet_tcp_connect_reserved_port',`
 	gen_require(`
-		type reserved_port_t;
+		attribute reserved_port_type;
 	')
 
-	allow $1 reserved_port_t:tcp_socket name_connect;
+	allow $1 reserved_port_type:tcp_socket name_connect;
 ')
 
 ########################################

--------------050803090809000802020907
Content-Type: text/plain;
 name="nsaserefpolicy_policy_modules_kernel_corenetwork.te.in"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_kernel_corenetwork.te.in"

--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/kernel/corenetwork.te.in	2007-02-20 10:22:47.000000000 -0500
@@ -43,11 +43,16 @@
 sid port gen_context(system_u:object_r:port_t,s0)
 
 #
-# reserved_port_t is the type of INET port numbers below 1024.
+# reserved_port_t is the type of INET port numbers below 599.
 #
 type reserved_port_t, port_type, reserved_port_type;
 
 #
+# hi_reserved_port_t is the type of INET port numbers between 600-1023.
+#
+type hi_reserved_port_t, port_type, reserved_port_type, rpc_port_type;
+
+#
 # server_packet_t is the default type of IPv4 and IPv6 server packets.
 #
 type server_packet_t, packet_type, server_packet_type;
@@ -140,6 +145,7 @@
 network_port(soundd, tcp,8000,s0, tcp,9433,s0)
 type socks_port_t, port_type; dnl network_port(socks) # no defined portcon
 type stunnel_port_t, port_type; dnl network_port(stunnel) # no defined portcon in current strict
+network_port(squid, udp,3401,s0, tcp,3401,s0, udp,4827,s0, tcp,4827,s0, )
 network_port(swat, tcp,901,s0)
 network_port(syslogd, udp,514,s0)
 network_port(telnetd, tcp,23,s0)
@@ -157,8 +163,11 @@
 
 # Defaults for reserved ports.  Earlier portcon entries take precedence;
 # these entries just cover any remaining reserved ports not otherwise declared.
-portcon tcp 1-1023 gen_context(system_u:object_r:reserved_port_t, s0)
-portcon udp 1-1023 gen_context(system_u:object_r:reserved_port_t, s0)
+
+portcon tcp 600-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
+portcon udp 600-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
+portcon tcp 1-599 gen_context(system_u:object_r:reserved_port_t, s0)
+portcon udp 1-599 gen_context(system_u:object_r:reserved_port_t, s0)
 
 ########################################
 #

--------------050803090809000802020907
Content-Type: application/x-m4;
 name="nsaserefpolicy_policy_modules_kernel_corenetwork.te.m4"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_kernel_corenetwork.te.m4"

LS0tIG5zYXNlcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL2tlcm5lbC9jb3JlbmV0d29yay50
ZS5tNAkyMDA2LTExLTE2IDE3OjE1OjA0LjAwMDAwMDAwMCAtMDUwMAorKysgc2VyZWZwb2xp
Y3ktMi41LjQvcG9saWN5L21vZHVsZXMva2VybmVsL2NvcmVuZXR3b3JrLnRlLm00CTIwMDct
MDItMTkgMTY6MDE6NTIuMDAwMDAwMDAwIC0wNTAwCkBAIC01NSw4ICs1NSw4IEBACiBkZWZp
bmUoYGRlY2xhcmVfcG9ydHMnLGBkbmwKIGlmZWxzZShldmFsKCQzIDwgMTAyNCksMSxgCiB0
eXBlYXR0cmlidXRlICQxIHJlc2VydmVkX3BvcnRfdHlwZTsKLSNiaW5kcmVzdnBvcnQgaW4g
Z2xpYmMgc3RhcnRzIHNlYXJjaGluZyBmb3IgcmVzZXJ2ZWQgcG9ydHMgYXQgNjAwCi1pZmVs
c2UoZXZhbCgkMyA+PSA2MDApLDEsYHR5cGVhdHRyaWJ1dGUgJDEgcnBjX3BvcnRfdHlwZTsn
LGBkbmwnKQorI2JpbmRyZXN2cG9ydCBpbiBnbGliYyBzdGFydHMgc2VhcmNoaW5nIGZvciBy
ZXNlcnZlZCBwb3J0cyBhdCA1MTIKK2lmZWxzZShldmFsKCQzID49IDUxMiksMSxgdHlwZWF0
dHJpYnV0ZSAkMSBycGNfcG9ydF90eXBlOycsYGRubCcpCiAnLGBkbmwnKQogcG9ydGNvbiAk
MiAkMyBnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3RfcjokMSwkNCkKIGlmZWxzZShgJDUn
LGAnLGAnLGBkZWNsYXJlX3BvcnRzKCQxLHNoaWZ0big0LCQqKSknKWRubAo=
--------------050803090809000802020907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
