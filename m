Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7T90YrT029098
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 05:00:35 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7T8xlwc023235
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 08:59:47 GMT
Date: Sun, 29 Aug 2004 10:11:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: mount accessing /dev/cdrom as a symlink
Message-ID: <20040829091147.GB7610@lkcl.net>
References: <20040828181909.GF11546@lkcl.net> <200408291708.23368.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408291708.23368.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 29, 2004 at 05:08:23PM +1000, Russell Coker wrote:
> On Sun, 29 Aug 2004 04:19, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > i had to add this to the mount.te policy in order to allow mount
> > to actually succeed on a udev-automatically-created /dev/cdrom symlink
> > (to /dev/hdc which is my ide cdrom drive).
> >
> > so, the question is: should udev have relabelled that symlink correctly,
> > or should mount be allowed to read device_t symlinks?
> 
> Mount should be allowed to read device_t symlinks.  There should be no symlink 
> under /dev with a type other than device_t under the current design.
 
 okay, great.  so for once i DidTheRightThing.  gosh.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
