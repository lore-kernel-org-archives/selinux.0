Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbKZq014116
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbH2p008302
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 11:17:21 -0400
Message-Id: <200705301517.l4UFHLjj010415@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: kernel_mls changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Policy used in lspp configurations

--- nsaserefpolicy/policy/modules/kernel/mls.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/kernel/mls.if	2007-05-30 09:25:53.000000000 -0400
@@ -154,6 +154,26 @@
 ########################################
 ## <summary>
 ##	Make specified domain MLS trusted
+##	for writing to sockets at any level
+##	that is dominated by the process clearance.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mls_socket_write_to_clearance',`
+	gen_require(`
+		attribute mlsnetwritetoclr;
+	')
+
+	typeattribute $1 mlsnetwritetoclr;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
 ##	for writing to sockets at any level.
 ## </summary>
 ## <param name="domain">
--- nsaserefpolicy/policy/modules/kernel/mls.te	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/kernel/mls.te	2007-05-30 09:25:53.000000000 -0400
@@ -18,6 +18,7 @@
 attribute mlsnetreadtoclr;
 attribute mlsnetwrite;
 attribute mlsnetwritetoclr;
+attribute mlsnetwriteranged;
 attribute mlsnetupgrade;
 attribute mlsnetdowngrade;
 attribute mlsnetrecvall;
@@ -43,6 +44,8 @@
 attribute mlsxwinwritecolormap;
 attribute mlsxwinwritexinput;
 
+# Object attributes that allow MLS overrides for access by all subjects
+attribute mlsrangedobject;
 attribute mlstrustedobject;
 
 attribute privrangetrans;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
