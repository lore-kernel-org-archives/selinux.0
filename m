Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7TDG9rT029896
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 09:16:09 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7TDFLwc026155
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 13:15:22 GMT
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
From: Colin Walters <walters@verbum.org>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200408282354.35395.russell@coker.com.au>
References: <20040823214228.GA13677@lkcl.net>
	 <200408252140.41362.russell@coker.com.au>
	 <1093453663.5092.84.camel@nexus.verbum.private>
	 <200408282354.35395.russell@coker.com.au>
Content-Type: text/plain
Date: Sun, 29 Aug 2004 09:17:07 -0400
Message-Id: <1093785427.12727.14.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-08-28 at 23:54 +1000, Russell Coker wrote: 
> On Thu, 26 Aug 2004 03:07, Colin Walters <walters@verbum.org> wrote:
> > I guess genhomedircon is a precendent here, but: I don't think this
> > makes sense, because then the policy is dependent on the machine where
> > you build the policy, which may be different from the machine to which
> > the policy is ultimately installed.
> >
> > This kind of calculation should probably be done in the policy post-
> > installation step.
> 
> We could do that.
> 
> Another possibility may be to have udev do this and create a /dev/cdroms 
> directory or something similar.

Yes, having this kind of logic in udev makes more sense to me.
Fundamentally the SELinux policy is a static entity, and devices are
dynamic.  I could plug in a USB mass-storage disk one minute, have that
be /dev/sda, then unplug it and plug in a CD-ROM the next.

I think what we need is a mapping in the policy from device *types* to
contexts.  E.g. something like:

disk system_u:object_r:fixed_disk_device_t
cdrom system_u:object_r:removable_device_t

Then udev can read this and do the labeling itself.  I think this will
be sufficient for most people, but I wonder if it's worth implementing a
more specific matching, so I could put e.g. PCI ids or USB manufacturers
on the left side.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
