Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92131F9BA;
	Tue,  5 May 2026 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955592; cv=none; b=LoARqD9q7ZiU5IGTae66r5y2t3XmM8S7bc5wio867rx1Ift9zJLkZFr969GZtWztkicq2WNEa0UJsX/EXSCuJqNX0cTvsSeJrc+tz+ErXHxadCbhTAR/UGzQ2iUTj42cXGi6sfN7pofddG3VdUW5xpirf7EqPC1H/x5ZHSNpcrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955592; c=relaxed/simple;
	bh=r4hFjJGCOQ3H2tIbEfEClomCP23YzdPBlr41HX63Gao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VI3SvaaqSy173gCEtq791YqkDxcCCdypmkLrGBl0QcKaV1E+O83Tc+4F6jHIx9M3pRlYjO1hslIjez1Ck6iB0b4Ei7vrTpeqQwwWqzCJx8M+6hQm+oziE5J37iL4SVtVgCiWtSSw6vlETYcOCi9zfqCDaHJ1BLtXmoGYbjEZpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=g9LQxrLz; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="g9LQxrLz"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5CA59201E4;
	Tue,  5 May 2026 06:33:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UC0Hkjc0ahzm; Tue,  5 May 2026 06:33:08 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A6B44201AE;
	Tue,  5 May 2026 06:33:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A6B44201AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777955588;
	bh=VndmE5aKA1c8Yxvg0TEdv6C7T34K3myq94Z7JC+XXHQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=g9LQxrLzjAU8ur0TX98RpOKtUutYQoqigfw8PnCYDldHJA4AyYIokG8NXJhoWWjMx
	 UuoEzjNjyILdw5lwkCvPb9M1GNZehI+Kupn0/i0x/DZFftnEY4a+V7D9SvClkaZo8h
	 BgGzCxc72xb6EmSxQSt3FEEHZ+QYs8sZKh1GpgYRoLKfuhHHetB5JaXdZNgsA+yk4t
	 jihvUDYl/hY94rOhq6otvr1h1JSu7h9fuch9M1oLeaJSv+emkKdFMQhd3iNIZHhz5s
	 LUv9vfFwg8n7nw5Row4+CpM1g659KdzD/zDXiMUykrVuB9zxVkUtPwDs8acYrCU3RX
	 lUCzZ000IO5SA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 06:33:06 +0200
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
Subject: [PATCH ipsec-next v8 05/14] xfrm: rename reqid in xfrm_migrate
Date: Tue, 5 May 2026 06:32:56 +0200
Message-ID: <migrate-state-v8-5-4578fb016965@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

In preparation for a later patch in this series s/reqid/old_reqid/.
No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h     |  2 +-
 net/key/af_key.c       | 10 +++++-----
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  |  6 +++---
 net/xfrm/xfrm_user.c   |  4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0c035955d87d..368b1dc22e5c 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -685,7 +685,7 @@ struct xfrm_migrate {
 	u8			proto;
 	u8			mode;
 	u16			reserved;
-	u32			reqid;
+	u32			old_reqid;
 	u16			old_family;
 	u16			new_family;
 };
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 842bf5786e3f..1f0201d97b4f 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2554,7 +2554,7 @@ static int ipsecrequests_to_migrate(struct sadb_x_ipsecrequest *rq1, int len,
 	if ((mode = pfkey_mode_to_xfrm(rq1->sadb_x_ipsecrequest_mode)) < 0)
 		return -EINVAL;
 	m->mode = mode;
-	m->reqid = rq1->sadb_x_ipsecrequest_reqid;
+	m->old_reqid = rq1->sadb_x_ipsecrequest_reqid;
 
 	return ((int)(rq1->sadb_x_ipsecrequest_len +
 		      rq2->sadb_x_ipsecrequest_len));
@@ -3655,15 +3655,15 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		if (mode < 0)
 			goto err;
 		if (set_ipsecrequest(skb, mp->proto, mode,
-				     (mp->reqid ?  IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
-				     mp->reqid, mp->old_family,
+				     (mp->old_reqid ? IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
+				     mp->old_reqid, mp->old_family,
 				     &mp->old_saddr, &mp->old_daddr) < 0)
 			goto err;
 
 		/* new ipsecrequest */
 		if (set_ipsecrequest(skb, mp->proto, mode,
-				     (mp->reqid ? IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
-				     mp->reqid, mp->new_family,
+				     (mp->old_reqid ? IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
+				     mp->old_reqid, mp->new_family,
 				     &mp->new_saddr, &mp->new_daddr) < 0)
 			goto err;
 	}
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c944327ce66c..fd505adf080e 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4538,7 +4538,7 @@ static int migrate_tmpl_match(const struct xfrm_migrate *m, const struct xfrm_tm
 	int match = 0;
 
 	if (t->mode == m->mode && t->id.proto == m->proto &&
-	    (m->reqid == 0 || t->reqid == m->reqid)) {
+	    (m->old_reqid == 0 || t->reqid == m->old_reqid)) {
 		switch (t->mode) {
 		case XFRM_MODE_TUNNEL:
 		case XFRM_MODE_BEET:
@@ -4632,7 +4632,7 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
 				    sizeof(m[i].old_saddr)) &&
 			    m[i].proto == m[j].proto &&
 			    m[i].mode == m[j].mode &&
-			    m[i].reqid == m[j].reqid &&
+			    m[i].old_reqid == m[j].old_reqid &&
 			    m[i].old_family == m[j].old_family) {
 				NL_SET_ERR_MSG(extack, "Entries in the MIGRATE attribute's list must be unique");
 				return -EINVAL;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index b9de931d84c1..5424f2becbaf 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2081,14 +2081,14 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 
-	if (m->reqid) {
+	if (m->old_reqid) {
 		h = xfrm_dst_hash(net, &m->old_daddr, &m->old_saddr,
-				  m->reqid, m->old_family);
+				  m->old_reqid, m->old_family);
 		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h, bydst) {
 			if (x->props.mode != m->mode ||
 			    x->id.proto != m->proto)
 				continue;
-			if (m->reqid && x->props.reqid != m->reqid)
+			if (m->old_reqid && x->props.reqid != m->old_reqid)
 				continue;
 			if (if_id != 0 && x->if_id != if_id)
 				continue;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ae144d1e4a65..273ea6fdb8ad 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3104,7 +3104,7 @@ static int copy_from_user_migrate(struct xfrm_migrate *ma,
 
 		ma->proto = um->proto;
 		ma->mode = um->mode;
-		ma->reqid = um->reqid;
+		ma->old_reqid = um->reqid;
 
 		ma->old_family = um->old_family;
 		ma->new_family = um->new_family;
@@ -3187,7 +3187,7 @@ static int copy_to_user_migrate(const struct xfrm_migrate *m, struct sk_buff *sk
 	memset(&um, 0, sizeof(um));
 	um.proto = m->proto;
 	um.mode = m->mode;
-	um.reqid = m->reqid;
+	um.reqid = m->old_reqid;
 	um.old_family = m->old_family;
 	memcpy(&um.old_daddr, &m->old_daddr, sizeof(um.old_daddr));
 	memcpy(&um.old_saddr, &m->old_saddr, sizeof(um.old_saddr));

-- 
2.47.3

