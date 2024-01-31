Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790B7B3CB
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706537; cv=none; b=e/+7yE/EorWvWq/IoS+3T2aXrsuGZ4gozx1PKFcK8deC+2n3r0yR2eyZ1t0AO4uWf+BpGyAL7lKW6LZyfCyJjDS8RHGoGBztSWOHudMhAR8LVBAKojSibX9F9C9TY/ovc6+kE+P3HnDtJ8UjmmSxqKikPgbIET5gLWL7fR/WUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706537; c=relaxed/simple;
	bh=EGvDKcmC2MmDDM/jgwV59iYj1DkTqivVx7To5L+qkas=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYPrIxHseYS3WGTRHHLSo1cPQEt7pR5aT5AEQRXrG53UsuwPvAGwEqH+qau0z636kvjBKVO1OVHLshsLfFer2nTDZe0v33AnNk5OXc0OghDh0oOsLDHUPz7oqXuwjnD45X0oA7tP2GBSbP4aTRSGWy2eRyynGGYMNX5c1339Aoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=crLHFHS0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="crLHFHS0"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f7b91ce4fso1344039a12.0
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 05:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706706533; x=1707311333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReElE90TAsMtEWqH5iu/uIPRfjwU93Y4DMwRSOErR5o=;
        b=crLHFHS095RQo6JuYTGIHozKL/YPLQbnkxLKUDFt2P/LJTa64qx9wEPI1qjxdE4Vxg
         XwwWu3pfGHiWfuWxHh4EsKgpIjHWs5Z4vl2cLo1d+YFH8+SVLlavmMjLEN1FwVRXBPrn
         R5lXSvgq8PCJ6IMImiK+4/pw/gWNyP7dPDqK0TayT8M8ik5tRXmYZ4WwoPgn+O8xFCyR
         s0APjLghqUDqCTOF7agrUPvToEFKzX6KdZyMeZHXZpCmCtuwWazAiG10DnhtMb53WkNa
         MiSHaSPiTdD/6cYEzQC7s6M4qVU4qaTTBXhNhjocyrG1Ha4mP3pJM2sqUFgz0B5CkPjB
         qIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706533; x=1707311333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReElE90TAsMtEWqH5iu/uIPRfjwU93Y4DMwRSOErR5o=;
        b=IpOIlR69CFVvi7VKDs6AYJkftkJw6fGtlLyZFKcyoevfak1gLLQbgiKYTr6a2b8lo+
         TcqXRJeRSA1Aro63CmN+MHNqfeDujyMhL5ScTXnMRVvfzg5oalnLxKLRD9Ach7+oK8Gd
         poDrCwJoLOPqxj61QmWjiLW1PY7BQOO4ikCZCM1+DaHgCFhGACMLgVy8HJXSiJdBDZa7
         TjKmdhwBUlQqrnh+zzlMZHpBjdCAvAhVlEyN+wbf1SOm6i9fIyKZMgBNYEud405LYA5y
         8fHKsLh8vnquwVeb6GAV/Au+puYH4C60SkIh7kYW/QDiDiNCZl85JEJXdCtWV0zEsrHr
         rylA==
X-Gm-Message-State: AOJu0YyDG0FBCyS0Yz/Qezd1zxjCVAyom5iXUAjApA7+M4vWizDEvD/+
	cYlaLhgzgm1Ia7a6q7e3U57COmhk73ngCvrn1AAa6EOhpt/Rn1MEXIE09b6I
X-Google-Smtp-Source: AGHT+IE4elbQoEn8uSZrGmNxzWFfEKjOpikS8/27FZKensiMpgVqTInQR1pGwdqb+Ix2Jol9hc7WBA==
X-Received: by 2002:a17:906:e28c:b0:a36:4d6c:f85c with SMTP id gg12-20020a170906e28c00b00a364d6cf85cmr1579569ejb.16.1706706533543;
        Wed, 31 Jan 2024 05:08:53 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm890351ejm.216.2024.01.31.05.08.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:08:53 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH v2 9/9] libselinux: support parallel selabel_lookup(3)
Date: Wed, 31 Jan 2024 14:08:35 +0100
Message-ID: <20240131130840.48155-10-cgzones@googlemail.com>
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

Support the parallel usage of the translated label lookup via
selabel_lookup(3) in multi threaded applications by locking the step
of computing the translated context and the validation state.

A potential use case might can usage from a Rust application via FFI.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add patch
---
 libselinux/src/label.c          | 56 +++++++++++++++++++++++++++------
 libselinux/src/label_db.c       |  2 ++
 libselinux/src/label_file.c     |  4 ++-
 libselinux/src/label_file.h     |  4 +++
 libselinux/src/label_internal.h |  1 +
 libselinux/src/label_media.c    |  1 +
 libselinux/src/label_x.c        |  1 +
 7 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index d2e703ef..10e78a9b 100644
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
index 2ff10b2f..ed178d34 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -183,6 +183,7 @@ db_close(struct selabel_handle *rec)
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
+		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 	free(catalog);
 }
@@ -355,6 +356,7 @@ out_error:
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
+		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 	free(catalog);
 	fclose(filp);
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index ac349bc5..3520fe2d 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -175,6 +175,7 @@ static int merge_mmap_spec_nodes(struct spec_node *restrict dest, struct spec_no
 			for (uint32_t i = 0; i < source->literal_specs_num; i++) {
 				source->literal_specs[i].lr.ctx_raw = NULL;
 				source->literal_specs[i].lr.ctx_trans = NULL;
+				__pthread_mutex_destroy(&source->literal_specs[i].lr.lock);
 			}
 
 		} else {
@@ -214,9 +215,10 @@ static int merge_mmap_spec_nodes(struct spec_node *restrict dest, struct spec_no
 			for (uint32_t i = 0; i < source->regex_specs_num; i++) {
 				source->regex_specs[i].lr.ctx_raw = NULL;
 				source->regex_specs[i].lr.ctx_trans = NULL;
+				__pthread_mutex_destroy(&source->regex_specs[i].lr.lock);
 				source->regex_specs[i].regex = NULL;
 				source->regex_specs[i].regex_compiled = false;
-				__pthread_mutex_init(&source->regex_specs[i].regex_lock, NULL);
+				__pthread_mutex_destroy(&source->regex_specs[i].regex_lock);
 			}
 		} else {
 			assert(dest->regex_specs == NULL);
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
index fad5ea6d..7bd85804 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -172,6 +172,7 @@ static void close(struct selabel_handle *rec)
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
+		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 
 	if (spec_arr)
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index bf569ca5..49c33b3b 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -199,6 +199,7 @@ static void close(struct selabel_handle *rec)
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
+		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 
 	if (spec_arr)
-- 
2.43.0

