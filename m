Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECFCC7EE24
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 13:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjFBNGX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjFBNGW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 09:06:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9F11B1
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 06:06:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so2967208a12.2
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685711176; x=1688303176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szaE7PIPBT8ltu6v3ucUuocqS0af//KmsoAdMMXNThg=;
        b=ISgKVuLbBs1WFchpY0hvgktz/OJsc8Byu7v/G6jI+VnS0IBw4nXpkAGdnbU73ZvFoa
         6WEISd/q803V3bQ1NPhi6LBKfj4AHlrig5aNFjf49j34WQ87rILnIT65w1LnoZKWgmYK
         j53q136AlEAioYsTtfJqVipHONBajfcrWhu1ImZKWNHO3ySnxE+d2pd8Z32aS3e+nyIj
         WtmySibXM+nMLoMsnv8K2L5UrV2hHU+tyEHkycDfVQk0FTvHFwgsMbhdPiv2jEwA4dHG
         jiiRsSSTw4v9y+OqQXOsPmiHNGVJeQrf8bpjO1e6UILyGrNlB+5QcR7ruRuVAKYbcjVZ
         2OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711176; x=1688303176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szaE7PIPBT8ltu6v3ucUuocqS0af//KmsoAdMMXNThg=;
        b=J5Ibtm7iVss1+runbV7plCZc0FuOcO/Ss7FBpQUtzCM5QJQBnoZ+PR45T6WKI04wLO
         9KXNmMvsVV+segp5783WFJIhZgwZws+j9cJO900jjT/GPDMnIEYITKjMnsfwraJrYCid
         jzK45JDykTY0gaUM5LQ3wXycY3oBG4UKVcdKfw2vG2tCl+nWIChILGgX7RmoWkzHiSE6
         tdM3dlnVlbB91mcsmW0GrNCypp8fQaFRZjsxl79Q+KVWHXrfE5V2CHbVGMxnHUonAmgA
         0iLNLKTCtudyMNURl1LcFlnjy1p91DfGX5QahxbaDygEWm3bJF2cnlGsOUZffEDbYRJ/
         72Bw==
X-Gm-Message-State: AC+VfDyj9BOWd+z9fw3LXP7ziho/9i6HL3vhNiDPASTJ1Djmk6J1HjW4
        G0MXpPs4huWwJxQTDUhLysGeHgmaAi6g0A==
X-Google-Smtp-Source: ACHHUZ7HzXcAMhluc3cswi0DkIAGKJVcn5DV0XP/G+SNmO2WqNyKluQ55S/9oUBtbvOR4NKAKbqx6Q==
X-Received: by 2002:a05:6402:1242:b0:514:a4da:408e with SMTP id l2-20020a056402124200b00514a4da408emr1770737edw.2.1685711176513;
        Fri, 02 Jun 2023 06:06:16 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-062-107.95.112.pool.telefonica.de. [95.112.62.107])
        by smtp.gmail.com with ESMTPSA id z19-20020aa7c653000000b005149b6ec1bdsm669961edr.29.2023.06.02.06.06.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:06:16 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 4/4] libsepol: replace log_err() by ERR()
Date:   Fri,  2 Jun 2023 15:06:08 +0200
Message-Id: <20230602130608.24586-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602130608.24586-1-cgzones@googlemail.com>
References: <20230602130608.24586-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the libsepol internal wrapper ERR() with a NULL handler to emit
error messages.  ERR() will besides adding a prefix of "libsepol" also
write to stderr.  One benefit is the option to suppress the messages via
sepol_debug(), although marked deprecated, e.g. in fuzzers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  added signed-off
---
 libsepol/src/module_to_cil.c | 173 ++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 93 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index e7bc6ee6..1a490089 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -52,6 +52,7 @@
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/util.h>
 
+#include "debug.h"
 #include "kernel_to_common.h"
 #include "private.h"
 #include "module_internal.h"
@@ -71,24 +72,10 @@ static FILE *out_file;
 #define TYPEATTR_INFIX "_typeattr_"        /* Also in libsepol/cil/src/cil_post.c */
 #define ROLEATTR_INFIX "_roleattr_"
 
-__attribute__ ((format(printf, 1, 2)))
-static void log_err(const char *fmt, ...)
-{
-	va_list argptr;
-	va_start(argptr, fmt);
-	if (vfprintf(stderr, fmt, argptr) < 0) {
-		_exit(EXIT_FAILURE);
-	}
-	va_end(argptr);
-	if (fprintf(stderr, "\n") < 0) {
-		_exit(EXIT_FAILURE);
-	}
-}
-
 static void cil_indent(int indent)
 {
 	if (fprintf(out_file, "%*s", indent * 4, "") < 0) {
-		log_err("Failed to write to output");
+		ERR(NULL, "Failed to write to output");
 		_exit(EXIT_FAILURE);
 	}
 }
@@ -98,7 +85,7 @@ static void cil_printf(const char *fmt, ...) {
 	va_list argptr;
 	va_start(argptr, fmt);
 	if (vfprintf(out_file, fmt, argptr) < 0) {
-		log_err("Failed to write to output");
+		ERR(NULL, "Failed to write to output");
 		_exit(EXIT_FAILURE);
 	}
 	va_end(argptr);
@@ -111,12 +98,12 @@ static void cil_println(int indent, const char *fmt, ...)
 	cil_indent(indent);
 	va_start(argptr, fmt);
 	if (vfprintf(out_file, fmt, argptr) < 0) {
-		log_err("Failed to write to output");
+		ERR(NULL, "Failed to write to output");
 		_exit(EXIT_FAILURE);
 	}
 	va_end(argptr);
 	if (fprintf(out_file, "\n") < 0) {
-		log_err("Failed to write to output");
+		ERR(NULL, "Failed to write to output");
 		_exit(EXIT_FAILURE);
 	}
 }
@@ -142,7 +129,7 @@ static int get_line(char **start, char *end, char **line)
 
 	*line = malloc(len+1);
 	if (*line == NULL) {
-		log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		rc = -1;
 		goto exit;
 	}
@@ -593,7 +580,7 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 		rule = "typechange";
 		break;
 	default:
-		log_err("Unknown avrule type: %i", type);
+		ERR(NULL, "Unknown avrule type: %i", type);
 		rc = -1;
 		goto exit;
 	}
@@ -602,7 +589,7 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 		if (type & AVRULE_AV) {
 			perms = sepol_av_to_string(pdb, classperm->tclass, classperm->data);
 			if (perms == NULL) {
-				log_err("Failed to generate permission string");
+				ERR(NULL, "Failed to generate permission string");
 				rc = -1;
 				goto exit;
 			}
@@ -702,7 +689,7 @@ static int avrulex_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 		rule = "neverallowx";
 		break;
 	default:
-		log_err("Unknown avrule xperm type: %i", type);
+		ERR(NULL, "Unknown avrule xperm type: %i", type);
 		rc = -1;
 		goto exit;
 	}
@@ -762,13 +749,13 @@ static char *get_new_attr_name(struct policydb *pdb, int is_type)
 	len = strlen(pdb->name) + strlen(infix) + num_digits(num_attrs) + 1;
 	attr_name = malloc(len);
 	if (!attr_name) {
-		log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		goto exit;
 	}
 
 	rlen = snprintf(attr_name, len, "%s%s%i", pdb->name, infix, num_attrs);
 	if (rlen < 0 || rlen >= len) {
-		log_err("Failed to generate attribute name");
+		ERR(NULL, "Failed to generate attribute name");
 		free(attr_name);
 		attr_name = NULL;
 		goto exit;
@@ -785,7 +772,7 @@ static int cil_add_attr_to_list(struct list *attr_list, char *attr_name, int is_
 
 	attr_list_node = calloc(1, sizeof(*attr_list_node));
 	if (attr_list_node == NULL) {
-		log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		rc = -1;
 		goto exit;
 	}
@@ -975,7 +962,7 @@ static int set_to_names(struct policydb *pdb, int is_type, void *set, struct lis
 
 	*names = malloc(sizeof(char *));
 	if (!*names) {
-		log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		rc = -1;
 		goto exit;
 	}
@@ -997,7 +984,7 @@ static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, char ***n
 	num = 0;
 	ebitmap_for_each_positive_bit(map, node, i) {
 		if (num >= UINT32_MAX / sizeof(*name_arr)) {
-			log_err("Overflow");
+			ERR(NULL, "Overflow");
 			rc = -1;
 			goto exit;
 		}
@@ -1012,7 +999,7 @@ static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, char ***n
 
 	name_arr = calloc(num, sizeof(*name_arr));
 	if (name_arr == NULL) {
-		log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		rc = -1;
 		goto exit;
 	}
@@ -1139,25 +1126,25 @@ static int name_list_to_string(char **names, unsigned int num_names, char **stri
 
 	for (i = 0; i < num_names; i++) {
 		if (__builtin_add_overflow(len, strlen(names[i]), &len)) {
-			log_err("Overflow");
+			ERR(NULL, "Overflow");
 			return -1;
 		}
 	}
 
 	// add spaces + null terminator
 	if (__builtin_add_overflow(len, (size_t)num_names, &len)) {
-		log_err("Overflow");
+		ERR(NULL, "Overflow");
 		return -1;
 	}
 
 	if (!len) {
-		log_err("Empty list");
+		ERR(NULL, "Empty list");
 		return -1;
 	}
 
 	str = malloc(len);
 	if (str == NULL) {
-		log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		rc = -1;
 		goto exit;
 	}
@@ -1266,7 +1253,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 
 	rc = stack_init(&stack);
 	if (rc != 0) {
-		log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		goto exit;
 	}
 
@@ -1277,13 +1264,13 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 			len = strlen(val1) + 2 + 1;
 			new_val = malloc(len);
 			if (new_val == NULL) {
-				log_err("Out of memory");
+				ERR(NULL, "Out of memory");
 				rc = -1;
 				goto exit;
 			}
 			rlen = snprintf(new_val, len, "(%s)", val1);
 			if (rlen < 0 || rlen >= len) {
-				log_err("Failed to generate conditional expression");
+				ERR(NULL, "Failed to generate conditional expression");
 				rc = -1;
 				goto exit;
 			}
@@ -1306,7 +1293,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 				val1 = stack_pop(stack);
 				val2 = strdup("");
 				if (val2 == NULL) {
-					log_err("Out of memory");
+					ERR(NULL, "Out of memory");
 					rc = -1;
 					goto exit;
 				}
@@ -1318,7 +1305,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 			}
 
 			if (val1 == NULL || val2 == NULL) {
-				log_err("Invalid conditional expression");
+				ERR(NULL, "Invalid conditional expression");
 				rc = -1;
 				goto exit;
 			}
@@ -1331,14 +1318,14 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 			len = strlen(val1) + strlen(val2) + strlen(op) + (num_params * 1) + 2 + 1;
 			new_val = malloc(len);
 			if (new_val == NULL) {
-				log_err("Out of memory");
+				ERR(NULL, "Out of memory");
 				rc = -1;
 				goto exit;
 			}
 
 			rlen = snprintf(new_val, len, "(%s %s%s%s)", op, val1, sep, val2);
 			if (rlen < 0 || rlen >= len) {
-				log_err("Failed to generate conditional expression");
+				ERR(NULL, "Failed to generate conditional expression");
 				rc = -1;
 				goto exit;
 			}
@@ -1351,7 +1338,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 
 		rc = stack_push(stack, new_val);
 		if (rc != 0) {
-			log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 		new_val = NULL;
@@ -1365,7 +1352,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 
 	val1 = stack_pop(stack);
 	if (val1 == NULL || stack_peek(stack) != NULL) {
-		log_err("Invalid conditional expression");
+		ERR(NULL, "Invalid conditional expression");
 		rc = -1;
 		goto exit;
 	}
@@ -1739,7 +1726,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 			case CEXPR_DOMBY:   op = "domby";  break;
 			case CEXPR_INCOMP:  op = "incomp"; break;
 			default:
-				log_err("Unknown constraint operator type: %i", expr->op);
+				ERR(NULL, "Unknown constraint operator type: %i", expr->op);
 				rc = -1;
 				goto exit;
 			}
@@ -1761,7 +1748,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 			case CEXPR_L1H1:                 attr1 = "l1"; attr2 = "h1"; break;
 			case CEXPR_L2H2:                 attr1 = "l2"; attr2 = "h2"; break;
 			default:
-				log_err("Unknown expression attribute type: %i", expr->attr);
+				ERR(NULL, "Unknown expression attribute type: %i", expr->attr);
 				rc = -1;
 				goto exit;
 			}
@@ -1771,13 +1758,13 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 				len = strlen(op) + strlen(attr1) + strlen(attr2) + 2 + 2 + 1;
 				new_val = malloc(len);
 				if (new_val == NULL) {
-					log_err("Out of memory");
+					ERR(NULL, "Out of memory");
 					rc = -1;
 					goto exit;
 				}
 				rlen = snprintf(new_val, len, "(%s %s %s)", op, attr1, attr2);
 				if (rlen < 0 || rlen >= len) {
-					log_err("Failed to generate constraint expression");
+					ERR(NULL, "Failed to generate constraint expression");
 					rc = -1;
 					goto exit;
 				}
@@ -1819,7 +1806,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 				}
 				new_val = malloc(len);
 				if (new_val == NULL) {
-					log_err("Out of memory");
+					ERR(NULL, "Out of memory");
 					rc = -1;
 					goto exit;
 				}
@@ -1829,7 +1816,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 					rlen = snprintf(new_val, len, "(%s %s %s)", op, attr1, names);
 				}
 				if (rlen < 0 || rlen >= len) {
-					log_err("Failed to generate constraint expression");
+					ERR(NULL, "Failed to generate constraint expression");
 					rc = -1;
 					goto exit;
 				}
@@ -1844,7 +1831,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 			case CEXPR_AND: op = "and"; break;
 			case CEXPR_OR:  op = "or"; break;
 			default:
-				log_err("Unknown constraint expression type: %i", expr->expr_type);
+				ERR(NULL, "Unknown constraint expression type: %i", expr->expr_type);
 				rc = -1;
 				goto exit;
 			}
@@ -1855,7 +1842,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 				val1 = stack_pop(stack);
 				val2 = strdup("");
 				if (val2 == NULL) {
-					log_err("Out of memory");
+					ERR(NULL, "Out of memory");
 					rc = -1;
 					goto exit;
 				}
@@ -1867,7 +1854,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 			}
 
 			if (val1 == NULL || val2 == NULL) {
-				log_err("Invalid constraint expression");
+				ERR(NULL, "Invalid constraint expression");
 				rc = -1;
 				goto exit;
 			}
@@ -1880,14 +1867,14 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 			len = strlen(val1) + strlen(val2) + strlen(op) + (num_params * 1) + 2 + 1;
 			new_val = malloc(len);
 			if (new_val == NULL) {
-				log_err("Out of memory");
+				ERR(NULL, "Out of memory");
 				rc = -1;
 				goto exit;
 			}
 
 			rlen = snprintf(new_val, len, "(%s %s%s%s)", op, val1, sep, val2);
 			if (rlen < 0 || rlen >= len) {
-				log_err("Failed to generate constraint expression");
+				ERR(NULL, "Failed to generate constraint expression");
 				rc = -1;
 				goto exit;
 			}
@@ -1900,7 +1887,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 
 		rc = stack_push(stack, new_val);
 		if (rc != 0) {
-			log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 
@@ -1909,7 +1896,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 
 	new_val = stack_pop(stack);
 	if (new_val == NULL || stack_peek(stack) != NULL) {
-		log_err("Invalid constraint expression");
+		ERR(NULL, "Invalid constraint expression");
 		rc = -1;
 		goto exit;
 	}
@@ -2012,7 +1999,7 @@ static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *U
 		case DEFAULT_SOURCE:	dflt = "source";	break;
 		case DEFAULT_TARGET:	dflt = "target";	break;
 		default:
-			log_err("Unknown default user value: %i", class->default_user);
+			ERR(NULL, "Unknown default user value: %i", class->default_user);
 			rc = -1;
 			goto exit;
 		}
@@ -2024,7 +2011,7 @@ static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *U
 		case DEFAULT_SOURCE:	dflt = "source";	break;
 		case DEFAULT_TARGET:	dflt = "target";	break;
 		default:
-			log_err("Unknown default role value: %i", class->default_role);
+			ERR(NULL, "Unknown default role value: %i", class->default_role);
 			rc = -1;
 			goto exit;
 		}
@@ -2036,7 +2023,7 @@ static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *U
 		case DEFAULT_SOURCE:	dflt = "source";	break;
 		case DEFAULT_TARGET:	dflt = "target";	break;
 		default:
-			log_err("Unknown default type value: %i", class->default_type);
+			ERR(NULL, "Unknown default type value: %i", class->default_type);
 			rc = -1;
 			goto exit;
 		}
@@ -2053,7 +2040,7 @@ static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *U
 		case DEFAULT_TARGET_LOW_HIGH:	dflt = "target low-high";	break;
 		case DEFAULT_GLBLUB:		dflt = "glblub";		break;
 		default:
-			log_err("Unknown default range value: %i", class->default_range);
+			ERR(NULL, "Unknown default range value: %i", class->default_range);
 			rc = -1;
 			goto exit;
 		}
@@ -2168,7 +2155,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 		}
 
 		if (ebitmap_cardinality(&role->dominates) > 1) {
-			log_err("Warning: role 'dominance' statement unsupported in CIL. Dropping from output.");
+			ERR(NULL, "Warning: role 'dominance' statement unsupported in CIL. Dropping from output.");
 		}
 
 		ts = &role->types;
@@ -2218,7 +2205,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 		break;
 
 	default:
-		log_err("Unknown role type: %i", role->flavor);
+		ERR(NULL, "Unknown role type: %i", role->flavor);
 		rc = -1;
 		goto exit;
 	}
@@ -2297,7 +2284,7 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 	case TYPE_ALIAS:
 		break;
 	default:
-		log_err("Unknown flavor (%i) of type %s", type->flavor, key);
+		ERR(NULL, "Unknown flavor (%i) of type %s", type->flavor, key);
 		rc = -1;
 		goto exit;
 	}
@@ -2477,7 +2464,7 @@ static int polcaps_to_cil(struct policydb *pdb)
 	ebitmap_for_each_positive_bit(map, node, i) {
 		name = sepol_polcap_getname(i);
 		if (name == NULL) {
-			log_err("Unknown policy capability id: %i", i);
+			ERR(NULL, "Unknown policy capability id: %i", i);
 			rc = -1;
 			goto exit;
 		}
@@ -2564,13 +2551,13 @@ static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_
 		// ocontext) for sidorder statement
 		item = malloc(sizeof(*item));
 		if (item == NULL) {
-			log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			rc = -1;
 			goto exit;
 		}
 		item->sid_key = strdup(sid);
 		if (!item->sid_key) {
-			log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			rc = -1;
 			goto exit;
 		}
@@ -2616,7 +2603,7 @@ exit:
 static int ocontext_selinux_fs_to_cil(struct policydb *UNUSED(pdb), struct ocontext *fss)
 {
 	if (fss != NULL) {
-		log_err("Warning: 'fscon' statement unsupported in CIL. Dropping from output.");
+		ERR(NULL, "Warning: 'fscon' statement unsupported in CIL. Dropping from output.");
 	}
 
 	return 0;
@@ -2638,7 +2625,7 @@ static int ocontext_selinux_port_to_cil(struct policydb *pdb, struct ocontext *p
 		case IPPROTO_DCCP: protocol = "dccp"; break;
 		case IPPROTO_SCTP: protocol = "sctp"; break;
 		default:
-			log_err("Unknown portcon protocol: %i", portcon->u.port.protocol);
+			ERR(NULL, "Unknown portcon protocol: %i", portcon->u.port.protocol);
 			rc = -1;
 			goto exit;
 		}
@@ -2680,7 +2667,7 @@ static int ocontext_selinux_ibpkey_to_cil(struct policydb *pdb,
 
 		if (inet_ntop(AF_INET6, &subnet_prefix.s6_addr,
 			      subnet_prefix_str, INET6_ADDRSTRLEN) == NULL) {
-			log_err("ibpkeycon subnet_prefix is invalid: %m");
+			ERR(NULL, "ibpkeycon subnet_prefix is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2725,13 +2712,13 @@ static int ocontext_selinux_node_to_cil(struct policydb *pdb, struct ocontext *n
 
 	for (node = nodes; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET, &node->u.node.addr, addr, INET_ADDRSTRLEN) == NULL) {
-			log_err("Nodecon address is invalid: %m");
+			ERR(NULL, "Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET, &node->u.node.mask, mask, INET_ADDRSTRLEN) == NULL) {
-			log_err("Nodecon mask is invalid: %m");
+			ERR(NULL, "Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2757,13 +2744,13 @@ static int ocontext_selinux_node6_to_cil(struct policydb *pdb, struct ocontext *
 
 	for (node = nodes; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET6, &node->u.node6.addr, addr, INET6_ADDRSTRLEN) == NULL) {
-			log_err("Nodecon address is invalid: %m");
+			ERR(NULL, "Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET6, &node->u.node6.mask, mask, INET6_ADDRSTRLEN) == NULL) {
-			log_err("Nodecon mask is invalid: %m");
+			ERR(NULL, "Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2807,7 +2794,7 @@ static int ocontext_selinux_fsuse_to_cil(struct policydb *pdb, struct ocontext *
 		case SECURITY_FS_USE_TRANS: behavior = "trans"; break;
 		case SECURITY_FS_USE_TASK:  behavior = "task"; break;
 		default:
-			log_err("Unknown fsuse behavior: %i", fsuse->v.behavior);
+			ERR(NULL, "Unknown fsuse behavior: %i", fsuse->v.behavior);
 			rc = -1;
 			goto exit;
 		}
@@ -2950,7 +2937,7 @@ static int ocontexts_to_cil(struct policydb *pdb)
 		ocon_funcs = ocon_xen_funcs;
 		break;
 	default:
-		log_err("Unknown target platform: %i", pdb->target_platform);
+		ERR(NULL, "Unknown target platform: %i", pdb->target_platform);
 		rc = -1;
 		goto exit;
 	}
@@ -3022,7 +3009,7 @@ static int level_string_to_cil(char *levelstr)
 
 	matched = tokenize(levelstr, ':', 2, &sens, &cats);
 	if (matched < 1 || matched > 2) {
-		log_err("Invalid level: %s", levelstr);
+		ERR(NULL, "Invalid level: %s", levelstr);
 		rc = -1;
 		goto exit;
 	}
@@ -3087,7 +3074,7 @@ static int context_string_to_cil(char *contextstr)
 
 	matched = tokenize(contextstr, ':', 4, &user, &role, &type, &level);
 	if (matched < 3 || matched > 4) {
-		log_err("Invalid context: %s", contextstr);
+		ERR(NULL, "Invalid context: %s", contextstr);
 		rc = -1;
 		goto exit;
 	}
@@ -3148,7 +3135,7 @@ static int seusers_to_cil(struct sepol_module_package *mod_pkg)
 		matched = tokenize(tmp, ':', 3, &user, &seuser, &level);
 
 		if (matched < 2 || matched > 3) {
-			log_err("Invalid seuser line: %s", line);
+			ERR(NULL, "Invalid seuser line: %s", line);
 			rc = -1;
 			goto exit;
 		}
@@ -3197,7 +3184,7 @@ static int netfilter_contexts_to_cil(struct sepol_module_package *mod_pkg)
 	size_t netcons_len = sepol_module_package_get_netfilter_contexts_len(mod_pkg);
 
 	if (netcons_len > 0) {
-		log_err("Warning: netfilter_contexts are unsupported in CIL. Dropping from output.");
+		ERR(NULL, "Warning: netfilter_contexts are unsupported in CIL. Dropping from output.");
 	}
 
 	return 0;
@@ -3239,7 +3226,7 @@ static int user_extra_to_cil(struct sepol_module_package *mod_pkg)
 		matched = tokenize(tmp, ' ', 4, &user_str, &user, &prefix_str, &prefix);
 		if (matched != 4) {
 			rc = -1;
-			log_err("Invalid user extra line: %s", line);
+			ERR(NULL, "Invalid user extra line: %s", line);
 			goto exit;
 		}
 
@@ -3247,7 +3234,7 @@ static int user_extra_to_cil(struct sepol_module_package *mod_pkg)
 		eol = prefix + prefix_len - 1;
 		if (*eol != ';' || strcmp(user_str, "user") || strcmp(prefix_str, "prefix")) {
 			rc = -1;
-			log_err("Invalid user extra line: %s", line);
+			ERR(NULL, "Invalid user extra line: %s", line);
 			goto exit;
 		}
 		*eol = '\0';
@@ -3309,7 +3296,7 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 		matched = tokenize(tmp, ' ', 3, &regex, &mode, &context);
 		if (matched < 2 || matched > 3) {
 			rc = -1;
-			log_err("Invalid file context line: %s", line);
+			ERR(NULL, "Invalid file context line: %s", line);
 			goto exit;
 		}
 
@@ -3336,7 +3323,7 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 			cilmode = "symlink";
 		} else {
 			rc = -1;
-			log_err("Invalid mode in file context line: %s", line);
+			ERR(NULL, "Invalid mode in file context line: %s", line);
 			goto exit;
 		}
 
@@ -3734,7 +3721,7 @@ static int module_block_to_cil(struct policydb *pdb, struct avrule_block *block,
 	}
 
 	if (decl->next != NULL) {
-		log_err("Warning: 'else' blocks in optional statements are unsupported in CIL. Dropping from output.");
+		ERR(NULL, "Warning: 'else' blocks in optional statements are unsupported in CIL. Dropping from output.");
 	}
 
 	if (block->flags & AVRULE_OPTIONAL) {
@@ -3775,7 +3762,7 @@ static int global_block_to_cil(struct policydb *pdb, struct avrule_block *block,
 	}
 
 	if (decl->next != NULL) {
-		log_err("Warning: 'else' not allowed in global block. Dropping from output.");
+		ERR(NULL, "Warning: 'else' not allowed in global block. Dropping from output.");
 	}
 
 	stack_push(stack, decl);
@@ -3912,7 +3899,7 @@ static int handle_unknown_to_cil(struct policydb *pdb)
 		hu = "allow";
 		break;
 	default:
-		log_err("Unknown value for handle-unknown: %i", pdb->handle_unknown);
+		ERR(NULL, "Unknown value for handle-unknown: %i", pdb->handle_unknown);
 		rc = -1;
 		goto exit;
 	}
@@ -3981,7 +3968,7 @@ static int fix_module_name(struct policydb *pdb)
 	if (pdb->policy_type == POLICY_BASE) {
 		pdb->name = strdup("base");
 		if (pdb->name == NULL) {
-			log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			rc = -1;
 			goto exit;
 		}
@@ -4015,7 +4002,7 @@ int sepol_module_policydb_to_cil(FILE *fp, struct policydb *pdb, int linked)
 
 	if (pdb->policy_type != SEPOL_POLICY_BASE &&
 		pdb->policy_type != SEPOL_POLICY_MOD) {
-		log_err("Policy package is not a base or module");
+		ERR(NULL, "Policy package is not a base or module");
 		rc = -1;
 		goto exit;
 	}
@@ -4121,7 +4108,7 @@ int sepol_module_package_to_cil(FILE *fp, struct sepol_module_package *mod_pkg)
 
 	pdb = sepol_module_package_get_policy(mod_pkg);
 	if (pdb == NULL) {
-		log_err("Failed to get policydb");
+		ERR(NULL, "Failed to get policydb");
 		rc = -1;
 		goto exit;
 	}
@@ -4167,7 +4154,7 @@ static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
 
 	d = malloc(max_len);
 	if (d == NULL) {
-		log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		rc = -1;
 		goto exit;
 	}
@@ -4178,7 +4165,7 @@ static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
 			max_len *= 2;
 			d_tmp = realloc(d, max_len);
 			if (d_tmp == NULL) {
-				log_err("Out of memory");
+				ERR(NULL, "Out of memory");
 				rc = -1;
 				goto exit;
 			}
@@ -4187,7 +4174,7 @@ static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
 	}
 
 	if (ferror(fp) != 0) {
-		log_err("Failed to read pp file");
+		ERR(NULL, "Failed to read pp file");
 		rc = -1;
 		goto exit;
 	}
@@ -4214,7 +4201,7 @@ int sepol_ppfile_to_module_package(FILE *fp, struct sepol_module_package **mod_p
 
 	rc = sepol_policy_file_create(&pf);
 	if (rc != 0) {
-		log_err("Failed to create policy file");
+		ERR(NULL, "Failed to create policy file");
 		goto exit;
 	}
 
@@ -4240,13 +4227,13 @@ int sepol_ppfile_to_module_package(FILE *fp, struct sepol_module_package **mod_p
 
 	rc = sepol_module_package_create(&pkg);
 	if (rc != 0) {
-		log_err("Failed to create module package");
+		ERR(NULL, "Failed to create module package");
 		goto exit;
 	}
 
 	rc = sepol_module_package_read(pkg, pf, 0);
 	if (rc != 0) {
-		log_err("Failed to read policy package");
+		ERR(NULL, "Failed to read policy package");
 		goto exit;
 	}
 
-- 
2.40.1

