Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1PJpNRb002299
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 14:51:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1PJpMQQ022069
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 19:51:22 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i1PJpMP0022064 for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 19:51:22 GMT
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16444.64693.876556.280002@neuro.alephnull.com>
Date: Wed, 25 Feb 2004 14:51:17 -0500
From: Rik Faith <faith@redhat.com>
To: Joshua Brindle <jbrindle@snu.edu>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [selinux] Re: identity
In-Reply-To: [Joshua Brindle <jbrindle@snu.edu>] Tue 24 Feb 2004 16:45:30 -0600
References: <Xine.LNX.4.44.0402240945330.24455-100000@thoron.boston.redhat.com>
	<1077634629.21221.80.camel@moss-spartans.epoch.ncsc.mil>
	<1077653032.22405.36.camel@kusturica>
	<1077655261.21221.191.camel@moss-spartans.epoch.ncsc.mil>
	<403BD40A.4010200@snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue 24 Feb 2004 16:45:30 -0600,
   Joshua Brindle <jbrindle@snu.edu> wrote:
> On this note, are any of the selinux distro guys looking at integrating 
> any specific auditing framework with selinux?

I've been working on this and I'll post a patch under a new topic later
today (what I've implemented does not currently contain an identity
feature, but it could be added without much work).

> We've looked at SAL a while back but it was very unsuitable at the
> time, and have plans to look at snare, are there others?

I have looked at several system-call auditing frameworks but, in
general, they:
    1) did not integrate with SELinux (which often meant they did a
       tremendous amount of work that is subsumed by LSM), and
    2) they had broader goals (i.e., performance monitoring/tuning or
       debugging, for which they were willing to take a performance hit
       that is not reasonable to take for always-on security auditing).

> If someone is alreay working on this let me know as I'd like to help.

Great!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
