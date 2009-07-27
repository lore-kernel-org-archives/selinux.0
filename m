MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: what is an object manager?!
Date: Mon, 27 Jul 2009 09:58:02 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E0133D678@exchange2.columbia.tresys.com>
In-Reply-To: <1248436074.28321.646.camel@moss-pluto.epoch.ncsc.mil>
References: <97B8FB97-31B2-4D18-A69B-7EBA6C745181@gmail.com> <1248436074.28321.646.camel@moss-pluto.epoch.ncsc.mil>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Sebastian Pfaff" <sebastian.pfaff@gmail.com>
Cc: <selinux@tycho.nsa.gov>, "David Caplan" <dac@tresys.com>,
        "Frank L. Mayer" <mayerf@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On
> Behalf Of Stephen Smalley
> Sent: Friday, July 24, 2009 7:48 AM
> To: Sebastian Pfaff
> Cc: selinux@tycho.nsa.gov
> Subject: Re: what is an object manager?!
> 
> On Fri, 2009-07-24 at 10:18 +0200, Sebastian Pfaff wrote:
> > hello,
> >
> > "Object managers are responsible for enforcing the policy decisions
of
> > the security server for the set
> > of resources they manage. For the kernel, you can think of object
> > managers as kernel subsystems that
> > create and manage kernel-level objects. Examples of kernel object
> > managers include the filesystem,
> > process management, and System V interprocess communication (IPC).
In
> > the LSM architecture, the
> > object managers are represented by the LSM hooks (!!!); these hooks
> > are scattered throughout the kernel
> > subsystems and call the SELinux LSM module for access decisions. The
> > LSM hooks then enforce
> > those decisions by allowing or denying access to the kernel
> > resource." [1]
> >
> > this basically says we have dozens of object managers, since every
LSM
> > hook is one!
> >
> > but here stephen smalley wrote:
> >
> > An object manager gets access decisions from its AVC, which consults
> > the security server when the decision isn't already cached.
Meanwhile,
> > if a policy change occurs, the security server needs to notify the
> > AVCs of all object managers of the change so that their state can be
> > updated (in simplest form, by flushing the caches). There can be any
> > number of object managers. In Linux, the entire kernel is really a
> > single object manager, but in earlier microkernel-based systems,
there
> > were separate object managers for process management, filesystems,
and
> > networking.
> >
> > http://marc.info/?l=selinux&m=115955074232032&w=2
> >
> >
> > What is an object manager and who says the truth? ;)
> >
> > "Every LSM hook object manager" vs "1 single Object Manager"
> 
> I don't think they intended to imply that each hook was a discrete
> object manager in their book.  The original terminology here comes
from
> the Flask paper,
> http://www.nsa.gov/research/_files/selinux/papers/flask-abs.shtml
> 
> An object manager is a component that manages a set of resources and
> that enforces policy decisions over those resources.  The policy
> decisions are obtained from the security server.
> 
> The Linux kernel is a single object manager, although logically you
can
> view it as a collection of object managers (process management,
> filesystem, networking, IPC) as mentioned above.  The X server is
> another object manager, as is the D-BUS daemon.
> 

Steve - thanks, that's an excellent clarification of what we intended in
the book. The key phrase is "For the kernel, you can _think_ of object
managers as kernel subsystems" - i.e., this is just a conceptual view
that might help understanding not a literal description.

Thanks - Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
