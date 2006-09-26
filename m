Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QDL385015227
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 09:21:03 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8QDKTqH021975
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 13:20:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Latest diffs
Date: Tue, 26 Sep 2006 23:21:07 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <45116881.3060406@redhat.com> <200609262041.49115.russell@coker.com.au> <1159276431.3920.245.camel@sgc>
In-Reply-To: <1159276431.3920.245.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609262321.10080.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 26 September 2006 23:13, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> > > So it sounds like we need two types, one for the control device and one
> > > for raw1, etc.
> >
> > What is the benefit of having an additional type?
> >
> > fixed_disk_device_t determines access to fixed disks.  If there is a
> > control device that controls fixed disks then surely the same type is
> > appropriate.
>
> Its not just fixed disks, its any block device.  Its just like
> scsi_generic_t, which could be another option rather than a new type.

Are you trying to cater for the case of raw access to removable_device_t or 
raw access to tape_device_t?

Currently either we only have three types for block devices or I messed up a 
grep command very badly.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
