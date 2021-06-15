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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648DFC48BE8
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F4E611EE
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFOS7H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOS7G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jun 2021 14:59:06 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A2C06175F
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:57:00 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e3so12128594qte.0
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqmvgu891xaz3sGDDEspH+WcSM+S7Bs/HD5GW1nhALg=;
        b=DmCweS3jIuS1WC8eWcEUrQj91tFrya3jJHTJVnjZ1UM7heADAJoL3hiwjSLNsAZfvc
         dSDTGZ7GosbSj7cU5t+014xYAXrVjAUmaCWzs5OLuJVYAQcilAqC81le5XKKcu8i5K2j
         y8+1eWTeCcc5nRs3X9HdmXgkuzTZWRvsdcdfv7V2l86Mi23JslGUjgANDCdXGITi2Tsy
         bC0Nv1t5mOziuOJwvHwwNxK6dMmt90td/pKsGsvLjpsrBWVD45MC6WFAsCfOdgs0bGlg
         5YDAqxp034kyYBJL8KuS0hDYsxkOvREPaKMeEy3CGcCG0HbRrchgU3ZYR6KegVEtJ5h1
         u67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqmvgu891xaz3sGDDEspH+WcSM+S7Bs/HD5GW1nhALg=;
        b=ISWbCNkgBudgkKVoD5yxTJ4TrBvaL7gTG/f/56GiHuJzQtbf6iKIcpI709wffDBLLS
         PqlM8Pl0F4+hUbSInMZ+qwRxFkzx9pHDfQtlnZ4RkowrxCfXm76O1tbsiGM+MMeeAP/B
         b0VnPRAFXTSL993TYNixXqnjGWrQjAiHsDVKPyoTp2eUa3lB/LHWxsIKzoNiUITs4djk
         iW+yQaBoN0YBRSkEi3lxoFgbp9myLA9bEeG9mPbvUVyn49fD9bjcZhrlQfxi9pugoEoc
         FWXra8OO2gWVSkVDekt1oYQlUY1m8c27wSQAbYI1l3xQLAU/2KbSVktPHsWQsErnWOKR
         cV8Q==
X-Gm-Message-State: AOAM532omrI4s8W6xkOWq6JmNTfnHorSrrtTMPuwT5woQaQ4PhWA1ZP2
        TAQHE5SfIz31JX3tTg/dBFosIZ3xADgdcw==
X-Google-Smtp-Source: ABdhPJwx07Gu7V/n987R2hobAFIcaX6EvzMUAxRv+ym2TXydqc8qgCTwzYaKX2lSjLKTF+atmOFtcw==
X-Received: by 2002:ac8:5c48:: with SMTP id j8mr1108118qtj.154.1623783419845;
        Tue, 15 Jun 2021 11:56:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e1sm12746838qti.27.2021.06.15.11.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:56:59 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol/cil: Fix anonymous IP address call arguments
Date:   Tue, 15 Jun 2021 14:56:53 -0400
Message-Id: <20210615185655.34064-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210615185655.34064-1-jwcart2@gmail.com>
References: <20210615185655.34064-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A named IP address (using an ipaddr rule) could be passed as an
argument, but trying to pass an actual IP address caused an error.

As an exmample, consider the following portion of a policy.
  (macro m4 ((ipaddr ip)(ipaddr nm))
    (nodecon ip nm (USER ROLE TYPE ((s0) (s0))))
  )
  (ipaddr nm1 255.255.255.0)
  (ipaddr ip1 1.2.3.4)
  (call m4 (ip1 nm1)) ; This works
  (call m4 (1.2.3.4 255.255.255.0)) ; This doesn't

Allow actual IP addresses to be passed as a call argument. Now the
second call works as well.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c   |  4 ----
 libsepol/cil/src/cil_resolve_ast.c | 23 ++++++++++-------------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 71f14e20..538df279 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5642,10 +5642,6 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr)
 		goto exit;
 	}
 
-	if (addr_node->cl_head != NULL ||  addr_node->next != NULL) {
-		goto exit;
-	}
-
 	if (strchr(addr_node->data, '.') != NULL) {
 		addr->family = AF_INET;
 	} else {
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 77ffe0ff..16c8c753 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3024,14 +3024,18 @@ static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call
 			break;
 		}
 		case CIL_IPADDR: {
-			if (arg_node->cl_head != NULL) {
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			} else if (strchr(arg_node->data, '.') || strchr(arg_node->data, ':')) {
 				struct cil_ipaddr *ipaddr = NULL;
 				struct cil_tree_node *addr_node = NULL;
 				cil_ipaddr_init(&ipaddr);
-
-				rc = cil_fill_ipaddr(arg_node->cl_head, ipaddr);
+				rc = cil_fill_ipaddr(arg_node, ipaddr);
 				if (rc != SEPOL_OK) {
-					cil_log(CIL_ERR, "Failed to create anonymous ip address, rc: %d\n", rc);
+					cil_tree_log(call_node, CIL_ERR, "Failed to create anonymous ip address");
 					cil_destroy_ipaddr(ipaddr);
 					cil_destroy_args(arg);
 					goto exit;
@@ -3039,18 +3043,11 @@ static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call
 				cil_tree_node_init(&addr_node);
 				addr_node->flavor = CIL_IPADDR;
 				addr_node->data = ipaddr;
-				cil_list_append(((struct cil_symtab_datum*)ipaddr)->nodes,
-								CIL_LIST_ITEM, addr_node);
-				arg->arg = (struct cil_symtab_datum*)ipaddr;
-			} else if (arg_node->data == NULL) {
-				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
-				cil_destroy_args(arg);
-				rc = SEPOL_ERR;
-				goto exit;
+				cil_list_append(DATUM(ipaddr)->nodes, CIL_LIST_ITEM, addr_node);
+				arg->arg = DATUM(ipaddr);
 			} else {
 				arg->arg_str = arg_node->data;
 			}
-
 			break;
 		}
 		case CIL_CLASS:
-- 
2.26.3

