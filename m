Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AEDeLa009097
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 10:13:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8AEC3LY029808
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 14:12:03 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id h8AEC2sG029805
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 14:12:02 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AEDcAi029134
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 10:13:38 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h8AEDcqR029132
	for selinux@tycho.nsa.gov; Wed, 10 Sep 2003 10:13:38 -0400
Message-ID: <3F5ED720.3090206@hotmail.com>
Date: Wed, 10 Sep 2003 08:47:44 +0100
From: James de Lurker <jtl2nospamMUNGIEjump@hotmail.com>
Reply-To: see.the.sig.2.reply.by.email.offlist@hotmail.com
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: Another small SE presentation
References: <20030909215414.K6475@lemuria.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Feedback to Tom's question. OT for a developer list, perhaps, but
I hope that you find my "end user" experiences valuable for
future promotion of the selinux project.

Tom wrote:
 >During a private, small meeting (about 20 people) in London this
 >weekend, I gave a shortened version of the CCC presentation that
 >Carsten I made in August. The audience was exclusively computer
 >security people. There was a lot of interest, many questions including
 >fairly deep ones, e.g. polyinstantiation or comparisons to other
 >systems.

 >It seems to me after these last events that SELinux is by far not as
 >well known as I would have thought. I'm a bit surprised by that. Is
 >anyone else?

Not at all. I've attended three selinux presentation events, taken a keen
interest in the selinux project from first release, and built one test
system a year ago and used it actively for four months until rpm stopped
working for package upgrading and removal for no reason that I could
fathom.
( Seen recently - glibc updating sub-arch issues a likely culprit )

There was considerable interest even for the early RH6.2 incarnation!
To the point where I was asked to include a briefing on it during a
due diligence meeting with Austrian Venture Capitalist Analysts on
behalf of a client building secure systems for the German speaking
market.

The succint answer to your question is obvious to anyone involved in 
raising market awareness, and gaining "market share" of new technical
innovations.

     Packaging - and promotion that will engage non specialists.

A knoppix-like CD. A "kickstart" CD that can painlessly install a
command line only basic version of the most current selinux; doing all
the necessary tweaking and post config things automagically to bring
a basic installation to a known good state for testers and systems
folk: persuading "the boss" to put an se box in a realistic real world
environment when there is a straightforward point of reference that
management can understand and accept as a low risk support exercise.

If Russell's recent article in The Linux Journal had a complementary
no brainer trial install CD on the cover - you'd have been swamped with
interest to the point where the developer list would have needed a
companion "end user, tester" list to divert the non developer traffic

Imagine the attendance at selinux presentations in more general venue
industry events ( InfoSec 200? Olympia ) if you were handing out trial
CDs where folks could go away and build a reference system _exactly_
the same as used for the presentation, with simple HOWTO newbie type
documentation. Advertised in advance, of course...

I used to build custom, secured Linux systems and have been commissioned
to build dedicated kickstart install CDs for server building and cloning.

Also used to do software development, involved with crypto and datacomms,
so I can just about cope at the level that exists on the selinux list
and the Wirex LSM lists. I don't pretend to be as productive a C
programmer, or as capable as people here who I'd be struggling to
compete with even if I turned the clock back 15 to 20 years!

There will be ( or _should_be_ ) dozens of "systems" and "tester" grade
people that could contribute valuable testing hours and feedback. But
the level of pain and attention to figure out what the snapshot status
of the project is, and what patches posted to this list are necessary,
is far too high, even for me, to cope with :-(

Making each patch "self documenting", and a periodic "patch FAQ" that
listed everything necessary in simple steps from the last kernel.org
reference kernels ought to be posted to the list for folk that don't
work from CVS. Where patches are distro dedicated ( Debian, SuSe, whatever)
make that obvious at a glance. I've just downloaded Russell's patches
to 2.4.22 and 2.6.0-test5 UML but am clueless if they will work with
the RedHat base distributions, or are Debian dedicated, only. Obvious
to Russell and other leading developers perhaps, but not to me!

I tried syncing to CVS - from a modem connection with a 2 hour cut-out!
Not an experience I'd care to repeat. CVS is way too scary and elite a
reference. Even if it is as autonomous as breathing for the top 10% of
active CS educated software developers. Not for me it isn't.

   ( Advice on how to work from CVS with this limitation appreciated )

The early rpm packages didn't work. There were no SRPMS available at
that time, and no clear documentation about status of "packaged" versions
so that I had any real chance of fault isolation and fixing what was
broken without considerable pain.

CVS isn't trivial as a first point of contact. So the "duplication"
of regular status and HOWTO documentation posted to a list is essential.
Someone will have to spend time bridging the gap between the top
contributors' posting patches and the head scratching system builders
and commercial deployers such as moi motivated to be on the receiving end

I am dismayed by all the distribution forks. I've been a RedHat distro
person (only) from 1998. Maybe their ought to be distro dedicated
subscriber lists to carry regular HOWTO postings and distro dedicated
traffic.

In August the project has forked base distributions that I need to
support: RH9 now, not just the reference RH7.2 base system that I built.
So I'm spending time creating and maintaining 2 base install backups for
my kit instead of just one, as per a year ago. The entry cost bar has
been raised to proper testing. I'd had preferred to remain with the old
RH7.2 GCC and libc base for development and 2.4.xx mainstream. Few of
my selinux boxes will be graphical and GUI enabled. As I tend to deploy
testing stuff on older kit - XFree86 driver rewrites have rendered (sic)
graphical interfaces useless on many of my legacy PCI video boxes, so all
my software development and building is still done on RedHat 7.x desktops.

The issue on the list recently of segfaulting due to weird sub-arch
glibc updating issues is a case in point. How many people ( like me )
will call it a day when they end up with a dead end broken system; 
repeating the same mistakes that others have already unwittingly made?

At no point has the selinux documentation made the status of the base
distribution at all clear: Basic install CD, or fully upgraded with all
the update RPMS applied? Might be a good idea to document clearly the
sensitive aspects for people that sub-arch customize building their own
rpms from SPRMS for all updates. That is what ate my first selinux build.

Currently, I am just putting the finishing touches to a RedHat 9 command
line only full updated base system ready to put on the latest 2.6.0-t5
kernel with Russell's one liner patch... Hope that it works!! Wish it
didn't feel like making a shot in dark - like the bad old days when
system security patches to production Windows NT boxes had to be tested.

OK - with that point of reference, I feel much happier :-)

-- 

   -- James

 From and Reply To are INVALID.

All public postings use munged headers[1]- To contact me off list:
   1) Remove "M U N G I E j u m p" ONLY: leave that "nospam" in there!
   2) change "hotmail" 2 "myrealbox" after the @

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
