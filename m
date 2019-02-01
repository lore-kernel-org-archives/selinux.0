Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B69C282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 06:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FDA20869
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 06:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PA/vGXSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfBAG0o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:26:44 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36403 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfBAG0n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 01:26:43 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so4845027ioh.3
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 22:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnGwpskr9yeCdhD56o/JHIU1UXh5isMTL6lwV86QHS4=;
        b=PA/vGXSz1G3k50mQfzVWUFLkuCvskU3a9TY3WmBQvhAkHNOzOllEMRNBMBG/gqv0ul
         m1witrFo8ukvhYHMew7iytkJ5uEzWP/e/naWlBafPaKclBoPEhxCbYpMuj/u80AFKQkE
         Oy278/ak464oguMErfijASY7z00LZ7gG9UHGuBosgOAVkbRSEFqls5neCeYt/tXE01IR
         SviScacNRLm0G5D2Le4xjiVjRmHTGiPJzAibLQkUk/s2mfMheurUG36cPPuZRJ0yBoI9
         I3ab58bItABb9uNg+hSkNkOcN48JJWZF1xdjz8SKzhFaWrSgdo8jqqS28yIXlNMxdlq6
         0aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnGwpskr9yeCdhD56o/JHIU1UXh5isMTL6lwV86QHS4=;
        b=CWBB0dtHjMiB7XjkgwOnQw4X0d7AGnFR1ivQZQTOALDT73id4N3Nx8BkaqwDuhtbGd
         /GomoTpCPM3WQq/wjQ22jKXSmR1ZmvwObnvZcK/iTtDR5rvjW+ExL/7SHWQPNjBzS9bR
         4m1Wdcc+rmSifmEOvdq1b1POZHRdCXzWN2jvXsJJ/2CUAyJiDIS2lG/4uif4L+kpRTk0
         fsZCkRTCtJM0dYrCnzbMpG+KI4Ecjc8DSJZFShmwkG15iexCxrMGNKw6j4l2aABbEAUj
         Cf8H7FBw9K2RxB8YByLVat8O6jqFjY1hyg5jgTySaz7KtNpDgaXZW8w1ieabAlxNobmG
         aNQA==
X-Gm-Message-State: AJcUukchH62qsoidPJeNxvhQbLsST2aJVnKOrM0HTACqd29Dv9rzTwt2
        aGURvf6tYTxZrRP+ONQYL/oNTK3e2qA7friw3R68ag==
X-Google-Smtp-Source: AHgI3IbktG1MpYbEnDaFKpDjfA44+KmFPRPI5RXhXBdJEQQjgfdR3ELA64iTEyXrD1OdmB+Qh+xHfO0C35D8OFcPQz8=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr20659710ioh.271.1549002402011;
 Thu, 31 Jan 2019 22:26:42 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003d28d10580b335cd@google.com> <CAHC9VhR9wwqVcnmAVcqfwmRuX02F8oMVzNNNQym-TeceHFLqOQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR9wwqVcnmAVcqfwmRuX02F8oMVzNNNQym-TeceHFLqOQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Feb 2019 07:26:30 +0100
Message-ID: <CACT4Y+Yk=bsS7Ti3PjeZm8yG_txt=orBztowHwddHRP_MzuTxw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in selinux_netlbl_socket_setsockopt
To:     Paul Moore <paul@paul-moore.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Miller <davem@davemloft.net>,
        linux-hams <linux-hams@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Cc:     syzbot <syzbot+1bfc00ca3aabe5bcd4cb@syzkaller.appspotmail.com>,
        Eric Paris <eparis@parisplace.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 30, 2019 at 10:30 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Jan 30, 2019 at 4:01 PM syzbot
> <syzbot+1bfc00ca3aabe5bcd4cb@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    62967898789d Merge git://git.kernel.org/pub/scm/linux/kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167fdef8c00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1bfc00ca3aabe5bcd4cb
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+1bfc00ca3aabe5bcd4cb@syzkaller.appspotmail.com
> >
> > 8021q: adding VLAN 0 to HW filter on device team0
> > ==================================================================
> > BUG: KASAN: use-after-free in selinux_netlbl_socket_setsockopt+0x49b/0x510
> > security/selinux/netlabel.c:525
> > Read of size 8 at addr ffff8880a63cf078 by task syz-executor3/18477
> >
> > CPU: 1 PID: 18477 Comm: syz-executor3 Not tainted 5.0.0-rc4+ #51
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
> >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
> >   selinux_netlbl_socket_setsockopt+0x49b/0x510
> > security/selinux/netlabel.c:525
>
> At first glance this seems odd.  The line above is simply
> dereferencing sock->sk_security (getting the "sksec"), which we also
> do higher up selinux_socket_setsockopt() via sock_has_perm().  Unless
> somehow the socket is being released/freed in the middle of a
> setsockopt() syscall this looks like maybe it's something else?

Hi Paul,

Searching for af_netrom across other syzbot bugs:
https://groups.google.com/forum/#!searchin/syzkaller-bugs/af_netrom%7Csort:date

I see at least:
https://syzkaller.appspot.com/bug?extid=b0b1952f5864b4009b09
https://syzkaller.appspot.com/bug?extid=febf3c50d4262e578b1c
https://syzkaller.appspot.com/bug?extid=defa700d16f1bd1b9a05

Which suggests there are some serious lifetime problems in netrom
sockets. That would probably explain this crash as well.

+netrom maintainers, does this explanation look plausible to you?
should we dup this crash onto one of the other netrom bugs? and
perhaps these netrom bugs across themselves too?



> >   selinux_socket_setsockopt+0x67/0x90 security/selinux/hooks.c:4693
> >   security_socket_setsockopt+0x7d/0xc0 security/security.c:1467
> >   __sys_setsockopt+0xe4/0x3a0 net/socket.c:1892
> >   __do_sys_setsockopt net/socket.c:1913 [inline]
> >   __se_sys_setsockopt net/socket.c:1910 [inline]
> >   __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
> >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x458089
> > Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> > ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fb988b9cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> > RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000458089
> > RDX: 0000000000000078 RSI: 0000000000000084 RDI: 000000000000000a
> > RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb988b9d6d4
> > R13: 00000000004cc9e8 R14: 00000000004da6a8 R15: 00000000ffffffff
> >
> > Allocated by task 18471:
> >   save_stack+0x45/0xd0 mm/kasan/common.c:73
> >   set_track mm/kasan/common.c:85 [inline]
> >   __kasan_kmalloc mm/kasan/common.c:496 [inline]
> >   __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
> >   kasan_kmalloc+0x9/0x10 mm/kasan/common.c:504
> >   __do_kmalloc mm/slab.c:3711 [inline]
> >   __kmalloc+0x15c/0x740 mm/slab.c:3720
> >   kmalloc include/linux/slab.h:550 [inline]
> >   sk_prot_alloc+0x19c/0x2e0 net/core/sock.c:1477
> >   sk_alloc+0xd7/0x1690 net/core/sock.c:1531
> >   nr_create+0xb9/0x5e0 net/netrom/af_netrom.c:436
> >   __sock_create+0x532/0x930 net/socket.c:1277
> >   sock_create net/socket.c:1317 [inline]
> >   __sys_socket+0x106/0x260 net/socket.c:1347
> >   __do_sys_socket net/socket.c:1356 [inline]
> >   __se_sys_socket net/socket.c:1354 [inline]
> >   __x64_sys_socket+0x73/0xb0 net/socket.c:1354
> >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Freed by task 18466:
> >   save_stack+0x45/0xd0 mm/kasan/common.c:73
> >   set_track mm/kasan/common.c:85 [inline]
> >   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
> >   kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
> >   __cache_free mm/slab.c:3487 [inline]
> >   kfree+0xcf/0x230 mm/slab.c:3806
> >   sk_prot_free net/core/sock.c:1514 [inline]
> >   __sk_destruct+0x76d/0xa60 net/core/sock.c:1596
> >   sk_destruct+0x7b/0x90 net/core/sock.c:1604
> >   __sk_free+0xce/0x300 net/core/sock.c:1615
> >   sk_free+0x42/0x50 net/core/sock.c:1626
> >   sock_put include/net/sock.h:1707 [inline]
> >   nr_release+0x337/0x3c0 net/netrom/af_netrom.c:557
> >   __sock_release+0xd3/0x250 net/socket.c:579
> >   sock_close+0x1b/0x30 net/socket.c:1141
> >   __fput+0x3c5/0xb10 fs/file_table.c:278
> >   ____fput+0x16/0x20 fs/file_table.c:309
> >   task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
> >   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
> >   exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
> >   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
> >   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
> >   do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > The buggy address belongs to the object at ffff8880a63cec80
> >   which belongs to the cache kmalloc-2k of size 2048
> > The buggy address is located 1016 bytes inside of
> >   2048-byte region [ffff8880a63cec80, ffff8880a63cf480)
> > The buggy address belongs to the page:
> > page:ffffea000298f380 count:1 mapcount:0 mapping:ffff88812c3f0c40 index:0x0
> > compound_mapcount: 0
> > flags: 0x1fffc0000010200(slab|head)
> > raw: 01fffc0000010200 ffffea000127f888 ffffea00013a3188 ffff88812c3f0c40
> > raw: 0000000000000000 ffff8880a63ce400 0000000100000003 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >   ffff8880a63cef00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8880a63cef80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > ffff8880a63cf000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                                  ^
> >   ffff8880a63cf080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8880a63cf100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > syzbot.
>
>
>
> --
> paul moore
> www.paul-moore.com
