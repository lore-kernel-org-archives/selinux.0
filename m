Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72EkQrT012898
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:46:26 -0400 (EDT)
Date: Mon, 2 Aug 2004 15:57:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
Message-ID: <20040802145724.GG4194@lkcl.net>
References: <20040801172751.GD20103@lkcl.net> <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 02, 2004 at 10:00:23AM -0400, Stephen Smalley wrote:
> On Sun, 2004-08-01 at 13:27, Luke Kenneth Casson Leighton wrote:
> > hi,
> > 
> > does anyone know: the matchfilecon program reads
> > /etc/selinux/.../file_contexts/file_contexts.
> > 
> > does the matchfilecon libselinux1 api does the same?
> > 
> > or does it read a binary policy from somewhere?
> > 
> > the reason i ask is because if i were to code up stuff into
> > udev, it might solve the problem of having to move
> > /usr/share/selinux/stuff off of /usr and onto /etc.
> 
> Do you mean matchpathcon?  

 yes.

> No matchfilecon here.  matchpathcon(1) is
> just a trivial test program that invokes the matchpathcon(3) library
> function on its arguments and reports the result.  matchpathcon(3) reads
> the installed file_contexts configuration
> (/etc/selinux/$SELINUXTYPE/contexts/files/file_contexts), not the one
> from the policy source tree, as policy sources are optional.  

 ack, ta.

> Binary
> policy isn't relevant here, as it doesn't contain file contexts.  BTW,
> policy does live in /etc/selinux in Fedora Core 3 (or
> /etc/security/selinux in Fedora Core 2), and sounds like Russell has
> likewise moved it there in Debian.

 yes, i believe so - this is 1.14.

 so, conclusion, it's almost irrelevant as to whether matchpathcon(1)
 or matchpathcon(3) are used.

 therefore, i might as well leave udev's code alone.

 ... one thing though: running udev, it can only generate about 4
 device inodes per second when having to do
 /etc/dev.d/defaults/selinux.dev (which calls restorecon $DEVICENAME).

 that's _awfully_ slow.

 especially when creating 64 /dev/ttyxx nodes, 64 /dev/ttySxx nodes,
 and then a few /dev/ramX nodes too.

 it delays boot-time by over 30 seconds, basically.

 what, if anything, could be done about this?

 run a restorecon asynchronous service?

 yes, i realise that sounds a bit mad, but if people are going to throw
 150 device inodes up at boot-time, it's got to be quick.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
