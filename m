Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1223C433FE
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 14:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbiDAOWg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiDAOWf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 10:22:35 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07433FBE1
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 07:20:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gh15so2101633qvb.8
        for <selinux@vger.kernel.org>; Fri, 01 Apr 2022 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rVEvEG5EmqpoGWNrEN7n9JqB68omYu+0V6hGYpT8xM=;
        b=SnGPx3Uvh6V8IG9chCuy8gReFCQJR+IoWj+Xm3N2ZK876x+8VVSa+HHRkp6YhYg6Q3
         RGiY2PLvbd6+Jev+QTzGxnObpN+Sq5OvPBctskpb1UougOQkd3SsRjkbyz1kGqCTSTa3
         3y2Ptt8mZTs/Sq/WNa/GU8DrWEBZG26LfJdf9NLSqUGsKazxxweku3L7kk3K747+3Cw2
         ui+19hMTu/RDQtg7JUsweKjDGcNjFgSxt+99EV1n2PBc6aByAjUXOGL3R9OuObuG+BB0
         lk4P26jvDaEYy4qS478EHCGnvzliAq9CZzcLIEXqwJO4V8K+WwYjLJxSBNkygv3GZd9T
         Uusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rVEvEG5EmqpoGWNrEN7n9JqB68omYu+0V6hGYpT8xM=;
        b=29/+oLYEUMHEXEZ8uh2xx5XohEal69bVeQe0xhXslccm3nC/8yoM/P+01yI98wye8v
         Q9khq3GobkT6+rIUWprj52ZLc0rA+QP9KlbcHJXaJLj0aTqVKBcTIzB9KgdKf1yIL2Ji
         1g71SM6Ghee0DX5y1n9wDPfy9ISdvEyjCZ1V7ZNbADh+ewcCJlLc2EDawAT6S4qC4d5m
         Afr7i+8ysYB1XtYfX+DQh4Z7PjSNOWTn2jSglqpa/+eWNP3AWibc/Zu87W83nBgV6An+
         PQjlVqeL9vyilIXaI4pBtsWFaW5AG6OhnbZY4I7P/08w1cDKtIbEvBMO8ryoDxdxpekd
         W1Aw==
X-Gm-Message-State: AOAM5316L2vtfZizUQzDfiM0k8l5a5juYVVUu/ap7EIemEwTQGtshItc
        eKmLWmWIVhB3jjp3ufQgBjIIpBQptgI=
X-Google-Smtp-Source: ABdhPJwo0Sg+CpW+pACIECLfQeKu9ms3JzSJCug5tkGQ8044SkH82TQaVyEbmWDrDDTCywQjHfsNbw==
X-Received: by 2002:a05:6214:d05:b0:441:527b:2148 with SMTP id 5-20020a0562140d0500b00441527b2148mr39540686qvh.0.1648822844303;
        Fri, 01 Apr 2022 07:20:44 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id n70-20020a372749000000b0067d4067ba89sm1359333qkn.100.2022.04.01.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:20:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol: Replace calls to mallocarray() with calls to calloc()
Date:   Fri,  1 Apr 2022 10:20:33 -0400
Message-Id: <20220401142033.895221-1-jwcart2@gmail.com>
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
v2
- Remove unused variables

 libsepol/src/expand.c        |  6 ++----
 libsepol/src/hashtab.c       |  5 +----
 libsepol/src/link.c          |  8 ++------
 libsepol/src/module.c        |  4 ++--
 libsepol/src/module_to_cil.c |  4 ++--
 libsepol/src/optimize.c      |  4 ++--
 libsepol/src/policydb.c      | 10 +++-------
 libsepol/src/private.h       |  9 ---------
 libsepol/src/services.c      | 12 +++---------
 libsepol/src/sidtab.c        |  6 +-----
 libsepol/src/user_record.c   |  2 +-
 libsepol/src/write.c         |  2 +-
 12 files changed, 20 insertions(+), 52 deletions(-)

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
index 3ecaf165..922a8a4a 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -43,7 +43,6 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 {
 
 	hashtab_t p;
-	unsigned int i;
 
 	p = (hashtab_t) malloc(sizeof(hashtab_val_t));
 	if (p == NULL)
@@ -54,13 +53,11 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
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
index adeae6eb..0cec41d2 100644
--- a/libsepol/src/sidtab.c
+++ b/libsepol/src/sidtab.c
@@ -26,13 +26,9 @@
 
 int sepol_sidtab_init(sidtab_t * s)
 {
-	int i;
-
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

