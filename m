Message-ID: <48E3D604.6060409@manicmethod.com>
Date: Wed, 01 Oct 2008 15:56:52 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Stephen Smalley <sds@tycho.nsa.gov>,
        jmorris@namei.org, paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] Thread/Child-Domain Assignment (rev.6)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB6F.6080709@ak.jp.nec.com> <48B2A66D.7030608@ak.jp.nec.com> <48B6C966.7040006@tresys.com> <48B756C4.2090909@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3510@exchange2.columbia.tresys.com> <48BB8B1E.7010208@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3609@exchange2.columbia.tresys.com> <48BC141F.2060802@kaigai.gr.jp> <48C5D9A7.7090909@ak.jp.nec.com> <48CAB248.6060701@tresys.com> <48CAF936.1090009@kaigai.gr.jp> <48E2310D.1080101@manicmethod.com> <48E32C7E.7020800@ak.jp.nec.com>
In-Reply-To: <48E32C7E.7020800@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Joshua Brindle wrote:
>> KaiGai Kohei wrote:
>>> Joshua Brindle wrote:
>>>> KaiGai Kohei wrote:
>>>>> The attached patch for libsepol add suport for a new policy version
>>>>> named as (MOD_)POLICYDB_VERSION_BOUNDARY.
>>>>> Userspace hierarchy checks are reworked in this revision.
>>>>>
>> I'm seeing a couple problems. First when writing out the policy
>> it doesn't seem to respect policyvers, I told it to generate
>> a version 23 and it still made a 24.
> 
> Are you saying a configuration of "policy-version = 23" at semanage.conf
> is ignored? I could not reproduce it in my environment.
> Could you tell me the steps to reproduce it?
> 
> I injected several printf()'s, but it shows a proper policyvers
> which reflects semanage.conf correctly.
> 
>> Second it is failing to downgrade the 24 to 23 since my kernel doesn't support 24.
> 

Err, ok. I'm getting inconsistent results now:

[root@misterfreeze policy]# semodule -B
SELinux:  Could not load policy file /etc/selinux/targeted/policy/policy.23:  Invalid argument
/usr/sbin/load_policy:  Can't load policy:  Invalid argument
libsemanage.semanage_reload_policy: load_policy returned error code 2.

I'm not sure what is causing it but it is a different problem than I had before, I'll investigate and see what is going on.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
