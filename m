Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3GFxq7C003601
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 11:59:52 -0400 (EDT)
Received: from oe-im1.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3GFtmiE015188
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 15:55:49 GMT
Subject: Re: [POLICY/PATCH] IA-64 Boot Partition
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: "SELinux-ML(NSA)" <selinux@tycho.nsa.gov>
In-Reply-To: <4260B74B.3000002@kaigai.gr.jp>
References: <4260B74B.3000002@kaigai.gr.jp>
Content-Type: text/plain
Date: Sat, 16 Apr 2005 11:55:59 -0400
Message-Id: <1113666959.6081.25.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-04-16 at 15:57 +0900, KaiGai Kohei wrote:
> This attached patch modifies genfs_contexts.
> When arch_ia64 is defined in tunable/tunable.tun,
> vfat is labeled as boot_t, not dosfs_t.
> 
> Currently, vfat-fs is recognized as dosfs_t.
> But, vfat is often used as bootable partition
> which should be labeled as boot_t.
> 
> In IA-64 Linux, any files related to booting process such as
> vmlinuz and initrd.img are placed under /boot/efi/.
> We must mount a vfat partition contains such files on /boot/efi,
> because EFI can't recognize the contents of Ext2/3 partitions.
> (EFI is a firmware similar to PC's BIOS.)
> # The kernel provided by RedHat is placed in /boot/efi/efi/redhat.

It would seem like mounting /boot with the context= mount option is a
better solution.  Vfat being mounted at /boot is an exception to the
genfscon; there could be other vfat partitions you might want to mount,
and they should be dosfs_t.  So rather then making all vfat partitions
boot_t on ia64, you should just mount /boot with the context= option.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
