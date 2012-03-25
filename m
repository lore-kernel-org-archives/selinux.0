Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2PLFuqc020063
	for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2012 17:15:56 -0400
Received: by lahc1 with SMTP id c1so3921092lah.12
        for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2012 14:15:55 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 25 Mar 2012 23:15:55 +0200
Message-ID: <CADyhKSWqX5t1UK-zGFYLbqoCjP+9Bf9H3dOM8VHSNwsybg15AA@mail.gmail.com>
Subject: [3/4] sepgsql - Add temporary objects support
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: refpolicy@oss1.tresys.com, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a special case handling on creation of temporary
schema; "pg_temp". The temporary schema shall be labeled as
"sepgsql_temp_schema" in the default, then underlying objects
also labeled as temporary objects; that allows confined users
to create, drop and so on, even if sepgsql_enable_users_ddl is off.

In PostgreSQL, all the temporary objects are deployed on "pg_temp"
schema, then they shall be removed at the session end.
Thus, it has no possibility to leak any other entities via references to
the shared database objects, and no need to prevent creation or
deletion of temporary objects by confined domains.

Thanks,

 Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
--
 policy/modules/services/postgresql.if |   32 ++++++++++++++++++++++++--------
 policy/modules/services/postgresql.te |   26 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/policy/modules/services/postgresql.if
b/policy/modules/services/postgresql.if
index 24e9958..56fc5fa 100644
--- a/policy/modules/services/postgresql.if
+++ b/policy/modules/services/postgresql.if
@@ -37,6 +37,9 @@ interface(`postgresql_role',`
 		type user_sepgsql_schema_t, user_sepgsql_seq_t;
 		type user_sepgsql_sysobj_t, user_sepgsql_table_t;
 		type user_sepgsql_view_t;
+		type sepgsql_temp_schema_t, sepgsql_temp_table_t;
+		type sepgsql_temp_seq_t, sepgsql_temp_view_t;
+		type sepgsql_temp_proc_exec_t;
 	')

 	########################################
@@ -65,25 +68,30 @@ interface(`postgresql_role',`

 	allow $2 user_sepgsql_schema_t:db_schema { getattr search add_name
remove_name };
 	type_transition $2 sepgsql_database_type:db_schema user_sepgsql_schema_t;
+	type_transition $2 sepgsql_database_type:db_schema
sepgsql_temp_schema_t "pg_temp";

 	allow $2 user_sepgsql_table_t:db_table	{ getattr use select update
insert delete lock };
 	allow $2 user_sepgsql_table_t:db_column { getattr use select update insert };
 	allow $2 user_sepgsql_table_t:db_tuple	{ use select update insert delete };
 	type_transition $2 sepgsql_database_type:db_table
user_sepgsql_table_t;		# deprecated
-	type_transition $2 sepgsql_schema_type:db_table user_sepgsql_table_t;
+	type_transition $2 {sepgsql_schema_type -
sepgsql_temp_schema_t}:db_table user_sepgsql_table_t;
+	type_transition $2 sepgsql_temp_schema_t:db_table sepgsql_temp_table_t;

 	allow $2 user_sepgsql_sysobj_t:db_tuple	{ use select };
 	type_transition $2 sepgsql_sysobj_table_type:db_tuple user_sepgsql_sysobj_t;

 	allow $2 user_sepgsql_seq_t:db_sequence { getattr get_value next_value };
-	type_transition $2 sepgsql_schema_type:db_sequence user_sepgsql_seq_t;
+	type_transition $2 {sepgsql_schema_type -
sepgsql_temp_schema_t}:db_sequence user_sepgsql_seq_t;
+	type_transition $2 sepgsql_temp_schema_t:db_sequence sepgsql_temp_seq_t;

 	allow $2 user_sepgsql_view_t:db_view { getattr expand };
-	type_transition $2 sepgsql_schema_type:db_view user_sepgsql_view_t;
+	type_transition $2 {sepgsql_schema_type -
sepgsql_temp_schema_t}:db_view user_sepgsql_view_t;
+	type_transition $2 sepgsql_temp_schema_t:db_view sepgsql_temp_view_t;

 	allow $2 user_sepgsql_proc_exec_t:db_procedure { getattr execute };
 	type_transition $2 sepgsql_database_type:db_procedure
user_sepgsql_proc_exec_t;	# deprecated
-	type_transition $2 sepgsql_schema_type:db_procedure user_sepgsql_proc_exec_t;
+	type_transition $2 {sepgsql_schema_type -
sepgsql_temp_schema_t}:db_procedure user_sepgsql_proc_exec_t;
+	type_transition $2 sepgsql_temp_schema_t:db_procedure
sepgsql_temp_proc_exec_t;

 	allow $2 user_sepgsql_blob_t:db_blob { create drop getattr setattr
read write import export };
 	type_transition $2 sepgsql_database_type:db_blob user_sepgsql_blob_t;
@@ -468,6 +476,9 @@ interface(`postgresql_unpriv_client',`
 		type unpriv_sepgsql_schema_t, unpriv_sepgsql_seq_t;
 		type unpriv_sepgsql_sysobj_t, unpriv_sepgsql_table_t;
 		type unpriv_sepgsql_view_t;
+		type sepgsql_temp_schema_t, sepgsql_temp_table_t;
+		type sepgsql_temp_seq_t, sepgsql_temp_view_t;
+		type sepgsql_temp_proc_exec_t;
 	')

 	########################################
@@ -500,25 +511,30 @@ interface(`postgresql_unpriv_client',`
 	')
 	allow $1 unpriv_sepgsql_schema_t:db_schema { getattr add_name remove_name };
 	type_transition $1 sepgsql_database_type:db_schema unpriv_sepgsql_schema_t;
+	type_transition $1 sepgsql_database_type:db_schema
unpriv_sepgsql_schema_t "pg_temp";

 	allow $1 unpriv_sepgsql_table_t:db_table { getattr use select update
insert delete lock };
 	allow $1 unpriv_sepgsql_table_t:db_column { getattr use select
update insert };
 	allow $1 unpriv_sepgsql_table_t:db_tuple { use select update insert delete };
 	type_transition $1 sepgsql_database_type:db_table
unpriv_sepgsql_table_t;	# deprecated
-	type_transition $1 sepgsql_schema_type:db_table unpriv_sepgsql_table_t;
+	type_transition $1 {sepgsql_schema_type -
sepgsql_temp_schema_t}:db_table unpriv_sepgsql_table_t;
+	type_transition $1 sepgsql_temp_schema_t:db_table sepgsql_temp_table_t;

 	allow $1 unpriv_sepgsql_seq_t:db_sequence { getattr get_value
next_value set_value };
-	type_transition $1 sepgsql_schema_type:db_sequence unpriv_sepgsql_seq_t;
+	type_transition $1 {sepgsql_schema_type -
sepgsql_temp_schema_t}:db_sequence unpriv_sepgsql_seq_t;
+	type_transition $1 sepgsql_temp_schema_t:db_sequence sepgsql_temp_seq_t;

 	allow $1 unpriv_sepgsql_view_t:db_view { getattr expand };
-	type_transition $1 sepgsql_schema_type:db_view unpriv_sepgsql_view_t;
+	type_transition $1 {sepgsql_schema_type -
sepgsql_temp_schema_t}:db_view unpriv_sepgsql_view_t;
+	type_transition $1 sepgsql_temp_schema_t:db_view unpriv_sepgsql_view_t;

 	allow $1 unpriv_sepgsql_sysobj_t:db_tuple { use select };
 	type_transition $1 sepgsql_sysobj_table_type:db_tuple unpriv_sepgsql_sysobj_t;

 	allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { getattr execute };
 	type_transition $1 sepgsql_database_type:db_procedure
unpriv_sepgsql_proc_exec_t; # deprecated
-	type_transition $1 sepgsql_schema_type:db_procedure
unpriv_sepgsql_proc_exec_t;
+	type_transition $1 {sepgsql_schema_type -
sepgsql_temp_schema_t}:db_procedure unpriv_sepgsql_proc_exec_t;
+	type_transition $1 sepgsql_temp_schema_t:db_procedure
sepgsql_temp_proc_exec_t;

 	allow $1 unpriv_sepgsql_blob_t:db_blob { create drop getattr setattr
read write import export };
 	type_transition $1 sepgsql_database_type:db_blob unpriv_sepgsql_blob_t;
diff --git a/policy/modules/services/postgresql.te
b/policy/modules/services/postgresql.te
index add0cd6..8a3c2bd 100644
--- a/policy/modules/services/postgresql.te
+++ b/policy/modules/services/postgresql.te
@@ -164,6 +164,22 @@ optional_policy(`
 	mls_process_set_level(sepgsql_ranged_proc_t)
 ')

+# Types for temporary objects
+type sepgsql_temp_schema_t;
+postgresql_schema_object(sepgsql_temp_schema_t)
+
+type sepgsql_temp_table_t;
+postgresql_table_object(sepgsql_temp_table_t)
+
+type sepgsql_temp_seq_t;
+postgresql_table_object(sepgsql_temp_seq_t)
+
+type sepgsql_temp_view_t;
+postgresql_view_object(sepgsql_temp_view_t)
+
+type sepgsql_temp_proc_exec_t;
+postgresql_procedure_object(sepgsql_temp_proc_exec_t)
+
 # Types for unprivileged client
 type unpriv_sepgsql_blob_t;
 postgresql_blob_object(unpriv_sepgsql_blob_t)
@@ -251,6 +267,7 @@ allow sepgsql_database_type
sepgsql_module_type:db_database load_module;

 allow postgresql_t sepgsql_schema_type:db_schema *;
 type_transition postgresql_t sepgsql_database_type:db_schema sepgsql_schema_t;
+type_transition postgresql_t sepgsql_database_type:db_schema
sepgsql_temp_schema_t "pg_temp";

 allow postgresql_t sepgsql_table_type:{ db_table db_column db_tuple } *;
 type_transition postgresql_t sepgsql_database_type:db_table
sepgsql_sysobj_t;	# deprecated
@@ -433,11 +450,18 @@ allow sepgsql_client_type
sepgsql_sysobj_t:db_table { getattr use select lock };
 allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr use select };
 allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { use select };

+allow sepgsql_client_type sepgsql_temp_table_t:db_table ~{ relabelto
relabelfrom };
+allow sepgsql_client_type sepgsql_temp_table_t:db_column ~{ relabelto
relabelfrom };
+allow sepgsql_client_type sepgsql_temp_table_t:db_tuple ~{ relabelto
relabelfrom };
+
 allow sepgsql_client_type sepgsql_seq_t:db_sequence { getattr
get_value next_value };
+allow sepgsql_client_type sepgsql_temp_seq_t:db_sequence ~{ relabelto
relabelfrom };

 allow sepgsql_client_type sepgsql_view_t:db_view { getattr expand };
+allow sepgsql_client_type sepgsql_temp_view_t:db_view ~{ relabelto
relabelfrom };

 allow sepgsql_client_type sepgsql_proc_exec_t:db_procedure { getattr
execute install };
+allow sepgsql_client_type sepgsql_temp_proc_exec_t:db_procedure ~{
install entrypoint };
 allow sepgsql_client_type sepgsql_trusted_procedure_type:db_procedure
{ getattr execute entrypoint };

 allow sepgsql_client_type sepgsql_lang_t:db_language { getattr };
@@ -483,6 +507,7 @@ type_transition sepgsql_admin_type
sepgsql_admin_type:db_database sepgsql_db_t;

 allow sepgsql_admin_type sepgsql_schema_type:db_schema { create drop
getattr setattr relabelfrom relabelto search add_name remove_name };
 type_transition sepgsql_admin_type sepgsql_database_type:db_schema
sepgsql_schema_t;
+type_transition sepgsql_admin_type sepgsql_database_type:db_schema
sepgsql_temp_schema_t "pg_temp";

 allow sepgsql_admin_type sepgsql_table_type:db_table { create drop
getattr setattr relabelfrom relabelto lock };
 allow sepgsql_admin_type sepgsql_table_type:db_column { create drop
getattr setattr relabelfrom relabelto };
@@ -545,6 +570,7 @@ type_transition sepgsql_unconfined_type
sepgsql_unconfined_type:db_database sepg

 allow sepgsql_unconfined_type sepgsql_schema_type:db_schema *;
 type_transition sepgsql_unconfined_type
sepgsql_database_type:db_schema sepgsql_schema_t;
+type_transition sepgsql_unconfined_type
sepgsql_database_type:db_schema sepgsql_schema_t "pg_temp";

 type_transition sepgsql_unconfined_type
sepgsql_database_type:db_table sepgsql_table_t;		# deprecated
 type_transition sepgsql_unconfined_type
sepgsql_database_type:db_procedure sepgsql_proc_exec_t;	# deprecated

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
