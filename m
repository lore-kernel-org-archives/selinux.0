Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2P6sZOR015257
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 02:54:35 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2P6sXkw020805
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 06:54:34 GMT
Message-ID: <49C9D524.9050208@ak.jp.nec.com>
Date: Wed, 25 Mar 2009 15:54:28 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
CC: refpolicy@oss.tresys.com
Subject: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com>
In-Reply-To: <49C84200.9090107@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As I noted in the previous message, SE-PostgreSQL is postponed to
the PostgreSQL v8.5 after the long discussion in the pgsql-hackers
list, unfortunately.
However, it also mean a good chance to revise its design because
we have a few months before v8.5 development cycle launched.

1. Changes in object classes and access vectors
 - add db_database:{superuser} permission
 - remove db_database:{get_param set_param} permission
 - remove db_table/db_column/db_tuple:{use} permission

  Please refer the previous messages for them.

 - add new object class "db_schema"
  As Andy noted, we directly put database objects under the
  db_database class directly. But, some of database objects
  are created under a schema object.
  In other word, RDBMS's design has three level hierachy as:
     <database>  (<-- some DBMSs calls it as <catalog>)
      + <schema>
         + <tables>, <procedures>, ...

  Now, we control user's DDL statement via permissions on
  the sepgsql_sysobj_t type as row-level controls.
  But I think db_schema object class here is meaningful
  to match SQL's design and analogy to the dir class.

  The new db_schema object class inherits six permissions
  from common database objects, and defines three its own
  permissions: add_object, remove_object, usage

  The former two permissions are checked when we create
  or drop database object within the given schema.
  The usage permission is checked when we use database
  objects under the schema.

 - add new object class "db_sequence"
  A secuence object enables to generate a set of sequencial
  numbers to avoid confliction of key value.
  We can set a value on the sequence, and others can fetch it.
  It can be used as an information flow channel.

  The new db_sequence object class inherits six permissions
  from common database objects, and defines two its own
  permissions: get_value and set_value.


2. System audit integration

Now, SE-PostgreSQL writes out its access denied message into
the logfile of PostgreSQL (/var/log/sepostgresql.log).
But it is more desirable approach to write out them into system
audit mechanism, because any other SELinux related messages
are collected here and utilities like audit2allow is available.

TODO:
- changes in the security policy:
  We need to allow postgresql_t to write audit messages.
  In addition, the backend process need to run with cap_audit_write.

- a new interface in audit-libs:
  The current audit-libs has the following interface.

    extern int audit_log_user_avc_message(int audit_fd, int type,
            const char *message, const char *hostname, const char *addr,
            const char *tty, uid_t uid);

  But some arguments are not meaningful in SE-PostgreSQL.
  I would like to write out database role here, instead of tty and uid.


3. Simplifies netlink loops

SE-PostgreSQL needs to implement its own userspace AVC due to
some reasons. When the backend started up, it creates a worker
process to receive messages from in-kernel SELinux via netlink
socket. The worker process invalidates the userspace AVC of
all the instance of PostgreSQL backend process when the state
of SELinux is changed.

However, I think the following loop to receive messages from
netlink socket should be provided via libselinux.

  http://code.google.com/p/sepgsql/source/browse/trunk/core/src/backend/security/sepgsql/avc.c#647

If avc_netlink_loop() provided a callback function, I could push
the code into the libselinux.

TODO:
- a set of new interface on libselinux:
I would like to add a few new interfaces to handle netlink socket
in libselinux, and expose them to application. I guess we can
write the existing standard avc with the interfaces.


4. Permissive domain in userspace

It is an issue got sleep for a few months.
  http://marc.info/?l=selinux&m=122337314619667&w=2


5. Handle unsupported object classes/access vectors

What is the correct behavior for userspace object managers,
when it tries to check undefined object classes or access
vectors?

For example, we don't define db_database:{superuser} in the
security policy. We cannot decide whether it is denied, or not.
How the SE-PostgreSQL should perform for this?

In the current implementation, it simply ignores undefined
permissions because string_to_av_perm() cannot return a valid
access vector.

One possible idea is it performs according to /selinux/deny_unknown.
If so, a new interface on libselinux is desirable.


Any comments are welcome.

Thanks,


KaiGai Kohei wrote:
> Andy Warner wrote:
>> Just a thought from working with the DBMS functionality within the 
>> SELinux policy. Has there been any thought or talks about adding support 
>> for catalog or schema objects? When I integrated the SELinux policy into 
>> our DBMS I found them lacking and ended up using the dir object class, 
>> as that closely mimicked our use of catalogs and schemata.
>>
>> Andy
> 
> Yes, I initially considered whether we should have "db_schema" object
> class or not, but concluded it is not needed strongly because of
> differences between two security models.
> 
> When we create a new database object (like a table), PostgreSQL checks
> "create" privilege on the schema on which the table is placed.
> Meanwhile, SELinux checks "db_table:{create}" privilege on the table
> itself which has a security context. In other word, the schema works
> just a namespace from viewpoint of the SELinux design.
> 
> However, I can understand the analogy which you pointed out.
> The "dir" object class has "add_name", "remove_name" and
> "search" permissions, similar to what the schema doing.
> 
> Because the SE-PostgreSQL is postponed to get merged, we can fix
> its fundamental design in other words.
> 
> Thanks,
> 
>> KaiGai Kohei wrote:
>>> Here is a bad news.
>>>
>>> I've had a discussion in pgsql-hackers list for a long time, but
>>> we cannot get a conclusion that SE-PostgreSQL should be merged
>>> in the PostgreSQL v8.4 which is the next major release, and it
>>> was postponed to the v8.5 development cycle due to lack of time
>>> for enough reviewing the feature.
>>>
>>> If it can be released on schedule, the v8.4 is released on the
>>> second quarter of 2009, and the v8.5 will be relased on a year
>>> later (but it tend to delay a few months).
>>> So, it is necessary to apply SE-PostgreSQL patches or install
>>> it from RPM package distributed via Fedora project. :(
>>>
>>> Under the discussion, I got a few suggestions in its security
>>> design, and it seems to me fair enough. Some of them needs to
>>> change definitions in the default policy.
>>>
>>> See the following items,
>>>
>>> * new permission: db_database:{superuser}
>>>
>>> They required a new permission to control database superuser
>>> privileges similar to "root" capability in operating system.
>>> The concept of superuser is common for some of major DBMSs,
>>> not only PostgreSQL. In addition, it seems to me well symmetric
>>> with operating system.
>>>
>>> The db_database:{superuser} controls whether the client can
>>> perform as database superuser on the given database, or not.
>>>
>>> * undesired permission: db_database:{set_param get_param}
>>>
>>> They wondered the necessity of these checks, because SQL spec
>>> does not require checks in set/get database parameters.
>>> I didn't think it is necessary the security design of SELinux
>>> should be symmetric with SQL, but I also thought these might
>>> be unnecessary due to another reason.
>>> In PostgreSQL, the scope of database parameters are session
>>> local and initialized on the connection startup, so we cannot
>>> use it as a pass to communicate between different two or more
>>> domains.
>>>
>>> * undesired permission: db_table/db_column/db_tuple:{use}
>>>
>>> I originally proposed the {use} permission to set up write-only
>>> tables, but it might be a misdesign.
>>> (Sorry, a bit long description.)
>>>
>>> At the initial design, SE-PostgreSQL applied {select} permission
>>> for all the refered tables, columns and tuples. But, it also means
>>> {select} permission is necessary for conditional DELETE or UPDATE
>>> even if its content is not exposed to the client.
>>> So, I proposed the privilege into two different permission: {select}
>>> and {use}. The {select} allows the client to refer the object and
>>> its content can be returned to him. The {use} also allows the client
>>> to refer the object but its content has to be consumed internally.
>>>
>>>   Example)
>>>     SELECT a, b FROM t WHERE c = 5;
>>>   In this case, we need {select} on column t.a and t.b, but {use}
>>>   is required on column t.c because its content is consumed by
>>>   SE-PostgreSQL itself and not returned to the client.
>>>
>>>   Example)
>>>     UPDATE t SET x = 20 WHERE y = 'aaa';
>>>   In this case, we need {update} on column t.x, and {use} on t.y,
>>>   but {select} is not necessary.
>>>
>>> However, we can break it rapidly with a clever condition clause.
>>> For example, we can get a result from the first trial:
>>>   DELETE FROM account WHERE userid = 100 and creditno like '1%';
>>>
>>> If this query removes a tuple, it means the first character of
>>> credit card number is '1'. If not so, he can try it 9 times.
>>> Then, he can get the information without {select} permission,
>>> with enough small number of trials.
>>>
>>> They concluded the "{use}" permission cannot work correctly, and
>>> danger to expect it does not allow to leak contexnt to the outside.
>>> I can agree this opinion.
>>>
>>>
>>> The attached patch add/remove these permissions.
>>> Any comments please.
>>>
>>> Thanks,

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
