Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OGc3gA007851
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 12:38:04 -0400 (EDT)
Received: from web31611.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j5OGbS2B023472
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 16:37:28 GMT
Message-ID: <20050624163802.24970.qmail@web31611.mail.mud.yahoo.com>
Date: Fri, 24 Jun 2005 09:38:02 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Alternative user management approach
To: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200506241602.j5OG2Gqc016513@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Karl MacMillan <kmacmillan@tresys.com> wrote:


> This starts with some basic assertions:
> 1) Reloading the kernel policy on user change just
> seems . . . wrong.

That's because it is wrong.

> ...
> We have a partial solution to this already
> with the concept of a generic user
> (user_u).

A good start.

> Our suggestion is to expand this concept
> to have multiple generalized users with
> rich mappings from Linux users to SELinux
> users.

How is the different from roles?
Oh, never mind, you answer below.

> This would mean that specific users would
> no longer be a part of the SELinux policy,
> removing the need for libsepol changes.
> 
> This makes the SELinux user more what we
> are calling a 'user role'. For example,
> the policy could create 3 user roles with
> different role authorizations (which
> become 'role capabilities'):
> 
> user role		role capabilities
> ------------------------------------
> normal		user_r
> staff			staff_r sysadm_r
> sysadm		sysadm_r
> 
> Normal Linux users are then mapped to user
> roles by username or group membership
> (this should be done by libselinux and not
> involve the kernel). For example, if
> the primary group of the user is wheel then
> they could be assigned to staff,
> root assigned to sysadm, and everyone else to
> normal.

I suggest a seperate "/etc/usrrole" or similar
rather than overloading an existing attribute.
The folks who did System V/MLS stole the group
membership and introduced a variety of issues
when the scheme was applied to systems with
multiple concurrent groups and the BSD file
system group ownership symantics. On a system
with capabilities enforced properly you may
not want root to have sysadm, too.

> This makes the addition of
> a user roughly equivalent to adding roles -
> something done by a policy developer
> that does not need to be done as part of normal
> system administration.

Not sure I quite parse your meaning here.

> In the future, this can be greatly expanded in the
> reference policy with more
> fine-grained role capabilities. For example:
> 
> user role		role capabilities
> -----------------------------------
> normal		user_r
> staff			staff_r webadmin_r logadmin_r genadmin_r
> secadmin		staff_r genadmin_r secadmin_r
> sysadm		webadmin_r logadmin_r genadmin_r
> 
> Questions/Thoughts?

I think you're on the right track to
seperate users from policy. The details
are most likely a matter of taste once
you establish that adding a normal user
doesn't need to update the policy.



Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
