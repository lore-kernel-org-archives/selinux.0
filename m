Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F9207A31;
	Mon, 16 Dec 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367303; cv=none; b=AWrfbhtrqXY1zPnE+NOPnmOYe7k6bbWqsdWWitERvlUwtUAxDZsFVMveJV+ncOrm3zHbqGGPzmGwrDwO65FrT4J+cKCgtUoamxOev3rZURuExDjWuI04dDFXfDwqFNEFxF9A4+1OyXQjwsWmdFGbr2lc86E8ffxO2PXp19UwQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367303; c=relaxed/simple;
	bh=WNcgJMGS2/qbmsW6kq0OMh4bclu4pycytPH+INcGkQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka7392mkomTWzJw5FFiX0QqQGReX+bFZF96a8WadJtKHaGTLospYLNffSn0RtC4KUIPk92xGonmeRtDumMHTlzmrv1/lebg6u2GHcu4Za/FZejWXdQjGZVKBDj32R6f+uhgnra6fVdor439MTBfzkWdEcCOtRQksnMPh0Z3u6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=k3NqMTkw; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="k3NqMTkw"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367299;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WySptIJBQZUK1FIhrzNp2y+geIdiCcwgh6X2ldomtZo=;
	b=k3NqMTkwYyM+IpxPcSa1fiIgDrt+3+9F8GU83SJ4k9lKR/sj47uPKvY3ITleA/yy4aMhXt
	5XTPGaSZq94sTw+gO7DftqIeu3NMe5AJ/htYiUGGzy/ZCWKDzLklWEb9Qn08TM3gq0gjdX
	McjmqUJuVPJRn+dgdDaWwexi5bVSuw9OldDGFnXCURAHiFiXqYeXvSMemW7gOkxJYf9L1b
	YQ5eplVRU5BSlt/r2UEJCnjbMP1h7H5UKmS7RDA5Z5fjwl9WBfs2v7u4p2/yPL2Wtae5QG
	MdBKbTndBbgXVGJSmLJEqf9xXjpAevtpFMn9SnGoU/UOVkrBVnNpu9fhR5ODFQ==
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
	llvm@lists.linux.dev
Subject: [RFC PATCH v2 08/22] selinux: avoid unnecessary indirection in struct level_datum
Date: Mon, 16 Dec 2024 17:40:06 +0100
Message-ID: <20241216164055.96267-8-cgoettsche@seltendoof.de>
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

Store the owned member of type struct mls_level directly in the parent
struct instead of an extra heap allocation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/mls.c      |  6 +++---
 security/selinux/ss/policydb.c | 19 ++++++-------------
 security/selinux/ss/policydb.h |  2 +-
 3 files changed, 10 insertions(+), 17 deletions(-)

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
index b57f7db4cd89..f7d0867428f5 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -303,9 +303,7 @@ static int sens_destroy(void *key, void *datum, void *p)
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
@@ -637,11 +635,11 @@ static int sens_index(void *key, void *datum, void *datap)
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
@@ -1620,12 +1618,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
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
 
@@ -2846,7 +2839,7 @@ static int sens_write(void *vkey, void *datum, void *ptr)
 	if (rc)
 		return rc;
 
-	rc = mls_write_level(levdatum->level, fp);
+	rc = mls_write_level(&levdatum->level, fp);
 	if (rc)
 		return rc;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index c699fa52f59a..80d1fa7e4995 100644
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

