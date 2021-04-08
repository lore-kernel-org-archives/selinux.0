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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F48CC433B4
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F7E610F9
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhDHTQq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhDHTQp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:45 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E2FC061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:34 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f12so2328945qtf.2
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxOBB5XvBgjcfRCt3SpPRgSU87/sGnnmSKicJrMBdWY=;
        b=HNVCuYAMuxhIFVmIazR+cG1e7Am/+B1bBCbZ3WxgEfbPSRYShqusXfUONvl/qdDP5b
         1InKhqGEzouAHyr6Ay4+2ZXhiYUS8QkDFrVSBxxQU2oCMWBvIyhsx2/kAc2LNYyrBnOH
         RYkh1udIbeB3+iuiBXDzId1Z+p6sBlF+ymfcD03P+0d+agjkX4DM5c2I0ZM7g/eFkXFJ
         xDh+y1HCgaYL+Tm67L84G8sPKwqLX87VE7EIaYYFj07X7isiaQ8BaLBSPprv5YWqE49w
         YGfitOLvM/3vBcs0xR/eMjB65FIgjR3JZqYgVWLMuvvhFM2NnAmS4YCWEozfud4tROZu
         3rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxOBB5XvBgjcfRCt3SpPRgSU87/sGnnmSKicJrMBdWY=;
        b=IYSRHb26lcjIiB63G0r+BwMcO1BrtfjDGeg60NL6NL3OMgKhOf7JuHpg3vsnNGkNda
         5uyds7w+go6w31sKYzVCYiN+nsQTDc2NQut9IM9Vv/QAqi0QvuyYz/emjlMLkSLY289k
         aBiZDCUm6KI4x0pbTGfPT5oOaRyyOBKM33GiBE631U6F9TqX9opuOaj9kJcDBtzF3ITR
         1sttSKtihZIq31gssn+xWSoWnrAWn5inYtYuG/4sM+TwX4X3tMvqc+IpYB4kUsIW+YUj
         OxSOHCaZkto3oIQU6i5onPiyN0yfodor0uohwETE6gsa28XV2qrbQv2Iaa4TjkS2JRH8
         cTWA==
X-Gm-Message-State: AOAM531LRObBAa0cbrmQINsyj5iqnhb8XSmoX0mTdCSNg+AeFXOK/MQA
        G7haHlk94MxYX5JO4XaMhE6Ce4qUD76gPA==
X-Google-Smtp-Source: ABdhPJxE0qU8GVEY9pLIhZeHj1xz9wtn9sz1mgslMwByWzJ4nxIZlOPAaHvjZqhlCZ0h0t0RmdunAw==
X-Received: by 2002:ac8:664a:: with SMTP id j10mr9119274qtp.119.1617909393262;
        Thu, 08 Apr 2021 12:16:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:33 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 07/11 v2] libsepol/cil: Exit with an error if declaration name is a reserved word
Date:   Thu,  8 Apr 2021 15:16:10 -0400
Message-Id: <20210408191614.262173-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
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
v2:
 Remove the check for u1, u2, u3, r1, r2, r3, t1, t2, and t3
 Removed example because that really shows a different bug
 Reworded the explanation

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
index 2707b6c9..6e46fef6 100644
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
+		if ((name == CIL_KEY_ALL))
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

