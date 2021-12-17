Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85C1C433F5
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhLQSTf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhLQSTe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:34 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A55C06173E
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:34 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id m6so3177253qvh.10
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B27Crs8BDI/b0uopwtXzC0FMir/HbJXcmoMpkqLZ7hc=;
        b=OkBnuJcaKZcmjPWZ0SX+HIO31hRNSmcuq9+opHcc/h0eSI7ieiFSqjn26LYy7ePCFl
         m1/yXnmXCl11Gt4WOSJrqDXbEuUKyf55it3GZRsRW/ALH6z01EEbRQUgsAiVXIeWqaA1
         xegUN6dBU/nDyGR0tQrFFDRaPog5dW2XTtlIC8vrcaahWoh/+TeT+tEk7/T+TMAr/k9v
         sP4K5OclfA80d4t3TPdoQyeJgxGS6jOCy4DpqSMD3muVJ/3hoK2KWF2v218qbZM62lOA
         Qyk9ggpA/UsjufuVjgOj/LIwHMU1oLQLLTU8sUOtTEV8jVqf96EmrN1MJFCihDfQIdXH
         lzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B27Crs8BDI/b0uopwtXzC0FMir/HbJXcmoMpkqLZ7hc=;
        b=N5u8THPEfLNmemAA1cszaR89aB87ouoygK6cMGivmUENOHDmxfufyhxqmHNjkIPMVg
         rGhoAZk5br9j0d2R2xts3hZJYT+Aj5xUqca1/zGqixSnJ19rLZfOOHU2jnz2Aogj1SS7
         Oqg7jP8h+jSfczoLbbdcyPKSTNf/Fvu6ZBF16s9iDERZRU/B/GMfWzcQG6dYs1xTukbx
         71YTqlTU5mqoJ08SyyFsoviEZ8e6cPG1/xVyIOmloqNw3pD1Mg15WyUyE2Ki3Sa1lp+P
         WSr0qBJuW5LBRsanBMcPhussWZM3xbiTs4MM/eaGRu9REDo46xXH3tVol7fApnjxNZNB
         WMtA==
X-Gm-Message-State: AOAM533W7vtrymw4W2vHexakw/oaNsW+ZQc8DVmm61Ka07q8igqL/9YQ
        LQA9TxSNCK0UkIc+0k5B/Hw7Qh+JcKw=
X-Google-Smtp-Source: ABdhPJwLja+pP4p/y7vbm988DzQLu9bSkUBrcs/ydvGtSLxzdeE54Xqy+CxasL+j6nCHFr4vFMNi4w==
X-Received: by 2002:ad4:5965:: with SMTP id eq5mr3667146qvb.64.1639765173601;
        Fri, 17 Dec 2021 10:19:33 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:33 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 16/16] libsepol: Fix two problems with neverallowxperm reporting
Date:   Fri, 17 Dec 2021 13:19:13 -0500
Message-Id: <20211217181913.336360-17-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Not all violations of neverallowxperm rules were being reported.
In check_assertion_extended_permissions_avtab(), a break was
performed after finding a match rather than just returning right
away. This means that if other src and tgt pairs were checked
afterward that did not match, then no match would be reported.

Example:
 allow attr attr:CLASS ioctl;
 allowxperm attr attr:CLASS ioctl 0x9401;
 allowxperm t1 self:CLASS ioctl 0x9421;
 neverallowxperm attr self:CLASS ioctl 0x9421;
Would result in no assertion violations being found.

Another problem was that the reporting function did not properly
recognize when there was a valid allowxperm rule and falsely
reported additional violations that did not exist. (There had
to be at least one legitimate violation.)

Using the same example as above (and assuming t1 and t2 both have
attribute attr), the following would be reported as:
  neverallowxperm on line 4 of policy.conf (or line 4 of policy.conf)
  violated by
  allowxperm t1 t1:CLASS ioctl { 0x9421 };

  neverallowxperm on line 4 of policy.conf (or line 4 of policy.conf)
  violated by
  allow t2 t2:CLASS4 { ioctl };

There is no violation for t2 because there is a valid allowxperm
rule for it.

With this patch, only the first error message (which is the correct
one) is printed.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index ecd3f567..0ee7f104 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -149,6 +149,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 	int rc;
+	int found_xperm = 0;
 	int errors = 0;
 
 	memcpy(&tmp_key, k, sizeof(avtab_key_t));
@@ -165,7 +166,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 				if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
 						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
 					continue;
-
+				found_xperm = 1;
 				rc = check_extended_permissions(avrule->xperms, xperms);
 				/* failure on the extended permission check_extended_permissions */
 				if (rc) {
@@ -185,7 +186,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	}
 
 	/* failure on the regular permissions */
-	if (!errors) {
+	if (!found_xperm) {
 		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.conf) violated by\n"
 				"allow %s %s:%s {%s };",
 				avrule->source_line, avrule->source_filename, avrule->line,
@@ -343,7 +344,7 @@ static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t
 					continue;
 				rc = check_extended_permissions(neverallow_xperms, xperms);
 				if (rc)
-					break;
+					return rc;
 			}
 		}
 	}
-- 
2.31.1

