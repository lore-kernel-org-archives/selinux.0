Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3GGSY7C003731
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 12:28:34 -0400 (EDT)
Received: from mail-old.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3GGLfOQ007324
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 16:21:42 GMT
Message-ID: <42613C72.5060408@kaigai.gr.jp>
Date: Sun, 17 Apr 2005 01:25:22 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "SELinux-ML(NSA)" <selinux@tycho.nsa.gov>
Subject: Re: [POLICY/PATCH] IA-64 Boot Partition
References: <4260B74B.3000002@kaigai.gr.jp> <1113666959.6081.25.camel@sgc.columbia.tresys.com>
In-Reply-To: <1113666959.6081.25.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, Christopher

Thanks for your solution.
Indeed, we can solve this problem with appending a line into /etc/fstab
or a command line option.

BTW, what archtectures are used and checked by SELinux's people ?
For example, kernel panic is occured on the 2.6.6 or former kernel for IA-64
when SELinux is enabled. This phenomenon have been overlooked.

I can validate the evidence on IA64/i386 environment.
Is there a person who can try to run SELinux on infrequent(not i386) plathome?

Thanks,

> It would seem like mounting /boot with the context= mount option is a
> better solution.  Vfat being mounted at /boot is an exception to the
> genfscon; there could be other vfat partitions you might want to mount,
> and they should be dosfs_t.  So rather then making all vfat partitions
> boot_t on ia64, you should just mount /boot with the context= option.
-- 
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
