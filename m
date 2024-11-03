Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D184B658
	for <selinux@vger.kernel.org>; Sun,  3 Nov 2024 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730607032; cv=none; b=davYPdBwisNa7Mn9VMlwYzqXx0BCIWZ7/wyzN1gylvdHV6GstOBIVXJv12yoPm/fay4gbYwQ/ccjv50ydSJ8tQXi/nzsuC0z/nU5Yyd2Pkm2sE4z3bXU0Nfwfq5shwtbweM4SpmfLYqHDLAnr1MC7R3HBKq6ev75zbFFrXe4C44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730607032; c=relaxed/simple;
	bh=/n3p4puBJ7sSNe74lPFLzKKNetNnWQHsV6tAZ/KrWoA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gJVyzfHDXX77gXXeI0WflXhpaZhmPJceXHqlJflAopzHTrf6C0Q8Pd/XnS1guzWII0uPrPZHSGdWG9X05SpYDPgOA5ZS28d/ozz8+gPetFNeK1Q97qZ4OfSccj2fXSZvXiI3kbjMIBerXI4r+X0E9ZCcgMQ360TUPRk9fEnUL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ac1f28d2bso322234639f.0
        for <selinux@vger.kernel.org>; Sat, 02 Nov 2024 21:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730607028; x=1731211828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPhq7dORpLHMz5+9P1fjaxCxmgnwejmnns2Co+5ixBk=;
        b=DanSt/fXnVk5Mq9aRpCLm/h19oR3iUpiZlaq9sHVAyulxQ6NF33uR5hqPVlrp4BLtA
         wqLzojFC6W19EdF6MuHRoFURiFxSHmgIZs7Gj1j56GMeLwR4dQ0vrbpwzShuWw4eCGg8
         1ku10Ake/TNvaVMJ3HY2qQ1EXUaFql8efTw1wt28DPhVHSP+zhgZZjNjihZKLP4VwQjZ
         dCg11JqUQxmfu9eXYfcoTY56RhSMVOBqJuiNMM9Mh4TKS45kwxwfGIzMIWHzr5w1uOyp
         lwnOp/T/DFfap9oIdMbV9eepFHRNGjZyoT9pmeq/kslKrELukG9L4px1ZZ62xXVaAVcv
         P2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6hxFNGz8Cgzm2Nnf5w6CpAYjvR2RIP1AKJas/RX3pyMFFeMDzCVF2NmmT1O1g3hRZiWQ0I9Ke@vger.kernel.org
X-Gm-Message-State: AOJu0YyjheYsNwr4GIaxf+8B2LjA0GmcQtSspVXXiAGMlhCoH3vk+HKl
	1xdmqwcz8R2MRyvdKpNZ7l0Bo+K/ZgwOpLYn3yEGjhrXtAHo71y/bG647pXiKLEWXEcuux9zG7V
	QuT4hnDztTLvMq2fQyRxDOP+T+vXW9FOvzvBb1qXB9itoUTbe7OGaZnc=
X-Google-Smtp-Source: AGHT+IFOvyzvXaf7OgAfQ2BHiZUXKrglPQZlVpY110EzDqE77iZV1KsVfbsLvWaMWLZijqa8MYZpBDc8TpqS1imv1YH6Goae62F8
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3a6:ac42:95c2 with SMTP id
 e9e14a558f8ab-3a6ac4297d7mr86864435ab.5.1730607028637; Sat, 02 Nov 2024
 21:10:28 -0700 (PDT)
Date: Sat, 02 Nov 2024 21:10:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6726f7b4.050a0220.35b515.0192.GAE@google.com>
Subject: [syzbot] [selinux?] INFO: rcu detected stall in rw_verify_area (3)
From: syzbot <syzbot+fc43743888db044f8f70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	omosnace@redhat.com, paul@paul-moore.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c67e9601e29a usb: core: use sysfs_emit() instead of sprint..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14004e87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5aceb1f10131390c
dashboard link: https://syzkaller.appspot.com/bug?extid=fc43743888db044f8f70
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11868630580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9933fbc4c105/disk-c67e9601.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/56cecafd8bd4/vmlinux-c67e9601.xz
kernel image: https://storage.googleapis.com/syzbot-assets/272d47ce6ff0/bzImage-c67e9601.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc43743888db044f8f70@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-...D
 } 2631 jiffies s: 1877 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 2848 Comm: acpid Not tainted 6.12.0-rc4-syzkaller-00059-gc67e9601e29a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_in+0x87/0xb0 drivers/tty/serial/8250/8250_port.c:407
Code: 68 b5 fe 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1a 66 03 5d 40 89 da ec <5b> 0f b6 c0 5d 41 5c c3 cc cc cc cc e8 78 ef 0d ff eb a2 e8 01 f0
RSP: 0018:ffffc90000006f00 EFLAGS: 00000002
RAX: dffffc0000000060 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: ffffffff82a08a30 RDI: ffffffff93637660
RBP: ffffffff93637620 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000020 R14: fffffbfff26c6f1e R15: dffffc0000000000
FS:  00007fa46bfe4740(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe321eb1000 CR3: 000000011649a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr+0xda/0x180 drivers/tty/serial/8250/8250_port.c:2068
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3315 [inline]
 serial8250_console_write+0xf5a/0x17c0 drivers/tty/serial/8250/8250_port.c:3393
 console_emit_next_record kernel/printk/printk.c:3092 [inline]
 console_flush_all+0x800/0xc60 kernel/printk/printk.c:3180
 __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
 console_unlock+0xd9/0x210 kernel/printk/printk.c:3279
 vprintk_emit+0x424/0x6f0 kernel/printk/printk.c:2407
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
 _printk+0xc8/0x100 kernel/printk/printk.c:2432
 printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x1b7/0x3d0 arch/x86/kernel/dumpstack.c:285
 sched_show_task kernel/sched/core.c:7604 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7579
 show_state_filter+0xee/0x320 kernel/sched/core.c:7649
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
 input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
 input_pass_values+0x777/0x8e0 drivers/input/input.c:126
 input_event_dispose drivers/input/input.c:352 [inline]
 input_handle_event+0xb30/0x14d0 drivers/input/input.c:369
 input_event drivers/input/input.c:398 [inline]
 input_event+0x83/0xa0 drivers/input/input.c:390
 hidinput_hid_event+0xa12/0x2410 drivers/hid/hid-input.c:1719
 hid_process_event+0x4b7/0x5e0 drivers/hid/hid-core.c:1540
 hid_input_array_field+0x535/0x710 drivers/hid/hid-core.c:1652
 hid_process_report drivers/hid/hid-core.c:1694 [inline]
 hid_report_raw_event+0xa02/0x11c0 drivers/hid/hid-core.c:2040
 __hid_input_report.constprop.0+0x341/0x440 drivers/hid/hid-core.c:2110
 hid_irq_in+0x35e/0x870 drivers/hid/usbhid/hid-core.c:285
 __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x17f0/0x3930 drivers/usb/gadget/udc/dummy_hcd.c:1993
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_pc+0x41/0x70 kernel/kcov.c:217
Code: 00 48 8b 34 24 74 1d f6 c4 01 74 43 a9 00 00 0f 00 75 3c a9 00 00 f0 00 75 35 8b 82 54 15 00 00 85 c0 74 2b 8b 82 30 15 00 00 <83> f8 02 75 20 48 8b 8a 38 15 00 00 8b 92 34 15 00 00 48 8b 01 48
RSP: 0018:ffffc900015ffa40 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff88810f33cf08 RCX: ffffffff8227ec7b
RDX: ffff8881162257c0 RSI: ffffffff8227ec8a RDI: 0000000000000002
RBP: 000000000000000b R08: 0000000000000002 R09: 000000000000000b
R10: 000000000000000b R11: 0000000000000000 R12: dffffc0000000000
R13: 000000000000004a R14: 000000000000000b R15: 0000000000000052
 avc_search_node security/selinux/avc.c:526 [inline]
 avc_lookup+0x12a/0x1d0 security/selinux/avc.c:552
 avc_has_perm_noaudit+0x97/0x3a0 security/selinux/avc.c:1150
 avc_has_perm+0xc1/0x1c0 security/selinux/avc.c:1188
 inode_has_perm+0x168/0x1d0 security/selinux/hooks.c:1676
 file_has_perm+0x2e8/0x350 security/selinux/hooks.c:1766
 selinux_revalidate_file_permission security/selinux/hooks.c:3620 [inline]
 selinux_file_permission+0x40d/0x580 security/selinux/hooks.c:3641
 security_file_permission+0x3e/0x80 security/security.c:2841
 rw_verify_area+0xaf/0x200 fs/read_write.c:470
 vfs_read+0x13b/0xbd0 fs/read_write.c:560
 ksys_read+0x1fa/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa46c0aeb6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff110d6008 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005597eefdc360 RCX: 00007fa46c0aeb6a
RDX: 0000000000000018 RSI: 00007fff110d6010 RDI: 000000000000000a
RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000008 R11: 0000000000000246 R12: 000000000000000a
R13: 00007fff110d6010 R14: 0000000000000001 R15: 000000000000000a
 </TASK>
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2448d17a90
RSP: 002b:00007fffcd210e08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f2448e08860 RCX: 00007f2448d17a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f2448e08860 R08: 0000000000000001 R09: 11740d9a3862498b
R10: 00007fffcd210cc0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f2448e0c658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:23656 pid:13160 tgid:13160 ppid:3561   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc288c79a90
RSP: 002b:00007ffecc1d9eb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fc288d6a860 RCX: 00007fc288c79a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fc288d6a860 R08: 0000000000000001 R09: 46f1e38a2604db34
R10: 00007ffecc1d9d70 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fc288d6e658 R15: 0000000000000001
 </TASK>
task:kworker/u8:0    state:R  running task     stack:28784 pid:13164 tgid:13164 ppid:11     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:2    state:R  running task     stack:28432 pid:13170 tgid:13170 ppid:2993   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7214
 _cond_resched include/linux/sched.h:2031 [inline]
 stop_one_cpu+0x112/0x190 kernel/stop_machine.c:151
 sched_exec+0x1dc/0x270 kernel/sched/core.c:5459
 bprm_execve fs/exec.c:1838 [inline]
 bprm_execve+0x46c/0x1950 fs/exec.c:1821
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13174 tgid:13174 ppid:11     flags:0x00000000
Call Trace:
 <TASK>
 mas_ascend+0x519/0x930 lib/maple_tree.c:1070
 </TASK>
task:modprobe        state:R  running task     stack:24000 pid:13178 tgid:13178 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:0    state:R  running task     stack:32568 pid:13183 tgid:13183 ppid:11     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13185 tgid:13185 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f48b4920a90
RSP: 002b:00007ffc36f8d688 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f48b4a11860 RCX: 00007f48b4920a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f48b4a11860 R08: 0000000000000001 R09: 62464e80d176aa17
R10: 00007ffc36f8d540 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f48b4a15658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:13188 tgid:13188 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc817d82a90
RSP: 002b:00007ffc28755168 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fc817e73860 RCX: 00007fc817d82a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fc817e73860 R08: 0000000000000001 R09: 35bbbf936f03e723
R10: 00007ffc28755020 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fc817e77658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24000 pid:13193 tgid:13193 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13199 tgid:13199 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13202 tgid:13202 ppid:2993   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:kworker/u8:6    state:R  running task     stack:32568 pid:13206 tgid:13206 ppid:3561   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:13210 tgid:13210 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13213 tgid:13213 ppid:2995   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13215 tgid:13215 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13218 tgid:13218 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13219 tgid:13219 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0db81a1a90
RSP: 002b:00007ffd7a6d18d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f0db8292860 RCX: 00007f0db81a1a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f0db8292860 R08: 0000000000000001 R09: 75cb73b10146c01f
R10: 00007ffd7a6d1790 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f0db8296658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13225 tgid:13225 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa0f978ba90
RSP: 002b:00007ffd342f13f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa0f987c860 RCX: 00007fa0f978ba90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fa0f987c860 R08: 0000000000000001 R09: 6e941c417c6dc1ec
R10: 00007ffd342f12b0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fa0f9880658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13230 tgid:13230 ppid:1391   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13236 tgid:13236 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13237 tgid:13237 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3629e09a90
RSP: 002b:00007ffcea81b8e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f3629efa860 RCX: 00007f3629e09a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f3629efa860 R08: 0000000000000001 R09: 44d346ec37427daa
R10: 00007ffcea81b7a0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f3629efe658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13242 tgid:13242 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __pfx_lock_release+0x10/0x10 kernel/locking/lockdep.c:5346
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13245 tgid:13245 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 lock_is_held include/linux/lockdep.h:249 [inline]
 rcu_read_lock_sched_held kernel/rcu/update.c:126 [inline]
 rcu_read_lock_sched_held+0x3e/0x70 kernel/rcu/update.c:120
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13251 tgid:13251 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f64f9a6ba90
RSP: 002b:00007ffc733f4b88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f64f9b5c860 RCX: 00007f64f9a6ba90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f64f9b5c860 R08: 0000000000000001 R09: 50350e11dd473f08
R10: 00007ffc733f4a40 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f64f9b60658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13256 tgid:13256 ppid:28     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5dc5c37a90
RSP: 002b:00007ffc85903da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5dc5d28860 RCX: 00007f5dc5c37a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f5dc5d28860 R08: 0000000000000001 R09: f5335c43cf1b36b4
R10: 00007ffc85903c60 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f5dc5d2c658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13261 tgid:13261 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13262 tgid:13262 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13267 tgid:13267 ppid:28     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class+0x4e/0x130 kernel/locking/lockdep.c:228
 lookup_chain_cache_add kernel/locking/lockdep.c:3816 [inline]
 validate_chain kernel/locking/lockdep.c:3872 [inline]
 __lock_acquire+0x163e/0x3ce0 kernel/locking/lockdep.c:5202
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13273 tgid:13273 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13281 tgid:13281 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 exit_to_user_mode_loop kernel/entry/common.c:102 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0xdb/0x240 kernel/entry/common.c:231
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc960bb8a90
RSP: 002b:00007ffd69c1b9b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fc960ca9860 RCX: 00007fc960bb8a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fc960ca9860 R08: 0000000000000001 R09: 4729d8953588a742
R10: 00007ffd69c1b870 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fc960cad658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13285 tgid:13285 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7214
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13293 tgid:13293 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb366bcda90
RSP: 002b:00007ffd1ab26538 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fb366cbe860 RCX: 00007fb366bcda90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fb366cbe860 R08: 0000000000000001 R09: 86af53a55a447ed7
R10: 00007ffd1ab263f0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb366cc2658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13298 tgid:13298 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:13306 tgid:13306 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13313 tgid:13313 ppid:2993   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13317 tgid:13317 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13319 tgid:13319 ppid:1391   flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24000 pid:13327 tgid:13327 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2ea9f46a90
RSP: 002b:00007ffe96566468 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f2eaa037860 RCX: 00007f2ea9f46a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f2eaa037860 R08: 0000000000000001 R09: 0843579c2927dd38
R10: 00007ffe96566320 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f2eaa03b658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13334 tgid:13334 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13339 tgid:13339 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f06c4218a90
RSP: 002b:00007ffce7217f88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f06c4309860 RCX: 00007f06c4218a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f06c4309860 R08: 0000000000000001 R09: 691458e7f5602762
R10: 00007ffce7217e40 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f06c430d658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13344 tgid:13344 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13346 tgid:13346 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fccd8b79a90
RSP: 002b:00007ffe86da7f78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fccd8c6a860 RCX: 00007fccd8b79a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fccd8c6a860 R08: 0000000000000001 R09: b12a4fcee88c41ba
R10: 00007ffe86da7e30 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fccd8c6e658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:13351 tgid:13351 ppid:28     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff0b2d57a90
RSP: 002b:00007ffd9747c8d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ff0b2e48860 RCX: 00007ff0b2d57a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007ff0b2e48860 R08: 0000000000000001 R09: 7487d9dbf7ee2240
R10: 00007ffd9747c790 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff0b2e4c658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13356 tgid:13356 ppid:1391   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9418904a90
RSP: 002b:00007ffc9d14f018 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f94189f5860 RCX: 00007f9418904a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f94189f5860 R08: 0000000000000001 R09: dd6a1ce318d07f54
R10: 00007ffc9d14eed0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f94189f9658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13361 tgid:13361 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13368 tgid:13368 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25968 pid:13372 tgid:13372 ppid:2993   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13373 tgid:13373 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13380 tgid:13380 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13389 tgid:13389 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13391 tgid:13391 ppid:11     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13393 tgid:13393 ppid:1391   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13401 tgid:13401 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13408 tgid:13408 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f93a34c5a90
RSP: 002b:00007ffcd73c26e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f93a35b6860 RCX: 00007f93a34c5a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f93a35b6860 R08: 0000000000000001 R09: 07d0a0b78da507b7
R10: 00007ffcd73c25a0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f93a35ba658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13413 tgid:13413 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd4a5abea90
RSP: 002b:00007ffd53b05598 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd4a5baf860 RCX: 00007fd4a5abea90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fd4a5baf860 R08: 0000000000000001 R09: f9e24cf2fdde29e1
R10: 00007ffd53b05450 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd4a5bb3658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13418 tgid:13418 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13422 tgid:13422 ppid:1391   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7214
 _cond_resched include/linux/sched.h:2031 [inline]
 task_work_run+0x16e/0x250 kernel/task_work.c:241
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f487b739a90
RSP: 002b:00007ffe6d708928 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f487b82a860 RCX: 00007f487b739a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f487b82a860 R08: 0000000000000001 R09: b6b856655501f3de
R10: 00007ffe6d7087e0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f487b82e658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13428 tgid:13428 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13432 tgid:13432 ppid:1391   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13436 tgid:13436 ppid:28     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd012114a90
RSP: 002b:00007ffd059d5108 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd012205860 RCX: 00007fd012114a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fd012205860 R08: 0000000000000001 R09: bfe5983747cb5541
R10: 00007ffd059d4fc0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd012209658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13442 tgid:13442 ppid:11     flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
