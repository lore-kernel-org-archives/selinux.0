Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4IKdkAk018132
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 16:39:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so545918wrc.3
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 13:39:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495053946.32535.32.camel@tycho.nsa.gov>
References: <20170512164423.17190-1-sds@tycho.nsa.gov>
 <CAHC9VhTcuba55YGaTFg0r8AewE9MXovhHpmnpYSc0D4ZCbLg7g@mail.gmail.com>
 <1494969093.21557.20.camel@tycho.nsa.gov>
 <CAHC9VhQjJ8qG2hYEvD9aJFN5hnp5durLffB-M1W8SJ+CyD=DQA@mail.gmail.com>
 <1495027020.32535.3.camel@tycho.nsa.gov>
 <CAHC9VhR-8ejo9oOFu1m0HXgSs0nV+j9g_p3+X1-sC_rhSX=-sw@mail.gmail.com>
 <1495053946.32535.32.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 May 2017 16:39:37 -0400
Message-ID: <CAHC9VhQboAiF2caYyKwzF4LDteGjUjAhzrWkg6Wefjc7R4EW6w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: log policy capability state when a policy is
 loaded
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 17, 2017 at 4:45 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-05-17 at 15:39 -0400, Paul Moore wrote:

...

>> Isn't that the right thing to do anyway?  You shouldn't use a policy
>> with a policy capability on a kernel that has no knowledge of the
>> policy capability for the reasons we've already discussed.  I'm also
>> going to guess that this isn't as large a problem as we may be making
>> it out, distributions should catch this problem fairly quickly in
>> their development process and those that are savvy enough to load
>> their own policy should know how to handle this as well.
>
> Possibly I overstated the seriousness of using a policy with an unknown
> policy capability ;)

There ya go, you just made me threaten to fail the policy load to get here ;)

> Historically we have preserved compatibility in
> policies so that old kernels continued to work correctly even if they
> do not support the capability, and you would only lose out on the
> ability to leverage that capability for improved access control.

Yes, I agree that I don't think this is a serious issue with any of
the existing policy capabilities.

> I don't think we can/should rely on the distributions to ensure that
> users don't end up with unbootable systems ...

I obviously agree, how could one not?  However, I also think we need
to take a realistic view of distributions that take use rather extreme
default configurations and don't ensure that their updates are
properly managed.  I don't see the point in arguing every possible
combination in this thread (I think we all have other more important
things to do, at least I hope we do), but I don't want to be held
responsible if a distro shoots *itself* in the foot.

>> > A warning seemed like a reasonable middle ground between silently
>> > ignoring unknown policy capabilities (as the kernel currently does
>> > before this patch) and rejecting the policy altogether.  WARN vs
>> > INFO
>> > was due to the fact that an unknown capability seemed more
>> > significant
>> > and potentially an indicator of a kernel/policy mismatch than the
>> > state
>> > of the known policy capabilities.
>
> Still think warning is best.  Willing to degrade to info.  Not willing
> to fail on policy load.

INFO please.

-- 
paul moore
www.paul-moore.com
