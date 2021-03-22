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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE9C433E0
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6593B61920
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 13:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhCVN1R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCVN0p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Mar 2021 09:26:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4306AC061574
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 06:26:45 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i9so10443657qka.2
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDJm2MATB84/tBzv++3dILccJagdPxvcMHOoGf479rM=;
        b=KqOKVwdby7tLeVmTe/6F3NJV6EddRoqqsuyAk2FdOBufA9ZI18F5X9U0p+nXiC9r1r
         9SRYFhGtPA1+R+wtFZ19z7spVimIv8A5+FHNs2dZ1/BgutHBKlwTLn7JW6maFbecuCd8
         3Rtn3UU0Eo/FCxBd/wNMA4W6DSvZhciThUfsRiSiU45uT20DfI/6ObI08r1dNsG2DtBM
         y7sfc1QBF+GpISm4k0ymO0x11OczJGN2zphKlylevNlFNFHejrD2jYOlozSpmeQcituC
         myM19JP+ajisa0pupJheTMBse1nwbKa58tKu++tSRlIwxuZcpZ+od8nLxU4dTFfzaQ4j
         vXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDJm2MATB84/tBzv++3dILccJagdPxvcMHOoGf479rM=;
        b=g3EDHK7+PQcghGZjQZ+atNh071s96fl8HRUul3oxey45FpS5CbbdOPBb7y4wHOVjaE
         DrrbUDRUAH3vN/7sL8o5K1UFzMZp9lpXg2kRAwC/dTayKvUz5Y5IjO4PHil+KBfESTdh
         eJe/fDZr9lAWyz7MyTvnjsB3avwJBj4ailr99RIO/7JtE9GXZudX3OciQSHMKhZTWFH3
         7DYrBikWpw4gDhFZxr+6hz45tSGGqpIMUoZ7epl5FaEVpxUIaCxUg6zOGW0EoyNHKfRj
         ePQW0jkY1OYJHr78TGpY3M86yC35ET+qF3sqS+LD+xLQJssoOYq+noGOLMChySt/YCOr
         fh4w==
X-Gm-Message-State: AOAM531BkGLn3zr0CZ7AolxxBQ94xbWluxQjpYUHPCmlU1fIot1+WrhZ
        mWsAWjJvDjS50c6kNJz3vnDLzkVnW6pVPg==
X-Google-Smtp-Source: ABdhPJyBS3l/kVOCcgX4zpNyjn7nEAGHDQNh5O/YpMLEqMGC3DVaznyBpBw4nHzh9SReo0Ko64JzcA==
X-Received: by 2002:a37:6108:: with SMTP id v8mr11076067qkb.448.1616419604275;
        Mon, 22 Mar 2021 06:26:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id g6sm11028550qkd.62.2021.03.22.06.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 06:26:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH V2] libsepol/cil: Exit with an error if declaration name is a reserved word
Date:   Mon, 22 Mar 2021 09:26:27 -0400
Message-Id: <20210322132627.19327-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
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
index 09e3daf9..498da0ac 100644
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
2.26.2

