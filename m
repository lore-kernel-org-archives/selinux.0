Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8DLeMJl003468
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 17:40:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so5843091ljc.7
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 14:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
In-Reply-To: <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Sep 2018 17:38:15 -0400
Message-ID: <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 5:01 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 13, 2018 at 12:12 PM, Paul Moore <paul@paul-moore.com> wrote:
> > None of the above deals with the user experience or support burden a
> > distro would have by forcing stacking on.  If we make it an option the
>
> Just to make sure we're clear here: this series does not provide
> "extreme" stacking: SELinux, AppArmor, and SMACK remain boot-exclusive
> no matter what the CONFIGs.
>
> > distros can choose for themselves; picking a kernel build config is
> > not something new to distros, and I think Casey's text adequately
> > explains CONFIG_SECURITY_STACKING in terms that would be sufficient.
>
> I absolutely want stacking to be configurable, but I want to point out
> that there is no operational difference between
> CONFIG_SECURITY_STACKING=n and CONFIG_SECURITY_STACKING=y in the code
> here:
>
> - all the new accessor and allocation code is exercised in both cases
>
> - with stacking enabled: selinux, apparmor, and smack have an offset
> of 0 into blobs (and only one can be enabled at a time)
>
> - with stacking disabled: selinux, apparmor, and smack have an offset
> of 0 into blobs (and only one can be enabled at a time)
>
> The only behavioral difference is TOMOYO:
>
> 1- with stacking disabled and TOMOYO as the only major LSM, it will
> have a 0 offset into blobs (like above)
>
> 2- with stacking enabled and TOMOYO as the only major LSM, it will
> have a 0 offset into blobs (like above)
>
> 3- with stacking disabled and another major LSM is enabled, TOMOYO
> will be disabled (like always)
>
> 4- with stacking enabled and another major LSM is enabled, TOMOYO will
> have a non-0 offset into blobs and will run after selinux or smack or
> run before apparmor (based on link ordering defined by the Makefile).

Case #3/#4 is what I'm getting at, and I would argue demonstrates an
operational difference that is user visible/configurable.

Unless something has changed and I missed it, you can currently build
all of the LSMs into a single kernel image, and the admin/user can
choose one at boot time.  CONFIG_SECURITY_STACKING=y enables the
admin/user to stack LSMs (albeit with restrictions in the current
iteration) and CONFIG_SECURITY_STACKING=n limits the admin/user to a
single LSM (what we have now).  I understand that as of this moment we
are talking only about TOMOYO and AppArmor/Smack/SELinux, but everyone
knows that S.A.R.A/SARA and LandLock are going to follow shortly -
that's the whole point of this latest spin, isn't it?

> > I currently have a neutral stance on stacking, making it mandatory
> > pushes me more towards a "no".
>
> This is why I'm trying to explain myself: the infrastructure proposed
> here is always exercised, no matter the CONFIG. From that sense it is
> "mandatory" no matter what the config is. There isn't a reality where
> you could "turn off stacking", because it's not stacking until you
> actually stack something, and that will be disabled by default as I've
> proposed it.
>
> Let me put this another way: if we simply leave off patch 10, we can
> take the other 9 patches (modulo feedback), and we only have to decide
> how to expose "stacking"; all the infrastructure work for supporting
> it is done.
>
> I'm arguing that "security=" is likely insufficient to describe what
> we want, and instead we should focus on individual LSM enablement via
> parameters ("tomoyo.enabled=1"). If _ordering_ becomes an issue, we
> could either use parameter order, or use "security=" again maybe, but
> for now, ordering is already defined by the Makefile (and
> security/security.c).

The infrastructure bits aren't really my concern; in fact I *like*
that the infrastructure is always exercised, it makes
testing/debugging easier.  I also like the ability to limit the
user/admin to one LSM at boot time to make support easier; my goal is
to allow a distro to build support for multiple LSMs without also
requiring that distro to support *stacked* LSMs (see my earlier
comments about the difficulty in determining the source of a failed
operation).

-- 
paul moore
www.paul-moore.com
