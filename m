Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBA9nq0M000407
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2010 04:49:52 -0500
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oBA9nniP018775
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2010 09:49:51 GMT
Message-ID: <4D01F7A4.90708@ak.jp.nec.com>
Date: Fri, 10 Dec 2010 18:49:24 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: refpolicy@oss1.tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] New database object classes
Content-Type: multipart/mixed;
 boundary="------------080301010304040206070306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080301010304040206070306
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch adds a few database object classes, as follows:

* db_schema
------------
A schema object performs as a namespace in database; similar to
directories in filesystem.
It seems some of (but not all) database objects are stored within
a certain schema logically. We can qualify these objects using
schema name. For example, a table: "my_tbl" within a schema: "my_scm"
is identified by "my_scm.my_tbl". This table is completely different
from "your_scm.my_tbl" that it a table within a schema: "your_scm".
Its characteristics is similar to a directory in filesystem, so
it has similar permissions.
The 'search' controls to resolve object name within a schema.
The 'add_name' and 'remove_name' controls to add/remove an object
to/from a schema.
See also,
  http://developer.postgresql.org/pgdocs/postgres/sql-createschema.html

In the past discussion, a rubix folks concerned about no object
class definition for schema and catalog which is an upper level
namespace. Since I'm not certain whether we have a disadvantage
when 'db_schema' class is applied on catalog class, I don't add
this definition yet.

Default security context of 'db_table' and 'db_procedure' classes
get being computed using type_transition with 'db_schema' class,
instead of 'db_database' class. It reflects logical hierarchy of
database object more correctly.


* db_view
----------
A view object performs as a virtual table. We can run SELECT
statement on views, although it has no physical entities.
The definition of views are expanded in run-time, so it allows
us to describe complex queries with keeping readability.
This object class uniquely provides 'expand' permission that
controls whether user can expand this view, or not.
The default security context shall be computed by type transition
rule with a schema object that owning the view.

See also,
  http://developer.postgresql.org/pgdocs/postgres/sql-createview.html


* db_sequence
--------------
A sequence object is a sequential number generator.
This object class uniquely provides 'get_value', 'next_value' and
'set_value' permissions. The 'get_value' controls to reference the
sequence object. The 'next_value' controls to fetch and increment
the value of sequence object. The 'set_value' controls to set
an arbitrary value.
The default security context shall be computed by type transition
rule with a schema object that owning the sequence.

See also,
  http://developer.postgresql.org/pgdocs/postgres/sql-createsequence.html


* db_language
--------------
A language object is an installed engine to execute procedures.
PostgreSQL supports to define SQL procedures using regular script
languages; such as Perl, Tcl, not only SQL or binary modules.
In addition, v9.0 or later supports DO statement. It allows us to
execute a script statement on server side without defining a SQL
procedure. It requires to control whether user can execute DO
statement on this language, or not.
This object class uniquely provides 'implement' and 'execute'
permissions. The 'implement' controls whether a procedure can
be implemented with this language, or not. So, it takes security
context of the procedure as subject. The 'execute' controls to
execute code block using DO statement.
The default security context shall be computed by type transition
rule with a database object, because it is not owned by a certain
schema.

In the default policy, we provide two types: 'sepgsql_lang_t' and
'sepgsql_safe_lang_t' that allows unpriv users to execute DO
statement. The default is 'sepgsql_leng_t'.
We assume newly installed language may be harm, so DBA has to relabel
it explicitly, if he want user defined procedures using the language.

See also,
  http://developer.postgresql.org/pgdocs/postgres/sql-createlanguage.html
  http://developer.postgresql.org/pgdocs/postgres/sql-do.html

P.S)
I found a bug in MCS. It didn't constraint 'relabelfrom' permission
of 'db_procedure' class. IIRC, I fixed it before, but it might be
only MLS side. Sorry.

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------080301010304040206070306
Content-Type: text/x-patch;
 name="refpolicy-sepgsql.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="refpolicy-sepgsql.1.patch"

 policy/flask/access_vectors           |   29 ++++++++
 policy/flask/security_classes         |    6 ++
 policy/mcs                            |   16 ++++-
 policy/mls                            |   58 ++++++++++++++-
 policy/modules/kernel/kernel.if       |    8 ++
 policy/modules/services/postgresql.if |  125 +++++++++++++++++++++++++++++++--
 policy/modules/services/postgresql.te |  116 +++++++++++++++++++++++++++++-
 7 files changed, 342 insertions(+), 16 deletions(-)

diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
index 6760c95..ae29de3 100644
--- a/policy/flask/access_vectors
+++ b/policy/flask/access_vectors
@@ -816,3 +816,32 @@ inherits x_device
 
 class x_keyboard
 inherits x_device
+
+class db_schema
+inherits database
+{
+	search
+	add_name
+	remove_name
+}
+
+class db_view
+inherits database
+{
+	expand
+}
+
+class db_sequence
+inherits database
+{
+	get_value
+	next_value
+	set_value
+}
+
+class db_language
+inherits database
+{
+	implement
+	execute
+}
diff --git a/policy/flask/security_classes b/policy/flask/security_classes
index fa65db2..14a4799 100644
--- a/policy/flask/security_classes
+++ b/policy/flask/security_classes
@@ -125,4 +125,10 @@ class tun_socket
 class x_pointer			# userspace
 class x_keyboard		# userspace
 
+# More Database stuff
+class db_schema			# userspace
+class db_view			# userspace
+class db_sequence		# userspace
+class db_language		# userspace
+
 # FLASK
diff --git a/policy/mcs b/policy/mcs
index af90ef2..358ce7c 100644
--- a/policy/mcs
+++ b/policy/mcs
@@ -107,7 +107,7 @@ mlsconstrain process { sigkill sigstop }
 
 # Any database object must be dominated by the relabeling subject
 # clearance, also the objects are single-level.
-mlsconstrain { db_database db_table db_procedure db_column db_blob } { create relabelto }
+mlsconstrain { db_database db_schema db_table db_sequence db_view db_procedure db_language db_column db_blob } { create relabelto }
 	(( h1 dom h2 ) and ( l2 eq h2 ));
 
 mlsconstrain { db_tuple } { insert relabelto }
@@ -117,6 +117,9 @@ mlsconstrain { db_tuple } { insert relabelto }
 mlsconstrain db_database { drop getattr setattr relabelfrom access install_module load_module get_param set_param }
 	( h1 dom h2 );
 
+mlsconstrain db_language { drop getattr setattr relabelfrom execute }
+	( h1 dom h2 );
+
 mlsconstrain db_table { drop getattr setattr relabelfrom select update insert delete use lock }
 	( h1 dom h2 );
 
@@ -126,7 +129,16 @@ mlsconstrain db_column { drop getattr setattr relabelfrom select update insert u
 mlsconstrain db_tuple { relabelfrom select update delete use }
 	( h1 dom h2 );
 
-mlsconstrain db_procedure { drop getattr setattr execute install }
+mlsconstrain db_sequence { drop getattr setattr relabelfrom get_value next_value set_value }
+	( h1 dom h2 );
+
+mlsconstrain db_view { drop getattr setattr relabelfrom expand }
+	( h1 dom h2 );
+
+mlsconstrain db_procedure { drop getattr setattr relabelfrom execute install }
+	( h1 dom h2 );
+
+mlsconstrain db_language { drop getattr setattr relabelfrom execute }
 	( h1 dom h2 );
 
 mlsconstrain db_blob { drop getattr setattr relabelfrom read write import export }
diff --git a/policy/mls b/policy/mls
index b9f0a3e..13151ad 100644
--- a/policy/mls
+++ b/policy/mls
@@ -727,13 +727,13 @@ mlsconstrain context contains
 #
 
 # make sure these database classes are "single level"
-mlsconstrain { db_database db_table db_procedure db_column db_blob } { create relabelto }
+mlsconstrain { db_database db_schema db_table db_sequence db_view db_procedure db_language db_column db_blob } { create relabelto }
 	( l2 eq h2 );
 mlsconstrain { db_tuple } { insert relabelto }
 	( l2 eq h2 );
 
 # new database labels must be dominated by the relabeling subjects clearance
-mlsconstrain { db_database db_table db_procedure db_column db_tuple db_blob } { relabelto }
+mlsconstrain { db_database db_schema db_table db_sequence db_view db_procedure db_language db_column db_tuple db_blob } { relabelto }
 	( h1 dom h2 );
 
 # the database "read" ops (note the check is dominance of the low level)
@@ -743,6 +743,12 @@ mlsconstrain { db_database } { getattr access get_param }
 	 ( t1 == mlsdbread ) or
 	 ( t2 == mlstrustedobject ));
 
+mlsconstrain { db_schema } { getattr search }
+	(( l1 dom l2 ) or
+	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsdbread ) or
+	 ( t2 == mlstrustedobject ));
+
 mlsconstrain { db_table } { getattr use select lock }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
@@ -755,12 +761,30 @@ mlsconstrain { db_column } { getattr use select }
 	 ( t1 == mlsdbread ) or
 	 ( t2 == mlstrustedobject ));
 
+mlsconstrain { db_sequence } { getattr get_value next_value }
+	(( l1 dom l2 ) or
+	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsdbread ) or
+	 ( t2 == mlstrustedobject ));
+
+mlsconstrain { db_view } { getattr expand }
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
 
+mlsconstrain { db_language } { getattr execute }
+	(( l1 dom l2 ) or
+	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsdbread ) or
+	 ( t2 == mlstrustedobject ));
+
 mlsconstrain { db_blob } { getattr read export }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
@@ -781,6 +805,13 @@ mlsconstrain { db_database } { create drop setattr relabelfrom install_module lo
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
+mlsconstrain { db_schema } { create drop setattr relabelfrom add_name remove_name }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t1 == mlsdbwrite ) or
+	 ( t2 == mlstrustedobject ));
+
 mlsconstrain { db_table } { create drop setattr relabelfrom update insert delete }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
@@ -795,6 +826,20 @@ mlsconstrain { db_column } { create drop setattr relabelfrom update insert }
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
+mlsconstrain { db_sequence } { create drop setattr relabelfrom set_value }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t1 == mlsdbwrite ) or
+	 ( t2 == mlstrustedobject ));
+
+mlsconstrain { db_view } { create drop setattr relabelfrom }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t1 == mlsdbwrite ) or
+	 ( t2 == mlstrustedobject ));
+
 mlsconstrain { db_procedure } { create drop setattr relabelfrom }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
@@ -802,6 +847,13 @@ mlsconstrain { db_procedure } { create drop setattr relabelfrom }
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
+mlsconstrain { db_language } { create drop setattr relabelfrom }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t1 == mlsdbwrite ) or
+	 ( t2 == mlstrustedobject ));
+
 mlsconstrain { db_blob } { create drop setattr relabelfrom write import }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
@@ -817,7 +869,7 @@ mlsconstrain { db_tuple } { relabelfrom update insert delete }
 	 ( t2 == mlstrustedobject ));
 
 # the database upgrade/downgrade rule
-mlsvalidatetrans { db_database db_table db_procedure db_column db_tuple db_blob }
+mlsvalidatetrans { db_database db_schema db_table db_sequence db_view db_procedure db_language db_column db_tuple db_blob }
 	((( l1 eq l2 ) or
 	  (( t3 == mlsdbupgrade ) and ( l1 domby l2 )) or
 	  (( t3 == mlsdbdowngrade ) and ( l1 dom l2 )) or
diff --git a/policy/modules/kernel/kernel.if b/policy/modules/kernel/kernel.if
index b4ad6d7..d7468b3 100644
--- a/policy/modules/kernel/kernel.if
+++ b/policy/modules/kernel/kernel.if
@@ -2865,16 +2865,24 @@ interface(`kernel_relabelfrom_unlabeled_database',`
 	gen_require(`
 		type unlabeled_t;
 		class db_database { setattr relabelfrom };
+		class db_schema { setattr relabelfrom };
 		class db_table { setattr relabelfrom };
+		class db_sequence { setattr relabelfrom };
+		class db_view { setattr relabelfrom };
 		class db_procedure { setattr relabelfrom };
+		class db_language { setattr relabelfrom };
 		class db_column { setattr relabelfrom };
 		class db_tuple { update relabelfrom };
 		class db_blob { setattr relabelfrom };
 	')
 
 	allow $1 unlabeled_t:db_database { setattr relabelfrom };
+	allow $1 unlabeled_t:db_schema { setattr relabelfrom };
 	allow $1 unlabeled_t:db_table { setattr relabelfrom };
+	allow $1 unlabeled_t:db_sequence { setattr relabelfrom };
+	allow $1 unlabeled_t:db_view { setattr relabelfrom };
 	allow $1 unlabeled_t:db_procedure { setattr relabelfrom };
+	allow $1 unlabeled_t:db_language { setattr relabelfrom };
 	allow $1 unlabeled_t:db_column { setattr relabelfrom };
 	allow $1 unlabeled_t:db_tuple { update relabelfrom };
 	allow $1 unlabeled_t:db_blob { setattr relabelfrom };
diff --git a/policy/modules/services/postgresql.if b/policy/modules/services/postgresql.if
index 539a7c9..09aeffa 100644
--- a/policy/modules/services/postgresql.if
+++ b/policy/modules/services/postgresql.if
@@ -18,18 +18,24 @@
 interface(`postgresql_role',`
 	gen_require(`
 		class db_database all_db_database_perms;
+		class db_schema all_db_schema_perms;
 		class db_table all_db_table_perms;
+		class db_sequence all_db_sequence_perms;
+		class db_view all_db_view_perms;
 		class db_procedure all_db_procedure_perms;
+		class db_language all_db_language_perms;
 		class db_column all_db_column_perms;
 		class db_tuple all_db_tuple_perms;
 		class db_blob all_db_blob_perms;
 
 		attribute sepgsql_client_type, sepgsql_database_type;
-		attribute sepgsql_sysobj_table_type;
+		attribute sepgsql_schema_type, sepgsql_sysobj_table_type;
 
 		type sepgsql_trusted_proc_exec_t, sepgsql_trusted_proc_t;
 		type user_sepgsql_blob_t, user_sepgsql_proc_exec_t;
+		type user_sepgsql_schema_t, user_sepgsql_seq_t;
 		type user_sepgsql_sysobj_t, user_sepgsql_table_t;
+		type user_sepgsql_view_t;
 	')
 
 	########################################
@@ -46,23 +52,36 @@ interface(`postgresql_role',`
 	#
 
 	tunable_policy(`sepgsql_enable_users_ddl',`
+		allow $2 user_sepgsql_schema_t:db_schema { create drop setattr };
 		allow $2 user_sepgsql_table_t:db_table { create drop setattr };
 		allow $2 user_sepgsql_table_t:db_column { create drop setattr };
-
 		allow $2 user_sepgsql_sysobj_t:db_tuple { update insert delete };
+		allow $2 user_sepgsql_seq_t:db_sequence { create drop setattr set_value };
+		allow $2 user_sepgsql_view_t:db_view { create drop setattr };
 		allow $2 user_sepgsql_proc_exec_t:db_procedure { create drop setattr };
 	')
 
+	allow $2 user_sepgsql_schema_t:db_schema { getattr search add_name remove_name };
+	type_transition $2 sepgsql_database_type:db_schema user_sepgsql_schema_t;
+
 	allow $2 user_sepgsql_table_t:db_table	{ getattr use select update insert delete lock };
 	allow $2 user_sepgsql_table_t:db_column { getattr use select update insert };
 	allow $2 user_sepgsql_table_t:db_tuple	{ use select update insert delete };
-	type_transition $2 sepgsql_database_type:db_table user_sepgsql_table_t;
+	type_transition $2 sepgsql_database_type:db_table user_sepgsql_table_t;		# deprecated
+	type_transition $2 sepgsql_schema_type:db_table user_sepgsql_table_t;
 
 	allow $2 user_sepgsql_sysobj_t:db_tuple	{ use select };
 	type_transition $2 sepgsql_sysobj_table_type:db_tuple user_sepgsql_sysobj_t;
 
+	allow $2 user_sepgsql_seq_t:db_sequence { getattr get_value next_value };
+	type_transition $2 sepgsql_schema_type:db_sequence user_sepgsql_seq_t;
+
+	allow $2 user_sepgsql_view_t:db_view { getattr expand };
+	type_transition $2 sepgsql_schema_type:db_view user_sepgsql_view_t;
+
 	allow $2 user_sepgsql_proc_exec_t:db_procedure { getattr execute };
-	type_transition $2 sepgsql_database_type:db_procedure user_sepgsql_proc_exec_t;
+	type_transition $2 sepgsql_database_type:db_procedure user_sepgsql_proc_exec_t;	# deprecated
+	type_transition $2 sepgsql_schema_type:db_procedure user_sepgsql_proc_exec_t;
 
 	allow $2 user_sepgsql_blob_t:db_blob { create drop getattr setattr read write import export };
 	type_transition $2 sepgsql_database_type:db_blob user_sepgsql_blob_t;
@@ -109,6 +128,24 @@ interface(`postgresql_database_object',`
 
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
@@ -146,6 +183,42 @@ interface(`postgresql_system_table_object',`
 
 ########################################
 ## <summary>
+##	Marks as a SE-PostgreSQL sequence type
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type marked as a sequence type.
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
+##	Marks as a SE-PostgreSQL view object type
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type marked as a view object type.
+##	</summary>
+## </param>
+#
+interface(`postgresql_view_object',`
+	gen_require(`
+		attribute sepgsql_view_type;
+	')
+
+	typeattribute $1 sepgsql_view_type;
+')
+
+########################################
+## <summary>
 ##	Marks as a SE-PostgreSQL procedure object type
 ## </summary>
 ## <param name="type">
@@ -164,6 +237,24 @@ interface(`postgresql_procedure_object',`
 
 ########################################
 ## <summary>
+##	Marks as a SE-PostgreSQL procedural language object type
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type marked as a procedural language object type.
+##	</summary>
+## </param>
+#
+interface(`postgresql_language_object',`
+	gen_require(`
+		attribute sepgsql_language_type;
+	')
+
+	typeattribute $1 sepgsql_language_type;
+')
+
+########################################
+## <summary>
 ##	Marks as a SE-PostgreSQL binary large object type
 ## </summary>
 ## <param name="type">
@@ -332,18 +423,25 @@ interface(`postgresql_stream_connect',`
 interface(`postgresql_unpriv_client',`
 	gen_require(`
 		class db_database all_db_database_perms;
+		class db_schema all_db_schema_perms;
 		class db_table all_db_table_perms;
+		class db_sequence all_db_sequence_perms;
+		class db_view all_db_view_perms;
 		class db_procedure all_db_procedure_perms;
+		class db_language all_db_language_perms;
 		class db_column all_db_column_perms;
 		class db_tuple all_db_tuple_perms;
 		class db_blob all_db_blob_perms;
 
 		attribute sepgsql_client_type;
-		attribute sepgsql_database_type, sepgsql_sysobj_table_type;
+		attribute sepgsql_database_type, sepgsql_schema_type;
+		attribute sepgsql_sysobj_table_type;
 
 		type sepgsql_trusted_proc_t, sepgsql_trusted_proc_exec_t;
 		type unpriv_sepgsql_blob_t, unpriv_sepgsql_proc_exec_t;
+		type unpriv_sepgsql_schema_t, unpriv_sepgsql_seq_t;
 		type unpriv_sepgsql_sysobj_t, unpriv_sepgsql_table_t;
+		type unpriv_sepgsql_view_t;
 	')
 
 	########################################
@@ -362,22 +460,35 @@ interface(`postgresql_unpriv_client',`
 	allow $1 sepgsql_trusted_proc_t:process transition;
 
 	tunable_policy(`sepgsql_enable_users_ddl',`
+		allow $1 unpriv_sepgsql_schema_t:db_schema { create drop setattr };
 		allow $1 unpriv_sepgsql_table_t:db_table { create drop setattr };
 		allow $1 unpriv_sepgsql_table_t:db_column { create drop setattr };
 		allow $1 unpriv_sepgsql_sysobj_t:db_tuple { update insert delete };
+		allow $1 unpriv_sepgsql_seq_t:db_sequence { create drop setattr };
+		allow $1 unpriv_sepgsql_view_t:db_view { create drop setattr };
 		allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { create drop setattr };
 	')
+	allow $1 unpriv_sepgsql_schema_t:db_schema { getattr add_name remove_name };
+	type_transition $1 sepgsql_database_type:db_schema unpriv_sepgsql_schema_t;
 
 	allow $1 unpriv_sepgsql_table_t:db_table { getattr use select update insert delete lock };
 	allow $1 unpriv_sepgsql_table_t:db_column { getattr use select update insert };
 	allow $1 unpriv_sepgsql_table_t:db_tuple { use select update insert delete };
-	type_transition $1 sepgsql_database_type:db_table unpriv_sepgsql_table_t;
+	type_transition $1 sepgsql_database_type:db_table unpriv_sepgsql_table_t;	# deprecated
+	type_transition $1 sepgsql_schema_type:db_table unpriv_sepgsql_table_t;
+
+	allow $1 unpriv_sepgsql_seq_t:db_sequence { getattr get_value next_value set_value };
+	type_transition $1 sepgsql_schema_type:db_sequence unpriv_sepgsql_seq_t;
+
+	allow $1 unpriv_sepgsql_view_t:db_view { getattr expand };
+	type_transition $1 sepgsql_schema_type:db_view unpriv_sepgsql_view_t;
 
 	allow $1 unpriv_sepgsql_sysobj_t:db_tuple { use select };
 	type_transition $1 sepgsql_sysobj_table_type:db_tuple unpriv_sepgsql_sysobj_t;
 
 	allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { getattr execute };
-	type_transition $1 sepgsql_database_type:db_procedure unpriv_sepgsql_proc_exec_t;
+	type_transition $1 sepgsql_database_type:db_procedure unpriv_sepgsql_proc_exec_t; # deprecated
+	type_transition $1 sepgsql_schema_type:db_procedure unpriv_sepgsql_proc_exec_t;
 
 	allow $1 unpriv_sepgsql_blob_t:db_blob { create drop getattr setattr read write import export };
 	type_transition $1 sepgsql_database_type:db_blob unpriv_sepgsql_blob_t;
diff --git a/policy/modules/services/postgresql.te b/policy/modules/services/postgresql.te
index 39abf57..2de95c5 100644
--- a/policy/modules/services/postgresql.te
+++ b/policy/modules/services/postgresql.te
@@ -60,9 +60,13 @@ attribute sepgsql_unconfined_type;
 
 # database objects attribute
 attribute sepgsql_database_type;
+attribute sepgsql_schema_type;
 attribute sepgsql_table_type;
 attribute sepgsql_sysobj_table_type;
+attribute sepgsql_sequence_type;
+attribute sepgsql_view_type;
 attribute sepgsql_procedure_type;
+attribute sepgsql_language_type;
 attribute sepgsql_blob_type;
 attribute sepgsql_module_type;
 
@@ -76,6 +80,12 @@ postgresql_database_object(sepgsql_db_t)
 type sepgsql_fixed_table_t;
 postgresql_table_object(sepgsql_fixed_table_t)
 
+type sepgsql_lang_t;
+postgresql_language_object(sepgsql_lang_t)
+
+type sepgsql_priv_lang_t;
+postgresql_language_object(sepgsql_priv_lang_t)
+
 type sepgsql_proc_exec_t;
 typealias sepgsql_proc_exec_t alias sepgsql_proc_t;
 postgresql_procedure_object(sepgsql_proc_exec_t)
@@ -86,12 +96,21 @@ postgresql_blob_object(sepgsql_ro_blob_t)
 type sepgsql_ro_table_t;
 postgresql_table_object(sepgsql_ro_table_t)
 
+type sepgsql_safe_lang_t;
+postgresql_language_object(sepgsql_safe_lang_t)
+
+type sepgsql_schema_t;
+postgresql_schema_object(sepgsql_schema_t)
+
 type sepgsql_secret_blob_t;
 postgresql_blob_object(sepgsql_secret_blob_t)
 
 type sepgsql_secret_table_t;
 postgresql_table_object(sepgsql_secret_table_t)
 
+type sepgsql_seq_t;
+postgresql_sequence_object(sepgsql_seq_t)
+
 type sepgsql_sysobj_t;
 postgresql_system_table_object(sepgsql_sysobj_t)
 
@@ -101,6 +120,9 @@ postgresql_table_object(sepgsql_table_t)
 type sepgsql_trusted_proc_exec_t;
 postgresql_procedure_object(sepgsql_trusted_proc_exec_t)
 
+type sepgsql_view_t;
+postgresql_view_object(sepgsql_view_t)
+
 # Trusted Procedure Domain
 type sepgsql_trusted_proc_t;
 domain_type(sepgsql_trusted_proc_t)
@@ -114,12 +136,21 @@ postgresql_blob_object(unpriv_sepgsql_blob_t)
 type unpriv_sepgsql_proc_exec_t;
 postgresql_procedure_object(unpriv_sepgsql_proc_exec_t)
 
+type unpriv_sepgsql_schema_t;
+postgresql_schema_object(unpriv_sepgsql_schema_t);
+
+type unpriv_sepgsql_seq_t;
+postgresql_sequence_object(unpriv_sepgsql_seq_t)
+
 type unpriv_sepgsql_sysobj_t;
 postgresql_system_table_object(unpriv_sepgsql_sysobj_t)
 
 type unpriv_sepgsql_table_t;
 postgresql_table_object(unpriv_sepgsql_table_t)
 
+type unpriv_sepgsql_view_t;
+postgresql_view_object(unpriv_sepgsql_view_t)
+
 # Types for UBAC
 type user_sepgsql_blob_t;
 typealias user_sepgsql_blob_t alias { staff_sepgsql_blob_t sysadm_sepgsql_blob_t };
@@ -131,6 +162,16 @@ typealias user_sepgsql_proc_exec_t alias { staff_sepgsql_proc_exec_t sysadm_sepg
 typealias user_sepgsql_proc_exec_t alias { auditadm_sepgsql_proc_exec_t secadm_sepgsql_proc_exec_t };
 postgresql_procedure_object(user_sepgsql_proc_exec_t)
 
+type user_sepgsql_schema_t;
+typealias user_sepgsql_schema_t alias { staff_sepgsql_schema_t sysadm_sepgsql_schema_t };
+typealias user_sepgsql_schema_t alias { auditadm_sepgsql_schema_t secadm_sepgsql_schema_t };
+postgresql_schema_object(user_sepgsql_schema_t)
+
+type user_sepgsql_seq_t;
+typealias user_sepgsql_seq_t alias { staff_sepgsql_seq_t sysadm_sepgsql_seq_t };
+typealias user_sepgsql_seq_t alias { auditadm_sepgsql_seq_t secadm_sepgsql_seq_t };
+postgresql_sequence_object(user_sepgsql_seq_t)
+
 type user_sepgsql_sysobj_t;
 typealias user_sepgsql_sysobj_t alias { staff_sepgsql_sysobj_t sysadm_sepgsql_sysobj_t };
 typealias user_sepgsql_sysobj_t alias { auditadm_sepgsql_sysobj_t secadm_sepgsql_sysobj_t };
@@ -141,6 +182,11 @@ typealias user_sepgsql_table_t alias { staff_sepgsql_table_t sysadm_sepgsql_tabl
 typealias user_sepgsql_table_t alias { auditadm_sepgsql_table_t secadm_sepgsql_table_t };
 postgresql_table_object(user_sepgsql_table_t)
 
+type user_sepgsql_view_t;
+typealias user_sepgsql_view_t alias { staff_sepgsql_view_t sysadm_sepgsql_view_t };
+typealias user_sepgsql_view_t alias { auditadm_sepgsql_view_t secadm_sepgsql_view_t };
+postgresql_view_object(user_sepgsql_view_t)
+
 ########################################
 #
 # postgresql Local policy
@@ -165,9 +211,15 @@ allow postgresql_t sepgsql_module_type:db_database install_module;
 # Database/Loadable module
 allow sepgsql_database_type sepgsql_module_type:db_database load_module;
 
+allow postgresql_t sepgsql_schema_type:db_schema *;
+
 allow postgresql_t sepgsql_table_type:{ db_table db_column db_tuple } *;
 type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
 
+allow postgresql_t sepgsql_sequence_type:db_sequence *;
+
+allow postgresql_t sepgsql_view_type:db_view *;
+
 allow postgresql_t sepgsql_procedure_type:db_procedure *;
 type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_exec_t;
 
@@ -314,6 +366,14 @@ optional_policy(`
 allow sepgsql_client_type sepgsql_db_t:db_database { getattr access get_param set_param };
 type_transition sepgsql_client_type sepgsql_client_type:db_database sepgsql_db_t;
 
+allow sepgsql_client_type sepgsql_schema_t:db_schema { getattr search };
+# Note that permission of creation/deletion are eventually controlled by
+# create or drop permission of individual objects within shared schemas.
+# So, it just allows to create/drop user specific types.
+tunable_policy(`sepgsql_enable_users_ddl',`
+	allow sepgsql_client_type sepgsql_schema_t:db_schema { add_name remove_name };
+')
+
 allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr use select insert lock };
 allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr use select insert };
 allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { use select insert };
@@ -333,9 +393,22 @@ allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr use select lock };
 allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr use select };
 allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { use select };
 
+allow sepgsql_client_type sepgsql_seq_t:db_sequence { getattr get_value next_value };
+
+allow sepgsql_client_type sepgsql_view_t:db_view { getattr expand };
+
 allow sepgsql_client_type sepgsql_proc_exec_t:db_procedure { getattr execute install };
 allow sepgsql_client_type sepgsql_trusted_proc_exec_t:db_procedure { getattr execute entrypoint };
 
+allow sepgsql_client_type sepgsql_lang_t:db_language { getattr };
+allow sepgsql_client_type sepgsql_safe_lang_t:db_language { getattr execute };
+
+# Only DBA can implement SQL procedures using `unsafe' procedural languages.
+# The `unsafe' one provides a capability to access internal data structure,
+# so we don't allow user-defined function being implemented using `unsafe' one.
+allow sepgsql_proc_exec_t sepgsql_lang_t:db_language { implement };
+allow sepgsql_procedure_type sepgsql_safe_lang_t:db_language { implement };
+
 allow sepgsql_client_type sepgsql_blob_t:db_blob { create drop getattr setattr read write };
 allow sepgsql_client_type sepgsql_ro_blob_t:db_blob { getattr read };
 allow sepgsql_client_type sepgsql_secret_blob_t:db_blob getattr;
@@ -361,16 +434,33 @@ dontaudit { postgresql_t sepgsql_admin_type sepgsql_client_type sepgsql_unconfin
 allow sepgsql_admin_type sepgsql_database_type:db_database { create drop getattr setattr relabelfrom relabelto access };
 type_transition sepgsql_admin_type sepgsql_admin_type:db_database sepgsql_db_t;
 
+allow sepgsql_admin_type sepgsql_schema_type:db_schema { create drop getattr setattr relabelfrom relabelto search add_name remove_name };
+type_transition sepgsql_admin_type sepgsql_database_type:db_schema sepgsql_schema_t;
+
 allow sepgsql_admin_type sepgsql_table_type:db_table { create drop getattr setattr relabelfrom relabelto lock };
 allow sepgsql_admin_type sepgsql_table_type:db_column { create drop getattr setattr relabelfrom relabelto };
 allow sepgsql_admin_type sepgsql_sysobj_table_type:db_tuple { relabelfrom relabelto select update insert delete };
 
-type_transition sepgsql_admin_type sepgsql_database_type:db_table sepgsql_table_t;
+type_transition sepgsql_admin_type sepgsql_database_type:db_table sepgsql_table_t;	# deprecated
+type_transition sepgsql_admin_type sepgsql_schema_type:db_table sepgsql_table_t;
+
+allow sepgsql_admin_type sepgsql_sequence_type:db_sequence { create drop getattr setattr relabelfrom relabelto get_value next_value set_value };
+
+type_transition sepgsql_admin_type sepgsql_schema_type:db_schema sepgsql_seq_t;
+
+allow sepgsql_admin_type sepgsql_view_type:db_view { create drop getattr setattr relabelfrom relabelto expand };
+
+type_transition sepgsql_admin_type sepgsql_view_type:db_view sepgsql_view_t;
 
 allow sepgsql_admin_type sepgsql_procedure_type:db_procedure { create drop getattr relabelfrom relabelto };
 allow sepgsql_admin_type sepgsql_proc_exec_t:db_procedure execute;
 
-type_transition sepgsql_admin_type sepgsql_database_type:db_procedure sepgsql_proc_exec_t;
+type_transition sepgsql_admin_type sepgsql_database_type:db_procedure sepgsql_proc_exec_t;	# deprecated
+type_transition sepgsql_admin_type sepgsql_schema_type:db_procedure sepgsql_proc_exec_t;
+
+allow sepgsql_admin_type sepgsql_language_type:db_language { create drop getattr setattr relabelfrom relabelto execute };
+
+type_transition sepgsql_admin_type sepgsql_database_type:db_language sepgsql_lang_t;
 
 allow sepgsql_admin_type sepgsql_blob_type:db_blob { create drop getattr setattr relabelfrom relabelto };
 
@@ -383,12 +473,18 @@ kernel_relabelfrom_unlabeled_database(sepgsql_admin_type)
 tunable_policy(`sepgsql_unconfined_dbadm',`
 	allow sepgsql_admin_type sepgsql_database_type:db_database *;
 
+	allow sepgsql_admin_type sepgsql_schema_type:db_schema *;
+
 	allow sepgsql_admin_type sepgsql_table_type:{ db_table db_column db_tuple } *;
+	allow sepgsql_admin_type sepgsql_sequence_type:db_sequence *;
+	allow sepgsql_admin_type sepgsql_view_type:db_view *;
 
 	allow sepgsql_admin_type sepgsql_proc_exec_t:db_procedure *;
 	allow sepgsql_admin_type sepgsql_trusted_proc_exec_t:db_procedure ~install;
 	allow sepgsql_admin_type sepgsql_procedure_type:db_procedure ~{ execute install };
 
+	allow sepgsql_admin_type sepgsql_language_type:db_language ~implement;
+
 	allow sepgsql_admin_type sepgsql_blob_type:db_blob *;
 ')
 
@@ -400,11 +496,21 @@ tunable_policy(`sepgsql_unconfined_dbadm',`
 allow sepgsql_unconfined_type sepgsql_database_type:db_database *;
 type_transition sepgsql_unconfined_type sepgsql_unconfined_type:db_database sepgsql_db_t;
 
-type_transition sepgsql_unconfined_type sepgsql_database_type:db_table sepgsql_table_t;
-type_transition sepgsql_unconfined_type sepgsql_database_type:db_procedure sepgsql_proc_exec_t;
+allow sepgsql_unconfined_type sepgsql_schema_type:db_schema *;
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_schema sepgsql_schema_t;
+
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_table sepgsql_table_t;		# deprecated
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_procedure sepgsql_proc_exec_t;	# deprecated
+type_transition sepgsql_unconfined_type sepgsql_schema_type:db_table sepgsql_table_t;
+type_transition sepgsql_unconfined_type sepgsql_schema_type:db_sequence sepgsql_seq_t;
+type_transition sepgsql_unconfined_type sepgsql_schema_type:db_view sepgsql_view_t;
+type_transition sepgsql_unconfined_type sepgsql_schema_type:db_procedure sepgsql_proc_exec_t;
+type_transition sepgsql_unconfined_type sepgsql_database_type:db_language sepgsql_lang_t;
 type_transition sepgsql_unconfined_type sepgsql_database_type:db_blob sepgsql_blob_t;
 
 allow sepgsql_unconfined_type sepgsql_table_type:{ db_table db_column db_tuple } *;
+allow sepgsql_unconfined_type sepgsql_sequence_type:db_sequence *;
+allow sepgsql_unconfined_type sepgsql_view_type:db_view *;
 
 # unconfined domain is not allowed to invoke user defined procedure directly.
 # They have to confirm and relabel it at first.
@@ -412,6 +518,8 @@ allow sepgsql_unconfined_type sepgsql_proc_exec_t:db_procedure *;
 allow sepgsql_unconfined_type sepgsql_trusted_proc_exec_t:db_procedure ~install;
 allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure ~{ execute install };
 
+allow sepgsql_unconfined_type sepgsql_language_type:db_language ~implement;
+
 allow sepgsql_unconfined_type sepgsql_blob_type:db_blob *;
 
 allow sepgsql_unconfined_type sepgsql_module_type:db_database install_module;

--------------080301010304040206070306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
