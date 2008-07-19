Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL4eIH024592
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:04:40 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL4c5T025074
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:04:39 GMT
Message-Id: <20080719210253.603531609@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:18 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 16/23] w3c policy addition
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a new module not present upstream, contains nothing that
looks controversial.

I've added one Debian path, perhaps it should be in a
conditional block...(/usr/lib/cgi-bin/check)

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/w3c.fc serefpolicy-3.5.0/policy/modules/services/w3c.fc
--- nsaserefpolicy/policy/modules/services/w3c.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.5.0/policy/modules/services/w3c.fc	2008-07-15 14:05:13.000000000 -0400
@@ -0,0 +1,3 @@
+/usr/share/w3c-markup-validator(/.*)?		gen_context(system_u:object_r:httpd_w3c_validator_content_t,s0)
+/usr/share/w3c-markup-validator/cgi-bin(/.*)?	gen_context(system_u:object_r:httpd_w3c_validator_script_exec_t,s0)
+/usr/lib/cgi-bin/check				gen_context(system_u:object_r:httpd_w3c_validator_script_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/w3c.if serefpolicy-3.5.0/policy/modules/services/w3c.if
--- nsaserefpolicy/policy/modules/services/w3c.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.5.0/policy/modules/services/w3c.if	2008-07-15 14:05:13.000000000 -0400
@@ -0,0 +1,20 @@
+## <summary>W3C</summary>
+
+########################################
+## <summary>
+##	Execute w3c server in the w3c domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+#
+interface(`w3c_script_domtrans',`
+	gen_require(`
+		type w3c_script_exec_t;
+	')
+
+	init_script_domtrans_spec($1,w3c_script_exec_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/w3c.te serefpolicy-3.5.0/policy/modules/services/w3c.te
--- nsaserefpolicy/policy/modules/services/w3c.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.5.0/policy/modules/services/w3c.te	2008-07-15 14:05:13.000000000 -0400
@@ -0,0 +1,14 @@
+policy_module(w3c,1.2.1)
+
+apache_content_template(w3c_validator)
+
+sysnet_dns_name_resolve(httpd_w3c_validator_script_t)
+
+corenet_tcp_connect_ftp_port(httpd_w3c_validator_script_t)
+corenet_tcp_sendrecv_ftp_port(httpd_w3c_validator_script_t)
+corenet_tcp_connect_http_port(httpd_w3c_validator_script_t)
+corenet_tcp_sendrecv_http_port(httpd_w3c_validator_script_t)
+corenet_tcp_connect_http_cache_port(httpd_w3c_validator_script_t)
+corenet_tcp_sendrecv_http_cache_port(httpd_w3c_validator_script_t)
+
+miscfiles_read_certs(httpd_w3c_validator_script_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
