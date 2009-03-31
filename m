Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2VA7hFI004997
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 06:07:43 -0400
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2VA7gP1005539
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 10:07:42 GMT
Message-ID: <49D1EAE7.8050100@rubix.com>
Date: Tue, 31 Mar 2009 12:05:27 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: cpebenito@tresys.com, method@manicmethod.com, selinux@tycho.nsa.gov,
        refpolicy@oss.tresys.com
Subject: Re: [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com>
In-Reply-To: <49D1DA85.1030902@ak.jp.nec.com>
Content-Type: multipart/alternative;
 boundary="------------060405020006070208000904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060405020006070208000904
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

looks good to me.

One minor comment. For the superuser permission, this may be common use
of DBMS's but I believe is not a standard SQL feature. RUBIX has no such
concept, so we would generally ignore that permission. Also, it is
unclear to me what abilities the superuser should have (in the general
sense, not necessarily within sepostgresql). Is this just a permission
to override SQL DAC, or does it also give administrative abilities like
setting audit configurations, or "all the above." I think you said
before that it would not allow MAC override, correct?

RUBIX currently has four privileged "roles":
Database Administrator: DAC override
Security Administrator: MAC override, to some degree. With SELinux much
of this can be done with discrete rules.
Audit Administrator: administer audit trail and criteria
Database Operator: do the normal day-today administrative DBMS tasks,
like backup.

I am curious, if the intended use of the db_database superuser
permission would be an encapsulation of our all of our roles, excluding
the Security Administrator.

As a side note, without knowing too much about the intent of the
superuser permission, I would think the categories of "roles" RUBIX uses
would be general enough for just about any database. Thus, providing
equivalent permissions might be useful (excluding the Security
Administrator, which I am guessing the community would say is not needed
because MAC override mechanisms exist within SELinux already) .

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

--------------060405020006070208000904
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-2022-JP"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">looks good to me. <br>
<br>
One minor comment. For the superuser permission, this may be common use
of DBMS's but I believe is not a standard SQL feature. RUBIX has no
such concept, so we would generally ignore that permission. Also, it is
unclear to me what abilities the superuser should have (in the general
sense, not necessarily within sepostgresql). Is this just a permission
to override SQL DAC, or does it also give administrative abilities like
setting audit configurations, or "all the above." I think you said
before that it would not allow MAC override, correct? <br>
<br>
RUBIX currently has four privileged "roles":<br>
Database Administrator: DAC override <br>
Security Administrator: MAC override, to some degree. With SELinux much
of this can be done with discrete rules.<br>
Audit Administrator: administer audit trail and criteria<br>
Database Operator: do the normal day-today administrative DBMS tasks,
like backup.<br>
<br>
I am curious, if the intended use of the db_database superuser
permission would be an encapsulation of our all of our roles, excluding
the Security Administrator. <br>
<br>
As a side note, without knowing too much about the intent of the
superuser permission, I would think the categories of "roles" RUBIX
uses would be general enough for just about any database. Thus,
providing equivalent permissions </font><font face="Arial">might be
useful </font><font face="Arial">(excluding the Security
Administrator, which I am guessing the community would say is not
needed because MAC override mechanisms exist within SELinux already) .<br>
</font><br>
KaiGai Kohei wrote:
<blockquote cite="mid:49D1DA85.1030902@ak.jp.nec.com" type="cite">
  <pre wrap="">As we have discussed for the recent week, I have a plan to rework
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
  </pre>
</blockquote>
</body>
</html>

--------------060405020006070208000904--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
