Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74Cc3ZM012044
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:38:03 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Cc27E010559
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:38:02 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 3C5E01AB
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:38:01 +0200 (CEST)
Message-Id: <20080804123735.658128129@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:03 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 07/35] w3c policy addition
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a new module not present upstream, contains nothing that
looks controversial.

I've added one Debian path, perhaps it should be in a
conditional block...(/usr/lib/cgi-bin/check)

Originally submitted Jul 19, no comments so far

Index: refpolicy/policy/modules/services/w3c.fc
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ refpolicy/policy/modules/services/w3c.fc	2008-08-03 17:13:33.000000000 +0200
@@ -0,0 +1,3 @@
+/usr/share/w3c-markup-validator(/.*)?		gen_context(system_u:object_r:httpd_w3c_validator_content_t,s0)
+/usr/share/w3c-markup-validator/cgi-bin(/.*)?	gen_context(system_u:object_r:httpd_w3c_validator_script_exec_t,s0)
+/usr/lib/cgi-bin/check				gen_context(system_u:object_r:httpd_w3c_validator_script_exec_t,s0)
Index: refpolicy/policy/modules/services/w3c.if
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ refpolicy/policy/modules/services/w3c.if	2008-08-03 17:13:33.000000000 +0200
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
Index: refpolicy/policy/modules/services/w3c.te
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ refpolicy/policy/modules/services/w3c.te	2008-08-03 17:13:33.000000000 +0200
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
