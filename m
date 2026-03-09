Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC22701DA;
	Mon,  9 Mar 2026 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081993; cv=none; b=E2T03/eg8nT0yRgblG5eYK9UQF0mdqXZUVjsRTx0LCOjhEtfri+ZoKJHT6egiT+Q/y9fZqYreqCRMrJHC01jqNdPN49qyZ05pifHsFyi9L34kKrAjHFaYRbcBzg24xUgu7aZSjynJv2D9tyfIyULEHys3i6e8bROjs7IVonFV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081993; c=relaxed/simple;
	bh=pA+fEAlgXWZZ66/7t2582jGortWmYxd4AbFBLHnuJCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdlrRXJ9m8OSTTzd2S6wfz8sSrmDYSx030p8jK2PF4bj0bmJUSmJMpRVg8jSxUx5E1RT8l+uy4enNV1JLjE+62y0CtlQR+9K0iTrxh1U7gkcGK7ABzMtLHHM2YrytlWM9DDWyY4x0N8qIkYNxlxnMA9fvL8G7Xd2fgtRE2Ubp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RgE4hk2d; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RgE4hk2d"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CD41F206DF;
	Mon,  9 Mar 2026 19:46:30 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UookW1vzRNvf; Mon,  9 Mar 2026 19:46:30 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0B66820538;
	Mon,  9 Mar 2026 19:46:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0B66820538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773081990;
	bh=aEKM2O3o1xsxbv9An0ZjSOcIgml+2bjEyMo90Kgaep4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=RgE4hk2dR05l4jgITYAAZa7vfQuyzfidBJUHiqpaau4qj2DciJsi6T2meOXGf0EqT
	 teR9s39dP6c9zvQP38ektesruerrES5WZHYfXBUgB30QK/BauEBsLCXZ1dieV2fCvr
	 1WSl4ez0Tl59/qM+gv0NF4SVCq93aBrtpM9YSS1itTwlsujs1iSnoBvY+uME/dhsuM
	 4nooqBpwD/dHuP/9y+whAFWjNUsM45+LYaY5DJ/e/GOGNwOtO7apjbA6C/qpUd3vbY
	 1+Vn5xBHbdlhmKSaFyOTK57Ak5O6u/H6Squqmhvw/KJREVzm0krVDE/vthOsbkFrYh
	 6s2VJzgd2Q3oQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 19:46:29 +0100
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
Subject: [PATCH ipsec-next v6 06/14] xfrm: split xfrm_state_migrate into create and install functions
Date: Mon, 9 Mar 2026 19:46:10 +0100
Message-ID: <migrate-state-v6-6-9df9764ddb9e@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

To prepare for subsequent patches, split
xfrm_state_migrate() into two functions:
- xfrm_state_migrate_create(): creates the migrated state
- xfrm_state_migrate_install(): installs it into the state table

splitting will help to avoid SN/IV reuse when migrating AEAD SA.

And add const whenever possible.
No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v4->v5: - added this patch
---
 include/net/xfrm.h    | 11 ++++++++
 net/xfrm/xfrm_state.c | 73 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 368b1dc22e5cc376cbe96a7f6fb8cddc2e1cec87..4137986f15e241bf0bda2003be1da8deb5a58f0c 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1895,6 +1895,17 @@ int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_encap_tmpl *encap);
 struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *net,
 						u32 if_id);
+struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
+					     const struct xfrm_migrate *m,
+					     const struct xfrm_encap_tmpl *encap,
+					     struct net *net,
+					     struct xfrm_user_offload *xuo,
+					     struct netlink_ext_ack *extack);
+int xfrm_state_migrate_install(const struct xfrm_state *x,
+			       struct xfrm_state *xc,
+			       const struct xfrm_migrate *m,
+			       struct xfrm_user_offload *xuo,
+			       struct netlink_ext_ack *extack);
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
 				      struct xfrm_encap_tmpl *encap,
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index a94f82f1354e4522673c9ed8d89cd9b9879c42ab..9060a6c399fd2befc09751f106e0f138990c9a2a 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1966,8 +1966,8 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
 }
 
 static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
-					   struct xfrm_encap_tmpl *encap,
-					   struct xfrm_migrate *m)
+					   const struct xfrm_encap_tmpl *encap,
+					   const struct xfrm_migrate *m)
 {
 	struct net *net = xs_net(orig);
 	struct xfrm_state *x = xfrm_state_alloc(net);
@@ -2125,12 +2125,12 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 }
 EXPORT_SYMBOL(xfrm_migrate_state_find);
 
-struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
-				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap,
-				      struct net *net,
-				      struct xfrm_user_offload *xuo,
-				      struct netlink_ext_ack *extack)
+struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
+					     const struct xfrm_migrate *m,
+					     const struct xfrm_encap_tmpl *encap,
+					     struct net *net,
+					     struct xfrm_user_offload *xuo,
+					     struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
 
@@ -2145,24 +2145,57 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
 		goto error;
 
-	/* add state */
+	return xc;
+error:
+	xc->km.state = XFRM_STATE_DEAD;
+	xfrm_state_put(xc);
+	return NULL;
+}
+EXPORT_SYMBOL(xfrm_state_migrate_create);
+
+int xfrm_state_migrate_install(const struct xfrm_state *x,
+			       struct xfrm_state *xc,
+			       const struct xfrm_migrate *m,
+			       struct xfrm_user_offload *xuo,
+			       struct netlink_ext_ack *extack)
+{
 	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
-		/* a care is needed when the destination address of the
-		   state is to be updated as it is a part of triplet */
+		/*
+		 * Care is needed when the destination address
+		 * of the state is to be updated as it is a part of triplet.
+		 */
 		xfrm_state_insert(xc);
 	} else {
-		if (xfrm_state_add(xc) < 0)
-			goto error_add;
+		if (xfrm_state_add(xc) < 0) {
+			if (xuo)
+				xfrm_dev_state_delete(xc);
+			xc->km.state = XFRM_STATE_DEAD;
+			xfrm_state_put(xc);
+			return -EEXIST;
+		}
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL(xfrm_state_migrate_install);
+
+struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
+				      struct xfrm_migrate *m,
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack)
+{
+	struct xfrm_state *xc;
+
+	xc = xfrm_state_migrate_create(x, m, encap, net, xuo, extack);
+	if (!xc)
+		return NULL;
+
+	if (xfrm_state_migrate_install(x, xc, m, xuo, extack) < 0)
+		return NULL;
+
 	return xc;
-error_add:
-	if (xuo)
-		xfrm_dev_state_delete(xc);
-error:
-	xc->km.state = XFRM_STATE_DEAD;
-	xfrm_state_put(xc);
-	return NULL;
 }
 EXPORT_SYMBOL(xfrm_state_migrate);
 #endif

-- 
2.47.3

