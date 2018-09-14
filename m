Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8EFxXXR032199
 for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2018 11:59:33 -0400
To: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
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
 <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
 <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
 <5b983bba-049c-795a-3354-a2e8ab33cecf@schaufler-ca.com>
 <CAGXu5jJ5__jdBM5X0vVyEU1TKnN4dpkXbj=10iak9RvD1DZk9g@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2bc5e4f5-8429-6843-f255-8fab6dacf39b@schaufler-ca.com>
Date: Fri, 14 Sep 2018 08:57:07 -0700
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ5__jdBM5X0vVyEU1TKnN4dpkXbj=10iak9RvD1DZk9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/13/2018 5:19 PM, Kees Cook wrote:
> On Thu, Sep 13, 2018 at 5:08 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/13/2018 4:57 PM, Kees Cook wrote:
>>> On Thu, Sep 13, 2018 at 4:51 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/13/2018 4:06 PM, Kees Cook wrote:
>>>>> - what order should any stacking happen? Makefile? security=?
>>>> Makefile by default.
>>> Okay, if ordering is by Makefile and everyone dislikes my
>>> $lsm.enabled=0/1 thing, then these mean the same thing:
>>>
>>> security=selinux,tomoyo
>>> security=tomoyo,selinux
>>>
>>> i.e. order of security= is _ignored_ in favor of the Makefile ordering.
>> No, I think that the two lines above should have a different
>> execution order. If we really need to specify multiple modules
>> at boot time that is what makes the most sense.
>>
>> It's a matter of mechanics and probably another pass during the
>> init process, but it's doable. If we determine it's necessary for
>> this stage it is just work.
> We already have the minor LSMs that cannot change order.

Are you saying that we don't have a mechanism to change
the order, or that they wouldn't work right in a different
order? Well, there's the capability module that has to be
first.

> They aren't
> part of security= parsing either.

True, but there's no reason now that we couldn't change that.
Except for capability. Hmm.

> To enable/disable LoadPin, you do
> "loadpin.enabled=1/0" separate from "security=".

SELinux and AppArmor have the same.

> Should "blob-sharing" LSMs be like major LSMs or minor LSMs?

I like the idea of changing the minor modules to do the full
registration process. That would make them all the same.
Except for capability. In any case, the "blob-sharing" LSMs
need to do the full registration process to account for their
blobs sizes, and that brings the "major" behavior along with it.

> If someone is booting with "security=selinux,tomoyo" and then SARA
> lands upstream, does that person have to explicitly add "sara" to
> their boot args, since they're doing a non-default list of LSMs?

Yes. security= is explicit.

> (I actually prefer the answer being "yes" here, FWIW, I just want to
> nail down the expectations.)

For now let's leave the minor (capability, yama, loadpin) as they are,
and require all new modules of any flavor to use full registration.

We could consider something like

security=$lsm		# Stack with $lsm at priority 2 - Existing behavior
$lsm.stacked=N		# Add $lsm to the stack at priority N. Delete if N == 0

It's OK to specify "selinux.stacked=2" and "sara.stacked=2". Which gets
called first is left up to the system to decide. Whatever the behavior is
gets documented. Capability will always be first and have priority 1.
It's OK to specify "smack.stacked=1".

The default stack is determined by CONFIG_SECURITY_$lsm_STACKED at
build time. CONFIG_SECURITY_$lsm_STACKED changes from a boolean to
an integer value to establish the default hook order.

/sys/kernel/security/lsm reports the modules in hook call order.
/sys/kernel/security/lsm-stack reports the list with the hook call priority

	capability:1,yama:1,selinux:1,sara:5,landlack:17

If stacking is not configured $lsm.stacked=0 is treated as security=none.
For other values of N $lsm.stacked=N is treated as security=$lsm.
