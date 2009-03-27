Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RBKkl5028326
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 07:20:46 -0400
Received: from mail2.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RBGksa026903
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 11:16:47 GMT
Message-ID: <49CCB678.4090209@kaigai.gr.jp>
Date: Fri, 27 Mar 2009 20:20:24 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, cpebenito@tresys.com,
        selinux <selinux@tycho.nsa.gov>, refpolicy@oss.tresys.com
Subject: Re: [PATCH] Policy rework for SE-PostgreSQL (Re: Some ideas in SE-PostgreSQL
 enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CC8BEF.507@ak.jp.nec.com> <49CCA004.9040608@rubix.com>
In-Reply-To: <49CCA004.9040608@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andy Warner wrote:
> 
> KaiGai Kohei wrote:
>> The attached patch is the first one in the series of reworks for
>> the SE-PostgreSQL security policy.
>>
>> It updates the following items.
>>
>> * Changes in the definition of object classes
>>
>> This patch add new three object classes and modifies the definition
>> of a few object classes.
>>  - db_database:{get_param set_param} is removed due to nonsense.
>>  - db_database:{superuser} is added to restrict privileges of
>>    database superuser.
>>  - db_table/db_column/db_tuple:{use} is removed due to nonsense.
>>  - New object classes: db_catalog, db_schema and db_sequence are added.
>>
>>   
> In the RUBIX policy I used the db_table use permission (could be called
> open) to have a simple way to control access to the table as a whole,
> much like a file open permission. While not absolutely necessary, I
> think it is valuable. The other uses of the use permission I did not
> use. Also, see my related comment below on the catalog/schema object
> permissions.

It is incorrect use of use permission.
The use permission was used when we refer the table, but its contents
were not read directly, like:

  SELECT count(*) FROM t WHERE x > 0;

This query refers the table t and column t.x, but its contents are
consumed by backend internally. But it was pointed out such kind of
discrimination is nonsense in pgsql-hackers.

If you need something like "open" permission on the db_table class,
what you should do is submitting a proposition for a new permission.
It is not a right way to apply existing one for another purpose.

If SE-PostgreSQL does not care about, it simply ignore the permission
like as db_catalog class.

>> In the previous design, we have the following object hierarchy:
>>   [db_database]
>>    + [db_table]
>>    |  + [db_column]
>>    |  + [db_tuple]
>>    + [db_procedure]
>>    + [db_blob]
>>
>> The newly added db_schema should be placed between the db_database and
>> the db_table and others. TYPE_TRANSITION rules follows the revised design.
>>
>>   [db_database]
>>    + [db_schema]
>>    |  + [db_table]
>>    |  |   + [db_column]
>>    |  |   + [db_tuple]
>>    |  + [db_procedure]
>>    |  + [db_sequence] (newly added object class)
>>    + [db_blob]
>>
>>   (*) Unfortunatelly, PostgreSQL handles large object quite ad-hoc,
>>       although it can be used to communicate channel between multiple
>>       domains. So, it needs to be placed under the database.
>>
>> Currently, SE-PostgreSQL does not use db_catalog class, but it can be
>> used for other DBMS's.
>>
>> In addition, this patch changes something.
>>
>>  o The trusted procedure (sepgsql_trusted_proc_t) lost the
>>    db_database:{superuser} privilege, because it is invoked by
>>    unprived users to over the MAC restriction for a certain
>>    purpose, but it does not need to allow superpower in DAC.
>>   
> Is it intended that the superuser privilege give only DAC override or
> both MAC and DAC? Specifically, is it intended to override MLS or Type
> enforcement?

If the client does not have db_database:{superuser} privilege,
he cannot perform as database superuser, even if the DAC policy
allows. Please note that MAC stuff does not have a concept of
superuser. All the player need to be checked by the reference
monitor and its security policy.

>>  o The trusted procedure (sepgsql_trusted_proc_exec_t) lost the
>>    db_procedure:{install} privilege, because once installed procedure
>>    as a system internal entity can be invoked implicitly.
>>    We should not install trusted procedures for the purpose.
>>
>>  o The db_schema:{add_object remove_object} newly added are controled
>>    via the "sepgsql_enable_users_ddl" boolean.
>>    Now we control user's DDLs on uncategorized objects as row-level
>>    checks on sepgsql_sysobj_t, but it can be revised with adding
>>    db_schema object class.
>>   
> I think this also needs the equivalent of a "search" permission (or
> open, or use). This gives a nice way to control some access to an entire
> schema. That is, we want to use the schema (and catalog) as a mechanism
> to cut off users from entire subtrees. This helps to ensure that a user
> does not gain access to a newly created subordinate object. So, if a
> user does not have search for a schema (or catalog), there is no way
> they can access any present or future object in that schema (or
> catalog). Analogous to a directory. Without this search control I would
> continue to use the dir object class.

This boolean controls the capability of DDL statement from unpriv
users. They should access existing objects via DML, even if they
cannot modify the definition of tables and so on.
I don't think your suggestion is correct one.

>>  o type_transition for user_sepgsql_XXXX_t is moved to outside of
>>    tunable_policy(`...'). IIRC, I said these should be inside of
>>    the tunable, but unprive ones cannot create/drop tables labeled
>>    as sepgsql_XXX_t anyway when the boolean is disabled.
>>    So, I reconsidered it should be placed out of the tunable.
>>
>>  o {create drop setattr} permission for user_sepgsql_XXX is moved
>>    to inside of the tunable_policy, even if it is db_procedure
>>    class. I wonder why we didn't control CREATE FUNCTION statement
>>    by unpriv domains.
>>
>>  o db_blob:{import export} on user_sepgsql_blob_t is allowed to
>>    unpriv domains. It seems to me a strange behavior that it is
>>    not allowed on the object created by unpriv domain itself.
>>
>> * Remaining items
>>  o When we allows an unpriv domain to access SE-PostgreSQL using
>>    postgresql_unpriv_client(), its default labeling behavior is
>>    same as unconfined domains. For example, functions created by
>>    them are labeled as "sepgsql_proc_t".
>>    Now I'm considering it should be user_sepgsql_XXXX_t, because
>>    I would like to handle unprefixed types as an object created
>>    by database administrator (unconfined domains).
>>    It helps correctness of db_procedure:{install} permission.
>>
>>  o Because of db_schema object class, we can control user's DDLs
>>    without ad-hoc using row-level security on sepgsql_sysobj_t
>>    class. Now I think its purpose should be changed to prevent
>>    users accesses system catalogs directly.
>>   
> Are you implying here the need for something like a search or open
> permissions as I suggested above? If so, please disregard my previous
> comment:-)
>> Thanks,
>>   
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
