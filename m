Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHaqCg013752
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHao2p008203
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:50 GMT
Date: Wed, 30 May 2007 11:41:46 -0400
Message-Id: <200705301541.l4UFfkJP011850@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: apps_java changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Allow apps writers to write transition rules when executing java
--- nsaserefpolicy/policy/modules/apps/java.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/apps/java.if	2007-05-30 09:25:53.000000000 -0400
@@ -220,3 +220,35 @@
 	corecmd_search_bin($1)
 	domtrans_pattern($1, java_exec_t, java_t)
 ')
+
+########################################
+## <summary>
+##	Execute a java in the specified domain
+## </summary>
+## <desc>
+##	<p>
+##	Execute the java command in the specified domain.  This allows
+##	the specified domain to execute any file
+##	on these filesystems in the specified
+##	domain. 
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="target_domain">
+##	<summary>
+##	The type of the new process.
+##	</summary>
+## </param>
+#
+interface(`java_spec_domtrans',`
+	gen_require(`
+		type java_exec_t;
+	')
+
+	domain_trans($1,java_exec_t,$2)
+	type_transition $1 java_exec_t:process $2;
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
