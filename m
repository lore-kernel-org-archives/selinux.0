Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97KUqWt014661
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 16:30:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97KUo7f021651
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 20:30:51 GMT
Date: Tue, 7 Oct 2003 16:31:04 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Vikram K <vikramatiitkdotacdotin@yahoo.com>, <selinux@tycho.nsa.gov>
Subject: Re: A few clarifications - SID, Precondition functions
In-Reply-To: <1065555072.3919.292.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.44.0310071614220.6227-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7 Oct 2003, Stephen Smalley wrote:

> On Tue, 2003-10-07 at 13:28, Vikram K wrote:

> > 1. The need for having a SID ( instead of having a
> > struct context* ) in
> > each of the *_security_struct structures. (* = task,
> > inode, etc.) As we
> > see it, the SID is just a means of referring to the
> > corresponding context
> > structure and seems to have no other utility.
> 
> You might want to read the Flask architecture paper available
> from http://www.nsa.gov/selinux/background.html to understand the
> original motivation for SIDs.  However, I'll grant that the elimination
> of SIDs from the userspace API makes them a less useful abstraction, so
> it might be reasonable to investigate replacing them with direct
> references to context structures (while continuing to keep the structure
> definition private to the security server to encapsulate the policy).

It's not clear to me that there would be any e.g. performance advantage
from doing this.  There is a potential to eliminate sidtab lookups,
although these are generally cached via the AVC and do not significantly 
impact on performance.

It would be a major job to remove SIDs from the kernel code, and given the
risk of introducing bugs, there would need to be strong justification for 
this kind of change.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
