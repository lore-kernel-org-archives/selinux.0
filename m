Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23B36BCC3;
	Tue, 26 May 2026 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822397; cv=none; b=czdmo4IoWnEn7rspdnuiqneSzk6FQM1Oz8YJnwi89IoGkVkE8gIVJhSUo2lHzMMnLqyCfoLIn98L4U9f7VXNL7K+0vORxOtO4h/HPjzXGfqSFUXZOVm3DmfavWo3NYll4Q1BFM5GYjEHm05mf+pM/9u93BVIc7CLhWn5pl1Rx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822397; c=relaxed/simple;
	bh=JjG0sV/r9G7WCAQbKlLWJl4n0RbXEWlFGpvamPWr6cM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oX53tFGanMAuW5+9NuKd2UBMn2FFCON1uZz6X+61XAMbKDec27nC7MT+ea0EA8bskcJJ0KIJJzPm3uqi2QLNkx49j+bBI+iWfKKn1uTzmTEKB0kqNcT1f1adw781vt6KmoiW4Aw1MPlWOivQcqYrnrngyBDcHTHFibKN20mBwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=KH34JoSE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="KH34JoSE"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 64F832069C;
	Tue, 26 May 2026 21:06:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NRj5iitQFDCN; Tue, 26 May 2026 21:06:33 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A443D201A7;
	Tue, 26 May 2026 21:06:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A443D201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822393;
	bh=5DZ5mGfrlrGyBA8mqpT4C25iXDChgqp2h3OJQ/ydUqo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=KH34JoSEc2ql1OrdcswX81PfeXR8QqEBLgY+p3Isl7l788LmyKNHR7qGqC37RIWbk
	 iLAGgOTj8COScrPx7a55+yFgFqzf9fGNN4Dimm1aOu/RiiqyMifxWFCsS8R2u4KDmu
	 p8rWgt6DNrhTBmhq3YOU/Bgd3gVt3CyazRPDje/mz1Ccgr9BM6afdMsFKhEYfhMu7T
	 nxnXu5pDcF73bR0YZSBPoPo8EEBq7KCqWiRteepNsq4bECt5f57yaBOopFEHmOzAut
	 dTEjYmQdPRs1k1Rgri04uXKaCAf0O6WDJBaiD1PicDPriGLt9vL2/tUDMK3K23fNQO
	 wGFj4qVlmKwBA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:06:30 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Masahide
 NAKAMURA <nakam@linux-ipv6.org>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek
	<omosnace@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Chiachang Wang <chiachangwang@google.com>, Yan
 Yan <evitayan@google.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v9 02/16] xfrm: add extack to xfrm_init_state
Date: Tue, 26 May 2026 21:06:06 +0200
Message-ID: <migrate-state-v9-2-ad9947e4ae74@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v9-0-ad9947e4ae74@secunet.com>
References: <migrate-state-v9-0-ad9947e4ae74@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

Add a struct extack parameter to xfrm_init_state() and pass it
through to __xfrm_init_state(). This allows validation errors detected
during state initialization to propagate meaningful error messages back
to userspace.

xfrm_state_migrate() now passes extack so that errors from the
XFRM_MSG_MIGRATE_STATE path are properly reported. Callers without an
extack context (af_key, ipcomp4, ipcomp6) pass NULL, preserving their
existing behaviour.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v8->v9: fix commit message
v5->v6: added this patch
---
 include/net/xfrm.h    | 2 +-
 net/ipv4/ipcomp.c     | 2 +-
 net/ipv6/ipcomp6.c    | 2 +-
 net/key/af_key.c      | 2 +-
 net/xfrm/xfrm_state.c | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 10d3edde6b2f..0c035955d87d 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1774,7 +1774,7 @@ u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
 int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
 int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
-int xfrm_init_state(struct xfrm_state *x);
+int xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
 int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
 int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
diff --git a/net/ipv4/ipcomp.c b/net/ipv4/ipcomp.c
index 9a45aed508d1..b1ea2d37e8c5 100644
--- a/net/ipv4/ipcomp.c
+++ b/net/ipv4/ipcomp.c
@@ -77,7 +77,7 @@ static struct xfrm_state *ipcomp_tunnel_create(struct xfrm_state *x)
 	memcpy(&t->mark, &x->mark, sizeof(t->mark));
 	t->if_id = x->if_id;
 
-	if (xfrm_init_state(t))
+	if (xfrm_init_state(t, NULL))
 		goto error;
 
 	atomic_set(&t->tunnel_users, 1);
diff --git a/net/ipv6/ipcomp6.c b/net/ipv6/ipcomp6.c
index 8607569de34f..b340d67eb1d9 100644
--- a/net/ipv6/ipcomp6.c
+++ b/net/ipv6/ipcomp6.c
@@ -95,7 +95,7 @@ static struct xfrm_state *ipcomp6_tunnel_create(struct xfrm_state *x)
 	memcpy(&t->mark, &x->mark, sizeof(t->mark));
 	t->if_id = x->if_id;
 
-	if (xfrm_init_state(t))
+	if (xfrm_init_state(t, NULL))
 		goto error;
 
 	atomic_set(&t->tunnel_users, 1);
diff --git a/net/key/af_key.c b/net/key/af_key.c
index a166a88d8788..842bf5786e3f 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1299,7 +1299,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 		}
 	}
 
-	err = xfrm_init_state(x);
+	err = xfrm_init_state(x, NULL);
 	if (err)
 		goto out;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9417a025270c..53d88b87bdbd 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2143,7 +2143,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (!xc)
 		return NULL;
 
-	if (xfrm_init_state(xc) < 0)
+	if (xfrm_init_state(xc, extack) < 0)
 		goto error;
 
 	/* configure the hardware if offload is requested */
@@ -3238,11 +3238,11 @@ int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 
 EXPORT_SYMBOL(__xfrm_init_state);
 
-int xfrm_init_state(struct xfrm_state *x)
+int xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 {
 	int err;
 
-	err = __xfrm_init_state(x, NULL);
+	err = __xfrm_init_state(x, extack);
 	if (err)
 		return err;
 

-- 
2.47.3

