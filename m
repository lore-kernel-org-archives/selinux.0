Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA13710
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 19:51:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA03965
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 00:48:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id AAA03961
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 00:48:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: forrest whitcher <fw@fwsystems.com>, selinux@tycho.nsa.gov
Subject: Re: Selinux on the "Lunar" linux distribution.
Date: Mon, 20 Jan 2003 01:51:13 +0100
Cc: lunar@lunar-linux.org
References: <20030119164412.4c7c8ad5.fw@fwsystems.com>
In-Reply-To: <20030119164412.4c7c8ad5.fw@fwsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301200151.13167.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 19 Jan 2003 22:44, forrest whitcher wrote:
> Removed the devfs/devfsd from the configuration. I have not had good luck
> getting the selinux policies to work on Lunar with devfsd enabled.

How exactly did it fail?  What kernel version did it fail on?

I wrote the devfsd policy and the SE Linux plugin, and I've contributed devfsd 
code to Richard Gooch.  I would like to see this problem solved, so please 
give me all available information off-list.

> in /usr/lib:
> ln -s libbsd-compat.a libbsd.a

Why not just change the "-lbsd" in utils/Makefile to "-lbsd-compat"?

> set GCCWRAPPERS=off in /etc/lunar/local/config. The GCC wrapper
> files have the wrong SID and will generate an avc: denied error
> in enforcing mode.

What are these wrapper files?  What are the error messages that are reported?  
Fixing this in policy should be easy enough, and it might even be something 
we want in the default policy.

"diff -ru" is really good for this...
> ==> ssh.te <==
>
> #
> # iterative edits
> #
>
> allow sshd_t device_t:chr_file { getattr ioctl read write };

Your labeling of /dev is broken.  There should never be a character device 
node in use that's labeled as device_t.

> allow sshd_t sysadm_tty_device_t:chr_file { getattr ioctl read relabelfrom
> relabelto setattr write };

After some discussion after OLS last year we decided that denying sshd the 
ability to transition to sysadm_t (and all related operations) was a good 
idea.  Therefore the above should not be needed.

> allow sshd_t tmpfs_t:file { lock read write };

What operation causes that?

> allow sshd_t tty_device_t:chr_file { getattr ioctl read relabelfrom setattr
> write }; allow sshd_t user_tty_device_t:chr_file { getattr ioctl read
> relabelfrom relabelto setattr write };

I think that you have the wrong contexts assigned to pseudo-tty devices.  Are 
you failing to use Unix98 PTY's?

> ==> klogd.te <==
>
> #
> # iterative edits
> #
>
> allow klogd_t file_t:file { getattr read };
> allow klogd_t tmpfs_t:file { getattr lock read unlink write };

What exactly is klogd doing that needs such access?  The file_t thing suggests 
mis-labelling.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
