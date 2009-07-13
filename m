Date: Mon, 13 Jul 2009 10:55:35 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Thomas Liu <tliu@redhat.com>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        eparis@parisplace.org
Subject: Re: [PATCH -v2] SELinux: Convert avc_audit to use lsm_audit.h
In-Reply-To: <alpine.LRH.2.00.0907130756300.29074@tundra.namei.org>
Message-ID: <alpine.LRH.2.00.0907131054210.29941@tundra.namei.org>
References: <1247171811.2276.13.camel@Ares>  <1247172234.2927.4.camel@dhcp235-23.rdu.redhat.com> <1247236264.2226.3.camel@Ares> <alpine.LRH.2.00.0907130756300.29074@tundra.namei.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 13 Jul 2009, James Morris wrote:

> On Fri, 10 Jul 2009, Thomas Liu wrote:
> 
> > Convert avc_audit in security/selinux/avc.c to use lsm_audit.h,
> > for better maintainability and for less code duplication.
> > 
> >  - changed selinux to use common_audit_data instead of
> >    avc_audit_data
> >  - eliminated code in avc.c and used code from lsm_audit.h instead.
> > 
> > I have tested to make sure that the avcs look the same before and
> > after this patch.
> > 
> > Signed-off-by: Thomas Liu <tliu@redhat.com>
> 
> 
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

I've had to revert this; it oopes my system during boot with what looks 
like a stack overflow (see below).


[    0.026792] ACPI: Core revision 20090521
[    0.035699] BUG: unable to handle kernel NULL pointer dereference at 0000000000000060
[    0.035994] IP: [<ffffffff811918f8>] avc_audit+0x8/0x30
[    0.035994] PGD 0 
[    0.035994] Thread overran stack, or stack corrupted
[    0.035994] Oops: 0002 [#1] PREEMPT SMP 
[    0.035994] last sysfs file: 
[    0.035994] CPU 0 
[    0.035994] Modules linked in:
[    0.035994] Pid: 0, comm: swapper Not tainted 2.6.31-rc1 #41 PowerEdge T105 
[    0.035994] RIP: 0010:[<ffffffff811918f8>]  [<ffffffff811918f8>] avc_audit+0x8/0x30
[    0.035994] RSP: 0018:ffffffff81675c38  EFLAGS: 00010292
[    0.035994] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
[    0.035994] RDX: 0000000000000002 RSI: 0000000000000001 RDI: 0000000000000000
[    0.035994] RBP: ffffffff81675c38 R08: ffffffff81675c68 R09: 0000000000000000
[    0.035994] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
[    0.035994] R13: 0000000000000001 R14: ffffffff81675c68 R15: 0000000000000002
[    0.035994] FS:  0000000000000000(0000) GS:ffff880028054000(0000) knlGS:0000000000000000
[    0.035994] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[    0.035994] CR2: 0000000000000060 CR3: 0000000001001000 CR4: 00000000000006f0
[    0.035994] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.035994] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[    0.035994] Process swapper (pid: 0, threadinfo ffffffff81674000, task ffffffff815b8020)
[    0.035994] Stack:
[    0.035994]  ffffffff81675cb8 ffffffff811922b2 0000000000000000 0000000000000000
[    0.035994] <0> ffffffff81675c78 0000000000000000 00000000ffffffff 00000000ffffffff
[    0.035994] <0> ffffffff81675c88 ffffffff8107e61d ffffffff81675cb8 0000000000000001
[    0.035994] Call Trace:
[    0.035994]  [<ffffffff811922b2>] avc_has_perm+0x62/0x80
[    0.035994]  [<ffffffff8107e61d>] ? trace_hardirqs_on+0xd/0x10
[    0.035994]  [<ffffffff81194880>] current_has_perm+0x60/0x70
[    0.035994]  [<ffffffff81194947>] selinux_task_create+0x17/0x20
[    0.035994]  [<ffffffff8118d0b1>] security_task_create+0x11/0x20
[    0.035994]  [<ffffffff8104fdf1>] copy_process+0x71/0x15d0
[    0.035994]  [<ffffffff8107f8db>] ? __lock_acquire+0x3db/0x1af0
[    0.035994]  [<ffffffff810513d2>] do_fork+0x82/0x450
[    0.035994]  [<ffffffff813eb455>] ? _spin_unlock_irqrestore+0x65/0x80
[    0.035994]  [<ffffffff8107e5bd>] ? trace_hardirqs_on_caller+0x15d/0x1b0
[    0.035994]  [<ffffffff81014092>] kernel_thread+0x82/0xe0
[    0.035994]  [<ffffffff8167d5d0>] ? kernel_init+0x0/0x1c3
[    0.035994]  [<ffffffff810140f0>] ? child_rip+0x0/0x20
[    0.035994]  [<ffffffff813d51c7>] ? rest_init+0x17/0x80
[    0.035994]  [<ffffffff8167dd96>] start_kernel+0x3cd/0x3d8
[    0.035994]  [<ffffffff8167d33a>] x86_64_start_reservations+0x125/0x129
[    0.035994]  [<ffffffff8167d436>] x86_64_start_kernel+0xf8/0x107
[    0.035994] Code: 00 00 f6 80 38 e0 ff ff 08 75 07 48 83 c4 08 5b c9 c3 e8 7c 72 25 00 eb f2 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 48 8b 7d 10 <4c> 89 47 60 66 89 57 50 89 4f 54 48 c7 47 70 20 19 19 81 48 c7 
[    0.035994] RIP  [<ffffffff811918f8>] avc_audit+0x8/0x30
[    0.035994]  RSP <ffffffff81675c38>
[    0.035994] CR2: 0000000000000060
[    0.036002] ---[ end trace 4eaa2a86a8e2da22 ]---
[    0.037003] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.038003] Pid: 0, comm: swapper Tainted: G      D    2.6.31-rc1 #41
[    0.039001] Call Trace:
[    0.040004]  [<ffffffff813e7a07>] panic+0x7d/0x139
[    0.041003]  [<ffffffff810565ba>] do_exit+0x76a/0x800
[    0.042003]  [<ffffffff813ecd14>] oops_end+0xa4/0xf0
[    0.043002]  [<ffffffff81035dba>] no_context+0xea/0x260
[    0.044003]  [<ffffffff81036075>] __bad_area_nosemaphore+0x145/0x1f0
[    0.044996]  [<ffffffff8107f8db>] ? __lock_acquire+0x3db/0x1af0
[    0.045996]  [<ffffffff8107f8db>] ? __lock_acquire+0x3db/0x1af0
[    0.047003]  [<ffffffff81101505>] ? kmem_cache_alloc+0xf5/0x1c0
[    0.048002]  [<ffffffff8107e5bd>] ? trace_hardirqs_on_caller+0x15d/0x1b0
[    0.049001]  [<ffffffff813ee861>] ? do_page_fault+0x221/0x3a0
[    0.049996]  [<ffffffff8103612e>] bad_area_nosemaphore+0xe/0x10
[    0.050995]  [<ffffffff813ee927>] do_page_fault+0x2e7/0x3a0
[    0.052002]  [<ffffffff813ebef5>] page_fault+0x25/0x30
[    0.052995]  [<ffffffff811918f8>] ? avc_audit+0x8/0x30
[    0.053995]  [<ffffffff811922b2>] avc_has_perm+0x62/0x80
[    0.054995]  [<ffffffff8107e61d>] ? trace_hardirqs_on+0xd/0x10
[    0.056001]  [<ffffffff81194880>] current_has_perm+0x60/0x70
[    0.056995]  [<ffffffff81194947>] selinux_task_create+0x17/0x20
[    0.057994]  [<ffffffff8118d0b1>] security_task_create+0x11/0x20
[    0.058994]  [<ffffffff8104fdf1>] copy_process+0x71/0x15d0
[    0.060000]  [<ffffffff8107f8db>] ? __lock_acquire+0x3db/0x1af0
[    0.060994]  [<ffffffff810513d2>] do_fork+0x82/0x450
[    0.061994]  [<ffffffff813eb455>] ? _spin_unlock_irqrestore+0x65/0x80
[    0.062994]  [<ffffffff8107e5bd>] ? trace_hardirqs_on_caller+0x15d/0x1b0
[    0.064000]  [<ffffffff81014092>] kernel_thread+0x82/0xe0
[    0.064994]  [<ffffffff8167d5d0>] ? kernel_init+0x0/0x1c3
[    0.065993]  [<ffffffff810140f0>] ? child_rip+0x0/0x20
[    0.066997]  [<ffffffff813d51c7>] ? rest_init+0x17/0x80
[    0.067999]  [<ffffffff8167dd96>] start_kernel+0x3cd/0x3d8
[    0.068993]  [<ffffffff8167d33a>] x86_64_start_reservations+0x125/0x129
[    0.069993]  [<ffffffff8167d436>] x86_64_start_kernel+0xf8/0x107
Press any key to enter the menu




-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
