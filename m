Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BIT6K1030053
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 14:29:06 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5BIT5QD029648
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 18:29:05 GMT
Message-ID: <4850190B.4000407@redhat.com>
Date: Wed, 11 Jun 2008 14:27:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: postgresql fedora differences
Content-Type: multipart/mixed;
 boundary="------------020509000206080808040201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020509000206080808040201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------020509000206080808040201
Content-Type: text/plain;
 name="services_postgresql.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="services_postgresql.patch"

Subject: [PATCH] refpolicy: services_postgresql changes
--text follows this line--
--- nsaserefpolicy/policy/modules/services/postgresql.fc	2008-06-11 08:15:44.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/services/postgresql.fc	2008-06-11 13:29:23.000000000 -0400
@@ -34,6 +34,7 @@
 /var/lib/sepgsql/pgstartup\.log	--	gen_context(system_u:object_r:postgresql_log_t,s0)
 
 /var/log/postgres\.log.* 	--	gen_context(system_u:object_r:postgresql_log_t,s0)
+/var/lib/pgsql/logfile(/.*)?		gen_context(system_u:object_r:postgresql_log_t,s0)
 /var/log/postgresql(/.*)?		gen_context(system_u:object_r:postgresql_log_t,s0)
 /var/log/sepostgresql\.log.*	--	gen_context(system_u:object_r:postgresql_log_t,s0)
 
@@ -42,3 +43,5 @@
 ')
 
 /var/run/postgresql(/.*)?		gen_context(system_u:object_r:postgresql_var_run_t,s0)
+
+/etc/rc\.d/init\.d/postgresql	--	gen_context(system_u:object_r:postgresql_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/postgresql.if	2008-06-11 08:15:44.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/services/postgresql.if	2008-06-11 13:35:43.000000000 -0400
@@ -375,3 +375,72 @@
 
 	typeattribute $1 sepgsql_unconfined_type;
 ')
+
+########################################
+## <summary>
+##	Execute postgresql server in the posgresql domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`postgresql_script_domtrans',`
+	gen_require(`
+		type postgresql_script_exec_t;
+	')
+
+	init_script_domtrans_spec($1,postgresql_script_exec_t)
+')
+
+########################################
+## <summary>
+##	All of the rules required to administrate an postgresql environment
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed to manage the postgresql domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the postgresql domain to use.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`postgresql_admin',`
+	gen_require(`
+		type postgresql_t;
+		type postgresql_var_run_t;
+		type postgresql_tmp_t;
+		type postgresql_db_t;
+		type postgresql_etc_t;
+		type postgresql_log_t;
+	')
+
+	allow $1 postgresql_t:process { ptrace signal_perms getattr };
+	read_files_pattern($1, postgresql_t, postgresql_t)
+
+	# Allow $1 to restart the apache service
+	postgresql_script_domtrans($1)
+	domain_system_change_exemption($1)
+	role_transition $2 postgresql_script_exec_t system_r;
+	allow $2 system_r;
+
+	manage_all_pattern($1,postgresql_var_run_t)
+
+	manage_all_pattern($1,postgresql_db_t)
+
+	manage_all_pattern($1,postgresql_etc_t)
+
+	manage_all_pattern($1,postgresql_log_t)
+
+	manage_all_pattern($1,postgresql_tmp_t)
+')
--- nsaserefpolicy/policy/modules/services/postgresql.te	2008-06-11 08:15:44.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/services/postgresql.te	2008-06-11 13:39:57.000000000 -0400
@@ -44,6 +44,9 @@
 type postgresql_var_run_t;
 files_pid_file(postgresql_var_run_t)
 
+type postgresql_script_exec_t;
+init_script_type(postgresql_script_exec_t)
+
 # database clients attribute
 attribute sepgsql_client_type;
 attribute sepgsql_unconfined_type;
@@ -186,6 +189,7 @@
 
 fs_getattr_all_fs(postgresql_t)
 fs_search_auto_mountpoints(postgresql_t)
+fs_rw_hugetlbfs_files(postgresql_t)
 
 selinux_get_enforce_mode(postgresql_t)
 selinux_validate_context(postgresql_t)

--------------020509000206080808040201
Content-Type: application/pgp-signature;
 name="services_postgresql.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="services_postgresql.patch.sig"

iEYEABECAAYFAkhQGQsACgkQrlYvE4MpobMT4gCfZYjpUgEzJX8mXJLHhFwBcWHF/WkAniKJ
ZIGc8oxnaydWHdoRAoQma8wt
--------------020509000206080808040201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
