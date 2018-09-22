Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M39g71002933
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 23:09:42 -0400
Received: by mail-yb1-f195.google.com with SMTP id o63-v6so6276264yba.2
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 20:09:36 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com.
 [209.85.161.43])
 by smtp.gmail.com with ESMTPSA id y188-v6sm4850857ywe.2.2018.09.21.20.09.34
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 20:09:34 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id 14-v6so5989211ywe.2
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 20:09:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 21 Sep 2018 20:02:57 -0700
Message-ID: <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and
 Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 21, 2018 at 4:59 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> v4: Finer granularity in the patches and other
>     cleanups suggested by Kees Cook.
>     Removed dead code created by the removal of SELinux
>     credential blob poisoning.

Thanks for the splitting, this really does make it easier to review
(at least for me). I think this looks really good, though obviously
I'd like to refactor it slightly on top of my series. :)

One additional thought I had was about the blobs allocations: some are
separate kmem caches, and some are kmalloc. I'm thinking it might make
sense to use separate kmem caches for two reasons:

- they're going to always be the same size and are regularly
allocated/freed, so it may offer a performance benefit.

- they're explicitly not supposed to be exposed to userspace, so
hardened usercopy would protect them if they were not kmalloc()ed.

I'm excited about getting this landed!

-Kees

-- 
Kees Cook
Pixel Security
