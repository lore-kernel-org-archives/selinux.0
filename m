Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8DJCvr7014181
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 15:12:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id z11-v6so5754662lff.9
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 12:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Sep 2018 15:12:32 -0400
Message-ID: <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
To: keescook@chromium.org
Cc: casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
 James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp,
 Stephen Smalley <sds@tycho.nsa.gov>, linux-fsdevel@vger.kernel.org,
 adobriyan@gmail.com, casey.schaufler@intel.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 13, 2018 at 11:19 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 13, 2018 at 6:16 AM, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Sep 13, 2018 at 12:19 AM Kees Cook <keescook@chromium.org> wrote:
> >> On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> > Two proposed security modules require the ability to
> >> > share security blobs with existing "major" security modules.
> >> > These modules, S.A.R.A and LandLock, provide significantly
> >> > different services than SELinux, Smack or AppArmor. Using
> >> > either in conjunction with the existing modules is quite
> >> > reasonable. S.A.R.A requires access to the cred blob, while
> >> > LandLock uses the cred, file and inode blobs.
> >> >
> >> > The use of the cred, file and inode blobs has been
> >> > abstracted in preceding patches in the series. This
> >> > patch teaches the affected security modules how to access
> >> > the part of the blob set aside for their use in the case
> >> > where blobs are shared. The configuration option
> >> > CONFIG_SECURITY_STACKING identifies systems where the
> >> > blobs may be shared.
> >> >
> >> > The mechanism for selecting which security modules are
> >> > active has been changed to allow non-conflicting "major"
> >> > security modules to be used together. At this time the
> >> > TOMOYO module can safely be used with any of the others.
> >> > The two new modules would be non-conflicting as well.
> >> >
> >> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> > ---
> >> >  Documentation/admin-guide/LSM/index.rst | 14 +++--
> >> >  include/linux/lsm_hooks.h               |  2 +-
> >> >  security/Kconfig                        | 81 +++++++++++++++++++++++++
> >> >  security/apparmor/include/cred.h        |  8 +++
> >> >  security/apparmor/include/file.h        |  9 ++-
> >> >  security/apparmor/include/lib.h         |  4 ++
> >> >  security/apparmor/lsm.c                 |  8 ++-
> >> >  security/security.c                     | 30 ++++++++-
> >> >  security/selinux/hooks.c                |  3 +-
> >> >  security/selinux/include/objsec.h       | 18 +++++-
> >> >  security/smack/smack.h                  | 19 +++++-
> >> >  security/smack/smack_lsm.c              | 17 +++---
> >> >  security/tomoyo/common.h                | 12 +++-
> >> >  security/tomoyo/tomoyo.c                |  3 +-
> >> >  14 files changed, 200 insertions(+), 28 deletions(-)
> >
> > ...
> >
> >> > diff --git a/security/Kconfig b/security/Kconfig
> >> > index 22f7664c4977..ed48025ae9e0 100644
> >> > --- a/security/Kconfig
> >> > +++ b/security/Kconfig
> >> > @@ -36,6 +36,28 @@ config SECURITY_WRITABLE_HOOKS
> >> >         bool
> >> >         default n
> >> >
> >> > +config SECURITY_STACKING
> >> > +       bool "Security module stacking"
> >> > +       depends on SECURITY
> >> > +       help
> >> > +         Allows multiple major security modules to be stacked.
> >> > +         Modules are invoked in the order registered with a
> >> > +         "bail on fail" policy, in which the infrastructure
> >> > +         will stop processing once a denial is detected. Not
> >> > +         all modules can be stacked. SELinux, Smack and AppArmor are
> >> > +         known to be incompatible. User space components may
> >> > +         have trouble identifying the security module providing
> >> > +         data in some cases.
> >> > +
> >> > +         If you select this option you will have to select which
> >> > +         of the stackable modules you wish to be active. The
> >> > +         "Default security module" will be ignored. The boot line
> >> > +         "security=" option can be used to specify that one of
> >> > +         the modules identifed for stacking should be used instead
> >> > +         of the entire stack.
> >> > +
> >> > +         If you are unsure how to answer this question, answer N.
> >>
> >> I don't see a good reason to make this a config. Why shouldn't this
> >> always be enabled?
> >
> > I do.  From a user perspective it is sometimes difficult to determine
> > the reason behind a failed operation; its is a DAC based denial, the
> > LSM, or some other failure?  Stacking additional LSMs has the
> > potential to make this worse.  The boot time configuration adds to the
> > complexity.
>
> Let me try to convince you otherwise. :) The reason I think there's no
> need for this is because the only functional change here is how
> _TOMOYO_ gets stacked. And in my proposal, we can convert TOMOYO to be
> enabled/disabled like LoadPin. Given the configs I showed, stacking
> TOMOYO with the other major LSMs becomes a config (and/or boottime)
> option.
>
> The changes for TOMOYO are still needed even _with_ SECURITY_STACKING,
> and I argue that the other major LSMs remain the same. It's only
> infrastructure that has changed. So, I think having SECURITY_STACKING
> actually makes things more complex internally (all the ifdefs, weird
> enable logic) and for distros ("what's this stacking option", etc?)

None of the above deals with the user experience or support burden a
distro would have by forcing stacking on.  If we make it an option the
distros can choose for themselves; picking a kernel build config is
not something new to distros, and I think Casey's text adequately
explains CONFIG_SECURITY_STACKING in terms that would be sufficient.
I currently have a neutral stance on stacking, making it mandatory
pushes me more towards a "no".

As far as the cpp ifdef's, and other conditionals are concerned, I
remain unconvinced this is any worse than any other significant
feature that is a build time option.

-- 
paul moore
www.paul-moore.com
