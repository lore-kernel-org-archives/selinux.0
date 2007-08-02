Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72IUC4M013520
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:30:12 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72IUBOD012110
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:30:11 GMT
Message-ID: <46B222AF.7070205@redhat.com>
Date: Thu, 02 Aug 2007 14:30:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: [PATCH] refpolicy: services_w3c changes]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Any reason to not add this policy 
--- nsaserefpolicy/policy/modules/services/w3c.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.4/policy/modules/services/w3c.fc	2007-07-25 12:27:26.000000000 -0400
@@ -0,0 +1,2 @@
+/usr/share/w3c-markup-validator(/.*)?		gen_context(system_u:object_r:httpd_w3c_validator_content_t,s0)
+/usr/share/w3c-markup-validator/cgi-bin(/.*)?	gen_context(system_u:object_r:httpd_w3c_validator_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/w3c.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.4/policy/modules/services/w3c.if	2007-07-25 12:27:26.000000000 -0400
@@ -0,0 +1 @@
+## <summary>W3C</summary>
--- nsaserefpolicy/policy/modules/services/w3c.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.4/policy/modules/services/w3c.te	2007-07-25 12:27:26.000000000 -0400
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
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
