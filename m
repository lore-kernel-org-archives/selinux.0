Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA703C07E99
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 14:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBA9613BA
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 14:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGIOOk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhGIOOk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Jul 2021 10:14:40 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9CC0613DD
        for <selinux@vger.kernel.org>; Fri,  9 Jul 2021 07:11:56 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id d2so4583119qvh.2
        for <selinux@vger.kernel.org>; Fri, 09 Jul 2021 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LikPSbGRw3g7BjCZbAu9pRp41JKko5G1hWqfvz1Tt10=;
        b=fD3v1V10Ds2s8MCURpn5OOdzdmo/W3T6DuFex/KLSfDb//SNBx9rgHjaYzG8AovyVG
         ZcNTcboDNmv4kPPrWaeV49whoJdKzL5Yo6E7yhQp46qcNqDNHdL0P4Yu7ENnldt4FfUR
         RsWSSo95qA7lMpcb8ZrRN46w+ydDLgSh7Kq2fz3SMqDdGjoRc5BENal5n8z+MRhJCFEc
         0Zp3DikcNFUGeLn+h0HPSmKXeqKwoBNhfGBR/bpcp4uEPTBaVm1gU6A9K///KFjp/qF/
         AozWOrXKvdmy0YSHIlHtKYCH/572QV5PHMpzzVoyCCMYBK1N/tuZGVrkxiSfNSgQZWXQ
         YSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LikPSbGRw3g7BjCZbAu9pRp41JKko5G1hWqfvz1Tt10=;
        b=GzY5wDFLBYI0Li5Nd0Ec2N725F4gpu9hdMVLr+7qCPASgmIxv1f/cS90wtkVCuqbFb
         ZnlW/fdEuNpGtHr5+qTUEL4atf9ubuZFjO5xp13vBYE87g1SayUYuaBK0f8vBK3jaVhn
         EaYxc55G2VIYZ+urKdI03ydr7Tefr2bXzXFxW9Me47nzlvk5WRg6HO0i+r+/RDhF+PqQ
         YFthkUA5tonESKFxZwg3/TqQc7dL2EZgjLMY1DZo4mOWwKGcNXDCaXBbSbsGZpvDYTf0
         +LFV61yI1duPVQaunSr1tWMXK4hjuVKv03VAGadzdMfttfErxCK7WgtbTxE8XTeIWY91
         LsMQ==
X-Gm-Message-State: AOAM531GrjMJvJiI1au9QffHRo5ESQXCu+S1ocRnWIe7y/G/L7s0zJWf
        cKPOqSwMS4mKVo4A18ZP9Cs6ZUDIYIWfSQ==
X-Google-Smtp-Source: ABdhPJzNnkTfW5764ahd7MQR5O9blCk6NIw6HcFi/43JhqRje/dXeiYrr2/Z94ixr3Apl01oOskYEg==
X-Received: by 2002:a0c:f850:: with SMTP id g16mr35860128qvo.5.1625839915665;
        Fri, 09 Jul 2021 07:11:55 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id w14sm2277644qtc.55.2021.07.09.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:11:55 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Fix handling category sets in an expression
Date:   Fri,  9 Jul 2021 10:11:49 -0400
Message-Id: <20210709141149.59229-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There are two problems that need to be addressed when resolving an
expression with category sets.

1. Only expand anonymous category sets in an expression.

Commit 982ec302b67f3c7f8df667dadb67352b1e4a6d18 (libsepol/cil:
Account for anonymous category sets in an expression) attempted to
properly handle anonymous category sets when resolving category
expressions. Unfortunately, it did not check whether a category set
was actually an anonymous category set and expanded all category
sets in an expression. If a category set refers to itself in the
expression, then everything from the name of the category set to the
end of the expression is ignored.

For example, the rule "(categoryset cs (c0 cs c1 c2))", would be
equivalent to the rule "(categoryset cs (c0))" as everything from
"cs" to the end would be dropped. The secilc-fuzzer found that the
rule "(categoryset cat (not cat))" would cause a segfault since
"(not)" is not a valid expression and it is assumed to be valid
during later evaluation because syntax checking has already been
done.

Instead, check whether or not the category set is anonymous before
expanding it when resolving an expression.

2. Category sets cannot be used in a category range

A category range can be used to specify a large number of categories.
The range "(range c0 c1023)" refers to 1024 categories. Only categories
and category aliases can be used in a range. Determining if an
identifier is a category, an alias, or a set can only be done after
resolving the identifer.

Keep track of the current operator as an expression is being resolved
and if the expression involves categories and a category set is
encountered, then return an error if the expression is a category
range.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 145d4e74..3d3ef955 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3228,6 +3228,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 	struct cil_symtab_datum *res_datum = NULL;
 	enum cil_sym_index sym_index =  CIL_SYM_UNKNOWN;
 	struct cil_list *datum_sub_expr;
+	enum cil_flavor op = CIL_NONE;
 
 	switch (str_expr->flavor) {
 	case CIL_BOOL:
@@ -3263,14 +3264,24 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 			}
 			if (sym_index == CIL_SYM_CATS && NODE(res_datum)->flavor == CIL_CATSET) {
 				struct cil_catset *catset = (struct cil_catset *)res_datum;
-				if (!catset->cats->datum_expr) {
-					rc = cil_resolve_expr(expr_type, catset->cats->str_expr, &catset->cats->datum_expr, parent, extra_args);
-					if (rc != SEPOL_OK) {
-						goto exit;
+				if (op == CIL_RANGE) {
+					cil_tree_log(parent, CIL_ERR, "Category set not allowed in category range");
+					rc = SEPOL_ERR;
+					goto exit;
+				}
+				if (!res_datum->name) {
+					/* Anonymous category sets need to be resolved when encountered */
+					if (!catset->cats->datum_expr) {
+						rc = cil_resolve_expr(expr_type, catset->cats->str_expr, &catset->cats->datum_expr, parent, extra_args);
+						if (rc != SEPOL_OK) {
+							goto exit;
+						}
 					}
+					cil_copy_list(catset->cats->datum_expr, &datum_sub_expr);
+					cil_list_append(*datum_expr, CIL_LIST, datum_sub_expr);
+				} else {
+					cil_list_append(*datum_expr, CIL_DATUM, res_datum);
 				}
-				cil_copy_list(catset->cats->datum_expr, &datum_sub_expr);
-				cil_list_append(*datum_expr, CIL_LIST, datum_sub_expr);
 			} else {
 				if (sym_index == CIL_SYM_TYPES && (expr_type == CIL_CONSTRAIN || expr_type == CIL_VALIDATETRANS)) {
 					cil_type_used(res_datum, CIL_ATTR_CONSTRAINT);
@@ -3287,9 +3298,12 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 			break;
 		}
 		default:
+			if (curr->flavor == CIL_OP) {
+				op = (enum cil_flavor)curr->data;
+			}
 			cil_list_append(*datum_expr, curr->flavor, curr->data);
 			break;
-		}				
+		}
 	}
 	return SEPOL_OK;
 
-- 
2.31.1

