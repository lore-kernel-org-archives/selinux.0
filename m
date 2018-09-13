Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8DNpi8D021716
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 19:51:45 -0400
To: Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>, John Johansen
 <john.johansen@canonical.com>,
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
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
Date: Thu, 13 Sep 2018 16:51:28 -0700
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/13/2018 4:06 PM, Kees Cook wrote:
> On Thu, Sep 13, 2018 at 2:51 PM, Kees Cook <keescook@chromium.org> wrote:
>> At the very least, to avoid stacking now (i.e. TOMOYO being enabled
>> with another major LSM), we just do nothing. The existing code already
>> makes the existing major LSMs exclusive. Adding a stackable LSM would
>> need to just have its own "enable" flag (i.e. ignore
>> security_module_enable()), and then either check a runtime "is
>> stacking allowed?" flag or have new "depends on SECURITY_STACKING". (I
>> think the CONFIG will force distros into enabling it without any
>> runtime opt-out.)
> Before stacking, we have:
>
> - major LSM, pick one

 - major LSM, pick at most one

> - all CONFIG minor LSMs, in security.c order
>
> There are two minor LSMs: Yama and LoadPin. If built, Yama is always
> on (though it has sysctl knobs). If built, LoadPin is controlled by a
> boot param.
>
> Picking the major LSM happens via "security=$LSM" and a per-LSM check
> of security_module_enable("$LSM").
>
> Ordering is major, then per security.c for minors.

Modules are invoked in the order they are registered.
Minor modules are registered first, so they are invoked before
the major module. This is important because capability comes
first.

> Under stacking, we have:
>
> The minor LSMs remain unchanged.

It wouldn't hurt to use the same registration process for
minor modules as major modules now that you can register more
than one. I haven't changed that because it's unnecessary and
just adds pointless overhead. If we adopt some of the suggestions
below, it may make sense to use the full-up process.

> We don't have SARA and Landlock yet, but we do have TOMOYO, which we
> can use as an example to future "compatible blob-using LSMs".
>
> I see two issues:
>
> - how to determine which set of LSMs are enabled at boot
> - how to determine the ORDER of the LSMs
>
>
> Casey's implementation does this (correct me if I'm wrong):
>
> The minor LSMs remain unchanged.
>
> SECURITY_$lsm_STACKED determines which major is enabled, with
> SECURITY_TOMOYO_STACKED allowed in addition.

Mostly correct. SECURITY_$lsm_STACKED instructs the security module
to register its hooks. Kconfig enforces that you can't specify more
than one of SECURITY_SELINUX_STACKED, SECURITY_SMACK_STACKED, and
SECURITY_APPARMOR_STACKED. 

> If security= is
> specified, all other major LSMs are disabled (i.e. it is not possible
> to switch between SELinux/AppArmor/SMACK without also disabling
> TOMOYO).

Correct.

> Ordering is per security/Makefile modulo enabled-ness for majors (i.e.
> TOMOYO is always _before_ AppArmor if stacked together, otherwise
> after SELinux and SMACK), and per security.c for minors.

Correct.

> I don't think this is how we want it to work. For example, Ubuntu
> builds in all LSMs, and default-enables AppArmor. If an Ubuntu user
> wants TOMOYO, the boot with "security=tomoyo". If Ubuntu wants to make
> stacking available to users but off by default, what CONFIGs do they
> pick? They could try SECURITY_APPARMOR_STACKED=y and
> SECURITY_TOMOYO_STACKED=n, but then how does an end user choose
> "apparmor and tomoyo" (or more meaningfully, for the future:
> "apparmor, sara, and landlock")? They can still pick
> "security=tomoyo", but there isn't a runtime way to opt into stacking.

Correct.
Earlier versions of the stacking patchset allowed security=lsm1,lsm2,...,lsmN.
I haven't retrofit that to the current module registration mechanism.
I believe that John Johansen has a patch in Ubuntu for doing this. I don't
have it handy. It's the obvious and backward compatible way to do it.

> What about leaving SECURITY_$lsm_DEFAULT as-is, and then...

That works when you're not stacking or only want one, but isn't
sensible for the general case.

> In the past I'd suggested using "security=" to determine both enabled
> and order: "security=tomoyo,smack" would mean stacked LSMs, with
> tomoyo going first.
>
> Currently I'm leaning towards "security=" to select ONLY the
> incompatible LSM, and per-LSM "enable" flags to determine stacking:
>
>     tomoyo.enabled=1 security=smack

I know that I've seen a TOMOYO installation that explicitly sets
security=tomoyo, so I don't see that working.

> This doesn't explicitly address ordering, though. If we made param
> _position_ meaningful, then we could get ordering (i.e. above would
> mean "tomoyo first").

security.tomoyo=1 security.apparmor=2 security.landlock=5

could tell the boot that tomoyo comes 1st, apparmor 2nd, landlock 5th.
The registration code would be smart enough to deal with the fact that
there is no module 3rd or 4th.

> Note, ordering matters because call_int_hook() will _stop_ on a
> non-zero return value: potentially hiding events from later LSMs. Do
> we need to revisit this? I seem to remember if being a very dead
> horse, and we needed to quick-abort otherwise we ended up in
> nonsensical states.

I have done it both ways, and "bail on fail" is far simpler. If
SELinux returns -EACCES and SARA returns -EPERM, which do you tell
the user?

> The reason for the new approach is because I can't find a meaningful
> way to provide CONFIGs that make sense. We want to provide a few
> things:
>
> - is an LSM built into the kernel at all? (CONFIG_SECURITY_$lsm)

That's how it works today.

> - is an LSM enabled by default? (CONFIG_SECURITY_$lsm_ENABLED?)

That's how it's done in this patchset.

> - has an LSM been enable for this boot? $lsm.enabled=1 or security=$lsm,$lsm ?

Currently security=$lsm for one LSM.

> - what order should any stacking happen? Makefile? security=?
Makefile by default.
>
> And for the incompatible-major, do we stick with CONFIG_SECURITY_$lsm_DEFAULT ?
>
>
>
> Anyway, if the concern is with exposed behavior for distros, what do
> we want? i.e. what should be done for patch 10. Everything else looks
> good.
>
> -Kees
>
