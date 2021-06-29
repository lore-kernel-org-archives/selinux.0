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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58822C11F67
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 15:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B8361DAD
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 15:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhF2PQf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhF2PQf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jun 2021 11:16:35 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E97C061760
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 08:14:08 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d5so16368058qtd.5
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW/7/+1nLHFH/Zwqtv/3N72W+1tiKj1USjx4rMJyJMU=;
        b=pWh4OnMGq/DheUFdbpKzFEQHYUPgIdX4MTIwFisKJxbIOQ3Qw/jrTWFUlJkboPfv61
         uy67WDE3N1Uqs6sWt2tBFZKePHKVnQ6HwHEDkqhZht5kpGatRwjfdoHB8XOjlp5ZQLVM
         YLFOYlUYW4xebSRzWpL8hXJJrULpZCTvZvLK21+9jvZVC1UgeLiE3iKjwJlwr0sTEwRZ
         WYHpm7HbiaF5Ujo18ojd6lQ7vV3rOXmEU3gsVUvMSedv9yePSG57VS5UT4zmKUY9NVeO
         oMlrD0hQoRGx14oV2EAzteIj7VBfFrbNNabnWRzy8Uyf/6HJ09ZrGRfRXgufZ4qVNFD5
         xg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW/7/+1nLHFH/Zwqtv/3N72W+1tiKj1USjx4rMJyJMU=;
        b=SydtTPTT42VCKj4VcbENQr/j7MsTKnL+w7wBu7ULQnCELssdqLC91+0QuQWa0ogyW5
         fSixl2gRCq6bpl1guaQTbMxbXbj7OF1O6GqRSBx5Ml8XnVHHKDh1vze/PXXw+q6gYtK1
         G9hK5UA9tGRSEF+44m8Zc4TKBZzer1Oix9LJAIFk9ZOHFSolmZ/VmTW1KHDBHRnMSOns
         V4V2NS1XCwwm4zoTHMRtiDIQ5WGEBVj+bOTfHVoYQDTer1NTmGC6amnvZoQT7GE+GXO5
         qxMkeQrB+6kzSNPEoBPo3v++IB/JJD0jwe7jmWuz5dopqrryvUtyAeu4rN+DI05kIv8u
         Xyww==
X-Gm-Message-State: AOAM532gJVy6uV9otPL3xPGWqEOnTNW5LHryijy27sS+5gfinrVzvVJu
        6SkLJf/IoLeAHGliWY4M4e86wuGD3K+OQw==
X-Google-Smtp-Source: ABdhPJx+mF9/YldCOXdJmP+FfbcYlXnSDs+2qJoELbTnhs8B/sKK8Mig8p9pjAos1QvOVS7V+cSnpA==
X-Received: by 2002:ac8:c01:: with SMTP id k1mr26955596qti.344.1624979647047;
        Tue, 29 Jun 2021 08:14:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e12sm7880721qtj.3.2021.06.29.08.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 08:14:06 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/4 v2] libsepol/cil: Provide option to allow qualified names in declarations
Date:   Tue, 29 Jun 2021 11:13:59 -0400
Message-Id: <20210629151402.41071-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Qualified names have "dots" in them. They are generated when a CIL
policy is compiled and come from declarations in blocks. If a kernel
policy is decompiled into a CIL policy, the resulting policy could
have declarations that use qualified names. Compiling this policy would
result in an error because "dots" in declarations are not allowed.

Qualified names in a policy are normally used to refer to the name of
identifiers, blocks, macros, or optionals that are declared in a
different block (that is not a parent). Name resolution is based on
splitting a name based on the "dots", searching the parents up to the
global namespace for the first block using the first part of the name,
using the second part of the name to lookup the next block using the
first block's symbol tables, looking up the third block in the second's
symbol tables, and so on.

To allow the option of using qualified names in declarations:

1) Create a field in the struct cil_db called "qualified_names" which
is set to CIL_TRUE when qualified names are to be used. This field is
checked in cil_verify_name() and "dots" are allowed if qualified names
are being allowed.

2) Only allow the direct lookup of the whole name in the global symbol
table. This means that blocks, blockinherits, blockabstracts, and in-
statements cannot be allowed. Use the "qualified_names" field of the
cil_db to know when using one of these should result in an error.

3) Create the function cil_set_qualified_names() that is used to set
the "qualified_names" field. Export the function in libsepol.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2:
 Fixed misspelling in commit message
 Make struct cil_db * const in cil_verify_name()
 
 libsepol/cil/include/cil/cil.h     |  1 +
 libsepol/cil/src/cil.c             |  6 ++++++
 libsepol/cil/src/cil_build_ast.c   | 24 ++++++++++++++++++++++--
 libsepol/cil/src/cil_internal.h    |  1 +
 libsepol/cil/src/cil_resolve_ast.c |  4 ++--
 libsepol/cil/src/cil_verify.c      | 19 ++++++++++++++-----
 libsepol/cil/src/cil_verify.h      |  2 +-
 libsepol/src/libsepol.map.in       |  1 +
 8 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index 92fac6e1..482ca522 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -51,6 +51,7 @@ extern int cil_selinuxusers_to_string(cil_db_t *db, char **out, size_t *size);
 extern int cil_filecons_to_string(cil_db_t *db, char **out, size_t *size);
 extern void cil_set_disable_dontaudit(cil_db_t *db, int disable_dontaudit);
 extern void cil_set_multiple_decls(cil_db_t *db, int multiple_decls);
+extern void cil_set_qualified_names(struct cil_db *db, int qualified_names);
 extern void cil_set_disable_neverallow(cil_db_t *db, int disable_neverallow);
 extern void cil_set_preserve_tunables(cil_db_t *db, int preserve_tunables);
 extern int cil_set_handle_unknown(cil_db_t *db, int handle_unknown);
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 9d5038d9..3f2e6927 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -440,6 +440,7 @@ void cil_db_init(struct cil_db **db)
 	(*db)->handle_unknown = -1;
 	(*db)->mls = -1;
 	(*db)->multiple_decls = CIL_FALSE;
+	(*db)->qualified_names = CIL_FALSE;
 	(*db)->target_platform = SEPOL_TARGET_SELINUX;
 	(*db)->policy_version = POLICYDB_VERSION_MAX;
 }
@@ -1872,6 +1873,11 @@ void cil_set_multiple_decls(struct cil_db *db, int multiple_decls)
 	db->multiple_decls = multiple_decls;
 }
 
+void cil_set_qualified_names(struct cil_db *db, int qualified_names)
+{
+	db->qualified_names = qualified_names;
+}
+
 void cil_set_target_platform(struct cil_db *db, int target_platform)
 {
 	db->target_platform = target_platform;
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index baed3e58..9da90883 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -146,7 +146,7 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 	int rc = SEPOL_ERR;
 	symtab_t *symtab = NULL;
 
-	rc = cil_verify_name((const char*)key, nflavor);
+	rc = cil_verify_name(db, (const char*)key, nflavor);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -204,6 +204,11 @@ int cil_gen_block(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		goto exit;
 	}
 
+	if (db->qualified_names) {
+		cil_log(CIL_ERR, "Blocks are not allowed when the option for qualified names is used\n");
+		goto exit;
+	}
+
 	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
 	if (rc != SEPOL_OK) {
 		goto exit;
@@ -274,6 +279,11 @@ int cil_gen_blockinherit(struct cil_db *db, struct cil_tree_node *parse_current,
 		goto exit;
 	}
 
+	if (db->qualified_names) {
+		cil_log(CIL_ERR, "Block inherit rules are not allowed when the option for qualified names is used\n");
+		goto exit;
+	}
+
 	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
 	if (rc != SEPOL_OK) {
 		goto exit;
@@ -331,6 +341,11 @@ int cil_gen_blockabstract(struct cil_db *db, struct cil_tree_node *parse_current
 		goto exit;
 	}
 
+	if (db->qualified_names) {
+		cil_log(CIL_ERR, "Block abstract rules are not allowed when the option for qualified names is used\n");
+		goto exit;
+	}
+
 	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
 	if (rc != SEPOL_OK) {
 		goto exit;
@@ -376,6 +391,11 @@ int cil_gen_in(struct cil_db *db, struct cil_tree_node *parse_current, struct ci
 		goto exit;
 	}
 
+	if (db->qualified_names) {
+		cil_log(CIL_ERR, "In-statements are not allowed when the option for qualified names is used\n");
+		goto exit;
+	}
+
 	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
 	if (rc != SEPOL_OK) {
 		goto exit;
@@ -5261,7 +5281,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 
 		param->str =  current_item->cl_head->next->data;
 
-		rc = cil_verify_name(param->str, param->flavor);
+		rc = cil_verify_name(db, param->str, param->flavor);
 		if (rc != SEPOL_OK) {
 			cil_destroy_param(param);
 			goto exit;
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 8b9aeabf..f184d739 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -321,6 +321,7 @@ struct cil_db {
 	int handle_unknown;
 	int mls;
 	int multiple_decls;
+	int qualified_names;
 	int target_platform;
 	int policy_version;
 };
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 5245cc15..27efffa6 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4409,8 +4409,8 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
 
 	*datum = NULL;
 
-	if (strchr(name,'.') == NULL) {
-		/* No '.' in name */
+	if (db->qualified_names || strchr(name,'.') == NULL) {
+		/* Using qualified names or No '.' in name */
 		rc = __cil_resolve_name_helper(db, ast_node->parent, name, sym_index, datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 59397f70..ce3fcd8c 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -92,7 +92,7 @@ static int __cil_is_reserved_name(const char *name, enum cil_flavor flavor)
 	return CIL_FALSE;
 }
 
-int cil_verify_name(const char *name, enum cil_flavor flavor)
+int cil_verify_name(const struct cil_db *db, const char *name, enum cil_flavor flavor)
 {
 	int rc = SEPOL_ERR;
 	int len;
@@ -116,10 +116,19 @@ int cil_verify_name(const char *name, enum cil_flavor flavor)
 			goto exit;
 	}
 
-	for (i = 1; i < len; i++) {
-		if (!isalnum(name[i]) && name[i] != '_' && name[i] != '-') {
-			cil_log(CIL_ERR, "Invalid character \"%c\" in %s\n", name[i], name);
-			goto exit;
+	if (db->qualified_names == CIL_FALSE) {
+		for (i = 1; i < len; i++) {
+			if (!isalnum(name[i]) && name[i] != '_' && name[i] != '-') {
+				cil_log(CIL_ERR, "Invalid character \"%c\" in %s\n", name[i], name);
+				goto exit;
+			}
+		}
+	} else {
+		for (i = 1; i < len; i++) {
+			if (!isalnum(name[i]) && name[i] != '_' && name[i] != '-' && name[i] != '.') {
+				cil_log(CIL_ERR, "Invalid character \"%c\" in %s\n", name[i], name);
+				goto exit;
+			}
 		}
 	}
 
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index 4ea14f5b..26e195a9 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -56,7 +56,7 @@ struct cil_args_verify {
 	int *pass;
 };
 
-int cil_verify_name(const char *name, enum cil_flavor flavor);
+int cil_verify_name(const struct cil_db *db, const char *name, enum cil_flavor flavor);
 int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], int len);
 int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, enum cil_flavor expr_flavor);
 int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_flavor r_flavor, enum cil_flavor op, enum cil_flavor expr_flavor);
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 2e503bd1..0e05d606 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -272,4 +272,5 @@ LIBSEPOL_3.0 {
 	cil_write_parse_ast;
 	cil_write_build_ast;
 	cil_write_resolve_ast;
+	cil_set_qualified_names;
 } LIBSEPOL_1.1;
-- 
2.31.1

