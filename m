Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TKQUrT022293
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 16:26:30 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TKQSCb020845
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 20:26:29 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 20:26:19 -0000
Date: Thu, 29 Jul 2004 21:37:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Erich Schubert <erich@debian.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev and .dev...
Message-ID: <20040729203724.GL9950@lkcl.net>
References: <20040729091423.GC6443@lkcl.net> <20040729150921.GA17881@legolas.drinsama.de> <1091120582.21971.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091120582.21971.119.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 01:03:02PM -0400, Stephen Smalley wrote:
> On Thu, 2004-07-29 at 11:09, Erich Schubert wrote:
> > This sounds like relabling hell :-) "make relabel" might even skip /.dev
> > because it doesn't know the file system.
> > You can't use "make relabel" to persistently fix labels on /dev.
> > I don't know enough about automatic labelling by selinux. Maybe you'll
> > need a udev which reads the file_contexts file. :-(
> > (or a similar specification file)
> 
> I think in Fedora, udev is presently set up to invoke restorecon, which
> uses the matchpathcon() function to obtain the proper context from the
> file_contexts configuration and then relabels the device node to that
> context.  There was a patch to udev to directly call matchpathcon() and
> use setfscreatecon() to directly create the device node in the proper
> context, but that seems to have been dropped.
 
 the little program - udev_selinux - uses setfilecon not setfscreatecon.

 it's a separate program, similar to restorecon in fact it is
 likely to be the same.

 it's run post-thingy.  post-create.

 also, symlinks aren't covered / managed / created.

 looks like a proper job's needed.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
