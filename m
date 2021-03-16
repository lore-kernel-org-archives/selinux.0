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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C6DC433E6
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C7364F3C
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCPUsb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhCPUrD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 16:47:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAED6C061763
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:47:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 130so36728591qkh.11
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVVLeswQX3H4oa0NEfzaaNNdDOmB4ycLHUjSbK8NV9w=;
        b=qHjx+fehstsfviBWi/rXH6Fr38RXas/+aFmjdszHFzb7/5aFh4SQySP6SdnKen1LCz
         6IidjLioVUcLDLV42UM7AufIxl/XbMChkqg23/O2/+1t1qmegOoY+EnaUAD+VxLm4p1l
         wsql9PHwDPyAZerX8tBk4Ca2C4yc8bH07UxHrEBuJYBcSopU2OfkcnCsJ0aACBYFj7QE
         G/EpACo2ucEmpVila1M2TP0uSuaYJvERBQz1iDybeAnwgvcbSIBu2jL6BJyby39YzcGw
         zFFaOoYclLJ6iGt1I8+p2YZJg95ROh3TynlqptqxLe+Hjh9QrFs+zuyQ+zJIq77vt0o0
         EP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVVLeswQX3H4oa0NEfzaaNNdDOmB4ycLHUjSbK8NV9w=;
        b=g+sAEf92Iuk6f3y6s80FxXi2PckTza9/OpTnL9QJc3t2QV4KKn2GA+vkfkl/2OCwSs
         Y9DoBX8zvN7Ugj+iXMP0cu+IvdwFSFcGOwW7rNhcjJMAcP+pH51WnQdGWVLPXE2RE8+n
         4OCNEO36cYL+ewIRRU7ySwz2Latzx3Y/Ix4FblsO7IZacEq27vvLBX9LAybVJB1mPxXo
         QSYFE6BR2nM+8TLctMD4JNgur8vxqWwhtlJ21cDkyVQFArCnH7TwX+uYK9qY9dZW5lRZ
         kp14dGO021rWp77cbKFmlV53N926LCaoWVieiDGK7jnRYl1fVEqfF8KapoJEOkrOSnAT
         ONIQ==
X-Gm-Message-State: AOAM530+DWx3LFXLIJOGfvK+SrHBdxTgEkMqVo4oeIiYukzSkxWqDm5s
        evQjeDSLiXrbepjKzN/8esXEpcH2Z08=
X-Google-Smtp-Source: ABdhPJxI7EQAqTSh7cHvGGYDe+5fPz3QurVYTUw7NRtX5uwbXZHf7bAUuZyn8hqitMcSNe2k6ANuTg==
X-Received: by 2002:a37:8ec4:: with SMTP id q187mr944356qkd.381.1615927621844;
        Tue, 16 Mar 2021 13:47:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v4sm13905687qte.18.2021.03.16.13.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:47:01 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/4] libsepol: Enclose identifier lists in CIL constraint expressions
Date:   Tue, 16 Mar 2021 16:46:45 -0400
Message-Id: <20210316204646.52060-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210316204646.52060-1-jwcart2@gmail.com>
References: <20210316204646.52060-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When writing CIL policy from a kernel policy or module, if there are
multiple users, roles, or types, then the list needs to be enclosed
by "(" and ")".

When writing a constraint expression, check to see if there are
multiple identifiers in the names string and enclose the list with
"(" and ")" if there are.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_cil.c | 6 +++++-
 libsepol/src/module_to_cil.c | 9 ++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index a146ac51..96e0f5d3 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -191,7 +191,11 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 				if (!names) {
 					goto exit;
 				}
-				new_val = create_str("(%s %s %s)", 3, op, attr1, names);
+				if (strchr(names, ' ')) {
+					new_val = create_str("(%s %s (%s))", 3, op, attr1, names);
+				} else {
+					new_val = create_str("(%s %s %s)", 3, op, attr1, names);
+				}
 				free(names);
 			}
 		} else {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index a87bc15e..3cc75b42 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1800,13 +1800,20 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 
 				// length of values/oper + 2 spaces + 2 parens + null terminator
 				len = strlen(op) + strlen(attr1) +  strlen(names) + 2 + 2 + 1;
+				if (num_names > 1) {
+					len += 2; // 2 more parens
+				}
 				new_val = malloc(len);
 				if (new_val == NULL) {
 					log_err("Out of memory");
 					rc = -1;
 					goto exit;
 				}
-				rlen = snprintf(new_val, len, "(%s %s %s)", op, attr1, names);
+				if (num_names > 1) {
+					rlen = snprintf(new_val, len, "(%s %s (%s))", op, attr1, names);
+				} else {
+					rlen = snprintf(new_val, len, "(%s %s %s)", op, attr1, names);
+				}
 				if (rlen < 0 || rlen >= len) {
 					log_err("Failed to generate constraint expression");
 					rc = -1;
-- 
2.26.2

