Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MHEtrT003449
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 13:14:55 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MHEsWF018431
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 17:14:54 GMT
Date: Wed, 22 Sep 2004 18:25:58 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: fuse
Message-ID: <20040922172558.GB7308@lkcl.net>
References: <20040922005509.GD14303@lkcl.net> <200409221355.i8MDtnFZ018380@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409221355.i8MDtnFZ018380@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 22, 2004 at 09:55:49AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 22 Sep 2004 01:55:09 BST, Luke Kenneth Casson Leighton said:
> 
> > fusexmp provides stateless proxy access to a linux filesystem,
> > so if HAL chops off /media/usbdisk1 without warning, then the
> > fusexmp mountpoint (say /home/user/proxyroot/media/usbdisk1)
> > just... doesn't _care_.
> 
> Somehow, I can't convince myself that isn't a good way to livelock the kernel
> because the VFS has locked something and then gone away for a LONG time in
> userspace - mostly because I've seen it all too many times with an NFS mount
> that includes 'hard' but *not* 'intr'...)
 
 well, if there existed a kernel filesystem "proxy" module i'd use that
 instead, like a shot.


 i _have_ encountered some weird VFS messages i'll let you know how i
 get on: they're due to a DVD being forcibly mounted (by KDE) and so
 i can't get it back.

 a umount /media/dvdrom says "Device busy".
 
 a umount -lf /media/dvdrom results in the weird VFS message.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
