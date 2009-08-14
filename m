Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7ECeECY011942
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 08:40:14 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7ECdiCQ021621
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 12:39:44 GMT
Date: Fri, 14 Aug 2009 22:40:12 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stefano Carucci <stecarucci@hotmail.com>
cc: selinux@tycho.nsa.gov
Subject: RE: SElinux protection
In-Reply-To: <SNT115-W34F722C08C53D234FB37CEC1020@phx.gbl>
Message-ID: <alpine.LRH.2.00.0908142229560.18040@tundra.namei.org>
References: <SNT115-W6FF8468946D002609BC73C1020@phx.gbl> <alpine.LRH.2.00.0908142117440.17571@tundra.namei.org> <SNT115-W34F722C08C53D234FB37CEC1020@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Aug 2009, Stefano Carucci wrote:

> 
> 
> Two further questions:
> 
> 1. Does SELinux provide any countermeasure against buffer overflows attacks? 

Here's some information on memory protection checks which may be 
controlled via SELinux policy:

http://people.redhat.com/drepper/selinux-mem.html


> 2. I read about the possibility of keeping processes from forking. 
> Wouldn't you consider this as a protection from DoS attacks?

That could be effective in this case (as would resource limits), but 
SELinux is not generally designed to counteract DoS attacks.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
