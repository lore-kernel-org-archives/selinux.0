Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OIvIrT019894
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 14:57:18 -0400 (EDT)
Received: from oe-im1.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OIvGrq004396
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 18:57:16 GMT
Subject: Re: Remove unrestricted_admin
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, jwcart2@epoch.ncsc.mil,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200409250427.49189.russell@coker.com.au>
References: <200409211526.37810.russell@coker.com.au>
	 <200409250105.40796.russell@coker.com.au> <1096048244.9895.4.camel@selinux>
	 <200409250427.49189.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 24 Sep 2004 14:59:16 -0400
Message-Id: <1096052356.9895.25.camel@selinux>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-09-25 at 04:27 +1000, Russell Coker wrote:
> On Sat, 25 Sep 2004 03:50, "Christopher J. PeBenito" <cpebenito@tresys.com> 
> wrote:
> > On Sat, 2004-09-25 at 01:05 +1000, Russell Coker wrote:
> > > -allow sysadm_t fixed_disk_device_t:devfile_class_set rw_file_perms;
> > >
> > > I think that perhaps we should add that line back.
> > >
> > > Of the times that I temporarily enable permissive mode to execute a
> > > command, in 99% of them it's because of access to a fixed disk.
> >
> > Why would you need to directly access the disk as sysadm_t?  All the
> > applicable tools should be transitioning to fsadm_t.
> 
> dd if=/dev/hda of=/dev/hdb
> 
> file -s /dev/hda
> 
> Using an LVM snapshot to backup a disk onto a DVD.

Yes these are reasons; however, this is supposed to be the strict
policy, and these are not compelling enough to loosen the policy this
way, in my opinion. 

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
