Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8E2iPHw012937
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 22:44:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so6284223ljk.1
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 19:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
In-Reply-To: <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Sep 2018 22:42:59 -0400
Message-ID: <CAHC9VhRXOuGqSw9yu18QZeA1z+vYwLFixTqEJ1WyBBFCeLebuA@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 5:52 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 13, 2018 at 2:38 PM, Paul Moore <paul@paul-moore.com> wrote:
> > The infrastructure bits aren't really my concern; in fact I *like*
> > that the infrastructure is always exercised, it makes
> > testing/debugging easier.  I also like the ability to limit the
> > user/admin to one LSM at boot time to make support easier; my goal is
> > to allow a distro to build support for multiple LSMs without also
> > requiring that distro to support *stacked* LSMs
>
> I see your point, but as soon as SARA and Landlock appear, they'll have:
>
>     depends on SECURITY_STACKING
>
> and then all distros will enable it and there will be no sensible
> runtime way to manage it. If, instead, we make it entirely runtime
> now, then a CONFIG can control the default state and we can provide
> guidance to how SARA and Landlock should expose their "enable"ness.

I question why SARA and LandLock require stacking.  While some LSMs
may benefit from stacking, e.g. Yama, traditionally each LSM has been
able to stand on its own.  I think this is a quality that should be
preserved.

> > (see my earlier
> > comments about the difficulty in determining the source of a failed
> > operation).
>
> Agreed. I would hope that audit could help for that case. *stare at blue sky*

*also staring at blue sky*

Audit can help, but it is independent of the LSMs and not a hard
requirement for all, and even when it is enabled the config might not
be suitable to provide enough information to be helpful in this case.

-- 
paul moore
www.paul-moore.com
