Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4HJdx6r027408
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 15:40:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id v4so5972967wmb.2
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 12:39:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495027020.32535.3.camel@tycho.nsa.gov>
References: <20170512164423.17190-1-sds@tycho.nsa.gov>
 <CAHC9VhTcuba55YGaTFg0r8AewE9MXovhHpmnpYSc0D4ZCbLg7g@mail.gmail.com>
 <1494969093.21557.20.camel@tycho.nsa.gov>
 <CAHC9VhQjJ8qG2hYEvD9aJFN5hnp5durLffB-M1W8SJ+CyD=DQA@mail.gmail.com>
 <1495027020.32535.3.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 May 2017 15:39:55 -0400
Message-ID: <CAHC9VhR-8ejo9oOFu1m0HXgSs0nV+j9g_p3+X1-sC_rhSX=-sw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: log policy capability state when a policy is
 loaded
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 17, 2017 at 9:17 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2017-05-16 at 17:19 -0400, Paul Moore wrote:
>> On Tue, May 16, 2017 at 5:11 PM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:

...

>> > If the kernel does not support a policy capability that was enabled
>> > in
>> > the policy, then it may not be capable of enforcing the policy as
>> > intended, and may therefore be operating insecurely (e.g. consider
>> > if
>> > your kernel was too old to support network_peer_controls or
>> > always_check_network or open_perms but your policy has enabled them
>> > and
>> > is relying on those checks to be present) ...
>>
>> Well, I think the key is "may"; depending on the policy capability
>> and
>> the handle_unknown setting things might not fail in an insecure
>> manner, but the system would definitely behave
>> strangely.  Regardless,
>> I see your point and I'm now wondering if we should just fail the
>> policy load if we detect any policy capabilities beyond what we know
>> about.
>
> I think that would prove problematic in practice since the system would
> then refuse to boot with such a policy (the only way to boot in Linux
> distributions would then be to boot with enforcing=0 and come up with
> no policy - requiring you to then replace the policy, reboot, and
> relabel, and in Android you can't boot at all if policy load fails - it
> will reboot into recovery mode).  It would mean that we could not add a
> new policy capability to a policy until we were sure that no one was
> still using a kernel that predated the support for it.

Isn't that the right thing to do anyway?  You shouldn't use a policy
with a policy capability on a kernel that has no knowledge of the
policy capability for the reasons we've already discussed.  I'm also
going to guess that this isn't as large a problem as we may be making
it out, distributions should catch this problem fairly quickly in
their development process and those that are savvy enough to load
their own policy should know how to handle this as well.

> That would more or less preclude new policy capabilities from ever being enabled by
> default in refpolicy (or at least take years to introduce them) ...

Once again, is it safe for refpolicy to enable these now if we are
worrying about older kernels?

> ... and
> would also be a problem for Android, since many different kernel
> versions (and often much older ones) are used with both.

I'm not saying I have completely made my mind up about this, but right
now I'm thinking the issue of new-policy/old-kernel is a distro
problem (I view Android as just another distribution) and not
something we can safely resolve upstream.

> A warning seemed like a reasonable middle ground between silently
> ignoring unknown policy capabilities (as the kernel currently does
> before this patch) and rejecting the policy altogether.  WARN vs INFO
> was due to the fact that an unknown capability seemed more significant
> and potentially an indicator of a kernel/policy mismatch than the state
> of the known policy capabilities.

-- 
paul moore
www.paul-moore.com
