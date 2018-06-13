Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5DFnc74026975
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 11:49:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 415WQn4gh9z34qRn
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 15:49:37 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 415WQm6Vltz34qRY
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 15:49:36 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id v135-v6so4686715lfa.9
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 08:49:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
 <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
 <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Jun 2018 11:49:33 -0400
Message-ID: <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
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

On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
>> Joe, in general I really appreciate the fixes you send, but these
>> patches that cross a lot of subsystem boundaries (this isn't the first
>> one that does this) causes unnecessary conflicts in -next and during
>> the merge window.  Could you split your patches up from now on please?
>
> Sorry. No.  Merge conflicts are inherent in this system.

Yes, merge conflicts are inherent in this system when one makes a
single change which impacts multiple subsystems, e.g. changing a core
kernel function which is called by multiple subsystems.  However, that
isn't what this patch does, it makes a number of self-contained
changes across multiple subsystems; there are no cross-subsystem
dependencies in this patch.  You are increasing the likelihood of
conflicts for no good reason; that is why I'm asking you to split this
patch and others like it.

> There is just no good way to do this as sending a set
> of per subsystem patches guarantees partial application
> of the entire set.

Please explain why all of these changes need to be made at the same
time?  Looking quickly at the patch it would appear that each chunk of
the patch could be applied independently and the kernel would still
build and operate correctly.  I'm not suggesting that you decompose
this patch with that level of granularity, that would be silly, but
splitting this patch (and many of the others you tend to submit) at
subsystem boundaries should be possible.

Further, as one could see from the responses of the other LSM
maintainers, splitting this patch is not just possible, it is
desirable.

> If you prefer, each sub-subsystem maintainer, at
> whatever granularity desired, could apply the patch
> to the appropriate subsystem by using
> "git am --include=<subsystem_path>".

Or you could split the patch up by subsystem before posting, like so
many other developers do already.

-- 
paul moore
www.paul-moore.com
