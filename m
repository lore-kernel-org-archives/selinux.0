Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2LEmMq0016807
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 10:48:22 -0400
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2LEmJ4b022293
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 14:48:20 GMT
Received: by nz-out-0506.google.com with SMTP id z3so177464nzf
        for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 07:48:17 -0700 (PDT)
Message-ID: <460145AA.9020109@kaigai.gr.jp>
Date: Wed, 21 Mar 2007 23:48:10 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: The reason why SEPostgreSQL use original userspace AVC
References: <45FE9A2F.40200@kaigai.gr.jp> <1174480707.22565.367.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1174480707.22565.367.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2007-03-19 at 23:11 +0900, KaiGai Kohei wrote:
>> Hi,
>>
>> This was one of the topics discussed on SELinux developer summit held on
>> last Friday.
>> I like to send the reason why I made a decision to implement SE-PostgreSQL
>> with original userspace AVC, for wider discussion.
>> (SE-PostgreSQL didn't use the userspace AVC provided by libselinux.)
>>
>> There are two major reasons. The one is a performance gain. The other is
>> concurrency of invalidation.
>>
>> Any comment and suggestion please.
>>
>> [ performance gain ]
>>
>> The biggest reason is originated from the way to associate a security context
>> for each tuple. As I mentioned, I modified the internal data structure of
>> tuples to add its security context. The field is a 4-byte length integer
>> variable (same as object id data type), not a string expression.
>> This value is associated with the contains of 'pg_selinux'.
>>
>> 'pg_selinux' is one of the system catalogs. System catalogs are special tables
>> which contains database meta information like definition of table, view, stored
>> procedure and so on.
>> 'pg_selinux' has two column. One is 'oid' defined as object id type. It hold
>> a unique number within the table. The other is 'selcontext' defined as variable
>> length text type. It hold a security context in text expression.
>> So, we can refer the pg_selinux system catalog, when a text expression of security
>> context is required.
>> (e.g A case when 'security_context' is specified in SQL queries.)
>>
>> The object id enables to identify a security context in text expression, so we
>> can also apply them as a key of userspace avc. I named it as psid (persistent
>> security id).
>>
>> Using psid enables to be unnecessary to handle a text represented security context
>> in the most frequently path. When we have to make a decision whether the fetched
>> tuple is allowed or not, we can search the userspace avc with psid held by the tuple
>> as is.
>>
>> In the userspace avc provided by libselinux. Its avc_has_perm() requires security_id_t
>> as arguments, but it means we have to translate security context from psid to text
>> representation in a decision making process.
>> No need to say, it make a bad effect to the performance of SE-PostgreSQL.
> 
> So I understand correctly, the underlying issue here is that you want
> your userspace object manager to be able to generate its own SID mapping
> (in your case, using these psids or object ids) rather than have the SID
> mapping handled entirely within libselinux, so that you can have the ids
> also represent something meaningful to the object manager for efficient
> lookup.  It seems possible to have the libselinux userspace AVC export
> interfaces to allow an object manager to optionally populate the
> SID->context mapping itself using identifiers it selects.  Would that
> address your concern?

Yes.
If we can use PSIDs as an alternatives of security_id_t, it seems to me
a good idea.

>> [ concurrency of invalidation ]
>>
>> SE-PostgreSQL deploys its userspace avc on the shared memory region, and generates
>> a single policy state monitoring process to poll netlink socket at bootup time.
>> It enables to invalidate the userspace avc referred by all SE-PostgreSQL instances
>> concurrently.
>>
>> If the userspace avc is deployed on the process local memory for each instance,
>> we need policy state monitoring threads for each instances and the invalidation
>> of userspace avc is not done concurrently.
>> At a moment, different policies may be applied between SE-PostgreSQL instances.
>>
>> In addition, we will get a little performance improvement on startup time of instances.
>> If the userspace avc deployed on the shared memory region, it may contains several
>> access control rules before it is referred at first. It enables to reduce the number
>> of calling system-call.
>> And, it is not necessary to generate a policy state monitoring thread for each
>> SE-PostgreSQL instance.
> 
> I'd be interested in seeing your userspace AVC implementation - is it
> short enough that you can post it, or if not, point us to the specific
> files in your repository?  I would tend to think that any gains you
> might get from sharing a single AVC among multiple processes would tend
> to be negated by 1) the locking required to make that safe (similar to
> the locking support in the AVC for multi-threaded applications), and 2)
> the affect on the cache of having multiple processes using it for
> different access checks. 

http://sepgsql.googlecode.com/svn/trunk/src/backend/security/sepgsqlCore.c
includes the implementation of userspace AVC.

It utilizes the shared memory management system in PostgreSQL.
sepgsqlShmemSize() is called to return the size of avc we need.
In sepgsql_avc_init(), ShmemInitStruct() is called to create/attach a shmem
segment.
If the shmem segment is newly generated, we initialize a lock variable and
the userspace avc deployed on the shmem segment.

sepgsql_avc_audit() is called to generate an audit message.

sepgsql_avc_permission_noaudit() is the core of the userspace avc.
It uses a light weight lock provided by PostgreSQL. In actually, it's a mutext
lock held on shmem segment.

sepgsqlMonitoringPolicyState() is the implementation of policy state monitoring
process. It is fork()'ed on bootup.

http://sepgsql.googlecode.com/svn/trunk/src/backend/security/sepgsqlPsid.c
provides translation between PSID and security contexts in text representation.

When we try to update/insert on a cell declared with PSID type, psid_in() is
called at first. It formalize the security context into raw format. Then, it
convert into PSID by looking up pg_selinux system catalog.
In finally, a security context we inputed with text representation is translated
into an integer value with 4-byte length.

> Also, IIUC, you don't need to have a separate
> thread monitoring the netlink socket per se; the libselinux AVC can
> check just its state on each avc_has_perm call in the non-threaded case.

The checks are done by recvfrom() with a netlink socket.
Because the userspace AVC is referred so frequently in SE-PostgreSQL,
I thought that checks on each avc_has_perm() will cause serious
performance degradation.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
