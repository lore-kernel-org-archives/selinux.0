Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA07246
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 16:33:02 -0500 (EST)
From: j.logsdon@lancaster.ac.uk
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1CLX1I14588
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 21:33:01 GMT
Received: from parmenides.zen.co.uk (parmenides.zen.co.uk [212.23.8.69])
        by jazzband.ncsc.mil  with SMTP id h1CLWxf14571 for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 21:33:00 GMT
Received: from localhost (j.logsdon@localhost)
	by quantex-research.com (8.8.7/8.8.7) with ESMTP id VAA03823
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 21:40:29 GMT
Date: Wed, 12 Feb 2003 21:40:29 +0000 (GMT)
To: selinux@tycho.nsa.gov
Subject: Re: Simple question
In-Reply-To: <200302121253.26502.pollard@admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.10.10302122051230.25327-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Jesse and Russell

You have explained a clear difference but presumably if the ACL for
setfacl etc are themselves restricted to root (or better another
privileged user) and/or they are moved from /usr/bin to /usr/sbin, there
is a another level of protection.  This doesn't protect you from a root
hacker of course, which is the key Unix weakness that SEL is trying to
eradicate.

So far I had the machine hanging from time to time which is probably
because of some inconsistency in the kernel options that I didn't
appreciate.  It's my fault I know but I can't afford that to happen on a
production system so if I can't fix it, at least I have a simple
alternative that does part of the job.  The issue of bind and dhcp as
examples won't come up - they are not needed fortunately but sendmail,
which is another candidate for hacking, and no doubt others will so there
will always be weaknesses.

As with all the moves in security, the ideal would be for them to be
incorporated into the official releases of the kernel but 2.5.x is already
getting pretty big and 2.6 when it is out (Q2/2k3?) will have so much more
in it that it's almost starting a new OS!

Obviously SEL is a much more sophisticated product and I may well go with
it but I am a little nervous at getting into deeper water than I am used
to!

Thanks again.

John

On Wed, 12 Feb 2003, Jesse Pollard wrote:

> On Wednesday 12 February 2003 12:32 pm, j.logsdon@lancaster.ac.uk wrote:
> > Hi
> >
> > In general terms, what does SEL do that I can't do (even if more
> > complicated) by Access Control Lists?  If I can control the users and
> > groups that can access files (and these are all properly set) what
> > advantage do I have in running SEL?
> 
> ACLs are under the control of the user. The user choses the other users that
> may access the files that the user owns.
> 
> SELinux is under the control of the security administrator. This includes the
> files that the user owns. Even if the user wants a specific other user to have
> access to a file, if that user is not in a domain containing the other user 
> (ie, both are in the same domain) then the other user still cannot access the 
> file.
> 
> > I'm not being rude - just trying to understand the difference and to see
> > whether it is really necessary to run a bespoke kernel.
> 
> The difference is in mandatory access vs descretionary access.
> 
> As far as the system files go, if all are carefully given approprate ACLs, 
> then they can be protected. However, if the root accout is hacked, the files
> are still vulnerable.
> 
> If a SELinux system is hacked, unless the hack itself contains an all powerful
> label/domain, the hack still doesn't have access to all of the files.. Only 
> those belonging to the domain of the hacked daemon.
> 
> Others may have more detailed/correct answers, but this should be the
> lowest common denominator.
> 
> -- 
> -------------------------------------------------------------------------
> Jesse I Pollard, II
> Email: pollard@navo.hpc.mil
> 
> Any opinions expressed are solely my own.
> 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
