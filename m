Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9GJ2aJX007486
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2008 15:02:36 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m9GJ1DDM016647
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2008 19:01:17 GMT
Subject: Re: (u|r)bacsep: initial testing
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1216224735.21191.50.camel@gorn>
References: <1216224735.21191.50.camel@gorn>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 15:01:13 -0400
Message-Id: <1224183673.21012.64.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-07-16 at 12:12 -0400, Christopher J. PeBenito wrote:
> For those that are interested, the SELinux user-based separation policy
> is ready for some initial testing.  It can be checked out from the
> rbacsep branch of the refpolicy SVN repo.  Not all of the type aliases
> are in place for compatibility yet, so switching from an existing policy
> should be done in permissive.
> 
> A question that comes up is how exactly to to determine which types
> should be constrained by ubac.  The obvious answer would seem to be that
> if the user isn't system_u, then there should be ubac constraints on the
> access check.  But the problem is that creating new files gets your
> selinux user on files.  So if you look in /etc, you're likely to see non
> system_u files, such as ld.so.cache.  The problem is that we don't want
> ubac constraints on these files.  In addition, since there is no
> run_init on redhat (and possibly other distros) machines, restarted
> services would get non system_u users, which would also cause problems.
> 
> My current implementation is actually more of an allow by default setup,
> where types are explicitly marked as being ubac constrained.  Obviously
> deny by default would be preferred, but that would require all exempted
> types to be marked instead.  The problem is the number of exempted types
> far outnumbers the constrained types.  I'm open to suggestions on
> tweaking this design, especially if it gets us a deny by default without
> the pain of marking most types in the policy as exempted.

ping

This is the last call.  I have not heard any comments from the
community.  User-based separations have finished going through vetting
interally at Tresys; I plan to finalize this and then merge it into
trunk in the next week or so unless there are any objections raised.

This really needs to be tested by people whose projects depend on proper
role separations.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
