Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA80C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 02:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940C220820
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 02:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Wa6Thu6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408528AbfIXCOq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:14:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33321 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbfIXCOp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Sep 2019 22:14:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so133925lfc.0
        for <selinux@vger.kernel.org>; Mon, 23 Sep 2019 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mt3Q/0unzX1H0yf83f1CEyMjmND1hzQWcT+TSDNjVx0=;
        b=Wa6Thu6CvdiXbRk1IH7PeU6mrr2WGlTwKaSw3ax6XQnUXG7ahMlV6sl8lq+Sq92ZrB
         Z6fnWNplYEslKk6XSx5AWW4zSe0Pi2oC9t6EStCt7CdAHz039dfRj8/NAmrvuDs26oRA
         VWxdORgjs4AO3TlJ88GFYfd2M52+NO/icnZGI3BBu+GS23vgGeoYOHRHRiDi8bufxFlA
         8Ri99zpFoty6wp2wgSZJYSiCUJO2KF7NSH+40z5NbUE7ykyJnXiSenacoRTyyGcmBzAU
         uu+e7morO7KSJCP6/fqn60eDYsllynO7sXve216XlBtOriST1liuMeK11ue2s4Ircvws
         dt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mt3Q/0unzX1H0yf83f1CEyMjmND1hzQWcT+TSDNjVx0=;
        b=sj9K12dHJqk3KP68EgXoRofp1G0aXZLftCf1ynC+uyjxyxPUPTA/T0W/JGdZF81QY1
         wCTT657wayxzzcg5t0Uf7OVEfNmEZxMtK4libnhI3nsiMFg5LRI4XdMo98WfaiT/VNh9
         qkoC70UYyUJTGCfhwaAuv+hiKHmyeyXTJuk1m/Ia9zTwLBYOIvx96bAkG1BJeiDMSoCf
         4keJGdHC2Twq4aJ2nP413mV4cf6umDf3G1/Y7EZW4AdnvM6CUAUBho4A96nhVLvPhp2N
         jTL2X1TAxxewufMVEMfpfi/K38VtTgJJyjaM3KHhR72EI0wSzPt4Uo481pKuhrIRVeHl
         RkYQ==
X-Gm-Message-State: APjAAAUGBXa60Fl9zQ2mqUpoeb3Bsj0Tz74ZsUe1++PgUVMo/d2JXji+
        IOrqLDNL7WMzQ33R9XtWZEfw73tC30gjS6mQGMvm
X-Google-Smtp-Source: APXvYqztGBVVbVrKSH+FJ75fBJvSoIoIpv+j5X7ap18h2ExAYGgF1ThJC3mbJ3st+rflvAhKqrnUkQbwzYBpbJBXmDs=
X-Received: by 2002:a19:8c14:: with SMTP id o20mr210911lfd.158.1569291282971;
 Mon, 23 Sep 2019 19:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000814c405931224fc@google.com>
In-Reply-To: <0000000000000814c405931224fc@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Sep 2019 22:14:31 -0400
Message-ID: <CAHC9VhQGLFWk3zqywgsip9KgTmKNTiwxDG4+BdkDQwNZKJunQg@mail.gmail.com>
Subject: Re: WARNING: locking bug in selinux_netlbl_socket_connect
To:     syzbot <syzbot+5fa07e4e18e4eb1ccb12@syzkaller.appspotmail.com>
Cc:     Eric Paris <eparis@parisplace.org>, linux-kernel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Sep 21, 2019 at 11:50 AM syzbot
<syzbot+5fa07e4e18e4eb1ccb12@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f97c81dc Merge tag 'armsoc-late' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=127b709d600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=10283c2b00ab4cd7
> dashboard link: https://syzkaller.appspot.com/bug?extid=5fa07e4e18e4eb1ccb12
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12996841600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5fa07e4e18e4eb1ccb12@syzkaller.appspotmail.com
>
> WARNING: CPU: 0 PID: 10315 at kernel/locking/lockdep.c:840
> look_up_lock_class kernel/locking/lockdep.c:840 [inline]
> WARNING: CPU: 0 PID: 10315 at kernel/locking/lockdep.c:840
> register_lock_class+0x206/0x1850 kernel/locking/lockdep.c:1185
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 10315 Comm: syz-executor.0 Not tainted 5.3.0+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   panic+0x2dc/0x755 kernel/panic.c:219
>   __warn.cold+0x20/0x4c kernel/panic.c:576
>   report_bug+0x263/0x2b0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> RIP: 0010:look_up_lock_class kernel/locking/lockdep.c:840 [inline]
> RIP: 0010:register_lock_class+0x206/0x1850 kernel/locking/lockdep.c:1185
> Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 aa 10 00 00 4c 3b 7b
> 18 44 8b 35 d5 de 55 09 74 0b 48 81 3b a0 65 06 8a 74 02 <0f> 0b 45 85 ed
> 0f 84 71 03 00 00 f6 85 70 ff ff ff 01 0f 85 64 03
> RSP: 0018:ffff888096777a48 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: ffff888093ff78e0 RCX: 0000000000000000
> RDX: 1ffff110127fef1f RSI: 0000000000000000 RDI: ffff888093ff78f8
> RBP: ffff888096777b10 R08: 1ffff11012ceef51 R09: ffffffff8aaea0e0
> R10: ffffffff8a7753c8 R11: 0000000000000000 R12: ffffffff8a7b5d20
> R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff884766e0
>   __lock_acquire+0xf4/0x4e70 kernel/locking/lockdep.c:3837
>   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
>   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
>   _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:175
>   spin_lock_bh include/linux/spinlock.h:343 [inline]
>   lock_sock_nested+0x41/0x120 net/core/sock.c:2929
>   lock_sock include/net/sock.h:1522 [inline]
>   selinux_netlbl_socket_connect+0x20/0xc0 security/selinux/netlabel.c:607
>   selinux_socket_connect+0x6a/0x90 security/selinux/hooks.c:4745
>   security_socket_connect+0x77/0xc0 security/security.c:1958
>   __sys_connect+0x19d/0x330 net/socket.c:1824
>   __do_sys_connect net/socket.c:1839 [inline]
>   __se_sys_connect net/socket.c:1836 [inline]
>   __x64_sys_connect+0x73/0xb0 net/socket.c:1836
>   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459a09
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fc302ec5c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a09
> RDX: 000000000000001c RSI: 0000000020000080 RDI: 0000000000000005
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc302ec66d4
> R13: 00000000004bff42 R14: 00000000004d1eb0 R15: 00000000ffffffff
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

This doesn't appear to be related to selinux_netlbl_socket_connect();
I believe it should be okay to call lock_sock() in that context.

-- 
paul moore
www.paul-moore.com
