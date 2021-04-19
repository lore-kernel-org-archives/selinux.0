Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A015C433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6497961157
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbhDSP23 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbhDSP22 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:28:28 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B066C061761
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:27:58 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j7so26341609qtx.5
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QSc4SycAP0DZSnL1I0IGQcikI5WEFo8Al5pXtz5Sq8=;
        b=O8JqGJv0fCvgI298t06L4f3eGEWOPH0EWj82tOp+OO9r3hFyDgNGiuSrpzF7Eq7hHX
         Wh94pZ140MXDPkAFUoPqBRU+80XxAEGMrMOCctMDJam1U/Se8mB2OWowQeTZ+VIPMEBX
         qlQariuXJ+HnHrsHR6R2pK7PQTVyAQM87bYTinnLyIvuScFr4hs3waKVrzD0A0c15w7U
         hBpArwM94FRO+ZVm01IkqH/lqpxWbdkFVFTpt2RGU/DLC6FJdynd2MjpSTYUGABbJbKr
         scc8eINuLKi+gomfeeabFc+RZ/NcgnmMNIaREvbKP6q3A0lhDYGJJDOuDLo1Y2X3IPA5
         VtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QSc4SycAP0DZSnL1I0IGQcikI5WEFo8Al5pXtz5Sq8=;
        b=YHQMz2idAdbvm1i+K75McmyLJm8pMV5n2bZdRrGLYYqEDxqC0M1TXPn3GiOoCOD7vU
         qf/K86Xn7+Mi1a+RqfmNpyeUbUtejAATNKRw52+HjXMl6szMEsMBb8Qr5lMO1Bv9kE6b
         3EjFRlZWHssDQPWNDnvvgfRq3McJ8XCiefyxtaMoBpSsP8JC9XncQRp74s8tUfplA5eq
         5YOQvc6glea9qYsAO6KIt7SXAkjcn2D36SihPIUknrP8FlzvRC40ft8xi0hiAEks8x53
         OkxxNTDvrO47E95Dh8IygBkOO7flSg4WztyrNZu0Rn5ztHK/ypUhWiIs7kkIOSGE+2vT
         3+/Q==
X-Gm-Message-State: AOAM533iyHWHH0ZipOgUbknPiVWMMFwqZppwYpFwcP/SXHUH3qv1bGoZ
        gl3nlivvB5Hc7Zi3yG25NhaRjcygf0Hbkg==
X-Google-Smtp-Source: ABdhPJxRJHwik8liBdILM2t25D1ex2UxqurdPJZSmS8kqLmzx28xmCbDaNe00Hr5azChAMeVkOnCpQ==
X-Received: by 2002:ac8:490c:: with SMTP id e12mr9130072qtq.351.1618846077683;
        Mon, 19 Apr 2021 08:27:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id p23sm5959249qtl.8.2021.04.19.08.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:27:57 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3 v2] libsepol/cil: Add functions to make use of cil_write_ast()
Date:   Mon, 19 Apr 2021 11:27:48 -0400
Message-Id: <20210419152749.88086-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419152749.88086-1-jwcart2@gmail.com>
References: <20210419152749.88086-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the functions cil_write_parse_ast(), cil_write_build_ast(),
and cil_write_resolve_ast() that can be used outside of libsepol.

These functions take a FILE pointer and CIL db, do the CIL build
through the desired phase, and then call cil_write_ast() to write
the CIL AST at that point.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/include/cil/cil.h |  3 ++
 libsepol/cil/src/cil.c         | 92 ++++++++++++++++++++++++++++++++++
 libsepol/src/libsepol.map.in   |  3 ++
 3 files changed, 98 insertions(+)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index e6f4503e..92fac6e1 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -60,6 +60,9 @@ extern void cil_set_attrs_expand_size(struct cil_db *db, unsigned attrs_expand_s
 extern void cil_set_target_platform(cil_db_t *db, int target_platform);
 extern void cil_set_policy_version(cil_db_t *db, int policy_version);
 extern void cil_write_policy_conf(FILE *out, struct cil_db *db);
+extern int cil_write_parse_ast(FILE *out, cil_db_t *db);
+extern int cil_write_build_ast(FILE *out, cil_db_t *db);
+extern int cil_write_resolve_ast(FILE *out, cil_db_t *db);
 
 enum cil_log_level {
 	CIL_ERR = 1,
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 99c8e288..1696ba82 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -50,6 +50,7 @@
 #include "cil_binary.h"
 #include "cil_policy.h"
 #include "cil_strpool.h"
+#include "cil_write_ast.h"
 
 int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
 	{64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
@@ -572,6 +573,97 @@ exit:
 	return rc;
 }
 
+int cil_write_parse_ast(FILE *out, cil_db_t *db)
+{
+	int rc = SEPOL_ERR;
+
+	if (db == NULL) {
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Writing Parse AST\n");
+	rc = cil_write_ast(out, CIL_WRITE_AST_PHASE_PARSE, db->parse->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to write parse ast\n");
+		goto exit;
+	}
+
+exit:
+	return rc;
+}
+
+int cil_write_build_ast(FILE *out, cil_db_t *db)
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
+	cil_log(CIL_INFO, "Writing Build AST\n");
+	rc = cil_write_ast(out, CIL_WRITE_AST_PHASE_BUILD, db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to write build ast\n");
+		goto exit;
+	}
+
+exit:
+	return rc;
+}
+
+int cil_write_resolve_ast(FILE *out, cil_db_t *db)
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
+	cil_log(CIL_INFO, "Writing Resolve AST\n");
+	rc = cil_write_ast(out, CIL_WRITE_AST_PHASE_RESOLVE, db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to write resolve ast\n");
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
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index eb572125..2e503bd1 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -269,4 +269,7 @@ LIBSEPOL_1.1 {
 LIBSEPOL_3.0 {
   global:
 	sepol_policydb_optimize;
+	cil_write_parse_ast;
+	cil_write_build_ast;
+	cil_write_resolve_ast;
 } LIBSEPOL_1.1;
-- 
2.26.3

