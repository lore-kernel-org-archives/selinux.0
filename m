Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TIIOrT017896
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 14:18:24 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TIILjQ021286
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 18:18:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: selinux tmpfs udev
Date: Thu, 30 Sep 2004 04:18:19 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040926181026.GE28076@lkcl.net>
In-Reply-To: <20040926181026.GE28076@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409300418.19904.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Sep 2004 04:10, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> disabling udev_can_tmpfs i get /sbin/udev cannot do
> filesystem:associate tmpfs_t udev_tbl_t and it gets worse from there-on.

Have a udev_can_tmpfs tunable for the associate access, and leave the access 
to tmpfs_t:chr_file inside distro_redhat.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
