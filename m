Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06A1D5CD1
	for <selinux@vger.kernel.org>; Tue, 26 Nov 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633155; cv=none; b=F04AncEzT465h/wtD+pT5ghHK31nVx5KkYsSeZCOEn7zhYhFcM7mJuLa2Jr4XVAg1R4hbXkNznBHoZWg1liSHAwb4lcCBov59ASr8Inw6QTkKfm9tcoyOe7CWEmJ41iVFphdlBmunwXaLXhF0BA8/jcw/xl9oSRtdqPDRxwxM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633155; c=relaxed/simple;
	bh=c9s5j5HugC+AoiPGvJnCt/UjnzlFA4eO7ktqoh7lg2A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CrEt608ocXvycWS2RBJ2HtpMdKMfcdYRZUWJixRM08hLtEeGpxDh21Csu/4kcVewqKsTyNMFcwOkOH9Q+riUaM4FFM4WtMpIZZycQ/uq65Hsaw5SphbqHrhxx3HIVSLd+5UX9xLebNKFhBzo7tQwpfMXx8Lx/9F+4cj+QmfGIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yFPGJaYs; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yFPGJaYs"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6785f0c3dso43411185a.1
        for <selinux@vger.kernel.org>; Tue, 26 Nov 2024 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732633152; x=1733237952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQudZCjaVdDzHtL5sibZ1sXlI3S8veThfHaA+fYC2yo=;
        b=yFPGJaYsl3jQkRNG6IyO9eZ+n8zhLFzI0uxWOJpJX/ij4RR556WqKV970drTLJNo3p
         qX4S2P6IORXVWKraELZvVGY6kegFKTGfTgqJA15XRkryLs3kI2spgPD1HsorvcXYY7x1
         jAp3Rso1QMngvB9GBZoYrKA8aeO9rJwAZ6TImbt4IbapVaJJFf5s/8TXX3tawWKhys2e
         xLxXa29Lkt2mZ+HsCogGiSuMlVHiUu1z82rB3HbfoEXaRyqNzuSLe7GLO7FjZb9P2hDU
         37S/jWLyXVsXorDF/qePBLZMfhS5LgN2eWPk9KwoEMKvRVlPhhIXdvAIVFPkohgUE8nn
         QgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732633152; x=1733237952;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQudZCjaVdDzHtL5sibZ1sXlI3S8veThfHaA+fYC2yo=;
        b=vTwe3lWN6qvC4A3+AX3ym/45+8s5PelCrqnoIMiJdLElmbrmG5xg6gI8uWm2zFAAJ4
         cWfsMKNNSkd2dxvJVbA/UYAjY6WF8PUfunX8//RvB0oltyDZSEKDfcT/ktwGr7x6oaUC
         f/wkncegKve0Y6pqBZfr5fazLtGM7tlR1PCTJVlMo+KMgAQKVrAdgBC1dVEGYxtGnr9D
         O5WTfuxVU5NsYO5iVEK/j4SxblY20yDczhnLIMHy2TQCzxg937AK5WHNUhAZKEN/mTeY
         muHNv7FI637qQnyDIJBWqJVv+wYGgfUeyhr6VuG4zmKK9HyCNfz1aWPYUijfNKJBb2/5
         fSvg==
X-Forwarded-Encrypted: i=1; AJvYcCUO2fraPlcj7jFnvk9z8UooT0NKD+M3CtYHD9CAP2DNRZFIFBvUltfyUwGxE2R3dtnwYh5sad38@vger.kernel.org
X-Gm-Message-State: AOJu0YxknsM4jJAhvL1bez97ceZu2c3z37Ufs6wKeNa5l1Y9Um09llL1
	m6N9bqp6ApayqOd4ix9/t/VHhYFZ+d4QETK939B9gh4VEDC7aSKJ7bGuLD4YcwsgzP9yge0iuw3
	RrisHBs2/3A==
X-Google-Smtp-Source: AGHT+IFap7RI7JlsbX1Nt2DLHCJpTn2gAcYVYCUN7zxPhNnAcwRihB52mLuN/xkJEtcJQQqSBuZn98H+v2UQEw==
X-Received: from qkee14.prod.google.com ([2002:a05:620a:4e4e:b0:7b3:5814:20ee])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:84ca:b0:7b6:62f9:109b with SMTP id af79cd13be357-7b662f9121bmr1518238085a.42.1732633152623;
 Tue, 26 Nov 2024 06:59:12 -0800 (PST)
Date: Tue, 26 Nov 2024 14:59:11 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126145911.4187198-1-edumazet@google.com>
Subject: [PATCH net] selinux: use sk_to_full_sk() in selinux_ip_output()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com, 
	Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"

In blamed commit, TCP started to attach timewait sockets to
some skbs.

syzbot reported that selinux_ip_output() was not expecting them yet.

Note that using sk_to_full_sk() is still allowing the
following sk_listener() check to work as before.

BUG: KASAN: slab-out-of-bounds in selinux_sock security/selinux/include/objsec.h:207 [inline]
BUG: KASAN: slab-out-of-bounds in selinux_ip_output+0x1e0/0x1f0 security/selinux/hooks.c:5761
Read of size 8 at addr ffff88804e86e758 by task syz-executor347/5894

CPU: 0 UID: 0 PID: 5894 Comm: syz-executor347 Not tainted 6.12.0-syzkaller-05480-gfcc79e1714e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <IRQ>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0xc3/0x620 mm/kasan/report.c:488
  kasan_report+0xd9/0x110 mm/kasan/report.c:601
  selinux_sock security/selinux/include/objsec.h:207 [inline]
  selinux_ip_output+0x1e0/0x1f0 security/selinux/hooks.c:5761
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xbb/0x200 net/netfilter/core.c:626
  nf_hook+0x386/0x6d0 include/linux/netfilter.h:269
  __ip_local_out+0x339/0x640 net/ipv4/ip_output.c:119
  ip_local_out net/ipv4/ip_output.c:128 [inline]
  ip_send_skb net/ipv4/ip_output.c:1505 [inline]
  ip_push_pending_frames+0xa0/0x5b0 net/ipv4/ip_output.c:1525
  ip_send_unicast_reply+0xd0e/0x1650 net/ipv4/ip_output.c:1672
  tcp_v4_send_ack+0x976/0x13f0 net/ipv4/tcp_ipv4.c:1024
  tcp_v4_timewait_ack net/ipv4/tcp_ipv4.c:1077 [inline]
  tcp_v4_rcv+0x2f96/0x4390 net/ipv4/tcp_ipv4.c:2428
  ip_protocol_deliver_rcu+0xba/0x4c0 net/ipv4/ip_input.c:205
  ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
  NF_HOOK include/linux/netfilter.h:314 [inline]
  NF_HOOK include/linux/netfilter.h:308 [inline]
  ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
  dst_input include/net/dst.h:460 [inline]
  ip_rcv_finish net/ipv4/ip_input.c:447 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  NF_HOOK include/linux/netfilter.h:308 [inline]
  ip_rcv+0x2c3/0x5d0 net/ipv4/ip_input.c:567
  __netif_receive_skb_one_core+0x199/0x1e0 net/core/dev.c:5672
  __netif_receive_skb+0x1d/0x160 net/core/dev.c:5785
  process_backlog+0x443/0x15f0 net/core/dev.c:6117
  __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6877
  napi_poll net/core/dev.c:6946 [inline]
  net_rx_action+0xa94/0x1010 net/core/dev.c:7068
  handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
  do_softirq kernel/softirq.c:455 [inline]
  do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
  __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
  local_bh_enable include/linux/bottom_half.h:33 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
  __dev_queue_xmit+0x8af/0x43e0 net/core/dev.c:4461
  dev_queue_xmit include/linux/netdevice.h:3168 [inline]
  neigh_hh_output include/net/neighbour.h:523 [inline]
  neigh_output include/net/neighbour.h:537 [inline]
  ip_finish_output2+0xc6c/0x2150 net/ipv4/ip_output.c:236
  __ip_finish_output net/ipv4/ip_output.c:314 [inline]
  __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:296
  ip_finish_output+0x35/0x380 net/ipv4/ip_output.c:324
  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
  ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:434
  dst_output include/net/dst.h:450 [inline]
  ip_local_out+0x33e/0x4a0 net/ipv4/ip_output.c:130
  __ip_queue_xmit+0x777/0x1970 net/ipv4/ip_output.c:536
  __tcp_transmit_skb+0x2b39/0x3df0 net/ipv4/tcp_output.c:1466
  tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
  tcp_write_xmit+0x12b1/0x8560 net/ipv4/tcp_output.c:2827
  __tcp_push_pending_frames+0xaf/0x390 net/ipv4/tcp_output.c:3010
  tcp_send_fin+0x154/0xc70 net/ipv4/tcp_output.c:3616
  __tcp_close+0x96b/0xff0 net/ipv4/tcp.c:3130
  tcp_close+0x28/0x120 net/ipv4/tcp.c:3221
  inet_release+0x13c/0x280 net/ipv4/af_inet.c:435
  __sock_release net/socket.c:640 [inline]
  sock_release+0x8e/0x1d0 net/socket.c:668
  smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
  __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
  smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
  __sock_release+0xb0/0x270 net/socket.c:640
  sock_close+0x1c/0x30 net/socket.c:1408
  __fput+0x3f8/0xb60 fs/file_table.c:450
  __fput_sync+0xa1/0xc0 fs/file_table.c:535
  __do_sys_close fs/open.c:1550 [inline]
  __se_sys_close fs/open.c:1535 [inline]
  __x64_sys_close+0x86/0x100 fs/open.c:1535
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6814c9ae10
Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d b1 e2 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007fffb2389758 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6814c9ae10
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000202 R12: 00007fffb23897b0
R13: 00000000000141c3 R14: 00007fffb238977c R15: 00007fffb2389790
 </TASK>

Fixes: 79636038d37e ("ipv4: tcp: give socket pointer to control skbs")
Reported-by: syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6745e1a2.050a0220.1286eb.001c.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Brian Vazquez <brianvv@google.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5a08f94e09402b6b0b1538fae1a7a3f5af19fe6..366c87a40bd15707f6da4f25e8de4ddce3d281fc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5738,7 +5738,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 	/* we do this in the LOCAL_OUT path and not the POST_ROUTING path
 	 * because we want to make sure we apply the necessary labeling
 	 * before IPsec is applied so we can leverage AH protection */
-	sk = skb->sk;
+	sk = sk_to_full_sk(skb->sk);
 	if (sk) {
 		struct sk_security_struct *sksec;
 
-- 
2.47.0.338.g60cca15819-goog

