Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103B5C43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 15:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73F1206BA
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfAIPlE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:41:04 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:43063 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbfAIPlE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 10:41:04 -0500
Received: by mail-io1-f70.google.com with SMTP id k4so6793624ioc.10
        for <selinux@vger.kernel.org>; Wed, 09 Jan 2019 07:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0FAwe0lDjP8h9AUhvn2Qnn3m5Wlr+FezM1aTRHNNe88=;
        b=p8kcVaVFYw237EAcMTohp73Nhy0UNQfdHdTr5nbBartIhxmNWPzHlK12QZjRxmInJy
         9E+JqL5j6ebByZNh4Jl6+t7/rH30MzjhZo/eVKiK5L4UNNoCfXbc12+XSQH7+sXlVt0+
         E7NDYeBCQFiyEePzHY36gx4EbTEuA6qXt/iG7MIzLCnTmhtgrmtmh5cBEWsGM9MQJR1T
         B0O+1MUu9nuAgAiiiCU6RUXYC7JodUX7Zn76mhrhrTcDGqic88364OP4D8o/YqwPEjMW
         TvrTzExX3qYXxYBlztw78jZxXQUnIxGX2QiMf2m6L7/amqwwpSlNF/E7iJnols3YJp2T
         6kIQ==
X-Gm-Message-State: AJcUukf/s4RD7DJkXoGykRNvCy3MKNMc72DI9s4b7rrPkBo5mP8hS2cm
        qEwBmtFyjQvAePfYCXxpxehPHT3eM9OShnnyrlqkUZWaHh16
X-Google-Smtp-Source: ALg8bN6wttTQvAK7SGRrEO04wL0ZUFXcEtMz0dwBEbNSTWgdaU7MzxOU7cYqe+wn6Numv8a7g4Mn8Lqi8GWTqwIkf5G5RRVAoT5S
MIME-Version: 1.0
X-Received: by 2002:a5d:8619:: with SMTP id f25mr1000594iol.31.1547048463274;
 Wed, 09 Jan 2019 07:41:03 -0800 (PST)
Date:   Wed, 09 Jan 2019 07:41:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a9aa0057f084a81@google.com>
Subject: general protection fault in ebitmap_destroy
From:   syzbot <syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com>
To:     eparis@parisplace.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, peter.enderborg@sony.com, sds@tycho.nsa.gov,
        selinux@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a88cc8da0279 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1722da4f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
dashboard link: https://syzkaller.appspot.com/bug?extid=6664500f0f18f07a5c0e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d43580c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com

SELinux: failed to load policy
sel_write_load: 238 callbacks suppressed
SELinux: failed to load policy
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9316 Comm: syz-executor2 Not tainted 5.0.0-rc1+ #16
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ebitmap_destroy+0x32/0xf0 security/selinux/ss/ebitmap.c:334
Code: 49 89 fd 41 54 53 e8 9d e6 36 fe 4d 85 ed 0f 84 99 00 00 00 e8 8f e6  
36 fe 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 98 00 00 00 49 be 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff88808967f5c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88808967f6a8 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: ffffffff834b1081 RDI: 0000000000000008
RBP: ffff88808967f5e0 R08: ffff8880972a8140 R09: ffffed1015cc5b90
R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff888099d993c0
R13: 0000000000000008 R14: ffff888099d993c0 R15: ffff88808967f648
FS:  00007f70cd9e5700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000015e7938 CR3: 0000000096c4a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sens_destroy+0x49/0xa0 security/selinux/ss/policydb.c:735
  sens_read+0x25d/0x460 security/selinux/ss/policydb.c:1636
  policydb_read+0xed9/0x60d0 security/selinux/ss/policydb.c:2430
  security_load_policy+0x423/0x1830 security/selinux/ss/services.c:2129
  sel_write_load+0x25a/0x470 security/selinux/selinuxfs.c:565
  __vfs_write+0x116/0xb40 fs/read_write.c:485
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0x105/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f70cd9e4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 000000000000005c RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f70cd9e56d4
R13: 00000000004c720f R14: 00000000004dc9a0 R15: 00000000ffffffff
Modules linked in:
---[ end trace 78ea480790940b53 ]---
RIP: 0010:ebitmap_destroy+0x32/0xf0 security/selinux/ss/ebitmap.c:334
Code: 49 89 fd 41 54 53 e8 9d e6 36 fe 4d 85 ed 0f 84 99 00 00 00 e8 8f e6  
36 fe 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 98 00 00 00 49 be 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff88808967f5c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88808967f6a8 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: ffffffff834b1081 RDI: 0000000000000008
RBP: ffff88808967f5e0 R08: ffff8880972a8140 R09: ffffed1015cc5b90
R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff888099d993c0
R13: 0000000000000008 R14: ffff888099d993c0 R15: ffff88808967f648
FS:  00007f70cd9e5700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000073c000 CR3: 0000000096c4a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
