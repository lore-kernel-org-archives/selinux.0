Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA9NFVIi026572
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 18:15:31 -0500 (EST)
Received: from rwcrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA9NE7xp024319
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 23:14:08 GMT
Message-ID: <41914F8B.3060102@tresys.com>
Date: Tue, 09 Nov 2004 18:15:23 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [RFC][PATCH] Control ability to have a writable executable mapping
References: <1100025603.408.203.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1100025603.408.203.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>I know that the PAX/selinux integration patch approaches this
>differently, applying a check based on the executable file type rather
>than the process domain, but I would favor a domain-based check for its
>greater generality (ability to handle multiple instances of the same
>program in different ways) and more direct representation of the actual
>operation (can this process perform this action?).  Admittedly, the
>domain-based check does impose a cost on policy writers - you have to
>define separate domains vs. just separate file types in order to
>selectively allow this permission.  But I believe that this cost is
>justified.
>  
>
I can't think of any circumstances where the domain which an application 
is in should have an impact on it's PaX flags.
In general we want whatever defaults (pageexec, mprotect, randmmap) on 
all the time except in cases where one or more of those flags don't work 
(eg, java doesn't like pageexec, nor does mono). The caller domain makes 
no difference in whether those will or will not function with PaX 
protection, nor should it make a difference in whether those are enabled.

That said, I know the current implementation breaks the current domain 
source, target object type model, and it would be better to make it the 
same for no better reason than consistancy.

On the other hand, you are right, it does impose a higher cost on policy 
writing. However, it isn't clear that SELinux facilitates this sort of 
flag setting via permissions well, since SELinux will deny by default 
all the flags would be off (!) which is less secure.

>Please note that this patch does NOT provide the functionality of PAX,
>exec-shield, NX support, etc.  It merely provides SELinux policy control
>over the ability to create an executable mapping that can contain data
>not covered by file permission checks.
>
>  
>
out of curiousity, is revocation handled?

>Constructive comments welcome.
>
>  
>
It seems like the whole purpose of this is to enforce a consistancy 
between filesystem permissions and mmaped files in memory?
Does this fall into the same category as PaX where denying the flag 
actually causes a less secure default?


Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
