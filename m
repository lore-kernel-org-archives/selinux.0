Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TH3trT020532
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 13:03:55 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TH3sCb012988
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 17:03:54 GMT
Subject: Re: udev and .dev...
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Erich Schubert <erich@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040729150921.GA17881@legolas.drinsama.de>
References: <20040729091423.GC6443@lkcl.net>
	 <20040729150921.GA17881@legolas.drinsama.de>
Content-Type: text/plain
Message-Id: <1091120582.21971.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 13:03:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-29 at 11:09, Erich Schubert wrote:
> This sounds like relabling hell :-) "make relabel" might even skip /.dev
> because it doesn't know the file system.
> You can't use "make relabel" to persistently fix labels on /dev.
> I don't know enough about automatic labelling by selinux. Maybe you'll
> need a udev which reads the file_contexts file. :-(
> (or a similar specification file)

I think in Fedora, udev is presently set up to invoke restorecon, which
uses the matchpathcon() function to obtain the proper context from the
file_contexts configuration and then relabels the device node to that
context.  There was a patch to udev to directly call matchpathcon() and
use setfscreatecon() to directly create the device node in the proper
context, but that seems to have been dropped.

make relabel omits bind mounts, to avoid obvious aliasing problems.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
