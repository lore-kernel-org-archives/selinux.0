Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6A4E77EB
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617629; cv=none; b=kadSZEVH0ZUAVYt0euZtGdAU/UFrQv3bFK0eUubkDX4HIrG5N1w8rft4UDWAvQk3JBGcixt8RrLigxx0rRpkaPa37bPQi0543xthmE3jiOAe+5edWguPj9jzwAWVOIe1VWCmIw8L0ZiKmIAIWSM5ff901XlJe0yzxkzQKhM3dcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617629; c=relaxed/simple;
	bh=8E9zbjPXeFOLHXGuCRmSxJi09gPJ/5AkDZz7LqGr51w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtoWgTHuX4L/CN2zkK7FiUsy+/pljex2jiFEicngOase68Ba1PvlvVr7dP8EEzxTSsW5nDBGLHLjpp8SY7dxlupRJb4OpxE0R06PMeijCy335MsDiFHLtTxHEuKefPwMisYiV4uluQQ2/4ecAj9l6A1l+3mI2tNKAmIXxI9NgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=SfIsLKMr; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="SfIsLKMr"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617622;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qI59MYrt3TYLskrB1drjvKnQpfnAaWaYYkzyShYEu9U=;
	b=SfIsLKMrytrbYNeI1ZOlOVYWnvFXPbCUvkU1tv08QsJJTTw8kgsXE/y4JMzTfzEDZp/YsF
	dMtZJH+PcVUapowZR3ZwetnlThadAuoKC9cSrTDcSXgg0H7/Si3ubIWjf3wi5RVJHyx92t
	2YEnD8Fb3pO4qqvx4oDhOn1s/coLL+U+NYtCnb5/RfOG4tqxVexV3pKSAvTVcfDb9qZqUb
	+IgrgajhVKuzbr2N5pYR0g8pXB/7OBBv9rA8PZ1WvKJRcL5Qfg8iWIFiW/X927Lr4Ap1U8
	iuEdpd1zdxx8JqIPB1b++NTGUTjIMG/I1zJV79cXur2Nl/4ls2bjvFGAr2sylQ==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 21/32] selinux: simplify mls_context_glblub() and mls_context_equal()
Date: Mon, 28 Sep 2026 19:46:31 +0200
Message-ID: <20260928174643.2458710-20-cgoettsche@seltendoof.de>
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

Drop a no-op goto and a dead initialization in mls_context_glblub() and
use mls_level_eq() in mls_context_equal().

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/context.h | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 4fe42da81cc3..ca8bd9fc100e 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -93,7 +93,7 @@ static inline int mls_context_glblub(struct context *dst,
 {
 	struct mls_range *dr = &dst->range;
 	const struct mls_range *r1 = &c1->range, *r2 = &c2->range;
-	int rc = 0;
+	int rc;
 
 	if (r1->level[1].sens < r2->level[0].sens ||
 	    r2->level[1].sens < r1->level[0].sens)
@@ -109,24 +109,17 @@ static inline int mls_context_glblub(struct context *dst,
 	rc = ebitmap_and(&dr->level[0].cat, &r1->level[0].cat,
 			 &r2->level[0].cat);
 	if (rc)
-		goto out;
-
-	rc = ebitmap_and(&dr->level[1].cat, &r1->level[1].cat,
-			 &r2->level[1].cat);
-	if (rc)
-		goto out;
+		return rc;
 
-out:
-	return rc;
+	return ebitmap_and(&dr->level[1].cat, &r1->level[1].cat,
+			   &r2->level[1].cat);
 }
 
 static inline bool mls_context_equal(const struct context *c1,
 				     const struct context *c2)
 {
-	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
-		ebitmap_equal(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
-		(c1->range.level[1].sens == c2->range.level[1].sens) &&
-		ebitmap_equal(&c1->range.level[1].cat, &c2->range.level[1].cat));
+	return mls_level_eq(&c1->range.level[0], &c2->range.level[0]) &&
+	       mls_level_eq(&c1->range.level[1], &c2->range.level[1]);
 }
 
 static inline void mls_context_destroy(struct context *c)
-- 
2.55.0

