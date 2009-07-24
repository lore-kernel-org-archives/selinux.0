Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6OC6aoL010835
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 08:06:36 -0400
Received: from mail-fx0-f215.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6OC7PAm015428
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 12:07:26 GMT
Received: by fxm11 with SMTP id 11so1442358fxm.18
        for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 05:06:34 -0700 (PDT)
Message-Id: <30C6B5E7-49A2-4C0D-8C78-87F267A49862@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <7b740b700907240246l28d05097y500a22e478fa018@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: what is an object manager?!
Date: Fri, 24 Jul 2009 14:06:32 +0200
References: <97B8FB97-31B2-4D18-A69B-7EBA6C745181@gmail.com> <7b740b700907240246l28d05097y500a22e478fa018@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tnx for answer,

ok, you're trying to tell me that a lsm hook is something similar to  
what an object manager is in FLASK architecture. But in general, all  
LSM hooks as a whole can be considered as one object manager, since in  
the monolithic linux kernel there are no different object managers.

>
> Now there is one object manager and libselinux exports an interface  
> to the userspace object managers.

> Stephen is referening to FLASK/FLUKE a predecessor of SELinux on  
> micrkernel architecture.
>

I'm not not sure, if stephen was referreing to FLASK. For me, he  
referred to the current state in linux.

> X server is an object manager for its own resources that it manages  
> and so is Gconf. Dbus is object manager of its IPC objects. The in  
> kernel security server is the PDP for all while the PEPs are kernel  
> object managers and the userspace object manager (some mentioned  
> earlier).
>

what is PDP und what is PEP(s)?

> I hope these examples will clear things.

me too ;)

--
Sebastian Pfaff



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
