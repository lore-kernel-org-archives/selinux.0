Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA01279
	for <selinux@tycho.nsa.gov>; Tue, 12 Nov 2002 19:50:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA05676
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 00:48:09 GMT
Received: from web40018.mail.yahoo.com (web40018.mail.yahoo.com [66.218.78.58])
	by jazzswing.ncsc.mil  with SMTP id AAA05672
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 00:48:08 GMT
Message-ID: <20021113005009.53937.qmail@web40018.mail.yahoo.com>
Date: Tue, 12 Nov 2002 16:50:09 -0800 (PST)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: SELinux distro building
To: Joshua Brindle <JBrindle@snu.edu>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <sdd11fd2.035@atlas.snu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Joshua Brindle <JBrindle@snu.edu> wrote:
> >I think that autoconf would be good for this.  Also perhaps my script
> for 
> >extracting header files from the kernel patch (instead of from a
> kernel 
> >source tree) would be a good addition to the distribution.
> 
> I agree, thats pretty much what i was thinking about. I can't even
> imagine trying to distribute code to the public without a configure
> system. If someone is more familiar with autoconf and the basic build
> process of selinux than me then i'd be very gracious if they worked on
> this

I agree. Having an autoconf-based configure system for SELinux would be
wonderful, and it would make changing options and adding features to the libs,
progs, etc a snap. Does anyone know how to use autoconf and all its friends?

> 
> >I think it would be good to have the selinux-small split into two
> parts, one 
> >for the header files and library code for compiling applications, and
> the 
> >other for policy, run_init, etc.
> 
> EXACTLY!. the libs have to be installed before the policy compiler
> anyway, they should be 2 separate packages. Either that, or
> selinux-small should know how to link to libs in it's own directory
> before being installed, a single package with several "install" steps
> isn't a clean implementation, and makes distro packaging a pain.

Yup. That's another problem that I've had to put up with. If I had the time,
I would code this up and test it, but I don't :(

> 
> >I agree.  Perhaps if I had posted patches here in the past rather than
> just 
> >talking about it then something would have happened.  I suggest that
> you post 
> >your patches here.
> 
> My patches are basically hacked INSTALLPREFIX and fixed paths into the
> Makefile, it is clearly not something that would be helpful, autoconf
> would be much better.

Post them anyway. I might try them. 

> 
> 
> 
> Joshua Brindle
> UNIX Administrator
> Southern Nazarene University
> 

Brad

__________________________________________________
Do you Yahoo!?
U2 on LAUNCH - Exclusive greatest hits videos
http://launch.yahoo.com/u2

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
