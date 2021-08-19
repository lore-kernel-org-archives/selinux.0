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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B8C4338F
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56ED610A6
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 16:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhHSQyU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Aug 2021 12:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhHSQyP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Aug 2021 12:54:15 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A3C061756
        for <selinux@vger.kernel.org>; Thu, 19 Aug 2021 09:53:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id y144so7845416qkb.6
        for <selinux@vger.kernel.org>; Thu, 19 Aug 2021 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CY1oivaNcgGqc+60GpGh5iHHVbeaHELLIOa6qzVNR8=;
        b=DkROTkCIzClmqeJIvte61/V42G1hg3fQvMXbY1odrnd0ngYooINX+AtZXq5ZODBMI3
         7a6+hu4jzhNYorGO7tQuq+KLzGA1rsUZrWoZIMhGamyaqx4EfBrVUneqIVmzynE2sKcd
         DezL4ppC7C8ONp0aqNNOk70wOOloC7XIa4YlH9ftmAfXRiPBxZT+rZ+haCH/T2MDdU3k
         HUfx595VezzaRX4pqwykmcCC70ywJIvEx/AugrYUfHTCFa4iCZueCawzI60ZigOZAYHt
         2xTG3Rb8dh47OqLaG9L6XEJYq/2zK682UTPlzjuJm5nXUiPQEZ7ovNdCLbcxoDqXGobS
         LcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CY1oivaNcgGqc+60GpGh5iHHVbeaHELLIOa6qzVNR8=;
        b=VW/+0DLOG3vH7/KhLVl1RpfW1QB+aMD+Hp44QR+RyiAbuHcLXnqnK8XULV9ZoKjJ0T
         Tq/yLd3ieADYB+sSaMdNedFrC3FlprxPXRtN5YiARWrSvPJHum5FQEwsgib/ZbDNT8gt
         slG5bPOVh4eTOtGp1Ls4puP+HuEp/+2VbQ6FAY/1fyu1MWkheUe8R680vcRVrRow02sh
         ZHy9sJxuCrDIkThefD+iddmg3Bz/Z/t+DyHuwe9tamo8QVD5ulfs9i36Y9Ngmi7rjBJE
         NvK/N8dzrHgDGS6rRoZkNUbTQ2PpdlOtgNH2ohKE2NdCbj6M9RdEBcBYLMYZCOqGnYH+
         XYMA==
X-Gm-Message-State: AOAM532PdT94FtCwvLS2i4IWG3tRyCNtsQpP88FGKNVHYUZkZQTZREMS
        OpsYS9j2uLXUep+8Zv4CdtrqtaMp/uxtCA==
X-Google-Smtp-Source: ABdhPJxwYZvS+JvfMpyPGwfgxTgl1jpsnj5X/FPF2cI4EinAzYhfEvRWFGsmenj7PMcnJIX7dr0GhQ==
X-Received: by 2002:a05:620a:1222:: with SMTP id v2mr4659864qkj.1.1629392017721;
        Thu, 19 Aug 2021 09:53:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h140sm1895411qke.112.2021.08.19.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:53:37 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol/cil: Fix syntax checking in __cil_verify_syntax()
Date:   Thu, 19 Aug 2021 12:53:32 -0400
Message-Id: <20210819165332.58896-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819165332.58896-1-jwcart2@gmail.com>
References: <20210819165332.58896-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function __cil_verify_syntax() is used to check the syntax of
CIL rules (and a few other common things like contexts and class
permissions). It does not correctly check the syntax combination
"CIL_SYN_STRING | CIL_SYN_N_LISTS, CIL_SYN_N_LISTS | CIL_SYN_END".
This should mean either a string followed by any number of lists
or any number of lists followed by the end of the rule. Instead,
while allowing the correct syntax, it allows any number of lists
followed by a string followed by any number of more lists followed
by the end of the rule and, also, any number of lists followed by a
string followed by the end of the rule.

Refactor the function to make it clearer to follow and so that once
checking begins for CIL_SYN_N_LISTS or CIL_SYN_N_STRINGS, then only
strings or lists are allowed until the end of the rule is found. In
addition, always check for CIL_SYN_END at the end.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_verify.c | 71 ++++++++++++-----------------------
 1 file changed, 23 insertions(+), 48 deletions(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index fc8a8a40..b1c2270e 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -146,68 +146,43 @@ exit:
 
 int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], int len)
 {
-	int rc = SEPOL_ERR;
-	int num_extras = 0;
 	struct cil_tree_node *c = parse_current;
 	int i = 0;
-	while (i < len) {
-		if ((s[i] & CIL_SYN_END) && c == NULL) {
-			break;
-		}
 
-		if (s[i] & CIL_SYN_N_LISTS || s[i] & CIL_SYN_N_STRINGS) {
-			if (c == NULL) {
-				if (num_extras > 0) {
-					i++;
-					continue;
+	while (i < len && c != NULL) {
+		if (s[i] & CIL_SYN_STRING && c->data != NULL && c->cl_head == NULL) {
+			c = c->next;
+			i++;
+		} else if (s[i] & CIL_SYN_LIST && c->data == NULL && c->cl_head != NULL) {
+			c = c->next;
+			i++;
+		} else if (s[i] & CIL_SYN_EMPTY_LIST && c->data == NULL && c->cl_head == NULL) {
+			c = c->next;
+			i++;
+		} else if (s[i] & CIL_SYN_N_LISTS || s[i] & CIL_SYN_N_STRINGS) {
+			while (c != NULL) {
+				if (s[i] & CIL_SYN_N_LISTS && c->data == NULL && c->cl_head != NULL) {
+					c = c->next;
+				} else if (s[i] & CIL_SYN_N_STRINGS && c->data != NULL && c->cl_head == NULL) {
+					c = c->next;
 				} else {
 					goto exit;
 				}
-			} else if ((s[i] & CIL_SYN_N_LISTS) && (c->data == NULL && c->cl_head != NULL)) {
-				c = c->next;
-				num_extras++;
-				continue;
-			} else if ((s[i] & CIL_SYN_N_STRINGS) && (c->data != NULL && c->cl_head == NULL)) {
-				c = c->next;
-				num_extras++;
-				continue;
 			}
-		}
-
-		if (c == NULL) {
+			i++;
+			break; /* Only CIL_SYN_END allowed after these */
+		} else {
 			goto exit;
 		}
+	}
 
-		if (s[i] & CIL_SYN_STRING) {
-			if (c->data != NULL && c->cl_head == NULL) {
-				c = c->next;
-				i++;
-				continue;
-			}
-		}
-
-		if (s[i] & CIL_SYN_LIST) {
-			if (c->data == NULL && c->cl_head != NULL) {
-				c = c->next;
-				i++;
-				continue;
-			}
-		}
-
-		if (s[i] & CIL_SYN_EMPTY_LIST) {
-			if (c->data == NULL && c->cl_head == NULL) {
-				c = c->next;
-				i++;
-				continue;
-			}
-		}
-		goto exit;
+	if (i < len && s[i] & CIL_SYN_END && c == NULL) {
+		return SEPOL_OK;
 	}
-	return SEPOL_OK;
 
 exit:
 	cil_log(CIL_ERR, "Invalid syntax\n");
-	return rc;
+	return SEPOL_ERR;
 }
 
 int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, enum cil_flavor expr_flavor)
-- 
2.31.1

