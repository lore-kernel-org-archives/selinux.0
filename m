Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i816K5rT018553
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 02:20:05 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i816K2eu021465
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 06:20:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Date: Wed, 1 Sep 2004 16:19:55 +1000
Cc: selinux@tycho.nsa.gov
References: <20040823214228.GA13677@lkcl.net> <200408282354.35395.russell@coker.com.au> <1093785427.12727.14.camel@nexus.verbum.private>
In-Reply-To: <1093785427.12727.14.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409011619.55182.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 29 Aug 2004 23:17, Colin Walters <walters@verbum.org> wrote:
> On Sat, 2004-08-28 at 23:54 +1000, Russell Coker wrote:
> > On Thu, 26 Aug 2004 03:07, Colin Walters <walters@verbum.org> wrote:
> > > I guess genhomedircon is a precendent here, but: I don't think this
> > > makes sense, because then the policy is dependent on the machine where
> > > you build the policy, which may be different from the machine to which
> > > the policy is ultimately installed.
> > >
> > > This kind of calculation should probably be done in the policy post-
> > > installation step.
> >
> > We could do that.
> >
> > Another possibility may be to have udev do this and create a /dev/cdroms
> > directory or something similar.
>
> Yes, having this kind of logic in udev makes more sense to me.
> Fundamentally the SELinux policy is a static entity, and devices are
> dynamic.  I could plug in a USB mass-storage disk one minute, have that
> be /dev/sda, then unplug it and plug in a CD-ROM the next.
>
> I think what we need is a mapping in the policy from device *types* to
> contexts.  E.g. something like:
>
> disk system_u:object_r:fixed_disk_device_t
> cdrom system_u:object_r:removable_device_t
>
> Then udev can read this and do the labeling itself.  I think this will
> be sufficient for most people, but I wonder if it's worth implementing a
> more specific matching, so I could put e.g. PCI ids or USB manufacturers
> on the left side.

I can't remember whether I already replied to this.  It's a great idea, now 
all we need is someone to contribute the code...  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
