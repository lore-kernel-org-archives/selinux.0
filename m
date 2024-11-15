Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A81CCEE8;
	Fri, 15 Nov 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677822; cv=none; b=NMT0ksTbNEYlST8pbL0wLRpp06/1QpoUN7m3DrpRz5/VcYalCt9hfZPriZqhHoBWyexZhg40s61bqIHCzWGWbBx6/c9KmLfWV8utnGjUj6LYEZuXDKbOLq2Naa+zbYPdlshwY9RlquWrzoE96L9gAhdGO+d5ZKzRVjwJQF8QNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677822; c=relaxed/simple;
	bh=Ib45uRot1acwKbGhYZdqeNpKRjT3L8tCv8MVfkCt1e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzcZzFRTkeoeIu2Oas90JAjJ8oIMjvzRd+Y1Eo7Rv4+H1dLqrkalfpQdrz6IiinqDJF9bjUn4JZH8xlzwO6MdiJBUFS4GNiZ1CPcWMfViUcUVy0ovv80Yv6ZjVsbB7pK6dLHdva8e7r+aaGI/VqnlOqxldoo7+Fh/pfJtkDs9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=BxbKMoKu; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="BxbKMoKu"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677814;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JSE9gS3/yAfd/yBjndcFF5XzOkcsUtlbyZdS90wDAQ=;
	b=BxbKMoKuSFXJvCqzFp8vMVTWvzWQStdS3dj5vjnsHbKOdEutd+wwtUWrdIQsYDVnlPRyj6
	Tlt+qKARSgLBqgxFBDOGUdxeWa3hKuRCAljFJ0rPv5+wdVQZ+rrXHUw/rFKfIvPiRn2V61
	Vs+XE5we36DX4EJxlau1rfqYASk0WTyqZHmpVes2RdExRRCZYUacm+8Jy0rWahovFAZtsW
	8hLnRvVuEdIrwb4xrM6Ijjy8P8qopX3wTWntG8kgqj/62aslrY0kNGMQZxIY7JeGSGYUik
	hbCUgu/K2K992GVJlgJStNJguDHANN388Gy8t0fXcW4zEcUHUW4RVGWvj1Wd1g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/22] selinux: rename comparison functions for clarity
Date: Fri, 15 Nov 2024 14:35:25 +0100
Message-ID: <20241115133619.114393-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-1-cgoettsche@seltendoof.de>
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
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

The functions context_cmp() and mls_context_cmp() are not traditional
C style compare functions returning -1, 0, and 1 for less than, equal,
and greater than; they only return whether their arguments are equal.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/context.c  |  2 +-
 security/selinux/ss/context.h  | 10 +++++-----
 security/selinux/ss/services.c |  2 +-
 security/selinux/ss/sidtab.c   |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

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
index 7ccab2e6965f..e1307f6f7f50 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -132,8 +132,8 @@ static inline int mls_context_glblub(struct context *dst,
 	return rc;
 }
 
-static inline int mls_context_cmp(const struct context *c1,
-				  const struct context *c2)
+static inline bool mls_context_equal(const struct context *c1,
+				     const struct context *c2)
 {
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
 		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
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
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 261a512528d5..2b155f22a0f4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3327,7 +3327,7 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 		       __func__, xfrm_sid);
 		goto out;
 	}
-	rc = (mls_context_cmp(nlbl_ctx, xfrm_ctx) ? 0 : -EACCES);
+	rc = (mls_context_equal(nlbl_ctx, xfrm_ctx) ? 0 : -EACCES);
 	if (rc)
 		goto out;
 
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index c8848cbba81f..c74353672dcf 100644
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

