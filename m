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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A106C49EA2
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6CA61040
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFUTU7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhFUTU7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 15:20:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5658C061756
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:43 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id e3so14375573qte.0
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7HAfMW+B1XJvbDs0vNOvjIbN8XUyOGzoA5qXa9JGTg=;
        b=puFkAzHJLN4bnXWcD0BAQgp+ZzSltc3GiQJ+7vdB6dk8hh6z27ALMV7FXYlV55IUJM
         CfKN2RaeowIT1WXHTocp/6ldvkrzZl4fntPS5gyfcC5ugAfrSI3Bg0sKdpF1KjVBxmus
         c+r1qbqbGv3dpK4UxHKj8XEXPxGFy99OXwtLDZgYATJv4tmp+TKthgJgqcgEDXzKxoLX
         btr1o6CtYBcs2mX4YgdHgy1bBC97UO68k1yLTv1eiN9D7eKZjh38P4dF1kQOXjfpgzD9
         kGv9gDh2qheyHQh7+hfQ9CTXlZOcQpzNwdl08gG06TKZvJt24VHOcoFyCKJ9N4nb3/IA
         6R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7HAfMW+B1XJvbDs0vNOvjIbN8XUyOGzoA5qXa9JGTg=;
        b=QL8+4YliRfOXz2/hGI3ZQqA1CMJYWn1HxPFx7S6yupJx2Q9D/+yAZDoyKKVMRFSTYc
         0D0k/359OO7qPt5OF76Mvb41vcf2LG1kmmN7+skDz+02AOwi6wHi7rDH2KWII+uU25Tn
         qW5F0ZnutNoUn5VTmK2+rH+lITyT1B3U9C0pOcO8spozt446FTD+5aM6zFC0qNbZkUlT
         hSuhcQvEQFPne+i+7hrDiVXG91zV15UmhvwJsrZB713jk+qOrPUQTV573t1VN2tlnrFv
         v12LD+jImnDyTsDt/mhc5r0NWT07CAa3EDUUx2lslRiB8oA5UbUz33LIdDDAmO7QoZtH
         LaKA==
X-Gm-Message-State: AOAM531M2oKyrGX0Jxe7SiBX5r7Ej/qWDpPKVpU6LCIzHAjX4fYtqd/n
        wTGxEXt/4TFw7Tddyz6Pk8rxRA3bAsjyag==
X-Google-Smtp-Source: ABdhPJylXc49msBUCk1+wugvDWV2P5KYUPSCA+fC3L0wYUfj+Wz5ZJjB1qs446zvTo3tXDRkgZwQPg==
X-Received: by 2002:ac8:5755:: with SMTP id 21mr71597qtx.267.1624303122803;
        Mon, 21 Jun 2021 12:18:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o5sm10449124qkl.25.2021.06.21.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:18:42 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/5 v2] libsepol/cil: Properly check for loops in sets
Date:   Mon, 21 Jun 2021 15:18:29 -0400
Message-Id: <20210621191833.282874-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210621191833.282874-1-jwcart2@gmail.com>
References: <20210621191833.282874-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 61fbdce666f24c4a118b249ece6b014d54b65074 (ibsepol/cil: Check
for self-referential loops in sets) added checks for self-referential
loops in user, role, type, and category sets. Unfortunately, this
check ends up in an infinite loop if the set with the self-referential
loop is used in a different set that is checked before the bad set.

The problem with the old check is that only the initial datum is used
for the check. Instead, use a stack to track all of the set datums
that are currently involved as the check is made. A self-referential
loop occurs if a duplicate datum is found for any of the datums in the
stack.

Signed-off-by: James Carter <jwcart2@gmail.com>
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_verify.c | 48 +++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 8e15a0e6..59397f70 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -44,6 +44,7 @@
 #include "cil_tree.h"
 #include "cil_list.h"
 #include "cil_find.h"
+#include "cil_stack.h"
 
 #include "cil_verify.h"
 
@@ -430,9 +431,9 @@ int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, str
 	return SEPOL_OK;
 }
 
-static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig);
+static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_stack *stack);
 
-static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_symtab_datum *orig)
+static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_stack *stack)
 {
 	struct cil_list_item *item;
 	int rc = SEPOL_OK;
@@ -444,9 +445,9 @@ static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_
 	cil_list_for_each(item, expr) {
 		if (item->flavor == CIL_DATUM) {
 			struct cil_symtab_datum* datum = item->data;
-			rc = cil_verify_no_self_reference(FLAVOR(datum), datum, orig);
+			rc = cil_verify_no_self_reference(FLAVOR(datum), datum, stack);
 		} else if (item->flavor == CIL_LIST) {
-			rc = __verify_no_self_reference_in_expr(item->data, orig);
+			rc = __verify_no_self_reference_in_expr(item->data, stack);
 		}
 		if (rc != SEPOL_OK) {
 			return SEPOL_ERR;
@@ -456,36 +457,47 @@ static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_
 	return SEPOL_OK;
 }
 
-static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig)
+static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_stack *stack)
 {
+	struct cil_stack_item *item;
+	int i = 0;
 	int rc = SEPOL_OK;
 
-	if (datum == orig) {
-		cil_tree_log(NODE(orig), CIL_ERR, "Self-reference found for %s", orig->name);
-		return SEPOL_ERR;
-	} else if (orig == NULL) {
-		orig = datum;
+	cil_stack_for_each(stack, i, item) {
+		struct cil_symtab_datum *prev = item->data;
+		if (datum == prev) {
+			cil_tree_log(NODE(datum), CIL_ERR, "Self-reference found for %s", datum->name);
+			return SEPOL_ERR;
+		}
 	}
 
 	switch (flavor) {
 	case CIL_USERATTRIBUTE: {
 		struct cil_userattribute *attr = (struct cil_userattribute *)datum;
-		rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
+		cil_stack_push(stack, CIL_DATUM, datum);
+		rc = __verify_no_self_reference_in_expr(attr->expr_list, stack);
+		cil_stack_pop(stack);
 		break;
 	}
 	case CIL_ROLEATTRIBUTE: {
 		struct cil_roleattribute *attr = (struct cil_roleattribute *)datum;
-		rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
+		cil_stack_push(stack, CIL_DATUM, datum);
+		rc = __verify_no_self_reference_in_expr(attr->expr_list, stack);
+		cil_stack_pop(stack);
 		break;
 	}
 	case CIL_TYPEATTRIBUTE: {
 		struct cil_typeattribute *attr = (struct cil_typeattribute *)datum;
-		rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
+		cil_stack_push(stack, CIL_DATUM, datum);
+		rc = __verify_no_self_reference_in_expr(attr->expr_list, stack);
+		cil_stack_pop(stack);
 		break;
 	}
 	case CIL_CATSET: {
 		struct cil_catset *set = (struct cil_catset *)datum;
-		rc = __verify_no_self_reference_in_expr(set->cats->datum_expr, orig);
+		cil_stack_push(stack, CIL_DATUM, datum);
+		rc = __verify_no_self_reference_in_expr(set->cats->datum_expr, stack);
+		cil_stack_pop(stack);
 		break;
 	}
 	default:
@@ -1826,9 +1838,13 @@ int __cil_pre_verify_helper(struct cil_tree_node *node, uint32_t *finished, __at
 	case CIL_USERATTRIBUTE:
 	case CIL_ROLEATTRIBUTE:
 	case CIL_TYPEATTRIBUTE:
-	case CIL_CATSET:
-		rc = cil_verify_no_self_reference(node->flavor, node->data, NULL);
+	case CIL_CATSET: {
+		struct cil_stack *stack;
+		cil_stack_init(&stack);
+		rc = cil_verify_no_self_reference(node->flavor, node->data, stack);
+		cil_stack_destroy(&stack);
 		break;
+	}
 	default:
 		rc = SEPOL_OK;
 		break;
-- 
2.26.3

