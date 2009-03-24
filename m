Message-ID: <49C833CE.4000206@ak.jp.nec.com>
Date: Tue, 24 Mar 2009 10:13:50 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux <selinux@tycho.nsa.gov>, refpolicy@oss.tresys.com
Subject: Re: The status of SE-PostgreSQL
References: <49C7667A.3020804@ak.jp.nec.com> <1237821939.8667.27.camel@localhost.localdomain>
In-Reply-To: <1237821939.8667.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> See the following items,
>>
>> * new permission: db_database:{superuser}
>>
>> They required a new permission to control database superuser
>> privileges similar to "root" capability in operating system.
>> The concept of superuser is common for some of major DBMSs,
>> not only PostgreSQL. In addition, it seems to me well symmetric
>> with operating system.
>>
>> The db_database:{superuser} controls whether the client can
>> perform as database superuser on the given database, or not.
> 
> Any chance of splitting this up into finer-grained privileges?

I basically think it is good idea from the viewpoint of security.
However, if they separate the superuser privige into finer-grained
ones without SQL specification, its design will fully depends on
PostgreSQL.

> And what precisely are the implications of this permission:  does it
> effectively make all of the other permission checks irrelevant for the
> subject?  In comparison, the SELinux capability permissions only allow
> the subject to override e.g. DAC file checks, not the SELinux MAC file
> checks.

In currently, it checks the context of client (subject) and the one
of database (object), but it can be fixed soon.
We already have several permissions on db_database class. Some of
them are checked on the database object, and the "superuser" is
checked on the subject itself. Is it no matter?

>> * undesired permission: db_database:{set_param get_param}
>>
>> They wondered the necessity of these checks, because SQL spec
>> does not require checks in set/get database parameters.
>> I didn't think it is necessary the security design of SELinux
>> should be symmetric with SQL, but I also thought these might
>> be unnecessary due to another reason.
>> In PostgreSQL, the scope of database parameters are session
>> local and initialized on the connection startup, so we cannot
>> use it as a pass to communicate between different two or more
>> domains.
> 
> Are any of the database parameters security-relevant (not just
> information flow)?

It provide a parameter of "sepostgresql=(on|off)" to turn on/off
its feature, but it is not allowed to change via SQL commands.
This parameter is initialized with the configuration file on
the server startup time, then it is handled as read-only.

If a man who can modify "$PGDATA/postgresql.conf" disables
SE-PostgreSQL, we have the matter in different place.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
