Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7LL2CY6028351
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 17:02:12 -0400
Received: from g1t0026.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7LL3K0H000988
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 21:03:20 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [refpolicy] SELinux policy for the new TUN hooks
Date: Fri, 21 Aug 2009 17:02:09 -0400
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
References: <200908201838.29478.paul.moore@hp.com> <1250858185.6222.43.camel@gorn.columbia.tresys.com>
In-Reply-To: <1250858185.6222.43.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200908211702.09769.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 21 August 2009 08:36:25 am Christopher J. PeBenito wrote:
> On Thu, 2009-08-20 at 18:38 -0400, Paul Moore wrote:
> > As you may have seen on the various lists, there is a problem where
> > network traffic sent via a TUN device is not labeled correctly due to
> > missing hooks in the TUN driver.  I believe we've reached a point where
> > the LSM hooks are relatively sorted so now it is time to start thinking
> > about the SELinux policy to go behind the hooks.
> >
> > My current approach has been to label the individual TUN device (actually
> > the sock associated with the TUN device) based on the domain which has
> > attached itself to the device (only one process can attach to a device at
> > any given time).  This has the conceptual advantage that packets sent
> > from the device are labeled based on the domain but the disadvantage that
> > attaching to a persistent TUN device requires a relabel operation.
>
> Seems ok to me.

Okay.

> >   With the current patches,
> > the basic policy for creating and attaching to a TUN device are shown
> > below:
> >
> > 	# create a new tun device
> > 	allow foo_t self:tun_socket { create };
> >
> > 	# attach to an existing persistent tun device
> > 	allow bar_t foo_t:tun_socket { relabel_from };
> > 	allow bar_t self:tun_socket { relabel_to };
>
> The perms should be relabelfrom and relabelto for consistency with all
> the other relabeling perms in the policy.

Sorry, typo on my part - my current patch just has tun_socket inheriting 
(probably overkill, but it works) from the socket class so the permissions are 
all consistent.

> > My first question is does this policy still sound reasonable?  My second
> > question is what refpolicy changes do we want to see?  As it stands I'm
> > thinking of the following refpolicy changes:
> >
> > 1. Add a new socket class, "tun_socket", which inherits from the socket
> > class. 2. Create a new interface, "corenet_create_tun_tap_dev($1)", which
> > would grant the given domain the tun_socket/create permission.
>
> I don't see why we need this since its just going to be a create on
> self.

Good point, consider it gone.

> > 3. Another new interface to grant permission for a domain to attach
> > itself to an existing persistent TUN device.
> >
> > Step #3 is where I seem to be having problems.  If we only allow one
> > argument, the requesting domain, we are forced to allow it to attach to
> > _all_ TUN devices.  If we allow two arguments, both the requesting domain
> > and the type of the persistent TUN device, doesn't that pose a problem
> > with directly accessing the persistent TUN device type?  We could also go
> > with another option that would introduce another interface to assign
> > persistent TUN devices an attribute which would allow them to be attached
> > later with a single argument attach interface.  Thoughts?
>
> Each domain that has this behavior would have its own interface.  So
> using your above example, foo.te would have:
>
> allow foo_t self:tun_socket create;
>
> foo.if would have (simplified for brevity):
>
> interface foo_tun_attach(`
> 	allow $1 foo_t:tun_socket relabelfrom;
> 	allow $1 self:tun_socket relabelto;
> ')
>
> and bar.te would have:
>
> allow bar_t self:tun_socket { read write };
> foo_tun_attach(bar_t)

Great, thanks for the example.  I'll try to get a RFC policy patch out next 
week.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
