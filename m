Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2FH0Mxq003551
	for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2007 13:00:22 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2FH0Ge3014244
	for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2007 17:00:17 GMT
Received: by ug-out-1314.google.com with SMTP id y2so451931uge
        for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2007 10:00:07 -0700 (PDT)
Message-ID: <9d1b82480703151000l282f2750l18291dc82be20b1@mail.gmail.com>
Date: Thu, 15 Mar 2007 22:30:06 +0530
From: Pravin <shindepravin@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Getting Security Identifier (SID) for newly created process
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1173807352.2068.104.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <9d1b82480703130901s767720eex709936ac66485cfb@mail.gmail.com>
	 <1173804916.2068.69.camel@moss-spartans.epoch.ncsc.mil>
	 <9d1b82480703131015y38a40d97k148b00e525f85cc2@mail.gmail.com>
	 <1173807352.2068.104.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanx for reply,

> You wouldn't put it directly there, just like we didn't directly put a
> security context on task_struct or inode.  LSM provides a layer of
> indirection via the void* security fields, and you make hook calls from
> your code to allocate, set up, and free the actual security structures.
>
Yes, we are added a security struct in
security/seliux/include/objsec.h named "res_group_security_struct".
and void * security field is res_group structure points to it.
We have also written the hooks to allot and free memory for this
security field in "hooks.c"
We are trying to follow the same structure which is used in task and
other kernel object.

> In the CKRM code, you would just make appropriate calls to LSM hooks and
> then define SELinux hook function implementations that would handle the
> actual setting of SIDs.  For initial objects, you can do it from
> selinux_init(), just as we do for the initial task and keyrings, or you
> can hook your initializer function to call a LSM hook for that purpose
> (as is done e.g. for kernel sockets).
>
> However, in terms of making sure that your approach is correct, I think
> you also need to engage the CKRM developers to see if they think you are
> controlling the right objects and operations based on their knowledge of
> CKRM internals.  I can give general guidance, but I'm no expert on CKRM
> internals.
I have mailed CKRM mailing list also with all details of the hooks
that I am planning to add.
But there was no response from them.
I am planning to mail them again once there is some more progress in work.

> Stephen Smalley
> National Security Agency

I am moving ahead with this work. I will come back to u after some progress.
Thanx.
-- 
 Pravin Shinde

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
