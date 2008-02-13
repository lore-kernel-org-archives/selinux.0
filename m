Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1D9Uk22007135
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 04:30:46 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1D9Ugjc015201
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 09:30:43 GMT
Message-ID: <47B2B885.4070300@ak.jp.nec.com>
Date: Wed, 13 Feb 2008 18:29:41 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] SE-PostgreSQL Security Policy
Content-Type: multipart/mixed;
 boundary="------------020203030908010806030103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020203030908010806030103
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch adds support for SE-PostgreSQL.
Most part of them are same as currently we are distributing via RPM package.

This patch adds some booleans, attributes and types.
You can find out the detailed description about works of them in the chapter 5
of "The Security-Enhanced PostgreSQL Security Guide".
See, http://sepgsql.googlecode.com/files/sepgsql_security_guide.20070903.en.pdf

Any comment please,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------020203030908010806030103
Content-Type: text/x-patch;
 name="refpolicy-sepostgresql.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepostgresql.patch"

Index: refpolicy/policy/modules/services/sepostgresql.fc
===================================================================
--- refpolicy/policy/modules/services/sepostgresql.fc	(revision 0)
+++ refpolicy/policy/modules/services/sepostgresql.fc	(revision 0)
@@ -0,0 +1,10 @@
+#
+# SE-PostgreSQL install path
+#
+/usr/bin/sepostgres		--	gen_context(system_u:object_r:postgresql_exec_t,s0)
+/usr/bin/initdb.sepgsql		--	gen_context(system_u:object_r:postgresql_exec_t,s0)
+/usr/bin/sepg_ctl		--	gen_context(system_u:object_r:initrc_exec_t,s0)
+
+/var/lib/sepgsql(/.*)?			gen_context(system_u:object_r:postgresql_db_t,s0)
+/var/lib/sepgsql/pgstartup\.log		gen_context(system_u:object_r:postgresql_log_t,s0)
+/var/log/sepostgresql\.log.*	--	gen_context(system_u:object_r:postgresql_log_t,s0)
Index: refpolicy/policy/modules/services/sepostgresql.if
===================================================================
--- refpolicy/policy/modules/services/sepostgresql.if	(revision 0)
+++ refpolicy/policy/modules/services/sepostgresql.if	(revision 0)
@@ -0,0 +1,88 @@
+## <summary>SE-PostgreSQL relational database</summary>
+
+########################################
+## <summary>
+##     marks as a server process of SE-PostgreSQL.
+## </summary>
+## <param name="domain">
+##     <summary>
+##     Type marked as a database object type.
+##     </summary>
+## </param>
+#
+interface(`sepgsql_server_domain',`
+	gen_require(`
+		attribute sepgsql_server_type;
+	')
+	typeattribute $1 sepgsql_server_type;
+')
+
+########################################
+## <summary>
+##     marks as a administrative client process of SE-PostgreSQL.
+## </summary>
+## <param name="domain">
+##     <summary>
+##     A domain marked as a administrative client domain
+##     </summary>
+## </param>
+#
+interface(`sepgsql_database_admin_domain',`
+	gen_require(`
+		attribute sepgsql_admin_type;
+		attribute sepgsql_users_type;
+	')
+	typeattribute $1 sepgsql_admin_type;
+	typeattribute $1 sepgsql_users_type;
+')
+
+########################################
+## <summary>
+##     marks as a generic client process of SE-PostgreSQL.
+## </summary>
+## <param name="type">
+##     <summary>
+##     A domain marked as a generic client domain
+##     </summary>
+## </param>
+#
+interface(`sepgsql_database_user_domain',`
+	gen_require(`
+		attribute sepgsql_users_type;
+	')
+	typeattribute $1 sepgsql_users_type;
+')
+
+########################################
+## <summary>
+##     marks as a generic client process of SE-PostgreSQL.
+## </summary>
+## <param name="role">
+##      <summary>
+##      The role to allow the trusted procedure domain.
+##      </summary>
+## </param>
+#
+interface(`sepgsql_database_client_role',`
+	gen_require(`
+		type sepgsql_trusted_domain_t;
+	')
+	role $1 types sepgsql_trusted_domain_t;
+')
+
+########################################
+## <summary>
+##     Marks as a SE-PostgreSQL loadable shared library module
+## </summary>
+## <param name="type">
+##     <summary>
+##     Type marked as a database object type.
+##     </summary>
+## </param>
+#
+interface(`sepgsql_module_object',`
+	gen_require(`
+		attribute sepgsql_module_type;
+	')
+	typeattribute $1 sepgsql_module_type;
+')
Index: refpolicy/policy/modules/services/apache.te
===================================================================
--- refpolicy/policy/modules/services/apache.te	(revision 2600)
+++ refpolicy/policy/modules/services/apache.te	(working copy)
@@ -482,6 +482,10 @@
 ')
 
 optional_policy(`
+	sepgsql_database_user_domain(httpd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(httpd_t)
 ')
 
Index: refpolicy/policy/modules/services/apache.if
===================================================================
--- refpolicy/policy/modules/services/apache.if	(revision 2600)
+++ refpolicy/policy/modules/services/apache.if	(working copy)
@@ -228,6 +228,10 @@
 	optional_policy(`
 		nscd_socket_use(httpd_$1_script_t)
 	')
+
+	optional_policy(`
+		sepgsql_database_user_domain(httpd_$1_script_t)
+	')
 ')
 
 #######################################
Index: refpolicy/policy/modules/services/postgresql.te
===================================================================
--- refpolicy/policy/modules/services/postgresql.te	(revision 2600)
+++ refpolicy/policy/modules/services/postgresql.te	(working copy)
@@ -160,6 +160,10 @@
 ')
 
 optional_policy(`
+	sepgsql_server_domain(postgresql_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(postgresql_t)
 ')
 
Index: refpolicy/policy/modules/services/sepostgresql.te
===================================================================
--- refpolicy/policy/modules/services/sepostgresql.te	(revision 0)
+++ refpolicy/policy/modules/services/sepostgresql.te	(revision 0)
@@ -0,0 +1,239 @@
+policy_module(sepostgresql,3.0)
+
+gen_require(`
+	all_userspace_class_perms
+
+	type unlabeled_t;
+	attribute file_type;
+	type lib_t, textrel_shlib_t;
+')
+
+#################################
+#
+# Declarations of SE-PostgreSQL booleans
+#
+
+## <desc>
+## <p>
+## Allow to enable unconfined domains
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_unconfined, true)
+
+## <desc>
+## <p>
+## Allow to generate auditallow logs
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_auditallow, false)
+
+## <desc>
+## <p>
+## Allow to generate auditdeny logs
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_auditdeny,  true)
+
+## <desc>
+## <p>
+## Allow to generate audit(allow|deny) logs for tuples
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_audittuple, false)
+
+## <desc>
+## <p>
+## Allow unprived users to execute DDL statement
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_users_ddl,  true)
+
+#################################
+#
+# Declarations of type/attributes
+#
+
+## Database Server/Client Attributes
+attribute sepgsql_server_type;
+attribute sepgsql_admin_type;
+attribute sepgsql_users_type;
+
+## Database Object Attributes
+attribute sepgsql_database_type;
+attribute sepgsql_table_type;
+attribute sepgsql_procedure_type;
+attribute sepgsql_blob_type;
+attribute sepgsql_module_type;
+
+## Database Trusted Domain
+type sepgsql_trusted_domain_t;
+domain_type(sepgsql_trusted_domain_t)
+sepgsql_database_admin_domain(sepgsql_trusted_domain_t)
+
+## Database Object Types
+type sepgsql_db_t,		sepgsql_database_type;
+
+type sepgsql_table_t,		sepgsql_table_type;
+type sepgsql_sysobj_t,		sepgsql_table_type;
+type sepgsql_secret_table_t,	sepgsql_table_type;
+type sepgsql_ro_table_t,	sepgsql_table_type;
+type sepgsql_fixed_table_t,	sepgsql_table_type;
+
+type sepgsql_proc_t,		sepgsql_procedure_type;
+type sepgsql_user_proc_t,	sepgsql_procedure_type;
+type sepgsql_trusted_proc_t,	sepgsql_procedure_type;
+
+type sepgsql_blob_t,		sepgsql_blob_type;
+type sepgsql_ro_blob_t,		sepgsql_blob_type;
+type sepgsql_secret_blob_t,	sepgsql_blob_type;
+
+typeattribute unlabeled_t	sepgsql_database_type;
+typeattribute unlabeled_t	sepgsql_table_type;
+typeattribute unlabeled_t	sepgsql_procedure_type;
+typeattribute unlabeled_t	sepgsql_blob_type;
+
+#################################
+#
+# SE-PostgreSQL Type Transitions
+#
+
+# db_database
+type_transition domain domain : db_database sepgsql_db_t;
+
+# db_table
+type_transition sepgsql_server_type sepgsql_database_type : db_table sepgsql_sysobj_t;
+type_transition { domain - sepgsql_server_type } sepgsql_database_type : db_table sepgsql_table_t;
+
+# db_procedure
+type_transition sepgsql_server_type sepgsql_database_type : db_procedure sepgsql_proc_t;
+tunable_policy(`sepgsql_enable_unconfined',`
+	type_transition sepgsql_admin_type sepgsql_database_type : db_procedure sepgsql_proc_t;
+',`
+	type_transition sepgsql_admin_type sepgsql_database_type : db_procedure sepgsql_user_proc_t;
+')
+type_transition { domain - sepgsql_server_type - sepgsql_admin_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
+
+# db_blob
+type_transition domain sepgsql_database_type : db_blob sepgsql_blob_t;
+
+# Trusted Procedures
+role system_r types sepgsql_trusted_proc_t;
+type_transition sepgsql_users_type sepgsql_trusted_proc_t : process sepgsql_trusted_domain_t;
+allow sepgsql_users_type sepgsql_trusted_domain_t : process { transition };
+
+#################################
+#
+# SE-PostgreSQL Server Local Policy
+#
+allow sepgsql_server_type self : netlink_selinux_socket create_socket_perms;
+selinux_get_fs_mount(sepgsql_server_type)
+selinux_get_enforce_mode(sepgsql_server_type)
+selinux_validate_context(sepgsql_server_type)
+selinux_compute_access_vector(sepgsql_server_type)
+selinux_compute_create_context(sepgsql_server_type)
+selinux_compute_relabel_context(sepgsql_server_type)
+
+allow sepgsql_server_type sepgsql_database_type : db_database all_db_database_perms;
+allow sepgsql_server_type sepgsql_module_type : db_database { install_module };
+allow sepgsql_server_type sepgsql_table_type : db_table all_db_table_perms;
+allow sepgsql_server_type sepgsql_table_type : db_column all_db_column_perms;
+allow sepgsql_server_type sepgsql_table_type : db_tuple all_db_tuple_perms;
+allow sepgsql_server_type { sepgsql_procedure_type - sepgsql_user_proc_t } : db_procedure all_db_procedure_perms;
+allow sepgsql_server_type sepgsql_user_proc_t : db_procedure { create drop getattr setattr relabelfrom relabelto };
+allow sepgsql_server_type sepgsql_blob_type : db_blob all_db_blob_perms;
+allow sepgsql_server_type sepgsql_server_type : db_blob { import export };
+
+#################################
+#
+# SE-PostgreSQL Administrative Domain Local Policy
+#
+tunable_policy(`sepgsql_enable_unconfined',`
+	allow sepgsql_admin_type sepgsql_database_type : db_database all_db_database_perms;
+	allow sepgsql_admin_type sepgsql_module_type : db_database { install_module };
+	allow sepgsql_admin_type sepgsql_table_type : db_table all_db_table_perms;
+	allow sepgsql_admin_type sepgsql_table_type : db_column all_db_column_perms;
+	allow sepgsql_admin_type sepgsql_table_type : db_tuple all_db_tuple_perms;
+	allow sepgsql_admin_type { sepgsql_procedure_type - sepgsql_user_proc_t } : db_procedure all_db_procedure_perms;
+	allow sepgsql_admin_type sepgsql_user_proc_t : db_procedure { create drop getattr setattr relabelfrom relabelto };
+	allow sepgsql_admin_type sepgsql_blob_type : db_blob all_db_blob_perms;
+	allow sepgsql_admin_type sepgsql_server_type : db_blob { import export };
+',`
+	allow sepgsql_admin_type sepgsql_user_proc_t : db_procedure { create drop getattr setattr execute };
+	allow sepgsql_admin_type sepgsql_trusted_proc_t : db_procedure { getattr execute entrypoint };
+')
+
+#################################
+#
+# SE-PostgreSQL Users Domain Local Policy
+#
+allow sepgsql_users_type sepgsql_db_t : db_database { getattr access get_param set_param };
+
+allow sepgsql_users_type sepgsql_table_t : db_table { getattr use select update insert delete };
+allow sepgsql_users_type sepgsql_table_t : db_column { getattr use select update insert };
+allow sepgsql_users_type sepgsql_table_t : db_tuple { use select update insert delete };
+
+allow sepgsql_users_type sepgsql_sysobj_t : db_table { getattr use select };
+allow sepgsql_users_type sepgsql_sysobj_t : db_column { getattr use select };
+allow sepgsql_users_type sepgsql_sysobj_t : db_tuple { use select };
+tunable_policy(`sepgsql_enable_users_ddl',`
+	allow sepgsql_users_type sepgsql_table_t : db_table { create drop setattr };
+	allow sepgsql_users_type sepgsql_table_t : db_column { create drop setattr };
+	allow sepgsql_users_type sepgsql_sysobj_t : db_tuple { update insert delete };
+')
+
+allow sepgsql_users_type sepgsql_secret_table_t : db_table { getattr };
+allow sepgsql_users_type sepgsql_secret_table_t : db_column { getattr };
+
+allow sepgsql_users_type sepgsql_ro_table_t : db_table { getattr use select };
+allow sepgsql_users_type sepgsql_ro_table_t : db_column { getattr use select };
+allow sepgsql_users_type sepgsql_ro_table_t : db_tuple { use select };
+
+allow sepgsql_users_type sepgsql_fixed_table_t : db_table { getattr use select insert };
+allow sepgsql_users_type sepgsql_fixed_table_t : db_column { getattr use select insert };
+allow sepgsql_users_type sepgsql_fixed_table_t : db_tuple { use select insert };
+
+allow sepgsql_users_type sepgsql_proc_t : db_procedure { getattr execute };
+allow { sepgsql_users_type - sepgsql_admin_type } sepgsql_user_proc_t : db_procedure { create drop getattr setattr execute };
+allow sepgsql_users_type sepgsql_trusted_proc_t : db_procedure { getattr execute entrypoint };
+
+allow sepgsql_users_type sepgsql_blob_t : db_blob { create drop getattr setattr read write };
+allow sepgsql_users_type sepgsql_ro_blob_t : db_blob { getattr read };
+allow sepgsql_users_type sepgsql_secret_blob_t : db_blob { getattr };
+
+########################################
+#
+# SE-PostgreSQL loadable shared library policy
+#
+
+allow sepgsql_database_type sepgsql_module_type : db_database { load_module };
+sepgsql_module_object(lib_t)
+sepgsql_module_object(textrel_shlib_t)
+
+########################################
+#
+# SE-PostgreSQL audit switch
+#
+tunable_policy(`sepgsql_enable_auditallow',`
+	auditallow domain sepgsql_database_type  : db_database all_db_database_perms;
+	auditallow domain sepgsql_table_type     : db_table all_db_table_perms;
+	auditallow domain sepgsql_table_type     : db_column all_db_column_perms;
+	auditallow domain sepgsql_procedure_type : db_procedure all_db_procedure_perms;
+	auditallow domain sepgsql_blob_type      : db_blob all_db_blob_perms;
+	auditallow domain sepgsql_server_type    : db_blob { import export };
+	auditallow domain file_type              : db_database { install_module };
+')
+tunable_policy(`sepgsql_enable_audittuple && sepgsql_enable_auditallow',`
+	auditallow domain sepgsql_table_type     : db_tuple all_db_tuple_perms;
+')
+tunable_policy(`! sepgsql_enable_auditdeny',`
+	dontaudit domain sepgsql_database_type   : db_database all_db_database_perms;
+	dontaudit domain sepgsql_table_type      : db_table all_db_table_perms;
+	dontaudit domain sepgsql_table_type      : db_column all_db_column_perms;
+	dontaudit domain sepgsql_procedure_type  : db_procedure all_db_procedure_perms;
+	dontaudit domain sepgsql_blob_type       : db_blob all_db_blob_perms;
+	dontaudit domain sepgsql_server_type     : db_blob { import export };
+	dontaudit domain file_type               : db_database { install_module };
+')
+tunable_policy(`! sepgsql_enable_audittuple || ! sepgsql_enable_auditdeny',`
+	dontaudit domain sepgsql_table_type      : db_tuple all_db_tuple_perms;
+')
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy/policy/modules/system/userdomain.if	(revision 2600)
+++ refpolicy/policy/modules/system/userdomain.if	(working copy)
@@ -1203,6 +1203,11 @@
 	optional_policy(`
 		setroubleshoot_stream_connect($1_t)
 	')
+
+	optional_policy(`
+		sepgsql_database_client_role($1_r)
+		sepgsql_database_user_domain($1_t)
+	')
 ')
 
 #######################################
@@ -1367,6 +1372,11 @@
 	optional_policy(`
 		userhelper_exec($1_t)
 	')
+
+	optional_policy(`
+		sepgsql_database_client_role($1_r)
+		sepgsql_database_admin_domain($1_t)
+	')
 ')
 
 ########################################
Index: refpolicy/policy/modules/system/unconfined.te
===================================================================
--- refpolicy/policy/modules/system/unconfined.te	(revision 2600)
+++ refpolicy/policy/modules/system/unconfined.te	(working copy)
@@ -193,6 +193,10 @@
 ')
 
 optional_policy(`
+	sepgsql_database_client_role(unconfined_r)
+')
+
+optional_policy(`
 	usermanage_run_admin_passwd(unconfined_t, unconfined_r, { unconfined_devpts_t unconfined_tty_device_t })
 ')
 
Index: refpolicy/policy/modules/system/unconfined.if
===================================================================
--- refpolicy/policy/modules/system/unconfined.if	(revision 2600)
+++ refpolicy/policy/modules/system/unconfined.if	(working copy)
@@ -88,6 +88,10 @@
 	')
 
 	optional_policy(`
+		sepgsql_database_admin_domain($1)
+	')
+
+	optional_policy(`
 		seutil_create_bin_policy($1)
 		seutil_relabelto_bin_policy($1)
 	')

--------------020203030908010806030103--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
