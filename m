Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA2Nu0gP011472
 for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2017 19:56:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 3yShmy5Rrgz4KRPB
 for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2017 23:56:02 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 3yShmy2YqTz4KRKS
 for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2017 23:56:02 +0000 (UTC)
Received: by mail-lf0-f46.google.com with SMTP id 75so1300245lfx.1
 for <selinux@tycho.nsa.gov>; Thu, 02 Nov 2017 16:51:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001a11451c6e293aaf055d03a825@google.com>
References: <001a11451c6e293aaf055d03a825@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Nov 2017 19:51:41 -0400
Message-ID: <CAHC9VhRY+EL89irk=nbnN_L_5SmNpjhWiDB8YwaTohQbMSKg-w@mail.gmail.com>
To: syzbot
 <bot+23f79c6532ceddb959aaea30dd5e3c752b93bf21@syzkaller.appspotmail.com>
Cc: anton@enomsg.org, ccross@android.com, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, keescook@chromium.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 serge@hallyn.com, syzkaller-bugs@googlegroups.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: KASAN: use-after-free Read in do_raw_spin_lock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Nov 2, 2017 at 1:52 PM, syzbot
<bot+23f79c6532ceddb959aaea30dd5e3c752b93bf21@syzkaller.appspotmail.com>
wrote:
> Hello,
>
> syzkaller hit the following crash on
> ebe6e90ccc6679cb01d2b280e4b61e6092d4bedb
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.

I'm not sure a real person is watching for responses on this, but just
in case ... are you able to reproduce this failure at all?  I'm
looking over the SELinux superblock code, as well as the corresponding
pieces in fs/super.c, and I'm not quite sure how we could get into the
situation where superblock's security blob is freed before the last
associated inode.

> capability: warning: `syz-executor3' uses 32-bit capabilities (legacy
> support in use)
> ==================================================================
> BUG: KASAN: use-after-free in debug_spin_lock_before
> kernel/locking/spinlock_debug.c:83 [inline]
> BUG: KASAN: use-after-free in do_raw_spin_lock+0x1aa/0x1e0
> kernel/locking/spinlock_debug.c:112
> Read of size 4 at addr ffff8801c5b1ddec by task syz-executor6/3887
>
> CPU: 1 PID: 3887 Comm: syz-executor6 Not tainted 4.14.0-rc5+ #136
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:429
>  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>  do_raw_spin_lock+0x1aa/0x1e0 kernel/locking/spinlock_debug.c:112
>  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
>  _raw_spin_lock+0x32/0x40 kernel/locking/spinlock.c:151
>  spin_lock include/linux/spinlock.h:316 [inline]
>  inode_free_security security/selinux/hooks.c:346 [inline]
>  selinux_inode_free_security+0x12a/0x410 security/selinux/hooks.c:2873
>  security_inode_free+0x50/0x90 security/security.c:442
>  __destroy_inode+0x287/0x650 fs/inode.c:236
>  destroy_inode+0xe7/0x200 fs/inode.c:263
>  evict+0x57e/0x920 fs/inode.c:570
>  iput_final fs/inode.c:1515 [inline]
>  iput+0x7b9/0xaf0 fs/inode.c:1542
>  fsnotify_put_mark+0x4d0/0x730 fs/notify/mark.c:237
>  fsnotify_clear_marks_by_group+0x19a/0x5f0 fs/notify/mark.c:691
>  fsnotify_destroy_group+0xde/0x3f0 fs/notify/group.c:70
>  inotify_release+0x37/0x50 fs/notify/inotify/inotify_user.c:280
>  __fput+0x327/0x7e0 fs/file_table.c:210
>  ____fput+0x15/0x20 fs/file_table.c:244
>  task_work_run+0x199/0x270 kernel/task_work.c:112
>  exit_task_work include/linux/task_work.h:21 [inline]
>  do_exit+0x9b5/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  get_signal+0x73f/0x16d0 kernel/signal.c:2334
>  do_signal+0x94/0x1ee0 arch/x86/kernel/signal.c:808
>  exit_to_usermode_loop+0x214/0x310 arch/x86/entry/common.c:158
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath+0x42f/0x510 arch/x86/entry/common.c:266
>  entry_SYSCALL_64_fastpath+0xbc/0xbe
> RIP: 0033:0x452779
> RSP: 002b:00007f6815b25ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00000000007581a0 RCX: 0000000000452779
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000007581a0
> RBP: 00000000007581a0 R08: 000000000000018e R09: 0000000000758180
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000a6f7ff R14: 00007f6815b269c0 R15: 000000000000001e
>
> Allocated by task 3873:
>  save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  kmem_cache_alloc_trace+0x136/0x750 mm/slab.c:3627
>  kmalloc include/linux/slab.h:493 [inline]
>  kzalloc include/linux/slab.h:666 [inline]
>  superblock_alloc_security security/selinux/hooks.c:390 [inline]
>  selinux_sb_alloc_security+0x93/0x2e0 security/selinux/hooks.c:2630
>  security_sb_alloc+0x6d/0xa0 security/security.c:356
>  alloc_super fs/super.c:196 [inline]
>  sget_userns+0x36a/0xe20 fs/super.c:505
>  sget+0xd2/0x120 fs/super.c:557
>  mount_nodev+0x37/0x100 fs/super.c:1160
>  ramfs_mount+0x2c/0x40 fs/ramfs/inode.c:253
>  mount_fs+0x66/0x2d0 fs/super.c:1222
>  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:2509 [inline]
>  do_new_mount fs/namespace.c:2512 [inline]
>  do_mount+0xea1/0x2bb0 fs/namespace.c:2840
>  SYSC_mount fs/namespace.c:3056 [inline]
>  SyS_mount+0xab/0x120 fs/namespace.c:3033
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
>
> Freed by task 3873:
>  save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3503 [inline]
>  kfree+0xca/0x250 mm/slab.c:3820
>  superblock_free_security security/selinux/hooks.c:410 [inline]
>  selinux_sb_free_security+0x42/0x50 security/selinux/hooks.c:2635
>  security_sb_free+0x48/0x80 security/security.c:361
>  destroy_super+0x93/0x200 fs/super.c:167
>  __put_super.part.6+0x1a4/0x2a0 fs/super.c:272
>  __put_super fs/super.c:270 [inline]
>  put_super+0x53/0x70 fs/super.c:286
>  deactivate_locked_super+0xb0/0xd0 fs/super.c:319
>  deactivate_super+0x141/0x1b0 fs/super.c:339
>  cleanup_mnt+0xb2/0x150 fs/namespace.c:1173
>  __cleanup_mnt+0x16/0x20 fs/namespace.c:1180
>  task_work_run+0x199/0x270 kernel/task_work.c:112
>  exit_task_work include/linux/task_work.h:21 [inline]
>  do_exit+0x9b5/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  get_signal+0x73f/0x16d0 kernel/signal.c:2334
>  do_signal+0x94/0x1ee0 arch/x86/kernel/signal.c:808
>  exit_to_usermode_loop+0x214/0x310 arch/x86/entry/common.c:158
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath+0x42f/0x510 arch/x86/entry/common.c:266
>  entry_SYSCALL_64_fastpath+0xbc/0xbe
>
> The buggy address belongs to the object at ffff8801c5b1dd40
>  which belongs to the cache kmalloc-256 of size 256
> The buggy address is located 172 bytes inside of
>  256-byte region [ffff8801c5b1dd40, ffff8801c5b1de40)
> The buggy address belongs to the page:
> page:ffffea000716c740 count:1 mapcount:0 mapping:ffff8801c5b1d0c0 index:0x0
> flags: 0x200000000000100(slab)
> raw: 0200000000000100 ffff8801c5b1d0c0 0000000000000000 000000010000000c
> raw: ffffea0007155de0 ffffea0007130ae0 ffff8801dac007c0 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801c5b1dc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801c5b1dd00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>>
>> ffff8801c5b1dd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
>                                                           ^
>  ffff8801c5b1de00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8801c5b1de80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
>
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line.



-- 
paul moore
www.paul-moore.com
