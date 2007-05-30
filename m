Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbxPZ014618
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbs2p008438
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:55 GMT
Date: Wed, 30 May 2007 10:25:26 -0400
Message-Id: <200705301425.l4UEPQsf007799@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Interfaces to access rwho private date
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think we should define access to all private data types, and define all interfaces to this data.  This will allow third parties building policy modules to easily use the interfaces.  Currently many times when I go to build a policy module, other domains do not have a complete set of interfaces.

--- nsaserefpolicy/policy/modules/services/rwho.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/rwho.if	2007-05-30 09:08:15.000000000 -0400
@@ -1 +1,84 @@
-## <summary>Who is logged in on other machines?</summary>
+
+## <summary>policy for rwho</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run rwho.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`rwho_domtrans',`
+	gen_require(`
+		type rwho_t, rwho_exec_t;
+	')
+
+	domain_auto_trans($1,rwho_exec_t,rwho_t)
+
+	allow rwho_t $1:fd use;
+	allow rwho_t $1:fifo_file rw_file_perms;
+	allow rwho_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Search rwho spool directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`rwho_search_spool',`
+	gen_require(`
+		type rwho_spool_t;
+	')
+
+	allow $1 rwho_spool_t:dir search_dir_perms;
+	files_search_spool($1)
+')
+
+########################################
+## <summary>
+##	Read rwho spool files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`rwho_read_spool_files',`
+	gen_require(`
+		type rwho_spool_t;
+	')
+
+	allow $1 rwho_spool_t:file r_file_perms;
+	allow $1 rwho_spool_t:dir list_dir_perms;
+	files_search_spool($1)
+')
+
+########################################
+## <summary>
+##	Create, read, write, and delete
+##	rwho spool files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`rwho_manage_spool_files',`
+	gen_require(`
+		type rwho_spool_t;
+	')
+
+	allow $1 rwho_spool_t:file manage_file_perms;
+	allow $1 rwho_spool_t:dir rw_dir_perms;
+	files_search_spool($1)
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
