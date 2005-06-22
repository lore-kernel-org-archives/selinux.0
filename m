Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5M6acgA014406
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 02:36:38 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5M6R2rk027640
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 06:27:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: mkfs.cramfs
Date: Wed, 22 Jun 2005 16:26:56 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
References: <200506221415.10141.russell@coker.com.au> <20050622053001.GA14480@lkcl.net>
In-Reply-To: <20050622053001.GA14480@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506221627.00632.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 22 June 2005 15:30, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> mksquashfs isn't in there is it?
>
> [mksquashfs goes in /usr/bin on debian]

mksquashfs won't get caught by the regex "/sbin/mkfs.*".  If squashfs works in 
the same was as cramfs and romfs, and if there is a mkfs.squashfs program 
then it would need a line in the .fc file.

The point of the entry for mkfs.cramfs is to prevent any special labeling of 
it.

> On Wed, Jun 22, 2005 at 02:15:05PM +1000, Russell Coker wrote:
> > I've attached a patch for fsadm.fc to make mkfs.cramfs not have
> > fsadm_exec_t. It doesn't access block devices and is more like an archive
> > utility than a regular mkfs program.
> >
> > --
> > http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
> > packages http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> > http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> > http://www.coker.com.au/~russell/  My home page
> >
> > --- fsadm.fc.orig	2005-06-22 14:12:25.000000000 +1000
> > +++ fsadm.fc	2005-06-22 14:12:44.000000000 +1000
> > @@ -1,6 +1,7 @@
> >  # fs admin utilities
> >  /sbin/fsck.*		--	system_u:object_r:fsadm_exec_t
> >  /sbin/mkfs.*		--	system_u:object_r:fsadm_exec_t
> > +/sbin/mkfs\.cramfs	--	system_u:object_r:sbin_t
> >  /sbin/e2fsck		--	system_u:object_r:fsadm_exec_t
> >  /sbin/mkdosfs		--	system_u:object_r:fsadm_exec_t
> >  /sbin/dosfsck		--	system_u:object_r:fsadm_exec_t

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
