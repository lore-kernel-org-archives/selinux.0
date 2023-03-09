Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B70C6FD1C
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCIVvd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjCIVv1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:51:27 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6639D10284D
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:51:23 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id w23so3733584qtn.6
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TphXNmLoxWyrKR3qabIIE/DfWh8CUfVO3rEaj4A1CJw=;
        b=JqwqEnKjpRVv1grp/9L7eleK4gY2p2Ugw98AZIXqAYJoNILFzF+tlyBm/CnSlQnEuX
         0RciT9sYQX0jpAQCSfjIJh/w6i5agmiVEoKNobwk51kDBZRhmPT2GcEuP0YsJDw2Gsfr
         MuscbvImrA223lSC5EFpj+EF721uNui2yXson2M9PiICoGSjPXMl0hpIOxxtR8Lmwv/9
         YwafDJxYhRBAx9aH43dhcDac5p325pKHE7fjbDuDn9cQ+lQhQDm9KVsSylS3Olq5fbR+
         WpRVjwgq8T/RjaPiHvTuwT1zZaU02IN1xTtEwJjggk4c3ZtqD7+cfhPBFUc/ZaMjhkVq
         4UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TphXNmLoxWyrKR3qabIIE/DfWh8CUfVO3rEaj4A1CJw=;
        b=wd/+DdlV0x3g2afYIYl09Q0WEgNyJM1GrLuLf8DcKcSDjiqVsYmtgcKFAr+GgVNrUj
         6agBg2yNAnOK7moBtWMCNOdEtzE0E5tV1ZUZWzqjTY9JRDoMJC+XlESv+ssG9ApbhV/T
         QY+LQY5fY5dFtw5wWJWKmP/mjGoNiucaCrEILAh5tUT/oHQKCzyKaljizwAaaKWfPkOL
         akqHlZIvF0MntvQM2qtxFwF1ZEoKzdpl9LOxItUcwJsHZVi0oJvJLZRRW4QUIcpRdC2i
         I9wMK/Yn2iH9sBcOQo+iwJz8EBSlOBxpc9hWRq9gj7vKQ/XEcXsgrnARK2HL4ERMmUB8
         /g1g==
X-Gm-Message-State: AO0yUKX71uvXiI5JujjaVhvAE49PMVr3DpOPTyNmVL4/4Y/Iuoa8gZCe
        bn0+e8lNZdAaaWLDNlaDka6AiiXcrfM=
X-Google-Smtp-Source: AK7set8MscObjdVp00eNMqJw4jmufjcRRuRINm/baJyBiPNVhiA0lHylk6lpD7C62X4sxVO9pfZEXw==
X-Received: by 2002:ac8:7e83:0:b0:3bf:c994:c9b3 with SMTP id w3-20020ac87e83000000b003bfc994c9b3mr40990182qtj.61.1678398681713;
        Thu, 09 Mar 2023 13:51:21 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007422fa6376bsm25731qkk.77.2023.03.09.13.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:21 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 5/9 v2] libsepol/cil: Add cil_write_post_ast function
Date:   Thu,  9 Mar 2023 16:51:10 -0500
Message-Id: <20230309215114.357831-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309215114.357831-1-jwcart2@gmail.com>
References: <20230309215114.357831-1-jwcart2@gmail.com>
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
2.39.2

