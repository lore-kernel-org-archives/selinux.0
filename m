Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A09DC43460
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F4661264
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhEMSzJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEMSzJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 14:55:09 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4047FC061574
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:53:59 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id u33so2375656qvf.9
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FC0ak52LAgRDIFnxZv/PhJhPRmOUWUZ6YhUX2JMSFXY=;
        b=UIc3Vf9tgWVESpknGcpO0x+zQDQ9dh1wismHXBwanP3khuG49+8ESoxBBVBat4UoLz
         MAymT4Bnkg8pDAS8EetPNbvjLxZRktaA2jAdTPZ1zgwIUMCHOO6g8Wncvh5DT4NA15o5
         lAnhM183MWKQl7VB3cIUl9BAf0DcxZT1YxbPy9xgEjB0avKSo1xY4YgRyozfK5Q1oUcr
         psDV8NF+kqJn+MrcsCZE2zhLB/qApqHQW8Psr9sRww6lYpApbJKk73bjYun54QKSeVWV
         kRRsfbz2vK5HoiVVDe+icBOOdaZT52Qg/rZxTlSj6lNuGpBVstVN35V6I1giglGx1d45
         HkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FC0ak52LAgRDIFnxZv/PhJhPRmOUWUZ6YhUX2JMSFXY=;
        b=M14d7AiyUjV5oCjLE9xLG7G0RpcMfAs1WRW9pwXlulCjG8DvycTtuXpTNQ/jktl+GC
         Ae+ogIegoYlhHDW6mzP0zGhSnkPI1uC1s5Bupm7et6oi4eYrx/N1y5Nw3f1jATMBZBy+
         eKEAHPKPcy54UJsjommO1iV9eYu+lsB4ZMvapWHWxEcBO77NkbLgXt2An8C7mL7ea3Mp
         dG2c85+5WN2Uo8TQLAefmwejkP2sNOHUeDqTdjKvQZyVJ4MUUeS9ztwnokihKgD3FuoJ
         2+LbSz8om/jKodqxBq5JKoHGKlrliZ8OFCDl7FBtu55ujQhv6KxE4aNb3P/2BfOCqWjm
         BiCQ==
X-Gm-Message-State: AOAM531+sR6GaadXN3yGBN3KqEIaYZpuJreMkAEPOyuthoK9oikn9vtF
        D6xWTyjRqsne9ULWMEsnqWx2nBC/+hfxpg==
X-Google-Smtp-Source: ABdhPJwv+KzjPTi1iNtkJfMWLcFz0aL94UjCuw0atgnBRjAcpWyPSRX0xkuOsG+ccKZtSJ8DV5STaA==
X-Received: by 2002:a05:6214:2b0:: with SMTP id m16mr42869575qvv.4.1620932038433;
        Thu, 13 May 2021 11:53:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h188sm1713767qkf.133.2021.05.13.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:53:53 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/6] libsepol/cil: Handle disabled optional blocks in earlier passes
Date:   Thu, 13 May 2021 14:52:49 -0400
Message-Id: <20210513185254.559588-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513185254.559588-1-jwcart2@gmail.com>
References: <20210513185254.559588-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A failed tunable resolution in a tunableif can cause an optional
to be disabled before the CIL_PASS_CALL1 phase. If this occurs, the
optional block and its subtree should be destroyed, but no reset
will be required since tunables are not allowed inside an optional
block.

Anytime there are optional blocks in the disabled_optionals list
(changed == 1), destroy the optional block and its subtree even if
in a pass before CIL_PASS_CALL1.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 54 ++++++++++++++++--------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 5368ae80..242aea4a 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4099,35 +4099,37 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 			}
 		}
 
-		if (changed && (pass > CIL_PASS_CALL1)) {
+		if (changed) {
 			struct cil_list_item *item;
-			/* Need to re-resolve because an optional was disabled that contained
-			 * one or more declarations. We only need to reset to the call1 pass 
-			 * because things done in the preceding passes aren't allowed in 
-			 * optionals, and thus can't be disabled.
-			 * Note: set pass to CIL_PASS_CALL1 because the pass++ will increment 
-			 * it to CIL_PASS_CALL2
-			 */
-			cil_log(CIL_INFO, "Resetting declarations\n");
-
-			if (pass >= CIL_PASS_MISC1) {
-				__cil_ordered_lists_reset(&extra_args.sidorder_lists);
-				__cil_ordered_lists_reset(&extra_args.classorder_lists);
-				__cil_ordered_lists_reset(&extra_args.unordered_classorder_lists);
-				__cil_ordered_lists_reset(&extra_args.catorder_lists);
-				__cil_ordered_lists_reset(&extra_args.sensitivityorder_lists);
-				cil_list_destroy(&db->sidorder, CIL_FALSE);
-				cil_list_destroy(&db->classorder, CIL_FALSE);
-				cil_list_destroy(&db->catorder, CIL_FALSE);
-				cil_list_destroy(&db->sensitivityorder, CIL_FALSE);
-			}
+			if (pass > CIL_PASS_CALL1) {
+				/* Need to re-resolve because an optional was disabled that contained
+				 * one or more declarations. We only need to reset to the call1 pass
+				 * because things done in the preceding passes aren't allowed in
+				 * optionals, and thus can't be disabled.
+				 * Note: set pass to CIL_PASS_CALL1 because the pass++ will increment
+				 * it to CIL_PASS_CALL2
+				 */
+				cil_log(CIL_INFO, "Resetting declarations\n");
+
+				if (pass >= CIL_PASS_MISC1) {
+					__cil_ordered_lists_reset(&extra_args.sidorder_lists);
+					__cil_ordered_lists_reset(&extra_args.classorder_lists);
+					__cil_ordered_lists_reset(&extra_args.unordered_classorder_lists);
+					__cil_ordered_lists_reset(&extra_args.catorder_lists);
+					__cil_ordered_lists_reset(&extra_args.sensitivityorder_lists);
+					cil_list_destroy(&db->sidorder, CIL_FALSE);
+					cil_list_destroy(&db->classorder, CIL_FALSE);
+					cil_list_destroy(&db->catorder, CIL_FALSE);
+					cil_list_destroy(&db->sensitivityorder, CIL_FALSE);
+				}
 
-			pass = CIL_PASS_CALL1;
+				pass = CIL_PASS_CALL1;
 
-			rc = cil_reset_ast(current);
-			if (rc != SEPOL_OK) {
-				cil_log(CIL_ERR, "Failed to reset declarations\n");
-				goto exit;
+				rc = cil_reset_ast(current);
+				if (rc != SEPOL_OK) {
+					cil_log(CIL_ERR, "Failed to reset declarations\n");
+					goto exit;
+				}
 			}
 			cil_list_for_each(item, extra_args.disabled_optionals) {
 				cil_tree_children_destroy(item->data);
-- 
2.26.3

