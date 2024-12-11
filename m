Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3B1DBB37
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933666; cv=none; b=vGU8WgVQPxdGXxwEyYanIU6u5x0D27GGiecJk2WoeI4TzVX5ke2RyQknclD4HodDpHc3OgbkAAeaYuc7E346PpM+m3YXkVsvfyXO0W/mDSxx+Wfj/wS/ZSiB00abhMWSngovczY2YyAlWCQqYIag88KHj107TSXs6czGnTil06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933666; c=relaxed/simple;
	bh=BrIUXKO4nzg6j7w66KDUsKHom/DULEjSIApPd2TWnkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBKp1ke0o/hSrKEELG9sIYwneaK3BwOzwjJQxH80CpLQk12/GIheXdyGAn7MpOryDka+IKq0no4NKVyS+t/Y7jqTS3NBJ8PXX8k6GBVDxzQvqWBsU/zOGW22iEYDd4ehpINPsC0eyl4W0eTaqZyCUb8pLKPIZYTuwrHqWIfpZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh4JsjeB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh4JsjeB"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef81222be7so64511157b3.3
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933663; x=1734538463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzFwQMetmumI8HKCxQD9it3khh5LAPfWmgH0msZkVhk=;
        b=mh4JsjeBDv6KvE/qVdmkuqUFrfylBIcZx6DUDrVBikcK8dqbZWuRNDWofitzHNsDTa
         IS0hgRNBE4aKcFUqbU5+16LhScNe3v5HGjGkLGetgMAEtfBjphvJxadhctUYRfzuLlwp
         GxJxzydACML3ZchaIAmepxCXPAMaCG+qGQivloR0YBWwLX2cksnjVJryKpfa9Kc6B24z
         j+BzRt4OLsPp5lY6GkepXEHf+dMJlAgJCBVNxg6MN6aDqxvYk9Sw+Cv9WAeAcT4OFC4a
         82RSLGlJk9gePI6B8cr+xa84vi0JTdKBS7xVGVfRtGSVF6ZET2a6/1kmKOguTn74Ap+M
         m1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933663; x=1734538463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzFwQMetmumI8HKCxQD9it3khh5LAPfWmgH0msZkVhk=;
        b=aNtG05lYOkXMI6PB8s/+D/lEBKIwlaVDR8WY+ftITDLxlp5eeCcysc2Uer1TRJV7c4
         EllGhaZzz1VTjxz1wVyoqZp+aZAXNvfVtfJCVGJnJPUKu6nbYPRCOJx19RpGLo8PinlA
         p64FWAHd/YMLWiDU79e9DMe4DiztNS1/lFDxtclJ2+mUBfFRZK6DiQAf6D3p1i3RVfnl
         lWCc0QShy5djdGUtxXnBNVYP401d0JPL386/DvqbMZzk8HDFeLYbCJRle+CMpsTVqA0q
         XqQd1PyGDtrVB7QeG5YOI3KMKlEdwG+w9Hr3ywe9+oYRDLdSYkU6J6g1YqcWXIdVQO+y
         Pzuw==
X-Gm-Message-State: AOJu0Yzf5Cbj480dQTywDRzz2vPp0e4TTFr/26LugraDfi9qJCf5XAqP
	NbqRpf0W1S1x7lGkcIx6eKLFad2EYtt+NTFvG/gO/gW/oCa2v9wFHsyP7g==
X-Gm-Gg: ASbGncuRoc8LwMKogTIumfdO4fGLFOPOIpPJLCcdk9YmXHaSk/4NxWmUIJyDyRYAgvf
	32BDE8ZjRU5emzh+y5DzO3wdkuTTanqjYht0hSz+Iz6/p7UzfXYtg6y2ArvqdshBN04vMqryCE3
	NJLxYk8LkUHwvYuk3Bunr7gu+3tKgwl54lL3blWSYmtHp7g2eV8RhfzlQ3K0mEobRdHliDIzOvX
	rUXqSZnrObZlxksoseVpclT8umCae6ltF+CYm0ZAJt8UNWAG9JGY30M8vAVh3XIP0fHuyNMviE5
	R1hMQKNgsDA=
X-Google-Smtp-Source: AGHT+IGBXbSaZo4MwhObASPg4vNsiVSg5V1zGpGR6wyPbBgUaCZcMLOyXuCw2sdtJJr7mOytJiqBOg==
X-Received: by 2002:a05:690c:3707:b0:6f0:21d6:44a4 with SMTP id 00721157ae682-6f1989f30a8mr1089087b3.10.1733933663314;
        Wed, 11 Dec 2024 08:14:23 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cd96799sm2890237b3.41.2024.12.11.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:14:22 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	takayas@chromium.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/9] Revert "libselinux: use vector instead of linked list for substitutions"
Date: Wed, 11 Dec 2024 11:14:01 -0500
Message-ID: <20241211161417.126236-4-jwcart2@gmail.com>
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

This reverts commit 4d436e4bf80284ac3b645bad022a9757dbc2dd36.

Needed to revert commit 92306daf5219e73f6e8bc9fc7699399457999bcd
"libselinux: rework selabel_file(5) database", which broke Android
file_context matching.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/label_file.c | 129 +++++++++++++++++-------------------
 libselinux/src/label_file.h |  20 ++----
 2 files changed, 66 insertions(+), 83 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b7ff8c09..be1ee11a 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1188,27 +1188,28 @@ static int process_file(const char *path, const char *suffix,
 	return -1;
 }
 
-static void selabel_subs_fini(struct selabel_sub *subs, uint32_t num)
+static void selabel_subs_fini(struct selabel_sub *ptr)
 {
-	for (uint32_t i = 0; i < num; i++) {
-		free(subs[i].src);
-		free(subs[i].dst);
+	struct selabel_sub *next;
+
+	while (ptr) {
+		next = ptr->next;
+		free(ptr->src);
+		free(ptr->dst);
+		free(ptr);
+		ptr = next;
 	}
-
-	free(subs);
 }
 
-static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num, const char *src)
+static char *selabel_sub(const struct selabel_sub *ptr, const char *src)
 {
-	char *dst;
-	uint32_t len;
-
-	for (uint32_t i = 0; i < num; i++) {
-		const struct selabel_sub *ptr = &subs[i];
+	char *dst = NULL;
+	unsigned int len;
 
+	while (ptr) {
 		if (strncmp(src, ptr->src, ptr->slen) == 0 ) {
 			if (src[ptr->slen] == '/' ||
-			    src[ptr->slen] == '\0') {
+			    src[ptr->slen] == 0) {
 				if ((src[ptr->slen] == '/') &&
 				    (strcmp(ptr->dst, "/") == 0))
 					len = ptr->slen + 1;
@@ -1219,38 +1220,34 @@ static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num, co
 				return dst;
 			}
 		}
+		ptr = ptr->next;
 	}
-
 	return NULL;
 }
 
 #if !defined(BUILD_HOST) && !defined(ANDROID)
 static int selabel_subs_init(const char *path, struct selabel_digest *digest,
-			     struct selabel_sub **out_subs,
-			     uint32_t *out_num, uint32_t *out_alloc)
+			     struct selabel_sub **out_subs)
 {
 	char buf[1024];
-	FILE *cfg;
+	FILE *cfg = fopen(path, "re");
+	struct selabel_sub *list = NULL, *sub = NULL;
 	struct stat sb;
-	struct selabel_sub *tmp = NULL;
-	uint32_t tmp_num = 0, tmp_alloc = 0;
-	char *src_cpy = NULL, *dst_cpy = NULL;
-	int rc;
+	int status = -1;
 
 	*out_subs = NULL;
-	*out_num = 0;
-	*out_alloc = 0;
-
-	cfg = fopen(path, "re");
 	if (!cfg) {
 		/* If the file does not exist, it is not fatal */
 		return (errno == ENOENT) ? 0 : -1;
 	}
 
+	if (fstat(fileno(cfg), &sb) < 0)
+		goto out;
+
 	while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
-		char *ptr;
+		char *ptr = NULL;
 		char *src = buf;
-		char *dst;
+		char *dst = NULL;
 		size_t len;
 
 		while (*src && isspace((unsigned char)*src))
@@ -1278,68 +1275,62 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 			goto err;
 		}
 
-		src_cpy = strdup(src);
-		if (!src_cpy)
+		sub = calloc(1, sizeof(*sub));
+		if (! sub)
 			goto err;
 
-		dst_cpy = strdup(dst);
-		if (!dst_cpy)
+		sub->src = strdup(src);
+		if (! sub->src)
 			goto err;
 
-		rc = GROW_ARRAY(tmp);
-		if (rc)
+		sub->dst = strdup(dst);
+		if (! sub->dst)
 			goto err;
 
-		tmp[tmp_num++] = (struct selabel_sub) {
-			.src = src_cpy,
-			.slen = len,
-			.dst = dst_cpy,
-		};
-		src_cpy = NULL;
-		dst_cpy = NULL;
+		sub->slen = len;
+		sub->next = list;
+		list = sub;
+		sub = NULL;
 	}
 
-	rc = fstat(fileno(cfg), &sb);
-	if (rc < 0)
-		goto err;
-
 	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
 		goto err;
 
-	*out_subs = tmp;
-	*out_num = tmp_num;
-	*out_alloc = tmp_alloc;
+	*out_subs = list;
+	status = 0;
 
+out:
 	fclose(cfg);
-
-	return 0;
-
+	return status;
 err:
-	free(dst_cpy);
-	free(src_cpy);
-	for (uint32_t i = 0; i < tmp_num; i++) {
-		free(tmp[i].src);
-		free(tmp[i].dst);
+	if (sub)
+		free(sub->src);
+	free(sub);
+	while (list) {
+		sub = list->next;
+		free(list->src);
+		free(list->dst);
+		free(list);
+		list = sub;
 	}
-	free(tmp);
-	fclose_errno_safe(cfg);
-	return -1;
+	goto out;
 }
 #endif
 
 static char *selabel_sub_key(const struct saved_data *data, const char *key)
 {
-	char *ptr, *dptr;
+	char *ptr = NULL;
+	char *dptr = NULL;
 
-	ptr = selabel_apply_subs(data->subs, data->subs_num, key);
+	ptr = selabel_sub(data->subs, key);
 	if (ptr) {
-		dptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, ptr);
+		dptr = selabel_sub(data->dist_subs, ptr);
 		if (dptr) {
 			free(ptr);
 			ptr = dptr;
 		}
 	} else {
-		ptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, key);
+		ptr = selabel_sub(data->dist_subs, key);
 	}
 
 	return ptr;
@@ -1384,25 +1375,23 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	if (!path) {
 		status = selabel_subs_init(
 			selinux_file_context_subs_dist_path(),
-			rec->digest,
-			&data->dist_subs, &data->dist_subs_num, &data->dist_subs_alloc);
+			rec->digest, &data->dist_subs);
 		if (status)
 			goto finish;
 		status = selabel_subs_init(selinux_file_context_subs_path(),
-			rec->digest,
-			&data->subs, &data->subs_num, &data->subs_alloc);
+			rec->digest, &data->subs);
 		if (status)
 			goto finish;
 		path = selinux_file_context_path();
 	} else {
 		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
 		status = selabel_subs_init(subs_file, rec->digest,
-					   &data->dist_subs, &data->dist_subs_num, &data->dist_subs_alloc);
+					   &data->dist_subs);
 		if (status)
 			goto finish;
 		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
 		status = selabel_subs_init(subs_file, rec->digest,
-					   &data->subs, &data->subs_num, &data->subs_alloc);
+					   &data->subs);
 		if (status)
 			goto finish;
 	}
@@ -1470,8 +1459,8 @@ static void closef(struct selabel_handle *rec)
 	if (!data)
 		return;
 
-	selabel_subs_fini(data->subs, data->subs_num);
-	selabel_subs_fini(data->dist_subs, data->dist_subs_num);
+	selabel_subs_fini(data->subs);
+	selabel_subs_fini(data->dist_subs);
 
 	free_spec_node(data->root);
 	free(data->root);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index d5dd2be1..b59db003 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -67,11 +67,11 @@ extern struct lookup_result *lookup_all(struct selabel_handle *rec, const char *
 extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2);
 #endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
 
-/* A path substitution entry */
 struct selabel_sub {
-	char *src;				/* source path prefix */
-	char *dst;				/* substituted path prefix */
-	uint32_t slen;				/* length of source path prefix */
+	char *src;
+	unsigned int slen;
+	char *dst;
+	struct selabel_sub *next;
 };
 
 /* A regular expression file security context specification */
@@ -159,17 +159,9 @@ struct saved_data {
 
 	struct mmap_area *mmap_areas;
 
-	/*
-	 * Array of distribution substitutions
-	 */
+	/* substitution support */
 	struct selabel_sub *dist_subs;
-	uint32_t dist_subs_num, dist_subs_alloc;
-
-	/*
-	 * Array of local substitutions
-	 */
 	struct selabel_sub *subs;
-	uint32_t subs_num, subs_alloc;
 };
 
 void free_spec_node(struct spec_node *node);
@@ -795,6 +787,8 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 	return 0;
 }
 
+#undef GROW_ARRAY
+
 /* This will always check for buffer over-runs and either read the next entry
  * if buf != NULL or skip over the entry (as these areas are mapped in the
  * current buffer). */
-- 
2.47.1

