Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7J4tBrT024937
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 00:55:12 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7J4t8EE016116
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 04:55:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: idea - running setfiles out of inetd!
Date: Thu, 19 Aug 2004 14:55:02 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
References: <20040817194712.GV18321@lkcl.net> <200408181956.46017.russell@coker.com.au> <20040818160459.GH19646@lkcl.net>
In-Reply-To: <20040818160459.GH19646@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408191455.02780.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Aug 2004 02:04, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > What if udev spawns "setfiles -q -s" and then sends the file names down
> > the pipe to it only closing the pipe after a certain time period of no
> > new nodes?
>
>  okay, cool...
>
>  so.... hey yes, of course.
>
>  yes, so that could be run from the main udev process, i get it.
>
>  and you exec each udevstart to create the file name, and then
>  send the same filename down to the "setfiles -q -s".

Yes.

>  is using popen() okay to do that?

Should be.

>  what implications [on policy writing and also security]
>  will it have to be running setfiles from inside udev
>  (bearing in mind that popen involves a pipe and a fork)

Nothing significant.  I don't think we'll have a domain transition (don't want 
it to relabel arbitrary files), just have it run in udev_t (which should 
already have most if not all the access needed for this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
