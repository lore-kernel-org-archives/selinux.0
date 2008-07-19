Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL7drw025093
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:07:39 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL7cTc007533
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:07:38 GMT
Message-Id: <20080719210252.686782832@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:12 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 10/23] courier policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adds a separate context for courier spooling dirs/files and a few
new interfaces.

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/courier.fc serefpolicy-3.5.0/policy/modules/services/courier.fc
--- nsaserefpolicy/policy/modules/services/courier.fc	2008-06-12 23:25:05.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/services/courier.fc	2008-07-15 14:05:12.000000000 -0400
@@ -19,3 +19,5 @@
 /var/lib/courier(/.*)?			--	gen_context(system_u:object_r:courier_var_lib_t,s0)
 
 /var/run/courier(/.*)?			--	gen_context(system_u:object_r:courier_var_run_t,s0)
+
+/var/spool/courier(/.*)?		gen_context(system_u:object_r:courier_spool_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/courier.if serefpolicy-3.5.0/policy/modules/services/courier.if
--- nsaserefpolicy/policy/modules/services/courier.if	2008-06-12 23:25:06.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/services/courier.if	2008-07-15 14:05:12.000000000 -0400
@@ -123,3 +123,77 @@
 
 	domtrans_pattern($1, courier_pop_exec_t, courier_pop_t)
 ')
+
+
+########################################
+## <summary>
+##	Allow domain to read courier config files
+## </summary>
+## <param name="prefix">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`courier_read_config',`
+	gen_require(`
+		type courier_etc_t;
+	')
+
+	read_files_pattern($1, courier_etc_t, courier_etc_t)
+')
+
+########################################
+## <summary>
+##	Allow domain to manage courier spool directories
+## </summary>
+## <param name="prefix">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`courier_manage_spool_dirs',`
+	gen_require(`
+		type courier_spool_t;
+	')
+
+	manage_dirs_pattern($1, courier_spool_t, courier_spool_t)
+')
+
+########################################
+## <summary>
+##	Allow domain to manage courier spool files
+## </summary>
+## <param name="prefix">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`courier_manage_spool_files',`
+	gen_require(`
+		type courier_spool_t;
+	')
+
+	manage_files_pattern($1, courier_spool_t, courier_spool_t)
+')
+
+########################################
+## <summary>
+##	Allow attempts to read and write to
+##	courier unnamed pipes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`courier_rw_pipes',`
+	gen_require(`
+		type courier_spool_t;
+	')
+
+	allow $1 courier_spool_t:fifo_file rw_fifo_file_perms; 
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/courier.te serefpolicy-3.5.0/policy/modules/services/courier.te
--- nsaserefpolicy/policy/modules/services/courier.te	2008-07-10 11:38:46.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/services/courier.te	2008-07-15 14:05:12.000000000 -0400
@@ -9,7 +9,10 @@
 courier_domain_template(authdaemon)
 
 type courier_etc_t;
-files_type(courier_etc_t)
+files_config_file(courier_etc_t)
+
+type courier_spool_t;
+files_type(courier_spool_t)
 
 courier_domain_template(pcp)
 
@@ -25,6 +28,7 @@
 
 type courier_exec_t;
 files_type(courier_exec_t)
+mta_mailclient(courier_exec_t)
 
 courier_domain_template(sqwebmail)
 typealias courier_sqwebmail_exec_t alias sqwebmail_cron_exec_t;
@@ -97,12 +101,12 @@
 courier_domtrans_authdaemon(courier_pop_t)
 
 # do the actual work (read the Maildir)
-userdom_manage_unpriv_users_home_content_files(courier_pop_t)
+unprivuser_manage_home_content_files(courier_pop_t)
 # cjp: the fact that this is different for pop vs imap means that
 # there should probably be a courier_pop_t and courier_imap_t
 # this should also probably be a separate type too instead of
 # the regular home dir
-userdom_manage_unpriv_users_home_content_dirs(courier_pop_t)
+unprivuser_manage_home_content_dirs(courier_pop_t)
 
 ########################################
 #

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
