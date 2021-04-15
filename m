Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5183CC433B4
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B1761131
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhDOUeP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbhDOUeL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Apr 2021 16:34:11 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34091C061574
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:33:46 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y12so19244778qtx.11
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vAuFveXG4ITLr/rChaPh8rxhdJulH7t5uJmq7Ewn2M=;
        b=OPDwMw48XfW4S7epTtgtaHuSLw41NEh+6bUFRTYBh1hxUsOdwJ72pjIAgF9BYK8nLO
         tnjdB8DnRjwuFri/U21PibkejOchJI41TgwXaqx+ZBQFNzl16zYQ1YUDZCQJVGlW1dMp
         Pl3uhy3ArL8l1ZziLeR3JPvPg4P+3vB3HN9yFbBia4n1KgwJykZAd9sNyd0mUgyLaldI
         mwegKcd6cokfAxOTTAT1mLDh/gFL0uOXWMB0GdfH3pJK7fpwBtl55VTAmTchCSQFInSF
         rBjdC3K9YeNjJys2iTtfV9aPMAqMHjLcKO1icb1uKQ3OVWoHpSZerlnHFEKklX9s9twR
         Qq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vAuFveXG4ITLr/rChaPh8rxhdJulH7t5uJmq7Ewn2M=;
        b=FCbDRc9TERR1FujVQ1f6lZYTAFq3zZ/zchzrfUWyRdXMtpjOmgYg07au7cn+1ox4t9
         ant2Att7nLvrb9xPeUlUsfdaX0+1lUJMgyX11Vdzfu2lyGvQJ+1ERdlvpqn2YbMU4OM8
         hz9vlu/V14XjJQ9eqEtKlM/rcPPByY2fJuV3pL/4sfxUpFJE2E2DHXN1y2c3orArP+DL
         fuULrygx7qhxRv2qxZXH2K4+Le7BlRCbtK9zbOufyO3QsrwEb3FS6UQ4rJLXHfDjIpTH
         KwEEX2m3zfvRAgShV7Ow70o+h1fPTqfxglf+OdQW5+d3JE4Gt4jllSDLdj5SXhFou5MN
         l5FQ==
X-Gm-Message-State: AOAM532ARTTEkPqJs5lpgyUCoHlRd24KCcXUXqC7ejaqTg2Aaz1JePwi
        csMdTbGOlOKp4YSPPwQUyAYxTxK7/xWEKg==
X-Google-Smtp-Source: ABdhPJw2+/yIJ44EPDX3SzqmUT4T8tOCYAB/Ms1SIqttkxZtPcW+qDWt6lfmieptzbEUKSc7qhy2Cg==
X-Received: by 2002:ac8:4d92:: with SMTP id a18mr4833579qtw.312.1618518823873;
        Thu, 15 Apr 2021 13:33:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c27sm2763469qko.71.2021.04.15.13.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:33:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol/cil: Create functions to write the CIL AST
Date:   Thu, 15 Apr 2021 16:33:30 -0400
Message-Id: <20210415203332.191302-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210415203332.191302-1-jwcart2@gmail.com>
References: <20210415203332.191302-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function cil_print_tree() has existed in cil_tree.c since the
beginning of the development of CIL and secilc. Unfortunately, it
used cil_log() at log level CIL_INFO to print out the AST and
has suffered greatly from bit rot.

Move the functions to write the CIL AST to cil_write_ast.c, update
the functions, and write the AST to the FILE pointer passed in as
an argument.

The function cil_write_ast() supports writing the CIL AST at three
different phases of the compiling a CIL policy. After parsing has
been done and the parse tree has been created, after the CIL AST
has been built, and after the CIL AST has been resolved.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_tree.c      | 1471 ----------------------------
 libsepol/cil/src/cil_tree.h      |    2 -
 libsepol/cil/src/cil_write_ast.c | 1573 ++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_write_ast.h |   47 +
 4 files changed, 1620 insertions(+), 1473 deletions(-)
 create mode 100644 libsepol/cil/src/cil_write_ast.c
 create mode 100644 libsepol/cil/src/cil_write_ast.h

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 3da972e9..067268eb 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -41,15 +41,6 @@
 #include "cil_parser.h"
 #include "cil_strpool.h"
 
-void cil_tree_print_perms_list(struct cil_tree_node *current_perm);
-void cil_tree_print_classperms(struct cil_classperms *cp);
-void cil_tree_print_level(struct cil_level *level);
-void cil_tree_print_levelrange(struct cil_levelrange *lvlrange);
-void cil_tree_print_context(struct cil_context *context);
-void cil_tree_print_expr_tree(struct cil_tree_node *expr_root);
-void cil_tree_print_constrain(struct cil_constrain *cons);
-void cil_tree_print_node(struct cil_tree_node *node);
-
 __attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void cil_tree_error(const char* msg, ...)
 {
 	va_list ap;
@@ -328,1465 +319,3 @@ int cil_tree_walk(struct cil_tree_node *node,
 
 	return SEPOL_OK;
 }
-
-
-/* Copied from cil_policy.c, but changed to prefix -- Need to refactor */
-static int cil_expr_to_string(struct cil_list *expr, char **out)
-{
-	int rc = SEPOL_ERR;
-	struct cil_list_item *curr;
-	char *stack[COND_EXPR_MAXDEPTH] = {};
-	int pos = 0;
-
-	cil_list_for_each(curr, expr) {
-		if (pos >= COND_EXPR_MAXDEPTH) {
-			rc = SEPOL_ERR;
-			goto exit;
-		}
-		switch (curr->flavor) {
-		case CIL_LIST:
-			rc = cil_expr_to_string(curr->data, &stack[pos]);
-			if (rc != SEPOL_OK) {
-				goto exit;
-			}
-			pos++;
-			break;
-		case CIL_STRING:
-			stack[pos] = curr->data;
-			pos++;
-			break;
-		case CIL_DATUM:
-			stack[pos] = ((struct cil_symtab_datum *)curr->data)->name;
-			pos++;
-			break;
-		case CIL_OP: {
-			int len;
-			char *expr_str;
-			enum cil_flavor op_flavor = *((enum cil_flavor *)curr->data);
-			char *op_str = NULL;
-
-			if (pos == 0) {
-				rc = SEPOL_ERR;
-				goto exit;
-			}
-			switch (op_flavor) {
-			case CIL_AND:
-				op_str = CIL_KEY_AND;
-				break;
-			case CIL_OR:
-				op_str = CIL_KEY_OR;
-				break;
-			case CIL_NOT:
-				op_str = CIL_KEY_NOT;
-				break;
-			case CIL_ALL:
-				op_str = CIL_KEY_ALL;
-				break;
-			case CIL_EQ:
-				op_str = CIL_KEY_EQ;
-				break;
-			case CIL_NEQ:
-				op_str = CIL_KEY_NEQ;
-				break;
-			case CIL_XOR:
-				op_str = CIL_KEY_XOR;
-				break;
-			case CIL_RANGE:
-				op_str = CIL_KEY_RANGE;
-				break;
-			case CIL_CONS_DOM:
-				op_str = CIL_KEY_CONS_DOM;
-				break;
-			case CIL_CONS_DOMBY:
-				op_str = CIL_KEY_CONS_DOMBY;
-				break;
-			case CIL_CONS_INCOMP:
-				op_str = CIL_KEY_CONS_INCOMP;
-				break;
-			default:
-				cil_log(CIL_ERR, "Unknown operator in expression\n");
-				goto exit;
-				break;
-			}
-			if (op_flavor == CIL_NOT) {
-				len = strlen(stack[pos-1]) + strlen(op_str) + 4;
-				expr_str = cil_malloc(len);
-				snprintf(expr_str, len, "(%s %s)", op_str, stack[pos-1]);
-				free(stack[pos-1]);
-				stack[pos-1] = NULL;
-				pos--;
-			} else {
-				if (pos < 2) {
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				len = strlen(stack[pos-1]) + strlen(stack[pos-2]) + strlen(op_str) + 5;
-				expr_str = cil_malloc(len);
-				snprintf(expr_str, len, "(%s %s %s)", op_str, stack[pos-1], stack[pos-2]);
-				free(stack[pos-2]);
-				free(stack[pos-1]);
-				stack[pos-2] = NULL;
-				stack[pos-1] = NULL;
-				pos -= 2;
-			}
-			stack[pos] = expr_str;
-			pos++;
-			break;
-		}
-		case CIL_CONS_OPERAND: {
-			enum cil_flavor operand_flavor = *((enum cil_flavor *)curr->data);
-			char *operand_str = NULL;
-			switch (operand_flavor) {
-			case CIL_CONS_U1:
-				operand_str = CIL_KEY_CONS_U1;
-				break;
-			case CIL_CONS_U2:
-				operand_str = CIL_KEY_CONS_U2;
-				break;
-			case CIL_CONS_U3:
-				operand_str = CIL_KEY_CONS_U3;
-				break;
-			case CIL_CONS_T1:
-				operand_str = CIL_KEY_CONS_T1;
-				break;
-			case CIL_CONS_T2:
-				operand_str = CIL_KEY_CONS_T2;
-				break;
-			case CIL_CONS_T3:
-				operand_str = CIL_KEY_CONS_T3;
-				break;
-			case CIL_CONS_R1:
-				operand_str = CIL_KEY_CONS_R1;
-				break;
-			case CIL_CONS_R2:
-				operand_str = CIL_KEY_CONS_R2;
-				break;
-			case CIL_CONS_R3:
-				operand_str = CIL_KEY_CONS_R3;
-				break;
-			case CIL_CONS_L1:
-				operand_str = CIL_KEY_CONS_L1;
-				break;
-			case CIL_CONS_L2:
-				operand_str = CIL_KEY_CONS_L2;
-				break;
-			case CIL_CONS_H1:
-				operand_str = CIL_KEY_CONS_H1;
-				break;
-			case CIL_CONS_H2:
-				operand_str = CIL_KEY_CONS_H2;
-				break;
-			default:
-				cil_log(CIL_ERR, "Unknown operand in expression\n");
-				goto exit;
-				break;
-			}
-			stack[pos] = operand_str;
-			pos++;
-			break;
-		}
-		default:
-			cil_log(CIL_ERR, "Unknown flavor in expression\n");
-			goto exit;
-			break;
-		}
-	}
-
-	*out = stack[0];
-
-	return SEPOL_OK;
-
-exit:
-	return rc;
-}
-
-void cil_tree_print_expr(struct cil_list *datum_expr, struct cil_list *str_expr)
-{
-	char *expr_str;
-	int rc;
-
-	cil_log(CIL_INFO, "(");
-
-	if (datum_expr != NULL) {
-		rc = cil_expr_to_string(datum_expr, &expr_str);
-	} else {
-		rc = cil_expr_to_string(str_expr, &expr_str);
-	}
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_INFO, "ERROR)");
-		return;
-	}
-	cil_log(CIL_INFO, "%s)", expr_str);
-	free(expr_str);
-}
-
-void cil_tree_print_perms_list(struct cil_tree_node *current_perm)
-{
-	while (current_perm != NULL) {
-		if (current_perm->flavor == CIL_PERM) {
-			cil_log(CIL_INFO, " %s", ((struct cil_perm *)current_perm->data)->datum.name);
-		} else if (current_perm->flavor == CIL_MAP_PERM) {
-			cil_log(CIL_INFO, " %s", ((struct cil_perm*)current_perm->data)->datum.name);
-		} else {
-			cil_log(CIL_INFO, "\n\n perms list contained unexpected data type: %d\n", current_perm->flavor);
-			break;
-		}
-		current_perm = current_perm->next;	
-	}
-}
-
-void cil_tree_print_cats(struct cil_cats *cats)
-{
-	cil_tree_print_expr(cats->datum_expr, cats->str_expr);
-}
-
-void cil_tree_print_perm_strs(struct cil_list *perm_strs)
-{
-	struct cil_list_item *curr;
-
-	if (perm_strs == NULL) {
-		return;
-	}
-
-	cil_log(CIL_INFO, " (");
-
-	cil_list_for_each(curr, perm_strs) {
-		cil_log(CIL_INFO, " %s", (char*)curr->data);
-	}
-
-	cil_log(CIL_INFO, " )");
-}
-
-
-void cil_tree_print_classperms(struct cil_classperms *cp)
-{
-	if (cp == NULL) {
-		return;
-	}
-
-	cil_log(CIL_INFO, " class: %s", cp->class_str);
-	cil_log(CIL_INFO, ", perm_strs:");
-	cil_tree_print_perm_strs(cp->perm_strs);
-}
-
-void cil_tree_print_classperms_set(struct cil_classperms_set *cp_set)
-{
-	if (cp_set == NULL) {
-		return;
-	}
-
-	cil_log(CIL_INFO, " %s", cp_set->set_str);
-}
-
-void cil_tree_print_classperms_list(struct cil_list *cp_list)
-{
-	struct cil_list_item *i;
-
-	if (cp_list == NULL) {
-		return;
-	}
-
-	cil_list_for_each(i, cp_list) {
-		if (i->flavor == CIL_CLASSPERMS) {
-			cil_tree_print_classperms(i->data);
-		} else {
-			cil_tree_print_classperms_set(i->data);
-		}
-	}
-}
-
-void cil_tree_print_level(struct cil_level *level)
-{
-	if (level->sens != NULL) {
-		cil_log(CIL_INFO, " %s", level->sens->datum.name);
-	} else if (level->sens_str != NULL) {
-		cil_log(CIL_INFO, " %s", level->sens_str);
-	}
-
-	cil_tree_print_cats(level->cats);
-
-	return;
-}
-
-void cil_tree_print_levelrange(struct cil_levelrange *lvlrange)
-{
-	cil_log(CIL_INFO, " (");
-	if (lvlrange->low != NULL) {
-		cil_log(CIL_INFO, " (");
-		cil_tree_print_level(lvlrange->low);
-		cil_log(CIL_INFO, " )");
-	} else if (lvlrange->low_str != NULL) {
-		cil_log(CIL_INFO, " %s", lvlrange->low_str);
-	}
-
-	if (lvlrange->high != NULL) {
-		cil_log(CIL_INFO, " (");
-		cil_tree_print_level(lvlrange->high);
-		cil_log(CIL_INFO, " )");
-	} else if (lvlrange->high_str != NULL) {
-		cil_log(CIL_INFO, " %s", lvlrange->high_str);
-	}
-	cil_log(CIL_INFO, " )");
-}
-
-void cil_tree_print_context(struct cil_context *context)
-{
-	cil_log(CIL_INFO, " (");
-	if (context->user != NULL) {
-		cil_log(CIL_INFO, " %s", context->user->datum.name);
-	} else if (context->user_str != NULL) {
-		cil_log(CIL_INFO, " %s", context->user_str);
-	}
-
-	if (context->role != NULL) {
-		cil_log(CIL_INFO, " %s", context->role->datum.name);
-	} else if (context->role_str != NULL) {
-		cil_log(CIL_INFO, " %s", context->role_str);
-	}
-
-	if (context->type != NULL) {
-		cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)context->type)->name);
-	} else if (context->type_str != NULL) {
-		cil_log(CIL_INFO, " %s", context->type_str);
-	}
-
-	if (context->range != NULL) {
-		cil_tree_print_levelrange(context->range);
-	} else if (context->range_str != NULL) {
-		cil_log(CIL_INFO, " %s", context->range_str);
-	}
-
-	cil_log(CIL_INFO, " )");
-
-	return;
-}
-
-void cil_tree_print_constrain(struct cil_constrain *cons)
-{
-	cil_tree_print_classperms_list(cons->classperms);
-
-	cil_tree_print_expr(cons->datum_expr, cons->str_expr);
-
-	cil_log(CIL_INFO, "\n");
-}
-
-void cil_tree_print_node(struct cil_tree_node *node)
-{
-	if (node->data == NULL) {
-		cil_log(CIL_INFO, "FLAVOR: %d", node->flavor);
-		return;
-	} else {
-		switch( node->flavor ) {
-		case CIL_BLOCK: {
-			struct cil_block *block = node->data;
-			cil_log(CIL_INFO, "BLOCK: %s\n", block->datum.name);
-			return;
-		}
-		case CIL_BLOCKINHERIT: {
-			struct cil_blockinherit *inherit = node->data;
-			cil_log(CIL_INFO, "BLOCKINHERIT: %s\n", inherit->block_str);
-			return;
-		}
-		case CIL_BLOCKABSTRACT: {
-			struct cil_blockabstract *abstract = node->data;
-			cil_log(CIL_INFO, "BLOCKABSTRACT: %s\n", abstract->block_str);
-			return;
-		}
-		case CIL_IN: {
-			struct cil_in *in = node->data;
-			cil_log(CIL_INFO, "IN: %s\n", in->block_str);
-			return;
-		}
-		case CIL_USER: {
-			struct cil_user *user = node->data;
-			cil_log(CIL_INFO, "USER: %s\n", user->datum.name);
-			return;
-		}
-		case CIL_TYPE: {
-			struct cil_type *type = node->data;
-			cil_log(CIL_INFO, "TYPE: %s\n", type->datum.name);
-			return;
-		}
-		case CIL_EXPANDTYPEATTRIBUTE: {
-			struct cil_expandtypeattribute *attr = node->data;
-
-			cil_log(CIL_INFO, "(EXPANDTYPEATTRIBUTE ");
-			cil_tree_print_expr(attr->attr_datums, attr->attr_strs);
-			cil_log(CIL_INFO, "%s)\n",attr->expand ?
-					CIL_KEY_CONDTRUE : CIL_KEY_CONDFALSE);
-
-			return;
-		}
-		case CIL_TYPEATTRIBUTESET: {
-			struct cil_typeattributeset *attr = node->data;
-
-			cil_log(CIL_INFO, "(TYPEATTRIBUTESET %s ", attr->attr_str);
-
-			cil_tree_print_expr(attr->datum_expr, attr->str_expr);
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_TYPEATTRIBUTE: {
-			struct cil_typeattribute *attr = node->data;
-			cil_log(CIL_INFO, "TYPEATTRIBUTE: %s\n", attr->datum.name);
-			return;
-		}
-		case CIL_ROLE: {
-			struct cil_role *role = node->data;
-			cil_log(CIL_INFO, "ROLE: %s\n", role->datum.name);
-			return;
-		}
-		case CIL_USERROLE: {
-			struct cil_userrole *userrole = node->data;
-			cil_log(CIL_INFO, "USERROLE:");
-			struct cil_symtab_datum *datum = NULL;
-
-			if (userrole->user != NULL) {
-				datum = userrole->user;
-				cil_log(CIL_INFO, " %s", datum->name);
-			} else if (userrole->user_str != NULL) {
-				cil_log(CIL_INFO, " %s", userrole->user_str);
-			}
-
-			if (userrole->role != NULL) {
-				datum = userrole->role;
-				cil_log(CIL_INFO, " %s", datum->name);
-			} else if (userrole->role_str != NULL) {
-				cil_log(CIL_INFO, " %s", userrole->role_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_USERLEVEL: {
-			struct cil_userlevel *usrlvl = node->data;
-			cil_log(CIL_INFO, "USERLEVEL:");
-
-			if (usrlvl->user_str != NULL) {
-				cil_log(CIL_INFO, " %s", usrlvl->user_str);
-			}
-
-			if (usrlvl->level != NULL) {
-				cil_log(CIL_INFO, " (");
-				cil_tree_print_level(usrlvl->level);
-				cil_log(CIL_INFO, " )");
-			} else if (usrlvl->level_str != NULL) {
-				cil_log(CIL_INFO, " %s", usrlvl->level_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_USERRANGE: {
-			struct cil_userrange *userrange = node->data;
-			cil_log(CIL_INFO, "USERRANGE:");
-
-			if (userrange->user_str != NULL) {
-				cil_log(CIL_INFO, " %s", userrange->user_str);
-			}
-
-			if (userrange->range != NULL) {
-				cil_log(CIL_INFO, " (");
-				cil_tree_print_levelrange(userrange->range);
-				cil_log(CIL_INFO, " )");
-			} else if (userrange->range_str != NULL) {
-				cil_log(CIL_INFO, " %s", userrange->range_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_USERBOUNDS: {
-			struct cil_bounds *bnds = node->data;
-			cil_log(CIL_INFO, "USERBOUNDS: user: %s, bounds: %s\n", bnds->parent_str, bnds->child_str);
-			return;
-		}
-		case CIL_ROLETYPE: {
-			struct cil_roletype *roletype = node->data;
-			struct cil_symtab_datum *datum = NULL;
-			cil_log(CIL_INFO, "ROLETYPE:");
-
-			if (roletype->role != NULL) {
-				datum = roletype->role;
-				cil_log(CIL_INFO, " %s", datum->name);
-			} else if (roletype->role_str != NULL) {
-				cil_log(CIL_INFO, " %s", roletype->role_str);
-			}
-
-			if (roletype->type != NULL) {
-				datum = roletype->type;
-				cil_log(CIL_INFO, " %s", datum->name);
-			} else if (roletype->type_str != NULL) {
-				cil_log(CIL_INFO, " %s", roletype->type_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_ROLETRANSITION: {
-			struct cil_roletransition *roletrans = node->data;
-			cil_log(CIL_INFO, "ROLETRANSITION:");
-
-			if (roletrans->src != NULL) {
-				cil_log(CIL_INFO, " %s", roletrans->src->datum.name);
-			} else {
-				cil_log(CIL_INFO, " %s", roletrans->src_str);
-			}
-
-			if (roletrans->tgt != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)roletrans->tgt)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", roletrans->tgt_str);
-			}
-				
-			if (roletrans->obj != NULL) {
-				cil_log(CIL_INFO, " %s", roletrans->obj->datum.name);
-			} else {
-				cil_log(CIL_INFO, " %s", roletrans->obj_str);
-			}
-
-			if (roletrans->result != NULL) {
-				cil_log(CIL_INFO, " %s\n", roletrans->result->datum.name);
-			} else {
-				cil_log(CIL_INFO, " %s\n", roletrans->result_str);
-			}
-
-			return;
-		}
-		case CIL_ROLEALLOW: {
-			struct cil_roleallow *roleallow = node->data;
-			cil_log(CIL_INFO, "ROLEALLOW:");
-
-			if (roleallow->src != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum*)roleallow->src)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", roleallow->src_str);
-			}
-
-			if (roleallow->tgt != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum*)roleallow->tgt)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", roleallow->tgt_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_ROLEATTRIBUTESET: {
-			struct cil_roleattributeset *attr = node->data;
-
-			cil_log(CIL_INFO, "(ROLEATTRIBUTESET %s ", attr->attr_str);
-
-			cil_tree_print_expr(attr->datum_expr, attr->str_expr);
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_ROLEATTRIBUTE: {
-			struct cil_roleattribute *attr = node->data;
-			cil_log(CIL_INFO, "ROLEATTRIBUTE: %s\n", attr->datum.name);
-			return;
-		}
-		case CIL_USERATTRIBUTESET: {
-			struct cil_userattributeset *attr = node->data;
-
-			cil_log(CIL_INFO, "(USERATTRIBUTESET %s ", attr->attr_str);
-
-			cil_tree_print_expr(attr->datum_expr, attr->str_expr);
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_USERATTRIBUTE: {
-			struct cil_userattribute *attr = node->data;
-			cil_log(CIL_INFO, "USERATTRIBUTE: %s\n", attr->datum.name);
-			return;
-		}
-		case CIL_ROLEBOUNDS: {
-			struct cil_bounds *bnds = node->data;
-			cil_log(CIL_INFO, "ROLEBOUNDS: role: %s, bounds: %s\n", bnds->parent_str, bnds->child_str);
-			return;
-		}
-		case CIL_CLASS: {
-			struct cil_class *cls = node->data;
-			cil_log(CIL_INFO, "CLASS: %s ", cls->datum.name);
-				
-			if (cls->common != NULL) {
-				cil_log(CIL_INFO, "inherits: %s ", cls->common->datum.name);
-			}
-			cil_log(CIL_INFO, "(");
-	
-			cil_tree_print_perms_list(node->cl_head);
-	
-			cil_log(CIL_INFO, " )");
-			return;
-		}
-		case CIL_CLASSORDER: {
-			struct cil_classorder *classorder = node->data;
-			struct cil_list_item *class;
-
-			if (classorder->class_list_str == NULL) {
-				cil_log(CIL_INFO, "CLASSORDER: ()\n");
-				return;
-			}
-
-			cil_log(CIL_INFO, "CLASSORDER: (");
-			cil_list_for_each(class, classorder->class_list_str) {
-				cil_log(CIL_INFO, " %s", (char*)class->data);
-			}
-			cil_log(CIL_INFO, " )\n");
-			return;
-		}
-		case CIL_COMMON: {
-			struct cil_class *common = node->data;
-			cil_log(CIL_INFO, "COMMON: %s (", common->datum.name);
-		
-			cil_tree_print_perms_list(node->cl_head);
-	
-			cil_log(CIL_INFO, " )");
-			return;
-		}
-		case CIL_CLASSCOMMON: {
-			struct cil_classcommon *clscom = node->data;
-
-			cil_log(CIL_INFO, "CLASSCOMMON: class: %s, common: %s\n", clscom->class_str, clscom->common_str);
-
-			return;
-		}
-		case CIL_CLASSPERMISSION: {
-			struct cil_classpermission *cp = node->data;
-
-			cil_log(CIL_INFO, "CLASSPERMISSION: %s", cp->datum.name);
-
-			cil_log(CIL_INFO, "\n");
-
-			return;
-		}
-		case CIL_CLASSPERMISSIONSET: {
-			struct cil_classpermissionset *cps = node->data;
-
-			cil_log(CIL_INFO, "CLASSPERMISSIONSET: %s", cps->set_str);
-
-			cil_tree_print_classperms_list(cps->classperms);
-
-			cil_log(CIL_INFO, "\n");
-
-			return;
-		}
-		case CIL_MAP_CLASS: {
-			struct cil_class *cm = node->data;
-			cil_log(CIL_INFO, "MAP_CLASS: %s", cm->datum.name);
-
-			cil_log(CIL_INFO, " (");
-			cil_tree_print_perms_list(node->cl_head);
-			cil_log(CIL_INFO, " )\n");
-
-			return;
-		}
-		case CIL_MAP_PERM: {
-			struct cil_perm *cmp = node->data;
-
-			cil_log(CIL_INFO, "MAP_PERM: %s", cmp->datum.name);
-
-			if (cmp->classperms == NULL) {
-				cil_log(CIL_INFO, " perms: ()");
-				return;
-			}
-
-			cil_log(CIL_INFO, " kernel class perms: (");
-
-			cil_tree_print_classperms_list(cmp->classperms);
-
-			cil_log(CIL_INFO, " )\n");
-
-			return;
-		}
-		case CIL_CLASSMAPPING: {
-			struct cil_classmapping *mapping = node->data;
-
-			cil_log(CIL_INFO, "CLASSMAPPING: map class: %s, map perm: %s,", mapping->map_class_str, mapping->map_perm_str);
-
-			cil_log(CIL_INFO, " (");
-
-			cil_tree_print_classperms_list(mapping->classperms);
-
-			cil_log(CIL_INFO, " )\n");
-			return;
-		}
-		case CIL_BOOL: {
-			struct cil_bool *boolean = node->data;
-			cil_log(CIL_INFO, "BOOL: %s, value: %d\n", boolean->datum.name, boolean->value);
-			return;
-		}
-		case CIL_TUNABLE: {
-			struct cil_tunable *tunable = node->data;
-			cil_log(CIL_INFO, "TUNABLE: %s, value: %d\n", tunable->datum.name, tunable->value);
-			return;
-		}
-		case CIL_BOOLEANIF: {
-			struct cil_booleanif *bif = node->data;
-
-			cil_log(CIL_INFO, "(BOOLEANIF ");
-
-			cil_tree_print_expr(bif->datum_expr, bif->str_expr);
-
-			cil_log(CIL_INFO, " )\n");
-			return;
-		}
-		case CIL_TUNABLEIF: {
-			struct cil_tunableif *tif = node->data;
-
-			cil_log(CIL_INFO, "(TUNABLEIF ");
-
-			cil_tree_print_expr(tif->datum_expr, tif->str_expr);
-
-			cil_log(CIL_INFO, " )\n");
-			return;
-		}
-		case CIL_CONDBLOCK: {
-			struct cil_condblock *cb = node->data;
-			if (cb->flavor == CIL_CONDTRUE) {
-				cil_log(CIL_INFO, "true\n");
-			} else if (cb->flavor == CIL_CONDFALSE) {
-				cil_log(CIL_INFO, "false\n");
-			}
-			return;
-		}
-		case CIL_ALL:
-			cil_log(CIL_INFO, "all");
-			return;
-		case CIL_AND:
-			cil_log(CIL_INFO, "&&");
-			return;
-		case CIL_OR:
-			cil_log(CIL_INFO, "|| ");
-			return;
-		case CIL_NOT:
-			cil_log(CIL_INFO, "!");
-			return;
-		case CIL_EQ:
-			cil_log(CIL_INFO, "==");
-			return;
-		case CIL_NEQ:
-			cil_log(CIL_INFO, "!=");
-			return;
-		case CIL_TYPEALIAS: {
-			struct cil_alias *alias = node->data;
-			cil_log(CIL_INFO, "TYPEALIAS: %s\n", alias->datum.name);
-			return;
-		}
-		case CIL_TYPEALIASACTUAL: {
-			struct cil_aliasactual *aliasactual = node->data;
-			cil_log(CIL_INFO, "TYPEALIASACTUAL: type: %s, alias: %s\n", aliasactual->alias_str, aliasactual->actual_str);
-			return;
-		}
-		case CIL_TYPEBOUNDS: {
-			struct cil_bounds *bnds = node->data;
-			cil_log(CIL_INFO, "TYPEBOUNDS: type: %s, bounds: %s\n", bnds->parent_str, bnds->child_str);
-			return;
-		}
-		case CIL_TYPEPERMISSIVE: {
-			struct cil_typepermissive *typeperm = node->data;
-
-			if (typeperm->type != NULL) {
-				cil_log(CIL_INFO, "TYPEPERMISSIVE: %s\n", ((struct cil_symtab_datum *)typeperm->type)->name);
-			} else {
-				cil_log(CIL_INFO, "TYPEPERMISSIVE: %s\n", typeperm->type_str);
-			}
-
-			return;
-		}
-		case CIL_NAMETYPETRANSITION: {
-			struct cil_nametypetransition *nametypetrans = node->data;
-			cil_log(CIL_INFO, "TYPETRANSITION:");
-
-			if (nametypetrans->src != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)nametypetrans->src)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", nametypetrans->src_str);
-			}
-
-			if (nametypetrans->tgt != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)nametypetrans->tgt)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", nametypetrans->tgt_str);
-			}
-
-			if (nametypetrans->obj != NULL) {
-				cil_log(CIL_INFO, " %s", nametypetrans->obj->datum.name);
-			} else {
-				cil_log(CIL_INFO, " %s", nametypetrans->obj_str);
-			}
-
-			cil_log(CIL_INFO, " %s\n", nametypetrans->name_str);
-
-			if (nametypetrans->result != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)nametypetrans->result)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", nametypetrans->result_str);
-			}
-
-			return;
-		}
-		case CIL_RANGETRANSITION: {
-			struct cil_rangetransition *rangetrans = node->data;
-			cil_log(CIL_INFO, "RANGETRANSITION:");
-
-			if (rangetrans->src != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)rangetrans->src)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", rangetrans->src_str);
-			}
-
-			if (rangetrans->exec != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)rangetrans->exec)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", rangetrans->exec_str);
-			}
-
-			if (rangetrans->obj != NULL) {
-				cil_log(CIL_INFO, " %s", rangetrans->obj->datum.name);
-			} else {
-				cil_log(CIL_INFO, " %s", rangetrans->obj_str);
-			}
-
-			if (rangetrans->range != NULL) {
-				cil_log(CIL_INFO, " (");
-				cil_tree_print_levelrange(rangetrans->range);
-				cil_log(CIL_INFO, " )");
-			} else {
-				cil_log(CIL_INFO, " %s", rangetrans->range_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_AVRULE: {
-			struct cil_avrule *rule = node->data;
-			switch (rule->rule_kind) {
-			case CIL_AVRULE_ALLOWED:
-				cil_log(CIL_INFO, "ALLOW:");
-				break;
-			case CIL_AVRULE_AUDITALLOW:
-				cil_log(CIL_INFO, "AUDITALLOW:");
-				break;
-			case CIL_AVRULE_DONTAUDIT:
-				cil_log(CIL_INFO, "DONTAUDIT:");
-				break;
-			case CIL_AVRULE_NEVERALLOW:
-				cil_log(CIL_INFO, "NEVERALLOW:");
-				break;
-			}
-
-			if (rule->src != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum*)rule->src)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", rule->src_str);
-			}
-
-			if (rule->tgt != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum*)rule->tgt)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", rule->tgt_str);
-			}
-
-			cil_tree_print_classperms_list(rule->perms.classperms);
-
-			cil_log(CIL_INFO, "\n");
-
-			return;
-		}
-		case CIL_TYPE_RULE: {
-			struct cil_type_rule *rule = node->data;
-			switch (rule->rule_kind) {
-			case CIL_TYPE_TRANSITION:
-				cil_log(CIL_INFO, "TYPETRANSITION:");
-				break;
-			case CIL_TYPE_MEMBER:
-				cil_log(CIL_INFO, "TYPEMEMBER:");
-				break;
-			case CIL_TYPE_CHANGE:
-				cil_log(CIL_INFO, "TYPECHANGE:");
-				break;
-			}
-
-			if (rule->src != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)rule->src)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", rule->src_str);
-			}
-
-			if (rule->tgt != NULL) {
-				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)rule->tgt)->name);
-			} else {
-				cil_log(CIL_INFO, " %s", rule->tgt_str);
-			}
-
-			if (rule->obj != NULL) {
-				cil_log(CIL_INFO, " %s", rule->obj->datum.name);
-			} else {
-				cil_log(CIL_INFO, " %s", rule->obj_str);
-			}
-
-			if (rule->result != NULL) {
-				cil_log(CIL_INFO, " %s\n", ((struct cil_symtab_datum *)rule->result)->name);
-			} else {
-				cil_log(CIL_INFO, " %s\n", rule->result_str);
-			}
-
-			return;
-		}
-		case CIL_SENS: {
-			struct cil_sens *sens = node->data;
-			cil_log(CIL_INFO, "SENSITIVITY: %s\n", sens->datum.name);
-			return;
-		}
-		case CIL_SENSALIAS: {
-			struct cil_alias *alias = node->data;
-			cil_log(CIL_INFO, "SENSITIVITYALIAS: %s\n", alias->datum.name);
-			return;
-		}
-		case CIL_SENSALIASACTUAL: {
-			struct cil_aliasactual *aliasactual = node->data;
-			cil_log(CIL_INFO, "SENSITIVITYALIAS: alias: %s, sensitivity: %s\n", aliasactual->alias_str, aliasactual->actual_str);
-
-			return;
-		}
-		case CIL_CAT: {
-			struct cil_cat *cat = node->data;
-			cil_log(CIL_INFO, "CATEGORY: %s\n", cat->datum.name);
-			return;
-		}
-		case CIL_CATALIAS: {
-			struct cil_alias *alias = node->data;
-			cil_log(CIL_INFO, "CATEGORYALIAS: %s\n", alias->datum.name);
-			return;
-		}
-		case CIL_CATALIASACTUAL: {
-			struct cil_aliasactual *aliasactual = node->data;
-			cil_log(CIL_INFO, "CATEGORYALIAS: alias %s, category: %s\n", aliasactual->alias_str, aliasactual->actual_str);
-			return;
-		}
-		case CIL_CATSET: {
-			struct cil_catset *catset = node->data;
-
-			cil_log(CIL_INFO, "CATSET: %s ",catset->datum.name);
-
-			cil_tree_print_cats(catset->cats);
-
-			return;
-		}
-		case CIL_CATORDER: {
-			struct cil_catorder *catorder = node->data;
-			struct cil_list_item *cat;
-
-			if (catorder->cat_list_str == NULL) {
-				cil_log(CIL_INFO, "CATORDER: ()\n");
-				return;
-			}
-
-			cil_log(CIL_INFO, "CATORDER: (");
-			cil_list_for_each(cat, catorder->cat_list_str) {
-				cil_log(CIL_INFO, " %s", (char*)cat->data);
-			}
-			cil_log(CIL_INFO, " )\n");
-			return;
-		}
-		case CIL_SENSCAT: {
-			struct cil_senscat *senscat = node->data;
-
-			cil_log(CIL_INFO, "SENSCAT: sens:");
-
-			if (senscat->sens_str != NULL) {
-				cil_log(CIL_INFO, " %s ", senscat->sens_str);
-			} else {
-				cil_log(CIL_INFO, " [processed]");
-			}
-
-			cil_tree_print_cats(senscat->cats);
-
-			return;
-		}
-		case CIL_SENSITIVITYORDER: {
-			struct cil_sensorder *sensorder = node->data;
-			struct cil_list_item *sens;
-
-			cil_log(CIL_INFO, "SENSITIVITYORDER: (");
-
-			if (sensorder->sens_list_str != NULL) {
-				cil_list_for_each(sens, sensorder->sens_list_str) {
-					if (sens->flavor == CIL_LIST) {
-						struct cil_list_item *sub;
-						cil_log(CIL_INFO, " (");
-						cil_list_for_each(sub, (struct cil_list*)sens->data) {
-							cil_log(CIL_INFO, " %s", (char*)sub->data);
-						}
-						cil_log(CIL_INFO, " )");
-					} else {
-						cil_log(CIL_INFO, " %s", (char*)sens->data);
-					}
-				}
-			}
-
-			cil_log(CIL_INFO, " )\n");
-			return;
-		}
-		case CIL_LEVEL: {
-			struct cil_level *level = node->data;
-			cil_log(CIL_INFO, "LEVEL %s:", level->datum.name); 
-			cil_tree_print_level(level);
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_LEVELRANGE: {
-			struct cil_levelrange *lvlrange = node->data;
-			cil_log(CIL_INFO, "LEVELRANGE %s:", lvlrange->datum.name);
-			cil_tree_print_levelrange(lvlrange);
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_CONSTRAIN: {
-			struct cil_constrain *cons = node->data;
-			cil_log(CIL_INFO, "CONSTRAIN: (");
-			cil_tree_print_constrain(cons);
-			return;
-		}
-		case CIL_MLSCONSTRAIN: {
-			struct cil_constrain *cons = node->data;
-			cil_log(CIL_INFO, "MLSCONSTRAIN: (");
-			cil_tree_print_constrain(cons);
-			return;
-		}
-		case CIL_VALIDATETRANS: {
-			struct cil_validatetrans *vt = node->data;
-
-			cil_log(CIL_INFO, "(VALIDATETRANS ");
-
-			if (vt->class != NULL) {
-				cil_log(CIL_INFO, "%s ", vt->class->datum.name);
-			} else if (vt->class_str != NULL) {
-				cil_log(CIL_INFO, "%s ", vt->class_str);
-			}
-
-			cil_tree_print_expr(vt->datum_expr, vt->str_expr);
-
-			cil_log(CIL_INFO, ")\n");
-			return;
-		}
-		case CIL_MLSVALIDATETRANS: {
-			struct cil_validatetrans *vt = node->data;
-
-			cil_log(CIL_INFO, "(MLSVALIDATETRANS ");
-
-			if (vt->class != NULL) {
-				cil_log(CIL_INFO, "%s ", vt->class->datum.name);
-			} else if (vt->class_str != NULL) {
-				cil_log(CIL_INFO, "%s ", vt->class_str);
-			}
-
-			cil_tree_print_expr(vt->datum_expr, vt->str_expr);
-
-			cil_log(CIL_INFO, ")\n");
-			return;
-		}
-		case CIL_CONTEXT: {
-			struct cil_context *context = node->data;
-			cil_log(CIL_INFO, "CONTEXT %s:", context->datum.name);
-			cil_tree_print_context(context);
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_FILECON: {
-			struct cil_filecon *filecon = node->data;
-			cil_log(CIL_INFO, "FILECON:");
-			cil_log(CIL_INFO, " %s %d", filecon->path_str, filecon->type);
-
-			if (filecon->context != NULL) {
-				cil_tree_print_context(filecon->context);
-			} else if (filecon->context_str != NULL) {
-				cil_log(CIL_INFO, " %s", filecon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-
-		}
-		case CIL_IBPKEYCON: {
-			struct cil_ibpkeycon *ibpkeycon = node->data;
-
-			cil_log(CIL_INFO, "IBPKEYCON: %s", ibpkeycon->subnet_prefix_str);
-			cil_log(CIL_INFO, " (%d %d) ", ibpkeycon->pkey_low, ibpkeycon->pkey_high);
-
-			if (ibpkeycon->context)
-				cil_tree_print_context(ibpkeycon->context);
-			else if (ibpkeycon->context_str)
-				cil_log(CIL_INFO, " %s", ibpkeycon->context_str);
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_PORTCON: {
-			struct cil_portcon *portcon = node->data;
-			cil_log(CIL_INFO, "PORTCON:");
-			if (portcon->proto == CIL_PROTOCOL_UDP) {
-				cil_log(CIL_INFO, " udp");
-			} else if (portcon->proto == CIL_PROTOCOL_TCP) {
-				cil_log(CIL_INFO, " tcp");
-			} else if (portcon->proto == CIL_PROTOCOL_DCCP) {
-				cil_log(CIL_INFO, " dccp");
-			} else if (portcon->proto == CIL_PROTOCOL_SCTP) {
-				cil_log(CIL_INFO, " sctp");
-			}
-			cil_log(CIL_INFO, " (%d %d)", portcon->port_low, portcon->port_high);
-
-			if (portcon->context != NULL) {
-				cil_tree_print_context(portcon->context);
-			} else if (portcon->context_str != NULL) {
-				cil_log(CIL_INFO, " %s", portcon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_NODECON: {
-			struct cil_nodecon *nodecon = node->data;
-			char buf[256];
-				
-			cil_log(CIL_INFO, "NODECON:");
-				
-			if (nodecon->addr) {
-				inet_ntop(nodecon->addr->family, &nodecon->addr->ip, buf, 256);
-				cil_log(CIL_INFO, " %s", buf);
-			}  else {
-				cil_log(CIL_INFO, " %s", nodecon->addr_str);
-			}
-
-			if (nodecon->mask) {
-				inet_ntop(nodecon->mask->family, &nodecon->mask->ip, buf, 256);
-				cil_log(CIL_INFO, " %s", buf);
-			} else {
-				cil_log(CIL_INFO, " %s", nodecon->mask_str);
-			}
-				
-			if (nodecon->context != NULL) {
-				cil_tree_print_context(nodecon->context);
-			} else if (nodecon->context_str != NULL) {
-				cil_log(CIL_INFO, " %s", nodecon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_GENFSCON: {
-			struct cil_genfscon *genfscon = node->data;
-			cil_log(CIL_INFO, "GENFSCON:");
-			cil_log(CIL_INFO, " %s %s", genfscon->fs_str, genfscon->path_str);
-
-			if (genfscon->context != NULL) {
-				cil_tree_print_context(genfscon->context);
-			} else if (genfscon->context_str != NULL) {
-				cil_log(CIL_INFO, " %s", genfscon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_NETIFCON: {
-			struct cil_netifcon *netifcon = node->data;
-			cil_log(CIL_INFO, "NETIFCON %s", netifcon->interface_str);
-
-			if (netifcon->if_context != NULL) {
-				cil_tree_print_context(netifcon->if_context);
-			} else if (netifcon->if_context_str != NULL) {
-				cil_log(CIL_INFO, " %s", netifcon->if_context_str);
-			}
-
-			if (netifcon->packet_context != NULL) {
-				cil_tree_print_context(netifcon->packet_context);
-			} else if (netifcon->packet_context_str != NULL) {
-				cil_log(CIL_INFO, " %s", netifcon->packet_context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_IBENDPORTCON: {
-			struct cil_ibendportcon *ibendportcon = node->data;
-
-			cil_log(CIL_INFO, "IBENDPORTCON: %s %u ", ibendportcon->dev_name_str, ibendportcon->port);
-
-			if (ibendportcon->context)
-				cil_tree_print_context(ibendportcon->context);
-			else if (ibendportcon->context_str)
-				cil_log(CIL_INFO, " %s", ibendportcon->context_str);
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_PIRQCON: {
-			struct cil_pirqcon *pirqcon = node->data;
-
-			cil_log(CIL_INFO, "PIRQCON %d", pirqcon->pirq);
-			if (pirqcon->context != NULL) {
-				cil_tree_print_context(pirqcon->context);
-			} else {
-				cil_log(CIL_INFO, " %s", pirqcon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_IOMEMCON: {
-			struct cil_iomemcon *iomemcon = node->data;
-
-			cil_log(CIL_INFO, "IOMEMCON ( %"PRId64" %"PRId64" )", iomemcon->iomem_low, iomemcon->iomem_high);
-			if (iomemcon->context != NULL) {
-				cil_tree_print_context(iomemcon->context);
-			} else {
-				cil_log(CIL_INFO, " %s", iomemcon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_IOPORTCON: {
-			struct cil_ioportcon *ioportcon = node->data;
-
-			cil_log(CIL_INFO, "IOPORTCON ( %d %d )", ioportcon->ioport_low, ioportcon->ioport_high);
-			if (ioportcon->context != NULL) {
-				cil_tree_print_context(ioportcon->context);
-			} else {
-				cil_log(CIL_INFO, " %s", ioportcon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_PCIDEVICECON: {
-			struct cil_pcidevicecon *pcidevicecon = node->data;
-
-			cil_log(CIL_INFO, "PCIDEVICECON %d", pcidevicecon->dev);
-			if (pcidevicecon->context != NULL) {
-				cil_tree_print_context(pcidevicecon->context);
-			} else {
-				cil_log(CIL_INFO, " %s", pcidevicecon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_DEVICETREECON: {
-			struct cil_devicetreecon *devicetreecon = node->data;
-
-			cil_log(CIL_INFO, "DEVICETREECON %s", devicetreecon->path);
-			if (devicetreecon->context != NULL) {
-				cil_tree_print_context(devicetreecon->context);
-			} else {
-				cil_log(CIL_INFO, " %s", devicetreecon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_FSUSE: {
-			struct cil_fsuse *fsuse = node->data;
-			cil_log(CIL_INFO, "FSUSE: ");
-
-			if (fsuse->type == CIL_FSUSE_XATTR) {
-				cil_log(CIL_INFO, "xattr ");
-			} else if (fsuse->type == CIL_FSUSE_TASK) {
-				cil_log(CIL_INFO, "task ");
-			} else if (fsuse->type == CIL_FSUSE_TRANS) {
-				cil_log(CIL_INFO, "trans ");
-			} else {
-				cil_log(CIL_INFO, "unknown ");
-			}
-
-			cil_log(CIL_INFO, "%s ", fsuse->fs_str);
-
-			if (fsuse->context != NULL) {
-				cil_tree_print_context(fsuse->context);
-			} else {
-				cil_log(CIL_INFO, " %s", fsuse->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_SID: {
-			struct cil_sid *sid = node->data;
-			cil_log(CIL_INFO, "SID: %s\n", sid->datum.name);
-			return;
-		}
-		case CIL_SIDCONTEXT: {
-			struct cil_sidcontext *sidcon = node->data;
-			cil_log(CIL_INFO, "SIDCONTEXT: %s", sidcon->sid_str);
-
-			if (sidcon->context != NULL) {
-				cil_tree_print_context(sidcon->context);
-			} else {
-				cil_log(CIL_INFO, " %s", sidcon->context_str);
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}
-		case CIL_SIDORDER: {
-			struct cil_sidorder *sidorder = node->data;
-			struct cil_list_item *sid;
-
-			if (sidorder->sid_list_str == NULL) {
-				cil_log(CIL_INFO, "SIDORDER: ()\n");
-				return;
-			}
-
-			cil_log(CIL_INFO, "SIDORDER: (");
-			cil_list_for_each(sid, sidorder->sid_list_str) {
-				cil_log(CIL_INFO, " %s", (char*)sid->data);
-			}
-			cil_log(CIL_INFO, " )\n");
-			return;
-		}
-		case CIL_POLICYCAP: {
-			struct cil_policycap *polcap = node->data;
-			cil_log(CIL_INFO, "POLICYCAP: %s\n", polcap->datum.name);
-			return;
-		}
-		case CIL_MACRO: {
-			struct cil_macro *macro = node->data;
-			cil_log(CIL_INFO, "MACRO %s:", macro->datum.name);
-
-			if (macro->params != NULL && macro->params->head != NULL) {
-				struct cil_list_item *curr_param;
-				cil_log(CIL_INFO, " parameters: (");
-				cil_list_for_each(curr_param, macro->params) {
-					cil_log(CIL_INFO, " flavor: %d, string: %s;", ((struct cil_param*)curr_param->data)->flavor, ((struct cil_param*)curr_param->data)->str);
-
-				}
-				cil_log(CIL_INFO, " )");
-			}
-			cil_log(CIL_INFO, "\n");
-
-			return;
-		}
-		case CIL_CALL: {
-			struct cil_call *call = node->data;
-			cil_log(CIL_INFO, "CALL: macro name:");
-
-			if (call->macro != NULL) {
-				cil_log(CIL_INFO, " %s", call->macro->datum.name);
-			} else {
-				cil_log(CIL_INFO, " %s", call->macro_str);
-			}
-
-			if (call->args != NULL) {
-				cil_log(CIL_INFO, ", args: ( ");
-				struct cil_list_item *item;
-				cil_list_for_each(item, call->args) {
-					struct cil_symtab_datum *datum = ((struct cil_args*)item->data)->arg;
-					if (datum != NULL) {
-						if (datum->nodes != NULL && datum->nodes->head != NULL) {
-							cil_tree_print_node(NODE(datum));
-						}
-					} else if (((struct cil_args*)item->data)->arg_str != NULL) {
-						switch (item->flavor) {
-						case CIL_TYPE: cil_log(CIL_INFO, "type:"); break;
-						case CIL_USER: cil_log(CIL_INFO, "user:"); break;
-						case CIL_ROLE: cil_log(CIL_INFO, "role:"); break;
-						case CIL_SENS: cil_log(CIL_INFO, "sensitivity:"); break;
-						case CIL_CAT: cil_log(CIL_INFO, "category:"); break;
-						case CIL_CATSET: cil_log(CIL_INFO, "categoryset:"); break;
-						case CIL_LEVEL: cil_log(CIL_INFO, "level:"); break;
-						case CIL_CLASS: cil_log(CIL_INFO, "class:"); break;
-						default: break;
-						}
-						cil_log(CIL_INFO, "%s ", ((struct cil_args*)item->data)->arg_str);
-					}
-				}
-				cil_log(CIL_INFO, ")");
-			}
-
-			cil_log(CIL_INFO, "\n");
-			return;
-		}	
-		case CIL_OPTIONAL: {
-			struct cil_optional *optional = node->data;
-			cil_log(CIL_INFO, "OPTIONAL: %s\n", optional->datum.name);
-			return;
-		}
-		case CIL_IPADDR: {
-			struct cil_ipaddr *ipaddr = node->data;
-			char buf[256];
-
-			inet_ntop(ipaddr->family, &ipaddr->ip, buf, 256);
-			cil_log(CIL_INFO, "IPADDR %s: %s\n", ipaddr->datum.name, buf);
-
-			break;
-		}
-		default : {
-			cil_log(CIL_INFO, "CIL FLAVOR: %d\n", node->flavor);
-			return;
-		}
-		}
-	}
-}
-
-void cil_tree_print(struct cil_tree_node *tree, uint32_t depth)
-{
-	struct cil_tree_node *current = NULL;
-	current = tree;
-	uint32_t x = 0;
-
-	if (current != NULL) {
-		if (current->cl_head == NULL) {
-			if (current->flavor == CIL_NODE) {
-				if (current->parent->cl_head == current) {
-					cil_log(CIL_INFO, "%s", (char*)current->data);
-				} else {
-					cil_log(CIL_INFO, " %s", (char*)current->data);
-				}
-			} else if (current->flavor != CIL_PERM) {
-				for (x = 0; x<depth; x++) {
-					cil_log(CIL_INFO, "\t");
-				}
-				cil_tree_print_node(current);
-			}
-		} else {
-			if (current->parent != NULL) {
-				cil_log(CIL_INFO, "\n");
-				for (x = 0; x<depth; x++) {
-					cil_log(CIL_INFO, "\t");
-				}
-				cil_log(CIL_INFO, "(");
-
-				if (current->flavor != CIL_NODE) {
-					cil_tree_print_node(current);
-				}
-			}
-			cil_tree_print(current->cl_head, depth + 1);
-		}
-
-		if (current->next == NULL) {
-			if ((current->parent != NULL) && (current->parent->cl_tail == current) && (current->parent->parent != NULL)) {
-				if (current->flavor == CIL_PERM) {
-					cil_log(CIL_INFO, ")\n");
-				} else if (current->flavor != CIL_NODE) {
-					for (x = 0; x<depth-1; x++) {
-						cil_log(CIL_INFO, "\t");
-					}
-					cil_log(CIL_INFO, ")\n");
-				} else {
-					cil_log(CIL_INFO, ")");
-				}
-			}
-
-			if ((current->parent != NULL) && (current->parent->parent == NULL))
-				cil_log(CIL_INFO, "\n\n");
-		} else {
-			cil_tree_print(current->next, depth);
-		}
-	} else {
-		cil_log(CIL_INFO, "Tree is NULL\n");
-	}
-}
diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
index aeded560..bac9f1e4 100644
--- a/libsepol/cil/src/cil_tree.h
+++ b/libsepol/cil/src/cil_tree.h
@@ -62,8 +62,6 @@ void cil_tree_children_destroy(struct cil_tree_node *node);
 void cil_tree_node_init(struct cil_tree_node **node);
 void cil_tree_node_destroy(struct cil_tree_node **node);
 
-void cil_tree_print(struct cil_tree_node *tree, uint32_t depth);
-
 //finished values
 #define CIL_TREE_SKIP_NOTHING	0
 #define CIL_TREE_SKIP_NEXT	1
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
new file mode 100644
index 00000000..6cb567a6
--- /dev/null
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -0,0 +1,1573 @@
+/*
+ * Copyright 2011 Tresys Technology, LLC. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ *    1. Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ *
+ *    2. Redistributions in binary form must reproduce the above copyright notice,
+ *       this list of conditions and the following disclaimer in the documentation
+ *       and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY EXPRESS
+ * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
+ * EVENT SHALL TRESYS TECHNOLOGY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * The views and conclusions contained in the software and documentation are those
+ * of the authors and should not be interpreted as representing official policies,
+ * either expressed or implied, of Tresys Technology, LLC.
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <ctype.h>
+
+#include "cil_internal.h"
+#include "cil_flavor.h"
+#include "cil_list.h"
+#include "cil_log.h"
+#include "cil_symtab.h"
+#include "cil_tree.h"
+#include "cil_write_ast.h"
+
+
+static inline char *datum_or_str(struct cil_symtab_datum *datum, char *str)
+{
+	return datum ? datum->fqn : str;
+}
+
+static inline char *datum_to_str(struct cil_symtab_datum *datum)
+{
+	return datum ? datum->fqn : "<?DATUM>";
+}
+
+static void write_expr(FILE *out, struct cil_list *expr)
+{
+	struct cil_list_item *curr;
+	int notfirst = 0;
+
+	fprintf(out, "(");
+	cil_list_for_each(curr, expr) {
+		if (notfirst)
+			fprintf(out, " ");
+		else
+			notfirst = 1;
+		switch (curr->flavor) {
+		case CIL_LIST:
+			write_expr(out, curr->data);
+			break;
+		case CIL_STRING:
+			fprintf(out, "%s", (char *)curr->data);
+			break;
+		case CIL_DATUM:
+		case CIL_TYPE:
+		case CIL_ROLE:
+		case CIL_USER:
+		case CIL_SENS:
+		case CIL_CAT:
+		case CIL_BOOL:
+		case CIL_CLASS:
+		case CIL_MAP_CLASS:
+		case CIL_NAME:
+			fprintf(out, "%s", datum_to_str(curr->data));
+			break;
+		case CIL_OP: {
+			char *op_str = NULL;
+			enum cil_flavor op_flavor = (enum cil_flavor)curr->data;
+			switch (op_flavor) {
+			case CIL_AND:
+				op_str = CIL_KEY_AND;
+				break;
+			case CIL_OR:
+				op_str = CIL_KEY_OR;
+				break;
+			case CIL_NOT:
+				op_str = CIL_KEY_NOT;
+				break;
+			case CIL_ALL:
+				op_str = CIL_KEY_ALL;
+				break;
+			case CIL_EQ:
+				op_str = CIL_KEY_EQ;
+				break;
+			case CIL_NEQ:
+				op_str = CIL_KEY_NEQ;
+				break;
+			case CIL_XOR:
+				op_str = CIL_KEY_XOR;
+				break;
+			case CIL_RANGE:
+				op_str = CIL_KEY_RANGE;
+				break;
+			case CIL_CONS_DOM:
+				op_str = CIL_KEY_CONS_DOM;
+				break;
+			case CIL_CONS_DOMBY:
+				op_str = CIL_KEY_CONS_DOMBY;
+				break;
+			case CIL_CONS_INCOMP:
+				op_str = CIL_KEY_CONS_INCOMP;
+				break;
+			default:
+				op_str = "<?OP>";
+				break;
+			}
+			fprintf(out, "%s", op_str);
+			break;
+		}
+		case CIL_CONS_OPERAND: {
+			char *operand_str = NULL;
+			enum cil_flavor operand_flavor = (enum cil_flavor)curr->data;
+			switch (operand_flavor) {
+			case CIL_CONS_U1:
+				operand_str = CIL_KEY_CONS_U1;
+				break;
+			case CIL_CONS_U2:
+				operand_str = CIL_KEY_CONS_U2;
+				break;
+			case CIL_CONS_U3:
+				operand_str = CIL_KEY_CONS_U3;
+				break;
+			case CIL_CONS_T1:
+				operand_str = CIL_KEY_CONS_T1;
+				break;
+			case CIL_CONS_T2:
+				operand_str = CIL_KEY_CONS_T2;
+				break;
+			case CIL_CONS_T3:
+				operand_str = CIL_KEY_CONS_T3;
+				break;
+			case CIL_CONS_R1:
+				operand_str = CIL_KEY_CONS_R1;
+				break;
+			case CIL_CONS_R2:
+				operand_str = CIL_KEY_CONS_R2;
+				break;
+			case CIL_CONS_R3:
+				operand_str = CIL_KEY_CONS_R3;
+				break;
+			case CIL_CONS_L1:
+				operand_str = CIL_KEY_CONS_L1;
+				break;
+			case CIL_CONS_L2:
+				operand_str = CIL_KEY_CONS_L2;
+				break;
+			case CIL_CONS_H1:
+				operand_str = CIL_KEY_CONS_H1;
+				break;
+			case CIL_CONS_H2:
+				operand_str = CIL_KEY_CONS_H2;
+				break;
+			default:
+				operand_str = "<?OPERAND>";
+				break;
+			}
+			fprintf(out, "%s", operand_str);
+			break;
+		}
+		default:
+			fprintf(out, "<?FLAVOR>");
+			break;
+		}
+	}
+	fprintf(out, ")");
+}
+
+static void write_node_list(FILE *out, struct cil_tree_node *current)
+{
+	int notfirst = 0;
+
+	fprintf(out, "(");
+	while (current) {
+		if (notfirst)
+			fprintf(out, " ");
+		else
+			notfirst = 1;
+
+		fprintf(out, "%s", datum_to_str(current->data));
+		current = current->next;
+	}
+	fprintf(out, ")");
+}
+
+static void write_string_list(FILE *out, struct cil_list *list)
+{
+	struct cil_list_item *curr;
+	int notfirst = 0;
+
+	if (!list) {
+		fprintf(out, "()");
+		return;
+	}
+
+	fprintf(out, "(");
+	cil_list_for_each(curr, list) {
+		if (notfirst)
+			fprintf(out, " ");
+		else
+			notfirst = 1;
+		fprintf(out, "%s", (char*)curr->data);
+	}
+	fprintf(out, ")");
+}
+
+static void write_datum_list(FILE *out, struct cil_list *list)
+{
+	struct cil_list_item *curr;
+	int notfirst = 0;
+
+	if (!list) {
+		fprintf(out, "()");
+		return;
+	}
+
+	fprintf(out, "(");
+	cil_list_for_each(curr, list) {
+		if (notfirst)
+			fprintf(out, " ");
+		else
+			notfirst = 1;
+		fprintf(out, "%s", datum_to_str(curr->data));
+	}
+	fprintf(out, ")");
+}
+
+static void write_classperms(FILE *out, struct cil_classperms *cp)
+{
+	if (!cp) {
+		fprintf(out, "()");
+		return;
+	}
+
+	fprintf(out, "(%s ", datum_or_str(DATUM(cp->class), cp->class_str));
+	if (cp->perms)
+		write_expr(out, cp->perms);
+	else
+		write_expr(out, cp->perm_strs);
+	fprintf(out, ")");
+}
+
+static void write_classperms_list(FILE *out, struct cil_list *cp_list)
+{
+	struct cil_list_item *curr;
+	int notfirst = 0;
+	int num = 0;
+
+	if (!cp_list) {
+		fprintf(out, "()");
+		return;
+	}
+
+	cil_list_for_each(curr, cp_list) {
+		num++;
+	}
+	if (num > 1)
+		fprintf(out, "(");
+	cil_list_for_each(curr, cp_list) {
+		if (notfirst)
+			fprintf(out, " ");
+		else
+			notfirst = 1;
+		if (curr->flavor == CIL_CLASSPERMS) {
+			write_classperms(out, curr->data);
+		} else {
+			struct cil_classperms_set *cp_set = curr->data;
+			struct cil_classpermission *cp = cp_set->set;
+			if (cp) {
+				if (cp->datum.name)
+					fprintf(out, "%s", datum_to_str(DATUM(cp)));
+				else
+					write_classperms_list(out,cp->classperms);
+			} else {
+				fprintf(out, "%s", cp_set->set_str);
+			}
+		}
+	}
+	if (num > 1)
+		fprintf(out, ")");
+}
+
+static void write_permx(FILE *out, struct cil_permissionx *permx)
+{
+	if (permx->datum.name) {
+		fprintf(out, "%s", datum_to_str(DATUM(permx)));
+	} else {
+		fprintf(out, "(");
+		fprintf(out, "%s ", permx->kind == CIL_PERMX_KIND_IOCTL ? "ioctl" : "<?KIND>");
+		fprintf(out, "%s ", datum_or_str(DATUM(permx->obj), permx->obj_str));
+		write_expr(out, permx->expr_str);
+		fprintf(out, ")");
+	}
+}
+
+static void write_cats(FILE *out, struct cil_cats *cats)
+{
+	if (cats->datum_expr) {
+		write_expr(out, cats->datum_expr);
+	} else {
+		write_expr(out, cats->str_expr);
+	}
+}
+
+static void write_level(FILE *out, struct cil_level *level, int print_name)
+{
+	if (print_name && level->datum.name) {
+		fprintf(out, "%s", datum_to_str(DATUM(level)));
+	} else {
+		fprintf(out, "(");
+		fprintf(out, "%s", datum_or_str(DATUM(level->sens), level->sens_str));
+		if (level->cats) {
+			fprintf(out, " ");
+			write_cats(out, level->cats);
+		}
+		fprintf(out, ")");
+	}
+}
+
+static void write_range(FILE *out, struct cil_levelrange *range, int print_name)
+{
+	if (print_name && range->datum.name) {
+		fprintf(out, "%s", datum_to_str(DATUM(range)));
+	} else {
+		fprintf(out, "(");
+		if (range->low)
+			write_level(out, range->low, CIL_TRUE);
+		else
+			fprintf(out, "%s", range->low_str);
+		fprintf(out, " ");
+		if (range->high)
+			write_level(out, range->high, CIL_TRUE);
+		else
+			fprintf(out, "%s", range->high_str);
+		fprintf(out, ")");
+	}
+}
+
+static void write_context(FILE *out, struct cil_context *context, int print_name)
+{
+	if (print_name && context->datum.name) {
+		fprintf(out, "%s", datum_to_str(DATUM(context)));
+	} else {
+		fprintf(out, "(");
+		fprintf(out, "%s ", datum_or_str(DATUM(context->user), context->user_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(context->role), context->role_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(context->type), context->type_str));
+		if (context->range)
+			write_range(out, context->range, CIL_TRUE);
+		else
+			fprintf(out, "%s", context->range_str);
+		fprintf(out, ")");
+	}
+}
+
+static void write_ipaddr(FILE *out, struct cil_ipaddr *ipaddr)
+{
+	if (ipaddr->datum.name) {
+		fprintf(out, "%s", datum_to_str(DATUM(ipaddr)));
+	} else {
+		char buf[256];
+		if (inet_ntop(ipaddr->family, &ipaddr->ip, buf, 256) == NULL)
+			strcpy(buf, "<?IPADDR>");
+		fprintf(out, "(%s)", buf);
+	}
+}
+
+static void write_constrain(FILE *out, struct cil_constrain *cons)
+{
+	write_classperms_list(out, cons->classperms);
+	fprintf(out, " ");
+	if (cons->datum_expr)
+		write_expr(out, cons->datum_expr);
+	else
+		write_expr(out, cons->str_expr);
+}
+
+static void write_call_args(FILE *out, struct cil_list *args)
+{
+	struct cil_list_item *item;
+	int notfirst = 0;
+
+	fprintf(out, "(");
+	cil_list_for_each(item, args) {
+		struct cil_args* arg = item->data;
+		enum cil_flavor arg_flavor = arg->flavor;
+		if (notfirst)
+			fprintf(out, " ");
+		else
+			notfirst = 1;
+		switch (arg_flavor) {
+		case CIL_TYPE:
+		case CIL_ROLE:
+		case CIL_USER:
+		case CIL_SENS:
+		case CIL_CAT:
+		case CIL_BOOL:
+		case CIL_CLASS:
+		case CIL_MAP_CLASS:
+		case CIL_NAME: {
+			fprintf(out, "%s", datum_or_str(arg->arg, arg->arg_str));
+			break;
+		}
+		case CIL_CATSET: {
+			if (arg->arg) {
+				struct cil_catset *catset = (struct cil_catset *)arg->arg;
+				write_cats(out, catset->cats);
+			} else {
+				fprintf(out, "%s", arg->arg_str);
+			}
+			break;
+		}
+		case CIL_LEVEL: {
+			if (arg->arg) {
+				struct cil_level *level = (struct cil_level *)arg->arg;
+				write_level(out, level, CIL_TRUE);
+			} else {
+				fprintf(out, "%s", arg->arg_str);
+			}
+			break;
+		}
+		case CIL_LEVELRANGE: {
+			if (arg->arg) {
+				struct cil_levelrange *range = (struct cil_levelrange *)arg->arg;
+				write_range(out, range, CIL_TRUE);
+			} else {
+				fprintf(out, "%s", arg->arg_str);
+			}
+			break;
+		}
+		case CIL_IPADDR: {
+			if (arg->arg) {
+				struct cil_ipaddr *addr = (struct cil_ipaddr *)arg->arg;
+				write_ipaddr(out, addr);
+			} else {
+				fprintf(out, "%s", arg->arg_str);
+			}
+			break;
+		}
+		case CIL_CLASSPERMISSION: {
+			if (arg->arg) {
+				struct cil_classpermission *cp = (struct cil_classpermission *)arg->arg;
+				if (cp->datum.name)
+					fprintf(out, "%s", datum_to_str(DATUM(cp)));
+				else
+					write_classperms_list(out, cp->classperms);
+			} else {
+				fprintf(out, "%s", arg->arg_str);
+			}
+			break;
+		}
+		default:
+			fprintf(out, "<?ARG:%s>", datum_or_str(arg->arg, arg->arg_str));
+			break;
+		}
+	}
+	fprintf(out, ")");
+}
+
+static void write_call_args_tree(FILE *out, struct cil_tree_node *arg_node)
+{
+	while (arg_node) {
+		if (arg_node->data) {
+			fprintf(out, "%s", (char *)arg_node->data);
+		} else if (arg_node->cl_head) {
+			fprintf(out, "(");
+			write_call_args_tree(out, arg_node->cl_head);
+			fprintf(out, ")");
+		}
+		if (arg_node->next)
+			fprintf(out, " ");
+		arg_node = arg_node->next;
+	}
+}
+
+static char *__macro_param_flavor_to_string(enum cil_flavor flavor)
+{
+	char *str = NULL;
+	switch(flavor) {
+	case CIL_TYPE:
+		str = CIL_KEY_TYPE;
+		break;
+	case CIL_ROLE:
+		str = CIL_KEY_ROLE;
+		break;
+	case CIL_USER:
+		str = CIL_KEY_USER;
+		break;
+	case CIL_SENS:
+		str = CIL_KEY_SENSITIVITY;
+		break;
+	case CIL_CAT:
+		str = CIL_KEY_CATEGORY;
+		break;
+	case CIL_CATSET:
+		str = CIL_KEY_CATSET;
+		break;
+	case CIL_LEVEL:
+		str = CIL_KEY_LEVEL;
+		break;
+	case CIL_LEVELRANGE:
+		str = CIL_KEY_LEVELRANGE;
+		break;
+	case CIL_CLASS:
+		str = CIL_KEY_CLASS;
+		break;
+	case CIL_IPADDR:
+		str = CIL_KEY_IPADDR;
+		break;
+	case CIL_MAP_CLASS:
+		str = CIL_KEY_MAP_CLASS;
+		break;
+	case CIL_CLASSPERMISSION:
+		str = CIL_KEY_CLASSPERMISSION;
+		break;
+	case CIL_BOOL:
+		str = CIL_KEY_BOOL;
+		break;
+	case CIL_STRING:
+		str = CIL_KEY_STRING;
+		break;
+	case CIL_NAME:
+		str = CIL_KEY_NAME;
+		break;
+	default:
+		str = "<?FLAVOR>";
+		break;
+	}
+	return str;
+}
+
+void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
+{
+	if (!node->data) {
+		return;
+	}
+
+	switch(node->flavor) {
+	case CIL_NODE: {
+		fprintf(out, "%s\n", (char *)node->data);
+		break;
+	}
+	case CIL_BLOCK: {
+		struct cil_block *block = node->data;
+		fprintf(out, "(block %s", datum_to_str(DATUM(block)));
+		if (!node->cl_head)
+			fprintf(out, ")");
+		fprintf(out, "\n");
+		break;
+	}
+	case CIL_BLOCKINHERIT: {
+		struct cil_blockinherit *inherit = node->data;
+		fprintf(out, "(blockinherit %s)\n", datum_or_str(DATUM(inherit->block), inherit->block_str));
+		break;
+	}
+	case CIL_IN: {
+		struct cil_in *in = node->data;
+		fprintf(out, "(in %s", in->block_str);
+		if (!node->cl_head)
+			fprintf(out, ")");
+		fprintf(out, "\n");
+		break;
+	}
+	case CIL_OPTIONAL: {
+		struct cil_optional *optional = node->data;
+		fprintf(out, "(optional %s", datum_to_str(DATUM(optional)));
+		if (!node->cl_head)
+			fprintf(out, ")");
+		fprintf(out, "\n");
+		break;
+	}
+	case CIL_BOOLEANIF: {
+		struct cil_booleanif *bif = node->data;
+		fprintf(out, "(booleanif ");
+		if (bif->datum_expr)
+			write_expr(out, bif->datum_expr);
+		else
+			write_expr(out, bif->str_expr);
+		if (!node->cl_head)
+			fprintf(out, ")");
+		fprintf(out, "\n");
+		break;
+	}
+	case CIL_TUNABLEIF: {
+		struct cil_tunableif *tif = node->data;
+		fprintf(out, "(tunableif ");
+		if (tif->datum_expr)
+			write_expr(out, tif->datum_expr);
+		else
+			write_expr(out, tif->str_expr);
+		if (!node->cl_head)
+			fprintf(out, ")");
+		fprintf(out, "\n");
+		break;
+	}
+	case CIL_CONDBLOCK: {
+		struct cil_condblock *cb = node->data;
+		fprintf(out, "(%s", cb->flavor == CIL_CONDTRUE ? "true" : "false");
+		if (!node->cl_head)
+			fprintf(out, ")");
+		fprintf(out, "\n");
+		break;
+	}
+	case CIL_MACRO: {
+		struct cil_macro *macro = node->data;
+		struct cil_list_item *curr;
+		fprintf(out, "(macro %s (", datum_to_str(DATUM(macro)));
+		if (macro->params) {
+			cil_list_for_each(curr, macro->params) {
+				struct cil_param *param = curr->data;
+				fprintf(out, "(%s %s)", __macro_param_flavor_to_string(param->flavor), param->str);
+			}
+		}
+		fprintf(out, ")");
+		if (!node->cl_head)
+			fprintf(out, ")");
+		fprintf(out, "\n");
+		break;
+	}
+	case CIL_CALL: {
+		struct cil_call *call = node->data;
+		fprintf(out, "(call %s", datum_or_str(DATUM(call->macro), call->macro_str));
+		if (call->args) {
+			fprintf(out, " ");
+			write_call_args(out, call->args);
+		} else if (call->args_tree) {
+			fprintf(out, " ");
+			write_call_args_tree(out, call->args_tree->root);
+		}
+		if (!node->cl_head)
+			fprintf(out, ")");
+		fprintf(out, "\n");
+		break;
+	}
+	case CIL_BLOCKABSTRACT: {
+		struct cil_blockabstract *abstract = node->data;
+		fprintf(out, "(blockabstract %s)\n", abstract->block_str);
+		break;
+	}
+	case CIL_MLS: {
+		struct cil_mls *mls = node->data;
+		fprintf(out, "(mls %s)\n", mls->value ? "true" : "false");
+		break;
+	}
+	case CIL_HANDLEUNKNOWN: {
+		struct cil_handleunknown *unknown = node->data;
+		fprintf(out, "(handleunknown ");
+		if (unknown->handle_unknown == SEPOL_ALLOW_UNKNOWN)
+			fprintf(out, "%s", CIL_KEY_HANDLEUNKNOWN_ALLOW);
+		else if (unknown->handle_unknown == SEPOL_DENY_UNKNOWN)
+			fprintf(out, "%s", CIL_KEY_HANDLEUNKNOWN_DENY);
+		else if (unknown->handle_unknown == SEPOL_REJECT_UNKNOWN)
+			fprintf(out, "%s", CIL_KEY_HANDLEUNKNOWN_REJECT);
+		else
+			fprintf(out, "<?UNKNOWN>");
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_DEFAULTUSER: {
+		struct cil_default *def = node->data;
+		fprintf(out, "(defaultuser ");
+		if (def->class_datums)
+			write_datum_list(out, def->class_datums);
+		else
+			write_string_list(out, def->class_strs);
+		if (def->object == CIL_DEFAULT_SOURCE)
+			fprintf(out, " source");
+		else if (def->object == CIL_DEFAULT_TARGET)
+			fprintf(out, " target");
+		else
+			fprintf(out, " <?DEFAULT>");
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_DEFAULTROLE: {
+		struct cil_default *def = node->data;
+		fprintf(out, "(defaultrole ");
+		if (def->class_datums)
+			write_datum_list(out, def->class_datums);
+		else
+			write_string_list(out, def->class_strs);
+		if (def->object == CIL_DEFAULT_SOURCE)
+			fprintf(out, " source");
+		else if (def->object == CIL_DEFAULT_TARGET)
+			fprintf(out, " target");
+		else
+			fprintf(out, " <?DEFAULT>");
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_DEFAULTTYPE: {
+		struct cil_default *def = node->data;
+		fprintf(out, "(defaulttype ");
+		if (def->class_datums)
+			write_datum_list(out, def->class_datums);
+		else
+			write_string_list(out, def->class_strs);
+		if (def->object == CIL_DEFAULT_SOURCE)
+			fprintf(out, " source");
+		else if (def->object == CIL_DEFAULT_TARGET)
+			fprintf(out, " target");
+		else
+			fprintf(out, " <?DEFAULT>");
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_DEFAULTRANGE: {
+		struct cil_defaultrange *def = node->data;
+		fprintf(out, "(defaultrange ");
+		if (def->class_datums)
+			write_datum_list(out, def->class_datums);
+		else
+			write_string_list(out, def->class_strs);
+		if (def->object_range == CIL_DEFAULT_SOURCE_LOW)
+			fprintf(out, " source low");
+		else if (def->object_range == CIL_DEFAULT_SOURCE_HIGH)
+			fprintf(out, " source high");
+		else if (def->object_range == CIL_DEFAULT_SOURCE_LOW_HIGH)
+			fprintf(out, " source low-high");
+		else if (def->object_range == CIL_DEFAULT_TARGET_LOW)
+			fprintf(out, " target low");
+		else if (def->object_range == CIL_DEFAULT_TARGET_HIGH)
+			fprintf(out, " target high");
+		else if (def->object_range == CIL_DEFAULT_TARGET_LOW_HIGH)
+			fprintf(out, " target low-high");
+		else
+			fprintf(out, " <?DEFAULT>");
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_CLASS: {
+		struct cil_class *class = node->data;
+		fprintf(out, "(class %s ", datum_to_str(DATUM(class)));
+		write_node_list(out, node->cl_head);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_CLASSORDER: {
+		struct cil_classorder *classorder = node->data;
+		fprintf(out, "(classorder ");
+		write_string_list(out, classorder->class_list_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_COMMON: {
+		struct cil_class *common = node->data;
+		fprintf(out, "(common %s ", datum_to_str(DATUM(common)));
+		write_node_list(out, node->cl_head);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_CLASSCOMMON: {
+		struct cil_classcommon *cc = node->data;
+		fprintf(out, "(classcommon %s %s)\n", cc->class_str, cc->common_str);
+		break;
+	}
+	case CIL_CLASSPERMISSION: {
+		struct cil_classpermission *cp = node->data;
+		fprintf(out, "(classpermission %s)\n", datum_to_str(DATUM(cp)));
+		break;
+	}
+	case CIL_CLASSPERMISSIONSET: {
+		struct cil_classpermissionset *cps = node->data;
+		fprintf(out, "(classpermissionset %s ", cps->set_str);
+		write_classperms_list(out, cps->classperms);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_MAP_CLASS: {
+		struct cil_class *map = node->data;
+		fprintf(out, "(classmap %s ", datum_to_str(DATUM(map)));
+		write_node_list(out, node->cl_head);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_CLASSMAPPING: {
+		struct cil_classmapping *mapping = node->data;
+		fprintf(out, "(classmapping %s %s ", mapping->map_class_str, mapping->map_perm_str);
+		write_classperms_list(out, mapping->classperms);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_PERMISSIONX: {
+		struct cil_permissionx *permx = node->data;
+		fprintf(out, "(permissionx %s (", datum_to_str(DATUM(permx)));
+		fprintf(out, "%s ", permx->kind == CIL_PERMX_KIND_IOCTL ? "ioctl" : "<?KIND>");
+		fprintf(out, "%s ", datum_or_str(DATUM(permx->obj), permx->obj_str));
+		write_expr(out, permx->expr_str);
+		fprintf(out, "))\n");
+		break;
+	}
+	case CIL_SID: {
+		struct cil_sid *sid = node->data;
+		fprintf(out, "(sid %s)\n", datum_to_str(DATUM(sid)));
+		break;
+	}
+	case CIL_SIDCONTEXT: {
+		struct cil_sidcontext *sidcon = node->data;
+		fprintf(out, "(sidcontext %s ", sidcon->sid_str);
+		if (sidcon->context)
+			write_context(out, sidcon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", sidcon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_SIDORDER: {
+		struct cil_sidorder *sidorder = node->data;
+		fprintf(out, "(sidorder ");
+		write_string_list(out, sidorder->sid_list_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_BOOL: {
+		struct cil_bool *boolean = node->data;
+		fprintf(out, "(boolean %s %s)\n", datum_to_str(DATUM(boolean)), boolean->value ? "true" : "false");
+		break;
+	}
+	case CIL_TUNABLE: {
+		struct cil_tunable *tunable = node->data;
+		fprintf(out, "(tunable %s %s)\n", datum_to_str(DATUM(tunable)), tunable->value ? "true" : "false");
+		break;
+	}
+	case CIL_SENS: {
+		struct cil_sens *sens = node->data;
+		fprintf(out, "(sensitivity %s)\n", datum_to_str(DATUM(sens)));
+		break;
+	}
+	case CIL_SENSALIAS: {
+		struct cil_alias *alias = node->data;
+		fprintf(out, "(sensitivityalias %s)\n", datum_to_str(DATUM(alias)));
+		break;
+	}
+	case CIL_SENSALIASACTUAL: {
+		struct cil_aliasactual *aliasactual = node->data;
+		fprintf(out, "(sensitivityaliasactual %s %s)\n", aliasactual->alias_str, aliasactual->actual_str);
+		break;
+	}
+	case CIL_CAT: {
+		struct cil_cat *cat = node->data;
+		fprintf(out, "(category %s)\n", datum_to_str(DATUM(cat)));
+		break;
+	}
+	case CIL_CATALIAS: {
+		struct cil_alias *alias = node->data;
+		fprintf(out, "(categoryalias %s)\n", datum_to_str(DATUM(alias)));
+		break;
+	}
+	case CIL_CATALIASACTUAL: {
+		struct cil_aliasactual *aliasactual = node->data;
+		fprintf(out, "(categoryaliasactual %s %s)\n", aliasactual->alias_str, aliasactual->actual_str);
+		break;
+	}
+	case CIL_CATSET: {
+		struct cil_catset *catset = node->data;
+		fprintf(out, "(categoryset %s ", datum_to_str(DATUM(catset)));
+		write_cats(out, catset->cats);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_CATORDER: {
+		struct cil_catorder *catorder = node->data;
+		fprintf(out, "(categoryorder ");
+		write_string_list(out, catorder->cat_list_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_SENSCAT: {
+		struct cil_senscat *senscat = node->data;
+		fprintf(out, "(sensitivitycategory ");
+		fprintf(out, "%s ", senscat->sens_str);
+		write_cats(out, senscat->cats);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_SENSITIVITYORDER: {
+		struct cil_sensorder *sensorder = node->data;
+		fprintf(out, "(sensitivityorder ");
+		write_string_list(out, sensorder->sens_list_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_LEVEL: {
+		struct cil_level *level = node->data;
+		fprintf(out, "(level %s ", datum_to_str(&level->datum));
+		write_level(out, level, CIL_FALSE);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_LEVELRANGE: {
+		struct cil_levelrange *lvlrange = node->data;
+		fprintf(out, "(levelrange %s ", datum_to_str(DATUM(lvlrange)));
+		write_range(out, lvlrange, CIL_FALSE);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_USER: {
+		struct cil_user *user = node->data;
+		fprintf(out, "(user %s)\n", datum_to_str(DATUM(user)));
+		break;
+	}
+	case CIL_USERATTRIBUTE: {
+		struct cil_userattribute *attr = node->data;
+		fprintf(out, "(userattribute %s)\n", datum_to_str(DATUM(attr)));
+		break;
+	}
+	case CIL_USERATTRIBUTESET: {
+		struct cil_userattributeset *attr = node->data;
+		fprintf(out, "(userattributeset %s ", attr->attr_str);
+		if (attr->datum_expr)
+			write_expr(out, attr->datum_expr);
+		else
+			write_expr(out, attr->str_expr);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_USERROLE: {
+		struct cil_userrole *userrole = node->data;
+		fprintf(out, "(userrole ");
+		fprintf(out, "%s ", datum_or_str(userrole->user, userrole->user_str));
+		fprintf(out, "%s", datum_or_str(userrole->role, userrole->role_str));
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_USERLEVEL: {
+		struct cil_userlevel *userlevel = node->data;
+		fprintf(out, "(userlevel %s ", userlevel->user_str);
+		if (userlevel->level)
+			write_level(out, userlevel->level, CIL_TRUE);
+		else
+			fprintf(out, "%s", userlevel->level_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_USERRANGE: {
+		struct cil_userrange *userrange = node->data;
+		fprintf(out, "(userrange %s ", userrange->user_str);
+		if (userrange->range)
+			write_range(out, userrange->range, CIL_TRUE);
+		else
+			fprintf(out, "%s", userrange->range_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_USERBOUNDS: {
+		struct cil_bounds *bounds = node->data;
+		fprintf(out, "(userbounds %s %s)\n", bounds->parent_str, bounds->child_str);
+		break;
+	}
+	case CIL_USERPREFIX: {
+		struct cil_userprefix *prefix = node->data;
+		fprintf(out, "(userprefix ");
+		fprintf(out, "%s ", datum_or_str(DATUM(prefix->user), prefix->user_str));
+		fprintf(out, "%s)\n", prefix->prefix_str);
+		break;
+	}
+	case CIL_SELINUXUSER: {
+		struct cil_selinuxuser *selinuxuser = node->data;
+		fprintf(out, "(selinuxuser %s ", selinuxuser->name_str);
+		fprintf(out, "%s ", datum_or_str(DATUM(selinuxuser->user), selinuxuser->user_str));
+		if (selinuxuser->range)
+			write_range(out, selinuxuser->range, CIL_TRUE);
+		else
+			fprintf(out, "%s", selinuxuser->range_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_SELINUXUSERDEFAULT: {
+		struct cil_selinuxuser *selinuxuser = node->data;
+		fprintf(out, "(selinuxuserdefault ");
+		fprintf(out, "%s ", datum_or_str(DATUM(selinuxuser->user), selinuxuser->user_str));
+		if (selinuxuser->range)
+			write_range(out, selinuxuser->range, CIL_TRUE);
+		else
+			fprintf(out, "%s", selinuxuser->range_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_ROLE: {
+		fprintf(out, "(role %s)\n", datum_to_str(node->data));
+		break;
+	}
+	case CIL_ROLEATTRIBUTE: {
+		fprintf(out, "(roleattribute %s)\n", datum_to_str(node->data));
+		break;
+	}
+	case CIL_ROLEATTRIBUTESET: {
+		struct cil_roleattributeset *attr = node->data;
+		fprintf(out, "(roleattributeset %s ", attr->attr_str);
+		if (attr->datum_expr)
+			write_expr(out, attr->datum_expr);
+		else
+			write_expr(out, attr->str_expr);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_ROLETYPE: {
+		struct cil_roletype *roletype = node->data;
+		fprintf(out, "(roletype ");
+		fprintf(out, "%s ", datum_or_str(DATUM(roletype->role), roletype->role_str));
+		fprintf(out, "%s", datum_or_str(DATUM(roletype->type), roletype->type_str));
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_ROLEBOUNDS: {
+		struct cil_bounds *bnds = node->data;
+		fprintf(out, "(rolebounds %s %s)\n", bnds->parent_str, bnds->child_str);
+		break;
+	}
+	case CIL_TYPE: {
+		fprintf(out, "(type %s)\n", datum_to_str(node->data));
+		break;
+	}
+	case CIL_TYPEALIAS: {
+		fprintf(out, "(typealias %s)\n", datum_to_str(node->data));
+		break;
+	}
+	case CIL_TYPEALIASACTUAL: {
+		struct cil_aliasactual *aliasactual = node->data;
+		fprintf(out, "(typealiasactual %s %s)\n", aliasactual->alias_str, aliasactual->actual_str);
+		break;
+	}
+	case CIL_TYPEATTRIBUTE: {
+		fprintf(out, "(typeattribute %s)\n", datum_to_str(node->data));
+		break;
+	}
+	case CIL_TYPEATTRIBUTESET: {
+		struct cil_typeattributeset *attr = node->data;
+		fprintf(out, "(typeattributeset %s ", attr->attr_str);
+		if (attr->datum_expr)
+			write_expr(out, attr->datum_expr);
+		else
+			write_expr(out, attr->str_expr);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_EXPANDTYPEATTRIBUTE: {
+		struct cil_expandtypeattribute *attr = node->data;
+		fprintf(out, "(expandtypeattribute ");
+		if (attr->attr_datums)
+			write_expr(out, attr->attr_datums);
+		else
+			write_expr(out, attr->attr_strs);
+		fprintf(out, " %s)\n", attr->expand ? "true" : "false");
+		break;
+	}
+	case CIL_TYPEPERMISSIVE: {
+		struct cil_typepermissive *tp = node->data;
+		fprintf(out, "(typepermissive ");
+		fprintf(out, "%s", datum_or_str(DATUM(tp->type), tp->type_str));
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_TYPEBOUNDS: {
+		struct cil_bounds *bounds = node->data;
+		fprintf(out, "(typebounds %s %s)\n", bounds->parent_str, bounds->child_str);
+		break;
+	}
+	case CIL_ROLEALLOW: {
+		struct cil_roleallow *roleallow = node->data;
+		fprintf(out, "(roleallow ");
+		fprintf(out, "%s ", datum_or_str(DATUM(roleallow->src), roleallow->src_str));
+		fprintf(out, "%s", datum_or_str(DATUM(roleallow->tgt), roleallow->tgt_str));
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_ROLETRANSITION: {
+		struct cil_roletransition *roletrans = node->data;
+		fprintf(out, "(roletransition ");
+		fprintf(out, "%s ", datum_or_str(DATUM(roletrans->src), roletrans->src_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(roletrans->tgt), roletrans->tgt_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(roletrans->obj), roletrans->obj_str));
+		fprintf(out, "%s", datum_or_str(DATUM(roletrans->result), roletrans->result_str));
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_AVRULE: {
+		struct cil_avrule *rule = node->data;
+		if (rule->rule_kind == AVRULE_ALLOWED)
+			fprintf(out, "(allow ");
+		else if (rule->rule_kind == AVRULE_AUDITALLOW)
+			fprintf(out, "(auditallow ");
+		else if (rule->rule_kind == AVRULE_DONTAUDIT)
+			fprintf(out, "(dontaudit ");
+		else if (rule->rule_kind == AVRULE_NEVERALLOW)
+			fprintf(out, "(neverallow ");
+		else
+			fprintf(out, "(<?AVRULE> ");
+
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->src), rule->src_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->tgt), rule->tgt_str));
+		write_classperms_list(out, rule->perms.classperms);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_AVRULEX: {
+		struct cil_avrule *rule = node->data;
+		if (rule->rule_kind == AVRULE_ALLOWED)
+			fprintf(out, "(allowx ");
+		else if (rule->rule_kind == AVRULE_AUDITALLOW)
+			fprintf(out, "(auditallowx ");
+		else if (rule->rule_kind == AVRULE_DONTAUDIT)
+			fprintf(out, "(dontauditx ");
+		else if (rule->rule_kind == AVRULE_NEVERALLOW)
+			fprintf(out, "(neverallowx ");
+		else
+			fprintf(out, "(<?AVRULEX> ");
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->src), rule->src_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->tgt), rule->tgt_str));
+		if (rule->perms.x.permx_str) {
+			fprintf(out, "%s",rule->perms.x.permx_str);
+		} else {
+			write_permx(out, rule->perms.x.permx);
+		}
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_TYPE_RULE: {
+		struct cil_type_rule *rule = node->data;
+		if (rule->rule_kind == AVRULE_TRANSITION)
+			fprintf(out, "(typetransition ");
+		else if (rule->rule_kind == AVRULE_MEMBER)
+			fprintf(out, "(typemember ");
+		else if (rule->rule_kind == AVRULE_CHANGE)
+			fprintf(out, "(typechange ");
+		else
+			fprintf(out, "(<?TYPERULE> ");
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->src), rule->src_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->tgt), rule->tgt_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->obj), rule->obj_str));
+		fprintf(out, "%s", datum_or_str(DATUM(rule->result), rule->result_str));
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_NAMETYPETRANSITION: {
+		struct cil_nametypetransition *rule = node->data;
+		fprintf(out, "(typetransition ");
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->src), rule->src_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->tgt), rule->tgt_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->obj), rule->obj_str));
+		fprintf(out, "\"%s\" ", datum_or_str(DATUM(rule->name), rule->name_str));
+		fprintf(out, "%s", datum_or_str(DATUM(rule->result), rule->result_str));
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_RANGETRANSITION: {
+		struct cil_rangetransition *rule = node->data;
+		fprintf(out, "(rangetransition ");
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->src), rule->src_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->exec), rule->exec_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(rule->obj), rule->obj_str));
+		if (rule->range)
+			write_range(out, rule->range, CIL_TRUE);
+		else
+			fprintf(out, "%s", rule->range_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_CONSTRAIN: {
+		struct cil_constrain *cons = node->data;
+		fprintf(out, "(constrain ");
+		write_constrain(out, cons);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_MLSCONSTRAIN: {
+		struct cil_constrain *cons = node->data;
+		fprintf(out, "(mlsconstrain ");
+		write_constrain(out, cons);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_VALIDATETRANS: {
+		struct cil_validatetrans *vt = node->data;
+		fprintf(out, "(validatetrans ");
+		fprintf(out, "%s ", datum_or_str(DATUM(vt->class), vt->class_str));
+		if (vt->datum_expr)
+			write_expr(out, vt->datum_expr);
+		else
+			write_expr(out, vt->str_expr);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_MLSVALIDATETRANS: {
+		struct cil_validatetrans *vt = node->data;
+		fprintf(out, "(mlsvalidatetrans ");
+		fprintf(out, "%s ", datum_or_str(DATUM(vt->class), vt->class_str));
+		if (vt->datum_expr)
+			write_expr(out, vt->datum_expr);
+		else
+			write_expr(out, vt->str_expr);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_CONTEXT: {
+		struct cil_context *context = node->data;
+		fprintf(out, "(context %s ", datum_to_str(DATUM(context)));
+		write_context(out, context, CIL_FALSE);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_FILECON: {
+		struct cil_filecon *filecon = node->data;
+		fprintf(out, "(filecon ");
+		fprintf(out, "\"%s\" ", filecon->path_str);
+		if (filecon->type == CIL_FILECON_FILE)
+			fprintf(out, "%s ", CIL_KEY_FILE);
+		else if (filecon->type == CIL_FILECON_DIR)
+			fprintf(out, "%s ", CIL_KEY_DIR);
+		else if (filecon->type == CIL_FILECON_CHAR)
+			fprintf(out, "%s ", CIL_KEY_CHAR);
+		else if (filecon->type == CIL_FILECON_BLOCK)
+			fprintf(out, "%s ", CIL_KEY_BLOCK);
+		else if (filecon->type == CIL_FILECON_SOCKET)
+			fprintf(out, "%s ", CIL_KEY_SOCKET);
+		else if (filecon->type == CIL_FILECON_PIPE)
+			fprintf(out, "%s ", CIL_KEY_PIPE);
+		else if (filecon->type == CIL_FILECON_SYMLINK)
+			fprintf(out, "%s ", CIL_KEY_SYMLINK);
+		else if (filecon->type == CIL_FILECON_ANY)
+			fprintf(out, "%s ", CIL_KEY_ANY);
+		else
+			fprintf(out, "<?FILETYPE> ");
+		if (filecon->context)
+			write_context(out, filecon->context, CIL_TRUE);
+		else if (filecon->context_str)
+			fprintf(out, "%s", filecon->context_str);
+		else
+			fprintf(out, "()");
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_IBPKEYCON: {
+		struct cil_ibpkeycon *ibpkeycon = node->data;
+		fprintf(out, "(ibpkeycon %s ", ibpkeycon->subnet_prefix_str);
+		fprintf(out, "(%d %d) ", ibpkeycon->pkey_low, ibpkeycon->pkey_high);
+		if (ibpkeycon->context)
+			write_context(out, ibpkeycon->context, CIL_TRUE);
+		else if (ibpkeycon->context_str)
+			fprintf(out, "%s", ibpkeycon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_PORTCON: {
+		struct cil_portcon *portcon = node->data;
+		fprintf(out, "(portcon ");
+		if (portcon->proto == CIL_PROTOCOL_UDP)
+			fprintf(out, " udp ");
+		else if (portcon->proto == CIL_PROTOCOL_TCP)
+			fprintf(out, " tcp ");
+		else if (portcon->proto == CIL_PROTOCOL_DCCP)
+			fprintf(out, "dccp ");
+		else if (portcon->proto == CIL_PROTOCOL_SCTP)
+			fprintf(out, "sctp ");
+		else
+			fprintf(out, "<?PROTOCOL> ");
+		if (portcon->port_low == portcon->port_high)
+			fprintf(out, "%d ", portcon->port_low);
+		else
+			fprintf(out, "(%d %d) ", portcon->port_low, portcon->port_high);
+		if (portcon->context)
+			write_context(out, portcon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", portcon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_NODECON: {
+		struct cil_nodecon *nodecon = node->data;
+		fprintf(out, "(nodecon ");
+		if (nodecon->addr)
+			write_ipaddr(out, nodecon->addr);
+		else
+			fprintf(out, "%s ", nodecon->addr_str);
+		fprintf(out, " ");
+		if (nodecon->mask)
+			write_ipaddr(out, nodecon->mask);
+		else
+			fprintf(out, "%s ", nodecon->mask_str);
+		fprintf(out, " ");
+		if (nodecon->context)
+			write_context(out, nodecon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", nodecon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_GENFSCON: {
+		struct cil_genfscon *genfscon = node->data;
+		fprintf(out, "(genfscon ");
+		fprintf(out, "%s \"%s\" ", genfscon->fs_str, genfscon->path_str);
+		if (genfscon->context)
+			write_context(out, genfscon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", genfscon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_NETIFCON: {
+		struct cil_netifcon *netifcon = node->data;
+		fprintf(out, "(netifcon %s ", netifcon->interface_str);
+		if (netifcon->if_context)
+			write_context(out, netifcon->if_context, CIL_TRUE);
+		else
+			fprintf(out, "%s", netifcon->if_context_str);
+		fprintf(out, " ");
+		if (netifcon->packet_context)
+			write_context(out, netifcon->packet_context, CIL_TRUE);
+		else
+			fprintf(out, "%s", netifcon->packet_context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_IBENDPORTCON: {
+		struct cil_ibendportcon *ibendportcon = node->data;
+		fprintf(out, "(ibendportcon %s %u ", ibendportcon->dev_name_str, ibendportcon->port);
+		if (ibendportcon->context)
+			write_context(out, ibendportcon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", ibendportcon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_PIRQCON: {
+		struct cil_pirqcon *pirqcon = node->data;
+		fprintf(out, "(pirqcon %d ", pirqcon->pirq);
+		if (pirqcon->context)
+			write_context(out, pirqcon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", pirqcon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_IOMEMCON: {
+		struct cil_iomemcon *iomemcon = node->data;
+		fprintf(out, "(iomemcon (%"PRId64" %"PRId64") ", iomemcon->iomem_low, iomemcon->iomem_high);
+		if (iomemcon->context)
+			write_context(out, iomemcon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", iomemcon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_IOPORTCON: {
+		struct cil_ioportcon *ioportcon = node->data;
+		fprintf(out, "(ioportcon ");
+		if (ioportcon->ioport_low == ioportcon->ioport_high)
+			fprintf(out, "%d ", ioportcon->ioport_low);
+		else
+			fprintf(out, "(%d %d) ", ioportcon->ioport_low, ioportcon->ioport_high);
+
+		if (ioportcon->context)
+			write_context(out, ioportcon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", ioportcon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_PCIDEVICECON: {
+		struct cil_pcidevicecon *pcidevicecon = node->data;
+		fprintf(out, "(pcidevicecon %d ", pcidevicecon->dev);
+		if (pcidevicecon->context)
+			write_context(out, pcidevicecon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", pcidevicecon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_DEVICETREECON: {
+		struct cil_devicetreecon *devicetreecon = node->data;
+		fprintf(out, "(devicetreecon \"%s\" ", devicetreecon->path);
+		if (devicetreecon->context)
+			write_context(out, devicetreecon->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", devicetreecon->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_FSUSE: {
+		struct cil_fsuse *fsuse = node->data;
+		fprintf(out, "(fsuse ");
+		if (fsuse->type == CIL_FSUSE_XATTR)
+			fprintf(out, "xattr ");
+		else if (fsuse->type == CIL_FSUSE_TASK)
+			fprintf(out, "task ");
+		else if (fsuse->type == CIL_FSUSE_TRANS)
+			fprintf(out, "trans ");
+		else
+			fprintf(out, "<?TYPE> ");
+		fprintf(out, "%s ", fsuse->fs_str);
+		if (fsuse->context)
+			write_context(out, fsuse->context, CIL_TRUE);
+		else
+			fprintf(out, "%s", fsuse->context_str);
+		fprintf(out, ")\n");
+		break;
+	}
+	case CIL_POLICYCAP: {
+		struct cil_policycap *polcap = node->data;
+		fprintf(out, "(policycap %s)\n", polcap->datum.name);
+		break;
+	}
+	case CIL_IPADDR: {
+		struct cil_ipaddr *ipaddr = node->data;
+		char buf[256];
+		if (inet_ntop(ipaddr->family, &ipaddr->ip, buf, 256) == NULL)
+			strcpy(buf, "<?IPADDR>");
+		fprintf(out, "(ipaddr %s %s)\n", datum_to_str(&ipaddr->datum), buf);
+		break;
+	}
+	default :
+		fprintf(out, "(<?RULE:%s>)\n", cil_node_to_string(node));
+		break;
+	}
+}
+
+/*
+ * Tree walk data and helper functions for writing the AST of the various phases
+ */
+
+struct cil_write_ast_args {
+	FILE *out;
+	int depth;
+};
+
+/*
+ * Helper functions for writing the parse AST
+ */
+
+static int __write_parse_ast_node_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
+{
+	struct cil_write_ast_args *args = extra_args;
+
+	fprintf(args->out, "%*s", args->depth*4, "");
+	if (!node->data) {
+		if (node->cl_head)
+			fprintf(args->out, "(\n");
+		else
+			fprintf(args->out, "()\n");
+	} else {
+		char *str = (char *)node->data;
+		size_t len = strlen(str);
+		size_t i;
+
+		for (i = 0; i < len; i++) {
+			if (isspace(str[i])) {
+				fprintf(args->out, "\"%s\"\n", str);
+				return SEPOL_OK;
+			}
+		}
+
+		fprintf(args->out, "%s\n", (char *)node->data);
+	}
+
+	return SEPOL_OK;
+}
+
+static int __write_parse_ast_first_child_helper(struct cil_tree_node *node, void *extra_args)
+{
+	struct cil_write_ast_args *args = extra_args;
+	struct cil_tree_node *parent = node->parent;
+
+	if (parent->flavor != CIL_ROOT) {
+		args->depth++;
+	}
+
+	return SEPOL_OK;
+}
+
+static int __write_parse_ast_last_child_helper(struct cil_tree_node *node, void *extra_args)
+{
+	struct cil_write_ast_args *args = extra_args;
+	struct cil_tree_node *parent = node->parent;
+
+	if (parent->flavor == CIL_ROOT) {
+		return SEPOL_OK;
+	}
+
+	args->depth--;
+	fprintf(args->out, "%*s", args->depth*4, "");
+	fprintf(args->out, ")\n");
+
+	return SEPOL_OK;
+}
+
+/*
+ * Helper functions for writing the CIL AST for the build and resolve phases
+ */
+
+static int __write_cil_ast_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
+{
+	struct cil_write_ast_args *args = extra_args;
+
+	if (node->flavor == CIL_SRC_INFO)
+		return SEPOL_OK;
+
+	fprintf(args->out, "%*s", args->depth*4, "");
+
+	cil_write_ast_node(args->out, node);
+
+	if (node->flavor == CIL_CLASS || node->flavor == CIL_COMMON || node->flavor == CIL_MAP_CLASS) {
+		*finished = CIL_TREE_SKIP_HEAD;
+	}
+
+	return SEPOL_OK;
+}
+
+static int __write_cil_ast_first_child_helper(struct cil_tree_node *node, void *extra_args)
+{
+	struct cil_write_ast_args *args = extra_args;
+	struct cil_tree_node *parent = node->parent;
+
+	if (parent->flavor != CIL_SRC_INFO && parent->flavor != CIL_ROOT) {
+		args->depth++;
+	}
+
+	return SEPOL_OK;
+}
+
+static int __write_cil_ast_last_child_helper(struct cil_tree_node *node, void *extra_args)
+{
+	struct cil_write_ast_args *args = extra_args;
+	struct cil_tree_node *parent = node->parent;
+
+	if (parent->flavor == CIL_SRC_INFO || parent->flavor == CIL_ROOT) {
+		return SEPOL_OK;
+	}
+
+	args->depth--;
+	fprintf(args->out, "%*s", args->depth*4, "");
+	fprintf(args->out, ")\n");
+
+	return SEPOL_OK;
+}
+
+int cil_write_ast(FILE *out, enum cil_write_ast_phase phase, struct cil_tree_node *node)
+{
+	struct cil_write_ast_args extra_args;
+	int rc;
+
+	extra_args.out = out;
+	extra_args.depth = 0;
+
+	if (phase == CIL_WRITE_AST_PHASE_PARSE) {
+		rc = cil_tree_walk(node, __write_parse_ast_node_helper, __write_parse_ast_first_child_helper, __write_parse_ast_last_child_helper, &extra_args);
+	} else {
+		rc = cil_tree_walk(node, __write_cil_ast_node_helper, __write_cil_ast_first_child_helper, __write_cil_ast_last_child_helper, &extra_args);
+	}
+
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to write AST\n");
+		return SEPOL_ERR;
+	}
+
+	return SEPOL_OK;
+}
diff --git a/libsepol/cil/src/cil_write_ast.h b/libsepol/cil/src/cil_write_ast.h
new file mode 100644
index 00000000..9d666b8a
--- /dev/null
+++ b/libsepol/cil/src/cil_write_ast.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright 2011 Tresys Technology, LLC. All rights reserved.
+ * 
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ * 
+ *    1. Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ * 
+ *    2. Redistributions in binary form must reproduce the above copyright notice,
+ *       this list of conditions and the following disclaimer in the documentation
+ *       and/or other materials provided with the distribution.
+ * 
+ * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY EXPRESS
+ * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
+ * EVENT SHALL TRESYS TECHNOLOGY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ * 
+ * The views and conclusions contained in the software and documentation are those
+ * of the authors and should not be interpreted as representing official policies,
+ * either expressed or implied, of Tresys Technology, LLC.
+ */
+
+#ifndef CIL_WRITE_AST_H_
+#define CIL_WRITE_AST_H_
+
+#include <stdio.h>
+
+#include "cil_tree.h"
+
+enum cil_write_ast_phase {
+	CIL_WRITE_AST_PHASE_PARSE = 0,
+	CIL_WRITE_AST_PHASE_BUILD,
+	CIL_WRITE_AST_PHASE_RESOLVE,
+};
+
+void cil_write_ast_node(FILE *out, struct cil_tree_node *node);
+int cil_write_ast(FILE *out, enum cil_write_ast_phase phase, struct cil_tree_node *node);
+
+#endif /* CIL_WRITE_AST_H_ */
+
-- 
2.26.3

