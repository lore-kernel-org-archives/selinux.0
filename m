Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F07AE68
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706533; cv=none; b=I0/PpmfpAUj7hRl7bhykUByIbgEtZY58dhtfKArO/YWigyBzZI2y9a0YQDoXJVnCRW26ncrjB+jhsdnC/YGgl5ZrlTTnwWXfl9JXRfvj/eDmIfejhIdSmIPAX54se6w2xVF3XcmsIUZnO762YFJk0k+aV/McWQGY53gviOJk7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706533; c=relaxed/simple;
	bh=F7Gk6Sk9WIUbIfyh+1/JIzwqebLGAPkOfTgJBpgMsiY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VW1SdIynv6KyrKP0Hr+lx2BLtDShtKERR8nXFw4YTgjnqe3uaop2jv0gXtrdqjY7BTYzNu01eo+mnJ8zjM2V5D2iwS/Eu/HqbjhKJ7L7JDgbN+LQXXy3wABdhvjItf2NXWZCIBD4mLMR2VdFYmL0SU3hGLeMd56kr+ZARhiKMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=N47gOul5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N47gOul5"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so730159166b.0
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 05:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706706530; x=1707311330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFIdkKtGWgenTqspVu4qxQWtQsq7J2gjHKGQWHLZvqM=;
        b=N47gOul5/pQdFY9cbbsCqZ9+7U4Mk+AaoBKDLY/rxu+F1zwv6puO6iUfcEXjab7PVg
         UMhDov+Unw1dkCVLy1DWhtAekSpJJt7TvS+vFgYTpWBnVoi6uv8vo4+njRaAVM7Ku7OM
         W3R0iJZ7/ci1JpJdCz3qgRYNy9gNavxk3tuel4kmhKBVMA908YYGIJECSfkUhnztMuZq
         DsscGr33f3yhuWra5fLbbmHMrRcIhbyOEqPcYnFLxhgLKL6iM96Q61C/Hg5cVU8g4wRQ
         2cfIITVRe8caE8NYuuXhhqELlF/J+uu8ZD7WI3yHJz6ZrtfmdKuGvov9Hhucd/It9e8w
         iqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706530; x=1707311330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFIdkKtGWgenTqspVu4qxQWtQsq7J2gjHKGQWHLZvqM=;
        b=jOV5rYxxjskWPLqRfq2BECT14FdItmsPi57UwgjFDSR90YAo50btbgXgHj41EHzcp8
         pTkJ4MOlURZd/GZc+z/OQx+zXNP2T0Cyi3Vtj/FYlNimcCd2TrpydRKV2sa1mzSX0vEg
         fmh7/SGHcoBUw3P1t8JUY8VKfVxw/ej68X6jFjES34BQ8FT4q8CPRfO3C/z/QKirNPqC
         dcW9F4xhg0YI3T74I72hNjX1CuCLyyojyqbGonsJdoFgElq/Mz107hVaP0gbBxE0LHu1
         t1YH+Z/GdE7LD5nGtc0caDlnBOGr1wIqPEB9jqB0eP/NQC6CEYyxHo9KVjcF7lwn3ysm
         PjTg==
X-Gm-Message-State: AOJu0YyZcq50ue1XPxdW4pRG9kjStrL7k/XA7tGdJkoQd9ZKsE9ZMSh+
	MJ1GcLFFy2HNo0iUW+gcqyl+8FKaP6pvghF20mYBeVs3TydDAZmhhAnLAH+6
X-Google-Smtp-Source: AGHT+IEize0tymeCmNvcP0awrTVRcxVLsblr6LGBgG8MZGhWzix/0z0FtTBO3SxX9JPZ0Nc+uwzu8Q==
X-Received: by 2002:a17:906:35d8:b0:a28:ec67:185f with SMTP id p24-20020a17090635d800b00a28ec67185fmr1120432ejb.60.1706706530209;
        Wed, 31 Jan 2024 05:08:50 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm890351ejm.216.2024.01.31.05.08.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:08:49 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH v2 5/9] libselinux: sidtab updates
Date: Wed, 31 Jan 2024 14:08:31 +0100
Message-ID: <20240131130840.48155-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131130840.48155-1-cgzones@googlemail.com>
References: <20240131130840.48155-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add sidtab_context_lookup() to just lookup a context, not inserting
non-existent ones.

Tweak sidtab_destroy() to accept a zero'ed struct sidtab.

Remove redundant lookup in sidtab_context_to_sid() after insertion by
returning the newly created node directly from sidtab_insert().

Drop declaration of only internal used sidtab_insert().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  add patch
---
 libselinux/src/avc_sidtab.c | 55 +++++++++++++++++++++----------------
 libselinux/src/avc_sidtab.h |  2 +-
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index 9475dcb0..3d347cea 100644
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
@@ -73,8 +68,25 @@ int sidtab_insert(struct sidtab *s, const char * ctx)
 	newnode->sid_s.ctx = newctx;
 	newnode->sid_s.id = ++s->nel;
 	s->htable[hvalue] = newnode;
-      out:
-	return rc;
+	return newnode;
+}
+
+const struct security_id *
+sidtab_context_lookup(const struct sidtab *s, const char *ctx)
+{
+	unsigned hvalue;
+	const struct sidtab_node *cur;
+
+	hvalue = sidtab_hash(ctx);
+
+	cur = s->htable[hvalue];
+	while (cur != NULL && strcmp(cur->sid_s.ctx, ctx))
+		cur = cur->next;
+
+	if (cur == NULL)
+		return NULL;
+
+	return &cur->sid_s;
 }
 
 int
@@ -82,27 +94,23 @@ sidtab_context_to_sid(struct sidtab *s,
 		      const char * ctx, security_id_t * sid)
 {
 	unsigned hvalue;
-	int rc = 0;
 	struct sidtab_node *cur;
 
 	*sid = NULL;
 	hvalue = sidtab_hash(ctx);
 
-      loop:
 	cur = s->htable[hvalue];
 	while (cur != NULL && strcmp(cur->sid_s.ctx, ctx))
 		cur = cur->next;
 
 	if (cur == NULL) {	/* need to make a new entry */
-		rc = sidtab_insert(s, ctx);
-		if (rc)
-			goto out;
-		goto loop;	/* find the newly inserted node */
+		cur = sidtab_insert(s, ctx);
+		if (cur == NULL)
+			return -1;
 	}
 
 	*sid = &cur->sid_s;
-      out:
-	return rc;
+	return 0;
 }
 
 void sidtab_sid_stats(const struct sidtab *s, char *buf, size_t buflen)
@@ -138,7 +146,7 @@ void sidtab_destroy(struct sidtab *s)
 	int i;
 	struct sidtab_node *cur, *temp;
 
-	if (!s)
+	if (!s || !s->htable)
 		return;
 
 	for (i = 0; i < SIDTAB_SIZE; i++) {
@@ -149,7 +157,6 @@ void sidtab_destroy(struct sidtab *s)
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
2.43.0

