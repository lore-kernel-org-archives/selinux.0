Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3FCC3DA71
	for <selinux@archiver.kernel.org>; Thu, 15 Dec 2022 21:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLOVep (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLOVen (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Dec 2022 16:34:43 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E51A5C745
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:42 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3b56782b3f6so7620337b3.13
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/Y8uMxZ5RpI6Wkcv+ld0hDRt33WJSY94UTyLUbiVxY=;
        b=JUA+AB/QGhG5VvPumvbdiUgOjtFhm9fjpuStV7v0Lo+aSuckBjT+A5+Mrlo2vOU4cL
         WsStfcQ2CjxpUS4HPiE2lwmAv0JrDJXexS5PY/OotZEBTg5fmuedLMeyCjgxhYqJPvAF
         gXs0XqMdsd0YN8tm9rDsZ0f0O0bJwKOKO/DOc9Czq5+Pw5ZOCV/QYgO2m5z84MNRv3QX
         GpB58JItUxuao4KID72a9HNX2C2ghIrSvl7wb7iDuIuYG3ocwV+R2MdgTZqa4Cr6lwoR
         WorG+ZKYDoh3zy06trSXC5W9EpqzbEZ1WOlfeVu7WmzI6mKqRxI+sfW2l3hPAXrCCWkI
         AzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/Y8uMxZ5RpI6Wkcv+ld0hDRt33WJSY94UTyLUbiVxY=;
        b=TjUFCzNoeyc1EjrgjsgWNvF69uyCBy2QRw5xae2omt+Gh4i4j094V4a9OLQ5BRBIR6
         A8/tEYjVPWFYZEN2DUP8//aYrOl8TTUl/XUw2NsI6YFftgbmiTj0TBPdSpc21FIg/KgJ
         ow5oood3fOh8ZkCtqjW7cqmPym6O7+Ec0zWIe3jelVNxmxUDSZkDS9lwU/h20oyDUJOt
         ttuiPkd+8E1KEdG1VaSxRQp4cOW2Ci/O/OHBhaSHXHrdiomf+NefJatQWpGTrwip4LXK
         5eESEuehcu+jG0re02dYuYbXVPaOw04MEo9lMZHD4bz/pHYb8I1rYGmH0zYU95xxQQ8d
         9c2Q==
X-Gm-Message-State: ANoB5pkivGGKMbGLquFIg00txrdUBdY3tmaC9cGMek80Mfz8y0ujYx/U
        x029tfYPln+FHxLmYa1Q8I4IN3hRIhc=
X-Google-Smtp-Source: AA0mqf5HoQ8Am5SADYAwqKmohu28vSxUHw4S671wlqSKkaxQz9hsZLuVzR9aDqIWmWlPK4nwRTCo7g==
X-Received: by 2002:a81:1ece:0:b0:389:157b:1f5c with SMTP id e197-20020a811ece000000b00389157b1f5cmr25275562ywe.42.1671140080918;
        Thu, 15 Dec 2022 13:34:40 -0800 (PST)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b006a6ebde4799sm21066qko.90.2022.12.15.13.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:34:40 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 5/9] libsepol/cil: Add cil_write_post_ast function
Date:   Thu, 15 Dec 2022 16:34:25 -0500
Message-Id: <20221215213429.998948-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215213429.998948-1-jwcart2@gmail.com>
References: <20221215213429.998948-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function cil_write_post_ast() will write the CIL AST after
post processing is done. Most post processing does not change the
CIL AST, this is where deny rules are processed (because to process
them, type attributes have to have been evaluated.)

When processed, deny rules may add new rules and attributes and the
deny rule itself will be removed from the AST, so using this new
function will show the results of the deny rule processing.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/include/cil/cil.h   |  1 +
 libsepol/cil/src/cil.c           | 50 ++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_write_ast.h |  1 +
 3 files changed, 52 insertions(+)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index 482ca522..88e47e79 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -64,6 +64,7 @@ extern void cil_write_policy_conf(FILE *out, struct cil_db *db);
 extern int cil_write_parse_ast(FILE *out, cil_db_t *db);
 extern int cil_write_build_ast(FILE *out, cil_db_t *db);
 extern int cil_write_resolve_ast(FILE *out, cil_db_t *db);
+extern int cil_write_post_ast(FILE *out, cil_db_t *db);
 
 enum cil_log_level {
 	CIL_ERR = 1,
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 0b35ad35..bfeccb0e 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -675,6 +675,56 @@ exit:
 	return rc;
 }
 
+int cil_write_post_ast(FILE *out, cil_db_t *db)
+{
+	int rc = SEPOL_ERR;
+
+	if (db == NULL) {
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Building AST from Parse Tree\n");
+	rc = cil_build_ast(db, db->parse->root, db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to build ast\n");
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Destroying Parse Tree\n");
+	cil_tree_destroy(&db->parse);
+
+	cil_log(CIL_INFO, "Resolving AST\n");
+	rc = cil_resolve_ast(db, db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to resolve ast\n");
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Qualifying Names\n");
+	rc = cil_fqn_qualify(db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to qualify names\n");
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Compile post process\n");
+	rc = cil_post_process(db);
+	if (rc != SEPOL_OK ) {
+		cil_log(CIL_ERR, "Post process failed\n");
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Writing Post AST\n");
+	rc = cil_write_ast(out, CIL_WRITE_AST_PHASE_POST, db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to write post ast\n");
+		goto exit;
+	}
+
+exit:
+	return rc;
+}
+
 int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db)
 {
 	int rc;
diff --git a/libsepol/cil/src/cil_write_ast.h b/libsepol/cil/src/cil_write_ast.h
index 3f4b9d95..6b3274a8 100644
--- a/libsepol/cil/src/cil_write_ast.h
+++ b/libsepol/cil/src/cil_write_ast.h
@@ -38,6 +38,7 @@ enum cil_write_ast_phase {
 	CIL_WRITE_AST_PHASE_PARSE = 0,
 	CIL_WRITE_AST_PHASE_BUILD,
 	CIL_WRITE_AST_PHASE_RESOLVE,
+	CIL_WRITE_AST_PHASE_POST,
 };
 
 void cil_write_ast_node(FILE *out, struct cil_tree_node *node);
-- 
2.38.1

