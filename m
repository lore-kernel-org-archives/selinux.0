Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4MLWqgA004276
	for <selinux@tycho.nsa.gov>; Sun, 22 May 2005 17:32:52 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4MLSPvh001336
	for <selinux@tycho.nsa.gov>; Sun, 22 May 2005 21:28:26 GMT
Date: Sun, 22 May 2005 22:37:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: depinit
Message-ID: <20050522213738.GS10156@lkcl.net>
References: <20050522174200.GP10156@lkcl.net> <1116794764.652.41.camel@chris.pebenito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1116794764.652.41.camel@chris.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 22, 2005 at 04:46:03PM -0400, Chris PeBenito wrote:
> On Sun, 2005-05-22 at 18:42 +0100, Luke Kenneth Casson Leighton wrote:
> > despite depinit being a core critical component of linux from
> > scratch, and thence, for some time, in gentoo, he has received
> 
> I'm not sure where you heard this; Gentoo has always used sysvinit.
> Depinit isn't even in the portage tree.
 
  odd.  time to read more carefully:

	  http://mail.lug.lk/lurker/message/20050428.084821.4711d463.en.html

 yep, you're absolutely right - it describes lfs as being similar to
 gentoo in that it's a source-code based distro, and describes _lfs_
 as having 3 startup options - one of them being depinit.

 i'm _sure_ i've also seen one other message about depinit being
 one of the early options for gentoo (a lfs derivative),
 and people going "hurrah" when it was removed in favour
 of sysvinit.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
