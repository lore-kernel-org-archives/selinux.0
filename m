Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819EBC433EF
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 20:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350465AbiC3UbL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350971AbiC3UbJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 16:31:09 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66065486
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 13:29:22 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id 10so19234646qtz.11
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5zJGvcTGLLtw6kbHLfrujlJYas4eErH89AnwiiadsU=;
        b=CMYzwbxVVAG/82roT8dX/NaIFkIHXzXdVWp3gFxkGJHxx1gSaiHqAxSJVaG5uIvN+m
         SqWbIxIA2XELqhUi+1c2ok7XJYIXBacDk1nDVtpGUZnjUWhTJs42MhjDH5u4V/98Y8x/
         OXxQdkdbEUYpILSwEeukyfT9tmQGl3mH/ld7D9CeF961od5L0MqTzf1Sd4rOtN5yw5vV
         9rNKDfR3Uu3vcZDxudeuFTRX9CY5pOOWqmUtsbUu8MIHQNpnEf/YyvLnLMinEeSsA4hd
         fWjfcOy37JXTRkew8jHnHhqczTpus7K26NHzw8uH6gsD51dWrFlQ9MDKQaPSqjE1Rb8B
         aH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5zJGvcTGLLtw6kbHLfrujlJYas4eErH89AnwiiadsU=;
        b=g1eoHaAq0VjF6pM013qw/nVAA/xd+1KM7HaWU6tM14uMmxLSP0UNfhUMY/HuRVTduh
         f7uKWVHcUAN2g0EZBY50Q7t36a8ekOneG5jj4wwtG5vmkzWEro39SpcqCgMBDXH7M8xU
         6/cx3sMS0iYzD2GsMjdZPxV0UvSby/hGUR2EPc0RxG7S2Oj5Lxn7ZrjFaEPfcq97mUDG
         FulHHFLXn/6Skp3A7+UAqY5I+pL0bgeRfzP1u2zFOqB/wiJ51GpWu4PBTZj/+6bfezhb
         FKJYLlykmKml89v1tzw5M/LrqbpjoZnOFtKryGgfB4FECgb4d3gEjzmxUh0YrBDVu0fC
         zogg==
X-Gm-Message-State: AOAM533qZ+J+aUpTHVW7Fd3yjkjhg+QpFmakoxp1KBz9pA3TYWNmESyT
        YX9VAVO+4Go00nACJQyQT/zmJ1PLf0E=
X-Google-Smtp-Source: ABdhPJwYP++k1bBCkbpjaMdc5ROhZ4zsHi6gcsjqt+yoGQLYM5jPgGkmYA3Yg+hD/HQnypuOgqHjaA==
X-Received: by 2002:a05:622a:1892:b0:2e2:324e:e9ae with SMTP id v18-20020a05622a189200b002e2324ee9aemr1334887qtc.116.1648672161512;
        Wed, 30 Mar 2022 13:29:21 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id bp31-20020a05622a1b9f00b002e21e80ecd8sm17393440qtb.45.2022.03.30.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:29:21 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Replace calls to mallocarray() with calls to calloc()
Date:   Wed, 30 Mar 2022 16:29:09 -0400
Message-Id: <20220330202909.819437-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since calloc() will return an error if nmemb * size would overflow,
just use it instead of mallocarray(). This also allows code that
initializes the array to zero to be removed.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c        |  6 ++----
 libsepol/src/hashtab.c       |  4 +---
 libsepol/src/link.c          |  8 ++------
 libsepol/src/module.c        |  4 ++--
 libsepol/src/module_to_cil.c |  4 ++--
 libsepol/src/optimize.c      |  4 ++--
 libsepol/src/policydb.c      | 10 +++-------
 libsepol/src/private.h       |  9 ---------
 libsepol/src/services.c      | 12 +++---------
 libsepol/src/sidtab.c        |  4 +---
 libsepol/src/user_record.c   |  2 +-
 libsepol/src/write.c         |  2 +-
 12 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 7da51a40..7316124f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -3153,17 +3153,15 @@ int expand_module(sepol_handle_t * handle,
 		goto cleanup;
 
 	/* Build the type<->attribute maps and remove attributes. */
-	state.out->attr_type_map = mallocarray(state.out->p_types.nprim,
+	state.out->attr_type_map = calloc(state.out->p_types.nprim,
 					  sizeof(ebitmap_t));
-	state.out->type_attr_map = mallocarray(state.out->p_types.nprim,
+	state.out->type_attr_map = calloc(state.out->p_types.nprim,
 					  sizeof(ebitmap_t));
 	if (!state.out->attr_type_map || !state.out->type_attr_map) {
 		ERR(handle, "Out of memory!");
 		goto cleanup;
 	}
 	for (i = 0; i < state.out->p_types.nprim; i++) {
-		ebitmap_init(&state.out->type_attr_map[i]);
-		ebitmap_init(&state.out->attr_type_map[i]);
 		/* add the type itself as the degenerate case */
 		if (ebitmap_set_bit(&state.out->type_attr_map[i], i, 1)) {
 			ERR(handle, "Out of memory!");
diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index 3ecaf165..872dfd80 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -54,13 +54,11 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 	p->nel = 0;
 	p->hash_value = hash_value;
 	p->keycmp = keycmp;
-	p->htable = (hashtab_ptr_t *) mallocarray(size, sizeof(hashtab_ptr_t));
+	p->htable = (hashtab_ptr_t *) calloc(size, sizeof(hashtab_ptr_t));
 	if (p->htable == NULL) {
 		free(p);
 		return NULL;
 	}
-	for (i = 0; i < size; i++)
-		p->htable[i] = (hashtab_ptr_t) NULL;
 
 	return p;
 }
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 21a5a935..ecfb5786 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1681,14 +1681,10 @@ static int copy_scope_index(scope_index_t * src, scope_index_t * dest,
 	}
 
 	/* next copy the enabled permissions data  */
-	if ((dest->class_perms_map = mallocarray(largest_mapped_class_value,
-					    sizeof(*dest->class_perms_map))) ==
-	    NULL) {
+	if ((dest->class_perms_map = calloc(largest_mapped_class_value,
+					    sizeof(*dest->class_perms_map))) == NULL) {
 		goto cleanup;
 	}
-	for (i = 0; i < largest_mapped_class_value; i++) {
-		ebitmap_init(dest->class_perms_map + i);
-	}
 	dest->class_perms_len = largest_mapped_class_value;
 	for (i = 0; i < src->class_perms_len; i++) {
 		ebitmap_t *srcmap = src->class_perms_map + i;
diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index d93d08a2..5246a599 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -409,14 +409,14 @@ static int module_package_read_offsets(sepol_module_package_t * mod,
 		goto err;
 	}
 
-	off = (size_t *) mallocarray(nsec + 1, sizeof(size_t));
+	off = (size_t *) calloc(nsec + 1, sizeof(size_t));
 	if (!off) {
 		ERR(file->handle, "out of memory");
 		goto err;
 	}
 
 	free(buf);
-	buf = mallocarray(nsec, sizeof(uint32_t));
+	buf = calloc(nsec, sizeof(uint32_t));
 	if (!buf) {
 		ERR(file->handle, "out of memory");
 		goto err;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index c9e88f1e..07507852 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -430,7 +430,7 @@ static int stack_init(struct stack **stack)
 		goto exit;
 	}
 
-	s->stack = mallocarray(STACK_SIZE, sizeof(*s->stack));
+	s->stack = calloc(STACK_SIZE, sizeof(*s->stack));
 	if (s->stack == NULL) {
 		goto exit;
 	}
@@ -1008,7 +1008,7 @@ static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, char ***n
 		goto exit;
 	}
 
-	name_arr = mallocarray(num, sizeof(*name_arr));
+	name_arr = calloc(num, sizeof(*name_arr));
 	if (name_arr == NULL) {
 		log_err("Out of memory");
 		rc = -1;
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 93ff2116..a38025ec 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -45,7 +45,7 @@ static int type_vec_init(struct type_vec *v)
 {
 	v->capacity = TYPE_VEC_INIT_SIZE;
 	v->count = 0;
-	v->types = mallocarray(v->capacity, sizeof(*v->types));
+	v->types = calloc(v->capacity, sizeof(*v->types));
 	if (!v->types)
 		return -1;
 	return 0;
@@ -97,7 +97,7 @@ static struct type_vec *build_type_map(const policydb_t *p)
 {
 	unsigned int i, k;
 	ebitmap_node_t *n;
-	struct type_vec *map = mallocarray(p->p_types.nprim, sizeof(*map));
+	struct type_vec *map = calloc(p->p_types.nprim, sizeof(*map));
 	if (!map)
 		return NULL;
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index fc71463e..adc512fd 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4126,7 +4126,7 @@ static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
 		goto cleanup;
 	}
 	if ((scope->decl_ids =
-	     mallocarray(scope->decl_ids_len, sizeof(uint32_t))) == NULL) {
+	     calloc(scope->decl_ids_len, sizeof(uint32_t))) == NULL) {
 		goto cleanup;
 	}
 	rc = next_entry(scope->decl_ids, fp, sizeof(uint32_t) * scope->decl_ids_len);
@@ -4517,14 +4517,10 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	}
 
 	if (policy_type == POLICY_KERN) {
-		p->type_attr_map = mallocarray(p->p_types.nprim, sizeof(ebitmap_t));
-		p->attr_type_map = mallocarray(p->p_types.nprim, sizeof(ebitmap_t));
+		p->type_attr_map = calloc(p->p_types.nprim, sizeof(ebitmap_t));
+		p->attr_type_map = calloc(p->p_types.nprim, sizeof(ebitmap_t));
 		if (!p->type_attr_map || !p->attr_type_map)
 			goto bad;
-		for (i = 0; i < p->p_types.nprim; i++) {
-			ebitmap_init(&p->type_attr_map[i]);
-			ebitmap_init(&p->attr_type_map[i]);
-		}
 		for (i = 0; i < p->p_types.nprim; i++) {
 			if (r_policyvers >= POLICYDB_VERSION_AVTAB) {
 				if (ebitmap_read(&p->type_attr_map[i], fp))
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index a8cc1472..1833b497 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -84,15 +84,6 @@ extern size_t put_entry(const void *ptr, size_t size, size_t n,
 		        struct policy_file *fp);
 extern int str_read(char **strp, struct policy_file *fp, size_t len);
 
-static inline void* mallocarray(size_t nmemb, size_t size) {
-	if (size && nmemb > (size_t)-1 / size) {
-		errno = ENOMEM;
-		return NULL;
-	}
-
-	return malloc(nmemb * size);
-}
-
 #ifndef HAVE_REALLOCARRAY
 static inline void* reallocarray(void *ptr, size_t nmemb, size_t size) {
 	if (size && nmemb > (size_t)-1 / size) {
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 29723729..909cfaff 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -712,7 +712,7 @@ mls_ops:
 	 * Generate the same number of answer buffer entries as expression
 	 * buffers (as there will never be more).
 	 */
-	answer_list = mallocarray(expr_count, sizeof(*answer_list));
+	answer_list = calloc(expr_count, sizeof(*answer_list));
 	if (!answer_list) {
 		ERR(NULL, "failed to allocate answer stack");
 		rc = -ENOMEM;
@@ -2163,12 +2163,11 @@ int sepol_get_user_sids(sepol_security_id_t fromsid,
 	}
 	usercon.user = user->s.value;
 
-	mysids = mallocarray(maxnel, sizeof(sepol_security_id_t));
+	mysids = calloc(maxnel, sizeof(sepol_security_id_t));
 	if (!mysids) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(mysids, 0, maxnel * sizeof(sepol_security_id_t));
 
 	ebitmap_for_each_positive_bit(&user->roles.roles, rnode, i) {
 		role = policydb->role_val_to_struct[i];
@@ -2198,17 +2197,12 @@ int sepol_get_user_sids(sepol_security_id_t fromsid,
 				mysids[mynel++] = sid;
 			} else {
 				maxnel += SIDS_NEL;
-				mysids2 =
-				    mallocarray(maxnel,
-					   sizeof(sepol_security_id_t));
-
+				mysids2 = calloc(maxnel, sizeof(sepol_security_id_t));
 				if (!mysids2) {
 					rc = -ENOMEM;
 					free(mysids);
 					goto out;
 				}
-				memset(mysids2, 0,
-				       maxnel * sizeof(sepol_security_id_t));
 				memcpy(mysids2, mysids,
 				       mynel * sizeof(sepol_security_id_t));
 				free(mysids);
diff --git a/libsepol/src/sidtab.c b/libsepol/src/sidtab.c
index adeae6eb..b9675612 100644
--- a/libsepol/src/sidtab.c
+++ b/libsepol/src/sidtab.c
@@ -28,11 +28,9 @@ int sepol_sidtab_init(sidtab_t * s)
 {
 	int i;
 
-	s->htable = mallocarray(SIDTAB_SIZE, sizeof(sidtab_ptr_t));
+	s->htable = calloc(SIDTAB_SIZE, sizeof(sidtab_ptr_t));
 	if (!s->htable)
 		return -ENOMEM;
-	for (i = 0; i < SIDTAB_SIZE; i++)
-		s->htable[i] = (sidtab_ptr_t) NULL;
 	s->nel = 0;
 	s->next_sid = 1;
 	s->shutdown = 0;
diff --git a/libsepol/src/user_record.c b/libsepol/src/user_record.c
index 404fa3a8..dddd23b9 100644
--- a/libsepol/src/user_record.c
+++ b/libsepol/src/user_record.c
@@ -267,7 +267,7 @@ int sepol_user_get_roles(sepol_handle_t * handle,
 
 	unsigned int i;
 	const char **tmp_roles =
-	    (const char **)mallocarray(user->num_roles, sizeof(char *));
+	    (const char **)calloc(user->num_roles, sizeof(char *));
 	if (!tmp_roles)
 		goto omem;
 
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 9df5b0bd..d7ac2b25 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -2117,7 +2117,7 @@ static int scope_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 		 * buffer.  this would have been easier with C99's
 		 * dynamic arrays... */
 		rc = POLICYDB_ERROR;
-		dyn_buf = mallocarray(items, sizeof(*dyn_buf));
+		dyn_buf = calloc(items, sizeof(*dyn_buf));
 		if (!dyn_buf)
 			goto err;
 		buf = dyn_buf;
-- 
2.34.1

