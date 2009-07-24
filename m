Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6OJYURU021354
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 15:34:30 -0400
Received: from mail-bw0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6OJZLPu021382
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 19:35:22 GMT
Received: by bwz7 with SMTP id 7so1565214bwz.18
        for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 12:34:28 -0700 (PDT)
Message-Id: <252265E7-91EA-4421-888D-9397C0031212@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: David Caplan <dac@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E0133D574@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: what is an object manager?!
Date: Fri, 24 Jul 2009 21:34:26 +0200
References: <97B8FB97-31B2-4D18-A69B-7EBA6C745181@gmail.com> <7b740b700907240246l28d05097y500a22e478fa018@mail.gmail.com> <30C6B5E7-49A2-4C0D-8C78-87F267A49862@gmail.com> <1248437971.28321.663.camel@moss-pluto.epoch.ncsc.mil> <01E29F48-459A-442D-91B2-BCFA4FAD177D@gmail.com> <06A6610D4F464D4EBEAFBF2C5F86911E0133D574@exchange2.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David, Stephen && Shaz,

tnx for your answers. It helped me alot.

--
Sebastian Pfaff

> Sebastian,
>
> I think Steve covered it fairly well. The description in the book was
> defining the object managers in a more abstract way; i.e., defining  
> the
> kernel subsystems as object managers. As Steve said, in reality, the
> entire kernel is the object manager for all of the kernel objects
> (files, directories, sockets, etc) because the code is all in kernel
> space. The user space object managers (e.g., X, dbus, sepostgres,  
> etc.)
> are individual object managers in that they all operate in separate
> process space outside of the kernel and enforce decisions on access to
> objects they define.
>
> We didn't mean to say or imply that the LSM hooks were each object
> managers. They are, as Steve said, enforcement points hooked into the
> appropriate kernel subsystems that manage the relevant kernel objects.
> In the book we were trying to strike a balance between abstraction of
> concepts and actual implementation details.
>
> David
>
>> -----Original Message-----
>> From: owner-selinux@tycho.nsa.gov [mailto:owner- 
>> selinux@tycho.nsa.gov]
>> On Behalf Of Sebastian Pfaff
>> Sent: Friday, July 24, 2009 8:59 AM
>> To: Stephen Smalley; selinux@tycho.nsa.gov
>> Subject: Re: what is an object manager?!
>>
>>>>
>>>> ok, you're trying to tell me that a lsm hook is something similar
> to
>>>> what an object manager is in FLASK architecture. But in general,
> all
>>>> LSM hooks as a whole can be considered as one object manager, since
>>>> in
>>>> the monolithic linux kernel there are no different object managers.
>>>
>>> The kernel is the object manager.  The hooks are merely the points
> at
>>> which the kernel/object manager is instrumented to enforce a policy
>>> decision.
>>>
>>
>> k, thank you. I think i got it.
>>
>>>>>
>>>>> Now there is one object manager and libselinux exports an
> interface
>>>>> to the userspace object managers.
>>>>
>>>>> Stephen is referening to FLASK/FLUKE a predecessor of SELinux on
>>>>> micrkernel architecture.
>>>>>
>>>>
>>>> I'm not not sure, if stephen was referreing to FLASK. For me, he
>>>> referred to the current state in linux.
>>>
>>> I think I described both in that paragraph.
>>
>> k
>>
>>>
>>>>> X server is an object manager for its own resources that it
> manages
>>>>> and so is Gconf. Dbus is object manager of its IPC objects. The in
>>>>> kernel security server is the PDP for all while the PEPs are
> kernel
>>>>> object managers and the userspace object manager (some mentioned
>>>>> earlier).
>>>>>
>>>>
>>>> what is PDP und what is PEP(s)?
>>>
>>> Policy decision point, policy enforcement point.  Just another
>>> terminology for the same concepts.
>>
>> tnx
>>
>> --
>> Sebastian Pfaff
>>
>>
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing
>> list.
>> If you no longer wish to subscribe, send mail to
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
