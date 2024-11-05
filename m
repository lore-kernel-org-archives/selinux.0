Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BA1E8845
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831612; cv=none; b=k68sCyjatogIFrGo6TMq7dkf6Z8rgF8V3vmaeCd79GMGGD4a1r8yBVZTOb1xTQNnknWoBwY/LrB9+nELTwe5HY6viVwO8hrtouncRiW/l2TODTuFm1sMRp6A8b5jxCZLB6hIXeC0TECRvZLdXCZCg+Ej7bJUUqknPLesirv1/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831612; c=relaxed/simple;
	bh=O26sOy4ovUMchFFHHOzKkRFvkUMZMi4Mtc1FkrfAIys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEX4fdehaTACzibJoIhSJi4jsvqiIiAe1+SPZgjCrSghZdqj7ztJ5PxeaSW6j+yL4okAIltlqisIzjFqIp7RR5ITy06U1507ypN6wW+onlAqgdoInCWFaeyalctBUCgXNL0OluhYq/TuMrD/1JOqJceq5UXuerdF99qPgwX5Tdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=AVsOBuLI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="AVsOBuLI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831606;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fpRpt7FxQPIMgOOLC3JIAm1uxw8SJfpkJ9OmuRvz4A=;
	b=AVsOBuLIThZ/bPKfUCcXgDecpu4ivMft/RWirN1IS5dzRai+OUCURw5yIVWkZf6SI9Mz0f
	SVubZZ2/FlfF9yu0+iRvb0UMVItysYpVg01JfoyA8hDFJL1Ogzo2xumdiaDOELMVqeyt+B
	ac/kvlrdIlZECzPSLGzApZ9eN6KQMfoJBgKfusfxboTLBlahH+/ru8nQSiWzX13aSAfO09
	HpBTUgOaVQO5kNPH0Dk9GZatKHtytWhX40daWxYN/y7pmta0Jz4iS0pU8GBGjzFJinmn07
	DdPzCDhyUQ4BBnpNUdt2gtQuKob9N8iW7xpfD852IyTzxXWWHpmBaaVAbMMsrQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 5/9] libselinux: sidtab updates
Date: Tue,  5 Nov 2024 19:33:15 +0100
Message-ID: <20241105183319.250410-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241105183319.250410-1-cgoettsche@seltendoof.de>
References: <20241105183319.250410-1-cgoettsche@seltendoof.de>
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

Add sidtab_context_lookup() to just lookup a context, not inserting
non-existent ones.

Tweak sidtab_destroy() to accept a zero'ed struct sidtab.

Remove redundant lookup in sidtab_context_to_sid() after insertion by
returning the newly created node directly from sidtab_insert().

Drop declaration of only internal used sidtab_insert().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  use sidtab_context_lookup() in sidtab_context_to_sid()
v2:
  add patch
---
 libselinux/src/avc_sidtab.c | 68 ++++++++++++++++++++-----------------
 libselinux/src/avc_sidtab.h |  2 +-
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index 9475dcb0..cb7dfc1d 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -44,28 +44,23 @@ int sidtab_init(struct sidtab *s)
 	return rc;
 }
 
-int sidtab_insert(struct sidtab *s, const char * ctx)
+static struct sidtab_node *
+sidtab_insert(struct sidtab *s, const char * ctx)
 {
 	unsigned hvalue;
-	int rc = 0;
 	struct sidtab_node *newnode;
 	char * newctx;
 
-	if (s->nel >= UINT_MAX - 1) {
-		rc = -1;
-		goto out;
-	}
+	if (s->nel >= UINT_MAX - 1)
+		return NULL;
 
 	newnode = (struct sidtab_node *)avc_malloc(sizeof(*newnode));
-	if (!newnode) {
-		rc = -1;
-		goto out;
-	}
+	if (!newnode)
+		return NULL;
 	newctx = strdup(ctx);
 	if (!newctx) {
-		rc = -1;
 		avc_free(newnode);
-		goto out;
+		return NULL;
 	}
 
 	hvalue = sidtab_hash(newctx);
@@ -73,36 +68,48 @@ int sidtab_insert(struct sidtab *s, const char * ctx)
 	newnode->sid_s.ctx = newctx;
 	newnode->sid_s.id = ++s->nel;
 	s->htable[hvalue] = newnode;
-      out:
-	return rc;
+	return newnode;
 }
 
-int
-sidtab_context_to_sid(struct sidtab *s,
-		      const char * ctx, security_id_t * sid)
+const struct security_id *
+sidtab_context_lookup(const struct sidtab *s, const char *ctx)
 {
 	unsigned hvalue;
-	int rc = 0;
-	struct sidtab_node *cur;
+	const struct sidtab_node *cur;
 
-	*sid = NULL;
 	hvalue = sidtab_hash(ctx);
 
-      loop:
 	cur = s->htable[hvalue];
 	while (cur != NULL && strcmp(cur->sid_s.ctx, ctx))
 		cur = cur->next;
 
-	if (cur == NULL) {	/* need to make a new entry */
-		rc = sidtab_insert(s, ctx);
-		if (rc)
-			goto out;
-		goto loop;	/* find the newly inserted node */
+	if (cur == NULL)
+		return NULL;
+
+	return &cur->sid_s;
+}
+
+int
+sidtab_context_to_sid(struct sidtab *s,
+		      const char * ctx, security_id_t * sid)
+{
+	struct sidtab_node *new;
+	const struct security_id *lookup_sid = sidtab_context_lookup(s, ctx);
+
+	if (lookup_sid) {
+		/* Dropping const is fine since our sidtab parameter is non-const. */
+		*sid = (struct security_id *)lookup_sid;
+		return 0;
 	}
 
-	*sid = &cur->sid_s;
-      out:
-	return rc;
+	new = sidtab_insert(s, ctx);
+	if (new == NULL) {
+		*sid = NULL;
+		return -1;
+	}
+
+	*sid = &new->sid_s;
+	return 0;
 }
 
 void sidtab_sid_stats(const struct sidtab *s, char *buf, size_t buflen)
@@ -138,7 +145,7 @@ void sidtab_destroy(struct sidtab *s)
 	int i;
 	struct sidtab_node *cur, *temp;
 
-	if (!s)
+	if (!s || !s->htable)
 		return;
 
 	for (i = 0; i < SIDTAB_SIZE; i++) {
@@ -149,7 +156,6 @@ void sidtab_destroy(struct sidtab *s)
 			freecon(temp->sid_s.ctx);
 			avc_free(temp);
 		}
-		s->htable[i] = NULL;
 	}
 	avc_free(s->htable);
 	s->htable = NULL;
diff --git a/libselinux/src/avc_sidtab.h b/libselinux/src/avc_sidtab.h
index e823e3f3..f62fd353 100644
--- a/libselinux/src/avc_sidtab.h
+++ b/libselinux/src/avc_sidtab.h
@@ -24,8 +24,8 @@ struct sidtab {
 };
 
 int sidtab_init(struct sidtab *s) ;
-int sidtab_insert(struct sidtab *s, const char * ctx) ;
 
+const struct security_id * sidtab_context_lookup(const struct sidtab *s, const char *ctx);
 int sidtab_context_to_sid(struct sidtab *s,
 			  const char * ctx, security_id_t * sid) ;
 
-- 
2.45.2

