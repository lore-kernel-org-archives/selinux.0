Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8DL3xQP030266
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 17:03:59 -0400
Received: by mail-yw1-f67.google.com with SMTP id p206-v6so1769356ywg.12
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 14:01:54 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com.
 [209.85.219.181])
 by smtp.gmail.com with ESMTPSA id d10-v6sm4908928ywh.87.2018.09.13.14.01.49
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Sep 2018 14:01:49 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id k5-v6so3877491ybo.10
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 14:01:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 13 Sep 2018 14:01:48 -0700
Message-ID: <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 13, 2018 at 12:12 PM, Paul Moore <paul@paul-moore.com> wrote:
> None of the above deals with the user experience or support burden a
> distro would have by forcing stacking on.  If we make it an option the

Just to make sure we're clear here: this series does not provide
"extreme" stacking: SELinux, AppArmor, and SMACK remain boot-exclusive
no matter what the CONFIGs.

> distros can choose for themselves; picking a kernel build config is
> not something new to distros, and I think Casey's text adequately
> explains CONFIG_SECURITY_STACKING in terms that would be sufficient.

I absolutely want stacking to be configurable, but I want to point out
that there is no operational difference between
CONFIG_SECURITY_STACKING=n and CONFIG_SECURITY_STACKING=y in the code
here:

- all the new accessor and allocation code is exercised in both cases

- with stacking enabled: selinux, apparmor, and smack have an offset
of 0 into blobs (and only one can be enabled at a time)

- with stacking disabled: selinux, apparmor, and smack have an offset
of 0 into blobs (and only one can be enabled at a time)

The only behavioral difference is TOMOYO:

1- with stacking disabled and TOMOYO as the only major LSM, it will
have a 0 offset into blobs (like above)

2- with stacking enabled and TOMOYO as the only major LSM, it will
have a 0 offset into blobs (like above)

3- with stacking disabled and another major LSM is enabled, TOMOYO
will be disabled (like always)

4- with stacking enabled and another major LSM is enabled, TOMOYO will
have a non-0 offset into blobs and will run after selinux or smack or
run before apparmor (based on link ordering defined by the Makefile).

Note that cases 1, 2, and 3 are identical in behavior to before this
series. Only case 4 is different, which is why I'm saying that instead
of creating a redundant and needlessly complex config, or reinventing
the "enable" wheel, we should simply drop the no-op
CONFIG_SECURITY_STACKING config and provide TOMOYO with an "enable"
parameter (and CONFIG). And it should be _separate_ from the
"security=" line.

This will be the SAME outcome for distros: if they want stacking, they
choose the "enable TOMOYO by default" CONFIG. If they don't want
stacking, they don't.

> I currently have a neutral stance on stacking, making it mandatory
> pushes me more towards a "no".

This is why I'm trying to explain myself: the infrastructure proposed
here is always exercised, no matter the CONFIG. From that sense it is
"mandatory" no matter what the config is. There isn't a reality where
you could "turn off stacking", because it's not stacking until you
actually stack something, and that will be disabled by default as I've
proposed it.

Let me put this another way: if we simply leave off patch 10, we can
take the other 9 patches (modulo feedback), and we only have to decide
how to expose "stacking"; all the infrastructure work for supporting
it is done.

I'm arguing that "security=" is likely insufficient to describe what
we want, and instead we should focus on individual LSM enablement via
parameters ("tomoyo.enabled=1"). If _ordering_ becomes an issue, we
could either use parameter order, or use "security=" again maybe, but
for now, ordering is already defined by the Makefile (and
security/security.c).

"Stacking" only exists if you try to enable one of [selinux, apparmor,
or smack] AND tomoyo. CONFIG_SECURITY_STACKING is redundant: if you
want to disable stacking, you just disable tomoyo if you have another
LSM (which we can already enforce in the Kconfig).

If you want something more explicit than per-LSM config, then a simple
"security.lsm_stack=1/0" with a CONFIG for the default would be fine.
I'm trying to argue against what appears to be needless complexity
around CONFIG_SECURITY_STACK as it was proposed, since it doesn't
provide a meaningful operational change, since exclusivity of major
LSMs is already handled.

> As far as the cpp ifdef's, and other conditionals are concerned, I
> remain unconvinced this is any worse than any other significant
> feature that is a build time option.

That's fine. That's just a code style issue. What I'm trying to show
is that by lifting the allocation logic up out of the LSMs, we've
actually simplified the logic. The "stacking" part will only become a
distro-choice once they knowingly enable TOMOYO or build in SARA
and/or Landlock in the future.

-Kees

-- 
Kees Cook
Pixel Security
