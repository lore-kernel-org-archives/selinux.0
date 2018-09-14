Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8E04I5o024331
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 20:04:18 -0400
To: Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
 <0eb75e66-ed50-4013-6440-38bc2f814c6f@canonical.com>
 <CAGXu5jKZ7rquTux5fS+5tQ==0w_9rDTRaJWS_mS7C+Fy2dXRRQ@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a2ffa6b7-5d05-39a1-11c3-d715566e4d51@schaufler-ca.com>
Date: Thu, 13 Sep 2018 17:03:50 -0700
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKZ7rquTux5fS+5tQ==0w_9rDTRaJWS_mS7C+Fy2dXRRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/13/2018 4:51 PM, Kees Cook wrote:
> On Thu, Sep 13, 2018 at 4:32 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/13/2018 04:06 PM, Kees Cook wrote:
>>> - what order should any stacking happen? Makefile? security=?
>>>
>> Preferably not. For the single LSM we have the ability to choose the default LSM, ideally we let the distro decide in the Kconfig and the user with security=...
> I can't find a non-crazy way to do this in Kconfig. Right now, if I
> threw out all the _DEFAULT stuff, I could do:
>
> config SECURITY_SELINUX_ENABLED
>         bool "SELinux LSM enabled at boot time"
>         depends on SECURITY_SELINUX
>         depends on !SECURITY_APPARMOR_ENABLED && !SECURITY_SMACK_ENABLED
>         default SECURITY_SELINUX
>
> config SECURITY_SMACK_ENABLED
>         bool "SMACK LSM enabled at boot time"
>         depends on SECURITY_SMACK
>         depends on !SECURITY_APPARMOR_ENABLED && !SECURITY_SELINUX_ENABLED
>         default SECURITY_SMACK
>
> config SECURITY_APPARMOR_ENABLED
>         bool "AppArmor LSM enabled at boot time"
>         depends on SECURITY_APPARMOR
>         depends on !SECURITY_SMACK_ENABLED && !SECURITY_SELINUX_ENABLED
>         default SECURITY_APPARMOR
>
> config SECURITY_TOMOYO_ENABLED
>         bool "TOMOYO LSM enabled at boot time"
>         depends on SECURITY_TOMOYO
>         default y if !SECURITY_SELINUX_ENABLED &&
> !SECURITY_SMACK_ENABLED && !SECURITY_APPARMOR_ENABLED
>
> config DEFAULT_SECURITY
>         string
>         default "selinux" if SECURITY_SELINUX_ENABLED
>         default "smack" if SECURITY_SMACK_ENABLED
>         default "apparmor" if SECURITY_APPARMOR_ENABLED
>         default "tomoyo" if SECURITY_TOMOYO_ENABLED
>
> (As before CONFIG_DEFAULT_SECURITY basically means the effective
> "security=" contents. Reminder than Kconfig default are "first match",
> so tomoyo would only happen if all others are not enabled by default.)
>
> But this doesn't provide a way for Kconfig to declare the ordering of
> TOMOYO followed by SELinux. If we just declare ordering is a function
> of the Makefile, then the above would work as expected. The
> "conflicting major LSM" could be specified on "security=" and stacked
> could be enabled with $lsm.enable=1 (or disabled).
>
> So, before we can really make a decision, I think we have to decide:
> should ordering be arbitrary for even this level of stacking?

Do we have a case where it matters? I know that I could write a
module that would have issues if one hook got called and another
didn't because because a precursor module hook failed. I don't
think that any of the existing modules have this problem.
