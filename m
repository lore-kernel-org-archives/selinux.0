Message-Id: <01E29F48-459A-442D-91B2-BCFA4FAD177D@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1248437971.28321.663.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: what is an object manager?!
Date: Fri, 24 Jul 2009 14:59:24 +0200
References: <97B8FB97-31B2-4D18-A69B-7EBA6C745181@gmail.com> <7b740b700907240246l28d05097y500a22e478fa018@mail.gmail.com> <30C6B5E7-49A2-4C0D-8C78-87F267A49862@gmail.com> <1248437971.28321.663.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>
>> ok, you're trying to tell me that a lsm hook is something similar to
>> what an object manager is in FLASK architecture. But in general, all
>> LSM hooks as a whole can be considered as one object manager, since  
>> in
>> the monolithic linux kernel there are no different object managers.
>
> The kernel is the object manager.  The hooks are merely the points at
> which the kernel/object manager is instrumented to enforce a policy
> decision.
>

k, thank you. I think i got it.

>>>
>>> Now there is one object manager and libselinux exports an interface
>>> to the userspace object managers.
>>
>>> Stephen is referening to FLASK/FLUKE a predecessor of SELinux on
>>> micrkernel architecture.
>>>
>>
>> I'm not not sure, if stephen was referreing to FLASK. For me, he
>> referred to the current state in linux.
>
> I think I described both in that paragraph.

k

>
>>> X server is an object manager for its own resources that it manages
>>> and so is Gconf. Dbus is object manager of its IPC objects. The in
>>> kernel security server is the PDP for all while the PEPs are kernel
>>> object managers and the userspace object manager (some mentioned
>>> earlier).
>>>
>>
>> what is PDP und what is PEP(s)?
>
> Policy decision point, policy enforcement point.  Just another
> terminology for the same concepts.

tnx

--
Sebastian Pfaff




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
