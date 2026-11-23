Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433899;
	b=wleaVJL0dGhlw7uZQLdGQ3oW8ALfh6qva35EffYQGTxf6pM0Y8FDTPkOiq36al4mLm9p
	 4GnvfyMZll367xSFz8+ogDepLJWc5m3VyUstUDZF9T1UBfK5bsX3dpPtvaZ10u8iEoGJr
	 3S34qUPTvq8MBSFPAVj89kAkcdReN12/vIfbmzytZqdZZNy77GwXbW28VNbiQIyuEn8fv
	 DWTZeXmEZw9/QTuXpxVD9k3BDaxRFHYSELUd/gastSDQsFsqtfFDD3y2LiJxSwdtTWf5+
	 gLg7L6SbcqQvtHjl3IYCQezxIuMV5qTfKHJYq357f0Lp+THCTKl6c3gEYp8M5y9iBjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433899;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ibTuH5326GpSfDxyW8QGVkxEl1EU9AG5En46fuNsGfU=;
	b=yRQGLNHlpNA3Z93lTSMnRJ9xSBxz3u5qr51xFHfV4Ew5XBuzRlqmzhrPYQel8AL2p/kO
	 kCJmSG81WthbdRpVAbg2IbyPtEtJHt/6V/CRKp3fSAO5tb324iEydKK7TajE8N+2rNq/+
	 /wXQVP2JIcTb71tirbXD+VvcHaZ63eIZwR4g2aKzZvIe++QIjk7VgMRur6pMpMouofaFg
	 0QZWbD4FSEbfwj0nJnsCr6Vbgfy08HB3YDqrADBLr+ZIET81uaq1vmBl66DsLZclds3AT
	 9GNxtOCV6j73EZCy3/xWWFDV5XbgMnzIiwq4vwKgrzkbqK45hanfNJyZ4gZ3alan6RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=Wf5cSZl8;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35C606A31A;
	Mon, 23 Nov 2026 11:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C35C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=Wf5cSZl8
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id C6380202F55A;
	Mon, 23 Nov 2026 16:38:09 +0500 (+05)
Received: from fedora (unknown [94.190.79.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id 6CD8A202F558;
	Mon, 23 Nov 2026 16:38:06 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 6CD8A202F558
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1795433889; bh=ibTuH5326GpSfDxyW8QGVkxEl1EU9AG5En46fuNsGfU=;
	h=From:To:Cc:Subject:Date;
	b=Wf5cSZl8TL9BTV90b2y7Y2GG5Nz8ljbjRGppKZQVBeL1UHCvaJD8M8g6glTLnwIs7
	 10/gzv7zkeAO+SytUtL+Ok1az3uSAEz5AZIBftFlnmODG4ZfF8dwOoRMgQVWpOFTpn
	 MY5oO+IKLBBEhUOIGye9Uw8Z18xj59wFXASNlbFpS0KeNj/pKQeofaML/s3wnoUzQW
	 +0+QAdptaP5y3ZxZFrEwKFJW3hdjtiOtIidPkvFjC8TkNta9LzOu/l/cOfnlZJwVIL
	 o7ByVPIxPaCXZUOlbu2/BzZvi/26se3QZDrJYfDA1Ib5uyLgG2Yrchi6ZlWBUzcROX
	 DkClIQrzfV0JQ==
From: Eduard Orehov <e.orehov@ideco.ru>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Eduard Orehov <e.orehov@ideco.ru>
Subject: [PATCH] selinux: initialize sport/dport in __ad_net_init()
Date: Mon, 23 Nov 2026 16:37:24 +0500
Message-ID: <20261123113724.35381-1-e.orehov@ideco.ru>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*()
helpers") the struct lsm_network_audit used by the SELinux network hooks
is no longer zeroed; __ad_net_init() sets only netif, sk and family.
The addresses are always filled in by selinux_parse_skb(), but sport
and dport are set by selinux_parse_skb_ipv4()/selinux_parse_skb_ipv6()
only for TCP, UDP and SCTP. For any other protocol (e.g. a raw
socket with IPPROTO_IGMP, UDP-Lite) and for non-first fragments they
are left uninitialized.

When such a packet hits an AVC denial (e.g. with NetLabel or secmark
peer labeling enabled), dump_common_audit_data() passes the garbage
ports to print_ipv4_addr()/print_ipv6_addr(), which leaks up to four
bytes of kernel stack into the audit log as "src=" / "dest=" and is
reported by KMSAN:

  BUG: KMSAN: uninit-value in common_lsm_audit+0x2196/0x2ff0
   print_ipv6_addr security/lsm_audit.c:178 [inline]
   dump_common_audit_data security/lsm_audit.c:373 [inline]
   common_lsm_audit+0x2196/0x2ff0 security/lsm_audit.c:458
   slow_avc_audit+0x17f/0x1d0 security/selinux/avc.c:773
   avc_has_perm+0x2d6/0x360 security/selinux/avc.c:1191
   selinux_inet_sys_rcv_skb+0x116/0x280 security/selinux/hooks.c:5326
   selinux_socket_sock_rcv_skb+0xaae/0x1270 security/selinux/hooks.c:5408
   security_sock_rcv_skb+0x79/0x120 security/security.c:4853
   sk_filter_trim_cap+0x18b/0xa60 net/core/filter.c:151
   sock_queue_rcv_skb_reason+0x46/0x1a0 net/core/sock.c:522
   rawv6_rcv+0x1b17/0x1c20 net/ipv6/raw.c:371
   ...
  Local variable net created at:
   selinux_socket_sock_rcv_skb+0x118/0x1270 security/selinux/hooks.c

Initialize sport and dport in __ad_net_init(). Zeroing only these two
fields keeps the cost low, which was the point of dd51fcd42fd6.

Found by Ideco on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller.

Fixes: dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*() helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Eduard Orehov <e.orehov@ideco.ru>
---
Tested on a 6.12.114-based kernel with KMSAN: the reproducer (NetLabel
static default label + raw IPv4/IPv6 socket with protocol 2, and UDP-Lite
over IPv6) triggers the report on the unpatched kernel and no longer does
with the fix. Mainline was not booted; the affected code there is
identical.

 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9950f89dfaa2..9029e2ab072a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -242,6 +242,8 @@ static void __ad_net_init(struct common_audit_data *ad,
 	net->netif = ifindex;
 	net->sk = sk;
 	net->family = family;
+	net->sport = 0;
+	net->dport = 0;
 }
 
 static void ad_net_init_from_sk(struct common_audit_data *ad,
-- 
2.56.1


