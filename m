Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PFLIrT023913
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 11:21:18 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PFKFsn029122
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 15:20:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Remove unrestricted_admin
Date: Sun, 26 Sep 2004 01:21:10 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <200409211526.37810.russell@coker.com.au> <200409252039.01196.russell@coker.com.au> <1096119005.11665.21.camel@gorn.pebenito.net>
In-Reply-To: <1096119005.11665.21.camel@gorn.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409260121.10665.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 25 Sep 2004 23:30, "Christopher J. PeBenito" <cpebenito@tresys.com> 
wrote:
> > So you are saying we should write special programs to copy block devices
> > to other block devices, to/from DVD, copying raw partition tables, and
> > all the other things that administrators usually do?  I don't think that
> > is viable.
>
> I still believe that the first two are more like corner cases.  I see it

Corner cases that happen to be a regular part of any sys-admin's job.

Post to any sys-admin mailing list and ask the subscribers how they would like 
a security system that prevents them from copying a block device to a file on 
a larger file system or that prevents them from using dd to copy one block 
device to another.  You will not get a positive response.

> much more likely that an admin would be using a regular backup solution
> with tapes and autoloaders (bigger systems) and the like for backups
> with tools seem to be fit for backup_t or similar domain.

Tapes and auto-loaders don't make these problems go away.

> > One possibility is to run things in fsadm_t, this means that fsadm_t
> > needs a heap of extra access which probably isn't desired.
>
> Since I'm not familiar with LVM, I'm curious as to why doing a snapshot
> doesn't fit into a domain of its own or fsadm_t.

The snapshot device is just like any other fixed disk device.  To use it for a 
backup you need a process that has permissions to read it and to write to 
wherever the backup may be stored.  We could allow backup_t to read 
fixed_disk_device_t for this case.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
