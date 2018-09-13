Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8DLq5d0005970
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 17:52:09 -0400
Received: by mail-yb1-f195.google.com with SMTP id y20-v6so3922269ybi.13
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 14:52:03 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com.
 [209.85.219.174])
 by smtp.gmail.com with ESMTPSA id t124-v6sm3328878ywt.105.2018.09.13.14.51.58
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Sep 2018 14:51:59 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id c4-v6so3946643ybl.6
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 14:51:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 13 Sep 2018 14:51:57 -0700
Message-ID: <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 2:38 PM, Paul Moore <paul@paul-moore.com> wrote:
> The infrastructure bits aren't really my concern; in fact I *like*
> that the infrastructure is always exercised, it makes
> testing/debugging easier.  I also like the ability to limit the
> user/admin to one LSM at boot time to make support easier; my goal is
> to allow a distro to build support for multiple LSMs without also
> requiring that distro to support *stacked* LSMs

I see your point, but as soon as SARA and Landlock appear, they'll have:

    depends on SECURITY_STACKING

and then all distros will enable it and there will be no sensible
runtime way to manage it. If, instead, we make it entirely runtime
now, then a CONFIG can control the default state and we can provide
guidance to how SARA and Landlock should expose their "enable"ness.

At the very least, to avoid stacking now (i.e. TOMOYO being enabled
with another major LSM), we just do nothing. The existing code already
makes the existing major LSMs exclusive. Adding a stackable LSM would
need to just have its own "enable" flag (i.e. ignore
security_module_enable()), and then either check a runtime "is
stacking allowed?" flag or have new "depends on SECURITY_STACKING". (I
think the CONFIG will force distros into enabling it without any
runtime opt-out.)

> (see my earlier
> comments about the difficulty in determining the source of a failed
> operation).

Agreed. I would hope that audit could help for that case. *stare at blue sky*

-Kees

-- 
Kees Cook
Pixel Security
