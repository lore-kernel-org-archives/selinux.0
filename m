Message-ID: <488EBDE8.2050106@ak.jp.nec.com>
Date: Tue, 29 Jul 2008 15:51:20 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>, jmorris@namei.org,
        paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com>	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>	 <4889CC5F.3030500@ak.jp.nec.com>  <4889CF30.2060306@ak.jp.nec.com>	 <1216993463.11948.22.camel@sulphur>  <488AD868.9050507@kaigai.gr.jp>	 <1217093311.3223.1.camel@sulphur>  <488B6972.4020003@tresys.com> <1217266316.20373.53.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217266316.20373.53.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Sat, 2008-07-26 at 14:14 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Sat, 2008-07-26 at 16:55 +0900, KaiGai Kohei wrote:
>>>> Stephen Smalley wrote:
>>>>> On Fri, 2008-07-25 at 22:03 +0900, KaiGai Kohei wrote:
>>>>>> [1/3] thread-context-kernel.1.patch
>>>>>>   This patch enables to assign a thread a "weaker" hierarchical domain,
>>>>>>   only if the destinated domain is a child of the current domain.
>>>>>>   Hierachy relationships are defined in the policy version 24.
>>>>>>   This patch also enables to read the new version of policy.
>>>>> If you are going to take type hierarchy support into the kernel, then it
>>>>> seems like it should be completely taken into the kernel, i.e. the
>>>>> hierarchy checking should be applied by the kernel rather than by the
>>>>> toolchain.  That is what the Flask security server did for its
>>>>> extensible policy mechanism.
>>>> When the checks are applied in the kernel?
>>>> One candidate is policy loading time, and the other is AVC entry creation
>>>> time. I prefers the later one, because checks in policy loading time will
>>>> require the expensive checks in kernel space.
>>>>
>>>> In my idea, violated permission bits on AVC entries are masked by ones of
>>>> its parent types, with/without printing logs.
>>>> Now hierarchy/neverallow constraint makes abort whole of policy loading.
>>>> It can be a significant difference.
>>> Yes, it makes sense to apply the hierarchy restrictions at computation
>>> time.  Neverallows are a bit different though - we want those to flag
>>> bugs in policy.  Thus, we likely should leave neverallow checking in the
>>> userland toolchain.
>>>
>> So you want to deny at runtime based on the hierarchy? Won't that
>> create another confusing way SELinux can deny something without any
>> clue why (aside from running the denial through audit2why)? Further,
>> this is something we can understand and reject ahead of time, I don't
>> know why it makes sense to wait until later when we can tell now that
>> something is wrong with the policy.
> 
> True.  On the other hand, if we are going to make the hierarchy visible
> to the kernel so that it can directly leverage information from it, then
> it makes sense to let the kernel directly enforce the relationships,
> whether that happens at policy load time or at compute_av time.
> 
> If we can make the checking happen entirely at policy load time in a
> manner that isn't too expensive, then that is cleaner, I agree.  If not,
> then lazy dynamic checking by the kernel and optional full static
> checking by the toolchain may be a compromise.

I guess we can reduce cost to check hierarchy constraint, because all
we have to do is to scan/check avtabs of related types and ebitmaps
of type_attr_maps.
However, I don't have a good idea to boost neverallow constraint so
much due to its flexibility. :(

I have measured a performance to check hierarchy/neverallow constraint
with patched libsepol as a trial. Unfortunatelly, about 80% of CPU time
is consumed by check_assertions() for neverallows.

[root@saba ~]# time -p semodule -r kaigai
hierarchy_check_constraints: 37.32 [s]
check_assertions: 139.05 [s]
real 205.32
user 198.06
sys 3.75

These checks at policy load time gives us negative effect in system
bootup time, unless remarkable improvements. So, I prefer lazy dynamic
checking approach.

(*) System bootup time is one of the major topics for embedded Linux folks.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
