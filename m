Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B0CC282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 21:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F5C2084C
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 21:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="nX+1EAOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfBAVIN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:08:13 -0500
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:21772 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBAVIM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 16:08:12 -0500
X-EEMSG-check-017: 186139869|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Feb 2019 21:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549055286; x=1580591286;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cZQa7CFz9MDGNF/yXL7K1kxC9nk2ILGp7cW69tky6pE=;
  b=nX+1EAOkvFU72Y7Id7v+QxHQqkIR/CnPOl9W5QmklRtxwTS15YAlhEgt
   LFg/hpzXlcLY4FkJsSOFfN8bRS3r3kMZ6GwnxH0xFUqmoJW1Solmh6wRV
   TKscKMWcZVwAlFjsuCuBRxnE/eSApfYp6h6RYQen5BXlkhxIusG0vcCl5
   d7EPdMncLD43rH5oaf+w3RwVYgKpYEARg4DM08LBL7jPDzWQZfVOf42yI
   Vj8AQ5mnh3MyCj1OM6CqF4c7odrRVoy4r7J7lbW3LNbNFuPNpat8YPj5d
   sp+fU16fVpx7ksWtws2DF97mGaH+2cMjOZ93608LLz1qMHUnGbuhKyuzo
   g==;
X-IronPort-AV: E=Sophos;i="5.56,549,1539648000"; 
   d="scan'208";a="23413446"
IronPort-PHdr: =?us-ascii?q?9a23=3AFU2xqxY1gnVb/EXqUyMNdGT/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMiybnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?us9adrTALjhjkBOTA37WrbjtV8gLxHrB6koRF03ozab5yPNPdmfq3TY84US2?=
 =?us-ascii?q?RCUMhWWCNPDZixY5cMAucbIepVtZXxq0cIoBCjBQesHuTvyjpQi3Hyx6I61v?=
 =?us-ascii?q?ouERrb1wE+Bd0OqmjUo8vvNKwPVu21zqfJwinZYPNMxTfx9pPFcgwhoP6QXb?=
 =?us-ascii?q?JwdtDdyU80FwzflFmQpovlPy2M2+kLrmOV7PJgWPqyh2MopAx9uDiiyto2ho?=
 =?us-ascii?q?XXiY8Z1ErI+Th/zY0oP9O3UlR7bsShEJZIsiGaMJZ5Td06TmFzvSY61qUGuZ?=
 =?us-ascii?q?mmfCgW0JgnxwDQa/iAc4WQ/hLsTvyRITZlhHJ+Yr6/mxaz/lSgyu37TMW01k?=
 =?us-ascii?q?pFrjFZndXWs3AN1hjT5tCGSvt74EihxS6C2x3c5+xLO0w5lbfXJ4Q/zrM/iJ?=
 =?us-ascii?q?Yfq1nPEjfzmErsja+Wcksk+vKv6+TierjmpJGdOJNuhQHkLqQihNeyAfg4Mw?=
 =?us-ascii?q?cSX2ib/v6w1Lv4/ULjWrlKgfo2krfBvJDAOcsbvrK5AxNS0os78BawETOm0N?=
 =?us-ascii?q?UenXkaI1NIYwyHj4f3NFHUOvz4Dumwg06qkDh1w/DKJLrhAo/CLiuLrLC0Zr?=
 =?us-ascii?q?t56khB2CItwt1FoZFZELcMJLT0QECimsbfC0obOgm52K7MAc9h25lWDWCQCa?=
 =?us-ascii?q?aDLPn6rU6D5uVpJfKFIoASpmCueLAe+/fygCphyhcmdq6z0M5SMii1?=
X-IPAS-Result: =?us-ascii?q?A2A1AACttFRc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VopgTcBMieMHYt0TAEBAQEBAQaKaY5agXsgGAGHUyI0CQ0BAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCOimDFQsBgheCYz+BdQ2qCzOFQ4Rqh3+EQYEPgQeBEYdcG4V8AoEsAYg+B?=
 =?us-ascii?q?oY2gQRXkGUGA5IqDBmSPwEtgwOaETiBVisIAhgpgWiBToIoF448IQMwgQUBA?=
 =?us-ascii?q?YlEgk0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 01 Feb 2019 21:08:04 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions.infosec.tycho.ncsc.mil [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x11L82jo025974
        for <selinux@vger.kernel.org>; Fri, 1 Feb 2019 16:08:04 -0500
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: Fix RESOURCE_LEAK defects reported by coverity scan
Date:   Fri,  1 Feb 2019 16:08:02 -0500
Message-Id: <20190201210802.8822-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These were reported by Petr Lautrbach (plautrba@redhat.com) and this
patch was based on his patch with only a few changes.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_binary.c      | 13 ++++++++++++-
 libsepol/cil/src/cil_resolve_ast.c |  9 +++++++++
 libsepol/cil/src/cil_symtab.c      |  1 +
 libsepol/src/expand.c              |  6 ++++++
 libsepol/src/kernel_to_cil.c       |  2 ++
 libsepol/src/kernel_to_conf.c      |  2 ++
 6 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 0cc6eeb1..a10c3763 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -54,6 +54,7 @@
 #include "cil_binary.h"
 #include "cil_symtab.h"
 #include "cil_find.h"
+#include "cil_build_ast.h"
 
 /* There are 44000 filename_trans in current fedora policy. 1.33 times this is the recommended
  * size of a hashtable. The next power of 2 of this is 2 ** 16.
@@ -930,7 +931,7 @@ int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alias)
 
 exit:
 	level_datum_destroy(sepol_alias);
-	free(sepol_level);
+	free(sepol_alias);
 	free(key);
 	return rc;
 }
@@ -1763,11 +1764,13 @@ int __cil_avrulex_ioctl_to_hashtable(hashtab_t h, uint16_t kind, uint32_t src, u
 		hashtab_xperms = cil_malloc(sizeof(*hashtab_xperms));
 		rc = ebitmap_cpy(hashtab_xperms, xperms);
 		if (rc != SEPOL_OK) {
+			free(hashtab_xperms);
 			free(avtab_key);
 			goto exit;
 		}
 		rc = hashtab_insert(h, (hashtab_key_t)avtab_key, hashtab_xperms);
 		if (rc != SEPOL_OK) {
+			free(hashtab_xperms);
 			free(avtab_key);
 			goto exit;
 		}
@@ -2157,6 +2160,7 @@ static int __cil_cond_expr_to_sepol_expr_helper(policydb_t *pdb, struct cil_list
 			op->expr_type = COND_NEQ;
 			break;
 		default:
+			free(op);
 			goto exit;
 		}
 
@@ -2283,6 +2287,7 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 
 	cond_expr_destroy(tmp_cond->expr);
 	free(tmp_cond);
+	tmp_cond = NULL;
 
 	for (cb_node = node->cl_head; cb_node != NULL; cb_node = cb_node->next) {
 		if (cb_node->flavor == CIL_CONDBLOCK) {
@@ -2327,6 +2332,11 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	return SEPOL_OK;
 
 exit:
+	if (tmp_cond) {
+		if (tmp_cond->expr)
+			cond_expr_destroy(tmp_cond->expr);
+		free(tmp_cond);
+	}
 	return rc;
 }
 
@@ -4797,6 +4807,7 @@ static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t clas
 	return cp_list;
 
 exit:
+	cil_destroy_classperms(cp);
 	cil_log(CIL_ERR,"Failed to create CIL class-permissions from sepol values\n");
 	return NULL;
 }
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index fb9d9174..ea08087d 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -1535,6 +1535,7 @@ int cil_resolve_sidorder(struct cil_tree_node *current, void *extra_args)
 	return SEPOL_OK;
 
 exit:
+	cil_list_destroy(&new, CIL_FALSE);
 	return rc;
 }
 
@@ -1591,6 +1592,7 @@ int cil_resolve_catorder(struct cil_tree_node *current, void *extra_args)
 	return SEPOL_OK;
 
 exit:
+	cil_list_destroy(&new, CIL_FALSE);
 	return rc;
 }
 
@@ -1624,6 +1626,7 @@ int cil_resolve_sensitivityorder(struct cil_tree_node *current, void *extra_args
 	return SEPOL_OK;
 
 exit:
+	cil_list_destroy(&new, CIL_FALSE);
 	return rc;
 }
 
@@ -2853,6 +2856,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					rc = cil_fill_cats(pc, &catset->cats);
 					if (rc != SEPOL_OK) {
 						cil_destroy_catset(catset);
+						cil_destroy_args(new_arg);
 						goto exit;
 					}
 					cil_tree_node_init(&cat_node);
@@ -2877,6 +2881,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					if (rc != SEPOL_OK) {
 						cil_log(CIL_ERR, "Failed to create anonymous level, rc: %d\n", rc);
 						cil_destroy_level(level);
+						cil_destroy_args(new_arg);
 						goto exit;
 					}
 					cil_tree_node_init(&lvl_node);
@@ -2901,6 +2906,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					if (rc != SEPOL_OK) {
 						cil_log(CIL_ERR, "Failed to create anonymous levelrange, rc: %d\n", rc);
 						cil_destroy_levelrange(range);
+						cil_destroy_args(new_arg);
 						goto exit;
 					}
 					cil_tree_node_init(&range_node);
@@ -2925,6 +2931,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					if (rc != SEPOL_OK) {
 						cil_log(CIL_ERR, "Failed to create anonymous ip address, rc: %d\n", rc);
 						cil_destroy_ipaddr(ipaddr);
+						cil_destroy_args(new_arg);
 						goto exit;
 					}
 					cil_tree_node_init(&addr_node);
@@ -2955,6 +2962,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 					if (rc != SEPOL_OK) {
 						cil_log(CIL_ERR, "Failed to create anonymous classpermission\n");
 						cil_destroy_classpermission(cp);
+						cil_destroy_args(new_arg);
 						goto exit;
 					}
 					cil_tree_node_init(&cp_node);
@@ -2970,6 +2978,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 			default:
 				cil_log(CIL_ERR, "Unexpected flavor: %d\n", 
 						(((struct cil_param*)item->data)->flavor));
+				cil_destroy_args(new_arg);
 				rc = SEPOL_ERR;
 				goto exit;
 			}
diff --git a/libsepol/cil/src/cil_symtab.c b/libsepol/cil/src/cil_symtab.c
index 3769979b..2970b863 100644
--- a/libsepol/cil/src/cil_symtab.c
+++ b/libsepol/cil/src/cil_symtab.c
@@ -185,6 +185,7 @@ int cil_complex_symtab_insert(struct cil_complex_symtab *symtab,
 			ckey->key2 == curr->ckey->key2 &&
 			ckey->key3 == curr->ckey->key3 &&
 			ckey->key4 == curr->ckey->key4) {
+			free(node);
 			return SEPOL_EEXIST;
 		}
 
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 6f1b235e..312d137b 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1451,6 +1451,7 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
 				new_trans->name = strdup(cur_rule->name);
 				if (!new_trans->name) {
 					ERR(state->handle, "Out of memory!");
+					free(new_trans);
 					return -1;
 				}
 				new_trans->stype = i + 1;
@@ -1460,6 +1461,8 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
 				otype = calloc(1, sizeof(*otype));
 				if (!otype) {
 					ERR(state->handle, "Out of memory!");
+					free(new_trans->name);
+					free(new_trans);
 					return -1;
 				}
 				otype->otype = mapped_otype;
@@ -1469,6 +1472,9 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
 						    otype);
 				if (rc) {
 					ERR(state->handle, "Out of memory!");
+					free(otype);
+					free(new_trans->name);
+					free(new_trans);
 					return -1;
 				}
 			}
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 63e4d489..ec82f597 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2031,6 +2031,8 @@ static int write_cond_av_list_to_cil(FILE *out, struct policydb *pdb, cond_av_li
 	return 0;
 
 exit:
+	strs_free_all(strs);
+	strs_destroy(&strs);
 	return rc;
 }
 
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 215d940c..afadca6b 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1999,6 +1999,8 @@ static int write_cond_av_list_to_conf(FILE *out, struct policydb *pdb, cond_av_l
 	return 0;
 
 exit:
+	strs_free_all(strs);
+	strs_destroy(&strs);
 	return rc;
 }
 
-- 
2.20.1

