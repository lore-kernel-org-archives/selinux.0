Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5DJvamK014191
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 15:57:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 415cws6znTz4KRKb
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 19:57:33 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 415cwr6XPhz4KRKf
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 19:57:32 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id o9-v6so5829210lfk.1
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 12:57:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <38670733fba157f7acd9c1555b44a296420f0774.camel@perches.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
 <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
 <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
 <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
 <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
 <CAHC9VhRXBx_Q2eM48FFqX9PbPz0k8R74gfFFoRhwV91n2_BPsQ@mail.gmail.com>
 <38670733fba157f7acd9c1555b44a296420f0774.camel@perches.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Jun 2018 15:57:29 -0400
Message-ID: <CAHC9VhRX7Vx9_FB69EgxLypo1SnA9bobtxeLn8KzuHEN8CSaNA@mail.gmail.com>
To: Joe Perches <joe@perches.com>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>,
 John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [-next PATCH] security: use octal not symbolic
 permissions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jun 13, 2018 at 3:30 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-06-13 at 12:19 -0400, Paul Moore wrote:
>> On Wed, Jun 13, 2018 at 12:04 PM, Joe Perches <joe@perches.com> wrote:
>> > On Wed, 2018-06-13 at 11:49 -0400, Paul Moore wrote:
>> > > On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
>> > > > On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
>> > > > > Joe, in general I really appreciate the fixes you send, but these
>> > > > > patches that cross a lot of subsystem boundaries (this isn't the first
>> > > > > one that does this) causes unnecessary conflicts in -next and during
>> > > > > the merge window.  Could you split your patches up from now on please?
>> > > >
>> > > > Sorry. No.  Merge conflicts are inherent in this system.
>> > >
>> > > Yes, merge conflicts are inherent in this system when one makes a
>> > > single change which impacts multiple subsystems, e.g. changing a core
>> > > kernel function which is called by multiple subsystems.  However, that
>> > > isn't what this patch does, it makes a number of self-contained
>> > > changes across multiple subsystems; there are no cross-subsystem
>> > > dependencies in this patch.  You are increasing the likelihood of
>> > > conflicts for no good reason; that is why I'm asking you to split this
>> > > patch and others like it.
>> >
>> > No.  History shows with high certainty that splitting
>> > patches like this across multiple subsystems of a primary
>> > subsystem means that the entire patchset is not completely
>> > applied.
>>
>> I think that is due more to a lack of effort on the part of the patch
>> author to keep pushing the individual patches.
>
> Nope.  Try again.
>
> Resistance to change and desire for status quo
> occurs in many subsystems.

Which gets back to the need for persistence on the part of the patch
author.  If your solution to a stubborn susbsystem is to go around
them by convincing another, potentially unrelated subsystem, to merge
the patch then I firmly believe you are doing it wrong.

>> > It's _much_ simpler and provides a generic mechanism to
>> > get the entire patch applied to send a single patch to the
>> > top level subsystem maintainer.
>>
>> I understand it is simpler for you, but it is more difficult for everyone else.
>
> Not true.

I think we are at the agree to disagree stage.

The way you have structured this patch it makes it easier for you to
submit, but makes it potentially more difficult for me (likely other
LSM maintainers too), the -next folks, and Linus.

> It's simply a matter of merge resolution being pushed down
> where and when necessary.
>
> See changes like the additions of the SPDX license tags.

Please don't even try to suggest that this trivial patch you are
proposing is even remotely as significant as the SPDX change.  There
are always going to be exceptions to every rule, and with each
exception there needs to be a solid reason behind the change.  The
SPDX change had a legitimate reason (legal concern) for doing it the
way it was done; this patch isn't close to that level of concern.

>> Further, where the LSMs are concerned, there is no "top level
>> subsystem maintainer" anymore.  SELinux and AppArmor send pull
>> requests directly to Linus.
>
> MAINTAINERS-SECURITY SUBSYSTEM
> MAINTAINERS-M:  James Morris <jmorris@namei.org>
> MAINTAINERS-M:  "Serge E. Hallyn" <serge@hallyn.com>
> MAINTAINERS-L:  linux-security-module@vger.kernel.org (suggested Cc:)
> MAINTAINERS-T:  git git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> MAINTAINERS-W:  http://kernsec.org/
> MAINTAINERS-S:  Supported
> MAINTAINERS:F:  security/
> MAINTAINERS-
>
> If James is not approving or merging security/selinux or
> security/tomoyo then perhaps the F: entries could be
> augmented with appropriate X: entries or made specific
> by using specific entries like:
>
> F:      security/*
> F:      security/integrity/
> F:      security/keys/

That is a good point.  I'll put together a patch for selinux/next as
soon as the merge window closes.  I'll let the other LSMs do as they
see fit.  As I said previously, I believe the only other LSM that
sends directly to Linux is AppArmor.

-- 
paul moore
www.paul-moore.com
