Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OFaYrT027703
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:36:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OFaVCV007713
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:36:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: patch for fsadm
Date: Wed, 25 Aug 2004 01:36:19 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823215041.GC13677@lkcl.net>
In-Reply-To: <20040823215041.GC13677@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408250136.19967.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Aug 2004 07:50, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> usb-mount uses sg_map and disktype.
>
> both these programs require some extra stuff.

# this is for sg_map and disktype
allow fsadm_t scsi_generic_device_t:chr_file { ioctl read };

It only needs ioctl and read access?  I'll give it r_file_perms.

+allow fsadm_t tape_device_t:chr_file { read };

Why does it need to access tape devices?

allow fsadm_t removable_device_t:lnk_file { read };

This is wrong.  We don't want to label lnk_file objects under /dev other than 
as device_t.

+# /bin/mountpoint to read /dev/shm
+allow fsadm_t devpts_t:dir { search };
+allow fsadm_t tmpfs_t:dir { getattr search };

The tmpfs_t part is good, I'm not so sure about the devpts_t part.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
