Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9IjWIi014819
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:45:32 -0500 (EST)
Received: from maat.darkhonor.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9IjZEj004322
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:45:35 GMT
Subject: RE: Single home directory type for all roles.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 9 Dec 2004 13:50:16 -0500
Message-ID: <A52BEA1D8EE8634B9196A136333637B13115@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: "Russell Coker" <rcoker@redhat.com>, "Colin Walters" <walters@redhat.com>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>,
   "Stephen Smalley" <sds@epoch.ncsc.mil>,
   "SE Linux list" <selinux@tycho.nsa.gov>,
   "Joshua Brindle" <jbrindle@snu.edu>, "Jim Carter" <jwcart2@epoch.ncsc.mil>,
   "Nalin Dahyabhai" <nalin@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> On Thur, December 09, 2004 1:02 PM, Russell Coker wrote:
> > Hmm.  But the fact that in the default strict policy user_r and
staff_r
> > are nearly equivalent in terms of functionality is really a special
> > case, no?
> 
> A bug IMHO.  If we have two roles that become almost equivalent then
the
> sensible thing to do is remove one.  If we decide that for Fedora
strict
> policy we don't want to have any regular users be denied the ability
> perform administrative tasks then the correct thing to do is to make
> staff_r the default user role.
> 
> It's easy enough for anyone to add a new role if they need more roles
> than the default policy provides.

As a novice Fedora SELinux user, this sounds like a bad idea (even if it
was only hypothetical). There is currently a boolean in the strict
policy which disables the ability for normal user_r users from
transitioning to the sysadm_r, thus requiring only those users who may
have need of sysadm_r functions to be a member of staff_r. Any default
changes to this (by eliminating one role or the other) would require
users, like myself, who are not overly comfortable with developing new
user roles to regenerate a restricted user_r-type role for non-trusted
users.

As basic feedback, please do not go this route for the strict policy,
which is a nice secure default for workstation-level systems.

My $0.02,
Alex Ackerman

http://www.darkhonor.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
