Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1375C433ED
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706A9610F9
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhDHTQw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhDHTQv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:51 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A364C061761
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id o11so1467466qvh.11
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evPRVxbFwAWkC5R48FuxkwmxPxWXmzzBFPOqwYJ8ZkA=;
        b=aBZ6oySNaf2Mtfd0x8IRXj6tYGNWJmLE3nKUK65nQqxloYPbsjYRBogG5gwzKBk5ei
         kP7QNnpgtU/jJpoqfVGwl+11cwYnjHsZp0HjyoMvtkL6I7+v+pbe/P5oev2A3X3+lGyQ
         6DtbHym7ge0boE8uWqZV2SkMv4uoXXC2iLbe4mIADSLpU0RpgHSwXyoPHYqcRoDd0zU+
         KLL8EnIrnwRnGJrBlC3gBJN10vkJeicA07U0MPNEpSEkqfBdKPaNePw+MEByrjefzlId
         97BMw/MXVsfjAzLPHaXMQeqWpcG+8OEwHfbdVQ00TBtjsiq02inj2LFuGiljjzRqg4Uw
         LgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evPRVxbFwAWkC5R48FuxkwmxPxWXmzzBFPOqwYJ8ZkA=;
        b=cgoV1Ry5dDRpW/wLgtXEoiSQK9T0t4bwqXTFG1IcMnIltvx06oPzi3D34gsF3Bgej1
         lWe3VvffOE75lF3CrZ4spLLKpOLLY7vuhzrAoLEnbbkPCKwRzRLjudfCNctCcBuR/bub
         viy0pr+Pr8tt1I7ZfeHaZ7OwmEqsvcd/iNtXlGawS2cFFxw15nEo8XDF4jkZ33LIhgpr
         egF8DlDcE+lfPHEol9Zw+lSnXEW/jB9uCwIR/CSltvHy93U1szG5o5xXAuNRjGOSihy0
         FVLLgIzC0cVheliDdPKq12MOFqODztZJwYtXhaZuwI4gnR23Xj9nbdyqZDUWjNjnaaoT
         Vu2Q==
X-Gm-Message-State: AOAM5319+XtOc8BWmcDUm4zNxoO1pEgHHomcbkTypPhsP9nAxV5v0q+5
        ZmQtA8aZCbn6BHvbr/vleI9AMNzXRsc8oQ==
X-Google-Smtp-Source: ABdhPJz74qkqHeUTV/HfMNLLo/BGoTltUcUElQxOsyZwkwS1H0MZvnn1I7podTH4mkH6bTXhcXb6gA==
X-Received: by 2002:a0c:f74d:: with SMTP id e13mr10980010qvo.8.1617909397501;
        Thu, 08 Apr 2021 12:16:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:37 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 10/11] libsepol/cil: Create function cil_add_decl_to_symtab() and refactor
Date:   Thu,  8 Apr 2021 15:16:13 -0400
Message-Id: <20210408191614.262173-11-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
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

