Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0PIsaXf013626
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 13:54:36 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0PIrMQk023854
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 18:53:23 GMT
Subject: Re: Refpolicy: Add target to create tags file
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1138214260.9344.92.camel@sgc.columbia.tresys.com>
References: <20060125155512.GA8779@thorium.jmh.mhn.de>
	 <1138214260.9344.92.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 13:57:16 -0500
Message-Id: <1138215436.9344.96.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-25 at 13:37 -0500, Christopher J. PeBenito wrote:
> On Wed, 2006-01-25 at 16:55 +0100, Thomas Bleher wrote:
> > The attached patch adds a target to the makefile to create a tags-file.
> > It is ported from the old policy, with a few changes for refpolicy.
> > It allows vim (and others) to quickly jump to the definition of
> > interfaces, booleans, and so on.
> 
> Merged.

I forgot to mention that I changed the ctags program detection to be
based on the DISTRO setting, since Gentoo has a different command too,
and I made "ctags" the fallback command.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
