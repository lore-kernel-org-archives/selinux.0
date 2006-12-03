Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB3GAnEP019328
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 11:10:49 -0500
Received: from py-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB3G952d016524
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 16:09:05 GMT
Received: by py-out-1112.google.com with SMTP id a78so2341179pyh
        for <selinux@tycho.nsa.gov>; Sun, 03 Dec 2006 08:09:42 -0800 (PST)
Message-ID: <4572F6B7.5060107@kaigai.gr.jp>
Date: Mon, 04 Dec 2006 01:09:27 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: jbrindle@tresys.com, russell@coker.com.au
Subject: The prototype of SE-PostgreSQL
Content-Type: multipart/mixed;
 boundary="------------000905060304070201060206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000905060304070201060206
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

In recent days, I'm working for development of SE-PostgreSQL as we talked
about two month earlier.
It does NOT have enough functionality compared to its specifications yet,
but we can apply access controls on the simple SQL statements.

The prototype versions of SE-PostgreSQL is now available at:
  http://code.google.com/p/sepgsql/

The very quick documentation is here:
  http://www.kaigai.gr.jp/index.php?sepgsql
  It also describes the way to checkout and building the SE-PostgreSQL.

The attached files are the patch of security policy which includes
the definition of new object classes and access vectors, and the
example SQL to define some table and tuples.

I would like to merge the patch, or the part of the definition of
new object classes and access vectors at least.

And we can play it as fllows:
[kaigai@masu ~]$ id -Z
root:system_r:unconfined_t:s0-s0:c0.c1023  <- more than 's0:c0.c1' is necessary to set up
[kaigai@masu ~]$ psql -f mytest.sql postgres
[kaigai@masu ~]$ psql postgres
kaigai=# select * from drink;
 id |  name  | price | cost | alcohol
----+--------+-------+------+---------
  1 | coffee |   120 |   80 | f
  2 | tea    |   120 |   70 | f
  5 | water  |   110 |   40 | f
  6 | coke   |   110 |   50 | f
  3 | wine   |   360 |  260 | t
  4 | beer   |   240 |  180 | t
(6 rows)

kaigai=# select * from person;
 uid | uname  | passwd
-----+--------+--------
   1 | KaiGai | aaa
   2 | ymj    | bbb
   3 | tak    | xyz
(3 rows)

kaigai=# \q
[kaigai@masu ~]$ runcon -l s0 bash
[kaigai@masu ~]$ id -Z
root:system_r:unconfined_t:s0
[kaigai@masu ~]$ psql postgres
kaigai=# select * from drink;
NOTICE:  denied { select } scontext=root:system_r:unconfined_t:s0
	tcontext=user_u:object_r:sepgsql_table_t:s0:c0 tclass=tuple
NOTICE:  denied { select } scontext=root:system_r:unconfined_t:s0
	tcontext=user_u:object_r:sepgsql_table_t:s0:c0 tclass=tuple
 id |  name  | price | cost | alcohol
----+--------+-------+------+---------
  1 | coffee |   120 |   80 | f
  2 | tea    |   120 |   70 | f
  5 | water  |   110 |   40 | f
  6 | coke   |   110 |   50 | f
(4 rows)  <-- alcohols are filtered

kaigai=# select * from person;
ERROR:  SELinux: denied { select } scontext=root:system_r:unconfined_t:s0
	tcontext=user_u:object_r:sepgsql_table_t:s0:c1 tclass=column name=passwd
kaigai=# select uid, uname, check_person_passwd(uid, 'xyz') from person;
 uid | uname  | check_person_passwd
-----+--------+---------------------
   1 | KaiGai | f
   2 | ymj    | f
   3 | tak    | t
(3 rows)  <-- using the trusted procedure instead of reference to 'passwd' column.

kaigai=# \q

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------000905060304070201060206
Content-Type: text/x-patch;
 name="policy-sepgsql.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-sepgsql.patch"

diff -rNU3 serefpolicy-2.4.5.orig/policy/flask/access_vectors serefpolicy-2.4.5.sepgsql/policy/flask/access_vectors
--- serefpolicy-2.4.5.orig/policy/flask/access_vectors	2006-11-27 12:00:21.000000000 +0900
+++ serefpolicy-2.4.5.sepgsql/policy/flask/access_vectors	2006-11-27 12:17:56.000000000 +0900
@@ -80,6 +80,20 @@
 }
 
 #
+#  Define a common prefix for userspace database object access vectors.
+#
+
+common database
+{
+	create
+	drop
+	getattr
+	setattr
+	relabelfrom
+	relabelto
+}
+
+#
 # Define the access vectors.
 #
 # class class_name [ inherits common_name ] { permission_name ... }
@@ -639,3 +653,55 @@
 	translate
 	contains
 }
+
+# definition for SE-PostgreSQL
+class database
+inherits database
+{
+	access
+	create_obj
+	drop_obj
+}
+
+class table
+inherits database
+{
+	select
+	update
+	insert
+	delete
+}
+
+class procedure
+inherits database
+{
+	execute
+	entrypoint
+}
+
+class column
+inherits database
+{
+	select
+	update
+	insert
+#	delete	# arguable one
+}
+
+class tuple
+{
+	relabelfrom
+	relabelto
+	select
+	update
+	insert
+	delete
+}
+
+class blob
+inherits database
+{
+	read
+	write
+}
+
diff -rNU3 serefpolicy-2.4.5.orig/policy/flask/security_classes serefpolicy-2.4.5.sepgsql/policy/flask/security_classes
--- serefpolicy-2.4.5.orig/policy/flask/security_classes	2006-11-17 22:47:47.000000000 +0900
+++ serefpolicy-2.4.5.sepgsql/policy/flask/security_classes	2006-11-27 12:13:29.000000000 +0900
@@ -95,4 +95,12 @@
 
 class context			# userspace
 
+# SE-PostgreSQL relation
+class database			# userspace
+class table			# userspace
+class procedure			# userspace
+class column			# userspace
+class tuple			# userspace
+class blob			# userspace
+
 # FLASK
diff -rNU3 serefpolicy-2.4.5.orig/policy/mcs serefpolicy-2.4.5.sepgsql/policy/mcs
--- serefpolicy-2.4.5.orig/policy/mcs	2006-11-17 22:47:47.000000000 +0900
+++ serefpolicy-2.4.5.sepgsql/policy/mcs	2006-11-27 13:10:04.000000000 +0900
@@ -98,4 +98,28 @@
 mlsconstrain process { sigkill sigstop }
 	(( h1 dom h2 ) or ( t1 == mcskillall ));
 
+# MCS policy for SE-PostgreSQL
+#-------------------------------
+
+# Any database object must be dominated by the relabeling subject
+# clearance, also the objects are single-level.
+mlsconstrain { database table procedure column blob } { create relabelto }
+	((h1 dom h2) and ( l1 domby h2 ) and ( l2 eq h2 ));
+mlsconstrain tuple { insert relabelto }
+	(( h1 dom h2 ) and ( l1 domby h2 ) and ( l2 eq h2 ));
+
+# Access control for any database objects based on MCS rules.
+mlsconstrain database { drop setattr relabelfrom access create_obj drop_obj }
+	( h1 dom h2 );
+mlsconstrain table { drop setattr relabelfrom select update insert delete }
+	( h1 dom h2 );
+mlsconstrain column { drop setattr relabelfrom select update insert }
+	( h1 dom h2 );
+mlsconstrain tuple { relabelfrom select update delete }
+	( h1 dom h2 );
+mlsconstrain procedure { execute }
+	( h1 dom h2 );
+mlsconstrain blob { drop setattr relabelfrom read write }
+	( h1 dom h2 );
+
 ') dnl end enable_mcs
diff -rNU3 serefpolicy-2.4.5.orig/policy/modules/services/postgresql.if serefpolicy-2.4.5.sepgsql/policy/modules/services/postgresql.if
--- serefpolicy-2.4.5.orig/policy/modules/services/postgresql.if	2006-11-17 22:47:48.000000000 +0900
+++ serefpolicy-2.4.5.sepgsql/policy/modules/services/postgresql.if	2006-11-27 13:40:33.000000000 +0900
@@ -118,3 +118,79 @@
         # Some versions of postgresql put the sock file in /tmp
 	allow $1 postgresql_tmp_t:sock_file write;
 ')
+
+########################################
+## <summary>
+##     Marks the specified type as a database object type.
+## </summary>
+## <param name="type">
+##     <summary>
+##     Type marked as a database object type.
+##     </summary>
+## </param>
+#
+interface(`sepgsql_database_object',`
+	gen_require(`
+		attribute sepgsql_database_object;
+	')
+	typeattribute $1 sepgsql_database_object;
+')
+
+########################################
+## <summary>
+##     Allows the specified domain unconfined access.
+## </summary>
+## <param name="domain">
+##     <summary>
+##     Domain allowed to access.
+##     </summary>
+## </param>
+#
+interface(`sepgsql_full_access',`
+	gen_require(`
+		class database  database_full_perms;
+		class table     table_full_perms;
+		class procedure proc_full_perms;
+		class column    column_full_perms;
+		class tuple     tuple_full_perms;
+		class blob      blob_full_perms;
+
+		bool sepgsql_enable_auditallow;
+
+		type postgresql_t;
+		type sepgsql_db_t;
+		type sepgsql_table_t;
+		type sepgsql_proc_t;
+		type sepgsql_trusted_proc_t;
+		type sepgsql_blob_t;
+	')
+	allow $1 sepgsql_db_t : database database_full_perms;
+	allow $1 sepgsql_table_t : table table_full_perms;
+	allow $1 sepgsql_table_t : column column_full_perms;
+	allow $1 sepgsql_table_t : tuple tuple_full_perms;
+	allow $1 sepgsql_proc_t : procedure proc_full_perms;
+	allow $1 sepgsql_trusted_proc_t : procedure proc_full_perms;
+	allow $1 sepgsql_blob_t : blob blob_full_perms;
+
+	if (sepgsql_enable_auditallow) {
+		auditallow $1 sepgsql_db_t : database database_full_perms;
+		auditallow $1 sepgsql_table_t : table table_full_perms;
+		auditallow $1 sepgsql_table_t : column column_full_perms;
+		auditallow $1 sepgsql_table_t : tuple tuple_full_perms;
+		auditallow $1 sepgsql_proc_t : procedure proc_full_perms;
+		auditallow $1 sepgsql_trusted_proc_t : procedure proc_full_perms;
+		auditallow $1 sepgsql_blob_t : blob blob_full_perms;
+	}
+
+	type_transition $1 { $1 postgresql_t } : database sepgsql_db_t;
+	type_transition $1 sepgsql_db_t : table sepgsql_table_t;
+	type_transition $1 sepgsql_db_t : procedure sepgsql_proc_t;
+	type_transition $1 sepgsql_db_t : blob sepgsql_blob_t;
+        ifdef(`enable_mcs',`
+		range_transition $1 sepgsql_trusted_proc_t mcs_systemhigh;
+        ')
+	ifdef(`enable_mls',`
+		range_transition $1 sepgsql_trusted_proc_t mls_systemhigh;
+	')
+')
+
diff -rNU3 serefpolicy-2.4.5.orig/policy/modules/services/postgresql.te serefpolicy-2.4.5.sepgsql/policy/modules/services/postgresql.te
--- serefpolicy-2.4.5.orig/policy/modules/services/postgresql.te	2006-11-17 22:47:49.000000000 +0900
+++ serefpolicy-2.4.5.sepgsql/policy/modules/services/postgresql.te	2006-11-27 13:29:10.000000000 +0900
@@ -27,6 +27,14 @@
 type postgresql_var_run_t;
 files_pid_file(postgresql_var_run_t)
 
+# SE-PostgreSQL related
+bool sepgsql_enable_auditallow false;
+type sepgsql_db_t;
+type sepgsql_table_t;
+type sepgsql_proc_t;
+type sepgsql_trusted_proc_t;
+type sepgsql_blob_t;
+
 ########################################
 #
 # postgresql Local policy
@@ -142,6 +150,8 @@
 
 mta_getattr_spool(postgresql_t)
 
+sepgsql_full_access(postgresql_t)
+
 ifdef(`targeted_policy', `
 	files_dontaudit_read_root_files(postgresql_t)
 	term_dontaudit_use_generic_ptys(postgresql_t)
diff -rNU3 serefpolicy-2.4.5.orig/policy/modules/system/unconfined.te serefpolicy-2.4.5.sepgsql/policy/modules/system/unconfined.te
--- serefpolicy-2.4.5.orig/policy/modules/system/unconfined.te	2006-11-27 12:00:21.000000000 +0900
+++ serefpolicy-2.4.5.sepgsql/policy/modules/system/unconfined.te	2006-11-27 13:42:36.000000000 +0900
@@ -135,6 +135,10 @@
 	')
 
 	optional_policy(`
+		sepgsql_full_access(unconfined_t)
+	')
+
+	optional_policy(`
 		# cjp: this should probably be removed:
 		rpc_domtrans_nfsd(unconfined_t)
 	')
diff -rNU3 serefpolicy-2.4.5.orig/policy/support/obj_perm_sets.spt serefpolicy-2.4.5.sepgsql/policy/support/obj_perm_sets.spt
--- serefpolicy-2.4.5.orig/policy/support/obj_perm_sets.spt	2006-11-17 22:47:50.000000000 +0900
+++ serefpolicy-2.4.5.sepgsql/policy/support/obj_perm_sets.spt	2006-11-27 13:43:14.000000000 +0900
@@ -224,3 +224,25 @@
 #
 define(`client_stream_socket_perms', `{ create ioctl read getattr write setattr append bind getopt setopt shutdown }')
 define(`server_stream_socket_perms', `{ client_stream_socket_perms listen accept }')
+
+#
+# Database objects (used in Security Enhanced PostgreSQL)
+#
+define(`database_full_perms', `{ create drop getattr setattr relabelfrom relabelto access create_obj drop_obj }')
+define(`database_user_perms', `{ getattr access create_obj drop_obj }')
+
+define(`table_full_perms', `{ create drop getattr setattr relabelfrom relabelto select update insert delete }')
+define(`table_user_perms', `{ create drop getattr setattr select update insert delete }')
+
+define(`proc_full_perms', `{ create drop getattr setattr relabelfrom relabelto execute entrypoint }')
+define(`proc_user_perms', `{ getattr execute entrypoint }')
+
+define(`column_full_perms', `{ create drop getattr setattr relabelfrom relabelto select update insert }')
+define(`column_user_perms', `{ create drop getattr setattr select update insert }')
+
+define(`tuple_full_perms', `{ relabelfrom relabelto select update insert delete }')
+define(`tuple_user_perms', `{ select update insert delete }')
+
+define(`blob_full_perms', `{ create drop getattr setattr relabelfrom relabelto read write }')
+define(`blob_user_perms', `{ create drop getattr setattr read write }')
+

--------------000905060304070201060206
Content-Type: text/plain;
 name="mytest.sql"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mytest.sql"

Y3JlYXRlIHRhYmxlIGRyaW5rICgKCWlkIHNlcmlhbCBwcmltYXJ5IGtleSwKCW5hbWUgdGV4
dCwKCXByaWNlIGludGVnZXIsCgljb3N0IGludGVnZXIsCglhbGNvaG9sIGJvb2wKKTsKaW5z
ZXJ0IGludG8gZHJpbmsobmFtZSwgcHJpY2UsIGNvc3QsIGFsY29ob2wpIHZhbHVlcygnY29m
ZmVlJywgMTIwLCA4MCwgZmFsc2UpOwppbnNlcnQgaW50byBkcmluayhuYW1lLCBwcmljZSwg
Y29zdCwgYWxjb2hvbCkgdmFsdWVzKCd0ZWEnLCAxMjAsIDcwLCBmYWxzZSk7Cmluc2VydCBp
bnRvIGRyaW5rKG5hbWUsIHByaWNlLCBjb3N0LCBhbGNvaG9sKSB2YWx1ZXMoJ3dpbmUnLCAz
NjAsIDI2MCwgdHJ1ZSk7Cmluc2VydCBpbnRvIGRyaW5rKG5hbWUsIHByaWNlLCBjb3N0LCBh
bGNvaG9sKSB2YWx1ZXMoJ2JlZXInLCAyNDAsIDE4MCwgdHJ1ZSk7Cmluc2VydCBpbnRvIGRy
aW5rKG5hbWUsIHByaWNlLCBjb3N0LCBhbGNvaG9sKSB2YWx1ZXMoJ3dhdGVyJywgMTEwLCA0
MCwgZmFsc2UpOwppbnNlcnQgaW50byBkcmluayhuYW1lLCBwcmljZSwgY29zdCwgYWxjb2hv
bCkgdmFsdWVzKCdjb2tlJywgMTEwLCA1MCwgZmFsc2UpOwoKdXBkYXRlIGRyaW5rIHNldCBz
ZWN1cml0eV9jb250ZXh0ID0gJ3VzZXJfdTpvYmplY3RfcjpzZXBnc3FsX3RhYmxlX3Q6czA6
YzAnCgl3aGVyZSBhbGNvaG9sID0gdHJ1ZTsgCgpjcmVhdGUgdGFibGUgcGVyc29uICgKCXVp
ZCBzZXJpYWwgcHJpbWFyeSBrZXksCgl1bmFtZSB0ZXh0LAoJcGFzc3dkIHZhcmNoYXIoMjQp
Cik7CgppbnNlcnQgaW50byBwZXJzb24gKHVuYW1lLCBwYXNzd2QpIHZhbHVlcygnS2FpR2Fp
JywgJ2FhYScpOwppbnNlcnQgaW50byBwZXJzb24gKHVuYW1lLCBwYXNzd2QpIHZhbHVlcygn
eW1qJywgJ2JiYicpOwppbnNlcnQgaW50byBwZXJzb24gKHVuYW1lLCBwYXNzd2QpIHZhbHVl
cygndGFrJywgJ3h5eicpOwoKY3JlYXRlIG9yIHJlcGxhY2UgZnVuY3Rpb24gY2hlY2tfcGVy
c29uX3Bhc3N3ZCAoaW50ZWdlciwgdGV4dCkKCXJldHVybnMgYm9vbCBsYW5ndWFnZSAnc3Fs
JwoJYXMgJ3NlbGVjdCBwYXNzd2QgPSAkMiBmcm9tIHBlcnNvbiB3aGVyZSB1aWQ9JDEnOwoK
dXBkYXRlIHBnX2F0dHJpYnV0ZSBzZXQgYXR0c2VsY29uID0gJ3VzZXJfdTpvYmplY3Rfcjpz
ZXBnc3FsX3RhYmxlX3Q6czA6YzEnCgl3aGVyZSBhdHRyZWxpZCBpbiAoc2VsZWN0IHRhYmxl
b2lkIGZyb20gcGVyc29uKSBhbmQgYXR0bmFtZT0ncGFzc3dkJzsKdXBkYXRlIHBnX3Byb2Mg
c2V0IHByb3NlbGNvbiA9ICd1c2VyX3U6b2JqZWN0X3I6c2VwZ3NxbF90cnVzdGVkX3Byb2Nf
dDpzMCc7Cg==
--------------000905060304070201060206--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
