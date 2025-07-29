Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE5182
	for <selinux@vger.kernel.org>; Tue, 29 Jul 2025 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788335; cv=none; b=IF5R8DLhb7ChEvGr25aitFKaDdLKZlFZ9RZYUXtRDKx3F/NKZS0DZeMmkcuHDNxZXSRJhMzU2+9w/soa1r0E3Nzkyne08B9D0V+BnKyL8uVjVRvaI/Sne9ygb6ANaHmnyHqpwUE+Qqy3VmW3K10BhXMcAPrLJ+64NcaJBzIjwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788335; c=relaxed/simple;
	bh=SCGrgsN8k/kT5PDKXNncZn9otftKXxe4c98vIwEKyxo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RHceKkhbFdthaURm+kaxwCoT1RTGHV2md6mfGDEQFuCRGeqBcPR9B6V87JGXxrELAgjkU/Bz4rOqOwKah3r5bYYGl6B6cE3pseZuKJjMsHRxHXKTMOgtOo6VIEmFVVGSlwgQUL4ZLOisUVucMBJiNUQ6vye9bQWSRwAbkjOBRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e29ee0fb2dso51367835ab.3
        for <selinux@vger.kernel.org>; Tue, 29 Jul 2025 04:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753788332; x=1754393132;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKMxNoBsiTCfPe9aUHJs86O8k35F3rPcOqA1XyoUnAs=;
        b=tlvt08nYs6JPL4MSYo6fZONIef0RjSwsl5C25BTEpI2Oj1tR7AmHuDyF3NBbZ4xnp4
         7kJn+l43HXB7TywIQMGXFxzAxqLnO7fP5J+KfFlnxqmZbd24fsGoIGpWSiOxorRwOCVc
         3z5JFKoz3A68FGj5UVffStsM2EqDoVT6f20us23ZTuz6/wQdc4NVDCtSNMcgSRx/8KCE
         qVBtm1SOR2nuI2A0RhFD3hXLHDu1Pv0ZD248jV9RVl02hlF8WlTIbz4Ig76jIpwNAVAA
         VChZ1c0YTJEM7EfsJSWH48Bcvast4IKrLvx3+fRINQCgdIL9XXL0tdwyTv72SHiNa11w
         iu5A==
X-Forwarded-Encrypted: i=1; AJvYcCVKwIUwX71SciRnB7MZMYdidYSnvyg9rKLbJnVwNXh7pNlbWMjCUxPJ5UgjxUxKStZkU0zPkZ9x@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8o7zyikb2HpZyo8anhCw1Jt4KY5LknKYlJrMJbzOQ7mC9EK/
	Dr7pAqgBX7BPrNdV394gpZH1uQB4EG9SCowTeXJVtjUQa3c2MgCVpMp8fhgFon6uf7EmXOuqn/c
	v26xp+OrJRzTjoIoAJbLImJgXVX2FXylhueycowiVuN0TfhsDAFzlCOUmqV4=
X-Google-Smtp-Source: AGHT+IHqhnTjUv/enBOaXsiWWw7RbcPi+SgZmzkSJww7fT+WuPuS46VjiYUEmkDirE5pWidY7n4A6DdH3Onpc4CPZwK0koHI/43B
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:3e2:c350:2e61 with SMTP id
 e9e14a558f8ab-3e3c5312d49mr238171395ab.20.1753788332544; Tue, 29 Jul 2025
 04:25:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 04:25:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6888afac.050a0220.f0410.0004.GAE@google.com>
Subject: [syzbot] [selinux?] KASAN: slab-out-of-bounds Read in hashtab_map
From: syzbot <syzbot+f5d178906c398555583d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    25fae0b93d1d Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164fbb82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
dashboard link: https://syzkaller.appspot.com/bug?extid=f5d178906c398555583d
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7acf9d19f311/disk-25fae0b9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/532080ae9996/vmlinux-25fae0b9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47473831ee3b/bzImage-25fae0b9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5d178906c398555583d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in hashtab_map+0x16b/0x1b0 security/selinux/ss/hashtab.c:97
Read of size 8 at addr ffff888052e330f8 by task syz.4.1473/10347

CPU: 1 UID: 0 PID: 10347 Comm: syz.4.1473 Not tainted 6.16.0-rc7-syzkaller-00034-g25fae0b93d1d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x610 mm/kasan/report.c:480
 kasan_report+0xe0/0x110 mm/kasan/report.c:593
 hashtab_map+0x16b/0x1b0 security/selinux/ss/hashtab.c:97
 policydb_write+0x519/0x2420 security/selinux/ss/policydb.c:3739
 __security_read_policy security/selinux/ss/services.c:3996 [inline]
 security_read_policy+0x16a/0x2e0 security/selinux/ss/services.c:4025
 sel_open_policy+0x276/0x530 security/selinux/selinuxfs.c:387
 do_dentry_open+0x744/0x1c10 fs/open.c:964
 vfs_open+0x82/0x3f0 fs/open.c:1094
 do_open fs/namei.c:3896 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4055
 do_filp_open+0x20b/0x470 fs/namei.c:4082
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3c8818e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3c88fd1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f3c883b6240 RCX: 00007f3c8818e9a9
RDX: 0000000000000000 RSI: 0000200000001040 RDI: 00000000ffffff9c
RBP: 00007f3c88210d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3c883b6240 R15: 00007ffcae330ab8
 </TASK>

Allocated by task 5497:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x1d5/0x3b0 mm/slub.c:4249
 __alloc_skb+0x2b2/0x380 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1336 [inline]
 alloc_skb_with_frags+0xe0/0x860 net/core/skbuff.c:6665
 sock_alloc_send_pskb+0x7fb/0x990 net/core/sock.c:2999
 unix_dgram_sendmsg+0x3e9/0x17a0 net/unix/af_unix.c:2083
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 __sys_sendto+0x4a3/0x520 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5184:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kmem_cache_free+0x2d1/0x4d0 mm/slub.c:4745
 kfree_skbmem+0x1a4/0x1f0 net/core/skbuff.c:1110
 __kfree_skb net/core/skbuff.c:1167 [inline]
 consume_skb net/core/skbuff.c:1398 [inline]
 consume_skb+0xcc/0x100 net/core/skbuff.c:1392
 __unix_dgram_recvmsg+0x779/0xbd0 net/unix/af_unix.c:2599
 unix_dgram_recvmsg+0xd0/0x110 net/unix/af_unix.c:2616
 sock_recvmsg_nosec net/socket.c:1017 [inline]
 sock_recvmsg+0x1f6/0x250 net/socket.c:1039
 sock_read_iter+0x2b9/0x3b0 net/socket.c:1109
 new_sync_read fs/read_write.c:491 [inline]
 vfs_read+0xa98/0xc60 fs/read_write.c:572
 ksys_read+0x1f8/0x250 fs/read_write.c:715
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888052e33000
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 8 bytes to the right of
 allocated 240-byte region [ffff888052e33000, ffff888052e330f0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x52e33
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801fe8a8c0 0000000000000000 0000000000000001
raw: 0000000000000000 00000000000c000c 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5497, tgid 5497 (dhcpcd), ts 281072548022, free_ts 280707616058
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 kmem_cache_alloc_node_noprof+0xf5/0x3b0 mm/slub.c:4249
 __alloc_skb+0x2b2/0x380 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1336 [inline]
 alloc_skb_with_frags+0xe0/0x860 net/core/skbuff.c:6665
 sock_alloc_send_pskb+0x7fb/0x990 net/core/sock.c:2999
 unix_dgram_sendmsg+0x3e9/0x17a0 net/unix/af_unix.c:2083
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 __sys_sendto+0x4a3/0x520 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 pagetable_free include/linux/mm.h:2884 [inline]
 pagetable_dtor_free include/linux/mm.h:2982 [inline]
 __tlb_remove_table include/asm-generic/tlb.h:220 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x116/0x1a0 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0x799/0x14e0 kernel/rcu/tree.c:2832
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff888052e32f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888052e33000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888052e33080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                                ^
 ffff888052e33100: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888052e33180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
