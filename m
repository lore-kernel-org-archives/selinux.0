Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BC323D
	for <selinux@vger.kernel.org>; Sat,  8 Mar 2025 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392208; cv=none; b=D1/Su8yzIvLbc3XNFgi67G9szdSAD9LIHNOo4+UmwxCiux4oti2C31vUZKe3euNBeAR4EpijkTOLuvQ6v76uJBlSXJkbaEugk00fP2W3T0nWeNFbH0+tDFvkjm5HtzFrmIToHD1tWBfheaN7qZlGEVdQ9txGNivnLii858K2RMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392208; c=relaxed/simple;
	bh=tMTNA9rwQlF1yAdzjYyJcJ/nCaUJfvHJs6U82ARcQPU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VZdQXubHhHLRab23CrK1qysAYPw1vv8y2zkoZpq4/1Zjo8KsZx84ScSxjSX8DNxI3mWeijATezVrGgpWNxSQSMnxXpdT6eh4qxnKNl/wfoQeQiyWD8Zn9cBHSsG99BlDy2ngyTJD3ljv9IRLyTU3ILkJXV5GfkYGjDWzFXVu1P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d05b1ae6e3so21510125ab.0
        for <selinux@vger.kernel.org>; Fri, 07 Mar 2025 16:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392206; x=1741997006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMnnv8hGd0U3wHqhfz54nHbSRWU7dP6v6lp+99nd4Lw=;
        b=qnDrEyL2a00Wsgjtt6CuHT7bOKhPEOMOW9lBj3w+5i92jrceleoK8tqSSIzS9AF/hE
         RJR/jaAp7gbNNdLBl16vYWqnqlV5hGHnYMZYuqZlu6Vm1rQvRR/mZmRhsJTfTLHOGaB9
         PW/JT1ztFOQc6He1sciKBeUrY6P62g8mjOOqmz/5Yt89lbVASss1/ch5ZYkI3cFaDQhT
         9Tbz0nvQaL+criUuNVL6ldz/ZWzexxUZxtlwKAD7+Ev35CgYouqSX8ynxtuwD3Ymo4NG
         Jz0YZkNbpNlK+rlF2llQa6JGgYR/Nvhr5wSJB2UwdtW/659T1CkLfEXg5G9LDxgXdHsn
         pN9w==
X-Forwarded-Encrypted: i=1; AJvYcCUVYIX71D/AOynF5Cz+/L2RnmgWSFWGOq+qOABH2P2OzM0IsC4TcIJOexzqK8lL4Ewjv2I241j+@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaRJ65+xBamnDfpwxZh8q/e2dOlXvjxX8JjubM31QoNe9ejGN
	nBjuty5iD6dlYgcR1l/fvPHIDkHAeWPyvoYXrhSS3NKO7uvmeTyTJnHzOEGID9cv7BtLPW/LqzW
	4ezA+0oCAhsh89a71wM4nfsaeQ9svSeIiXGtBc7pN/rUFrsrgPV/dqyE=
X-Google-Smtp-Source: AGHT+IF/zCFditfD6OUSyvzdPnCxdI/XBzmfEjPiUXuzT+EOEnqSQ9DtgOJdqcXt51mJd0lzEuCpLvOrI7YuUyXg7g+jurGcsk2k
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3d3:fdb8:17a7 with SMTP id
 e9e14a558f8ab-3d441964d37mr64515355ab.6.1741392205730; Fri, 07 Mar 2025
 16:03:25 -0800 (PST)
Date: Fri, 07 Mar 2025 16:03:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb894d.050a0220.d8275.0232.GAE@google.com>
Subject: [syzbot] [selinux?] KCSAN: data-race in selinux_socket_post_create / selinux_socket_sock_rcv_skb
From: syzbot <syzbot+00c633585760c05507c3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f52fd4f67c6 Merge tag 'bcachefs-2025-03-06' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a5ca64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523b0e2f15224775
dashboard link: https://syzkaller.appspot.com/bug?extid=00c633585760c05507c3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb0d7b540c67/disk-0f52fd4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51c261332ad9/vmlinux-0f52fd4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/38914a4790c8/bzImage-0f52fd4f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in selinux_socket_post_create / selinux_socket_sock_rcv_skb

write to 0xffff88811b989e30 of 4 bytes by task 3803 on cpu 0:
 selinux_socket_post_create+0x1b5/0x2a0 security/selinux/hooks.c:4681
 security_socket_post_create+0x5b/0xa0 security/security.c:4577
 __sock_create+0x35b/0x5a0 net/socket.c:1571
 sock_create net/socket.c:1606 [inline]
 __sys_socket_create net/socket.c:1643 [inline]
 __sys_socket+0xae/0x240 net/socket.c:1690
 __do_sys_socket net/socket.c:1704 [inline]
 __se_sys_socket net/socket.c:1702 [inline]
 __x64_sys_socket+0x3f/0x50 net/socket.c:1702
 x64_sys_call+0x2cf2/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:42
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811b989e30 of 4 bytes by task 3805 on cpu 1:
 selinux_socket_sock_rcv_skb+0x72/0x6a0 security/selinux/hooks.c:5129
 security_sock_rcv_skb+0x3d/0x80 security/security.c:4781
 sk_filter_trim_cap+0xca/0x3c0 net/core/filter.c:151
 sk_filter include/linux/filter.h:1062 [inline]
 sock_queue_rcv_skb_reason+0x28/0xc0 net/core/sock.c:527
 sock_queue_rcv_skb include/net/sock.h:2403 [inline]
 packet_rcv_spkt+0x2f7/0x3b0 net/packet/af_packet.c:1967
 deliver_skb net/core/dev.c:2449 [inline]
 __netif_receive_skb_core+0x48f/0x2350 net/core/dev.c:5737
 __netif_receive_skb_list_core+0x115/0x520 net/core/dev.c:5968
 __netif_receive_skb_list net/core/dev.c:6035 [inline]
 netif_receive_skb_list_internal+0x4e4/0x660 net/core/dev.c:6126
 netif_receive_skb_list+0x31/0x230 net/core/dev.c:6178
 xdp_recv_frames net/bpf/test_run.c:280 [inline]
 xdp_test_run_batch net/bpf/test_run.c:361 [inline]
 bpf_test_run_xdp_live+0xe10/0x1040 net/bpf/test_run.c:390
 bpf_prog_test_run_xdp+0x51d/0x8b0 net/bpf/test_run.c:1316
 bpf_prog_test_run+0x20f/0x3a0 kernel/bpf/syscall.c:4407
 __sys_bpf+0x400/0x7a0 kernel/bpf/syscall.c:5813
 __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5900
 x64_sys_call+0x2914/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000003 -> 0x00000087

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3805 Comm: syz.4.118 Not tainted 6.14.0-rc5-syzkaller-00109-g0f52fd4f67c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
==================================================================
syz.4.118 (3805) used greatest stack depth: 10328 bytes left


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
