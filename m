Message-ID: <1493832192.15269.11.camel@tycho.nsa.gov>
Subject: Re: Policy capabilities: when to use and complications with using
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Wed, 03 May 2017 13:23:12 -0400
In-Reply-To: <20170503165137.GA15940@julius>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <20170503165137.GA15940@julius>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-03 at 18:51 +0200, Dominick Grift wrote:
> On Wed, May 03, 2017 at 12:14:16PM -0400, Stephen Smalley wrote:
> > Looking at adding a map permission for mmap [1], and thinking about
> > whether it needs to be wrapped by a policy capability.  On the one
> > hand, we made the open permission depend on a policy capability,
> > but on
> > the other hand, we haven't done that for other cases where we
> > simply
> > added a check of a new permission (recent examples include prlimit
> > checking and module_load).  Compatibility for new permission checks
> > is
> > generally covered in Linux distributions via handle_unknown=allow,
> > and
> > in Android where handle_unknown=deny, the kernel and policy are not
> > independently updated so we can keep them properly synchronized
> > without
> > needing such compatibility measures.
> > 
> > It seems like we generally reserve the use of policy capabilities
> > for
> > when there is a more fundamental change in logic that wouldn't be
> > covered by handle_unknown.  All of the current policy capabilities
> > except for open_perms seem to fit into that category; they change
> > what
> > permissions/classes are checked rather than merely adding a new
> > check,
> > or they change when checks are applied, or they alter labeling
> > behavior.  Even if that is our standard, we haven't consistently
> > defined new policy capabilities for all such changes, e.g. for
> > distinguishing non-init user namespace capability checks (commit
> > 8e4ff6f228e4722cac74db716e308d1da33d744f) or for the earlier
> > updating
> > of netlink socket classes (commit
> > 6c6d2e9bde1c1c87a7ead806f8f5e2181d41a652).  Those changes don't
> > break
> > existing policies because of handle_unknown=allow, but since they
> > are
> > actually changing what is checked and not merely adding new checks,
> > they technically ought to have been wrapped (with
> > handle_unknown=allow,
> > they could end up allowing what would have been previously denied
> > due
> > to changes in the classes).
> > 
> > Part of the reason that we tend to not introduce a new policy
> > capability more often is that it is painful to do so currently.  We
> > have to patch libsepol to recognize the new capability and patch
> > the
> > policy to declare it (although for the latter we can now declare
> > them
> > via a CIL module without modifying the base policy).  And since the
> > policy or module won't build without the updated libsepol, we can't
> > turn on the capability by default in refpolicy without making it
> > dependent on a new libsepol version.  That's why
> > extended_socket_class
> > isn't yet enabled in refpolicy, for example.  That causes
> > enablement
> > and adoption to lag behind.  It also makes it harder to test the
> > new
> > kernel feature in the first place.
> 
> I would like to see Fedora package the RC's in Rawhide as well (other
> distributions could help by packaging the RC's in unstable as well).
> That would atleast make the RC's a bit more accessible.
> In Fedora it is usually not the kernel that is the problem, it is
> user space that is generally to old. And as you've said policy is no
> longer a problem with CIL.
> 
> > 
> > We could possibly look into lighter weight support for policy
> > capabilities.  If the policy compiler toolchain left the capability
> > names as strings in the kernel policy (new binary format version),
> > then
> > we would no longer need to update libsepol for each new policy
> > capability.  The kernel would then turn the list into the bitmap
> > internally.  The downside is that we would lose validation of the
> > capability names when policy is built, and it isn't clear how the
> > kernel should handle unknown names (presently the kernel will
> > simply
> > ignore any unknown capabilities in the bitmap).  Failing at policy
> > load
> > time would mean we can't enable the capability in policy without
> > making
> > it depend on a particular kernel version.
> > 
> > The lack of any direct relationship between policy capabilities and
> > the
> > classes/permissions they affect also can be misleading.  For
> > example,
> > someone booting a recent kernel might see warnings about undefined
> > classes introduced by the extended_socket_class feature and add
> > those
> > class definitions to their policy, which will silence the kernel
> > warning and make them think that they are actually using those
> > classes
> > now.  But they won't actually get used until they declare the
> > capability too in their policy, and the kernel doesn't warn about
> > that
> > (nor does it necessarily make sense to do so, since that may be a
> > conscious choice by the policy author).  The kernel could however
> > log
> > each policy capability and its state as part of its normal logging
> > and
> > leave it up to the reader to decide whether those values are
> > correct or
> > not.  We also had talked originally about checkpolicy and friends
> > possibly warning on inconsistencies, while leaving it up to the
> > policy
> > author.
> > 
> > So:
> > 
> > 1) Should we investigate lighter weight support for policy
> > capabilities, and if so, how?
> > 
> > 2) Should the kernel log information about enabled/disabled policy
> > capabilities in much the same manner as it does for undefined
> > classes/permissions?
> > 
> > 3) Should the policy compiler toolchain warn the user if a policy
> > capability is not declared and classes/permissions are used in
> > rules
> > that will only be used if that policy capability is declared?  And
> > similarly if a policy capability is declared but the corresponding
> > classes/permissions are not used in any rules?
> > 
> > 4) Do we need/want a policy capability for map permission and other
> > cases where we are only adding a new permission check? Or should we
> > continue to reserve them for cases not addressed via
> > handle_unknown?
> 
> Would the map permission "only add a new permission". The way i see
> it is that it will actually change the meaning of the "execute"
> existing permission
> 
> As a matter of fact: When we add map then what is execute for?

No, map would be a new permission that controls the ability to mmap() a
file.  The existing read/write/execute checks during mmap() would
remain unchanged.  This is similar to open permission, which controls
the ability to open() a file, but does not replace the read/write
checks on it.  See the issue link below for the rationale for a
separate map check.

> 
> > 
> > [1] https://github.com/SELinuxProject/selinux-kernel/issues/13
> 
> 
