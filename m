Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7EBT0ab032118
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 07:29:00 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7EBU39c029741
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 11:30:03 GMT
Date: Fri, 14 Aug 2009 21:28:57 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stefano Carucci <stecarucci@hotmail.com>
cc: selinux@tycho.nsa.gov
Subject: Re: SElinux protection
In-Reply-To: <SNT115-W6FF8468946D002609BC73C1020@phx.gbl>
Message-ID: <alpine.LRH.2.00.0908142117440.17571@tundra.namei.org>
References: <SNT115-W6FF8468946D002609BC73C1020@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Aug 2009, Stefano Carucci wrote:

> 
> Hello all.
> 
> I would like to pose some questions on the type of attacks that SELinux offers a protection from.
> 
> In particular: 
> 1. What are the type of attacks that are inhibited?

The aim for the general case is to contain software vulnerabilities in 
userland code.  Note that in commonly shipped general purpose policies, 
local login users are not confined by default; the emphasis is on locking 
down network facing services.

> 2. What are those that are not, because not explicitly designed for, and may still affect the system?

As mentioned, local login users are generally not confined by SELinux 
policy in Fedora-based systems, although this is a matter of policy 
design; it's not inherent to SELinux itself.  There are some examples of 
confining local users, such as Kiosk Mode (install the xguest package), 
and work in this area generally is expected to continue.

SELinux operates at the kernel level, so vulnerabilities in the kernel 
itself may reduce or disable the protection of SELinux.  Other mechanisms 
are required to protect the kernel.

> 3. Is there any countermeasure against DoS attacks?

No.

A lot of information on SELinux is available here:
http://selinuxproject.org/page/User_Resources

This is a very brief overview:
http://www.slideshare.net/jamesmorris/lf-japan-08-talk


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
