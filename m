Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C7EC47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E616128E
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhFHQCS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:18 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:35407 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhFHQCR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:17 -0400
Received: by mail-ej1-f49.google.com with SMTP id h24so33483150ejy.2
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zuJF77diJ0OlqenndOdxFGXjb+CzZpkVStMkjT4TTio=;
        b=RjT0qQWQ7h0sAz2Nk570DfD4c0fREpQpyNb6bRHmNM/MZOLdRUCy7ZyBgr/FuGjXCf
         7LTOoMIWcQMYZ1+7TDIN4e5pqWgxlBKA8LMqRsVJw+fdIhD38furWyWp5y5/+H8mx1//
         tNRKW9E9V9TsLkPatWCncIyhXR/zrfBg8z7eYUFH2ZfqZ1OiUbSRVwDV7G8ZTbGbO+U4
         h4FLH7CmjHSXjw6CK44aEOkA3+pjCVTLGXhEEs+RnFhHHZoq0FJ37fnhTWAVELuIZ+qf
         MPZ5o/ivECxB6uNr/8zdioDK/OyLz2puB+HAyfMQCGE+KJFisNZQItFuivnM21TQuvpo
         z9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuJF77diJ0OlqenndOdxFGXjb+CzZpkVStMkjT4TTio=;
        b=XKOKeGoCKfBbO/Wf2MZxzbGIpjEzXd1vJqoC5/y6AayojYnw0fMhGhkfZDkh01YDVj
         CmHdYFU/17CDX7GojqXY7/BV9pEMTbSagGf5+xVX49NHo3R2Beouwsc6ex1bw5x6wMxd
         wAO6kEhkm32iPqLe5GJAMNFUBL7ItJx1xXVaFhMCGMHKfpW4YwaJ8sHcaGMHCmyqNeSz
         HToCkWt7kZP4lz015VjjvboI33h9o9BgxUs+DCs2doBp4uBzeFvq2jjLi0hcKZqAFRdC
         5jvmIRigY/AFlnvhx+j2hoz/rqNKK1Qyjr3P0AXuuN6GYLjnuTG3OPe2QipB+vKf3mEm
         C52g==
X-Gm-Message-State: AOAM531pAPxWd7ClV3C1lLUGd42ar9krVMmOnWjvKt8IDgJXFBWsAkHH
        RktRRZBoMC7DejwxGCzGLjgOb3oZMwA=
X-Google-Smtp-Source: ABdhPJwDJKEphFXiyDaxgB1RXQfj6YvoyXwuKqO2Vw4ka0GAdzHquFP161l8GLmbFaOclLVgA4Ry5Q==
X-Received: by 2002:a17:906:f285:: with SMTP id gu5mr24343991ejb.226.1623167963855;
        Tue, 08 Jun 2021 08:59:23 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 08/23] libsepol/cil: follow declaration-after-statement
Date:   Tue,  8 Jun 2021 17:58:57 +0200
Message-Id: <20210608155912.32047-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Follow the project style of no declaration after statement.

Found by the gcc warning -Wdeclaration-after-statement

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c      | 5 +++--
 libsepol/cil/src/cil_build_ast.c   | 5 +++--
 libsepol/cil/src/cil_fqn.c         | 3 ++-
 libsepol/cil/src/cil_list.c        | 7 ++++---
 libsepol/cil/src/cil_post.c        | 2 +-
 libsepol/cil/src/cil_resolve_ast.c | 6 +++---
 libsepol/cil/src/cil_strpool.c     | 3 ++-
 7 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 18532aad..85094b01 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -593,11 +593,11 @@ exit:
 int __cil_typeattr_bitmap_init(policydb_t *pdb)
 {
 	int rc = SEPOL_ERR;
+	uint32_t i;
 
 	pdb->type_attr_map = cil_malloc(pdb->p_types.nprim * sizeof(ebitmap_t));
 	pdb->attr_type_map = cil_malloc(pdb->p_types.nprim * sizeof(ebitmap_t));
 
-	uint32_t i = 0;
 	for (i = 0; i < pdb->p_types.nprim; i++) {
 		ebitmap_init(&pdb->type_attr_map[i]);
 		ebitmap_init(&pdb->attr_type_map[i]);
@@ -2657,6 +2657,7 @@ int __cil_constrain_expr_to_sepol_expr_helper(policydb_t *pdb, const struct cil_
 	int rc = SEPOL_ERR;
 	struct cil_list_item *item;
 	enum cil_flavor flavor;
+	enum cil_flavor cil_op;
 	constraint_expr_t *op, *h1, *h2, *t1, *t2;
 	int is_leaf = CIL_FALSE;
 
@@ -2673,7 +2674,7 @@ int __cil_constrain_expr_to_sepol_expr_helper(policydb_t *pdb, const struct cil_
 		goto exit;
 	}
 
-	enum cil_flavor cil_op = (enum cil_flavor)(uintptr_t)item->data;
+	cil_op = (enum cil_flavor)(uintptr_t)item->data;
 	switch (cil_op) {
 	case CIL_NOT:
 		op->expr_type = CEXPR_NOT;
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 42d10c87..9a9bc598 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5173,6 +5173,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	char *key = NULL;
 	struct cil_macro *macro = NULL;
 	struct cil_tree_node *macro_content = NULL;
+	struct cil_tree_node *current_item;
 	enum cil_syntax syntax[] = {
 		CIL_SYN_STRING,
 		CIL_SYN_STRING,
@@ -5195,7 +5196,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 
 	key = parse_current->next->data;
 
-	struct cil_tree_node *current_item = parse_current->next->next->cl_head;
+	current_item = parse_current->next->next->cl_head;
 	while (current_item != NULL) {
 		enum cil_syntax param_syntax[] = {
 			CIL_SYN_STRING,
@@ -5205,6 +5206,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		int param_syntax_len = sizeof(param_syntax)/sizeof(*param_syntax);
 		char *kind = NULL;
 		struct cil_param *param = NULL;
+		struct cil_list_item *curr_param;
 
 		rc =__cil_verify_syntax(current_item->cl_head, param_syntax, param_syntax_len);
 		if (rc != SEPOL_OK) {
@@ -5263,7 +5265,6 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		}
 
 		//walk current list and check for duplicate parameters
-		struct cil_list_item *curr_param;
 		cil_list_for_each(curr_param, macro->params) {
 			if (param->str == ((struct cil_param*)curr_param->data)->str) {
 				cil_log(CIL_ERR, "Duplicate parameter\n");
diff --git a/libsepol/cil/src/cil_fqn.c b/libsepol/cil/src/cil_fqn.c
index 097222a8..46db069b 100644
--- a/libsepol/cil/src/cil_fqn.c
+++ b/libsepol/cil/src/cil_fqn.c
@@ -78,12 +78,13 @@ static int __cil_fqn_qualify_blocks(__attribute__((unused)) hashtab_key_t k, has
 	struct cil_tree_node *node = NODE(datum);
 	int i;
 	int rc = SEPOL_OK;
+	int newlen;
 
 	if (node->flavor != CIL_BLOCK) {
 		goto exit;
 	}
 
-	int newlen = fqn_args->len + strlen(datum->name) + 1;
+	newlen = fqn_args->len + strlen(datum->name) + 1;
 	if (newlen >= CIL_MAX_NAME_LENGTH) {
 		cil_log(CIL_INFO, "Fully qualified name for block %s is too long\n", datum->name);
 		rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_list.c b/libsepol/cil/src/cil_list.c
index 4e7843cb..8a426f1f 100644
--- a/libsepol/cil/src/cil_list.c
+++ b/libsepol/cil/src/cil_list.c
@@ -55,15 +55,16 @@ void cil_list_init(struct cil_list **list, enum cil_flavor flavor)
 
 void cil_list_destroy(struct cil_list **list, unsigned destroy_data)
 {
+	struct cil_list_item *item;
+
 	if (*list == NULL) {
 		return;
 	}
 
-	struct cil_list_item *item = (*list)->head;
-	struct cil_list_item *next = NULL;
+	item = (*list)->head;
 	while (item != NULL)
 	{
-		next = item->next;
+		struct cil_list_item *next = item->next;
 		if (item->flavor == CIL_LIST) {
 			cil_list_destroy((struct cil_list**)&(item->data), destroy_data);
 			free(item);
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 05842b64..7bca0834 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -213,8 +213,8 @@ int cil_post_filecon_compare(const void *a, const void *b)
 	struct fc_data *a_data = cil_malloc(sizeof(*a_data));
 	struct fc_data *b_data = cil_malloc(sizeof(*b_data));
 	char *a_path = cil_malloc(strlen(a_filecon->path_str) + 1);
-	a_path[0] = '\0';
 	char *b_path = cil_malloc(strlen(b_filecon->path_str) + 1);
+	a_path[0] = '\0';
 	b_path[0] = '\0';
 	strcat(a_path, a_filecon->path_str);
 	strcat(b_path, b_filecon->path_str);
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index d8481002..a322b1b7 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3949,10 +3949,10 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 		enum cil_log_level lvl = CIL_ERR;
 
 		if (optional != NULL) {
-			lvl = CIL_INFO;
-
 			struct cil_optional *opt = (struct cil_optional *)optional->data;
-			struct cil_tree_node *opt_node = NODE(opt);;
+			struct cil_tree_node *opt_node = NODE(opt);
+
+			lvl = CIL_INFO;
 			/* disable an optional if something failed to resolve */
 			opt->enabled = CIL_FALSE;
 			cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
index 2598bbf3..70bca363 100644
--- a/libsepol/cil/src/cil_strpool.c
+++ b/libsepol/cil/src/cil_strpool.c
@@ -75,9 +75,10 @@ char *cil_strpool_add(const char *str)
 
 	strpool_ref = hashtab_search(cil_strpool_tab, (hashtab_key_t)str);
 	if (strpool_ref == NULL) {
+		int rc;
 		strpool_ref = cil_malloc(sizeof(*strpool_ref));
 		strpool_ref->str = cil_strdup(str);
-		int rc = hashtab_insert(cil_strpool_tab, (hashtab_key_t)strpool_ref->str, strpool_ref);
+		rc = hashtab_insert(cil_strpool_tab, (hashtab_key_t)strpool_ref->str, strpool_ref);
 		if (rc != SEPOL_OK) {
 			pthread_mutex_unlock(&cil_strpool_mutex);
 			cil_log(CIL_ERR, "Failed to allocate memory\n");
-- 
2.32.0

