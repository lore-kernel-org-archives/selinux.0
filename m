Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6H1horT002935
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 21:43:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6H1hPbx011714
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 01:43:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: nfs policy fixes
Date: Sat, 17 Jul 2004 11:43:41 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040716193517.GA4940@obadja.jmh.mhn.de>
In-Reply-To: <20040716193517.GA4940@obadja.jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407171143.41804.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 17 Jul 2004 05:35, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> This patch adds some permissions for nfs homedirs. It only adds
> permissions which were already there for non-nfs homedirs.
> Additionally it dontaudits a small denial in gpg_macros.te.

That denial should be fixed in the calling code.  Ideally the MUA (or whatever 
program you are using) should close all file handles that aren't needed after 
the fork and before the exec.

The patch is good, I've included it in my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
