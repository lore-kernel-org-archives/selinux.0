Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PMGCrT009617
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 18:16:12 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PMGBuQ026659
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 22:16:11 GMT
Subject: Re: policy mods for xfs (to support xfstt and xfs-xtt)
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040825132834.GB4241@lkcl.net>
References: <20040823232812.GB12720@lkcl.net>
	 <200408252124.12152.russell@coker.com.au>  <20040825132834.GB4241@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 26 Aug 2004 00:16:08 +0200
Message-Id: <1093472168.3759.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
are you aware that X11 does support TrueType fonts out of the box since
version 4, removing the need for a truetype font server?

In fact, in my experience it is best to avoid using font servers unless
you have a reason to do so (for example with thin clients, where you do
not want or maybe even cannot copy the fonts to the xserver itself)

I'd suggest you to only install and use stuff that is needed. The more
you install, the more resources are needed, the longer the startup
takes, and the more likely security issues will arise. (Even when a
security issue with the font server is likely do be limited in damage by
selinux, you still do not want it)

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
       Die einzige Hoffnung auf Freude liegt in den menschlichen       V_/_
               Beziehungen. --- Antoine de Saint-Exupéry



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
