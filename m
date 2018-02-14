Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1EEU8dj006409
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:30:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3zhMHz40Nvz1x08n
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 14:30:07 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3zhMHz2yJmz1x08m
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 14:30:07 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id b25so3995937pfd.9
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 06:30:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001a1135057ececf4505652ce310@google.com>
References: <001a1135057ececf4505652ce310@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 15:29:42 +0100
Message-ID: <CACT4Y+ZaSXU4247LNqdwu3d62ZH6PAH4Ea1582qQELG5HZm_Zg@mail.gmail.com>
To: syzbot <syzbot+14580019ce01b3f29b74@syzkaller.appspotmail.com>
Cc: anton@enomsg.org, ccross@android.com, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, Kees Cook <keescook@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, serge@hallyn.com,
 syzkaller-bugs@googlegroups.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: KASAN: use-after-free Read in
 selinux_inode_free_security
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 14, 2018 at 3:25 PM, syzbot
<syzbot+14580019ce01b3f29b74@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> b89e32ccd1be92a3643df3908d3026b09e271616 (Fri Feb 2 21:46:21 2018 +0000)
> Merge branch 'for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.


FTR, the previous bug about probably the same root cause:
https://groups.google.com/forum/#!msg/syzkaller-bugs/9JWqz8iHjuk/HLyjL4UAAgAJ



> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+14580019ce01b3f29b74@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> ==================================================================
> BUG: KASAN: use-after-free in list_empty_careful include/linux/list.h:221
> [inline]
> BUG: KASAN: use-after-free in inode_free_security
> security/selinux/hooks.c:346 [inline]
> BUG: KASAN: use-after-free in selinux_inode_free_security+0x3c1/0x410
> security/selinux/hooks.c:2890
> Read of size 8 at addr ffff8801d09b5488 by task syz-executor2/29672
>
> CPU: 0 PID: 29672 Comm: syz-executor2 Not tainted 4.15.0+ #294
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
>  list_empty_careful include/linux/list.h:221 [inline]
>  inode_free_security security/selinux/hooks.c:346 [inline]
>  selinux_inode_free_security+0x3c1/0x410 security/selinux/hooks.c:2890
>  security_inode_free+0x50/0x90 security/security.c:443
>  __destroy_inode+0x287/0x660 fs/inode.c:237
>  destroy_inode+0xe7/0x200 fs/inode.c:264
>  evict+0x57e/0x920 fs/inode.c:571
>  iput_final fs/inode.c:1516 [inline]
>  iput+0x7b9/0xaf0 fs/inode.c:1543
>  dentry_unlink_inode+0x4b0/0x5e0 fs/dcache.c:371
>  d_delete+0x1ca/0x280 fs/dcache.c:2368
>  __debugfs_remove_file fs/debugfs/inode.c:626 [inline]
>  __debugfs_remove.part.10+0x185/0x250 fs/debugfs/inode.c:656
>  __debugfs_remove include/linux/dcache.h:492 [inline]
>  debugfs_remove_recursive+0x22e/0x5e0 fs/debugfs/inode.c:738
>  kvm_destroy_vm_debugfs arch/x86/kvm/../../../virt/kvm/kvm_main.c:562
> [inline]
>  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:716 [inline]
>  kvm_put_kvm+0x1da/0xde0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:756
>  kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:767
>  __fput+0x327/0x7e0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  get_signal+0x73a/0x16d0 kernel/signal.c:2469
>  do_signal+0x90/0x1eb0 arch/x86/kernel/signal.c:809
>  exit_to_usermode_loop+0x258/0x2f0 arch/x86/entry/common.c:161
>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>  syscall_return_slowpath+0x490/0x550 arch/x86/entry/common.c:264
>  entry_SYSCALL_64_fastpath+0x9e/0xa0
> RIP: 0033:0x453299
> RSP: 002b:00007f7f43691ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000071bf80 RCX: 0000000000453299
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000071bf80
> RBP: 000000000071bf80 R08: 000000000000060b R09: 000000000071bf58
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000a2f33f R14: 00007f7f436929c0 R15: 0000000000000002
>
> Allocated by task 29664:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3540
>  kmem_cache_zalloc include/linux/slab.h:678 [inline]
>  inode_alloc_security security/selinux/hooks.c:234 [inline]
>  selinux_inode_alloc_security+0xf9/0x390 security/selinux/hooks.c:2885
>  security_inode_alloc+0x90/0xd0 security/security.c:437
>  inode_init_always+0x653/0xca0 fs/inode.c:168
>  alloc_inode+0x82/0x180 fs/inode.c:216
>  new_inode_pseudo+0x69/0x190 fs/inode.c:891
>  new_inode+0x1c/0x40 fs/inode.c:920
>  debugfs_get_inode+0x1b/0x120 fs/debugfs/inode.c:37
>  __debugfs_create_file+0x98/0x3d0 fs/debugfs/inode.c:355
>  debugfs_create_file+0x57/0x70 fs/debugfs/inode.c:402
>  kvm_create_vm_debugfs arch/x86/kvm/../../../virt/kvm/kvm_main.c:600
> [inline]
>  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3194
> [inline]
>  kvm_dev_ioctl+0xbd4/0x18c0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3217
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x29/0xa0
>
> Freed by task 29664:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3484 [inline]
>  kmem_cache_free+0x83/0x2a0 mm/slab.c:3742
>  inode_free_rcu+0x1d/0x20 security/selinux/hooks.c:328
>  __rcu_reclaim kernel/rcu/rcu.h:172 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2674 [inline]
>  invoke_rcu_callbacks kernel/rcu/tree.c:2933 [inline]
>  __rcu_process_callbacks kernel/rcu/tree.c:2900 [inline]
>  rcu_process_callbacks+0xd6c/0x17f0 kernel/rcu/tree.c:2917
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>
> The buggy address belongs to the object at ffff8801d09b5480
>  which belongs to the cache selinux_inode_security of size 96
> The buggy address is located 8 bytes inside of
>  96-byte region [ffff8801d09b5480, ffff8801d09b54e0)
> The buggy address belongs to the page:
> page:ffffea0007426d40 count:1 mapcount:0 mapping:ffff8801d09b5000
> index:0xffff8801d09b5800
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801d09b5000 ffff8801d09b5800 000000010000001d
> raw: ffffea00070743a0 ffffea0006c5c920 ffff8801da9c1240 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801d09b5380: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
>  ffff8801d09b5400: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>>
>> ffff8801d09b5480: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>
>                       ^
>  ffff8801d09b5500: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff8801d09b5580: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> ==================================================================
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1135057ececf4505652ce310%40google.com.
> For more options, visit https://groups.google.com/d/optout.
