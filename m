Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OIS2rT019705
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 14:28:02 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OIRxrq003348
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 18:28:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Remove unrestricted_admin
Date: Sat, 25 Sep 2004 04:27:49 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, jwcart2@epoch.ncsc.mil,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <200409211526.37810.russell@coker.com.au> <200409250105.40796.russell@coker.com.au> <1096048244.9895.4.camel@selinux>
In-Reply-To: <1096048244.9895.4.camel@selinux>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409250427.49189.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 25 Sep 2004 03:50, "Christopher J. PeBenito" <cpebenito@tresys.com> 
wrote:
> On Sat, 2004-09-25 at 01:05 +1000, Russell Coker wrote:
> > -allow sysadm_t fixed_disk_device_t:devfile_class_set rw_file_perms;
> >
> > I think that perhaps we should add that line back.
> >
> > Of the times that I temporarily enable permissive mode to execute a
> > command, in 99% of them it's because of access to a fixed disk.
>
> Why would you need to directly access the disk as sysadm_t?  All the
> applicable tools should be transitioning to fsadm_t.

dd if=/dev/hda of=/dev/hdb

file -s /dev/hda

Using an LVM snapshot to backup a disk onto a DVD.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
