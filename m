Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5M5UfgA014130
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 01:30:41 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5M5L7rk026843
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 05:21:08 GMT
Date: Wed, 22 Jun 2005 06:30:01 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: mkfs.cramfs
Message-ID: <20050622053001.GA14480@lkcl.net>
References: <200506221415.10141.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200506221415.10141.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

mksquashfs isn't in there is it?

[mksquashfs goes in /usr/bin on debian]

On Wed, Jun 22, 2005 at 02:15:05PM +1000, Russell Coker wrote:
> I've attached a patch for fsadm.fc to make mkfs.cramfs not have fsadm_exec_t.  
> It doesn't access block devices and is more like an archive utility than a 
> regular mkfs program.
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page

> --- fsadm.fc.orig	2005-06-22 14:12:25.000000000 +1000
> +++ fsadm.fc	2005-06-22 14:12:44.000000000 +1000
> @@ -1,6 +1,7 @@
>  # fs admin utilities
>  /sbin/fsck.*		--	system_u:object_r:fsadm_exec_t
>  /sbin/mkfs.*		--	system_u:object_r:fsadm_exec_t
> +/sbin/mkfs\.cramfs	--	system_u:object_r:sbin_t
>  /sbin/e2fsck		--	system_u:object_r:fsadm_exec_t
>  /sbin/mkdosfs		--	system_u:object_r:fsadm_exec_t
>  /sbin/dosfsck		--	system_u:object_r:fsadm_exec_t


-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
