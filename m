Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA27C433FE
	for <selinux@archiver.kernel.org>; Fri, 13 May 2022 09:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379222AbiEMJ4k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 May 2022 05:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379275AbiEMJ4h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 May 2022 05:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59D942DD77
        for <selinux@vger.kernel.org>; Fri, 13 May 2022 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652435794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oseWuOpTvLk8aBnERDU2q68qrpghuZvvnsSQxyuO50=;
        b=VbvtSc8pLIymOr/T6YiOQ3LR/DcBmzgKvVTbSfobRY9w7PBXvlevOA/nfxrmMwTrP2gu9k
        zsAGwCW1QRGTWg/vwHxt9Lj3aeyxwv8dr9rpx+L3rx6B8ODAp3je5hXM9QeJkI+CvVij1n
        s/QfERzPMb0Ejvb69oot8LwJewKUxz0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-GFqTJf8SM-W31dT5JbMVuQ-1; Fri, 13 May 2022 05:56:32 -0400
X-MC-Unique: GFqTJf8SM-W31dT5JbMVuQ-1
Received: by mail-ed1-f72.google.com with SMTP id ec44-20020a0564020d6c00b00425b136662eso4674191edb.12
        for <selinux@vger.kernel.org>; Fri, 13 May 2022 02:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8oseWuOpTvLk8aBnERDU2q68qrpghuZvvnsSQxyuO50=;
        b=BuwY9ZmPFwr0qxU7sGvnUhSWUF3fzjiIiIIGFmOdJQBI+NPSYa2/kKOMbwBa773BFT
         y2g7MShx6aWATrCE9c8unIoaO19wygNdEHFm28ojsC4bgRQlxJLrG7FBNHSg71wyCMZT
         xAnG/Z/18dbJ7joPLsu0cOwu4bcLzjnInp3fKWI732M6gC6IQlG8MnqE/AKkWCi84g70
         jFnxUBymPPTti1LncrVg/dNpqK1YksdN6l/iDB6J6r+xeP8eXHTnyUXAX65BvYjJX02k
         QQaHuMJsMMAOwN1MNzdnym0c/sq+Mf816EQp1ydDFqW9AjO+vu2Cm2HOuuLQWHTx9nds
         EeHw==
X-Gm-Message-State: AOAM530wuYAKr4dSUuNo0INp8XFwpLD7/rCZfw1VP8x2ahBZbTHZAMbI
        uEyKEhCjMIkK037CAJlEIfBzPLMb8NnX+08CvohvvJOpt8vrskGRo5QxS/R3xX0cx6Q/Z5WpwMI
        K7yyZvgrSMSauQOttc4Is7cg7Vo5tQjPuDxaBAM1agivoOPHXWf5/GEsRHXfszsZNPFZotQ==
X-Received: by 2002:a17:906:7d5:b0:6f3:a6a5:28c6 with SMTP id m21-20020a17090607d500b006f3a6a528c6mr3603058ejc.11.1652435791163;
        Fri, 13 May 2022 02:56:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSu7TB+mxsUBduxMyApd6UR/S4K4mKtqcARlaM2H21krRSBS3D7sS7j6KPCJk7gCZUEhQrVg==
X-Received: by 2002:a17:906:7d5:b0:6f3:a6a5:28c6 with SMTP id m21-20020a17090607d500b006f3a6a528c6mr3603029ejc.11.1652435790797;
        Fri, 13 May 2022 02:56:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090602cd00b006f3ef214e1asm588189ejk.128.2022.05.13.02.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 02:56:30 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH userspace v4 1/2] libsepol/cil: add support for self keyword in type transitions
Date:   Fri, 13 May 2022 11:56:27 +0200
Message-Id: <20220513095628.154274-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513095628.154274-1-omosnace@redhat.com>
References: <20220513095628.154274-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the addition of the anon_inode class in the kernel, 'self'
transition rules became useful, but haven't been implemented.

The typetransition, typemember, and typechange statements share the
relevant code, so this patch implements the self keyword in all of them
at the CIL level. It also adds basic coverage for the such 'self' rules
to the secilc test policy.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/cil/src/cil_binary.c      | 168 +++++++++++++++++++++--------
 libsepol/cil/src/cil_resolve_ast.c |  25 +++--
 secilc/test/policy.cil             |   7 ++
 3 files changed, 149 insertions(+), 51 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index aceb90e0..40615db2 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1063,24 +1063,53 @@ exit:
 	return rc;
 }
 
+static int __cil_type_rule_to_avtab_helper(policydb_t *pdb,
+					   type_datum_t *sepol_src,
+					   type_datum_t *sepol_tgt,
+					   struct cil_list *class_list,
+					   type_datum_t *sepol_result,
+					   struct cil_type_rule *cil_rule,
+					   cond_node_t *cond_node,
+					   enum cil_flavor cond_flavor)
+{
+	int rc;
+	class_datum_t *sepol_obj = NULL;
+	struct cil_list_item *c;
+
+	cil_list_for_each(c, class_list) {
+		rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
+		if (rc != SEPOL_OK) return rc;
+
+		rc = __cil_insert_type_rule(
+			pdb, cil_rule->rule_kind, sepol_src->s.value,
+			sepol_tgt->s.value, sepol_obj->s.value,
+			sepol_result->s.value, cil_rule, cond_node, cond_flavor
+		);
+		if (rc != SEPOL_OK) return rc;
+	}
+	return SEPOL_OK;
+}
+
 static int __cil_type_rule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_type_rule *cil_rule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_ERR;
-	uint16_t kind = cil_rule->rule_kind;
+	struct cil_symtab_datum *src = NULL;
+	struct cil_symtab_datum *tgt = NULL;
 	type_datum_t *sepol_src = NULL;
 	type_datum_t *sepol_tgt = NULL;
-	class_datum_t *sepol_obj = NULL;
 	struct cil_list *class_list = NULL;
 	type_datum_t *sepol_result = NULL;
 	ebitmap_t src_bitmap, tgt_bitmap;
 	ebitmap_node_t *node1, *node2;
 	unsigned int i, j;
-	struct cil_list_item *c;
 
-	rc = __cil_expand_type(cil_rule->src, &src_bitmap);
-	if (rc != SEPOL_OK) goto exit;
+	ebitmap_init(&src_bitmap);
+	ebitmap_init(&tgt_bitmap);
+
+	src = cil_rule->src;
+	tgt = cil_rule->tgt;
 
-	rc = __cil_expand_type(cil_rule->tgt, &tgt_bitmap);
+	rc = __cil_expand_type(src, &src_bitmap);
 	if (rc != SEPOL_OK) goto exit;
 
 	class_list = cil_expand_class(cil_rule->obj);
@@ -1088,19 +1117,34 @@ static int __cil_type_rule_to_avtab(policydb_t *pdb, const struct cil_db *db, st
 	rc = __cil_get_sepol_type_datum(pdb, DATUM(cil_rule->result), &sepol_result);
 	if (rc != SEPOL_OK) goto exit;
 
-	ebitmap_for_each_positive_bit(&src_bitmap, node1, i) {
-		rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_src);
+	if (tgt->fqn == CIL_KEY_SELF) {
+		ebitmap_for_each_positive_bit(&src_bitmap, node1, i) {
+			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_src);
+			if (rc != SEPOL_OK) goto exit;
+
+			rc = __cil_type_rule_to_avtab_helper(
+				pdb, sepol_src, sepol_src, class_list,
+				sepol_result, cil_rule, cond_node, cond_flavor
+			);
+			if (rc != SEPOL_OK) goto exit;
+		}
+	} else {
+		rc = __cil_expand_type(tgt, &tgt_bitmap);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_positive_bit(&tgt_bitmap, node2, j) {
-			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[j]), &sepol_tgt);
+		ebitmap_for_each_positive_bit(&src_bitmap, node1, i) {
+			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_src);
 			if (rc != SEPOL_OK) goto exit;
 
-			cil_list_for_each(c, class_list) {
-				rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
+			ebitmap_for_each_positive_bit(&tgt_bitmap, node2, j) {
+				rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[j]), &sepol_tgt);
 				if (rc != SEPOL_OK) goto exit;
 
-				rc = __cil_insert_type_rule(pdb, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value, sepol_result->s.value, cil_rule, cond_node, cond_flavor);
+				rc = __cil_type_rule_to_avtab_helper(
+					pdb, sepol_src, sepol_tgt, class_list,
+					sepol_result, cil_rule, cond_node,
+					cond_flavor
+				);
 				if (rc != SEPOL_OK) goto exit;
 			}
 		}
@@ -1120,19 +1164,57 @@ int cil_type_rule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	return  __cil_type_rule_to_avtab(pdb, db, cil_rule, NULL, CIL_FALSE);
 }
 
+static int __cil_typetransition_to_avtab_helper(policydb_t *pdb,
+						type_datum_t *sepol_src,
+						type_datum_t *sepol_tgt,
+						struct cil_list *class_list,
+						char *name,
+						type_datum_t *sepol_result)
+{
+	int rc;
+	class_datum_t *sepol_obj = NULL;
+	uint32_t otype;
+	struct cil_list_item *c;
+
+	cil_list_for_each(c, class_list) {
+		rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
+		if (rc != SEPOL_OK) return rc;
+
+		rc = policydb_filetrans_insert(
+			pdb, sepol_src->s.value, sepol_tgt->s.value,
+			sepol_obj->s.value, name, NULL,
+			sepol_result->s.value, &otype
+		);
+		if (rc != SEPOL_OK) {
+			if (rc == SEPOL_EEXIST) {
+				if (sepol_result->s.value!= otype) {
+					cil_log(CIL_ERR, "Conflicting name type transition rules\n");
+				} else {
+					rc = SEPOL_OK;
+				}
+			} else {
+				cil_log(CIL_ERR, "Out of memory\n");
+			}
+			if (rc != SEPOL_OK) {
+				return rc;
+			}
+		}
+	}
+	return SEPOL_OK;
+}
+
 static int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_nametypetransition *typetrans, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_ERR;
+	struct cil_symtab_datum *src = NULL;
+	struct cil_symtab_datum *tgt = NULL;
 	type_datum_t *sepol_src = NULL;
 	type_datum_t *sepol_tgt = NULL;
-	class_datum_t *sepol_obj = NULL;
 	struct cil_list *class_list = NULL;
 	type_datum_t *sepol_result = NULL;
 	ebitmap_t src_bitmap, tgt_bitmap;
 	ebitmap_node_t *node1, *node2;
 	unsigned int i, j;
-	uint32_t otype;
-	struct cil_list_item *c;
 	char *name = DATUM(typetrans->name)->name;
 
 	if (name == CIL_KEY_STAR) {
@@ -1149,10 +1231,13 @@ static int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *d
 		return __cil_type_rule_to_avtab(pdb, db, &trans, cond_node, cond_flavor);
 	}
 
-	rc = __cil_expand_type(typetrans->src, &src_bitmap);
-	if (rc != SEPOL_OK) goto exit;
+	ebitmap_init(&src_bitmap);
+	ebitmap_init(&tgt_bitmap);
 
-	rc = __cil_expand_type(typetrans->tgt, &tgt_bitmap);
+	src = typetrans->src;
+	tgt = typetrans->tgt;
+
+	rc = __cil_expand_type(src, &src_bitmap);
 	if (rc != SEPOL_OK) goto exit;
 
 	class_list = cil_expand_class(typetrans->obj);
@@ -1160,37 +1245,34 @@ static int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *d
 	rc = __cil_get_sepol_type_datum(pdb, DATUM(typetrans->result), &sepol_result);
 	if (rc != SEPOL_OK) goto exit;
 
-	ebitmap_for_each_positive_bit(&src_bitmap, node1, i) {
-		rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_src);
+	if (tgt->fqn == CIL_KEY_SELF) {
+		ebitmap_for_each_positive_bit(&src_bitmap, node1, i) {
+			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_src);
+			if (rc != SEPOL_OK) goto exit;
+
+			rc = __cil_typetransition_to_avtab_helper(
+				pdb, sepol_src, sepol_src, class_list,
+				name, sepol_result
+			);
+			if (rc != SEPOL_OK) goto exit;
+		}
+	} else {
+		rc = __cil_expand_type(tgt, &tgt_bitmap);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_positive_bit(&tgt_bitmap, node2, j) {
-			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[j]), &sepol_tgt);
+		ebitmap_for_each_positive_bit(&src_bitmap, node1, i) {
+			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_src);
 			if (rc != SEPOL_OK) goto exit;
 
-			cil_list_for_each(c, class_list) {
-				rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
+			ebitmap_for_each_positive_bit(&tgt_bitmap, node2, j) {
+				rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[j]), &sepol_tgt);
 				if (rc != SEPOL_OK) goto exit;
 
-				rc = policydb_filetrans_insert(
-					pdb, sepol_src->s.value, sepol_tgt->s.value,
-					sepol_obj->s.value, name, NULL,
-					sepol_result->s.value, &otype
+				rc = __cil_typetransition_to_avtab_helper(
+					pdb, sepol_src, sepol_tgt, class_list,
+					name, sepol_result
 				);
-				if (rc != SEPOL_OK) {
-					if (rc == SEPOL_EEXIST) {
-						if (sepol_result->s.value!= otype) {
-							cil_log(CIL_ERR, "Conflicting name type transition rules\n");
-						} else {
-							rc = SEPOL_OK;
-						}
-					} else {
-						cil_log(CIL_ERR, "Out of memory\n");
-					}
-					if (rc != SEPOL_OK) {
-						goto exit;
-					}
-				}
+				if (rc != SEPOL_OK) goto exit;
 			}
 		}
 	}
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 7823eb94..f5e22c97 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -373,6 +373,7 @@ exit:
 
 int cil_resolve_type_rule(struct cil_tree_node *current, void *extra_args)
 {
+	struct cil_args_resolve *args = extra_args;
 	struct cil_type_rule *rule = current->data;
 	struct cil_symtab_datum *src_datum = NULL;
 	struct cil_symtab_datum *tgt_datum = NULL;
@@ -387,11 +388,15 @@ int cil_resolve_type_rule(struct cil_tree_node *current, void *extra_args)
 	}
 	rule->src = src_datum;
 
-	rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, extra_args, &tgt_datum);
-	if (rc != SEPOL_OK) {
-		goto exit;
+	if (rule->tgt_str == CIL_KEY_SELF) {
+		rule->tgt = args->db->selftype;
+	} else {
+		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, extra_args, &tgt_datum);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		rule->tgt = tgt_datum;
 	}
-	rule->tgt = tgt_datum;
 
 	rc = cil_resolve_name(current, rule->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
 	if (rc != SEPOL_OK) {
@@ -638,11 +643,15 @@ int cil_resolve_nametypetransition(struct cil_tree_node *current, void *extra_ar
 	}
 	nametypetrans->src = src_datum;
 
-	rc = cil_resolve_name(current, nametypetrans->tgt_str, CIL_SYM_TYPES, extra_args, &tgt_datum);
-	if (rc != SEPOL_OK) {
-		goto exit;
+	if (nametypetrans->tgt_str == CIL_KEY_SELF) {
+		nametypetrans->tgt = args->db->selftype;
+	} else {
+		rc = cil_resolve_name(current, nametypetrans->tgt_str, CIL_SYM_TYPES, extra_args, &tgt_datum);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		nametypetrans->tgt = tgt_datum;
 	}
-	nametypetrans->tgt = tgt_datum;
 
 	rc = cil_resolve_name(current, nametypetrans->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
 	if (rc != SEPOL_OK) {
diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index 02f4f88d..e6b78618 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -129,7 +129,14 @@
 	(typealiasactual sbin_t bin_t)
 	(typepermissive device_t) 
 	(typemember device_t bin_t file exec_t)
+	(typemember exec_type self file exec_t)
 	(typetransition device_t console_t files console_device_t)
+	(typetransition device_t exec_type files console_device_t)
+	(typetransition exec_type self files console_device_t)
+	(typetransition exec_type self files "filename" console_device_t)
+	(typechange console_device_t device_t file user_tty_device_t)
+	(typechange exec_type device_t file user_tty_device_t)
+	(typechange exec_type self file console_device_t)
 
 	(roleattribute exec_role)
 	(roleattribute foo_role)
-- 
2.36.1

