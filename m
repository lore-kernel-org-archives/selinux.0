Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8B0mRLa013012
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 20:48:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8B0mQmw014219
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 00:48:26 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8B0mN9d014207 for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 00:48:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, Colin Walters <walters@verbum.org>
Subject: Re: rfs xattr's, mkinitrd and other stories
Date: Thu, 11 Sep 2003 10:48:16 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030910164854.GO5397@vnl.com> <20030910230519.GU5397@vnl.com> <20030910233424.GV5397@vnl.com>
In-Reply-To: <20030910233424.GV5397@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309111048.16590.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 11 Sep 2003 09:34, Dale Amon wrote:
> Okay, next round of questions. According to Steve's HOWTO, the
> line
>
> 	none /selinux selinuxfs defaults 0 0
>
> goes into the /etc/fstab to cause this file to mount. However
> Debian mkinitrd defaults to cramfs and also states it requires
> a debian dist patched kernel.

none                    /selinux                selinuxfs       noauto  0 0

Currently on my main development UML I have the above in /etc/fstab and the 
below as a start script.  I also have a version of the below script with 
"exec /sbin/init" in /sbin/se-init, so if I boot my machine with
"init=/sbin/se-init" on the kernel command line then it loads the policy 
before running init.  This makes it usable on a machine without an initrd.

#!/bin/sh -e

mount -n /selinux
/usr/sbin/load_policy /etc/security/selinux/policy.15
if [ -f /selinux/enforce ]; then
  echo 1 > /selinux/enforce
else
  echo "Can't set enforcing mode"
fi

> I'm left with these questions:
>
> * what is an selinuxfs???

A special file system for SE Linux related entries.  I can't understand why it 
wasn't just made part of /proc, Steve, perhaps you could explain.

> * where do I find the cramfs patches. I don't use packaged
>   kernels. I roll my own no-module jobbies.

Nothing special needs to be done for cramfs.  But I suggest not using it.  
cramfs has a long history of being broken in kernels from ftp.kernel.org, 
it's not well supported upstream, and for most things you want to do there 
are other file systems that do it better.  I suggest using a gzip compressed 
romfs, it will be considerably smaller than cramfs for the same file storage 
and work more reliably.

> * what should dst be?
> 	mkinitrd -o dst
>
> I'm going to go back and look over Steve's howto again and
> see if I can figure how to relate it to your debian set up.

The Debian mkinitrd is more flexible than the Red Hat one.  So once you have 
the correct scripts dropped in place (as Colin's package does) then you just 
create an initrd in the regular fashion.  For Red Hat a patch to mkinitrd was 
shipped because there is no other way to do it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
