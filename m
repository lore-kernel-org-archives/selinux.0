Subject: Re: [ SEPOL ] Another debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <434B7FF2.2090306@cornell.edu>
References: <434B62B8.4080309@cornell.edu>  <434B7FF2.2090306@cornell.edu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 10:45:29 -0400
Message-Id: <1129041930.3308.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 05:03 -0400, Ivan Gyurdiev wrote:
> Attached patch introduces the same debug system to sepol, except it does 
> not break compatibility, or replace old usage here yet - this is a bit 
> more difficult to do than in semanage, so I'd rather split it up in 
> several patches. This one introduces a handle, but doesn't allow the 
> handle to be passed in anywhere yet. A global handle is used for 
> handling the compatibility functions. I've exported those interfaces via 
> the map file, and included them in sepol.h.
> 
> Bugfix: can you delete the '\n' from the default handler in the semanage 
> patch - it prints an extra newline.
> 
> Question: should sepol.h be including all (external api) sepol headers ? 
> It does not do that currently. I added debug.h, but the others are still 
> not included.

- Same comments apply as for the semanage patch.

- Yes, sepol.h should likely include all external API sepol headers, and
the current interfaces in sepol.h should likely be moved to separate
headers that are then included.

- The natural first target for adding the handles would be those
interfaces that already take error buffer arguments, i.e.
sepol_link_packages, sepol_link_modules, and sepol_expand_modules.

- I'm not sure it is worthwhile to add the handles to primitive
interfaces like sepol_policydb_create, where the only failure case is
out of memory.  In contrast, sepol_policydb_read/write and
sepol_policydb_from_image/to_image are more likely candidates.

- We'll need to preserve versions of the old sepol.h interfaces without
handles for backward compatibility, since there have been official
releases with those interfaces.  Some of those interfaces will be
obsoleted (genusers/genbools) but others will continue to be used
(genbools_array for load_policy, set_policydb_from_file and
check_context for setfiles -c).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
