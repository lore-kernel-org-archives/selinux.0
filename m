Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h47IBKI4011548
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 14:11:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h47IBJ7R016784
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 18:11:19 GMT
Received: from hal.istation.com (hal.istation.com [65.120.151.132])
        by jazzband.ncsc.mil  with ESMTP id h47IBIKP016770 for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 18:11:19 GMT
Reply-To: <kbottner@istation.com>
From: "Keith Bottner" <kbottner@istation.com>
To: "'Nick Gray'" <nagray@austin.rr.com>, <selinux@tycho.nsa.gov>
Subject: RE: SELinux and LFS
Date: Wed, 7 May 2003 13:09:40 -0500
Message-ID: <000201c314c3$d433ab00$ae977841@istation.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1052323369.1487.46.camel@celestial>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick,

I think this is a great idea. I am very interested in your results. I
have been thinking of doing something similar but as of yet have had no
time to pursue it. Please keep us informed of your progress.

Keith Bottner
kbottner@istation.com

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Nick Gray
Sent: Wednesday, May 07, 2003 11:03 AM
To: selinux@tycho.nsa.gov
Subject: SELinux and LFS


All,

I introduced myself several months back. I work on a MLS project for the
ONI. We have been evaluating SELinux for awhile. A couple of months ago
I raise a question, within our group, about the viability of using
RedHat as a base for a secure system. I believe that certification of a
system based on a (almost any) distribution would be rather difficult to
achieve. This coupled with the fact that a Redhat server that was under
scrutiny here at the lab, continued to contact Redhat via HTTPS despite
my efforts to remove the software responsible. I actually found circular
dependencies in the packages.

This led me to the question, Does anyone remember when we used to build
this things from scratch. In answer to that question, I found a web site
which I have been playing with for the last couple of weeks called
appropriately enough "Linux from Scratch" so far I have been able to use
LFS as the starting point for a CDROM based Linux gateway/firewall.I
started a build of SELinux on a LFS system, but had several problems
including discovering what I believe are a couple bugs in the code.I
have put it aside for the moment to work on a couple of other things,
but I will return to this when I get the chance.

I am interested in whether anyone on the list has used this as the
starting point for SELinux and what the results where. 

In the next day or so I will post the problem I found in the makefile.
Perhaps it is either a known issue or doesn't come up on Redhat based
systems. In a separate post I will address a problem I found in string.h
(as soon as I get a chance to figure out what the problem is)

Don't get me wrong, I have nothing against Redhat. I'm just not sure
that I could keep a straight face when placing this in front of the
accreditors.

Any comments/discussion would be appreciated 

Nick Gray
Senior Network Engineer
Bruzenak Inc.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
