Message-Id: <200506241838.j5OIc0qc018533@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: Alternative user management approach
Date: Fri, 24 Jun 2005 14:38:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119637197.12865.113.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, June 24, 2005 2:20 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Alternative user management approach
> 
> On Fri, 2005-06-24 at 12:02 -0400, Karl MacMillan wrote:
> > This makes the SELinux user more what we are calling a 'user role'. For
> example,
> > the policy could create 3 user roles with different role authorizations
> (which
> > become 'role capabilities'):
> >
> > user role		role capabilities
> > ------------------------------------
> > normal		user_r
> > staff			staff_r sysadm_r
> > sysadm		sysadm_r
> >
> > Normal Linux users are then mapped to user roles by username or group
> membership
> > (this should be done by libselinux and not involve the kernel). For example,
> if
> > the primary group of the user is wheel then they could be assigned to staff,
> > root assigned to sysadm, and everyone else to normal. This makes the
> addition of
> > a user roughly equivalent to adding roles - something done by a policy
> developer
> > that does not need to be done as part of normal system administration.
> 
> Yes, the idea of performing generalized user mapping in libselinux has
> been suggested previously on the list.  One concern we had with it
> originally was that the SELinux user identity provided stronger
> accountability than the Linux uid, but the audit uid can serve that
> purpose now, and you are still using the SELinux user identity aka "user
> role" (likely to create confusion due with SELinux roles, maybe role
> group or role set) above to bound the possible range of reachable
> SELinux roles aka "role capabilities" (likely to create confusion with
> POSIX/Linux capabilities) for programs like newrole (although how
> su/sudo/userhelper fit into this new scheme remains unclear).  So I
> agree that this makes sense.
> 

No idea about better names, though I agree that both are prone to confusion.
Anyone have any ideas?

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
