Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2R8J69N011684
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 04:19:16 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2R8F7sa001061
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 08:15:08 GMT
Message-ID: <49CC8BEF.507@ak.jp.nec.com>
Date: Fri, 27 Mar 2009 17:18:55 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: cpebenito@tresys.com
CC: selinux <selinux@tycho.nsa.gov>, refpolicy@oss.tresys.com
Subject: [PATCH] Policy rework for SE-PostgreSQL (Re: Some ideas in SE-PostgreSQL
 enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>
In-Reply-To: <49C9D524.9050208@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------080300010702050701020001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080300010702050701020001
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch is the first one in the series of reworks for
the SE-PostgreSQL security policy.

It updates the following items.

* Changes in the definition of object classes

This patch add new three object classes and modifies the definition
of a few object classes.
 - db_database:{get_param set_param} is removed due to nonsense.
 - db_database:{superuser} is added to restrict privileges of
   database superuser.
 - db_table/db_column/db_tuple:{use} is removed due to nonsense.
 - New object classes: db_catalog, db_schema and db_sequence are added.

In the previous design, we have the following object hierarchy:
  [db_database]
   + [db_table]
   |  + [db_column]
   |  + [db_tuple]
   + [db_procedure]
   + [db_blob]

The newly added db_schema should be placed between the db_database and
the db_table and others. TYPE_TRANSITION rules follows the revised design.

  [db_database]
   + [db_schema]
   |  + [db_table]
   |  |   + [db_column]
   |  |   + [db_tuple]
   |  + [db_procedure]
   |  + [db_sequence] (newly added object class)
   + [db_blob]

  (*) Unfortunatelly, PostgreSQL handles large object quite ad-hoc,
      although it can be used to communicate channel between multiple
      domains. So, it needs to be placed under the database.

Currently, SE-PostgreSQL does not use db_catalog class, but it can be
used for other DBMS's.

In addition, this patch changes something.

 o The trusted procedure (sepgsql_trusted_proc_t) lost the
   db_database:{superuser} privilege, because it is invoked by
   unprived users to over the MAC restriction for a certain
   purpose, but it does not need to allow superpower in DAC.

 o The trusted procedure (sepgsql_trusted_proc_exec_t) lost the
   db_procedure:{install} privilege, because once installed procedure
   as a system internal entity can be invoked implicitly.
   We should not install trusted procedures for the purpose.

 o The db_schema:{add_object remove_object} newly added are controled
   via the "sepgsql_enable_users_ddl" boolean.
   Now we control user's DDLs on uncategorized objects as row-level
   checks on sepgsql_sysobj_t, but it can be revised with adding
   db_schema object class.

 o type_transition for user_sepgsql_XXXX_t is moved to outside of
   tunable_policy(`...'). IIRC, I said these should be inside of
   the tunable, but unprive ones cannot create/drop tables labeled
   as sepgsql_XXX_t anyway when the boolean is disabled.
   So, I reconsidered it should be placed out of the tunable.

 o {create drop setattr} permission for user_sepgsql_XXX is moved
   to inside of the tunable_policy, even if it is db_procedure
   class. I wonder why we didn't control CREATE FUNCTION statement
   by unpriv domains.

 o db_blob:{import export} on user_sepgsql_blob_t is allowed to
   unpriv domains. It seems to me a strange behavior that it is
   not allowed on the object created by unpriv domain itself.

* Remaining items
 o When we allows an unpriv domain to access SE-PostgreSQL using
   postgresql_unpriv_client(), its default labeling behavior is
   same as unconfined domains. For example, functions created by
   them are labeled as "sepgsql_proc_t".
   Now I'm considering it should be user_sepgsql_XXXX_t, because
   I would like to handle unprefixed types as an object created
   by database administrator (unconfined domains).
   It helps correctness of db_procedure:{install} permission.

 o Because of db_schema object class, we can control user's DDLs
   without ad-hoc using row-level security on sepgsql_sysobj_t
   class. Now I think its purpose should be changed to prevent
   users accesses system catalogs directly.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------080300010702050701020001
Content-Type: text/x-patch;
 name="refpolicy-sepgsql-rework.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepgsql-rework.1.patch"

Index: policy/flask/security_classes
===================================================================
--- policy/flask/security_classes	(revision 2936)
+++ policy/flask/security_classes	(working copy)
@@ -119,4 +119,9 @@
 # kernel services that need to override task security, e.g. cachefiles
 class kernel_service 
 
+# More Database stuff
+class db_catalog		# userspace
+class db_schema			# userspace
+class db_sequence		# userspace
+
 # FLASK
Index: policy/flask/access_vectors
===================================================================
--- policy/flask/access_vectors	(revision 2936)
+++ policy/flask/access_vectors	(working copy)
@@ -723,14 +723,12 @@
 	access
 	install_module
 	load_module
-	get_param
-	set_param
+	superuser
 }
 
 class db_table
 inherits database
 {
-	use
 	select
 	update
 	insert
@@ -749,7 +747,6 @@
 class db_column
 inherits database
 {
-	use
 	select
 	update
 	insert
@@ -759,7 +756,6 @@
 {
 	relabelfrom
 	relabelto
-	use
 	select
 	update
 	insert
@@ -793,3 +789,27 @@
 	use_as_override
 	create_files_as	
 }
+
+# More database stuff
+class db_catalog
+inherits database
+{
+	search
+	add_object
+	remove_object
+}
+
+class db_schema
+inherits database
+{
+	search
+	add_object
+	remove_object
+}
+
+class db_sequence
+inherits database
+{
+	get_value
+	set_value
+}
Index: policy/modules/kernel/kernel.if
===================================================================
--- policy/modules/kernel/kernel.if	(revision 2936)
+++ policy/modules/kernel/kernel.if	(working copy)
@@ -2563,18 +2563,22 @@
 	gen_require(`
 		type unlabeled_t;
 		class db_database { setattr relabelfrom };
+		class db_schema { setattr relabelfrom };
 		class db_table { setattr relabelfrom };
 		class db_procedure { setattr relabelfrom };
 		class db_column { setattr relabelfrom };
 		class db_tuple { update relabelfrom };
+		class db_sequence { setattr relabelfrom };
 		class db_blob { setattr relabelfrom };
 	')
 
 	allow $1 unlabeled_t:db_database { setattr relabelfrom };
+	allow $1 unlabeled_t:db_schema { setattr relabelfrom };
 	allow $1 unlabeled_t:db_table { setattr relabelfrom };
 	allow $1 unlabeled_t:db_procedure { setattr relabelfrom };
 	allow $1 unlabeled_t:db_column { setattr relabelfrom };
 	allow $1 unlabeled_t:db_tuple { update relabelfrom };
+	allow $1 unlabeled_t:db_sequence { setattr relabelfrom };
 	allow $1 unlabeled_t:db_blob { setattr relabelfrom };
 ')
 
Index: policy/modules/services/postgresql.if
===================================================================
--- policy/modules/services/postgresql.if	(revision 2936)
+++ policy/modules/services/postgresql.if	(working copy)
@@ -24,7 +24,9 @@
 		class db_tuple all_db_tuple_perms;
 		class db_blob all_db_blob_perms;
 
-		attribute sepgsql_client_type, sepgsql_database_type;
+		attribute sepgsql_client_type;
+		attribute sepgsql_database_type;
+		attribute sepgsql_schema_type;
 		attribute sepgsql_sysobj_table_type;
 
 		type sepgsql_trusted_proc_exec_t, sepgsql_trusted_proc_t;
@@ -45,26 +47,28 @@
 	# Client local policy
 	#
 
+	type_transition $2 sepgsql_schema_type:db_table user_sepgsql_table_t;
+	type_transition $2 sepgsql_sysobj_t:db_tuple user_sepgsql_sysobj_t;
+	type_transition $2 sepgsql_schema_type:db_procedure user_sepgsql_proc_exec_t;
+	type_transition $2 sepgsql_schema_type:db_sequence user_sepgsql_sequence_t;
+	type_transition $2 sepgsql_database_type:db_blob user_sepgsql_blob_t;
+
 	tunable_policy(`sepgsql_enable_users_ddl',`
-		allow $2 user_sepgsql_table_t:db_table { create drop };
-		type_transition $2 sepgsql_database_type:db_table user_sepgsql_table_t;
-
-		allow $2 user_sepgsql_table_t:db_column { create drop };
-
-		allow $2 user_sepgsql_sysobj_t:db_tuple { update insert delete };
-		type_transition $2 sepgsql_sysobj_table_type:db_tuple user_sepgsql_sysobj_t;
+		allow $2 user_sepgsql_table_t:db_table { create drop setattr };
+		allow $2 user_sepgsql_table_t:db_column { create drop setattr };
+		allow $2 user_sepgsql_proc_exec_t:db_procedure { create drop setattr };
+		allow $2 user_sepgsql_sequence_t:db_sequence { create drop setattr };
 	')
+	allow $2 user_sepgsql_table_t:db_table  { getattr select update insert delete };
+	allow $2 user_sepgsql_table_t:db_column { getattr select update insert };
+	allow $2 user_sepgsql_table_t:db_tuple	{ select update insert delete };
+	allow $2 user_sepgsql_sysobj_t:db_tuple	{ select update insert delete };
 
-	allow $2 user_sepgsql_table_t:db_table  { getattr setattr use select update insert delete };
-	allow $2 user_sepgsql_table_t:db_column { getattr setattr use select update insert };
-	allow $2 user_sepgsql_table_t:db_tuple	{ use select update insert delete };
-	allow $2 user_sepgsql_sysobj_t:db_tuple	{ use select };
+	allow $2 user_sepgsql_proc_exec_t:db_procedure { getattr execute };
 
-	allow $2 user_sepgsql_proc_exec_t:db_procedure { create drop getattr setattr execute };
-	type_transition $2 sepgsql_database_type:db_procedure user_sepgsql_proc_exec_t;
+	allow $2 user_sepgsql_sequence_t:db_sequence { getattr get_value set_value };
 
-	allow $2 user_sepgsql_blob_t:db_blob { create drop getattr setattr read write };
-	type_transition $2 sepgsql_database_type:db_blob user_sepgsql_blob_t;
+	allow $2 user_sepgsql_blob_t:db_blob { create drop getattr setattr read write import export };
 
 	allow $2 sepgsql_trusted_proc_t:process transition;
 	type_transition $2 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
@@ -108,6 +112,24 @@
 
 ########################################
 ## <summary>
+##	Marks as a SE-PostgreSQL schema object type
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type marked as a schema object type.
+##	</summary>
+## </param>
+#
+interface(`postgresql_schema_object',`
+	gen_require(`
+		attribute sepgsql_schema_type;
+	')
+
+	typeattribute $1 sepgsql_schema_type;
+')
+
+########################################
+## <summary>
 ##	Marks as a SE-PostgreSQL table/column/tuple object type
 ## </summary>
 ## <param name="type">
@@ -163,6 +185,24 @@
 
 ########################################
 ## <summary>
+##	Marks as a SE-PostgreSQL sequence object type
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type marked as a sequence object type.
+##	</summary>
+## </param>
+#
+interface(`postgresql_sequence_object',`
+	gen_require(`
+		attribute sepgsql_sequence_type;
+	')
+
+	typeattribute $1 sepgsql_sequence_type;
+')
+
+########################################
+## <summary>
 ##	Marks as a SE-PostgreSQL binary large object type
 ## </summary>
 ## <param name="type">
@@ -319,14 +359,16 @@
 
 		attribute sepgsql_client_type;
 
-		type sepgsql_db_t, sepgsql_table_t, sepgsql_proc_t, sepgsql_blob_t;
+		type sepgsql_db_t, sepgsql_schema_t;
+		type sepgsql_table_t, sepgsql_proc_t, sepgsql_sequence_t, sepgsql_blob_t;
 		type sepgsql_trusted_proc_t, sepgsql_trusted_proc_exec_t;
 	')
 
 	typeattribute $1 sepgsql_client_type;
 
-	type_transition $1 sepgsql_db_t:db_table sepgsql_table_t;
-	type_transition $1 sepgsql_db_t:db_procedure sepgsql_proc_t;
+	type_transition $1 sepgsql_schema_t:db_table sepgsql_table_t;
+	type_transition $1 sepgsql_schema_t:db_procedure sepgsql_proc_t;
+	type_transition $1 sepgsql_schema_t:db_sequence sepgsql_sequence_t;
 	type_transition $1 sepgsql_db_t:db_blob sepgsql_blob_t;
 
 	type_transition $1 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
@@ -346,8 +388,30 @@
 #
 interface(`postgresql_unconfined',`
 	gen_require(`
+		class db_database { superuser };
+
 		attribute sepgsql_unconfined_type;
 	')
 
 	typeattribute $1 sepgsql_unconfined_type;
+	allow $1 $1 : db_database superuser;
 ')
+
+########################################
+## <summary>
+##	Allow the specified domain unconfined accesses without superuser
+##	to any database objects managed by SE-PostgreSQL,
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`postgresql_unconfined_without_superuser',`
+	gen_require(`
+		attribute sepgsql_unconfined_type;
+	')
+
+	typeattribute $1 sepgsql_unconfined_type;
+')
Index: policy/modules/services/postgresql.te
===================================================================
--- policy/modules/services/postgresql.te	(revision 2936)
+++ policy/modules/services/postgresql.te	(working copy)
@@ -1,12 +1,14 @@
 
-policy_module(postgresql, 1.8.3)
+policy_module(postgresql, 1.9.1)
 
 gen_require(`
 	class db_database all_db_database_perms;
+	class db_schema all_db_schema_perms;
 	class db_table all_db_table_perms;
 	class db_procedure all_db_procedure_perms;
 	class db_column all_db_column_perms;
 	class db_tuple all_db_tuple_perms;
+	class db_sequence all_db_sequence_perms;
 	class db_blob all_db_blob_perms;
 ')
 
@@ -50,9 +52,11 @@
 
 # database objects attribute
 attribute sepgsql_database_type;
+attribute sepgsql_schema_type;
 attribute sepgsql_table_type;
 attribute sepgsql_sysobj_table_type;
 attribute sepgsql_procedure_type;
+attribute sepgsql_sequence_type;
 attribute sepgsql_blob_type;
 attribute sepgsql_module_type;
 
@@ -75,12 +79,18 @@
 type sepgsql_ro_table_t;
 postgresql_table_object(sepgsql_ro_table_t)
 
+type sepgsql_schema_t;
+postgresql_schema_object(sepgsql_schema_t)
+
 type sepgsql_secret_blob_t;
 postgresql_blob_object(sepgsql_secret_blob_t)
 
 type sepgsql_secret_table_t;
 postgresql_table_object(sepgsql_secret_table_t)
 
+type sepgsql_sequence_t;
+postgresql_sequence_object(sepgsql_sequence_t)
+
 type sepgsql_sysobj_t;
 postgresql_system_table_object(sepgsql_sysobj_t)
 
@@ -93,7 +103,7 @@
 # Trusted Procedure Domain
 type sepgsql_trusted_proc_t;
 domain_type(sepgsql_trusted_proc_t)
-postgresql_unconfined(sepgsql_trusted_proc_t)
+postgresql_unconfined_without_superuser(sepgsql_trusted_proc_t)
 role system_r types sepgsql_trusted_proc_t;
 
 type user_sepgsql_blob_t;
@@ -106,6 +116,11 @@
 typealias user_sepgsql_proc_exec_t alias { auditadm_sepgsql_proc_exec_t secadm_sepgsql_proc_exec_t };
 postgresql_procedure_object(user_sepgsql_proc_exec_t)
 
+type user_sepgsql_sequence_t;
+typealias user_sepgsql_sequence_t alias { staff_sepgsql_sequence_t sysadm_sepgsql_sequence_t };
+typealias user_sepgsql_sequence_t alias { auditadm_sepgsql_sequence_t secadm_sepgsql_sequence_t };
+postgresql_sequence_object(user_sepgsql_sequence_t)
+
 type user_sepgsql_sysobj_t;
 typealias user_sepgsql_sysobj_t alias { staff_sepgsql_sysobj_t sysadm_sepgsql_sysobj_t };
 typealias user_sepgsql_sysobj_t alias { auditadm_sepgsql_sysobj_t secadm_sepgsql_sysobj_t };
@@ -135,16 +150,22 @@
 allow postgresql_t sepgsql_database_type:db_database *;
 type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
 
+allow postgresql_t sepgsql_schema_type:db_schema *;
+type_transition postgresql_t sepgsql_database_type:db_schema sepgsql_schema_t;
+
 allow postgresql_t sepgsql_module_type:db_database install_module;
 # Database/Loadable module
 allow sepgsql_database_type sepgsql_module_type:db_database load_module;
 
 allow postgresql_t sepgsql_table_type:{ db_table db_column db_tuple } *;
-type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
+type_transition postgresql_t sepgsql_schema_type:db_table sepgsql_sysobj_t;
 
 allow postgresql_t sepgsql_procedure_type:db_procedure *;
-type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
+type_transition postgresql_t sepgsql_schema_type:db_procedure sepgsql_proc_t;
 
+allow postgresql_t sepgsql_sequence_type:db_sequence *;
+type_transition postgresql_t sepgsql_schema_type:db_sequence sepgsql_sequence_t;
+
 allow postgresql_t sepgsql_blob_type:db_blob *;
 type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
 
@@ -281,27 +302,30 @@
 # Rules common to all clients
 #
 
-allow sepgsql_client_type sepgsql_db_t:db_database { getattr access get_param set_param };
+allow sepgsql_client_type sepgsql_db_t:db_database { getattr access };
 type_transition sepgsql_client_type sepgsql_client_type:db_database sepgsql_db_t;
 
-allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr use select insert };
-allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr use select insert };
-allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { use select insert };
+allow sepgsql_client_type sepgsql_schema_t:db_schema { search };
+type_transition sepgsql_client_type sepgsql_schema_type:db_schema sepgsql_schema_t;
 
-allow sepgsql_client_type sepgsql_table_t:db_table { getattr use select update insert delete };
-allow sepgsql_client_type sepgsql_table_t:db_column { getattr use select update insert };
-allow sepgsql_client_type sepgsql_table_t:db_tuple { use select update insert delete };
+allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr select insert lock };
+allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr select insert };
+allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { select insert };
 
-allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr use select };
-allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr use select };
-allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { use select };
+allow sepgsql_client_type sepgsql_table_t:db_table { getattr select update insert delete lock };
+allow sepgsql_client_type sepgsql_table_t:db_column { getattr select update insert };
+allow sepgsql_client_type sepgsql_table_t:db_tuple { select update insert delete };
 
+allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr select lock };
+allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr select };
+allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { select };
+
 allow sepgsql_client_type sepgsql_secret_table_t:db_table getattr;
 allow sepgsql_client_type sepgsql_secret_table_t:db_column getattr;
 
-allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr use select };
-allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr use select };
-allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { use select };
+allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr select };
+allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr select };
+allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { select };
 
 allow sepgsql_client_type sepgsql_proc_t:db_procedure { getattr execute install };
 allow sepgsql_client_type sepgsql_trusted_proc_t:db_procedure { getattr execute entrypoint };
@@ -321,9 +345,10 @@
 # to access classified tuples and can make a audit record.
 #
 # Therefore, the following rule is applied for any domains which can connect SE-PostgreSQL.
-dontaudit { postgresql_t sepgsql_client_type sepgsql_unconfined_type } { sepgsql_table_type -sepgsql_sysobj_table_type }:db_tuple { use select update insert delete };
+dontaudit { postgresql_t sepgsql_client_type sepgsql_unconfined_type } { sepgsql_table_type -sepgsql_sysobj_table_type }:db_tuple { select update insert delete };
 
 tunable_policy(`sepgsql_enable_users_ddl',`
+	allow sepgsql_client_type sepgsql_schema_t:db_schema { add_object remove_object };
 	allow sepgsql_client_type sepgsql_table_t:db_table { create drop setattr };
 	allow sepgsql_client_type sepgsql_table_t:db_column { create drop setattr };
 	allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { update insert delete };
@@ -334,20 +359,29 @@
 # Unconfined access to this module
 #
 
-allow sepgsql_unconfined_type sepgsql_database_type:db_database *;
+allow sepgsql_unconfined_type sepgsql_database_type:db_database ~{ superuser };
 type_transition sepgsql_unconfined_type sepgsql_unconfined_type:db_database sepgsql_db_t;
 
-type_transition sepgsql_unconfined_type sepgsql_database_type:db_table sepgsql_table_t;
-type_transition sepgsql_unconfined_type sepgsql_database_type:db_procedure sepgsql_proc_t;
+allow sepgsql_unconfined_type sepgsql_schema_type:db_schema *;
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_schema sepgsql_schema_t;
+
+type_transition sepgsql_unconfined_type sepgsql_schema_type:db_table sepgsql_table_t;
+type_transition sepgsql_unconfined_type sepgsql_schema_type:db_procedure sepgsql_proc_t;
+type_transition sepgsql_unconfined_type sepgsql_schema_type:db_sequence sepgsql_sequence_t;
 type_transition sepgsql_unconfined_type sepgsql_database_type:db_blob sepgsql_blob_t;
 
 allow sepgsql_unconfined_type sepgsql_table_type:{ db_table db_column db_tuple } *;
 
 # unconfined domain is not allowed to invoke user defined procedure directly.
 # They have to confirm and relabel it at first.
-allow sepgsql_unconfined_type { sepgsql_proc_t sepgsql_trusted_proc_t }:db_procedure *;
-allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure { create drop getattr setattr relabelfrom relabelto };
+# In addition, trusted procedure should not installed as system internal procedure,
+# because it can be implicitly invoked.
+allow sepgsql_unconfined_type sepgsql_proc_t:db_procedure *;
+allow sepgsql_unconfined_type sepgsql_trusted_proc_t:db_procedure ~{ install };
+allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure ~{ execute install };
 
+allow sepgsql_unconfined_type sepgsql_sequence_type:db_sequence *;
+
 allow sepgsql_unconfined_type sepgsql_blob_type:db_blob *;
 
 allow sepgsql_unconfined_type sepgsql_module_type:db_database install_module;

--------------080300010702050701020001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
