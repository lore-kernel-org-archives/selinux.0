Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95F206F15;
	Mon, 16 Dec 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367298; cv=none; b=YVT1XdzoL5LCtLV3NnBBi8eLFMObObpjA7qrmTrECHfAEFlPwFfj9bP0RroJCKdtMNfRDowsK3YNk/VDhU70sK0x7Ou4L9c+LfGIuZa7LZuieL6htjucc4kJzriRLJ1aEqMY2jovj7U8cEcjgzKH18PW/5GW8XXUvbe5rhuqH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367298; c=relaxed/simple;
	bh=KIFmrfH9DEqmtH6MpUEoEvtH4sjHmNfNcbo9qvegAuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxvMkRXhiNx8FO2ZdcoOGCmmnUwtinJeN1cj/yqYA9abhTekXH/eFaEOEiX8BMIvPgeEEG9A4/nQf4oMFdt3UGin0wsMuNMJnfslpmogJYj90/fTApoKDTx090Sk8kGJ/GRa6X8fu8/e39ORvjUlXwQGC1xhV46F4a9GcRcvdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=t+lek5Lu; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="t+lek5Lu"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367294;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgoPJKqdslI0EtHYP2qhOP7CfRq8KEVfj1UoB5ZnA9g=;
	b=t+lek5Luupo9Vv3NcW/StJsrUsl6YlvCMbuH6S4ZM0LuViZEAWyHpSiEs4fuF5YPdFopua
	SWtBGYZ5WotUnKnLk5sj+1ObddbX4ioVywBcy+f8y9Kb+d6oNnM+F5mEmkPMC0JuHYG/l9
	fneK5F8nYsp6l/dZ3Nsfmidc7LcP5wWaK72jVNMkX38DqLHQKw7nSWeeoxjTCIt632BP3J
	vGwB6sTRbp0LFZMgSEdLty9XIRFm+d//e74amZtrG8zxhB6PSDqi72puHGy8TPouBlaFev
	6jUAO0wF40cLIRQV68jHteV8a1RKUINADKXQ0YWFqr3Xk5NzLkmXXbLbUElLRA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Eric Suen <ericsu@linux.microsoft.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	GUO Zihua <guozihua@huawei.com>
Subject: [RFC PATCH v2 06/22] selinux: rename comparison functions for clarity
Date: Mon, 16 Dec 2024 17:40:04 +0100
Message-ID: <20241216164055.96267-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-1-cgoettsche@seltendoof.de>
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The functions context_cmp(), mls_context_cmp() and ebitmap_cmp() are not
traditional C style compare functions returning -1, 0, and 1 for less
than, equal, and greater than; they only return whether their arguments
are equal.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: also convert ebitmap_cmp() as suggested by Daniel
---
 security/selinux/ss/context.c   |  2 +-
 security/selinux/ss/context.h   | 14 +++++++-------
 security/selinux/ss/ebitmap.c   |  8 ++++----
 security/selinux/ss/ebitmap.h   |  2 +-
 security/selinux/ss/mls_types.h |  2 +-
 security/selinux/ss/services.c  |  2 +-
 security/selinux/ss/sidtab.c    |  2 +-
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
index e39990f494dd..a528b7f76280 100644
--- a/security/selinux/ss/context.c
+++ b/security/selinux/ss/context.c
@@ -20,7 +20,7 @@ u32 context_compute_hash(const struct context *c)
 	 * context struct with only the len & str set (and vice versa)
 	 * under a given policy. Since context structs from different
 	 * policies should never meet, it is safe to hash valid and
-	 * invalid contexts differently. The context_cmp() function
+	 * invalid contexts differently. The context_equal() function
 	 * already operates under the same assumption.
 	 */
 	if (c->len)
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 7ccab2e6965f..dd3b9b5b588e 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -132,13 +132,13 @@ static inline int mls_context_glblub(struct context *dst,
 	return rc;
 }
 
-static inline int mls_context_cmp(const struct context *c1,
-				  const struct context *c2)
+static inline bool mls_context_equal(const struct context *c1,
+				     const struct context *c2)
 {
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
-		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
+		ebitmap_equal(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
 		(c1->range.level[1].sens == c2->range.level[1].sens) &&
-		ebitmap_cmp(&c1->range.level[1].cat, &c2->range.level[1].cat));
+		ebitmap_equal(&c1->range.level[1].cat, &c2->range.level[1].cat));
 }
 
 static inline void mls_context_destroy(struct context *c)
@@ -188,15 +188,15 @@ static inline void context_destroy(struct context *c)
 	mls_context_destroy(c);
 }
 
-static inline int context_cmp(const struct context *c1,
-			      const struct context *c2)
+static inline bool context_equal(const struct context *c1,
+				 const struct context *c2)
 {
 	if (c1->len && c2->len)
 		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
 	if (c1->len || c2->len)
 		return 0;
 	return ((c1->user == c2->user) && (c1->role == c2->role) &&
-		(c1->type == c2->type) && mls_context_cmp(c1, c2));
+		(c1->type == c2->type) && mls_context_equal(c1, c2));
 }
 
 u32 context_compute_hash(const struct context *c);
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 99c01be15115..1cc1e7e711e3 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -25,12 +25,12 @@
 
 static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
 
-int ebitmap_cmp(const struct ebitmap *e1, const struct ebitmap *e2)
+bool ebitmap_equal(const struct ebitmap *e1, const struct ebitmap *e2)
 {
 	const struct ebitmap_node *n1, *n2;
 
 	if (e1->highbit != e2->highbit)
-		return 0;
+		return false;
 
 	n1 = e1->node;
 	n2 = e2->node;
@@ -41,9 +41,9 @@ int ebitmap_cmp(const struct ebitmap *e1, const struct ebitmap *e2)
 	}
 
 	if (n1 || n2)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index ba2ac3da1153..49eb33de87e0 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -120,7 +120,7 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n, u32 bit)
 	     (bit) < ebitmap_length(e);               \
 	     (bit) = ebitmap_next_positive(e, &(n), bit))
 
-int ebitmap_cmp(const struct ebitmap *e1, const struct ebitmap *e2);
+bool ebitmap_equal(const struct ebitmap *e1, const struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src);
 int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
 		const struct ebitmap *e2);
diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index 7ef6e8cb0cf4..51df2ebd1211 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -29,7 +29,7 @@ struct mls_range {
 static inline int mls_level_eq(const struct mls_level *l1,
 			       const struct mls_level *l2)
 {
-	return ((l1->sens == l2->sens) && ebitmap_cmp(&l1->cat, &l2->cat));
+	return ((l1->sens == l2->sens) && ebitmap_equal(&l1->cat, &l2->cat));
 }
 
 static inline int mls_level_dom(const struct mls_level *l1,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 9bd14256a154..e5c9b62e59c1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3331,7 +3331,7 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 		       __func__, xfrm_sid);
 		goto out;
 	}
-	rc = (mls_context_cmp(nlbl_ctx, xfrm_ctx) ? 0 : -EACCES);
+	rc = (mls_context_equal(nlbl_ctx, xfrm_ctx) ? 0 : -EACCES);
 	if (rc)
 		goto out;
 
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index cb7125cc7f8e..59f8c09158ef 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -66,7 +66,7 @@ static u32 context_to_sid(struct sidtab *s, struct context *context, u32 hash)
 	hash_for_each_possible_rcu(s->context_to_sid, entry, list, hash) {
 		if (entry->hash != hash)
 			continue;
-		if (context_cmp(&entry->context, context)) {
+		if (context_equal(&entry->context, context)) {
 			sid = entry->sid;
 			break;
 		}
-- 
2.45.2

