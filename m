Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7T78jrT028709
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 03:08:45 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7T77rwc022151
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 07:07:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: mount accessing /dev/cdrom as a symlink
Date: Sun, 29 Aug 2004 17:08:23 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040828181909.GF11546@lkcl.net>
In-Reply-To: <20040828181909.GF11546@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408291708.23368.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 29 Aug 2004 04:19, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> i had to add this to the mount.te policy in order to allow mount
> to actually succeed on a udev-automatically-created /dev/cdrom symlink
> (to /dev/hdc which is my ide cdrom drive).
>
> so, the question is: should udev have relabelled that symlink correctly,
> or should mount be allowed to read device_t symlinks?

Mount should be allowed to read device_t symlinks.  There should be no symlink 
under /dev with a type other than device_t under the current design.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
