Message-ID: <4892AC81.3090607@ak.jp.nec.com>
Date: Fri, 01 Aug 2008 15:26:09 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>, jmorris@namei.org,
        paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com>	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>	 <4889CC5F.3030500@ak.jp.nec.com>  <4889CF30.2060306@ak.jp.nec.com>	 <1216993463.11948.22.camel@sulphur>  <488AD868.9050507@kaigai.gr.jp>	 <1217093311.3223.1.camel@sulphur>  <488B6972.4020003@tresys.com>	 <1217266316.20373.53.camel@moss-spartans.epoch.ncsc.mil>	 <488EBDE8.2050106@ak.jp.nec.com> <1217333164.20373.154.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217333164.20373.154.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> I have measured a performance to check hierarchy/neverallow constraint
>> with patched libsepol as a trial. Unfortunatelly, about 80% of CPU time
>> is consumed by check_assertions() for neverallows.
>>
>> [root@saba ~]# time -p semodule -r kaigai
>> hierarchy_check_constraints: 37.32 [s]
>> check_assertions: 139.05 [s]
>> real 205.32
>> user 198.06
>> sys 3.75
>>
>> These checks at policy load time gives us negative effect in system
>> bootup time, unless remarkable improvements. So, I prefer lazy dynamic
>> checking approach.
>>
>> (*) System bootup time is one of the major topics for embedded Linux folks.
> 
> Ok.  I'd be interested in seeing that libsepol patch nonetheless, and we
> may want to retain full checking there as an option for validation at
> policy build time (via make validate) while introducing lazy dynamic
> checking in the kernel.

I tries to run semodule with patched libsepol to deliver NEVERALLOW rules
into kernel space, however, it cost was extremely expensive and unacceptable.

Some of NEVERALLOWs covers wide range of types, like:
    neverallow ~{ domain unlabeled_t } *:process *;

It is finally translated massive amount of avtab structure, and it makes
grow the size of security policy. In my estimation, the above single NEVERALLOW
constraint makes about 4,000,000 of avtab and it will consume 48Mb of additional
memory and storage for nonsense purpose in most cases.

So, I reconsidered the feature to check NEVERALLOW should not be ported into
kernelspace.


(*) I killed semodule due to its long processes...
[root@saba libsepol]# ls -lh /etc/selinux/targeted/modules/tmp/policy.kern
-rw-r--r-- 1 root root 29M 2008-08-01 15:08 /etc/selinux/targeted/modules/tmp/policy.kern
                       ^^^
[root@saba libsepol]# ls -lh /etc/selinux/targeted/policy/
total 11M
-rw-r--r-- 1 root root 3.4M 2008-04-03 15:19 policy.22
-rw-r--r-- 1 root root 3.7M 2008-07-22 19:27 policy.23
-rw-r--r-- 1 root root 3.7M 2008-08-01 13:45 policy.24

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
