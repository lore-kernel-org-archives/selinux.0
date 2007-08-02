Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JuYwX021162
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:56:34 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JuXOD028311
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:56:33 GMT
Date: Thu, 2 Aug 2007 15:55:29 -0400
Message-Id: <200708021955.l72JtTch029403@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: apps_wine changes add run interface
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/apps/wine.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/apps/wine.if	2007-08-02 11:02:02.000000000 -0400
@@ -18,3 +18,34 @@
 	corecmd_search_bin($1)
 	domtrans_pattern($1, wine_exec_t, wine_t)
 ')
+
+########################################
+## <summary>
+##	Execute wine in the wine domain, and
+##	allow the specified role the wine domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the wine domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the wine domain to use.
+##	</summary>
+## </param>
+#
+interface(`wine_run',`
+	gen_require(`
+		type wine_t;
+	')
+
+	wine_domtrans($1)
+	role $2 types wine_t;
+	allow wine_t $3:chr_file rw_term_perms;
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
