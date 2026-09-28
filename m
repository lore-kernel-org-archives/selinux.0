Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBF4DD3D1
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617624; cv=none; b=NMXUvdfBMsvQX25n9s7nGK7bik/KoeIlKmJmqAUK5u6TpYMRDe5G7oH90RxsKgMLoNE09ELUy2X5NWFKlDYsIewYb5ipRVM0qcxL+qioaxyeW/mrFp/G1shfNDltgSTm6ymqDJjE1J/u3W+bo+YhZ4jlLOLwxPIcMuIT/v8Rz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617624; c=relaxed/simple;
	bh=7+/yFzTJwia4YmxMOrD51asBsON2mrwQyiyfT1sXv8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JC4o6Y51DhfI+LLeoUAitzlOzPy1KBDFDn02e8aY1Olm0NG2p2y4DYK7fyY3JD0sHMYT/TFCLCGe6eWkGLUFMv480rJArRoYuvrkzpEbUpbyjRNiuItY8a/Dy02Q2Qa0GPN40V8zaSfTeHD5KaLfTQ7aHagiT1M5+AkU2W390PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ITEHUMMW; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ITEHUMMW"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617618;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tTY8wklYPq4RPCmfEDzLb+RaTPd0abnOpdXF3ERTaE=;
	b=ITEHUMMWXcT9tnKW52Wd83t2s9nOmfvP8rWmvHexCY//iSjq/NyarQBd0l/Xgug6VkG5Ci
	jyiMKF3YFjm6ruGFNEByg88DLCJQLvIvGOQViy5oEey84HCfarUO9X0BV9lwku7oxjrLgI
	897dr7FMDnI2rFD5dwMU7aCatsmo25DKag9gqC3svnkZocLNC+TKX2YFJEySd2+2myXCHl
	vq/jTIvWV05+T6QZ9FacmE8thpQHjZ12TIXNCEIL0HivLklGeAf5on85nhWB/5Jp0ppgIc
	UpsYEmn0q64SmO3f9sN2woMFpzvM8wvHXMUXia/g28UxejbIHASHUjRhw5Xg3g==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 07/32] selinux: drop constant value parameter of ebitmap_set_bit()
Date: Mon, 28 Sep 2026 19:46:17 +0200
Message-ID: <20260928174643.2458710-6-cgoettsche@seltendoof.de>
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

All callers of ebitmap_set_bit() pass 1 as value.  Drop the parameter
together with the unused bit clearing branch and
ebitmap_node_clr_bit().

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/ebitmap.c  | 37 +++-------------------------------
 security/selinux/ss/ebitmap.h  | 11 +---------
 security/selinux/ss/mls.c      |  6 +++---
 security/selinux/ss/policydb.c |  8 ++++----
 4 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index ea894361fed6..fd489d8cfbed 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -87,7 +87,7 @@ int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
 	ebitmap_for_each_positive_bit(e1, n, bit)
 	{
 		if (ebitmap_get_bit(e2, bit)) {
-			rc = ebitmap_set_bit(dst, bit, 1);
+			rc = ebitmap_set_bit(dst, bit);
 			if (rc < 0)
 				return rc;
 		}
@@ -301,7 +301,7 @@ int ebitmap_get_bit(const struct ebitmap *e, u32 bit)
 	return 0;
 }
 
-int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value)
+int ebitmap_set_bit(struct ebitmap *e, u32 bit)
 {
 	struct ebitmap_node *n, *prev, *new;
 
@@ -309,44 +309,13 @@ int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value)
 	n = e->node;
 	while (n && n->startbit <= bit) {
 		if ((n->startbit + EBITMAP_SIZE) > bit) {
-			if (value) {
-				ebitmap_node_set_bit(n, bit);
-			} else {
-				u32 s;
-
-				ebitmap_node_clr_bit(n, bit);
-
-				s = find_first_bit(n->maps, EBITMAP_SIZE);
-				if (s < EBITMAP_SIZE)
-					return 0;
-
-				/* drop this node from the bitmap */
-				if (!n->next) {
-					/*
-					 * this was the highest map
-					 * within the bitmap
-					 */
-					if (prev)
-						e->highbit = prev->startbit +
-							     EBITMAP_SIZE;
-					else
-						e->highbit = 0;
-				}
-				if (prev)
-					prev->next = n->next;
-				else
-					e->node = n->next;
-				kmem_cache_free(ebitmap_node_cachep, n);
-			}
+			ebitmap_node_set_bit(n, bit);
 			return 0;
 		}
 		prev = n;
 		n = n->next;
 	}
 
-	if (!value)
-		return 0;
-
 	new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
 	if (!new)
 		return -ENOMEM;
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index ae05cc8e4672..9b14f2304620 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -106,15 +106,6 @@ static inline void ebitmap_node_set_bit(struct ebitmap_node *n, u32 bit)
 	n->maps[index] |= (EBITMAP_BIT << ofs);
 }
 
-static inline void ebitmap_node_clr_bit(struct ebitmap_node *n, u32 bit)
-{
-	u32 index = EBITMAP_NODE_INDEX(n, bit);
-	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
-
-	BUG_ON(index >= EBITMAP_UNIT_NUMS);
-	n->maps[index] &= ~(EBITMAP_BIT << ofs);
-}
-
 #define ebitmap_for_each_positive_bit(e, n, bit)      \
 	for ((bit) = ebitmap_start_positive(e, &(n)); \
 	     (bit) < ebitmap_length(e);               \
@@ -128,7 +119,7 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
 		     u32 last_e2bit);
 u32 ebitmap_get_highest_set_bit(const struct ebitmap *e);
 int ebitmap_get_bit(const struct ebitmap *e, u32 bit);
-int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value);
+int ebitmap_set_bit(struct ebitmap *e, u32 bit);
 void ebitmap_destroy(struct ebitmap *e);
 struct policy_file;
 int ebitmap_read(struct ebitmap *e, struct policy_file *fp);
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index b48f8256dd4c..3b2f888506af 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -318,7 +318,7 @@ int mls_context_to_sid(struct policydb *pol, char oldc, char *scontext,
 				return -EINVAL;
 
 			rc = ebitmap_set_bit(&context->range.level[l].cat,
-					     catdatum->value - 1, 1);
+					     catdatum->value - 1);
 			if (rc)
 				return rc;
 
@@ -335,7 +335,7 @@ int mls_context_to_sid(struct policydb *pol, char oldc, char *scontext,
 
 			for (i = catdatum->value; i < rngdatum->value; i++) {
 				rc = ebitmap_set_bit(
-					&context->range.level[l].cat, i, 1);
+					&context->range.level[l].cat, i);
 				if (rc)
 					return rc;
 			}
@@ -438,7 +438,7 @@ int mls_convert_context(struct policydb *oldp, struct policydb *newp,
 			if (!catdatum)
 				return -EINVAL;
 			rc = ebitmap_set_bit(&newc->range.level[l].cat,
-					     catdatum->value - 1, 1);
+					     catdatum->value - 1);
 			if (rc)
 				return rc;
 		}
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 13d88e47db3c..cad404fc8819 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2292,13 +2292,13 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 			name = NULL;
 
 			rc = ebitmap_set_bit(&p->filename_trans_ttypes,
-					     key.ttype, 1);
+					     key.ttype);
 			if (rc)
 				return rc;
 		}
 	}
 	kfree(name);
-	return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
+	return ebitmap_set_bit(&datum->stypes, stype - 1);
 
 out:
 	kfree(ft);
@@ -2400,7 +2400,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	if (rc)
 		goto out;
 
-	return ebitmap_set_bit(&p->filename_trans_ttypes, ttype, 1);
+	return ebitmap_set_bit(&p->filename_trans_ttypes, ttype);
 
 out:
 	kfree(ft);
@@ -3122,7 +3122,7 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			goto bad;
 
 		/* add the type itself as the degenerate case */
-		rc = ebitmap_set_bit(e, i, 1);
+		rc = ebitmap_set_bit(e, i);
 		if (rc)
 			goto bad;
 	}
-- 
2.55.0

