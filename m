Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9MhlIi016958
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:43:48 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9MhlEl013535
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 22:43:51 GMT
Subject: Re: Single home directory type for all roles.
From: Colin Walters <walters@redhat.com>
To: Russell Coker <rcoker@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102615344.4509.39.camel@aeon>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
	 <1102615344.4509.39.camel@aeon>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 17:43:42 -0500
Message-Id: <1102632223.10785.36.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-10 at 05:02 +1100, Russell Coker wrote:

> Currently the default policy has /root labeled as staff_home_dir_t.
> This significantly weakens the boundaries between staff_r and sysadm_r.

I don't see there as being an interesting boundary between staff_r and
sysadm_r.  The reason I see staff_r as separated is because it has no
interaction with user_r, which closes a lot of possible attacks.

> If we were to make changes which then weaken the boundaries between
> user_r and staff_r then we might as well just have no user_r and staff_r
> and use sysadm_r for all user logins - IE have the targeted policy.

Yes, allowing interaction between user_r and staff_r would be bad.

> A bug IMHO.  If we have two roles that become almost equivalent then the
> sensible thing to do is remove one.  If we decide that for Fedora strict
> policy we don't want to have any regular users be denied the ability
> perform administrative tasks then the correct thing to do is to make
> staff_r the default user role.

Agreed.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
