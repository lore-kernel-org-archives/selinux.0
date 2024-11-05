Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC821E8825
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831613; cv=none; b=UA9E0T+1c9k++w2r9TJpiZpfiiPN1ISB18KR1pkP3N2D+4iJZbRVYK/ITVm9dW6L4KxEcyI+k7Bi0bbbjFhWVUGmuj7DlzUp9l7KTYbrbyaJLdcJLc8A5daEYTt3QVbQN56T0t5L10iI5VpzhAggVcau9dyziMa5CQApP/6/X5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831613; c=relaxed/simple;
	bh=JQvPI0dwlcbtXenHQpByDU/wElZ5A1cHQEIAp7TlkIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgfrfnBJHdIQ3aMgZxN5pUriwchHLDVV+j5PL0elz/bQlymJWxNL1wSm9WENvXF6o2tZFeG9fUkSCQX4f8UyL1vcKzhSexiplCWcnFG4NC0eAuI6PMr15l06olwJu3dT7QvivEtu2sigDUZOL9PbH0eiMXoFBPzy5Lyr2e3kFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=qPiNayk8; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="qPiNayk8"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831608;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0T40JtsodI6Qzfe5bxPCIH5sxHsZhJgh4gnTR7BYVA=;
	b=qPiNayk8nFlscNzc7G9/FCahu7aJTZX+bOzUzZgmsQ2ZO3rDEA7/wDY40F4jVz1W2ikx0n
	VYauP8VD/uYj8A8cSV/fXDouAB9ZaZW4YGrI+YVsbcxI5KadSUC7wJfTjnamycbfJWKuVe
	Pww/0AfCPZCD++djRqfZjY3jFsWMm6n0z93qyoU381Mibneo32mTxTrd+TNwUu8yefnZ3V
	lsznT6qgRyXP6jsUmYqNHAQ1R2X2cSSkK71Hh3OFR8juXCW4EjCtsSrjgd8ZjZiRe67wcm
	G902IGQkrtlK3UwZWQc6otj7k/zpfYvUml3OV/7IF2iObSyVZLYGGfyRFbgkWg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 9/9] libselinux: support parallel selabel_lookup(3)
Date: Tue,  5 Nov 2024 19:33:19 +0100
Message-ID: <20241105183319.250410-10-cgoettsche@seltendoof.de>
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

Support the parallel usage of the translated label lookup via
selabel_lookup(3) in multi threaded applications by locking the step
of computing the translated context and the validation state.

A potential use case might can usage from a Rust application via FFI.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label.c          | 56 +++++++++++++++++++++++++++------
 libselinux/src/label_db.c       |  2 ++
 libselinux/src/label_file.h     |  4 +++
 libselinux/src/label_internal.h |  1 +
 libselinux/src/label_media.c    |  1 +
 libselinux/src/label_x.c        |  1 +
 6 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 06d743ec..2c510290 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -124,18 +124,32 @@ static inline int selabel_is_validate_set(const struct selinux_opt *opts,
 
 int selabel_validate(struct selabel_lookup_rec *contexts)
 {
-	int rc = 0;
+	bool validated;
+	int rc;
 
-	if (contexts->validated)
-		goto out;
+	validated = __atomic_load_n(&contexts->validated, __ATOMIC_ACQUIRE);
+	if (validated)
+		return 0;
+
+	__pthread_mutex_lock(&contexts->lock);
+
+	/* Check if another thread validated the context while we waited on the mutex */
+	validated = __atomic_load_n(&contexts->validated, __ATOMIC_ACQUIRE);
+	if (validated) {
+		__pthread_mutex_unlock(&contexts->lock);
+		return 0;
+	}
 
 	rc = selinux_validate(&contexts->ctx_raw);
+	if (rc == 0)
+		__atomic_store_n(&contexts->validated, true, __ATOMIC_RELEASE);
+
+	__pthread_mutex_unlock(&contexts->lock);
+
 	if (rc < 0)
-		goto out;
+		return -1;
 
-	contexts->validated = true;
-out:
-	return rc;
+	return 0;
 }
 
 /* Public API helpers */
@@ -143,11 +157,35 @@ static int selabel_fini(const struct selabel_handle *rec,
 			    struct selabel_lookup_rec *lr,
 			    bool translating)
 {
+	char *ctx_trans;
+	int rc;
+
 	if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
 		return -1;
 
-	if (translating && !lr->ctx_trans &&
-	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
+	if (!translating)
+		return 0;
+
+	ctx_trans = __atomic_load_n(&lr->ctx_trans, __ATOMIC_ACQUIRE);
+	if (ctx_trans)
+		return 0;
+
+	__pthread_mutex_lock(&lr->lock);
+
+	/* Check if another thread translated the context while we waited on the mutex */
+	ctx_trans = __atomic_load_n(&lr->ctx_trans, __ATOMIC_ACQUIRE);
+	if (ctx_trans) {
+		__pthread_mutex_unlock(&lr->lock);
+		return 0;
+	}
+
+	rc = selinux_raw_to_trans_context(lr->ctx_raw, &ctx_trans);
+	if (rc == 0)
+		__atomic_store_n(&lr->ctx_trans, ctx_trans, __ATOMIC_RELEASE);
+
+	__pthread_mutex_unlock(&lr->lock);
+
+	if (rc)
 		return -1;
 
 	return 0;
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 40d5fc4a..eb060ede 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -186,6 +186,7 @@ db_close(struct selabel_handle *rec)
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
+		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 	free(catalog);
 }
@@ -358,6 +359,7 @@ out_error:
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
+		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 	free(catalog);
 	fclose(filp);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 529a1bd2..de8190f9 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -661,6 +661,7 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 			.lr.ctx_trans = NULL,
 			.lr.lineno = lineno,
 			.lr.validated = false,
+			.lr.lock = PTHREAD_MUTEX_INITIALIZER,
 		};
 
 		data->num_specs++;
@@ -794,6 +795,7 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 			.lr.ctx_trans = NULL,
 			.lr.lineno = lineno,
 			.lr.validated = false,
+			.lr.lock = PTHREAD_MUTEX_INITIALIZER,
 		};
 
 		data->num_specs++;
@@ -818,6 +820,7 @@ static inline void free_spec_node(struct spec_node *node)
 
 		free(lspec->lr.ctx_raw);
 		free(lspec->lr.ctx_trans);
+		__pthread_mutex_destroy(&lspec->lr.lock);
 
 		if (lspec->from_mmap)
 			continue;
@@ -832,6 +835,7 @@ static inline void free_spec_node(struct spec_node *node)
 
 		free(rspec->lr.ctx_raw);
 		free(rspec->lr.ctx_trans);
+		__pthread_mutex_destroy(&rspec->lr.lock);
 		regex_data_free(rspec->regex);
 		__pthread_mutex_destroy(&rspec->regex_lock);
 
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 854f92fa..743dbf94 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -71,6 +71,7 @@ extern void digest_gen_hash(struct selabel_digest *digest);
 struct selabel_lookup_rec {
 	char * ctx_raw;
 	char * ctx_trans;
+	pthread_mutex_t lock;	/* lock for validation and translation */
 	unsigned int lineno;
 	bool validated;
 };
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index d535ef86..0510b5b1 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -177,6 +177,7 @@ static void close(struct selabel_handle *rec)
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
+		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 
 	if (spec_arr)
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index c0d1d475..1a5b9268 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -204,6 +204,7 @@ static void close(struct selabel_handle *rec)
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
+		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 
 	if (spec_arr)
-- 
2.45.2

