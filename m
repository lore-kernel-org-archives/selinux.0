Message-ID: <20040131044945.36671.qmail@web21402.mail.yahoo.com>
Date: Sat, 31 Jan 2004 15:49:45 +1100 (EST)
From: =?iso-8859-1?q?Leigh=20Purdie?= <intersect_alliance@yahoo.com.au>
Subject: SELinux auditing - proposal
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've seen quite a few messages over time asking about
the potential for integrating auditing into SELinux -
and a few more asking about a nice user interface to
such an audit subsystem.

A few methods have been proposed over time. I'm not
sure if these have fizzled, or are still being worked
on, but I thought I'd throw another option into the
mix.

'Snare for Linux' has been around for a while now, and
is really starting to solidify in terms of
feature-set, and effective performance (thanks largely
to a few key contributors - a couple of which are
active members of the SELinux list).  Note: From
memory, Stephen S@nsa has already had a look at the
Snare stuff, with a view to using it with SELinux - so
please forgive me if this has been dicussed before,
and has already been rejected.

Although system level (c2/capp style) auditing is not
something that most users are interested in on a
day-to-day basis, the user profile of SELinux and
Snare overlaps to a large extent.

There are plenty of organisations out there that are
using, or are looking at using Snare - Sikorsky
helicopters, Raytheon, Lockheed Martin, NASA, Miltec
Missiles, HP, General Dynamics, many DoD sites in the
US and in Australia... etc. RedHat have also looked at
including Snare with Advanced Server once we have
everything stable & happy, and DISA & Mitre are
recommending Snare for installation in DoD linux
boxes. This doesn't mean that Snare is the best thing
since sliced bread, by any means - it just implies
that it seems to meet their requirements at this point
in time.

Snare has a kernel-patch component, a daemon portion,
and a nice GUI interface that, in combination, tries
to make auditing a lot easier to get into on Linux
than other operating systems.

A lot of people are starting to ask us when Snare is
going to make it into the kernel. Alan Cox has
suggested that 2.7 may be a possibility. Andrew Morton
reckons that 2.6 inclusion might be viable (subject to
many conditions). However, I think Snare would benefit
a great deal by yanking it out of it's 'standalone
application' mode, and integrating it in with a
project that focuses on a broader security
framework... Hence this message.

So down to the question: Do people think that making
Snare a component of SELinux would be of benefit to
both projects?
If so, how can we make it happen, and would anyone be
interested in helping out?

If the first thing that pops into your mind is "what's
a snare":
http://www.intersectalliance.com/projects/Snare/index.html

Regards,

Leigh.
(Snare Developer - InterSect Alliance)

http://greetings.yahoo.com.au - Yahoo! Greetings
Send your love online with Yahoo! Greetings - FREE!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
