Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IJ66rT019425
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 15:06:06 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5IJ62rD005661
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 19:06:02 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 18 Jun 2004 19:04:31 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BbO3M-0002we-Ax
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2004 18:25:28 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BbOcR-0000LS-3j
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2004 19:01:43 +0000
Date: Fri, 18 Jun 2004 19:01:43 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040618190143.GQ362@lkcl.net>
References: <20040609144404.GJ5477@philips.com> <200406121819.57709.russell@coker.com.au> <20040612143714.GA28996@yggdrasil.localdomain> <200406131029.35825.russell@coker.com.au> <20040613012852.GA4210@yggdrasil.localdomain> <20040613075427.GZ2861@lkcl.net> <20040613154033.GA10171@yggdrasil.localdomain> <20040613160310.GA10763@yggdrasil.localdomain> <20040613232622.GA13617@yggdrasil.localdomain> <20040614033955.GA14338@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040614033955.GA14338@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 13, 2004 at 10:39:55PM -0500, Greg Norris wrote:
> On Sun, Jun 13, 2004 at 06:26:22PM -0500, Greg Norris wrote:
> > I case anyone else encounters this issue, I've submitted a bugreport
> > to the Debian bug-tracking system.  You can view it at
> > "http://bugs.debian.org/254219".
> 
> Ok, I've finally managed to get the package to install... it turns out
> that I needed to include chkpwd.te and inetd.se in my policy
> selections.  I'm not actually using the corresponding software for
> either, but they apparently include some definitions which are needed
> by other policies.

well done :)

greg, i am curious: the debian selinux policy packages that i
installed (1.12-1) i didn't get asked any questions about policy
selections.

at least, i don't _remember_ being asked any...

what gives?

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
