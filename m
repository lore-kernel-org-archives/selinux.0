Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA02124
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 16:57:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA17445
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 21:55:08 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA17441
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 21:55:06 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: kernel warning
Date: Wed, 30 Oct 2002 22:56:39 +0100
References: <Pine.GSO.4.33.0210301642520.22794-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210301642520.22794-100000@raven>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200210302256.39163.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Oct 2002 22:45, Stephen Smalley wrote:
> > That isn't new; in prior releases, the SELinux-specific patch set the
> > SELinux option defaults in defconfig and set EXTRAVERSION to -selinux in
> > the top-level Makefile, so it wasn't appropriate for LIDS or DTE users
> > anyway.
>
> By the way, the EXTRAVERSION change was requested by you a year ago
> (distribution of kernel patches thread on the selinux list).  But I get

Correct.  However unofficial Debian policy regarding kernel patches changed 
after that time and I reluctantly changed my packages to match.

> the impression that you've been dropping the Makefile and defconfig
> changes from your kernel patch packages (not sure whether you have been
> including the netsyms.c changes, those are needed for building Selopt as a
> module, and are #ifdef'd appropriately).

I've just built a new kernel-patch package with this.  I'll upload it now.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
