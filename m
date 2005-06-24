Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OFpPgA007214
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 11:51:25 -0400 (EDT)
Received: from web31601.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j5OFoo2B018503
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 15:50:50 GMT
Message-ID: <20050624155123.43926.qmail@web31601.mail.mud.yahoo.com>
Date: Fri, 24 Jun 2005 08:51:23 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: RE: file contexts and modularity
To: selinux@tycho.nsa.gov
In-Reply-To: <1119615710.12865.57.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> This is something that I think merits further
> discussion.  I think that
> the real problem is that the avtab size has grown
> far beyond what we
> originally anticipated and this is hurting us both
> in time (to
> manipulate policies, to load policies, and even to
> search the avtab) and
> in space (kernel memory consumption by the avtab is
> huge).  We certainly
> didn't expect the avtab to reach 484,677 distinct
> entries (FC4 strict
> policy) and even the targeted policy in FC4 is now
> up to 215886 entries.

With close to half a million (Ack!) rules you
end up with a memory burden that would be
excessive even if you could represent a rule in
a single byte. Oh sure, you could swap out rule
pages on a LRU scheme, or hash them to death,
but the basic problem is not the representation
of hundreds of thousands of rules, it's a matter
of having hundreds of thousands of rules. Good
heavens, the policy file is starting to look
like the IRS tax code.

The solution does not lie in the direction
of kernel hacking, as much fun as that is.

Why are there so many rules? You can correct
me if I'm wrong, but these (somewhat jaded)
eyes see a piecemeal approach to the
introduction of new rules. There is serious
effort going into defining policies that
match behavior and since there are so many
different behaviors there is an explosion of
rules required to match them.

I suggest that if you want to address this
issue properly you need to back away from the
current method of developing policy.

Design your policy, then implement it rather
than sniffing out what programs do and then
crafting a policy to accomodate their whims.
I suggest you begin with a policy that includes
exactly two domains, User and System. Create
the rule set that provides this two state level
of protection. If a policy with two domains is
too stiffling use more, but define them first.

I don't believe that this is an easy path,
nor would I expect it to be popular. On the
other hand I guarantee you'll reduce the size
of the policy by a factor of 10. I also opine
that the actual system vulnerability will
decline due to better understanding of the
policy. I will also help address some of the
issues floating about regarding 3rd party
policy creation, what with having a designed
policy that a developer can follow instead
of the notion of "run strace and audit and
do magic".

It's what we had to do to create Unix MLS
systems. The casualty rate wasn't too high,
although it's true that we didn't get invited
to lots of partys afterward. Oh well, y'all
knew the job was dangerous when you took it.



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
