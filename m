Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4CDOIgA025528
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2005 09:24:18 -0400 (EDT)
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1115896944.32202.22.camel@moss-spartans.epoch.ncsc.mil>
References: <1115825335.28084.27.camel@moss-huskies.epoch.ncsc.mil>
	 <42826782.9040108@redhat.com>
	 <1115844045.28698.30.camel@moss-huskies.epoch.ncsc.mil>
	 <4282B1C1.2080202@redhat.com>
	 <1115896944.32202.22.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 12 May 2005 09:22:47 -0400
Message-Id: <1115904167.30162.7.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-05-12 at 07:22 -0400, Stephen Smalley wrote:
> On Wed, 2005-05-11 at 21:30 -0400, Daniel J Walsh wrote:
> > Not sure what you mean by context.  Are you saying that all user_r would 
> > share the same /tmp?
> > I would prefer that the directories be separated by UID/ROLE.
> 
> The latter (separation by uid/role/level) is what Chad was suggesting in
> response to your posting.  His current implementation is just separation
> by role/level, since that is what concerns us for mandatory access
> control, but it could be extended to also incorporate the Linux uid in
> the computation/selection of a member subdirectory.
> 
Yes.

> >   So most systems will
> > have only limited user roles, maybe user_r, staff_r and sysadm_r.  So if 
> > I give each user their
> > own /tmp directory, you eliminate users attacking each other, or at 
> > least make it more difficult.
> 
> One thing to note is that the current implementation is bind mounting
> the original top-level /tmp directory elsewhere so that security-aware
> applications can access other member subdirectories if they are allowed
> to do so by policy.  This is necessary e.g. so that su and newrole can
> re-bind to a different /tmp member when switching users/roles/levels and
> so that trusted applications that operate on multiple levels can access
> data at other levels.  Hence, we'll have to be careful about the policy
> and the mode bits on the top-level directory and on the member
> subdirectories to prevent such attacks.
> 
> > I think the users /tmp directory should be the same for all logins.  So 
> > if I copy a file to /tmp
> > and then go to another machine and scp it off, the file will be there.
> 
This is how it works right now for security contexts.  So if I add
support for uid as well, that's how it would work.

> 
> > This would then work on all Linux systems with or without SELinux and 
> > independant of the policy.
> 
> Possibly his implementation could fall back to just per-uid
> polyinstantiation if SELinux is disabled.  But when SELinux is enabled,
> we do want it to be based on policy, so that we can provide proper
> separation among roles and levels even for a single user.
> 
I could make this a config file option.  Per directory, you could
specify whether to polyinstantiate based on policy, uid, or both.  Would
that work for you?

Have you tried implementing per-user /tmp directories yet?  I'm curious
if it breaks anything (at least anything more than per security context
does)?

-- 
Chad Sellers
cdselle@tycho.nsa.gov


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
