Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F52D2488;
	Sun, 12 Apr 2026 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992551; cv=none; b=F26aUvCowXDQWimayZZozedDJItc6BW/WkTwgUezAuxIqsmerzW7sQ7sUG/58O/odODfIuzawqhXAcP9xRRKIKlU1D6eF9D9uAWMe52lG5o9kAFCzzxsP6jk2rvi+PhSdi86eXKhBWoQEJ8IvMCLRY3iv8VhMdXsWSQstAmJVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992551; c=relaxed/simple;
	bh=wsa7n6AiZkK0WuSe5K8/OI9qW8IqEiWJzkNpj6Xb0Bc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzdrPw7R0jsHrIK80oJzxq1tdVHTqIIJB0HG/M3qtVSBaP4NjjZIa6/Nwii/6Gcj4jjCw0Q3gKlMd7ToaQqLYXutNhdIvbmVw3fiLpiBVwIRY72BF9woyGiKW8QPSObd9iBwO65B7fnN+5pCbXrpRZJr3fKTG5xHuH6wm+yZU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=dPTLX6SH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="dPTLX6SH"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id ACD57207D1;
	Sun, 12 Apr 2026 13:15:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VhHanJVXug3o; Sun, 12 Apr 2026 13:15:48 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1B0012076B;
	Sun, 12 Apr 2026 13:15:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1B0012076B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775992548;
	bh=jQhXn4zoW93iPj7P3Jzmpn20X2zQoQ1PFEojR1TghM4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=dPTLX6SHFOO2I0rfbH+YXj8H28+hIi9FmAYzK8F9OfeIr2UhI+wJnicxKyEuSs0VQ
	 UK7e6CMg6IPAg2M038FkossmMobx6P6CTa3E1qEOsxPOG+r0mmrd2m0qfb2jQiM14S
	 C3Hw9nj5SFLLtDY8ovfnn53s1OImaSPQsbYBBo5Dzst739vDTgGEb2Tp2HEszG6+WF
	 5AQ6vdGIGvoHHcGDUK0+UUnsm+ATka0AjtX4R+hPHV7/zeFh9dJgVUSF6Dye1DrGue
	 cP/etFycUfNzXC8e4AxUKELXoD9hnQ4g/Cgqbs5wpBJduPDPs9M6JTBZ3j3LpbQT6X
	 gKuoc+9SFtuGQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Apr
 2026 13:15:47 +0200
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
Subject: [PATCH ipsec-next v7 09/14] xfrm: add error messages to state migration
Date: Sun, 12 Apr 2026 13:15:39 +0200
Message-ID: <migrate-state-v7-9-44eb2440b91c@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

Add descriptive(extack) error messages for all error paths
in state migration. This improves diagnostics by
providing clear feedback when migration fails.

After xfrm_init_state() use NL_SET_ERR_MSG_WEAK() as fallback for
error paths not yet propagating extack e.g. mode_cbs->init_state()

No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v5->v6: - in case dev_state_add() extack already set
	- after xfrm_init_state() use NL_SET_ERR_MSG_WEAK() as fallback
v4->v5: - added this patch
---
 net/xfrm/xfrm_state.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 8494c46118d9..06ba8f03eab3 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2130,11 +2130,15 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 	struct xfrm_state *xc;
 
 	xc = xfrm_state_clone_and_setup(x, encap, m);
-	if (!xc)
+	if (!xc) {
+		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");
 		return NULL;
+	}
 
-	if (xfrm_init_state(xc, extack) < 0)
+	if (xfrm_init_state(xc, extack) < 0) {
+		NL_SET_ERR_MSG_WEAK(extack, "Failed to initialize migrated state");
 		goto error;
+	}
 
 	/* configure the hardware if offload is requested */
 	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
@@ -2163,6 +2167,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 		xfrm_state_insert(xc);
 	} else {
 		if (xfrm_state_add(xc) < 0) {
+			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
 			if (xuo)
 				xfrm_dev_state_delete(xc);
 			xc->km.state = XFRM_STATE_DEAD;

-- 
2.47.3

