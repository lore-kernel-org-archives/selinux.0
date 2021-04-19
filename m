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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A5C433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7216611CE
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbhDSPQw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbhDSPQv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B487C06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:22 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id e13so26259079qkl.6
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pOlz7wGcHQM3MqxkhimHA9KcoCJz+h2Y1oTAnuOBYNg=;
        b=cgy9Z0hMI8pEL7AILqxutuEFK9PNQQgSMZDBUb4NWaIoZ9cAtD5Yc8wrxbtH+y0eZr
         76O5L6ha9RCflYyg6oOyvQFDaiSonu1bqVjuWSkwWmNAnbMwxLJK6EEjt2OvEAqrpIm/
         tVLZVcxwjoElx+kO+3OMK2C+lnlWT56SEiR9d9bMJLJ6/xr2PJ5GFe8OcXZCh8ICwBz9
         piXUpujkgu09fpAfoqHLCUy80QkFlCP8oYRSSJpk9Jd8ZgyQpiWIz1G3yuVOnZQKmznh
         K03SUZegQtHxQ3Atm+bThPFBZe6A4fs3VbmIxwVXhZ/YMe7jNoDgLX9GQ2slkwA9/XiY
         a0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pOlz7wGcHQM3MqxkhimHA9KcoCJz+h2Y1oTAnuOBYNg=;
        b=cBeoCRL3x8TgylMyYKKrIL2PthjBRd+2ktS6NxddTebyQT+b5EepKgd8DF8rPD5msj
         arTQ57ynYy7lhtwTF3pdF1yz6pSMQMTcHWmnuU6E7IMYwGWRtR/WqCwrKqAQgse8r1tc
         to36FqQPjXaSSS1RwkFT/AWTYldd2m81VVRTgf+M314yCTAD3pEBBImtITamrczZQw7t
         KokAEaGK+3V1becnN+YR0ZHuBO0ByVCaaGFg/cMBmLCIrA4DGSwDmSFTqHRHptRmvN0p
         YnNvzgQMxwsX/nvhpTSQyQkE7n4h69ZiCXxLcnmnumK/yPLYxG+nfnDYP2DegW4bIsyX
         EZxA==
X-Gm-Message-State: AOAM530UN0Nv8K9qiFp2Rmk74mJcD/Y1+/0nH37fXPQqqumuAUCHKZg2
        c3GVh+paKMvPXsSLtcuXhQwnTzrE7/DRUQ==
X-Google-Smtp-Source: ABdhPJya5FDN/sYnugJI33NfGeiQAXhLZngLZ3n2vb1E5897eiqnC6+l00My22vjrPVHLBFbMaar/Q==
X-Received: by 2002:ae9:df46:: with SMTP id t67mr12445998qkf.269.1618845381157;
        Mon, 19 Apr 2021 08:16:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:20 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 07/11 v2] libsepol/cil: Exit with an error if declaration name is a reserved word
Date:   Mon, 19 Apr 2021 11:15:53 -0400
Message-Id: <20210419151557.87561-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When CIL parses sets or conditional expressions, any identifier that
matches an operator name will always be taken as an operator. If a
declaration has the same name as an operator, then there is the
possibility of causing either confusion or a syntax error if it is
used in an expression. The potential for problems is much greater
than any possible advantage in allowing a declaration to share the
name of a reserved word.

Create a new function, __cil_is_reserved_name() that is called when
an identifier is declared and its name is being validated. In this
function, check if the declaration has the same name as a reserved
word for an expression operator that can be used with the identifer's
flavor and exit with an error if it does.

Also, move the check for types, type aliases, and type attributes
matching the reserved word "self" to this new function.

Finally, change the name of the function __cil_verify_name() to
cil_verify_name(), since this function is neither static nor a
helper function.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 28 ++---------------
 libsepol/cil/src/cil_verify.c    | 52 +++++++++++++++++++++++++++++++-
 libsepol/cil/src/cil_verify.h    |  2 +-
 3 files changed, 54 insertions(+), 28 deletions(-)

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
index 2707b6c9..8fd54360 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -47,7 +47,51 @@
 
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
+	case CIL_USER:
+	case CIL_USERATTRIBUTE:
+	case CIL_ROLE:
+	case CIL_ROLEATTRIBUTE:
+		if (name == CIL_KEY_ALL)
+			return CIL_TRUE;
+		break;
+	case CIL_TYPE:
+	case CIL_TYPEATTRIBUTE:
+	case CIL_TYPEALIAS:
+		if ((name == CIL_KEY_ALL) || (name == CIL_KEY_SELF))
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
+		/* All of these are not used in expressions */
+		return CIL_FALSE;
+		break;
+	}
+
+	/* Everything not under the default case is also checked for these */
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
@@ -77,6 +121,12 @@ int __cil_verify_name(const char *name)
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
2.26.3

