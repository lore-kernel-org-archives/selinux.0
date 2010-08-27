Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7R8jivJ003575
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2010 04:45:46 -0400
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o7R8jiqa015440
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2010 08:45:45 GMT
Message-ID: <4C777B1A.7040102@ak.jp.nec.com>
Date: Fri, 27 Aug 2010 17:45:14 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: memcached@googlegroups.com, Kelvin Edmison <kelvin@kindsight.net>,
        SELinux <selinux@tycho.nsa.gov>,
        Reference Policy <refpolicy@oss1.tresys.com>
Subject: Re: memcached permissions
References: <C87E39DA.3481E%kelvin@kindsight.net> <4C5A03DD.5080605@ak.jp.nec.com> <4C68CEF0.2070202@ak.jp.nec.com>
In-Reply-To: <4C68CEF0.2070202@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

BTW, how about getting inclusion of this patch?

(2010/08/16 14:38), KaiGai Kohei wrote:
> The attached patch is a revised version of memcached permissions.
> 
> The 'calculate' permission has gone, and INCR/DECR requires us
> both of 'read' and 'write' permissions.
> It means we should switch domain of the client process when we
> need special treatments to unaccessable items; something like
> trusted procedures.
> 
> Rest of the patch is not changed.
> 
> (2010/08/05 9:20), KaiGai Kohei wrote:
>> (2010/08/04 10:25), Kelvin Edmison wrote:
>>> I'm still not sure how allowing a 'calculate' permission would be helpful in
>>> this case.  Incr and decr allow for incrementing and decrementing by any
>>> amount.  There does not seem to be any real difference between that and
>>> 'write' to me.
>>>
>> INCR and DECR allow users to set a numerical value according to arithmetic
>> rule, although SET allows to set a fully arbitrary value.
>> If administrator want to allow users to modify a value in a limited way,
>> he can grant 'calculate' permission, instead of 'write' permission.
>>
>> If we would be talking about RDBMS, it is possible to switch client's
>> privileges during execution of a certain stored procedure.
>> However, memcached does not have such a feature, so we need to consider
>> more fine grained permissions.
>>
>> BTW, I noticed a different viewpoint, although I didn't reach the idea before.
>> Since memcached does not have stored procedure, it might be a correct answer
>> that the client switches its privileges when it tries to modify read-only
>> values. Like set-uid programs in unix, SELinux has a feature to switch
>> privileges of process on execve(2) time. It allows a small number of trusted
>> programs to write values, but prevents to modify items by others.
>>
>>> If a strict security partitioning is desired, then perhaps a single
>>> reference counter isn't feasible.  Would it not be better, from a security
>>> point of view, to have individual counters for the different clients?
>>> The clients would have 'create|read|write' permissions, and any overall
>>> administrative app could have read-only permissions on all those counters to
>>> collect and sum (or otherwise report) them?
>>>
>> If a strict security partitioning environment, it seems to me what you introduced
>> is reasonable.
>>
>> Thanks,
>>
>>> Kelvin
>>>
>>> On 02/08/10 1:45 AM, "KaiGai Kohei"<kaigai@ak.jp.nec.com>    wrote:
>>>
>>>> (2010/07/30 22:55), Kelvin Edmison wrote:
>>>>> While I haven't yet read the patch, I would like to understand why there is
>>>>> a need for a Calculate permission.  Why would someone be granted 'calculate'
>>>>> permission but not 'write' permission?
>>>>>
>>>>> Kelvin
>>>>>
>>>> The issue depends on individual user's requirement of security.
>>>> If they want not to leak anything over the security domains,
>>>> they should grant the 'calculate' permission on everybody who
>>>> already have both 'read' and 'write' permissions.
>>>> It it equivalent to these permissions.
>>>> However, it may lack flexibility in configuration of access
>>>> controls, if users don't consider 'INCR' and 'DECR' are risk
>>>> information leaks/manipulations.
>>>> For example, it is not a rare case that we don't want to expose
>>>> individual client's items, but want to control a shared reference
>>>> counter.
>>>>
>>>> Ideally, I'd like to define more fine grained permissions to
>>>> distinguish a security sensitive operations and others.
>>>> But here is limitation of protocol. We cannot automatically
>>>> determine what is security sensitive data and what is not.
>>>>
>>>> Thanks,
>>>>
>>>>> On 30/07/10 12:49 AM, "KaiGai Kohei"<kaigai@ak.jp.nec.com>     wrote:
>>>>>
>>>>>> I'll mainly submit the patch and message to SELinux community,
>>>>>> but please don't hesitate to comment anything from memcached
>>>>>> community.
>>>>>> --------
>>>>>>
>>>>>> The attached patch adds policies to support access controls
>>>>>> on key-value items managed by memcached with SELinux engine.
>>>>>>
>>>>>> Nowadays, various kind of key-value-stores support memcached
>>>>>> compatible protocol as a de-facto standard. So, it will be a
>>>>>> reasonable start to consider the protocol to control accesses
>>>>>> from clients; typically web applications.
>>>>>>
>>>>>>       http://github.com/memcached/memcached/blob/master/doc/protocol.txt
>>>>>>
>>>>>> 1) new permissions
>>>>>>
>>>>>> This patch adds 'kv_item' class with the following permissions
>>>>>>      - create
>>>>>>      - getattr
>>>>>>      - setattr
>>>>>>      - remove
>>>>>>      - relabelfrom
>>>>>>      - relabelto
>>>>>>      - read
>>>>>>      - write
>>>>>>      - append
>>>>>>      - calculate
>>>>>>
>>>>>>        Most of permission works as literal.
>>>>>>        On the 'SET' or 'CAS' operations, it creates a new item when here
>>>>>>        is no items with same kye. In this case, 'create' permission shall
>>>>>>        be checked. Elsewhere, 'write' permission shall be checked on the
>>>>>>        existing items.
>>>>>>
>>>>>>        When an item get expired, it shall be unlinked internally. In this
>>>>>>        case, no permissions are checked, because it does not work according
>>>>>>        to the user's request.
>>>>>>
>>>>>>        On the 'FLUSH_ALL' operation, it unlinks any items older than
>>>>>>        a certain watermark. In this case, 'remove' permission shall be
>>>>>>        checked on the items to be unlinked. If violated, it skips to
>>>>>>        unlink this item.
>>>>>>
>>>>>>        On 'INCR' or 'DECR' operation, 'calculate' permission shall be checked.
>>>>>>        Is it necessary to distinguish between 'INCR' and 'DECR' here?
>>>>>>        E.g, an item which can be incremented, but unavailable to decrement.
>>>>>>
>>>>>> 2) new types
>>>>>>      - memcached_db_t
>>>>>>        Some of modular memcached engines support on-disk storage, not only
>>>>>>        volatile ram. The selinux_engine.so allows us to use a certain file
>>>>>>        as a backend storage, but existing policy does not have definition
>>>>>>        of data file type. This type allows memcached_t read/write accesses.
>>>>>>
>>>>>>      - memcached_item_t         (default of unconfined domain)
>>>>>>      - memcached_ro_item_t
>>>>>>      - memcached_secret_item_t
>>>>>>      - user_memcached_item_t    (default of rbac domain)
>>>>>>      - unpriv_memcached_item_t  (default of unprivileged domain)
>>>>>>        These are types of individual key-value items.
>>>>>>        The three default types are read-writable for its domains,
>>>>>>        memcached_ro_item_t is read-only for confined domains, and
>>>>>>        memcached_secret_t is invisible from confined domains.
>>>>>>
>>>>>> 3) supplemental policies
>>>>>>      - This patch also adds permission on memcached_t to communicate with
>>>>>>        SELinux using netlink socket and selinuxfs.
>>>>>>      - This patch also adds permission on memcached_t to write out audit
>>>>>>        logs onto auditd daemon, although it is not implemented yet.
>>>>>>
>>>>>> Thanks, Any comments please.
>>>>>
>>>
>>>
>>
>>
> 
> 


-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
