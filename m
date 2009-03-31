Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2V8tp8H029043
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 04:55:51 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2V8tnT8027956
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 08:55:49 GMT
Message-ID: <49D1DA85.1030902@ak.jp.nec.com>
Date: Tue, 31 Mar 2009 17:55:33 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: cpebenito@tresys.com
CC: method@manicmethod.com, warner@rubix.com, selinux@tycho.nsa.gov,
        refpolicy@oss.tresys.com
Subject: [RFC] Security policy reworks for SE-PostgreSQL
Content-Type: multipart/mixed;
 boundary="------------020304030909080005080302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020304030909080005080302
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

As we have discussed for the recent week, I have a plan to rework
some of security policy for SE-PostgreSQL.

The attached patch adds the significan changes, as follows.
Could you give me any suggestion, approval or opposition?

New object classes and permissions
----------------------------------
 * db_catalog class
   It shows the top level namespace in the database, and has a capability
   to store a set of schemas. Some of implementation does not support
   catalogs. In this case, we simply ignore this class and any schemas
   are placed under the db_database directly.

   It defines the following four permissions and inherited ones:
     { search add_object remove_object associate }

   Client should have db_catalog:{search} on the catalog when he refers
   any schemas under the catalog, and he should also have
   db_catalog:{add_object} and db_catalog:{remove_object} on the catalog
   when he tries to add or remove a shema within the catalog.
   These permissions are an analogy of dir object class.

   The db_catalog:{associate}, which I've not introduced yet but noticed
   its necessity, is also checked when we create or relabel a schema
   within the catalog, and the schema should have db_catalog:{associate}
   on the catalog. It is an analogy of filesystem:{associate}.
   It prevents a schema is labeled unexpectedly.

 * db_schema class
   It shows the second level namespace in the database, but it may be
   the top level one in some of implementation (like PostgreSQL).
   It has a capability to store a set of database objects (tables,
   procedures and so on).

   It defines the following four permissions and inherited ones:
     { search add_object remove_object associate }
   Their meanings are similar to ones in db_catalog class except for
   the schema to be replaced by database objects.

   Its security context can be computed with TYPE_TRANSITION between
   the client as a subject and the database (or catalog, if availabel)
   as a target.

 * db_sequence class
   It shows the sequential number generator objects. We can also use
   them as a communication channel between two domains, so it is
   necessary to apply security policy.

   It inherits common database and defines the following two permissions:
     { get_value set_value }
   Client should have db_sequence:{get_value} when he fetch a value from
   the sequence generator, and db_sequence:{set_value} when he set a
   discretionary value. When he fetch a value from the sequence object,
   it implicitly increments internal counter, but it is covered by the
   get_value permission.

   Its security context can be computed with TYPE_TRANSITION between
   the client as a subject and the schema as a target.

Change definition of object classes
-----------------------------------
 * db_database class
   The db_database:{get_param set_param} is removed because these two
   permissions are nonsense.
   The db_database:{superuser} is newly added. It is checked when
   client perform as database superuser. Stephen suggested it can
   be separated to more finer grained privileges. It makes sense,
   but this kind of separation which focuses on PostgreSQL makes
   hard to port the concept for other database management systems.

 * db_table/db_column/db_tuple:{use} permission
   The db_xxx:{use} permission is integrated into db_xxx:{select}
   permission, because it can hide the risk to infer invisible
   information easily with well considered WHERE clauses.

user_sepgsql_xxxx_t types
-------------------------
 * Currently, sepgsql_proc_t is assigned to the procedures created
   by unprivileged and unprefixed clients, like httpd_t.
   But I would like to handle it as a procedure created or relabeled
   by database administrator.
   Basically, we consider user defined procedures are untrusted, so
   it should be checked before it becomes available for all the clients.
   So, we don't allow to install them as system internal entities, and
   don't allow unconfined domains to execute them directly.

   My preference is the user_sepgsql_xxxx_t is also assigned to
   procedures created by unprivileged and unprfixed client.

A schema for temporary obejcts
------------------------------
 * The sepgsql_schema_t is the default type for schema objects, and
   rest of database objects within the schema is labeled with the chain
   of TYPE_TRANSITION rules.
   We have a characteristic scheme named as "pg_temp_*". Any database
   objects within the schema are cleared after the session closed,
   so its contents are always session local. We would like to assign
   special types on the temporary schema and delivered database objects
   withing the schema. In addition, users can create and use these
   database objects independently from the sepgsql_enable_users_ddl.

Booelean behavior: sepgsql_enable_users_ddl
-------------------------------------------
 * Because the current design does not care about actions on schema
   objects, we need to assign separated label (sepgsql_sysobj_t) on
   system informations and apply checks as row-level controls.
   But db_schema object class enables to control user's DDLs in
   the schema level checks mainly, so now sepgsql_enable_user_ddl
   focuses on db_schema class permissions and {create drop setattr}
   for any other database objects.
   The attached patch allows users to modify tuples with sepgsql_sysobj_t
   but not allows columns/tables. It means user can define database
   objects with proper way (like CREATE TABLE), but prevents to
   manipulate system information by hand.
   In addition, this boolean controls only user_sepgsql_xxxx_t.
   The unprefixed types are always not allowed to modify its definition
   by unprivileges users.

db_table:{lock} for reader actions
----------------------------------
 * db_table:{lock} is also necessary for reader side actions due to the
   implementation reason.
   In PostgreSQL, FK constraints are implemented as trigger functions.
   It is invoked for each INSERT/UPDATE/DELETE on constrainted tuples,
   and run a secondary query to check whether the action satisfies
   FK constraints or not.
   This query is described as:
     SELECT 1 FROM t WHERE k = "$1" FOR SHARE;

   The "FOR SHARE" clause means explicit table lock and requires
   db_table:{lock} permission. If we don't allow unpriv clients to
   lock read-only tables, it disables to set up FK constraint which
   refers read-only tables.

Miscellaneous changes
---------------------
 * The security context of a new database is decided via type_transition
   on the server process's context. It enables to avoid conflicts when
   we have multiple DBMSs in a system.
 * It allows postgresql_t domain to write out messages to system audit.
 * sepgsql_proc_t is aliased to sepgsql_proc_exec_t.
 * db_procedure:{install} is revoked from sepgsql_trusted_proc_exec_t,
   because we don't need to run trusted procedure implicitly.
 * Most of postgresql_role() are shared with postgresql_unpriv_client(),
   except for "role $1 types sepgsql_trusted_proc_t;"
 * /etc/selinux/$POLICYTYPE/contexts/db_contexts for selabel_lookup(3)

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------020304030909080005080302
Content-Type: text/x-patch;
 name="refpolicy-sepgsql-rework.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepgsql-rework.2.patch"

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
@@ -793,3 +789,29 @@
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
+	associate
+}
+
+class db_schema
+inherits database
+{
+	search
+	add_object
+	remove_object
+	associate
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
@@ -17,57 +17,12 @@
 #
 interface(`postgresql_role',`
 	gen_require(`
-		class db_database all_db_database_perms;
-		class db_table all_db_table_perms;
-		class db_procedure all_db_procedure_perms;
-		class db_column all_db_column_perms;
-		class db_tuple all_db_tuple_perms;
-		class db_blob all_db_blob_perms;
-
-		attribute sepgsql_client_type, sepgsql_database_type;
-		attribute sepgsql_sysobj_table_type;
-
-		type sepgsql_trusted_proc_exec_t, sepgsql_trusted_proc_t;
-		type user_sepgsql_blob_t, user_sepgsql_proc_exec_t;
-		type user_sepgsql_sysobj_t, user_sepgsql_table_t;
+		type sepgsql_trusted_proc_t;
 	')
 
-	########################################
-	#
-	# Declarations
-	#
-
-	typeattribute $2 sepgsql_client_type;
 	role $1 types sepgsql_trusted_proc_t;
 
-	##############################
-	#
-	# Client local policy
-	#
-
-	tunable_policy(`sepgsql_enable_users_ddl',`
-		allow $2 user_sepgsql_table_t:db_table { create drop };
-		type_transition $2 sepgsql_database_type:db_table user_sepgsql_table_t;
-
-		allow $2 user_sepgsql_table_t:db_column { create drop };
-
-		allow $2 user_sepgsql_sysobj_t:db_tuple { update insert delete };
-		type_transition $2 sepgsql_sysobj_table_type:db_tuple user_sepgsql_sysobj_t;
-	')
-
-	allow $2 user_sepgsql_table_t:db_table  { getattr setattr use select update insert delete };
-	allow $2 user_sepgsql_table_t:db_column { getattr setattr use select update insert };
-	allow $2 user_sepgsql_table_t:db_tuple	{ use select update insert delete };
-	allow $2 user_sepgsql_sysobj_t:db_tuple	{ use select };
-
-	allow $2 user_sepgsql_proc_exec_t:db_procedure { create drop getattr setattr execute };
-	type_transition $2 sepgsql_database_type:db_procedure user_sepgsql_proc_exec_t;
-
-	allow $2 user_sepgsql_blob_t:db_blob { create drop getattr setattr read write };
-	type_transition $2 sepgsql_database_type:db_blob user_sepgsql_blob_t;
-
-	allow $2 sepgsql_trusted_proc_t:process transition;
-	type_transition $2 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
+	postgresql_unpriv_client($2)
 ')
 
 ########################################
@@ -108,6 +63,24 @@
 
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
@@ -163,6 +136,24 @@
 
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
@@ -181,6 +172,24 @@
 
 ########################################
 ## <summary>
+##	Marks as a SE-PostgreSQL object type stored within temporary schema
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type marked as a temporary database object type.
+##	</summary>
+## </param>
+#
+interface(`postgresql_temporary_object',`
+	gen_require(`
+		attribute sepgsql_temporary_type;
+	')
+
+	typeattribute $1 sepgsql_temporary_type;
+')
+
+########################################
+## <summary>
 ##	Allow the specified domain to search postgresql's database directory.
 ## </summary>
 ## <param name="domain">
@@ -313,22 +322,46 @@
 #
 interface(`postgresql_unpriv_client',`
 	gen_require(`
+		class db_database all_db_database_perms;
+		class db_schema all_db_schema_perms;
 		class db_table all_db_table_perms;
 		class db_procedure all_db_procedure_perms;
+		class db_column all_db_column_perms;
+		class db_tuple all_db_tuple_perms;
+		class db_sequence all_db_sequence_perms;
 		class db_blob all_db_blob_perms;
 
-		attribute sepgsql_client_type;
+		attribute sepgsql_client_type, sepgsql_database_type;
 
-		type sepgsql_db_t, sepgsql_table_t, sepgsql_proc_t, sepgsql_blob_t;
+		type sepgsql_schema_t, sepgsql_temp_schema_t;
+		type user_sepgsql_table_t, user_sepgsql_proc_exec_t;
+		type user_sepgsql_sequence_t, user_sepgsql_blob_t;
+		type sepgsql_temp_table_t, sepgsql_temp_proc_exec_t, sepgsql_temp_sequence_t;
 		type sepgsql_trusted_proc_t, sepgsql_trusted_proc_exec_t;
 	')
 
+	########################################
+	#
+	# Declarations
+	#
+
 	typeattribute $1 sepgsql_client_type;
 
-	type_transition $1 sepgsql_db_t:db_table sepgsql_table_t;
-	type_transition $1 sepgsql_db_t:db_procedure sepgsql_proc_t;
-	type_transition $1 sepgsql_db_t:db_blob sepgsql_blob_t;
+	##############################
+	#
+	# Type transitions
+	#
+	type_transition $1 sepgsql_schema_t:db_table user_sepgsql_table_t;
+	type_transition $1 sepgsql_schema_t:db_procedure user_sepgsql_proc_exec_t;
+	type_transition $1 sepgsql_schema_t:db_sequence user_sepgsql_sequence_t;
 
+	type_transition $1 sepgsql_temp_schema_t:db_table sepgsql_temp_table_t;
+	type_transition $1 sepgsql_temp_schema_t:db_procedure sepgsql_temp_proc_exec_t;
+	type_transition $1 sepgsql_temp_schema_t:db_sequence sepgsql_temp_sequence_t;
+
+	type_transition $1 sepgsql_database_type:db_blob user_sepgsql_blob_t;
+
+	# Trusted procedure invocation
 	type_transition $1 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
 	allow $1 sepgsql_trusted_proc_t:process transition;
 ')
@@ -346,8 +379,31 @@
 #
 interface(`postgresql_unconfined',`
 	gen_require(`
+		class db_database {superuser};
+
 		attribute sepgsql_unconfined_type;
 	')
 
 	typeattribute $1 sepgsql_unconfined_type;
+
+	allow $1 $1 : db_database {superuser};
 ')
+
+########################################
+## <summary>
+##	Allow the specified domain unconfined accesses to any database objects
+##	managed by SE-PostgreSQL, without db_database:{superuser} privilege.
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
 
@@ -50,10 +52,13 @@
 
 # database objects attribute
 attribute sepgsql_database_type;
+attribute sepgsql_schema_type;
 attribute sepgsql_table_type;
 attribute sepgsql_sysobj_table_type;
 attribute sepgsql_procedure_type;
 attribute sepgsql_blob_type;
+attribute sepgsql_sequence_type;
+attribute sepgsql_temporary_type;
 attribute sepgsql_module_type;
 
 # database object types
@@ -66,8 +71,9 @@
 type sepgsql_fixed_table_t;
 postgresql_table_object(sepgsql_fixed_table_t)
 
-type sepgsql_proc_t;
-postgresql_procedure_object(sepgsql_proc_t)
+type sepgsql_proc_exec_t;
+typealias sepgsql_proc_exec_t alias { sepgsql_proc_t };
+postgresql_procedure_object(sepgsql_proc_exec_t)
 
 type sepgsql_ro_blob_t;
 postgresql_blob_object(sepgsql_ro_blob_t)
@@ -75,25 +81,46 @@
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
 
 type sepgsql_table_t;
 postgresql_table_object(sepgsql_table_t)
 
+type sepgsql_temp_proc_exec_t;
+postgresql_procedure_object(sepgsql_temp_proc_exec_t)
+postgresql_temporary_object(sepgsql_temp_proc_exec_t)
+
+type sepgsql_temp_schema_t;
+postgresql_schema_object(sepgsql_temp_schema_t)
+
+type sepgsql_temp_sequence_t;
+postgresql_sequence_object(sepgsql_temp_sequence_t)
+postgresql_temporary_object(sepgsql_temp_sequence_t)
+
+type sepgsql_temp_table_t;
+postgresql_table_object(sepgsql_temp_table_t)
+postgresql_temporary_object(sepgsql_temp_table_t)
+
 type sepgsql_trusted_proc_exec_t;
 postgresql_procedure_object(sepgsql_trusted_proc_exec_t)
 
 # Trusted Procedure Domain
 type sepgsql_trusted_proc_t;
 domain_type(sepgsql_trusted_proc_t)
-postgresql_unconfined(sepgsql_trusted_proc_t)
+postgresql_unconfined_without_superuser(sepgsql_trusted_proc_t)
 role system_r types sepgsql_trusted_proc_t;
 
 type user_sepgsql_blob_t;
@@ -106,6 +133,10 @@
 typealias user_sepgsql_proc_exec_t alias { auditadm_sepgsql_proc_exec_t secadm_sepgsql_proc_exec_t };
 postgresql_procedure_object(user_sepgsql_proc_exec_t)
 
+type user_sepgsql_sequence_t;
+typealias user_sepgsql_sequence_t alias { staff_sepgsql_sequence_t sysadm_sepgsql_sequence_t };
+typealias user_sepgsql_sequence_t alias { auditadm_sepgsql_sequence_t secadm_sepgsql_sequence_t };
+
 type user_sepgsql_sysobj_t;
 typealias user_sepgsql_sysobj_t alias { staff_sepgsql_sysobj_t sysadm_sepgsql_sysobj_t };
 typealias user_sepgsql_sysobj_t alias { auditadm_sepgsql_sysobj_t secadm_sepgsql_sysobj_t };
@@ -116,11 +147,17 @@
 typealias user_sepgsql_table_t alias { auditadm_sepgsql_table_t secadm_sepgsql_table_t };
 postgresql_table_object(user_sepgsql_table_t)
 
+# Relationship between schema and database objects
+allow { sepgsql_table_type     - sepgsql_temporary_type } sepgsql_schema_t : db_schema { associate };
+allow { sepgsql_procedure_type - sepgsql_temporary_type } sepgsql_schema_t : db_schema { associate };
+allow { sepgsql_sequence_type  - sepgsql_temporary_type } sepgsql_schema_t : db_schema { associate };
+allow { sepgsql_temporary_type } sepgsql_temp_schema_t : db_schema { associate };
+
 ########################################
 #
 # postgresql Local policy
 #
-allow postgresql_t self:capability { kill dac_override dac_read_search chown fowner fsetid setuid setgid sys_nice sys_tty_config sys_admin };
+allow postgresql_t self:capability { kill dac_override dac_read_search chown fowner fsetid setuid setgid sys_nice sys_tty_config sys_admin audit_write };
 dontaudit postgresql_t self:capability { sys_tty_config sys_admin };
 allow postgresql_t self:process signal_perms;
 allow postgresql_t self:fifo_file rw_fifo_file_perms;
@@ -130,6 +167,7 @@
 allow postgresql_t self:udp_socket create_stream_socket_perms;
 allow postgresql_t self:unix_dgram_socket create_socket_perms;
 allow postgresql_t self:unix_stream_socket create_stream_socket_perms;
+allow postgresql_t self:netlink_audit_socket create_socket_perms;
 allow postgresql_t self:netlink_selinux_socket create_socket_perms;
 
 allow postgresql_t sepgsql_database_type:db_database *;
@@ -139,11 +177,14 @@
 # Database/Loadable module
 allow sepgsql_database_type sepgsql_module_type:db_database load_module;
 
+allow postgresql_t sepgsql_schema_type:db_schema *;
+type_transition postgresql_t sepgsql_schema_type:db_schema sepgsql_schema_t;
+
 allow postgresql_t sepgsql_table_type:{ db_table db_column db_tuple } *;
-type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
+type_transition postgresql_t sepgsql_schema_type:db_table sepgsql_sysobj_t;
 
 allow postgresql_t sepgsql_procedure_type:db_procedure *;
-type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
+type_transition postgresql_t sepgsql_schema_type:db_procedure sepgsql_proc_exec_t;
 
 allow postgresql_t sepgsql_blob_type:db_blob *;
 type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
@@ -281,35 +322,56 @@
 # Rules common to all clients
 #
 
-allow sepgsql_client_type sepgsql_db_t:db_database { getattr access get_param set_param };
-type_transition sepgsql_client_type sepgsql_client_type:db_database sepgsql_db_t;
+allow sepgsql_client_type sepgsql_db_t:db_database { getattr access };
+type_transition sepgsql_client_type postgresql_t:db_database sepgsql_db_t;
 
-allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr use select insert };
-allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr use select insert };
-allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { use select insert };
+allow sepgsql_client_type sepgsql_schema_t:db_schema { search };
+allow sepgsql_client_type sepgsql_temp_schema_t:db_schema { search add_object remove_object };
 
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
+allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr select lock };
+allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr select };
+allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { select update insert delete };
 
 allow sepgsql_client_type sepgsql_proc_t:db_procedure { getattr execute install };
 allow sepgsql_client_type sepgsql_trusted_proc_t:db_procedure { getattr execute entrypoint };
 
+allow sepgsql_client_type sepgsql_sequence_t:db_sequence { getattr get_value };
+
 allow sepgsql_client_type sepgsql_blob_t:db_blob { create drop getattr setattr read write };
 allow sepgsql_client_type sepgsql_ro_blob_t:db_blob { getattr read };
 allow sepgsql_client_type sepgsql_secret_blob_t:db_blob getattr;
 
+allow sepgsql_client_type sepgsql_temp_table_t:db_table { create drop getattr setattr select update insert delete lock };
+allow sepgsql_client_type sepgsql_temp_table_t:db_column { create drop getattr setattr select update insert };
+allow sepgsql_client_type sepgsql_temp_table_t:db_tuple { select update insert delete };
+
+allow sepgsql_client_type sepgsql_temp_proc_exec_t:db_procedure { create drop getattr setattr execute };
+
+allow sepgsql_client_type sepgsql_temp_sequence_t:db_sequence { create drop getattr setattr get_value set_value };
+
+allow sepgsql_client_type user_sepgsql_table_t:db_table { getattr select update insert delete lock };
+allow sepgsql_client_type user_sepgsql_table_t:db_column { getattr select update insert };
+allow sepgsql_client_type user_sepgsql_table_t:db_tuple { select update insert delete };
+
+allow sepgsql_client_type user_sepgsql_proc_exec_t:db_procedure { getattr execute };
+
+allow sepgsql_client_type user_sepgsql_sequence_t:db_sequence { getattr get_value set_value };
+
 # The purpose of the dontaudit rule in row-level access control is to prevent a flood of logs.
 # If a client tries to SELECT a table including violated tuples, these are filtered from
 # the result set as if not exist, but its access denied longs can be recorded within log files.
@@ -321,12 +383,14 @@
 # to access classified tuples and can make a audit record.
 #
 # Therefore, the following rule is applied for any domains which can connect SE-PostgreSQL.
-dontaudit { postgresql_t sepgsql_client_type sepgsql_unconfined_type } { sepgsql_table_type -sepgsql_sysobj_table_type }:db_tuple { use select update insert delete };
+dontaudit { postgresql_t sepgsql_client_type sepgsql_unconfined_type } { sepgsql_table_type -sepgsql_sysobj_table_type }:db_tuple { select update insert delete };
 
 tunable_policy(`sepgsql_enable_users_ddl',`
-	allow sepgsql_client_type sepgsql_table_t:db_table { create drop setattr };
-	allow sepgsql_client_type sepgsql_table_t:db_column { create drop setattr };
-	allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { update insert delete };
+	allow sepgsql_client_type sepgsql_schema_t:db_schema { add_object remove_object };
+	allow sepgsql_client_type user_sepgsql_table_t:db_table { create drop setattr };
+	allow sepgsql_client_type user_sepgsql_table_t:db_column { create drop setattr };
+	allow sepgsql_client_type user_sepgsql_proc_exec_t:db_procedure { create drop setattr };
+	allow sepgsql_client_type user_sepgsql_sequence_t:db_sequence { create drop setattr };
 ')
 
 ########################################
@@ -334,20 +398,33 @@
 # Unconfined access to this module
 #
 
-allow sepgsql_unconfined_type sepgsql_database_type:db_database *;
-type_transition sepgsql_unconfined_type sepgsql_unconfined_type:db_database sepgsql_db_t;
+allow sepgsql_unconfined_type sepgsql_database_type:db_database ~{superuser};
+type_transition sepgsql_unconfined_type postgresql_t:db_database sepgsql_db_t;
 
-type_transition sepgsql_unconfined_type sepgsql_database_type:db_table sepgsql_table_t;
-type_transition sepgsql_unconfined_type sepgsql_database_type:db_procedure sepgsql_proc_t;
+allow sepgsql_unconfined_type sepgsql_schema_type:db_schema *;
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_schema sepgsql_schema_t;
+
+type_transition sepgsql_unconfined_type sepgsql_schema_t:db_table sepgsql_table_t;
+type_transition sepgsql_unconfined_type sepgsql_schema_t:db_procedure sepgsql_proc_exec_t;
+type_transition sepgsql_unconfined_type sepgsql_schema_t:db_sequence sepgsql_sequence_t;
+
+type_transition sepgsql_unconfined_type sepgsql_temp_schema_t:db_table sepgsql_temp_table_t;
+type_transition sepgsql_unconfined_type sepgsql_temp_schema_t:db_procedure sepgsql_temp_proc_exec_t;
+type_transition sepgsql_unconfined_type sepgsql_temp_schema_t:db_sequence sepgsql_temp_sequence_t;
+
 type_transition sepgsql_unconfined_type sepgsql_database_type:db_blob sepgsql_blob_t;
 
 allow sepgsql_unconfined_type sepgsql_table_type:{ db_table db_column db_tuple } *;
 
 # unconfined domain is not allowed to invoke user defined procedure directly.
 # They have to confirm and relabel it at first.
-allow sepgsql_unconfined_type { sepgsql_proc_t sepgsql_trusted_proc_t }:db_procedure *;
-allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure { create drop getattr setattr relabelfrom relabelto };
+# In addition, trusted procedure is not allowed to install.
+allow sepgsql_unconfined_type sepgsql_proc_t:db_procedure *;
+allow sepgsql_unconfined_type sepgsql_trusted_proc_t:db_procedure ~{ install };
+allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure ~{ execute install };
 
+allow sepgsql_unconfined_type sepgsql_sequence_type:db_sequence *;
+
 allow sepgsql_unconfined_type sepgsql_blob_type:db_blob *;
 
 allow sepgsql_unconfined_type sepgsql_module_type:db_database install_module;
Index: config/appconfig-mls/db_contexts
===================================================================
--- config/appconfig-mls/db_contexts	(revision 0)
+++ config/appconfig-mls/db_contexts	(revision 0)
@@ -0,0 +1,16 @@
+#
+# Config file for SE-PostgreSQL extension
+#
+
+#
+# db_database object
+# ------------------
+database	*		system_u:object_r:sepgsql_db_t:s0
+
+#
+# db_schema object
+# ----------------
+schema		pg_temp_*	system_u:object_r:sepgsql_temp_schema_t:s0
+
+# NOTE: all the database objects stored in pg_temp_* namespace is
+#       released at end of the session.
Index: config/appconfig-standard/db_contexts
===================================================================
--- config/appconfig-standard/db_contexts	(revision 0)
+++ config/appconfig-standard/db_contexts	(revision 0)
@@ -0,0 +1,16 @@
+#
+# Config file for SE-PostgreSQL extension
+#
+
+#
+# db_database object
+# ------------------
+database	*		system_u:object_r:sepgsql_db_t
+
+#
+# db_schema object
+# ----------------
+schema		pg_temp_*	system_u:object_r:sepgsql_temp_schema_t
+
+# NOTE: all the database objects stored in pg_temp_* namespace is
+#       released at end of the session.
Index: config/appconfig-mcs/db_contexts
===================================================================
--- config/appconfig-mcs/db_contexts	(revision 0)
+++ config/appconfig-mcs/db_contexts	(revision 0)
@@ -0,0 +1,16 @@
+#
+# Config file for SE-PostgreSQL extension
+#
+
+#
+# db_database object
+# ------------------
+database	*		system_u:object_r:sepgsql_db_t:s0
+
+#
+# db_schema object
+# ----------------
+schema		pg_temp_*	system_u:object_r:sepgsql_temp_schema_t:s0
+
+# NOTE: all the database objects stored in pg_temp_* namespace is
+#       released at end of the session.

--------------020304030909080005080302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
