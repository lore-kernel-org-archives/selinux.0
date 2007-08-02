Subject: Re: [PATCH] kernel: selinux: policy selectable handling of unknown
	classes and perms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <46B1F5D1.3020804@manicmethod.com>
References: <1185983352.3673.16.camel@localhost.localdomain>
	 <1186065564.2434.12.camel@moss-spartans.epoch.ncsc.mil>
	 <46B1F5D1.3020804@manicmethod.com>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 11:33:25 -0400
Message-Id: <1186068805.2434.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 11:18 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-08-01 at 11:49 -0400, Eric Paris wrote:
> >   
> >> Allow policy to select, in much the same way as it selects MLS support,
> >> how the kernel should handle access decisions which contain either
> >> unknown classes or unknown permissions in unknown classes.  The three
> >> choices are (from a kernel perspective)
> >>
> >> 0 - Deny unknown security access. (default)
> >> 2 - reject loading policy if it does not contain all definitions
> >> 4 - allow unknown security access
> >>     
> >
> > If we leave the default as the current behavior (i.e. deny access if
> > checking an unknown class or permission), then what exactly have we
> > achieved with this patch?  The next time we introduce a new permission
> > check in the kernel, anyone who installs that kernel on an existing
> > distribution release will still encounter breakage.  It will only start
> > providing benefit for newer distribution releases with policies built to
> > have the non-default setting.
> >
> >   
> I don't think we should change the default behavior of the policy, this 
> could have some very unintended consequences to people building policies 
> for security oriented systems that may not be aware of the build 
> infrastructure changes necessary to keep the old behavior.

One would generally expect such people to be using policies that define
all the classes and perms they care about, right?  Even more so in the
-mls world, since you need them defined in order to define MLS
constraints on them.

That is certainly a more specialized and security-aware community than
the typical user, so it is fair to impose stronger requirements on them
to configure their systems correctly.

Versus a typical kernel developer or user who just wants to run the
latest kernel on his existing distro, and not have everything break the
next time we add a new permission check.

If we require new policy to be used in order to gain the benefit of the
compatibility behavior, then we aren't actually providing compatibility.
If we could require policy upgrades in the first place when using a
newer kernel, then we wouldn't have the problem that motivated this
patch.

So either this patch cannot achieve its ends (regardless of default) or
the default is wrong.

> > Other points to ponder:
> > - Would this have helped with the recent netlabel breakage?  I don't
> > think so, as that was introducing a further check for an existing
> > class/perm in the unlabeled case, not a new class/perm.
> > - Does this help with letting us fix the ioctl hook?  Problem there is
> > again that we are more likely to start mapping ioctls to read/write or
> > getattr/setattr instead of the generic "ioctl" fallback rather than
> > introducing new perms.
> >   
> How many policies give ioctl without giving read/write or 
> getattr/setattr? Is this really an issue?

Today we typically allow ioctl whenever we allow read or write.  But
remapping ioctl to read/write or getattr/setattr based on _IOC_DIR() may
yield cases where we were only giving read perms (read + ioctl) but now
we need read + write or read + setattr.  I don't if it will be an issue
in practice, but it is technically a compatibility issue if it can ever
cause a denial that would have been allowed previously.

> > - We still can't easily add new perms to common definitions (displaces
> > class-specific ones).
> >   
> I'm not sure we are going to be able to handle this one until we extend 
> object class/perm discovery to the kernel object managers, its a 
> completely different problem from what this is attempting to solve.

Yep, just wondering if it would make more sense to tackle that one
directly, at which point this one becomes moot, right?  Because if the
object manager discovers that the class/perm isn't defined by the
policy, it can disable the calling of the check altogether (which would
also be more efficient than having the security server handle it).

> > - Does this help us with secmark at all, e.g. can we eliminate
> > compat_net?  Do we want to eliminate compat_net yet?  Fedora still seems
> > to have compat_net=1.
> > - We still can't purge obsolete classes/perms or reorganize the existing
> > ones safely with this change.
> >   
> Ditto.
> 
> > So...is it worth it by itself?
> >   

You didn't answer the question ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
