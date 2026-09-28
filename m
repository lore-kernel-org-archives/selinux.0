Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD054EBAEC
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617628; cv=none; b=Ck+eG5dV5PPaqVZ+ly2yaJnm+aBPGACLvdz+JkWhbmZPiSweN2K03vEB2nfW0dk4HEzu8O31O/EvSrByydzySvOUyetQVSq2Bafy2Ayupcj6YkdOD0VJHrLhx/BRJ4lPDW2bE/OfGBTZzurRWB0ytUzXu0C3mA+uahMNi6ixM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617628; c=relaxed/simple;
	bh=fjLkWmGAgqHlCsq2NHkfheWTACwrcxWg7YOcjFL3hyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teJUUmY0ShTdPVyAAzBKBlFZO6p78/tZctWhNtOH2N5IoNdWhF38gHsyKAmAu6wqSW7/CXDYBKIWjbkapEiHEuYZxnkGR1zEWEQ3poigleMG4r3UZ1iJMhOjW66Iot3Y//ULXRRclS/YKVH1BM9aSEpYd0daDoh1PsSbu5R11KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=aYqYR0pV; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="aYqYR0pV"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617622;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9A88GiR52ZoIYUKTFDxNkWdHAFztQdsjmVlJTyWDvE=;
	b=aYqYR0pVkJIe2nx8/PSz9Banf0cvDj96XI3bXgMA04eBEw5H2yreVW8hkqabmExvrtGohN
	eCVLy6QXilc4yMXFvKzb2t6s5/dEYUymzfVy9iOYvd34LV7Cy5/1IN+tyo42kZQm8PxD8B
	cbmM2iC5oze2Xf83jLs/l4WhxaCeUPSb/7gqgChnk5iVaj20JsouoHhMyIV+Fm+fb2YWLj
	ObnLOykjuvDvIyBN/OlUoVBUOQ5Kt1mCLN1J493v2K5OHp6oJcoQ3feXWi/AXaKbQLJRVT
	8Sh3rqMhp/yHMHYEryj8XmJq7AqDlSgJVTdiEVYfmlT4E1wfywkua4MOE6/6qg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 20/32] selinux: consolidate MLS context copy helpers
Date: Mon, 28 Sep 2026 19:46:30 +0200
Message-ID: <20260928174643.2458710-19-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
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

mls_context_cpy(), mls_context_cpy_low() and mls_context_cpy_high()
only differ in the source levels.  Implement them via a common helper.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/context.h | 56 ++++++++++++++---------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index dd3b9b5b588e..4fe42da81cc3 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -39,43 +39,42 @@ static inline void mls_context_init(struct context *c)
 	memset(&c->range, 0, sizeof(c->range));
 }
 
-static inline int mls_context_cpy(struct context *dst,
-				  const struct context *src)
+/*
+ * Sets the MLS range of 'dst' to the levels 'low' and 'high'.
+ */
+static inline int mls_context_cpy_levels(struct context *dst,
+					 const struct mls_level *low,
+					 const struct mls_level *high)
 {
 	int rc;
 
-	dst->range.level[0].sens = src->range.level[0].sens;
-	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
+	dst->range.level[0].sens = low->sens;
+	rc = ebitmap_cpy(&dst->range.level[0].cat, &low->cat);
 	if (rc)
-		goto out;
+		return rc;
 
-	dst->range.level[1].sens = src->range.level[1].sens;
-	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[1].cat);
+	dst->range.level[1].sens = high->sens;
+	rc = ebitmap_cpy(&dst->range.level[1].cat, &high->cat);
 	if (rc)
 		ebitmap_destroy(&dst->range.level[0].cat);
-out:
 	return rc;
 }
 
+static inline int mls_context_cpy(struct context *dst,
+				  const struct context *src)
+{
+	return mls_context_cpy_levels(dst, &src->range.level[0],
+				      &src->range.level[1]);
+}
+
 /*
  * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
  */
 static inline int mls_context_cpy_low(struct context *dst,
 				      const struct context *src)
 {
-	int rc;
-
-	dst->range.level[0].sens = src->range.level[0].sens;
-	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
-	if (rc)
-		goto out;
-
-	dst->range.level[1].sens = src->range.level[0].sens;
-	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[0].cat);
-	if (rc)
-		ebitmap_destroy(&dst->range.level[0].cat);
-out:
-	return rc;
+	return mls_context_cpy_levels(dst, &src->range.level[0],
+				      &src->range.level[0]);
 }
 
 /*
@@ -84,19 +83,8 @@ static inline int mls_context_cpy_low(struct context *dst,
 static inline int mls_context_cpy_high(struct context *dst,
 				       const struct context *src)
 {
-	int rc;
-
-	dst->range.level[0].sens = src->range.level[1].sens;
-	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[1].cat);
-	if (rc)
-		goto out;
-
-	dst->range.level[1].sens = src->range.level[1].sens;
-	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[1].cat);
-	if (rc)
-		ebitmap_destroy(&dst->range.level[0].cat);
-out:
-	return rc;
+	return mls_context_cpy_levels(dst, &src->range.level[1],
+				      &src->range.level[1]);
 }
 
 static inline int mls_context_glblub(struct context *dst,
-- 
2.55.0

