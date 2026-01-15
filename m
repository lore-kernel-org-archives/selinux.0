Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123A31355D;
	Thu, 15 Jan 2026 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464393; cv=none; b=sHDbNmUn9aD7CKFFjexerLGuTgdnHC3pms5FdN37nlJcBK/6l92fd+khM05XdpnRvoIo6YWauxNpdIeZfEn2/IRjS99T7hbF21dbEL5kjiS4p2KMZzC7Nilm50y6wDRETU1SWSAJrEcUKWW568v+hTBTvB/sCN2vOPzqxnaVumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464393; c=relaxed/simple;
	bh=5wSNSxE/+84dvRaoiZYtKNsgDW+o8LpXQcWD+JArCo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8oe61+7nFIB6fH7SanK2SUaVcIo7cYe77Gwgi/mEm0F+aKKObDy8hNt/apCBY1VpJBYs8NHJVWEVz9yXu8vSqC7yj6sUS01/WMTCKHIhGabc/r/LcBe7uzCUdav1VtsjSJmurVX6OWS3ZpIlUTNQzUfXXRoXdLe5sLLKt8n+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=MLu87Jfx; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="MLu87Jfx"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EC522208B0;
	Thu, 15 Jan 2026 09:06:23 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tgzT67rvDSTq; Thu, 15 Jan 2026 09:06:23 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 00B8120894;
	Thu, 15 Jan 2026 09:06:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 00B8120894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768464383;
	bh=1ZQ8UCD1/JFJ06foyidVKgbZGf/W18cxJte+8JopSmM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=MLu87Jfx41UZMzFbXLOlC4ADDQWVL/30H5FPXdsJTfg8YlKyqBGWHXFmSlVXVLF2e
	 iwsiVXdmTa9SV+I+BTlzPxo1ZmTZy3/muyUIvzE/cD6bI6qOY40d4EAFbIPi99EzDX
	 v8xmzAsb3alRdQIW42hdoYSlwX1HYvaR+LoRpzXGbKx4iFo8pG24aR/tXzhz6Z8d62
	 ykiFQiH+GbnvOdpYbPkZBF8ll48QJ6X/ZyGemIe3AS1ZUhpWpIaROvoMLwxhp9H+Sj
	 8CdTGg9nv1XLip8JAWbimh5IqE38OUT69Ny4sBJ+xVXDbC7xMFSuwusuzl6GulbCcG
	 eQq53rzo6qtEw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 09:06:21 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, Shinta Sugimoto <shinta.sugimoto@ericsson.com>,
	<devel@linux-ipsec.org>, Simon Horman <horms@kernel.org>, Paul Moore
	<paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>
Subject: [PATCH ipsec-next v2 4/4] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
Date: Thu, 15 Jan 2026 09:05:59 +0100
Message-ID: <33ff1bb0672e49e7e3ea2424a9a61ae621a2a28d.1768462955.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1768462955.git.antony.antony@secunet.com>
References: <cover.1768462955.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

Add a new netlink method to migrate a single xfrm_state.
Unlike the existing migration mechanism (SA + policy), this
supports migrating only the SA and allows changing the reqid.

The reqid is invarient in old migration.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v1->v2: merged next patch here to fix use uninitialized value
	- removed unnecessary inline
        - added const when possible
---
 include/net/xfrm.h          |   1 +
 include/uapi/linux/xfrm.h   |  11 +++
 net/xfrm/xfrm_state.c       |  19 +++--
 net/xfrm/xfrm_user.c        | 160 ++++++++++++++++++++++++++++++++++++
 security/selinux/nlmsgtab.c |   3 +-
 5 files changed, 185 insertions(+), 9 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 05fa0552523d..4147c5ba6093 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -686,6 +686,7 @@ struct xfrm_migrate {
 	u8			mode;
 	u16			reserved;
 	u32			old_reqid;
+	u32			new_reqid;
 	u16			old_family;
 	u16			new_family;
 };
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index a23495c0e0a1..60b1f201b237 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -227,6 +227,9 @@ enum {
 #define XFRM_MSG_SETDEFAULT XFRM_MSG_SETDEFAULT
 	XFRM_MSG_GETDEFAULT,
 #define XFRM_MSG_GETDEFAULT XFRM_MSG_GETDEFAULT
+
+	XFRM_MSG_MIGRATE_STATE,
+#define XFRM_MSG_MIGRATE_STATE XFRM_MSG_MIGRATE_STATE
 	__XFRM_MSG_MAX
 };
 #define XFRM_MSG_MAX (__XFRM_MSG_MAX - 1)
@@ -507,6 +510,14 @@ struct xfrm_user_migrate {
 	__u16				new_family;
 };

+struct xfrm_user_migrate_state {
+	struct xfrm_usersa_id id;
+	xfrm_address_t new_saddr;
+	xfrm_address_t new_daddr;
+	__u16 new_family;
+	__u32 new_reqid;
+};
+
 struct xfrm_user_mapping {
 	struct xfrm_usersa_id		id;
 	__u32				reqid;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index fe595d7f4398..f35630dea00f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1966,8 +1966,9 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
 }

 static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
-					   struct xfrm_encap_tmpl *encap,
-					   struct xfrm_migrate *m)
+					   const struct xfrm_encap_tmpl *encap,
+					   const struct xfrm_migrate *m,
+					   struct netlink_ext_ack *extack)
 {
 	struct net *net = xs_net(orig);
 	struct xfrm_state *x = xfrm_state_alloc(net);
@@ -1979,7 +1980,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	memcpy(&x->lft, &orig->lft, sizeof(x->lft));
 	x->props.mode = orig->props.mode;
 	x->props.replay_window = orig->props.replay_window;
-	x->props.reqid = orig->props.reqid;

 	if (orig->aalg) {
 		x->aalg = xfrm_algo_auth_clone(orig->aalg);
@@ -2058,7 +2058,7 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 			goto error;
 	}

-
+	x->props.reqid = m->new_reqid;
 	x->props.family = m->new_family;
 	memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
 	memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
@@ -2133,7 +2133,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 {
 	struct xfrm_state *xc;

-	xc = xfrm_state_clone_and_setup(x, encap, m);
+	xc = xfrm_state_clone_and_setup(x, encap, m, extack);
 	if (!xc)
 		return NULL;

@@ -2145,9 +2145,12 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 		goto error;

 	/* add state */
-	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
-		/* a care is needed when the destination address of the
-		   state is to be updated as it is a part of triplet */
+	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) ||
+	    x->props.reqid != xc->props.reqid) {
+		/*
+		 * a care is needed when the destination address or the reqid
+		 * of the state is to be updated as it is a part of triplet
+		 */
 		xfrm_state_insert(xc);
 	} else {
 		if (xfrm_state_add(xc) < 0)
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 26b82d94acc1..298d7c1454e5 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3052,6 +3052,22 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 }

 #ifdef CONFIG_XFRM_MIGRATE
+static int copy_from_user_migrate_state(struct xfrm_migrate *ma,
+					const struct xfrm_user_migrate_state *um)
+{
+	memcpy(&ma->old_daddr, &um->id.daddr, sizeof(ma->old_daddr));
+	memcpy(&ma->new_daddr, &um->new_daddr, sizeof(ma->new_daddr));
+	memcpy(&ma->new_saddr, &um->new_saddr, sizeof(ma->new_saddr));
+
+	ma->proto = um->id.proto;
+	ma->new_reqid = um->new_reqid;
+
+	ma->old_family = um->id.family;
+	ma->new_family = um->new_family;
+
+	return 0;
+}
+
 static int copy_from_user_migrate(struct xfrm_migrate *ma,
 				  struct xfrm_kmaddress *k,
 				  struct nlattr **attrs, int *num,
@@ -3088,6 +3104,7 @@ static int copy_from_user_migrate(struct xfrm_migrate *ma,
 		ma->proto = um->proto;
 		ma->mode = um->mode;
 		ma->old_reqid = um->reqid;
+		ma->new_reqid = um->reqid; /* reqid is invariant in XFRM_MSG_MIGRATE */

 		ma->old_family = um->old_family;
 		ma->new_family = um->new_family;
@@ -3154,7 +3171,148 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	kfree(xuo);
 	return err;
 }
+
+static int build_migrate_state(struct sk_buff *skb,
+			       const struct xfrm_user_migrate_state *m,
+			       const struct xfrm_encap_tmpl *encap,
+			       const struct xfrm_user_offload *xuo)
+{
+	int err;
+	struct nlmsghdr *nlh;
+	struct xfrm_user_migrate_state *um;
+
+	nlh = nlmsg_put(skb, 0, 0, XFRM_MSG_MIGRATE_STATE,
+			sizeof(struct xfrm_user_migrate_state), 0);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	um = nlmsg_data(nlh);
+	memset(um, 0, sizeof(*um));
+	memcpy(um, m, sizeof(*um));
+
+	if (encap) {
+		err = nla_put(skb, XFRMA_ENCAP, sizeof(*encap), encap);
+		if (err)
+			goto out_cancel;
+	}
+
+	if (xuo) {
+		err = nla_put(skb, XFRMA_OFFLOAD_DEV, sizeof(*xuo), xuo);
+		if (err)
+			goto out_cancel;
+	}
+
+	nlmsg_end(skb, nlh);
+	return 0;
+
+out_cancel:
+	nlmsg_cancel(skb, nlh);
+	return err;
+}
+
+static unsigned int xfrm_migrate_state_msgsize(bool with_encap, bool with_xuo)
+{
+	return NLMSG_ALIGN(sizeof(struct xfrm_user_migrate_state)) +
+		(with_encap ? nla_total_size(sizeof(struct xfrm_encap_tmpl)) : 0) +
+		(with_xuo ? nla_total_size(sizeof(struct xfrm_user_offload)) : 0);
+}
+
+static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state *um,
+				   const struct xfrm_encap_tmpl *encap,
+				   const struct xfrm_user_offload *xuo)
+{
+	int err;
+	struct sk_buff *skb;
+	struct net *net = &init_net;
+
+	skb = nlmsg_new(xfrm_migrate_state_msgsize(!!encap, !!xuo), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	err = build_migrate_state(skb, um, encap, xuo);
+	if (err < 0) {
+		WARN_ON(1);
+		return err;
+	}
+
+	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
+}
+
+static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
+				 struct nlattr **attrs, struct netlink_ext_ack *extack)
+{
+	int err = -ESRCH;
+	struct xfrm_state *x;
+	struct net *net = sock_net(skb->sk);
+	struct xfrm_encap_tmpl *encap = NULL;
+	struct xfrm_user_offload *xuo = NULL;
+	struct xfrm_migrate m = { .old_saddr.a4 = 0,};
+	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
+
+	if (!um->id.spi) {
+		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
+		return -EINVAL;
+	}
+
+	err = copy_from_user_migrate_state(&m, um);
+	if (err)
+		return err;
+
+	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
+
+	if (x) {
+		struct xfrm_state *xc;
+
+		if (!x->dir) {
+			NL_SET_ERR_MSG(extack, "State direction is invalid");
+			err = -EINVAL;
+			goto error;
+		}
+
+		if (attrs[XFRMA_ENCAP]) {
+			encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]),
+					sizeof(*encap), GFP_KERNEL);
+			if (!encap) {
+				err = -ENOMEM;
+				goto error;
+			}
+		}
+		if (attrs[XFRMA_OFFLOAD_DEV]) {
+			xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
+				      sizeof(*xuo), GFP_KERNEL);
+			if (!xuo) {
+				err = -ENOMEM;
+				goto error;
+			}
+		}
+		xc = xfrm_state_migrate(x, &m, encap, net, xuo, extack);
+		if (xc) {
+			xfrm_state_delete(x);
+			xfrm_send_migrate_state(um, encap, xuo);
+		} else {
+			if (extack && !extack->_msg)
+				NL_SET_ERR_MSG(extack, "State migration clone failed");
+			err = -EINVAL;
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Can not find state");
+		return err;
+	}
+error:
+	xfrm_state_put(x);
+	kfree(encap);
+	kfree(xuo);
+	return err;
+}
+
 #else
+static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
+				 struct nlattr **attrs, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG(extack, "XFRM_MSG_MIGRATE_STATE is not supported");
+	return -ENOPROTOOPT;
+}
+
 static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 			   struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
@@ -3307,6 +3465,7 @@ const int xfrm_msg_min[XFRM_NR_MSGTYPES] = {
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
+	[XFRM_MSG_MIGRATE_STATE - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_migrate_state),
 };
 EXPORT_SYMBOL_GPL(xfrm_msg_min);

@@ -3400,6 +3559,7 @@ static const struct xfrm_link {
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = { .doit = xfrm_get_spdinfo   },
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_set_default   },
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_get_default   },
+	[XFRM_MSG_MIGRATE_STATE - XFRM_MSG_BASE] = { .doit = xfrm_do_migrate_state },
 };

 static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 2c0b07f9fbbd..655d2616c9d2 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -128,6 +128,7 @@ static const struct nlmsg_perm nlmsg_xfrm_perms[] = {
 	{ XFRM_MSG_MAPPING, NETLINK_XFRM_SOCKET__NLMSG_READ },
 	{ XFRM_MSG_SETDEFAULT, NETLINK_XFRM_SOCKET__NLMSG_WRITE },
 	{ XFRM_MSG_GETDEFAULT, NETLINK_XFRM_SOCKET__NLMSG_READ },
+	{ XFRM_MSG_MIGRATE_STATE, NETLINK_XFRM_SOCKET__NLMSG_WRITE },
 };

 static const struct nlmsg_perm nlmsg_audit_perms[] = {
@@ -203,7 +204,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		 * structures at the top of this file with the new mappings
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
-		BUILD_BUG_ON(XFRM_MSG_MAX != XFRM_MSG_GETDEFAULT);
+		BUILD_BUG_ON(XFRM_MSG_MAX != XFRM_MSG_MIGRATE_STATE);

 		if (selinux_policycap_netlink_xperm()) {
 			*perm = NETLINK_XFRM_SOCKET__NLMSG;
--
2.39.5

