Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QE11Of016467
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 10:01:01 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8QDxxoN006726
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 13:59:59 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200609262321.10080.russell@coker.com.au>
References: <45116881.3060406@redhat.com>
	 <200609262041.49115.russell@coker.com.au> <1159276431.3920.245.camel@sgc>
	 <200609262321.10080.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 10:01:48 -0400
Message-Id: <1159279309.3920.260.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-26 at 23:21 +1000, Russell Coker wrote:
> On Tuesday 26 September 2006 23:13, "Christopher J. PeBenito" 
> <cpebenito@tresys.com> wrote:
> > > > So it sounds like we need two types, one for the control device and one
> > > > for raw1, etc.
> > >
> > > What is the benefit of having an additional type?
> > >
> > > fixed_disk_device_t determines access to fixed disks.  If there is a
> > > control device that controls fixed disks then surely the same type is
> > > appropriate.
> >
> > Its not just fixed disks, its any block device.  Its just like
> > scsi_generic_t, which could be another option rather than a new type.
> 
> Are you trying to cater for the case of raw access to removable_device_t or 
> raw access to tape_device_t?

Yes.  I understand that fixed disks are the common case; however, I also
don't want to mix block and char devices, since it doesn't make sense
for the general case of /dev/hda, etc.

> Currently either we only have three types for block devices or I messed up a 
> grep command very badly.

You are correct.  They are all in storage.te.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
