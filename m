Subject: Re: threads
From: Albert Cahalan <albert@users.sourceforge.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Albert Cahalan <albert@users.sourceforge.net>, SELinux@tycho.nsa.gov
In-Reply-To: <1072712224.845.66.camel@moss-spartans.epoch.ncsc.mil>
References: <1072454081.827.103.camel@cube>
	 <1072712224.845.66.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1074647474.953.40407.camel@cube>
Mime-Version: 1.0
Date: 20 Jan 2004 20:11:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-29 at 10:37, Stephen Smalley wrote:
> On Fri, 2003-12-26 at 10:54, Albert Cahalan wrote:
> > Normal Linux security data (uid, capability bits)
> > is per-thread. There are at least two reasons for
> > this:
> > 
> > 1. Multi-threaded server daemons can rely on
> >    kernel-enforced security.
> > 
> > 2. Race conditions are eliminated without locking.
> >    This deals with the problem of two threads
> >    simultaneously updating the security data, or
> >    one thread updating while another thread uses.
> > 
> > I'm told that SE Linux enforces shared security
> > data. I suppose this is mostly required when
> > implementing a mandatory system. Is this race-free?
> > Is there a capability that would allow a suitably
> > privileged process to have per-thread contexts?
> 
> For MAC, per-thread contexts make little sense
> since you cannot enforce any separation of the memory.

This is not quite right. A server daemon using
per-thread contexts is clearly within your trusted
computing base, just as the kernel is. This can
improve security over the obvious alternative of
having the server run in a context that can do
anything.

> > Also, I'm told that a security context can only
> > change during exec. WHAT???? Besides the case of
> > a suitably privileged process, what about the
> > need to move some sort of watermark? AFAIK, your
> > security context needs to be tainted when you
> > read low-integrity data and so on.
> 
> Limiting security context transitions to execve allows the inheritance
> of state between the contexts and the initialization of the process in
> the new security context to be precisely controlled, including the
> particular entrypoint program used to enter the new context. A
> setuid(2)-like call for contexts would lack such controls and would
> provide no real separation between the two contexts. Introducing such an
> operation into the system would yield two different sets of controls and
> behaviors for context transitions.
> The omission of such an operation from SELinux was noted in the original
> design documentation, and has been discussed on the list before.

I was assuming you wouldn't hand out such
privilige willy-nilly.


> With regard to "tainting", you are thinking about it the wrong way.  A
> high integrity process shouldn't be allowed to read low integrity data
> (if that is your security goal), not magically migrated to a low
> integrity label upon performing such a read.

Isn't this the way LOMAC works?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
