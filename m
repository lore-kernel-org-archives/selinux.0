Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3L2pi2f023768
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 22:51:44 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3L2pggx010158
	for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2009 02:51:43 GMT
Message-ID: <49ED34B2.4010906@ak.jp.nec.com>
Date: Tue, 21 Apr 2009 11:51:30 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com>	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>	 <1238684951.32379.311.camel@gorn.columbia.tresys.com>	 <49D563A9.1000607@ak.jp.nec.com>  <49D965CA.4030908@ak.jp.nec.com> <1240258044.19211.767.camel@gorn.columbia.tresys.com>
In-Reply-To: <1240258044.19211.767.camel@gorn.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------090403070905060402060600"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090403070905060402060600
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Chris, the attached patch is the part you already OK'ed.

- rework: Add a comment of "deprecated" for deprecated permissions.
- bugfix: MCS policy did not constrain the following permissions.
    db_database:{getattr}
    db_table:{getattr lock}
    db_column:{getattr}
    db_procedure:{drop getattr setattr}
    db_blob:{getattr import export}
- rework: db_table:{lock} is moved to reader side, because it makes
  impossible to refer read-only table with foreign-key constraint.
  (FK checks internally acquire explicit locks.)
- bugfix: some of permissions in db_procedure class are allowed
  on sepgsql_trusted_proc_t, but it is a domain, not a procedure.
  It should allow them on sepgsql_trusted_proc_exec_t.
  I also aliased sepgsql_proc_t as sepgsql_proc_exec_t to avoid
  such kind of confusion, as Chris suggested before.
- rework: we should not allow db_procedure:{install} on the
  sepgsql_trusted_proc_exec_t, because of a risk to invoke trusted
  procedure implicitly.
- bugfix: MLS policy dealt db_blob:{export} as writer-side permission,
  but it is required whrn the largeobject is refered.
- bugfix: MLS policy didn't constrain the db_procedure class.

I'll send the rest of patches after we determine what prefix is preferable
for unprivileged domains.

Thanks,

Christopher J. PeBenito wrote:
> On Mon, 2009-04-06 at 11:15 +0900, KaiGai Kohei wrote:
>> The attached patch provides some of reworks and bugfuxes
>> except for new object classes and permissions.
>>
>> - rework: Add a comment of "not currently in use" for deprecated
>>   permissions, but its definitions are not removed.
> 
> "deprecated" should be sufficient.
> 
>> - bugfix: MCS policy did not constrain the following permissions.
>>     db_database:{getattr}
>>     db_table:{getattr lock}
>>     db_column:{getattr}
>>     db_procedure:{drop getattr setattr}
>>     db_blob:{getattr import export}
> 
> Looks ok to me.
> 
>> - rework: All the newly created database objects by unprivileged
>>   clients are prefixed with "user_", and these are controled via
>>   sepgsql_enable_users_ddl.
> 
> I don't think we should be mixing user content with other unpriv
> clients.
> 
>>   The current policy allows httpd_t to created a function labeled
>>   as sepgsql_proc_t which is also allowed to be installed as a
>>   system internal entity (db_procedure:{install}).
>>   It is a potentially risk for trojan horse.
>>
>> - rework: postgresql_role() shares most part of postgresql_unpriv_client().
> 
> See above comment.
> 
>> - bugfix: some of permissions in db_procedure class are allowed
>>   on sepgsql_trusted_proc_t, but it is a domain, not a procedure.
>>   It should allow them on sepgsql_trusted_proc_exec_t.
>>   I also aliased sepgsql_proc_t as sepgsql_proc_exec_t to avoid
>>   such kind of confusion, as Chris suggested before.
>>
>> - rework: we should not allow db_procedure:{install} on the
>>   sepgsql_trusted_proc_exec_t, because of a risk to invoke trusted
>>   procedure implicitly.
>>
>> - rework: db_table:{lock} is moved to reader side, because it makes
>>   impossible to refer read-only table with foreign-key constraint.
>>   (FK checks internally acquire explicit locks.)
>>
>> - bugfix: MLS policy dealt db_blob:{export} as writer-side permission,
>>   but it is required whrn the largeobject is refered.
>>
>> - bugfix: MLS policy didn't constrain the db_procedure class.
> 
> Seems ok.
> 
> It would be helpful to break up the patch into a set to make it easier
> to review in the future.
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------090403070905060402060600
Content-Type: text/x-patch;
 name="refpolicy-sepgsql-bugfixes.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepgsql-bugfixes.4.patch"

Index: policy/flask/access_vectors
===================================================================
--- policy/flask/access_vectors	(revision 2963)
+++ policy/flask/access_vectors	(working copy)
@@ -723,14 +723,14 @@
 	access
 	install_module
 	load_module
-	get_param
-	set_param
+	get_param	# deprecated
+	set_param	# deprecated
 }
 
 class db_table
 inherits database
 {
-	use
+	use		# deprecated
 	select
 	update
 	insert
@@ -749,7 +749,7 @@
 class db_column
 inherits database
 {
-	use
+	use		# deprecated
 	select
 	update
 	insert
@@ -759,7 +759,7 @@
 {
 	relabelfrom
 	relabelto
-	use
+	use		# deprecated
 	select
 	update
 	insert
Index: policy/mcs
===================================================================
--- policy/mcs	(revision 2963)
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
--- policy/modules/services/postgresql.if	(revision 2963)
+++ policy/modules/services/postgresql.if	(working copy)
@@ -55,7 +55,7 @@
 		type_transition $2 sepgsql_sysobj_table_type:db_tuple user_sepgsql_sysobj_t;
 	')
 
-	allow $2 user_sepgsql_table_t:db_table  { getattr setattr use select update insert delete };
+	allow $2 user_sepgsql_table_t:db_table  { getattr setattr use select update insert delete lock };
 	allow $2 user_sepgsql_table_t:db_column { getattr setattr use select update insert };
 	allow $2 user_sepgsql_table_t:db_tuple	{ use select update insert delete };
 	allow $2 user_sepgsql_sysobj_t:db_tuple	{ use select };
@@ -319,14 +319,14 @@
 
 		attribute sepgsql_client_type;
 
-		type sepgsql_db_t, sepgsql_table_t, sepgsql_proc_t, sepgsql_blob_t;
+		type sepgsql_db_t, sepgsql_table_t, sepgsql_proc_exec_t, sepgsql_blob_t;
 		type sepgsql_trusted_proc_t, sepgsql_trusted_proc_exec_t;
 	')
 
 	typeattribute $1 sepgsql_client_type;
 
 	type_transition $1 sepgsql_db_t:db_table sepgsql_table_t;
-	type_transition $1 sepgsql_db_t:db_procedure sepgsql_proc_t;
+	type_transition $1 sepgsql_db_t:db_procedure sepgsql_proc_exec_t;
 	type_transition $1 sepgsql_db_t:db_blob sepgsql_blob_t;
 
 	type_transition $1 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
Index: policy/modules/services/postgresql.te
===================================================================
--- policy/modules/services/postgresql.te	(revision 2963)
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
@@ -338,15 +339,16 @@
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
--- policy/mls	(revision 2963)
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

--------------090403070905060402060600--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
