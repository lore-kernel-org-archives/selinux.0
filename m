Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F31D1DACA1
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933670; cv=none; b=S2LQ1FykuRImGLS/0Vo6X74Wr7wPcG2unnSfEv+EMgv+jsLi5xpZAgLwl95V3GWksfFE7vCXfMWqQsyQVRDqFRvwVF0492BkuKaNaRMxwuNU4F81GcrUlrSf4n9S6H9QxO+tp8+kONSl6Eb0t1bqXu1JnY63olOFYVie7sFoMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933670; c=relaxed/simple;
	bh=jERva+NGmRUvk0O7kSW/yItCNbm8/kAQ9rVE2Dgk6Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0D7hA77DN56IvLLM/bRKm46z5SkS2EL8cK9TkJ2E4CeVkWpqEROA/AmYdTHFgl+Q4VGH3Rfz2gHDypaPNOegqjJ/s9gttvfMUOqBkmKnk+2fIuMu4jK3RQ3KFSdcuh9mfh+V+sVCsyv5DWFmTjDrFVHATfiPt23zRJu1jxQXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbF4Z7Fk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbF4Z7Fk"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f145e5cd83so14113317b3.1
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933666; x=1734538466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he38c6rs+3hnVN/kxp2KHeSs+JO2uYvIvrH9RTK9jn0=;
        b=CbF4Z7FkT0IKjEC2WYgpjWX/jiBhQz2jZPCpomNxMOw2ayNRp3c3mwO/beog+zkjz4
         XZoU5eRkjrZ5vbwsVSuIuHnJ2jtS3G4J3WyY7i0Niu4VZhnppFo/X1xJ2s04SeeT7Lkn
         4iy5O6ZjN6o0MHF9sjq5cgqZ4rfKxKys6elo9KPij7yl99DLjvfBnmmHPM6xrw1vreKR
         SoeeEo1Q1Qx4t3844glN57bRNDZSiCMRdcOcW3uDl+QDfp6xXwJmIKTME86tbfBgnFaR
         aC/N8i30EYtNvpQZKoU12aC7yY6EwIo1KlWcklwdgaKksgOtm+O+YZQhseIVTwJ1igQJ
         1Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933666; x=1734538466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he38c6rs+3hnVN/kxp2KHeSs+JO2uYvIvrH9RTK9jn0=;
        b=C9sZvdZ9SghC0ca1oGhOcWqWRNxfPTcaxpIl28fg3J9UUheD8L553iBuB24uN/qxLo
         laH56OYPUhI58YpV75be6WPZ2247d+LHG7YCBEa1bB+lB9qzDoKJp2dA8xvSzVJV6pb9
         pkDIi59rwJVso7Jv5gp2B9J5Y8R8vHweaORjQl5LPSO9RdaywX0eC5vj/HGbWQCWM3wu
         6R6fcTBNT31ZQMbADazmW3Pf5YYoAw3WGJfd7JfjFWbwyhp5GK1ZEJx4qlspWlRKWqtL
         wzukXMtaHkZiWqMcyMZg4vALvRBovFbftTMUa2X/D1DHMwYuFlPZnufpakrl9FDaJgZz
         8G5A==
X-Gm-Message-State: AOJu0YxbLBpvNEAFvARTHP4JfXFldP1uYdkSA+xJb7E/UhrQ5VAKimS7
	P1gf4/TTOvoiA3ClxheDgDDKP1X1a346RteIwZbE9CrTIqER69h8fdZcBw==
X-Gm-Gg: ASbGnct4HyvihaCVNrpkbEgMwhM5wh8ha3CzXsPf913wjLUiVAuN43XlMYlRI3hv8NZ
	vc2esliveosi4d7oj8dpp6WMxkgF5kVomHc2945InSs/Z5Ze2PD3eK4wwvEBfwda/Kna4iaWZTq
	+tLKz6a+jhvVv2Lgyq0pDq9wCbbzERh9XzCub/jH0mb+1n7l9flsl0PGW7DhgaGf5o7SYMI8oED
	ifUph00eh8iieth49QTribliC6X0AYsWMJkaCzIFEuGkESmmreRMhy9T4ZfK75fVf9PZYXWoTPB
	9W/E/BycKmw=
X-Google-Smtp-Source: AGHT+IEVsygNShn1KEkT7tn9lBX71zvWtY6SLROp/rHt2bN3d0uD6Vmbxxg2I9FrytlcfPLLE90TvQ==
X-Received: by 2002:a05:690c:4c13:b0:6f0:237e:fc4c with SMTP id 00721157ae682-6f19e4f06f6mr830947b3.12.1733933665721;
        Wed, 11 Dec 2024 08:14:25 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cd96799sm2890237b3.41.2024.12.11.08.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:14:25 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	takayas@chromium.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 7/9] Revert "libselinux: support parallel selabel_lookup(3)"
Date: Wed, 11 Dec 2024 11:14:04 -0500
Message-ID: <20241211161417.126236-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211161417.126236-1-jwcart2@gmail.com>
References: <20241211161417.126236-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 20175564fcc6fdc1fee7847a2b5cb6c51353f41a.

Needed to revert commit 92306daf5219e73f6e8bc9fc7699399457999bcd
"libselinux: rework selabel_file(5) database", which broke Android
file_context matching.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/label.c          | 56 ++++++---------------------------
 libselinux/src/label_db.c       |  2 --
 libselinux/src/label_file.h     |  4 ---
 libselinux/src/label_internal.h |  1 -
 libselinux/src/label_media.c    |  1 -
 libselinux/src/label_x.c        |  1 -
 6 files changed, 9 insertions(+), 56 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 2c510290..06d743ec 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -124,32 +124,18 @@ static inline int selabel_is_validate_set(const struct selinux_opt *opts,
 
 int selabel_validate(struct selabel_lookup_rec *contexts)
 {
-	bool validated;
-	int rc;
+	int rc = 0;
 
-	validated = __atomic_load_n(&contexts->validated, __ATOMIC_ACQUIRE);
-	if (validated)
-		return 0;
-
-	__pthread_mutex_lock(&contexts->lock);
-
-	/* Check if another thread validated the context while we waited on the mutex */
-	validated = __atomic_load_n(&contexts->validated, __ATOMIC_ACQUIRE);
-	if (validated) {
-		__pthread_mutex_unlock(&contexts->lock);
-		return 0;
-	}
+	if (contexts->validated)
+		goto out;
 
 	rc = selinux_validate(&contexts->ctx_raw);
-	if (rc == 0)
-		__atomic_store_n(&contexts->validated, true, __ATOMIC_RELEASE);
-
-	__pthread_mutex_unlock(&contexts->lock);
-
 	if (rc < 0)
-		return -1;
+		goto out;
 
-	return 0;
+	contexts->validated = true;
+out:
+	return rc;
 }
 
 /* Public API helpers */
@@ -157,35 +143,11 @@ static int selabel_fini(const struct selabel_handle *rec,
 			    struct selabel_lookup_rec *lr,
 			    bool translating)
 {
-	char *ctx_trans;
-	int rc;
-
 	if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
 		return -1;
 
-	if (!translating)
-		return 0;
-
-	ctx_trans = __atomic_load_n(&lr->ctx_trans, __ATOMIC_ACQUIRE);
-	if (ctx_trans)
-		return 0;
-
-	__pthread_mutex_lock(&lr->lock);
-
-	/* Check if another thread translated the context while we waited on the mutex */
-	ctx_trans = __atomic_load_n(&lr->ctx_trans, __ATOMIC_ACQUIRE);
-	if (ctx_trans) {
-		__pthread_mutex_unlock(&lr->lock);
-		return 0;
-	}
-
-	rc = selinux_raw_to_trans_context(lr->ctx_raw, &ctx_trans);
-	if (rc == 0)
-		__atomic_store_n(&lr->ctx_trans, ctx_trans, __ATOMIC_RELEASE);
-
-	__pthread_mutex_unlock(&lr->lock);
-
-	if (rc)
+	if (translating && !lr->ctx_trans &&
+	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
 		return -1;
 
 	return 0;
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index eb060ede..40d5fc4a 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -186,7 +186,6 @@ db_close(struct selabel_handle *rec)
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
-		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 	free(catalog);
 }
@@ -359,7 +358,6 @@ out_error:
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
-		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 	free(catalog);
 	fclose(filp);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index de8190f9..529a1bd2 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -661,7 +661,6 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 			.lr.ctx_trans = NULL,
 			.lr.lineno = lineno,
 			.lr.validated = false,
-			.lr.lock = PTHREAD_MUTEX_INITIALIZER,
 		};
 
 		data->num_specs++;
@@ -795,7 +794,6 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 			.lr.ctx_trans = NULL,
 			.lr.lineno = lineno,
 			.lr.validated = false,
-			.lr.lock = PTHREAD_MUTEX_INITIALIZER,
 		};
 
 		data->num_specs++;
@@ -820,7 +818,6 @@ static inline void free_spec_node(struct spec_node *node)
 
 		free(lspec->lr.ctx_raw);
 		free(lspec->lr.ctx_trans);
-		__pthread_mutex_destroy(&lspec->lr.lock);
 
 		if (lspec->from_mmap)
 			continue;
@@ -835,7 +832,6 @@ static inline void free_spec_node(struct spec_node *node)
 
 		free(rspec->lr.ctx_raw);
 		free(rspec->lr.ctx_trans);
-		__pthread_mutex_destroy(&rspec->lr.lock);
 		regex_data_free(rspec->regex);
 		__pthread_mutex_destroy(&rspec->regex_lock);
 
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 743dbf94..854f92fa 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -71,7 +71,6 @@ extern void digest_gen_hash(struct selabel_digest *digest);
 struct selabel_lookup_rec {
 	char * ctx_raw;
 	char * ctx_trans;
-	pthread_mutex_t lock;	/* lock for validation and translation */
 	unsigned int lineno;
 	bool validated;
 };
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index be3df388..b541faf4 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -176,7 +176,6 @@ static void close(struct selabel_handle *rec)
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
-		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 
 	if (spec_arr)
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 5b0e4063..6bdba9cd 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -203,7 +203,6 @@ static void close(struct selabel_handle *rec)
 		free(spec->key);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
-		__pthread_mutex_destroy(&spec->lr.lock);
 	}
 
 	if (spec_arr)
-- 
2.47.1

