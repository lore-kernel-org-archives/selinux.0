Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5SDabrT012630
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 09:36:37 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5SDaa7l014969
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 13:36:36 GMT
Subject: Re: r_file_perms and ioctl
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <200406281747.37392.russell@coker.com.au>
References: <200406281701.18137.russell@coker.com.au>
	 <200406281747.37392.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1088429778.17133.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 28 Jun 2004 09:36:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-06-28 at 03:47, Russell Coker wrote:
> On Mon, 28 Jun 2004 17:01, Russell Coker <russell@coker.com.au> wrote:
> > It seems to me that including ioctl in the r_file_perms macro is a bad
> > idea. ioctl is often (usually?) used for writing, so therefore the macro is
> > not doing what it's name suggests.
> 
> Sorry my last message was not complete.
> 
> I was thinking of the case of using r_file_perms for access to device nodes.  
> ioctl on a file is usually harmless.
> 
> Of course there's probably some policy which uses r_file_perms when it really 
> wants to do ioctl's as well, access to sound devices and SCSI generic devices 
> comes to mind.

IIRC, ioctl permission was added to r_file_perms and similar macros
because library routines were using ioctl frequently to probe the type
of file, and because certain ioctls are indeed read flows (e.g. ext[23]
getflags and getversion ioctls, although we did try to map those ioctls
to other permissions in the ioctl hook).  If you remove ioctl from those
macros, then you'll likely encounter a number of denials due to such
probes.

With regard to read vs. write on devices, note that you have to obtain a
descriptor in order to perform the ioctl, and we already mediate read
and write permissions on the open or exec or local IPC.  Further, any
capability checks performed by the driver code for the ioctl will
require corresponding SELinux capability permissions.

The ioctl permission check is really just a placeholder; a reminder that
we ultimately need fine-grained permissions on individual ioctl
operations implemented in the driver code if we want to effectively
control ioctls.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
