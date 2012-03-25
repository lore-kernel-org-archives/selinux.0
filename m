Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2PLEquV020004
	for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2012 17:14:52 -0400
Received: by lbok6 with SMTP id k6so3971059lbo.12
        for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2012 14:14:50 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 25 Mar 2012 23:14:50 +0200
Message-ID: <CADyhKSUb0q06VGR5hEa5pKB-_n7Gn3OFzB_r5yASuVFGE4AJGQ@mail.gmail.com>
Subject: [1/4] sepgsql - add connection pooling server support
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: refpolicy@oss1.tresys.com, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch provides a new trusted procedure type that allows to
switch the security label of database client, with interaction of new
sepgsql_setcon() function being supported at upcoming v9.2 release.

The original idea was given by Joshua Brindle. The sepgsql_setcon()
provides an analogy of dynamic domain transition on operating system.
Although we don't give privileges to switch security label on confined
domains, but it allows to switch via trusted procedure.

The new sepgsql_ranged_proc_exec_t is an entrypoint of
sepgsql_ranged_proc_t that has mcssetcats and mlsprocsetsl.

We assume its typical usage is sepgsql_setcon() getting invoked
via trusted procedure that references secret credential tables at
beginning of the database session by connection pooling server.

Usage example)

(*) The credential table is labeled as "sepgsql_secret_table_t",
     that holds a pair of username, credential and security context.

postgres=# CREATE OR REPLACE FUNCTION client_switch(text)
    RETURNS bool LANGUAGE sql
    AS 'SELECT sepgsql_setcon(ucontext) FROM credential
              WHERE uname = current_user AND ucred = $1';
CREATE FUNCTION
postgres=# SECURITY LABEL ON FUNCTION client_switch(text) IS
'system_u:object_r:sepgsql_ranged_proc_exec_t:s0';
SECURITY LABEL
postgres=# CREATE OR REPLACE FUNCTION client_reset()
    RETURNS bool LANGUAGE sql AS 'SELECT sepgsql_setcon(NULL)';
CREATE FUNCTION
postgres=# SECURITY LABEL ON FUNCTION client_reset() IS
'system_u:object_r:sepgsql_ranged_proc_exec_t:s0';
SECURITY LABEL

Then, it shows a scenario to switch the client label via trusted procedure.

[alice@iwashi ~]$ psql postgres -q
postgres=# SELECT sepgsql_getcon();
       sepgsql_getcon
----------------------------
 staff_u:staff_r:staff_t:s0
(1 row)

postgres=# SELECT * FROM info_c0;
ERROR:  SELinux: security policy violation
postgres=# SELECT * FROM info_c1;
ERROR:  SELinux: security policy violation
-- client have no permission neither info_c0 nor info_c1

postgres=# SELECT client_switch('6384e2b2184bcbf58eccf10ca7a6563c');
 client_switch
---------------
 t
(1 row)

postgres=# SELECT sepgsql_getcon();
        sepgsql_getcon
-------------------------------
 staff_u:staff_r:staff_t:s0:c1
(1 row)

postgres=# SELECT * FROM info_c0;
ERROR:  SELinux: security policy violation
postgres=# SELECT * FROM info_c1;
 a |  b
---+-----
 3 | xxx
 4 | yyy
(2 rows)

-- needless to say, credential table is not visible
postgres=# SELECT * FROM credential ;
ERROR:  SELinux: security policy violation

Also see,
http://git.postgresql.org/gitweb/?p=postgresql.git;a=commit;h=523176cbf14a3414170a83dd43686c0eccdc61c6

 Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
--
 policy/modules/services/postgresql.if |   32 +++++++++++++++++++++++++++++++-
 policy/modules/services/postgresql.te |   32 ++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/policy/modules/services/postgresql.if
b/policy/modules/services/postgresql.if
index 09aeffa..24e9958 100644
--- a/policy/modules/services/postgresql.if
+++ b/policy/modules/services/postgresql.if
@@ -32,6 +32,7 @@ interface(`postgresql_role',`
 		attribute sepgsql_schema_type, sepgsql_sysobj_table_type;

 		type sepgsql_trusted_proc_exec_t, sepgsql_trusted_proc_t;
+		type sepgsql_ranged_proc_exec_t, sepgsql_ranged_proc_t;
 		type user_sepgsql_blob_t, user_sepgsql_proc_exec_t;
 		type user_sepgsql_schema_t, user_sepgsql_seq_t;
 		type user_sepgsql_sysobj_t, user_sepgsql_table_t;
@@ -45,6 +46,7 @@ interface(`postgresql_role',`

 	typeattribute $2 sepgsql_client_type;
 	role $1 types sepgsql_trusted_proc_t;
+	role $1 types sepgsql_ranged_proc_t;

 	##############################
 	#
@@ -88,6 +90,10 @@ interface(`postgresql_role',`

 	allow $2 sepgsql_trusted_proc_t:process transition;
 	type_transition $2 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
+
+	allow $2 sepgsql_ranged_proc_t:process transition;
+	type_transition $2 sepgsql_ranged_proc_exec_t:process sepgsql_ranged_proc_t;
+	allow sepgsql_ranged_proc_t $2:process dyntransition;
 ')

 ########################################
@@ -223,7 +229,7 @@ interface(`postgresql_view_object',`
 ## </summary>
 ## <param name="type">
 ##	<summary>
-##	Type marked as a database object type.
+##	Type marked as a procedure object type.
 ##	</summary>
 ## </param>
 #
@@ -237,6 +243,26 @@ interface(`postgresql_procedure_object',`

 ########################################
 ## <summary>
+##	Marks as a SE-PostgreSQL trusted procedure object type
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type marked as a trusted procedure object type.
+##	</summary>
+## </param>
+#
+interface(`postgresql_trusted_procedure_object',`
+	gen_require(`
+		attribute sepgsql_procedure_type;
+		attribute sepgsql_trusted_procedure_type;
+	')
+
+	typeattribute $1 sepgsql_procedure_type;
+	typeattribute $1 sepgsql_trusted_procedure_type;
+')
+
+########################################
+## <summary>
 ##	Marks as a SE-PostgreSQL procedural language object type
 ## </summary>
 ## <param name="type">
@@ -459,6 +485,10 @@ interface(`postgresql_unpriv_client',`
 	type_transition $1 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
 	allow $1 sepgsql_trusted_proc_t:process transition;

+	type_transition $1 sepgsql_ranged_proc_exec_t:process sepgsql_ranged_proc_t;
+	allow $1 sepgsql_ranged_proc_t:process transition;
+	allow sepgsql_ranged_proc_t $1:process dyntransition;
+
 	tunable_policy(`sepgsql_enable_users_ddl',`
 		allow $1 unpriv_sepgsql_schema_t:db_schema { create drop setattr };
 		allow $1 unpriv_sepgsql_table_t:db_table { create drop setattr };
diff --git a/policy/modules/services/postgresql.te
b/policy/modules/services/postgresql.te
index 4d71f89..2457d10 100644
--- a/policy/modules/services/postgresql.te
+++ b/policy/modules/services/postgresql.te
@@ -70,6 +70,7 @@ attribute sepgsql_sysobj_table_type;
 attribute sepgsql_sequence_type;
 attribute sepgsql_view_type;
 attribute sepgsql_procedure_type;
+attribute sepgsql_trusted_procedure_type;
 attribute sepgsql_language_type;
 attribute sepgsql_blob_type;
 attribute sepgsql_module_type;
@@ -122,7 +123,10 @@ type sepgsql_table_t;
 postgresql_table_object(sepgsql_table_t)

 type sepgsql_trusted_proc_exec_t;
-postgresql_procedure_object(sepgsql_trusted_proc_exec_t)
+postgresql_trusted_procedure_object(sepgsql_trusted_proc_exec_t)
+
+type sepgsql_ranged_proc_exec_t;
+postgresql_trusted_procedure_object(sepgsql_ranged_proc_exec_t)

 type sepgsql_view_t;
 postgresql_view_object(sepgsql_view_t)
@@ -133,6 +137,26 @@ domain_type(sepgsql_trusted_proc_t)
 postgresql_unconfined(sepgsql_trusted_proc_t)
 role system_r types sepgsql_trusted_proc_t;

+# Ranged Trusted Procedure Domain
+#
+# XXX - the purpose of this domain is to switch security context of
+# the database client using dynamic domain transition; typically,
+# used for connection pooling software that shall assign a security
+# context at beginning of the user session based on the credentials
+# being invisible from unprivileged domains.
+#
+type sepgsql_ranged_proc_t;
+domain_type(sepgsql_ranged_proc_t)
+postgresql_unconfined(sepgsql_ranged_proc_t)
+allow sepgsql_ranged_proc_t self:process { setcurrent };
+role system_r types sepgsql_ranged_proc_t;
+optional_policy(`
+	mcs_process_set_categories(sepgsql_ranged_proc_t)
+')
+optional_policy(`
+	mls_process_set_level(sepgsql_ranged_proc_t)
+')
+
 # Types for unprivileged client
 type unpriv_sepgsql_blob_t;
 postgresql_blob_object(unpriv_sepgsql_blob_t)
@@ -404,7 +428,7 @@ allow sepgsql_client_type
sepgsql_seq_t:db_sequence { getattr get_value next_val
 allow sepgsql_client_type sepgsql_view_t:db_view { getattr expand };

 allow sepgsql_client_type sepgsql_proc_exec_t:db_procedure { getattr
execute install };
-allow sepgsql_client_type sepgsql_trusted_proc_exec_t:db_procedure {
getattr execute entrypoint };
+allow sepgsql_client_type sepgsql_trusted_procedure_type:db_procedure
{ getattr execute entrypoint };

 allow sepgsql_client_type sepgsql_lang_t:db_language { getattr };
 allow sepgsql_client_type sepgsql_safe_lang_t:db_language { getattr execute };
@@ -493,7 +517,7 @@ tunable_policy(`sepgsql_unconfined_dbadm',`
 	allow sepgsql_admin_type sepgsql_view_type:db_view *;

 	allow sepgsql_admin_type sepgsql_proc_exec_t:db_procedure *;
-	allow sepgsql_admin_type sepgsql_trusted_proc_exec_t:db_procedure ~install;
+	allow sepgsql_admin_type sepgsql_trusted_procedure_type:db_procedure ~install;
 	allow sepgsql_admin_type sepgsql_procedure_type:db_procedure ~{
execute install };

 	allow sepgsql_admin_type sepgsql_language_type:db_language ~implement;
@@ -528,7 +552,7 @@ allow sepgsql_unconfined_type sepgsql_view_type:db_view *;
 # unconfined domain is not allowed to invoke user defined procedure directly.
 # They have to confirm and relabel it at first.
 allow sepgsql_unconfined_type sepgsql_proc_exec_t:db_procedure *;
-allow sepgsql_unconfined_type
sepgsql_trusted_proc_exec_t:db_procedure ~install;
+allow sepgsql_unconfined_type
sepgsql_trusted_procedure_type:db_procedure ~install;
 allow sepgsql_unconfined_type sepgsql_procedure_type:db_procedure ~{
execute install };

 allow sepgsql_unconfined_type sepgsql_language_type:db_language ~implement;

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
