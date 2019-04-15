Return-Path: <SRS0=LFc9=SR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CDCC10F0E
	for <selinux@archiver.kernel.org>; Mon, 15 Apr 2019 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C80220684
	for <selinux@archiver.kernel.org>; Mon, 15 Apr 2019 13:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfDONni (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfDONni (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 15 Apr 2019 09:43:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DB1DF74D8;
        Mon, 15 Apr 2019 13:43:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id C04AB5C223;
        Mon, 15 Apr 2019 13:43:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 Apr 2019 15:43:37 +0200 (CEST)
Date:   Mon, 15 Apr 2019 15:43:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>, neilb@suse.com,
        Anna.Schumaker@Netapp.com, keescook@chromium.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        viro@zeniv.linux.org.uk,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>, yanaijie@huawei.com,
        peterz@infradead.org, mingo@redhat.com,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org
Subject: Re: kernel BUG at kernel/cred.c:434!
Message-ID: <20190415134331.GC22204@redhat.com>
References: <6e4428ca-3da1-a033-08f7-a51e57503989@huawei.com>
 <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 15 Apr 2019 13:43:37 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Well, acct("/proc/self/attr/current") doesn't look like a good idea, but I do
not know where should we put the additional check... And probably
"echo /proc/self/attr/current > /proc/sys/kernel/core_pattern" can hit the
same problem, do_coredump() does override_creds() too.

May be just add

	if (current->cred != current->real_cred)
		return -EACCES;

into proc_pid_attr_write(), I dunno.



On 04/12, Casey Schaufler wrote:
>
> On 4/11/2019 11:21 PM, chengjian (D) wrote:
> 
> Added LSM and SELinux lists.
> 
> 
> >Hi.
> >
> >
> >syzkaller reported the following BUG:
> >
> >[   73.146973] kernel BUG at kernel/cred.c:434!
> >[   73.150231] invalid opcode: 0000 [#1] SMP KASAN PTI
> >[   73.151928] CPU: 2 PID: 4058 Comm: syz-executor.6 Not tainted
> >5.1.0-rc4-00062-g2d06b235815e-dirty #2
> >[   73.155174] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> >[   73.159798] RIP: 0010:commit_creds+0xadb/0xe50
> >[   73.161426] Code: 8b 5b 20 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f
> >8e 06 03 00 00 39 5d 20 0f 85 ff fa ff ff e9 0c fb ff ff e8 05 a2 25 00
> ><0f> 0b 48 c7 c7 80 56 c0 83 e8 95 22 b1 00 e8 f2 a1 25 00 0f 0b 48
> >[   73.167852] RSP: 0000:ffff88836e65f5d0 EFLAGS: 00010293
> >[   73.169636] RAX: ffff8883767b0000 RBX: ffff88837f111300 RCX:
> >ffffffff8124b5db
> >[   73.171962] RDX: 0000000000000000 RSI: ffffffff83c9b140 RDI:
> >ffff88837f111300
> >[   73.174310] RBP: ffff888376610400 R08: 0000000000000000 R09:
> >0000000000000004
> >[   73.176646] R10: 0000000000000001 R11: ffffed107c655acf R12:
> >ffff8883767b0000
> >[   73.178527] Process accounting resumed
> >[   73.179021] R13: ffff88837f111900 R14: ffff88837f111300 R15:
> >ffff8883767b0ac0
> >[   73.179029] FS:  00007f2d207f9700(0000) GS:ffff8883e3280000(0000)
> >knlGS:0000000000000000
> >[   73.179034] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >[   73.179039] CR2: 00007f1500bd36c0 CR3: 00000003df304003 CR4:
> >00000000000206e0
> >[   73.179047] Call Trace:
> >[   73.190461]  selinux_setprocattr+0x2ea/0x8f0
> >[   73.191925]  ? ptrace_parent_sid+0x530/0x530
> >[   73.193436]  ? proc_pid_attr_write+0x185/0x5a0
> >[   73.194967]  security_setprocattr+0xa1/0x100
> >[   73.196408]  proc_pid_attr_write+0x307/0x5a0
> >[   73.197869]  ? mem_read+0x40/0x40
> >[   73.199013]  __vfs_write+0x81/0x100
> >[   73.200222]  __kernel_write+0xf8/0x330
> >[   73.201562]  do_acct_process+0xca5/0x1340
> >[   73.202969]  ? __ia32_sys_acct+0x1e0/0x1e0
> >[   73.204498]  ? find_held_lock+0x2f/0x1e0
> >[   73.205857]  ? rcu_irq_exit+0xec/0x2c0
> >[   73.207160]  ? lock_downgrade+0x630/0x630
> >[   73.208541]  acct_pin_kill+0x63/0x150
> >[   73.209816]  pin_kill+0x16d/0x7c0
> >[   73.210934]  ? lockdep_hardirqs_on+0x5e0/0x5e0
> >[   73.212452]  ? xas_start+0x155/0x510
> >[   73.213705]  ? pin_insert+0x50/0x50
> >[   73.214903]  ? finish_wait+0x270/0x270
> >[   73.216213]  ? cpumask_next+0x57/0x90
> >[   73.217442]  ? mnt_pin_kill+0x68/0x1d0
> >[   73.218851]  mnt_pin_kill+0x68/0x1d0
> >[   73.220398]  cleanup_mnt+0x11b/0x150
> >[   73.221970]  task_work_run+0x136/0x1b0
> >[   73.223427]  do_exit+0x830/0x2ca0
> >[   73.224586]  ? trace_hardirqs_off+0x3b/0x180
> >[   73.226088]  ? mm_update_next_owner+0x6a0/0x6a0
> >[   73.227622]  ? find_held_lock+0x2f/0x1e0
> >[   73.228954]  ? get_signal+0x2cf/0x1c00
> >[   73.230236]  ? lock_downgrade+0x630/0x630
> >[   73.231628]  ? rwlock_bug.part.0+0x90/0x90
> >[   73.233020]  do_group_exit+0x106/0x2f0
> >[   73.234330]  get_signal+0x325/0x1c00
> >[   73.235571]  do_signal+0x97/0x1670
> >[   73.236739]  ? do_send_specific+0x12d/0x220
> >[   73.238213]  ? lock_downgrade+0x630/0x630
> >[   73.239566]  ? setup_sigcontext+0x820/0x820
> >[   73.240982]  ? check_kill_permission+0x4a/0x510
> >[   73.242509]  ? do_send_specific+0x156/0x220
> >[   73.243905]  ? do_tkill+0x1c4/0x260
> >[   73.245081]  ? do_send_specific+0x220/0x220
> >[   73.246514]  ? trace_hardirqs_on_thunk+0x1a/0x1c
> >[   73.248061]  ? exit_to_usermode_loop+0x97/0x1d0
> >[   73.249619]  exit_to_usermode_loop+0x108/0x1d0
> >[   73.251129]  do_syscall_64+0x461/0x580
> >[   73.252454]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >[   73.254219] RIP: 0033:0x462eb9
> >[   73.255327] Code: Bad RIP value.
> >[   73.256539] RSP: 002b:00007f2d207f8c58 EFLAGS: 00000246 ORIG_RAX:
> >00000000000000c8
> >[   73.259454] RAX: 0000000000000000 RBX: 000000000073bf00 RCX:
> >0000000000462eb9
> >[   73.262309] RDX: 0000000000000000 RSI: 000000000000001e RDI:
> >0000000000000005
> >[   73.265064] RBP: 0000000000000002 R08: 0000000000000000 R09:
> >0000000000000000
> >[   73.267774] R10: 0000000000000000 R11: 0000000000000246 R12:
> >00007f2d207f96bc
> >[   73.270546] R13: 00000000004c5509 R14: 00000000007042f0 R15:
> >00000000ffffffff
> >[   73.273542] Modules linked in:
> >[   73.274670] Dumping ftrace buffer:
> >[   73.275852]    (ftrace buffer empty)
> >[   73.277187] ---[ end trace dde36a95f458175d ]---
> >[   73.278834] RIP: 0010:commit_creds+0xadb/0xe50
> >[   73.280549] Code: 8b 5b 20 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f
> >8e 06 03 00 00 39 5d 20 0f 85 ff fa ff ff e9 0c fb ff ff e8 05 a2 25 00
> ><0f> 0b 48 c7 c7 80 56 c0 83 e8 95 22 b1 00 e8 f2 a1 25 00 0f 0b 48
> >[   73.287090] RSP: 0000:ffff88836e65f5d0 EFLAGS: 00010293
> >[   73.288917] RAX: ffff8883767b0000 RBX: ffff88837f111300 RCX:
> >ffffffff8124b5db
> >[   73.291390] RDX: 0000000000000000 RSI: ffffffff83c9b140 RDI:
> >ffff88837f111300
> >[   73.293864] RBP: ffff888376610400 R08: 0000000000000000 R09:
> >0000000000000004
> >[   73.296370] R10: 0000000000000001 R11: ffffed107c655acf R12:
> >ffff8883767b0000
> >[   73.299275] R13: ffff88837f111900 R14: ffff88837f111300 R15:
> >ffff8883767b0ac0
> >[   73.301351] Process accounting resumed
> >[   73.301822] FS:  00007f2d207f9700(0000) GS:ffff8883e3280000(0000)
> >knlGS:0000000000000000
> >[   73.301827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >[   73.301832] CR2: 0000000000462e8f CR3: 0000000003a18002 CR4:
> >00000000000206e0
> >[   73.301850] Kernel panic - not syncing: Fatal exception
> >[   73.310719] Process accounting resumed
> >[   73.311515] Process accounting resumed
> >[   73.318916] Dumping ftrace buffer:
> >[   73.318921]    (ftrace buffer empty)
> >[   73.318945] Kernel Offset: disabled
> >[   73.328061] Rebooting in 10 seconds..
> >
> >
> >425 int commit_creds(struct cred *new)
> >426 {
> >427         struct task_struct *task = current;
> >428         const struct cred *old = task->real_cred;
> >429
> >430         kdebug("commit_creds(%p{%d,%d})", new,
> >431                atomic_read(&new->usage),
> >432                read_cred_subscribers(new));
> >433
> >434         BUG_ON(task->cred != old);  // BUG here
> >
> >
> >I find that the call chain which triggered the BUG is :
> >
> >do_exit
> >    |-=> acct_process
> >    |    -=> do_acct_process
> >    |        -=> orig_cred = override_creds(file->f_cred); // cred =
> >ffff8883c1878900/real_cred = ffff8883c1878900
> >    |        -=>  if (file_start_write_trylock(file))
> >{__kernel_write(file, &ac, sizeof(acct_t), &pos);}
> >    |               -=> __kernel_write+0xf8/0x330
> >    |                    -=> __vfs_write+0x81/0x100
> >    |                           -=> proc_pid_attr_write+0x307/0x5a0
> >    |                                -=> security_setprocattr+0xa1/0x100
> >    | -=>selinux_setprocattr+0x2ea/0x8f0
> >    | -=>commit_creds+0xd97/0x1080  // cred = ffff888379a79c00/real_cred =
> >ffff888379a79c00
> >    |       -=> revert_creds(orig_cred);   // cred =
> >ffff8883c1878900/real_cred = ffff888379a79c00
> >    |-=> task_work_run
> >           -=> cleanup_mnt+0x11b/0x150
> >                -=> mnt_pin_kill+0x68/0x1d0
> >                    -=> pin_kill+0x16d/0x7c0
> >                    -=> acct_pin_kill+0x2e/0x100
> >                    -=> do_acct_process+0x1a0/0x1340
> >                          -=> override_creds+0x18a/0x1c0   // cred =
> >ffff8883c1878900/real_cred = ffff888379a79c00
> >                          -=>  if (file_start_write_trylock(file))
> >{__kernel_write(file, &ac, sizeof(acct_t), &pos);}
> >                                    -=>   ......
> >-=>commit_creds+0xd97/0x1080   // new = ffff888379a6bb00, cred =
> >ffff8883c1878900, real_ceed = ffff888379a79c00 BUG here
> >                          -=> revert_creds(orig_cred);
> >
> >
> >Syzkaller Report Testcase:
> >
> >cat crash.log
> >
> >04:05:28 executing program 3:
> >clone(0x24100, 0x0, 0x0, 0x0, 0x0)
> >r0 = gettid()
> >perf_event_open(&(0x7f00000000c0)={0x2, 0x70, 0x4, 0x2, 0x0, 0x0, 0x0,
> >0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
> >0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
> >0x0, 0x0, 0x0, 0x0, @perf_bp={0x0}}, 0x0, 0xffffffffffffffff,
> >0xffffffffffffffff, 0x0)
> >acct(&(0x7f0000000000)='./file0\x00')
> >r1 = openat$smack_thread_current(0xffffffffffffff9c,
> >&(0x7f0000000000)='/proc/thread-self/attr/current\x00', 0x2, 0x0)
> >fcntl$setown(r1, 0x8, r0)
> >rt_tgsigqueueinfo(r0, r0, 0x1e, &(0x7f00000002c0))
> >tkill(r0, 0x1e)
> >
> >
> >Reproduce this BUG:
> >./syz-execprog -executor=./syz-executor -repeat=0 -procs=16 -cover=0
> >./crash.log
> >
> >
> >Can anyone help me ?
> >
> >
> >Thanks,
> >
> >        Cheng Jian.
> >
> >

