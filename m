Message-ID: <484C9E55.30702@ak.jp.nec.com>
Date: Mon, 09 Jun 2008 12:07:01 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH]	libselinux:	add	support	for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>	 <483C6BEA.8040101@tycho.nsa.gov>	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>	 <4843CB24.1040000@ak.jp.nec.com>  <48442E7E.9050303@tycho.nsa.gov>	 <1212431955.31546.94.camel@gorn>  <48451C0C.6060303@ak.jp.nec.com>	 <1212496632.31546.105.camel@gorn.columbia.tresys.com>	 <4846142F.8090100@ak.jp.nec.com>	 <1212589930.4140.16.camel@gorn.columbia.tresys.com>	 <48473ECC.6020501@ak.jp.nec.com> <1212672916.15752.7.camel@gorn.pebenito.net> <4848C96F.50201@ak.jp.nec.com>
In-Reply-To: <4848C96F.50201@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------080204020605080504040307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080204020605080504040307
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

In the attached patch, the following points are changed from [1].

  [1] http://marc.info/?l=selinux&m=120999566809541&w=2

- type_transition rule of a newly created database got being described
  as a relation ship between client and itself, like:
  | type_transition sepgsql_client_type sepgsql_client_type:db_database sepgsql_db_t;

- neverallow rule has gone.

- allow sepgsql_unconfined_type postgresql_t:db_blob { import export }; is removed.

- A comment is added to explain dontaudit rule in row-level denied logs.
 | # NOTE:
 | # The purpose of the dontaudit rule in row-level access control is to prevent a flood of logs.
 | # If a client tries to SELECT a table including violated tuples, these are filtered from
 | # the result set as if not exist, but its access denied longs can be recorded within log files.
 | # In generally, the number of tuples are much larger than the number of columns, tables and so on.
 | # So, it makes a flood of logs when many tuples are violated.
 | #
 | # The default policy does not prevent anything for sepgsql_client_type sepgsql_unconfined_type,
 | # so we don't need "dontaudit" rules in Type-Enforcement. However, MLS/MCS can prevent them
 | # to access classified tuples and can make a audit record.
 | #
 | # Therefore, the following rule is applied for any domains which can connect SE-PostgreSQL.

Thanks,

KaiGai Kohei wrote:
> Chris PeBenito wrote:
>> On Thu, 2008-06-05 at 10:18 +0900, KaiGai Kohei wrote:
>>> Christopher J. PeBenito wrote:
>>>> On Wed, 2008-06-04 at 13:03 +0900, KaiGai Kohei wrote:
>>>>> Christopher J. PeBenito wrote:
>>>>>> On Tue, 2008-06-03 at 19:25 +0900, KaiGai Kohei wrote:
>>>>>>> Christopher J. PeBenito wrote:
>>>>>>>> I'm out of arguments; clearly I'm in the minority on this issue.  I
>>>>>>>> already said I wouldn't block the policy over this, so KaiGai, if you
>>>>>>>> would send a last patch based on the revisions I made [1], let see if we
>>>>>>>> can finally get this merged.
>>>>>>>>
>>>>>>>> [1] http://marc.info/?l=selinux&m=120999566809541&w=2
>>>>>>> I'll submit a revised version later.
>>>>>>> (Now we cannot update SVN repository, due to server maintenance.)
>>>>>>>
>>>>>>> Before this, I want to modify the following points:
>>>>> Then, the above dontaudit rule should be rewritten as follows:
>>>>>
>>>>>   dontaudit { sepgsql_client_type sepgsql_unpriv_type postgresql_t } \
>>>>>             { sepgsql_table_type - sepgsql_sysobj_table_type } : db_tuple *;
>>>>>
>>>>> At first, I used a boolean (sepgsql_enable_audittuple) to turn on/off
>>>>> tuple-level access logs, but you suggested it is unnecessary, so I removed it.
>>>> I don't agree because of:
>>>>
>>>> +allow postgresql_t sepgsql_table_type:{ db_table db_column db_tuple } *;
>>>> +allow sepgsql_unconfined_type sepgsql_table_type:{ db_table db_column db_tuple } *;
>>>>
>>>> so dontauditing for postgresql_t and sepgsql_unconfined_type doesn't do
>>>> anything since the access is allowed.
>>> It is correct in type enforcement.
>>> But MCS/MLS can prevent to access by unconfined domains, and make flood of
>>> access denied logs.
>> Ok, I see your point.  Please add a comment in the policy that explains
>> this, so I don't mistakenly remove the dontaudit in the future :)
>>
>> One thing I just realized: do we really want to dontaudit all perms?  It
>> seems like use and/or select might be sufficient.  Dontauditing
>> relabelto and relabelfrom doesn't seem like a good idea.
> 
> OK, I'll send the patch with a comment for tuple-level dontaudit and
> without dontaudit for relabelfrom/relabelto.
> 
> Please wait for days.
> 
> Thanks,


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------080204020605080504040307
Content-Type: text/x-patch;
 name="refpolicy-sepgsql-kaigai-final.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepgsql-kaigai-final.patch"

Index: refpolicy/policy/modules/kernel/kernel.if
===================================================================
--- refpolicy/policy/modules/kernel/kernel.if	(revision 2710)
+++ refpolicy/policy/modules/kernel/kernel.if	(working copy)
@@ -2553,6 +2553,35 @@
 
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
Index: refpolicy/policy/modules/services/postgresql.if
===================================================================
--- refpolicy/policy/modules/services/postgresql.if	(revision 2710)
+++ refpolicy/policy/modules/services/postgresql.if	(working copy)
@@ -1,7 +1,210 @@
 ## <summary>PostgreSQL relational database</summary>
 
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
+		attribute sepgsql_database_type;
+		attribute sepgsql_sysobj_table_type;
+
+		type sepgsql_trusted_proc_t;
+		type sepgsql_trusted_domain_t;
+	')
+
+	########################################
+	#
+	# Declarations
+	#
+
+	typeattribute $2 sepgsql_client_type;
+
+	type $1_sepgsql_blob_t;
+	postgresql_blob_object($1_sepgsql_blob_t)
+
+	type $1_sepgsql_proc_t;
+	postgresql_procedure_object($1_sepgsql_proc_t)
+
+	type $1_sepgsql_sysobj_t;
+	postgresql_system_table_object($1_sepgsql_sysobj_t)
+
+	type $1_sepgsql_table_t;
+	postgresql_table_object($1_sepgsql_table_t)
+
+	role $3 types sepgsql_trusted_domain_t;
+
+	##############################
+	#
+	# Client local policy
+	#
+
+	tunable_policy(`sepgsql_enable_users_ddl',`
+		allow $2 $1_sepgsql_table_t  : db_table { create drop };
+		type_transition $2 sepgsql_database_type:db_table $1_sepgsql_table_t;
+
+		allow $2 $1_sepgsql_table_t  : db_column { create drop };
+
+		allow $2 $1_sepgsql_sysobj_t : db_tuple { update insert delete };
+		type_transition $2 sepgsql_sysobj_table_type:db_tuple $1_sepgsql_sysobj_t;
+	')
+
+	allow $2 $1_sepgsql_table_t  : db_table  { getattr setattr use select update insert delete };
+	allow $2 $1_sepgsql_table_t  : db_column { getattr setattr use select update insert };
+	allow $2 $1_sepgsql_table_t  : db_tuple  { use select update insert delete };
+	allow $2 $1_sepgsql_sysobj_t : db_tuple  { use select };
+
+	allow $2 $1_sepgsql_proc_t : db_procedure { create drop getattr setattr execute };
+	type_transition $2 sepgsql_database_type:db_procedure $1_sepgsql_proc_t;
+
+	allow $2 $1_sepgsql_blob_t : db_blob { create drop getattr setattr read write };
+	type_transition $2 sepgsql_database_type:db_blob $1_sepgsql_blob_t;
+
+	allow $2 sepgsql_trusted_domain_t:process transition;
+	type_transition $2 sepgsql_trusted_proc_t:process sepgsql_trusted_domain_t;
+')
+
 ########################################
 ## <summary>
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
+
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
+
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
+
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
+
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
+
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
+
+	typeattribute $1 sepgsql_blob_type;
+')
+
+########################################
+## <summary>
 ##	Allow the specified domain to search postgresql's database directory.
 ## </summary>
 ## <param name="domain">
@@ -120,3 +323,60 @@
         # Some versions of postgresql put the sock file in /tmp
 	allow $1 postgresql_tmp_t:sock_file write;
 ')
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
+
+	typeattribute $1 sepgsql_client_type;
+
+	type_transition $1 sepgsql_database_type:db_table sepgsql_table_t;
+	type_transition $1 sepgsql_database_type:db_procedure sepgsql_proc_t;
+	type_transition $1 sepgsql_database_type:db_blob sepgsql_blob_t;
+
+	type_transition $1 sepgsql_trusted_proc_t:process sepgsql_trusted_domain_t;
+	allow $1 sepgsql_trusted_domain_t:process transition;
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
+	')
+
+	typeattribute $1 sepgsql_unconfined_type;
+')
Index: refpolicy/policy/modules/services/apache.te
===================================================================
--- refpolicy/policy/modules/services/apache.te	(revision 2710)
+++ refpolicy/policy/modules/services/apache.te	(working copy)
@@ -475,6 +475,7 @@
 optional_policy(`
 	# Allow httpd to work with postgresql
 	postgresql_stream_connect(httpd_t)
+	postgresql_unpriv_client(httpd_t)
 
 	tunable_policy(`httpd_can_network_connect_db',`
 		postgresql_tcp_connect(httpd_t)
Index: refpolicy/policy/modules/services/apache.if
===================================================================
--- refpolicy/policy/modules/services/apache.if	(revision 2710)
+++ refpolicy/policy/modules/services/apache.if	(working copy)
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
Index: refpolicy/policy/modules/services/postgresql.te
===================================================================
--- refpolicy/policy/modules/services/postgresql.te	(revision 2710)
+++ refpolicy/policy/modules/services/postgresql.te	(working copy)
@@ -1,10 +1,27 @@
 
 policy_module(postgresql,1.5.1)
 
+gen_require(`
+	class db_database all_db_database_perms;
+	class db_table all_db_table_perms;
+	class db_procedure all_db_procedure_perms;
+	class db_column all_db_column_perms;
+	class db_tuple all_db_tuple_perms;
+	class db_blob all_db_blob_perms;
+')
+
 #################################
 #
 # Declarations
 #
+
+## <desc>
+## <p>
+## Allow unprived users to execute DDL statement
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_users_ddl, true)
+
 type postgresql_t;
 type postgresql_exec_t;
 init_daemon_domain(postgresql_t,postgresql_exec_t)
@@ -27,6 +44,58 @@
 type postgresql_var_run_t;
 files_pid_file(postgresql_var_run_t)
 
+# database clients attribute
+attribute sepgsql_client_type;
+attribute sepgsql_unconfined_type;
+
+# database objects attribute
+attribute sepgsql_database_type;
+attribute sepgsql_table_type;
+attribute sepgsql_sysobj_table_type;
+attribute sepgsql_procedure_type;
+attribute sepgsql_blob_type;
+attribute sepgsql_module_type;
+
+# database object types
+type sepgsql_blob_t;
+postgresql_blob_object(sepgsql_blob_t)
+
+type sepgsql_db_t;
+postgresql_database_object(sepgsql_db_t)
+
+type sepgsql_fixed_table_t;
+postgresql_table_object(sepgsql_fixed_table_t)
+
+type sepgsql_proc_t;
+postgresql_procedure_object(sepgsql_proc_t)
+
+type sepgsql_ro_blob_t;
+postgresql_blob_object(sepgsql_ro_blob_t)
+
+type sepgsql_ro_table_t;
+postgresql_table_object(sepgsql_ro_table_t)
+
+type sepgsql_secret_blob_t;
+postgresql_blob_object(sepgsql_secret_blob_t)
+
+type sepgsql_secret_table_t;
+postgresql_table_object(sepgsql_secret_table_t)
+
+type sepgsql_sysobj_t;
+postgresql_system_table_object(sepgsql_sysobj_t)
+
+type sepgsql_table_t;
+postgresql_table_object(sepgsql_table_t)
+
+type sepgsql_trusted_proc_t;
+postgresql_procedure_object(sepgsql_trusted_proc_t)
+
+# Trusted Procedure Domain
+type sepgsql_trusted_domain_t;
+domain_type(sepgsql_trusted_domain_t)
+postgresql_unconfined(sepgsql_trusted_domain_t)
+role system_r types sepgsql_trusted_domain_t;
+
 ########################################
 #
 # postgresql Local policy
@@ -42,7 +111,21 @@
 allow postgresql_t self:udp_socket create_stream_socket_perms;
 allow postgresql_t self:unix_dgram_socket create_socket_perms;
 allow postgresql_t self:unix_stream_socket create_stream_socket_perms;
+allow postgresql_t self:netlink_selinux_socket create_socket_perms;
 
+allow postgresql_t sepgsql_database_type:db_database *;
+type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
+
+allow postgresql_t sepgsql_module_type:db_database install_module;
+allow postgresql_t sepgsql_table_type:{ db_table db_column db_tuple } *;
+allow postgresql_t sepgsql_procedure_type:db_procedure *;
+allow postgresql_t sepgsql_blob_type:db_blob *;
+
+# server specific type transitions
+type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
+type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
+type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
+
 manage_dirs_pattern(postgresql_t,postgresql_db_t,postgresql_db_t)
 manage_files_pattern(postgresql_t,postgresql_db_t,postgresql_db_t)
 manage_lnk_files_pattern(postgresql_t,postgresql_db_t,postgresql_db_t)
@@ -75,6 +158,9 @@
 manage_sock_files_pattern(postgresql_t,postgresql_var_run_t,postgresql_var_run_t)
 files_pid_filetrans(postgresql_t,postgresql_var_run_t,file)
 
+# Database/Loadable module
+allow sepgsql_database_type sepgsql_module_type:db_database load_module;
+
 kernel_read_kernel_sysctls(postgresql_t)
 kernel_read_system_state(postgresql_t)
 kernel_list_proc(postgresql_t)
@@ -101,6 +187,12 @@
 fs_getattr_all_fs(postgresql_t)
 fs_search_auto_mountpoints(postgresql_t)
 
+selinux_get_enforce_mode(postgresql_t)
+selinux_validate_context(postgresql_t)
+selinux_compute_access_vector(postgresql_t)
+selinux_compute_create_context(postgresql_t)
+selinux_compute_relabel_context(postgresql_t)
+
 term_use_controlling_term(postgresql_t)
 
 corecmd_exec_bin(postgresql_t)
@@ -126,7 +218,7 @@
 
 miscfiles_read_localization(postgresql_t)
 
-seutil_dontaudit_search_config(postgresql_t)
+seutil_libselinux_linked(postgresql_t)
 
 userdom_dontaudit_use_unpriv_user_fds(postgresql_t)
 
@@ -167,3 +259,89 @@
 optional_policy(`
 	udev_read_db(postgresql_t)
 ')
+
+########################################
+#
+# Rules common to all clients
+#
+
+allow sepgsql_client_type sepgsql_db_t:db_database { getattr access get_param set_param };
+type_transition sepgsql_client_type sepgsql_client_type:db_database sepgsql_db_t;
+
+allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr use select insert };
+allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr use select insert };
+allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { use select insert };
+
+allow sepgsql_client_type sepgsql_table_t:db_table { getattr use select update insert delete };
+allow sepgsql_client_type sepgsql_table_t:db_column { getattr use select update insert };
+allow sepgsql_client_type sepgsql_table_t:db_tuple { use select update insert delete };
+
+allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr use select };
+allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr use select };
+allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { use select };
+
+allow sepgsql_client_type sepgsql_secret_table_t:db_table getattr;
+allow sepgsql_client_type sepgsql_secret_table_t:db_column getattr;
+
+allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr use select };
+allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr use select };
+allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { use select };
+
+allow sepgsql_client_type sepgsql_proc_t:db_procedure { getattr execute };
+allow sepgsql_client_type sepgsql_trusted_proc_t:db_procedure { getattr execute entrypoint };
+
+allow sepgsql_client_type sepgsql_blob_t:db_blob { create drop getattr setattr read write };
+allow sepgsql_client_type sepgsql_ro_blob_t:db_blob { getattr read };
+allow sepgsql_client_type sepgsql_secret_blob_t:db_blob getattr;
+
+tunable_policy(`sepgsql_enable_users_ddl',`
+	allow sepgsql_client_type sepgsql_table_t:db_table  { create drop setattr };
+	allow sepgsql_client_type sepgsql_table_t:db_column { create drop setattr };
+	allow sepgsql_client_type sepgsql_sysobj_t:db_tuple  { update insert delete };
+')
+
+########################################
+#
+# Unconfined access to this module
+#
+allow sepgsql_unconfined_type sepgsql_database_type:db_database *;
+type_transition sepgsql_unconfined_type sepgsql_unconfined_type:db_database sepgsql_db_t;
+
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_table sepgsql_table_t;
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_procedure sepgsql_proc_t;
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_blob sepgsql_blob_t;
+
+allow sepgsql_unconfined_type sepgsql_table_type:{ db_table db_column db_tuple } *;
+
+# unconfined domain is not allowed to invoke user defined procedure directly.
+# They have to confirm and relabel it at first.
+allow sepgsql_unconfined_type { sepgsql_proc_t sepgsql_trusted_proc_t }:db_procedure *;
+allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure { create drop getattr setattr relabelfrom relabelto };
+
+allow sepgsql_unconfined_type sepgsql_blob_type:db_blob *;
+
+allow sepgsql_unconfined_type sepgsql_module_type:db_database install_module;
+
+optional_policy(`
+	kernel_relabelfrom_unlabeled_database(sepgsql_unconfined_type)
+')
+
+########################################
+#
+# Dontaudit deny logs in row-level access control
+#
+
+# NOTE:
+# The purpose of the dontaudit rule in row-level access control is to prevent a flood of logs.
+# If a client tries to SELECT a table including violated tuples, these are filtered from
+# the result set as if not exist, but its access denied longs can be recorded within log files.
+# In generally, the number of tuples are much larger than the number of columns, tables and so on.
+# So, it makes a flood of logs when many tuples are violated.
+#
+# The default policy does not prevent anything for sepgsql_client_type sepgsql_unconfined_type,
+# so we don't need "dontaudit" rules in Type-Enforcement. However, MLS/MCS can prevent them
+# to access classified tuples and can make a audit record.
+#
+# Therefore, the following rule is applied for any domains which can connect SE-PostgreSQL.
+
+dontaudit { postgresql_t sepgsql_client_type sepgsql_unconfined_type } { sepgsql_table_type - sepgsql_sysobj_table_type } : db_tuple { use select update insert delete };
Index: refpolicy/policy/modules/services/postgresql.fc
===================================================================
--- refpolicy/policy/modules/services/postgresql.fc	(revision 2710)
+++ refpolicy/policy/modules/services/postgresql.fc	(working copy)
@@ -6,8 +6,8 @@
 #
 # /usr
 #
-/usr/bin/initdb			--	gen_context(system_u:object_r:postgresql_exec_t,s0)
-/usr/bin/postgres		--	gen_context(system_u:object_r:postgresql_exec_t,s0)
+/usr/bin/initdb(\.sepgsql)?	--	gen_context(system_u:object_r:postgresql_exec_t,s0)
+/usr/bin/(se)?postgres		--	gen_context(system_u:object_r:postgresql_exec_t,s0)
 
 /usr/lib/pgsql/test/regres(/.*)?	gen_context(system_u:object_r:postgresql_db_t,s0)
 /usr/lib/pgsql/test/regress/pg_regress -- gen_context(system_u:object_r:postgresql_exec_t,s0)
@@ -30,8 +30,12 @@
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
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy/policy/modules/system/userdomain.if	(revision 2710)
+++ refpolicy/policy/modules/system/userdomain.if	(working copy)
@@ -1197,6 +1197,10 @@
 		netutils_run_traceroute_cond($1_t,$1_r,{ $1_tty_device_t $1_devpts_t })
 	')
 
+	optional_policy(`
+		postgresql_userdom_template($1,$1_t,$1_r)
+	')
+
 	# Run pppd in pppd_t by default for user
 	optional_policy(`
 		ppp_run_cond($1_t,$1_r,{ $1_tty_device_t $1_devpts_t })
@@ -1367,6 +1371,10 @@
 	')
 
 	optional_policy(`
+		postgresql_unconfined($1_t)
+	')
+
+	optional_policy(`
 		userhelper_exec($1_t)
 	')
 ')
Index: refpolicy/policy/modules/system/libraries.te
===================================================================
--- refpolicy/policy/modules/system/libraries.te	(revision 2710)
+++ refpolicy/policy/modules/system/libraries.te	(working copy)
@@ -109,3 +109,8 @@
 	# blow up.
 	rpm_manage_script_tmp_files(ldconfig_t)
 ')
+
+optional_policy(`
+	postgresql_loadable_module(lib_t)
+	postgresql_loadable_module(textrel_shlib_t)
+')
Index: refpolicy/policy/modules/system/unconfined.if
===================================================================
--- refpolicy/policy/modules/system/unconfined.if	(revision 2710)
+++ refpolicy/policy/modules/system/unconfined.if	(working copy)
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
Index: refpolicy/policy/modules/system/init.fc
===================================================================
--- refpolicy/policy/modules/system/init.fc	(revision 2710)
+++ refpolicy/policy/modules/system/init.fc	(working copy)
@@ -38,6 +38,8 @@
 #
 # /usr
 #
+/usr/bin/sepg_ctl	--	gen_context(system_u:object_r:initrc_exec_t,s0)
+
 /usr/libexec/dcc/start-.* --	gen_context(system_u:object_r:initrc_exec_t,s0)
 /usr/libexec/dcc/stop-.* --	gen_context(system_u:object_r:initrc_exec_t,s0)
 

--------------080204020605080504040307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
