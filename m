Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PDfNrT005427
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 09:41:23 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PDfMuQ008589
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 13:41:22 GMT
Date: Wed, 25 Aug 2004 14:28:34 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy mods for xfs (to support xfstt and xfs-xtt)
Message-ID: <20040825132834.GB4241@lkcl.net>
References: <20040823232812.GB12720@lkcl.net> <200408252124.12152.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408252124.12152.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 25, 2004 at 09:24:12PM +1000, Russell Coker wrote:
> What is /usr/bin/xfs-xtt?  Contents-i386.gz doesn't list it.
 
 apt-cache show xfs-xtt:

	Description: X-TrueType font server
	This package provide X-TrueType font server. This is compatible
	normal X font server, but added X-TrueType font handling scheme
	support instead of FreeType backend. XFree86 4.0's font server
	can handle TrueType too, but it can not handle TTCap. By
	using TTCap description, support for font transformations,
	such as slanting, adjusting glyph width, pseudo-bolding, etc.
	.
	xfs-xtt is a daemon that listens on a network port and serves X
	fonts to X servers (and thus to X clients).  All X servers have
	the ability to serve locally installed fonts for themselves,
	but xfs makes it possible to offload that job from the X server,
	and/or have a central repository of fonts on a networked machine
	running xfs so that all the machines running X servers on a
	network do not require their own set of fonts.  xfs may also
	be invoked by users to, for instance, make available X fonts
	in user accounts that are not available to the X server or to
	an already running system xfs-xtt.


 apt-cache show xfstt:

 Description: TrueType Font Server for X11
	xfstt means "X11 Font Server for TT fonts".  TT fonts
	are generally regarded to be the best scalable fonts for
	displays. Applications needing scalable fonts that are to be
	displayed on a screen benefit most.  This server will allow
	X11 applications to use the exact same fonts as the TrueType
	fonts used on most Windows Machines.  NB: This package contains
	NO FONTS. They MUST be obtained separately


 i just installed them both.
 
 well... actually i installed all the font servers i could find.

 maybe i shouldn't have, but i don't care, they're there, ItWorks,
 ItAin'tBroken, IAintGonnaTouchItUnlessItBreaks.


> +allow xfs_t { etc_runtime_t }:dir { getattr search };
> 
> There should not be a directory of type etc_runtime_t (there is no 
> file_contexts entry for it).

 oops!

> What is /var/cache/xfstt?  

 i _really_ don't know!  i was in a hurry!

> The name implies that xfs would write to it, in 
> which case fonts_t is not the appropriate type label.  Changing the policy to 
> allow xfs_t to write to fonts_t changes the way things work.  I think that we 
> probably need different types for read-only files and writable files.
> 
> I've put a few things from your patch in my tree and attached the relevant 
> files in a tgz so we can work from the same base.

 ack.

 ta.  will be in a position to look at it on saturday.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
