Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2NAc3RA029592
	for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2009 06:38:04 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2NAY7hh018171
	for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2009 10:34:09 GMT
Message-ID: <49C7667A.3020804@ak.jp.nec.com>
Date: Mon, 23 Mar 2009 19:37:46 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
CC: refpolicy@oss.tresys.com
Subject: The status of SE-PostgreSQL
Content-Type: multipart/mixed;
 boundary="------------010908020200040307050606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010908020200040307050606
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Here is a bad news.

I've had a discussion in pgsql-hackers list for a long time, but
we cannot get a conclusion that SE-PostgreSQL should be merged
in the PostgreSQL v8.4 which is the next major release, and it
was postponed to the v8.5 development cycle due to lack of time
for enough reviewing the feature.

If it can be released on schedule, the v8.4 is released on the
second quarter of 2009, and the v8.5 will be relased on a year
later (but it tend to delay a few months).
So, it is necessary to apply SE-PostgreSQL patches or install
it from RPM package distributed via Fedora project. :(

Under the discussion, I got a few suggestions in its security
design, and it seems to me fair enough. Some of them needs to
change definitions in the default policy.

See the following items,

* new permission: db_database:{superuser}

They required a new permission to control database superuser
privileges similar to "root" capability in operating system.
The concept of superuser is common for some of major DBMSs,
not only PostgreSQL. In addition, it seems to me well symmetric
with operating system.

The db_database:{superuser} controls whether the client can
perform as database superuser on the given database, or not.

* undesired permission: db_database:{set_param get_param}

They wondered the necessity of these checks, because SQL spec
does not require checks in set/get database parameters.
I didn't think it is necessary the security design of SELinux
should be symmetric with SQL, but I also thought these might
be unnecessary due to another reason.
In PostgreSQL, the scope of database parameters are session
local and initialized on the connection startup, so we cannot
use it as a pass to communicate between different two or more
domains.

* undesired permission: db_table/db_column/db_tuple:{use}

I originally proposed the {use} permission to set up write-only
tables, but it might be a misdesign.
(Sorry, a bit long description.)

At the initial design, SE-PostgreSQL applied {select} permission
for all the refered tables, columns and tuples. But, it also means
{select} permission is necessary for conditional DELETE or UPDATE
even if its content is not exposed to the client.
So, I proposed the privilege into two different permission: {select}
and {use}. The {select} allows the client to refer the object and
its content can be returned to him. The {use} also allows the client
to refer the object but its content has to be consumed internally.

  Example)
    SELECT a, b FROM t WHERE c = 5;
  In this case, we need {select} on column t.a and t.b, but {use}
  is required on column t.c because its content is consumed by
  SE-PostgreSQL itself and not returned to the client.

  Example)
    UPDATE t SET x = 20 WHERE y = 'aaa';
  In this case, we need {update} on column t.x, and {use} on t.y,
  but {select} is not necessary.

However, we can break it rapidly with a clever condition clause.
For example, we can get a result from the first trial:
  DELETE FROM account WHERE userid = 100 and creditno like '1%';

If this query removes a tuple, it means the first character of
credit card number is '1'. If not so, he can try it 9 times.
Then, he can get the information without {select} permission,
with enough small number of trials.

They concluded the "{use}" permission cannot work correctly, and
danger to expect it does not allow to leak contexnt to the outside.
I can agree this opinion.


The attached patch add/remove these permissions.
Any comments please.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------010908020200040307050606
Content-Type: text/x-patch;
 name="refpolicy-sepgsql-perms.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepgsql-perms.patch"

Index: policy/flask/access_vectors
===================================================================
--- policy/flask/access_vectors	(revision 2935)
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
Index: policy/modules/services/postgresql.if
===================================================================
--- policy/modules/services/postgresql.if	(revision 2935)
+++ policy/modules/services/postgresql.if	(working copy)
@@ -55,10 +55,10 @@
 		type_transition $2 sepgsql_sysobj_table_type:db_tuple user_sepgsql_sysobj_t;
 	')
 
-	allow $2 user_sepgsql_table_t:db_table  { getattr setattr use select update insert delete };
-	allow $2 user_sepgsql_table_t:db_column { getattr setattr use select update insert };
-	allow $2 user_sepgsql_table_t:db_tuple	{ use select update insert delete };
-	allow $2 user_sepgsql_sysobj_t:db_tuple	{ use select };
+	allow $2 user_sepgsql_table_t:db_table  { getattr setattr select update insert delete lock };
+	allow $2 user_sepgsql_table_t:db_column { getattr setattr select update insert };
+	allow $2 user_sepgsql_table_t:db_tuple	{ select update insert delete };
+	allow $2 user_sepgsql_sysobj_t:db_tuple	{ select };
 
 	allow $2 user_sepgsql_proc_exec_t:db_procedure { create drop getattr setattr execute };
 	type_transition $2 sepgsql_database_type:db_procedure user_sepgsql_proc_exec_t;
Index: policy/modules/services/postgresql.te
===================================================================
--- policy/modules/services/postgresql.te	(revision 2935)
+++ policy/modules/services/postgresql.te	(working copy)
@@ -281,27 +281,27 @@
 # Rules common to all clients
 #
 
-allow sepgsql_client_type sepgsql_db_t:db_database { getattr access get_param set_param };
+allow sepgsql_client_type sepgsql_db_t:db_database { getattr access };
 type_transition sepgsql_client_type sepgsql_client_type:db_database sepgsql_db_t;
 
-allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr use select insert };
-allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr use select insert };
-allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { use select insert };
+allow sepgsql_client_type sepgsql_fixed_table_t:db_table { getattr select insert lock };
+allow sepgsql_client_type sepgsql_fixed_table_t:db_column { getattr select insert };
+allow sepgsql_client_type sepgsql_fixed_table_t:db_tuple { select insert };
 
-allow sepgsql_client_type sepgsql_table_t:db_table { getattr use select update insert delete };
-allow sepgsql_client_type sepgsql_table_t:db_column { getattr use select update insert };
-allow sepgsql_client_type sepgsql_table_t:db_tuple { use select update insert delete };
+allow sepgsql_client_type sepgsql_table_t:db_table { getattr select update insert delete lock };
+allow sepgsql_client_type sepgsql_table_t:db_column { getattr select update insert };
+allow sepgsql_client_type sepgsql_table_t:db_tuple { select update insert delete };
 
-allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr use select };
-allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr use select };
-allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { use select };
+allow sepgsql_client_type sepgsql_ro_table_t:db_table { getattr select lock };
+allow sepgsql_client_type sepgsql_ro_table_t:db_column { getattr select };
+allow sepgsql_client_type sepgsql_ro_table_t:db_tuple { select };
 
 allow sepgsql_client_type sepgsql_secret_table_t:db_table getattr;
 allow sepgsql_client_type sepgsql_secret_table_t:db_column getattr;
 
-allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr use select };
-allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr use select };
-allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { use select };
+allow sepgsql_client_type sepgsql_sysobj_t:db_table { getattr select lock };
+allow sepgsql_client_type sepgsql_sysobj_t:db_column { getattr select };
+allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { select };
 
 allow sepgsql_client_type sepgsql_proc_t:db_procedure { getattr execute install };
 allow sepgsql_client_type sepgsql_trusted_proc_t:db_procedure { getattr execute entrypoint };
@@ -321,7 +321,7 @@
 # to access classified tuples and can make a audit record.
 #
 # Therefore, the following rule is applied for any domains which can connect SE-PostgreSQL.
-dontaudit { postgresql_t sepgsql_client_type sepgsql_unconfined_type } { sepgsql_table_type -sepgsql_sysobj_table_type }:db_tuple { use select update insert delete };
+dontaudit { postgresql_t sepgsql_client_type sepgsql_unconfined_type } { sepgsql_table_type -sepgsql_sysobj_table_type }:db_tuple { select update insert delete };
 
 tunable_policy(`sepgsql_enable_users_ddl',`
 	allow sepgsql_client_type sepgsql_table_t:db_table { create drop setattr };

--------------010908020200040307050606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
