Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840C1CBEB9;
	Tue,  5 May 2026 04:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955662; cv=none; b=guFLcrWUkls6ZhppSgxBqgfYqTpGjrbX2oZpvdkIP8TMWiMyz4+geNTeIf/gmJqAyj9vZHooGcI2mV5snjL6FUiMXAQKTAiYeQ1vvMMEH9sbJE0rjO2ElnY+2nDkPZmxqWHy8dweVO/BT8GzQFonsIvN5gFadmKppEf5oaBclIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955662; c=relaxed/simple;
	bh=ROkQQjcozTbH+lK7rLa25VipnO9Von+LUjerRQL3oyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/OEDOoFjuwQ+UipLU0sd+635kLu64h0X5uWUihhu7O6za1S2yEW/J+5XIXfMVOPXm2XyiuF6KBnVkgBIMtSuVFK11jPzdGuBHDJXRnb7FeTNJY2zBRN5OBMirQ8YG+5/pVhQWe+KV+/uiUkltzZw4WNZb623+l3eZzUoC4UTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XJNvbzE6; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XJNvbzE6"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A1624206E9;
	Tue,  5 May 2026 06:34:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ObDISX7Pz7Eh; Tue,  5 May 2026 06:34:19 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E1E2420049;
	Tue,  5 May 2026 06:34:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E1E2420049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777955658;
	bh=emxtaJ2lESUwFih2fmaeQMZoNrIPoa8WZifNsod9eig=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=XJNvbzE66d4zgEtS3FcRlSBC1l2dnk/g3h54axH2piqr3yaIOwUxKF5az5/WaPAyL
	 dL05LnQWHZqAdBUSGQmz9fvbUDnVGrHGQSviNv4N7OuVsB0IV++ZzFfzEOXarI8UnG
	 3CjCZpTbm1J6gGmydokbCG7kxAH1o+ieh+K+qNNByLBZ9ydXOaPBTfy1tVEdJuRRlt
	 h7iet9B5pSpor2wph7ZVzivre869kQFcSd7ZRRymlMd3o+2dR05yv5/OfZbL3Suyxc
	 Bay+qPa1d1Vqe7PbLxZZTMs2VgtnrGgsLku2XyZrXOGntw0xHKRQoxC/A9NPS3O89X
	 2xko8gSmsLJXA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 06:34:15 +0200
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
Subject: [PATCH ipsec-next v8 10/14] xfrm: move encap and xuo into struct xfrm_migrate
Date: Tue, 5 May 2026 06:34:04 +0200
Message-ID: <migrate-state-v8-10-4578fb016965@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v8-0-4578fb016965@secunet.com>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
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

In preparation for an upcoming patch, move the xfrm_encap_tmpl and
xfrm_user_offload pointers from separate parameters into struct
xfrm_migrate, reducing the parameter count of
xfrm_state_migrate_create(), xfrm_state_migrate_install(), and
xfrm_state_migrate().

The fields are placed after the four xfrm_address_t members where
the struct is naturally 8-byte aligned, avoiding padding.

No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v5->v6: added this patch.
---
 include/net/xfrm.h     |  7 ++-----
 net/xfrm/xfrm_policy.c |  4 +++-
 net/xfrm/xfrm_state.c  | 20 +++++++-------------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index be22c26e4661..4b29ab92c2a7 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -682,6 +682,8 @@ struct xfrm_migrate {
 	xfrm_address_t		old_saddr;
 	xfrm_address_t		new_daddr;
 	xfrm_address_t		new_saddr;
+	struct xfrm_encap_tmpl *encap;
+	struct xfrm_user_offload *xuo;
 	u8			proto;
 	u8			mode;
 	u16			reserved;
@@ -1897,20 +1899,15 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 						u32 if_id);
 struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 					     const struct xfrm_migrate *m,
-					     const struct xfrm_encap_tmpl *encap,
 					     struct net *net,
-					     struct xfrm_user_offload *xuo,
 					     struct netlink_ext_ack *extack);
 int xfrm_state_migrate_install(const struct xfrm_state *x,
 			       struct xfrm_state *xc,
 			       const struct xfrm_migrate *m,
-			       struct xfrm_user_offload *xuo,
 			       struct netlink_ext_ack *extack);
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap,
 				      struct net *net,
-				      struct xfrm_user_offload *xuo,
 				      struct netlink_ext_ack *extack);
 int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_bundles,
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index fd505adf080e..cf05d778e2dd 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4680,7 +4680,9 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
 			x_cur[nx_cur] = x;
 			nx_cur++;
-			xc = xfrm_state_migrate(x, mp, encap, net, xuo, extack);
+			mp->encap = encap;
+			mp->xuo = xuo;
+			xc = xfrm_state_migrate(x, mp, net, extack);
 			if (xc) {
 				x_new[nx_new] = xc;
 				nx_new++;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1db48ecda80d..043e573c4f32 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1966,7 +1966,6 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
 }
 
 static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
-					   const struct xfrm_encap_tmpl *encap,
 					   const struct xfrm_migrate *m)
 {
 	struct net *net = xs_net(orig);
@@ -2008,8 +2007,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	}
 	x->props.calgo = orig->props.calgo;
 
-	if (encap) {
-		x->encap = kmemdup(encap, sizeof(*x->encap), GFP_KERNEL);
+	if (m->encap) {
+		x->encap = kmemdup(m->encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
 		x->mapping_maxage = orig->mapping_maxage;
@@ -2122,14 +2121,12 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);
 
 struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 					     const struct xfrm_migrate *m,
-					     const struct xfrm_encap_tmpl *encap,
 					     struct net *net,
-					     struct xfrm_user_offload *xuo,
 					     struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
 
-	xc = xfrm_state_clone_and_setup(x, encap, m);
+	xc = xfrm_state_clone_and_setup(x, m);
 	if (!xc) {
 		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");
 		return NULL;
@@ -2141,7 +2138,7 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 	}
 
 	/* configure the hardware if offload is requested */
-	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
+	if (m->xuo && xfrm_dev_state_add(net, xc, m->xuo, extack))
 		goto error;
 
 	return xc;
@@ -2155,7 +2152,6 @@ EXPORT_SYMBOL(xfrm_state_migrate_create);
 int xfrm_state_migrate_install(const struct xfrm_state *x,
 			       struct xfrm_state *xc,
 			       const struct xfrm_migrate *m,
-			       struct xfrm_user_offload *xuo,
 			       struct netlink_ext_ack *extack)
 {
 	if (m->new_family == m->old_family &&
@@ -2168,7 +2164,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 	} else {
 		if (xfrm_state_add(xc) < 0) {
 			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
-			if (xuo)
+			if (m->xuo)
 				xfrm_dev_state_delete(xc);
 			xc->km.state = XFRM_STATE_DEAD;
 			xfrm_state_put(xc);
@@ -2182,20 +2178,18 @@ EXPORT_SYMBOL(xfrm_state_migrate_install);
 
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap,
 				      struct net *net,
-				      struct xfrm_user_offload *xuo,
 				      struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
 
-	xc = xfrm_state_migrate_create(x, m, encap, net, xuo, extack);
+	xc = xfrm_state_migrate_create(x, m, net, extack);
 	if (!xc)
 		return NULL;
 
 	xfrm_migrate_sync(xc, x);
 
-	if (xfrm_state_migrate_install(x, xc, m, xuo, extack) < 0)
+	if (xfrm_state_migrate_install(x, xc, m, extack) < 0)
 		return NULL;
 
 	return xc;

-- 
2.47.3

