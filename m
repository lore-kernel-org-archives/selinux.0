Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA08744
	for <selinux@tycho.nsa.gov>; Sat, 30 Dec 2000 16:12:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA09402
	for <selinux@tycho.nsa.gov>; Sat, 30 Dec 2000 21:11:55 GMT
Received: from tomts7-srv.bellnexxia.net (tomts7.bellnexxia.net [209.226.175.40])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA09366
	for <selinux@tycho.nsa.gov>; Sat, 30 Dec 2000 21:11:55 GMT
Received: from judy ([207.236.16.190]) by tomts7-srv.bellnexxia.net
          (InterMail vM.4.01.03.00 201-229-121) with SMTP
          id <20001230211220.MVHG1081.tomts7-srv.bellnexxia.net@judy>
          for <selinux@tycho.nsa.gov>; Sat, 30 Dec 2000 16:12:20 -0500
From: "Frank Stratton" <fstratton@sympatico.ca>
To: <selinux@tycho.nsa.gov>
Subject: RE: porting to 2.4?
Date: Sat, 30 Dec 2000 16:09:20 -0500
Message-ID: <NCBBLGKNMLBJBPOFEOHMOEKKEKAA.fstratton@sympatico.ca>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.SOL.3.95.1001229100358.9554B-100000@clipper.gw.tislabs.com>
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

I'm new to this list.  My first Linux version was Kernel 0.99 PL113 and have
not done much hacking for a few years.  I'm just getting back into it and
setting up a couple of test platforms.  I've worked on B1 and B2 operating
systems so I have some feeling for secure systems.  I will help in any way
that I can.  I can write in C but have not done so in a few years.  I can
run system tests since I currently test firewalls and VPNs. I have a lab
here that I can set up any way you wish.  Let me know.

Frank Stratton

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Stephen Smalley
Sent: Friday, December 29, 2000 10:15 AM
To: selinux
Subject: Re: porting to 2.4?



On Wed, 27 Dec 2000, Steven King wrote:

> Is anyone already working on this?  I've been looking at it and it seems
like
> it should be fairly straight forward...

We haven't started a port to the 2.4 kernel yet, other than
some preliminary analysis of the differences between 2.2 and
2.4 by a relatively new member of the NSA SELinux team.  His
assessment was that a port could be quite involved due to the extent
of changes between 2.2 and 2.4, but I'm not sure how significant
those changes are for our modifications.  In addition to porting
our existing changes, we would want to address new features in the
2.4 kernel.  Since we have a small development team, we have to
carefully balance between porting what we have to newer kernel versions
and doing further security development.  If you are interested in
assisting in a port to the 2.4 kernel, let us know.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
