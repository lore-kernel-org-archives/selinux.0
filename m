Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KD1urT017272
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 09:01:56 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KD1sT2026440
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 13:01:55 GMT
Date: Mon, 20 Sep 2004 13:22:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <method@gentoo.org>
Cc: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov,
   Chris PeBenito <pebenito@gentoo.org>
Subject: Re: [RFC] Upstream policy handling
Message-ID: <20040920122221.GL23901@lkcl.net>
References: <414DA0A7.1000708@gentoo.org> <1095631736.4431.27.camel@nexus.verbum.private> <414E153B.7070805@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <414E153B.7070805@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 19, 2004 at 07:24:43PM -0400, Joshua Brindle wrote:

> The divergence is not the problem, if divergence wasn't good then most 
> applications wouldn't exist today. There is no compelling need for every 
> vendor to shoehorn their policy into the sample, adding bloat and 
> causing it's analyzability to go down. 

... which is, in combination with the earlier responses about not
having divergent repositories, why i mentioned the thing about
multi-tagged CVS.

criteria to satisfy:

	1) the sample "strict" policy must be managed
	   exclusively by stephen et al.

	2) the sample "strict" policy should not include
	   absolutely everything [auditability and maintenance]

	3) ideally, REDHAT, Gentoo, Debian policies should be
	   based on the "strict" policy [too much work otherwise]

	4) ideally, all policies in 3) _should_ also be managed
	   through stephen et al {_someone's_ gotta be responsible]

	5) ideally, there should _be_ no number 3) above but
	   realistically this is in conflict with 2)

	6) there should be no distro "tunables" in the sample
	   "strict" policy.

therefore, a means to satisfy these criteria is to have a CVS repository
per distribution which contains only the files that are different from
the "strict" one.

the reasons for recommending this double-tagged approach over the
"put-the-entire-lot-of-the-nsa-strict-policy-files-into-another-cvs-tag"
approach are two-fold:

	1) maintaining totally separate cvs tags is a maintenance headache:
	   it's merge, merge, merge and it's boring.

	2) having separate tags FORCES maintainers of BOTH tags to be alert.

	   any commits in say the NSA tagged location will IMMEDIATELY be
	   pulled in by anyone doing a cvs update, NOT just when they next
	   do a merge-merge-merge.

	3) having a separate tag for REDHAT files that are additional or
	   different from the NSA tag minimises people's desire to _create_
	   such differences in the first place!


enough said: i won't mention this issue any more, it's up to you to
decide if a future maintenance headache warrants the above solution.

l.

p.s. if you like i can create a tiny test cvs repository plus example
cvs commands which demonstrates the principle of multi-tagging.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
