Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9364DC433EF
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7836960296
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhKLPpA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhKLPo7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:44:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F63C061766
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so39405431edd.10
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ML/+3QOv3GlJ0avXCmvVPY6qAn7nDT9Dty+pznymaJ0=;
        b=lUgYoOZeRIFDP208YEQl5cprfw0s//aMvBsVmOpSkRUggBLI73zG198ps/TXae7YbO
         OofiB9TdCorp1FVi6jPYCbc43O3yN1Yr6gwLL/YMhvKBVyokwYwZWE9Z5H//yisYNJx2
         cd2mQ78SKzlPHhOTxMntgctXMVCMQdQc09Eb5a+/hPyYQPAxDz/Drp4HgS0rL7CO4ceJ
         ZqvwIf0Y1/1tgNVmnIT6DX0zf6Yq/Bm0eLclFRIKLv1wFx2Xt1L7gMSWVpZ/ItfnTUkd
         tLo0uvVh/VdBEbeCcpPmL4d1qqQpS/Gl8Br+y2exS5BwHDaVe7ifl1JwY/dOMR9qNtY4
         FxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ML/+3QOv3GlJ0avXCmvVPY6qAn7nDT9Dty+pznymaJ0=;
        b=hK2LBOh7uSdz/gJqCw7SdqPnY8yk+C4OAHlJYH50be/04wjfJAxfbJ9PK1ChKEMb1X
         n/VXulXiAzdizCnXflCfAIP0+HCeFR2D5hki9qDd69lI+IvL7FbwQwCegshh+BiU69vE
         L/QkMfA3FkBbKazgXTZ+cYF0AKPIpApsECY08xA4QUNskRbXnr3talk4Jvs+vawxsBNL
         y/zTYDXy2jXXX47A/zYrAT6KLw77PwDTVcR7Ph8vE5VnKWSWCAYEEd12wflyZEmxTiPM
         whI+LS9/FiG9gCBPJQiV7Y46tDBEjYEEOuD1Q56hOjdo6QgwPeer/Zk7U1pNBqQCmZVJ
         FylQ==
X-Gm-Message-State: AOAM530/DCN/Pl6JQSZB5B65/srYJbaTUUCoL4sF2qKVlSwtVxlkTJ7X
        VUGN9t+gCD9XtMLAIkqk3j2E7d+BkAM=
X-Google-Smtp-Source: ABdhPJwipo3P4/M62CAQyrAMUd4iKn/nBILEFiqH2OYMlm75DdaWQg5Pjuj7BSg/8NE0IINwI0MS2A==
X-Received: by 2002:a17:907:3d9e:: with SMTP id he30mr20418842ejc.177.1636731727308;
        Fri, 12 Nov 2021 07:42:07 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:06 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 02/12] libsepol: use string literals as format strings
Date:   Fri, 12 Nov 2021 16:41:51 +0100
Message-Id: <20211112154201.78217-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use string literals as format strings so that compilers can validate the
count and types of the inherent arguments.

    kernel_to_cil.c: In function ‘class_constraint_rules_to_strs’:
    kernel_to_cil.c:301:17: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
      301 |                 rc = strs_create_and_add(strs, format_str, 3, classkey, perms+1, expr);
          |                 ^~
    kernel_to_cil.c: In function ‘class_validatetrans_rules_to_strs’:
    kernel_to_cil.c:341:17: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
      341 |                 rc = strs_create_and_add(strs, format_str, 2, classkey, expr);
          |                 ^~
    kernel_to_cil.c: In function ‘cats_ebitmap_to_str’:
    kernel_to_cil.c:1068:40: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
     1068 |                                        val_to_name[start], val_to_name[i]);
          |                                        ^~~~~~~~~~~

    kernel_to_conf.c: In function ‘class_constraint_rules_to_strs’:
    kernel_to_conf.c:301:42: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
      301 |                                          flavor, classkey, perms+1, expr);
          |                                          ^~~~~~
    kernel_to_conf.c: In function ‘cats_ebitmap_to_str’:
    kernel_to_conf.c:1059:40: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
     1059 |                                        val_to_name[start], sep, val_to_name[i]);
          |                                        ^~~~~~~~~~~
    kernel_to_conf.c:1062:25: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
     1062 |                         len = snprintf(p, remaining, fmt, val_to_name[start]);
          |                         ^~~

    module_to_cil.c: In function ‘cond_expr_to_cil’:
    module_to_cil.c:1340:25: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
     1340 |                         rlen = snprintf(new_val, len, fmt_str, op, val1, val2);
          |                         ^~~~
    module_to_cil.c: In function ‘constraint_expr_to_string’:
    module_to_cil.c:1881:25: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
     1881 |                         rlen = snprintf(new_val, len, fmt_str, op, val1, val2);
          |                         ^~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c  | 29 +++++++++++++++++------------
 libsepol/src/kernel_to_conf.c | 23 +++++++++++++----------
 libsepol/src/module_to_cil.c  | 22 ++++++++--------------
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 305567a5..b81cdb22 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -278,7 +278,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 	char *expr = NULL;
 	int is_mls;
 	char *perms;
-	const char *format_str;
+	const char *key_word;
 	struct strs *strs;
 
 	for (curr = constraint_rules; curr != NULL; curr = curr->next) {
@@ -291,14 +291,14 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 		perms = sepol_av_to_string(pdb, class->s.value, curr->permissions);
 
 		if (is_mls) {
-			format_str = "(mlsconstrain (%s (%s)) %s)";
+			key_word = "mlsconstrain";
 			strs = mls_list;
 		} else {
-			format_str = "(constrain (%s (%s)) %s)";
+			key_word = "constrain";
 			strs = non_mls_list;
 		}
 
-		rc = strs_create_and_add(strs, format_str, 3, classkey, perms+1, expr);
+		rc = strs_create_and_add(strs, "(%s (%s (%s)) %s)", 4, key_word, classkey, perms+1, expr);
 		free(expr);
 		if (rc != 0) {
 			goto exit;
@@ -319,7 +319,7 @@ static int class_validatetrans_rules_to_strs(struct policydb *pdb, char *classke
 	struct constraint_node *curr;
 	char *expr = NULL;
 	int is_mls;
-	const char *format_str;
+	const char *key_word;
 	struct strs *strs;
 	int rc = 0;
 
@@ -331,14 +331,14 @@ static int class_validatetrans_rules_to_strs(struct policydb *pdb, char *classke
 		}
 
 		if (is_mls) {
-			format_str = "(mlsvalidatetrans %s %s)";
+			key_word = "mlsvalidatetrans";
 			strs = mls_list;
 		} else {
-			format_str = "(validatetrans %s %s)";
+			key_word = "validatetrans";
 			strs = non_mls_list;
 		}
 
-		rc = strs_create_and_add(strs, format_str, 2, classkey, expr);
+		rc = strs_create_and_add(strs, "(%s %s %s)", 3, key_word, classkey, expr);
 		free(expr);
 		if (rc != 0) {
 			goto exit;
@@ -1035,7 +1035,6 @@ static char *cats_ebitmap_to_str(struct ebitmap *cats, char **val_to_name)
 	struct ebitmap_node *node;
 	uint32_t i, start, range;
 	char *catsbuf = NULL, *p;
-	const char *fmt;
 	int len, remaining;
 
 	remaining = (int)cats_ebitmap_len(cats, val_to_name);
@@ -1063,9 +1062,15 @@ static char *cats_ebitmap_to_str(struct ebitmap *cats, char **val_to_name)
 			continue;
 
 		if (range > 1) {
-			fmt = (range == 2) ? "%s %s " : "(range %s %s) ";
-			len = snprintf(p, remaining, fmt,
-				       val_to_name[start], val_to_name[i]);
+			if (range == 2) {
+				len = snprintf(p, remaining, "%s %s ",
+					       val_to_name[start],
+					       val_to_name[i]);
+			} else {
+				len = snprintf(p, remaining, "(range %s %s) ",
+					       val_to_name[start],
+					       val_to_name[i]);
+			}
 		} else {
 			len = snprintf(p, remaining, "%s ", val_to_name[start]);
 		}
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index eb72e4ac..460209c8 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -271,7 +271,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 {
 	struct constraint_node *curr;
 	struct strs *strs;
-	const char *format_str, *flavor;
+	const char *flavor, *perm_prefix, *perm_suffix;
 	char *perms, *expr;
 	int is_mls;
 	int rc = 0;
@@ -285,9 +285,11 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 
 		perms = sepol_av_to_string(pdb, class->s.value, curr->permissions);
 		if (strchr(perms, ' ')) {
-			format_str = "%s %s { %s } %s;";
+			perm_prefix = "{ ";
+			perm_suffix = " }";
 		} else {
-			format_str = "%s %s %s %s";
+			perm_prefix = "";
+			perm_suffix = "";
 		}
 		if (is_mls) {
 			flavor = "mlsconstrain";
@@ -297,8 +299,10 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 			strs = non_mls_list;
 		}
 
-		rc = strs_create_and_add(strs, format_str, 4,
-					 flavor, classkey, perms+1, expr);
+		rc = strs_create_and_add(strs, "%s %s %s%s%s %s;", 6,
+					 flavor, classkey,
+					 perm_prefix, perms+1, perm_suffix,
+					 expr);
 		free(expr);
 		if (rc != 0) {
 			goto exit;
@@ -1026,7 +1030,6 @@ static char *cats_ebitmap_to_str(struct ebitmap *cats, char **val_to_name)
 	struct ebitmap_node *node;
 	uint32_t i, start, range, first;
 	char *catsbuf = NULL, *p;
-	const char *fmt;
 	char sep;
 	int len, remaining;
 
@@ -1054,12 +1057,12 @@ static char *cats_ebitmap_to_str(struct ebitmap *cats, char **val_to_name)
 
 		if (range > 1) {
 			sep = (range == 2) ? ',' : '.';
-			fmt = first ? "%s%c%s" : ",%s%c%s";
-			len = snprintf(p, remaining, fmt,
+			len = snprintf(p, remaining, "%s%s%c%s",
+				       first ? "" : ",",
 				       val_to_name[start], sep, val_to_name[i]);
 		} else {
-			fmt = first ? "%s" : ",%s";
-			len = snprintf(p, remaining, fmt, val_to_name[start]);
+			len = snprintf(p, remaining, "%s%s", first ? "" : ",",
+				       val_to_name[start]);
 
 		}
 		if (len < 0 || len >= remaining) {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 16e4004e..b231d7f8 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1259,7 +1259,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 	char *val2 = NULL;
 	unsigned int num_params;
 	const char *op;
-	const char *fmt_str;
+	const char *sep;
 	const char *type;
 
 	rc = stack_init(&stack);
@@ -1308,11 +1308,11 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 					rc = -1;
 					goto exit;
 				}
-				fmt_str = "(%s %s)";
+				sep = "";
 			} else {
 				val2 = stack_pop(stack);
 				val1 = stack_pop(stack);
-				fmt_str = "(%s %s %s)";
+				sep = " ";
 			}
 
 			if (val1 == NULL || val2 == NULL) {
@@ -1334,10 +1334,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 				goto exit;
 			}
 
-			// although we always supply val2 and there isn't always a 2nd
-			// value, it should only be used when there are actually two values
-			// in the format strings
-			rlen = snprintf(new_val, len, fmt_str, op, val1, val2);
+			rlen = snprintf(new_val, len, "(%s %s%s%s)", op, val1, sep, val2);
 			if (rlen < 0 || rlen >= len) {
 				log_err("Failed to generate conditional expression");
 				rc = -1;
@@ -1711,7 +1708,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 	char *val2 = NULL;
 	uint32_t num_params;
 	const char *op;
-	const char *fmt_str;
+	const char *sep;
 	const char *attr1;
 	const char *attr2;
 	char *names = NULL;
@@ -1849,11 +1846,11 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 					rc = -1;
 					goto exit;
 				}
-				fmt_str = "(%s %s)";
+				sep = "";
 			} else {
 				val2 = stack_pop(stack);
 				val1 = stack_pop(stack);
-				fmt_str = "(%s %s %s)";
+				sep = " ";
 			}
 
 			if (val1 == NULL || val2 == NULL) {
@@ -1875,10 +1872,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 				goto exit;
 			}
 
-			// although we always supply val2 and there isn't always a 2nd
-			// value, it should only be used when there are actually two values
-			// in the format strings
-			rlen = snprintf(new_val, len, fmt_str, op, val1, val2);
+			rlen = snprintf(new_val, len, "(%s %s%s%s)", op, val1, sep, val2);
 			if (rlen < 0 || rlen >= len) {
 				log_err("Failed to generate constraint expression");
 				rc = -1;
-- 
2.33.1

