MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: How to configure and reload selinux policy
Date: Fri, 22 Sep 2006 09:28:13 +0800
Message-ID: <117E3EB5059E4E48ADFF2822933287A40176C6BF@pdsmsx404.ccr.corp.intel.com>
From: "Jin, Yihua" <yihua.jin@intel.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>-----Original Message-----
>From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
>Sent: 2006Äê9ÔÂ21ÈÕ 21:22
>To: Jin, Yihua
>Cc: SELinux@tycho.nsa.gov
>Subject: Re: How to configure and reload selinux policy
>
>On Thu, 2006-09-21 at 16:59 +0800, Jin, Yihua wrote:
>> I used targeted policy 1.17 in RHEL4U4
>>
>> Modify the domain/unconfined_t, added:
>>
>> Bool allow_execmem false;
>>
>> If ( allow_execmem ) {
>>
>>          Allow domain self :process execmem;
>>
>> }
>>
>> Than I type make reload to load this modified policy, but I find exec
>> memory is still allowed by system.
>>
>> That is, I check avc_has_perm and it allowed this operation.
>
>Booleans are runtime options.  The value above is just the initial
>value.  When you reload the policy on the running system, the boolean
>states are preserved, so if allow_execmem was true before, then it would
>stay true until you `setsebool allow_execmem 0`.  In addition, you don't
>need to rebuild the policy to alter the initial value of the booleans,
>you can edit the /etc/selinux/targeted/booleans file.  The values in
>this file will be set when the policy is loaded the first time by init.
>

This policy has no Boolean allow_execmem defined initially and I add this Boolean switch. after reload, this Boolean appears in /selinux/Booleans, but not in /etc/selinux/targeted/booleans file, I don't know what is the relationship between these two locations 
Actually, what I want to know is how to make a modified policy take effect.


>On a side note, I don't think the RHEL4 kernels have execmem checking,
>so this rule has no effect.

For this problem, I've update kernel to 2.6.11.7 and confirm the kernel has such check.


>Chris PeBenito
>Tresys Technology, LLC
>(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
