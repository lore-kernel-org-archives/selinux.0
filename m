Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9I2QIi014450
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:02:26 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9I0kPS010732
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:00:47 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Colin Walters <walters@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102613299.10785.21.camel@nexus.verbum.private>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 05:02:24 +1100
Message-Id: <1102615344.4509.39.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 12:28 -0500, Colin Walters wrote:
> policy for the gnome-user-share Apache daemon.  It does seem wrong to me
> for any user_t to have access to my staff_t temporary files, and also
> the other way around (remember that user_t/staff_t prevents /tmp race
> conditions).  I run a strict server on which I have several users who I
> don't *entirely* trust.  The extra assurance the user_t/staff_t
> distinction brings is nice.

Currently the default policy has /root labeled as staff_home_dir_t.
This significantly weakens the boundaries between staff_r and sysadm_r.
If we were to make changes which then weaken the boundaries between
user_r and staff_r then we might as well just have no user_r and staff_r
and use sysadm_r for all user logins - IE have the targeted policy.

> > 2.  Requirement that selinux-policy-strict-sources be installed and a 
> > rebuild of policy in order to change the roles of a user.
> 
> I'm not sure I see what's so bad about this.  I would assume that most
> people running strict will have to customize policy anyways.

I agree.

> Hmm.  But the fact that in the default strict policy user_r and staff_r
> are nearly equivalent in terms of functionality is really a special
> case, no?

A bug IMHO.  If we have two roles that become almost equivalent then the
sensible thing to do is remove one.  If we decide that for Fedora strict
policy we don't want to have any regular users be denied the ability
perform administrative tasks then the correct thing to do is to make
staff_r the default user role.

It's easy enough for anyone to add a new role if they need more roles
than the default policy provides.

>   I imagine most people really using RBAC will be defining
> specialized roles such as webmaster_r, nurse_r, developer_r, etc.  In
> this situation it seems to me that it would be unusual for a person to
> switch roles entirely; much more likely they would gain a role.  And if
> they *did* switch roles, it seems likely that they would not have access
> to their old files at all.  

Gaining a role (IE one user having multiple roles) is another issue
entirely.  But I think that apart from the special case of staff_r and
sysadm_r there is little need to have multiple roles.

You might have a situation where developers and webmasters have write
access to the web content.  Web masters have access to web logs, and
developers have access to source.  Writing appropriate TE rules for this
such that developers can do everything they need as developer_t and web
masters can do everything they need as webmaster_t is easy enough.

> > With SELinux Policy Modules, can I build an system-config-user/adduser 
> > that would modify a file under /etc/selinux/strict/roles/
> > (the users file) and then reload just that policy?
> 
> I haven't looked in detail at binary policy modules, but my guess is
> that they can't *delete* a role, type, or permission.  So it seems
> difficult to use a binary policy module to change a user's role, e.g.
> from user_r to staff_r as you suggest.

If you use binary policy modules to add roles and the users in question
are not in the base policy then this might work.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
