Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7EHA7iC019392
 for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2018 13:10:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id t2-v6so10486545edr.5
 for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2018 10:05:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From: Sargun Dhillon <sargun@sargun.me>
Date: Tue, 14 Aug 2018 10:05:07 -0700
Message-ID: <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 16, 2018 at 10:53 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> LSM: Full security module stacking
>
> I'm calling this v1 not because it's the first version
> I've put out but because it's the first version I'm getting
> serious external pressure to get upstream.
Awesome work, I'm glad that this is getting further.

>
> The blob management part (through "LSM: Sharing of security blobs")
> is ready for prime-time. These changes move the management of
> security blobs out of the security modules and into the security
> module infrastructure. With this change the proposed S.A.R.A,
> LandLock and PTAGS security modules could co-exist with any of
> the existing "major" security modules. The changes reduce some
> code duplication.
>
> Beyond the blob management there's a bit of clean-up.
> Mounting filesystems had to be changed so that options
> a security module doesn't recognize won't be considered
> a fatal error. The mount infrastructure is somewhat
> more complex than one might assume.
>

Casey,
Do you think you can break out 1 into its own patch? It seems like
that'd be valuable to everyone.


What's your thought here if we ever introduce dynamic security
modules? It's nice that we now have a way around rolling back blobs if
one fails, but what if a new module was activated, would we just
resize the slab cache?
