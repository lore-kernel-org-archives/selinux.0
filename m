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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D6BC4338F
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 20:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9641B60232
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 20:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhHPUK4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhHPUK4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 16:10:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F9C061764
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 13:10:24 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j9so560384qvt.4
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+kzG2DK/HmOBf9mhg2ouBqg3PKiGND6k0b4EQgDkaY=;
        b=HrexspJ4sgQC26VSb8loDusbOmy/KtpcgD5t7n6oCv1VpQSdR0HSyUkpA6noTSQQd2
         mi1cqGX/PNnf9TblExPsr1YPp6PyThZfCGHwnwTcQj2M4X2yahx0DHaOFR9nzulH0deZ
         sbU5B7yeiQ+OUEOAk3TxcseqsHc3vFAF9i5Nq9VbG89gdzXVSoK5ghFB6DVJeeEs6gXl
         aRo4UnwlLiD5n1qU+HAJPJqa9ptepVc8ITDPU2Pfaa0COBUJTr66JLyBg21vTNrcykVm
         H3+nQCPPFGtj47+0sJkG5XUNfe8AvFyhmVj2mvJtlLYg3YmPHPA89z3hg/PUsdiznspI
         P43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+kzG2DK/HmOBf9mhg2ouBqg3PKiGND6k0b4EQgDkaY=;
        b=ImqLyOuFGR5t6WMjfVr8FoRVc9iSDaDMrEw/jGOiTzQQ307W6UfvvHaigQX/de5CeD
         MjaZSQcZ0lRBBdWUpUvIIdnWPajDUKn/zciEKqmQ58bc6qTCWI9aFzKN7+9z+ZxrLtQK
         19Xk0JWLX/KXIJ18ou7TXEaQErUuXPDyFeDxtKp+qmSXYS8YKVTgZOUAr1oeghSu/rKw
         hyUjQKNZj80NQ+Vzzeru//NKJH+1rlA4o3GtRKVZJc0h4vek61hEfhinrWoqQz2ly+3Z
         JS98rH2q/7Wwti8DOf3DtKW+Y4XJ7ssTmj9ysF5mR2EKgdG8myF4+Fh0BMu5kU4C8bul
         SAPw==
X-Gm-Message-State: AOAM53008bVmP//r7Vq4/g13vXgIh6Ef/8NghFM1uytYAtbZJs93kBZU
        kRYn4f1OFW8Xzme0x8dnBMAZ3zMYbDx7MA==
X-Google-Smtp-Source: ABdhPJy8U6YAyGAi6bpqga4Axiz2joOdXXesbtnpL7fmvdpuauHHQ4K43DmnThZzwPQ4W/M23JVgTw==
X-Received: by 2002:a0c:be85:: with SMTP id n5mr482422qvi.59.1629144623293;
        Mon, 16 Aug 2021 13:10:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id a14sm151296qtb.57.2021.08.16.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:10:23 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol/cil: Allow some duplicate macro and block declarations
Date:   Mon, 16 Aug 2021 16:10:19 -0400
Message-Id: <20210816201019.925773-1-jwcart2@gmail.com>
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
v2:
 Removed extra format argument "key"

 libsepol/cil/src/cil_copy_ast.c | 69 ++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 9c0231f2..ef793448 100644
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
+		cil_tree_log(NODE(datum), CIL_WARN, "  Previously declared");
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

