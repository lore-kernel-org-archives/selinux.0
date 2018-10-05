Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F1AC65BA7
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E6C20834
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E6C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeJEVGP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:06:15 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:63163 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbeJEVGP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 17:06:15 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2018 17:06:13 EDT
X-EEMSG-check-008: 322824831|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Oct 2018 13:57:10 +0000
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="19089839"
IronPort-PHdr: =?us-ascii?q?9a23=3AO59wFBSLGSWdR+KiGctmOijYBdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa69YByN2/xhgRfzUJnB7Loc0qyK6/+mATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbF/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4KlxSB/slSwJKTg3/m/KgcB0la5Xvg6tqxl5zoXJYo+aKeB+c7vdc90EWG?=
 =?us-ascii?q?RPUMVfWStDDYOydIYDE/YNMPxEo4Tnu1cCsR2zDhSsCuP1zT9Ig2f706kg3O?=
 =?us-ascii?q?QkDw7GxxErEswUv3TOsNX6Kr0SWv2ywanKwzTMc+lZ2S3h6ITWaR0hvfGNUq?=
 =?us-ascii?q?5wccrW00UvERjFgU+KpYzqODOVyP0Avm6G5ORjTeKik3Mrpg5+rzS1xsogl5?=
 =?us-ascii?q?PFipwax1za7yl13YA4LsCiRkFhe96rCp5QujmfN4txX8wtXXlluD0/yr0aoZ?=
 =?us-ascii?q?67ezUKyIg/yx7fdfOHd4+I7wr/VOmLOzd4hW9leKmlixau8Umv1u38Vs6u3F?=
 =?us-ascii?q?ZMsiVFicXDumoI1xzS7siLUvp9/kG/1jaTzw3f9+5JLE8umafbNpIt2KA8m5?=
 =?us-ascii?q?UNvUjZAyP6gED2g7WXdkUg9Oio8ePnYrD+q5+eOY57lhvxMr4ymsChGuk4Lg?=
 =?us-ascii?q?gPUHSb+eS7zrHj+1b5T69Qgv05lanZrojWJd4Hqa6hHw9VzoEj5g6kDzi41N?=
 =?us-ascii?q?QYnH8HLE9KeR+ckYjpNE/BIOriAfe8nVusijFryO7CPrH7BZXNNHfDw//deu?=
 =?us-ascii?q?Nm5kpdzhcj5c5Q6ogSCbwbJv/3HEjru4/2FBg8Zi69xuv8QP50zJ8TQyrbAL?=
 =?us-ascii?q?CSObnO63eU9+kvJK+Kf4ZTtzHjfat2r8XyhGM0zAdONZKi2oEaPTXiRvk=3D?=
X-IPAS-Result: =?us-ascii?q?A2BjAABdbLdb/wHyM5BjHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?VsqgWUomC9MAQEBAQEBBookiQuEZIF6IBgBhEAChCwhNQwNAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjYkgmAGgQlRVxmCYj+BdQ2lXIR3hRyHE4QegRCBB4ESjWgCgSgBhy6VC?=
 =?us-ascii?q?wYDkDsLF490LJZ+ATWBVSsIAhgpgWiBToImF440IzB7AQGNTwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Oct 2018 13:57:09 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w95Dv6Kt003753
        for <selinux@vger.kernel.org>; Fri, 5 Oct 2018 09:57:09 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] libsepol: Rename kernel_to_common.c stack functions
Date:   Fri,  5 Oct 2018 09:57:26 -0400
Message-Id: <20181005135729.13998-2-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005135729.13998-1-jwcart2@tycho.nsa.gov>
References: <20181005135729.13998-1-jwcart2@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Want to make use of selinux_sid_to_str[] and xen_sid_to_str[] from
kernel_to_common.h in module_to_cil.c, but stack functions with the
same names exist in module_to_cil.c and kernel_to_common.c (with
the function prototypes in kernel_to_common.h).

Since the stack functions in kernel_to_common.c are less general and
only work with strings, rename those functions from stack_* to
strs_stack_*.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/kernel_to_cil.c    | 36 ++++++++++++++++-----------------
 libsepol/src/kernel_to_common.c | 10 ++++-----
 libsepol/src/kernel_to_common.h | 10 ++++-----
 libsepol/src/kernel_to_conf.c   | 36 ++++++++++++++++-----------------
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index b1eb66d6..c2a733ee 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -36,7 +36,7 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 	char *str = NULL;
 	int rc;
 
-	rc = stack_init(&stack);
+	rc = strs_stack_init(&stack);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -65,13 +65,13 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 			}
 
 			if (num_params == 2) {
-				val2 = stack_pop(stack);
+				val2 = strs_stack_pop(stack);
 				if (!val2) {
 					sepol_log_err("Invalid conditional expression");
 					goto exit;
 				}
 			}
-			val1 = stack_pop(stack);
+			val1 = strs_stack_pop(stack);
 			if (!val1) {
 				sepol_log_err("Invalid conditional expression");
 				free(val2);
@@ -89,29 +89,29 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 			sepol_log_err("Invalid conditional expression");
 			goto exit;
 		}
-		rc = stack_push(stack, new_val);
+		rc = strs_stack_push(stack, new_val);
 		if (rc != 0) {
 			sepol_log_err("Out of memory");
 			goto exit;
 		}
 	}
 
-	new_val = stack_pop(stack);
-	if (!new_val || !stack_empty(stack)) {
+	new_val = strs_stack_pop(stack);
+	if (!new_val || !strs_stack_empty(stack)) {
 		sepol_log_err("Invalid conditional expression");
 		goto exit;
 	}
 
 	str = new_val;
 
-	stack_destroy(&stack);
+	strs_stack_destroy(&stack);
 	return str;
 
 exit:
-	while ((new_val = stack_pop(stack)) != NULL) {
+	while ((new_val = strs_stack_pop(stack)) != NULL) {
 		free(new_val);
 	}
-	stack_destroy(&stack);
+	strs_stack_destroy(&stack);
 
 	return NULL;
 }
@@ -127,7 +127,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 
 	*use_mls = 0;
 
-	rc = stack_init(&stack);
+	rc = strs_stack_init(&stack);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -208,13 +208,13 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			}
 
 			if (num_params == 2) {
-				val2 = stack_pop(stack);
+				val2 = strs_stack_pop(stack);
 				if (!val2) {
 					sepol_log_err("Invalid constraint expression");
 					goto exit;
 				}
 			}
-			val1 = stack_pop(stack);
+			val1 = strs_stack_pop(stack);
 			if (!val1) {
 				sepol_log_err("Invalid constraint expression");
 				goto exit;
@@ -231,30 +231,30 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 		if (!new_val) {
 			goto exit;
 		}
-		rc = stack_push(stack, new_val);
+		rc = strs_stack_push(stack, new_val);
 		if (rc != 0) {
 			sepol_log_err("Out of memory");
 			goto exit;
 		}
 	}
 
-	new_val = stack_pop(stack);
-	if (!new_val || !stack_empty(stack)) {
+	new_val = strs_stack_pop(stack);
+	if (!new_val || !strs_stack_empty(stack)) {
 		sepol_log_err("Invalid constraint expression");
 		goto exit;
 	}
 
 	str = new_val;
 
-	stack_destroy(&stack);
+	strs_stack_destroy(&stack);
 
 	return str;
 
 exit:
-	while ((new_val = stack_pop(stack)) != NULL) {
+	while ((new_val = strs_stack_pop(stack)) != NULL) {
 		free(new_val);
 	}
-	stack_destroy(&stack);
+	strs_stack_destroy(&stack);
 
 	return NULL;
 }
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 7c5699c5..891e139c 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -400,27 +400,27 @@ exit:
 	return str;
 }
 
-int stack_init(struct strs **stack)
+int strs_stack_init(struct strs **stack)
 {
 	return strs_init(stack, STACK_SIZE);
 }
 
-void stack_destroy(struct strs **stack)
+void strs_stack_destroy(struct strs **stack)
 {
 	return strs_destroy(stack);
 }
 
-int stack_push(struct strs *stack, char *s)
+int strs_stack_push(struct strs *stack, char *s)
 {
 	return strs_add(stack, s);
 }
 
-char *stack_pop(struct strs *stack)
+char *strs_stack_pop(struct strs *stack)
 {
 	return strs_remove_last(stack);
 }
 
-int stack_empty(struct strs *stack)
+int strs_stack_empty(struct strs *stack)
 {
 	return strs_num_items(stack) == 0;
 }
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 992929ae..7c5edbd6 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -105,10 +105,10 @@ int hashtab_ordered_to_strs(char *key, void *data, void *args);
 int ebitmap_to_strs(struct ebitmap *map, struct strs *strs, char **val_to_name);
 char *ebitmap_to_str(struct ebitmap *map, char **val_to_name, int sort);
 
-int stack_init(struct strs **stack);
-void stack_destroy(struct strs **stack);
-int stack_push(struct strs *stack, char *s);
-char *stack_pop(struct strs *stack);
-int stack_empty(struct strs *stack);
+int strs_stack_init(struct strs **stack);
+void strs_stack_destroy(struct strs **stack);
+int strs_stack_push(struct strs *stack, char *s);
+char *strs_stack_pop(struct strs *stack);
+int strs_stack_empty(struct strs *stack);
 
 int sort_ocontexts(struct policydb *pdb);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 95405207..a98b5ca9 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -35,7 +35,7 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 	char *str = NULL;
 	int rc;
 
-	rc = stack_init(&stack);
+	rc = strs_stack_init(&stack);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -63,13 +63,13 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 			}
 
 			if (num_params == 2) {
-				val2 = stack_pop(stack);
+				val2 = strs_stack_pop(stack);
 				if (!val2) {
 					sepol_log_err("Invalid conditional expression");
 					goto exit;
 				}
 			}
-			val1 = stack_pop(stack);
+			val1 = strs_stack_pop(stack);
 			if (!val1) {
 				sepol_log_err("Invalid conditional expression");
 				free(val2);
@@ -87,29 +87,29 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 			sepol_log_err("Invalid conditional expression");
 			goto exit;
 		}
-		rc = stack_push(stack, new_val);
+		rc = strs_stack_push(stack, new_val);
 		if (rc != 0) {
 			sepol_log_err("Out of memory");
 			goto exit;
 		}
 	}
 
-	new_val = stack_pop(stack);
-	if (!new_val || !stack_empty(stack)) {
+	new_val = strs_stack_pop(stack);
+	if (!new_val || !strs_stack_empty(stack)) {
 		sepol_log_err("Invalid conditional expression");
 		goto exit;
 	}
 
 	str = new_val;
 
-	stack_destroy(&stack);
+	strs_stack_destroy(&stack);
 	return str;
 
 exit:
-	while ((new_val = stack_pop(stack)) != NULL) {
+	while ((new_val = strs_stack_pop(stack)) != NULL) {
 		free(new_val);
 	}
-	stack_destroy(&stack);
+	strs_stack_destroy(&stack);
 
 	return NULL;
 }
@@ -125,7 +125,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 
 	*use_mls = 0;
 
-	rc = stack_init(&stack);
+	rc = strs_stack_init(&stack);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -204,13 +204,13 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			}
 
 			if (num_params == 2) {
-				val2 = stack_pop(stack);
+				val2 = strs_stack_pop(stack);
 				if (!val2) {
 					sepol_log_err("Invalid constraint expression");
 					goto exit;
 				}
 			}
-			val1 = stack_pop(stack);
+			val1 = strs_stack_pop(stack);
 			if (!val1) {
 				sepol_log_err("Invalid constraint expression");
 				goto exit;
@@ -227,30 +227,30 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 		if (!new_val) {
 			goto exit;
 		}
-		rc = stack_push(stack, new_val);
+		rc = strs_stack_push(stack, new_val);
 		if (rc != 0) {
 			sepol_log_err("Out of memory");
 			goto exit;
 		}
 	}
 
-	new_val = stack_pop(stack);
-	if (!new_val || !stack_empty(stack)) {
+	new_val = strs_stack_pop(stack);
+	if (!new_val || !strs_stack_empty(stack)) {
 		sepol_log_err("Invalid constraint expression");
 		goto exit;
 	}
 
 	str = new_val;
 
-	stack_destroy(&stack);
+	strs_stack_destroy(&stack);
 
 	return str;
 
 exit:
-	while ((new_val = stack_pop(stack)) != NULL) {
+	while ((new_val = strs_stack_pop(stack)) != NULL) {
 		free(new_val);
 	}
-	stack_destroy(&stack);
+	strs_stack_destroy(&stack);
 
 	return NULL;
 }
-- 
2.17.1

