Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n310V0IX014040
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 20:31:00 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n310Uw5H027430
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 00:30:59 GMT
Message-ID: <49D2B5A9.6070506@ak.jp.nec.com>
Date: Wed, 01 Apr 2009 09:30:33 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: cpebenito@tresys.com
CC: method@manicmethod.com, warner@rubix.com, selinux@tycho.nsa.gov,
        refpolicy@oss.tresys.com
Subject: Re: [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com>
In-Reply-To: <49D1DA85.1030902@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------010308040106010104030705"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010308040106010104030705
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Chris,

The attached patch also reworks and fixes a few bugs in MLS/MCS policy
for SE-PostgreSQL. Could you check it please?

List of updates:
 * db_catalog, db_schema, db_sequence classes are newly constrained.
 * Removed permissions (db_database:{get_param set_param} and
   db_xxx:{use}) have gone away.
 * bugfix: MCS didn't constrain db_xxx:{getattr} permission.
 * bugfix: MCS didn't constrain db_procedure:{ drop getattr
           setattr relabelfrom } permission.
 * bugfix: MLS didn't constrain writer permission in db_procedure class.

Thanks,

KaiGai Kohei wrote:
> As we have discussed for the recent week, I have a plan to rework
> some of security policy for SE-PostgreSQL.
> 
> The attached patch adds the significan changes, as follows.
> Could you give me any suggestion, approval or opposition?
> 
> New object classes and permissions
> ----------------------------------
>  * db_catalog class
>    It shows the top level namespace in the database, and has a capability
>    to store a set of schemas. Some of implementation does not support
>    catalogs. In this case, we simply ignore this class and any schemas
>    are placed under the db_database directly.
> 
>    It defines the following four permissions and inherited ones:
>      { search add_object remove_object associate }
> 
>    Client should have db_catalog:{search} on the catalog when he refers
>    any schemas under the catalog, and he should also have
>    db_catalog:{add_object} and db_catalog:{remove_object} on the catalog
>    when he tries to add or remove a shema within the catalog.
>    These permissions are an analogy of dir object class.
> 
>    The db_catalog:{associate}, which I've not introduced yet but noticed
>    its necessity, is also checked when we create or relabel a schema
>    within the catalog, and the schema should have db_catalog:{associate}
>    on the catalog. It is an analogy of filesystem:{associate}.
>    It prevents a schema is labeled unexpectedly.
> 
>  * db_schema class
>    It shows the second level namespace in the database, but it may be
>    the top level one in some of implementation (like PostgreSQL).
>    It has a capability to store a set of database objects (tables,
>    procedures and so on).
> 
>    It defines the following four permissions and inherited ones:
>      { search add_object remove_object associate }
>    Their meanings are similar to ones in db_catalog class except for
>    the schema to be replaced by database objects.
> 
>    Its security context can be computed with TYPE_TRANSITION between
>    the client as a subject and the database (or catalog, if availabel)
>    as a target.
> 
>  * db_sequence class
>    It shows the sequential number generator objects. We can also use
>    them as a communication channel between two domains, so it is
>    necessary to apply security policy.
> 
>    It inherits common database and defines the following two permissions:
>      { get_value set_value }
>    Client should have db_sequence:{get_value} when he fetch a value from
>    the sequence generator, and db_sequence:{set_value} when he set a
>    discretionary value. When he fetch a value from the sequence object,
>    it implicitly increments internal counter, but it is covered by the
>    get_value permission.
> 
>    Its security context can be computed with TYPE_TRANSITION between
>    the client as a subject and the schema as a target.
> 
> Change definition of object classes
> -----------------------------------
>  * db_database class
>    The db_database:{get_param set_param} is removed because these two
>    permissions are nonsense.
>    The db_database:{superuser} is newly added. It is checked when
>    client perform as database superuser. Stephen suggested it can
>    be separated to more finer grained privileges. It makes sense,
>    but this kind of separation which focuses on PostgreSQL makes
>    hard to port the concept for other database management systems.
> 
>  * db_table/db_column/db_tuple:{use} permission
>    The db_xxx:{use} permission is integrated into db_xxx:{select}
>    permission, because it can hide the risk to infer invisible
>    information easily with well considered WHERE clauses.
> 
> user_sepgsql_xxxx_t types
> -------------------------
>  * Currently, sepgsql_proc_t is assigned to the procedures created
>    by unprivileged and unprefixed clients, like httpd_t.
>    But I would like to handle it as a procedure created or relabeled
>    by database administrator.
>    Basically, we consider user defined procedures are untrusted, so
>    it should be checked before it becomes available for all the clients.
>    So, we don't allow to install them as system internal entities, and
>    don't allow unconfined domains to execute them directly.
> 
>    My preference is the user_sepgsql_xxxx_t is also assigned to
>    procedures created by unprivileged and unprfixed client.
> 
> A schema for temporary obejcts
> ------------------------------
>  * The sepgsql_schema_t is the default type for schema objects, and
>    rest of database objects within the schema is labeled with the chain
>    of TYPE_TRANSITION rules.
>    We have a characteristic scheme named as "pg_temp_*". Any database
>    objects within the schema are cleared after the session closed,
>    so its contents are always session local. We would like to assign
>    special types on the temporary schema and delivered database objects
>    withing the schema. In addition, users can create and use these
>    database objects independently from the sepgsql_enable_users_ddl.
> 
> Booelean behavior: sepgsql_enable_users_ddl
> -------------------------------------------
>  * Because the current design does not care about actions on schema
>    objects, we need to assign separated label (sepgsql_sysobj_t) on
>    system informations and apply checks as row-level controls.
>    But db_schema object class enables to control user's DDLs in
>    the schema level checks mainly, so now sepgsql_enable_user_ddl
>    focuses on db_schema class permissions and {create drop setattr}
>    for any other database objects.
>    The attached patch allows users to modify tuples with sepgsql_sysobj_t
>    but not allows columns/tables. It means user can define database
>    objects with proper way (like CREATE TABLE), but prevents to
>    manipulate system information by hand.
>    In addition, this boolean controls only user_sepgsql_xxxx_t.
>    The unprefixed types are always not allowed to modify its definition
>    by unprivileges users.
> 
> db_table:{lock} for reader actions
> ----------------------------------
>  * db_table:{lock} is also necessary for reader side actions due to the
>    implementation reason.
>    In PostgreSQL, FK constraints are implemented as trigger functions.
>    It is invoked for each INSERT/UPDATE/DELETE on constrainted tuples,
>    and run a secondary query to check whether the action satisfies
>    FK constraints or not.
>    This query is described as:
>      SELECT 1 FROM t WHERE k = "$1" FOR SHARE;
> 
>    The "FOR SHARE" clause means explicit table lock and requires
>    db_table:{lock} permission. If we don't allow unpriv clients to
>    lock read-only tables, it disables to set up FK constraint which
>    refers read-only tables.
> 
> Miscellaneous changes
> ---------------------
>  * The security context of a new database is decided via type_transition
>    on the server process's context. It enables to avoid conflicts when
>    we have multiple DBMSs in a system.
>  * It allows postgresql_t domain to write out messages to system audit.
>  * sepgsql_proc_t is aliased to sepgsql_proc_exec_t.
>  * db_procedure:{install} is revoked from sepgsql_trusted_proc_exec_t,
>    because we don't need to run trusted procedure implicitly.
>  * Most of postgresql_role() are shared with postgresql_unpriv_client(),
>    except for "role $1 types sepgsql_trusted_proc_t;"
>  * /etc/selinux/$POLICYTYPE/contexts/db_contexts for selabel_lookup(3)
> 
> Thanks,
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------010308040106010104030705
Content-Type: text/x-patch;
 name="refpolicy-sepgsql-mls-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepgsql-mls-fixes.patch"

Index: policy/mcs
===================================================================
--- policy/mcs	(revision 2937)
+++ policy/mcs	(working copy)
@@ -104,29 +104,38 @@
 
 # Any database object must be dominated by the relabeling subject
 # clearance, also the objects are single-level.
-mlsconstrain { db_database db_table db_procedure db_column db_blob } { create relabelto }
+mlsconstrain { db_database db_catalog db_schema db_table db_procedure db_column db_sequence db_blob } { create relabelto }
 	(( h1 dom h2 ) and ( l2 eq h2 ));
 
 mlsconstrain { db_tuple } { insert relabelto }
 	(( h1 dom h2 ) and ( l2 eq h2 ));
 
 # Access control for any database objects based on MCS rules.
-mlsconstrain db_database { drop setattr relabelfrom access install_module load_module get_param set_param }
+mlsconstrain db_database { drop getattr setattr relabelfrom access install_module load_module }
 	( h1 dom h2 );
 
-mlsconstrain db_table { drop setattr relabelfrom select update insert delete use }
+mlsconstrain db_catalog { drop getattr setattr relabelfrom search add_object remove_object }
 	( h1 dom h2 );
 
-mlsconstrain db_column { drop setattr relabelfrom select update insert use }
+mlsconstrain db_schema { drop getattr setattr relabelfrom search add_object remove_object }
 	( h1 dom h2 );
 
-mlsconstrain db_tuple { relabelfrom select update delete use }
+mlsconstrain db_table { drop getattr setattr relabelfrom select update insert delete }
 	( h1 dom h2 );
 
-mlsconstrain db_procedure { execute install }
+mlsconstrain db_column { drop getattr setattr relabelfrom select update insert }
 	( h1 dom h2 );
 
-mlsconstrain db_blob { drop setattr relabelfrom read write }
+mlsconstrain db_tuple { relabelfrom select update delete }
 	( h1 dom h2 );
 
+mlsconstrain db_procedure { drop getattr setattr relabelfrom execute install }
+	( h1 dom h2 );
+
+mlsconstrain db_sequence { drop getattr setattr relabelfrom get_value set_value }
+	( h1 dom h2 );
+
+mlsconstrain db_blob { drop getattr setattr relabelfrom read write }
+	( h1 dom h2 );
+
 ') dnl end enable_mcs
Index: policy/mls
===================================================================
--- policy/mls	(revision 2937)
+++ policy/mls	(working copy)
@@ -693,69 +693,87 @@
 #
 
 # make sure these database classes are "single level"
-mlsconstrain { db_database db_table db_procedure db_column db_blob } { create relabelto }
+mlsconstrain { db_database db_catalog db_schema db_table db_column db_procedure db_sequence db_blob } { create relabelto }
 	( l2 eq h2 );
 mlsconstrain { db_tuple } { insert relabelto }
 	( l2 eq h2 );
 
 # new database labels must be dominated by the relabeling subjects clearance
-mlsconstrain { db_database db_table db_procedure db_column db_tuple db_blob } { relabelto }
+mlsconstrain { db_database db_catalog db_schema db_table db_column db_tuple db_procedure db_sequence db_blob } { relabelto }
 	( h1 dom h2 );
 
 # the database "read" ops (note the check is dominance of the low level)
-mlsconstrain { db_database } { getattr access get_param }
+mlsconstrain { db_database } { getattr access }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsdbread ) or
 	 ( t2 == mlstrustedobject ));
 
-mlsconstrain { db_table db_column } { getattr use select }
+mlsconstrain { db_catalog db_schema } { getattr search }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsdbread ) or
 	 ( t2 == mlstrustedobject ));
 
+mlsconstrain { db_table } { getattr select lock }
+	(( l1 dom l2 ) or
+	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsdbread ) or
+	 ( t2 == mlstrustedobject ));
+
+mlsconstrain { db_column } { getattr select }
+	(( l1 dom l2 ) or
+	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsdbread ) or
+	 ( t2 == mlstrustedobject ));
+
+mlsconstrain { db_tuple } { select }
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
+mlsconstrain { db_sequence } { getattr get_value }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsdbread ) or
 	 ( t2 == mlstrustedobject ));
 
-mlsconstrain { db_tuple } { use select }
+mlsconstrain { db_blob } { getattr read }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsdbread ) or
 	 ( t2 == mlstrustedobject ));
 
 # the "single level" file "write" ops
-mlsconstrain { db_database } { create drop setattr relabelfrom install_module load_module set_param }
+mlsconstrain { db_database } { create drop setattr relabelfrom install_module load_module }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
-mlsconstrain { db_table } { create drop setattr relabelfrom update insert delete lock }
+mlsconstrain { db_catalog db_schema } { create drop setattr relabelfrom add_object remove_object }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
-mlsconstrain { db_column } { create drop setattr relabelfrom update insert }
+mlsconstrain { db_table } { create drop setattr relabelfrom update insert delete }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
-mlsconstrain { db_blob } { create drop setattr relabelfrom write import export }
+mlsconstrain { db_column } { create drop setattr relabelfrom update insert }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
@@ -769,8 +787,29 @@
 	 ( t1 == mlsdbwrite ) or
 	 ( t2 == mlstrustedobject ));
 
+mlsconstrain { db_procedure } { create drop setattr relabelfrom }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t1 == mlsdbwrite ) or
+	 ( t2 == mlstrustedobject ));
+
+mlsconstrain { db_sequence } { create drop setattr relabelfrom set_value }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t1 == mlsdbwrite ) or
+	 ( t2 == mlstrustedobject ));
+
+mlsconstrain { db_blob } { create drop setattr relabelfrom write import export }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t1 == mlsdbwrite ) or
+	 ( t2 == mlstrustedobject ));
+
 # the database upgrade/downgrade rule
-mlsvalidatetrans { db_database db_table db_procedure db_column db_tuple db_blob }
+mlsvalidatetrans { db_database db_catalog db_schema db_table db_column db_tuple db_procedure db_sequence db_blob }
 	((( l1 eq l2 ) or
 	  (( t3 == mlsdbupgrade ) and ( l1 domby l2 )) or
 	  (( t3 == mlsdbdowngrade ) and ( l1 dom l2 )) or

--------------010308040106010104030705--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
