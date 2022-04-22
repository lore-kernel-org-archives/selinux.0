Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3EC433EF
	for <selinux@archiver.kernel.org>; Fri, 22 Apr 2022 15:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449508AbiDVPrd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Apr 2022 11:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449556AbiDVPrX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Apr 2022 11:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76DFE5DE71
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650642193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AztyClHPmS/RMHXOgaYO5sT8AtemL3iw0aYtgKNYk8Y=;
        b=P3NcxF2jQOW+PIkKhQduMvqpzzDTh0AK7DrJeoBw4I8zbBMvVV+pyluLC0ntdXNA0hyZK4
        SqH9VPYf3pi5yt3WupzVfl3YcJmAjxdOzkukOOC0+GhjY2PfapQCAmw+Lquz49P5TVaG1B
        Ktc4/b6fRt++7nOknD3Vs494tB6LYv8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-xONmNBlbNDK2CIDZjYh1sw-1; Fri, 22 Apr 2022 11:43:12 -0400
X-MC-Unique: xONmNBlbNDK2CIDZjYh1sw-1
Received: by mail-wm1-f72.google.com with SMTP id g9-20020a1c4e09000000b0038f20d94f01so6191051wmh.8
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 08:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AztyClHPmS/RMHXOgaYO5sT8AtemL3iw0aYtgKNYk8Y=;
        b=zv6pB4uWeEfDHVuzCZ54GW7pGIataIySmIg7fEO/ztEN5a2Yh+5t30M+H44tYj75Ot
         8jZw7nKVkSTYTBPRGYuwnwbacHkxOYa1N+IeMx5sdeOPSbIH3Xub+63A/SY9fF7wEdDk
         JcVHYw6JDAJ/j86YDWaiQo4KBcWiPoL/VEe4rWKemSu6rpdXWDTPM9oNYlgyEGMHkVMM
         j5nxUj9wcsxFBM7qEeba68spF55nrssY/RjzrzsyZEeduUpbLOCEUjFgWMPjZOtmNHYn
         ZInXXjZUxvRN1dsp3LqwiCGzFEcqV+r6+siVjwY3sv549AgJET4+YzAU7rq5+MciNoc9
         4BlA==
X-Gm-Message-State: AOAM53079AzLAE3b/U6zQxEp2IyIMwDgfrBX6uvYD8xPGCO33/pdns73
        wGCuGz3eFcHpbs71ur2N7HkCr+Fvh9ZAqW/w6VxvDkGSLEN8ukvBH4Y10RVrCirzMAR931DCale
        G1Z52aZ/tqYYPKnG98YSGC69kX81C7onFCXV7YqbOSCui8GUIVyx0IZUr4RyObMMwIQIJuA==
X-Received: by 2002:adf:a1c4:0:b0:20a:92c3:abfd with SMTP id v4-20020adfa1c4000000b0020a92c3abfdmr4381199wrv.551.1650642190257;
        Fri, 22 Apr 2022 08:43:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkZsO7CgeZIRCsz3K+GqCcWXDfZ4lSpdLHYbvJqgaAZCNuwQvhPKhdXj3zIIHkcDN2ZVK/Tg==
X-Received: by 2002:adf:a1c4:0:b0:20a:92c3:abfd with SMTP id v4-20020adfa1c4000000b0020a92c3abfdmr4381179wrv.551.1650642189956;
        Fri, 22 Apr 2022 08:43:09 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm2044080wra.96.2022.04.22.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:43:09 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH userspace 1/2] libsepol/cil: add support for self keyword in type transitions
Date:   Fri, 22 Apr 2022 17:43:06 +0200
Message-Id: <20220422154307.968527-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422154307.968527-1-omosnace@redhat.com>
References: <20220422154307.968527-1-omosnace@redhat.com>
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

