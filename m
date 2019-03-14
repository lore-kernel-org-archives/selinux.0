Return-Path: <SRS0=Q8hv=RR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD639C43381
	for <selinux@archiver.kernel.org>; Thu, 14 Mar 2019 20:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7AB20854
	for <selinux@archiver.kernel.org>; Thu, 14 Mar 2019 20:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfCNUwI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:52:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37463 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfCNUwI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Mar 2019 16:52:08 -0400
Received: by mail-io1-f72.google.com with SMTP id u22so5292017iof.4
        for <selinux@vger.kernel.org>; Thu, 14 Mar 2019 13:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LiadQGp0rsm/oiWoHZ12ezgYKH2k9o1vICh/iPkv/ew=;
        b=OU3r7Qya6+Km19PJSe2YtZFHMLYoUOxHzZ6Ca6UA4YGlmy9unDqqyoeCEJcZPYxgc5
         N2gOVoDRSszGxsVqc9FvtiK9dbJYplUc/P5D43ypfve9jwuYWmepaSJy5Ii8kP2MbkO9
         JtFA2HJjH0HseC295jgLzwUkWA7CMIdfAWhS85z+1G26P4RBQpvIwJcmaYAAIeumFtsS
         LUbz/EZ0JnwU66qjoljf6YVMPJnO0EZ+vLOfjzPmvUwuZ6GjdqFtofxQKjJ2iHq5gutz
         CtvNl7l6wQ5Nl8Ojm9fl2QPrdxC8gjWEq1696nBx0l5SHFu/JvkVVp1DHAHboAc1ZQUK
         VE4A==
X-Gm-Message-State: APjAAAV+U1DqWPXwWlZzOblfg2pD9wlPbJkn/1GLEL7wHbqBxTVEPGKQ
        xFurC7JbCS7f4FejV63voVuAvhmsmMpsc9qKt0HISniLKFeg
X-Google-Smtp-Source: APXvYqxPNFbUsckffe3Vos36uNHXicdmIIoFQcf2x9bCcLcA5B3knQT1UCpWy3OX11DXLw6YuqXNdjvLBTQzCel2ZDDI192Jwujn
MIME-Version: 1.0
X-Received: by 2002:a5e:8a07:: with SMTP id d7mr199561iok.7.1552596726876;
 Thu, 14 Mar 2019 13:52:06 -0700 (PDT)
Date:   Thu, 14 Mar 2019 13:52:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006294c30584141805@google.com>
Subject: general protection fault in ebitmap_destroy (2)
From:   syzbot <syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        dave.hansen@intel.com, eparis@parisplace.org,
        kent.overstreet@gmail.com, linux-kernel@vger.kernel.org,
        marcelo.leitner@gmail.com, nhorman@tuxdriver.com,
        paul@paul-moore.com, peter.enderborg@sony.com, pshelar@ovn.org,
        sds@tycho.nsa.gov, selinux@vger.kernel.org, shli@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, vyasevich@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ebc551f2 Merge tag 'nfsd-5.1' of git://linux-nfs.org/~bfie..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105c28d7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f05902bca21d8935
dashboard link: https://syzkaller.appspot.com/bug?extid=a57b2aff60832666fc28
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1510bd5f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1405dd6f200000

The crash was bisected to:

commit acdf52d97f824019888422842757013b37441dd1
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Tue Mar 12 06:31:10 2019 +0000

     selinux: convert to kvmalloc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b2b093200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b2b093200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b2b093200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com
Fixes: acdf52d9 ("selinux: convert to kvmalloc")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8151 Comm: syz-executor646 Not tainted 5.0.0+ #20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ebitmap_destroy+0x32/0xf0 security/selinux/ss/ebitmap.c:334
Code: 49 89 fd 41 54 53 e8 6d f6 7f fe 4d 85 ed 0f 84 99 00 00 00 e8 5f f6  
7f fe 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 98 00 00 00 49 be 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff8880918478c8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880a15c93e8 RCX: ffffffff82f1b92c
RDX: 0000000000000002 RSI: ffffffff82f06dd1 RDI: 0000000000000010
RBP: ffff8880918478e8 R08: ffff88807c05c080 R09: ffff88807c05c948
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000010 R14: ffffed10142b92b2 R15: 0000000000000401
FS:  0000000000f65880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 000000007e591000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  policydb_destroy+0x62c/0x7f0 security/selinux/ss/policydb.c:832
  policydb_read+0xe27/0x52c0 security/selinux/ss/policydb.c:2522
  security_load_policy+0x36d/0x1170 security/selinux/ss/services.c:2147
  sel_write_load+0x25a/0x470 security/selinux/selinuxfs.c:565
  __vfs_write+0x8d/0x110 fs/read_write.c:485
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0xea/0x1f0 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4401f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff747a42f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401f9
RDX: 0000000000000050 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a80
R13: 0000000000401b10 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace c9a4ce516f33c859 ]---
RIP: 0010:ebitmap_destroy+0x32/0xf0 security/selinux/ss/ebitmap.c:334
Code: 49 89 fd 41 54 53 e8 6d f6 7f fe 4d 85 ed 0f 84 99 00 00 00 e8 5f f6  
7f fe 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 98 00 00 00 49 be 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff8880918478c8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880a15c93e8 RCX: ffffffff82f1b92c
RDX: 0000000000000002 RSI: ffffffff82f06dd1 RDI: 0000000000000010
RBP: ffff8880918478e8 R08: ffff88807c05c080 R09: ffff88807c05c948
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000010 R14: ffffed10142b92b2 R15: 0000000000000401
FS:  0000000000f65880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 000000007e591000 CR4: 00000000001406e0
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
