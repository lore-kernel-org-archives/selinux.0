Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0PIZ1Xf013267
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 13:35:01 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0PIYxvt016778
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 18:34:59 GMT
Subject: Re: Refpolicy: Add target to create tags file
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20060125155512.GA8779@thorium.jmh.mhn.de>
References: <20060125155512.GA8779@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 13:37:40 -0500
Message-Id: <1138214260.9344.92.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-25 at 16:55 +0100, Thomas Bleher wrote:
> The attached patch adds a target to the makefile to create a tags-file.
> It is ported from the old policy, with a few changes for refpolicy.
> It allows vim (and others) to quickly jump to the definition of
> interfaces, booleans, and so on.

Merged.

> Another neat feature: You can autocomplete all interface-names in vim
> with C-N and C-P if you have an appropriate tags-file. I find this very
> useful with the new (rather long) interface names.

If you think they're long, you should have seen very early prototypes of
refpolicy; many of the names were 50%-100% longer than they are now. :)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
