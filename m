Subject: Re: [PATCH 4/4] Validate kernel object classes and permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <C14C502C.18471%csellers@tresys.com>
References: <C14C502C.18471%csellers@tresys.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 09:25:02 -0400
Message-Id: <1160486702.16807.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 18:25 -0400, Chad Sellers wrote:
> On 10/6/06 5:37 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> 
> > On Fri, 2006-10-06 at 16:09 -0400, Chad Sellers wrote:
> >> plain text document attachment (verify_kernel.diff)
> >> This patch replaces the object class and permission validation code to
> >> validate against the defined kernel headers, and allow extra classes
> >> and permissions that do not conflict with the kernel definitions. Note
> >> that validation is now done for all policy loads, not just subsequent
> >> loads after the first policy load.
> > 
> > I haven't looked closely, but it doesn't quite look right to me.  The
> > old logic would walk the "good" definitions from the old policy,
> > checking each one against the definitions in the new policy.  This logic
> > appears to walk the new policy, checking each of its definitions against
> > the kernel tables.  But what if the new policy simply omits a definition
> > required by the kernel, e.g. delete the last class or the last five
> > classes altogether from policy?  Interestingly, the old logic includes
> > messages like "permission %s disappeared" or "class %s disappeared" but
> > this logic does not (only messages about incorrect values).  I think you
> > want it the other way around, i.e. walk the kernel tables and look up
> > each definition there in the policy being loaded, then see if it is
> > correct.  That also avoids having to skip around things that are defined
> > in policy but not in the kernel tables.
> > 
> I don't think that's the logic we want, though. Part of the eventual idea
> here is to help out the "Andrew Morton syndrome," where a kernel developer
> has a new kernel class/permission, but no policy for it. If we require all
> kernel defined classes/perms to be present in the policy, then we can't
> support this situation. The logic in my patch requires that all the kernel
> classes defined in the policy are consistent with the kernel, but allows for
> the possibility of the kernel having new classes/permissions that aren't in
> policy yet. The logic you propose would not allow a kernel developer to load
> a policy until that policy supported their new object class/permission.

The only thing that changes in that future situation (for which no patch
yet exists, and thus this patch should not presume it) is how one
handles the absence of a kernel class or permission in the policy, not
the logic for detecting such an absence.  Your logic won't even detect
the absence, and thus cannot properly deal with it no matter how we want
it handled, whether that means rejecting the policy altogether,
accepting the policy and permitting the undefined permissions, or
accepting the policy and denying the undefined permissions.  Note too
that the handler will likely remain conditional on some policy-defined
flag, so we will always need such detection logic even in that future
situation.  Until we have support for gracefully handling a missing
class or permission definition, we want to retain the safety property of
rejecting such policies.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
