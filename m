Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9GHrGrT013373
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 13:53:16 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9GHq3i9016195
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 17:52:03 GMT
Date: Sat, 16 Oct 2004 19:04:14 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alex Ackerman <alex@darkhonor.com>
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov, ackermal@jmu.edu
Subject: Re: SELinux Testing Software/Scripts
Message-ID: <20041016180414.GB19398@lkcl.net>
References: <A52BEA1D8EE8634B9196A136333637B130F1@maat.darkhonor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B130F1@maat.darkhonor.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Oct 16, 2004 at 09:56:41AM -0400, Alex Ackerman wrote:

> capabilities of SELinux; i.e., making sure that SELinux functions as
> advertised when dealing with events of escalating privilege. 

 just a comment [other than privilege means private law]:

 as i understand it, there is no "escalation" present in SE/Linux,
 only that assigned in the minds of us humans.

 a good analogy for the way that SE/Linux works is door-cards and
 guards.

 outside a building, you are given a door-card by a guard: depending
 on whether you are on a list, your door-card will now give you
 access a) to an entry point into the building b) the right to go
 through certain doors inside that building.

 at _some_ doors inside the building, there will be another guard.

 if you attempt to go through a door (assuming your card allows you to
 do that), the guard will, depending on whether you are on a list, TAKE
 AWAY your present card and GIVE YOU A TOTALLY DIFFERENT ONE.

 that card might, or might not, give you the right to go back through
 the door you have just gone through (!).

 so, you can enter the university building, use your card to get into
 the lecture theatre, but your card is taken away from you when you
 enter the lecture theatre, and the card you are given only allows you
 to go to the toilet or to the exit out the building.

 in this "world", there is no "escalation" as such.

 certain rooms are only allowed to be accessed by certain people who have
 certain cards: you can only get to a certain place via a specific route
 if you are the right person.

 that's a bit different from "escalating privilege" because that implies
 hierarchy, which SE/Linux doesn't have, per-se.

 l.

 p.s. if this analogy sounds a bit weird, to help you tie it into selinux,
 the guards swapping cards at doors is managed by "domain_auto_trans".


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
