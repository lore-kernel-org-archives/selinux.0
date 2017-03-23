Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NATh9B010408
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 06:29:43 -0400
Received: by mail-vk0-f47.google.com with SMTP id z204so87165475vkd.1
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 03:29:37 -0700 (PDT)
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 23 Mar 2017 11:29:16 +0100
Message-ID: <CACT4Y+bb83Vku6iTtSp34HzM+hr+ZZD4Pex-N10qehfXXhHQjA@mail.gmail.com>
Subject: security: double-free in superblock_doinit
To: Paul Moore <paul@paul-moore.com>, sds@tycho.nsa.gov, eparis@parisplace.org,
 james.l.morris@oracle.com, serge@hallyn.com,
 Kees Cook <keescook@chromium.org>, anton@enomsg.org,
 ccross@android.com, tony.luck@intel.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I've got the following double-free report in superblock_doinit while
running syzkaller fuzzer.
Note the preceding injected failure in kmalloc, most likely that the root cause.

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 2 PID: 15269 Comm: syz-executor1 Not tainted 4.11.0-rc3+ #364
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x1b8/0x28d lib/dump_stack.c:52
 fail_dump lib/fault-inject.c:45 [inline]
 should_fail+0x78a/0x870 lib/fault-inject.c:154
 should_failslab+0xec/0x120 mm/failslab.c:31
 slab_pre_alloc_hook mm/slab.h:434 [inline]
 slab_alloc mm/slab.c:3394 [inline]
 kmem_cache_alloc_trace+0x206/0x720 mm/slab.c:3636
 kmalloc include/linux/slab.h:490 [inline]
 kmalloc_array include/linux/slab.h:608 [inline]
 kcalloc include/linux/slab.h:620 [inline]
 selinux_parse_opts_str+0x36e/0x7f0 security/selinux/hooks.c:1107
 superblock_doinit+0x155/0x430 security/selinux/hooks.c:1157
 selinux_sb_kern_mount+0xb2/0x300 security/selinux/hooks.c:2783
 security_sb_kern_mount+0x7d/0xb0 security/security.c:331
 mount_fs+0x11b/0x2f0 fs/super.c:1233
 vfs_kern_mount.part.23+0xc6/0x4b0 fs/namespace.c:979
 vfs_kern_mount fs/namespace.c:3293 [inline]
 kern_mount_data+0x50/0xb0 fs/namespace.c:3293
 mq_init_ns+0x167/0x220 ipc/mqueue.c:1418
 create_ipc_ns ipc/namespace.c:57 [inline]
 copy_ipcs+0x39b/0x580 ipc/namespace.c:83
 create_new_namespaces+0x285/0x8c0 kernel/nsproxy.c:86
 unshare_nsproxy_namespaces+0xae/0x1e0 kernel/nsproxy.c:205
 SYSC_unshare kernel/fork.c:2319 [inline]
 SyS_unshare+0x664/0xf80 kernel/fork.c:2269
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x445b79
RSP: 002b:00007f1c280f1858 EFLAGS: 00000286 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000708000 RCX: 0000000000445b79
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000048000000
RBP: 0000000000000086 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000004a7e31
R13: 0000000000000000 R14: 00007f1c280f1618 R15: 00007f1c280f1788
==================================================================
BUG: Double free or freeing an invalid pointer
Unexpected shadow byte: 0xFB
CPU: 2 PID: 15269 Comm: syz-executor1 Not tainted 4.11.0-rc3+ #364
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x1b8/0x28d lib/dump_stack.c:52
 kasan_object_err+0x1c/0x70 mm/kasan/report.c:166
 kasan_report_double_free+0x5c/0x70 mm/kasan/report.c:193
 kasan_slab_free+0xab/0xc0 mm/kasan/kasan.c:584
 __cache_free mm/slab.c:3514 [inline]
 kfree+0xd7/0x250 mm/slab.c:3831
 security_free_mnt_opts include/linux/security.h:175 [inline]
 superblock_doinit+0x2a3/0x430 security/selinux/hooks.c:1165
 selinux_sb_kern_mount+0xb2/0x300 security/selinux/hooks.c:2783
 security_sb_kern_mount+0x7d/0xb0 security/security.c:331
 mount_fs+0x11b/0x2f0 fs/super.c:1233
 vfs_kern_mount.part.23+0xc6/0x4b0 fs/namespace.c:979
 vfs_kern_mount fs/namespace.c:3293 [inline]
 kern_mount_data+0x50/0xb0 fs/namespace.c:3293
 mq_init_ns+0x167/0x220 ipc/mqueue.c:1418
 create_ipc_ns ipc/namespace.c:57 [inline]
 copy_ipcs+0x39b/0x580 ipc/namespace.c:83
 create_new_namespaces+0x285/0x8c0 kernel/nsproxy.c:86
 unshare_nsproxy_namespaces+0xae/0x1e0 kernel/nsproxy.c:205
 SYSC_unshare kernel/fork.c:2319 [inline]
 SyS_unshare+0x664/0xf80 kernel/fork.c:2269
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x445b79
RSP: 002b:00007f1c280f1858 EFLAGS: 00000286 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000708000 RCX: 0000000000445b79
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000048000000
RBP: 0000000000000086 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000004a7e31
R13: 0000000000000000 R14: 00007f1c280f1618 R15: 00007f1c280f1788
Object at ffff88004b57ce80, in cache kmalloc-64 size: 64
Allocated:
PID = 15269
 save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:517
 set_track mm/kasan/kasan.c:529 [inline]
 kasan_kmalloc+0xbc/0xf0 mm/kasan/kasan.c:620
 kmem_cache_alloc_trace+0x11a/0x720 mm/slab.c:3638
 kmalloc include/linux/slab.h:490 [inline]
 kmalloc_array include/linux/slab.h:608 [inline]
 kcalloc include/linux/slab.h:620 [inline]
 selinux_parse_opts_str+0x303/0x7f0 security/selinux/hooks.c:1103
 superblock_doinit+0x155/0x430 security/selinux/hooks.c:1157
 selinux_sb_kern_mount+0xb2/0x300 security/selinux/hooks.c:2783
 security_sb_kern_mount+0x7d/0xb0 security/security.c:331
 mount_fs+0x11b/0x2f0 fs/super.c:1233
 vfs_kern_mount.part.23+0xc6/0x4b0 fs/namespace.c:979
 vfs_kern_mount fs/namespace.c:3293 [inline]
 kern_mount_data+0x50/0xb0 fs/namespace.c:3293
 mq_init_ns+0x167/0x220 ipc/mqueue.c:1418
 create_ipc_ns ipc/namespace.c:57 [inline]
 copy_ipcs+0x39b/0x580 ipc/namespace.c:83
 create_new_namespaces+0x285/0x8c0 kernel/nsproxy.c:86
 unshare_nsproxy_namespaces+0xae/0x1e0 kernel/nsproxy.c:205
 SYSC_unshare kernel/fork.c:2319 [inline]
 SyS_unshare+0x664/0xf80 kernel/fork.c:2269
 entry_SYSCALL_64_fastpath+0x1f/0xc2
Freed:
PID = 15269
 save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:517
 set_track mm/kasan/kasan.c:529 [inline]
 kasan_slab_free+0x81/0xc0 mm/kasan/kasan.c:593
 __cache_free mm/slab.c:3514 [inline]
 kfree+0xd7/0x250 mm/slab.c:3831
 selinux_parse_opts_str+0x6c7/0x7f0 security/selinux/hooks.c:1110
 superblock_doinit+0x155/0x430 security/selinux/hooks.c:1157
 selinux_sb_kern_mount+0xb2/0x300 security/selinux/hooks.c:2783
 security_sb_kern_mount+0x7d/0xb0 security/security.c:331
 mount_fs+0x11b/0x2f0 fs/super.c:1233
 vfs_kern_mount.part.23+0xc6/0x4b0 fs/namespace.c:979
 vfs_kern_mount fs/namespace.c:3293 [inline]
 kern_mount_data+0x50/0xb0 fs/namespace.c:3293
 mq_init_ns+0x167/0x220 ipc/mqueue.c:1418
 create_ipc_ns ipc/namespace.c:57 [inline]
 copy_ipcs+0x39b/0x580 ipc/namespace.c:83
 create_new_namespaces+0x285/0x8c0 kernel/nsproxy.c:86
 unshare_nsproxy_namespaces+0xae/0x1e0 kernel/nsproxy.c:205
 SYSC_unshare kernel/fork.c:2319 [inline]
 SyS_unshare+0x664/0xf80 kernel/fork.c:2269
 entry_SYSCALL_64_fastpath+0x1f/0xc2
==================================================================

On commit 093b995e3b55a0ae0670226ddfcb05bfbf0099ae
