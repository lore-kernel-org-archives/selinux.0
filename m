Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i62LDPrT016086
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 17:13:25 -0400 (EDT)
Received: from p15107633.pureserver.info (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i62LDNdS014189
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 21:13:23 GMT
Date: Fri, 2 Jul 2004 23:08:13 +0200
From: Jan Gehring <pr0gm4@linoratix.com>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: Compiling error - sysvinit
Message-Id: <20040702230813.2416f740.pr0gm4@linoratix.com>
In-Reply-To: <1088791604.6478.6.camel@gorn.pebenito.net>
References: <20040702134850.353b2f51.pr0gm4@linoratix.com>
	<20040702071544.GA3277@lkcl.net>
	<20040702092526.GD3277@lkcl.net>
	<20040702190146.78697fe7.pr0gm4@linoratix.com>
	<1088791604.6478.6.camel@gorn.pebenito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Chris,

> > i tried to compile sysvinit-2.85 but i get the following error.
> > 
> > root@maracuja src # make LDFLAGS="-s -lselinux" CFLAGS="-D_GNU_SOURCE"
> > cc -c -D_GNU_SOURCE -DWITH_SELINUX init.c
> > [...]
> > init.c:97: error: `SELINUXMNT' undeclared (first use in this function)
> > [...]
> > init.c:123: error: `SELINUXPOLICY' undeclared (first use in this function)
> > make: *** [init.o] Error 1
> 
> Most likely you are trying to compile an older sysvinit patch against
> libselinux-1.14.  I saw this myself a few days ago.  These two #defines
> are gone in 1.14.  Best bet is to update your sysvinit patch.  I added
> back these two #defines back into Gentoo's libselinux-1.14 selinux.h for
> compatibility, which is another option.
> 
> The #defines were:
> 
> #define SELINUXMNT "/selinux/"
> #define SELINUXPOLICY "/etc/security/selinux/policy"

Thank you. this works fine.

Best regards
Jan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
