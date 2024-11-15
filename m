Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16831CF2B2;
	Fri, 15 Nov 2024 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677823; cv=none; b=dZY4JhNDVpTntVI7u4bQSOrmj2yHdCBmBzQhKJJxN00pzR0yNnDnVE13pUsvv09pcVgTh07cL7vgpoaaUtp+V5NDJFc0K/pu2hYu/LneianmpehCMipSyCAR2W7L1/ZwYKBAJLK9OBnucM0WGfnXTKoIKYtkJ5Ru8vvYGvHmgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677823; c=relaxed/simple;
	bh=n0ozRySSb/HDW3WxToKFW0mkcIyNosv+Qmwk5st8Rc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYiGEVBAcpC/pVHWjHp+FpchKv0Qo6xPiC25rBfhEUBSlAlvUZS99A+xQR0WpX8uAJbkYm0CnYWQsgbZk+EG5dUAAswSBa561/p7tkcOaL44OoQKNm+LUG9KEi7lhqzX4/4QpYvON6J8dQZYDuIQokSTa4zVgXr5v/4o80s8AME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=NaxQTE72; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="NaxQTE72"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677820;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW1Z45XIE9YGIRkXHUVVzbmSbv1jGRvie471/U53Ez0=;
	b=NaxQTE72lRLPw7M6K+rNOX349gS7YT3qpXGezUBlZbhz3gqOj9CqRmaY3Q0dlNzmfsWpZI
	gN4O6WXlusR7WpkB0qKZbEtEk8KW0j6GKuwUNwyJ7FPlmVZeApJ7Q7RZCdFTaBFYQytu75
	pB+tbBHwMU40DrTrdUeLcGELZUJFT0LzD8WpZluxb+Mu/y7pNRy/XJGQkfTzU7ggZpaGon
	el53G5riyZj57P88GNyRE8CvfUG4c0Xq+r0JfTtg5FPWC8+PyudGod2f3tKZ1KTcZ9p/YB
	PBU/uHoh4q1PGDsQE2RoYo25mgwMxmtZQ+AjebKIRq1HIu8d986CLTaykIn7IA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/22] selinux: avoid unnecessary indirection in struct level_datum
Date: Fri, 15 Nov 2024 14:35:27 +0100
Message-ID: <20241115133619.114393-8-cgoettsche@seltendoof.de>
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

Store the owned member of type struct mls_level directly in the parent
struct instead of an extra heap allocation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/mls.c      |  6 +++---
 security/selinux/ss/policydb.c | 22 ++++++++--------------
 security/selinux/ss/policydb.h |  2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 989c809d310d..a6e49269f535 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -171,7 +171,7 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l)
 	 * levdatum->level->cat and no bit in l->cat is larger than
 	 * p->p_cats.nprim.
 	 */
-	return ebitmap_contains(&levdatum->level->cat, &l->cat,
+	return ebitmap_contains(&levdatum->level.cat, &l->cat,
 				p->p_cats.nprim);
 }
 
@@ -289,7 +289,7 @@ int mls_context_to_sid(struct policydb *pol, char oldc, char *scontext,
 		levdatum = symtab_search(&pol->p_levels, sensitivity);
 		if (!levdatum)
 			return -EINVAL;
-		context->range.level[l].sens = levdatum->level->sens;
+		context->range.level[l].sens = levdatum->level.sens;
 
 		/* Extract category set. */
 		while (next_cat != NULL) {
@@ -456,7 +456,7 @@ int mls_convert_context(struct policydb *oldp, struct policydb *newp,
 
 		if (!levdatum)
 			return -EINVAL;
-		newc->range.level[l].sens = levdatum->level->sens;
+		newc->range.level[l].sens = levdatum->level.sens;
 
 		ebitmap_for_each_positive_bit(&oldc->range.level[l].cat, node,
 					      i)
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e94ecb81c6d3..5e9a54645b80 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -298,9 +298,7 @@ static int sens_destroy(void *key, void *datum, void *p)
 	kfree(key);
 	if (datum) {
 		levdatum = datum;
-		if (levdatum->level)
-			ebitmap_destroy(&levdatum->level->cat);
-		kfree(levdatum->level);
+		ebitmap_destroy(&levdatum->level.cat);
 	}
 	kfree(datum);
 	return 0;
@@ -632,11 +630,11 @@ static int sens_index(void *key, void *datum, void *datap)
 	p = datap;
 
 	if (!levdatum->isalias) {
-		if (!levdatum->level->sens ||
-		    levdatum->level->sens > p->p_levels.nprim)
+		if (!levdatum->level.sens ||
+		    levdatum->level.sens > p->p_levels.nprim)
 			return -EINVAL;
 
-		p->sym_val_to_name[SYM_LEVELS][levdatum->level->sens - 1] = key;
+		p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] = key;
 	}
 
 	return 0;
@@ -1615,12 +1613,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (rc)
 		goto bad;
 
-	rc = -ENOMEM;
-	levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_KERNEL);
-	if (!levdatum->level)
-		goto bad;
-
-	rc = mls_read_level(levdatum->level, fp);
+	rc = mls_read_level(&levdatum->level, fp);
 	if (rc)
 		goto bad;
 
@@ -2841,7 +2834,7 @@ static int sens_write(void *vkey, void *datum, void *ptr)
 	if (rc)
 		return rc;
 
-	rc = mls_write_level(levdatum->level, fp);
+	rc = mls_write_level(&levdatum->level, fp);
 	if (rc)
 		return rc;
 
@@ -3303,7 +3296,8 @@ static int (*const write_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 /* clang-format on */
 
 static int ocontext_write(struct policydb *p,
-			  const struct policydb_compat_info *info, void *fp)
+			  const struct policydb_compat_info *info,
+			  struct policy_file *fp)
 {
 	unsigned int i, j;
 	int rc;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 985f319e2266..aa37f4eb6244 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -126,7 +126,7 @@ struct user_datum {
 
 /* Sensitivity attributes */
 struct level_datum {
-	struct mls_level *level; /* sensitivity and associated categories */
+	struct mls_level level; /* sensitivity and associated categories */
 	unsigned char isalias; /* is this sensitivity an alias for another? */
 };
 
-- 
2.45.2

