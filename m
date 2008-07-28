Message-ID: <488D37A3.9060307@ak.jp.nec.com>
Date: Mon, 28 Jul 2008 12:06:11 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <stephen.smalley@gmail.com>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
        paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com>	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>	 <4889CC5F.3030500@ak.jp.nec.com>  <4889CF30.2060306@ak.jp.nec.com>	 <1216993463.11948.22.camel@sulphur>  <488AD868.9050507@kaigai.gr.jp> <1217093311.3223.1.camel@sulphur> <488B6972.4020003@tresys.com>
In-Reply-To: <488B6972.4020003@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Sat, 2008-07-26 at 16:55 +0900, KaiGai Kohei wrote:
>>> Stephen Smalley wrote:
>>>> On Fri, 2008-07-25 at 22:03 +0900, KaiGai Kohei wrote:
>>>>> [1/3] thread-context-kernel.1.patch
>>>>>   This patch enables to assign a thread a "weaker" hierarchical domain,
>>>>>   only if the destinated domain is a child of the current domain.
>>>>>   Hierachy relationships are defined in the policy version 24.
>>>>>   This patch also enables to read the new version of policy.
>>>> If you are going to take type hierarchy support into the kernel, then it
>>>> seems like it should be completely taken into the kernel, i.e. the
>>>> hierarchy checking should be applied by the kernel rather than by the
>>>> toolchain.  That is what the Flask security server did for its
>>>> extensible policy mechanism.
>>> When the checks are applied in the kernel?
>>> One candidate is policy loading time, and the other is AVC entry creation
>>> time. I prefers the later one, because checks in policy loading time will
>>> require the expensive checks in kernel space.
>>>
>>> In my idea, violated permission bits on AVC entries are masked by ones of
>>> its parent types, with/without printing logs.
>>> Now hierarchy/neverallow constraint makes abort whole of policy loading.
>>> It can be a significant difference.
>> Yes, it makes sense to apply the hierarchy restrictions at computation
>> time.  Neverallows are a bit different though - we want those to flag
>> bugs in policy.  Thus, we likely should leave neverallow checking in the
>> userland toolchain.

OK, it seems to me a reasonable approach that the userland toolchain also
checks neverallow constraints.
What is a proper way to notice violations in neverallow constraint?
I think audit messages are candidate. When user receives violation messages,
he can check his policy with expand-check=1 for more detailed infomation.

> So you want to deny at runtime based on the hierarchy? Won't that create
 > another confusing way SELinux can deny something without any clue why
 > (aside from running the denial through audit2why)?

Yes, I think the hierarchy constraints are applied on the creation of AVC entries
at runtime. If violated, masked permissions and attributes should be noticed to
userspace via audit messages.

 > Further, this is something we can understand and reject ahead of time, I don't
 > know why it makes sense to wait until later when we can tell now that something
 > is wrong with the policy.

We can also apply these checks at policy module linking time, if configured.
However, it is currently skipped in the default due to its expensiveness, isn't it?
Could you consider the runtime checks give us a hint/change to enabls checks in
the userland toolchain for more detailed information?

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
