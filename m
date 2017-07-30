Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6UJfJee029197
 for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2017 15:41:20 -0400
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com
 [209.85.216.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 2168A560659
 for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2017 21:40:09 +0200 (CEST)
Received: by mail-qt0-f172.google.com with SMTP id v29so78383660qtv.3
 for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2017 12:40:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d296cb72-90a1-4ebd-5d9d-879c0b4165b1@debian.org>
References: <d296cb72-90a1-4ebd-5d9d-879c0b4165b1@debian.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sun, 30 Jul 2017 21:40:07 +0200
Message-ID: <CAJfZ7==NsE_3RctgtYCavH73oqsSKT8dL1A4Qizfp-Vpw_Gshg@mail.gmail.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: setfiles crashing when SELinux is disabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jul 30, 2017 at 8:52 PM, Laurent Bigonville <bigon@debian.org> wrote:
> Hi,
>
> When using sefiles (setfiles -m -F -v
> /etc/selinux/refpolicy/contexts/files/file_contexts.bin  /) when SELinux is
> disabled, it crahes with the fillowing trace:
>
> #0  __strcmp_sse2_unaligned () at
> ../sysdeps/x86_64/multiarch/strcmp-sse2-unaligned.S:31
> No locals.
> #1  0x00007f13241957be in restorecon_sb (pathname=0xd36aa93160
> "/usr/include/xf86drm.h", flags=flags@entry=0x7fffd3700ae3, sb=<optimized
> out>, sb=<optimized out>) at selinux_restorecon.c:666
>         newcon = 0xd36abdc100 "system_u:object_r:usr_t:s0"
>         curcon = 0x0
>         newtypecon = 0x0
>         rc = <optimized out>
>         updated = false
>         lookup_path = <optimized out>
> #2  0x00007f1324196810 in selinux_restorecon
> (pathname_orig=pathname_orig@entry=0xd36aa943e0 "/",
> restorecon_flags=<optimized out>) at selinux_restorecon.c:984

Having "curcon = 0x0" with a non-NULL newcon in selinux_restorecon.c
looks like the bug fixed by commit a9094fae2c7b ("libselinux: avoid
calling strcmp() on a NULL pointer",
https://github.com/SELinuxProject/selinux/commit/a9094fae2c7bcd14af7263f9bb7fbacff5bc761c).
Which version are you using? Does back-porting this commit fix your
issue?

Thanks,
Nicolas
