Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C001CC77B73
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 12:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjDTM6M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 08:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDTM6K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 08:58:10 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED21B9
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 05:58:08 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-74e19dcf217so32371085a.2
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681995487; x=1684587487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DL1VGdOjmK08RtAiKgjYYWfxfzo6g6KGVCEZUQTl/bI=;
        b=kK6yW2ivvzcJw5ZeyPoWYR5UqsBFQR5hEW3/D/DGItFKkmlIuqXeHlhYLkHyb98ZJU
         oz0+it2PXc7XbuQ/Z8gyqG+akvS6MGb3OG3SA1vagZZpPtcdFotj9xzTrJ6Z8p9Isy3o
         X2gK/lIvlJ0XhHPXEnaA1ixeU/Fw+/uVaFAM/zn8heiHqPGyweC+4G8Xoc6gOoKShbEj
         gfh96XBegRhoLVlQuCpyXptxOtDzxIkUz/Ypy8uLqYUnNLebVt08iMt3kHbgblwJXa1u
         hC1cDSDN6MrJPRq0xYNa95poWLi4nW1DsfCMewizIM+9FQXjYTfQtcTx8NoBUvPX1Q4Z
         wCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681995487; x=1684587487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DL1VGdOjmK08RtAiKgjYYWfxfzo6g6KGVCEZUQTl/bI=;
        b=hdyb7dAKcnr99AS1HyoT70QDx2qYMeRdc5UjzBwuosYHFF+ggJVWgqJl4q7MbPwdCZ
         oGNgNrP5dxq0GeEulNF+56/LjH/JOECuqbacu1ELkXLZ9JUdd8jZGzsUPPHpItJR394k
         UNuvtTaH89Yp9rTZsGhJ3t/r60/+2YR5M92Dtx1zFyVC9pRzqamJHSFxV7cyPLB6Jd4k
         I00xa7WqVX3tj5wwhpkGQ8Ej0U2xJ9cbS+2Escp/UkCQXL3Ev52Rwr2qF62uUA7dZkdl
         UE82ULFPofxRQMPY9ZMBBiikB0JyHxOU51iivCe5p+Cz1NQj/jKl3FJJ2dzOxmtEknBQ
         MrMg==
X-Gm-Message-State: AAQBX9dcKJOK6rAYlHMYzb+DBDIEeNxPBnXtG7HF1fgcSqu6ierKk09U
        s233D7EBhJxvrMuI4ekPHzeNqlnij/o=
X-Google-Smtp-Source: AKy350b/1KUXzy+hKXZH9e0WxLJkWbJwbTicnb7yXmC3k8y+bNzrag/PYTXwQSLKAObKmt4/akbIYg==
X-Received: by 2002:a05:6214:d4e:b0:5eb:74ab:2e5e with SMTP id 14-20020a0562140d4e00b005eb74ab2e5emr1919079qvr.11.1681995486834;
        Thu, 20 Apr 2023 05:58:06 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id x16-20020a0cb210000000b005fcbafebfeasm215242qvd.46.2023.04.20.05.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:58:06 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Fix class permission verification in CIL
Date:   Thu, 20 Apr 2023 08:58:01 -0400
Message-Id: <20230420125801.999381-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Before the CIL post processing phase (where expressions are evaluated,
various ebitmaps are set, etc) there is a pre-verification where
checks are made to find self references or loops in bounds, attribute
sets, and class permissions. The class permission checking is faulty
in two ways.

First, it does not check for the use of "all" in a permission expression
for a class that has no permissions. An error will still be generated
later and secilc will exit cleanly, but without an error message that
explains the problem.

Second, it does not properly handle lists in permission expressions.
For example, "(C ((P)))" is a legitimate class permission. The
permissions expression contains one item that is a list containing
one permission. This permission expression will be properly evaluated.
Unfortunately, the class permission verification assumes that each
item in the permission expression is either an operator or a
permission datum and a segmenation fault will occur.

Refactor the class permission checking to give a proper error when
"all" is used in a permission expression for a class that has no
permissions and so that it can handle lists in permission
expressions. Also, check for the actual flavor of each item in
the permission expression and return an error if an unexpected
flavor is found.

The failure to properly handle lists in permission expressions was
found by oss-fuzz (#58085).

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_verify.c | 167 +++++++++++++++++++++++-----------
 1 file changed, 114 insertions(+), 53 deletions(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 4640dc59..3f58969d 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1700,31 +1700,109 @@ static int __add_perm_to_list(__attribute__((unused)) hashtab_key_t k, hashtab_d
 	return SEPOL_OK;
 }
 
-static int __cil_verify_classperms(struct cil_list *classperms,
-				   struct cil_symtab_datum *orig,
-				   struct cil_symtab_datum *parent,
-				   struct cil_symtab_datum *cur,
-				   enum cil_flavor flavor,
-				   unsigned steps, unsigned limit)
+static int __cil_verify_classperms(struct cil_list *classperms, struct cil_symtab_datum *orig, struct cil_symtab_datum *cur, unsigned steps, unsigned limit);
+
+static int __cil_verify_map_perm(struct cil_class *class, struct cil_perm *perm, struct cil_symtab_datum *orig, unsigned steps, unsigned limit)
+{
+	int rc;
+
+	if (!perm->classperms) {
+		cil_tree_log(NODE(class), CIL_ERR, "No class permissions for map class %s, permission %s", DATUM(class)->name, DATUM(perm)->name);
+		goto exit;
+	}
+
+	rc = __cil_verify_classperms(perm->classperms, orig, &perm->datum, steps, limit);
+	if (rc != SEPOL_OK) {
+		cil_tree_log(NODE(class), CIL_ERR, "There was an error verifying class permissions for map class %s, permission %s", DATUM(class)->name, DATUM(perm)->name);
+		goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return SEPOL_ERR;
+}
+
+
+static int __cil_verify_perms(struct cil_class *class, struct cil_list *perms, struct cil_symtab_datum *orig, unsigned steps, unsigned limit)
 {
 	int rc = SEPOL_ERR;
-	struct cil_list_item *curr;
+	int count = 0;
+	struct cil_list_item *i = NULL;
 
-	if (classperms == NULL) {
-		if (flavor == CIL_MAP_PERM) {
-			cil_tree_log(NODE(cur), CIL_ERR, "Map class %s does not have a classmapping for %s", parent->name, cur->name);
+	if (!perms) {
+		cil_tree_log(NODE(class), CIL_ERR, "No permissions for class %s in class permissions", DATUM(class)->name);
+		goto exit;
+	}
+
+	cil_list_for_each(i, perms) {
+		count++;
+		if (i->flavor == CIL_LIST) {
+			rc = __cil_verify_perms(class, i->data, orig, steps, limit);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+		} else if (i->flavor == CIL_DATUM) {
+			struct cil_perm *perm = i->data;
+			if (FLAVOR(perm) == CIL_MAP_PERM) {
+				rc = __cil_verify_map_perm(class, perm, orig, steps, limit);
+				if (rc != SEPOL_OK) {
+					goto exit;
+				}
+			}
+		} else if (i->flavor == CIL_OP) {
+			enum cil_flavor op = (enum cil_flavor)(uintptr_t)i->data;
+			if (op == CIL_ALL) {
+				struct cil_list *perm_list;
+				struct cil_list_item *j = NULL;
+				int count2 = 0;
+				cil_list_init(&perm_list, CIL_MAP_PERM);
+				cil_symtab_map(&class->perms, __add_perm_to_list, perm_list);
+				cil_list_for_each(j, perm_list) {
+					count2++;
+					struct cil_perm *perm = j->data;
+					if (FLAVOR(perm) == CIL_MAP_PERM) {
+						rc = __cil_verify_map_perm(class, perm, orig, steps, limit);
+						if (rc != SEPOL_OK) {
+							cil_list_destroy(&perm_list, CIL_FALSE);
+							goto exit;
+						}
+					}
+				}
+				cil_list_destroy(&perm_list, CIL_FALSE);
+				if (count2 == 0) {
+					cil_tree_log(NODE(class), CIL_ERR, "Operator \"all\" used for %s which has no permissions associated with it", DATUM(class)->name);
+					goto exit;
+				}
+			}
 		} else {
-			cil_tree_log(NODE(cur), CIL_ERR, "Classpermission %s does not have a classpermissionset", cur->name);
+			cil_tree_log(NODE(class), CIL_ERR, "Permission list for %s has an unexpected flavor: %d", DATUM(class)->name, i->flavor);
+			goto exit;
 		}
+	}
+
+	if (count == 0) {
+		cil_tree_log(NODE(class), CIL_ERR, "Empty permissions list for class %s in class permissions", DATUM(class)->name);
+		goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return SEPOL_ERR;
+}
+
+static int __cil_verify_classperms(struct cil_list *classperms, struct cil_symtab_datum *orig, struct cil_symtab_datum *cur, unsigned steps, unsigned limit)
+{
+	int rc;
+	struct cil_list_item *i;
+
+	if (classperms == NULL) {
 		goto exit;
 	}
 
 	if (steps > 0 && orig == cur) {
-		if (flavor == CIL_MAP_PERM) {
-			cil_tree_log(NODE(cur), CIL_ERR, "Found circular class permissions involving the map class %s and permission %s", parent->name, cur->name);
-		} else {
-			cil_tree_log(NODE(cur), CIL_ERR, "Found circular class permissions involving the set %s", cur->name);
-		}
+		cil_tree_log(NODE(cur), CIL_ERR, "Found circular class permissions involving %s", cur->name);
 		goto exit;
 	} else {
 		steps++;
@@ -1735,44 +1813,20 @@ static int __cil_verify_classperms(struct cil_list *classperms,
 		}
 	}
 
-	cil_list_for_each(curr, classperms) {
-		if (curr->flavor == CIL_CLASSPERMS) {
-			struct cil_classperms *cp = curr->data;
-			if (FLAVOR(cp->class) != CIL_CLASS) { /* MAP */
-				struct cil_list_item *i = NULL;
-				cil_list_for_each(i, cp->perms) {
-					if (i->flavor != CIL_OP) {
-						struct cil_perm *cmp = i->data;
-						rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
-						if (rc != SEPOL_OK) {
-							goto exit;
-						}
-					} else {
-						enum cil_flavor op = (enum cil_flavor)(uintptr_t)i->data;
-						if (op == CIL_ALL) {
-							struct cil_class *mc = cp->class;
-							struct cil_list *perm_list;
-							struct cil_list_item *j = NULL;
-
-							cil_list_init(&perm_list, CIL_MAP_PERM);
-							cil_symtab_map(&mc->perms, __add_perm_to_list, perm_list);
-							cil_list_for_each(j, perm_list) {
-								struct cil_perm *cmp = j->data;
-								rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
-								if (rc != SEPOL_OK) {
-									cil_list_destroy(&perm_list, CIL_FALSE);
-									goto exit;
-								}
-							}
-							cil_list_destroy(&perm_list, CIL_FALSE);
-						}
-					}
-				}
+	cil_list_for_each(i, classperms) {
+		if (i->flavor == CIL_CLASSPERMS) {
+			struct cil_classperms *cp = i->data;
+			rc = __cil_verify_perms(cp->class, cp->perms, orig, steps, limit);
+			if (rc != SEPOL_OK) {
+				goto exit;
 			}
 		} else { /* SET */
-			struct cil_classperms_set *cp_set = curr->data;
+			struct cil_classperms_set *cp_set = i->data;
 			struct cil_classpermission *cp = cp_set->set;
-			rc = __cil_verify_classperms(cp->classperms, orig, NULL, &cp->datum, CIL_CLASSPERMISSION, steps, limit);
+			if (!cp->classperms) {
+				cil_tree_log(NODE(cur), CIL_ERR, "Classpermission %s does not have a classpermissionset", DATUM(cp)->name);
+			}
+			rc = __cil_verify_classperms(cp->classperms, orig, &cp->datum, steps, limit);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
@@ -1787,9 +1841,15 @@ exit:
 
 static int __cil_verify_classpermission(struct cil_tree_node *node)
 {
+	int rc;
 	struct cil_classpermission *cp = node->data;
 
-	return __cil_verify_classperms(cp->classperms, &cp->datum, NULL, &cp->datum, CIL_CLASSPERMISSION, 0, 2);
+	rc = __cil_verify_classperms(cp->classperms, &cp->datum, &cp->datum, 0, 2);
+	if (rc != SEPOL_OK) {
+		cil_tree_log(node, CIL_ERR, "Error verifying class permissions for classpermission %s", DATUM(cp)->name);
+	}
+
+	return rc;
 }
 
 struct cil_verify_map_args {
@@ -1804,8 +1864,9 @@ static int __verify_map_perm_classperms(__attribute__((unused)) hashtab_key_t k,
 	struct cil_perm *cmp = (struct cil_perm *)d;
 	int rc;
 
-	rc = __cil_verify_classperms(cmp->classperms, &cmp->datum, &map_args->class->datum, &cmp->datum, CIL_MAP_PERM, 0, 2);
+	rc = __cil_verify_classperms(cmp->classperms, &cmp->datum, &cmp->datum, 0, 2);
 	if (rc != SEPOL_OK) {
+		cil_tree_log(NODE(cmp), CIL_ERR, "Error verifying class permissions for map class %s, permission %s", DATUM(map_args->class)->name, DATUM(cmp)->name);
 		map_args->rc = rc;
 	}
 
-- 
2.39.2

