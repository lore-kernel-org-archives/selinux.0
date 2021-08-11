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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA1FC4338F
	for <selinux@archiver.kernel.org>; Wed, 11 Aug 2021 21:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4B46101D
	for <selinux@archiver.kernel.org>; Wed, 11 Aug 2021 21:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhHKVFN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKVFL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Aug 2021 17:05:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEF0C061765
        for <selinux@vger.kernel.org>; Wed, 11 Aug 2021 14:04:47 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c130so3966798qkg.7
        for <selinux@vger.kernel.org>; Wed, 11 Aug 2021 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4MZlDoJcVrEjWnzoJywbM3q5gvmqVsnwjLuiBe/daU=;
        b=kBt0klEafGAZTDl8+JqlHtBdJ3Fmgu7Lt4sBqw3+9oRgZ1EA9wbq3MGSe2yQjJia6/
         SFwLeoNySqhGrupDbzi0H3HQGqb/qkAZ9Zi9c5AUs5O7tZCyuDDLhabvnBqNM3i9DCnR
         3mK15ZHyeRyvZ9sLaZBlamsz7ao2JfI7Iy6eR2UADjbQj4zfVFUxg8kmaVPil/mDv4GB
         fipwHTWYnfRANT5ipVNpmc44kDySOvhWObSA2Ca49E9XpfnqnXUK8B7QJGUPhq1w1Xjy
         4/yo38Om2m4R/1UJYVnz+AExsxNpdBMBng5rplIWGGBH9QsKA/KaAXsQSP5Ch2QRosg0
         U4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4MZlDoJcVrEjWnzoJywbM3q5gvmqVsnwjLuiBe/daU=;
        b=gCYjcYCLL1hDwcYIoz9VIBHPcvCwqdTVuX+NEms8ijkDu6Tfx7OpJfihfoN70/fwiq
         5MMEEBcHCdtCwZojxkvM1k09HR9F/j1fTH7ACDKBEFtBwLY+/xhA9O2ONiXRoMNRnoDb
         /dl6NK9VEUdRiAIWZ40qgnC2fOCZ2/PhSPvNY9EdlWAWVM3EXM2XXnWeX/BjHNzNGIxf
         Sr/0CFfXrnRDwdZf7S51dCDYPEtvGN8FMOm/rWXlta1s5PUrpsVzKXD2BhA0CYQDsXU6
         UluxwWthdbdb3nAOTbcjZnolqP3GnWWgqw2pYIkQyBPY5MMazMBtQ+UxgUJWr9CA8kCK
         Y7dw==
X-Gm-Message-State: AOAM531MGptGppXlz8tmz7Pw3NA6izPeAD7UYvaxRXNncsEA7bWTEt+7
        XmKtdww3FomETWxfLTyr1UM2Ph7DHgSS9w==
X-Google-Smtp-Source: ABdhPJwTYXmkCjsd707Ugfqq/58oUjXN5JhK0Y3QUtmTf8bQZ5s5nuOqCbKBpD6c4gRf0nZckQ/VqQ==
X-Received: by 2002:a37:a2c5:: with SMTP id l188mr1041764qke.90.1628715886005;
        Wed, 11 Aug 2021 14:04:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f17sm173291qtk.82.2021.08.11.14.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:04:45 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dominick.grift@defensec.nl, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Allow some duplicate macro and block declarations
Date:   Wed, 11 Aug 2021 17:04:40 -0400
Message-Id: <20210811210440.744101-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The commit d155b410d4bbc90d28f361b966f0429598da8188 (libsepol/cil:
Check for duplicate blocks, optionals, and macros) added checks when
copying blocks, macros, and optionals so that a duplicate would cause
an exit with an error. Unfortunately, some policies exist that depend
on this behavior when using inheritance.

The behavior is as follows.

For macros only the first declared macro matters.
;
(macro m ((type ARG1))
  (allow ARG1 self (CLASS (PERM1)))
)
(block b
  (macro m ((type ARG1))
    (allow ARG1 self (CLASS (PERM2)))
  )
)
(blockinherit b)
(type t)
(call m (t))
;
For this policy segment, the macro m in block b will not be called.
Only the original macro m will be.

This behavior has been used to override macros that are going to
be inherited. Only the inherited macros that have not already been
declared in the destination namespace will be used.

Blocks seem to work fine even though there are two of them
;
(block b1
  (blockinherit b2)
  (block b
    (type t1)
    (allow t1 self (CLASS (PERM)))
  )
)
(block b2
  (block b
    (type t2)
    (allow t2 self (CLASS (PERM)))
  )
)
(blockinherit b1)
;
In this example, the blockinherit of b2 will cause there to be
two block b's in block b1. Note that if both block b's tried to
declare the same type, then that would be an error. The blockinherit
of b1 will copy both block b's.

This behavior has been used to allow the use of in-statements for
a block that is being inherited. Since the in-statements are resolved
before block inheritance, this only works if a block with the same
name as the block to be inherited is declared in the namespace.

To support the use of these two behaviors, allow duplicate blocks
and macros when they occur as the result of block inheritance. In
any other circumstances and error for a redeclaration will be given.

Since the duplicate macro is not going to be used it is just skipped.
The duplicate block will use the datum of the original block. In both
cases a warning message will be produced (it will only be seen if
"-v" is used when compiling the policy).

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_copy_ast.c | 69 ++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 9c0231f2..67be2ec8 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -43,6 +43,7 @@
 #include "cil_verify.h"
 
 struct cil_args_copy {
+	struct cil_tree_node *orig_dest;
 	struct cil_tree_node *dest;
 	struct cil_db *db;
 };
@@ -101,17 +102,23 @@ int cil_copy_block(__attribute__((unused)) struct cil_db *db, void *data, void *
 	struct cil_block *orig = data;
 	char *key = orig->datum.name;
 	struct cil_symtab_datum *datum = NULL;
-	struct cil_block *new;
 
 	cil_symtab_get_datum(symtab, key, &datum);
 	if (datum != NULL) {
-		cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
-		return SEPOL_ERR;
+		if (FLAVOR(datum) != CIL_BLOCK) {
+			cil_tree_log(NODE(orig), CIL_ERR, "Block %s being copied", key);
+			cil_tree_log(NODE(datum), CIL_ERR, "  Conflicts with %s already declared", cil_node_to_string(NODE(datum)));
+			return SEPOL_ERR;
+		}
+		cil_tree_log(NODE(orig), CIL_WARN, "Block %s being copied", key);
+		cil_tree_log(NODE(datum), CIL_WARN, "  Previously declared", key);
+		*copy = datum;
+	} else {
+		struct cil_block *new;
+		cil_block_init(&new);
+		*copy = new;
 	}
 
-	cil_block_init(&new);
-	*copy = new;
-
 	return SEPOL_OK;
 }
 
@@ -1511,21 +1518,26 @@ int cil_copy_macro(__attribute__((unused)) struct cil_db *db, void *data, void *
 	struct cil_macro *orig = data;
 	char *key = orig->datum.name;
 	struct cil_symtab_datum *datum = NULL;
-	struct cil_macro *new;
 
 	cil_symtab_get_datum(symtab, key, &datum);
 	if (datum != NULL) {
-		cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
-		return SEPOL_ERR;
-	}
-
-	cil_macro_init(&new);
-	if (orig->params != NULL) {
-		cil_copy_list(orig->params, &new->params);
+		if (FLAVOR(datum) != CIL_MACRO) {
+			cil_tree_log(NODE(orig), CIL_ERR, "Macro %s being copied", key);
+			cil_tree_log(NODE(datum), CIL_ERR, "  Conflicts with %s already declared", cil_node_to_string(NODE(datum)));
+			return SEPOL_ERR;
+		}
+		cil_tree_log(NODE(orig), CIL_WARN, "Skipping macro %s", key);
+		cil_tree_log(NODE(datum), CIL_WARN, "  Previously declared");
+		*copy = NULL;
+	} else {
+		struct cil_macro *new;
+		cil_macro_init(&new);
+		if (orig->params != NULL) {
+			cil_copy_list(orig->params, &new->params);
+		}
+		*copy = new;
 	}
 
-	*copy = new;
-
 	return SEPOL_OK;
 }
 
@@ -1700,7 +1712,7 @@ int cil_copy_src_info(__attribute__((unused)) struct cil_db *db, void *data, voi
 	return SEPOL_OK;
 }
 
-int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) uint32_t *finished, void *extra_args)
+int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished, void *extra_args)
 {
 	int rc = SEPOL_ERR;
 	struct cil_tree_node *parent = NULL;
@@ -2005,6 +2017,16 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 
 	rc = (*copy_func)(db, orig->data, &data, symtab);
 	if (rc == SEPOL_OK) {
+		if (orig->flavor == CIL_MACRO && data == NULL) {
+			/* Skipping macro re-declaration */
+			if (args->orig_dest->flavor != CIL_BLOCKINHERIT) {
+				cil_log(CIL_ERR, "  Re-declaration of macro is only allowed when inheriting a block\n");
+				return SEPOL_ERR;
+			}
+			*finished = CIL_TREE_SKIP_HEAD;
+			return SEPOL_OK;
+		}
+
 		cil_tree_node_init(&new);
 
 		new->parent = parent;
@@ -2013,7 +2035,15 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 		new->flavor = orig->flavor;
 		new->data = data;
 
-		if (orig->flavor >= CIL_MIN_DECLARATIVE) {
+		if (orig->flavor == CIL_BLOCK && DATUM(data)->nodes->head != NULL) {
+			/* Duplicate block */
+			if (args->orig_dest->flavor != CIL_BLOCKINHERIT) {
+				cil_log(CIL_ERR, "  Re-declaration of block is only allowed when inheriting a block\n");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			cil_list_append(DATUM(new->data)->nodes, CIL_NODE, new);
+		} else if (orig->flavor >= CIL_MIN_DECLARATIVE) {
 			/* Check the flavor of data if was found in the destination symtab */
 			if (DATUM(data)->nodes->head && FLAVOR(data) != orig->flavor) {
 				cil_tree_log(orig, CIL_ERR, "Incompatible flavor when trying to copy %s", DATUM(data)->name);
@@ -2098,12 +2128,13 @@ int cil_copy_ast(struct cil_db *db, struct cil_tree_node *orig, struct cil_tree_
 	int rc = SEPOL_ERR;
 	struct cil_args_copy extra_args;
 
+	extra_args.orig_dest = dest;
 	extra_args.dest = dest;
 	extra_args.db = db;
 
 	rc = cil_tree_walk(orig, __cil_copy_node_helper, NULL,  __cil_copy_last_child_helper, &extra_args);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_INFO, "cil_tree_walk failed, rc: %d\n", rc);
+		cil_tree_log(dest, CIL_ERR, "Failed to copy %s to %s", cil_node_to_string(orig), cil_node_to_string(dest));
 		goto exit;
 	}
 
-- 
2.31.1

