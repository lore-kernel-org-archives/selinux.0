Message-ID: <49D034B9.9080406@ak.jp.nec.com>
Date: Mon, 30 Mar 2009 11:55:53 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: method@manicmethod.com, jmorris@namei.org, selinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Permissive domain in userspace (Re: Some ideas in SE-PostgreSQL
 enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CB3CEB.1070505@ak.jp.nec.com> <49CD8E68.9090004@tycho.nsa.gov>
In-Reply-To: <49CD8E68.9090004@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> KaiGai Kohei wrote:
>> KaiGai Kohei wrote:
>>   
>>> 4. Permissive domain in userspace
>>>
>>> It is an issue got sleep for a few months.
>>>   http://marc.info/?l=selinux&m=122337314619667&w=2
>>>     
>> It was discussed at the past a bit, but left it for several months.
>>
>> Now we have a new idea of permissive domain which allows certain
>> domains to work as if being in permissive mode.
>> The in-kernel SELinux can handle it well, but userspace object
>> managers could not handler it because we don't have an interface
>> to tell what domain is permissive.
>>
>> The attached patches are for the kernel and libselinux.
>>
>> The kernel patch adds a flags field on av_decision, and returns
>> it as the sixth parameter on the reply of /selinux/access.
>>
>> The libselinux patch enhance libselinux to understand it, and
>> two new interfaces are added.
>>  - security_compute_av_flags()
>>  - security_compute_av_flags_raw()
>> It also adds a new flags field on av_decision, but it is not
>> touched when we use the existing interfaces due to the binary
>> compatibility.
>>
>> The standard userspace avc uses _flags interface, instead of
>> existing one, so it enables to control permissive domain.
>>
>> IIRC, Eamon pointed out that it is preferable to put a new field
>> of 'permissive' than general purpose 'flags'. But it will require
>> interface changes, if we need more state in the future.
>> So, I don't change the implementation.
>>
>> Please comment anything.
>>
>> Thanks,
>>   
> 
> Don't have any immediate issues with the libselinux patches. Will wait
> on kernel acceptance.
> 
> Some general questions:
> 
> When the userspace AVC is configured in "enforcing" mode, which
> overrides the kernel setting, how should permissive domains be treated?

>From an analogy of the kernel, the object manager (kernel) allows
the permissive domains to override security policy setting, even if
it is configured as "enforcing mode".
I think the object manager (X, DBMS) should also allow the permissive
domains to override their access controls, because of symmetry.

> When the entire system is in permissive mode, should the permissive flag
> be returned as true for all domains?

I don't think it is correct manner, because the permissive flag shows
the domain (subject context) is configured as permissive domain, not
the global system state.

> /me wonders how long it will be before someone proposes permissive
> classes, or permissions ("permissive permissions"). Or marking
> individual tsid,ssid,tclass tuples as permissive. Just think of the
> problems we could solve.

This patch marks the permissive flag for an individual pair of tsid,
ssid and tclass in the result, but its value is determined by only
the property of tsid.

I don't think we have to hold the flag with the pair of them, but
it is worthfull from the viewpoint of implementation.
In the kernel, the avc_has_perm_noaudit() calls security_permissive_sid()
which aquires "policy_rwlock" to check permissive domain. The lock
operatins need unchached memory operatins, so heavy iteration of locks
(even if it is reader lock) on SMP system hits performance.
If an avc entry has the flag, we can check whether the given domain
is permissive or not, without "policy_rwlock".

If we have an entry something like "/selinux/permissive" to return
whether the given domain is permissive or not, I think we don't need
to have the flags field on security_compute_av(). It can be checked
on the creation of userspace avc entry, and checked it on later access
controls.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
