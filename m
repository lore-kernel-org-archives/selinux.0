Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m88CpLfv024766
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 08:51:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m88CpLGU004852
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 12:51:21 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m88CpJKV007997
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 08:51:19 -0400
Message-ID: <48C51FB1.1040307@redhat.com>
Date: Mon, 08 Sep 2008 08:50:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Targeted Policy" review
References: <48BE3FB4.8020003@redhat.com> <48BE9106.6050703@redhat.com> <48C0D4CD.5090908@redhat.com> <48C13900.8050401@redhat.com> <48C2085C.6020008@redhat.com>
In-Reply-To: <48C2085C.6020008@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray McAllister wrote:
> Daniel J Walsh wrote:
>> Murray McAllister wrote:
>>> Daniel J Walsh wrote:
>>> Murray McAllister wrote:
>>>>>> Hi,
>>>>>>
>>>>>> The following is a draft of the "Targeted Policy" sections for the
>>>>>> SELinux User Guide. Any comments and corrections are appreciated.
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> Targeted Policy
>>>>>>
>>>>>> Targeted policy is the default SELinux policy used in Fedora 10. When
>>>>>> using targeted policy, subjects that are targeted run in their own
>>>>>> domain type, and subjects that are not targeted run in the
>>>>>> unconfined_t
>>> confined domain, and subjects that are not targeted run in an unconfined
>>> domain,  For example logged in users by default log in as unconfined_t
>>> while system processes started by init run in initrc_t.  Both of these
>>> domains are unconfined.
>>>
>>> NOTE:
>>>
>>> Even unconfined domains are subject to executable/writable memory
>>> checks.  execmem, execstack, execheap.  By default processes run as an
>>> unconfined domain can not allocate writeable memory and execute it.
>>> This is a common attack vector call buffer overflow attacks.  Some
>>> applications require this type of access (java, wine, mono and a few
>>> others).
>>>> Does this mean applications running in a Java Virtual Machine, and
>>>> in Wine?
>>>> I'll change my response below based on the answer to this.
>> Yes
>>>> These applications need to be labeled correctly to allow the
>>> access.  There are booleans that can turn off this protection for the
>>> unconfined user unconfined_t.  allow_execmem, allow_execstack,
>>> allow_execheap.
>>>
>>> You can turn the booleans on using setsebool
>>>
>>> setsebool -P allow_execmem 1
>>>
>>>> I will use these examples later on.
>>>
>>>> How about:
>>>> Targeted policy is the default SELinux policy used in Fedora 10. When
>>>> using targeted policy, subjects that are targeted run in a confined
>>>> domain, and subjects that are not targeted run in an unconfined domain.
>>>> For example, by default, logged in users run in the unconfined_t
>>>> domain,
>>>> and system processes started by init run in the initrc_t domain - both
>>>> of these domains are unconfined.
>>>> Unconfined domains (as well as confined domains) are subject to
>>>> executable and writeable memory checks. By default, subjects running in
>>>> an unconfined domain can not allocate writeable memory and execute it.
>>>> [I think I changed the meaning. Is it still correct? ]
>> Looks good
>>>> This reduces vulnerability to buffer overflow attacks. Some subjects
>>>> require this access, including but not limited to Java", Wine and Mono.
>>>> To allow this access, these subjects must be labeled correctly.
>>
>> For example, if you had a java application /usr/local/bin/myjavaapp,
>> that was not working because it needed the execmem access, you could
>> change the system labeling.
>> # semanage fcontext -a -t java_exec_t /usr/local/bin/myjavaapp
>> Then you fix the context on the actual file
>> # restorecon /usr/local/bin/myjavaapp
>>
>> myjavaapp will now be allowed to run with execmem and execstack.
>>
>> If you do not want to deal with any of the memory checks for users, you
>> can disable them with by setting the allow_exec* booleans.
>>
>> # setsebool -P allow_execmem=1 allow_execstack=1 allow_execheap=1
>> You can check if the booleans current state by executing
>>
>> getsebool -a | grep allow_exec
>>
>> You system is most protected if these booleans are turned off.
>>
>> # setsebool -P allow_execmem=0 allow_execstack=0 allow_execheap=0
>>
>>>> memory checks need to be disabled for the users running in the
>>>> unconfined_t domain. 
>> No this sentence is wrong.
>> These memory checks are disable by setting
>>>> booleans, which allow the SELinux policy to be modified during runtime.
>>>> Configuring booleans is discussed later.
>>>
> 
> I removed some bits to avoid too much theory:
> 
> Unconfined domains (as well as confined domains) are subject to
> executable and writeable memory checks. By default, subjects running in
> an unconfined domain can not allocate writeable memory and execute it.
> This reduces vulnerability to buffer overflow attacks. These memory
> checks are disable by setting booleans, which allow the SELinux policy
> to be modified during runtime. Configuring booleans is discussed later.
> 
>>>> How about:
>>>> When an unconfined subject is comprised, SELinux does not prevent the
>>>> attacker from gaining access to system resources and data, and DAC
>>>> rules
>>>> are used.
>>>> (I should probably change these to "If an...")
>> If an unconfined subject is comprised, SELinux does not prevent the
>> attacker from gaining access to system resources and data, of course DAC
>> rules are used.
>>
>> Note: A common misconception about SELinux is that it replaces DAC
>> Controls, when it really just augments them.
> 
> How about:
> 
> If an unconfined subject is compromised, SELinux does not prevent the
> attacker from gaining access to system resources and data, but of
> course, DAC rules are still used. SELinux is a security enhancement on
> top of DAC rules - it does not replace them.
Looks good.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
