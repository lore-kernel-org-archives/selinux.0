Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A073C09F8;
	Tue, 26 May 2026 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822513; cv=none; b=FaVl8oLSeDV9sBU95wKNc31lm6MB0cUC4tI46vIXo0/HHjm7cL8bDWtGXGUVCbMfIU1l2Gt0oDl1bsmDqTqYic3ZVfM8OY+dSerucTxnR9jSwPPwmxstHXMuio5RjVzmLQBsUsgCy4A3ZZGBVB4lrtA8EDNncMFgGhVVNYmD2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822513; c=relaxed/simple;
	bh=/xOhxfAvktLqrl487vd1De5bZe22caKuH7jFjEXOwv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfsgultMlWCqiCMonck3wekeIDGsvkQ//wSljNauA06nz6bYXFdGZF0iWoYEBWnCYZ2/JlNCNqDfMKv/PKFkyU8Q69+zluaKYXS/RcNYgxzOSwzo+Bnly5SnWJvUbxxnJFPiwGmKgA4d4lc/VYnOmiQkj9jF+BpT2nCLquCHJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=IUkgnfQT; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="IUkgnfQT"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 08BDF201E4;
	Tue, 26 May 2026 21:08:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12cvxuDGD8cR; Tue, 26 May 2026 21:08:30 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 41A66201A7;
	Tue, 26 May 2026 21:08:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 41A66201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822510;
	bh=qu6EWOPrCSZgNx/xfDQ43EMucg5M59PsSb5NL6DVhA0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=IUkgnfQTzM+o+DcWKNcwziNnjLyy1z/DJ52GzqqE5Ayi/mjzyZT84lPAFGe7xajed
	 8k/mOIT8SS9MxtoxqAOpAAWh5BcTrYiezF4QDMMW1w2mzhfxVnQc4Jtb3lHkA6VTc/
	 LqDzxOEg+JMeu9NdZDtSr7XTMgr+G9+q1qrysfmaof8vJIhAfsmj90fIiij2WElfkn
	 dZ86xuh1DqUCpV8FCaExjsxT7WHvH4aRstfNIgfnQ4fI0dvd1see2lGZ4AcDtOshhR
	 v09S/AEV9dDpcALGM5jpvvDLJpznz+FPF8b1pf5IVyd+5/SF8tS8EuiCDXZaWv8gda
	 KdwKOWmWpCvEg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:08:27 +0200
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
Subject: [PATCH ipsec-next v9 08/16] xfrm: add state synchronization after migration
Date: Tue, 26 May 2026 21:08:17 +0200
Message-ID: <migrate-state-v9-8-ad9947e4ae74@secunet.com>
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
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

Add xfrm_migrate_sync() to copy curlft and replay state from the old SA
to the new one before installation. The function allocates no memory, so
it can be called under a spinlock. In preparation for a subsequent patch
in this series.

A subsequent patch calls this under x->lock, atomically capturing the
latest lifetime counters and replay state from the original SA and
deleting it in the same critical section to prevent SN/IV reuse
for XFRM_MSG_MIGRATE_STATE method.

No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v6->v7: - rephrase commit message
v5->v6: - move the sync before install to avoid overwriting
v4->v5: - added this patch
---
 include/net/xfrm.h    | 46 +++++++++++++++++++++++++++++++++++++---------
 net/xfrm/xfrm_state.c | 11 ++++-------
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 4137986f15e2..be22c26e4661 100644
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
index 327a855253e6..fcf6f0c6400d 100644
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
@@ -2193,6 +2188,8 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (!xc)
 		return NULL;
 
+	xfrm_migrate_sync(xc, x);
+
 	if (xfrm_state_migrate_install(x, xc, m, xuo, extack) < 0)
 		return NULL;
 

-- 
2.47.3

