Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45024360;
	Tue, 11 Mar 2025 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651708; cv=none; b=fINiC5yJviQrlGZVhqOYwTYKcsFtEOziG/uKz2jTbSaUQSEEU1VjsY8i8LFdQgdvDbaJh/kmiLXUiCzI7hSxyDlVc10CCrvY8KIkNOUIyNX5hm4RyR+3r5BtBe2A6UtYqe2kv95Ckxn568RkS5Ql05GoqEEOp4/pkOOtw+JvZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651708; c=relaxed/simple;
	bh=qlBORcXcv79O9jkWzB5hycoZa4C0nQquC4/hGca6LR8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gsCWySI2LNCESwZD8QBPigMNxpu4r3JG6wiU/3w4H7MtG5cMkiTeTEuMG5ofAQys7ySYswxYjo2mOHw/Tfg1aDj/ox+kqA+zf2Gah26AQIfgM0nzuif46eiKZAKMMVGddE/Pkq92+yFyx7gl/KJF87zFRQ7i5boZ0JqKxBK+NRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ioo7Q3b1; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ioo7Q3b1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741651393; bh=rfTzhd8ZSIhtidRNxNIL06awcZLzSLHonxjCJcKSPgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ioo7Q3b1dVLkfgWRIX81YxsjUfOuR5lWtKkwHKPu/bPGz0DXtYxod11m9mg2gXPfO
	 Lzg7fQFdFMGjFlbqMwbSGJJKhk8VZIAi5gUY1TaNCq7lgJAxp1rxXMTbjmEaCkLmuj
	 NuqBjk9/QiHk/REVblNrlzg3kKX45vngARKEMrqY=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id CB2FA5B; Tue, 11 Mar 2025 08:03:11 +0800
X-QQ-mid: xmsmtpt1741651391tqvcfec3x
Message-ID: <tencent_5E4FD70DE825E68D96927A5DE95D90991807@qq.com>
X-QQ-XMAILINFO: Of6TnALcrk8RHj03cXvro/DzVa/OLTCfSzKHWMo3oONMwF60lnhYqY5d17Sj79
	 r0P4pkRbbf2HHbjYP5038WGhF3pvleL9WjwdpSd4kWlJuYH0k6RPNV7/pE5udubeoIHj2ve9HIA8
	 WEXQcdbAb6dtHj70JRAW1jEOdHywAzknCsd2vOIsNl4eEiY5UMUuoQt0bDpX/dtgVaQIMu41EOdH
	 3aWD0C57tJkGqETKUVP7b9Nxoj9SHREWFmBsw5ETxGNymUh2ajeM2lXkZLl7A++WteLxUkTYaxMZ
	 paS7USzgIRGrAjY7uGMFsorbDQx47eWk8DnXykWyRw9GO+0URZGX9sVzj+4o9lam/2uSEm5gjjXu
	 6X0aIXqOGbvJ0ULk478jb/3dMzimjke09qKu6WRc3O9StiDdnhYPApEzckMqDVRTyhBYogwQzhCB
	 wO1kS6gLOr0siYTxyEvRaYYsQuXMwAOqXd6YdzorKoUCvp/zWj9xzBfUP+bzga7tube7V9TK7dUA
	 J3oTW+IssaCq6lhCGplqVCh+VQchtvTwbRAg905OpuCohWJ4Z5L2bBytMkNKJ0eugrbCoLt9VtB/
	 BywNXlMeBNDY36LP43gLPvVyq4j8Q8YJ3J3HEoCLbjpGE8lkrVPndeRGqXW3+oQ2zlNBH1AfHhz1
	 7nOVrXDA+eIkDF2iJoD/clADFg9QTS6cODFeHRY4GswG+VhDlCPvwOo8dDOM+6TyDrMXMsWCFkb6
	 7Rhnq4mKfnZgs72JPmmrNG7f1GwJSRPVXPn3JNl4YIwEBlatpssZIWM+hSlKRWyplZP1uxIgKX6L
	 hx7+H1PLDrksNKHkUWceZX/9lhIJfrorQ6K1m7qPnle4vwF2Moh0LkuCo7YIMmaLdwqWo2PIwkh2
	 7hpsD6BmD6IR61vn4Eoi+NGIF8AId1RSaM9q+oiO4Al6SwcTl4ix2gTr7QlvxjMg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: paul@paul-moore.com
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] selinux: access sid under READ/WRITE_ONCE
Date: Tue, 11 Mar 2025 08:03:07 +0800
X-OQ-MSGID: <20250311000306.3411804-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAHC9VhT-VA74h90ScjwO11g7b0pmCjzhVYWKHmkKqD2LLio98g@mail.gmail.com>
References: <CAHC9VhT-VA74h90ScjwO11g7b0pmCjzhVYWKHmkKqD2LLio98g@mail.gmail.com>
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

Use READ_ONCE/WRITE_ONCE to synchronize the two.

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
V1 -> V2: replace with READ_ONCE/WRITE_ONCE

 security/selinux/hooks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..77d2953eaa4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4678,7 +4678,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	if (sock->sk) {
 		sksec = selinux_sock(sock->sk);
 		sksec->sclass = sclass;
-		sksec->sid = sid;
+		WRITE_ONCE(sksec->sid, sid);
 		/* Allows detection of the first association on this socket */
 		if (sksec->sclass == SECCLASS_SCTP_SOCKET)
 			sksec->sctp_assoc_state = SCTP_ASSOC_UNSET;
@@ -5126,7 +5126,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	int err, peerlbl_active, secmark_active;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
-	u32 sk_sid = sksec->sid;
+	u32 sk_sid = READ_ONCE(sksec->sid);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	char *addrp;
-- 
2.43.0

