Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NDA1vm027578
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 09:10:01 -0400
Received: by mail-ua0-f181.google.com with SMTP id q7so93360358uaf.2
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 06:09:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z1eodoxayi1qP-x05UoQ3nscXYUwA3UTN8ypOHfGJwjg@mail.gmail.com>
References: <CACT4Y+Z1eodoxayi1qP-x05UoQ3nscXYUwA3UTN8ypOHfGJwjg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 23 Mar 2017 14:09:19 +0100
Message-ID: <CACT4Y+ZHqNYPE_uMrc1NwX3Rb1FXYoN47D4eJFn=T07bSQ7YEw@mail.gmail.com>
Subject: Re: security,
 hugetlbfs: write to user memory in hugetlbfs_destroy_inode
To: nyc@holomorphy.com, LKML <linux-kernel@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, sds@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, james.l.morris@oracle.com,
 serge@hallyn.com, Kees Cook <keescook@chromium.org>, anton@enomsg.org,
 ccross@android.com, tony.luck@intel.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Cc: syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 23, 2017 at 2:06 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Hello,
>
> I've got the following report while running syzkaller fuzzer on
> 093b995e3b55a0ae0670226ddfcb05bfbf0099ae. Note the preceding injected
> kmalloc failure in inode_alloc_security, most likely it's the root
> cause.
>
>
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 3 PID: 14086 Comm: syz-executor6 Not tainted 4.11.0-rc3+ #364
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x1b8/0x28d lib/dump_stack.c:52
>  fail_dump lib/fault-inject.c:45 [inline]
>  should_fail+0x78a/0x870 lib/fault-inject.c:154
>  should_failslab+0xec/0x120 mm/failslab.c:31
>  slab_pre_alloc_hook mm/slab.h:434 [inline]
>  slab_alloc mm/slab.c:3394 [inline]
>  kmem_cache_alloc+0x200/0x720 mm/slab.c:3570
>  kmem_cache_zalloc include/linux/slab.h:653 [inline]
>  inode_alloc_security security/selinux/hooks.c:221 [inline]
>  selinux_inode_alloc_security+0xf9/0x390 security/selinux/hooks.c:2833
>  security_inode_alloc+0x90/0xd0 security/security.c:387
>  inode_init_always+0x5af/0xc20 fs/inode.c:166
>  alloc_inode+0x82/0x180 fs/inode.c:214
>  new_inode_pseudo+0x69/0x190 fs/inode.c:889
>  new_inode+0x1c/0x40 fs/inode.c:918
>  hugetlbfs_get_inode+0x40/0x420 fs/hugetlbfs/inode.c:734
>  hugetlb_file_setup+0x329/0x9f0 fs/hugetlbfs/inode.c:1282
>  newseg+0x422/0xd30 ipc/shm.c:575
>  ipcget_new ipc/util.c:285 [inline]
>  ipcget+0x21e/0x580 ipc/util.c:639
>  SYSC_shmget ipc/shm.c:673 [inline]
>  SyS_shmget+0x158/0x230 ipc/shm.c:657
>  entry_SYSCALL_64_fastpath+0x1f/0xc2
> RIP: 0033:0x445b79
> RSP: 002b:00007f9dcc5df858 EFLAGS: 00000282 ORIG_RAX: 000000000000001d
> RAX: ffffffffffffffda RBX: 0000000000708000 RCX: 0000000000445b79
> RDX: 0000000000000800 RSI: 0000000000003000 RDI: 0000000000000000
> RBP: 0000000000000086 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000020207000 R11: 0000000000000282 R12: 00000000004a7e31
> R13: 0000000000000000 R14: 00007f9dcc5df618 R15: 00007f9dcc5df788
> ==================================================================
> BUG: KASAN: user-memory-access in atomic_inc
> include/asm-generic/atomic-instrumented.h:87 [inline] at addr
> 000000131730bd7a
> BUG: KASAN: user-memory-access in __lock_acquire+0x21a/0x3a80
> kernel/locking/lockdep.c:3239 at addr 000000131730bd7a
> Write of size 4 by task syz-executor6/14086
> CPU: 3 PID: 14086 Comm: syz-executor6 Not tainted 4.11.0-rc3+ #364
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x1b8/0x28d lib/dump_stack.c:52
>  kasan_report_error mm/kasan/report.c:291 [inline]
>  kasan_report.part.2+0x34a/0x480 mm/kasan/report.c:316
>  kasan_report+0x21/0x30 mm/kasan/report.c:303
>  check_memory_region_inline mm/kasan/kasan.c:326 [inline]
>  check_memory_region+0x137/0x190 mm/kasan/kasan.c:333
>  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:344
>  atomic_inc include/asm-generic/atomic-instrumented.h:87 [inline]
>  __lock_acquire+0x21a/0x3a80 kernel/locking/lockdep.c:3239
>  lock_acquire+0x1ee/0x590 kernel/locking/lockdep.c:3762
>  __raw_write_lock include/linux/rwlock_api_smp.h:210 [inline]
>  _raw_write_lock+0x33/0x50 kernel/locking/spinlock.c:295
>  mpol_free_shared_policy+0x43/0xb0 mm/mempolicy.c:2536
>  hugetlbfs_destroy_inode+0xca/0x120 fs/hugetlbfs/inode.c:952
>  alloc_inode+0x10d/0x180 fs/inode.c:216
>  new_inode_pseudo+0x69/0x190 fs/inode.c:889
>  new_inode+0x1c/0x40 fs/inode.c:918
>  hugetlbfs_get_inode+0x40/0x420 fs/hugetlbfs/inode.c:734
>  hugetlb_file_setup+0x329/0x9f0 fs/hugetlbfs/inode.c:1282
>  newseg+0x422/0xd30 ipc/shm.c:575
>  ipcget_new ipc/util.c:285 [inline]
>  ipcget+0x21e/0x580 ipc/util.c:639
>  SYSC_shmget ipc/shm.c:673 [inline]
>  SyS_shmget+0x158/0x230 ipc/shm.c:657
>  entry_SYSCALL_64_fastpath+0x1f/0xc2
> RIP: 0033:0x445b79
> RSP: 002b:00007f9dcc5df858 EFLAGS: 00000282 ORIG_RAX: 000000000000001d
> RAX: ffffffffffffffda RBX: 0000000000708000 RCX: 0000000000445b79
> RDX: 0000000000000800 RSI: 0000000000003000 RDI: 0000000000000000
> RBP: 0000000000000086 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000020207000 R11: 0000000000000282 R12: 00000000004a7e31
> R13: 0000000000000000 R14: 00007f9dcc5df618 R15: 00007f9dcc5df788
> ==================================================================


Similar on address 0x2d302e31312e35c7, looks like uninit.

==================================================================
BUG: KASAN: wild-memory-access in atomic_inc
include/asm-generic/atomic-instrumented.h:87 [inline] at addr
2d302e31312e35c7
BUG: KASAN: wild-memory-access in __lock_acquire+0x21a/0x3a80
kernel/locking/lockdep.c:3239 at addr 2d302e31312e35c7
Write of size 4 by task syz-executor1/9446
CPU: 1 PID: 9446 Comm: syz-executor1 Not tainted 4.11.0-rc3+ #364
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x1b8/0x28d lib/dump_stack.c:52
 kasan_report_error mm/kasan/report.c:291 [inline]
 kasan_report.part.2+0x34a/0x480 mm/kasan/report.c:316
 kasan_report+0x21/0x30 mm/kasan/report.c:303
 check_memory_region_inline mm/kasan/kasan.c:326 [inline]
 check_memory_region+0x137/0x190 mm/kasan/kasan.c:333
 kasan_check_write+0x14/0x20 mm/kasan/kasan.c:344
 atomic_inc include/asm-generic/atomic-instrumented.h:87 [inline]
 __lock_acquire+0x21a/0x3a80 kernel/locking/lockdep.c:3239
 lock_acquire+0x1ee/0x590 kernel/locking/lockdep.c:3762
 __raw_write_lock include/linux/rwlock_api_smp.h:210 [inline]
 _raw_write_lock+0x33/0x50 kernel/locking/spinlock.c:295
 mpol_free_shared_policy+0x43/0xb0 mm/mempolicy.c:2536
 hugetlbfs_destroy_inode+0xca/0x120 fs/hugetlbfs/inode.c:952
 alloc_inode+0x10d/0x180 fs/inode.c:216
 new_inode_pseudo+0x69/0x190 fs/inode.c:889
 new_inode+0x1c/0x40 fs/inode.c:918
 hugetlbfs_get_inode+0x40/0x420 fs/hugetlbfs/inode.c:734
 hugetlb_file_setup+0x329/0x9f0 fs/hugetlbfs/inode.c:1282
 newseg+0x422/0xd30 ipc/shm.c:575
 ipcget_new ipc/util.c:285 [inline]
 ipcget+0x21e/0x580 ipc/util.c:639
 SYSC_shmget ipc/shm.c:673 [inline]
 SyS_shmget+0x158/0x230 ipc/shm.c:657
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x445b79
RSP: 002b:00007fc865dbe858 EFLAGS: 00000282 ORIG_RAX: 000000000000001d
RAX: ffffffffffffffda RBX: 0000000000708000 RCX: 0000000000445b79
RDX: 0000000000000800 RSI: 0000000000003000 RDI: 0000000000000000
RBP: 0000000000000086 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020002000 R11: 0000000000000282 R12: 00000000004a7e31
R13: 0000000000000000 R14: 00007fc865dbe618 R15: 00007fc865dbe788
==================================================================
