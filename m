Message-Id: <200510041241.j94CfGYs028157@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, <SELinux-dev@tresys.com>
Subject: RE: [RFC][PATCH] New interface for loading policy
Date: Tue, 4 Oct 2005 08:41:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128349050.26285.57.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Monday, October 03, 2005 10:18 AM
> To: Karl MacMillan
> Cc: 'Ivan Gyurdiev'; selinux@tycho.nsa.gov; 'Daniel J Walsh'; SELinux-
> dev@tresys.com
> Subject: RE: [RFC][PATCH] New interface for loading policy
> 
> On Mon, 2005-10-03 at 08:56 -0400, Karl MacMillan wrote:
> > I think that it needs to remain. In the future all requests for changing
> > bools, either persistently or temporarily, should go through the policy
> > server so that it can a) notify all security servers and b) enforce
> access
> > control over the changes. It does not, however, make sense to save all
> > states to disk. This means that load_policy needs to take care of saving
> the
> > state on reload. I think this is significantly "safer" than the users
> case -
> > the fallback is the defaults in the on-disk policy.
> 
> True.  The only potential concern is that we are trying to preserve the
> active boolean values of the booleans that were defined in the previous
> policy in the new policy.  If the boolean is no longer defined at all,
> we just skip it.  But if a given boolean name has changed its semantic
> meaning between the policies, then preserving its value could have
> interesting effects.
> 

This is a general problem that we can't solve, though. What if role names
suddenly change meaning - then my local.users file is probably very wrong.
These kinds of large policy changes probably require careful upgrading,
including things like taking the machine offline, changing customization
files (user, Booleans, etc.), and a reboot. So, not really a worry for this
case I think. And, of course, load_policy should take an option to not
preserve the state. 

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
