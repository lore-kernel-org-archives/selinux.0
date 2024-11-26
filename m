Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4618FDBA
	for <selinux@vger.kernel.org>; Tue, 26 Nov 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616800; cv=none; b=Xl/f3+6WD7qTZSwl47475KkYXKqHLO9cW33w+wQ1BV3I03MVW2PuVzmpyhVTXXzafAEAudeK7CXR6qqjDRV0xYqFnFu+miozU5/PI+GNYw8HS8qNvGX7iHxaDB8IxHKunR30VYHLiVcaX4d5nhqTgu2XFvXuw5bUyKFQuYDCGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616800; c=relaxed/simple;
	bh=1ZTCypzcXHi9LvzLnyJ/KcXnQ3VHQ7pQobATp7NmzZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOzpp8yf6eoGG8yNVBMoOPpvOWcSJKPCsDiuzzIR4imfiVOgQIea1jyzz4zoxxEPwmjiPvbIzPpWM8vilRevUwZAwQelQrRFucWMwCzMZPQwf7o3IucJh0RcCSpgTvufHE2XM0ce1qxjMrzVAwt8L4Noey/bT2lh4MaPCgavOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=HPLsn4J0; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="HPLsn4J0"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732616794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WnnYKqGsvMRFUBHZQHjvdFa3fGLJmOEoy4PQW5YTKQ=;
	b=HPLsn4J0QKuYWyE8AK9O3M5y0XiW7ogwEdNgylkr/wpI2xhI2O2K5ErrylxySdo31WyTSc
	OFhLGJsC8u4Cyw28sPLej+LLBgJjcl+YEYvr0eMwUs1sRV0cH/+s0b+Wp+003hTyONXkuR
	tO7i4eEBueCDKbTdRPf0SBKKoTexyj3HpAXHc4LR435B1gJiF7cKaJuWV0mD3dSSn5r9pV
	u+4arCLJ9meizAkMvzlYHnVB4NBuFafHgxW2AaF5JzXBObChQCLyZqQY3vVKhchVgcAdC7
	WHD8mQM9Qr4QKa7gVtFBANvAOCCJLmUJ9N9WD13WIUhwTXpNGu1P0MMFtewOFA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 2/3] libselinux: use vector instead of linked list for substitutions
Date: Tue, 26 Nov 2024 11:26:20 +0100
Message-ID: <20241126102621.20253-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241126102621.20253-1-cgoettsche@seltendoof.de>
References: <20241126102621.20253-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Utilize cache locality for the substitutions by storing them in
contiguous memory instead of a linked list.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: fix memleak in err label in selabel_subs_init()
v2: drop unnecessary check for zero length
---
 libselinux/src/label_file.c | 129 +++++++++++++++++++-----------------
 libselinux/src/label_file.h |  20 ++++--
 2 files changed, 83 insertions(+), 66 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 4e212aa4..8050ef1a 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1120,28 +1120,27 @@ static int process_file(const char *path, const char *suffix,
 	return -1;
 }
 
-static void selabel_subs_fini(struct selabel_sub *ptr)
+static void selabel_subs_fini(struct selabel_sub *subs, uint32_t num)
 {
-	struct selabel_sub *next;
-
-	while (ptr) {
-		next = ptr->next;
-		free(ptr->src);
-		free(ptr->dst);
-		free(ptr);
-		ptr = next;
+	for (uint32_t i = 0; i < num; i++) {
+		free(subs[i].src);
+		free(subs[i].dst);
 	}
+
+	free(subs);
 }
 
-static char *selabel_sub(const struct selabel_sub *ptr, const char *src)
+static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t num, const char *src)
 {
-	char *dst = NULL;
-	unsigned int len;
+	char *dst;
+	uint32_t len;
+
+	for (uint32_t i = 0; i < num; i++) {
+		const struct selabel_sub *ptr = &subs[i];
 
-	while (ptr) {
 		if (strncmp(src, ptr->src, ptr->slen) == 0 ) {
 			if (src[ptr->slen] == '/' ||
-			    src[ptr->slen] == 0) {
+			    src[ptr->slen] == '\0') {
 				if ((src[ptr->slen] == '/') &&
 				    (strcmp(ptr->dst, "/") == 0))
 					len = ptr->slen + 1;
@@ -1152,34 +1151,38 @@ static char *selabel_sub(const struct selabel_sub *ptr, const char *src)
 				return dst;
 			}
 		}
-		ptr = ptr->next;
 	}
+
 	return NULL;
 }
 
 #if !defined(BUILD_HOST) && !defined(ANDROID)
 static int selabel_subs_init(const char *path, struct selabel_digest *digest,
-			     struct selabel_sub **out_subs)
+			     struct selabel_sub **out_subs,
+			     uint32_t *out_num, uint32_t *out_alloc)
 {
 	char buf[1024];
-	FILE *cfg = fopen(path, "re");
-	struct selabel_sub *list = NULL, *sub = NULL;
+	FILE *cfg;
 	struct stat sb;
-	int status = -1;
+	struct selabel_sub *tmp = NULL;
+	uint32_t tmp_num = 0, tmp_alloc = 0;
+	char *src_cpy = NULL, *dst_cpy = NULL;
+	int rc;
 
 	*out_subs = NULL;
+	*out_num = 0;
+	*out_alloc = 0;
+
+	cfg = fopen(path, "re");
 	if (!cfg) {
 		/* If the file does not exist, it is not fatal */
 		return (errno == ENOENT) ? 0 : -1;
 	}
 
-	if (fstat(fileno(cfg), &sb) < 0)
-		goto out;
-
 	while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
-		char *ptr = NULL;
+		char *ptr;
 		char *src = buf;
-		char *dst = NULL;
+		char *dst;
 		size_t len;
 
 		while (*src && isspace((unsigned char)*src))
@@ -1207,62 +1210,68 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 			goto err;
 		}
 
-		sub = calloc(1, sizeof(*sub));
-		if (! sub)
+		src_cpy = strdup(src);
+		if (!src_cpy)
 			goto err;
 
-		sub->src = strdup(src);
-		if (! sub->src)
+		dst_cpy = strdup(dst);
+		if (!dst_cpy)
 			goto err;
 
-		sub->dst = strdup(dst);
-		if (! sub->dst)
+		rc = GROW_ARRAY(tmp);
+		if (rc)
 			goto err;
 
-		sub->slen = len;
-		sub->next = list;
-		list = sub;
-		sub = NULL;
+		tmp[tmp_num++] = (struct selabel_sub) {
+			.src = src_cpy,
+			.slen = len,
+			.dst = dst_cpy,
+		};
+		src_cpy = NULL;
+		dst_cpy = NULL;
 	}
 
+	rc = fstat(fileno(cfg), &sb);
+	if (rc < 0)
+		goto err;
+
 	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
 		goto err;
 
-	*out_subs = list;
-	status = 0;
+	*out_subs = tmp;
+	*out_num = tmp_num;
+	*out_alloc = tmp_alloc;
 
-out:
 	fclose(cfg);
-	return status;
+
+	return 0;
+
 err:
-	if (sub)
-		free(sub->src);
-	free(sub);
-	while (list) {
-		sub = list->next;
-		free(list->src);
-		free(list->dst);
-		free(list);
-		list = sub;
+	free(dst_cpy);
+	free(src_cpy);
+	for (uint32_t i = 0; i < tmp_num; i++) {
+		free(tmp[i].src);
+		free(tmp[i].dst);
 	}
-	goto out;
+	free(tmp);
+	fclose_errno_safe(cfg);
+	return -1;
 }
 #endif
 
 static char *selabel_sub_key(const struct saved_data *data, const char *key)
 {
-	char *ptr = NULL;
-	char *dptr = NULL;
+	char *ptr, *dptr;
 
-	ptr = selabel_sub(data->subs, key);
+	ptr = selabel_apply_subs(data->subs, data->subs_num, key);
 	if (ptr) {
-		dptr = selabel_sub(data->dist_subs, ptr);
+		dptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, ptr);
 		if (dptr) {
 			free(ptr);
 			ptr = dptr;
 		}
 	} else {
-		ptr = selabel_sub(data->dist_subs, key);
+		ptr = selabel_apply_subs(data->dist_subs, data->dist_subs_num, key);
 	}
 
 	return ptr;
@@ -1307,23 +1316,25 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	if (!path) {
 		status = selabel_subs_init(
 			selinux_file_context_subs_dist_path(),
-			rec->digest, &data->dist_subs);
+			rec->digest,
+			&data->dist_subs, &data->dist_subs_num, &data->dist_subs_alloc);
 		if (status)
 			goto finish;
 		status = selabel_subs_init(selinux_file_context_subs_path(),
-			rec->digest, &data->subs);
+			rec->digest,
+			&data->subs, &data->subs_num, &data->subs_alloc);
 		if (status)
 			goto finish;
 		path = selinux_file_context_path();
 	} else {
 		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
 		status = selabel_subs_init(subs_file, rec->digest,
-					   &data->dist_subs);
+					   &data->dist_subs, &data->dist_subs_num, &data->dist_subs_alloc);
 		if (status)
 			goto finish;
 		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
 		status = selabel_subs_init(subs_file, rec->digest,
-					   &data->subs);
+					   &data->subs, &data->subs_num, &data->subs_alloc);
 		if (status)
 			goto finish;
 	}
@@ -1391,8 +1402,8 @@ static void closef(struct selabel_handle *rec)
 	if (!data)
 		return;
 
-	selabel_subs_fini(data->subs);
-	selabel_subs_fini(data->dist_subs);
+	selabel_subs_fini(data->subs, data->subs_num);
+	selabel_subs_fini(data->dist_subs, data->dist_subs_num);
 
 	free_spec_node(data->root);
 	free(data->root);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index de8190f9..436982bf 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -67,11 +67,11 @@ extern struct lookup_result *lookup_all(struct selabel_handle *rec, const char *
 extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2);
 #endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
 
+/* A path substitution entry */
 struct selabel_sub {
-	char *src;
-	unsigned int slen;
-	char *dst;
-	struct selabel_sub *next;
+	char *src;				/* source path prefix */
+	char *dst;				/* substituted path prefix */
+	uint32_t slen;				/* length of source path prefix */
 };
 
 /* A regular expression file security context specification */
@@ -159,9 +159,17 @@ struct saved_data {
 
 	struct mmap_area *mmap_areas;
 
-	/* substitution support */
+	/*
+	 * Array of distribution substitutions
+	 */
 	struct selabel_sub *dist_subs;
+	uint32_t dist_subs_num, dist_subs_alloc;
+
+	/*
+	 * Array of local substitutions
+	 */
 	struct selabel_sub *subs;
+	uint32_t subs_num, subs_alloc;
 };
 
 static inline mode_t string_to_file_kind(const char *mode)
@@ -811,8 +819,6 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 	return 0;
 }
 
-#undef GROW_ARRAY
-
 static inline void free_spec_node(struct spec_node *node)
 {
 	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
-- 
2.45.2

