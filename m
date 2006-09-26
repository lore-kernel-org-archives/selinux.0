Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QDD5oR015008
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 09:13:05 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8QDC2oN027215
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 13:12:02 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200609262041.49115.russell@coker.com.au>
References: <45116881.3060406@redhat.com> <451447EA.70905@redhat.com>
	 <1159210299.3920.218.camel@sgc>  <200609262041.49115.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 09:13:51 -0400
Message-Id: <1159276431.3920.245.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-26 at 20:41 +1000, Russell Coker wrote:
> On Tuesday 26 September 2006 04:51, "Christopher J. PeBenito" 
> <cpebenito@tresys.com> wrote:
> > > /dev/rawctl is labeled as a fixed_disk_device_t even though it is a
> > > chr_file.  Not sure if this is correct.
> >
> > According to drivers/char/raw.c:
> >
> >  * Front-end raw character devices.  These can be bound to any block
> >  * devices to provide genuine Unix raw character device semantics.
> >  *
> >  * We reserve minor number 0 for a control interface.  ioctl()s on this
> >  * device are used to bind the other minor numbers to block devices.
> >
> > So it sounds like we need two types, one for the control device and one
> > for raw1, etc.
> 
> What is the benefit of having an additional type?
> 
> fixed_disk_device_t determines access to fixed disks.  If there is a control 
> device that controls fixed disks then surely the same type is appropriate.

Its not just fixed disks, its any block device.  Its just like
scsi_generic_t, which could be another option rather than a new type.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
