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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E9C433F2
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D8A60249
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhCVQrZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhCVQrP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Mar 2021 12:47:15 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467B7C061574
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:47:15 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s2so12816842qtx.10
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79pWD6D7Vsx1PH5bL/XBtvkh9K5YsKHF3I4Y3JhC0yA=;
        b=jW6Bu6hLi8JgBJa/NV9vlcQZNKTubtvGIRBbKRsJGNiirFqS+PXZgxco2tYHJoDhjD
         8zNeyBkbG7+Ek/07vvGMqmAge7PgwTo4WpjnDGYNw7Y06eWKR3ZDHKhJ8Wotfnl/Uckn
         m6w3FT1o39GeB/puYYBhfDzC+Tll1PsaSG1rnX+m6su2RBNhEvS/cBmkIFZdzxmwp09Z
         nrM2WGy/pWhv/AAwUuGKcEC+LSUWETbO4tG130LFQUvDLK7DTFGc2nS4136SHfrpkQjH
         lpHELr5GYMzBgRBX6MnDBWbBYY1e5QHAcLGGtME8uXAwzi8xPCkuoG/LfAQtn+Xo0/Te
         Qr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79pWD6D7Vsx1PH5bL/XBtvkh9K5YsKHF3I4Y3JhC0yA=;
        b=RWuXeXTLMAYx48qXKyKwQcnWSN5AY7m6/I8lqtOjeKMWgIZFXjLnofNkmyzZDhhmt5
         t/pdOBKsdmzyeO64niwsGVod+bby7pOqkh7ZkiwjdkCptdZulPWjEMednnSkKFZttwl2
         XWogO8bRagr7D62Yf+/dWYgUEL2RhZrcpqrYu8KQ+URggej2dKs1pTUO/MKxPo1IA1wp
         JXqgfn7vNOb3YvLOVLp0uv3Ft89QQMi33vz2luP3ns3LwWLNF4AVyT6pJemwtjYMvoza
         iS327UrbxRVNO3yO1X+ZTXTePu7dFrV1ckf+6CVL1NygAjotlrwKes0rNxQo0V7mWtga
         yoeg==
X-Gm-Message-State: AOAM5331P/iOA97QcrKgjggbiNbsQ86PekEDcuhLAYlyfiVzUmf2TzFZ
        RE8zNEahuMBCkksvelNF/PtGNnCH4abuog==
X-Google-Smtp-Source: ABdhPJwLBHGWhPhq6wKa5hZsPSlFlWsppCkuyx7lq9o81Hh/lhcCCZHRAjMilNiW0tJbuadO8P5awQ==
X-Received: by 2002:ac8:5a46:: with SMTP id o6mr709448qta.289.1616431634364;
        Mon, 22 Mar 2021 09:47:14 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f9sm10964106qkk.115.2021.03.22.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:47:14 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol/cil: Create function cil_add_decl_to_symtab() and refactor
Date:   Mon, 22 Mar 2021 12:47:02 -0400
Message-Id: <20210322164703.29564-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322164703.29564-1-jwcart2@gmail.com>
References: <20210322164703.29564-1-jwcart2@gmail.com>
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
index 764719d0..a18e072b 100644
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
 
 	rc = __cil_verify_name((const char*)key);
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
2.26.2

