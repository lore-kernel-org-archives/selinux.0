Subject: Re: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux-dev@tresys.com
In-Reply-To: <433CB578.6070303@cornell.edu>
References: <1128028816.27495.182.camel@moss-spartans.epoch.ncsc.mil>
	 <433CB578.6070303@cornell.edu>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 08:21:49 -0400
Message-Id: <1128082909.12459.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-29 at 23:48 -0400, Ivan Gyurdiev wrote:
> It doesn't belong in libselinux. I've had an implementation of this for 
> a long time, but I haven't submitted it, because we're changing the plan 
> (right). Boolean and user components will be handled by semanage, using 
> the dbase thing which I'm adding there. Genbools/genusers will be 
> deprecated. Semanage will compile a module, and put users/booleans into 
> that. Then it will re-link modules upon change, and load_policy will ... 
> load the policy.
> 
> OTOH this may be a good way to get rid of this code from things like 
> init, which needs to happen anyway...

Yes, boolean and user components are expected to be handled by semanage
in the future, regenerating the kernel binary policy file on each
modification.  When that happens, selinux_mkload_policy() can drop out
the calls to sepol_genusers and sepol_genbools, but will still
encapsulate the logic for finding the right policy version, opening it
and mmap'ing it, and loading it.  So this change will make it easier to
make that transition - we won't need to re-patch sysvinit or
load_policy, and will still encapsulate some higher level logic than the
current security_load_policy().

BTW, one thing that I'm not clear on is how the preservebools case (the
default behavior for load_policy) will be handled in the future.  The
idea is that if a boolean has been toggled at runtime without altering
its saved value (e.g. manually by an admin, or by a cron job that
toggles a boolean to enforce different day/night policies, or by an IDS
in response to an event), we don't want a subsequent policy reload (e.g.
from an update) to reset that boolean value to the saved settings.  At
present, load_policy (and thus selinux_mkload_policy) grab the active
boolean settings from selinuxfs and patch them into the binary policy
image via sepol_genbools_array() by default (preservebools=1).

My earlier comment about the path needing to go away when the policy
server is introduced was a mistake on my part, I think.  /sbin/init will
still need to directly load a kernel binary policy file into the kernel,
as the server won't be running yet, and load_policy will still be run
from libsemanage in direct mode (and possibly from the policy server) to
load policy files, although it should no longer be directly run by the %
post scriptlet in the policy package for updates.  Hence, retaining the
path as an optional argument isn't necessarily a problem (I think), but
we should decide whether we want it.  It does offer the flexibility of
loading a test policy without first installing it to the standard
location, but we don't offer the same flexibility for the other files
presently.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
