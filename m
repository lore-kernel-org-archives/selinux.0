Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7QAnTrT012013
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 06:49:29 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7QAnR0g008139
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 10:49:28 GMT
Date: Thu, 26 Aug 2004 12:00:41 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy mods for xfs (to support xfstt and xfs-xtt)
Message-ID: <20040826110041.GC6382@lkcl.net>
References: <20040823232812.GB12720@lkcl.net> <200408252124.12152.russell@coker.com.au> <20040825132834.GB4241@lkcl.net> <1093472168.3759.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093472168.3759.5.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 26, 2004 at 12:16:08AM +0200, Erich Schubert wrote:
> Hi,
> are you aware that X11 does support TrueType fonts out of the box since
> version 4, removing the need for a truetype font server?
 
 *lol*.

 noooo :)

> In fact, in my experience it is best to avoid using font servers unless
> you have a reason to do so (for example with thin clients, where you do
> not want or maybe even cannot copy the fonts to the xserver itself)
> 
> I'd suggest you to only install and use stuff that is needed. The more
> you install, the more resources are needed, the longer the startup
> takes, and the more likely security issues will arise. (Even when a
> security issue with the font server is likely do be limited in damage by
> selinux, you still do not want it)

 okay, i get rid of them.

 thanks.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
