Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8MGcOgE017372
 for <selinux@tycho.nsa.gov>; Sat, 22 Sep 2018 12:38:25 -0400
To: Kees Cook <keescook@chromium.org>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
Date: Sat, 22 Sep 2018 09:38:12 -0700
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and
 Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/21/2018 8:02 PM, Kees Cook wrote:
> On Fri, Sep 21, 2018 at 4:59 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> v4: Finer granularity in the patches and other
>>     cleanups suggested by Kees Cook.
>>     Removed dead code created by the removal of SELinux
>>     credential blob poisoning.
> Thanks for the splitting, this really does make it easier to review
> (at least for me). I think this looks really good, though obviously
> I'd like to refactor it slightly on top of my series. :)

Whichever goes on top is fine with me. What's one
more patch set merge, after all?

> One additional thought I had was about the blobs allocations: some are
> separate kmem caches, and some are kmalloc. I'm thinking it might make
> sense to use separate kmem caches for two reasons:

I had seriously considered doing that. I can't see any reason
not to. It's something that could be done at any time, and with
all the other things that had to change it just didn't get in.

> - they're going to always be the same size and are regularly
> allocated/freed, so it may offer a performance benefit.
>
> - they're explicitly not supposed to be exposed to userspace, so
> hardened usercopy would protect them if they were not kmalloc()ed.
>
> I'm excited about getting this landed!

Soon. Real soon. I hope. I would very much like for
someone from the SELinux camp to chime in, especially on
the selinux_is_enabled() removal.

On a somewhat related note, I will be out for the first three
weeks of October, returning just in time for the Linux Security
Summit in Edinburgh. My connectivity will be severely limited.
I don't expect to accomplish anything while I'm out.
