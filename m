Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AFEC32788
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638012077C
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638012077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJKUC0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:02:26 -0400
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:32086 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbeJKUC0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 16:02:26 -0400
X-EEMSG-check-008: 345164732|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Oct 2018 12:35:23 +0000
X-IronPort-AV: E=Sophos;i="5.54,368,1534809600"; 
   d="scan'208";a="19290036"
IronPort-PHdr: =?us-ascii?q?9a23=3AxyM3whdVeR2CDWDkeMBAkQUxlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcu+bB7h7PlgxGXEQZ/co6odzbaO7Oa4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahY75+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+t4b1rSBv1gykZMTA3/nzchshpgK5FvB6tohpyyJPWbo6ILvpzZqPTc80HS2?=
 =?us-ascii?q?RPXchfUC5OAo2nYocTE+YMJ/pUopPhq1cSqxa1GAmiBPnoyj9NnnL42bc10+?=
 =?us-ascii?q?E/HgHdwQctAcgBsG7IrNrrLqcZTOe4zKvGzDrfdfxWwyv95JbTfxA9ofCDQb?=
 =?us-ascii?q?Jwcc3LxUkpDAPKlE+cqYPiPzOLz+kAtXWQ4el4Ve+3lmIqpA58riKvy8sxkI?=
 =?us-ascii?q?XFmI0Yxk7e+Slkxos+OMe2R1RhYdG+FZtdrySaN4xrTcw8W2xooyM6yqEeuZ?=
 =?us-ascii?q?68YSgK1Iwrxx7BZPyDdIiF+g7jW/yLITd5mXJlY6izhwqy8Ee8yu38UdO40F?=
 =?us-ascii?q?BWoSpejtbArHUN1x3X6sSfS/t9+Fmu2SqX2gzO5exJLlo4mKrGJ5I73LI9mY?=
 =?us-ascii?q?QfvV7eEiPunUX5lq6WdkEq+uiy7OTnZ63rpp2SNoBokA7+KLgultKkDOQkMg?=
 =?us-ascii?q?kBQ2ib+eOm2L3l5k32Wq9GjvIxkqnHqJzaP9gUpralAw9J1YYu8w2/ACmi0N?=
 =?us-ascii?q?QZm3kHMV1EdQmZj4jmJV7OOur0DfShjFS2ljdk2fTGMqfmApXXIXiQ2IvmKK?=
 =?us-ascii?q?1w709a1Rob099S/dRXB6sHLfa1XVX+5/LCCRpsEQWxzv2vI9xnyo4EETaNHa?=
 =?us-ascii?q?SQKr+ImUOZ7eIoZe+XbckavyireKtt3OLnkXJswQxVRqKux5ZCLSrgEw=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2B+AQAkQ79b/wHyM5BiHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VkqgWUomEFMAQEBAQEBBoo1iReGYyAYAYRAAoRVITcKDQEDAQEBAQEBAgFsK?=
 =?us-ascii?q?II2JIJgBnkQUVcZgmE/gXUNp06Ed4RihyWEIIEQgQeBEo1oAoEoAYc4lS8GA?=
 =?us-ascii?q?5BJCxeQESyXPiKBVSsIAhgpgWiBToImF440IzB7AQGLZAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Oct 2018 12:35:23 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9BCZNWp028160;
        Thu, 11 Oct 2018 08:35:23 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov
Subject: [PATCH 1/4] libsepol: Rename kernel_to_common.c stack functions
Date:   Thu, 11 Oct 2018 08:35:46 -0400
Message-Id: <20181011123549.14875-2-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
References: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
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

