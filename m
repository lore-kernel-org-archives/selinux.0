Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Kpp1X027053
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:51:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KpnTm009187
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:51:49 GMT
Date: Thu, 2 Aug 2007 16:51:45 -0400
Message-Id: <200708022051.l72Kpj70000490@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_lpd changes New interface for samba
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/lpd.if	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/lpd.if	2007-08-02 11:02:02.000000000 -0400
@@ -394,3 +394,22 @@
 
 	domtrans_pattern($2, lpr_exec_t, $1_lpr_t)
 ')
+
+########################################
+## <summary>
+##	Allow the specified domain to execute lpr
+##	in the caller domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`lpd_exec_lpr',`
+	gen_require(`
+		type lpr_exec_t;
+	')
+
+	can_exec($1,lpr_exec_t)
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
