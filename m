Subject: Re: [PATCH] kernel: selinux: policy selectable handling of unknown
	classes and perms
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1186068805.2434.40.camel@moss-spartans.epoch.ncsc.mil>
References: <1185983352.3673.16.camel@localhost.localdomain>
	 <1186065564.2434.12.camel@moss-spartans.epoch.ncsc.mil>
	 <46B1F5D1.3020804@manicmethod.com>
	 <1186068805.2434.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 13:25:12 -0400
Message-Id: <1186075512.4405.34.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 11:33 -0400, Stephen Smalley wrote:
> On Thu, 2007-08-02 at 11:18 -0400, Joshua Brindle wrote:
> > Stephen Smalley wrote:

> One would generally expect such people to be using policies that define
> all the classes and perms they care about, right?  Even more so in the
> -mls world, since you need them defined in order to define MLS
> constraints on them.
> 
> That is certainly a more specialized and security-aware community than
> the typical user, so it is fair to impose stronger requirements on them
> to configure their systems correctly.
> 
> Versus a typical kernel developer or user who just wants to run the
> latest kernel on his existing distro, and not have everything break the
> next time we add a new permission check.
> 
> If we require new policy to be used in order to gain the benefit of the
> compatibility behavior, then we aren't actually providing compatibility.
> If we could require policy upgrades in the first place when using a
> newer kernel, then we wouldn't have the problem that motivated this
> patch.
> 
> So either this patch cannot achieve its ends (regardless of default) or
> the default is wrong.

I will ask the question, is there any concern of people with strict
security goals grabbing some new kernel with this new feature and
shooting themselves in the foot?  Are there adequate safeguards at such
sites that they would not make this mistake?  I'm considering it for
RHEL5, will users of RHEL5 get themselves in trouble if we default to
allow?  Would all such interesting users either use the RHEL5 MLS policy
which would I assume default to reject_unknown?  Would they use custom
policy and most likely default to something they don't want unknowingly?

I also see a big different between "update your policy once and I'll
stop breaking your X/DCCP/whatever until policy fixes it" and "every
time Eric does some work you need a new policy"
> 
> > > Other points to ponder:
> > > - Would this have helped with the recent netlabel breakage?  I don't
> > > think so, as that was introducing a further check for an existing
> > > class/perm in the unlabeled case, not a new class/perm.

Maybe instead a versioning scheme?  Every security check comes with a
'version.'  Every time we add/change a security check we add one to the
'version' for that check.  If the policy handed to the kernel has a
'version' less than the value we get from the security hook call coded
in kernel we can just allow it?   Maybe that could be a solution to the
issue I am addressing now along with things like this netlabel change?
It certainly would have to touch a whole lot of stuff and might be a
pain to keep up with.  Lets say I move a security hook around in a
function, I need to decide if the version need to be bumped on that hook
or not.  Not impossible, but not pretty.  Also probably means a policy
version update, which in turn breaks the discussion which we have
ongoing above....

> > > - Does this help with letting us fix the ioctl hook?  Problem there is
> > > again that we are more likely to start mapping ioctls to read/write or
> > > getattr/setattr instead of the generic "ioctl" fallback rather than
> > > introducing new perms.
> > >   
> > How many policies give ioctl without giving read/write or 
> > getattr/setattr? Is this really an issue?
> 
> Today we typically allow ioctl whenever we allow read or write.  But
> remapping ioctl to read/write or getattr/setattr based on _IOC_DIR() may
> yield cases where we were only giving read perms (read + ioctl) but now
> we need read + write or read + setattr.  I don't if it will be an issue
> in practice, but it is technically a compatibility issue if it can ever
> cause a denial that would have been allowed previously.

versioning like I talk about isn't pretty, but it could solve the
problem...
> 
> > > - We still can't easily add new perms to common definitions (displaces
> > > class-specific ones).

next policy bump move (hey when I add my 'version' right?)
class-specific perms starting at the last bit and working forward while
make common perms start at the front and move back?  Guess that's just a
hack though and makes validating and stuff a whole lot harder since we
couldn't go from 0 to nperms.

> > >   
> > I'm not sure we are going to be able to handle this one until we extend 
> > object class/perm discovery to the kernel object managers, its a 
> > completely different problem from what this is attempting to solve.
> 
> Yep, just wondering if it would make more sense to tackle that one
> directly, at which point this one becomes moot, right?  Because if the
> object manager discovers that the class/perm isn't defined by the
> policy, it can disable the calling of the check altogether (which would
> also be more efficient than having the security server handle it).

/me is confuzzled   who in the kernel do you want to discover that
something isn't defined and to just 'not call' ?  How does this
something know not to do the new netlabel check?
> 
> > > - Does this help us with secmark at all, e.g. can we eliminate
> > > compat_net?  Do we want to eliminate compat_net yet?  Fedora still seems
> > > to have compat_net=1.

I want compat_net off.  99.9% of people pay a perf penalty on networking
and don't use any of it.  The only network hooks policy cares about are
bind/connect which don't care.

No, as it stand it does not help with secmark, and I don't think it
should.  Look at it this way, if you change the label on a file the
kernel shouldn't realize policy doesn't know you changed the label and
handle it special.  If you add iptables rules and change the label on a
network object you need to update policy.  We are going to need some
sort of working together somewhere to get secmark rules used by default,
but I don't think this is the place.

> > > - We still can't purge obsolete classes/perms or reorganize the existing
> > > ones safely with this change.

nope, although when do start allowing this we are going to end up with
some sort of kernel/userspace upgrade required at the same time, or at
least I assume so.....

> > >   
> > Ditto.
> > 
> > > So...is it worth it by itself?

obviously I thought so, but my opinion doesn't count for much on this
one, does it?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
