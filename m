Return-Path: <SRS0=NIRl=XY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105DDC4360C
	for <selinux@archiver.kernel.org>; Sun, 29 Sep 2019 01:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD231214D8
	for <selinux@archiver.kernel.org>; Sun, 29 Sep 2019 01:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XDe6ts8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfI2BMh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 28 Sep 2019 21:12:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40252 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2BMh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 28 Sep 2019 21:12:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so5925884ljw.7
        for <selinux@vger.kernel.org>; Sat, 28 Sep 2019 18:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HvcZ/gFpqLiMCG5pTmJbkFiitEteERr3tcxjrVi5Sc=;
        b=XDe6ts8BQnqX0/ftyVpIUsh06Xbdz6P9Aspuwb3JvC4FJ+jmDt8mANqTZFNoB7j9Tf
         7BJEeU1XJOjzjRKJbs8nnAJC/7F6JvO4u4p7kbhNZcs3hFMExE4SUP3REoLzN1luxWxa
         3ueDds5EKWIxT/3NjgiELiRygpE0qcauvoWwgQuqkbfOOZdCSmM3lbVfDdly1UU9Jb6n
         ViolcPJxXWxQ4yAEwFFSd2VKM4FCeqek1FgifpAVop7EdYlFhG0qkfDLB1gMB2aCv/90
         tctx5QrD516ZdslGjfHDFS+WdF4q7tBFYZo29dyro9dRq0PSLsrDY+73FCNdOSqHAyp7
         HHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HvcZ/gFpqLiMCG5pTmJbkFiitEteERr3tcxjrVi5Sc=;
        b=KF1676YH0YeF+rtuhq7zkEFyB+D/gMFotW5rot2m5KetQACVi0STmyTe9zVFDfB8jQ
         EbS/PgR1B3HY23F2s+8CY9q9w5g9KxKtEa4xfWtu6VqPqoXBcoFhRLSWdVga8eqSCYtM
         ApZppD0Tt/GFtqhaKVo/22BhE4puoYGN0oUOTq/w3tsapuAJmHeCI1FBxut+lUlIxHfl
         q3LFmTUQpfQL/UZHWF6LpoD46GT3ZrvX7PXoNyAMSf0V9wXdXS53n14AdOgvZT1KP9F1
         P70alLWFAV/zZTNCV7OjBJlS2UB7kzleNjCc5mRekgcv2B9AKZncBgV/f5rDHobsO/FE
         UaNg==
X-Gm-Message-State: APjAAAUqGh14Df5wdv++zxR1xyoISHlhPFF3NQLToyawBBi/UpvjwQ1J
        EbiJOvJv7iI4NQzi1p50tDdpyGtRLO/jBhgJwTgG
X-Google-Smtp-Source: APXvYqy9EldFnvghHDLWGIjuabqrN0BkXO3TgTmCFYTlLoxNwcOZLnf1uQhq5txih1ni6OZmUFm0gnJynqOIASnS5d4=
X-Received: by 2002:a2e:7212:: with SMTP id n18mr3231271ljc.91.1569719552013;
 Sat, 28 Sep 2019 18:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000814c405931224fc@google.com> <CAHC9VhQGLFWk3zqywgsip9KgTmKNTiwxDG4+BdkDQwNZKJunQg@mail.gmail.com>
 <CACT4Y+ZqJJS+g=svSJDfd4Jo==kVFbJDCxrfRX2eyBH4hw2+-g@mail.gmail.com>
 <CAHC9VhSa7GeLMZu=DTL_h-wtbkg7y6R9WeSAwJa4tZTVXGoX5g@mail.gmail.com> <20190928024504.GC1079@sol.localdomain>
In-Reply-To: <20190928024504.GC1079@sol.localdomain>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 28 Sep 2019 21:12:20 -0400
Message-ID: <CAHC9VhRKJMLY7=y3L-Kq6opn2DyGEw9T8PMVnsLWMMUKBYabmw@mail.gmail.com>
Subject: Re: WARNING: locking bug in selinux_netlbl_socket_connect
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+5fa07e4e18e4eb1ccb12@syzkaller.appspotmail.com>,
        Eric Paris <eparis@parisplace.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 27, 2019 at 10:45 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On Tue, Sep 24, 2019 at 09:17:35AM -0400, Paul Moore wrote:
> > On Tue, Sep 24, 2019 at 4:21 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > On Tue, Sep 24, 2019 at 4:14 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Sat, Sep 21, 2019 at 11:50 AM syzbot
> > > > <syzbot+5fa07e4e18e4eb1ccb12@syzkaller.appspotmail.com> wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    f97c81dc Merge tag 'armsoc-late' of git://git.kernel.org/p..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=127b709d600000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=10283c2b00ab4cd7
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=5fa07e4e18e4eb1ccb12
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12996841600000
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+5fa07e4e18e4eb1ccb12@syzkaller.appspotmail.com
> > > > >
> > > > > WARNING: CPU: 0 PID: 10315 at kernel/locking/lockdep.c:840
> > > > > look_up_lock_class kernel/locking/lockdep.c:840 [inline]
> > > > > WARNING: CPU: 0 PID: 10315 at kernel/locking/lockdep.c:840
> > > > > register_lock_class+0x206/0x1850 kernel/locking/lockdep.c:1185
> > > > > Kernel panic - not syncing: panic_on_warn set ...
> > > > > CPU: 0 PID: 10315 Comm: syz-executor.0 Not tainted 5.3.0+ #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > Google 01/01/2011
> > > > > Call Trace:
> > > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > > > >   panic+0x2dc/0x755 kernel/panic.c:219
> > > > >   __warn.cold+0x20/0x4c kernel/panic.c:576
> > > > >   report_bug+0x263/0x2b0 lib/bug.c:186
> > > > >   fixup_bug arch/x86/kernel/traps.c:179 [inline]
> > > > >   fixup_bug arch/x86/kernel/traps.c:174 [inline]
> > > > >   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
> > > > >   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
> > > > >   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> > > > > RIP: 0010:look_up_lock_class kernel/locking/lockdep.c:840 [inline]
> > > > > RIP: 0010:register_lock_class+0x206/0x1850 kernel/locking/lockdep.c:1185
> > > > > Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 aa 10 00 00 4c 3b 7b
> > > > > 18 44 8b 35 d5 de 55 09 74 0b 48 81 3b a0 65 06 8a 74 02 <0f> 0b 45 85 ed
> > > > > 0f 84 71 03 00 00 f6 85 70 ff ff ff 01 0f 85 64 03
> > > > > RSP: 0018:ffff888096777a48 EFLAGS: 00010002
> > > > > RAX: dffffc0000000000 RBX: ffff888093ff78e0 RCX: 0000000000000000
> > > > > RDX: 1ffff110127fef1f RSI: 0000000000000000 RDI: ffff888093ff78f8
> > > > > RBP: ffff888096777b10 R08: 1ffff11012ceef51 R09: ffffffff8aaea0e0
> > > > > R10: ffffffff8a7753c8 R11: 0000000000000000 R12: ffffffff8a7b5d20
> > > > > R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff884766e0
> > > > >   __lock_acquire+0xf4/0x4e70 kernel/locking/lockdep.c:3837
> > > > >   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
> > > > >   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
> > > > >   _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:175
> > > > >   spin_lock_bh include/linux/spinlock.h:343 [inline]
> > > > >   lock_sock_nested+0x41/0x120 net/core/sock.c:2929
> > > > >   lock_sock include/net/sock.h:1522 [inline]
> > > > >   selinux_netlbl_socket_connect+0x20/0xc0 security/selinux/netlabel.c:607
> > > > >   selinux_socket_connect+0x6a/0x90 security/selinux/hooks.c:4745
> > > > >   security_socket_connect+0x77/0xc0 security/security.c:1958
> > > > >   __sys_connect+0x19d/0x330 net/socket.c:1824
> > > > >   __do_sys_connect net/socket.c:1839 [inline]
> > > > >   __se_sys_connect net/socket.c:1836 [inline]
> > > > >   __x64_sys_connect+0x73/0xb0 net/socket.c:1836
> > > > >   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
> > > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > > RIP: 0033:0x459a09
> > > > > Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> > > > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> > > > > ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > > > RSP: 002b:00007fc302ec5c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> > > > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a09
> > > > > RDX: 000000000000001c RSI: 0000000020000080 RDI: 0000000000000005
> > > > > RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc302ec66d4
> > > > > R13: 00000000004bff42 R14: 00000000004d1eb0 R15: 00000000ffffffff
> > > > > Kernel Offset: disabled
> > > > > Rebooting in 86400 seconds..
> > > >
> > > > This doesn't appear to be related to selinux_netlbl_socket_connect();
> > > > I believe it should be okay to call lock_sock() in that context.
> > >
> > >
> > > FTR, this is this warning:
> > >
> > > static inline struct lock_class *
> > > look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
> > > {
> > > ....
> > >                         /*
> > >                          * Huh! same key, different name? Did someone trample
> > >                          * on some memory? We're most confused.
> > >                          */
> > >                         WARN_ON_ONCE(class->name != lock->name &&
> > >                                      lock->key != &__lockdep_no_validate__);
> > >
> > >
> > > So something fishy happens here (stack overflow again?).
> >
> > Yeah, when I saw that yesterday I figured it was something beyond the
> > usual connect() call path; something else is going on I think.  I
> > didn't see a reproducer for this, is that right?
> >
>
> There was a link to a syzkaller reproducer in the original email.

Heh, I had to re-read that original report a half-dozen times, I kept
reading "repro" as "repo" :)

-- 
paul moore
www.paul-moore.com
