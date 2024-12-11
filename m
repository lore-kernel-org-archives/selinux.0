Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417B1DAC80
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933669; cv=none; b=Fbq/cDSgE9iI0OdbmuGflPIyswfsy0qqbvtHjQS0yZabxxzCv6LMbrvcypTcei6tAeBE2aKG3mcZ7qiAvGZFHmSwNfwM+aydaYMjpmWQhdlGwRgt2T3+bj1ws9s+vp6CbaUSa9phE/+xMaH2yCp/DY51l+nZ77OZaqUTF8PYb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933669; c=relaxed/simple;
	bh=GB3Dzl5x+WvWJUWRFro9kQKCYN29GCbBuumAK3wMX/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOYL2Nw4bkbwCvbru0U2+I1GPGzN277TQJWDy1kIJdtsXCpe6wOkjplkRmKd5VckxKCDjRgYd8oXcuJ+95sFt0p7VvOpi0FFJeonweq7jHVbYU9wyPzW7M7qCIVbnTHcl5Gj3cjArYgBRcBc1Q5Fq3aPM9Hz1FFRFPT2byApkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSDK5rGh; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSDK5rGh"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e396c98af22so5483610276.1
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933665; x=1734538465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/S8OZS5W7udoJBfkSHgqiE6aHnbqqk9IhcNZhm4/cA=;
        b=ZSDK5rGhIhXVb0cIdYgJ2d9mC48P+I5/iPietlBfdEUWu3FBm6HWhMg+DG/dagkQmm
         OgtfK2qNPH88J6D45qCKI+UVjiSyKUSgJHQFyjtnEwChymSShML98OAZ53IkDeJNnxIw
         DJcrbKy5czW6uMhCUzhJo49mvhDww9yCj0nQmFgFJjhQ9J7NquTMbKanwXl/lKK3/uUK
         Ce/JHDPVnLZgHmzxFsXQL1SIca3PnCchxBrFucp0Mqeg4aIZ4W7wTggInRhw6fEK2PQr
         ohCgGtHmG/ap5E31+0/KVI5rZCJk/6eLS8RPpRqFNqVjfE8ULJxQQH73J93vl5cLojSj
         p1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933665; x=1734538465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/S8OZS5W7udoJBfkSHgqiE6aHnbqqk9IhcNZhm4/cA=;
        b=OzhXUBG60ONrFw6144SiLqLSNexpXg8RIRi6N6aIPWCv/5r75H0FjYLdBem/RiKkbH
         ZqN9nm+4Sgd3G6/iAX8C/TFe0NbEk8qwL0DGeKXxk4FzEtDJ1tGNUzpz3+8iEtba4WBg
         jzx2tRdxzBAZkdZ0Elg2DoKBqEWoz80tTseuo20BkiUyoSThLrRY+ZOA7fO3sJlPPNRz
         XXynQ/o/1V3jHMLdf5IJMyycioXDIXCMjI7WicBovvkM1FM9DraY1fEsq0L7wfdeXfRU
         sqQ+iN7ZqOgvtTfvU9I/cdms6o/AengpFWUK2ovGQlraGwHIJcpgKYHk7clXEdGJwgfT
         Gzxw==
X-Gm-Message-State: AOJu0Ywo8WqYv4HHfcTUYXS98bbVrkNGSwCW9E3vDJbaJynOJaNv+N1K
	CEeN+bSFp+8NtKonb1z0LNatr/lytJnC2O1wPzD/quSkbPVi7s8bjkKJyg==
X-Gm-Gg: ASbGnctJIl4PhSTJ7Ws0ChF3930MfkeO6cje1es7A5otZcfT1plsZZJJpxYTZ6ovLUL
	Lr4Vu/Hj9TN/AX/CfXud8WQRPpukoTRAqZQIGotsptV3ckd2Uz7MKFEGIqcpV4voKWbJiLY5TMW
	8gYvsFkm5ERkVqJtH7p+1Lps7WnVJse3s6wWzRt9D57FTu8lwCXT9lK3G2hnEaDCGrfa9sWCcIr
	A4GVChSaMQyftORqhdmAk9ClFoUpqnGxUFBCyXdILzKq7wC5brPC5xVeV2tRub+b+DMinjIihkQ
	RkHnxvaorDc=
X-Google-Smtp-Source: AGHT+IFlsczh9z1OxJQclnLOgg8pcQntICdwZt+EhSzP1Xba+PZg1V3+1GIOcLrIXDqC2E0IEqKqBA==
X-Received: by 2002:a05:690c:fd3:b0:6ef:77e3:efe3 with SMTP id 00721157ae682-6f19ad9a564mr697067b3.13.1733933664971;
        Wed, 11 Dec 2024 08:14:24 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cd96799sm2890237b3.41.2024.12.11.08.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:14:24 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	takayas@chromium.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/9] Revert "libselinux: move functions out of header file"
Date: Wed, 11 Dec 2024 11:14:03 -0500
Message-ID: <20241211161417.126236-6-jwcart2@gmail.com>
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

This reverts commit 856895ca255cafb183b853704094fe6a37a9a8c8.

Needed to revert commit 92306daf5219e73f6e8bc9fc7699399457999bcd
"libselinux: rework selabel_file(5) database", which broke Android
file_context matching.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/label_file.c | 68 -----------------------------------
 libselinux/src/label_file.h | 71 +++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 71 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 40bcb9ee..189a5ed2 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -34,74 +34,6 @@
 #endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
 
 
-void free_spec_node(struct spec_node *node)
-{
-	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
-		struct literal_spec *lspec = &node->literal_specs[i];
-
-		free(lspec->lr.ctx_raw);
-		free(lspec->lr.ctx_trans);
-		__pthread_mutex_destroy(&lspec->lr.lock);
-
-		if (lspec->from_mmap)
-			continue;
-
-		free(lspec->literal_match);
-		free(lspec->regex_str);
-	}
-	free(node->literal_specs);
-
-	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
-		struct regex_spec *rspec = &node->regex_specs[i];
-
-		free(rspec->lr.ctx_raw);
-		free(rspec->lr.ctx_trans);
-		__pthread_mutex_destroy(&rspec->lr.lock);
-		regex_data_free(rspec->regex);
-		__pthread_mutex_destroy(&rspec->regex_lock);
-
-		if (rspec->from_mmap)
-			continue;
-
-		free(rspec->regex_str);
-	}
-	free(node->regex_specs);
-
-	for (uint32_t i = 0; i < node->children_num; i++)
-		free_spec_node(&node->children[i]);
-	free(node->children);
-
-	if (!node->from_mmap)
-		free(node->stem);
-}
-
-void sort_spec_node(struct spec_node *node, struct spec_node *parent)
-{
-	/* A node should not be its own parent */
-	assert(node != parent);
-	/* Only root node has NULL stem */
-	assert((!parent && !node->stem) || (parent && node->stem && node->stem[0] != '\0'));
-	/* A non-root node should not be empty */
-	assert(!parent || (node->literal_specs_num || node->regex_specs_num || node->children_num));
-
-
-	node->parent = parent;
-
-	/* Sort for comparison support and binary search lookup */
-
-	if (node->literal_specs_num > 1)
-		qsort(node->literal_specs, node->literal_specs_num, sizeof(struct literal_spec), compare_literal_spec);
-
-	if (node->regex_specs_num > 1)
-		qsort(node->regex_specs, node->regex_specs_num, sizeof(struct regex_spec), compare_regex_spec);
-
-	if (node->children_num > 1)
-		qsort(node->children, node->children_num, sizeof(struct spec_node), compare_spec_node);
-
-	for (uint32_t i = 0; i < node->children_num; i++)
-		sort_spec_node(&node->children[i], node);
-}
-
 /*
  * Warn about duplicate specifications.
  */
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index b59db003..de8190f9 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -164,9 +164,6 @@ struct saved_data {
 	struct selabel_sub *subs;
 };
 
-void free_spec_node(struct spec_node *node);
-void sort_spec_node(struct spec_node *node, struct spec_node *parent);
-
 static inline mode_t string_to_file_kind(const char *mode)
 {
 	if (mode[0] != '-' || mode[1] == '\0' || mode[2] != '\0')
@@ -404,6 +401,33 @@ static inline int compare_spec_node(const void *p1, const void *p2)
 	return rc;
 }
 
+static inline void sort_spec_node(struct spec_node *node, struct spec_node *parent)
+{
+	/* A node should not be its own parent */
+	assert(node != parent);
+	/* Only root node has NULL stem */
+	assert((!parent && !node->stem) || (parent && node->stem && node->stem[0] != '\0'));
+	/* A non-root node should not be empty */
+	assert(!parent || (node->literal_specs_num || node->regex_specs_num || node->children_num));
+
+
+	node->parent = parent;
+
+	/* Sort for comparison support and binary search lookup */
+
+	if (node->literal_specs_num > 1)
+		qsort(node->literal_specs, node->literal_specs_num, sizeof(struct literal_spec), compare_literal_spec);
+
+	if (node->regex_specs_num > 1)
+		qsort(node->regex_specs, node->regex_specs_num, sizeof(struct regex_spec), compare_regex_spec);
+
+	if (node->children_num > 1)
+		qsort(node->children, node->children_num, sizeof(struct spec_node), compare_spec_node);
+
+	for (uint32_t i = 0; i < node->children_num; i++)
+		sort_spec_node(&node->children[i], node);
+}
+
 static inline void sort_specs(struct saved_data *data)
 {
 	sort_spec_node(data->root, NULL);
@@ -789,6 +813,47 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 
 #undef GROW_ARRAY
 
+static inline void free_spec_node(struct spec_node *node)
+{
+	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
+		struct literal_spec *lspec = &node->literal_specs[i];
+
+		free(lspec->lr.ctx_raw);
+		free(lspec->lr.ctx_trans);
+		__pthread_mutex_destroy(&lspec->lr.lock);
+
+		if (lspec->from_mmap)
+			continue;
+
+		free(lspec->literal_match);
+		free(lspec->regex_str);
+	}
+	free(node->literal_specs);
+
+	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
+		struct regex_spec *rspec = &node->regex_specs[i];
+
+		free(rspec->lr.ctx_raw);
+		free(rspec->lr.ctx_trans);
+		__pthread_mutex_destroy(&rspec->lr.lock);
+		regex_data_free(rspec->regex);
+		__pthread_mutex_destroy(&rspec->regex_lock);
+
+		if (rspec->from_mmap)
+			continue;
+
+		free(rspec->regex_str);
+	}
+	free(node->regex_specs);
+
+	for (uint32_t i = 0; i < node->children_num; i++)
+		free_spec_node(&node->children[i]);
+	free(node->children);
+
+	if (!node->from_mmap)
+		free(node->stem);
+}
+
 /* This will always check for buffer over-runs and either read the next entry
  * if buf != NULL or skip over the entry (as these areas are mapped in the
  * current buffer). */
-- 
2.47.1

