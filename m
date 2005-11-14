Subject: Re: [ SEPOL ] Add sepol_policydb_mls_enabled, organize map file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43765D20.9070200@cornell.edu>
References: <43765D20.9070200@cornell.edu>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 11:37:13 -0500
Message-Id: <1131986233.5415.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-11-12 at 16:22 -0500, Ivan Gyurdiev wrote:
> - marks sepol_module_package_init static (not used outside that file/not 
> exported)
> - removes sepol_ prefix on two module functions that are not exported 
> (init, read_offsets)
> 
> - use wildcards in more places in the map file, to make it a bit more 
> organized. Enforce "_" after suffix, and organize things by the objects 
> being managed.
> 
> I like that the change makes it easy to see which functions are not 
> following proper namespace/convention. Also, it's easy to see when API's 
> being chaged (marked with sepol_). Also, makes names shorter (but if not 
> marked static, this could be a namespace problem for static linking). 
> Also, allows grep for exported functions for each object.

Removing the sepol_ prefix on those module functions and making the init
function static is likely fine; that was leftover from the original
module code prior to encapsulation of the module interfaces (when there
was no create function at all, and users of the static libsepol were
using the init function).

> On the other hand, with wildcards things can be exported by mistake in 
> the future - not sure if that's a significant problem. You could argue 
> against this change, but then I don't understand why many functions were 
> marked hidden in services.c. Either we should or should not use 
> wildcards - I don't care which, but it should be consistent.

On the service functions, they originally had security_ prefixes
(derived from the security server code), but this conflicted with the
libselinux APIs for interacting with the kernel security server on a
SELinux system, so they were changed to have sepol_ prefixes.  They are
only exported by the static libsepol, not the shared libsepol, which is
why they are marked hidden.  The namespace prefix allows audit2why to
use the static libsepol and libselinux without conflict.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
