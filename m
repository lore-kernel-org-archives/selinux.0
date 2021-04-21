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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC65AC433ED
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 17:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A107A61164
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 17:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbhDURVy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhDURVx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 13:21:53 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB823C06174A
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 10:21:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t17so15088162qkg.4
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbnKLSR0zRYL/nVbnERkq6QTO6O4uX30idvr23Mx9qI=;
        b=tUByqAyBcYIWeDrg7ExXyTV2L28wAOB/SEXo3r0fVR1FYnCZorrYVBv/byHvd3ub0A
         jaYw5zPGCmcdel7UlejTiVVYc+njkWQyPDnQSY47yFZWonYi/Q1eUj9Pui9sXfRuBuCK
         lT/Tl3Zn/rTo/eQR+YrU2NHFiBGf/txPNhxNexJgMTzQLYerCblKO9HGGZ7BQcF/kqBm
         1nQSXfRKsGbX8x9Ce0q/WUV6lQpoZk+e0S/deDWULAOcFCNQVFk7XbYfLBrqlLumN9Gv
         IYotDmUtU24l9ix2TOmSBRIH4Q+27u6XLKk/nAwcJaa7ajE8F/M1UH4RJGjFCNaFd/3N
         0lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbnKLSR0zRYL/nVbnERkq6QTO6O4uX30idvr23Mx9qI=;
        b=GaIL/CFMAw5RImmkdZwpROOElqVd4egTIDy37OE7wXoh7ToHQvbGadVuJ6yKPeU9LZ
         zUictiznRqcOqgSaWveftqTIAChnrZoRu8w+L8wNBtVfYMtS2v5BdmK7ERdmmSKaq/NA
         AjkKdsuKzfPUJT/Uz7JRO1krUPB2Ikxi10RQBJzJEr7nzMzYqnkNvSYAlnq5K2d6OihJ
         IKDnUWpYbfn7agLDWp08q8iYDB/gJhyZY9++eZeBoHetyspU9mqkLiKBucyKxLI4UC3U
         VP65pv+QxtMUbzAjMO4t1FPOXWSJN71quNHaohig1TRJEI2ECGs8B+Ee7VeEj0kvxgGX
         9wLQ==
X-Gm-Message-State: AOAM5335m4cQcFP4NXs3IDF7aUjruSJ/DeODhl5P15SC9hQRppmaKiLc
        IZYkt2qG6UQMoi7Yp3TW7P+OtvkWqCbRlA==
X-Google-Smtp-Source: ABdhPJx7XtOrvRXgD7avN5zX/LHM6w9z8xWPctXQF0QBY79dnOSzul9UANxqpvJhtgKDxcUMeA4IvQ==
X-Received: by 2002:a37:d4e:: with SMTP id 75mr7128772qkn.110.1619025679823;
        Wed, 21 Apr 2021 10:21:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r25sm143051qtm.18.2021.04.21.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:21:19 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3 v3] libsepol/cil: Add functions to make use of cil_write_ast()
Date:   Wed, 21 Apr 2021 13:21:11 -0400
Message-Id: <20210421172112.13277-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421172112.13277-1-jwcart2@gmail.com>
References: <20210421172112.13277-1-jwcart2@gmail.com>
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
index b971922c..0d351b49 100644
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

