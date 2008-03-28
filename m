Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2S4oaiu010487
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 00:50:37 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2S4oXC6010447
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 04:50:34 GMT
Message-ID: <47EC7910.2060505@ak.jp.nec.com>
Date: Fri, 28 Mar 2008 13:50:24 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy (try #3)
References: <47B2B885.4070300@ak.jp.nec.com> <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com> <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com> <47D09FEB.3030005@ak.jp.nec.com> <1204922912.20251.58.camel@gorn.columbia.tresys.com> <47D3F33B.5010209@kaigai.gr.jp> <1205240234.25555.55.camel@gorn> <47DE3A66.602@ak.jp.nec.com> <1205937929.16113.78.camel@gorn> <47E33A66.6030705@ak.jp.nec.com> <1206384282.16113.205.camel@gorn.columbia.tresys.com> <47E8D58B.5040707@ak.jp.nec.com> <1206451493.16113.217.camel@gorn.columbia.tresys.com> <47EB6E41.9040309@ak.jp.nec.com> <1206624233.16113.291.camel@gorn>
In-Reply-To: <1206624233.16113.291.camel@gorn>
Content-Type: multipart/mixed;
 boundary="------------010700070204070201060103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010700070204070201060103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>> Do you consider they are really complex type_transition rules now?
>> They are not conditional, not set operations.
> 
> Sounds like they are ok, but I'd have to see the policy to make sure.

I'm sorry, I din't submit the latest one yet, although I gave assurance
to update some points you pointed out.

The attached one is the latest one.
Please confirm this version.

Significant updates:
- kernel_relabelfrom_unlabeled_database() is added to kernel/kernel.if.
   It enables sepgsql_unconfined_type to relabel unlabaled_t to other types.
- Any types/attributes/booleans are declared at the head of services/postgresql.te.
- postgresql_userdom_template() requires tree arguments of prefix, domain and role.
- Naming convention is changed. When userdomain tries to create a new object,
   it is labeled as FOO_sepgsql_table_t, not sepgsql_FOO_table_t.
- The target of type_transition is unconditional.
   If userdomain create a new objects, it is always labeled as FOO_sepgsql_xxx_t.
   If others create a new one, it is always labeled as sepgsql_xxx_t.
- A new attribute of sepgsql_unpriv_client_type provides baseline permissions to
   attached domain. It is necessary to avoid to deploy sepgsql_enable_users_ddl
   boolean within interfaces.
- The meanings of sepgsql_client_type is changed. It means a set of domains
   connectable to SE-PostgreSQL.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------010700070204070201060103
Content-Type: text/x-patch;
 name="refpolicy-sepostgresql.5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepostgresql.5.patch"

Index: refpolicy-sepgsql/policy/modules/kernel/kernel.if
===================================================================
--- refpolicy-sepgsql/policy/modules/kernel/kernel.if	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/kernel/kernel.if	(working copy)
@@ -2493,6 +2493,35 @@
 
 ########################################
 ## <summary>
+##      Relabelfrom unlabeled database objects of SE-PostgreSQL
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`kernel_relabelfrom_unlabeled_database',`
+	gen_require(`
+		type unlabeled_t;
+
+		class db_database { setattr relabelfrom };
+		class db_table { setattr relabelfrom };
+		class db_procedure { setattr relabelfrom };
+		class db_column { setattr relabelfrom };
+		class db_tuple { update relabelfrom };
+		class db_blob { setattr relabelfrom };
+	')
+	allow $1 unlabeled_t:db_database { setattr relabelfrom };
+	allow $1 unlabeled_t:db_table { setattr relabelfrom };
+	allow $1 unlabeled_t:db_procedure { setattr relabelfrom };
+	allow $1 unlabeled_t:db_column { setattr relabelfrom };
+	allow $1 unlabeled_t:db_tuple { update relabelfrom };
+	allow $1 unlabeled_t:db_blob { setattr relabelfrom };
+')
+
+########################################
+## <summary>
 ##	Unconfined access to kernel module resources.
 ## </summary>
 ## <param name="domain">
Index: refpolicy-sepgsql/policy/modules/services/postgresql.if
===================================================================
--- refpolicy-sepgsql/policy/modules/services/postgresql.if	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/services/postgresql.if	(working copy)
@@ -120,3 +120,264 @@
         # Some versions of postgresql put the sock file in /tmp
 	allow $1 postgresql_tmp_t:sock_file write;
 ')
+
+#######################################
+## <summary>
+##      The userdomain template for the SE-PostgreSQL.
+## </summary>
+## <desc>
+##      This template creates a delivered types which are used
+##	for given userdomains.
+## </desc>
+## <param name="userdomain_prefix">
+##      <summary>
+##      The prefix of the user domain (e.g., user
+##      is the prefix for user_t).
+##      </summary>
+## </param>
+## <param name="user_domain">
+## 	<summary>
+##      The type of the user domain.
+##      </summary>
+## </param>
+## <param name="user_role">
+##      <summary>
+##      The role associated with the user domain.
+##      </summary>
+## </param>
+#
+template(`postgresql_userdom_template',`
+	gen_require(`
+		class db_database all_db_database_perms;
+		class db_table all_db_table_perms;
+		class db_procedure all_db_procedure_perms;
+		class db_column all_db_column_perms;
+		class db_tuple all_db_tuple_perms;
+		class db_blob all_db_blob_perms;
+
+		attribute sepgsql_client_type;
+		attribute sepgsql_unpriv_client_type;
+		attribute sepgsql_database_type;
+		attribute sepgsql_sysobj_table_type;
+
+		type sepgsql_trusted_proc_t;
+		type sepgsql_trusted_domain_t;
+
+		bool sepgsql_enable_users_ddl;
+	')
+
+	########################################
+	#
+	# Declarations
+	#
+
+	typeattribute $2 sepgsql_client_type;
+	typeattribute $2 sepgsql_unpriv_client_type;
+
+	type $1_sepgsql_table_t;
+	postgresql_table_object($1_sepgsql_table_t)
+
+	type $1_sepgsql_sysobj_t;
+	postgresql_system_table_object($1_sepgsql_sysobj_t)
+
+	type $1_sepgsql_proc_t;
+	postgresql_procedure_object($1_sepgsql_proc_t)
+
+	type $1_sepgsql_blob_t;
+	postgresql_blob_object($1_sepgsql_blob_t)
+
+	##############################
+	#
+	# Client local policy
+	#
+	tunable_policy(`sepgsql_enable_users_ddl',`
+		allow $2 $1_sepgsql_table_t  : db_table { create drop };
+		allow $2 $1_sepgsql_table_t  : db_column { create drop };
+		allow $2 $1_sepgsql_sysobj_t : db_tuple { update insert delete };
+	')
+
+	allow $2 $1_sepgsql_table_t  : db_table  { getattr setattr use select update insert delete };
+	allow $2 $1_sepgsql_table_t  : db_column { getattr setattr use select update insert };
+	allow $2 $1_sepgsql_table_t  : db_tuple  { use select update insert delete };
+	allow $2 $1_sepgsql_sysobj_t : db_tuple  { use select };
+
+	allow $2 $1_sepgsql_proc_t : db_procedure { create drop getattr setattr execute };
+
+	allow $2 $1_sepgsql_blob_t : db_blob { create drop getattr setattr read write };
+
+	##############################
+	#
+	# Type/Domain Transition
+	#
+	type_transition $2 sepgsql_database_type     : db_table     $1_sepgsql_table_t;
+	type_transition $2 sepgsql_database_type     : db_procedure $1_sepgsql_proc_t;
+	type_transition $2 sepgsql_database_type     : db_blob      $1_sepgsql_blob_t;
+	type_transition $2 sepgsql_sysobj_table_type : db_tuple     $1_sepgsql_sysobj_t;
+
+	type_transition $2 sepgsql_trusted_proc_t: process sepgsql_trusted_domain_t;
+	allow $2 sepgsql_trusted_domain_t : process { transition };
+	role $3 types sepgsql_trusted_domain_t;
+')
+
+########################################
+## <summary>
+##      Allow the specified domain unconfined accesses to any database objects
+##	managed by SE-PostgreSQL,
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`postgresql_unconfined',`
+	gen_require(`
+		attribute sepgsql_unconfined_type;
+		attribute sepgsql_client_type;
+	')
+	typeattribute $1 sepgsql_unconfined_type;
+	typeattribute $1 sepgsql_client_type;
+')
+
+########################################
+## <summary>
+##      Allow the specified domain unprivileged accesses to unifined database objects
+##	managed by SE-PostgreSQL,
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`postgresql_unpriv_client',`
+	gen_require(`
+		class db_table all_db_table_perms;
+		class db_procedure all_db_procedure_perms;
+		class db_blob all_db_blob_perms;
+
+		attribute sepgsql_unpriv_client_type;
+		attribute sepgsql_client_type;
+		attribute sepgsql_database_type;
+
+		type sepgsql_table_t;
+		type sepgsql_proc_t;
+		type sepgsql_blob_t;
+
+		type sepgsql_trusted_proc_t;
+		type sepgsql_trusted_domain_t;
+	')
+	typeattribute $1 sepgsql_unpriv_client_type;
+	typeattribute $1 sepgsql_client_type;
+
+	type_transition $1 sepgsql_database_type : db_table sepgsql_table_t;
+	type_transition $1 sepgsql_database_type : db_procedure sepgsql_proc_t;
+	type_transition $1 sepgsql_database_type : db_blob sepgsql_blob_t;
+
+	type_transition $1 sepgsql_trusted_proc_t : process sepgsql_trusted_domain_t;
+	allow $1 sepgsql_trusted_domain_t : process { transition };
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
+interface(`postgresql_loadable_module',`
+	gen_require(`
+		attribute sepgsql_module_type;
+	')
+	typeattribute $1 sepgsql_module_type;
+')
+
+########################################
+## <summary>
+##     Marks as a SE-PostgreSQL database object type
+## </summary>
+## <param name="type">
+##     <summary>
+##     Type marked as a database object type.
+##     </summary>
+## </param>
+#
+interface(`postgresql_database_object',`
+	gen_require(`
+		attribute sepgsql_database_type;
+	')
+	typeattribute $1 sepgsql_database_type;
+')
+
+########################################
+## <summary>
+##     Marks as a SE-PostgreSQL table/column/tuple object type
+## </summary>
+## <param name="type">
+##     <summary>
+##     Type marked as a table/column/tuple object type.
+##     </summary>
+## </param>
+#
+interface(`postgresql_table_object',`
+	gen_require(`
+		attribute sepgsql_table_type;
+	')
+	typeattribute $1 sepgsql_table_type;
+')
+
+########################################
+## <summary>
+##     Marks as a SE-PostgreSQL system table/column/tuple object type
+## </summary>
+## <param name="type">
+##     <summary>
+##     Type marked as a table/column/tuple object type.
+##     </summary>
+## </param>
+#
+interface(`postgresql_system_table_object',`
+	gen_require(`
+		attribute sepgsql_table_type;
+		attribute sepgsql_sysobj_table_type;
+	')
+	typeattribute $1 sepgsql_table_type;
+	typeattribute $1 sepgsql_sysobj_table_type;
+')
+
+########################################
+## <summary>
+##     Marks as a SE-PostgreSQL procedure object type
+## </summary>
+## <param name="type">
+##     <summary>
+##     Type marked as a database object type.
+##     </summary>
+## </param>
+#
+interface(`postgresql_procedure_object',`
+	gen_require(`
+		attribute sepgsql_procedure_type;
+	')
+	typeattribute $1 sepgsql_procedure_type;
+')
+
+########################################
+## <summary>
+##     Marks as a SE-PostgreSQL binary large object type
+## </summary>
+## <param name="type">
+##     <summary>
+##     Type marked as a database binary large object type.
+##     </summary>
+## </param>
+#
+interface(`postgresql_blob_object',`
+	gen_require(`
+		attribute sepgsql_blob_type;
+	')
+	typeattribute $1 sepgsql_blob_type;
+')
Index: refpolicy-sepgsql/policy/modules/services/apache.te
===================================================================
--- refpolicy-sepgsql/policy/modules/services/apache.te	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/services/apache.te	(working copy)
@@ -479,6 +479,8 @@
 	tunable_policy(`httpd_can_network_connect_db',`
 		postgresql_tcp_connect(httpd_t)
 	')
+
+	postgresql_unpriv_client(httpd_t)
 ')
 
 optional_policy(`
Index: refpolicy-sepgsql/policy/modules/services/apache.if
===================================================================
--- refpolicy-sepgsql/policy/modules/services/apache.if	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/services/apache.if	(working copy)
@@ -226,6 +226,10 @@
 	')
 
 	optional_policy(`
+		postgresql_unpriv_client(httpd_$1_script_t)
+	')
+
+	optional_policy(`
 		nscd_socket_use(httpd_$1_script_t)
 	')
 ')
Index: refpolicy-sepgsql/policy/modules/services/postgresql.te
===================================================================
--- refpolicy-sepgsql/policy/modules/services/postgresql.te	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/services/postgresql.te	(working copy)
@@ -27,6 +27,61 @@
 type postgresql_var_run_t;
 files_pid_file(postgresql_var_run_t)
 
+#################################
+#
+# Declarations related to SE-PostgreSQL
+#
+
+## <desc>
+## <p>
+## Allow unprived users to execute DDL statement
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_users_ddl, true)
+
+# database clients attribute
+attribute sepgsql_client_type;
+attribute sepgsql_unconfined_type;
+attribute sepgsql_unpriv_client_type;
+
+# database objects attribute
+attribute sepgsql_database_type;
+attribute sepgsql_table_type;
+attribute sepgsql_sysobj_table_type;
+attribute sepgsql_procedure_type;
+attribute sepgsql_blob_type;
+attribute sepgsql_module_type;
+
+# database trusted domain
+type sepgsql_trusted_domain_t;
+
+# database object types
+type sepgsql_db_t;
+postgresql_database_object(sepgsql_db_t)
+
+type sepgsql_table_t;
+postgresql_table_object(sepgsql_table_t)
+type sepgsql_sysobj_t;
+postgresql_system_table_object(sepgsql_sysobj_t)
+type sepgsql_secret_table_t;
+postgresql_table_object(sepgsql_secret_table_t)
+type sepgsql_ro_table_t;
+postgresql_table_object(sepgsql_ro_table_t)
+type sepgsql_fixed_table_t;
+postgresql_table_object(sepgsql_fixed_table_t)
+
+type sepgsql_proc_t;
+postgresql_procedure_object(sepgsql_proc_t)
+type sepgsql_trusted_proc_t;
+postgresql_procedure_object(sepgsql_trusted_proc_t)
+
+type sepgsql_blob_t;
+postgresql_blob_object(sepgsql_blob_t)
+type sepgsql_ro_blob_t;
+postgresql_blob_object(sepgsql_ro_blob_t)
+type sepgsql_secret_blob_t;
+postgresql_blob_object(sepgsql_secret_blob_t)
+
 ########################################
 #
 # postgresql Local policy
@@ -166,3 +221,109 @@
 optional_policy(`
 	udev_read_db(postgresql_t)
 ')
+
+########################################
+#
+# SE-PostgreSQL Server Local policy
+#                    (postgresql_t)
+
+allow postgresql_t self : netlink_selinux_socket create_socket_perms;
+selinux_get_fs_mount(postgresql_t)
+selinux_get_enforce_mode(postgresql_t)
+selinux_validate_context(postgresql_t)
+selinux_compute_access_vector(postgresql_t)
+selinux_compute_create_context(postgresql_t)
+selinux_compute_relabel_context(postgresql_t)
+
+allow postgresql_t sepgsql_database_type : db_database *;
+allow postgresql_t sepgsql_module_type : db_database { install_module };
+allow postgresql_t sepgsql_table_type : { db_table db_column db_tuple } *;
+allow postgresql_t sepgsql_procedure_type : db_procedure *;
+allow postgresql_t sepgsql_blob_type : db_blob *;
+
+# server specific type transitions
+type_transition postgresql_t sepgsql_database_type : db_table sepgsql_sysobj_t;
+type_transition postgresql_t sepgsql_database_type : db_procedure sepgsql_proc_t;
+type_transition postgresql_t sepgsql_database_type : db_blob sepgsql_blob_t;
+
+########################################
+#
+# SE-PostgreSQL unconfined domain local policy
+#                    (sepgsql_unconfined_type)
+
+allow sepgsql_unconfined_type sepgsql_database_type : db_database *;
+allow sepgsql_unconfined_type sepgsql_module_type : db_database { install_module };
+allow sepgsql_unconfined_type sepgsql_table_type : { db_table db_column db_tuple } *;
+allow sepgsql_unconfined_type { sepgsql_proc_t sepgsql_trusted_proc_t } : db_procedure *;
+allow sepgsql_unconfined_type sepgsql_procedure_type : db_procedure { create drop getattr setattr relabelfrom relabelto };
+allow sepgsql_unconfined_type sepgsql_blob_type : db_blob *;
+allow sepgsql_unconfined_type postgresql_t : db_blob { import export };
+
+optional_policy(`
+	kernel_relabelfrom_unlabeled_database(sepgsql_unconfined_type)
+')
+
+type_transition sepgsql_unconfined_type sepgsql_database_type : db_table sepgsql_table_t;
+type_transition sepgsql_unconfined_type sepgsql_database_type : db_procedure sepgsql_proc_t;
+type_transition sepgsql_unconfined_type sepgsql_database_type : db_blob sepgsql_blob_t;
+
+########################################
+#
+# SE-PostgreSQL unpriv-Client domain local policy
+#                    (sepgsql_unpriv_client_type)
+
+allow sepgsql_unpriv_client_type sepgsql_db_t : db_database { getattr access get_param set_param};
+
+allow sepgsql_unpriv_client_type sepgsql_table_t : db_table { getattr use select update insert delete };
+allow sepgsql_unpriv_client_type sepgsql_table_t : db_column { getattr use select update insert };
+allow sepgsql_unpriv_client_type sepgsql_table_t : db_tuple { use select update insert delete };
+
+tunable_policy(`sepgsql_enable_users_ddl',`
+	allow sepgsql_unpriv_client_type sepgsql_table_t  : db_table  { create drop setattr };
+	allow sepgsql_unpriv_client_type sepgsql_table_t  : db_column { create drop setattr };
+	allow sepgsql_unpriv_client_type sepgsql_sysobj_t : db_tuple  { update insert delete };
+')
+
+allow sepgsql_unpriv_client_type sepgsql_sysobj_t : db_table { getattr use select };
+allow sepgsql_unpriv_client_type sepgsql_sysobj_t : db_column { getattr use select };
+allow sepgsql_unpriv_client_type sepgsql_sysobj_t : db_tuple { use select };
+
+allow sepgsql_unpriv_client_type sepgsql_secret_table_t : db_table { getattr };
+allow sepgsql_unpriv_client_type sepgsql_secret_table_t : db_column { getattr };
+
+allow sepgsql_unpriv_client_type sepgsql_ro_table_t : db_table { getattr use select };
+allow sepgsql_unpriv_client_type sepgsql_ro_table_t : db_column { getattr use select };
+allow sepgsql_unpriv_client_type sepgsql_ro_table_t : db_tuple { use select };
+
+allow sepgsql_unpriv_client_type sepgsql_fixed_table_t : db_table { getattr use select insert };
+allow sepgsql_unpriv_client_type sepgsql_fixed_table_t : db_column { getattr use select insert };
+allow sepgsql_unpriv_client_type sepgsql_fixed_table_t : db_tuple { use select insert };
+
+allow sepgsql_unpriv_client_type sepgsql_proc_t : db_procedure { getattr execute };
+allow sepgsql_unpriv_client_type sepgsql_trusted_proc_t : db_procedure { getattr execute entrypoint };
+
+allow sepgsql_unpriv_client_type sepgsql_blob_t : db_blob { create drop getattr setattr read write };
+allow sepgsql_unpriv_client_type sepgsql_ro_blob_t : db_blob { getattr read };
+allow sepgsql_unpriv_client_type sepgsql_secret_blob_t : db_blob { getattr };
+
+########################################
+#
+# SE-PostgreSQL Misc policies
+#
+
+# Type Transition for database object
+type_transition { postgresql_t sepgsql_client_type } postgresql_t : db_database sepgsql_db_t;
+
+# Trusted Procedure Domain
+domain_type(sepgsql_trusted_domain_t)
+postgresql_unconfined(sepgsql_trusted_domain_t)
+role system_r types sepgsql_trusted_domain_t;
+
+# Database/Loadable module
+allow sepgsql_database_type sepgsql_module_type : db_database { load_module };
+
+# Don't audit deny logs in row-level access control
+dontaudit sepgsql_client_type { sepgsql_table_type - sepgsql_sysobj_table_type } : db_tuple *;
+
+# Client domain constraint
+neverallow ~{ postgresql_t sepgsql_client_type } sepgsql_database_type : db_database { access };
Index: refpolicy-sepgsql/policy/modules/services/postgresql.fc
===================================================================
--- refpolicy-sepgsql/policy/modules/services/postgresql.fc	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/services/postgresql.fc	(working copy)
@@ -6,8 +6,9 @@
 #
 # /usr
 #
-/usr/bin/initdb			--	gen_context(system_u:object_r:postgresql_exec_t,s0)
-/usr/bin/postgres		--	gen_context(system_u:object_r:postgresql_exec_t,s0)
+/usr/bin/initdb(\.sepgsql)?	--	gen_context(system_u:object_r:postgresql_exec_t,s0)
+/usr/bin/(se)?postgres		--	gen_context(system_u:object_r:postgresql_exec_t,s0)
+/usr/bin/sepg_ctl		--	gen_context(system_u:object_r:initrc_exec_t,s0)
 
 /usr/lib/pgsql/test/regres(/.*)?	gen_context(system_u:object_r:postgresql_db_t,s0)
 /usr/lib/pgsql/test/regress/pg_regress -- gen_context(system_u:object_r:postgresql_exec_t,s0)
@@ -30,8 +31,12 @@
 /var/lib/pgsql/data(/.*)?		gen_context(system_u:object_r:postgresql_db_t,s0)
 /var/lib/pgsql/pgstartup\.log		gen_context(system_u:object_r:postgresql_log_t,s0)
 
+/var/lib/sepgsql(/.*)?			gen_context(system_u:object_r:postgresql_db_t,s0)
+/var/lib/sepgsql/pgstartup\.log	--	gen_context(system_u:object_r:postgresql_log_t,s0)
+
 /var/log/postgres\.log.* 	--	gen_context(system_u:object_r:postgresql_log_t,s0)
 /var/log/postgresql(/.*)?		gen_context(system_u:object_r:postgresql_log_t,s0)
+/var/log/sepostgresql\.log.*	--	gen_context(system_u:object_r:postgresql_log_t,s0)
 
 ifdef(`distro_redhat', `
 /var/log/rhdb/rhdb(/.*)?		gen_context(system_u:object_r:postgresql_log_t,s0)
Index: refpolicy-sepgsql/policy/modules/system/userdomain.if
===================================================================
--- refpolicy-sepgsql/policy/modules/system/userdomain.if	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/system/userdomain.if	(working copy)
@@ -1201,6 +1201,10 @@
 		netutils_run_traceroute_cond($1_t,$1_r,{ $1_tty_device_t $1_devpts_t })
 	')
 
+	optional_policy(`
+		postgresql_userdom_template($1,$1_t,$1_r)
+	')
+
 	# Run pppd in pppd_t by default for user
 	optional_policy(`
 		ppp_run_cond($1_t,$1_r,{ $1_tty_device_t $1_devpts_t })
@@ -1371,6 +1375,10 @@
 	')
 
 	optional_policy(`
+		postgresql_unconfined($1_t)
+	')
+
+	optional_policy(`
 		userhelper_exec($1_t)
 	')
 ')
Index: refpolicy-sepgsql/policy/modules/system/unconfined.te
===================================================================
--- refpolicy-sepgsql/policy/modules/system/unconfined.te	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/system/unconfined.te	(working copy)
@@ -189,6 +189,10 @@
 ')
 
 optional_policy(`
+	postgresql_unconfined(unconfined_t)
+')
+
+optional_policy(`
 	tzdata_run(unconfined_t, unconfined_r, { unconfined_devpts_t unconfined_tty_device_t })
 ')
 
Index: refpolicy-sepgsql/policy/modules/system/libraries.te
===================================================================
--- refpolicy-sepgsql/policy/modules/system/libraries.te	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/system/libraries.te	(working copy)
@@ -109,3 +109,8 @@
 	# blow up.
 	rpm_manage_script_tmp_files(ldconfig_t)
 ')
+
+optional_policy(`
+	postgresql_loadable_module(lib_t)
+	postgresql_loadable_module(textrel_shlib_t)
+')
Index: refpolicy-sepgsql/policy/modules/system/unconfined.if
===================================================================
--- refpolicy-sepgsql/policy/modules/system/unconfined.if	(revision 2647)
+++ refpolicy-sepgsql/policy/modules/system/unconfined.if	(working copy)
@@ -88,6 +88,10 @@
 	')
 
 	optional_policy(`
+		postgresql_unconfined($1)
+	')
+
+	optional_policy(`
 		seutil_create_bin_policy($1)
 		seutil_relabelto_bin_policy($1)
 	')

--------------010700070204070201060103--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
