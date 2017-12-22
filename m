Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBMGvV19009012
 for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2017 11:57:31 -0500
Received: by mail-qk0-f194.google.com with SMTP id p13so19436799qke.4
 for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2017 08:57:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQCJ9tR08S2f-QKmgnwTbuLfeaTm9wDYdoUdFRzWiamkQ@mail.gmail.com>
References: <94eb2c0d010a8dcf040560c0cdf5@google.com>
 <CAHC9VhT5qK4nUmWo5Pksq0rsxa6Wk7wBEa0Gn41pNx5oS_NDCQ@mail.gmail.com>
 <CACT4Y+ZkrWR9=s9qVUAiF6bEeGgdhLGE_W_wWwX7HsaVo1MLiQ@mail.gmail.com>
 <CAHC9VhTjfaOiGm99w3OQMb5m7_zzZg92C_=vPpDhZ1uJBcRdLw@mail.gmail.com>
 <CACT4Y+bq3DLE1Pv9cP5cM4+m8UO6aovRMbqZ-SdvLv7b=AFmyg@mail.gmail.com>
 <CACT4Y+bxacBxs=5L=V4e_m-N=Wmez=C5w9TLFkSEseZoCDNcnA@mail.gmail.com>
 <CAHC9VhQCJ9tR08S2f-QKmgnwTbuLfeaTm9wDYdoUdFRzWiamkQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 22 Dec 2017 17:55:05 +0100
Message-ID: <CACT4Y+bhoK-y--jiRt55B=hUXThZ_ZfG6ncyHMxeB0K5XD122g@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: syzbot
 <bot+904436b33e141b4f4c57c1ddc94199ffd2e34b9d@syzkaller.appspotmail.com>,
 elfring@users.sourceforge.net, Eric Paris <eparis@parisplace.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 serge@hallyn.com, syzkaller-bugs@googlegroups.com,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: BUG: unable to handle kernel NULL pointer dereference
 in sidtab_search_core
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 22, 2017 at 5:05 PM, Paul Moore <paul@paul-moore.com> wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzkaller hit the following crash on
>>>>>>> 6084b576dca2e898f5c101baef151f7bfdbb606d
>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
>>>>>>> compiler: gcc (GCC) 7.1.1 20170620
>>>>>>> .config is attached
>>>>>>> Raw console output is attached.
>>>>>>> C reproducer is attached
>>>>>>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>>>>>>> for information about syzkaller reproducers
>>>>>>>
>>>>>>>
>>>>>>> SELinux: security_compute_sid:  unrecognized SID 1
>>>>>>> SELinux: security_compute_sid:  unrecognized SID 1
>>>>>>> SELinux: security_compute_sid:  unrecognized SID 1
>>>>>>> SELinux: security_compute_sid:  unrecognized SID 1
>>>>>>> SELinux: security_compute_sid:  unrecognized SID 1
>>>>>>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
>>>>>>> IP: sidtab_search_core+0x88/0x110 security/selinux/ss/sidtab.c:100
>>>>>>> PGD 0 P4D 0
>>>>>>> Oops: 0000 [#1] SMP
>>>>>>> Dumping ftrace buffer:
>>>>>>>    (ftrace buffer empty)
>>>>>>> Modules linked in:
>>>>>>> CPU: 1 PID: 4252 Comm: kworker/u4:1 Not tainted 4.15.0-rc3-next-20171214+
>>>>>>> #67
>>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>>>>>> Google 01/01/2011
>>>>>>> RIP: 0010:sidtab_search_core+0x88/0x110 security/selinux/ss/sidtab.c:100
>>>>>>> RSP: 0018:ffffc900028abc18 EFLAGS: 00010293
>>>>>>> RAX: ffff8802131a87c0 RBX: 0000000000000001 RCX: ffffffff8165d978
>>>>>>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff83fd17a0
>>>>>>> RBP: ffffc900028abc40 R08: 0000000000000001 R09: 0000000000000001
>>>>>>> R10: ffffc900028abbe0 R11: 0000000000000000 R12: 0000000000000001
>>>>>>> R13: 0000000000000001 R14: 0000000000000000 R15: ffff880214d93800
>>>>>>> FS:  0000000000000000(0000) GS:ffff88021fd00000(0000) knlGS:0000000000000000
>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> CR2: 0000000000000001 CR3: 0000000214e31000 CR4: 00000000001406e0
>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>> Call Trace:
>>>>>>>  sidtab_search+0x1f/0x30 security/selinux/ss/sidtab.c:111
>>>>>>>  security_compute_sid.part.11+0xe2/0x710 security/selinux/ss/services.c:1618
>>>>>>>  security_compute_sid+0x92/0xa0 security/selinux/ss/services.c:1598
>>>>>>>  security_transition_sid+0x57/0x70 security/selinux/ss/services.c:1764
>>>>>>>  selinux_bprm_set_creds+0x215/0x2f0 security/selinux/hooks.c:2423
>>>>>>>  security_bprm_set_creds+0x41/0x60 security/security.c:332
>>>>>>>  prepare_binprm+0xae/0x1f0 fs/exec.c:1561
>>>>>>>  do_execveat_common.isra.30+0x6f7/0xb90 fs/exec.c:1784
>>>>>>>  do_execve+0x31/0x40 fs/exec.c:1848
>>>>>>>  call_usermodehelper_exec_async+0x104/0x190 kernel/umh.c:100
>>>>>>>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
>>>>>>> Code: 8b 5b 50 48 85 db 75 e5 e8 e6 c9 c5 ff 49 8b 5f 18 48 85 db 75 10 eb
>>>>>>> 43 e8 d6 c9 c5 ff 48 8b 5b 50 48 85 db 74 35 e8 c8 c9 c5 ff <44> 8b 23 41 83
>>>>>>> fc 02 76 e4 e8 ba c9 c5 ff 41 83 fc 03 75 1c 48
>>>>>>> RIP: sidtab_search_core+0x88/0x110 security/selinux/ss/sidtab.c:100 RSP:
>>>>>>> ffffc900028abc18
>>>>>>> CR2: 0000000000000001
>>>>>>> ---[ end trace 571c0ea6c6959387 ]---
>>>>>>> Kernel panic - not syncing: Fatal exception
>>>>>>> Dumping ftrace buffer:
>>>>>>>    (ftrace buffer empty)
>>>>>>> Kernel Offset: disabled
>>>>>>> Rebooting in 86400 seconds..
>>>>>>
>>>>>> Based on the reproducer and the stack trace, I'm guessing the system
>>>>>> is attempting to load a kernel module for a a defined, but unloaded,
>>>>>> protocol.  Looking quickly at the SELinux bprm and sidtab code,
>>>>>> nothing obvious is jumping out at me.  Considering the number of false
>>>>>> positives I've been seeing from syzbot lately, I'm assuming this is
>>>>>> more of the same.
>>>>>
>>>>> Hi Paul,
>>>>>
>>>>> What are these false positives? Please elaborate.
>>>>> There is no single false positive that I am aware of. All the ones
>>>>> that were debugged are real kernel bugs.
>>>>
>>>> I've replied to several of the syzbot automated reports with the
>>>> "invalid" response.  I haven't been keeping track, but it seems like
>>>> approximately 50% of the SELinux related reports don't make sense upon
>>>> inspection.
>>>
>>>
>>> Can you please point me to some of these bugs? I don't see anything
>>> like this in my inbox, in google group nor in database.
>>
>> Btw, this one I was able to reproduce with the syzbot provided
>> reproducer in a second.
>> It maybe doesn't make sense, but it's true.
>
> FWIW, I ran the supplied reproducer for a few minutes yesterday and
> didn't see a problem.  Your test kernels are based on linux-next, yes?


syzbot tests multiple trees. It provides exact git repo and branch and
config where it triggered the crash.
That commit should be available in
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git



>> [ 1768.418388] ==================================================================
>> [ 1768.420222] kasan: CONFIG_KASAN_INLINE enabled
>> [ 1768.420254] kasan: GPF could be caused by NULL-ptr deref or user
>> memory access
>> [ 1768.420283] general protection fault: 0000 [#1] SMP KASAN
>> [ 1768.420290] Modules linked in:
>> [ 1768.420309] CPU: 2 PID: 1705 Comm: kworker/u8:6 Not tainted 4.15.0-rc4+ #2
>> [ 1768.420313] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS Bochs 01/01/2011
>> [ 1768.420363] RIP: 0010:sidtab_search_core+0x96/0x320
>> [ 1768.420368] RSP: 0018:ffff8800644df6d8 EFLAGS: 00010a02
>> [ 1768.420380] RAX: dffffc0000000000 RBX: c4c001a5000006a8 RCX: ffffffff82207e95
>> [ 1768.420385] RDX: 18980034a00000d5 RSI: 0000000000000005 RDI: ffffffff874c29a0
>> [ 1768.420391] RBP: ffff8800644df708 R08: 1ffff1000c89be25 R09: 0000000000000006
>> [ 1768.420395] R10: ffff8800644df5f0 R11: 0000000000000000 R12: 0000000000000005
>> [ 1768.420400] R13: 0000000000000005 R14: ffff880065e4db40 R15: ffff8800644df8a8
>> [ 1768.420407] FS:  0000000000000000(0000) GS:ffff88006cd00000(0000)
>> knlGS:0000000000000000
>> [ 1768.420413] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1768.420418] CR2: 0000000020269000 CR3: 0000000005e22003 CR4: 00000000001606e0
>> [ 1768.420425] Call Trace:
>> [ 1768.420443]  sidtab_search+0x1f/0x30
>> [ 1768.420454]  security_compute_sid+0x31b/0x18f0
>> [ 1768.420473]  ? security_context_to_sid_core+0x620/0x620
>> [ 1768.420489]  ? __lock_is_held+0xb6/0x140
>> [ 1768.420534]  ? ret_from_fork+0x24/0x30
>> [ 1768.420552]  security_transition_sid+0x75/0x90
>> [ 1768.420567]  selinux_bprm_set_creds+0x779/0xc20
>> [ 1768.420582]  ? selinux_setprocattr+0xb50/0xb50
>> [ 1768.420603]  ? debug_lockdep_rcu_enabled+0x77/0x90
>> [ 1768.420617]  security_bprm_set_creds+0x6d/0xa0
>> [ 1768.420635]  prepare_binprm+0x390/0x9f0
>> [ 1768.420648]  ? install_exec_creds+0x170/0x170
>> [ 1768.420657]  ? cpu_weight_nice_write_s64+0xd/0x80
>> [ 1768.420672]  ? __might_fault+0x8e/0x1d0
>> [ 1768.420684]  ? get_user_arg_ptr.isra.17+0x47/0xa0
>> [ 1768.420711]  ? count.isra.19.constprop.32+0xbe/0x120
>> [ 1768.420725]  do_execveat_common.isra.30+0x14b5/0x23c0
>> [ 1768.420733]  ? save_stack+0xa3/0xd0
>> [ 1768.420747]  ? path_openat+0x3510/0x3530
>> [ 1768.420756]  ? ptregs_sys_rt_sigreturn+0x10/0x10
>> [ 1768.420767]  ? prepare_bprm_creds+0x110/0x110
>> [ 1768.420776]  ? check_noncircular+0x20/0x20
>> [ 1768.420789]  ? find_held_lock+0x35/0x1d0
>> [ 1768.420821]  ? trace_event_raw_event_sched_switch+0x800/0x800
>> [ 1768.420831]  ? rcu_pm_notify+0xc0/0xc0
>> [ 1768.420843]  ? getname_kernel+0x54/0x340
>> [ 1768.420859]  ? rcu_read_lock_sched_held+0x108/0x120
>> [ 1768.420871]  ? kmem_cache_alloc+0x466/0x760
>> [ 1768.420881]  ? do_raw_spin_trylock+0x190/0x190
>> [ 1768.420892]  ? get_task_cred+0x3b0/0x3b0
>> [ 1768.420905]  do_execve+0x31/0x40
>> [ 1768.420918]  call_usermodehelper_exec_async+0x457/0x8f0
>> [ 1768.420926]  ? finish_task_switch+0x1d3/0x740
>> [ 1768.420932]  ? finish_task_switch+0x1aa/0x740
>> [ 1768.420941]  ? umh_complete+0x90/0x90
>> [ 1768.420952]  ? copy_overflow+0x20/0x20
>> [ 1768.420966]  ? umh_complete+0x90/0x90
>> [ 1768.420975]  ? umh_complete+0x90/0x90
>> [ 1768.420986]  ret_from_fork+0x24/0x30
>> [ 1768.421011] Code: 3c 02 00 0f 85 41 02 00 00 48 8b 1b 48 85 db 0f
>> 84 8b 00 00 00 e8 bb 6a 4f ff 48 89 da 48 b8 00 00 00 00 00 fc ff df
>> 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e f4 01 00 00 44 8b 3b
>> 45 39
>> [ 1768.421166] RIP: sidtab_search_core+0x96/0x320 RSP: ffff8800644df6d8
>> [ 1768.421279] ---[ end trace bfed1c399df72093 ]---
>> [ 1768.421285] Kernel panic - not syncing: Fatal exception
>> [ 1768.486255] BUG: KASAN: use-after-free in sidtab_search_core+0x2bd/0x320
>> [ 1768.487474] Read of size 8 at addr ffff880065e4db48 by task id/1702
>> [ 1768.488619]
>> [ 1768.488914] CPU: 1 PID: 1702 Comm: id Tainted: G      D
>> 4.15.0-rc4+ #2
>> [ 1768.490264] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS Bochs 01/01/2011
>> [ 1768.491718] Call Trace:
>> [ 1768.492193]  dump_stack+0x194/0x257
>> [ 1768.492849]  ? arch_local_irq_restore+0x53/0x53
>> [ 1768.493709]  ? show_regs_print_info+0x18/0x18
>> [ 1768.494431]  ? lock_acquire+0x1d5/0x580
>> [ 1768.495079]  ? sidtab_search_core+0x2bd/0x320
>> [ 1768.495894]  print_address_description+0x73/0x250
>> [ 1768.496707]  ? sidtab_search_core+0x2bd/0x320
>> [ 1768.497481]  kasan_report+0x25b/0x340
>> [ 1768.498136]  __asan_report_load8_noabort+0x14/0x20
>> [ 1768.498962]  sidtab_search_core+0x2bd/0x320
>> [ 1768.499702]  sidtab_search+0x1f/0x30
>> [ 1768.500344]  security_sid_mls_copy+0x1cf/0xa30
>> [ 1768.501123]  ? security_get_bool_value+0xb0/0xb0
>> [ 1768.501934]  ? avc_has_perm+0x43e/0x680
>> [ 1768.502602]  ? avc_has_perm_noaudit+0x520/0x520
>> [ 1768.503385]  ? lock_release+0xa40/0xa40
>> [ 1768.504052]  ? lock_downgrade+0x980/0x980
>> [ 1768.504751]  ? do_raw_spin_unlock+0x1ec/0x300
>> [ 1768.505625]  ? mnt_get_count+0x150/0x150
>> [ 1768.506298]  ? dput.part.23+0x207/0x830
>> [ 1768.506938]  selinux_socket_unix_stream_connect+0x364/0x590
>> [ 1768.507853]  ? lock_acquire+0x1d5/0x580
>> [ 1768.508495]  ? lock_acquire+0x1d5/0x580
>> [ 1768.509138]  ? selinux_inet_conn_request+0x390/0x390
>> [ 1768.509972]  ? lock_release+0xa40/0xa40
>> [ 1768.510634]  ? unix_bind+0xf90/0xf90
>> [ 1768.511246]  security_unix_stream_connect+0x7d/0xb0
>> [ 1768.512066]  unix_stream_connect+0x8bc/0x1580
>> [ 1768.512824]  ? unix_release+0x90/0x90
>> [ 1768.513446]  ? __might_sleep+0x95/0x190
>> [ 1768.514101]  ? security_socket_connect+0x89/0xb0
>> [ 1768.514880]  SYSC_connect+0x213/0x4a0
>> [ 1768.515589]  ? SYSC_bind+0x410/0x410
>> [ 1768.516193]  ? get_unused_fd_flags+0x121/0x190
>> [ 1768.516944]  ? entry_SYSCALL_64_fastpath+0x5/0x96
>> [ 1768.517736]  ? trace_hardirqs_on_caller+0x421/0x5c0
>> [ 1768.518531]  SyS_connect+0x24/0x30
>> [ 1768.519081]  entry_SYSCALL_64_fastpath+0x1f/0x96
>> [ 1768.519820] RIP: 0033:0x7f0bbb592fd0
>> [ 1768.520392] RSP: 002b:00007ffe7688aed8 EFLAGS: 00000246 ORIG_RAX:
>> 000000000000002a
>> [ 1768.521574] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0bbb592fd0
>> [ 1768.522678] RDX: 000000000000006e RSI: 00007ffe7688aee0 RDI: 0000000000000003
>> [ 1768.523788] RBP: 0000000000608260 R08: 0000000000000004 R09: 000000000064d010
>> [ 1768.524896] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>> [ 1768.526080] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
>> [ 1768.527182]
>> [ 1768.527439] Allocated by task 1:
>> [ 1768.527961]  save_stack+0x43/0xd0
>> [ 1768.528492]  kasan_kmalloc+0xad/0xe0
>> [ 1768.529061]  kmem_cache_alloc_trace+0x136/0x750
>> [ 1768.529791]  sidtab_init+0x4b/0x1c0
>> [ 1768.530346]  policydb_load_isids+0x20/0x220
>> [ 1768.531043]  security_load_policy+0x5c1/0x1260
>> [ 1768.531790]  sel_write_load+0x241/0x1910
>> [ 1768.532447]  __vfs_write+0xef/0x970
>> [ 1768.533035]  vfs_write+0x189/0x510
>> [ 1768.533613]  SyS_write+0xef/0x220
>> [ 1768.534167]  entry_SYSCALL_64_fastpath+0x1f/0x96
>> [ 1768.534891]
>> [ 1768.535141] Freed by task 0:
>> [ 1768.535695] (stack is not available)
>> [ 1768.536266]
>> [ 1768.536521] The buggy address belongs to the object at ffff880065e4db40
>> [ 1768.536521]  which belongs to the cache kmalloc-1024 of size 1024
>> [ 1768.538504] The buggy address is located 8 bytes inside of
>> [ 1768.538504]  1024-byte region [ffff880065e4db40, ffff880065e4df40)
>> [ 1768.540296] The buggy address belongs to the page:
>> [ 1768.541057] page:00000000221ddb34 count:1 mapcount:0
>> mapping:00000000c8b57d81 index:0x0 compound_mapcount: 0
>> [ 1768.542565] flags: 0x1fffc0000008100(slab|head)
>> [ 1768.543261] raw: 01fffc0000008100 ffff880065e4c040 0000000000000000
>> 0000000100000007
>> [ 1768.544419] raw: ffffea0001b0fba0 ffffea0001aa1920 ffff88006c800ac0
>> 0000000000000000
>> [ 1768.545595] page dumped because: kasan: bad access detected
>> [ 1768.546497]
>> [ 1768.546741] Memory state around the buggy address:
>> [ 1768.547469]  ffff880065e4da00: fb fb fb fb fb fb fb fb fb fb fb fb
>> fb fb fb fb
>> [ 1768.548554]  ffff880065e4da80: fb fb fb fb fb fb fb fb fb fb fb fb
>> fb fb fb fb
>> [ 1768.549679] >ffff880065e4db00: fb fb fb fb fb fb fb fb fb fb fb fb
>> 00 00 00 00
>> [ 1768.550737]                                               ^
>> [ 1768.551565]  ffff880065e4db80: 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00
>> [ 1768.552627]  ffff880065e4dc00: 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00
>> [ 1768.553694] ==================================================================
>> [ 1768.554780] Kernel Offset: disabled
>> [ 1768.555312] Rebooting in 86400 seconds..
>
>
>
> --
> paul moore
> www.paul-moore.com
