Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2DHFv1o028651
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 13:15:57 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2DHFt4b024427
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 17:15:55 GMT
Received: by nf-out-0910.google.com with SMTP id n15so2654739nfc
        for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 10:15:54 -0700 (PDT)
Message-ID: <9d1b82480703131015y38a40d97k148b00e525f85cc2@mail.gmail.com>
Date: Tue, 13 Mar 2007 22:45:53 +0530
From: Pravin <shindepravin@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Getting Security Identifier (SID) for newly created process
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1173804916.2068.69.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <9d1b82480703130901s767720eex709936ac66485cfb@mail.gmail.com>
	 <1173804916.2068.69.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,

> But this is all internal to SELinux; you should not be calling any of
> those functions from outside of SELinux directly.  Some SELinux
> functions are exported to the rest of the kernel via
> include/linux/selinux.h.  Some SELinux functions are exported to
> userspace via selinuxfs.
>
> Why do you ask?
>

I dont know if u remember, But I was working on CKRM and SELinux integration.
I also sent u a mail regarding my plans of adding hooks inside
configfs, so that
we can get better access control by using SELinux ACL's.

Please refer that mail with "SELinux and CKRM integration" for details
of my plan about where in CKRM i am planning to add these hooks. If u
want, I can resend it again.

As part of those hooks, I also need to add security context to
"res_group" data structure  (struct res_group) used by CKRM.
This is required because SELinux need's to take decision like
"Can process A create resource group B" and for that SELinux should be
able to addrss "resource group B". This is why I need that security
context in "struct res_group".


Here I am stuck about how to give initial SID's to these initial "res_group",
and how to give SID's to any newly created res_group.

It will be great, If I can get some help here.

> --
> Stephen Smalley
> National Security Agency
>
>

Thanx for reply.
-- 
 Pravin Shinde

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
