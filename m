Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFC3C09E9;
	Tue, 26 May 2026 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822468; cv=none; b=G8/8x0zzWe2gGTDgfVS5nYbXyxW3gjRHMyOk/xho0J20ljM5Ot5lg4Ex30kLrFoKrQvc4rQigyUs5iquMcwi+Miczpyi59hxPIGLUI8NGi2G4/SUOPqp+0MRNcNbH67Dhg3yyxXvP+9tkL150Uu8sP1xEzJl6E6QxBCIcJUb7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822468; c=relaxed/simple;
	bh=Q4NHhl9ZAEwg4p0tFeYbLxM4xJad4JGgfbz9Dvgy3S8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAi8AqH79mlAtA6/bOUV6Cr4poWgGkSUCDPMuLbhdK6YPM4vN7LpOiOf/pxNcXEhqsOmesDUiPyHJ4b/X3QE4ry55yoaTixF1CWLHwYNDvsOxyz6Q7zuMT23mwhP22nnuUn5s75+Bz/ueszw8ggm5X5Qa1EmZIqMp8087UzyLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=I3qHY1Qr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="I3qHY1Qr"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 51683206B1;
	Tue, 26 May 2026 21:07:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XqqCRniUrAeh; Tue, 26 May 2026 21:07:44 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8E1FD201A7;
	Tue, 26 May 2026 21:07:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8E1FD201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822464;
	bh=nFBV3Hh9bYsWTBcJDt3K+jDQ7Biwup3fJVaFus+8pOU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=I3qHY1QrYqOTKJSfwjl5a5cfqWk18wZ52NvIPBDg2ZE9/hLrV4Gl0I8zvDqcdeerd
	 NIxEBgq+RKuss4gdG2JpI6nRfiGd7H7QNwUdbbHGI7MYFNmfEGIDrWN+pFMZSUUlzv
	 Du1/mysa7Hbrjm2SezH/Ij1geI4o+h8WLB5R3SMJ5e6h7x8gOJXULPTfyXC3cEaG95
	 g6DV5i8p8j6K4N540kjTQMHk+LyGC9ZjulUGv9itgdxkyOmekiFdAZa5hfEwkt/DLV
	 KrRcrg3QJzAh6aBIg+xJ4tWMEEjLxKUNYQ5wA+0YlEDnsbip3Emy5HS95PAANwh1vP
	 E65j78a9LX4cw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:07:42 +0200
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
Subject: [PATCH ipsec-next v9 06/16] xfrm: split xfrm_state_migrate into create and install functions
Date: Tue, 26 May 2026 21:07:30 +0200
Message-ID: <migrate-state-v9-6-ad9947e4ae74@secunet.com>
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

To prepare for subsequent patches, split
xfrm_state_migrate() into two functions:
- xfrm_state_migrate_create(): creates the migrated state
- xfrm_state_migrate_install(): installs it into the state table

splitting will help to avoid SN/IV reuse when migrating AEAD SA.

And add const whenever possible.
No functional change.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v8->v9: move comment reflow into this patch (Sabrina)
v4->v5: added this patch
---
 include/net/xfrm.h    | 11 ++++++++
 net/xfrm/xfrm_state.c | 73 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 368b1dc22e5c..4137986f15e2 100644
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
index 5424f2becbaf..85fd80520184 100644
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

