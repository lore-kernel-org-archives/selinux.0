Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5BECuI4023676
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2003 10:12:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5BECh5e003510
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2003 14:12:43 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h5BECg92003507 for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2003 14:12:43 GMT
Subject: Re: Policy transport, management, application installation, etc
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Tom <tom@lemuria.org>, Joshua Brindle <JBrindle@snu.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030611093016.C12287@lemuria.org>
References: <see628a5.002@atlas.snu.edu> <20030611093016.C12287@lemuria.org>
Content-Type: text/plain
Message-Id: <1055340740.2660.317.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 11 Jun 2003 10:12:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you haven't already seen it there was considerable discussion about
managing SELinux within an RPM framework about a year ago. 
Unfortunately, I think more was said than done.

http://www.nsa.gov/selinux/list-archive/1645.html This thread has a lot
of thinking about how to construct RPMS for SELinux, although you'll
have to hunt through the messages for it.  (Of course, I'm partial to my
opinions expressed there.)

http://www.nsa.gov/selinux/list-archive/1501.html This thread also has
some concepts I think are important about trying to manage different
distribution provided policies in concert with local policies.

On Wed, 2003-06-11 at 03:30, Tom wrote:
> On Tue, Jun 10, 2003 at 06:50:54PM -0500, Joshua Brindle wrote:
> > Policy management:
> >   How should the package manager deal with policies.
> 
> Not at all.
> 
> The policy is definitely NOT part of the user-space program, and it has
> no business messing with it. The policy is set by the system (or
> security) administrator, and may well be very different on different
> systems for the same program.
> 
> Also, remember that SE tries to be transparent to most software.
> 
> 
> >   This seems bad, playing with the users policy can't be a good thing,
> >   but installing files with incorrect labels can't either. 
> > 
> >   Without doing this the user would be installing apps that either
> > don't 
> >   have the proper labels to enforce proper use, or apps that just 
> >   plain don't work
> 
> I am convinced that there is no solution but a secondary infrastructure
> for policy management. On all accounts, this does make sense. Think
> seperation of function and control.
> 
> Setting up the policy is the responsibility of - well, whoever is
> responsible for the security of the system in question. I would go so
> far to say that the package manager should be considered an untrusted
> piece of software. On a regular Unix, the package management tool can
> essentially own you. On SE, we can prevent this, maintaining system
> integrity provided we are willing to leave the core tools untouchable
> by the package manager (or only touchable if run from a specific role).
> 
> (Yes, I still have that dream of a "core system" that is small and can
> be shown to be secure, and an outer layer that doesn't necessarily have
> to be trustworthy. A "ring 0" equivalent, if you want.)
> 
> Anyway, we can help the starting-out admins by providing examples and
> default policies, though we definitely have to set up a better
> management process for that, see my earlier mail.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
