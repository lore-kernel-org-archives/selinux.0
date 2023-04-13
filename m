Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D81C77B73
	for <selinux@archiver.kernel.org>; Thu, 13 Apr 2023 19:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDMTez (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Apr 2023 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDMTey (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Apr 2023 15:34:54 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC76649FF
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:53 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54f6fc7943eso184702167b3.3
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681414492; x=1684006492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjjPArLljG3+riJQfS2Y0TCPWrwFZjCT7dfqqWfapEo=;
        b=UAFf8xZ+nRWlxiv27Ev/UtzAjTojgu7hPLh7rYSLaQ3dwHrr3KwdHpsyGtLsfXZqRZ
         rlqpxKnqNme1tzYsMrH3LO7f6y1v/WTRknnbk6sTMNe34hlmMzJgig7WGH6HYEuJ8B0u
         l64ZLAt3xJu95wkX5Q+aiFu8w9xxTEGO952hVxXviqL+/AbxbQ3fmx7m1YK9g12VMdj3
         KqpO0Eb8mJ7bWl1pZB+CuYvQ0ma3vrqHLSeS0tMmgNpTbyelEDMhjosfDf9pV0nTTLQI
         7QasFuvvIPw887rD+KZ+MHbS30A78QH9Yq86lGbPsBeIxDKswjl0ht+T6HN6oNFDM8o7
         79mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414492; x=1684006492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjjPArLljG3+riJQfS2Y0TCPWrwFZjCT7dfqqWfapEo=;
        b=H2yWemMfjw+KmI9mvxxQC32HMfTLXygEzxvEiK36+nn9ejr2c/jYHiunC2ueGH1k4l
         kJgqG2rz06vrlwvhyCyG5g65JmVv78d3DYDkoh8XgniaYriB5hdWq2UWILmBDKhSRgrW
         8QpI6PXxR6QqJhLa7QX/nxJ70yXsasEYAJRy01jUTmQhIu6ie+vEbgXrs5aqCgbxOTj9
         ph81CBxNvq65GH2iIfhGHN5ssCFJeeBNua550/EDHnJeF3MTikR73f4U3sQyQGOkxwg+
         Dk8Fjh35w8ok+ADa1g33A6HHFHW92wUPohWh7KgMBd/x7z4D5CIJuMbokEiZoR9lb42i
         HPeA==
X-Gm-Message-State: AAQBX9f1HGqHZafZ0I33SrL2BfO5hLYyepuqnQFQewhBiVFy3w2g9/Q9
        xDbJ7uErvsnh1ofvDCmSheZhhQrWXRc=
X-Google-Smtp-Source: AKy350apC6PSOKKmFNr4pm+7weX4uuxpQetVhE/I0r3uVDxDipOhGQeFI3u25NZSkgFIk2NxzHll2w==
X-Received: by 2002:a81:83c5:0:b0:54f:cf6e:4b97 with SMTP id t188-20020a8183c5000000b0054fcf6e4b97mr2661763ywf.25.1681414492568;
        Thu, 13 Apr 2023 12:34:52 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id 21-20020a811615000000b0054c0f46b24bsm691350yww.5.2023.04.13.12.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:34:52 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/9 v3] libsepol/cil: Add cil_write_post_ast function
Date:   Thu, 13 Apr 2023 15:34:41 -0400
Message-Id: <20230413193445.588395-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413193445.588395-1-jwcart2@gmail.com>
References: <20230413193445.588395-1-jwcart2@gmail.com>
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
index 4876752a..2021187d 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -687,6 +687,56 @@ exit:
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
2.39.2

