Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ED4C432BE
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C22F60F4C
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhH0OuM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Aug 2021 10:50:12 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42873 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhH0OuL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Aug 2021 10:50:11 -0400
Received: by mail-il1-f200.google.com with SMTP id z14-20020a92d18e0000b029022418b34bc9so3171117ilz.9
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 07:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zme3oqhaRPqOxyEVa6qXZflTFNypbpRkaNf+HNcb2hI=;
        b=m8Z373UYGlyxZmhi8SN8+DYHOEgFhbiWmkOcG4IIMeHbcCi8Y2tixqWRbuQedXGaA+
         Qh6xq3CafwfB4CJkw01MclOFU+1v6CI3Bcm8OGcDmJU3lRCLo1DDEnXM1SA2dmhxkKHv
         MhGhzbhR8pSLiStJGA7A68XZEFSN6cyeG5IELuecS81ffiQigoqbpw4tAzHkutK9quSG
         rjyO3+a2d9rU1NBrDW8oZS3l8os+TgrdOKx1Ubz+4C7xfh4C69AXMmfsdKkVPX5IO0rX
         uUFxACe64sBqXL0EoixTH9qFFbl5mrfa3gaXUQEIkasIVlJpX67Hi3xD7rKR5yq1IKZM
         EsSA==
X-Gm-Message-State: AOAM533s50BgZp1pucMYG9/qP30kdLkQ70NplU8PKW1FHRK2tU73fsWc
        DqiV9PfbgXfoozdugg9Rv3TukzAMnul+E5FT0yW9nNal0dp1
X-Google-Smtp-Source: ABdhPJwDmNyWip24oPcN/2tFbu35ZESqlWMsdd6Zas93i+q+XWKUqetn8oM5fnnFzs4RUPPBoeKr/EcJkpt57uG0Gv7ukvDHX1US
MIME-Version: 1.0
X-Received: by 2002:a5e:8e4c:: with SMTP id r12mr7808124ioo.73.1630075762565;
 Fri, 27 Aug 2021 07:49:22 -0700 (PDT)
Date:   Fri, 27 Aug 2021 07:49:22 -0700
In-Reply-To: <0000000000004e5ec705c6318557@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8e9e605ca8b962c@google.com>
Subject: Re: [syzbot] general protection fault in legacy_parse_param
From:   syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, dhowells@redhat.com, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    77dd11439b86 Merge tag 'drm-fixes-2021-08-27' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10636bde300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2fd902af77ff1e56
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126d084d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16216eb1300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8435 Comm: syz-executor272 Not tainted 5.14.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
RSP: 0018:ffffc9000d9f7d08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88801c1f3880
RDX: 0000000000000001 RSI: 000000000000002c RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81e3db46 R09: ffffffff81e3d8e2
R10: 0000000000000002 R11: ffff88801c1f3880 R12: dffffc0000000000
R13: 1ffff92001b3efcc R14: 0000000000000000 R15: 000000000000002c
FS:  0000000000deb300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000044 CR3: 0000000037173000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 legacy_parse_param+0x49b/0x810 fs/fs_context.c:555
 vfs_parse_fs_param+0x1df/0x460 fs/fs_context.c:146
 vfs_fsconfig_locked fs/fsopen.c:265 [inline]
 __do_sys_fsconfig fs/fsopen.c:439 [inline]
 __se_sys_fsconfig+0xba9/0xff0 fs/fsopen.c:314
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43ee69
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc5e9e0b98 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043ee69
RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000402e50 R08: 0000000000000000 R09: 0000000000400488
R10: 00000000200000c0 R11: 0000000000000246 R12: 0000000000402ee0
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
Modules linked in:
---[ end trace 74baf661f3b47b0a ]---
RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
RSP: 0018:ffffc9000d9f7d08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88801c1f3880
RDX: 0000000000000001 RSI: 000000000000002c RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81e3db46 R09: ffffffff81e3d8e2
R10: 0000000000000002 R11: ffff88801c1f3880 R12: dffffc0000000000
R13: 1ffff92001b3efcc R14: 0000000000000000 R15: 000000000000002c
FS:  0000000000deb300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fed5f8146c0 CR3: 0000000037173000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	41 54                	push   %r12
   2:	53                   	push   %rbx
   3:	48 89 d3             	mov    %rdx,%rbx
   6:	41 89 f7             	mov    %esi,%r15d
   9:	45 31 f6             	xor    %r14d,%r14d
   c:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  13:	fc ff df
  16:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1b:	48 85 db             	test   %rbx,%rbx
  1e:	74 3b                	je     0x5b
  20:	48 89 fd             	mov    %rdi,%rbp
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	75 0f                	jne    0x42
  33:	48 ff cb             	dec    %rbx
  36:	48 8d 7d 01          	lea    0x1(%rbp),%rdi
  3a:	44 38 7d 00          	cmp    %r15b,0x0(%rbp)
  3e:	75 db                	jne    0x1b

