Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49Ho3Cs004701
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 13:50:04 -0400
Received: by mail-lf0-f42.google.com with SMTP id 99so6651953lfu.1
 for <selinux@tycho.nsa.gov>; Tue, 09 May 2017 10:49:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <23de1ae5-c3ef-9c31-be15-4b9cde74157d@tycho.nsa.gov>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <23de1ae5-c3ef-9c31-be15-4b9cde74157d@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 May 2017 13:49:55 -0400
Message-ID: <CAHC9VhSD_Ydp9JCHUZmW7zW05mgMkwHV1m_LSc8KT2EvqTk_VQ@mail.gmail.com>
Subject: Re: Policy capabilities: when to use and complications with using
To: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>,
 Joshua Brindle <brindle@quarksecurity.com>,
 Chris PeBenito <pebenito@ieee.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 3, 2017 at 3:35 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:
> On 05/03/2017 12:14 PM, Stephen Smalley wrote:

...

> I think that there are three cases to consider. (I am ignoring removing
> checks and/or permissions.)
>
> Case 1: Additional checks using existing permissions
>
> This case occurs when additional checks are added but they are very similar
> to checks already being done and there does not seem to be any benefit to
> adding a new permission. New policy is required to allow access where
> additional checks apply. If this requires giving a domain more access then
> desired, then probably a new permission should have been created.
> Compatibility:
> new kernel - old policy
>     Previously unchecked accesses may now be denied. Potential compatibility
> issues.
> old kernel - new policy
>     No problems
>
>
> Case 2: New checks using new permissions
>
> This case occurs when additional checks are added and they are not similar
> to other checks, so a new permission would be beneficial. New policy is
> required to allow access where the new checks apply.
> Compatibility:
> new kernel - old policy
>     SEPOL_ALLOW_UNKNOWN - No problems, but not getting the security benefits
> of the new check.
>     SEPOL_DENY_UNKNOWN - Access attempts involving the new checks will be
> denied instead of always being allowed like they were before the new check
> was added. Potential compatibility issues.
>     SEPOL_REJECT_UNKNOWN - Policy will not load.
> old kernel - new policy
>     No problem because no check will involve the new permission.
>
>
> Case 3: Old checks now using new permissions
>
> This case occurs when there is a new use-case that makes splitting an old
> permission into multiple ones worthwhile. New policy is required to allow
> access where the new permissions are required.
> Compatibility:
> new kernel - old policy
>     SEPOL_ALLOW_UNKNOWN - Previously denied access attempts will now be
> allowed. Potential security issues.
>     SEPOL_DENY_UNKNOWN - Accesses checked with the new permissions will be
> denied. Potential compatibility issues.
>     SEPOL_REJECT_UNKNOWN - Policy will not load
> old kernel - new policy
>     Denials will occur where old permission is no longer allowed because
> only the new one needs to be allowed for a new kernel. Potential security
> issues.
>
> Case 2 can be handled adequately by allowing unknown permissions, but the
> other two cases (and case 3 particularly) need a policycap to avoid
> problems.
>
> This seems to fit with what the practice has been.

I agree with all of the above.

>> Part of the reason that we tend to not introduce a new policy
>> capability more often is that it is painful to do so currently.  We
>> have to patch libsepol to recognize the new capability and patch the
>> policy to declare it (although for the latter we can now declare them
>> via a CIL module without modifying the base policy).  And since the
>> policy or module won't build without the updated libsepol, we can't
>> turn on the capability by default in refpolicy without making it
>> dependent on a new libsepol version.  That's why extended_socket_class
>> isn't yet enabled in refpolicy, for example.  That causes enablement
>> and adoption to lag behind.  It also makes it harder to test the new
>> kernel feature in the first place.
>>
>> We could possibly look into lighter weight support for policy
>> capabilities.  If the policy compiler toolchain left the capability
>> names as strings in the kernel policy (new binary format version), then
>> we would no longer need to update libsepol for each new policy
>> capability.  The kernel would then turn the list into the bitmap
>> internally.  The downside is that we would lose validation of the
>> capability names when policy is built, and it isn't clear how the
>> kernel should handle unknown names (presently the kernel will simply
>> ignore any unknown capabilities in the bitmap).  Failing at policy load
>> time would mean we can't enable the capability in policy without making
>> it depend on a particular kernel version.
>>
>
> I wonder if in the case of a new permission being added whether the kernel
> could revert to the previous behavior if the new permission is not in the
> policy. The new permission would be an implicit policy capability.

Not all policy capabilities are due to new permissions, e.g. the
"always_check_network" capability.  The policy capability
functionality is a way of introducing backwards-incompatible changes
into the kernel in a manner which (hopefully) doesn't break existing
policies.  While new/changed permissions are the obvious things, I
don't want to rule out use of policy capabilities for working around
other changes we may want to make in the future.

>> So:
>>
>> 1) Should we investigate lighter weight support for policy
>> capabilities, and if so, how?

I agree that not having to update userspace for each new policy
capability is a desirable goal, but I'm hopeful that changes requiring
a new policy capability are kept to a minimum.

>> 2) Should the kernel log information about enabled/disabled policy
>> capabilities in much the same manner as it does for undefined
>> classes/permissions?

This seems like a very good idea to me.

* https://github.com/SELinuxProject/selinux-kernel/issues/32

>> 3) Should the policy compiler toolchain warn the user if a policy
>> capability is not declared and classes/permissions are used in rules
>> that will only be used if that policy capability is declared?  And
>> similarly if a policy capability is declared but the corresponding
>> classes/permissions are not used in any rules?

This seems to go against lighter weight policy capabilities, would it not?

>> 4) Do we need/want a policy capability for map permission and other
>> cases where we are only adding a new permission check? Or should we
>> continue to reserve them for cases not addressed via handle_unknown?

See James' earlier comments.  I think sticking with the current usage
is the "best practice", but I think we should reserve the right to
treat each change individually.  I'm hopeful that changes where we
consider new policy capabilities remain infrequent enough that we can
along without a concrete policy on their use.

> I know you also want this:
> 5) Should CIL support adding a permission to a new class, so we don't need
> to grab a source rpm and rebuild the whole policy from source just to test a
> new permission?

-- 
paul moore
www.paul-moore.com
