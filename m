Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TK4JrT022094
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 16:04:19 -0400 (EDT)
Received: from smtp806.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TK4HCb020048
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 20:04:18 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp806.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 20:04:18 -0000
Date: Thu, 29 Jul 2004 21:15:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev and .dev...
Message-ID: <20040729201519.GH9950@lkcl.net>
References: <20040729091423.GC6443@lkcl.net> <4108EE75.6040109@gentoo.org> <1091110451.7878.87.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091110451.7878.87.camel@icampbell-debian>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 03:14:11PM +0100, Ian Campbell wrote:
> On Thu, 2004-07-29 at 13:32, Joshua Brindle wrote:
> > Why not have a minimal /dev for init and friends and mount the ramfs for 
> > udev on top of it? it's much easier to deal with 1 /dev and this is 
> > pretty standard anyway.
> 
> I believe what happens is that the on disk dev does live at /dev and the
> udev initscript bind mounts it to /.dev before mounting the rams over
> the top so that you can still get at the on disk version.
 
  presumably in order to sort it out (for admin purposes)

 and in this case, thank goodness for that, because otherwise
 it would be necessary to terminate udev in order to set the
 selinux permissions on the "real" /dev.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
