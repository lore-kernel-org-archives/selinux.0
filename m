Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8DLp5ji003530
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 17:51:05 -0400
Received: by mail-lj1-f181.google.com with SMTP id f1-v6so5865367ljc.9
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 14:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <tb3zfQ7fac9Oth8YArOo84SbMfqV1s0DjOmVy7op90J_o1XOaEjflZloOpj9PIiUQRhKJxhauXzJD3irkSSjOXK94qYlfQ1frIQiH1OTWPQ=@protonmail.ch>
In-Reply-To: <tb3zfQ7fac9Oth8YArOo84SbMfqV1s0DjOmVy7op90J_o1XOaEjflZloOpj9PIiUQRhKJxhauXzJD3irkSSjOXK94qYlfQ1frIQiH1OTWPQ=@protonmail.ch>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Sep 2018 17:50:48 -0400
Message-ID: <CAHC9VhR0qfTn3qwVGpBV=LcM8O1jz-dmqxTW0OqJ-xfO+1k6ew@mail.gmail.com>
To: Golden_Miller83@protonmail.ch
Cc: keescook@chromium.org, casey@schaufler-ca.com,
 linux-security-module@vger.kernel.org,
 James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp,
 Stephen Smalley <sds@tycho.nsa.gov>, linux-fsdevel@vger.kernel.org,
 casey.schaufler@intel.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 13, 2018 at 4:58 PM Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
>
> On Thursday, September 13, 2018 9:12 PM, Paul Moore <paul@paul-moore.com> wrote:
>
> > On Thu, Sep 13, 2018 at 11:19 AM Kees Cook keescook@chromium.org wrote:
> >
> > > On Thu, Sep 13, 2018 at 6:16 AM, Paul Moore paul@paul-moore.com wrote:
> > >
> > > > On Thu, Sep 13, 2018 at 12:19 AM Kees Cook keescook@chromium.org wrote:

...

> > > > > I don't see a good reason to make this a config. Why shouldn't this
> > > > > always be enabled?
> > > >
> > > > I do. From a user perspective it is sometimes difficult to determine
> > > > the reason behind a failed operation; its is a DAC based denial, the
> > > > LSM, or some other failure? Stacking additional LSMs has the
> > > > potential to make this worse. The boot time configuration adds to the
> > > > complexity.
> > >
> > > Let me try to convince you otherwise. :) The reason I think there's no
> > > need for this is because the only functional change here is how
> > > TOMOYO gets stacked. And in my proposal, we can convert TOMOYO to be
> > > enabled/disabled like LoadPin. Given the configs I showed, stacking
> > > TOMOYO with the other major LSMs becomes a config (and/or boottime)
> > > option.
> > > The changes for TOMOYO are still needed even with SECURITY_STACKING,
> > > and I argue that the other major LSMs remain the same. It's only
> > > infrastructure that has changed. So, I think having SECURITY_STACKING
> > > actually makes things more complex internally (all the ifdefs, weird
> > > enable logic) and for distros ("what's this stacking option", etc?)
> >
> > None of the above deals with the user experience or support burden a
> > distro would have by forcing stacking on. If we make it an option the
> > distros can choose for themselves; picking a kernel build config is
> > not something new to distros, and I think Casey's text adequately
> > explains CONFIG_SECURITY_STACKING in terms that would be sufficient.
>
> CONFIG_SECURITY_STACKING doesn't make any user visible changes on
> itself as it doesn't automatically enable any new LSM. The LSM
> specific configs are place where users/distros make decisions. If
> there is only one LSM enabled to run then there's nothing to stack.
> If someone choose to run two or more LSM in config/boot cmdline
> then we can assume having it stacked is what they wanted. As Kees
> pointed there is already CONFIG_SECURITY_DEFAULT_XXX. In both cases
> CONFIG_SECURITY_STACKING is redundant and only adds burden instead
> of removing it.

See my last response to Kees.

> > I currently have a neutral stance on stacking, making it mandatory
> > pushes me more towards a "no".
>
> This implies that your real concern is something else than
> CONFIG_SECURITY_STACKING which only allows you to ignore the whole
> thing. Please reveal it. There are a lot of people waiting for LSM
> stacking which is several years late and it would be great to
> resolve potential issues earlier  rather later.

What?  I resent the implication that I'm hiding anything; there are a
lot of fair criticisms you could level at me, but I take offense at
the idea that I'm not being honest here.  I've been speaking with
Casey, John, and others about stacking for years, both on-list and
in-person at conferences, and my
neutral-opinion-just-make-it-work-for-everything-and-make-it-optional
stance has been pretty consistent and isn't new.

Also, let's be really clear here: I'm only asking that stacking be
made a build time option (as it is in Casey's patchset).  That seems
like a pretty modest ask for something so significant and "several
years late" as you put it.

-- 
paul moore
www.paul-moore.com
