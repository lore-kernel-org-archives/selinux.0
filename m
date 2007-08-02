Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Jt6bQ021043
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:55:06 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Jt5OD028113
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:55:05 GMT
Date: Thu, 2 Aug 2007 15:55:00 -0400
Message-Id: <200708021955.l72Jt0ri029372@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: apps_ada changes add ada_run policy for unconfined user
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/apps/ada.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/apps/ada.if	2007-08-02 11:02:02.000000000 -0400
@@ -18,3 +18,34 @@
 	corecmd_search_bin($1)
 	domtrans_pattern($1, ada_exec_t, ada_t)
 ')
+
+########################################
+## <summary>
+##	Execute ada in the ada domain, and
+##	allow the specified role the ada domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the ada domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the ada domain to use.
+##	</summary>
+## </param>
+#
+interface(`ada_run',`
+	gen_require(`
+		type ada_t;
+	')
+
+	ada_domtrans($1)
+	role $2 types ada_t;
+	allow ada_t $3:chr_file rw_term_perms;
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
