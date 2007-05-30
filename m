Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbKOn014085
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbH2p008301
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 11:39:09 -0400
Message-Id: <200705301539.l4UFd9QD011809@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: kernel_selinux changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional interfaces for access to /selinux
--- nsaserefpolicy/policy/modules/kernel/selinux.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/kernel/selinux.if	2007-05-30 09:25:53.000000000 -0400
@@ -51,6 +51,44 @@
 
 ########################################
 ## <summary>
+##	Do not audit attempts to get the
+##	attributes of the selinuxfs filesystem
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`selinux_dontaudit_getattr_fs',`
+	gen_require(`
+		type security_t;
+	')
+
+	dontaudit $1 security_t:filesystem getattr;
+')
+
+########################################
+## <summary>
+##	Allow domain to get the
+##	attributes of the selinuxfs filesystem
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`selinux_getattr_fs',`
+	gen_require(`
+		type security_t;
+	')
+
+	allow $1 security_t:filesystem getattr;
+')
+
+########################################
+## <summary>
 ##	Search selinuxfs.
 ## </summary>
 ## <param name="domain">

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
