Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TEEJrT019122
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 10:14:19 -0400 (EDT)
Received: from mta03-svc.ntlworld.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TEDgbB021617
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 14:13:48 GMT
Subject: Re: udev and .dev...
From: Ian Campbell <ijc@hellion.org.uk>
To: Joshua Brindle <method@gentoo.org>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4108EE75.6040109@gentoo.org>
References: <20040729091423.GC6443@lkcl.net>  <4108EE75.6040109@gentoo.org>
Content-Type: text/plain
Message-Id: <1091110451.7878.87.camel@icampbell-debian>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 15:14:11 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-29 at 13:32, Joshua Brindle wrote:
> Why not have a minimal /dev for init and friends and mount the ramfs for 
> udev on top of it? it's much easier to deal with 1 /dev and this is 
> pretty standard anyway.

I believe what happens is that the on disk dev does live at /dev and the
udev initscript bind mounts it to /.dev before mounting the rams over
the top so that you can still get at the on disk version.

An excerpt from the Debian udev initscript:
  # /.dev is used by /sbin/MAKEDEV to access the real /dev directory.
  # if you don't like it just remove it.
  [ -d /.dev ] && mount --bind /dev /.dev

  echo -n "Mounting a tmpfs over /dev..."
  mount -n -o size=$tmpfs_size,mode=0755 -t tmpfs none /dev
  echo "done."

Ian.


-- 
Ian Campbell
Current Noise: Faith No More - Woodpecker From Mars

I must get out of these wet clothes and into a dry Martini.
		-- Alexander Woolcott


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
