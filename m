Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n414t8ZV028852
	for <selinux@tycho.nsa.gov>; Fri, 1 May 2009 00:55:08 -0400
Message-ID: <49FA80A2.7060804@tycho.nsa.gov>
Date: Fri, 01 May 2009 00:54:58 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Joshua Brindle <method@manicmethod.com>, Andy Warner <warner@rubix.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com> <49CD687C.9080401@kaigai.gr.jp> <49CDCF07.1020900@rubix.com> <49D018A3.2090304@ak.jp.nec.com> <49D08105.2090607@ak.jp.nec.com> <49EE5FE3.7010601@tycho.nsa.gov> <49EE9619.6090602@ak.jp.nec.com>
In-Reply-To: <49EE9619.6090602@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Eamon Walsh wrote:
>   
>> KaiGai Kohei wrote:
>>     
>>> KaiGai Kohei wrote:
>>>   
>>>       
>>>> My preference is the later one:
>>>>   TYPE_TRANSITION <subject context> <server context> : <class> <new context>;
>>>>
>>>> In addition, an idea of configuration file can be considerable to set up
>>>> the default context of database objects, though I considered it is not
>>>> necessary in the past discussion.
>>>> If a user want to work the database server process as an unconfined domain,
>>>> like a legacy "disable_xxxx_trans" boolean doing, the <server context> as
>>>> the target of TYPE_TRANSITION breaks all the correct labeling.
>>>>
>>>> If we have a /etc/selinux/$POLICYTYPE/contexts/db_{sepgsql|rubix}, as follows,
>>>> it can be used to specify the default context of special purpose database
>>>> object such as schemas to store temporary database objects, not only the
>>>> context of database as the root of type transition.
>>>> ------------
>>>> database    *             system_u:object_r:sepgsql_db_t:s0
>>>> schema      pg_temp_*     system_u:object_r:sepgsql_temp_schema_t:s0
>>>>   :             :            :
>>>> ------------
>>>>
>>>> The libselinux has selabel_lookup(3) interface to implement them
>>>> for various kind of objects.
>>>>     
>>>>         
>>> The attached patch is a proof of the concept.
>>> It adds the forth backend of selabel_lookup(3) interface.
>>>
>>> Under the enhancement, we should the following rules to determine what
>>> security context is assigned on the newly created database object.
>>>
>>> 1. An explicitly specified security context by users.
>>>    e.g)  CREATE TABLE t (a int, b text)
>>>              SECURITY_LABEL = 'system_u:object_r:sepgsql_table_t:SystemHigh';
>>>
>>> 2. A matched entry in the configuration file which can be lookup up
>>>    by selabel_lookup(3).
>>>    e.g)  schema  pg_temp_*  system_u:object_r:sepgsql_temp_schema_t:s0
>>>                  ^^^^^^^^^ --> if the new object name and type are matched.
>>>
>>> 3. The result of security_compute_av() or avc_compute_create() which can
>>>    return the result of TYPE_TRANSITION rules.
>>>
>>> The second step is newly suggested in this patch.
>>> Needless to say, the determinded security context has to be checked
>>> by the security policy.
>>>
>>>   
>>>       
>>>> One concern is performance hit. If we need to open/lookup/close the file
>>>> for each INSERT statement, its pain will be unacceptable.
>>>>     
>>>>         
>>> This patch does not support db_tuple class, because of headach in performance
>>> and its characteristic that database tuples have no name to identify itself.
>>>
>>> Thanks,
>>>   
>>>       
>> First, regarding the problem of labeling the top-level (root) database
>> object, why can't you specify this through a command line argument (to
>> "createdb") or extra argument to CREATE DATABASE? I see above that a
>> "SECURITY_LABEL" arg is supported for CREATE TABLE. Just use something
>> similar for CREATE DATABASE and default to the <subject> <subject> type
>> transition if none is specified.
>>     
>
> It is not preferable to enforce the "SECURITY_LABEL=xxx" option for all
> the case due to the SQL compatibility, so I would like to focus on the
> default behavior.
> The <subject> <subject> type transition works correctly to compute the
> root of the database objects, if we have only SELinux aware DBMSs.
> However, at least, RUBIX appeared in other than SE-PostgreSQL.
>
> So, we want to determine the security context of the root object depending
> on the database obejct manager.
>
> I have one other idea which applies a common security policy for all the
> SE- DBMSs, but I guess it is not good because of differences in their
> specifications and functionalities.
> (E.g PostgreSQL creates schema objects under a database directly, but
> RUBIX has a catalog object between them.)
>
>   
>> But let's step back and take a look at how the file system uses file
>> contexts. Files are labeled in three ways:
>>
>> 1. The normal, preferred way, through a type transition on a subject
>> (domain) and target (parent directory). The database analog to this:
>> through a type transition on a subject (domain) and target (parent
>> table, schema, or other object).
>>     
>
> Yes, we can basically cover all the database object which have its
> parent object. But the root database obejct does not have its parent.
> It is the first issue.
>   

How are databases stored on disk? Is there a file or directory that
could serve as the parent object?


>   
>> 2. For files that are NOT persistent, such as /proc and /sys, by
>> genfscon rules, which are basically the same as file_contexts. So if
>> there are non-persistent database objects (such as the pg_temp
>> mentioned) and there really is no parent object to label from in a type
>> transition, using selabel lookups could make sense.
>>     
>
> I think the setfscreatecon is better analogy than the genfscon.
>   

I don't agree here - setfscreatecon is analogous to SECURITY_LABEL=xxx,
where the client (not the object manager) can override the default
context for its own purposes. Label lookups, on the other hand, come
from a fixed configuration file in /etc/selinux and they are done by the
object manager, not the client. It's more like a matchpathcon() or a
genfscon.

That said, I don't have a strong objection to this and I do think the
selabel support has some valid uses for Postgres.


> A schema object is deployed under a database object, so we can compute
> a default security context using type transition rules, but I also want
> to set a characteristic default on pg_temp due to its feature.
> It is the second issue how individual security contexts can be set on
> objects within same object class.
>   

SE-Postgres should be able to detect when a temp table is being created
and only do the selabel lookup in that case.

Actually, if the temp tables are visible to other clients you may need
to do an selabel lookup followed by a type transition. Such as
temp_schema_t (from lookup) -> type transition -> user_temp_schema_t.
Otherwise the temp table could be accessible to other domains. Another
alternative would be to use UBAC. If the temp table is not shared
between sessions then it doesn't matter.




> (Or, defines db_schema_temp class? I'm not sure whether other DBMSs
> shares the concept of schamas to store temporary objects.)
>   

This may work. Whether to define a separate object class depends on the
complexity it would add to the policy writing and object manager code,
versus looking it up in selabel. I wouldn't worry about whether other
DBMS would use the class. If they don't need it they can simply ignore it.


>   
>> 3. By a trusted relabeler, such as fixfiles. Here again the proposal may
>> be useful, if you wanted to keep a default set of labels and have some
>> offline relabeler program that would go through the whole database and
>> fix up the labels. This program would be some trusted client that
>> changes all the labels.
>>     
>
> Yes, we don't have this kind of utility now, but I believe a similar
> command will be desirable.
>
>   
>> So other than a single case, which is non-persistent database objects,
>> selabel lookups should not be required. By analogy, the filesystem does
>> not consult the file_contexts file every time a new file is created. In
>> your priority list defined above, step 2 (selabel) should be after step
>> 3 (type transition) and should be qualified with "only when type
>> transition is not possible because object is non-persistent."
>>
>> Does this make sense or am I missing something fundamental about the
>> database environment?
>>     
>
> The selabel_lookup(3) for database tries to solve two issues in same time.
> The one is the default to the root of database objects which does not have
> any parent object. The other is also the default to certain characteristic
> objects.
> If we can consider the selabel as analogy of setfscreatecon (automatically
> set up) for the second issue, I don't think its priority should be moved
> to the behind of type transition.
>
> An aside, the pg_temp schema is implicitly created when CREATE TEMP TABLE
> statement is given, so we cannot apply SECURITY_LABEL=xxx here. :(
>   

Understood.

I'll probably push the patch next week sometime, unless I hear otherwise.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
