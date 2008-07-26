Message-ID: <488AD868.9050507@kaigai.gr.jp>
Date: Sat, 26 Jul 2008 16:55:20 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com>	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>	 <4889CC5F.3030500@ak.jp.nec.com>  <4889CF30.2060306@ak.jp.nec.com> <1216993463.11948.22.camel@sulphur>
In-Reply-To: <1216993463.11948.22.camel@sulphur>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-07-25 at 22:03 +0900, KaiGai Kohei wrote:
>> [1/3] thread-context-kernel.1.patch
>>   This patch enables to assign a thread a "weaker" hierarchical domain,
>>   only if the destinated domain is a child of the current domain.
>>   Hierachy relationships are defined in the policy version 24.
>>   This patch also enables to read the new version of policy.
> 
> If you are going to take type hierarchy support into the kernel, then it
> seems like it should be completely taken into the kernel, i.e. the
> hierarchy checking should be applied by the kernel rather than by the
> toolchain.  That is what the Flask security server did for its
> extensible policy mechanism.

When the checks are applied in the kernel?
One candidate is policy loading time, and the other is AVC entry creation
time. I prefers the later one, because checks in policy loading time will
require the expensive checks in kernel space.

In my idea, violated permission bits on AVC entries are masked by ones of
its parent types, with/without printing logs.
Now hierarchy/neverallow constraint makes abort whole of policy loading.
It can be a significant difference.

> And I think both the neverallow checking and the type hierarchy checking
> needs to move away from needing to do a full expansion in order to
> check; it is just too expensive these days.

I agree. expand-check=1 makes slow downed so much. :(
It should be done on-demand.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
