Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9330C433EF
	for <selinux@archiver.kernel.org>; Tue, 26 Apr 2022 10:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346522AbiDZKyj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349321AbiDZKyh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Apr 2022 06:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C71485655
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650970286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AztyClHPmS/RMHXOgaYO5sT8AtemL3iw0aYtgKNYk8Y=;
        b=IfArnX1kgcV6MrW8DxJiu3mlEosZaA9lwh5Y+/J/Yox81DlfeO0vEiUbaE8KevVNPA0kz0
        AaykgMq5c4sLAC2QE6gJC1MWTvMgwYvOi+V8NE1acFuqMHPNCif9oqeJtBrM2cbKkT7Bcl
        weTqdlRyFMVn114/QLnqf8sYxIbpa/w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-qy20mik1NvmGq7iTHG_qPQ-1; Tue, 26 Apr 2022 06:51:25 -0400
X-MC-Unique: qy20mik1NvmGq7iTHG_qPQ-1
Received: by mail-ed1-f70.google.com with SMTP id eg38-20020a05640228a600b00425d61d0302so3886031edb.17
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 03:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AztyClHPmS/RMHXOgaYO5sT8AtemL3iw0aYtgKNYk8Y=;
        b=U0SGh3RwdL9WGJP5b7+8jo8oI+q23k1RkF1oTQ3EL0vzGU1KvNzemSN/ucOYcURnaJ
         t1ux9tBUer6IE52t2RBMsmzeHBSsYC6m5jVn+qMj5KRYS9dfVroOXW5esi2b/koVgLh6
         /+GEMOjmVtkylRHJqPahUdX6PJXKr0YGF33IoQRjXsZCz6qIgy6iTkxPb41ymmYmcYQJ
         y5q3jcfzefYB2FWQGpEp09hRBAVEBoj0GLZmoeF2dAGiUng2wWXM/4dFWcLHaGiYyKYw
         bHCekov5qx1VivEJPUkpIuPahO/YtCQNrrvO0pN26dmy6BgcQ350ERVCLLr1HppJykMR
         QPjQ==
X-Gm-Message-State: AOAM531f4Xl9qigNW+1ytcoDSWAHvtexOqoufdudU1kmCC4WIrEIT9kE
        p+NcSj8TIkF1bG9Q31nxNjI4SFer6zShE8pAt1LxevtewiQdX9/BFLwql2WzdL7EpFpjPthJS1e
        8fymWY5qjrFhSrUJebhs/A2YZrCeDjahqhzdnmime0gH679c6ULuTVvooji5clgougXCxkA==
X-Received: by 2002:a17:906:1114:b0:6ed:864a:3303 with SMTP id h20-20020a170906111400b006ed864a3303mr20624316eja.200.1650970283648;
        Tue, 26 Apr 2022 03:51:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxC1gvanXOAUi6r6GAi90qSdvMhEcoCwLZXtcolM7dIhFd1BI/f4Lo0FU5ebsBr6qxs4od9Gw==
X-Received: by 2002:a17:906:1114:b0:6ed:864a:3303 with SMTP id h20-20020a170906111400b006ed864a3303mr20624281eja.200.1650970283235;
        Tue, 26 Apr 2022 03:51:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id en13-20020a056402528d00b00423dd17c95asm5629959edb.95.2022.04.26.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 03:51:22 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH userspace v2 1/2] libsepol/cil: add support for self keyword in type transitions
Date:   Tue, 26 Apr 2022 12:51:17 +0200
Message-Id: <20220426105118.506847-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426105118.506847-1-omosnace@redhat.com>
References: <20220426105118.506847-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the addition of the anon_inode class in the kernel, 'self'
transition rules became useful, but haven't been implemented.

This patch implements the self keyword in all 'typetransition'
statements at the CIL level and adds some basic coverage to the secilc
test.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/cil/src/cil_binary.c      | 168 +++++++++++++++++++++--------
 libsepol/cil/src/cil_resolve_ast.c |  25 +++--
 secilc/test/policy.cil             |   3 +
 3 files changed, 145 insertions(+), 51 deletions(-)

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
index 02f4f88d..9e812f59 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -130,6 +130,9 @@
 	(typepermissive device_t) 
 	(typemember device_t bin_t file exec_t)
 	(typetransition device_t console_t files console_device_t)
+	(typetransition device_t exec_type files console_device_t)
+	(typetransition exec_type self files console_device_t)
+	(typetransition exec_type self files "filename" console_device_t)
 
 	(roleattribute exec_role)
 	(roleattribute foo_role)
-- 
2.35.1

