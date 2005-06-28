Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5SFOwgA004353
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 11:24:58 -0400 (EDT)
Received: from web31611.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j5SFOGaC025882
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 15:24:16 GMT
Message-ID: <20050628152416.26965.qmail@web31611.mail.mud.yahoo.com>
Date: Tue, 28 Jun 2005 08:24:16 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: RE: Alternative user management approach
To: Frank Mayer <mayerf@tresys.com>, russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200506281244.j5SCiqqc027274@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Frank Mayer <mayerf@tresys.com> wrote:


> The problem is building a general mechanism that can
> handle nearly any situation.

It usually is. I wanted to point out particulars that
might
help out when y'all are making some of those tougher
tradeoff decisions.

> I agree that over the past 20+ years,
> most MLS applications I've
> seen use a small portion of the possible lattice
> supported. However they use
> differing portions.

Yes, that's true. The Military tends to use levels,
while
civilian supercomputer sites use categories. I can't
recall
a single instance where both were used on the same
site.

> And some applications, in
> particular compartmented mode
> applications, can use many categories with the
> potential for a large number
> of points in the lattice being assigned to specific
> users. Worse users can
> be granted and removed access to lattice points
> (i.e., categories) now and
> then. 

I have rarely seen anyone in more than one category
at a time.

> Nonetheless I agree with Steve's earlier suggestions
> that we just have to
> figure a way to build a number of "roles mapping
> users", potentially on the
> fly, to account for any set of levels that a site
> may want to assign to a
> user. 

I think that I like the concept. It may have other
applications for policy simplification as well.

> MLS will be a small % of the SELinux systems
> used, and a small % of
> those will use more than a few security levels.

It was a glorious day when MLS made the
transition from Lunitic Fringe to Fringe.

> Most of the traditional uses
> of MLS systems are better addressed by type
> enforcement, as our application
> experience shows us every day.

I don't buy that yet, but I'm willing to
leave open the possibility that it could
be true.

> So a little pain for
> MLS SELinux boxes is not
> unjustified for increased benefit of our suggested
> new user management
> approach IMHO. Frank

If y'all can keep it to a "little" pain
I doubt you'll see many complaints.



Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
