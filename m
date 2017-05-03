Subject: Re: Policy capabilities: when to use and complications with using
To: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 Paul Moore <paul@paul-moore.com>, Joshua Brindle
 <brindle@quarksecurity.com>, Chris PeBenito <pebenito@ieee.org>
Cc: selinux@tycho.nsa.gov
References: <1493828056.15269.9.camel@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <23de1ae5-c3ef-9c31-be15-4b9cde74157d@tycho.nsa.gov>
Date: Wed, 3 May 2017 15:35:49 -0400
MIME-Version: 1.0
In-Reply-To: <1493828056.15269.9.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/03/2017 12:14 PM, Stephen Smalley wrote:
> Looking at adding a map permission for mmap [1], and thinking about
> whether it needs to be wrapped by a policy capability.  On the one
> hand, we made the open permission depend on a policy capability, but on
> the other hand, we haven't done that for other cases where we simply
> added a check of a new permission (recent examples include prlimit
> checking and module_load).  Compatibility for new permission checks is
> generally covered in Linux distributions via handle_unknown=allow, and
> in Android where handle_unknown=deny, the kernel and policy are not
> independently updated so we can keep them properly synchronized without
> needing such compatibility measures.
> 
> It seems like we generally reserve the use of policy capabilities for
> when there is a more fundamental change in logic that wouldn't be
> covered by handle_unknown.  All of the current policy capabilities
> except for open_perms seem to fit into that category; they change what
> permissions/classes are checked rather than merely adding a new check,
> or they change when checks are applied, or they alter labeling
> behavior.  Even if that is our standard, we haven't consistently
> defined new policy capabilities for all such changes, e.g. for
> distinguishing non-init user namespace capability checks (commit
> 8e4ff6f228e4722cac74db716e308d1da33d744f) or for the earlier updating
> of netlink socket classes (commit
> 6c6d2e9bde1c1c87a7ead806f8f5e2181d41a652).  Those changes don't break
> existing policies because of handle_unknown=allow, but since they are
> actually changing what is checked and not merely adding new checks,
> they technically ought to have been wrapped (with handle_unknown=allow,
> they could end up allowing what would have been previously denied due
> to changes in the classes).
> 

I think that there are three cases to consider. (I am ignoring removing checks 
and/or permissions.)

Case 1: Additional checks using existing permissions

This case occurs when additional checks are added but they are very similar to 
checks already being done and there does not seem to be any benefit to adding a 
new permission. New policy is required to allow access where additional checks 
apply. If this requires giving a domain more access then desired, then probably 
a new permission should have been created.
Compatibility:
new kernel - old policy
     Previously unchecked accesses may now be denied. Potential compatibility 
issues.
old kernel - new policy
     No problems


Case 2: New checks using new permissions

This case occurs when additional checks are added and they are not similar to 
other checks, so a new permission would be beneficial. New policy is required to 
allow access where the new checks apply.
Compatibility:
new kernel - old policy
     SEPOL_ALLOW_UNKNOWN - No problems, but not getting the security benefits of 
the new check.
     SEPOL_DENY_UNKNOWN - Access attempts involving the new checks will be 
denied instead of always being allowed like they were before the new check was 
added. Potential compatibility issues.
     SEPOL_REJECT_UNKNOWN - Policy will not load.
old kernel - new policy
     No problem because no check will involve the new permission.


Case 3: Old checks now using new permissions

This case occurs when there is a new use-case that makes splitting an old 
permission into multiple ones worthwhile. New policy is required to allow access 
where the new permissions are required.
Compatibility:
new kernel - old policy
     SEPOL_ALLOW_UNKNOWN - Previously denied access attempts will now be 
allowed. Potential security issues.
     SEPOL_DENY_UNKNOWN - Accesses checked with the new permissions will be 
denied. Potential compatibility issues.
     SEPOL_REJECT_UNKNOWN - Policy will not load
old kernel - new policy
     Denials will occur where old permission is no longer allowed because only 
the new one needs to be allowed for a new kernel. Potential security issues.

Case 2 can be handled adequately by allowing unknown permissions, but the other 
two cases (and case 3 particularly) need a policycap to avoid problems.

This seems to fit with what the practice has been.

> Part of the reason that we tend to not introduce a new policy
> capability more often is that it is painful to do so currently.  We
> have to patch libsepol to recognize the new capability and patch the
> policy to declare it (although for the latter we can now declare them
> via a CIL module without modifying the base policy).  And since the
> policy or module won't build without the updated libsepol, we can't
> turn on the capability by default in refpolicy without making it
> dependent on a new libsepol version.  That's why extended_socket_class
> isn't yet enabled in refpolicy, for example.  That causes enablement
> and adoption to lag behind.  It also makes it harder to test the new
> kernel feature in the first place.
> 
> We could possibly look into lighter weight support for policy
> capabilities.  If the policy compiler toolchain left the capability
> names as strings in the kernel policy (new binary format version), then
> we would no longer need to update libsepol for each new policy
> capability.  The kernel would then turn the list into the bitmap
> internally.  The downside is that we would lose validation of the
> capability names when policy is built, and it isn't clear how the
> kernel should handle unknown names (presently the kernel will simply
> ignore any unknown capabilities in the bitmap).  Failing at policy load
> time would mean we can't enable the capability in policy without making
> it depend on a particular kernel version.
> 

I wonder if in the case of a new permission being added whether the kernel could 
revert to the previous behavior if the new permission is not in the policy. The 
new permission would be an implicit policy capability.

Even if we just included strings in the kernel policy it would still be nice to 
have something in libsepol, so that typos would be caught.

> The lack of any direct relationship between policy capabilities and the
> classes/permissions they affect also can be misleading.  For example,
> someone booting a recent kernel might see warnings about undefined
> classes introduced by the extended_socket_class feature and add those
> class definitions to their policy, which will silence the kernel
> warning and make them think that they are actually using those classes
> now.  But they won't actually get used until they declare the
> capability too in their policy, and the kernel doesn't warn about that
> (nor does it necessarily make sense to do so, since that may be a
> conscious choice by the policy author).  The kernel could however log
> each policy capability and its state as part of its normal logging and
> leave it up to the reader to decide whether those values are correct or
> not.  We also had talked originally about checkpolicy and friends
> possibly warning on inconsistencies, while leaving it up to the policy
> author.
> 

If the permissions acted as an implicit policy capability, that would take care 
of this problem. The kernel could warn that since the new permission is missing 
then these checks would be different.

> So:
> 
> 1) Should we investigate lighter weight support for policy
> capabilities, and if so, how?
> 
> 2) Should the kernel log information about enabled/disabled policy
> capabilities in much the same manner as it does for undefined
> classes/permissions?
> 
> 3) Should the policy compiler toolchain warn the user if a policy
> capability is not declared and classes/permissions are used in rules
> that will only be used if that policy capability is declared?  And
> similarly if a policy capability is declared but the corresponding
> classes/permissions are not used in any rules?
> 
> 4) Do we need/want a policy capability for map permission and other
> cases where we are only adding a new permission check? Or should we
> continue to reserve them for cases not addressed via handle_unknown?
> 

I know you also want this:
5) Should CIL support adding a permission to a new class, so we don't need to 
grab a source rpm and rebuild the whole policy from source just to test a new 
permission?

Jim

> [1] https://github.com/SELinuxProject/selinux-kernel/issues/13
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
