Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GM2DrT002357
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 18:02:13 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GM1mbx007675
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 22:01:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: file_contexts patch
Date: Sat, 17 Jul 2004 08:02:08 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040716201531.GB4940@obadja.jmh.mhn.de>
In-Reply-To: <20040716201531.GB4940@obadja.jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407170802.08072.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 17 Jul 2004 06:15, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> The attached patch adds some file_contexts and most importantly labels
> libs under /opt correctly.

Why does kdesktop_lock need to be labelled as screensaver_exec_t?  The problem 
that caused the creation of the screen saver policy has only been reported 
under GNOME, and kdesktop_lock has been working well for me for years without 
such policy.

What is /dev/usbscanner?  It's not in devices.txt in the kernel source and not 
installed by default on any Debian or Fedora system.

The other stuff seems fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
