Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OH4ngA008194
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 13:04:49 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OH4E2B025621
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 17:04:14 GMT
Message-Id: <200506241704.j5OH4jqc017398@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Casey Schaufler'" <casey@schaufler-ca.com>, <selinux@tycho.nsa.gov>
Subject: RE: Alternative user management approach
Date: Fri, 24 Jun 2005 13:04:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20050624163802.24970.qmail@web31611.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Casey Schaufler [mailto:casey@schaufler-ca.com]
> Sent: Friday, June 24, 2005 12:38 PM
> To: Karl MacMillan; selinux@tycho.nsa.gov
> Subject: Re: Alternative user management approach
> 
> 
> > This would mean that specific users would
> > no longer be a part of the SELinux policy,
> > removing the need for libsepol changes.
> >
> > This makes the SELinux user more what we
> > are calling a 'user role'. For example,
> > the policy could create 3 user roles with
> > different role authorizations (which
> > become 'role capabilities'):
> >
> > user role		role capabilities
> > ------------------------------------
> > normal		user_r
> > staff			staff_r sysadm_r
> > sysadm		sysadm_r
> >
> > Normal Linux users are then mapped to user
> > roles by username or group membership
> > (this should be done by libselinux and not
> > involve the kernel). For example, if
> > the primary group of the user is wheel then
> > they could be assigned to staff,
> > root assigned to sysadm, and everyone else to
> > normal.
> 
> I suggest a seperate "/etc/usrrole" or similar
> rather than overloading an existing attribute.
> The folks who did System V/MLS stole the group
> membership and introduced a variety of issues
> when the scheme was applied to systems with
> multiple concurrent groups and the BSD file
> system group ownership symantics. On a system
> with capabilities enforced properly you may
> not want root to have sysadm, too.
> 

To make my suggestion more concrete, I think a mapping file in
/etc/selinux/policyname that maps from users to SELinux users. The config would
be an ordered list of mappings that use username and group information. That
means that if the admin wants to use group info they can, otherwise it is
ignored. The first match in the ordered list would win. Maybe something like:

id:root	sysadm
group:wheel staff
default	normal

There are a lot of possibilities including boolean logic, wildcards, etc. Not
certain how much complexity is needed.

> > This makes the addition of
> > a user roughly equivalent to adding roles -
> > something done by a policy developer
> > that does not need to be done as part of normal
> > system administration.
> 
> Not sure I quite parse your meaning here.
> 

Overloaded use of user . . . probably a sign of problems to come in this
discussion. Adding an SELinux user role is done by the policy developer at
development time. Adding Linux users and mapping them to SELinux user roles is
runtime and done by the system administrator.

> > In the future, this can be greatly expanded in the
> > reference policy with more
> > fine-grained role capabilities. For example:
> >
> > user role		role capabilities
> > -----------------------------------
> > normal		user_r
> > staff			staff_r webadmin_r logadmin_r genadmin_r
> > secadmin		staff_r genadmin_r secadmin_r
> > sysadm		webadmin_r logadmin_r genadmin_r
> >
> > Questions/Thoughts?
> 
> I think you're on the right track to
> seperate users from policy. The details
> are most likely a matter of taste once
> you establish that adding a normal user
> doesn't need to update the policy.
> 
> 

Sounds about right to me.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> Casey Schaufler
> casey@schaufler-ca.com
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
