Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1R80fsF003412
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 03:00:41 -0500
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1R80ZcR009500
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 08:00:36 GMT
Message-ID: <47C5189B.9070500@ak.jp.nec.com>
Date: Wed, 27 Feb 2008 17:00:27 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com> <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>
In-Reply-To: <47C38287.4080302@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------070903070608060109030803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070903070608060109030803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch provides security policies related to SE-PostgreSQL.

The followings are updates/unchanges from the previous version submitted
at two weeks ago. These updates replaced most of the part in the previous
one.

- The targets of this patch are moved to services/postgresql.*,
   although the previous one added new entries.
- Any interface got slim. They contains only one TYPEATTRIBUTE
   statement, and postgresql.te allows most of permissions to
   the associated attributes.
* Tunables to turn on/off audit are remained now, because database
   folks told me fine-grained logs are worthwhile feature.

Any comment please,

Thanks,

>> Just like with the X server, I don't believe that sepostgres should have
>> its own module.
> 
> OK, I'll make next one as a patch for services/postgresql.*.
> 
>> At first glance, there appears to be too many
>> attributes.  I'm guessing that you're doing the same thing that is done
>> with the *_unconfined() interfaces.  We mainly do that to optimize size
>> since unconfined brings in so many rules.
> 
> OK, I'll replace current interfaces by the following style's one.
> 
> interface(`sepostgresql_unconfined',`
>         gen_require(`
>                 attribute sepostgresql_unconfined_type;
>         ')
>         typeattribute $1 sepostgresql_unconfined_type;
> ')
> 
>> I also see references to types and attributes that belong do the module.
> 
> Is it unlabel_t and system_r?
> Where is the best place to associate them with my local policy?
> 
>  > Also the auditing
>> tunables seem unneeded; they seem to be more for debugging use.  I think
>> I can get a better handle on the policy with these revisions.
> 
> Hmm...
> The reason why I added these tunables is that database folks told me
> that collecting logs in column/tuple level is an attractive feature,
> because native DBMS cannot provide fine-grained access control and
> cannot collect logs in these level.
> Thus, I believe the feature to turn on/off auditing readily should
> be remained.
> 
> Thanks,


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------070903070608060109030803
Content-Type: text/x-patch;
 name="refpolicy-sepostgresql.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepostgresql.patch"

Index: refpolicy-sepgsql/policy/modules/services/postgresql.if
===================================================================
--- refpolicy-sepgsql/policy/modules/services/postgresql.if	(revision 2626)
+++ refpolicy-sepgsql/policy/modules/services/postgresql.if	(working copy)
@@ -120,3 +120,92 @@
         # Some versions of postgresql put the sock file in /tmp
 	allow $1 postgresql_tmp_t:sock_file write;
 ')
+
+########################################
+## <summary>
+##      Marks the specified domain as SE-PostgreSQL server process.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain to be marked
+##      </summary>
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
+##      Allow the specified domain unconfined accesses to any database objects
+##	managed by SE-PostgreSQL,
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`sepgsql_unconfined_domain',`
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
+##      Allow the specified domain unprivileged accesses to any database objects
+##	managed by SE-PostgreSQL,
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`sepgsql_client_domain',`
+	gen_require(`
+		attribute sepgsql_client_type;
+	')
+	typeattribute $1 sepgsql_client_type;
+')
+
+########################################
+## <summary>
+##      Allow the specified role to invoke trusted procedures
+## </summary>
+## <param name="role">
+##	<summary>
+##	The role associated with the domain.
+##	</summary>
+## </param>
+#
+interface(`sepgsql_trusted_procedure_role',`
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
+interface(`sepgsql_loadable_module',`
+	gen_require(`
+		attribute sepgsql_module_type;
+	')
+	typeattribute $1 sepgsql_module_type;
+')
Index: refpolicy-sepgsql/policy/modules/services/apache.te
===================================================================
--- refpolicy-sepgsql/policy/modules/services/apache.te	(revision 2626)
+++ refpolicy-sepgsql/policy/modules/services/apache.te	(working copy)
@@ -498,6 +498,10 @@
 	yam_read_content(httpd_t)
 ')
 
+optional_policy(`
+	sepgsql_client_domain(httpd_t)
+')
+
 ########################################
 #
 # Apache helper local policy
Index: refpolicy-sepgsql/policy/modules/services/apache.if
===================================================================
--- refpolicy-sepgsql/policy/modules/services/apache.if	(revision 2626)
+++ refpolicy-sepgsql/policy/modules/services/apache.if	(working copy)
@@ -226,6 +226,10 @@
 	')
 
 	optional_policy(`
+		sepgsql_client_domain(httpd_$1_script_t)
+	')
+
+	optional_policy(`
 		nscd_socket_use(httpd_$1_script_t)
 	')
 ')
Index: refpolicy-sepgsql/policy/modules/services/postgresql.te
===================================================================
--- refpolicy-sepgsql/policy/modules/services/postgresql.te	(revision 2626)
+++ refpolicy-sepgsql/policy/modules/services/postgresql.te	(working copy)
@@ -166,3 +166,230 @@
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
+# SE-PostgreSQL Type/Attribute declarations
+#
+
+# database subjects
+attribute sepgsql_server_type;
+attribute sepgsql_client_type;
+attribute sepgsql_unconfined_type;
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
+########################################
+#
+# SE-PostgreSQL Server Local policy
+#                    (sepgsql_server_type)
+
+sepgsql_server_domain(postgresql_t)
+
+allow sepgsql_server_type self : netlink_selinux_socket create_socket_perms;
+selinux_get_fs_mount(sepgsql_server_type)
+selinux_get_enforce_mode(sepgsql_server_type)
+selinux_validate_context(sepgsql_server_type)
+selinux_compute_access_vector(sepgsql_server_type)
+selinux_compute_create_context(sepgsql_server_type)
+selinux_compute_relabel_context(sepgsql_server_type)
+
+allow sepgsql_server_type sepgsql_database_type : db_database *;
+allow sepgsql_server_type sepgsql_module_type : db_database { install_module };
+allow sepgsql_server_type sepgsql_table_type : { db_table db_column db_tuple } *;
+allow sepgsql_server_type sepgsql_procedure_type : db_procedure *;
+allow sepgsql_server_type sepgsql_blob_type : db_blob *;
+
+# server specific type transitions
+type_transition sepgsql_server_type sepgsql_database_type : db_table sepgsql_sysobj_t;
+type_transition sepgsql_server_type sepgsql_database_type : db_procedure sepgsql_proc_t;
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
+	allow sepgsql_unconfined_type { sepgsql_procedure_type - sepgsql_user_proc_t } : db_procedure *;
+	allow sepgsql_unconfined_type sepgsql_user_proc_t : db_procedure { create drop getattr setattr relabelfrom relabelto };
+	allow sepgsql_unconfined_type sepgsql_blob_type : db_blob *;
+	allow sepgsql_unconfined_type postgresql_t : db_blob { import export };
+
+	type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
+',`
+	type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
+')
+
+########################################
+#
+# SE-PostgreSQL Users domain local policy
+#                     (sepgsql_client_type)
+
+allow sepgsql_client_type sepgsql_db_t : db_database { getattr access get_param set_param};
+
+allow sepgsql_client_type sepgsql_table_t : db_table { getattr use select update insert delete };
+allow sepgsql_client_type sepgsql_table_t : db_column { getattr use select update insert };
+allow sepgsql_client_type sepgsql_table_t : db_tuple { use select update insert delete };
+
+allow sepgsql_client_type sepgsql_sysobj_t : db_table { getattr use select };
+allow sepgsql_client_type sepgsql_sysobj_t : db_column { getattr use select };
+allow sepgsql_client_type sepgsql_sysobj_t : db_tuple { use select };
+tunable_policy(`sepgsql_enable_users_ddl',`
+	allow sepgsql_client_type sepgsql_table_t : db_table { create drop setattr };
+	allow sepgsql_client_type sepgsql_table_t : db_column { create drop setattr };
+	allow sepgsql_client_type sepgsql_sysobj_t : db_tuple { update insert delete };
+')
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
+allow { sepgsql_client_type - sepgsql_unconfined_type } sepgsql_user_proc_t : db_procedure { create drop getattr setattr execute };
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
+type_transition domain domain : db_database sepgsql_db_t;
+type_transition { domain - sepgsql_server_type } sepgsql_database_type : db_table sepgsql_table_t;
+type_transition { domain - sepgsql_server_type - sepgsql_unconfined_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
+type_transition domain sepgsql_database_type : db_blob sepgsql_blob_t;
+
+########################################
+#
+# SE-PostgreSQL Misc policies
+#
+
+# Trusted Procedure Domain
+domain_type(sepgsql_trusted_domain_t)
+role system_r types sepgsql_trusted_domain_t;
+sepgsql_unconfined_domain(sepgsql_trusted_domain_t)
+
+# The following permissions are allowed, even if sepgsql_enable_unconfined is disabled.
+allow sepgsql_trusted_domain_t sepgsql_database_type : db_database { getattr setattr access get_param set_param};
+allow sepgsql_trusted_domain_t sepgsql_table_type : db_table { getattr use select update insert delete lock };
+allow sepgsql_trusted_domain_t sepgsql_table_type : db_column { getattr use select update insert };
+allow sepgsql_trusted_domain_t sepgsql_table_type : db_tuple { use select update insert delete };
+
+allow sepgsql_trusted_domain_t { sepgsql_procedure_type - sepgsql_user_proc_t } : db_procedure { getattr execute };
+allow sepgsql_trusted_domain_t sepgsql_user_proc_t : db_procedure { getattr };
+allow sepgsql_trusted_domain_t sepgsql_blob_type : db_blob { getattr setattr read write };
+
+# Database/Loadable module
+allow sepgsql_database_type sepgsql_module_type : db_database { load_module };
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
+	auditallow domain sepgsql_module_type    : db_database { install_module };
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
+	dontaudit domain sepgsql_module_type     : db_database { install_module };
+')
+tunable_policy(`! sepgsql_enable_audittuple || ! sepgsql_enable_auditdeny',`
+	dontaudit domain sepgsql_table_type      : db_tuple all_db_tuple_perms;
+')
Index: refpolicy-sepgsql/policy/modules/services/postgresql.fc
===================================================================
--- refpolicy-sepgsql/policy/modules/services/postgresql.fc	(revision 2626)
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
--- refpolicy-sepgsql/policy/modules/system/userdomain.if	(revision 2626)
+++ refpolicy-sepgsql/policy/modules/system/userdomain.if	(working copy)
@@ -1201,6 +1201,11 @@
 		netutils_run_traceroute_cond($1_t,$1_r,{ $1_tty_device_t $1_devpts_t })
 	')
 
+	optional_policy(`
+		sepgsql_client_domain($1_t)
+		sepgsql_trusted_procedure_role($1_r)
+	')
+
 	# Run pppd in pppd_t by default for user
 	optional_policy(`
 		ppp_run_cond($1_t,$1_r,{ $1_tty_device_t $1_devpts_t })
@@ -1371,6 +1376,10 @@
 	')
 
 	optional_policy(`
+		sepgsql_unconfined_domain($1_t)
+	')
+
+	optional_policy(`
 		userhelper_exec($1_t)
 	')
 ')
Index: refpolicy-sepgsql/policy/modules/system/unconfined.te
===================================================================
--- refpolicy-sepgsql/policy/modules/system/unconfined.te	(revision 2626)
+++ refpolicy-sepgsql/policy/modules/system/unconfined.te	(working copy)
@@ -189,6 +189,10 @@
 ')
 
 optional_policy(`
+	sepgsql_trusted_procedure_role(unconfined_r)
+')
+
+optional_policy(`
 	tzdata_run(unconfined_t, unconfined_r, { unconfined_devpts_t unconfined_tty_device_t })
 ')
 
Index: refpolicy-sepgsql/policy/modules/system/libraries.te
===================================================================
--- refpolicy-sepgsql/policy/modules/system/libraries.te	(revision 2626)
+++ refpolicy-sepgsql/policy/modules/system/libraries.te	(working copy)
@@ -103,3 +103,8 @@
 	# blow up.
 	rpm_manage_script_tmp_files(ldconfig_t)
 ')
+
+optional_policy(`
+	sepgsql_loadable_module(lib_t)
+	sepgsql_loadable_module(textrel_shlib_t)
+')
Index: refpolicy-sepgsql/policy/modules/system/unconfined.if
===================================================================
--- refpolicy-sepgsql/policy/modules/system/unconfined.if	(revision 2626)
+++ refpolicy-sepgsql/policy/modules/system/unconfined.if	(working copy)
@@ -88,6 +88,10 @@
 	')
 
 	optional_policy(`
+		sepgsql_unconfined_domain($1)
+	')
+
+	optional_policy(`
 		seutil_create_bin_policy($1)
 		seutil_relabelto_bin_policy($1)
 	')

--------------070903070608060109030803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
