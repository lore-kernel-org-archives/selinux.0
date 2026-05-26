Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C73C09EE;
	Tue, 26 May 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822609; cv=none; b=Y1HpKbVkHJxcsSfk+mLhX3jYSz5Li36v4zOUTz5o2tV8cYTyO2klBShvADVv8SUMFTddqpoE8odaTzSQ1FiwF7abUEsK3r6xiCa172h83gJrpvWxAD5oDcJi+Kmf/sn2pxyx7kTT4442M0X/MxMRdZJkWnynr69J5OySw3XLSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822609; c=relaxed/simple;
	bh=QK2i2Bq/nhF7aHlB6JXUdD5jlE9VPleL08UE+bghHaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BojA/M6h5lmsaB24m2K8hd2jr4AL01qIbT3iL+3QRsoTezx1xeKn46CMtvB+8ujtTSYfaDq+OzEBz9v1IwAotvrslq2aR7K1E5RwnFJqf8Rk/oU8dG4ITzNIzh+OLNDT6QIgo7qI2+3DNHORbc04Woi+lS9Wuv8EAjiAX3WzXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hSrmOQXD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hSrmOQXD"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id ACC1D201E4;
	Tue, 26 May 2026 21:10:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id usiG9SscpfnC; Tue, 26 May 2026 21:10:04 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 32807201A7;
	Tue, 26 May 2026 21:10:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 32807201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822604;
	bh=Ws2Sfofwv0srySFvtnHog6qEye1UezUgWfDfvVO8HsY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=hSrmOQXDdtEoyuwZvzM94uk2CIwhvkpZ5sx5mK07V4QWRiXb2tke+V0EbkfTdf9sr
	 W3mCqlQrQ8pz/9nlybeYkjsy+tpz1uFawV/YEUugi+PMHoa+cYTKIQG2YbY8nI/VFK
	 6o8E1+hevzjipzIUW+nYdDuHiMslOqbK7JEDwdWH+PJK29JMiFKASei8N3SSjFQhS0
	 cb8yfprDu0cUOvBlvhGEwVS8T/JE8HknhneA5wHNF5BF3TZW0JkqjVG5FpewRx+sKr
	 VDb3zkeu33LzCHSYt87vjYxyCiBmmFIvIm61YGDQv69zFpSqtY26HehcT2rNqUBm+O
	 fyBQFH30fDixQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:10:02 +0200
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
Subject: [PATCH ipsec-next v9 14/16] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
Date: Tue, 26 May 2026 21:09:51 +0200
Message-ID: <migrate-state-v9-14-ad9947e4ae74@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

Add a new netlink method to migrate a single xfrm_state.
Unlike the existing migration mechanism (SA + policy), this
supports migrating only the SA and allows changing the reqid.

The SA is looked up via xfrm_usersa_id, which uniquely
identifies it, so old_saddr is not needed. old_daddr is carried in
xfrm_usersa_id.daddr.

The reqid is invariant in the old migration.

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v8->v9: - fix smark size estimate (Steffen)
  - pass net from caller in xfrm_send_migrate_state()(Steffen: 7e2a4f7ca095)
  - fix race condition in xfrm_do_migrate_state(): check km.state
    under x->lock before migrate_sync/delete to prevent concurrent
    migrations (sashiko AI review)
  - add XFRM_MIGRATE_STATE_KNOWN_FLAGS to uapi; reject unknown flags with -EINVAL and extack string
  - pre-check new SA tuple before migration
  - add XFRM_MSG_MIGRATE_STATE for single SA migration: SQUASH
  - add xfrm_compat.c support for XFRM_MSG_MIGRATE_STATE
  - fix uninitialized msg_type in PF_KEY migrate path
  - new_mark handling point to x->mark directly, drop new_marks[] array
  - fix UPDATE_SEL family check to use props.family instead of sel.family
  - extract xso_to_xuo() helper, fix duplication
  - drop extra check XFRMA_OFFLOAD_DEV takes precedence
  - rename XFRM_MIGRATE_STATE_NO_OFFLOAD -> XFRM_MIGRATE_STATE_CLEAR_OFFLOAD
  - rename XFRM_MIGRATE_STATE_UPDATE_SEL -> XFRM_MIGRATE_STATE_UPDATE_H2H_SEL
  - use nla_get_u32_default() when possible
  - use verify_selector_prefixlen()
  - split const xfrm_user_offload *xuo cleanup into separate patch (Sabrina)
v7->v8: - removed the unknown-flags validation block
v6->v7: - add flags field to xfrm_user_migrate_state (based on Sabrina's feedback)
  - add XFRM_MIGRATE_STATE_NO_OFFLOAD (bit 0): suppresses offload
  - omit-to-inherit; mutually exclusive with XFRMA_OFFLOAD_DEV
  - zero-initialize struct xfrm_migrate m[XFRM_MAX_DEPTH]
  - add struct xfrm_selector new_sel to xfrm_user_migrate_state
  - add XFRM_MIGRATE_STATE_UPDATE_SEL: derive new selector
    from SA addresses when old selector is a single-host match
v5->v6: - (Feedback from Sabrina's review)
  - reqid change: use xfrm_state_add, not xfrm_state_insert
  - encap and xuo: use nla_data() directly, no kmemdup needed
  - notification failure is non-fatal: set extack warning, return 0
  - drop state direction, x->dir, check, not required
  - reverse xmas tree local variable ordering
  - use NL_SET_ERR_MSG_WEAK for clone failure message
  - fix implicit padding in xfrm_user_migrate_state uapi struct
  - support XFRMA_SET_MARK/XFRMA_SET_MARK_MASK in XFRM_MSG_MIGRATE_STATE
v4->v5: - set portid, seq in XFRM_MSG_MIGRATE_STATE netlink notification
  - rename error label to out for clarity
  - add locking and synchronize after cloning
  - change some if(x) to if(!x) for clarity
  - call __xfrm_state_delete() inside the lock
  - return error from xfrm_send_migrate_state() instead of always returning 0
v3->v4: preserve reqid invariant for each state migrated
v2->v3: free the skb on the error path
v1->v2: merged next patch here to fix use uninitialized value
  - removed unnecessary inline
  - added const when possible

xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration : SQUASH
---
 include/net/xfrm.h          |  10 +-
 include/uapi/linux/xfrm.h   |  25 ++++
 net/xfrm/xfrm_compat.c      |   5 +-
 net/xfrm/xfrm_policy.c      |  17 +++
 net/xfrm/xfrm_state.c       |  29 +++-
 net/xfrm/xfrm_user.c        | 333 +++++++++++++++++++++++++++++++++++++++++++-
 security/selinux/nlmsgtab.c |   3 +-
 7 files changed, 405 insertions(+), 17 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 5515c7b10020..e2cb2d0e5cee 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -684,12 +684,20 @@ struct xfrm_migrate {
 	xfrm_address_t		new_saddr;
 	struct xfrm_encap_tmpl *encap;
 	struct xfrm_user_offload *xuo;
+	struct xfrm_mark        old_mark;
+	const struct xfrm_mark *new_mark;
+	struct xfrm_mark        smark;
 	u8			proto;
 	u8			mode;
-	u16			reserved;
+	u16			msg_type; /* XFRM_MSG_MIGRATE or XFRM_MSG_MIGRATE_STATE */
+	u32			flags;
 	u32			old_reqid;
+	u32			new_reqid;
+	u32			nat_keepalive_interval;
+	u32			mapping_maxage;
 	u16			old_family;
 	u16			new_family;
+	const struct xfrm_selector *new_sel;
 };
 
 #define XFRM_KM_TIMEOUT                30
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index a23495c0e0a1..051f8066efd1 100644
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
@@ -507,6 +510,28 @@ struct xfrm_user_migrate {
 	__u16				new_family;
 };
 
+struct xfrm_user_migrate_state {
+	struct xfrm_usersa_id id;
+	xfrm_address_t new_daddr;
+	xfrm_address_t new_saddr;
+	struct xfrm_mark old_mark;
+	struct xfrm_selector new_sel;
+	__u32 new_reqid;
+	__u32 flags;
+	__u16 new_family;
+	__u16 reserved;
+};
+
+/* Flags for xfrm_user_migrate_state.flags */
+enum xfrm_migrate_state_flags {
+	XFRM_MIGRATE_STATE_CLEAR_OFFLOAD = 1, /* do not inherit offload from existing SA */
+	XFRM_MIGRATE_STATE_UPDATE_H2H_SEL = 2, /* update H2H selector from new daddr/saddr */
+};
+
+/* All flags defined as of this header version; unknown bits are rejected. */
+#define XFRM_MIGRATE_STATE_KNOWN_FLAGS \
+	(XFRM_MIGRATE_STATE_CLEAR_OFFLOAD | XFRM_MIGRATE_STATE_UPDATE_H2H_SEL)
+
 struct xfrm_user_mapping {
 	struct xfrm_usersa_id		id;
 	__u32				reqid;
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index b8d2e6930041..670e3512fc09 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -94,7 +94,8 @@ static const int compat_msg_min[XFRM_NR_MSGTYPES] = {
 	[XFRM_MSG_GETSADINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_NEWSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
-	[XFRM_MSG_MAPPING     - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_mapping)
+	[XFRM_MSG_MAPPING        - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_mapping),
+	[XFRM_MSG_MIGRATE_STATE  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_migrate_state),
 };
 
 static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
@@ -162,6 +163,7 @@ static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
 	case XFRM_MSG_NEWAE:
 	case XFRM_MSG_REPORT:
 	case XFRM_MSG_MIGRATE:
+	case XFRM_MSG_MIGRATE_STATE:
 	case XFRM_MSG_NEWSADINFO:
 	case XFRM_MSG_NEWSPDINFO:
 	case XFRM_MSG_MAPPING:
@@ -498,6 +500,7 @@ static int xfrm_xlate32(struct nlmsghdr *dst, const struct nlmsghdr *src,
 	case XFRM_MSG_GETAE:
 	case XFRM_MSG_REPORT:
 	case XFRM_MSG_MIGRATE:
+	case XFRM_MSG_MIGRATE_STATE:
 	case XFRM_MSG_NEWSADINFO:
 	case XFRM_MSG_GETSADINFO:
 	case XFRM_MSG_NEWSPDINFO:
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index cf05d778e2dd..1c558362d375 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4643,6 +4643,21 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
 	return 0;
 }
 
+/*
+ * Fill migrate fields that are invariant in XFRM_MSG_MIGRATE: inherited
+ * from the existing SA unchanged. XFRM_MSG_MIGRATE_STATE can update these.
+ */
+static void xfrm_migrate_copy_old(const struct xfrm_state *x,
+				  struct xfrm_migrate *mp)
+{
+	mp->msg_type               = XFRM_MSG_MIGRATE;
+	mp->smark                  = x->props.smark;
+	mp->new_reqid              = x->props.reqid;
+	mp->nat_keepalive_interval = x->nat_keepalive_interval;
+	mp->mapping_maxage         = x->mapping_maxage;
+	mp->new_mark               = &x->mark;
+}
+
 int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_migrate,
 		 struct xfrm_kmaddress *k, struct net *net,
@@ -4682,6 +4697,8 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			nx_cur++;
 			mp->encap = encap;
 			mp->xuo = xuo;
+			xfrm_migrate_copy_old(x, mp);
+
 			xc = xfrm_state_migrate(x, mp, net, extack);
 			if (xc) {
 				x_new[nx_new] = xc;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 043e573c4f32..2c738e980b3f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1974,11 +1974,25 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 		goto out;
 
 	memcpy(&x->id, &orig->id, sizeof(x->id));
-	memcpy(&x->sel, &orig->sel, sizeof(x->sel));
+	if (m->msg_type == XFRM_MSG_MIGRATE_STATE) {
+		if (m->flags & XFRM_MIGRATE_STATE_UPDATE_H2H_SEL) {
+			u8 prefixlen = (m->new_family == AF_INET6) ? 128 : 32;
+
+			x->sel             = orig->sel;
+			x->sel.family      = m->new_family;
+			x->sel.prefixlen_d = prefixlen;
+			x->sel.prefixlen_s = prefixlen;
+			x->sel.daddr       = m->new_daddr;
+			x->sel.saddr       = m->new_saddr;
+		} else {
+			x->sel = *m->new_sel;
+		}
+	} else {
+		x->sel = orig->sel;
+	}
 	memcpy(&x->lft, &orig->lft, sizeof(x->lft));
 	x->props.mode = orig->props.mode;
 	x->props.replay_window = orig->props.replay_window;
-	x->props.reqid = orig->props.reqid;
 
 	if (orig->aalg) {
 		x->aalg = xfrm_algo_auth_clone(orig->aalg);
@@ -2011,8 +2025,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 		x->encap = kmemdup(m->encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
-		x->mapping_maxage = orig->mapping_maxage;
-		x->nat_keepalive_interval = orig->nat_keepalive_interval;
+		x->mapping_maxage = m->mapping_maxage;
+		x->nat_keepalive_interval = m->nat_keepalive_interval;
 	}
 
 	if (orig->security)
@@ -2029,8 +2043,9 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	if (xfrm_replay_clone(x, orig))
 		goto error;
 
-	memcpy(&x->mark, &orig->mark, sizeof(x->mark));
-	memcpy(&x->props.smark, &orig->props.smark, sizeof(x->props.smark));
+	x->mark = m->new_mark ? *m->new_mark : m->old_mark;
+
+	x->props.smark = m->smark;
 
 	x->props.flags = orig->props.flags;
 	x->props.extra_flags = orig->props.extra_flags;
@@ -2053,7 +2068,7 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 			goto error;
 	}
 
-
+	x->props.reqid = m->new_reqid;
 	x->props.family = m->new_family;
 	memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
 	memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c7ae670212a9..fca7b02e0e02 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1195,6 +1195,16 @@ static int copy_sec_ctx(struct xfrm_sec_ctx *s, struct sk_buff *skb)
 	return 0;
 }
 
+static void xso_to_xuo(const struct xfrm_dev_offload *xso,
+		       struct xfrm_user_offload *xuo)
+{
+	xuo->ifindex = xso->dev->ifindex;
+	if (xso->dir == XFRM_DEV_OFFLOAD_IN)
+		xuo->flags = XFRM_OFFLOAD_INBOUND;
+	if (xso->type == XFRM_DEV_OFFLOAD_PACKET)
+		xuo->flags |= XFRM_OFFLOAD_PACKET;
+}
+
 static int copy_user_offload(struct xfrm_dev_offload *xso, struct sk_buff *skb)
 {
 	struct xfrm_user_offload *xuo;
@@ -1206,11 +1216,7 @@ static int copy_user_offload(struct xfrm_dev_offload *xso, struct sk_buff *skb)
 
 	xuo = nla_data(attr);
 	memset(xuo, 0, sizeof(*xuo));
-	xuo->ifindex = xso->dev->ifindex;
-	if (xso->dir == XFRM_DEV_OFFLOAD_IN)
-		xuo->flags = XFRM_OFFLOAD_INBOUND;
-	if (xso->type == XFRM_DEV_OFFLOAD_PACKET)
-		xuo->flags |= XFRM_OFFLOAD_PACKET;
+	xso_to_xuo(xso, xuo);
 
 	return 0;
 }
@@ -1335,7 +1341,7 @@ static int copy_to_user_encap(struct xfrm_encap_tmpl *ep, struct sk_buff *skb)
 	return 0;
 }
 
-static int xfrm_smark_put(struct sk_buff *skb, struct xfrm_mark *m)
+static int xfrm_smark_put(struct sk_buff *skb, const struct xfrm_mark *m)
 {
 	int ret = 0;
 
@@ -3084,6 +3090,25 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 #ifdef CONFIG_XFRM_MIGRATE
+static void copy_from_user_migrate_state(struct xfrm_migrate *ma,
+					 const struct xfrm_user_migrate_state *um)
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
+	ma->old_mark = um->old_mark;
+	ma->flags    = um->flags;
+	ma->new_sel  = &um->new_sel;
+	ma->msg_type = XFRM_MSG_MIGRATE_STATE;
+}
+
 static int copy_from_user_migrate(struct xfrm_migrate *ma,
 				  struct xfrm_kmaddress *k,
 				  struct nlattr **attrs, int *num,
@@ -3123,6 +3148,7 @@ static int copy_from_user_migrate(struct xfrm_migrate *ma,
 
 		ma->old_family = um->old_family;
 		ma->new_family = um->new_family;
+		ma->msg_type   = XFRM_MSG_MIGRATE;
 	}
 
 	*num = i;
@@ -3133,7 +3159,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 			   struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct xfrm_userpolicy_id *pi = nlmsg_data(nlh);
-	struct xfrm_migrate m[XFRM_MAX_DEPTH];
+	struct xfrm_migrate m[XFRM_MAX_DEPTH] = {};
 	struct xfrm_kmaddress km, *kmp;
 	u8 type;
 	int err;
@@ -3186,7 +3212,298 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	kfree(xuo);
 	return err;
 }
+
+static int build_migrate_state(struct sk_buff *skb,
+			       const struct xfrm_user_migrate_state *um,
+			       const struct xfrm_migrate *m,
+			       u8 dir, u32 portid, u32 seq)
+{
+	int err;
+	struct nlmsghdr *nlh;
+	struct xfrm_user_migrate_state *hdr;
+
+	nlh = nlmsg_put(skb, portid, seq, XFRM_MSG_MIGRATE_STATE,
+			sizeof(struct xfrm_user_migrate_state), 0);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	hdr = nlmsg_data(nlh);
+	*hdr = *um;
+	hdr->new_sel = *m->new_sel;
+
+	if (m->encap) {
+		err = nla_put(skb, XFRMA_ENCAP, sizeof(*m->encap), m->encap);
+		if (err)
+			goto out_cancel;
+	}
+
+	if (m->xuo) {
+		err = nla_put(skb, XFRMA_OFFLOAD_DEV, sizeof(*m->xuo), m->xuo);
+		if (err)
+			goto out_cancel;
+	}
+
+	if (m->new_mark) {
+		err = nla_put(skb, XFRMA_MARK, sizeof(*m->new_mark),
+			      m->new_mark);
+		if (err)
+			goto out_cancel;
+	}
+
+	err = xfrm_smark_put(skb, &m->smark);
+	if (err)
+		goto out_cancel;
+
+	if (m->mapping_maxage) {
+		err = nla_put_u32(skb, XFRMA_MTIMER_THRESH, m->mapping_maxage);
+		if (err)
+			goto out_cancel;
+	}
+
+	if (m->nat_keepalive_interval) {
+		err = nla_put_u32(skb, XFRMA_NAT_KEEPALIVE_INTERVAL,
+				  m->nat_keepalive_interval);
+		if (err)
+			goto out_cancel;
+	}
+
+	if (dir) {
+		err = nla_put_u8(skb, XFRMA_SA_DIR, dir);
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
+static unsigned int xfrm_migrate_state_msgsize(const struct xfrm_migrate *m,
+					       u8 dir)
+{
+	return NLMSG_ALIGN(sizeof(struct xfrm_user_migrate_state)) +
+		(m->encap ? nla_total_size(sizeof(struct xfrm_encap_tmpl)) : 0) +
+		(m->xuo ? nla_total_size(sizeof(struct xfrm_user_offload)) : 0) +
+		(m->new_mark ? nla_total_size(sizeof(struct xfrm_mark)) : 0) +
+		((m->smark.v | m->smark.m) ? nla_total_size(sizeof(u32)) * 2 : 0) +
+		(m->mapping_maxage ? nla_total_size(sizeof(u32)) : 0) +
+		(m->nat_keepalive_interval ? nla_total_size(sizeof(u32)) : 0) +
+		(dir ? nla_total_size(sizeof(u8)) : 0); /* XFRMA_SA_DIR */
+}
+
+static int xfrm_send_migrate_state(struct net *net,
+				   const struct xfrm_user_migrate_state *um,
+				   const struct xfrm_migrate *m,
+				   u8 dir, u32 portid, u32 seq)
+{
+	int err;
+	struct sk_buff *skb;
+
+	skb = nlmsg_new(xfrm_migrate_state_msgsize(m, dir), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	err = build_migrate_state(skb, um, m, dir, portid, seq);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
+}
+
+static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
+				 struct nlattr **attrs, struct netlink_ext_ack *extack)
+{
+	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
+	struct net *net = sock_net(skb->sk);
+	struct xfrm_user_offload xuo = {};
+	struct xfrm_migrate m = {};
+	struct xfrm_state *xc;
+	struct xfrm_state *x;
+	int err;
+
+	if (!um->id.spi) {
+		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
+		return -EINVAL;
+	}
+
+	if (um->reserved) {
+		NL_SET_ERR_MSG(extack, "Reserved field must be zero");
+		return -EINVAL;
+	}
+
+	if (um->flags & ~XFRM_MIGRATE_STATE_KNOWN_FLAGS) {
+		NL_SET_ERR_MSG_FMT(extack, "Unknown flags: 0x%x",
+				   um->flags & ~XFRM_MIGRATE_STATE_KNOWN_FLAGS);
+		return -EINVAL;
+	}
+
+	err = verify_xfrm_family(um->new_family, extack);
+	if (err)
+		return err;
+
+	if (!(um->flags & XFRM_MIGRATE_STATE_UPDATE_H2H_SEL)) {
+		err = verify_selector_prefixlen(um->new_sel.family,
+						&um->new_sel, extack);
+		if (err)
+			return err;
+	}
+
+	copy_from_user_migrate_state(&m, um);
+
+	x = xfrm_state_lookup(net, m.old_mark.v & m.old_mark.m,
+			      &um->id.daddr, um->id.spi,
+			      um->id.proto, um->id.family);
+	if (!x) {
+		NL_SET_ERR_MSG(extack, "Can not find state");
+		return -ESRCH;
+	}
+
+	if (um->flags & XFRM_MIGRATE_STATE_UPDATE_H2H_SEL) {
+		u8 prefixlen = (x->props.family == AF_INET6) ? 128 : 32;
+
+		if (x->sel.prefixlen_s != x->sel.prefixlen_d ||
+		    x->sel.prefixlen_d != prefixlen ||
+		    !xfrm_addr_equal(&x->sel.daddr, &x->id.daddr, x->props.family) ||
+		    !xfrm_addr_equal(&x->sel.saddr, &x->props.saddr, x->props.family)) {
+			NL_SET_ERR_MSG(extack,
+				       "SA selector is not a single-host match for SA addresses");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (attrs[XFRMA_ENCAP]) {
+		m.encap = nla_data(attrs[XFRMA_ENCAP]);
+		if (m.encap->encap_type == 0) {
+			m.encap = NULL; /* sentinel: remove encap */
+		} else if (m.encap->encap_type != UDP_ENCAP_ESPINUDP) {
+			NL_SET_ERR_MSG(extack, "Unsupported encapsulation type");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		m.encap = x->encap; /* omit-to-inherit */
+	}
+
+	if (attrs[XFRMA_MTIMER_THRESH]) {
+		err = verify_mtimer_thresh(!!m.encap, x->dir, extack);
+		if (err)
+			goto out;
+	}
+
+	if (nla_get_u32_default(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL], 0) && !m.encap) {
+		NL_SET_ERR_MSG(extack,
+			       "NAT_KEEPALIVE_INTERVAL requires encapsulation");
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (attrs[XFRMA_OFFLOAD_DEV]) {
+		m.xuo = nla_data(attrs[XFRMA_OFFLOAD_DEV]);
+	} else {
+		bool inherit_offload = !(um->flags & XFRM_MIGRATE_STATE_CLEAR_OFFLOAD);
+
+		if (inherit_offload && x->xso.dev) {
+			xso_to_xuo(&x->xso, &xuo);
+			m.xuo = &xuo;
+		}
+	}
+
+	if (attrs[XFRMA_MARK])
+		m.new_mark = nla_data(attrs[XFRMA_MARK]);
+
+	if (attrs[XFRMA_SET_MARK])
+		xfrm_smark_init(attrs, &m.smark);
+	else
+		m.smark = x->props.smark;
+
+	m.mapping_maxage = nla_get_u32_default(attrs[XFRMA_MTIMER_THRESH],
+					       x->mapping_maxage);
+	m.nat_keepalive_interval = nla_get_u32_default(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL],
+						       x->nat_keepalive_interval);
+
+	if (m.new_family != um->id.family ||
+	    !xfrm_addr_equal(&m.new_daddr, &um->id.daddr, um->id.family)) {
+		u32 new_mark_key = m.new_mark ? m.new_mark->v & m.new_mark->m :
+						m.old_mark.v & m.old_mark.m;
+		struct xfrm_state *x_new;
+
+		x_new = xfrm_state_lookup(net, new_mark_key, &m.new_daddr,
+					  um->id.spi, um->id.proto, m.new_family);
+		if (x_new) {
+			xfrm_state_put(x_new);
+			NL_SET_ERR_MSG(extack, "New SA tuple already occupied");
+			err = -EEXIST;
+			goto out;
+		}
+	}
+
+	xc = xfrm_state_migrate_create(x, &m, net, extack);
+	if (!xc) {
+		NL_SET_ERR_MSG_WEAK(extack, "State migration clone failed");
+		err = -EINVAL;
+		goto out;
+	}
+
+	spin_lock_bh(&x->lock);
+	if (x->km.state != XFRM_STATE_VALID) {
+		spin_unlock_bh(&x->lock);
+		NL_SET_ERR_MSG(extack, "State already deleted");
+		err = -ESRCH;
+		goto out_xc;
+	}
+	xfrm_migrate_sync(xc, x); /* to prevent SN/IV reuse */
+	__xfrm_state_delete(x);
+	spin_unlock_bh(&x->lock);
+
+	err = xfrm_state_migrate_install(x, xc, &m, extack);
+	if (err < 0) {
+		/*
+		 * Should not occur: pre-check above ensures the new tuple is
+		 * free under xfrm_cfg_mutex. Both SAs are gone if it does;
+		 * restoring x would risk SN/IV reuse.
+		 */
+		goto out;
+	}
+
+	/* Restore encap cleared by sentinel (type=0) during migration. */
+	if (attrs[XFRMA_ENCAP])
+		m.encap = nla_data(attrs[XFRMA_ENCAP]);
+
+	m.new_sel = &xc->sel;
+	m.mapping_maxage = xc->mapping_maxage;
+	m.nat_keepalive_interval = xc->nat_keepalive_interval;
+
+	err = xfrm_send_migrate_state(net, um, &m, xc->dir,
+				      nlh->nlmsg_pid, nlh->nlmsg_seq);
+	if (err < 0) {
+		NL_SET_ERR_MSG(extack, "Failed to send migration notification");
+		err = 0;
+	}
+
+out:
+	xfrm_state_put(x);
+	return err;
+out_xc:
+	xc->km.state = XFRM_STATE_DEAD;
+	xfrm_state_put(xc);
+	xfrm_state_put(x);
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
@@ -3339,6 +3656,7 @@ const int xfrm_msg_min[XFRM_NR_MSGTYPES] = {
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
+	[XFRM_MSG_MIGRATE_STATE - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_migrate_state),
 };
 EXPORT_SYMBOL_GPL(xfrm_msg_min);
 
@@ -3432,6 +3750,7 @@ static const struct xfrm_link {
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
2.47.3

