Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4OISORb012733
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 14:28:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4OISLAR005452
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 18:28:21 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4OISLHn005449 for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 18:28:21 GMT
Subject: Re: [PATCH][RFC] Allow administrator control over per-user
	default_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200405241725.i4OHPmRs008204@turing-police.cc.vt.edu>
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil>
	 <200405212213.i4LMDLZM005446@turing-police.cc.vt.edu>
	 <200405240612.15645.russell@coker.com.au>
	 <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil>
	 <200405241725.i4OHPmRs008204@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1085423295.26446.185.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 May 2004 14:28:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-05-24 at 13:25, Valdis.Kletnieks@vt.edu wrote:
> No, I was clear on that distinction (and was counting "domains" as being more
> akin to group membership).  On the other hand, I've had the joy of running
> larger systems back in the "old days" when NGROUPS_MAX was still 8 or 16 or
> whatever it was for NFS back in SunOS 3.5/4.0 days, and I had literally a dozen
> users pegged at the group limit (doesn't take long, when you have a 'cs_dept'
> group, then a "these 3 CS profs and 1 EE prof", a "same EE prof and 2 guys from
> Physics", and... you get the idea..).   One of our production machines (which
> has end-user userids on it) currently has 314 users and 273 groups defined....
> 
> I've gotten burnt too many times when a user who's in multiple groups has
> managed to screw things up with a 'chgrp' command (between the -R flag and file
> globbing, chgrp and chmod are dangerous for users ;) - so there's a real
> temptation to use roles to build a much higher wall between the contexts. And
> using the one production machine as an example, it's not at all clear that
> there is any really sensible halfway point between 300 people in 1 user_t
> domain and 250 domains with single-digit numbers of users...

Ok, but adding a $1_default_context_t type isn't going to make much of
an impact here, as there are already a number of $1_foo_t domains and
types derived from the base user domains.  Looks like we have around 25
domains and 44 file types defined for each of the user roles at present.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
