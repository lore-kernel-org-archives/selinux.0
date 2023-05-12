Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C070C77B7F
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbjELKOZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbjELKOP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:14:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9141154F
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:13:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so17169859a12.1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683886420; x=1686478420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5voSbIH8pALureXv9LuTtsil0NRlYrXtNyRf5MCnd8=;
        b=ISmQiI3jyfpcOcacMSN1Pl3Sq0h0V8fHQHpfJcUZxQWrpYMPXgI5s5cg3HKiFD4HYW
         /cfOz69hpgzTIneyrjr/32ZNQI+6wbm0ogwT1uUpErKrEeQdeydS83xE+JMDJoEEAU3y
         6IMktWa0SvVefVHEL1IZC+QXbIhM05O3fnt2E1vE+hkzUXicrAOYZn0dSp+zJJ585Orw
         oUGtIO5ZUFqCbi4wcJrDlLlttp52DyhAkZBYxwuumHwVCIIINW1+lVY+uDfbPkHxVFJf
         9Mlfwr0ldt7sbQo9ZcOaRM6zOoIWGeRU3NhawV0xY1DY4KcE0YSKBBtzRJYPubDmHFeR
         O7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886420; x=1686478420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5voSbIH8pALureXv9LuTtsil0NRlYrXtNyRf5MCnd8=;
        b=gbD6BKcY7cj8sa0OPSpuMQrt/DrYhBZ+fDk+9WBNnbDQKUE+IgRnoL3Phi2Hz00TlF
         d0ZTaOnFb2a6RvaUmKsCkv4Zk/zW8fSgH8y+UO8IyLdjCtJg1klL/aQxo6yxmGX8hErh
         KtaWoOhLRXMzOVYD/SeYryXXN200nTguZc/rHkhEQ5S/B0S+abjTOjJ7g/pEBRdmJtj5
         EY3ZJh0aCuJAcqFHw21UB/Jga/dxxunmxJEJoCN5QFF4xQ2fx0NKsNL4b800d/v5QZsM
         ZPaWteDVO4l3pnJOqVPOmwf8P9EojSBgAI9p5fOA+XdxLUJXIfYxR+uWKZMysKsuGD6r
         OV3g==
X-Gm-Message-State: AC+VfDxiuFzm0VRMTjsu5RDTkImuobO/9MeSSggkFwTdOcRVwe4u5Rl8
        /2KEqXiRWY+DV7ywqlUwR4SdShP8tY7Plg==
X-Google-Smtp-Source: ACHHUZ4XKBAhZh/YdVrZDQMtmzOUIZ/xl0HBN7TG423rxz6EADw09fI1gKT/mk0XKzvlLy8fJVouQg==
X-Received: by 2002:a17:907:ea6:b0:96a:4325:2593 with SMTP id ho38-20020a1709070ea600b0096a43252593mr7045504ejc.42.1683886419143;
        Fri, 12 May 2023 03:13:39 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709065da500b0096616adc0d5sm5233551ejv.104.2023.05.12.03.13.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:13:38 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] libsepol: replace sepol_log_err() by ERR()
Date:   Fri, 12 May 2023 12:13:32 +0200
Message-Id: <20230512101333.67196-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512101333.67196-1-cgzones@googlemail.com>
References: <20230512101333.67196-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the libsepol internal wrapper ERR() with a NULL handler to emit
error messages.  ERR() will besides adding a prefix of "libsepol" also
write to stderr.  One benefit is the option to suppress the messages via
sepol_debug(), although marked deprecated, e.g. in fuzzers.
---
 libsepol/src/kernel_to_cil.c    | 151 ++++++++++++++++----------------
 libsepol/src/kernel_to_common.c |  34 +++----
 libsepol/src/kernel_to_common.h |   2 -
 libsepol/src/kernel_to_conf.c   | 151 ++++++++++++++++----------------
 4 files changed, 163 insertions(+), 175 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index edca4d5f..4c48d3e0 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -25,6 +25,7 @@
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/util.h>
 
+#include "debug.h"
 #include "kernel_to_common.h"
 
 
@@ -59,7 +60,7 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 			case COND_EQ:	op = "eq";  num_params = 2; break;
 			case COND_NEQ:	op = "neq"; num_params = 2; break;
 			default:
-				sepol_log_err("Unknown conditional operator: %i",
+				ERR(NULL, "Unknown conditional operator: %i",
 					      curr->expr_type);
 				goto exit;
 			}
@@ -67,13 +68,13 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 			if (num_params == 2) {
 				val2 = strs_stack_pop(stack);
 				if (!val2) {
-					sepol_log_err("Invalid conditional expression");
+					ERR(NULL, "Invalid conditional expression");
 					goto exit;
 				}
 			}
 			val1 = strs_stack_pop(stack);
 			if (!val1) {
-				sepol_log_err("Invalid conditional expression");
+				ERR(NULL, "Invalid conditional expression");
 				free(val2);
 				goto exit;
 			}
@@ -86,19 +87,19 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 			free(val1);
 		}
 		if (!new_val) {
-			sepol_log_err("Invalid conditional expression");
+			ERR(NULL, "Invalid conditional expression");
 			goto exit;
 		}
 		rc = strs_stack_push(stack, new_val);
 		if (rc != 0) {
-			sepol_log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 	}
 
 	new_val = strs_stack_pop(stack);
 	if (!new_val || !strs_stack_empty(stack)) {
-		sepol_log_err("Invalid conditional expression");
+		ERR(NULL, "Invalid conditional expression");
 		goto exit;
 	}
 
@@ -146,7 +147,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			case CEXPR_DOMBY:   op = "domby";  break;
 			case CEXPR_INCOMP:  op = "incomp"; break;
 			default:
-				sepol_log_err("Unknown constraint operator: %i", curr->op);
+				ERR(NULL, "Unknown constraint operator: %i", curr->op);
 				goto exit;
 			}
 
@@ -167,7 +168,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			case CEXPR_L1H1:                 attr1 ="l1"; attr2 ="h1"; break;
 			case CEXPR_L2H2:                 attr1 ="l2"; attr2 ="h2"; break;
 			default:
-				sepol_log_err("Unknown constraint attribute: %i",
+				ERR(NULL, "Unknown constraint attribute: %i",
 					      curr->attr);
 				goto exit;
 			}
@@ -191,7 +192,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 				if (!names) {
 					names = strdup("NO_IDENTIFIER");
 					if (!names) {
-						sepol_log_err("Out of memory");
+						ERR(NULL, "Out of memory");
 						goto exit;
 					}
 				}
@@ -212,7 +213,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			case CEXPR_AND: op = "and"; num_params = 2; break;
 			case CEXPR_OR:  op = "or";  num_params = 2; break;
 			default:
-				sepol_log_err("Unknown constraint expression type: %i",
+				ERR(NULL, "Unknown constraint expression type: %i",
 					      curr->expr_type);
 				goto exit;
 			}
@@ -220,13 +221,13 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			if (num_params == 2) {
 				val2 = strs_stack_pop(stack);
 				if (!val2) {
-					sepol_log_err("Invalid constraint expression");
+					ERR(NULL, "Invalid constraint expression");
 					goto exit;
 				}
 			}
 			val1 = strs_stack_pop(stack);
 			if (!val1) {
-				sepol_log_err("Invalid constraint expression");
+				ERR(NULL, "Invalid constraint expression");
 				goto exit;
 			}
 
@@ -243,14 +244,14 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 		}
 		rc = strs_stack_push(stack, new_val);
 		if (rc != 0) {
-			sepol_log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 	}
 
 	new_val = strs_stack_pop(stack);
 	if (!new_val || !strs_stack_empty(stack)) {
-		sepol_log_err("Invalid constraint expression");
+		ERR(NULL, "Invalid constraint expression");
 		goto exit;
 	}
 
@@ -314,7 +315,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 
 	return 0;
 exit:
-	sepol_log_err("Error gathering constraint rules");
+	ERR(NULL, "Error gathering constraint rules");
 	return rc;
 }
 
@@ -423,7 +424,7 @@ static int write_handle_unknown_to_cil(FILE *out, struct policydb *pdb)
 		action = "allow";
 		break;
 	default:
-		sepol_log_err("Unknown value for handle-unknown: %i", pdb->handle_unknown);
+		ERR(NULL, "Unknown value for handle-unknown: %i", pdb->handle_unknown);
 		return -1;
 	}
 
@@ -508,7 +509,7 @@ static int write_class_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 	/* common */
 	used = calloc(pdb->p_commons.nprim, sizeof(*used));
 	if (!used) {
-		sepol_log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		rc = -1;
 		goto exit;
 	}
@@ -543,7 +544,7 @@ static int write_class_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing class rules to CIL");
+		ERR(NULL, "Error writing class rules to CIL");
 	}
 
 	return rc;
@@ -573,7 +574,7 @@ static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
 			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
 			sid = strdup(unknown);
 			if (!sid) {
-				sepol_log_err("Out of memory");
+				ERR(NULL, "Out of memory");
 				rc = -1;
 				goto exit;
 			}
@@ -616,7 +617,7 @@ exit:
 	}
 	strs_destroy(&strs);
 	if (rc != 0) {
-		sepol_log_err("Error writing sid rules to CIL");
+		ERR(NULL, "Error writing sid rules to CIL");
 	}
 
 	return rc;
@@ -633,7 +634,7 @@ static int write_sid_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 		rc = write_sids_to_cil(out, xen_sid_to_str, XEN_SID_SZ,
 				       pdb->ocontexts[0]);
 	} else {
-		sepol_log_err("Unknown target platform: %i", pdb->target_platform);
+		ERR(NULL, "Unknown target platform: %i", pdb->target_platform);
 		rc = -1;
 	}
 
@@ -652,7 +653,7 @@ static int write_default_user_to_cil(FILE *out, char *class_name, class_datum_t
 		dft = "target";
 		break;
 	default:
-		sepol_log_err("Unknown default role value: %i", class->default_user);
+		ERR(NULL, "Unknown default role value: %i", class->default_user);
 		return -1;
 	}
 	sepol_printf(out, "(defaultuser %s %s)\n", class_name, dft);
@@ -672,7 +673,7 @@ static int write_default_role_to_cil(FILE *out, char *class_name, class_datum_t
 		dft = "target";
 		break;
 	default:
-		sepol_log_err("Unknown default role value: %i", class->default_role);
+		ERR(NULL, "Unknown default role value: %i", class->default_role);
 		return -1;
 	}
 	sepol_printf(out, "(defaultrole %s %s)\n", class_name, dft);
@@ -692,7 +693,7 @@ static int write_default_type_to_cil(FILE *out, char *class_name, class_datum_t
 		dft = "target";
 		break;
 	default:
-		sepol_log_err("Unknown default type value: %i", class->default_type);
+		ERR(NULL, "Unknown default type value: %i", class->default_type);
 		return -1;
 	}
 	sepol_printf(out, "(defaulttype %s %s)\n", class_name, dft);
@@ -727,7 +728,7 @@ static int write_default_range_to_cil(FILE *out, char *class_name, class_datum_t
 		dft = "glblub";
 		break;
 	default:
-		sepol_log_err("Unknown default type value: %i", class->default_range);
+		ERR(NULL, "Unknown default type value: %i", class->default_range);
 		return -1;
 	}
 	sepol_printf(out, "(defaultrange %s %s)\n", class_name, dft);
@@ -795,7 +796,7 @@ static int write_default_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing default rules to CIL");
+		ERR(NULL, "Error writing default rules to CIL");
 	}
 
 	return rc;
@@ -906,7 +907,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing sensitivity rules to CIL");
+		ERR(NULL, "Error writing sensitivity rules to CIL");
 	}
 
 	return rc;
@@ -1010,7 +1011,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing category rules to CIL");
+		ERR(NULL, "Error writing category rules to CIL");
 	}
 
 	return rc;
@@ -1141,7 +1142,7 @@ static int write_sensitivitycategory_rules_to_cil(FILE *out, struct policydb *pd
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing sensitivitycategory rules to CIL");
+		ERR(NULL, "Error writing sensitivitycategory rules to CIL");
 	}
 
 	return rc;
@@ -1177,7 +1178,7 @@ static int write_mls_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing mls rules to CIL");
+		ERR(NULL, "Error writing mls rules to CIL");
 	}
 
 	return rc;
@@ -1199,7 +1200,7 @@ static int write_polcap_rules_to_cil(FILE *out, struct policydb *pdb)
 	ebitmap_for_each_positive_bit(&pdb->policycaps, node, i) {
 		name = sepol_polcap_getname(i);
 		if (name == NULL) {
-			sepol_log_err("Unknown policy capability id: %i", i);
+			ERR(NULL, "Unknown policy capability id: %i", i);
 			rc = -1;
 			goto exit;
 		}
@@ -1218,7 +1219,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing polcap rules to CIL");
+		ERR(NULL, "Error writing polcap rules to CIL");
 	}
 
 	return rc;
@@ -1263,7 +1264,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typeattribute rules to CIL");
+		ERR(NULL, "Error writing typeattribute rules to CIL");
 	}
 
 	return rc;
@@ -1308,7 +1309,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing roleattribute rules to CIL");
+		ERR(NULL, "Error writing roleattribute rules to CIL");
 	}
 
 	return rc;
@@ -1348,7 +1349,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing boolean declarations to CIL");
+		ERR(NULL, "Error writing boolean declarations to CIL");
 	}
 
 	return rc;
@@ -1393,7 +1394,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type declarations to CIL");
+		ERR(NULL, "Error writing type declarations to CIL");
 	}
 
 	return rc;
@@ -1476,7 +1477,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type alias rules to CIL");
+		ERR(NULL, "Error writing type alias rules to CIL");
 	}
 
 	return rc;
@@ -1530,7 +1531,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type bounds rules to CIL");
+		ERR(NULL, "Error writing type bounds rules to CIL");
 	}
 
 	return rc;
@@ -1578,7 +1579,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typeattributeset rules to CIL");
+		ERR(NULL, "Error writing typeattributeset rules to CIL");
 	}
 
 	return rc;
@@ -1620,7 +1621,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typepermissive rules to CIL");
+		ERR(NULL, "Error writing typepermissive rules to CIL");
 	}
 
 	return rc;
@@ -1739,7 +1740,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 		flavor = "typechange";
 		break;
 	default:
-		sepol_log_err("Unknown avtab type: %i", key->specified);
+		ERR(NULL, "Unknown avtab type: %i", key->specified);
 		goto exit;
 	}
 
@@ -1756,7 +1757,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 	if (key->specified & AVTAB_AV) {
 		perms = sepol_av_to_string(pdb, key->target_class, data);
 		if (perms == NULL) {
-			sepol_log_err("Failed to generate permission string");
+			ERR(NULL, "Failed to generate permission string");
 			goto exit;
 		}
 		rule = create_str("(%s %s %s (%s (%s)))", 5,
@@ -1764,7 +1765,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 	} else if (key->specified & AVTAB_XPERMS) {
 		perms = xperms_to_str(datum->xperms);
 		if (perms == NULL) {
-			sepol_log_err("Failed to generate extended permission string");
+			ERR(NULL, "Failed to generate extended permission string");
 			goto exit;
 		}
 
@@ -1862,7 +1863,7 @@ static int write_avtab_to_cil(FILE *out, struct policydb *pdb, int indent)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing avtab rules to CIL");
+		ERR(NULL, "Error writing avtab rules to CIL");
 	}
 
 	return rc;
@@ -1933,7 +1934,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing filename typetransition rules to CIL");
+		ERR(NULL, "Error writing filename typetransition rules to CIL");
 	}
 
 	return rc;
@@ -2044,7 +2045,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing range transition rules to CIL");
+		ERR(NULL, "Error writing range transition rules to CIL");
 	}
 
 	return rc;
@@ -2184,7 +2185,7 @@ exit:
 	}
 
 	if (rc != 0) {
-		sepol_log_err("Error writing conditional rules to CIL");
+		ERR(NULL, "Error writing conditional rules to CIL");
 	}
 
 	return rc;
@@ -2309,7 +2310,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role declarations to CIL");
+		ERR(NULL, "Error writing role declarations to CIL");
 	}
 
 	return rc;
@@ -2350,7 +2351,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role transition rules to CIL");
+		ERR(NULL, "Error writing role transition rules to CIL");
 	}
 
 	return rc;
@@ -2388,7 +2389,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role allow rules to CIL");
+		ERR(NULL, "Error writing role allow rules to CIL");
 	}
 
 	return rc;
@@ -2529,7 +2530,7 @@ exit:
 		strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing user declarations to CIL");
+		ERR(NULL, "Error writing user declarations to CIL");
 	}
 
 	return rc;
@@ -2611,7 +2612,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing sidcontext rules to CIL");
+		ERR(NULL, "Error writing sidcontext rules to CIL");
 	}
 
 	return rc;
@@ -2636,7 +2637,7 @@ static int write_selinux_fsuse_rules_to_cil(FILE *out, struct policydb *pdb)
 		case SECURITY_FS_USE_TRANS: behavior = "trans"; break;
 		case SECURITY_FS_USE_TASK:  behavior = "task"; break;
 		default:
-			sepol_log_err("Unknown fsuse behavior: %i", fsuse->v.behavior);
+			ERR(NULL, "Unknown fsuse behavior: %i", fsuse->v.behavior);
 			rc = -1;
 			goto exit;
 		}
@@ -2655,7 +2656,7 @@ static int write_selinux_fsuse_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing fsuse rules to CIL");
+		ERR(NULL, "Error writing fsuse rules to CIL");
 	}
 
 	return rc;
@@ -2733,7 +2734,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing genfscon rules to CIL");
+		ERR(NULL, "Error writing genfscon rules to CIL");
 	}
 
 	return rc;
@@ -2756,7 +2757,7 @@ static int write_selinux_port_rules_to_cil(FILE *out, struct policydb *pdb)
 		case IPPROTO_DCCP: protocol = "dccp"; break;
 		case IPPROTO_SCTP: protocol = "sctp"; break;
 		default:
-			sepol_log_err("Unknown portcon protocol: %i", portcon->u.port.protocol);
+			ERR(NULL, "Unknown portcon protocol: %i", portcon->u.port.protocol);
 			rc = -1;
 			goto exit;
 		}
@@ -2788,7 +2789,7 @@ static int write_selinux_port_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing portcon rules to CIL");
+		ERR(NULL, "Error writing portcon rules to CIL");
 	}
 
 	return rc;
@@ -2822,7 +2823,7 @@ static int write_selinux_netif_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing netifcon rules to CIL");
+		ERR(NULL, "Error writing netifcon rules to CIL");
 	}
 
 	return rc;
@@ -2838,13 +2839,13 @@ static int write_selinux_node_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (node = pdb->ocontexts[4]; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET, &node->u.node.addr, addr, INET_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon address is invalid: %m");
+			ERR(NULL, "Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET, &node->u.node.mask, mask, INET_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon mask is invalid: %m");
+			ERR(NULL, "Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2862,7 +2863,7 @@ static int write_selinux_node_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing nodecon rules to CIL");
+		ERR(NULL, "Error writing nodecon rules to CIL");
 	}
 
 	return rc;
@@ -2878,13 +2879,13 @@ static int write_selinux_node6_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (node = pdb->ocontexts[6]; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET6, &node->u.node6.addr, addr, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon address is invalid: %m");
+			ERR(NULL, "Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET6, &node->u.node6.mask, mask, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon mask is invalid: %m");
+			ERR(NULL, "Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2902,7 +2903,7 @@ static int write_selinux_node6_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing nodecon rules to CIL");
+		ERR(NULL, "Error writing nodecon rules to CIL");
 	}
 
 	return rc;
@@ -2926,7 +2927,7 @@ static int write_selinux_ibpkey_rules_to_cil(FILE *out, struct policydb *pdb)
 
 		if (inet_ntop(AF_INET6, &subnet_prefix.s6_addr,
 			      subnet_prefix_str, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("ibpkeycon subnet_prefix is invalid: %m");
+			ERR(NULL, "ibpkeycon subnet_prefix is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2958,7 +2959,7 @@ static int write_selinux_ibpkey_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ibpkeycon rules to CIL");
+		ERR(NULL, "Error writing ibpkeycon rules to CIL");
 	}
 
 	return rc;
@@ -2995,7 +2996,7 @@ static int write_selinux_ibendport_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ibendportcon rules to CIL");
+		ERR(NULL, "Error writing ibendportcon rules to CIL");
 	}
 
 	return rc;
@@ -3035,7 +3036,7 @@ static int write_xen_pirq_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing pirqcon rules to CIL");
+		ERR(NULL, "Error writing pirqcon rules to CIL");
 	}
 
 	return rc;
@@ -3078,7 +3079,7 @@ static int write_xen_ioport_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ioportcon rules to CIL");
+		ERR(NULL, "Error writing ioportcon rules to CIL");
 	}
 
 	return rc;
@@ -3121,7 +3122,7 @@ static int write_xen_iomem_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing iomemcon rules to CIL");
+		ERR(NULL, "Error writing iomemcon rules to CIL");
 	}
 
 	return rc;
@@ -3156,7 +3157,7 @@ static int write_xen_pcidevice_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing pcidevicecon rules to CIL");
+		ERR(NULL, "Error writing pcidevicecon rules to CIL");
 	}
 
 	return rc;
@@ -3183,7 +3184,7 @@ static int write_xen_devicetree_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing devicetreecon rules to CIL");
+		ERR(NULL, "Error writing devicetreecon rules to CIL");
 	}
 
 	return rc;
@@ -3218,13 +3219,13 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 	}
 
 	if (pdb == NULL) {
-		sepol_log_err("No policy");
+		ERR(NULL, "No policy");
 		rc = -1;
 		goto exit;
 	}
 
 	if (pdb->policy_type != SEPOL_POLICY_KERN) {
-		sepol_log_err("Policy is not a kernel policy");
+		ERR(NULL, "Policy is not a kernel policy");
 		rc = -1;
 		goto exit;
 	}
@@ -3236,7 +3237,7 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
 		 * can refer to those gaps.
 		 */
-		sepol_log_err("Writing policy versions between 20 and 23 as CIL is not supported");
+		ERR(NULL, "Writing policy versions between 20 and 23 as CIL is not supported");
 		rc = -1;
 		goto exit;
 	}
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 8da399e2..09c08b3d 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -18,27 +18,15 @@
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/symtab.h>
 
+#include "debug.h"
 #include "private.h"
 #include "kernel_to_common.h"
 
 
-void sepol_log_err(const char *fmt, ...)
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
 void sepol_indent(FILE *out, int indent)
 {
 	if (fprintf(out, "%*s", indent * 4, "") < 0) {
-		sepol_log_err("Failed to write to output");
+		ERR(NULL, "Failed to write to output");
 	}
 }
 
@@ -47,7 +35,7 @@ void sepol_printf(FILE *out, const char *fmt, ...)
 	va_list argptr;
 	va_start(argptr, fmt);
 	if (vfprintf(out, fmt, argptr) < 0) {
-		sepol_log_err("Failed to write to output");
+		ERR(NULL, "Failed to write to output");
 	}
 	va_end(argptr);
 }
@@ -73,7 +61,7 @@ static char *create_str_helper(const char *fmt, int num, va_list vargs)
 
 	str = malloc(len);
 	if (!str) {
-		sepol_log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		goto exit;
 	}
 
@@ -116,13 +104,13 @@ int strs_init(struct strs **strs, size_t size)
 
 	new = malloc(sizeof(struct strs));
 	if (!new) {
-		sepol_log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		return -1;
 	}
 
 	new->list = calloc(size, sizeof(char *));
 	if (!new->list) {
-		sepol_log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		free(new);
 		return -1;
 	}
@@ -169,7 +157,7 @@ int strs_add(struct strs *strs, char *s)
 		strs->size *= 2;
 		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
-			sepol_log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			return -1;
 		}
 		strs->list = new;
@@ -228,7 +216,7 @@ int strs_add_at_index(struct strs *strs, char *s, size_t index)
 		}
 		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
-			sepol_log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			return -1;
 		}
 		strs->list = new;
@@ -301,7 +289,7 @@ char *strs_to_str(const struct strs *strs)
 	len = strs_len_items(strs) + strs->num;
 	str = malloc(len);
 	if (!str) {
-		sepol_log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		goto exit;
 	}
 
@@ -627,7 +615,7 @@ static int sort_ocontext_data(struct ocontext **ocons, int (*cmp)(const void *,
 
 	data = calloc(sizeof(*data), num);
 	if (!data) {
-		sepol_log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		return -1;
 	}
 
@@ -718,7 +706,7 @@ int sort_ocontexts(struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error sorting ocontexts");
+		ERR(NULL, "Error sorting ocontexts");
 	}
 
 	return rc;
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 159c4289..7a3960b0 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -83,8 +83,6 @@ struct strs {
 	size_t size;
 };
 
-__attribute__ ((format(printf, 1, 2)))
-void sepol_log_err(const char *fmt, ...);
 void sepol_indent(FILE *out, int indent);
 __attribute__ ((format(printf, 2, 3)))
 void sepol_printf(FILE *out, const char *fmt, ...);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 1d812b19..eb85406a 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -24,6 +24,7 @@
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/util.h>
 
+#include "debug.h"
 #include "kernel_to_common.h"
 
 
@@ -58,20 +59,20 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 			case COND_EQ:	op = "=="; num_params = 2; break;
 			case COND_NEQ:	op = "!="; num_params = 2; break;
 			default:
-				sepol_log_err("Unknown conditional operator: %i", curr->expr_type);
+				ERR(NULL, "Unknown conditional operator: %i", curr->expr_type);
 				goto exit;
 			}
 
 			if (num_params == 2) {
 				val2 = strs_stack_pop(stack);
 				if (!val2) {
-					sepol_log_err("Invalid conditional expression");
+					ERR(NULL, "Invalid conditional expression");
 					goto exit;
 				}
 			}
 			val1 = strs_stack_pop(stack);
 			if (!val1) {
-				sepol_log_err("Invalid conditional expression");
+				ERR(NULL, "Invalid conditional expression");
 				free(val2);
 				goto exit;
 			}
@@ -84,19 +85,19 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 			free(val1);
 		}
 		if (!new_val) {
-			sepol_log_err("Invalid conditional expression");
+			ERR(NULL, "Invalid conditional expression");
 			goto exit;
 		}
 		rc = strs_stack_push(stack, new_val);
 		if (rc != 0) {
-			sepol_log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 	}
 
 	new_val = strs_stack_pop(stack);
 	if (!new_val || !strs_stack_empty(stack)) {
-		sepol_log_err("Invalid conditional expression");
+		ERR(NULL, "Invalid conditional expression");
 		goto exit;
 	}
 
@@ -144,7 +145,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			case CEXPR_DOMBY:   op = "domby";  break;
 			case CEXPR_INCOMP:  op = "incomp"; break;
 			default:
-				sepol_log_err("Unknown constraint operator: %i", curr->op);
+				ERR(NULL, "Unknown constraint operator: %i", curr->op);
 				goto exit;
 			}
 
@@ -165,7 +166,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			case CEXPR_L1H1:                 attr1 ="l1"; attr2 ="h1"; break;
 			case CEXPR_L2H2:                 attr1 ="l2"; attr2 ="h2"; break;
 			default:
-				sepol_log_err("Unknown constraint attribute: %i", curr->attr);
+				ERR(NULL, "Unknown constraint attribute: %i", curr->attr);
 				goto exit;
 			}
 
@@ -188,7 +189,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 				if (!names) {
 					names = strdup("NO_IDENTIFIER");
 					if (!names) {
-						sepol_log_err("Out of memory");
+						ERR(NULL, "Out of memory");
 						goto exit;
 					}
 				}
@@ -209,20 +210,20 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			case CEXPR_AND: op = "and"; num_params = 2; break;
 			case CEXPR_OR:  op = "or";  num_params = 2; break;
 			default:
-				sepol_log_err("Unknown constraint expression type: %i", curr->expr_type);
+				ERR(NULL, "Unknown constraint expression type: %i", curr->expr_type);
 				goto exit;
 			}
 
 			if (num_params == 2) {
 				val2 = strs_stack_pop(stack);
 				if (!val2) {
-					sepol_log_err("Invalid constraint expression");
+					ERR(NULL, "Invalid constraint expression");
 					goto exit;
 				}
 			}
 			val1 = strs_stack_pop(stack);
 			if (!val1) {
-				sepol_log_err("Invalid constraint expression");
+				ERR(NULL, "Invalid constraint expression");
 				goto exit;
 			}
 
@@ -239,14 +240,14 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 		}
 		rc = strs_stack_push(stack, new_val);
 		if (rc != 0) {
-			sepol_log_err("Out of memory");
+			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 	}
 
 	new_val = strs_stack_pop(stack);
 	if (!new_val || !strs_stack_empty(stack)) {
-		sepol_log_err("Invalid constraint expression");
+		ERR(NULL, "Invalid constraint expression");
 		goto exit;
 	}
 
@@ -318,7 +319,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 
 	return 0;
 exit:
-	sepol_log_err("Error gathering constraint rules");
+	ERR(NULL, "Error gathering constraint rules");
 	return rc;
 }
 
@@ -425,7 +426,7 @@ static int write_handle_unknown_to_conf(FILE *out, struct policydb *pdb)
 		action = "allow";
 		break;
 	default:
-		sepol_log_err("Unknown value for handle-unknown: %i", pdb->handle_unknown);
+		ERR(NULL, "Unknown value for handle-unknown: %i", pdb->handle_unknown);
 		return -1;
 	}
 
@@ -495,7 +496,7 @@ exit:
 	}
 	strs_destroy(&strs);
 	if (rc != 0) {
-		sepol_log_err("Error writing sid rules to policy.conf");
+		ERR(NULL, "Error writing sid rules to policy.conf");
 	}
 
 	return rc;
@@ -512,7 +513,7 @@ static int write_sid_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 		rc = write_sids_to_conf(out, xen_sid_to_str, XEN_SID_SZ,
 					pdb->ocontexts[0]);
 	} else {
-		sepol_log_err("Unknown target platform: %i", pdb->target_platform);
+		ERR(NULL, "Unknown target platform: %i", pdb->target_platform);
 		rc = -1;
 	}
 
@@ -556,7 +557,7 @@ static int write_class_and_common_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* common */
 	used = calloc(pdb->p_commons.nprim, sizeof(*used));
 	if (!used) {
-		sepol_log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		rc = -1;
 		goto exit;
 	}
@@ -610,7 +611,7 @@ static int write_class_and_common_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing class rules to policy.conf");
+		ERR(NULL, "Error writing class rules to policy.conf");
 	}
 
 	return rc;
@@ -628,7 +629,7 @@ static int write_default_user_to_conf(FILE *out, char *class_name, class_datum_t
 		dft = "target";
 		break;
 	default:
-		sepol_log_err("Unknown default role value: %i", class->default_user);
+		ERR(NULL, "Unknown default role value: %i", class->default_user);
 		return -1;
 	}
 	sepol_printf(out, "default_user { %s } %s;\n", class_name, dft);
@@ -648,7 +649,7 @@ static int write_default_role_to_conf(FILE *out, char *class_name, class_datum_t
 		dft = "target";
 		break;
 	default:
-		sepol_log_err("Unknown default role value: %i", class->default_role);
+		ERR(NULL, "Unknown default role value: %i", class->default_role);
 		return -1;
 	}
 	sepol_printf(out, "default_role { %s } %s;\n", class_name, dft);
@@ -668,7 +669,7 @@ static int write_default_type_to_conf(FILE *out, char *class_name, class_datum_t
 		dft = "target";
 		break;
 	default:
-		sepol_log_err("Unknown default type value: %i", class->default_type);
+		ERR(NULL, "Unknown default type value: %i", class->default_type);
 		return -1;
 	}
 	sepol_printf(out, "default_type { %s } %s;\n", class_name, dft);
@@ -703,7 +704,7 @@ static int write_default_range_to_conf(FILE *out, char *class_name, class_datum_
 		dft = "glblub";
 		break;
 	default:
-		sepol_log_err("Unknown default type value: %i", class->default_range);
+		ERR(NULL, "Unknown default type value: %i", class->default_range);
 		return -1;
 	}
 	sepol_printf(out, "default_range { %s } %s;\n", class_name, dft);
@@ -771,7 +772,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing default rules to policy.conf");
+		ERR(NULL, "Error writing default rules to policy.conf");
 	}
 
 	return rc;
@@ -902,7 +903,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing sensitivity rules to CIL");
+		ERR(NULL, "Error writing sensitivity rules to CIL");
 	}
 
 	return rc;
@@ -1010,7 +1011,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing category rules to policy.conf");
+		ERR(NULL, "Error writing category rules to policy.conf");
 	}
 
 	return rc;
@@ -1129,7 +1130,7 @@ static int write_level_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing level rules to policy.conf");
+		ERR(NULL, "Error writing level rules to policy.conf");
 	}
 
 	return rc;
@@ -1160,7 +1161,7 @@ static int write_mls_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing mls rules to policy.conf");
+		ERR(NULL, "Error writing mls rules to policy.conf");
 	}
 
 	return rc;
@@ -1182,7 +1183,7 @@ static int write_polcap_rules_to_conf(FILE *out, struct policydb *pdb)
 	ebitmap_for_each_positive_bit(&pdb->policycaps, node, i) {
 		name = sepol_polcap_getname(i);
 		if (name == NULL) {
-			sepol_log_err("Unknown policy capability id: %i", i);
+			ERR(NULL, "Unknown policy capability id: %i", i);
 			rc = -1;
 			goto exit;
 		}
@@ -1201,7 +1202,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing polcap rules to policy.conf");
+		ERR(NULL, "Error writing polcap rules to policy.conf");
 	}
 
 	return rc;
@@ -1246,7 +1247,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typeattribute rules to policy.conf");
+		ERR(NULL, "Error writing typeattribute rules to policy.conf");
 	}
 
 	return rc;
@@ -1291,7 +1292,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing roleattribute rules to policy.conf");
+		ERR(NULL, "Error writing roleattribute rules to policy.conf");
 	}
 
 	return rc;
@@ -1331,7 +1332,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing boolean declarations to policy.conf");
+		ERR(NULL, "Error writing boolean declarations to policy.conf");
 	}
 
 	return rc;
@@ -1376,7 +1377,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type declarations to policy.conf");
+		ERR(NULL, "Error writing type declarations to policy.conf");
 	}
 
 	return rc;
@@ -1450,7 +1451,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type alias rules to policy.conf");
+		ERR(NULL, "Error writing type alias rules to policy.conf");
 	}
 
 	return rc;
@@ -1504,7 +1505,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type bounds rules to policy.conf");
+		ERR(NULL, "Error writing type bounds rules to policy.conf");
 	}
 
 	return rc;
@@ -1526,7 +1527,7 @@ static char *attr_strs_to_str(struct strs *strs)
 	len = strs_len_items(strs) + 2*strs->num - 1;
 	str = malloc(len);
 	if (!str) {
-		sepol_log_err("Out of memory");
+		ERR(NULL, "Out of memory");
 		goto exit;
 	}
 
@@ -1631,7 +1632,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typeattributeset rules to policy.conf");
+		ERR(NULL, "Error writing typeattributeset rules to policy.conf");
 	}
 
 	return rc;
@@ -1673,7 +1674,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typepermissive rules to policy.conf");
+		ERR(NULL, "Error writing typepermissive rules to policy.conf");
 	}
 
 	return rc;
@@ -1716,7 +1717,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 		flavor = "type_change";
 		break;
 	default:
-		sepol_log_err("Unknown avtab type: %i", key->specified);
+		ERR(NULL, "Unknown avtab type: %i", key->specified);
 		goto exit;
 	}
 
@@ -1733,7 +1734,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 	if (key->specified & AVTAB_AV) {
 		perms = sepol_av_to_string(pdb, key->target_class, data);
 		if (perms == NULL) {
-			sepol_log_err("Failed to generate permission string");
+			ERR(NULL, "Failed to generate permission string");
 			goto exit;
 		}
 		rule = create_str("%s %s %s:%s { %s };", 5,
@@ -1741,7 +1742,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 	} else if (key->specified & AVTAB_XPERMS) {
 		perms = sepol_extended_perms_to_string(datum->xperms);
 		if (perms == NULL) {
-			sepol_log_err("Failed to generate extended permission string");
+			ERR(NULL, "Failed to generate extended permission string");
 			goto exit;
 		}
 
@@ -1838,7 +1839,7 @@ static int write_avtab_to_conf(FILE *out, struct policydb *pdb, int indent)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing avtab rules to policy.conf");
+		ERR(NULL, "Error writing avtab rules to policy.conf");
 	}
 
 	return rc;
@@ -1909,7 +1910,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing filename typetransition rules to policy.conf");
+		ERR(NULL, "Error writing filename typetransition rules to policy.conf");
 	}
 
 	return rc;
@@ -2020,7 +2021,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing range transition rules to policy.conf");
+		ERR(NULL, "Error writing range transition rules to policy.conf");
 	}
 
 	return rc;
@@ -2158,7 +2159,7 @@ exit:
 	}
 
 	if (rc != 0) {
-		sepol_log_err("Error writing conditional rules to policy.conf");
+		ERR(NULL, "Error writing conditional rules to policy.conf");
 	}
 
 	return rc;
@@ -2240,7 +2241,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role declarations to policy.conf");
+		ERR(NULL, "Error writing role declarations to policy.conf");
 	}
 
 	return rc;
@@ -2281,7 +2282,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role transition rules to policy.conf");
+		ERR(NULL, "Error writing role transition rules to policy.conf");
 	}
 
 	return rc;
@@ -2319,7 +2320,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role allow rules to policy.conf");
+		ERR(NULL, "Error writing role allow rules to policy.conf");
 	}
 
 	return rc;
@@ -2402,7 +2403,7 @@ exit:
 		strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing user declarations to policy.conf");
+		ERR(NULL, "Error writing user declarations to policy.conf");
 	}
 
 	return rc;
@@ -2479,7 +2480,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing sidcontext rules to policy.conf");
+		ERR(NULL, "Error writing sidcontext rules to policy.conf");
 	}
 
 	return rc;
@@ -2504,7 +2505,7 @@ static int write_selinux_fsuse_rules_to_conf(FILE *out, struct policydb *pdb)
 		case SECURITY_FS_USE_TRANS: behavior = "trans"; break;
 		case SECURITY_FS_USE_TASK:  behavior = "task"; break;
 		default:
-			sepol_log_err("Unknown fsuse behavior: %i", fsuse->v.behavior);
+			ERR(NULL, "Unknown fsuse behavior: %i", fsuse->v.behavior);
 			rc = -1;
 			goto exit;
 		}
@@ -2523,7 +2524,7 @@ static int write_selinux_fsuse_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing fsuse rules to policy.conf");
+		ERR(NULL, "Error writing fsuse rules to policy.conf");
 	}
 
 	return rc;
@@ -2601,7 +2602,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing genfscon rules to policy.conf");
+		ERR(NULL, "Error writing genfscon rules to policy.conf");
 	}
 
 	return rc;
@@ -2624,7 +2625,7 @@ static int write_selinux_port_rules_to_conf(FILE *out, struct policydb *pdb)
 		case IPPROTO_DCCP: protocol = "dccp"; break;
 		case IPPROTO_SCTP: protocol = "sctp"; break;
 		default:
-			sepol_log_err("Unknown portcon protocol: %i", portcon->u.port.protocol);
+			ERR(NULL, "Unknown portcon protocol: %i", portcon->u.port.protocol);
 			rc = -1;
 			goto exit;
 		}
@@ -2656,7 +2657,7 @@ static int write_selinux_port_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing portcon rules to policy.conf");
+		ERR(NULL, "Error writing portcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2690,7 +2691,7 @@ static int write_selinux_netif_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing netifcon rules to policy.conf");
+		ERR(NULL, "Error writing netifcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2706,13 +2707,13 @@ static int write_selinux_node_rules_to_conf(FILE *out, struct policydb *pdb)
 
 	for (node = pdb->ocontexts[4]; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET, &node->u.node.addr, addr, INET_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon address is invalid: %m");
+			ERR(NULL, "Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET, &node->u.node.mask, mask, INET_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon mask is invalid: %m");
+			ERR(NULL, "Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2730,7 +2731,7 @@ static int write_selinux_node_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing nodecon rules to policy.conf");
+		ERR(NULL, "Error writing nodecon rules to policy.conf");
 	}
 
 	return rc;
@@ -2747,13 +2748,13 @@ static int write_selinux_node6_rules_to_conf(FILE *out, struct policydb *pdb)
 
 	for (node6 = pdb->ocontexts[6]; node6 != NULL; node6 = node6->next) {
 		if (inet_ntop(AF_INET6, &node6->u.node6.addr, addr, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon address is invalid: %m");
+			ERR(NULL, "Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET6, &node6->u.node6.mask, mask, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon mask is invalid: %m");
+			ERR(NULL, "Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2771,7 +2772,7 @@ static int write_selinux_node6_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing nodecon rules to policy.conf");
+		ERR(NULL, "Error writing nodecon rules to policy.conf");
 	}
 
 	return rc;
@@ -2795,7 +2796,7 @@ static int write_selinux_ibpkey_rules_to_conf(FILE *out, struct policydb *pdb)
 
 		if (inet_ntop(AF_INET6, &subnet_prefix.s6_addr,
 			      subnet_prefix_str, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("ibpkeycon address is invalid: %m");
+			ERR(NULL, "ibpkeycon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2828,7 +2829,7 @@ static int write_selinux_ibpkey_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ibpkeycon rules to policy.conf");
+		ERR(NULL, "Error writing ibpkeycon rules to policy.conf");
 	}
 
 	return rc;
@@ -2864,7 +2865,7 @@ static int write_selinux_ibendport_rules_to_conf(FILE *out, struct policydb *pdb
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ibendportcon rules to policy.conf");
+		ERR(NULL, "Error writing ibendportcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2905,7 +2906,7 @@ static int write_xen_pirq_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing pirqcon rules to policy.conf");
+		ERR(NULL, "Error writing pirqcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2948,7 +2949,7 @@ static int write_xen_ioport_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ioportcon rules to policy.conf");
+		ERR(NULL, "Error writing ioportcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2991,7 +2992,7 @@ static int write_xen_iomem_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing iomemcon rules to policy.conf");
+		ERR(NULL, "Error writing iomemcon rules to policy.conf");
 	}
 
 	return rc;
@@ -3026,7 +3027,7 @@ static int write_xen_pcidevice_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing pcidevicecon rules to policy.conf");
+		ERR(NULL, "Error writing pcidevicecon rules to policy.conf");
 	}
 
 	return rc;
@@ -3053,7 +3054,7 @@ static int write_xen_devicetree_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing devicetreecon rules to policy.conf");
+		ERR(NULL, "Error writing devicetreecon rules to policy.conf");
 	}
 
 	return rc;
@@ -3088,13 +3089,13 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 	}
 
 	if (pdb == NULL) {
-		sepol_log_err("No policy");
+		ERR(NULL, "No policy");
 		rc = -1;
 		goto exit;
 	}
 
 	if (pdb->policy_type != SEPOL_POLICY_KERN) {
-		sepol_log_err("Policy is not a kernel policy");
+		ERR(NULL, "Policy is not a kernel policy");
 		rc = -1;
 		goto exit;
 	}
@@ -3106,7 +3107,7 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
 		 * can refer to those gaps.
 		 */
-		sepol_log_err("Writing policy versions between 20 and 23 as a policy.conf is not supported");
+		ERR(NULL, "Writing policy versions between 20 and 23 as a policy.conf is not supported");
 		rc = -1;
 		goto exit;
 	}
-- 
2.40.1

