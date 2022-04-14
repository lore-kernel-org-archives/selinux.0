Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C64EC433EF
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 18:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiDNSpy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiDNSpx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 14:45:53 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F9DA6F0
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 11:43:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4F35425FE; Thu, 14 Apr 2022 14:43:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4F35425FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1649961805;
        bh=Z6NNow6xMaSeXZxSaUfukI6KvQtcz2R5nmMCdw2IbFY=;
        h=Date:To:Cc:Subject:From:From;
        b=pHBjwGEOrG7GNG4J1kF6XIRrxkL6PJy2cVpk4KK0aQBoEPv1brSeV+QMAg4ZwZakO
         yT5a4fFqMBphcpOC6zqXd/vbtWZCQjw9kDUO9kvsHpz1zUrIui3J0O3c4SKk4/lJDP
         i2yRXt1vDqUjuf9vtsGALHHNC3t9oTXYhmwGFI2k=
Date:   Thu, 14 Apr 2022 14:43:25 -0400
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: boot failures as of "selinux: checkreqprot is deprecated, add some
 ssleep() discomfort"
Message-ID: <20220414184325.GD21485@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

My Fedora 33 test VMs stopped booting linux-next recently; reverting
81200b0265b1 "selinux: checkreqprot is deprecated, add some ssleep()
discomfort" allows them to boot again.

I'm guessing this warning wasn't intended to be quite *that* dramatic?

--b.

LSM: Security Framework initializing
SELinux:  Initializing.
SELinux: CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE is non-zero.  This is deprecated and will be rejected in a future kernel release.
SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot
BUG: scheduling while atomic: swapper/0/0/0x00000002
no locks held by swapper/0/0.
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 __schedule_bug.cold+0x105/0x117
 __schedule+0x1852/0x2290
 ? __mod_timer+0x5a0/0xa40
 ? io_schedule_timeout+0x150/0x150
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
------------[ cut here ]------------
releasing a pinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5349 lock_release+0x68c/0x760
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_release+0x68c/0x760
Code: 4c 00 e9 20 fa ff ff 4c 89 f7 e8 df 9d 4c 00 e9 6b fc ff ff e8 65 9d 4c 00 e9 2a fc ff ff 48 c7 c7 a0 e1 26 84 e8 6d e0 94 02 <0f> 0b e9 bc fb ff ff 48 c7 c7 6c a0 77 85 e8 41 9d 4c 00 e9 0d fb
RSP: 0000:ffffffff84c07c18 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff84c72dc0 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f79
RBP: 1ffffffff0980f85 R08: 0000000000000000 R09: ffffffff84c078f7
R10: fffffbfff0980f1e R11: 0000000000000001 R12: ffff88806d437998
R13: 0000000000000001 R14: ffffffff84c72db8 R15: ffffffff84c72400
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? dequeue_task_idle+0xe/0x50
 ? lock_downgrade+0x690/0x690
 _raw_spin_unlock+0x17/0x40
 dequeue_task_idle+0xe/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2426
hardirqs last  enabled at (2425): [<ffffffff83c7182d>] dump_stack_lvl+0x54/0x59
hardirqs last disabled at (2426): [<ffffffff83cfd78d>] __schedule+0xf9d/0x2290
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
bad: scheduling from the idle thread!
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 dequeue_task_idle+0x25/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
------------[ cut here ]------------
unpinning an unpinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5477 lock_unpin_lock+0x2e0/0x390
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_unpin_lock+0x2e0/0x390
Code: e6 29 a5 02 65 c7 05 6b 16 d8 7e 00 00 00 00 eb a4 4c 89 e7 e8 21 bb 4d 00 e9 ab fd ff ff 48 c7 c7 80 af 26 84 e8 29 fe 95 02 <0f> 0b e9 66 ff ff ff 48 c7 c7 c0 af 26 84 e8 16 fe 95 02 0f 0b 48
RSP: 0000:ffffffff84c07b00 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff88806d437998 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f56
RBP: ffffffff84c72de4 R08: 0000000000000000 R09: ffffffff84c077df
R10: fffffbfff0980efb R11: 0000000000000001 R12: fffffbfff098e5b7
R13: ffffffff84c72dc0 R14: ffffffff84c72dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? lock_repin_lock+0x310/0x310
 ? lock_is_held_type+0xd7/0x130
 newidle_balance+0x337/0x10a0
 ? lock_acquire+0x1dc/0x540
 ? lock_release+0x760/0x760
 ? load_balance+0x28a0/0x28a0
 ? do_raw_spin_lock+0x11e/0x240
 pick_next_task_fair+0x4d/0xb90
 __schedule+0x3c9/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2438
hardirqs last  enabled at (2437): [<ffffffff83c7182d>] dump_stack_lvl+0x54/0x59
hardirqs last disabled at (2438): [<ffffffff81257ced>] dequeue_task_idle+0x3d/0x50
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
releasing a pinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5349 lock_release+0x68c/0x760
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_release+0x68c/0x760
Code: 4c 00 e9 20 fa ff ff 4c 89 f7 e8 df 9d 4c 00 e9 6b fc ff ff e8 65 9d 4c 00 e9 2a fc ff ff 48 c7 c7 a0 e1 26 84 e8 6d e0 94 02 <0f> 0b e9 bc fb ff ff 48 c7 c7 6c a0 77 85 e8 41 9d 4c 00 e9 0d fb
RSP: 0000:ffffffff84c07c18 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff84c72dc0 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f79
RBP: 1ffffffff0980f85 R08: 0000000000000000 R09: ffffffff84c078f7
R10: fffffbfff0980f1e R11: 0000000000000001 R12: ffff88806d437998
R13: 0000000000000001 R14: ffffffff84c72db8 R15: ffffffff84c72400
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? dequeue_task_idle+0xe/0x50
 ? lock_downgrade+0x690/0x690
 _raw_spin_unlock+0x17/0x40
 dequeue_task_idle+0xe/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2454
hardirqs last  enabled at (2453): [<ffffffff83d13b5d>] _raw_spin_unlock_irqrestore+0x2d/0x50
hardirqs last disabled at (2454): [<ffffffff83cfd78d>] __schedule+0xf9d/0x2290
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
bad: scheduling from the idle thread!
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 dequeue_task_idle+0x25/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
------------[ cut here ]------------
unpinning an unpinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5477 lock_unpin_lock+0x2e0/0x390
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_unpin_lock+0x2e0/0x390
Code: e6 29 a5 02 65 c7 05 6b 16 d8 7e 00 00 00 00 eb a4 4c 89 e7 e8 21 bb 4d 00 e9 ab fd ff ff 48 c7 c7 80 af 26 84 e8 29 fe 95 02 <0f> 0b e9 66 ff ff ff 48 c7 c7 c0 af 26 84 e8 16 fe 95 02 0f 0b 48
RSP: 0000:ffffffff84c07b00 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff88806d437998 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f56
RBP: ffffffff84c72de4 R08: 0000000000000000 R09: ffffffff84c077df
R10: fffffbfff0980efb R11: 0000000000000001 R12: fffffbfff098e5b7
R13: ffffffff84c72dc0 R14: ffffffff84c72dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? lock_repin_lock+0x310/0x310
 ? lock_is_held_type+0xd7/0x130
 newidle_balance+0x337/0x10a0
 ? lock_acquire+0x1dc/0x540
 ? lock_release+0x760/0x760
 ? load_balance+0x28a0/0x28a0
 ? do_raw_spin_lock+0x11e/0x240
 pick_next_task_fair+0x4d/0xb90
 __schedule+0x3c9/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2466
hardirqs last  enabled at (2465): [<ffffffff83c7182d>] dump_stack_lvl+0x54/0x59
hardirqs last disabled at (2466): [<ffffffff81257ced>] dequeue_task_idle+0x3d/0x50
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
releasing a pinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5349 lock_release+0x68c/0x760
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_release+0x68c/0x760
Code: 4c 00 e9 20 fa ff ff 4c 89 f7 e8 df 9d 4c 00 e9 6b fc ff ff e8 65 9d 4c 00 e9 2a fc ff ff 48 c7 c7 a0 e1 26 84 e8 6d e0 94 02 <0f> 0b e9 bc fb ff ff 48 c7 c7 6c a0 77 85 e8 41 9d 4c 00 e9 0d fb
RSP: 0000:ffffffff84c07c18 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff84c72dc0 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f79
RBP: 1ffffffff0980f85 R08: 0000000000000000 R09: ffffffff84c078f7
R10: fffffbfff0980f1e R11: 0000000000000001 R12: ffff88806d437998
R13: 0000000000000001 R14: ffffffff84c72db8 R15: ffffffff84c72400
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? dequeue_task_idle+0xe/0x50
 ? lock_downgrade+0x690/0x690
 _raw_spin_unlock+0x17/0x40
 dequeue_task_idle+0xe/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2482
hardirqs last  enabled at (2481): [<ffffffff83d13b5d>] _raw_spin_unlock_irqrestore+0x2d/0x50
hardirqs last disabled at (2482): [<ffffffff83cfd78d>] __schedule+0xf9d/0x2290
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
bad: scheduling from the idle thread!
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 dequeue_task_idle+0x25/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
------------[ cut here ]------------
unpinning an unpinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5477 lock_unpin_lock+0x2e0/0x390
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_unpin_lock+0x2e0/0x390
Code: e6 29 a5 02 65 c7 05 6b 16 d8 7e 00 00 00 00 eb a4 4c 89 e7 e8 21 bb 4d 00 e9 ab fd ff ff 48 c7 c7 80 af 26 84 e8 29 fe 95 02 <0f> 0b e9 66 ff ff ff 48 c7 c7 c0 af 26 84 e8 16 fe 95 02 0f 0b 48
RSP: 0000:ffffffff84c07b00 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff88806d437998 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f56
RBP: ffffffff84c72de4 R08: 0000000000000000 R09: ffffffff84c077df
R10: fffffbfff0980efb R11: 0000000000000001 R12: fffffbfff098e5b7
R13: ffffffff84c72dc0 R14: ffffffff84c72dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? lock_repin_lock+0x310/0x310
 ? lock_is_held_type+0xd7/0x130
 newidle_balance+0x337/0x10a0
 ? lock_acquire+0x1dc/0x540
 ? lock_release+0x760/0x760
 ? load_balance+0x28a0/0x28a0
 ? do_raw_spin_lock+0x11e/0x240
 pick_next_task_fair+0x4d/0xb90
 __schedule+0x3c9/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2494
hardirqs last  enabled at (2493): [<ffffffff83c7182d>] dump_stack_lvl+0x54/0x59
hardirqs last disabled at (2494): [<ffffffff81257ced>] dequeue_task_idle+0x3d/0x50
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
releasing a pinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5349 lock_release+0x68c/0x760
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_release+0x68c/0x760
Code: 4c 00 e9 20 fa ff ff 4c 89 f7 e8 df 9d 4c 00 e9 6b fc ff ff e8 65 9d 4c 00 e9 2a fc ff ff 48 c7 c7 a0 e1 26 84 e8 6d e0 94 02 <0f> 0b e9 bc fb ff ff 48 c7 c7 6c a0 77 85 e8 41 9d 4c 00 e9 0d fb
RSP: 0000:ffffffff84c07c18 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff84c72dc0 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f79
RBP: 1ffffffff0980f85 R08: 0000000000000000 R09: ffffffff84c078f7
R10: fffffbfff0980f1e R11: 0000000000000001 R12: ffff88806d437998
R13: 0000000000000001 R14: ffffffff84c72db8 R15: ffffffff84c72400
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? dequeue_task_idle+0xe/0x50
 ? lock_downgrade+0x690/0x690
 _raw_spin_unlock+0x17/0x40
 dequeue_task_idle+0xe/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2510
hardirqs last  enabled at (2509): [<ffffffff83d13b5d>] _raw_spin_unlock_irqrestore+0x2d/0x50
hardirqs last disabled at (2510): [<ffffffff83cfd78d>] __schedule+0xf9d/0x2290
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
bad: scheduling from the idle thread!
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 dequeue_task_idle+0x25/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
------------[ cut here ]------------
unpinning an unpinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5477 lock_unpin_lock+0x2e0/0x390
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_unpin_lock+0x2e0/0x390
Code: e6 29 a5 02 65 c7 05 6b 16 d8 7e 00 00 00 00 eb a4 4c 89 e7 e8 21 bb 4d 00 e9 ab fd ff ff 48 c7 c7 80 af 26 84 e8 29 fe 95 02 <0f> 0b e9 66 ff ff ff 48 c7 c7 c0 af 26 84 e8 16 fe 95 02 0f 0b 48
RSP: 0000:ffffffff84c07b00 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff88806d437998 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f56
RBP: ffffffff84c72de4 R08: 0000000000000000 R09: ffffffff84c077df
R10: fffffbfff0980efb R11: 0000000000000001 R12: fffffbfff098e5b7
R13: ffffffff84c72dc0 R14: ffffffff84c72dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? lock_repin_lock+0x310/0x310
 ? lock_is_held_type+0xd7/0x130
 newidle_balance+0x337/0x10a0
 ? lock_acquire+0x1dc/0x540
 ? lock_release+0x760/0x760
 ? load_balance+0x28a0/0x28a0
 ? do_raw_spin_lock+0x11e/0x240
 pick_next_task_fair+0x4d/0xb90
 __schedule+0x3c9/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2522
hardirqs last  enabled at (2521): [<ffffffff83c7182d>] dump_stack_lvl+0x54/0x59
hardirqs last disabled at (2522): [<ffffffff81257ced>] dequeue_task_idle+0x3d/0x50
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
releasing a pinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5349 lock_release+0x68c/0x760
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_release+0x68c/0x760
Code: 4c 00 e9 20 fa ff ff 4c 89 f7 e8 df 9d 4c 00 e9 6b fc ff ff e8 65 9d 4c 00 e9 2a fc ff ff 48 c7 c7 a0 e1 26 84 e8 6d e0 94 02 <0f> 0b e9 bc fb ff ff 48 c7 c7 6c a0 77 85 e8 41 9d 4c 00 e9 0d fb
RSP: 0000:ffffffff84c07c18 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff84c72dc0 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f79
RBP: 1ffffffff0980f85 R08: 0000000000000000 R09: ffffffff84c078f7
R10: fffffbfff0980f1e R11: 0000000000000001 R12: ffff88806d437998
R13: 0000000000000001 R14: ffffffff84c72db8 R15: ffffffff84c72400
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? dequeue_task_idle+0xe/0x50
 ? lock_downgrade+0x690/0x690
 _raw_spin_unlock+0x17/0x40
 dequeue_task_idle+0xe/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2538
hardirqs last  enabled at (2537): [<ffffffff83d13b5d>] _raw_spin_unlock_irqrestore+0x2d/0x50
hardirqs last disabled at (2538): [<ffffffff83cfd78d>] __schedule+0xf9d/0x2290
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
bad: scheduling from the idle thread!
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 dequeue_task_idle+0x25/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
------------[ cut here ]------------
unpinning an unpinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5477 lock_unpin_lock+0x2e0/0x390
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_unpin_lock+0x2e0/0x390
Code: e6 29 a5 02 65 c7 05 6b 16 d8 7e 00 00 00 00 eb a4 4c 89 e7 e8 21 bb 4d 00 e9 ab fd ff ff 48 c7 c7 80 af 26 84 e8 29 fe 95 02 <0f> 0b e9 66 ff ff ff 48 c7 c7 c0 af 26 84 e8 16 fe 95 02 0f 0b 48
RSP: 0000:ffffffff84c07b00 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff88806d437998 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f56
RBP: ffffffff84c72de4 R08: 0000000000000000 R09: ffffffff84c077df
R10: fffffbfff0980efb R11: 0000000000000001 R12: fffffbfff098e5b7
R13: ffffffff84c72dc0 R14: ffffffff84c72dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? lock_repin_lock+0x310/0x310
 ? lock_is_held_type+0xd7/0x130
 newidle_balance+0x337/0x10a0
 ? lock_acquire+0x1dc/0x540
 ? lock_release+0x760/0x760
 ? load_balance+0x28a0/0x28a0
 ? do_raw_spin_lock+0x11e/0x240
 pick_next_task_fair+0x4d/0xb90
 __schedule+0x3c9/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2550
hardirqs last  enabled at (2549): [<ffffffff83c7182d>] dump_stack_lvl+0x54/0x59
hardirqs last disabled at (2550): [<ffffffff81257ced>] dequeue_task_idle+0x3d/0x50
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
releasing a pinned lock
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5349 lock_release+0x68c/0x760
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.18.0-rc2-next-20220413 #2564
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:lock_release+0x68c/0x760
Code: 4c 00 e9 20 fa ff ff 4c 89 f7 e8 df 9d 4c 00 e9 6b fc ff ff e8 65 9d 4c 00 e9 2a fc ff ff 48 c7 c7 a0 e1 26 84 e8 6d e0 94 02 <0f> 0b e9 bc fb ff ff 48 c7 c7 6c a0 77 85 e8 41 9d 4c 00 e9 0d fb
RSP: 0000:ffffffff84c07c18 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff84c72dc0 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000008 RDI: fffffbfff0980f79
RBP: 1ffffffff0980f85 R08: 0000000000000000 R09: ffffffff84c078f7
R10: fffffbfff0980f1e R11: 0000000000000001 R12: ffff88806d437998
R13: 0000000000000001 R14: ffffffff84c72db8 R15: ffffffff84c72400
FS:  0000000000000000(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888007001000 CR3: 0000000004c66001 CR4: 00000000000606b0
Call Trace:
 <TASK>
 ? dequeue_task_idle+0xe/0x50
 ? lock_downgrade+0x690/0x690
 _raw_spin_unlock+0x17/0x40
 dequeue_task_idle+0xe/0x50
 __schedule+0xead/0x2290
 ? io_schedule_timeout+0x150/0x150
 ? _raw_spin_unlock_irqrestore+0x2d/0x50
 ? msleep+0x4c/0xd0
 schedule+0xe0/0x200
 schedule_timeout+0x111/0x230
 ? usleep_range_state+0x150/0x150
 ? vprintk_emit+0x9f/0x390
 ? destroy_timer_on_stack+0x20/0x20
 ? __entry_text_end+0x1feab6/0x1feab6
 msleep+0x91/0xd0
 selinux_init+0x64/0x22e
 initialize_lsm+0xc9/0x107
 security_init+0x3d7/0x3f0
 start_kernel+0x354/0x3a3
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
irq event stamp: 2566
hardirqs last  enabled at (2565): [<ffffffff83d13b5d>] _raw_spin_unlock_irqrestore+0x2d/0x50
hardirqs last disabled at (2566): [<ffffffff83cfd78d>] __schedule+0xf9d/0x2290
softirqs last  enabled at (0): [<0000000000000000>] 0x0
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
...
