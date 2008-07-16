Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GGCbL0003138
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 12:12:37 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6GGCbhc009046
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 16:12:37 GMT
Subject: (u|r)bacsep: initial testing
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 16 Jul 2008 12:12:15 -0400
Message-Id: <1216224735.21191.50.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For those that are interested, the SELinux user-based separation policy
is ready for some initial testing.  It can be checked out from the
rbacsep branch of the refpolicy SVN repo.  Not all of the type aliases
are in place for compatibility yet, so switching from an existing policy
should be done in permissive.

A question that comes up is how exactly to to determine which types
should be constrained by ubac.  The obvious answer would seem to be that
if the user isn't system_u, then there should be ubac constraints on the
access check.  But the problem is that creating new files gets your
selinux user on files.  So if you look in /etc, you're likely to see non
system_u files, such as ld.so.cache.  The problem is that we don't want
ubac constraints on these files.  In addition, since there is no
run_init on redhat (and possibly other distros) machines, restarted
services would get non system_u users, which would also cause problems.

My current implementation is actually more of an allow by default setup,
where types are explicitly marked as being ubac constrained.  Obviously
deny by default would be preferred, but that would require all exempted
types to be marked instead.  The problem is the number of exempted types
far outnumbers the constrained types.  I'm open to suggestions on
tweaking this design, especially if it gets us a deny by default without
the pain of marking most types in the policy as exempted.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
