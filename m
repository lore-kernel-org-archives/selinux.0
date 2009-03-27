Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RCHFh6001868
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 08:17:15 -0400
Received: from mail2.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RCHDEe019585
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 12:17:14 GMT
Message-ID: <49CCC3C1.2040601@kaigai.gr.jp>
Date: Fri, 27 Mar 2009 21:17:05 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, cpebenito@tresys.com,
        selinux <selinux@tycho.nsa.gov>, refpolicy@oss.tresys.com
Subject: Re: [PATCH] Policy rework for SE-PostgreSQL (Re: Some ideas in SE-PostgreSQL
 enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CC8BEF.507@ak.jp.nec.com> <49CCA004.9040608@rubix.com> <49CCB678.4090209@kaigai.gr.jp> <49CCBC52.7000503@rubix.com>
In-Reply-To: <49CCBC52.7000503@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andy Warner wrote:
> 
> 
> KaiGai Kohei wrote:
>> Andy Warner wrote:
>>   
>>> KaiGai Kohei wrote:
>>>     
>>>> The attached patch is the first one in the series of reworks for
>>>> the SE-PostgreSQL security policy.
>>>>
>>>> It updates the following items.
>>>>
>>>> * Changes in the definition of object classes
>>>>
>>>> This patch add new three object classes and modifies the definition
>>>> of a few object classes.
>>>>  - db_database:{get_param set_param} is removed due to nonsense.
>>>>  - db_database:{superuser} is added to restrict privileges of
>>>>    database superuser.
>>>>  - db_table/db_column/db_tuple:{use} is removed due to nonsense.
>>>>  - New object classes: db_catalog, db_schema and db_sequence are added.
>>>>       
> 
> I guess I should have asked before, is there is any proposed permission 
> set for the three new object classes mentioned above?

In the attached patch:
--------
+# More database stuff
+class db_catalog
+inherits database
+{
+	search
+	add_object
+	remove_object
+}
+
+class db_schema
+inherits database
+{
+	search
+	add_object
+	remove_object
+}
+
+class db_sequence
+inherits database
+{
+	get_value
+	set_value
+}
--------

The db_catalog, db_schema and db_sequence inherit six permissions
from common database object.

  create        ... should be checked when the object is created
  drop          ... should be checked when the object is dropped
  getattr       ... should be checked when its metadata is changed
  setattr       ... should be checked when its metadata is changed
  relabelfrom   ... should be checked when its security context is changed
  relabelto     ... same as relabelfrom

And these object class has its own permission:

  search        ... should be checked when a object under the namespace
                    is refered.
  add_object    ... should be checked when we add a object under the namespace
  remove_object ... should be checked when we remove a object under the namespace
   (*) namespace means catalog or schema, here.
  get_value     ... should be checked when we fetch a value from the sequence
  set_value     ... should be checked when we reset the sequence

> I understand now and then the intent of the use permission. If I need 
> functionality from the database object classes that is not provided, 
> then I have little option other than use something in a way that is not 
> "correct". Such as my use of the dir object class to account for not 
> having object classes for schemata and catalog. And, from a user's point 
> of view, a permission called "use" works well with being to (or not) use 
> a table. So, I think it was quite reasonable to use it for my purposes. 
> I'm not sure what the official means of proposing a new permission is, 
> but I thought this thread was a discussion of any changes that may need 
> to made to the database policy, and since you are removing the use 
> permission, I thought it relevant. Call the permission "use" or call if 
> "open", the intent of my comment was to suggest that policy support for 
> the semantics of how I used the use permission would be good.

I don't intend you to force my opinion.
However, it's not unclear the purpose of your "use" permission on
db_table class. If you prevent users to access the tabel, it can
be controled via select, update, delete, insert and other permission.

I can understand "search" permission on the db_catalog and db_schema
as an analogy of directory.
But it is not suitable for tables, procedures or others, because it
does not intend to hide existence of these object.
For example, when "cat.schm.tbl_A" is invisible, I can try to create
a table with same name then get an error. It enables us to know
existence of the table, so such kind of permission is nonsense.

>>>>  o The db_schema:{add_object remove_object} newly added are controled
>>>>    via the "sepgsql_enable_users_ddl" boolean.
>>>>    Now we control user's DDLs on uncategorized objects as row-level
>>>>    checks on sepgsql_sysobj_t, but it can be revised with adding
>>>>    db_schema object class.
>>>>   
>>>>       
>>> I think this also needs the equivalent of a "search" permission (or
>>> open, or use). This gives a nice way to control some access to an entire
>>> schema. That is, we want to use the schema (and catalog) as a mechanism
>>> to cut off users from entire subtrees. This helps to ensure that a user
>>> does not gain access to a newly created subordinate object. So, if a
>>> user does not have search for a schema (or catalog), there is no way
>>> they can access any present or future object in that schema (or
>>> catalog). Analogous to a directory. Without this search control I would
>>> continue to use the dir object class.
>>>     
>>
>> This boolean controls the capability of DDL statement from unpriv
>> users. They should access existing objects via DML, even if they
>> cannot modify the definition of tables and so on.
>> I don't think your suggestion is correct one.
>>   
> I think you misunderstood me. I was not commenting on the boolean at 
> all. I was commenting on the reference to "db_schema:{add_object 
> remove_object}" thinking (assuming) that add_object and remove_object 
> were the only two permission given to the db_schema object class. Is 
> this the intent? I did not see anywhere in the email that defined the 
> set of permissions the db_schema (or db_catalog) would have.

As I noted above, the db_schema object class has 9 permissions in total.
It also includes "search" permission.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
