Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n362G3YB010445
	for <selinux@tycho.nsa.gov>; Sun, 5 Apr 2009 22:16:03 -0400
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n362G1Dg015965
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 02:16:02 GMT
Message-ID: <49D965CA.4030908@ak.jp.nec.com>
Date: Mon, 06 Apr 2009 11:15:38 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com>	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>	<1238684951.32379.311.camel@gorn.columbia.tresys.com> <49D563A9.1000607@ak.jp.nec.com>
In-Reply-To: <49D563A9.1000607@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------010205040201020409070506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010205040201020409070506
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch provides some of reworks and bugfuxes
except for new object classes and permissions.

- rework: Add a comment of "not currently in use" for deprecated
  permissions, but its definitions are not removed.

- bugfix: MCS policy did not constrain the following permissions.
    db_database:{getattr}
    db_table:{getattr lock}
    db_column:{getattr}
    db_procedure:{drop getattr setattr}
    db_blob:{getattr import export}

- rework: All the newly created database objects by unprivileged
  clients are prefixed with "user_", and these are controled via
  sepgsql_enable_users_ddl.
  The current policy allows httpd_t to created a function labeled
  as sepgsql_proc_t which is also allowed to be installed as a
  system internal entity (db_procedure:{install}).
  It is a potentially risk for trojan horse.

- rework: postgresql_role() shares most part of postgresql_unpriv_client().

- bugfix: some of permissions in db_procedure class are allowed
  on sepgsql_trusted_proc_t, but it is a domain, not a procedure.
  It should allow them on sepgsql_trusted_proc_exec_t.
  I also aliased sepgsql_proc_t as sepgsql_proc_exec_t to avoid
  such kind of confusion, as Chris suggested before.

- rework: we should not allow db_procedure:{install} on the
  sepgsql_trusted_proc_exec_t, because of a risk to invoke trusted
  procedure implicitly.

- rework: db_table:{lock} is moved to reader side, because it makes
  impossible to refer read-only table with foreign-key constraint.
  (FK checks internally acquire explicit locks.)

- bugfix: MLS policy dealt db_blob:{export} as writer-side permission,
  but it is required whrn the largeobject is refered.

- bugfix: MLS policy didn't constrain the db_procedure class.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------010205040201020409070506
Content-Type: text/x-patch;
 name="refpolicy-sepgsql-rework.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepgsql-rework.3.patch"

Index: policy/flask/access_vectors
===================================================================
--- policy/flask/access_vectors	(revision 2942)
+++ policy/flask/access_vectors	(working copy)
@@ -723,14 +723,14 @@
 	access
 	install_module
 	load_module
-	get_param
-	set_param
+	get_param	# not currently in use
+	set_param	# not currently in use
 }
 
 class db_table
 inherits database
 {
-	use
+	use		# not currently in use
 	select
 	update
 	insert
@@ -749,7 +749,7 @@
 class db_column
 inherits database
 {
-	use
+	use		# not currently in use
 	select
 	update
 	insert
@@ -759,7 +759,7 @@
 {
 	relabelfrom
 	relabelto
-	use
+	use		# not currently in use
 	select
 	update
 	insert
Index: policy/mcs
===================================================================
--- policy/mcs	(revision 2942)
+++ policy/mcs	(working copy)
@@ -111,22 +111,22 @@
 	(( h1 dom h2 ) and ( l2 eq h2 ));
 
 # Access control for any database objects based on MCS rules.
-mlsconstrain db_database { drop setattr relabelfrom access install_module load_module get_param set_param }
+mlsconstrain db_database { drop getattr setattr relabelfrom access install_module load_module get_param set_param }
 	( h1 dom h2 );
 
-mlsconstrain db_table { drop setattr relabelfrom select update insert delete use }
+mlsconstrain db_table { drop getattr setattr relabelfrom select update insert delete use lock }
 	( h1 dom h2 );
 
-mlsconstrain db_column { drop setattr relabelfrom select update insert use }
+mlsconstrain db_column { drop getattr setattr relabelfrom select update insert use }
 	( h1 dom h2 );
 
 mlsconstrain db_tuple { relabelfrom select update delete use }
 	( h1 dom h2 );
 
-mlsconstrain db_procedure { execute install }
+mlsconstrain db_procedure { drop getattr setattr execute install }
 	( h1 dom h2 );
 
-mlsconstrain db_blob { drop setattr relabelfrom read write }
+mlsconstrain db_blob { drop getattr setattr relabelfrom read write import export }
 	( h1 dom h2 );
 
 ') dnl end enable_mcs
Index: policy/modules/services/postgresql.if
===================================================================
--- policy/modules/services/postgresql.if	(revision 2942)
+++ policy/modules/services/postgresql.if	(working copy)
@@ -17,57 +17,11 @@
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
+	postgresql_unpriv_client($2)
 	role $1 types sepgsql_trusted_proc_t;
-
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
 ')
 
 ########################################
@@ -313,22 +267,62 @@
 #
 interface(`postgresql_unpriv_client',`
 	gen_require(`
+		class db_database all_db_database_perms;
 		class db_table all_db_table_perms;
 		class db_procedure all_db_procedure_perms;
+		class db_column all_db_column_perms;
+		class db_tuple all_db_tuple_perms;
 		class db_blob all_db_blob_perms;
 
 		attribute sepgsql_client_type;
+		attribute sepgsql_database_type;
+		attribute sepgsql_sysobj_table_type;
 
-		type sepgsql_db_t, sepgsql_table_t, sepgsql_proc_t, sepgsql_blob_t;
-		type sepgsql_trusted_proc_t, sepgsql_trusted_proc_exec_t;
-	')
+		type user_sepgsql_table_t;
+		type user_sepgsql_sysobj_t;
+		type user_sepgsql_proc_exec_t;
+		type user_sepgsql_blob_t;
 
+		type sepgsql_trusted_proc_t;
+		type sepgsql_trusted_proc_exec_t;
+	')
+	########################################
+	#
+	# Declarations
+	#
 	typeattribute $1 sepgsql_client_type;
 
-	type_transition $1 sepgsql_db_t:db_table sepgsql_table_t;
-	type_transition $1 sepgsql_db_t:db_procedure sepgsql_proc_t;
-	type_transition $1 sepgsql_db_t:db_blob sepgsql_blob_t;
+	##############################
+	#
+	# Client local policy
+	#
+	type_transition $1 sepgsql_database_type:db_table user_sepgsql_table_t;
+	allow $1 user_sepgsql_table_t:db_table { getattr use select update insert delete lock };
+	allow $1 user_sepgsql_table_t:db_column { getattr use select update insert };
+	allow $1 user_sepgsql_table_t:db_tuple { use select update insert delete };
 
+	type_transition $1 sepgsql_sysobj_table_type:db_tuple user_sepgsql_sysobj_t;
+	allow $1 user_sepgsql_sysobj_t:db_tuple { use select };
+
+	type_transition $1 sepgsql_database_type:db_procedure user_sepgsql_proc_exec_t;
+	allow $1 user_sepgsql_proc_exec_t:db_procedure { getattr execute };
+
+	tunable_policy(`sepgsql_enable_users_ddl',`
+		allow $1 user_sepgsql_table_t:db_table { create drop setattr };
+		allow $1 user_sepgsql_table_t:db_column { create drop setattr };
+
+		allow $1 user_sepgsql_sysobj_t:db_tuple { insert update delete };
+
+		allow $1 user_sepgsql_proc_exec_t:db_procedure { create drop setattr };
+	')
+
+	type_transition $1 sepgsql_database_type:db_blob user_sepgsql_blob_t;
+	allow $1 user_sepgsql_blob_t:db_blob { create drop getattr setattr read write import export };
+
+	##############################
+	#
+	# Trusted procedure
+	#
 	type_transition $1 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
 	allow $1 sepgsql_trusted_proc_t:process transition;
 ')
Index: policy/modules/services/postgresql.te
===================================================================
--- policy/modules/services/postgresql.te	(revision 2942)
+++ policy/modules/services/postgresql.te	(working copy)
@@ -66,8 +66,9 @@
 type sepgsql_fixed_table_t;
 postgresql_table_object(sepgsql_fixed_table_t)
 
-type sepgsql_proc_t;
-postgresql_procedure_object(sepgsql_proc_t)
+type sepgsql_proc_exec_t;
+typealias sepgsql_proc_exec_t alias { sepgsql_proc_t };
+postgresql_procedure_object(sepgsql_proc_exec_t)
 
 type sepgsql_ro_blob_t;
 postgresql_blob_object(sepgsql_ro_blob_t)
@@ -143,7 +144,7 @@
 type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
 
 allow postgresql_t sepgsql_procedure_type:db_procedure *;
-type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
+type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_exec_t;
 
 allow postgresql_t sepgsql_blob_type:db_blob *;
 type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
@@ -284,27 +285,27 @@
 allow sepgsql_client_type sepgsql_db_t:db_database { getattr access get_param set_param };
 type_transition sepgsql_client_type sepgsql_client_type:db_database sepgsql_db_t;
 
-allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr use select insert };
+allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr use select insert lock };
 allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr use select insert };
 allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { use select insert };
 
-allow sepgsql_client_type sepgsql_table_t:db_table { getattr use select update insert delete };
+allow sepgsql_client_type sepgsql_table_t:db_table { getattr use select update insert delete lock };
 allow sepgsql_client_type sepgsql_table_t:db_column { getattr use select update insert };
 allow sepgsql_client_type sepgsql_table_t:db_tuple { use select update insert delete };
 
-allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr use select };
+allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr use select lock };
 allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr use select };
 allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { use select };
 
 allow sepgsql_client_type sepgsql_secret_table_t:db_table getattr;
 allow sepgsql_client_type sepgsql_secret_table_t:db_column getattr;
 
-allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr use select };
+allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr use select lock };
 allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr use select };
 allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { use select };
 
-allow sepgsql_client_type sepgsql_proc_t:db_procedure { getattr execute install };
-allow sepgsql_client_type sepgsql_trusted_proc_t:db_procedure { getattr execute entrypoint };
+allow sepgsql_client_type sepgsql_proc_exec_t:db_procedure { getattr execute install };
+allow sepgsql_client_type sepgsql_trusted_proc_exec_t:db_procedure { getattr execute entrypoint };
 
 allow sepgsql_client_type sepgsql_blob_t:db_blob { create drop getattr setattr read write };
 allow sepgsql_client_type sepgsql_ro_blob_t:db_blob { getattr read };
@@ -323,12 +324,6 @@
 # Therefore, the following rule is applied for any domains which can connect SE-PostgreSQL.
 dontaudit { postgresql_t sepgsql_client_type sepgsql_unconfined_type } { sepgsql_table_type -sepgsql_sysobj_table_type }:db_tuple { use select update insert delete };
 
-tunable_policy(`sepgsql_enable_users_ddl',`
-	allow sepgsql_client_type sepgsql_table_t:db_table { create drop setattr };
-	allow sepgsql_client_type sepgsql_table_t:db_column { create drop setattr };
-	allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { update insert delete };
-')
-
 ########################################
 #
 # Unconfined access to this module
@@ -338,15 +333,16 @@
 type_transition sepgsql_unconfined_type sepgsql_unconfined_type:db_database sepgsql_db_t;
 
 type_transition sepgsql_unconfined_type sepgsql_database_type:db_table sepgsql_table_t;
-type_transition sepgsql_unconfined_type sepgsql_database_type:db_procedure sepgsql_proc_t;
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_procedure sepgsql_proc_exec_t;
 type_transition sepgsql_unconfined_type sepgsql_database_type:db_blob sepgsql_blob_t;
 
 allow sepgsql_unconfined_type sepgsql_table_type:{ db_table db_column db_tuple } *;
 
 # unconfined domain is not allowed to invoke user defined procedure directly.
 # They have to confirm and relabel it at first.
-allow sepgsql_unconfined_type { sepgsql_proc_t sepgsql_trusted_proc_t }:db_procedure *;
-allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure { create drop getattr setattr relabelfrom relabelto };
+allow sepgsql_unconfined_type sepgsql_proc_exec_t:db_procedure *;
+allow sepgsql_unconfined_type sepgsql_trusted_proc_exec_t:db_procedure ~{ install };
+allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure ~{ execute install };
 
 allow sepgsql_unconfined_type sepgsql_blob_type:db_blob *;
 
Index: policy/mls
===================================================================
--- policy/mls	(revision 2942)
+++ policy/mls	(working copy)
@@ -709,19 +709,25 @@
 	 ( t1 == mlsdbread ) or
 	 ( t2 == mlstrustedobject ));
 
-mlsconstrain { db_table db_column } { getattr use select }
+mlsconstrain { db_table } { getattr use select lock }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsdbread ) or
 	 ( t2 == mlstrustedobject ));
 
+mlsconstrain { db_column } { getattr use select }
+	(( l1 dom l2 ) or
+	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsdbread ) or
+	 ( t2 == mlstrustedobject ));
+
 mlsconstrain { db_procedure } { getattr execute install }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsdbread ) or
 	 ( t2 == mlstrustedobject ));
 
-mlsconstrain { db_blob } { getattr read }
+mlsconstrain { db_blob } { getattr read export }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsdbread ) or
@@ -741,7 +747,7 @@
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
-mlsconstrain { db_table } { create drop setattr relabelfrom update insert delete lock }
+mlsconstrain { db_table } { create drop setattr relabelfrom update insert delete }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
@@ -755,13 +761,20 @@
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
-mlsconstrain { db_blob } { create drop setattr relabelfrom write import export }
+mlsconstrain { db_procedure } { create drop setattr relabelfrom }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
+mlsconstrain { db_blob } { create drop setattr relabelfrom write import }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t1 == mlsdbwrite ) or
+	 ( t2 == mlstrustedobject ));
+
 mlsconstrain { db_tuple } { relabelfrom update insert delete }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or

--------------010205040201020409070506--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
