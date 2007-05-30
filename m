Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHapWk013699
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHanue002796
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:49 GMT
Date: Wed, 30 May 2007 11:16:40 -0400
Message-Id: <200705301516.l4UFGeH5010406@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: kernel_terminal changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Console is a legitimate login device on s390,

--- nsaserefpolicy/policy/modules/kernel/terminal.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/kernel/terminal.if	2007-05-30 09:25:53.000000000 -0400
@@ -278,6 +278,25 @@
 
 ########################################
 ## <summary>
+##	Relabel from and to the console_device_t
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`term_relabel_console',`
+	gen_require(`
+		type console_device_t;
+	')
+
+	dev_list_all_dev_nodes($1)
+	allow $1 console_device_t:chr_file { relabelfrom relabelto };
+')
+
+########################################
+## <summary>
 ##	Create the console device (/dev/console).
 ## </summary>
 ## <param name="domain">
@@ -1052,7 +1071,7 @@
 	')
 
 	dev_list_all_dev_nodes($1)
-	allow $1 ttynode:chr_file { getattr write };
+	allow $1 ttynode:chr_file { getattr write append };
 ')
 
 ########################################

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
