Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F96C433F5
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 14:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiCaOtx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiCaOtw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 10:49:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A8721FC64
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:48:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b24so28424173edu.10
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XsQV4ZR3hnpbmmDoonnSS/bCLiErwPEOUhLyeiXeYgU=;
        b=Ed7ZBZLu8EWn2IRQiRwahSklqQyLIOy0Uq2sBa70webXUW14zr6M1jl7H+8h0s4+7d
         27lE4mHDPzVH9snZImzG4Hlm/9IebPkoBkFuMyXDriLtiKUI27AJ+paqR/yb3cjdpuFl
         3kPcf9AwNmjE7ZCDy+Ls4FOZxH887S78ZpdDQzeIZVxbE8sqQC1NQYapJ4F8PgScO++S
         RHdXyleK0WgNa1BjMvD8ZXr/mHZn8qD/HHgVfc4GnObyNaSSL+v48RitcJgVIdNm+Drf
         wIERC/4VgsWr6mrwsNK1GIGcIEKUgYv/Vu9eDfUwIjC+VKGu3Uj5hlM+8ahRU+MnVWFb
         JZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XsQV4ZR3hnpbmmDoonnSS/bCLiErwPEOUhLyeiXeYgU=;
        b=Dq8O0aTN86HzpTUTunTgaeEb44yFH6uR+p0mI55wMzH48JYdkb+tXJLiimQiQvZ8Gp
         zbKMm1v6psN2qQlbpzVPiQGkhmx/rKSv+dwsgR3dql0aBa4JPKIJLkyVXdooyR0ASiWS
         r1patUgz6RouTOgkje1A8SLCJMPGc5foWh/XdixCLb5bR5yuJrHCrUG7j4jv3BlSntaa
         2qMmvIMEZmImFeqLaGFGBKVRR/qU3QvLZQKdp3ZyS9LO8yaGmQQ1HhUV81da5Hz0x7hz
         XMz2SDBW+r/BcxugASjh1YFx2tgnMZTR8VsSJM+Uzt88UybC0afRzx7TOK6k+EuzzqVx
         v2XA==
X-Gm-Message-State: AOAM530cO77eRVFhwV485TMBaKZ8QUD1Tt/0RUJKBlc6ZIVTCSHEUyR/
        MGTCLOtSbjG20iVqIO2DR3Hr0h0Lu04=
X-Google-Smtp-Source: ABdhPJxeiBGRF4/TVDBm2q9E1WSs6z5hunuTcJ58oqU1kXCbFlixgnCYe6N7RZdd2Y5BAeCDVMKUmw==
X-Received: by 2002:a05:6402:27d0:b0:419:5184:58ae with SMTP id c16-20020a05640227d000b00419518458aemr16960029ede.314.1648738080748;
        Thu, 31 Mar 2022 07:48:00 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-065-043.77.6.pool.telefonica.de. [77.6.65.43])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm3163368edt.94.2022.03.31.07.47.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:48:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/4] libsepol/cil: declare file local functions static
Date:   Thu, 31 Mar 2022 16:47:49 +0200
Message-Id: <20220331144752.31495-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c      | 110 ++++++++++++++---------------
 libsepol/cil/src/cil_build_ast.c   |  16 ++---
 libsepol/cil/src/cil_copy_ast.c    |  46 ++++++------
 libsepol/cil/src/cil_find.c        |   2 +-
 libsepol/cil/src/cil_list.c        |   2 +-
 libsepol/cil/src/cil_log.c         |   2 +-
 libsepol/cil/src/cil_post.c        |  36 +++++-----
 libsepol/cil/src/cil_reset_ast.c   |   2 +-
 libsepol/cil/src/cil_resolve_ast.c |  68 +++++++++---------
 libsepol/cil/src/cil_symtab.c      |   4 +-
 libsepol/cil/src/cil_tree.c        |   2 +-
 libsepol/cil/src/cil_verify.c      |  60 ++++++++--------
 libsepol/cil/src/cil_write_ast.c   |   2 +-
 13 files changed, 176 insertions(+), 176 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 53017e2d..7ce391e7 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -284,7 +284,7 @@ exit:
 	return rc;
 }
 
-int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
+static int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr_class;
@@ -396,7 +396,7 @@ exit:
 	return rc;
 }
 
-int cil_role_bounds_to_policydb(policydb_t *pdb, struct cil_role *cil_role)
+static int cil_role_bounds_to_policydb(policydb_t *pdb, struct cil_role *cil_role)
 {
 	int rc = SEPOL_ERR;
 	role_datum_t *sepol_role = NULL;
@@ -479,7 +479,7 @@ exit:
 	return rc;
 }
 
-int cil_type_bounds_to_policydb(policydb_t *pdb, struct cil_type *cil_type)
+static int cil_type_bounds_to_policydb(policydb_t *pdb, struct cil_type *cil_type)
 {
 	int rc = SEPOL_ERR;
 	type_datum_t *sepol_type = NULL;
@@ -587,7 +587,7 @@ exit:
 	return rc;
 }
 
-int __cil_typeattr_bitmap_init(policydb_t *pdb)
+static int __cil_typeattr_bitmap_init(policydb_t *pdb)
 {
 	int rc = SEPOL_ERR;
 	uint32_t i;
@@ -698,7 +698,7 @@ exit:
 	return rc;
 }
 
-int cil_user_bounds_to_policydb(policydb_t *pdb, struct cil_user *cil_user)
+static int cil_user_bounds_to_policydb(policydb_t *pdb, struct cil_user *cil_user)
 {
 	int rc = SEPOL_ERR;
 	user_datum_t *sepol_user = NULL;
@@ -881,7 +881,7 @@ exit:
 	return rc;
 }
 
-int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alias)
+static int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alias)
 {
 	int rc = SEPOL_ERR;
 	char *key = NULL;
@@ -919,7 +919,7 @@ exit:
 	return rc;
 }
 
-int __cil_cond_insert_rule(avtab_t *avtab, avtab_key_t *avtab_key, avtab_datum_t *avtab_datum, cond_node_t *cond_node, enum cil_flavor cond_flavor)
+static int __cil_cond_insert_rule(avtab_t *avtab, avtab_key_t *avtab_key, avtab_datum_t *avtab_datum, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_OK;
 	avtab_ptr_t avtab_ptr = NULL;
@@ -954,7 +954,7 @@ exit:
 	return rc;
 }
 
-avtab_datum_t *cil_cond_av_list_search(avtab_key_t *key, cond_av_list_t *cond_list)
+static avtab_datum_t *cil_cond_av_list_search(avtab_key_t *key, cond_av_list_t *cond_list)
 {
 	cond_av_list_t *cur_av;
 
@@ -970,7 +970,7 @@ avtab_datum_t *cil_cond_av_list_search(avtab_key_t *key, cond_av_list_t *cond_li
 	return NULL;
 }
 
-int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src, uint32_t tgt, uint32_t obj, uint32_t res, struct cil_type_rule *cil_rule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
+static int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src, uint32_t tgt, uint32_t obj, uint32_t res, struct cil_type_rule *cil_rule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_OK;
 	avtab_key_t avtab_key;
@@ -1063,7 +1063,7 @@ exit:
 	return rc;
 }
 
-int __cil_type_rule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_type_rule *cil_rule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
+static int __cil_type_rule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_type_rule *cil_rule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_ERR;
 	uint16_t kind = cil_rule->rule_kind;
@@ -1120,7 +1120,7 @@ int cil_type_rule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	return  __cil_type_rule_to_avtab(pdb, db, cil_rule, NULL, CIL_FALSE);
 }
 
-int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_nametypetransition *typetrans, cond_node_t *cond_node, enum cil_flavor cond_flavor)
+static int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_nametypetransition *typetrans, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_ERR;
 	type_datum_t *sepol_src = NULL;
@@ -1209,7 +1209,7 @@ int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, str
 	return  __cil_typetransition_to_avtab(pdb, db, typetrans, NULL, CIL_FALSE);
 }
 
-int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t *datum)
+static int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t *datum)
 {
 	int rc;
 	perm_datum_t *sepol_perm;
@@ -1233,7 +1233,7 @@ exit:
 	return rc;
 }
 
-int __cil_perms_to_datum(struct cil_list *perms, class_datum_t *sepol_class, uint32_t *datum)
+static int __cil_perms_to_datum(struct cil_list *perms, class_datum_t *sepol_class, uint32_t *datum)
 {
 	int rc = SEPOL_ERR;
 	char *key = NULL;
@@ -1259,7 +1259,7 @@ exit:
 	return rc;
 }
 
-int __cil_insert_avrule(policydb_t *pdb, uint32_t kind, uint32_t src, uint32_t tgt, uint32_t obj, uint32_t data, cond_node_t *cond_node, enum cil_flavor cond_flavor)
+static int __cil_insert_avrule(policydb_t *pdb, uint32_t kind, uint32_t src, uint32_t tgt, uint32_t obj, uint32_t data, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_OK;
 	avtab_key_t avtab_key;
@@ -1306,7 +1306,7 @@ exit:
 	return rc;
 }
 
-int __cil_avrule_expand_helper(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_classperms *cp, cond_node_t *cond_node, enum cil_flavor cond_flavor)
+static int __cil_avrule_expand_helper(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_classperms *cp, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_ERR;
 	type_datum_t *sepol_src = NULL;
@@ -1347,7 +1347,7 @@ exit:
 }
 
 
-int __cil_avrule_expand(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_list *classperms, cond_node_t *cond_node, enum cil_flavor cond_flavor)
+static int __cil_avrule_expand(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_list *classperms, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
@@ -1402,7 +1402,7 @@ static int __cil_should_expand_attribute( const struct cil_db *db, struct cil_sy
 	return !attr->keep || (ebitmap_cardinality(attr->types) < db->attrs_expand_size);
 }
 
-int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
+static int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_ERR;
 	uint16_t kind = cil_avrule->rule_kind;
@@ -1528,7 +1528,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_
 #define XPERM_LOW(x) (x << 5)
 /* high value for this u32 */
 #define XPERM_HIGH(x) (((x + 1) << 5) - 1)
-void __avrule_xperm_setrangebits(uint16_t low, uint16_t high, struct avtab_extended_perms *xperms)
+static void __avrule_xperm_setrangebits(uint16_t low, uint16_t high, struct avtab_extended_perms *xperms)
 {
 	unsigned int i;
 	uint16_t h = high + 1;
@@ -1553,7 +1553,7 @@ void __avrule_xperm_setrangebits(uint16_t low, uint16_t high, struct avtab_exten
 #define IOC_DRIV(x) (x >> 8)
 #define IOC_FUNC(x) (x & 0xff)
 
-int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct cil_list **xperms_list)
+static int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct cil_list **xperms_list)
 {
 	ebitmap_node_t *node;
 	unsigned int i;
@@ -1618,7 +1618,7 @@ int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct cil_list *
 	return SEPOL_OK;
 }
 
-int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void *args)
+static int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void *args)
 {
 	int rc = SEPOL_OK;
 	struct policydb *pdb;
@@ -1668,7 +1668,7 @@ exit:
 	return rc;
 }
 
-int __cil_avrulex_ioctl_to_hashtable(hashtab_t h, uint16_t kind, uint32_t src, uint32_t tgt, uint32_t obj, ebitmap_t *xperms)
+static int __cil_avrulex_ioctl_to_hashtable(hashtab_t h, uint16_t kind, uint32_t src, uint32_t tgt, uint32_t obj, ebitmap_t *xperms)
 {
 	uint16_t specified;
 	avtab_key_t *avtab_key;
@@ -1725,7 +1725,7 @@ exit:
 	return rc;
 }
 
-int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_permissionx *permx, struct cil_args_binary *args)
+static int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_permissionx *permx, struct cil_args_binary *args)
 {
 	int rc = SEPOL_ERR;
 	type_datum_t *sepol_src = NULL;
@@ -1765,7 +1765,7 @@ exit:
 	return rc;
 }
 
-int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrulex, struct cil_args_binary *args)
+static int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrulex, struct cil_args_binary *args)
 {
 	int rc = SEPOL_ERR;
 	uint16_t kind;
@@ -1883,7 +1883,7 @@ static int __cil_avrulex_ioctl_destroy(hashtab_key_t k, hashtab_datum_t datum, _
 	return SEPOL_OK;
 }
 
-int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
+static int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
 {
 	int rc;
 	enum cil_flavor flavor;
@@ -2174,7 +2174,7 @@ static int __cil_cond_expr_to_sepol_expr(policydb_t *pdb, struct cil_list *cil_e
 	return SEPOL_OK;
 }
 
-int __cil_validate_cond_expr(cond_expr_t *cond_expr)
+static int __cil_validate_cond_expr(cond_expr_t *cond_expr)
 {
 	cond_expr_t *e;
 	int depth = -1;
@@ -2454,7 +2454,7 @@ exit:
 	return rc;
 }
 
-int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, const struct cil_db *db, struct cil_list_item *item, enum cil_flavor expr_flavor, constraint_expr_t *expr)
+static int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, const struct cil_db *db, struct cil_list_item *item, enum cil_flavor expr_flavor, constraint_expr_t *expr)
 {
 	int rc = SEPOL_ERR;
 
@@ -2554,7 +2554,7 @@ exit:
 	return SEPOL_ERR;
 }
 
-int __cil_constrain_expr_leaf_to_sepol_expr(policydb_t *pdb, const struct cil_db *db, struct cil_list_item *op_item, enum cil_flavor expr_flavor, constraint_expr_t *expr)
+static int __cil_constrain_expr_leaf_to_sepol_expr(policydb_t *pdb, const struct cil_db *db, struct cil_list_item *op_item, enum cil_flavor expr_flavor, constraint_expr_t *expr)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *l_item = op_item->next;
@@ -2649,7 +2649,7 @@ exit:
 	return rc;
 }
 
-int __cil_constrain_expr_to_sepol_expr_helper(policydb_t *pdb, const struct cil_db *db, const struct cil_list *cil_expr, constraint_expr_t **head, constraint_expr_t **tail)
+static int __cil_constrain_expr_to_sepol_expr_helper(policydb_t *pdb, const struct cil_db *db, const struct cil_list *cil_expr, constraint_expr_t **head, constraint_expr_t **tail)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *item;
@@ -2747,7 +2747,7 @@ exit:
 	return SEPOL_ERR;
 }
 
-int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const struct cil_db *db, const struct cil_list *cil_expr, constraint_expr_t **sepol_expr)
+static int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const struct cil_db *db, const struct cil_list *cil_expr, constraint_expr_t **sepol_expr)
 {
 	int rc;
 	constraint_expr_t *head, *tail;
@@ -2762,7 +2762,7 @@ int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const struct cil_db *db,
 	return SEPOL_OK;
 }
 
-int __cil_validate_constrain_expr(constraint_expr_t *sepol_expr)
+static int __cil_validate_constrain_expr(constraint_expr_t *sepol_expr)
 {
 	constraint_expr_t *e;
 	int depth = -1;
@@ -2805,7 +2805,7 @@ int __cil_validate_constrain_expr(constraint_expr_t *sepol_expr)
 	return SEPOL_OK;
 }
 
-int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, struct cil_symtab_datum *class, struct cil_list *perms, struct cil_list *expr)
+static int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, struct cil_symtab_datum *class, struct cil_list *perms, struct cil_list *expr)
 {
 	int rc = SEPOL_ERR;
 	constraint_node_t *sepol_constrain = NULL;
@@ -2851,7 +2851,7 @@ exit:
 	return rc;
 }
 
-int cil_constrain_expand(policydb_t *pdb, const struct cil_db *db, struct cil_list *classperms, struct cil_list *expr)
+static int cil_constrain_expand(policydb_t *pdb, const struct cil_db *db, struct cil_list *classperms, struct cil_list *expr)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
@@ -2905,7 +2905,7 @@ exit:
 	return rc;
 }
 
-int cil_validatetrans_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_validatetrans *cil_validatetrans)
+static int cil_validatetrans_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_validatetrans *cil_validatetrans)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list *expr = cil_validatetrans->datum_expr;
@@ -2942,7 +2942,7 @@ exit:
 	return rc;
 }
 
-int __cil_cats_to_mls_level(policydb_t *pdb, struct cil_cats *cats, mls_level_t *mls_level)
+static int __cil_cats_to_mls_level(policydb_t *pdb, struct cil_cats *cats, mls_level_t *mls_level)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *i;
@@ -3035,7 +3035,7 @@ exit:
 	return rc;
 }
 
-int __cil_levelrange_to_mls_range(policydb_t *pdb, struct cil_levelrange *cil_lvlrange, mls_range_t *mls_range)
+static int __cil_levelrange_to_mls_range(policydb_t *pdb, struct cil_levelrange *cil_lvlrange, mls_range_t *mls_range)
 {
 	int rc = SEPOL_ERR;
 	struct cil_level *low = cil_lvlrange->low;
@@ -3062,7 +3062,7 @@ exit:
 	return rc;
 }
 
-int cil_userlevel_userrange_to_policydb(policydb_t *pdb, struct cil_user *cil_user)
+static int cil_userlevel_userrange_to_policydb(policydb_t *pdb, struct cil_user *cil_user)
 {
 	int rc = SEPOL_ERR;
 	struct cil_level *cil_level = cil_user->dftlevel;
@@ -3088,7 +3088,7 @@ exit:
 	return rc;
 }
 
-int __cil_context_to_sepol_context(policydb_t *pdb, struct cil_context *cil_context, context_struct_t *sepol_context)
+static int __cil_context_to_sepol_context(policydb_t *pdb, struct cil_context *cil_context, context_struct_t *sepol_context)
 {
 	int rc = SEPOL_ERR;
 	struct cil_levelrange *cil_lvlrange = cil_context->range;
@@ -3126,7 +3126,7 @@ exit:
 	return rc;
 }
 
-int cil_sidorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
+static int cil_sidorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
@@ -3615,7 +3615,7 @@ exit:
 	return rc;
 }
 
-int cil_devicetreecon_to_policydb(policydb_t *pdb, struct cil_sort *devicetreecons)
+static int cil_devicetreecon_to_policydb(policydb_t *pdb, struct cil_sort *devicetreecons)
 {
 	int rc = SEPOL_ERR;
 	uint32_t i = 0;
@@ -3639,7 +3639,7 @@ exit:
 	return rc;
 }
 
-int cil_default_to_policydb(policydb_t *pdb, struct cil_default *def)
+static int cil_default_to_policydb(policydb_t *pdb, struct cil_default *def)
 {
 	struct cil_list_item *curr;
 	class_datum_t *sepol_class;
@@ -3694,7 +3694,7 @@ exit:
 	return SEPOL_ERR;
 }
 
-int cil_defaultrange_to_policydb(policydb_t *pdb, struct cil_defaultrange *def)
+static int cil_defaultrange_to_policydb(policydb_t *pdb, struct cil_defaultrange *def)
 {
 	struct cil_list_item *curr;
 	class_datum_t *sepol_class;
@@ -3727,7 +3727,7 @@ exit:
 	return SEPOL_ERR;
 }
 
-int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
+static int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 {
 	int rc = SEPOL_OK;
 	int pass;
@@ -3909,7 +3909,7 @@ exit:
 	return rc;
 }
 
-int __cil_binary_create_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
+static int __cil_binary_create_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
 {
 	int rc = SEPOL_ERR;
 
@@ -3937,7 +3937,7 @@ exit:
 	return rc;
 }
 
-int __cil_contexts_to_policydb(policydb_t *pdb, const struct cil_db *db)
+static int __cil_contexts_to_policydb(policydb_t *pdb, const struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 
@@ -4007,7 +4007,7 @@ exit:
 	return rc;
 }
 
-int __cil_common_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static int __cil_common_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	policydb_t *pdb = data;
 	common_datum_t *common = (common_datum_t *)datum;
@@ -4020,7 +4020,7 @@ int __cil_common_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void
 	return 0;
 }
 
-int __cil_class_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static int __cil_class_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	policydb_t *pdb = data;
 	class_datum_t *class = (class_datum_t *)datum;
@@ -4034,7 +4034,7 @@ int __cil_class_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void
 	return 0;
 }
 
-int __cil_role_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static int __cil_role_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	policydb_t *pdb = data;
 	role_datum_t *role = (role_datum_t *)datum;
@@ -4048,7 +4048,7 @@ int __cil_role_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *
 	return 0;
 }
 
-int __cil_type_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static int __cil_type_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	policydb_t *pdb = data;
 	type_datum_t *type = (type_datum_t *)datum;
@@ -4062,7 +4062,7 @@ int __cil_type_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *
 	return 0;
 }
 
-int __cil_user_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static int __cil_user_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	policydb_t *pdb = data;
 	user_datum_t *user = (user_datum_t *)datum;
@@ -4076,7 +4076,7 @@ int __cil_user_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *
 	return 0;
 }
 
-int __cil_bool_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static int __cil_bool_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	policydb_t *pdb = data;
 	cond_bool_datum_t *bool = (cond_bool_datum_t *)datum;
@@ -4090,7 +4090,7 @@ int __cil_bool_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *
 	return 0;
 }
 
-int __cil_level_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static int __cil_level_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	policydb_t *pdb = data;
 	level_datum_t *level = (level_datum_t *)datum;
@@ -4103,7 +4103,7 @@ int __cil_level_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void
 	return 0;
 }
 
-int __cil_cat_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static int __cil_cat_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	policydb_t *pdb = data;
 	cat_datum_t *cat = (cat_datum_t *)datum;
@@ -4116,7 +4116,7 @@ int __cil_cat_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *d
 	return 0;
 }
 
-int __cil_policydb_val_arrays_create(policydb_t *policydb)
+static int __cil_policydb_val_arrays_create(policydb_t *policydb)
 {
 	int rc = SEPOL_ERR;
 
@@ -4211,7 +4211,7 @@ static void __cil_set_conditional_state_and_flags(policydb_t *pdb)
 	}
 }
 
-int __cil_policydb_create(const struct cil_db *db, struct sepol_policydb **spdb)
+static int __cil_policydb_create(const struct cil_db *db, struct sepol_policydb **spdb)
 {
 	int rc;
 	struct policydb *pdb = NULL;
@@ -4240,7 +4240,7 @@ exit:
 }
 
 
-int __cil_policydb_init(policydb_t *pdb, const struct cil_db *db, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
+static int __cil_policydb_init(policydb_t *pdb, const struct cil_db *db, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
 {
 	int rc = SEPOL_ERR;
 
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 5f9392d1..26fa7906 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -56,7 +56,7 @@ struct cil_args_build {
 	struct cil_tree_node *boolif;
 };
 
-int cil_fill_list(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **list)
+static int cil_fill_list(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **list)
 {
 	int rc = SEPOL_ERR;
 	struct cil_tree_node *curr;
@@ -176,7 +176,7 @@ exit:
 	return rc;
 }
 
-void cil_clear_node(struct cil_tree_node *ast_node)
+static void cil_clear_node(struct cil_tree_node *ast_node)
 {
 	if (ast_node == NULL) {
 		return;
@@ -2141,7 +2141,7 @@ void cil_destroy_avrule(struct cil_avrule *rule)
 	free(rule);
 }
 
-int cil_fill_permissionx(struct cil_tree_node *parse_current, struct cil_permissionx *permx)
+static int cil_fill_permissionx(struct cil_tree_node *parse_current, struct cil_permissionx *permx)
 {
 	enum cil_syntax syntax[] = {
 		CIL_SYN_STRING,
@@ -2844,7 +2844,7 @@ exit:
 	return rc;
 }
 
-int cil_gen_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr)
+static int cil_gen_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr)
 {
 	int rc = SEPOL_ERR;
 
@@ -3583,7 +3583,7 @@ void cil_destroy_category(struct cil_cat *cat)
 	free(cat);
 }
 
-int cil_gen_catset(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+static int cil_gen_catset(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	enum cil_syntax syntax[] = {
 		CIL_SYN_STRING,
@@ -6476,7 +6476,7 @@ static struct cil_tree_node * parse_statement(struct cil_db *db, struct cil_tree
 	return new_ast_node;
 }
 
-int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *finished, void *extra_args)
+static int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *finished, void *extra_args)
 {
 	struct cil_args_build *args = extra_args;
 	struct cil_tree_node *new_ast_node = NULL;
@@ -6524,7 +6524,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	return SEPOL_OK;
 }
 
-int __cil_build_ast_first_child_helper(__attribute__((unused)) struct cil_tree_node *parse_current, void *extra_args)
+static int __cil_build_ast_first_child_helper(__attribute__((unused)) struct cil_tree_node *parse_current, void *extra_args)
 {
 	struct cil_args_build *args = extra_args;
 	struct cil_tree_node *ast = args->ast;
@@ -6544,7 +6544,7 @@ int __cil_build_ast_first_child_helper(__attribute__((unused)) struct cil_tree_n
 	return SEPOL_OK;
 }
 
-int __cil_build_ast_last_child_helper(struct cil_tree_node *parse_current, void *extra_args)
+static int __cil_build_ast_last_child_helper(struct cil_tree_node *parse_current, void *extra_args)
 {
 	struct cil_args_build *args = extra_args;
 	struct cil_tree_node *ast = args->ast;
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index a4ead9db..17f05021 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -85,7 +85,7 @@ void cil_copy_list(struct cil_list *data, struct cil_list **copy)
 	*copy = new;
 }
 
-int cil_copy_node(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_node(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	char *new = NULL;
 
@@ -151,7 +151,7 @@ int cil_copy_blockinherit(__attribute__((unused)) struct cil_db *db, void *data,
 	return SEPOL_OK;
 }
 
-int cil_copy_policycap(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+static int cil_copy_policycap(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_policycap *orig = data;
 	char *key = orig->datum.name;
@@ -641,7 +641,7 @@ int cil_copy_typeattributeset(struct cil_db *db, void *data, void **copy, __attr
 	return SEPOL_OK;
 }
 
-int cil_copy_expandtypeattribute(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_expandtypeattribute(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_expandtypeattribute *orig = data;
 	struct cil_expandtypeattribute *new = NULL;
@@ -663,7 +663,7 @@ int cil_copy_expandtypeattribute(__attribute__((unused)) struct cil_db *db, void
 	return SEPOL_OK;
 }
 
-int cil_copy_alias(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+static int cil_copy_alias(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_alias *orig = data;
 	struct cil_alias *new = NULL;
@@ -683,7 +683,7 @@ int cil_copy_alias(__attribute__((unused)) struct cil_db *db, void *data, void *
 	return SEPOL_OK;
 }
 
-int cil_copy_aliasactual(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused))symtab_t *symtab)
+static int cil_copy_aliasactual(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused))symtab_t *symtab)
 {
 	struct cil_aliasactual *orig = data;
 	struct cil_aliasactual *new = NULL;
@@ -698,7 +698,7 @@ int cil_copy_aliasactual(__attribute__((unused)) struct cil_db *db, void *data,
 	return SEPOL_OK;
 }
 
-int cil_copy_roletransition(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_roletransition(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_roletransition *orig = data;
 	struct cil_roletransition *new = NULL;
@@ -777,7 +777,7 @@ int cil_copy_bool(__attribute__((unused)) struct cil_db *db, void *data, void **
 	return SEPOL_OK;
 }
 
-int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+static int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_tunable *orig = data;
 	struct cil_tunable *new = NULL;
@@ -797,7 +797,7 @@ int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, void *data, void
 	return SEPOL_OK;
 }
 
-void cil_copy_fill_permissionx(struct cil_db *db, struct cil_permissionx *orig, struct cil_permissionx *new)
+static void cil_copy_fill_permissionx(struct cil_db *db, struct cil_permissionx *orig, struct cil_permissionx *new)
 {
 	new->kind = orig->kind;
 	new->obj_str = orig->obj_str;
@@ -832,7 +832,7 @@ int cil_copy_avrule(struct cil_db *db, void *data, void **copy, __attribute__((u
 	return SEPOL_OK;
 }
 
-int cil_copy_permissionx(struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+static int cil_copy_permissionx(struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_permissionx *orig = data;
 	struct cil_permissionx *new = NULL;
@@ -908,7 +908,7 @@ int cil_copy_cat(__attribute__((unused)) struct cil_db *db, void *data, void **c
 	return SEPOL_OK;
 }
 
-void cil_copy_cats(struct cil_db *db, struct cil_cats *orig, struct cil_cats **new)
+static void cil_copy_cats(struct cil_db *db, struct cil_cats *orig, struct cil_cats **new)
 {
 	cil_cats_init(new);
 	cil_copy_expr(db, orig->str_expr, &(*new)->str_expr);
@@ -1219,7 +1219,7 @@ int cil_copy_ibpkeycon(struct cil_db *db, void *data, void **copy, __attribute__
 	return SEPOL_OK;
 }
 
-int cil_copy_ibendportcon(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_ibendportcon(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_ibendportcon *orig = data;
 	struct cil_ibendportcon *new = NULL;
@@ -1350,7 +1350,7 @@ int cil_copy_pcidevicecon(struct cil_db *db, void *data, void **copy, __attribut
 	return SEPOL_OK;
 }
 
-int cil_copy_devicetreecon(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_devicetreecon(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_devicetreecon *orig = data;
 	struct cil_devicetreecon *new = NULL;
@@ -1497,7 +1497,7 @@ exit:
 	return rc;
 }
 
-int cil_copy_macro(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+static int cil_copy_macro(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_macro *orig = data;
 	char *key = orig->datum.name;
@@ -1562,7 +1562,7 @@ int cil_copy_ipaddr(__attribute__((unused)) struct cil_db *db, void *data, void
 	return SEPOL_OK;
 }
 
-int cil_copy_condblock(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_condblock(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_condblock *orig = data;
 	struct cil_condblock *new = *copy;
@@ -1589,7 +1589,7 @@ int cil_copy_boolif(struct cil_db *db, void *data, void **copy, __attribute__((u
 	return SEPOL_OK;
 }
 
-int cil_copy_tunif(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_tunif(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_tunableif *orig = data;
 	struct cil_tunableif *new = NULL;
@@ -1604,7 +1604,7 @@ int cil_copy_tunif(struct cil_db *db, void *data, void **copy, __attribute__((un
 	return SEPOL_OK;
 }
 
-int cil_copy_default(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_default(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_default *orig = data;
 	struct cil_default *new = NULL;
@@ -1624,7 +1624,7 @@ int cil_copy_default(__attribute__((unused)) struct cil_db *db, void *data, void
 	return SEPOL_OK;
 }
 
-int cil_copy_defaultrange(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_defaultrange(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_defaultrange *orig = data;
 	struct cil_defaultrange *new = NULL;
@@ -1642,7 +1642,7 @@ int cil_copy_defaultrange(__attribute__((unused)) struct cil_db *db, void *data,
 	return SEPOL_OK;
 }
 
-int cil_copy_handleunknown(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_handleunknown(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_handleunknown *orig = data;
 	struct cil_handleunknown *new = NULL;
@@ -1654,7 +1654,7 @@ int cil_copy_handleunknown(__attribute__((unused)) struct cil_db *db, void *data
 	return SEPOL_OK;
 }
 
-int cil_copy_mls(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_mls(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_mls *orig = data;
 	struct cil_mls *new = NULL;
@@ -1666,7 +1666,7 @@ int cil_copy_mls(__attribute__((unused)) struct cil_db *db, void *data, void **c
 	return SEPOL_OK;
 }
 
-int cil_copy_bounds(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_bounds(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_bounds *orig = data;
 	struct cil_bounds *new = NULL;
@@ -1681,7 +1681,7 @@ int cil_copy_bounds(__attribute__((unused)) struct cil_db *db, void *data, void
 	return SEPOL_OK;
 }
 
-int cil_copy_src_info(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+static int cil_copy_src_info(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_src_info *orig = data;
 	struct cil_src_info *new = NULL;
@@ -1697,7 +1697,7 @@ int cil_copy_src_info(__attribute__((unused)) struct cil_db *db, void *data, voi
 	return SEPOL_OK;
 }
 
-int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished, void *extra_args)
+static int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished, void *extra_args)
 {
 	int rc = SEPOL_ERR;
 	struct cil_tree_node *parent = NULL;
@@ -2104,7 +2104,7 @@ exit:
 	return rc;
 }
 
-int __cil_copy_last_child_helper(__attribute__((unused)) struct cil_tree_node *orig, void *extra_args)
+static int __cil_copy_last_child_helper(__attribute__((unused)) struct cil_tree_node *orig, void *extra_args)
 {
 	struct cil_tree_node *node = NULL;
 	struct cil_args_copy *args = NULL;
diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
index 3898725f..8b755277 100644
--- a/libsepol/cil/src/cil_find.c
+++ b/libsepol/cil/src/cil_find.c
@@ -292,7 +292,7 @@ exit:
 	return rc;
 }
 
-int cil_find_matching_avrule(struct cil_tree_node *node, struct cil_avrule *avrule, struct cil_avrule *target, struct cil_list *matching, int match_self)
+static int cil_find_matching_avrule(struct cil_tree_node *node, struct cil_avrule *avrule, struct cil_avrule *target, struct cil_list *matching, int match_self)
 {
 	int rc = SEPOL_OK;
 	struct cil_symtab_datum *s1 = avrule->src;
diff --git a/libsepol/cil/src/cil_list.c b/libsepol/cil/src/cil_list.c
index 8a426f1f..85446b4c 100644
--- a/libsepol/cil/src/cil_list.c
+++ b/libsepol/cil/src/cil_list.c
@@ -35,7 +35,7 @@
 #include "cil_log.h"
 #include "cil_mem.h"
 
-__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void cil_list_error(const char* msg, ...)
+__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) static void cil_list_error(const char* msg, ...)
 {
 	va_list ap;
 	va_start(ap, msg);
diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
index e78c0aeb..e45c58fc 100644
--- a/libsepol/cil/src/cil_log.c
+++ b/libsepol/cil/src/cil_log.c
@@ -37,7 +37,7 @@
 
 static enum cil_log_level cil_log_level = CIL_ERR;
 
-void cil_default_log_handler(__attribute__((unused)) int lvl, const char *msg)
+static void cil_default_log_handler(__attribute__((unused)) int lvl, const char *msg)
 {
 	fprintf(stderr, "%s", msg);
 }
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 09c02af9..7f33cd9e 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -366,7 +366,7 @@ int cil_post_nodecon_compare(const void *a, const void *b)
 	}
 }
 
-int cil_post_pirqcon_compare(const void *a, const void *b)
+static int cil_post_pirqcon_compare(const void *a, const void *b)
 {
 	int rc = SEPOL_ERR;
 	struct cil_pirqcon *apirqcon = *(struct cil_pirqcon**)a;
@@ -383,7 +383,7 @@ int cil_post_pirqcon_compare(const void *a, const void *b)
 	return rc;
 }
 
-int cil_post_iomemcon_compare(const void *a, const void *b)
+static int cil_post_iomemcon_compare(const void *a, const void *b)
 {
 	int rc = SEPOL_ERR;
 	struct cil_iomemcon *aiomemcon = *(struct cil_iomemcon**)a;
@@ -402,7 +402,7 @@ int cil_post_iomemcon_compare(const void *a, const void *b)
 	return rc;
 }
 
-int cil_post_ioportcon_compare(const void *a, const void *b)
+static int cil_post_ioportcon_compare(const void *a, const void *b)
 {
 	int rc = SEPOL_ERR;
 	struct cil_ioportcon *aioportcon = *(struct cil_ioportcon**)a;
@@ -421,7 +421,7 @@ int cil_post_ioportcon_compare(const void *a, const void *b)
 	return rc;
 }
 
-int cil_post_pcidevicecon_compare(const void *a, const void *b)
+static int cil_post_pcidevicecon_compare(const void *a, const void *b)
 {
 	int rc = SEPOL_ERR;
 	struct cil_pcidevicecon *apcidevicecon = *(struct cil_pcidevicecon**)a;
@@ -438,7 +438,7 @@ int cil_post_pcidevicecon_compare(const void *a, const void *b)
 	return rc;
 }
 
-int cil_post_devicetreecon_compare(const void *a, const void *b)
+static int cil_post_devicetreecon_compare(const void *a, const void *b)
 {
 	int rc = SEPOL_ERR;
 	struct cil_devicetreecon *adevicetreecon = *(struct cil_devicetreecon**)a;
@@ -466,35 +466,35 @@ int cil_post_fsuse_compare(const void *a, const void *b)
 	return rc;
 }
 
-int cil_post_filecon_context_compare(const void *a, const void *b)
+static int cil_post_filecon_context_compare(const void *a, const void *b)
 {
 	struct cil_filecon *a_filecon = *(struct cil_filecon**)a;
 	struct cil_filecon *b_filecon = *(struct cil_filecon**)b;
 	return context_compare(a_filecon->context, b_filecon->context);
 }
 
-int cil_post_ibpkeycon_context_compare(const void *a, const void *b)
+static int cil_post_ibpkeycon_context_compare(const void *a, const void *b)
 {
 	struct cil_ibpkeycon *a_ibpkeycon = *(struct cil_ibpkeycon **)a;
 	struct cil_ibpkeycon *b_ibpkeycon = *(struct cil_ibpkeycon **)b;
 	return context_compare(a_ibpkeycon->context, b_ibpkeycon->context);
 }
 
-int cil_post_portcon_context_compare(const void *a, const void *b)
+static int cil_post_portcon_context_compare(const void *a, const void *b)
 {
 	struct cil_portcon *a_portcon = *(struct cil_portcon**)a;
 	struct cil_portcon *b_portcon = *(struct cil_portcon**)b;
 	return context_compare(a_portcon->context, b_portcon->context);
 }
 
-int cil_post_genfscon_context_compare(const void *a, const void *b)
+static int cil_post_genfscon_context_compare(const void *a, const void *b)
 {
 	struct cil_genfscon *a_genfscon = *(struct cil_genfscon**)a;
 	struct cil_genfscon *b_genfscon = *(struct cil_genfscon**)b;
 	return context_compare(a_genfscon->context, b_genfscon->context);
 }
 
-int cil_post_netifcon_context_compare(const void *a, const void *b)
+static int cil_post_netifcon_context_compare(const void *a, const void *b)
 {
 	int rc;
 	struct cil_netifcon *a_netifcon = *(struct cil_netifcon**)a;
@@ -506,56 +506,56 @@ int cil_post_netifcon_context_compare(const void *a, const void *b)
 	return context_compare(a_netifcon->packet_context, b_netifcon->packet_context);
 }
 
-int cil_post_ibendportcon_context_compare(const void *a, const void *b)
+static int cil_post_ibendportcon_context_compare(const void *a, const void *b)
 {
 	struct cil_ibendportcon *a_ibendportcon = *(struct cil_ibendportcon **)a;
 	struct cil_ibendportcon *b_ibendportcon = *(struct cil_ibendportcon **)b;
 	return context_compare(a_ibendportcon->context, b_ibendportcon->context);
 }
 
-int cil_post_nodecon_context_compare(const void *a, const void *b)
+static int cil_post_nodecon_context_compare(const void *a, const void *b)
 {
 	struct cil_nodecon *a_nodecon = *(struct cil_nodecon **)a;
 	struct cil_nodecon *b_nodecon = *(struct cil_nodecon **)b;
 	return context_compare(a_nodecon->context, b_nodecon->context);
 }
 
-int cil_post_pirqcon_context_compare(const void *a, const void *b)
+static int cil_post_pirqcon_context_compare(const void *a, const void *b)
 {
 	struct cil_pirqcon *a_pirqcon = *(struct cil_pirqcon**)a;
 	struct cil_pirqcon *b_pirqcon = *(struct cil_pirqcon**)b;
 	return context_compare(a_pirqcon->context, b_pirqcon->context);
 }
 
-int cil_post_iomemcon_context_compare(const void *a, const void *b)
+static int cil_post_iomemcon_context_compare(const void *a, const void *b)
 {
 	struct cil_iomemcon *a_iomemcon = *(struct cil_iomemcon**)a;
 	struct cil_iomemcon *b_iomemcon = *(struct cil_iomemcon**)b;
 	return context_compare(a_iomemcon->context, b_iomemcon->context);
 }
 
-int cil_post_ioportcon_context_compare(const void *a, const void *b)
+static int cil_post_ioportcon_context_compare(const void *a, const void *b)
 {
 	struct cil_ioportcon *a_ioportcon = *(struct cil_ioportcon**)a;
 	struct cil_ioportcon *b_ioportcon = *(struct cil_ioportcon**)b;
 	return context_compare(a_ioportcon->context, b_ioportcon->context);
 }
 
-int cil_post_pcidevicecon_context_compare(const void *a, const void *b)
+static int cil_post_pcidevicecon_context_compare(const void *a, const void *b)
 {
 	struct cil_pcidevicecon *a_pcidevicecon = *(struct cil_pcidevicecon**)a;
 	struct cil_pcidevicecon *b_pcidevicecon = *(struct cil_pcidevicecon**)b;
 	return context_compare(a_pcidevicecon->context, b_pcidevicecon->context);
 }
 
-int cil_post_devicetreecon_context_compare(const void *a, const void *b)
+static int cil_post_devicetreecon_context_compare(const void *a, const void *b)
 {
 	struct cil_devicetreecon *a_devicetreecon = *(struct cil_devicetreecon**)a;
 	struct cil_devicetreecon *b_devicetreecon = *(struct cil_devicetreecon**)b;
 	return context_compare(a_devicetreecon->context, b_devicetreecon->context);
 }
 
-int cil_post_fsuse_context_compare(const void *a, const void *b)
+static int cil_post_fsuse_context_compare(const void *a, const void *b)
 {
 	struct cil_fsuse *a_fsuse = *(struct cil_fsuse**)a;
 	struct cil_fsuse *b_fsuse = *(struct cil_fsuse**)b;
diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 0ba075c8..0864d7ef 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -475,7 +475,7 @@ static void cil_reset_booleanif(struct cil_booleanif *bif)
 	cil_list_destroy(&bif->datum_expr, CIL_FALSE);
 }
 
-int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32_t *finished, __attribute__((unused)) void *extra_args)
+static int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32_t *finished, __attribute__((unused)) void *extra_args)
 {
 	switch (node->flavor) {
 	case CIL_CLASS:
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 69a8a2ed..7823eb94 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -191,7 +191,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_classperms_set(struct cil_tree_node *current, struct cil_classperms_set *cp_set, void *extra_args)
+static int cil_resolve_classperms_set(struct cil_tree_node *current, struct cil_classperms_set *cp_set, void *extra_args)
 {
 	int rc = SEPOL_ERR;
 	struct cil_symtab_datum *datum = NULL;
@@ -275,7 +275,7 @@ exit:
 	return rc;
 }
 
-void cil_type_used(struct cil_symtab_datum *datum, int used)
+static void cil_type_used(struct cil_symtab_datum *datum, int used)
 {
 	struct cil_typeattribute *attr = NULL;
 
@@ -292,7 +292,7 @@ void cil_type_used(struct cil_symtab_datum *datum, int used)
 	}
 }
 
-int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
+static int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
 {
 	struct cil_symtab_datum *obj_datum = NULL;
 	int rc = SEPOL_ERR;
@@ -459,7 +459,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_expandtypeattribute(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_expandtypeattribute(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_expandtypeattribute *expandattr = current->data;
 	struct cil_symtab_datum *attr_datum = NULL;
@@ -493,7 +493,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor, enum cil_flavor alias_flavor)
+static int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor, enum cil_flavor alias_flavor)
 {
 	int rc = SEPOL_ERR;
 	enum cil_sym_index sym_index;
@@ -544,7 +544,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_alias_to_actual(struct cil_tree_node *current, enum cil_flavor flavor)
+static int cil_resolve_alias_to_actual(struct cil_tree_node *current, enum cil_flavor flavor)
 {
 	struct cil_alias *alias = current->data;
 	struct cil_alias *a1 = current->data;
@@ -733,7 +733,7 @@ exit:
 	return rc;
 }
 
-int __class_update_perm_values(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+static int __class_update_perm_values(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
 {
 	struct cil_perm *perm = (struct cil_perm *)d;
 
@@ -1178,7 +1178,7 @@ struct cil_ordered_list {
 	struct cil_tree_node *node;
 };
 
-void __cil_ordered_list_init(struct cil_ordered_list **ordered)
+static void __cil_ordered_list_init(struct cil_ordered_list **ordered)
 {
 	*ordered = cil_malloc(sizeof(**ordered));
 
@@ -1187,7 +1187,7 @@ void __cil_ordered_list_init(struct cil_ordered_list **ordered)
 	(*ordered)->node = NULL;
 }
 
-void __cil_ordered_list_destroy(struct cil_ordered_list **ordered)
+static void __cil_ordered_list_destroy(struct cil_ordered_list **ordered)
 {
 	cil_list_destroy(&(*ordered)->list, CIL_FALSE);
 	(*ordered)->node = NULL;
@@ -1195,7 +1195,7 @@ void __cil_ordered_list_destroy(struct cil_ordered_list **ordered)
 	*ordered = NULL;
 }
 
-void __cil_ordered_lists_destroy(struct cil_list **ordered_lists)
+static void __cil_ordered_lists_destroy(struct cil_list **ordered_lists)
 {
 	struct cil_list_item *item = NULL;
 
@@ -1215,13 +1215,13 @@ void __cil_ordered_lists_destroy(struct cil_list **ordered_lists)
 	*ordered_lists = NULL;
 }
 
-void __cil_ordered_lists_reset(struct cil_list **ordered_lists)
+static void __cil_ordered_lists_reset(struct cil_list **ordered_lists)
 {
 	__cil_ordered_lists_destroy(ordered_lists);
 	cil_list_init(ordered_lists, CIL_LIST_ITEM);
 }
 
-struct cil_list_item *__cil_ordered_item_insert(struct cil_list *old, struct cil_list_item *curr, struct cil_list_item *item)
+static struct cil_list_item *__cil_ordered_item_insert(struct cil_list *old, struct cil_list_item *curr, struct cil_list_item *item)
 {
 	if (item->flavor == CIL_SID) {
 		struct cil_sid *sid = item->data;
@@ -1256,7 +1256,7 @@ struct cil_list_item *__cil_ordered_item_insert(struct cil_list *old, struct cil
 	return cil_list_insert(old, curr, item->flavor, item->data);
 }
 
-int __cil_ordered_list_insert(struct cil_list *old, struct cil_list_item *ocurr, struct cil_list_item *nstart, struct cil_list_item *nstop)
+static int __cil_ordered_list_insert(struct cil_list *old, struct cil_list_item *ocurr, struct cil_list_item *nstart, struct cil_list_item *nstop)
 {
 	struct cil_list_item *ncurr = NULL;
 
@@ -1269,7 +1269,7 @@ int __cil_ordered_list_insert(struct cil_list *old, struct cil_list_item *ocurr,
 	return SEPOL_OK;
 }
 
-struct cil_list_item *__cil_ordered_find_match(struct cil_list_item *t, struct cil_list_item *i)
+static struct cil_list_item *__cil_ordered_find_match(struct cil_list_item *t, struct cil_list_item *i)
 {
 	while (i) {
 		if (i->data == t->data) {
@@ -1280,7 +1280,7 @@ struct cil_list_item *__cil_ordered_find_match(struct cil_list_item *t, struct c
 	return NULL;
 }
 
-int __cil_ordered_lists_merge(struct cil_list *old, struct cil_list *new)
+static int __cil_ordered_lists_merge(struct cil_list *old, struct cil_list *new)
 {
 	struct cil_list_item *omatch = NULL;
 	struct cil_list_item *ofirst = old->head;
@@ -1409,7 +1409,7 @@ exit:
 	return rc;
 }
 
-struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered_lists, struct cil_list **unordered_lists)
+static struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered_lists, struct cil_list **unordered_lists)
 {
 	struct cil_list *composite = NULL;
 	struct cil_list_item *curr = NULL;
@@ -1556,7 +1556,7 @@ exit:
 	return rc;
 }
 
-void cil_set_cat_values(struct cil_list *ordered_cats, struct cil_db *db)
+static void cil_set_cat_values(struct cil_list *ordered_cats, struct cil_db *db)
 {
 	struct cil_list_item *curr;
 	int v = 0;
@@ -1652,7 +1652,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_cats(struct cil_tree_node *current, struct cil_cats *cats, void *extra_args)
+static int cil_resolve_cats(struct cil_tree_node *current, struct cil_cats *cats, void *extra_args)
 {
 	int rc = SEPOL_ERR;
 
@@ -2224,7 +2224,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_devicetreecon(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_devicetreecon(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_devicetreecon *devicetreecon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
@@ -2316,7 +2316,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_blockinherit_link(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_blockinherit_link(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_blockinherit *inherit = current->data;
 	struct cil_symtab_datum *block_datum = NULL;
@@ -2349,7 +2349,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_blockinherit_copy(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_blockinherit_copy(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_block *block = current->data;
 	struct cil_args_resolve *args = extra_args;
@@ -2398,7 +2398,7 @@ static void cil_mark_subtree_abstract(struct cil_tree_node *node)
 	}
 }
 
-int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_blockabstract *abstract = current->data;
 	struct cil_symtab_datum *block_datum = NULL;
@@ -2469,7 +2469,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_in_list(struct cil_list *in_list, void *extra_args)
+static int cil_resolve_in_list(struct cil_list *in_list, void *extra_args)
 {
 	struct cil_list_item *curr = NULL;
 	struct cil_tree_node *node = NULL;
@@ -2523,7 +2523,7 @@ exit:
 }
 
 
-int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor, enum cil_flavor attr_flavor)
+static int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor, enum cil_flavor attr_flavor)
 {
 	int rc = SEPOL_ERR;
 	struct cil_bounds *bounds = current->data;
@@ -2605,7 +2605,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_default(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_default(struct cil_tree_node *current, void *extra_args)
 {
 	int rc = SEPOL_ERR;
 	struct cil_default *def = current->data;
@@ -2628,7 +2628,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_defaultrange(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_defaultrange(struct cil_tree_node *current, void *extra_args)
 {
 	int rc = SEPOL_ERR;
 	struct cil_defaultrange *def = current->data;
@@ -2651,7 +2651,7 @@ exit:
 	return rc;
 }
 
-void cil_print_recursive_call(struct cil_tree_node *call_node, struct cil_tree_node *terminating_node)
+static void cil_print_recursive_call(struct cil_tree_node *call_node, struct cil_tree_node *terminating_node)
 {
 	struct cil_list *trace = NULL;
 	struct cil_list_item * item = NULL;
@@ -2686,7 +2686,7 @@ void cil_print_recursive_call(struct cil_tree_node *call_node, struct cil_tree_n
 	cil_list_destroy(&trace, CIL_FALSE);
 }
 
-int cil_check_recursive_call(struct cil_tree_node *call_node, struct cil_tree_node *macro_node)
+static int cil_check_recursive_call(struct cil_tree_node *call_node, struct cil_tree_node *macro_node)
 {
 	struct cil_tree_node *curr = NULL;
 	struct cil_call * call = NULL;
@@ -3022,7 +3022,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_call(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_call(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_call *call = current->data;
 	struct cil_args_resolve *args = extra_args;
@@ -3072,7 +3072,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_call_args(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_call_args(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_call *call = current->data;
 	int rc = SEPOL_ERR;
@@ -3603,7 +3603,7 @@ static int cil_check_for_bad_inheritance(struct cil_tree_node *node)
 	return rc;
 }
 
-int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
+static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 {
 	int rc = SEPOL_OK;
 	struct cil_args_resolve *args = extra_args;
@@ -3893,7 +3893,7 @@ exit:
 	return rc;
 }
 
-int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
+static int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
 {
 	int rc = SEPOL_OK;
 	struct cil_args_resolve *args = extra_args;
@@ -4000,7 +4000,7 @@ exit:
 	return rc;
 }
 
-int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, void *extra_args)
+static int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, void *extra_args)
 {
 	int rc = SEPOL_ERR;
 	struct cil_args_resolve *args = extra_args;
@@ -4029,7 +4029,7 @@ exit:
 
 }
 
-int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *extra_args)
+static int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *extra_args)
 {
 	int rc = SEPOL_ERR;
 	struct cil_args_resolve *args = extra_args;
diff --git a/libsepol/cil/src/cil_symtab.c b/libsepol/cil/src/cil_symtab.c
index c1951560..7e43a690 100644
--- a/libsepol/cil/src/cil_symtab.c
+++ b/libsepol/cil/src/cil_symtab.c
@@ -42,7 +42,7 @@
 #include "cil_strpool.h"
 #include "cil_log.h"
 
-__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void cil_symtab_error(const char* msg, ...)
+__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) static void cil_symtab_error(const char* msg, ...)
 {
 	va_list ap;
 	va_start(ap, msg);
@@ -149,7 +149,7 @@ void cil_symtab_destroy(symtab_t *symtab)
 	}
 }
 
-void cil_complex_symtab_hash(struct cil_complex_symtab_key *ckey, int mask, intptr_t *hash)
+static void cil_complex_symtab_hash(struct cil_complex_symtab_key *ckey, int mask, intptr_t *hash)
 {
 	intptr_t sum = ckey->key1 + ckey->key2 + ckey->key3 + ckey->key4;
 	*hash = (intptr_t)((sum >> 2) & mask);
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index aafc9dee..525b60d4 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -273,7 +273,7 @@ void cil_tree_node_destroy(struct cil_tree_node **node)
    extra_args:               any additional data to be passed to the helper functions
 */
 
-int cil_tree_walk_core(struct cil_tree_node *node,
+static int cil_tree_walk_core(struct cil_tree_node *node,
 					   int (*process_node)(struct cil_tree_node *node, uint32_t *finished, void *extra_args),
 					   int (*first_child)(struct cil_tree_node *node, void *extra_args), 
 					   int (*last_child)(struct cil_tree_node *node, void *extra_args), 
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index d994d717..aecbdc19 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -591,7 +591,7 @@ int __cil_verify_initsids(struct cil_list *sids)
 	return rc;
 }
 
-int __cil_is_cat_in_cats(struct cil_cat *cat, struct cil_cats *cats)
+static int __cil_is_cat_in_cats(struct cil_cat *cat, struct cil_cats *cats)
 {
 	struct cil_list_item *i;
 
@@ -606,7 +606,7 @@ int __cil_is_cat_in_cats(struct cil_cat *cat, struct cil_cats *cats)
 }
 
 
-int __cil_verify_cat_in_cats(struct cil_cat *cat, struct cil_cats *cats)
+static int __cil_verify_cat_in_cats(struct cil_cat *cat, struct cil_cats *cats)
 {
 	if (__cil_is_cat_in_cats(cat, cats) != CIL_TRUE) {
 		cil_log(CIL_ERR, "Failed to find category %s in category list\n", cat->datum.name);
@@ -616,7 +616,7 @@ int __cil_verify_cat_in_cats(struct cil_cat *cat, struct cil_cats *cats)
 	return SEPOL_OK;
 }
 
-int __cil_verify_cats_associated_with_sens(struct cil_sens *sens, struct cil_cats *cats)
+static int __cil_verify_cats_associated_with_sens(struct cil_sens *sens, struct cil_cats *cats)
 {
 	int rc = SEPOL_OK;
 	struct cil_list_item *i, *j;
@@ -650,7 +650,7 @@ int __cil_verify_cats_associated_with_sens(struct cil_sens *sens, struct cil_cat
 	return rc;
 }
 
-int __cil_verify_levelrange_sensitivity(struct cil_db *db, struct cil_sens *low, struct cil_sens *high)
+static int __cil_verify_levelrange_sensitivity(struct cil_db *db, struct cil_sens *low, struct cil_sens *high)
 {
 	struct cil_list_item *curr;
 	int found = CIL_FALSE;
@@ -679,7 +679,7 @@ exit:
 
 }
 
-int __cil_verify_levelrange_cats(struct cil_cats *low, struct cil_cats *high)
+static int __cil_verify_levelrange_cats(struct cil_cats *low, struct cil_cats *high)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *item;
@@ -707,7 +707,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_levelrange(struct cil_db *db, struct cil_levelrange *lr)
+static int __cil_verify_levelrange(struct cil_db *db, struct cil_levelrange *lr)
 {
 	int rc = SEPOL_ERR;
 
@@ -739,7 +739,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_named_levelrange(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_named_levelrange(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_levelrange *lr = node->data;
@@ -814,7 +814,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_role(struct cil_tree_node *node)
+static int __cil_verify_role(struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_role *role = node->data;
@@ -845,7 +845,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_type(struct cil_tree_node *node)
+static int __cil_verify_type(struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_type *type = node->data;
@@ -876,7 +876,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_context(struct cil_db *db, struct cil_context *ctx)
+static int __cil_verify_context(struct cil_db *db, struct cil_context *ctx)
 {
 	int rc = SEPOL_ERR;
 	struct cil_user *user = ctx->user;
@@ -954,7 +954,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_named_context(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_named_context(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_context *ctx = node->data;
@@ -1017,7 +1017,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_booleanif_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, __attribute__((unused)) void *extra_args)
+static int __cil_verify_booleanif_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, __attribute__((unused)) void *extra_args)
 {
 	int rc = SEPOL_ERR;
 	struct cil_tree_node *rule_node = node;
@@ -1105,7 +1105,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_booleanif(struct cil_tree_node *node, struct cil_complex_symtab *symtab)
+static int __cil_verify_booleanif(struct cil_tree_node *node, struct cil_complex_symtab *symtab)
 {
 	int rc = SEPOL_ERR;
 	struct cil_booleanif *bif = (struct cil_booleanif*)node->data;
@@ -1129,7 +1129,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_netifcon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_netifcon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_netifcon *netif = node->data;
@@ -1159,7 +1159,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_ibendportcon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_ibendportcon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_ibendportcon *ib_end_port = node->data;
@@ -1179,7 +1179,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_genfscon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_genfscon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_genfscon *genfs = node->data;
@@ -1200,7 +1200,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_filecon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_filecon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_filecon *file = node->data;
@@ -1226,7 +1226,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_nodecon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_nodecon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_nodecon *nodecon = node->data;
@@ -1247,7 +1247,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_ibpkeycon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_ibpkeycon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_ibpkeycon *pkey = node->data;
@@ -1267,7 +1267,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_portcon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_portcon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_portcon *port = node->data;
@@ -1288,7 +1288,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_pirqcon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_pirqcon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_pirqcon *pirq = node->data;
@@ -1309,7 +1309,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_iomemcon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_iomemcon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_iomemcon *iomem = node->data;
@@ -1330,7 +1330,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_ioportcon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_ioportcon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_ioportcon *ioport = node->data;
@@ -1351,7 +1351,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_pcidevicecon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_pcidevicecon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_pcidevicecon *pcidev = node->data;
@@ -1372,7 +1372,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_devicetreecon(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_devicetreecon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_devicetreecon *dt = node->data;
@@ -1393,7 +1393,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_fsuse(struct cil_db *db, struct cil_tree_node *node)
+static int __cil_verify_fsuse(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_fsuse *fsuse = node->data;
@@ -1414,7 +1414,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_permissionx(struct cil_permissionx *permx, struct cil_tree_node *node)
+static int __cil_verify_permissionx(struct cil_permissionx *permx, struct cil_tree_node *node)
 {
 	int rc;
 	struct cil_list *classes = NULL;
@@ -1461,13 +1461,13 @@ exit:
 	return rc;
 }
 
-int __cil_verify_avrulex(struct cil_tree_node *node)
+static int __cil_verify_avrulex(struct cil_tree_node *node)
 {
 	struct cil_avrule *avrulex = node->data;
 	return __cil_verify_permissionx(avrulex->perms.x.permx, node);
 }
 
-int __cil_verify_class(struct cil_tree_node *node)
+static int __cil_verify_class(struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_class *class = node->data;
@@ -1503,7 +1503,7 @@ exit:
 	return rc;
 }
 
-int __cil_verify_policycap(struct cil_tree_node *node)
+static int __cil_verify_policycap(struct cil_tree_node *node)
 {
 	int rc;
 	struct cil_policycap *polcap = node->data;
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index bebb2670..b75784ef 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -546,7 +546,7 @@ static const char *macro_param_flavor_to_string(enum cil_flavor flavor)
 	return str;
 }
 
-void cil_write_src_info_node(FILE *out, struct cil_tree_node *node)
+static void cil_write_src_info_node(FILE *out, struct cil_tree_node *node)
 {
 	struct cil_src_info *info = node->data;
 	if (info->kind == CIL_KEY_SRC_CIL || info->kind == CIL_KEY_SRC_HLL_LMS) {
-- 
2.35.1

