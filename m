Message-Id: <200510031256.j93CugYs013021@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   <SELinux-dev@tresys.com>
Subject: RE: [RFC][PATCH] New interface for loading policy
Date: Mon, 3 Oct 2005 08:56:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128100586.12459.178.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, September 30, 2005 1:16 PM
> To: Ivan Gyurdiev
> Cc: Karl MacMillan; selinux@tycho.nsa.gov; Daniel J Walsh; SELinux-
> dev@tresys.com
> Subject: Re: [RFC][PATCH] New interface for loading policy
> 
> On Fri, 2005-09-30 at 08:21 -0400, Stephen Smalley wrote:
> > BTW, one thing that I'm not clear on is how the preservebools case (the
> > default behavior for load_policy) will be handled in the future.  The
> > idea is that if a boolean has been toggled at runtime without altering
> > its saved value (e.g. manually by an admin, or by a cron job that
> > toggles a boolean to enforce different day/night policies, or by an IDS
> > in response to an event), we don't want a subsequent policy reload (e.g.
> > from an update) to reset that boolean value to the saved settings.  At
> > present, load_policy (and thus selinux_mkload_policy) grab the active
> > boolean settings from selinuxfs and patch them into the binary policy
> > image via sepol_genbools_array() by default (preservebools=1).
> 
> We seem to have agreed to drop the optional path argument entirely from
> selinux_mkload_policy().  But we still need to decide whether the
> preservebools argument is going to make sense going forward.  This is
> for preserving temporary boolean values across a policy reload rather
> than resetting them to the policy settings and is the default behavior
> for load_policy (in the absence of the -b option), as noted above.  As
> with the path argument, this argument is not needed for the initial
> policy load by init, but is only relevant for policy reloads.
> 

I think that it needs to remain. In the future all requests for changing
bools, either persistently or temporarily, should go through the policy
server so that it can a) notify all security servers and b) enforce access
control over the changes. It does not, however, make sense to save all
states to disk. This means that load_policy needs to take care of saving the
state on reload. I think this is significantly "safer" than the users case -
the fallback is the defaults in the on-disk policy.

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
