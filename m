Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9JTqIi015273
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 14:29:52 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9JTrEj006395
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 19:29:54 GMT
Subject: RE: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Alex Ackerman <alex@darkhonor.com>
Cc: Colin Walters <walters@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B13115@maat.darkhonor.net>
References: <A52BEA1D8EE8634B9196A136333637B13115@maat.darkhonor.net>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 06:29:50 +1100
Message-Id: <1102620591.4509.79.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 13:50 -0500, Alex Ackerman wrote:
> > On Thur, December 09, 2004 1:02 PM, Russell Coker wrote:
> > A bug IMHO.  If we have two roles that become almost equivalent then
> > the sensible thing to do is remove one.  If we decide that for Fedora
> > strict policy we don't want to have any regular users be denied the ability
> > perform administrative tasks then the correct thing to do is to make
> > staff_r the default user role.
> > 
> > It's easy enough for anyone to add a new role if they need more roles
> > than the default policy provides.
> 
> As a novice Fedora SELinux user, this sounds like a bad idea (even if it
> was only hypothetical). There is currently a boolean in the strict
> policy which disables the ability for normal user_r users from
> transitioning to the sysadm_r, thus requiring only those users who may
> have need of sysadm_r functions to be a member of staff_r. Any default
> changes to this (by eliminating one role or the other) would require
> users, like myself, who are not overly comfortable with developing new
> user roles to regenerate a restricted user_r-type role for non-trusted
> users.

I agree that it's not desirable to remove a role for an untrusted user
from the default install.  However that is the way things are going with
recent policy changes.  I think it's better to remove the user_r role
entirely than to make it almost the same as staff_r and give people who
are novices at reading policy the wrong idea.

Currently if you want a really restricted user_r role then you need to
change tunables.tun and comment out the definition of user_canbe_sysadm
(this requires having the policy source installed and that you are
capable of editing and compiling policy).  I believe that a better
option would be to have staff_r be the default role for all users in the
default policy and then let someone who wants to create accounts for
untrusted users assign them to user_r.  As part of that they can assign
user_u to user_r (user_u would have to default to staff_r too).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
