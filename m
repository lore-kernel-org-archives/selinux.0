Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA04583
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 13:59:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA25934
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 17:58:57 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA25930
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 17:58:56 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g4SHwjL04686
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 13:58:45 -0400 (EDT)
Date: Tue, 28 May 2002 13:58:45 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: devfs mysterious relabelling (fwd)
Message-ID: <Pine.GSO.4.33.0205281357550.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


---------- Forwarded message ----------
Date: Tue, 28 May 2002 08:04:45 -0600
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tislabs.com>, devfs@oss.sgi.com
Subject: Re: devfs mysterious relabelling

Russell Coker writes:
> On Tue, 28 May 2002 15:04, Stephen Smalley wrote:
> > On Fri, 24 May 2002, Russell Coker wrote:
> > > On my systems I have devfsd do most of the device node labelling.
> > >
> > > I have noticed that often the system_u:object_r:fixed_disk_device_t
> > > labels (for /dev/ide/host0/bus0/target0/lun0/*) will get changed to
> > > system_u:object_r:devfs_t (the default context for devfs).
> > >
> > > It doesn't happen to the device node for the entire file system
> > > /dev/ide/host0/bus0/target0/lun0/disc and the device node
> > > /dev/ide/host0/bus0/target0/lun0/part5 (an extended partition).
> > >
> > > I believe that this is not a user-land issue, and it's something in the
> > > kernel (but I have not proven this yet).
> > >
> > > Also it seems to happen more often when under load (setfiles on the root
> > > file system usually does the job).
> >
> > This could happen if a devfs entry is evicted from the dcache and is later
> > looked up again, causing the security context to be re-acquired from the
> > devfs_contexts configuration.  Doesn't this issue also arise for the
> > ownership and mode on devfs entries when they are managed by devfsd?
>
> No!  Devfs preserves the results of chmod/chown operations until the
> next reboot.

Or until the entry is unregistered (and if you haven't configured
devfsd to restore permissions).

> I'm surprised though, I thought that devfs entries would be locked
> in the dcache...

Nope. Devfs currently uses it's own backing store (i.e. file tree),
thus devfs dentries may be freed. That's going to change in 2.5,
however.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
