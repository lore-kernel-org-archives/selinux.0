Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PHjPrT024402
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 13:45:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PHjMAk024329
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 17:45:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: Remove unrestricted_admin
Date: Sun, 26 Sep 2004 03:45:21 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <200409211526.37810.russell@coker.com.au> <200409260121.10665.russell@coker.com.au> <1096132140.11665.34.camel@gorn.pebenito.net>
In-Reply-To: <1096132140.11665.34.camel@gorn.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409260345.21216.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 26 Sep 2004 03:09, Chris PeBenito <pebenito@gentoo.org> wrote:
> > > much more likely that an admin would be using a regular backup solution
> > > with tapes and autoloaders (bigger systems) and the like for backups
> > > with tools seem to be fit for backup_t or similar domain.
> >
> > Tapes and auto-loaders don't make these problems go away.
>
> They're more likely to use backup software to run it, which is what I
> meant, then it will be using a program that can be put in its own domain
> to do its work.  Raw access could be added to that domain if needed.

So every time you add a new disk and want to migrate a file system you use a 
backup program instead of dd?

> > > Since I'm not familiar with LVM, I'm curious as to why doing a snapshot
> > > doesn't fit into a domain of its own or fsadm_t.
> >
> > The snapshot device is just like any other fixed disk device.  To use it
> > for a backup you need a process that has permissions to read it and to
> > write to wherever the backup may be stored.  We could allow backup_t to
> > read fixed_disk_device_t for this case.
>
> Does this not require a program to do a snapshotting?  If it does, why
> does it not fit in its own domain?

lvm creates the snapshot which looks just like any other block device to the 
system.  Then something else has to access it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
