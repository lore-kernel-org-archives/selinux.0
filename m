Message-ID: <4A023AC0.9080207@ak.jp.nec.com>
Date: Thu, 07 May 2009 10:34:56 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, Andy Warner <warner@rubix.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com> <49CD687C.9080401@kaigai.gr.jp> <49CDCF07.1020900@rubix.com> <49D018A3.2090304@ak.jp.nec.com> <49D08105.2090607@ak.jp.nec.com> <49EE5FE3.7010601@tycho.nsa.gov> <49EE9619.6090602@ak.jp.nec.com> <49FA80A2.7060804@tycho.nsa.gov>
In-Reply-To: <49FA80A2.7060804@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry for late reply due to the spring vacation season in Japan.

>>> But let's step back and take a look at how the file system uses file
>>> contexts. Files are labeled in three ways:
>>>
>>> 1. The normal, preferred way, through a type transition on a subject
>>> (domain) and target (parent directory). The database analog to this:
>>> through a type transition on a subject (domain) and target (parent
>>> table, schema, or other object).
>>>     
>> Yes, we can basically cover all the database object which have its
>> parent object. But the root database obejct does not have its parent.
>> It is the first issue.
>>   
> 
> How are databases stored on disk? Is there a file or directory that
> could serve as the parent object?

In PostgreSQL, all the database files are indeed stored in a single root
directory ($PGDATA), however, it depends on the current implementation.

>>> 2. For files that are NOT persistent, such as /proc and /sys, by
>>> genfscon rules, which are basically the same as file_contexts. So if
>>> there are non-persistent database objects (such as the pg_temp
>>> mentioned) and there really is no parent object to label from in a type
>>> transition, using selabel lookups could make sense.
>>>     
>> I think the setfscreatecon is better analogy than the genfscon.
>>   
> 
> I don't agree here - setfscreatecon is analogous to SECURITY_LABEL=xxx,
> where the client (not the object manager) can override the default
> context for its own purposes. Label lookups, on the other hand, come
> from a fixed configuration file in /etc/selinux and they are done by the
> object manager, not the client. It's more like a matchpathcon() or a
> genfscon.
> 
> That said, I don't have a strong objection to this and I do think the
> selabel support has some valid uses for Postgres.

Hmm... it seems to me you are correct.
This behavior of selbalel_lookup() may not have appropriate analogy in
filesystem.

>> A schema object is deployed under a database object, so we can compute
>> a default security context using type transition rules, but I also want
>> to set a characteristic default on pg_temp due to its feature.
>> It is the second issue how individual security contexts can be set on
>> objects within same object class.
>> 
> 
> SE-Postgres should be able to detect when a temp table is being created
> and only do the selabel lookup in that case.
> 
> Actually, if the temp tables are visible to other clients you may need
> to do an selabel lookup followed by a type transition. Such as
> temp_schema_t (from lookup) -> type transition -> user_temp_schema_t.
> Otherwise the temp table could be accessible to other domains. Another
> alternative would be to use UBAC. If the temp table is not shared
> between sessions then it doesn't matter.

It seems to me this kind of special case handling can give us confusion...

>> (Or, defines db_schema_temp class? I'm not sure whether other DBMSs
>> shares the concept of schamas to store temporary objects.)
>>   
> 
> This may work. Whether to define a separate object class depends on the
> complexity it would add to the policy writing and object manager code,
> versus looking it up in selabel. I wouldn't worry about whether other
> DBMS would use the class. If they don't need it they can simply ignore it.

Indeed, we discussed about differences between SE-PostgreSQL and
RUBIX before, and agreed to ignore db_catalog class in SE-PostgreSQL.

At least, it has a benefit compared to selabel in UBAC handling,
so it might be necessary to consider the option.

>> The selabel_lookup(3) for database tries to solve two issues in same time.
>> The one is the default to the root of database objects which does not have
>> any parent object. The other is also the default to certain characteristic
>> objects.
>> If we can consider the selabel as analogy of setfscreatecon (automatically
>> set up) for the second issue, I don't think its priority should be moved
>> to the behind of type transition.
>>
>> An aside, the pg_temp schema is implicitly created when CREATE TEMP TABLE
>> statement is given, so we cannot apply SECURITY_LABEL=xxx here. :(
>>   
> 
> Understood.
> 
> I'll probably push the patch next week sometime, unless I hear otherwise.

Please wait for a while.

As I noted before, the selabel patch tries to solve two matters.
 - The default label for db_database class.
 - The default label for temporary schame.

If we can have db_schema_temp class, the only remaining matter is the default
in db_database class. It can be solved using a file which store a default label
for SE-PostgreSQL's db_database objects, as if run_init uses initrc_context.

It makes sense for me, and clear its behavior from the viewpoint of the analogy.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
