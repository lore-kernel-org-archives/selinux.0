Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82MYErT003684
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 18:34:14 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82MXO3w016437
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 22:33:24 GMT
Date: Thu, 2 Sep 2004 23:45:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>,
   Colin Walters <walters@redhat.com>
Subject: Re: Proposed Hardware File Context file.
Message-ID: <20040902224521.GP5745@lkcl.net>
References: <200408241818.40064.russell@coker.com.au> <41371628.2020408@redhat.com> <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil> <200409022338.20644.russell@coker.com.au> <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil> <413741A3.3070305@redhat.com> <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil> <41377927.3080703@redhat.com> <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil> <41377DD5.8010500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41377DD5.8010500@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 04:08:53PM -0400, Daniel J Walsh wrote:

> >>The other thought would be to use a separate file that would map device 
> >>type to policy
> >>cat hardware_contexts
> >>
> >>cdrom system_u:object_r:removable_disk_device_t 
> >>
> >>disk system_u:object_r:fixed_disk_device_t
> >>   
> >>
> >
> >I think I like this better.  But let them also specify unit number or
> >similar so that multiple devices of the same type can be mapped to
> >different contexts, please.

 the major and minor numbers?

> >
> > 
> >
> Ok so the original context as specified in the file context file with 
> hardware type.   IE
> PATH  MODETYPE CONTEXT HARDWARE
> /dev/hd.* -b  system_u:object_r:removable_disk_device_t     cdrom
> /dev/hd.* -b  system_u:object_r:fixed_disk_device_t              disk
> 
> >>But this would still fail the restorecon, rpm and setfiles.
> >>
> >>One idea would be to not include /dev in the setfiles stuff.  ( I guess 
> >>it wouldn't now that it is a tmpfs file system)
> >>   
> >>
> >
> >True, relabel won't include tmpfs mounts.   Not sure about rpm and /dev
> >nodes, e.g. is dev package obsoleted by udev, and are there other /dev
> >nodes that are part of other packages?
> >
> > 
> >
> >>We still need a mapping in policy and a libselinux function to give us 
> >>that mapping.
> >>   
> >>
> >
> >True.  But much simpler than matchpathcon.

well as an API, you'd have something like

	int matchdevcon(char *devicename, char *devicetype, mode_t mode,
					scontext *scontext);

or:

	int matchdevcon(int major, int minor, char *devicetype, mode_t mode,
					scontext *scontext);

in using something like that, would you _care_ if underneath it did
regexps like matchpathcon does?

l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
