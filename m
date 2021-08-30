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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BD2C432BE
	for <selinux@archiver.kernel.org>; Mon, 30 Aug 2021 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4460A60FA0
	for <selinux@archiver.kernel.org>; Mon, 30 Aug 2021 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhH3SZn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhH3SZm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Aug 2021 14:25:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2447C061575
        for <selinux@vger.kernel.org>; Mon, 30 Aug 2021 11:24:48 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id p4so10391668qki.3
        for <selinux@vger.kernel.org>; Mon, 30 Aug 2021 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+LzAehsE1IWi3+UVcZWDzW2dAsQpBqzmynp8yXS+VQ=;
        b=AuDw2kkAYQXbr8FUMDg//YhkkRr+aeqTVZQ1qYDnw9rvCVObuqi+2KvoN35g8e6b3+
         RL5FTZV64BKLNNA/h+81EbfgCKgkK3XBbpb76YaimLyLbO3CwNevEJXu3OuYBC/6Hrll
         zbpPFX4D9eeBaaPVOIFV7iKrVvd7dR1l11br79pFo1CBrQZMKrKUcc42yeKKvwVaQQGT
         MAgBXTnuxoJyiPiYtYdeVyn2w9MXqYHEx5jJZRWRSD7mcReCQBIONPN5dSbh4YLpT8pV
         nGinfulmUJTpknqAdj0r6MibqVkXwId5rZzUa6V+aQg0awfM621vmQ3v7AhtMb4nCTtu
         ATQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+LzAehsE1IWi3+UVcZWDzW2dAsQpBqzmynp8yXS+VQ=;
        b=Yrd+C6Ce9yoHqIkhqOTjmZvDSlDWf87itahi3agfVbroOUMC6shuvSnXidikDsLRcS
         52mqkPPPOdkaT3aNs5oBxiDyJCDJIqW0iaAuLHLI+QpwJsqC0kD6k1BJHDNWNNHjTyKX
         cmaBkqMsbSkmYzfBtgaK7MeWZ7uvFL76fo6Y1BnOgiGqd7uWKvwZbgmWnfX/NgJK9YtJ
         uii45t74GI0XU40DuRRqbcE7dk0i/9qfg6MC/FtoeVdnuyWnY2cawGr2tU5MtVBzFnH7
         DKHvrFWYr8/f3Rq7eGr/wJV2m5CM0vIzBIt/9WSCLjhJ/6l+LGmKyOQjgaq6G3y1Ls0o
         ao0A==
X-Gm-Message-State: AOAM531idQ+VCY5AjoZ2eHMhEmbFM8J4r+U66j0pbxM2NZRu1zih66Sh
        VqJ43wy8nDDjvq9QANAiqz15MxKYDrw=
X-Google-Smtp-Source: ABdhPJw6GmXxjbKRMMlV7npCJTcSOFSYonXPl2E+uE/lOoxFG4ZDwZQMwzea180reTl8uxF0nek+Rw==
X-Received: by 2002:ae9:e915:: with SMTP id x21mr23562259qkf.183.1630347887697;
        Mon, 30 Aug 2021 11:24:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm11581572qkm.56.2021.08.30.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:24:47 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol/cil: Refactor the function __cil_build_ast_node_helper()
Date:   Mon, 30 Aug 2021 14:24:41 -0400
Message-Id: <20210830182442.491886-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830182442.491886-1-jwcart2@gmail.com>
References: <20210830182442.491886-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Refactor the function __cil_build_ast_node_helper() by moving the
check for illegal statements and the large if-then-else statement
to determine which function to call to parse the policy statements
to different functions.

There is no need to keep walking the nodes of a policy statement
that has already been completely parsed. This means that the
remaining nodes of any policy statement that does not contain a list
of policy statements can be skipped. This was done inconsistently
before. The following policy statements now have all nodes after
the first one skipped: blockinherit, blockabstract, classcommon,
user, userattribute, userbounds, userprefix, type, typeattribute,
typealias, typealiasactual, typebounds, typepermissive, role,
userrole, roletype, roletransition, roleallow, roleattribute,
rolebounds, bool, tunable, typetransition, typechange, typemember,
sensitivity, sensitivityalias, senistivityaliasactual, category,
categoryalias, categoryaliasactual, and ipaddr. The only policy
statements that do contain a list of policy statements are:
block, in, tunableif, booleanif, true (conditional block), false
(conditional block), macro, optional, and src_info.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 416 ++++++++++++++-----------------
 1 file changed, 184 insertions(+), 232 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index a5afc267..521c3012 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6108,77 +6108,47 @@ void cil_destroy_src_info(struct cil_src_info *info)
 	free(info);
 }
 
-int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *finished, void *extra_args)
+static int check_for_illegal_statement(struct cil_tree_node *parse_current, struct cil_args_build *args)
 {
-	struct cil_args_build *args = extra_args;
-	struct cil_db *db = args->db;
-	struct cil_tree_node *ast_current = args->ast;
-	struct cil_tree_node *tunif = args->tunif;
-	struct cil_tree_node *in = args->in;
-	struct cil_tree_node *macro = args->macro;
-	struct cil_tree_node *optional = args->optional;
-	struct cil_tree_node *boolif = args->boolif;
-	struct cil_tree_node *ast_node = NULL;
-	int rc = SEPOL_ERR;
-
-	if (parse_current->parent->cl_head != parse_current) {
-		/* ignore anything that isn't following a parenthesis */
-		rc = SEPOL_OK;
-		goto exit;
-	} else if (parse_current->data == NULL) {
-		/* the only time parenthesis can immediately following parenthesis is if
-		 * the parent is the root node */
-		if (parse_current->parent->parent == NULL) {
-			rc = SEPOL_OK;
-		} else {
-			cil_tree_log(parse_current, CIL_ERR, "Keyword expected after open parenthesis");
-		}
-		goto exit;
-	}
-
-	if (tunif != NULL) {
+	if (args->tunif != NULL) {
 		if (parse_current->data == CIL_KEY_TUNABLE) {
-			rc = SEPOL_ERR;
 			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in tunableif", (char *)parse_current->data);
-			goto exit;
+			return SEPOL_ERR;
 		}
 	}
 
-	if (in != NULL) {
+	if (args->in != NULL) {
 		if (parse_current->data == CIL_KEY_TUNABLE ||
 			parse_current->data == CIL_KEY_IN) {
-			rc = SEPOL_ERR;
 			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in in-statement", (char *)parse_current->data);
-			goto exit;
+			return SEPOL_ERR;
 		}
 	}
 
-	if (macro != NULL) {
+	if (args->macro != NULL) {
 		if (parse_current->data == CIL_KEY_TUNABLE ||
 			parse_current->data == CIL_KEY_IN ||
 			parse_current->data == CIL_KEY_BLOCK ||
 			parse_current->data == CIL_KEY_BLOCKINHERIT ||
 			parse_current->data == CIL_KEY_BLOCKABSTRACT ||
 			parse_current->data == CIL_KEY_MACRO) {
-			rc = SEPOL_ERR;
 			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in macro", (char *)parse_current->data);
-			goto exit;
+			return SEPOL_ERR;
 		}
 	}
 
-	if (optional != NULL) {
+	if (args->optional != NULL) {
 		if (parse_current->data == CIL_KEY_TUNABLE ||
 			parse_current->data == CIL_KEY_IN ||
 			parse_current->data == CIL_KEY_BLOCK ||
 			parse_current->data == CIL_KEY_BLOCKABSTRACT ||
 			parse_current->data == CIL_KEY_MACRO) {
-			rc = SEPOL_ERR;
 			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in optional", (char *)parse_current->data);
-			goto exit;
+			return SEPOL_ERR;
 		}
 	}
 
-	if (boolif != NULL) {
+	if (args->boolif != NULL) {
 		if (parse_current->data != CIL_KEY_TUNABLEIF &&
 			parse_current->data != CIL_KEY_CALL &&
 			parse_current->data != CIL_KEY_CONDTRUE &&
@@ -6189,338 +6159,320 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 			parse_current->data != CIL_KEY_TYPETRANSITION &&
 			parse_current->data != CIL_KEY_TYPECHANGE &&
 			parse_current->data != CIL_KEY_TYPEMEMBER) {
-			rc = SEPOL_ERR;
-			if (((struct cil_booleanif*)boolif->data)->preserved_tunable) {
+			if (((struct cil_booleanif*)args->boolif->data)->preserved_tunable) {
 				cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in tunableif being treated as a booleanif", (char *)parse_current->data);
 			} else {
 				cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in booleanif", (char *)parse_current->data);
 			}
-			goto exit;
+			return SEPOL_ERR;
 		}
 	}
 
-	cil_tree_node_init(&ast_node);
+	return SEPOL_OK;
+}
 
-	ast_node->parent = ast_current;
-	ast_node->line = parse_current->line;
-	ast_node->hll_offset = parse_current->hll_offset;
+static struct cil_tree_node * parse_statement(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_parent)
+{
+	struct cil_tree_node *new_ast_node = NULL;
+	int rc = SEPOL_ERR;
+
+	cil_tree_node_init(&new_ast_node);
+	new_ast_node->parent = ast_parent;
+	new_ast_node->line = parse_current->line;
+	new_ast_node->hll_offset = parse_current->hll_offset;
 
 	if (parse_current->data == CIL_KEY_BLOCK) {
-		rc = cil_gen_block(db, parse_current, ast_node, 0);
+		rc = cil_gen_block(db, parse_current, new_ast_node, 0);
 	} else if (parse_current->data == CIL_KEY_BLOCKINHERIT) {
-		rc = cil_gen_blockinherit(db, parse_current, ast_node);
+		rc = cil_gen_blockinherit(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_BLOCKABSTRACT) {
-		rc = cil_gen_blockabstract(db, parse_current, ast_node);
+		rc = cil_gen_blockabstract(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_IN) {
-		rc = cil_gen_in(db, parse_current, ast_node);
+		rc = cil_gen_in(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CLASS) {
-		rc = cil_gen_class(db, parse_current, ast_node);
-		// To avoid parsing list of perms again
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_class(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CLASSORDER) {
-		rc = cil_gen_classorder(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_classorder(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_MAP_CLASS) {
-		rc = cil_gen_map_class(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_map_class(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CLASSMAPPING) {
-		rc = cil_gen_classmapping(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_classmapping(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CLASSPERMISSION) {
-		rc = cil_gen_classpermission(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_classpermission(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CLASSPERMISSIONSET) {
-		rc = cil_gen_classpermissionset(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_classpermissionset(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_COMMON) {
-		rc = cil_gen_common(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_common(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CLASSCOMMON) {
-		rc = cil_gen_classcommon(db, parse_current, ast_node);
+		rc = cil_gen_classcommon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SID) {
-		rc = cil_gen_sid(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_sid(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SIDCONTEXT) {
-		rc = cil_gen_sidcontext(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_sidcontext(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SIDORDER) {
-		rc = cil_gen_sidorder(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_sidorder(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_USER) {
-		rc = cil_gen_user(db, parse_current, ast_node);
+		rc = cil_gen_user(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_USERATTRIBUTE) {
-		rc = cil_gen_userattribute(db, parse_current, ast_node);
+		rc = cil_gen_userattribute(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_USERATTRIBUTESET) {
-		rc = cil_gen_userattributeset(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_userattributeset(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_USERLEVEL) {
-		rc = cil_gen_userlevel(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_userlevel(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_USERRANGE) {
-		rc = cil_gen_userrange(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_userrange(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_USERBOUNDS) {
-		rc = cil_gen_bounds(db, parse_current, ast_node, CIL_USER);
+		rc = cil_gen_bounds(db, parse_current, new_ast_node, CIL_USER);
 	} else if (parse_current->data == CIL_KEY_USERPREFIX) {
-		rc = cil_gen_userprefix(db, parse_current, ast_node);
+		rc = cil_gen_userprefix(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SELINUXUSER) {
-		rc = cil_gen_selinuxuser(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_selinuxuser(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SELINUXUSERDEFAULT) {
-		rc = cil_gen_selinuxuserdefault(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_selinuxuserdefault(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_TYPE) {
-		rc = cil_gen_type(db, parse_current, ast_node);
+		rc = cil_gen_type(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_TYPEATTRIBUTE) {
-		rc = cil_gen_typeattribute(db, parse_current, ast_node);
+		rc = cil_gen_typeattribute(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_TYPEATTRIBUTESET) {
-		rc = cil_gen_typeattributeset(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_typeattributeset(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_EXPANDTYPEATTRIBUTE) {
-		rc = cil_gen_expandtypeattribute(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_expandtypeattribute(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_TYPEALIAS) {
-		rc = cil_gen_alias(db, parse_current, ast_node, CIL_TYPEALIAS);
+		rc = cil_gen_alias(db, parse_current, new_ast_node, CIL_TYPEALIAS);
 	} else if (parse_current->data == CIL_KEY_TYPEALIASACTUAL) {
-		rc = cil_gen_aliasactual(db, parse_current, ast_node, CIL_TYPEALIASACTUAL);
+		rc = cil_gen_aliasactual(db, parse_current, new_ast_node, CIL_TYPEALIASACTUAL);
 	} else if (parse_current->data == CIL_KEY_TYPEBOUNDS) {
-		rc = cil_gen_bounds(db, parse_current, ast_node, CIL_TYPE);
+		rc = cil_gen_bounds(db, parse_current, new_ast_node, CIL_TYPE);
 	} else if (parse_current->data == CIL_KEY_TYPEPERMISSIVE) {
-		rc = cil_gen_typepermissive(db, parse_current, ast_node);
+		rc = cil_gen_typepermissive(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_RANGETRANSITION) {
-		rc = cil_gen_rangetransition(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_rangetransition(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_ROLE) {
-		rc = cil_gen_role(db, parse_current, ast_node);
+		rc = cil_gen_role(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_USERROLE) {
-		rc = cil_gen_userrole(db, parse_current, ast_node);
+		rc = cil_gen_userrole(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_ROLETYPE) {
-		rc = cil_gen_roletype(db, parse_current, ast_node);
+		rc = cil_gen_roletype(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_ROLETRANSITION) {
-		rc = cil_gen_roletransition(parse_current, ast_node);
+		rc = cil_gen_roletransition(parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_ROLEALLOW) {
-		rc = cil_gen_roleallow(db, parse_current, ast_node);
+		rc = cil_gen_roleallow(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_ROLEATTRIBUTE) {
-		rc = cil_gen_roleattribute(db, parse_current, ast_node);
+		rc = cil_gen_roleattribute(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_ROLEATTRIBUTESET) {
-		rc = cil_gen_roleattributeset(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_roleattributeset(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_ROLEBOUNDS) {
-		rc = cil_gen_bounds(db, parse_current, ast_node, CIL_ROLE);
+		rc = cil_gen_bounds(db, parse_current, new_ast_node, CIL_ROLE);
 	} else if (parse_current->data == CIL_KEY_BOOL) {
-		rc = cil_gen_bool(db, parse_current, ast_node, CIL_FALSE);
+		rc = cil_gen_bool(db, parse_current, new_ast_node, CIL_FALSE);
 	} else if (parse_current->data == CIL_KEY_BOOLEANIF) {
-		rc = cil_gen_boolif(db, parse_current, ast_node, CIL_FALSE);
+		rc = cil_gen_boolif(db, parse_current, new_ast_node, CIL_FALSE);
 	} else if(parse_current->data == CIL_KEY_TUNABLE) {
 		if (db->preserve_tunables) {
-			rc = cil_gen_bool(db, parse_current, ast_node, CIL_TRUE);
+			rc = cil_gen_bool(db, parse_current, new_ast_node, CIL_TRUE);
 		} else {
-			rc = cil_gen_tunable(db, parse_current, ast_node);
+			rc = cil_gen_tunable(db, parse_current, new_ast_node);
 		}
 	} else if (parse_current->data == CIL_KEY_TUNABLEIF) {
 		if (db->preserve_tunables) {
-			rc = cil_gen_boolif(db, parse_current, ast_node, CIL_TRUE);
+			rc = cil_gen_boolif(db, parse_current, new_ast_node, CIL_TRUE);
 		} else {
-			rc = cil_gen_tunif(db, parse_current, ast_node);
+			rc = cil_gen_tunif(db, parse_current, new_ast_node);
 		}
 	} else if (parse_current->data == CIL_KEY_CONDTRUE) {
-		rc = cil_gen_condblock(db, parse_current, ast_node, CIL_CONDTRUE);
+		rc = cil_gen_condblock(db, parse_current, new_ast_node, CIL_CONDTRUE);
 	} else if (parse_current->data == CIL_KEY_CONDFALSE) {
-		rc = cil_gen_condblock(db, parse_current, ast_node, CIL_CONDFALSE);
+		rc = cil_gen_condblock(db, parse_current, new_ast_node, CIL_CONDFALSE);
 	} else if (parse_current->data == CIL_KEY_ALLOW) {
-		rc = cil_gen_avrule(parse_current, ast_node, CIL_AVRULE_ALLOWED);
-		// So that the object and perms lists do not get parsed again
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_avrule(parse_current, new_ast_node, CIL_AVRULE_ALLOWED);
 	} else if (parse_current->data == CIL_KEY_AUDITALLOW) {
-		rc = cil_gen_avrule(parse_current, ast_node, CIL_AVRULE_AUDITALLOW);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_avrule(parse_current, new_ast_node, CIL_AVRULE_AUDITALLOW);
 	} else if (parse_current->data == CIL_KEY_DONTAUDIT) {
-		rc = cil_gen_avrule(parse_current, ast_node, CIL_AVRULE_DONTAUDIT);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_avrule(parse_current, new_ast_node, CIL_AVRULE_DONTAUDIT);
 	} else if (parse_current->data == CIL_KEY_NEVERALLOW) {
-		rc = cil_gen_avrule(parse_current, ast_node, CIL_AVRULE_NEVERALLOW);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_avrule(parse_current, new_ast_node, CIL_AVRULE_NEVERALLOW);
 	} else if (parse_current->data == CIL_KEY_ALLOWX) {
-		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_ALLOWED);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_avrulex(parse_current, new_ast_node, CIL_AVRULE_ALLOWED);
 	} else if (parse_current->data == CIL_KEY_AUDITALLOWX) {
-		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_AUDITALLOW);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_avrulex(parse_current, new_ast_node, CIL_AVRULE_AUDITALLOW);
 	} else if (parse_current->data == CIL_KEY_DONTAUDITX) {
-		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_DONTAUDIT);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_avrulex(parse_current, new_ast_node, CIL_AVRULE_DONTAUDIT);
 	} else if (parse_current->data == CIL_KEY_NEVERALLOWX) {
-		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_NEVERALLOW);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_avrulex(parse_current, new_ast_node, CIL_AVRULE_NEVERALLOW);
 	} else if (parse_current->data == CIL_KEY_PERMISSIONX) {
-		rc = cil_gen_permissionx(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_permissionx(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_TYPETRANSITION) {
-		rc = cil_gen_typetransition(db, parse_current, ast_node);
+		rc = cil_gen_typetransition(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_TYPECHANGE) {
-		rc = cil_gen_type_rule(parse_current, ast_node, CIL_TYPE_CHANGE);
+		rc = cil_gen_type_rule(parse_current, new_ast_node, CIL_TYPE_CHANGE);
 	} else if (parse_current->data == CIL_KEY_TYPEMEMBER) {
-		rc = cil_gen_type_rule(parse_current, ast_node, CIL_TYPE_MEMBER);
+		rc = cil_gen_type_rule(parse_current, new_ast_node, CIL_TYPE_MEMBER);
 	} else if (parse_current->data == CIL_KEY_SENSITIVITY) {
-		rc = cil_gen_sensitivity(db, parse_current, ast_node);
+		rc = cil_gen_sensitivity(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SENSALIAS) {
-		rc = cil_gen_alias(db, parse_current, ast_node, CIL_SENSALIAS);
+		rc = cil_gen_alias(db, parse_current, new_ast_node, CIL_SENSALIAS);
 	} else if (parse_current->data == CIL_KEY_SENSALIASACTUAL) {
-		rc = cil_gen_aliasactual(db, parse_current, ast_node, CIL_SENSALIASACTUAL);
+		rc = cil_gen_aliasactual(db, parse_current, new_ast_node, CIL_SENSALIASACTUAL);
 	} else if (parse_current->data == CIL_KEY_CATEGORY) {
-		rc = cil_gen_category(db, parse_current, ast_node);
+		rc = cil_gen_category(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CATALIAS) {
-		rc = cil_gen_alias(db, parse_current, ast_node, CIL_CATALIAS);
+		rc = cil_gen_alias(db, parse_current, new_ast_node, CIL_CATALIAS);
 	} else if (parse_current->data == CIL_KEY_CATALIASACTUAL) {
-		rc = cil_gen_aliasactual(db, parse_current, ast_node, CIL_CATALIASACTUAL);
+		rc = cil_gen_aliasactual(db, parse_current, new_ast_node, CIL_CATALIASACTUAL);
 	} else if (parse_current->data == CIL_KEY_CATSET) {
-		rc = cil_gen_catset(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_catset(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CATORDER) {
-		rc = cil_gen_catorder(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_catorder(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SENSITIVITYORDER) {
-		rc = cil_gen_sensitivityorder(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_sensitivityorder(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SENSCAT) {
-		rc = cil_gen_senscat(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_senscat(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_LEVEL) {
-		rc = cil_gen_level(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_level(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_LEVELRANGE) {
-		rc = cil_gen_levelrange(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_levelrange(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CONSTRAIN) {
-		rc = cil_gen_constrain(db, parse_current, ast_node, CIL_CONSTRAIN);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_constrain(db, parse_current, new_ast_node, CIL_CONSTRAIN);
 	} else if (parse_current->data == CIL_KEY_MLSCONSTRAIN) {
-		rc = cil_gen_constrain(db, parse_current, ast_node, CIL_MLSCONSTRAIN);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_constrain(db, parse_current, new_ast_node, CIL_MLSCONSTRAIN);
 	} else if (parse_current->data == CIL_KEY_VALIDATETRANS) {
-		rc = cil_gen_validatetrans(db, parse_current, ast_node, CIL_VALIDATETRANS);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_validatetrans(db, parse_current, new_ast_node, CIL_VALIDATETRANS);
 	} else if (parse_current->data == CIL_KEY_MLSVALIDATETRANS) {
-		rc = cil_gen_validatetrans(db, parse_current, ast_node, CIL_MLSVALIDATETRANS);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_validatetrans(db, parse_current, new_ast_node, CIL_MLSVALIDATETRANS);
 	} else if (parse_current->data == CIL_KEY_CONTEXT) {
-		rc = cil_gen_context(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_context(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_FILECON) {
-		rc = cil_gen_filecon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_filecon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_IBPKEYCON) {
-		rc = cil_gen_ibpkeycon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_ibpkeycon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_IBENDPORTCON) {
-		rc = cil_gen_ibendportcon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_ibendportcon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_PORTCON) {
-		rc = cil_gen_portcon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_portcon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_NODECON) {
-		rc = cil_gen_nodecon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_nodecon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_GENFSCON) {
-		rc = cil_gen_genfscon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_genfscon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_NETIFCON) {
-		rc = cil_gen_netifcon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_netifcon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_PIRQCON) {
-		rc = cil_gen_pirqcon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_pirqcon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_IOMEMCON) {
-		rc = cil_gen_iomemcon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_iomemcon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_IOPORTCON) {
-		rc = cil_gen_ioportcon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_ioportcon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_PCIDEVICECON) {
-		rc = cil_gen_pcidevicecon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_pcidevicecon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_DEVICETREECON) {
-		rc = cil_gen_devicetreecon(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_devicetreecon(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_FSUSE) {
-		rc = cil_gen_fsuse(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_fsuse(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_MACRO) {
-		rc = cil_gen_macro(db, parse_current, ast_node);
+		rc = cil_gen_macro(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CALL) {
-		rc = cil_gen_call(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_call(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_POLICYCAP) {
-		rc = cil_gen_policycap(db, parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_policycap(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_OPTIONAL) {
-		rc = cil_gen_optional(db, parse_current, ast_node);
+		rc = cil_gen_optional(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_IPADDR) {
-		rc = cil_gen_ipaddr(db, parse_current, ast_node);
+		rc = cil_gen_ipaddr(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_DEFAULTUSER) {
-		rc = cil_gen_default(parse_current, ast_node, CIL_DEFAULTUSER);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_default(parse_current, new_ast_node, CIL_DEFAULTUSER);
 	} else if (parse_current->data == CIL_KEY_DEFAULTROLE) {
-		rc = cil_gen_default(parse_current, ast_node, CIL_DEFAULTROLE);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_default(parse_current, new_ast_node, CIL_DEFAULTROLE);
 	} else if (parse_current->data == CIL_KEY_DEFAULTTYPE) {
-		rc = cil_gen_default(parse_current, ast_node, CIL_DEFAULTTYPE);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_default(parse_current, new_ast_node, CIL_DEFAULTTYPE);
 	} else if (parse_current->data == CIL_KEY_DEFAULTRANGE) {
-		rc = cil_gen_defaultrange(parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_defaultrange(parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_HANDLEUNKNOWN) {
-		rc = cil_gen_handleunknown(parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_handleunknown(parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_MLS) {
-		rc = cil_gen_mls(parse_current, ast_node);
-		*finished = CIL_TREE_SKIP_NEXT;
+		rc = cil_gen_mls(parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SRC_INFO) {
-		rc = cil_gen_src_info(parse_current, ast_node);
+		rc = cil_gen_src_info(parse_current, new_ast_node);
 	} else {
 		cil_log(CIL_ERR, "Error: Unknown keyword %s\n", (char *)parse_current->data);
 		rc = SEPOL_ERR;
 	}
 
 	if (rc == SEPOL_OK) {
-		if (ast_current->cl_head == NULL) {
-			ast_current->cl_head = ast_node;
+		if (ast_parent->cl_head == NULL) {
+			ast_parent->cl_head = new_ast_node;
 		} else {
-			ast_current->cl_tail->next = ast_node;
+			ast_parent->cl_tail->next = new_ast_node;
 		}
-		ast_current->cl_tail = ast_node;
-		ast_current = ast_node;
-		args->ast = ast_current;
+		ast_parent->cl_tail = new_ast_node;
 	} else {
-		cil_tree_node_destroy(&ast_node);
+		cil_tree_node_destroy(&new_ast_node);
+		new_ast_node = NULL;
 	}
 
-exit:
-	return rc;
+	return new_ast_node;
 }
 
-int __cil_build_ast_first_child_helper(__attribute__((unused)) struct cil_tree_node *parse_current, void *extra_args)
+int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *finished, void *extra_args)
 {
 	struct cil_args_build *args = extra_args;
-	struct cil_tree_node *ast = args->ast;
+	struct cil_tree_node *new_ast_node = NULL;
+	int rc = SEPOL_ERR;
 
-	if (ast->flavor == CIL_TUNABLEIF) {
-		args->tunif = ast;
+	if (parse_current->parent->cl_head != parse_current) {
+		/* ignore anything that isn't following a parenthesis */
+		return SEPOL_OK;
+	} else if (parse_current->data == NULL) {
+		/* the only time parenthesis can immediately following parenthesis is if
+		 * the parent is the root node */
+		if (parse_current->parent->parent == NULL) {
+			return SEPOL_OK;
+		} else {
+			cil_tree_log(parse_current, CIL_ERR, "Keyword expected after open parenthesis");
+			return SEPOL_ERR;
+		}
 	}
 
-	if (ast->flavor == CIL_IN) {
-		args->in = ast;
+	rc = check_for_illegal_statement(parse_current, args);
+	if (rc != SEPOL_OK) {
+		return SEPOL_ERR;
 	}
 
-	if (ast->flavor == CIL_MACRO) {
-		args->macro = ast;
+	new_ast_node = parse_statement(args->db, parse_current, args->ast);
+	if (!new_ast_node) {
+		return SEPOL_ERR;
 	}
 
-	if (ast->flavor == CIL_OPTIONAL) {
-		args->optional = ast;
+	args->ast = new_ast_node;
+
+	if (parse_current->data != CIL_KEY_BLOCK &&
+		parse_current->data != CIL_KEY_IN &&
+		parse_current->data != CIL_KEY_TUNABLEIF &&
+		parse_current->data != CIL_KEY_BOOLEANIF &&
+		parse_current->data != CIL_KEY_CONDTRUE &&
+		parse_current->data != CIL_KEY_CONDFALSE &&
+		parse_current->data != CIL_KEY_MACRO &&
+		parse_current->data != CIL_KEY_OPTIONAL &&
+		parse_current->data != CIL_KEY_SRC_INFO) {
+		/* Skip anything that does not contain a list of policy statements */
+		*finished = CIL_TREE_SKIP_NEXT;
 	}
 
-	if (ast->flavor == CIL_BOOLEANIF) {
+	return SEPOL_OK;
+}
+
+int __cil_build_ast_first_child_helper(__attribute__((unused)) struct cil_tree_node *parse_current, void *extra_args)
+{
+	struct cil_args_build *args = extra_args;
+	struct cil_tree_node *ast = args->ast;
+
+	if (ast->flavor == CIL_TUNABLEIF) {
+		args->tunif = ast;
+	} else if (ast->flavor == CIL_IN) {
+		args->in = ast;
+	} else if (ast->flavor == CIL_MACRO) {
+		args->macro = ast;
+	} else if (ast->flavor == CIL_OPTIONAL) {
+		args->optional = ast;
+	} else if (ast->flavor == CIL_BOOLEANIF) {
 		args->boolif = ast;
 	}
 
-- 
2.31.1

