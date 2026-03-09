Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069733B95E9;
	Mon,  9 Mar 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082012; cv=none; b=MBwVsyp/nseFITNIAWPfJuFk0LAoPz4Km2gZKwQlqSsaGq2UwMb2eFFIdXb82HaD2mfFxrYQKeLxnCvLQZzqbOEVR3/y3di2+TwwiVw+oR8cEBT3ClrHhdfWIB7BhD6JPRWjHnbipfgyvoB5IWBZbLD0JdroYOuGSUIQt2YBEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082012; c=relaxed/simple;
	bh=f9HcoGt6ol3Vn2q6HCMicZp5U0A0jEDx5SBU0e+tz2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lS/1LQsIX6N2T5260nwUq/TnP+a+sdZYc1FUv9PclQgSL/cyzCDAlBComvm5gmEWOpmoryt0Ic1/bLLzYsiWqs3eebGSsiUyeK1urftm0kQ8xZ6R/QzjhaR7pyNRS/0zeHwCKZsCa/j9YZn0qabMuDHHeS0F4YAoB0EnAeR5ux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=oQLTNx94; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="oQLTNx94"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9411A206DF;
	Mon,  9 Mar 2026 19:46:49 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yy6LfYTIz39q; Mon,  9 Mar 2026 19:46:48 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9399020538;
	Mon,  9 Mar 2026 19:46:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9399020538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773082008;
	bh=Xqwbrx+kFpcdO4D2LEuz9uj0+5BtNpsk/Kf90RsAgDw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=oQLTNx94pJwwMwe1eNJjji/blv5YsPEEQn8am66lsv9fIUss/m6n5JOvjt1DbMZwc
	 t3JQe60518cM/YGRH68t7qy98WKs8evU5BmPjVa9gsP6FSSxklRs+gpXZVsGDz+ULl
	 9bWFBFXW6Brcx+FS53MolWmJzDW2wL0yDhcoQWB6DUFDmX1r8EClFyUNkY83MBFL2w
	 GbkSJvSKB7hL6AGzQxH+0a7Mc/Y3WQpNQNvHypHHvkgNaJsg55ZoKq2xq9RDJOPAFA
	 In1oPRWTWMirfwTlVoIfyHXs6+eVbrRIfgSPin3ZRbdgkhZM9HJ1WqFavnz1oupcEM
	 ur/lR/+VMBDYQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 19:46:46 +0100
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
Subject: [PATCH ipsec-next v6 08/14] xfrm: add state synchronization after migration
Date: Mon, 9 Mar 2026 19:46:36 +0100
Message-ID: <migrate-state-v6-8-9df9764ddb9e@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v6-0-9df9764ddb9e@secunet.com>
References: <migrate-state-v6-0-9df9764ddb9e@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

Add xfrm_migrate_sync() to synchronize curlft and replay state after
state installation, this can be called under lock without memory
allocation.  In preparation for a subsequent patch in this series.

This ensures the migrated state captures the latest lifetime counters
and replay state from the original after installation completes.
Within the same lock, the original xfrm state is deleted.

No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v5->v6: - move the sync before install to sync overwriting
Link:
https://lore.kernel.org/all/58f43c2cf105ed9ab4ac6807c8bcdbe2764f13c3.1769509131.git.antony.antony@secunet.com/
[v5]
v4->v5: - added this patch
---
 include/net/xfrm.h    | 46 +++++++++++++++++++++++++++++++++++++---------
 net/xfrm/xfrm_state.c | 12 +++++-------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 4137986f15e241bf0bda2003be1da8deb5a58f0c..be22c26e4661b9cd5613878b7cc6fac20712ffc2 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2024,23 +2024,51 @@ static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_es
 
 #ifdef CONFIG_XFRM_MIGRATE
 static inline int xfrm_replay_clone(struct xfrm_state *x,
-				     struct xfrm_state *orig)
+				    const struct xfrm_state *orig)
 {
+	/* Counters synced later in xfrm_replay_sync() */
 
-	x->replay_esn = kmemdup(orig->replay_esn,
+	x->replay = orig->replay;
+	x->preplay = orig->preplay;
+
+	if (orig->replay_esn) {
+		x->replay_esn = kmemdup(orig->replay_esn,
 				xfrm_replay_state_esn_len(orig->replay_esn),
 				GFP_KERNEL);
-	if (!x->replay_esn)
-		return -ENOMEM;
-	x->preplay_esn = kmemdup(orig->preplay_esn,
-				 xfrm_replay_state_esn_len(orig->preplay_esn),
-				 GFP_KERNEL);
-	if (!x->preplay_esn)
-		return -ENOMEM;
+		if (!x->replay_esn)
+			return -ENOMEM;
+		x->preplay_esn = kmemdup(orig->preplay_esn,
+				xfrm_replay_state_esn_len(orig->preplay_esn),
+				GFP_KERNEL);
+		if (!x->preplay_esn)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
 
+static inline void xfrm_replay_sync(struct xfrm_state *x, const struct xfrm_state *orig)
+{
+	x->replay = orig->replay;
+	x->preplay = orig->preplay;
+
+	if (orig->replay_esn) {
+		memcpy(x->replay_esn, orig->replay_esn,
+				xfrm_replay_state_esn_len(orig->replay_esn));
+
+		memcpy(x->preplay_esn, orig->preplay_esn,
+				xfrm_replay_state_esn_len(orig->preplay_esn));
+	}
+}
+
+static inline void xfrm_migrate_sync(struct xfrm_state *x,
+					  const struct xfrm_state *orig)
+{
+	/* called under lock so no race conditions or mallocs allowed */
+	memcpy(&x->curlft, &orig->curlft, sizeof(x->curlft));
+	xfrm_replay_sync(x, orig);
+}
+
 static inline struct xfrm_algo_aead *xfrm_algo_aead_clone(struct xfrm_algo_aead *orig)
 {
 	return kmemdup(orig, aead_len(orig), GFP_KERNEL);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f7bcf14223584bd7d779a2521a9d5b0bf7946640..85a5567af5b33fc70c48a7205b334b2ab3c0ab81 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2027,10 +2027,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 			goto error;
 	}
 
-	if (orig->replay_esn) {
-		if (xfrm_replay_clone(x, orig))
-			goto error;
-	}
+	if (xfrm_replay_clone(x, orig))
+		goto error;
 
 	memcpy(&x->mark, &orig->mark, sizeof(x->mark));
 	memcpy(&x->props.smark, &orig->props.smark, sizeof(x->props.smark));
@@ -2043,11 +2041,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	x->tfcpad = orig->tfcpad;
 	x->replay_maxdiff = orig->replay_maxdiff;
 	x->replay_maxage = orig->replay_maxage;
-	memcpy(&x->curlft, &orig->curlft, sizeof(x->curlft));
 	x->km.state = orig->km.state;
 	x->km.seq = orig->km.seq;
-	x->replay = orig->replay;
-	x->preplay = orig->preplay;
 	x->lastused = orig->lastused;
 	x->new_mapping = 0;
 	x->new_mapping_sport = 0;
@@ -2193,9 +2188,12 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (!xc)
 		return NULL;
 
+	xfrm_migrate_sync(xc, x);
+
 	if (xfrm_state_migrate_install(x, xc, m, xuo, extack) < 0)
 		return NULL;
 
+
 	return xc;
 }
 EXPORT_SYMBOL(xfrm_state_migrate);

-- 
2.47.3

