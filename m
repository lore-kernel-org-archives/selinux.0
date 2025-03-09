Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7535280;
	Sun,  9 Mar 2025 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741496783; cv=none; b=FcfCCZli/pmhny7L8cueU6MC2VXTdXD3boYdsOrHw89nGf3w4wizJ+lOQ16UezZQpkrN3pZisLQ7DpqElElIFlfYTrmc1SFu20W56r5M2CcYdYULUeH2rNisjpp6vPVH9dqK1G48YSs7m4eCmmPqDHB5msKIHkQdVLg03zsPCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741496783; c=relaxed/simple;
	bh=ap14RnM0FXHiW/c1s1yggxVd0fRMyWGdyxBDMRKs5g4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Wm3WhazhUVNNFSrVxZsJ1jGCQysRIVfuTimkwsYO353wFPzOmSWh5ttI0JvcUY2BoRv26Fv6Inj2fp963zTMvDmdDoTYCIeK4Dj+PBEjrOps5luJgX560KQVES///AGWgoyqRaifdPTzS34nGxdzP2Jb7D2hE+vSoUWSIrL53+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZqyLlcpG; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZqyLlcpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741496468; bh=zsWjWchoYt4RUeJrfVrKynL/2TGiCO85mo2XGyQv9tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZqyLlcpG0KDJDenOjbu5amYOIR7g56xBxidFf2mpEeFJuTVjFNTvfTI81KH18j9kt
	 EvmUPR7GbE2p9ve2UzWwxf8ph0F5V1hY2PQZToAGn3GA6LcwS2eET41Qv8xARUETfW
	 Z5zh/+oFk3MFoNm02fYWvt4zs8NnWX85XSNX8A/k=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id DC1984B7; Sun, 09 Mar 2025 12:55:01 +0800
X-QQ-mid: xmsmtpt1741496101ta2qaz7oj
Message-ID: <tencent_0BEE86CD3878D26D402DDD6F949484E96E0A@qq.com>
X-QQ-XMAILINFO: N7MBeL6vDXVdHGCMEieOPTrj7H4vCU2dXZZuxupGB4Mm831JCzHmWX2hs9ROHF
	 XCXxAwrJqidJgFeUQ9s4snV/CMkKNNy7isxOPeikc9plSlyKbmqzNioxN2LXQgDklcoCG7uMvOOH
	 OI9iakV2BDj+w3UuJ4Qw9wnaiQ2XrGGbR/j4R2iu2Eq5YRsCMDKJMuSnbCrOlIPNYpnMGAKzjFDt
	 szyCm1cU3QmGStBA2UVTTOd1r4N0kJqj24qY2iPPoTj0R6Rp1CTCBhwwoxMXG9lBZjNpcD33I9ru
	 ipN9J7kvDw9VSAGg8YNC2g/Qovi2SM6kByyyCjiDtCjjHGtGTE1XIjqwCD/6WZTwC2aKAykUNhFZ
	 oXM3aJSBbwQMWXuznZdMS8ZD7KzkIlp25kehKqXlrEKDWQzCEY3dHRTjfdEaPO/vpENyqmSRSq4q
	 IQIiLRIzzduDwMkIxlWEh2dwp5NESs/uv89P2yrQMtiMebMs4+mbgmh+mVApHPUO13sZxuRlKbVG
	 KJalETTyVXDqm9BhOcffuDUzWugmcccBOu46wt3HKFgKJdIABurBu1w5un4vR6s3Rk99L4tt34eQ
	 roJkvCapEuXeHdOTef9Z908FrVxH1h/3P5eWJqzld2KPjVaXow/wc6m/PtmNGdJxIyex700DLPg+
	 rEa67EujRYm6Z1gn99+fFJKCd9BVg9amiuhU/+VivFhhwGZDMAlgv36CgGrEO/DfLGQG9Im+cEG9
	 dOHhL0NZCnLTWNY6vh6N2+j/6GOBXxVWNdD32NO2EGC7ej2HQZ8+JN13pyHxMwbGJt/oANsgu49j
	 JSXCWAiegYaxsvR7wJ6VZibzL+OSOe+q6TMj5XJVXLSNB4TdaQ5Zo42pA15BO2R/ahZNGNvLFYh5
	 6f8/dDZMpVWYvTncJTu06MEuJ4cWyGdj2SwFiMlZ/3
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] selinux: read and write sid under lock
Date: Sun,  9 Mar 2025 12:55:02 +0800
X-OQ-MSGID: <20250309045501.2651020-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67cb894d.050a0220.d8275.0232.GAE@google.com>
References: <67cb894d.050a0220.d8275.0232.GAE@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a data-race in selinux_socket_post_create /
selinux_socket_sock_rcv_skb. [1]

When creating the socket path and receiving the network data packet path,
effective data access protection is not performed when reading and writing
the sid, resulting in a race condition.

Add a lock to synchronize the two.

[1]
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

Reported-by: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=00c633585760c05507c3
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 security/selinux/hooks.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..ea5d0273f9d5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4677,8 +4677,10 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 
 	if (sock->sk) {
 		sksec = selinux_sock(sock->sk);
+		spin_lock(&sksec->lock);
 		sksec->sclass = sclass;
 		sksec->sid = sid;
+		spin_unlock(&sksec->lock);
 		/* Allows detection of the first association on this socket */
 		if (sksec->sclass == SECCLASS_SCTP_SOCKET)
 			sksec->sctp_assoc_state = SCTP_ASSOC_UNSET;
@@ -5126,7 +5128,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	int err, peerlbl_active, secmark_active;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
-	u32 sk_sid = sksec->sid;
+	u32 sk_sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	char *addrp;
@@ -5155,6 +5157,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (err)
 		return err;
 
+	spin_lock(&sksec->lock);
+	sk_sid = sksec->sid;
+	spin_unlock(&sksec->lock);
 	if (peerlbl_active) {
 		u32 peer_sid;
 
-- 
2.43.0

