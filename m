Message-ID: <1495053946.32535.32.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2] selinux: log policy capability state when a policy
 is loaded
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 17 May 2017 16:45:46 -0400
In-Reply-To: <CAHC9VhR-8ejo9oOFu1m0HXgSs0nV+j9g_p3+X1-sC_rhSX=-sw@mail.gmail.com>
References: <20170512164423.17190-1-sds@tycho.nsa.gov>
 <CAHC9VhTcuba55YGaTFg0r8AewE9MXovhHpmnpYSc0D4ZCbLg7g@mail.gmail.com>
 <1494969093.21557.20.camel@tycho.nsa.gov>
 <CAHC9VhQjJ8qG2hYEvD9aJFN5hnp5durLffB-M1W8SJ+CyD=DQA@mail.gmail.com>
 <1495027020.32535.3.camel@tycho.nsa.gov>
 <CAHC9VhR-8ejo9oOFu1m0HXgSs0nV+j9g_p3+X1-sC_rhSX=-sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-17 at 15:39 -0400, Paul Moore wrote:
> On Wed, May 17, 2017 at 9:17 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Tue, 2017-05-16 at 17:19 -0400, Paul Moore wrote:
> > > On Tue, May 16, 2017 at 5:11 PM, Stephen Smalley <sds@tycho.nsa.g
> > > ov>
> > > wrote:
> 
> ...
> 
> > > > If the kernel does not support a policy capability that was
> > > > enabled
> > > > in
> > > > the policy, then it may not be capable of enforcing the policy
> > > > as
> > > > intended, and may therefore be operating insecurely (e.g.
> > > > consider
> > > > if
> > > > your kernel was too old to support network_peer_controls or
> > > > always_check_network or open_perms but your policy has enabled
> > > > them
> > > > and
> > > > is relying on those checks to be present) ...
> > > 
> > > Well, I think the key is "may"; depending on the policy
> > > capability
> > > and
> > > the handle_unknown setting things might not fail in an insecure
> > > manner, but the system would definitely behave
> > > strangely.  Regardless,
> > > I see your point and I'm now wondering if we should just fail the
> > > policy load if we detect any policy capabilities beyond what we
> > > know
> > > about.
> > 
> > I think that would prove problematic in practice since the system
> > would
> > then refuse to boot with such a policy (the only way to boot in
> > Linux
> > distributions would then be to boot with enforcing=0 and come up
> > with
> > no policy - requiring you to then replace the policy, reboot, and
> > relabel, and in Android you can't boot at all if policy load fails
> > - it
> > will reboot into recovery mode).  It would mean that we could not
> > add a
> > new policy capability to a policy until we were sure that no one
> > was
> > still using a kernel that predated the support for it.
> 
> Isn't that the right thing to do anyway?  You shouldn't use a policy
> with a policy capability on a kernel that has no knowledge of the
> policy capability for the reasons we've already discussed.  I'm also
> going to guess that this isn't as large a problem as we may be making
> it out, distributions should catch this problem fairly quickly in
> their development process and those that are savvy enough to load
> their own policy should know how to handle this as well.

Possibly I overstated the seriousness of using a policy with an unknown
policy capability ;) Historically we have preserved compatibility in
policies so that old kernels continued to work correctly even if they
do not support the capability, and you would only lose out on the
ability to leverage that capability for improved access control.

I don't think we can/should rely on the distributions to ensure that
users don't end up with unbootable systems.  The people maintaining
policy are not the same as the people maintaining the kernel, we've
gone to great lengths to allow them to be independently updated, and
the point at which their updates take effect differs (policy updates
are immediately loaded; kernel updates won't until they choose to
reboot into the new kernel).  Even better, a policy load failure at
update time might not even be visible to the user, particularly as it
isn't even visible to rpm (hurray for doing things from %post), so they
might not know they are in trouble until they next reboot and find
their system dead.  Further, some distributions support multiple
kernels, and all distributions support multiple kernels over time (i.e.
updates).  So the potential for users to end up with newer policy that
enables a capability unknown to their currently running kernel is
significant.  Even if the policy packager carefully tests the policy on
the kernel he is running, that's no guarantee it will work for all
users.  And the failure mode would be quite severe; the system would
refuse to boot, they would have to boot with enforcing=0, no policy
would load (effectively selinux=0), download a fixed policy, reboot and
relabel.  That would not be good PR for selinux.

> 
> > That would more or less preclude new policy capabilities from ever
> > being enabled by
> > default in refpolicy (or at least take years to introduce them) ...
> 
> Once again, is it safe for refpolicy to enable these now if we are
> worrying about older kernels?

Well, as I said, it has generally been done in a backward-compatible
manner, so the system degrades gracefully.  And we have to be able to
add them in a timely manner if we don't want SELinux advancement to
come to a halt.

> > ... and
> > would also be a problem for Android, since many different kernel
> > versions (and often much older ones) are used with both.
> 
> I'm not saying I have completely made my mind up about this, but
> right
> now I'm thinking the issue of new-policy/old-kernel is a distro
> problem (I view Android as just another distribution) and not
> something we can safely resolve upstream.

Android is in some ways easier than distributions (policy and kernel
are not updated independently), but in other ways it is harder (every
device forks its own kernel and maintains it, so kernel maintenance is
even more distributed, and kernels are often not updated or at least
not rebased).  I don't think we can count on that going well either.

> 
> > A warning seemed like a reasonable middle ground between silently
> > ignoring unknown policy capabilities (as the kernel currently does
> > before this patch) and rejecting the policy altogether.  WARN vs
> > INFO
> > was due to the fact that an unknown capability seemed more
> > significant
> > and potentially an indicator of a kernel/policy mismatch than the
> > state
> > of the known policy capabilities.

Still think warning is best.  Willing to degrade to info.  Not willing
to fail on policy load.
