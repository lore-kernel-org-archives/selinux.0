Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h47G2dI4010445
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 12:02:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h47G2c7R008770
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 16:02:38 GMT
Received: from clifford.graysdepoot.org (cs24243192-103.austin.rr.com [24.243.192.103])
        by jazzband.ncsc.mil  with ESMTP id h47G2bKP008765 for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 16:02:37 GMT
Received: from celestial.graysdepot.org (celestial.graysdepot.org [192.168.10.20])
	by clifford.graysdepoot.org (8.12.9/8.12.3) with ESMTP id h47G5Ehj017162
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 11:05:14 -0500
Subject: SELinux and LFS
From: Nick Gray <nagray@austin.rr.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 07 May 2003 11:02:49 -0500
Message-Id: <1052323369.1487.46.camel@celestial>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
