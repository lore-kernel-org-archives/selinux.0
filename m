Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA07664
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 15:08:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA16805
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 20:08:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id UAA16801
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 20:08:31 GMT
Date: Tue, 6 Feb 2001 15:08:21 -0500 (EST)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200102062008.PAA04494@coalstove.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: PPC port of SELinux
Cc: rbsmith@sandia.gov
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

I'm not aware of any port underway to the Power PC, nor is it something
likely to ever be a priority for the NSA team.  If someone else wants
to port to the Power PC, or in fact has done any work extending the
system please keep the list informed so that we don't have people
duplicating each other's work and consider making your work in progress
available.  In general, as has already been said, we think the effort
for most hardware ports should be low.  There are certainly bound to be
a few problem areas, particularly as the first few ports weed out
subtle x86 assumptions.

For my part of keeping the list informed I'll say that the NSA team has
as its priorities demonstrating the security features to the community
and exploring research aspects of policy and implmentation.  We also
try to fix egregious user interface problems just to keep the system
usable.  Specificly that means for the time being we're concentrating
on making certain that kernel interfaces are adequately controlled and
porting to current kernel versions.  Application policies and ports to
other hardware are not going to be a priority until the kernel work is
a lot more complete.

rbsmith@sandia.gov wrote:
> Is anyone working on a Power PC / Macintosh G4 port of SELinux? If so, can
> you say something about the status of the work?
> 
> Also, can anyone provide a ballpark estimate on the level-of-effort for the
> 2.2.12 enhancements and/or the anticipated effort for the 2.4 port?

--
Howard Holm <hdholm@epoch.ncsc.mil>
Information Assurance Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
