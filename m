Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IJNtrT022563
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 15:23:55 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IJNsRq004984
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 19:23:54 GMT
Date: Wed, 18 Aug 2004 17:04:59 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: idea - running setfiles out of inetd!
Message-ID: <20040818160459.GH19646@lkcl.net>
References: <20040817194712.GV18321@lkcl.net> <200408181956.46017.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408181956.46017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 18, 2004 at 07:56:46PM +1000, Russell Coker wrote:
> On Wed, 18 Aug 2004 05:47, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > i'd like to canvas people's opinions of running
> > "setfiles -q -s /etc/selinux/contexts/file_contexts" from inetd
> 
> Bad idea, anyone can call it.

 i've done root-only-accessible unix domain socket stuff before now,
 it's necessary to create a directory which is 0500 and then inside
 that the socket is 0600 [some unixen don't support permissions on
 sockets]

> > the alternative is, in the case of udev, to merge the functionality
> > of udevd and udevsend, such that the file context cacheing can
> > be taken advantage of.
> 
> What if udev spawns "setfiles -q -s" and then sends the file names down the 
> pipe to it only closing the pipe after a certain time period of no new nodes?
 
 okay, cool...

 so.... hey yes, of course.

 yes, so that could be run from the main udev process, i get it.
 
 and you exec each udevstart to create the file name, and then
 send the same filename down to the "setfiles -q -s".

 is using popen() okay to do that?

 what implications [on policy writing and also security]
 will it have to be running setfiles from inside udev
 (bearing in mind that popen involves a pipe and a fork)


 ... darn!  how many programs has udev been split into??? :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
