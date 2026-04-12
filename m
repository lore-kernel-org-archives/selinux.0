Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B1378D64;
	Sun, 12 Apr 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992484; cv=none; b=BdiB2DSRRTuRyyJfZot0fu14HfwJI4UC/oiiCIoJh7vW0v6yMBNyVPdghNw493oh6Ev/wIYWl7/umpf89nyOU/nDEfbzMr4rkdWAe8/zvs8qITLOJWhmlKcsQkD4IvxhUnQJ5jHw9H+xAUVhtsyMOn326BHjvYmIbhPTHpuzfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992484; c=relaxed/simple;
	bh=lrfEvaSsd2ByZp/jAauV7VFzYguATGG5T1Ex0AXo3Uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2jHPXRewj8G/ToOdij8UJMgoFKokQmBlBlGVoxHaLdLVQxikmdudqDhctcYwi0DF3DdarRW4bGpPTaUC8CTCjBYXoTh7Lq8UTJgLWt9Hqt4BP+iQ//r/hiPn301sVCWE9VUMtoHZ8vk44UXnUk/z21j3mdreALEoHiKdojI9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nW+vF/Sa; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nW+vF/Sa"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CB0F720799;
	Sun, 12 Apr 2026 13:14:40 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pknzWdMBmSm2; Sun, 12 Apr 2026 13:14:40 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2AB072076B;
	Sun, 12 Apr 2026 13:14:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2AB072076B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775992480;
	bh=Xdt1mQj6nHwR1//3+J3FJ92IKxFNQc96m9sJEc9JnNo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=nW+vF/Sa37OHHVqz48eOu79lWqLGggzi15ig3FaeWFtvQSnPpwYdYTL2KwKzglMSU
	 bvvzf9xAk18Wy6nm0F88TivVq763rJDmwavi15bHWlmcIxDAdWxNuoEYFSrfrZWg/u
	 TBDr0nf2d+SYvXsk0HlyIA38sq0NRB6WK5fRNyo8//ouHLG7H6hKQSJZI1Iv5lntA1
	 fBU55tf0c9moANouHQFFm099Jcy91AXb9yP8kylXherV+aMrs1cXj0V9FkAPg/Wsrp
	 jPptLhoIPTXOLL4s+YBjP607hSOnjOlPNuz33R4OpCPD4lVliU/shs2u7/mZagHXG7
	 PiVvz6F/jBs4g==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Apr
 2026 13:14:38 +0200
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
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chiachang Wang
	<chiachangwang@google.com>, Yan Yan <evitayan@google.com>,
	<devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v7 02/14] xfrm: add extack to xfrm_init_state
Date: Sun, 12 Apr 2026 13:13:53 +0200
Message-ID: <migrate-state-v7-2-44eb2440b91c@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v7-0-44eb2440b91c@secunet.com>
References: <migrate-state-v7-0-44eb2440b91c@secunet.com>
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

xfrm_state_migrate_create() now passes extack so that errors from the
XFRM_MSG_MIGRATE_STATE path are properly reported. Callers without an
extack context (af_key, ipcomp4, ipcomp6) pass NULL, preserving their
existing behaviour.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
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
index 571200433aa9..41afb9e82a58 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1283,7 +1283,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 		}
 	}
 
-	err = xfrm_init_state(x);
+	err = xfrm_init_state(x, NULL);
 	if (err)
 		goto out;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 3ee92f93dbd2..86f21a19a0ee 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2143,7 +2143,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (!xc)
 		return NULL;
 
-	if (xfrm_init_state(xc) < 0)
+	if (xfrm_init_state(xc, extack) < 0)
 		goto error;
 
 	/* configure the hardware if offload is requested */
@@ -3236,11 +3236,11 @@ int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 
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

