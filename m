Subject: Re: threads
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1072454081.827.103.camel@cube>
References: <1072454081.827.103.camel@cube>
Content-Type: text/plain
Message-Id: <1072712224.845.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 29 Dec 2003 10:37:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-26 at 10:54, Albert Cahalan wrote:
> Normal Linux security data (uid, capability bits)
> is per-thread. There are at least two reasons for
> this:
> 
> 1. Multi-threaded server daemons can rely on
>    kernel-enforced security.
> 
> 2. Race conditions are eliminated without locking.
>    This deals with the problem of two threads
>    simultaneously updating the security data, or
>    one thread updating while another thread uses.
> 
> I'm told that SE Linux enforces shared security
> data. I suppose this is mostly required when
> implementing a mandatory system. Is this race-free?
> Is there a capability that would allow a suitably
> privileged process to have per-thread contexts?

For MAC, per-thread contexts make little sense since you cannot enforce
any separation of the memory.

> Also, I'm told that a security context can only
> change during exec. WHAT???? Besides the case of
> a suitably privileged process, what about the
> need to move some sort of watermark? AFAIK, your
> security context needs to be tainted when you
> read low-integrity data and so on.

Limiting security context transitions to execve allows the inheritance
of state between the contexts and the initialization of the process in
the new security context to be precisely controlled, including the
particular entrypoint program used to enter the new context. A
setuid(2)-like call for contexts would lack such controls and would
provide no real separation between the two contexts. Introducing such an
operation into the system would yield two different sets of controls and
behaviors for context transitions.
The omission of such an operation from SELinux was noted in the original
design documentation, and has been discussed on the list before.

With regard to "tainting", you are thinking about it the wrong way.  A
high integrity process shouldn't be allowed to read low integrity data
(if that is your security goal), not magically migrated to a low
integrity label upon performing such a read.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
