Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA00090
	for <selinux@tycho.nsa.gov>; Tue, 12 Nov 2002 16:36:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA26199
	for <selinux@tycho.nsa.gov>; Tue, 12 Nov 2002 21:34:02 GMT
Received: from pandora.snu.edu ([204.126.2.1])
	by jazzswing.ncsc.mil  with SMTP id VAA26192
	for <selinux@tycho.nsa.gov>; Tue, 12 Nov 2002 21:34:00 GMT
Message-Id: <sdd11fd2.035@atlas.snu.edu>
Date: Tue, 12 Nov 2002 15:35:26 -0600
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <selinux@tycho.nsa.gov>
Subject: Re: SELinux distro building
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>I think that autoconf would be good for this.  Also perhaps my script
for 
>extracting header files from the kernel patch (instead of from a
kernel 
>source tree) would be a good addition to the distribution.

I agree, thats pretty much what i was thinking about. I can't even
imagine trying to distribute code to the public without a configure
system. If someone is more familiar with autoconf and the basic build
process of selinux than me then i'd be very gracious if they worked on
this

>I think it would be good to have the selinux-small split into two
parts, one 
>for the header files and library code for compiling applications, and
the 
>other for policy, run_init, etc.

EXACTLY!. the libs have to be installed before the policy compiler
anyway, they should be 2 separate packages. Either that, or
selinux-small should know how to link to libs in it's own directory
before being installed, a single package with several "install" steps
isn't a clean implementation, and makes distro packaging a pain.

>I agree.  Perhaps if I had posted patches here in the past rather than
just 
>talking about it then something would have happened.  I suggest that
you post 
>your patches here.

My patches are basically hacked INSTALLPREFIX and fixed paths into the
Makefile, it is clearly not something that would be helpful, autoconf
would be much better.



Joshua Brindle
UNIX Administrator
Southern Nazarene University

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
