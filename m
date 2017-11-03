Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA395MN6005718
 for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2017 05:05:22 -0400
Received: by mail-io0-f194.google.com with SMTP id 101so4808635ioj.3
 for <selinux@tycho.nsa.gov>; Fri, 03 Nov 2017 02:04:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YtPfJJbCwpCaOSxxmswA53YMHd=LY6VJ9EdULUAgK5EA@mail.gmail.com>
References: <001a11451c6e293aaf055d03a825@google.com>
 <CAHC9VhRY+EL89irk=nbnN_L_5SmNpjhWiDB8YwaTohQbMSKg-w@mail.gmail.com>
 <CACT4Y+YtPfJJbCwpCaOSxxmswA53YMHd=LY6VJ9EdULUAgK5EA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 3 Nov 2017 12:04:31 +0300
Message-ID: <CACT4Y+arSm_8QGcPh=CCEeSPYqHafSUTNdh4cwy9GGW-d9hv9Q@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: syzbot
 <bot+23f79c6532ceddb959aaea30dd5e3c752b93bf21@syzkaller.appspotmail.com>,
 anton@enomsg.org, ccross@android.com, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 serge@hallyn.com, syzkaller-bugs@googlegroups.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: KASAN: use-after-free Read in do_raw_spin_lock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Nov 3, 2017 at 11:59 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Nov 3, 2017 at 2:51 AM, Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Nov 2, 2017 at 1:52 PM, syzbot
>> <bot+23f79c6532ceddb959aaea30dd5e3c752b93bf21@syzkaller.appspotmail.com>
>> wrote:
>>> Hello,
>>>
>>> syzkaller hit the following crash on
>>> ebe6e90ccc6679cb01d2b280e4b61e6092d4bedb
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>>> compiler: gcc (GCC) 7.1.1 20170620
>>> .config is attached
>>> Raw console output is attached.
>>
>> I'm not sure a real person is watching for responses on this, but just
>> in case ... are you able to reproduce this failure at all?
>
> Yes, there are real people watching, at least initially. Long term we
> are aiming at self-service mostly.
> Please refer to the referenced doc (if there is anything unclear, we
> should improve it):
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-reproducer-at-all
>
>
>>  I'm
>> looking over the SELinux superblock code, as well as the corresponding
>> pieces in fs/super.c, and I'm not quite sure how we could get into the
>> situation where superblock's security blob is freed before the last
>> associated inode.
>
> So far we've seen this only once. So this is either caused by a very
> subtle race (e.g. inconsistency windows on 1 instruction), or a
> previously silently corrupted heap (however, in such cases KASAN
> reports frequently obviously inconsistent, e.g. allocation stack
> refers to an unrelated object, this is not the case as far as I see).
> Since this happened only once, this does not harm fuzzer. So if you
> don't see how this could happen in the code, we can leave it aside for
> now, then either we get new similar reports, or can close this later
> as invalid.
>
> Thanks



FWIW, from the log I see that this was this program that triggered the bug:

2017/10/18 09:57:08 executing program 6:
mmap(&(0x7f0000000000/0xf64000)=nil, 0xf64000, 0x1, 0x31,
0xffffffffffffffff, 0x0)
mmap(&(0x7f0000000000/0xfff000)=nil, 0xfff000, 0x3, 0x32,
0xffffffffffffffff, 0x0)
r0 = accept4$ax25(0xffffffffffffff9c, 0x0, &(0x7f0000001000-0x4)=0x0, 0x800)
r1 = accept4$unix(0xffffffffffffffff, &(0x7f0000b8e000)=@file={0x0,
"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"},
&(0x7f0000ec1000)=0x55, 0x80000)
bind$unix(r1, &(0x7f00000fc000-0x8)=@abs={0x1, 0x0, 0x1}, 0x8)
mmap(&(0x7f0000000000/0x210000)=nil, 0x210000, 0x3, 0x32, r0, 0x0)
mmap(&(0x7f0000210000/0x1000)=nil, 0x1000, 0x3, 0x32, 0xffffffffffffffff, 0x0)
r2 = accept(r0, 0x0, &(0x7f0000211000-0x4)=0x0)
setsockopt$inet_sctp6_SCTP_INITMSG(r2, 0x84, 0x2,
&(0x7f00000f0000-0x8)={0x2, 0x80000001, 0x4000000abe5, 0x1}, 0x8)
setsockopt$netrom_NETROM_IDLE(r0, 0x103, 0x7,
&(0x7f00000d2000-0x4)=0x80000001, 0x4)
r3 = socket(0x10, 0x2, 0xc)
mmap(&(0x7f0000210000/0x1000)=nil, 0x1000, 0x3, 0x32, 0xffffffffffffffff, 0x0)
write(r3, &(0x7f00007b4000-0x20)="1f00000000011303f900d4e80788060c41ff200008000280061b0f0e000096fa",
0x20)
setsockopt$llc_int(r3, 0x10c, 0x8000000000006, &(0x7f0000f2d000-0x4)=0x2, 0x4)
r4 = socket$inet6(0xa, 0x1000000000000001, 0x800)
getsockopt$inet_sctp_SCTP_SOCKOPT_CONNECTX3(r3, 0x84, 0x6f,
&(0x7f0000b41000)={0x0, 0x3, &(0x7f0000f7d000-0x54)=[@in6={0xa, 0x0,
0x7fff, @empty={[0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0]}, 0x1000}, @in6={0xa, 0x3, 0x3,
@local={0xfe, 0x80, [0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0], 0x0, 0xaa}, 0x0}, @in6={0xa, 0x2, 0x5, @remote={0xfe, 0x80,
[0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0], 0x0,
0xbb}, 0x81}]}, &(0x7f00005fb000-0x4)=0x10)
getsockopt$inet_sctp6_SCTP_LOCAL_AUTH_CHUNKS(r3, 0x84, 0x1b,
&(0x7f00008d1000-0x1a)={<r5=>0x0, 0x12,
"8572e0f5c102f1d1755e06b25a03953c07d9"}, &(0x7f000017e000)=0x1a)
getsockopt$inet_sctp6_SCTP_PRIMARY_ADDR(r2, 0x84, 0x6,
&(0x7f0000699000-0x8c)={r5, @in6={{0xa, 0x2, 0x0, @empty={[0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0]}, 0xfffffffffffffffe}, [0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0]}}, &(0x7f0000e4e000)=0x8c)
connect$inet6(r4, &(0x7f0000754000)={0xa, 0x0, 0xfffffffffffffffd,
@remote={0xfe, 0x80, [0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0], 0x0, 0xbb}, 0x9}, 0x1c)
mmap(&(0x7f0000000000/0xfff000)=nil, 0xfff000, 0x3, 0x32,
0xffffffffffffffff, 0x0)
clock_gettime(0x0, &(0x7f000092c000-0x10)={0x0, 0x0})
futex(&(0x7f000000d000-0x4)=0x0, 0x0, 0x4,
&(0x7f000000b000)={0x77359400, 0x0}, &(0x7f0000cef000)=0x0, 0x0)
sendmmsg$unix(0xffffffffffffffff, &(0x7f000039b000)=[], 0x0, 0x0)
mkdir(&(0x7f0000f84000-0x8)="2e2f66696c653000", 0x0)
r6 = openat(0xffffffffffffff9c,
&(0x7f0000956000-0x8)="2e2f66696c653000", 0x408000, 0x40)
open(&(0x7f000038f000)="2e2f66696c653000", 0x400001, 0x20)
ioctl$PIO_FONTRESET(r6, 0x4b6d, 0x0)
unshare(0x20000)
mount(&(0x7f00004a4000-0x8)="2e2f66696c653000",
&(0x7f0000b7c000)="2e2f66696c653000",
&(0x7f00006d6000-0x6)="72616d667300", 0x0, &(0x7f0000691000-0x1)="")
r7 = inotify_init()
inotify_add_watch(r7, &(0x7f0000cc8000-0x8)="2e2f66696c653000", 0x14)


Bot wasn't able to reproduce the crash using this program, but it can
give hints as to what syscalls were executed.
There seems to be few things happened with the mount and
"2e2f66696c653000" path:

mkdir(&(0x7f0000f84000-0x8)="2e2f66696c653000", 0x0)
r6 = openat(0xffffffffffffff9c,
&(0x7f0000956000-0x8)="2e2f66696c653000", 0x408000, 0x40)
open(&(0x7f000038f000)="2e2f66696c653000", 0x400001, 0x20)
mount(&(0x7f00004a4000-0x8)="2e2f66696c653000",
&(0x7f0000b7c000)="2e2f66696c653000",
&(0x7f00006d6000-0x6)="72616d667300", 0x0, &(0x7f0000691000-0x1)="")
r7 = inotify_init()
inotify_add_watch(r7, &(0x7f0000cc8000-0x8)="2e2f66696c653000", 0x14)

But note that syscalls can be executed in parallel.




>>> capability: warning: `syz-executor3' uses 32-bit capabilities (legacy
>>> support in use)
>>> ==================================================================
>>> BUG: KASAN: use-after-free in debug_spin_lock_before
>>> kernel/locking/spinlock_debug.c:83 [inline]
>>> BUG: KASAN: use-after-free in do_raw_spin_lock+0x1aa/0x1e0
>>> kernel/locking/spinlock_debug.c:112
>>> Read of size 4 at addr ffff8801c5b1ddec by task syz-executor6/3887
>>>
>>> CPU: 1 PID: 3887 Comm: syz-executor6 Not tainted 4.14.0-rc5+ #136
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Call Trace:
>>>  __dump_stack lib/dump_stack.c:16 [inline]
>>>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>>>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>>>  kasan_report_error mm/kasan/report.c:351 [inline]
>>>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>>>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:429
>>>  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>>>  do_raw_spin_lock+0x1aa/0x1e0 kernel/locking/spinlock_debug.c:112
>>>  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
>>>  _raw_spin_lock+0x32/0x40 kernel/locking/spinlock.c:151
>>>  spin_lock include/linux/spinlock.h:316 [inline]
>>>  inode_free_security security/selinux/hooks.c:346 [inline]
>>>  selinux_inode_free_security+0x12a/0x410 security/selinux/hooks.c:2873
>>>  security_inode_free+0x50/0x90 security/security.c:442
>>>  __destroy_inode+0x287/0x650 fs/inode.c:236
>>>  destroy_inode+0xe7/0x200 fs/inode.c:263
>>>  evict+0x57e/0x920 fs/inode.c:570
>>>  iput_final fs/inode.c:1515 [inline]
>>>  iput+0x7b9/0xaf0 fs/inode.c:1542
>>>  fsnotify_put_mark+0x4d0/0x730 fs/notify/mark.c:237
>>>  fsnotify_clear_marks_by_group+0x19a/0x5f0 fs/notify/mark.c:691
>>>  fsnotify_destroy_group+0xde/0x3f0 fs/notify/group.c:70
>>>  inotify_release+0x37/0x50 fs/notify/inotify/inotify_user.c:280
>>>  __fput+0x327/0x7e0 fs/file_table.c:210
>>>  ____fput+0x15/0x20 fs/file_table.c:244
>>>  task_work_run+0x199/0x270 kernel/task_work.c:112
>>>  exit_task_work include/linux/task_work.h:21 [inline]
>>>  do_exit+0x9b5/0x1ad0 kernel/exit.c:865
>>>  do_group_exit+0x149/0x400 kernel/exit.c:968
>>>  get_signal+0x73f/0x16d0 kernel/signal.c:2334
>>>  do_signal+0x94/0x1ee0 arch/x86/kernel/signal.c:808
>>>  exit_to_usermode_loop+0x214/0x310 arch/x86/entry/common.c:158
>>>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>>>  syscall_return_slowpath+0x42f/0x510 arch/x86/entry/common.c:266
>>>  entry_SYSCALL_64_fastpath+0xbc/0xbe
>>> RIP: 0033:0x452779
>>> RSP: 002b:00007f6815b25ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
>>> RAX: fffffffffffffe00 RBX: 00000000007581a0 RCX: 0000000000452779
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000007581a0
>>> RBP: 00000000007581a0 R08: 000000000000018e R09: 0000000000758180
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> R13: 0000000000a6f7ff R14: 00007f6815b269c0 R15: 000000000000001e
>>>
>>> Allocated by task 3873:
>>>  save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
>>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>>>  set_track mm/kasan/kasan.c:459 [inline]
>>>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>>>  kmem_cache_alloc_trace+0x136/0x750 mm/slab.c:3627
>>>  kmalloc include/linux/slab.h:493 [inline]
>>>  kzalloc include/linux/slab.h:666 [inline]
>>>  superblock_alloc_security security/selinux/hooks.c:390 [inline]
>>>  selinux_sb_alloc_security+0x93/0x2e0 security/selinux/hooks.c:2630
>>>  security_sb_alloc+0x6d/0xa0 security/security.c:356
>>>  alloc_super fs/super.c:196 [inline]
>>>  sget_userns+0x36a/0xe20 fs/super.c:505
>>>  sget+0xd2/0x120 fs/super.c:557
>>>  mount_nodev+0x37/0x100 fs/super.c:1160
>>>  ramfs_mount+0x2c/0x40 fs/ramfs/inode.c:253
>>>  mount_fs+0x66/0x2d0 fs/super.c:1222
>>>  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
>>>  vfs_kern_mount fs/namespace.c:2509 [inline]
>>>  do_new_mount fs/namespace.c:2512 [inline]
>>>  do_mount+0xea1/0x2bb0 fs/namespace.c:2840
>>>  SYSC_mount fs/namespace.c:3056 [inline]
>>>  SyS_mount+0xab/0x120 fs/namespace.c:3033
>>>  entry_SYSCALL_64_fastpath+0x1f/0xbe
>>>
>>> Freed by task 3873:
>>>  save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
>>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>>>  set_track mm/kasan/kasan.c:459 [inline]
>>>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>>>  __cache_free mm/slab.c:3503 [inline]
>>>  kfree+0xca/0x250 mm/slab.c:3820
>>>  superblock_free_security security/selinux/hooks.c:410 [inline]
>>>  selinux_sb_free_security+0x42/0x50 security/selinux/hooks.c:2635
>>>  security_sb_free+0x48/0x80 security/security.c:361
>>>  destroy_super+0x93/0x200 fs/super.c:167
>>>  __put_super.part.6+0x1a4/0x2a0 fs/super.c:272
>>>  __put_super fs/super.c:270 [inline]
>>>  put_super+0x53/0x70 fs/super.c:286
>>>  deactivate_locked_super+0xb0/0xd0 fs/super.c:319
>>>  deactivate_super+0x141/0x1b0 fs/super.c:339
>>>  cleanup_mnt+0xb2/0x150 fs/namespace.c:1173
>>>  __cleanup_mnt+0x16/0x20 fs/namespace.c:1180
>>>  task_work_run+0x199/0x270 kernel/task_work.c:112
>>>  exit_task_work include/linux/task_work.h:21 [inline]
>>>  do_exit+0x9b5/0x1ad0 kernel/exit.c:865
>>>  do_group_exit+0x149/0x400 kernel/exit.c:968
>>>  get_signal+0x73f/0x16d0 kernel/signal.c:2334
>>>  do_signal+0x94/0x1ee0 arch/x86/kernel/signal.c:808
>>>  exit_to_usermode_loop+0x214/0x310 arch/x86/entry/common.c:158
>>>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>>>  syscall_return_slowpath+0x42f/0x510 arch/x86/entry/common.c:266
>>>  entry_SYSCALL_64_fastpath+0xbc/0xbe
>>>
>>> The buggy address belongs to the object at ffff8801c5b1dd40
>>>  which belongs to the cache kmalloc-256 of size 256
>>> The buggy address is located 172 bytes inside of
>>>  256-byte region [ffff8801c5b1dd40, ffff8801c5b1de40)
>>> The buggy address belongs to the page:
>>> page:ffffea000716c740 count:1 mapcount:0 mapping:ffff8801c5b1d0c0 index:0x0
>>> flags: 0x200000000000100(slab)
>>> raw: 0200000000000100 ffff8801c5b1d0c0 0000000000000000 000000010000000c
>>> raw: ffffea0007155de0 ffffea0007130ae0 ffff8801dac007c0 0000000000000000
>>> page dumped because: kasan: bad access detected
>>>
>>> Memory state around the buggy address:
>>>  ffff8801c5b1dc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>  ffff8801c5b1dd00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>>>>
>>>> ffff8801c5b1dd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>
>>>                                                           ^
>>>  ffff8801c5b1de00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>>  ffff8801c5b1de80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ==================================================================
>>>
>>>
>>> ---
>>> This bug is generated by a dumb bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for details.
>>> Direct all questions to syzkaller@googlegroups.com.
>>> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
>>>
>>> syzbot will keep track of this bug report.
>>> Once a fix for this bug is committed, please reply to this email with:
>>> #syz fix: exact-commit-title
>>> To mark this as a duplicate of another syzbot report, please reply with:
>>> #syz dup: exact-subject-of-another-report
>>> If it's a one-off invalid bug report, please reply with:
>>> #syz invalid
>>> Note: if the crash happens again, it will cause creation of a new bug
>>> report.
>>> Note: all commands must start from beginning of the line.
>>
>>
>>
>> --
>> paul moore
>> www.paul-moore.com
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAHC9VhRY%2BEL89irk%3DnbnN_L_5SmNpjhWiDB8YwaTohQbMSKg-w%40mail.gmail.com.
>> For more options, visit https://groups.google.com/d/optout.
