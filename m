Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m279WZrF030795
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 04:32:35 -0500
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m279WUMZ002695
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 09:32:31 GMT
Message-ID: <47D10BA9.2030803@ak.jp.nec.com>
Date: Fri, 07 Mar 2008 18:32:25 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com> <47D09FEB.3030005@ak.jp.nec.com>
In-Reply-To: <47D09FEB.3030005@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------080905030907040107090006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080905030907040107090006
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch provides revised SE-PostgreSQL security policy.

I changed the following points:
- Interfaces are renamed from sepgsql_* to postgresql_*
- Tunables to turn on/off autit logs are removed.
- The unlabeled_t is associated with database object attribute
  via interfaces at kernel/kernel.te.
- sepgsql_(database|table|procedure|blob)_object interfaces
  are added for unlabeled_t and end-user extension.
- sepgsql_server_type is removed, postgresql_t is used instead.
- Widespread type_transition rules are removed.
- Add postgresql_userdom_template(userdom_prefix).

However,
>> The two existing connect interfaces (tcp and stream) should probably
>> call this interface.  If its regular postgresql, it won't hurt anything.
>
> OK,

I didn't apply this update yet, because it is invoked with an attribute
in Fedora default policy.
I tested this patch with applying it on selinux-policy-3.3.1-11.fc9, and
it works fine.


I think detailed explanations are necessary for postgresql_userdom_template()
and client attributes.

postgresql_userdom_template() requires a userdomain prefix, like `staff'.
It declares the following types and allows (USERDOM)_t to access with
few limitation.
 - sepgsql_FOO_table_t
 - sepgsql_FOO_proc_t
 - sepgsql_FOO_blob_t
(USERDOM)_t also got type_transition rules to create database objects
with above types. But these rules will be invalidated when (USERDOM)_t
belongs sepgsql_unconfined_type and sepgsql_enable_unconfined is turned on.


There are three attribute for domains.
 * sepgsql_client_type
   Any domain which want to connect SE-PostgreSQL is associated with
   this attribute. Some of restricted accesses are allowed to this
   attribute, like read-only on sepgsql_ro_table_t.

 * sepgsql_userdom_type
   Any domain which uses postgresql_userdom_template() is associated
   with this attribute.
   They are allowed to access user domain local types (like sepgsql_FOO_t)
   with few limitation (relabeling are not allowed).
   They also belong to sepgsql_client_type, so restricted accesses are
   also allowed on common types.

 * sepgsql_unconfined_type
   Domains belong to this attribute can access widespread database object
   with no limitation, when sepgsql_enable_unconfined tunable is turned on.
   If this tunable is disabled, this attribute does not give anything.

In other words, sepgsql_client_type is a set of all client domains.
It also contains sepgsq_userdom_type and sepgsql_unconfined_type,
but sepgsq_userdom_type and sepgsql_unconfined_type are not mutually
exclusive set. The unconfined_t belongs both attributes, for example.

The sepgsql_unconfined_type cannot invoke sepgsql_(USERDOM)_proc_t,
as the previous policy prevent it to execute sepgsql_user_proc_t.

Please review it again.
Thanks.
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------080905030907040107090006
Content-Type: text/x-patch;
 name="refpolicy-sepostgresql.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepostgresql.2.patch"

Index: refpolicy-sepgsql/policy/modules/kernel/kernel.te
===================================================================
--- refpolicy-sepgsql/policy/modules/kernel/kernel.te	(revision 2632)
+++ refpolicy-sepgsql/policy/modules/kernel/kernel.te	(working copy)
@@ -358,6 +358,17 @@
 
 ########################################
 #
+# Unlabeled database objects
+#
+optional_policy(`
+	postgresql_database_object(unlabeled_t)
+	postgresql_table_object(unlabeled_t)
+	postgresql_procedure_object(unlabeled_t)
+	postgresql_blob_object(unlabeled_t)
+')
+
+########################################
+#
 # Rules for unconfined acccess to this module
 #
 
Index: refpolicy-sepgsql/policy/modules/services/postgresql.if
===================================================================
--- refpolicy-sepgsql/policy/modules/services/postgresql.if	(revision 2632)
+++ refpolicy-sepgsql/policy/modules/services/postgresql.if	(working copy)
@@ -120,3 +120,202 @@
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
+		attribute sepgsql_unconfined_type;
+		attribute sepgsql_userdom_type;
+
+		attribute sepgsql_database_type;
+		attribute sepgsql_table_type;
+		attribute sepgsql_procedure_type;
+		attribute sepgsql_blob_type;
+
+		type sepgsql_trusted_domain_t;
+
+		bool sepgsql_enable_unconfined;
+	')
+
+	########################################
+	#
+	# Declarations
+	#
+	typeattribute $1_t sepgsql_client_type;
+	typeattribute $1_t sepgsql_userdom_type;
+
+	type sepgsql_$1_table_t, sepgsql_table_type;
+	type sepgsql_$1_proc_t,  sepgsql_procedure_type;
+	type sepgsql_$1_blob_t, sepgsql_blob_type;
+
+	##############################
+	#
+	# Client local policy
+	#
+
+	tunable_policy(`sepgsql_enable_unconfined',`
+		type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_table sepgsql_$1_table_t;
+		type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_procedure sepgsql_$1_proc_t;
+		type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_blob sepgsql_$1_blob_t;
+	',`
+		type_transition $1_t sepgsql_database_type : db_table sepgsql_$1_table_t;
+		type_transition $1_t sepgsql_database_type : db_procedure sepgsql_$1_proc_t;
+		type_transition $1_t sepgsql_database_type : db_blob sepgsql_$1_blob_t;
+	')
+	allow $1_t sepgsql_$1_table_t : db_table { create drop getattr setattr use select update insert delete };
+	allow $1_t sepgsql_$1_table_t : db_column { create drop getattr setattr use select update insert };
+	allow $1_t sepgsql_$1_table_t : db_tuple { use select update insert delete };
+
+	allow $1_t sepgsql_$1_proc_t : db_procedure { create drop getattr setattr execute };
+
+	allow $1_t sepgsql_$1_blob_t : db_blob { create drop getattr setattr read write };
+
+	# Trusted Procedure
+	role $1_r types sepgsql_trusted_domain_t;
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
+interface(`postgresql_client',`
+	gen_require(`
+		attribute sepgsql_client_type;
+	')
+	typeattribute $1 sepgsql_client_type;
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
Index: refpolicy-sepgsql/policy/modules/services/apache.te
===================================================================
--- refpolicy-sepgsql/policy/modules/services/apache.te	(revision 2632)
+++ refpolicy-sepgsql/policy/modules/services/apache.te	(working copy)
@@ -479,6 +479,8 @@
 	tunable_policy(`httpd_can_network_connect_db',`
 		postgresql_tcp_connect(httpd_t)
 	')
+
+	postgresql_client(httpd_t)
 ')
 
 optional_policy(`
Index: refpolicy-sepgsql/policy/modules/services/apache.if
===================================================================
--- refpolicy-sepgsql/policy/modules/services/apache.if	(revision 2632)
+++ refpolicy-sepgsql/policy/modules/services/apache.if	(working copy)
@@ -226,6 +226,10 @@
 	')
 
 	optional_policy(`
+		postgresql_client(httpd_$1_script_t)
+	')
+
+	optional_policy(`
 		nscd_socket_use(httpd_$1_script_t)
 	')
 ')
Index: refpolicy-sepgsql/policy/modules/services/postgresql.te
===================================================================
--- refpolicy-sepgsql/policy/modules/services/postgresql.te	(revision 2632)
+++ refpolicy-sepgsql/policy/modules/services/postgresql.te	(working copy)
@@ -166,3 +166,188 @@
 optional_policy(`
 	udev_read_db(postgresql_t)
 ')
+
+#################################
+#
+# SE-PostgreSQL Boolean declarations
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
+## Allow unprived users to execute DDL statement
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_users_ddl, true)
+
+#################################
+#
+# SE-PostgreSQL Type/Attribute declarations
+#
+
+# database subjects
+attribute sepgsql_client_type;
+attribute sepgsql_unconfined_type;
+attribute sepgsql_userdom_type;
+
+# database objects attribute
+attribute sepgsql_database_type;
+attribute sepgsql_table_type;
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
+postgresql_table_object(sepgsql_sysobj_t)
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
+type_transition postgresql_t postgresql_t : db_database sepgsql_db_t;
+type_transition postgresql_t sepgsql_database_type : db_table sepgsql_sysobj_t;
+type_transition postgresql_t sepgsql_database_type : db_procedure sepgsql_proc_t;
+type_transition postgresql_t sepgsql_database_type : db_blob sepgsql_blob_t;
+
+########################################
+#
+# SE-PostgreSQL Administrative domain local policy
+#                    (sepgsql_unconfined_type)
+
+tunable_policy(`sepgsql_enable_unconfined',`
+	allow sepgsql_unconfined_type sepgsql_database_type : db_database *;
+	allow sepgsql_unconfined_type sepgsql_module_type : db_database { install_module };
+	allow sepgsql_unconfined_type sepgsql_table_type : { db_table db_column db_tuple } *;
+	allow sepgsql_unconfined_type sepgsql_proc_t : db_procedure *;
+	allow sepgsql_unconfined_type { sepgsql_procedure_type - sepgsql_proc_t } : db_procedure { create drop getattr setattr relabelfrom relabelto };
+	allow sepgsql_unconfined_type sepgsql_blob_type : db_blob *;
+	allow sepgsql_unconfined_type postgresql_t : db_blob { import export };
+
+	type_transition sepgsql_unconfined_type sepgsql_database_type : db_table sepgsql_table_t;
+	type_transition sepgsql_unconfined_type sepgsql_database_type : db_procedure sepgsql_proc_t;
+	type_transition sepgsql_unconfined_type sepgsql_database_type : db_blob sepgsql_blob_t;
+')
+
+########################################
+#
+# SE-PostgreSQL unpriv-Client domain local policy
+#                    (sepgsql_client_type)
+
+allow sepgsql_client_type sepgsql_db_t : db_database { getattr access get_param set_param};
+
+allow sepgsql_client_type sepgsql_table_t : db_table { getattr use select update insert delete };
+allow sepgsql_client_type sepgsql_table_t : db_column { getattr use select update insert };
+allow sepgsql_client_type sepgsql_table_t : db_tuple { use select update insert delete };
+
+tunable_policy(`sepgsql_enable_users_ddl',`
+	allow sepgsql_client_type sepgsql_table_t : db_table { create drop setattr };
+	allow sepgsql_client_type sepgsql_table_t : db_column { create drop setattr };
+')
+
+allow sepgsql_client_type sepgsql_sysobj_t : db_table { getattr use select };
+allow sepgsql_client_type sepgsql_sysobj_t : db_column { getattr use select };
+allow sepgsql_client_type sepgsql_sysobj_t : db_tuple { use select update insert delete };
+
+allow sepgsql_client_type sepgsql_secret_table_t : db_table { getattr };
+allow sepgsql_client_type sepgsql_secret_table_t : db_column { getattr };
+
+allow sepgsql_client_type sepgsql_ro_table_t : db_table { getattr use select };
+allow sepgsql_client_type sepgsql_ro_table_t : db_column { getattr use select };
+allow sepgsql_client_type sepgsql_ro_table_t : db_tuple { use select };
+
+allow sepgsql_client_type sepgsql_fixed_table_t : db_table { getattr use select insert };
+allow sepgsql_client_type sepgsql_fixed_table_t : db_column { getattr use select insert };
+allow sepgsql_client_type sepgsql_fixed_table_t : db_tuple { use select insert };
+
+allow sepgsql_client_type sepgsql_proc_t : db_procedure { getattr execute };
+allow sepgsql_client_type sepgsql_trusted_proc_t : db_procedure { getattr execute entrypoint };
+
+allow sepgsql_client_type sepgsql_blob_t : db_blob { create drop getattr setattr read write };
+allow sepgsql_client_type sepgsql_ro_blob_t : db_blob { getattr read };
+allow sepgsql_client_type sepgsql_secret_blob_t : db_blob { getattr };
+
+# call trusted procedure
+type_transition sepgsql_client_type sepgsql_trusted_proc_t : process sepgsql_trusted_domain_t;
+allow sepgsql_client_type sepgsql_trusted_domain_t : process { transition };
+
+# type transitions for rest of domains
+type_transition sepgsql_client_type postgresql_t : db_database sepgsql_db_t;
+tunable_policy(`sepgsql_enable_unconfined',`
+	type_transition { sepgsql_client_type - sepgsql_unconfined_type - sepgsql_userdom_type } sepgsql_database_type : db_table sepgsql_table_t;
+	type_transition { sepgsql_client_type - sepgsql_unconfined_type - sepgsql_userdom_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
+	type_transition { sepgsql_client_type - sepgsql_unconfined_type - sepgsql_userdom_type } sepgsql_database_type : db_blob sepgsql_blob_t;
+',`
+	type_transition { sepgsql_client_type - sepgsql_userdom_type } sepgsql_database_type : db_table sepgsql_table_t;
+	type_transition { sepgsql_client_type - sepgsql_userdom_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
+	type_transition { sepgsql_client_type - sepgsql_userdom_type } sepgsql_database_type : db_blob sepgsql_blob_t;
+')
+
+########################################
+#
+# SE-PostgreSQL Misc policies
+#
+
+# Trusted Procedure Domain
+domain_type(sepgsql_trusted_domain_t)
+postgresql_unconfined(sepgsql_trusted_domain_t)
+role system_r types sepgsql_trusted_domain_t;
+
+# The following permissions are allowed, even if sepgsql_enable_unconfined is disabled.
+allow sepgsql_trusted_domain_t sepgsql_database_type : db_database { getattr setattr access get_param set_param};
+allow sepgsql_trusted_domain_t sepgsql_table_type : db_table { getattr use select update insert delete lock };
+allow sepgsql_trusted_domain_t sepgsql_table_type : db_column { getattr use select update insert };
+allow sepgsql_trusted_domain_t sepgsql_table_type : db_tuple { use select update insert delete };
+
+allow sepgsql_trusted_domain_t sepgsql_blob_type : db_blob { getattr setattr read write };
+
+# Database/Loadable module
+allow sepgsql_database_type sepgsql_module_type : db_database { load_module };
Index: refpolicy-sepgsql/policy/modules/services/postgresql.fc
===================================================================
--- refpolicy-sepgsql/policy/modules/services/postgresql.fc	(revision 2632)
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
--- refpolicy-sepgsql/policy/modules/system/userdomain.if	(revision 2632)
+++ refpolicy-sepgsql/policy/modules/system/userdomain.if	(working copy)
@@ -1201,6 +1201,10 @@
 		netutils_run_traceroute_cond($1_t,$1_r,{ $1_tty_device_t $1_devpts_t })
 	')
 
+	optional_policy(`
+		postgresql_userdom_template($1)
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
--- refpolicy-sepgsql/policy/modules/system/unconfined.te	(revision 2632)
+++ refpolicy-sepgsql/policy/modules/system/unconfined.te	(working copy)
@@ -189,6 +189,11 @@
 ')
 
 optional_policy(`
+	postgresql_userdom_template(unconfined)
+	postgresql_unconfined(unconfined_t)
+')
+
+optional_policy(`
 	tzdata_run(unconfined_t, unconfined_r, { unconfined_devpts_t unconfined_tty_device_t })
 ')
 
Index: refpolicy-sepgsql/policy/modules/system/libraries.te
===================================================================
--- refpolicy-sepgsql/policy/modules/system/libraries.te	(revision 2632)
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
--- refpolicy-sepgsql/policy/modules/system/unconfined.if	(revision 2632)
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

--------------080905030907040107090006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
