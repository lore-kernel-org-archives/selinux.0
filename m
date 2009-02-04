Date: Wed, 4 Feb 2009 11:18:20 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
Subject: Re: filesystem mount AVC denial
In-Reply-To: <1233668475.14235.2.camel@localhost.localdomain>
Message-ID: <alpine.LRH.1.10.0902041111420.28618@tundra.namei.org>
References: <7b4dai$ejec6@dmzms99901.na.baesystems.com>  <1233583453.3826.4.camel@localhost.localdomain>  <49874331.2050102@redhat.com> <1233668475.14235.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Feb 2009, Stephen Smalley wrote:

> > guest_t cd to /mynfs Would fail????
> > 
> > automount is doing the mount so the kernel should say automount not
> > libstart_t.
> > 
> > I think this is a bug in the kernel.

Well, the behavior I see with automount is:

avc:  granted  { mount } for  pid=3378 comm="mount" name="/" dev=sdc4 
ino=2 scontext=unconfined_u:system_r:mount_t:s0 
tcontext=system_u:object_r:fs_t:s0 tclass=filesystem

... always running as mount_t (in this case, I used runcon to 'ls' an 
automount from sshd_t).

> 
> Yes, it is similar to the recent proc/self/net problem.
> 
> Eric?  James?  The fundamental issue is that we are performing a
> permission check in a core function that gets used internally by the
> kernel for mounts, not just when userspace initiates a mount.  In the
> proc case we could use MS_KERNMOUNT as a discriminator, but not in this
> case, at least at present.

Firstly, why isn't Mike's example running as mount_t (and how do you 
define userspace initiating a mount -- does this include automounting?)

(Also, Dan asked for a bz to be filed with the autofs folk...)


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
