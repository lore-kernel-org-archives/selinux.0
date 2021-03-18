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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C745C433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 19:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40A664F1D
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 19:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhCRTJB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 15:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhCRTIa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 15:08:30 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF59C06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 12:08:30 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cx5so3759537qvb.10
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8rEBrQp5MPeB03Dm2NM6o3jQsn03LyJ2o6sG2W3uYc=;
        b=Cu+XDebNvsm3PYw6iYiwn0T6Z2W/S4EnzD7cnGmpR3lL36iOJyIoQ25NwEyBpTCODr
         GDZieO+oqrUtVDqW02BOo7sJA/liMpyVp8lPfvD8ss047+t8eIJTyAh2IIzNh4jJbuua
         eT8L3v+El3Llb0QzzQ+kLJV8BOgHu3GfmWV1Kzezm3zLPn7mXdmZ3fKHMDuvhRZjy8eo
         NBVp380qYwLt8L4VCjVypyqCLcNOMaK2iRG5gvHEViX6H1QvAJ/igcnRDn/ps4pbEvzg
         FPyIo7BDlDH3MZedUxRQY8bIONtS1i6Gh+v8L9uyIH/Fri3Gx0GDlumfijJ5PYSpeqcJ
         Mayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8rEBrQp5MPeB03Dm2NM6o3jQsn03LyJ2o6sG2W3uYc=;
        b=RTl7FgilgNBUcU2m6qhpFKjHkyU8lla3HuQ6VJV6/AJQndKW9q9TqYwJ95L0//sdgM
         k+ZFPdWzk1jEX3IooNjOyxCgTc2AQKjxzgzNdUEpnY4hHPnpG6TpK1JTZHTUgVXWh/iM
         MkHUVCu+xXePnAzbrcLbf0c2E0/KqlPVqPirYy+t7IMY9Fa/iu1siyR02t1thvko3ZDW
         0rm2s0IoR/gQnVsWxoObrW0Pwu6Gwto5lvX4YTenZD/jINdf7rzft2v627kBG8+Do7ff
         B/YrIcqvv8bgXAn5Auw5yp6TiVfGo+oV8bFF4vYoMVuSJzxDKzVVyG/AOgpnFk9sBZkG
         eN1A==
X-Gm-Message-State: AOAM531xVkyxiq7qRQ+7Xmp2Mo2rn5sRMgKRDGnfBCpAC8CyUDqj5mpr
        6eU6tvqJOUoF6blCglm1Y8now0fthPIAWA==
X-Google-Smtp-Source: ABdhPJxa8akNkXcbylz8j4SzO0bW7kTDwtC94ebNRJeP8gvsQXVD75emwD6yLuXG6IULfJSre0QREg==
X-Received: by 2002:ad4:58e3:: with SMTP id di3mr5769094qvb.43.1616094509559;
        Thu, 18 Mar 2021 12:08:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d24sm2467024qko.54.2021.03.18.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 12:08:29 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Exit with an error if declaration name is a reserved word
Date:   Thu, 18 Mar 2021 15:08:26 -0400
Message-Id: <20210318190826.151168-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When CIL evaluates sets, conditional expressions, or constraint
expressions, bad things can happen if an identifier has a name that
is the same as an operator. CIL will interpret the name as an
identifier in some places and as an operator in others.

Example:
  (classmap CM1 (and pm1 pm2))
  (classmapping CM1 and (C1 (P1a)))
  (classmapping CM1 pm1 (C1 (P1b)))
  (classmapping CM1 pm2 (C1 (P1c)))
  (allow TYPE self (CM1 (and pm1 pm2)))
In the classmap and classmapping statements, "and" is the name of an
identifier, but in the allow rule, "and" is an expression operator.
The result is a segfault.

When an identifier is declared and it is being validated, check if
it has the same name as a reserved word for an expression operator
that can be used with the identifer's flavor and exit with an error
if it does.

Also, change the name of the function __cil_verify_name() to
cil_verify_name(), since this function is neither static nor a
helper function.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 28 ++--------------
 libsepol/cil/src/cil_verify.c    | 56 +++++++++++++++++++++++++++++++-
 libsepol/cil/src/cil_verify.h    |  2 +-
 3 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 4e53f06a..e57de662 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -114,7 +114,7 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 	symtab_t *symtab = NULL;
 	struct cil_symtab_datum *prev;
 
-	rc = __cil_verify_name((const char*)key);
+	rc = cil_verify_name((const char*)key, nflavor);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1953,12 +1953,6 @@ int cil_gen_roleattribute(struct cil_db *db, struct cil_tree_node *parse_current
 		goto exit;
 	}
 
-	if (parse_current->next->data == CIL_KEY_SELF) {
-		cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_KEY_SELF);
-		rc = SEPOL_ERR;
-		goto exit;
-	}
-
 	cil_roleattribute_init(&attr);
 
 	key = parse_current->next->data;
@@ -2337,12 +2331,6 @@ int cil_gen_type(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		goto exit;
 	}
 
-	if (parse_current->next->data == CIL_KEY_SELF) {
-		cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_KEY_SELF);
-		rc = SEPOL_ERR;
-		goto exit;
-	}
-
 	cil_type_init(&type);
 
 	key = parse_current->next->data;
@@ -2391,12 +2379,6 @@ int cil_gen_typeattribute(struct cil_db *db, struct cil_tree_node *parse_current
 		goto exit;
 	}
 
-	if (parse_current->next->data == CIL_KEY_SELF) {
-		cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_KEY_SELF);
-		rc = SEPOL_ERR;
-		goto exit;
-	}
-
 	cil_typeattribute_init(&attr);
 
 	key = parse_current->next->data;
@@ -3048,12 +3030,6 @@ int cil_gen_alias(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		goto exit;
 	}
 
-	if (flavor == CIL_TYPEALIAS && parse_current->next->data == CIL_KEY_SELF) {
-		cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_KEY_SELF);
-		rc = SEPOL_ERR;
-		goto exit;
-	}
-
 	cil_alias_init(&alias);
 
 	key = parse_current->next->data;
@@ -5278,7 +5254,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 
 		param->str =  current_item->cl_head->next->data;
 
-		rc = __cil_verify_name(param->str);
+		rc = cil_verify_name(param->str, param->flavor);
 		if (rc != SEPOL_OK) {
 			cil_destroy_param(param);
 			goto exit;
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 09e3daf9..c2efbf1c 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -47,7 +47,55 @@
 
 #include "cil_verify.h"
 
-int __cil_verify_name(const char *name)
+static int __cil_is_reserved_name(const char *name, enum cil_flavor flavor)
+{
+	switch (flavor) {
+	case CIL_BOOL:
+	case CIL_TUNABLE:
+		if ((name == CIL_KEY_EQ) || (name == CIL_KEY_NEQ))
+			return CIL_TRUE;
+		break;
+	case CIL_PERM:
+	case CIL_MAP_PERM:
+		if (name == CIL_KEY_ALL)
+			return CIL_TRUE;
+		break;
+	case CIL_USER:
+	case CIL_USERATTRIBUTE:
+		if ((name == CIL_KEY_ALL) || (name == CIL_KEY_CONS_U1) || (name == CIL_KEY_CONS_U2) || (name == CIL_KEY_CONS_U3))
+			return CIL_TRUE;
+		break;
+	case CIL_ROLE:
+	case CIL_ROLEATTRIBUTE:
+		if ((name == CIL_KEY_ALL) || (name == CIL_KEY_CONS_R1) || (name == CIL_KEY_CONS_R2) || (name == CIL_KEY_CONS_R3))
+			return CIL_TRUE;
+		break;
+	case CIL_TYPE:
+	case CIL_TYPEATTRIBUTE:
+	case CIL_TYPEALIAS:
+		if ((name == CIL_KEY_ALL) || (name == CIL_KEY_SELF) || (name == CIL_KEY_CONS_T1) || (name == CIL_KEY_CONS_T2) || (name == CIL_KEY_CONS_T3))
+			return CIL_TRUE;
+		break;
+	case CIL_CAT:
+	case CIL_CATSET:
+	case CIL_CATALIAS:
+	case CIL_PERMISSIONX:
+		if ((name == CIL_KEY_ALL) || (name == CIL_KEY_RANGE))
+			return CIL_TRUE;
+		break;
+	default:
+		return CIL_FALSE;
+		break;
+	}
+
+	if ((name == CIL_KEY_AND) || (name == CIL_KEY_OR) || (name == CIL_KEY_NOT) || (name == CIL_KEY_XOR)) {
+		return CIL_TRUE;
+	}
+
+	return CIL_FALSE;
+}
+
+int cil_verify_name(const char *name, enum cil_flavor flavor)
 {
 	int rc = SEPOL_ERR;
 	int len;
@@ -77,6 +125,12 @@ int __cil_verify_name(const char *name)
 			goto exit;
 		}
 	}
+
+	if (__cil_is_reserved_name(name, flavor)) {
+		cil_log(CIL_ERR, "Name %s is a reserved word\n", name);
+		goto exit;
+	}
+
 	return SEPOL_OK;
 
 exit:
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index 905761b0..1887ae3f 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -56,7 +56,7 @@ struct cil_args_verify {
 	int *pass;
 };
 
-int __cil_verify_name(const char *name);
+int cil_verify_name(const char *name, enum cil_flavor flavor);
 int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], int len);
 int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, enum cil_flavor expr_flavor);
 int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_flavor r_flavor, enum cil_flavor op, enum cil_flavor expr_flavor);
-- 
2.26.2

