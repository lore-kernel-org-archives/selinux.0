Return-Path: <SRS0=Z/YK=VU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27BAC7618E
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEA12171F
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 09:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GknPiziS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfGWJls (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:41:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42597 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfGWJls (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jul 2019 05:41:48 -0400
Received: by mail-io1-f68.google.com with SMTP id e20so50068954iob.9
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2019 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8j1V89L88/kxHixbpOjcJ5wnbtrRMYhG+kPXvVm3pw=;
        b=GknPiziSCThhzNy8G1IPCwAl8TeFYe7UPT3ZXDZA6HdiMxdMmGd6+3akkPw2a51eRD
         a8Wh4knUUlcBl5u2Dmy1ivJ0UGtkE0SLAncloWfMoX9+E8PJpbj/9/tHPtTmzKX7gqCi
         rg/KieEQtyzhylhzuzErxU3x2Z6C/oTh/iMqsNTjAJGtnaVuU5rOA8Js28kILEj2pZMg
         9gFvVJy7BHrHUHblJ4byMliatn33wN0yPH6Mll9U4tKpxfsq63/lF/i/VfXe9Nhze7mc
         Ssp+PyDhP0A+gcKsRaYVXgAY67m6Ay9IsoHkHLiAQnpiePMOUAKN7B+9r/933SKax9QO
         d7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8j1V89L88/kxHixbpOjcJ5wnbtrRMYhG+kPXvVm3pw=;
        b=py2o23MxVHPrI/QcCIlD9wtJSC6n2y3TxpiqFZjOIVC8SSj/1ORsWcXNcg1NDiREdJ
         Kk25G2J5I0d3qMJgrF8aowVzwZ/Gt18sSCFk699SsXcnGaJKTtbz7KrW2PUxXMyXZ5bo
         yxWDxrP+ISf0xIAWQJPBNHutCsobNfd1AgYwUagURFvjOf6EtStTPstZaSqdEqhPkpBv
         YyzmpAbxKBjwOA3mRhzlmx+D7GNdsOF+6ZF1oroTrN+u0URLMt5dPDiXoPkxDCsbRE8g
         +DCjzODYgkRNrJjgxTgdvNII6P1dVx7ZZytOreHaI1s/Ezx0qv44yM3G0vXiOBClmVaD
         YUJQ==
X-Gm-Message-State: APjAAAVmc0SL+k9G5NMyDJuMJW+GVq8bomLKrxwgzE5Ks1NDeKUr27Ce
        IBY7HgKXFbkinVjPII2WmZkXvcb+8AtrAJ5GsxurbK+GV70=
X-Google-Smtp-Source: APXvYqxmm1nZnM6rAGRPeFIg6oQFN+bovzxekd4klVxFGV4SfkIEVgB0PhbsbJOgZY4JjGVnbp4PuXArfDcViWCtL84=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr71222917iog.266.1563874906868;
 Tue, 23 Jul 2019 02:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009b2fe9058e55abbf@google.com>
In-Reply-To: <0000000000009b2fe9058e55abbf@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Jul 2019 11:41:34 +0200
Message-ID: <CACT4Y+Z-RLp69EEKz9xj+y2UYv3RCF2GS7iUYNrUcVmVuDBi6g@mail.gmail.com>
Subject: Re: memory leak in policydb_read
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, omosnace@redhat.com,
        selinux@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 23, 2019 at 11:18 AM syzbot
<syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1613751fa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
> dashboard link: https://syzkaller.appspot.com/bug?extid=fee3a14d4cdf92646287
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a7951fa00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16206444600000
>
> The bug was bisected to:
>
> commit d9570ee3bd1d4f20ce63485f5ef05663866fe6c0
> Author: Dmitry Vyukov <dvyukov@google.com>
> Date:   Sat Jan 13 00:53:10 2018 +0000
>
>      kmemleak: allow to coexist with fault injection


I suspect this is a bug in SELinux which become detectable after this
commit (introduced before). +selinux maintianters
Since fault injection is involved, most likely a typical missed kfree
on an error path.


> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1633cb00600000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1533cb00600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1133cb00600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
> Fixes: d9570ee3bd1d ("kmemleak: allow to coexist with fault injection")
>
> BUG: memory leak
> unreferenced object 0xffff888123547c80 (size 64):
>    comm "syz-executor647", pid 6976, jiffies 4294940919 (age 7.920s)
>    hex dump (first 32 bytes):
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<0000000019b1b22a>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<0000000019b1b22a>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<0000000019b1b22a>] slab_alloc /mm/slab.c:3319 [inline]
>      [<0000000019b1b22a>] kmem_cache_alloc_trace+0x145/0x280 /mm/slab.c:3548
>      [<00000000d64c33c7>] kmalloc /./include/linux/slab.h:552 [inline]
>      [<00000000d64c33c7>] kzalloc /./include/linux/slab.h:748 [inline]
>      [<00000000d64c33c7>] roles_init /security/selinux/ss/policydb.c:188
> [inline]
>      [<00000000d64c33c7>] policydb_init /security/selinux/ss/policydb.c:294
> [inline]
>      [<00000000d64c33c7>] policydb_read+0x141/0x1b80
> /security/selinux/ss/policydb.c:2259
>      [<000000004dd18ef6>] security_load_policy+0x182/0x740
> /security/selinux/ss/services.c:2141
>      [<000000004f5bb277>] sel_write_load+0x101/0x1f0
> /security/selinux/selinuxfs.c:564
>      [<00000000ee05c840>] __vfs_write+0x43/0xa0 /fs/read_write.c:494
>      [<000000008ca23315>] vfs_write /fs/read_write.c:558 [inline]
>      [<000000008ca23315>] vfs_write+0xee/0x210 /fs/read_write.c:542
>      [<00000000d97bcbc9>] ksys_write+0x7c/0x130 /fs/read_write.c:611
>      [<000000007a3f006b>] __do_sys_write /fs/read_write.c:623 [inline]
>      [<000000007a3f006b>] __se_sys_write /fs/read_write.c:620 [inline]
>      [<000000007a3f006b>] __x64_sys_write+0x1e/0x30 /fs/read_write.c:620
>      [<000000001c16ef20>] do_syscall_64+0x76/0x1a0
> /arch/x86/entry/common.c:296
>      [<000000007784189d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
