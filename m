Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3F33B97A;
	Mon,  9 Mar 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082054; cv=none; b=PEacTU0tN0vgvZw1EA+zpTrLPFwfH/BffIbQwCJrXdsD9KYdUmEQ5NAZkiX/mBMWfiMe3F3euGKWWd9ggMv3ZpT4YgKg24gtAmzFuTbwjgLQfOWkAGQwzHqWj3i+sZ27xiysnvmAnkv6b/fNmudHo4hXcEqNPOq2bSvv4hz0fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082054; c=relaxed/simple;
	bh=PXNh3xox5WnWzptuKWQpGcybhYew2NAI0/42i3zq+CY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/qRW+BSXY2a8Dslsdg4unLxz5DtSzQ5AxErQFogVmiUsRl9AY9ikrkpiDEShFC3FCpeiQI7CflxgQDn7kQuA4/iy/3DIa0E+dU8AnGZZQlYLhIJorsRIbkr+putTR4SEL/25h/wWtBIpkND9cannpm0Bq2/F/ZxUKRGiyrtEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kmH0QhxK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kmH0QhxK"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2893020612;
	Mon,  9 Mar 2026 19:47:31 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRV9na-bYD0h; Mon,  9 Mar 2026 19:47:29 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 765D520538;
	Mon,  9 Mar 2026 19:47:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 765D520538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773082049;
	bh=sfZxroz9e1r0yMjtAotHm46ag6xCtt0xXs0cACQ+Ujg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=kmH0QhxKd5Oo6GQf+tSi9jSoSFdTPkfy9d+lN5kxe46AoJxrgLSFHaxWTAF8kZE13
	 j6yAtkoBjJSfdgAM+785VdFRiFHb9Byg9qdbhLPAtH1kbj2vPgbPx6MYIk+MYUp8Ra
	 UKR88wgfNCevZKMVhfQr2dlVTUTdygonzZxPh9WcnY98Qh3VdFjUCAdldFMIyv5v/N
	 HrIDhhtA83G1owD+j3w1yljB5S0R7dSMPHjefimfGUyzOz9bdB/rQ22vsEa+pf5idh
	 qmUW/2yz4s9flAd2zPporMT7l1qFRKcXPT2L1+9G7WlfbKx1VoE6ifftLbPdP0CqWU
	 9uaX1Sx+CrHLQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 19:47:27 +0100
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
Subject: [PATCH ipsec-next v6 12/14] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
Date: Mon, 9 Mar 2026 19:47:17 +0100
Message-ID: <migrate-state-v6-12-9df9764ddb9e@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
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
v5->v6: - (Feedback from Sabrina's review)
  - reqid change: use xfrm_state_add, not xfrm_state_insert
  - encap and xuo: use nla_data() directly, no kmemdup needed
  - notification failure is non-fatal: set extack warning, return 0
  - drop state direction, x->dir, check, not required
  - reverse xmas tree local variable ordering
  - use NL_SET_ERR_MSG_WEAK for clone failure message
  - fix implicit padding in xfrm_user_migrate_state uapi struct
  - support XFRMA_SET_MARK/XFRMA_SET_MARK_MASK in XFRM_MSG_MIGRATE_STATE
Link: https://lore.kernel.org/all/b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com/ [v5]
v4->v5: - set portid, seq in XFRM_MSG_MIGRATE_STATE netlink notification
  - rename error label to out for clarity
  - add locking and synchronize after cloning
  - change some if(x) to if(!x) for clarity
  - call __xfrm_state_delete() inside the lock
  - return error from xfrm_send_migrate_state() instead of always returning 0
Link: https://lore.kernel.org/all/b134abaf18390d1bcdd59d2192687bac0e2c2710.1768811736.git.antony.antony@secunet.com/ [v4]
v3->v4: preserve reqid invariant for each state migrated
v2->v3: free the skb on the error path
v1->v2: merged next patch here to fix use uninitialized value
  - removed unnecessary inline
  - added const when possible
---
 include/net/xfrm.h          |  14 ++-
 include/uapi/linux/xfrm.h   |  13 +++
 net/xfrm/xfrm_device.c      |   2 +-
 net/xfrm/xfrm_policy.c      |  18 +++-
 net/xfrm/xfrm_state.c       |  16 +--
 net/xfrm/xfrm_user.c        | 251 +++++++++++++++++++++++++++++++++++++++++++-
 security/selinux/nlmsgtab.c |   3 +-
 7 files changed, 302 insertions(+), 15 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 4b29ab92c2a73533795825034cd5e4e12538cb83..ae2a1cf2311af55d3c436ed069272a1d19f01f97 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -683,11 +683,17 @@ struct xfrm_migrate {
 	xfrm_address_t		new_daddr;
 	xfrm_address_t		new_saddr;
 	struct xfrm_encap_tmpl *encap;
-	struct xfrm_user_offload *xuo;
+	struct xfrm_user_offload xuo;
+	struct xfrm_mark        old_mark;
+	struct xfrm_mark        new_mark;
+	struct xfrm_mark        smark;
 	u8			proto;
 	u8			mode;
 	u16			reserved;
 	u32			old_reqid;
+	u32			new_reqid;
+	u32			nat_keepalive_interval;
+	u32			mapping_maxage;
 	u16			old_family;
 	u16			new_family;
 };
@@ -2104,7 +2110,7 @@ void xfrm_dev_resume(struct sk_buff *skb);
 void xfrm_dev_backlog(struct softnet_data *sd);
 struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t features, bool *again);
 int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
-		       struct xfrm_user_offload *xuo,
+		       const struct xfrm_user_offload *xuo,
 		       struct netlink_ext_ack *extack);
 int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 			struct xfrm_user_offload *xuo, u8 dir,
@@ -2175,7 +2181,9 @@ static inline struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_fea
 	return skb;
 }
 
-static inline int xfrm_dev_state_add(struct net *net, struct xfrm_state *x, struct xfrm_user_offload *xuo, struct netlink_ext_ack *extack)
+static inline int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
+				     const struct xfrm_user_offload *xuo,
+				     struct netlink_ext_ack *extack)
 {
 	return 0;
 }
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index a23495c0e0a109c428080d207f59f7581336537f..eed74e1c4061f167e0898b06e111f32a56ba9c2b 100644
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
@@ -507,6 +510,16 @@ struct xfrm_user_migrate {
 	__u16				new_family;
 };
 
+struct xfrm_user_migrate_state {
+	struct xfrm_usersa_id id;
+	xfrm_address_t new_daddr;
+	xfrm_address_t new_saddr;
+	__u16 new_family;
+	__u16 reserved;
+	__u32 new_reqid;
+	struct xfrm_mark old_mark;
+};
+
 struct xfrm_user_mapping {
 	struct xfrm_usersa_id		id;
 	__u32				reqid;
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 52ae0e034d29e265af5eeaf03df8fd973d8dbf9f..9d4c1addb98f61dd4a19177aedb673749262060c 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -229,7 +229,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 EXPORT_SYMBOL_GPL(validate_xmit_xfrm);
 
 int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
-		       struct xfrm_user_offload *xuo,
+		       const struct xfrm_user_offload *xuo,
 		       struct netlink_ext_ack *extack)
 {
 	int err;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 0b5c7b51183a9ddf17270da6367b478380f2fbf0..b24cb5b7509f5533db3329e680c85c6413e9e987 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4635,6 +4635,19 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
 	return 0;
 }
 
+/* Fill migrate fields that are invariant in XFRM_MSG_MIGRATE: inherited
+ * from the existing SA unchanged.
+ */
+static void xfrm_migrate_copy_old(struct xfrm_migrate *mp,
+				  const struct xfrm_state *x)
+{
+	mp->smark                  = x->props.smark;
+	mp->new_reqid              = x->props.reqid;
+	mp->nat_keepalive_interval = x->nat_keepalive_interval;
+	mp->mapping_maxage         = x->mapping_maxage;
+	mp->new_mark               = x->mark;
+}
+
 int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_migrate,
 		 struct xfrm_kmaddress *k, struct net *net,
@@ -4673,7 +4686,10 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			x_cur[nx_cur] = x;
 			nx_cur++;
 			mp->encap = encap;
-			mp->xuo = xuo;
+			if (xuo)
+				mp->xuo = *xuo;
+			xfrm_migrate_copy_old(mp, x);
+
 			xc = xfrm_state_migrate(x, mp, net, extack);
 			if (xc) {
 				x_new[nx_new] = xc;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 8f07e6294c472cd92baa72c9e15358917faed008..ddafbae085f1388cc9eda53d5e8cadf658be5cdd 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1978,7 +1978,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	memcpy(&x->lft, &orig->lft, sizeof(x->lft));
 	x->props.mode = orig->props.mode;
 	x->props.replay_window = orig->props.replay_window;
-	x->props.reqid = orig->props.reqid;
 
 	if (orig->aalg) {
 		x->aalg = xfrm_algo_auth_clone(orig->aalg);
@@ -2011,8 +2010,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 		x->encap = kmemdup(m->encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
-		x->mapping_maxage = orig->mapping_maxage;
-		x->nat_keepalive_interval = orig->nat_keepalive_interval;
+		x->mapping_maxage = m->mapping_maxage;
+		x->nat_keepalive_interval = m->nat_keepalive_interval;
 	}
 
 	if (orig->security)
@@ -2029,8 +2028,9 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	if (xfrm_replay_clone(x, orig))
 		goto error;
 
-	memcpy(&x->mark, &orig->mark, sizeof(x->mark));
-	memcpy(&x->props.smark, &orig->props.smark, sizeof(x->props.smark));
+	x->mark = m->new_mark;
+
+	x->props.smark = m->smark;
 
 	x->props.flags = orig->props.flags;
 	x->props.extra_flags = orig->props.extra_flags;
@@ -2053,7 +2053,7 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 			goto error;
 	}
 
-
+	x->props.reqid = m->new_reqid;
 	x->props.family = m->new_family;
 	memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
 	memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
@@ -2138,7 +2138,7 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 	}
 
 	/* configure the hardware if offload is requested */
-	if (m->xuo && xfrm_dev_state_add(net, xc, m->xuo, extack))
+	if (m->xuo.ifindex && xfrm_dev_state_add(net, xc, &m->xuo, extack))
 		goto error;
 
 	return xc;
@@ -2164,7 +2164,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 	} else {
 		if (xfrm_state_add(xc) < 0) {
 			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
-			if (m->xuo)
+			if (m->xuo.ifindex)
 				xfrm_dev_state_delete(xc);
 			xc->km.state = XFRM_STATE_DEAD;
 			xfrm_state_put(xc);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index fe0cf824f072b09e3267dc5b8aab9b5b0d68c968..f3b485c800a3483b1515218805b1c2edcdb0c512 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1318,7 +1318,7 @@ static int copy_to_user_encap(struct xfrm_encap_tmpl *ep, struct sk_buff *skb)
 	return 0;
 }
 
-static int xfrm_smark_put(struct sk_buff *skb, struct xfrm_mark *m)
+static int xfrm_smark_put(struct sk_buff *skb, const struct xfrm_mark *m)
 {
 	int ret = 0;
 
@@ -3059,6 +3059,22 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
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
+}
+
 static int copy_from_user_migrate(struct xfrm_migrate *ma,
 				  struct xfrm_kmaddress *k,
 				  struct nlattr **attrs, int *num,
@@ -3161,7 +3177,238 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	kfree(xuo);
 	return err;
 }
+
+static int build_migrate_state(struct sk_buff *skb,
+			       const struct xfrm_user_migrate_state *um,
+			       const struct xfrm_migrate *m,
+			       bool new_mark_set, bool offload_set,
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
+
+	if (m->encap) {
+		err = nla_put(skb, XFRMA_ENCAP, sizeof(*m->encap), m->encap);
+		if (err)
+			goto out_cancel;
+	}
+
+	if (offload_set || m->xuo.ifindex) {
+		err = nla_put(skb, XFRMA_OFFLOAD_DEV, sizeof(m->xuo), &m->xuo);
+		if (err)
+			goto out_cancel;
+	}
+
+	if (new_mark_set) {
+		err = nla_put(skb, XFRMA_MARK, sizeof(m->new_mark),
+			      &m->new_mark);
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
+		nla_total_size(sizeof(struct xfrm_user_offload)) +
+		nla_total_size(sizeof(struct xfrm_mark)) +
+		nla_total_size(sizeof(u32)) * 2 + /* SET_MARK + SET_MARK_MASK */
+		(m->mapping_maxage ? nla_total_size(sizeof(u32)) : 0) +
+		(m->nat_keepalive_interval ? nla_total_size(sizeof(u32)) : 0) +
+		(dir ? nla_total_size(sizeof(u8)) : 0); /* XFRMA_SA_DIR */
+}
+
+static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state *um,
+				   const struct xfrm_migrate *m,
+				   bool new_mark_set, bool offload_set,
+				   u8 dir, u32 portid, u32 seq)
+{
+	int err;
+	struct sk_buff *skb;
+	struct net *net = &init_net;
+
+	skb = nlmsg_new(xfrm_migrate_state_msgsize(m, dir), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	err = build_migrate_state(skb, um, m, new_mark_set, offload_set,
+				  dir, portid, seq);
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
+	if (attrs[XFRMA_NAT_KEEPALIVE_INTERVAL] &&
+	    nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]) && !m.encap) {
+		NL_SET_ERR_MSG(extack,
+			       "NAT_KEEPALIVE_INTERVAL requires encapsulation");
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* absent copies offload; ifindex=0 removes it */
+	if (attrs[XFRMA_OFFLOAD_DEV]) {
+		nla_memcpy(&m.xuo, attrs[XFRMA_OFFLOAD_DEV], sizeof(m.xuo));
+	} else if (x->xso.dev) {
+		m.xuo.ifindex = x->xso.dev->ifindex;
+		if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
+			m.xuo.flags = XFRM_OFFLOAD_INBOUND;
+		if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
+			m.xuo.flags |= XFRM_OFFLOAD_PACKET;
+	}
+
+	if (attrs[XFRMA_MARK])
+		m.new_mark = *(struct xfrm_mark *)nla_data(attrs[XFRMA_MARK]);
+	else
+		m.new_mark = m.old_mark;
+
+	if (attrs[XFRMA_SET_MARK])
+		xfrm_smark_init(attrs, &m.smark);
+	else
+		m.smark = x->props.smark;
+
+	m.mapping_maxage = attrs[XFRMA_MTIMER_THRESH] ?
+		nla_get_u32(attrs[XFRMA_MTIMER_THRESH]) : x->mapping_maxage;
+	m.nat_keepalive_interval = attrs[XFRMA_NAT_KEEPALIVE_INTERVAL] ?
+		nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]) :
+		x->nat_keepalive_interval;
+
+	xc = xfrm_state_migrate_create(x, &m, net, extack);
+	if (!xc) {
+		NL_SET_ERR_MSG_WEAK(extack, "State migration clone failed");
+		err = -EINVAL;
+		goto out;
+	}
+
+	spin_lock_bh(&x->lock);
+	xfrm_migrate_sync(xc, x); /* to prevent SN/IV reuse */
+	__xfrm_state_delete(x);
+	spin_unlock_bh(&x->lock);
+
+	err = xfrm_state_migrate_install(x, xc, &m, extack);
+	if (err < 0) {
+		/*
+		 * In this rare case both the old SA and the new SA
+		 * will disappear.
+		 * Alternatives risk duplicate SN/IV usage which must not occur.
+		 * Userspace must handle this error, -EEXIST.
+		 */
+		goto out;
+	}
+
+	/* Restore encap cleared by sentinel (type=0) during migration. */
+	if (attrs[XFRMA_ENCAP])
+		m.encap = nla_data(attrs[XFRMA_ENCAP]);
+
+	err = xfrm_send_migrate_state(um, &m, !!attrs[XFRMA_MARK],
+				      !!attrs[XFRMA_OFFLOAD_DEV],
+				      xc->dir, nlh->nlmsg_pid, nlh->nlmsg_seq);
+	if (err < 0) {
+		NL_SET_ERR_MSG(extack, "Failed to send migration notification");
+		err = 0;
+	}
+
+out:
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
@@ -3314,6 +3561,7 @@ const int xfrm_msg_min[XFRM_NR_MSGTYPES] = {
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
+	[XFRM_MSG_MIGRATE_STATE - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_migrate_state),
 };
 EXPORT_SYMBOL_GPL(xfrm_msg_min);
 
@@ -3407,6 +3655,7 @@ static const struct xfrm_link {
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = { .doit = xfrm_get_spdinfo   },
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_set_default   },
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_get_default   },
+	[XFRM_MSG_MIGRATE_STATE - XFRM_MSG_BASE] = { .doit = xfrm_do_migrate_state },
 };
 
 static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 2c0b07f9fbbd0b38edfd063020f09933c0f1ecb3..655d2616c9d2ab8af51b427499434d96f0b4bfd2 100644
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

