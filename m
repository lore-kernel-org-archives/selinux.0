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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27950C433B4
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18F86143F
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbhD1USs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhD1USr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 16:18:47 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4DC061573
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 8so31229322qkv.8
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdjlkgFvZ6bJVB9yZnI+PcfD6xo19ON36Uj6JSeXF6A=;
        b=QryY62m1mAjU5W3rj6BdjK7+r3kvEIloWUfyypGk+jJBSc9EWyKc9Mwr4Kn2nq8KWW
         2CRBkaVr+KQj39cvnAwAqAgkEXBb0cUCBMskWBQIxM5Zh9eLKsIsQT9tYHcSnxqtWu91
         DOUOmLuIu+m67yIapEqnVaZx1jcDZNijYxu0xOrmqmwNWDOcVvZKRhoglH4zVx+laFAD
         swV9tJE4ixlNSQ6cD4BBY+mtgnVU4fI5amKgIgUslZaFk1OdWegZN5sZ6IN5Y0tc93J0
         1jiZut+tWjc7T5vVE5m02+U85/hv2ZVoPVSt1phr93++TtZ2+vNlmMx1Gp/47aoc4+LS
         RzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdjlkgFvZ6bJVB9yZnI+PcfD6xo19ON36Uj6JSeXF6A=;
        b=e9WVaualtcoGqMuiNj9dwd6Y1pl9q4nJVcvgMvJYV3zZacvrD5uzbYQVP8u0m/WEte
         d2cN9AooO/zfjcya24ZASrnUGxKj7IFqe/l+fIF9I/21S3/8ZOKkIRwlAxAzREoQDWE2
         56hsO8VwFxoOHJUTByWXoveE2JW8qsniEk7Imam1vb//s+ZZJvSUj+iLRSkJDQHoVVNd
         Ue/N1ScPEWbLdyEZ8TfC7b09OThSBP3bf4Xe6NrCqOqYr05oQA8fwzNhn06qUzIdKkR2
         ZGpgNqpZjlsJ4qCFu1Qd8GM27J4zKK9YLJhTG+aHfCHmXLBDUcKd4zMsuxOPndSkadPD
         6UnA==
X-Gm-Message-State: AOAM530i2dluZsQokVEUo3myLvaU6cNpRa35XnKZAn0Yr0iQj8344SEw
        Cmo5qW3D8MYKdYLXGxMUQkaI7Aiyf9z66Q==
X-Google-Smtp-Source: ABdhPJw81l8OAP6tci1uwt422mH3gCAG03mfgTHh0+dnrlzBG2jk5GUJgpcwnss/cwzrux1EtTEi/Q==
X-Received: by 2002:a37:9d3:: with SMTP id 202mr23947561qkj.390.1619641079221;
        Wed, 28 Apr 2021 13:17:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q126sm616666qkd.48.2021.04.28.13.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:17:58 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/5] libsepol/cil: Fix instances where an error returns SEPOL_OK
Date:   Wed, 28 Apr 2021 16:17:49 -0400
Message-Id: <20210428201753.282831-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210428201753.282831-1-jwcart2@gmail.com>
References: <20210428201753.282831-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There are six instances when the CIL policy is being built or
resolved where an error can be detected, but SEPOL_OK is returned
instead of SEPOL_ERR. This causes the policy compiler to continue
when it should exit with an error.

Return SEPOL_ERR in these cases, so the compiler exits with an
error.

Two of the instances were found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c   | 3 +++
 libsepol/cil/src/cil_resolve_ast.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 5b1e2824..87043a8f 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -444,6 +444,7 @@ int cil_gen_class(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		}
 		if (class->num_perms > CIL_PERMS_PER_CLASS) {
 			cil_tree_log(parse_current, CIL_ERR, "Too many permissions in class '%s'", class->datum.name);
+			rc = SEPOL_ERR;
 			goto exit;
 		}
 
@@ -1018,6 +1019,7 @@ int cil_gen_common(struct cil_db *db, struct cil_tree_node *parse_current, struc
 	}
 	if (common->num_perms > CIL_PERMS_PER_CLASS) {
 		cil_tree_log(parse_current, CIL_ERR, "Too many permissions in common '%s'", common->datum.name);
+		rc = SEPOL_ERR;
 		goto exit;
 	}
 
@@ -3209,6 +3211,7 @@ int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_node *parse_c
 		expandattr->expand = CIL_FALSE;
 	} else {
 		cil_log(CIL_ERR, "Value must be either \'true\' or \'false\'");
+		rc = SEPOL_ERR;
 		goto exit;
 	}
 
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 872b6799..5389df43 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -772,6 +772,7 @@ int cil_resolve_classcommon(struct cil_tree_node *current, void *extra_args)
 	class->num_perms += common->num_perms;
 	if (class->num_perms > CIL_PERMS_PER_CLASS) {
 		cil_tree_log(current, CIL_ERR, "Too many permissions in class '%s' when including common permissions", class->datum.name);
+		rc = SEPOL_ERR;
 		goto exit;
 	}
 
@@ -1484,6 +1485,7 @@ int cil_resolve_classorder(struct cil_tree_node *current, void *extra_args)
 		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, extra_args, &datum);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Failed to resolve class %s in classorder\n", (char *)curr->data);
+			rc = SEPOL_ERR;
 			goto exit;
 		}
 		cil_list_append(new, CIL_CLASS, datum);
@@ -2464,6 +2466,7 @@ int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_args)
 	block_node = NODE(block_datum);
 	if (block_node->flavor != CIL_BLOCK) {
 		cil_log(CIL_ERR, "Failed to resolve blockabstract to a block, rc: %d\n", rc);
+		rc = SEPOL_ERR;
 		goto exit;
 	}
 
-- 
2.26.3

