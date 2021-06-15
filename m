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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1FFC48BE5
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE1060FE6
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhFOS7H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFOS7G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jun 2021 14:59:06 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6EC061574
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:57:01 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u13so221197qvt.7
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jk6zZPJsPzKDbpSQGeRCQlKG9x7FyUYChO9zaHevgmE=;
        b=JcZ+e0U75rpnLXvPl9Pk7D6bK5mh38Sr6WdaZhWDXRBY3M1ZerQV6R80rsahUm79qz
         sFIs7WbPsxLs2qyoV5APMv/SAvXFfjWy43S1/sEVAbjC5P+GUaGfe19/XuC1jAowsPts
         SA5K6Cs7JCgrPwSKFDFW9C1E4PXmZrS5ftlHvV8EihQWKlCNooYaYFMFL0Ew8o6KyIIw
         /IOmEnNAQoJ7NRAYXcVKBhhQD/JBFP9XbtefU6dRnN/Gb2P2H0j1aKFsSlBpWw5D2Dzh
         4LZGw9yWJ75ZbU7YH1dOPNX7Slop+GkyjOj3adRBYKDvOvucLsTTdTfobdpdQ1xN8ZtQ
         puMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jk6zZPJsPzKDbpSQGeRCQlKG9x7FyUYChO9zaHevgmE=;
        b=FH131JLWLxXzeRSrhujXvFkJWB4mLcJeC3+WovNWY/Tkattpa2C12lAppcLxQ0glhr
         /3uvVfvy9wYVDMik6w6ukQY1jC01ofSUV1KlmXMybNuj5WRUl9PaBp9rDrrbV1JawzkS
         GTHnL/X5RnU6JGTo+GVsUfk2MKpH0ZswQMcXmSByYLMayrpBXbgJmOza6hJQKbqc72Oq
         F4jzbGDn5pmIjtClbLO6mktTWtedae/KaY5EOKbH3BES7AfwRDB7IakyFMkZ7SHdTSGR
         zV60t65Pw0v8nIxJ3/J8TIXZwGcQPvqdgzgDLjibkyZ4ODYdGaOECVv+eQSbn/ElkYWA
         3XTA==
X-Gm-Message-State: AOAM530xNzC4dy4IHaO6WAT193ygBM2mkUUiyoT8tMB5KBDII5m453W+
        CWDnj6JVn5xv+osS8S0pGNgih2F5ysgy7w==
X-Google-Smtp-Source: ABdhPJwtpzC486ODE6cg477BT8o41mOqtjcWbiY8jRqx1HnCZJAggtg7iQKkG0Du1tpnAVLi2yynSA==
X-Received: by 2002:a05:6214:180a:: with SMTP id o10mr6527308qvw.31.1623783420848;
        Tue, 15 Jun 2021 11:57:00 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e1sm12746838qti.27.2021.06.15.11.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:57:00 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol/cil: Account for anonymous category sets in an expression
Date:   Tue, 15 Jun 2021 14:56:54 -0400
Message-Id: <20210615185655.34064-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210615185655.34064-1-jwcart2@gmail.com>
References: <20210615185655.34064-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It is possible for anonymous category sets to be in a category
expression if the expression has a macro parameter in it.
Unfortunately, anonymous category sets are not looked for when
resolving category expressions and a segfault will occur during
later processing if there was one.

As an example, consider the following portion of a policy.
  (macro m1 ((categoryset cs))
    (userlevel USER (s0 (cs)))
  )
  (call m1 ((c0 c1)))
This policy will cause a segault, because the categoryset datum
for the parameter cs is not seen as a categoryset and is treated
as a plain category.

When resolving an expression, check whether or not the datum that
is found is actually an anonymous category set associated with a
macro parameter. If it is, then resolve the category set if it
has not already been resolved and treat its categories as a sub
expression.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 16c8c753..42a58468 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3346,6 +3346,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 	struct cil_list_item *curr;
 	struct cil_symtab_datum *res_datum = NULL;
 	enum cil_sym_index sym_index =  CIL_SYM_UNKNOWN;
+	struct cil_list *datum_sub_expr;
 
 	switch (str_expr->flavor) {
 	case CIL_BOOL:
@@ -3379,18 +3380,26 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
-
-			if (sym_index == CIL_SYM_TYPES && (expr_type == CIL_CONSTRAIN || expr_type == CIL_VALIDATETRANS)) {
-				cil_type_used(res_datum, CIL_ATTR_CONSTRAINT);
+			if (sym_index == CIL_SYM_CATS && NODE(res_datum)->flavor == CIL_CATSET) {
+				struct cil_catset *catset = (struct cil_catset *)res_datum;
+				if (!catset->cats->datum_expr) {
+					rc = cil_resolve_expr(expr_type, catset->cats->str_expr, &catset->cats->datum_expr, parent, extra_args);
+					if (rc != SEPOL_OK) {
+						goto exit;
+					}
+				}
+				cil_copy_list(catset->cats->datum_expr, &datum_sub_expr);
+				cil_list_append(*datum_expr, CIL_LIST, datum_sub_expr);
+			} else {
+				if (sym_index == CIL_SYM_TYPES && (expr_type == CIL_CONSTRAIN || expr_type == CIL_VALIDATETRANS)) {
+					cil_type_used(res_datum, CIL_ATTR_CONSTRAINT);
+				}
+				cil_list_append(*datum_expr, CIL_DATUM, res_datum);
 			}
-
-			cil_list_append(*datum_expr, CIL_DATUM, res_datum);
 			break;
 		case CIL_LIST: {
-			struct cil_list *datum_sub_expr;
 			rc = cil_resolve_expr(expr_type, curr->data, &datum_sub_expr, parent, extra_args);
 			if (rc != SEPOL_OK) {
-				cil_list_destroy(&datum_sub_expr, CIL_TRUE);
 				goto exit;
 			}
 			cil_list_append(*datum_expr, CIL_LIST, datum_sub_expr);
@@ -3404,6 +3413,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 	return SEPOL_OK;
 
 exit:
+	cil_list_destroy(datum_expr, CIL_FALSE);
 	return rc;
 }
 
-- 
2.26.3

