Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214D2E54CD
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252042; cv=none; b=foo0rz58kqpjTRWzUgdPTzQpPAltUK2vWPgSFIKGWZjrP43V4zR6Xu2kgqCPyRosSBYRzD/Fh3gZ5DmT3zjomROtHvETKsQ9te19JrbefvTY69H3O5BGqgYbknW+YW7DvXsc0IFM2/pEcDb7sCIIo0IvN7gH7FLyOj6DRMmHg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252042; c=relaxed/simple;
	bh=YT4slGZLjT3z3if1pDL1XfyU2P/p1nEtvH/FFrcg1vA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iPt6D4zTY93qKyG1rYTSZZ0tfxsx4Z0G20b9RwQ/uW+jRoJuRtzALnO9DCYh2nrp2XCF2gRoVhS/SxCJO3D2I4wctMDuMvpVEjll3+yzOF7CwRUL7jzkfo3BnbZ2WdNHrrGmvMXkosQc4Yw1++gdM7ddUtRFHWcEJeXzA5gmFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddc9e145daso109088695ab.2
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 06:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750252040; x=1750856840;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29iIlAM/vPeDIyvRyfchXzOgO7DL5UfI/2dgENdz4q0=;
        b=XjicSibjPSFB1i1/NPBTfob4N23Js9mC/Bha9StXACvw2MSX0iK4m359+MlP49e+cx
         vzHJ6MeVaeYT4gYnCE9aK/FhBeGrzxbbzV0OWt4pNecBuGP6Rm5YjX6x5Hy+sVn7O8NC
         wPZVGUsJsxFFZQsu1/y/JGhVX3TtFLsmI4secfaEMhx4IHI3/Dc7Seahv0xP4ObxLtcC
         LSHcEz93tQnQuSTOHQL4ZXj8QRtuMD1MlWZYUtUg/brPbAnUuYej09ZUPm4tcGw/ya0s
         HTr1/Q59e1d6W3jNTnH3LNSjZsoPELeaTLKWgd4I7NK6iJxBbNnyCaX1zIDkgZLEu3lK
         Cjrg==
X-Forwarded-Encrypted: i=1; AJvYcCUefWtVwVnbN7e5cMkkdATixlz19H4tKMOXU5aJ4MhksLJxDdaFCxuttJmRJADRbivl0GprGVr4@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOopo4MlLdENAM3DWq8jtELRcntY3aqvr5BIgXNsM8VqZfSz9
	XMlBFLmUATVeY+E4OPVYE77yDEvKOAMOmnE9q4YxoZUtPNkKdJkNRmnnctIjnruP/ACCkhcF1ud
	fwWVBsLBHdzYMEZjuYMw2fb2IH1CAfRi3V/vSHbRcEpZHJ4UBkDjcuOI1wG8=
X-Google-Smtp-Source: AGHT+IHsiUSW+UimKk/AACwNTW7uFLE8AyVvAaU7GFns0uX4B+XFPTuTKQ7eXhSqtaLNS2kuy4FNJBMP8ZVgjBPdfwy+pTxt1fpA
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:3dd:d746:25eb with SMTP id
 e9e14a558f8ab-3de07cd170amr198045805ab.16.1750252040444; Wed, 18 Jun 2025
 06:07:20 -0700 (PDT)
Date: Wed, 18 Jun 2025 06:07:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6852ba08.050a0220.216029.0011.GAE@google.com>
Subject: [syzbot] [selinux?] WARNING in hashtab_init
From: syzbot <syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    52da431bf03b Merge tag 'libnvdimm-fixes-6.16-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144635d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4130f4d8a06c3e71
dashboard link: https://syzkaller.appspot.com/bug?extid=bc2c99c2929c3d219fb3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a1f50c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1094050c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-52da431b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ebc79a3dea1/vmlinux-52da431b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b1157e117a2/bzImage-52da431b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com

WARNING: CPU: 3 PID: 5931 at mm/page_alloc.c:4935 __alloc_frozen_pages_noprof+0x30b/0x23f0 mm/page_alloc.c:4935
Modules linked in:
CPU: 3 UID: 0 PID: 5931 Comm: syz-executor128 Not tainted 6.16.0-rc2-syzkaller-00047-g52da431bf03b #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_frozen_pages_noprof+0x30b/0x23f0 mm/page_alloc.c:4935
Code: f0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 83 fe 0a 0f 86 0a fe ff ff 80 3d 83 6e 7a 0e 00 75 0b c6 05 7a 6e 7a 0e 01 90 <0f> 0b 90 45 31 f6 eb 81 4d 85 f6 74 22 44 89 fa 89 ee 4c 89 f7 e8
RSP: 0018:ffffc90003d87438 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000015 RDI: 0000000000040dc0
RBP: 0000000200000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000040000000 R11: 0000000000000001 R12: 0000000000000015
R13: 1ffff920007b0e9c R14: 0000000200000000 R15: 0000000000000015
FS:  0000555574b0f380(0000) GS:ffff8880d6a53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 000000002a80f000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_noprof+0xb/0x1b0 mm/page_alloc.c:4993
 __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
 ___kmalloc_large_node+0x84/0x1e0 mm/slub.c:4272
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4300
 __do_kmalloc_node mm/slub.c:4316 [inline]
 __kmalloc_noprof.cold+0xc/0x61 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 hashtab_init+0x1b1/0x290 security/selinux/ss/hashtab.c:43
 common_read+0x1c2/0x3d0 security/selinux/ss/policydb.c:1172
 policydb_read+0x874/0x3220 security/selinux/ss/policydb.c:2578
 security_load_policy+0x15c/0x12c0 security/selinux/ss/services.c:2299
 sel_write_load+0x332/0x1bd0 security/selinux/selinuxfs.c:603
 vfs_write+0x2a0/0x1150 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0fd65a5d79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc49f31638 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000200000000300 RCX: 00007f0fd65a5d79
RDX: 0000000000002000 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 0000200000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000008f R11: 0000000000000246 R12: 00007f0fd65f419c
R13: 00007f0fd65ef082 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
