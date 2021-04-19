Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8581EC433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B6761246
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbhDSPQ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbhDSPQ4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:56 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37326C06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id u20so3915268qku.10
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evPRVxbFwAWkC5R48FuxkwmxPxWXmzzBFPOqwYJ8ZkA=;
        b=gAg2vylwP4FmuXPfhJqzwR3oimcLY8/xj7DiXQ8cTStg4fKkn166r+3ntZGl35Y/G3
         r9tuoaeHodwaoBVSR1hevbdv2bLG5fbOGd8NJD/y+lBYKOhT8L4XVo6DgxMoqZl+c2tq
         AexgX3s5QbXM0a64FqRKsVLGJRsSFf71P2u+greEaWzEjZ1IuvHuLMM5IQIWxzhzRIHZ
         c5l/4s5KeTN4UaRzaLYSZKSUvfktmBPHS6X7DtklL0hucDfQmsyTLOSuLMt0SQIqsMjq
         Cis59bCtnpSEc+Y9l3jdWDqs32vZTc2+jPYo9c5sDYEK+uIpMNArBm2GWitVFuhdz+Sw
         /Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evPRVxbFwAWkC5R48FuxkwmxPxWXmzzBFPOqwYJ8ZkA=;
        b=ZT25O6lYCKeCPqTltEGsaEtH/+HcDZ6AMsj/bw+t3gXu/YietY3BkWaaCKqaC6fxYR
         /VYGHzY5nPyVmKZcYDVItfVcfAh/O6UbnYGh4H64R9xKQcdgwzLPsGdAZfos/ObXS1xu
         eTkm2IS47EpBXUxRjp6FFiHNZe1Cstj2RYSbaQn8pNHg2iigNXMatflAygUeml6vJxpS
         b3f+w6wkwv5yNd3kTMTZtFP45kIHdyCczEsWE6zWHzFIYze96X8ID2VDNsMZTlOP65/l
         YGbCzi8GGmcJChtKQNz9bj0AkPFMPx6zHhm8yXmgt/BIo1tCtbBmGvZjumPKMu/tmwtQ
         rxgg==
X-Gm-Message-State: AOAM531E0aU/JIFIPI2it3/e6leyXIxUqNGnE9tBtNBhuo08L0dIIHlu
        3Dq4a1J6XqIKZmHhBjNorf0y8eHUceWxUg==
X-Google-Smtp-Source: ABdhPJzEi4TiW884UFNhNh6cc64tx5DQcy08fAwWeM6mggStdbfjpZS2S352vOxoQHtctujSx5VyZQ==
X-Received: by 2002:a37:a7d5:: with SMTP id q204mr6204588qke.23.1618845385287;
        Mon, 19 Apr 2021 08:16:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:25 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 10/11 v2] libsepol/cil: Create function cil_add_decl_to_symtab() and refactor
Date:   Mon, 19 Apr 2021 11:15:56 -0400
Message-Id: <20210419151557.87561-11-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The functionality of adding a declaration to a symbol table is also
needed in __cil_copy_node_helper() and not just cil_gen_node().

Create a new function called cil_add_decl_to_symtab() to add a
declaration to a symtab and refactor cil_gen_node() and
__cil_copy_node_helper() to use the new function.

By using the new function, __cil_copy_node_helper() will now allow
duplicate declarations when appropriate.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 63 +++++++++++++++++++-------------
 libsepol/cil/src/cil_build_ast.h |  2 +
 libsepol/cil/src/cil_copy_ast.c  |  6 ++-
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 14cdce14..ec81db55 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -102,11 +102,45 @@ static int cil_allow_multiple_decls(struct cil_db *db, enum cil_flavor f_new, en
 	return CIL_FALSE;
 }
 
+int cil_add_decl_to_symtab(struct cil_db *db, symtab_t *symtab, hashtab_key_t key, struct cil_symtab_datum *datum, struct cil_tree_node *node)
+{
+	int rc;
+
+	if (symtab == NULL || datum == NULL || node == NULL) {
+		return SEPOL_ERR;
+	}
+
+	rc = cil_symtab_insert(symtab, key, datum, node);
+	if (rc == SEPOL_EEXIST) {
+		struct cil_symtab_datum *prev;
+		rc = cil_symtab_get_datum(symtab, key, &prev);
+		if (rc != SEPOL_OK) {
+			cil_log(CIL_ERR, "Re-declaration of %s %s, but previous declaration could not be found\n",cil_node_to_string(node), key);
+			return SEPOL_ERR;
+		}
+		if (!cil_allow_multiple_decls(db, node->flavor, FLAVOR(prev))) {
+			/* multiple_decls not ok, ret error */
+			struct cil_tree_node *n = NODE(prev);
+			cil_log(CIL_ERR, "Re-declaration of %s %s\n",
+				cil_node_to_string(node), key);
+			cil_tree_log(node, CIL_ERR, "Previous declaration of %s",
+				     cil_node_to_string(n));
+			return SEPOL_ERR;
+		}
+		/* multiple_decls is enabled and works for this datum type, add node */
+		cil_list_append(prev->nodes, CIL_NODE, node);
+		node->data = prev;
+		cil_symtab_datum_destroy(datum);
+		free(datum);
+	}
+
+	return SEPOL_OK;
+}
+
 int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_symtab_datum *datum, hashtab_key_t key, enum cil_sym_index sflavor, enum cil_flavor nflavor)
 {
 	int rc = SEPOL_ERR;
 	symtab_t *symtab = NULL;
-	struct cil_symtab_datum *prev;
 
 	rc = cil_verify_name((const char*)key, nflavor);
 	if (rc != SEPOL_OK) {
@@ -121,30 +155,9 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 	ast_node->data = datum;
 	ast_node->flavor = nflavor;
 
-	if (symtab != NULL) {
-		rc = cil_symtab_insert(symtab, (hashtab_key_t)key, datum, ast_node);
-		if (rc == SEPOL_EEXIST) {
-			rc = cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev);
-			if (rc != SEPOL_OK) {
-				cil_log(CIL_ERR, "Re-declaration of %s %s, but previous declaration could not be found\n",cil_node_to_string(ast_node), key);
-				goto exit;
-			}
-			if (!cil_allow_multiple_decls(db, nflavor, FLAVOR(prev))) {
-				/* multiple_decls not ok, ret error */
-				struct cil_tree_node *node = NODE(prev);
-				cil_log(CIL_ERR, "Re-declaration of %s %s\n",
-					cil_node_to_string(ast_node), key);
-				cil_tree_log(node, CIL_ERR, "Previous declaration of %s",
-					cil_node_to_string(node));
-				rc = SEPOL_ERR;
-				goto exit;
-			}
-			/* multiple_decls is enabled and works for this datum type, add node */
-			cil_list_append(prev->nodes, CIL_NODE, ast_node);
-			ast_node->data = prev;
-			cil_symtab_datum_destroy(datum);
-			free(datum);
-		}
+	rc = cil_add_decl_to_symtab(db, symtab, key, datum, ast_node);
+	if (rc != SEPOL_OK) {
+		goto exit;
 	}
 
 	if (ast_node->parent->flavor == CIL_MACRO) {
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 8153e51e..fd9053ce 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -37,6 +37,8 @@
 #include "cil_tree.h"
 #include "cil_list.h"
 
+int cil_add_decl_to_symtab(struct cil_db *db, symtab_t *symtab, hashtab_key_t key, struct cil_symtab_datum *datum, struct cil_tree_node *node);
+
 int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_symtab_datum *datum, hashtab_key_t key, enum cil_sym_index sflavor, enum cil_flavor nflavor);
 int cil_parse_to_list(struct cil_tree_node *parse_cl_head, struct cil_list *ast_cl, enum cil_flavor flavor);
 
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index ed967861..12bc553c 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -2031,7 +2031,11 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 				rc = SEPOL_ERR;
 				goto exit;
 			}
-			rc = cil_symtab_insert(symtab, ((struct cil_symtab_datum*)orig->data)->name, ((struct cil_symtab_datum*)data), new);
+
+			rc = cil_add_decl_to_symtab(db, symtab, DATUM(orig->data)->name, DATUM(data), new);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
 
 			namespace = new;
 			while (namespace->flavor != CIL_MACRO && namespace->flavor != CIL_BLOCK && namespace->flavor != CIL_ROOT) {
-- 
2.26.3

