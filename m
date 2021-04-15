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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D561CC433ED
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCC361132
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhDOUeQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhDOUeM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Apr 2021 16:34:12 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DCAC061756
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:33:47 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id j3so12390739qvs.1
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QSc4SycAP0DZSnL1I0IGQcikI5WEFo8Al5pXtz5Sq8=;
        b=p+YzA/v79SwtB1EdjLlUW9JFQ47PZWiMS6Rt2Ja4qj53V6C4d4nm1VQ0xEl8bq08O9
         d6UWcy2pd2O3lfw8XiZHQxab4NybDwUpq7qH31QmwMny/ZSCXXMjtWqPPUn8jy94yPbl
         Fo5obfi0ASTWcejNIve4Z6JN5qIHaFXUFgaNSZN4hR7xk1BLID+8NxAElgql74ih0bFX
         e8UrJRbzLvgOyt73LgQlJ3Zd+wsO8SBIGP0aXmfWmQQ/+i/EnjVj4LDSqGTq7DZ5AoBl
         P8UXEvCPP74Cfiek8++rRE+wAK2fZNVJ7seK90x7b6r8UNqYsMPtzFg968Aubdzug3pW
         q6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QSc4SycAP0DZSnL1I0IGQcikI5WEFo8Al5pXtz5Sq8=;
        b=fDYxEmLVBozFBH9MKzkYQCOBc/l1pQF8dqAF+MvvR9mzEEuK+utTQOCSWaibMDL6cn
         /nBx7rs2YzktsQ9vLixKTVGvshLTxtyUn87Fj3Qv4pZYD54RkpKNz0UZ2ATbwbA+Eq10
         +FCpxoCrTDbKAD5CC/CPkx3eYGe6cVY1DY8/AhekEYm5plXrHmZGn1yPhqJwhjPsjri8
         u1GHxvQcjU+tuNQ+nAXsluhMIGVj3p/ufAY4qXlTb3X8cYL2CmvrAo1JvqX0hfqKs9lB
         lap4RfUrRuo76qV3r3WQ0iDInvg2SIoCwY7SXhlvBAvU3unwgmO3eDggje/HBi2vJXRE
         DS3Q==
X-Gm-Message-State: AOAM531gfyEs7jBwEByG0cUMtOB1V4ERFMvP75VOC8oLbQ8ZIBypxi8F
        HzCpXWmKx1O8UZ+5lhFRl4XHDAbv4Ub0mw==
X-Google-Smtp-Source: ABdhPJxotMDZihFE6zxWoHHUPEv8bmjFfROetVly3gz4jdBs0PqQy7+6bsQq1dT0zB2JWBVgMM0o7w==
X-Received: by 2002:a0c:e950:: with SMTP id n16mr5022974qvo.43.1618518826771;
        Thu, 15 Apr 2021 13:33:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c27sm2763469qko.71.2021.04.15.13.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:33:46 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol/cil: Add functions to make use of cil_write_ast()
Date:   Thu, 15 Apr 2021 16:33:31 -0400
Message-Id: <20210415203332.191302-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210415203332.191302-1-jwcart2@gmail.com>
References: <20210415203332.191302-1-jwcart2@gmail.com>
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

