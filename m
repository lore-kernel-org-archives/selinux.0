Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAO082Ii016299
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 19:08:02 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAO06VuA023504
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 00:06:32 GMT
Date: Wed, 24 Nov 2004 00:18:47 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Mark Williamson <maw48@hermes.cam.ac.uk>
Cc: xen-devel@lists.sourceforge.net, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [Xen-devel] protecting xen startup
Message-ID: <20041124001847.GH5146@lkcl.net>
References: <20041123170546.GB6250@lkcl.net> <Pine.LNX.4.60.0411231802570.3258@hermes-1.csi.cam.ac.uk> <20041123205152.GA5146@lkcl.net> <Pine.LNX.4.60.0411232242120.3871@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0411232242120.3871@hermes-1.csi.cam.ac.uk>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 23, 2004 at 10:49:24PM +0000, Mark Williamson wrote:
> >is there anything preventing that interface from being removed, such
> >that the client/server bit is munged into a single application?
> 
> In older releases, there wasn't a Xend.  Instead we had a set of 
> management scripts that called various operations directly.  You could in 
> principle munge xm and xend together into a big megatool but it wouldn't 
> be pretty.

 i'll take that as a challenge, then :)

> Xend makes concurrency control much easier, provides a central point of 
> contact regarding machine state and demuxes the virtual consoles of the 
> domain.  You'd have to address these problems in addition to combining the 
> tools, which would take a fair bit of hacking to do properly.

 okay.

 assuming that 1) i don't want a central point of contact i only want
 _one_ point of contact and 2) i can live without virtual consoles
 until i understand the code enough and can get away with
 using ssh logins instead:

 would this be a simple enough task for someone not entirely
 familiar with xen's code [but who has developed a number of
 20k+ line python projects over the past four years]?



> >>Not exactly.  At the Linux Level, there aren't any extra Xen system calls.
> >>Most commands are issued to Xen by performing ioctls on the
> >>/proc/xen/privcmd file.
> >
> >GREAT.
> >
> >that means that it will be possible to lock down at the very least the
> >access to /proc/xen and later, should it prove worthwhile, to protect
> >each ioctl with a new selinux security id per ioctl command.
> 
> Right now, only root (actually, probably users with the CAP_SYSADMIN 
> capability or similar) can do operations on /proc/xen.  

 [which, please excuse me for saying so, doesn't exactly help if that
 root-only interface is then exposed via an open high port number!! :) ]

> Also, many Xen 
> operations are mapped onto one ioctl call so as it is you can't do very 
> fine grained protection based on ioctl number.  

 i was thinking of adding in an LSM hook function that received the
 ioctl number as one of its arguments, translated that in a case
 statement into the corresponding selinux SIDs, and from there checked
 an selinux permission - in a similar way that security/selinux/hooks.c's
 selinux_file_ioctl() or the selinux_file_fcntl() function operates.

 i.e. not using file_has_perm() but task_has_perm() instead.

 then the first thing that the xen ioctl function does is call that LSM
 hook function.

 it would therefore also be possible for someone else to write a
 corresponding LSM linux capabilities function call, too.  should
 someone so wish.

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
