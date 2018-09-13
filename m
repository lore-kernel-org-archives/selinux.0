To: Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
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
From: John Johansen <john.johansen@canonical.com>
Message-ID: <0eb75e66-ed50-4013-6440-38bc2f814c6f@canonical.com>
Date: Thu, 13 Sep 2018 16:32:42 -0700
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/13/2018 04:06 PM, Kees Cook wrote:
> On Thu, Sep 13, 2018 at 2:51 PM, Kees Cook <keescook@chromium.org> wrote:
>> At the very least, to avoid stacking now (i.e. TOMOYO being enabled
>> with another major LSM), we just do nothing. The existing code already
>> makes the existing major LSMs exclusive. Adding a stackable LSM would
>> need to just have its own "enable" flag (i.e. ignore
>> security_module_enable()), and then either check a runtime "is
>> stacking allowed?" flag or have new "depends on SECURITY_STACKING". (I
>> think the CONFIG will force distros into enabling it without any
>> runtime opt-out.)
> 
> Before stacking, we have:
> 
> - major LSM, pick one
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
> 
> 
> Under stacking, we have:
> 
> The minor LSMs remain unchanged.
> 
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
> SECURITY_TOMOYO_STACKED allowed in addition. If security= is
> specified, all other major LSMs are disabled (i.e. it is not possible
> to switch between SELinux/AppArmor/SMACK without also disabling
> TOMOYO).
> 
> Ordering is per security/Makefile modulo enabled-ness for majors (i.e.
> TOMOYO is always _before_ AppArmor if stacked together, otherwise
> after SELinux and SMACK), and per security.c for minors.
> 
> 
> I don't think this is how we want it to work. For example, Ubuntu
> builds in all LSMs, and default-enables AppArmor. If an Ubuntu user
> wants TOMOYO, the boot with "security=tomoyo". If Ubuntu wants to make
> stacking available to users but off by default, what CONFIGs do they
> pick? They could try SECURITY_APPARMOR_STACKED=y and
> SECURITY_TOMOYO_STACKED=n, but then how does an end user choose
> "apparmor and tomoyo" (or more meaningfully, for the future:
> "apparmor, sara, and landlock")? They can still pick
> "security=tomoyo", but there isn't a runtime way to opt into stacking.
> 

Ubuntu is carrying an early set of the stacking patches and about a
dozen patches on top of that.

It allows choosing to build the LSMs separate from the what the
default LSM(s) are. There is some config patching here that I need to
update and drop onto this thread.

There is also a patch that allows selecting the set of LSMs at boot.

   security=selinux,apparmor

but yama and loadpin are treated differently and I never liked
that. But again another patch to rebase and drop on this thread for
discussion.


> 
> What about leaving SECURITY_$lsm_DEFAULT as-is, and then...
> 
> In the past I'd suggested using "security=" to determine both enabled
> and order: "security=tomoyo,smack" would mean stacked LSMs, with
> tomoyo going first.
> 
> Currently I'm leaning towards "security=" to select ONLY the
> incompatible LSM, and per-LSM "enable" flags to determine stacking:
> 
>     tomoyo.enabled=1 security=smack
>

I don't like this, it makes it hard for the end user specifying option
at boot time. They have to set security= for the modules they want and
then also individual modules $lsm.enabled= which is very inconvenient
for users.

apparmor.enabled really should only default to enabled and provides a
legacy way to disable apparmor during boot. This option was around
before security= was added.

I need to leave it available as its become part of the api (there are
applications checking /sys/module/apparmor/parameters/enabled but we
can remove it from the Kconfig.


> This doesn't explicitly address ordering, though. If we made param
> _position_ meaningful, then we could get ordering (i.e. above would
> mean "tomoyo first").
> 

yes, I think that makes sense

> Note, ordering matters because call_int_hook() will _stop_ on a
> non-zero return value: potentially hiding events from later LSMs. Do
> we need to revisit this? I seem to remember if being a very dead
> horse, and we needed to quick-abort otherwise we ended up in
> nonsensical states.
> 

we shouldn't be in nonsensical states but we are doing work that is
thrown away.

Another potential solution is allowing an LSM to register a set of
post hooks that will get called after the regular LSM hooks are
called. This would allow an LSM that cared about whether a hook
succeeded or not to do some processing.


> The reason for the new approach is because I can't find a meaningful
> way to provide CONFIGs that make sense. We want to provide a few
> things:
> 
> - is an LSM built into the kernel at all? (CONFIG_SECURITY_$lsm)
> - is an LSM enabled by default? (CONFIG_SECURITY_$lsm_ENABLED?)
> - has an LSM been enable for this boot? $lsm.enabled=1 or security=$lsm,$lsm ?

at least for apparmor it is apparmor.enabled=1 AND security=apparmor or security=$lsm,apparmor ...

> - what order should any stacking happen? Makefile? security=?
> 
Preferably not. For the single LSM we have the ability to choose the default LSM, ideally we let the distro decide in the Kconfig and the user with security=...

> And for the incompatible-major, do we stick with CONFIG_SECURITY_$lsm_DEFAULT ?

Ideally Kconfig wouldn't let you choose incompatible LSMs when
selecting what is going to be enabled by default.

> 
> 
> 
> Anyway, if the concern is with exposed behavior for distros, what do
> we want? i.e. what should be done for patch 10. Everything else looks
> good.
> 

well speaking for Ubuntu we want to be able to specify the default LSMs
and we want to enable our users to change this.

The current patchset we have is less than ideal partly because of the
whole $lsm.enabled vs security= mess that needs to be resolved.
