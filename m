Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5N9OCNW013431
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 05:24:12 -0400
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5N9OAAS014546
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 09:24:11 GMT
Message-ID: <485F6BAE.305@ak.jp.nec.com>
Date: Mon, 23 Jun 2008 18:23:58 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] CGI scripts/PostgreSQL stream connect
Content-Type: multipart/mixed;
 boundary="------------090504040708020300000501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090504040708020300000501
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch allows CGI scripts to connect PostgreSQL
via unix domain socket, as MySQL doing.

Please apply it.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------090504040708020300000501
Content-Type: text/x-patch;
 name="refpolicy-cgi-pgsql-stream.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-cgi-pgsql-stream.patch"

Index: refpolicy/policy/modules/services/apache.te
===================================================================
--- refpolicy/policy/modules/services/apache.te	(revision 2727)
+++ refpolicy/policy/modules/services/apache.te	(working copy)
@@ -559,6 +559,10 @@
 ')
 
 optional_policy(`
+	postgresql_stream_connect(httpd_php_t)
+')
+
+optional_policy(`
 	nis_use_ypbind(httpd_php_t)
 ')
 
@@ -703,6 +707,10 @@
 	mysql_rw_db_sockets(httpd_sys_script_t)
 ')
 
+optional_policy(`
+	postgresql_stream_connect(httpd_sys_script_t)
+')
+
 ########################################
 #
 # httpd_rotatelogs local policy

--------------090504040708020300000501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
