Subject: Re: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com
In-Reply-To: <1128082909.12459.14.camel@moss-spartans.epoch.ncsc.mil>
References: <1128028816.27495.182.camel@moss-spartans.epoch.ncsc.mil>
	 <433CB578.6070303@cornell.edu>
	 <1128082909.12459.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 13:16:26 -0400
Message-Id: <1128100586.12459.178.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 08:21 -0400, Stephen Smalley wrote:
> BTW, one thing that I'm not clear on is how the preservebools case (the
> default behavior for load_policy) will be handled in the future.  The
> idea is that if a boolean has been toggled at runtime without altering
> its saved value (e.g. manually by an admin, or by a cron job that
> toggles a boolean to enforce different day/night policies, or by an IDS
> in response to an event), we don't want a subsequent policy reload (e.g.
> from an update) to reset that boolean value to the saved settings.  At
> present, load_policy (and thus selinux_mkload_policy) grab the active
> boolean settings from selinuxfs and patch them into the binary policy
> image via sepol_genbools_array() by default (preservebools=1).

We seem to have agreed to drop the optional path argument entirely from
selinux_mkload_policy().  But we still need to decide whether the
preservebools argument is going to make sense going forward.  This is
for preserving temporary boolean values across a policy reload rather
than resetting them to the policy settings and is the default behavior
for load_policy (in the absence of the -b option), as noted above.  As
with the path argument, this argument is not needed for the initial
policy load by init, but is only relevant for policy reloads.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
