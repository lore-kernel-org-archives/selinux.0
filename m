Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D3CCCA487
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGUPY4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGUPYz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:24:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772937969B
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:24:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id j22so3787969ejs.2
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nphZ6wEXpB2aLpU8LjkNiRokmPuLForKnLbl4KDBZiY=;
        b=OLKWAxt+yovborlzuDvN3r5wpZmhl7KW1jeLYHy+d5ZzgGknNhWpcqlCyJxsN3NZtg
         JIjQ1AmyGDtxAvtRx8pdvRzjY4cO5/491oXtcAtsTyK2qyCR7YbEcWztxVhkBJbl6itt
         bFhK1YK50nZ8fQI1P+SX7ZOjZs6NPnVGCGye1XAqa90D98Y8mXsEKU4jENsq24EIMafs
         mfPlc3kx5i469m9bODe5mAEYhwhtmutl8Hxur0/s/zDUwMj/qjieOxNhZ8wG7sY2TT+u
         4XqMSx/VJqCpd1m/+XQMATVkLrYEStiWdpsPbC70zR7eW290H9FIVO5xpcxWMoDTCB1w
         vAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nphZ6wEXpB2aLpU8LjkNiRokmPuLForKnLbl4KDBZiY=;
        b=a8gIp2LzSIzwff2aIAkEDp1lOsI4Ev4IXk/NMufaRT8BbtBXA662cgK/WX+W0BYc48
         QHhsxUe1vw+e4aNa93z2qceWbcc1A6aPhmwloku0bLZoacEU2af8lU5OPSv49UlEx1cW
         yvPDA5I3Arlhgr7abY9TmbssglkWyLJcTCBGr/WGJNERXnlyUbCaLrZ+HN1x18qHd304
         QbtjLEhoBgUuNcFTMhljANTBdEwcT2vnst12vmmh7BRNUNvaX3kQn/CWziBk8+eFgYgE
         MM1pJzIHLYGUqjJw3tchamSVHxiDtAJ2yi+rx9lKccNdf5W8c80wvswGoHf/aW+xVmsn
         GStQ==
X-Gm-Message-State: AJIora/Gtoi1aX1fwhfTejG9oxswenDVAljOdKgmsk+m0OGpE1esRdiy
        zDhddG0tqO1szdo8JYdhDWJqX2rHKqvc8g==
X-Google-Smtp-Source: AGRyM1t/t/ELcJiXxD54yys5s3TTzsxb3J7oUe931+BbpM8SdBhna8Mdb9IoSsbQd528ldh2LL7d6A==
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id mp9-20020a1709071b0900b006d8faa84a06mr40960510ejc.701.1658417090661;
        Thu, 21 Jul 2022 08:24:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402079200b0043a253973aasm1163486edy.10.2022.07.21.08.24.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:24:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/5] libsepol: operate on const pointers during validation
Date:   Thu, 21 Jul 2022 17:24:42 +0200
Message-Id: <20220721152444.31690-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721152444.31690-1-cgzones@googlemail.com>
References: <20220721152444.31690-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The actual policy should not be modified during validation, thus use
const pointers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   fixed typo in commit message
---
 libsepol/src/policydb_validate.c | 114 +++++++++++++++----------------
 libsepol/src/policydb_validate.h |   2 +-
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index e1dad236..a567c411 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -8,7 +8,7 @@
 #include "policydb_validate.h"
 
 #define bool_xor(a, b) (!(a) != !(b))
-#define bool_xnor(a, b) !bool_xor(a, b)
+#define bool_xnor(a, b) (!bool_xor(a, b))
 
 typedef struct validate {
 	uint32_t nprim;
@@ -18,7 +18,7 @@ typedef struct validate {
 typedef struct map_arg {
 	validate_t *flavors;
 	sepol_handle_t *handle;
-	policydb_t *policy;
+	const policydb_t *policy;
 } map_arg_t;
 
 static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitmap_t *gaps)
@@ -46,7 +46,7 @@ static int validate_init(validate_t *flavor, char **val_to_name, uint32_t nprim)
 	return 0;
 }
 
-static int validate_array_init(policydb_t *p, validate_t flavors[])
+static int validate_array_init(const policydb_t *p, validate_t flavors[])
 {
 	if (validate_init(&flavors[SYM_CLASSES], p->p_class_val_to_name, p->p_classes.nprim))
 		goto bad;
@@ -91,7 +91,7 @@ int value_isvalid(uint32_t value, uint32_t nprim)
 	return 1;
 }
 
-static int validate_value(uint32_t value, validate_t *flavor)
+static int validate_value(uint32_t value, const validate_t *flavor)
 {
 	if (!value || value > flavor->nprim)
 		goto bad;
@@ -104,7 +104,7 @@ bad:
 	return -1;
 }
 
-static int validate_ebitmap(ebitmap_t *map, validate_t *flavor)
+static int validate_ebitmap(const ebitmap_t *map, const validate_t *flavor)
 {
 	if (ebitmap_length(map) > 0 && ebitmap_highest_set_bit(map) >= flavor->nprim)
 		goto bad;
@@ -117,7 +117,7 @@ bad:
 	return -1;
 }
 
-static int validate_type_set(type_set_t *type_set, validate_t *type)
+static int validate_type_set(const type_set_t *type_set, const validate_t *type)
 {
 	if (validate_ebitmap(&type_set->types, type))
 		goto bad;
@@ -139,7 +139,7 @@ bad:
 	return -1;
 }
 
-static int validate_empty_type_set(type_set_t *type_set)
+static int validate_empty_type_set(const type_set_t *type_set)
 {
 	if (!ebitmap_is_empty(&type_set->types))
 		goto bad;
@@ -154,7 +154,7 @@ bad:
 	return -1;
 }
 
-static int validate_role_set(role_set_t *role_set, validate_t *role)
+static int validate_role_set(const role_set_t *role_set, const validate_t *role)
 {
 	if (validate_ebitmap(&role_set->roles, role))
 		goto bad;
@@ -176,8 +176,8 @@ bad:
 
 static int validate_scope(__attribute__ ((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
 {
-	scope_datum_t *scope_datum = (scope_datum_t *)d;
-	uint32_t *nprim = (uint32_t *)args;
+	const scope_datum_t *scope_datum = (scope_datum_t *)d;
+	const uint32_t *nprim = (uint32_t *)args;
 	unsigned int i;
 
 	switch (scope_datum->scope) {
@@ -199,9 +199,9 @@ bad:
 	return -1;
 }
 
-static int validate_scopes(sepol_handle_t *handle, symtab_t scopes[], avrule_block_t *block)
+static int validate_scopes(sepol_handle_t *handle, const symtab_t scopes[], const avrule_block_t *block)
 {
-	avrule_decl_t *decl;
+	const avrule_decl_t *decl;
 	unsigned int i;
 	unsigned int num_decls = 0;
 
@@ -223,9 +223,9 @@ bad:
 	return -1;
 }
 
-static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, constraint_node_t *cons, validate_t flavors[])
+static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, const constraint_node_t *cons, validate_t flavors[])
 {
-	constraint_expr_t *cexp;
+	const constraint_expr_t *cexp;
 
 	for (; cons; cons = cons->next) {
 		if (nperms == 0 && cons->permissions != 0)
@@ -339,7 +339,7 @@ bad:
 	return -1;
 }
 
-static int validate_class_datum(sepol_handle_t *handle, class_datum_t *class, validate_t flavors[])
+static int validate_class_datum(sepol_handle_t *handle, const class_datum_t *class, validate_t flavors[])
 {
 	if (validate_value(class->s.value, &flavors[SYM_CLASSES]))
 		goto bad;
@@ -405,7 +405,7 @@ static int validate_class_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_class_datum(margs->handle, d, margs->flavors);
 }
 
-static int validate_common_datum(sepol_handle_t *handle, common_datum_t *common)
+static int validate_common_datum(sepol_handle_t *handle, const common_datum_t *common)
 {
 	if (common->permissions.nprim > PERM_SYMTAB_SIZE)
 		goto bad;
@@ -424,7 +424,7 @@ static int validate_common_datum_wrapper(__attribute__((unused)) hashtab_key_t k
 	return validate_common_datum(margs->handle, d);
 }
 
-static int validate_role_datum(sepol_handle_t *handle, role_datum_t *role, validate_t flavors[])
+static int validate_role_datum(sepol_handle_t *handle, const role_datum_t *role, validate_t flavors[])
 {
 	if (validate_value(role->s.value, &flavors[SYM_ROLES]))
 		goto bad;
@@ -451,7 +451,7 @@ static int validate_role_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_role_datum(margs->handle, d, margs->flavors);
 }
 
-static int validate_type_datum(sepol_handle_t *handle, type_datum_t *type, validate_t flavors[])
+static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type, validate_t flavors[])
 {
 	if (validate_value(type->s.value, &flavors[SYM_TYPES]))
 		goto bad;
@@ -494,7 +494,7 @@ static int validate_type_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_type_datum(margs->handle, d, margs->flavors);
 }
 
-static int validate_mls_semantic_cat(mls_semantic_cat_t *cat, validate_t *cats)
+static int validate_mls_semantic_cat(const mls_semantic_cat_t *cat, const validate_t *cats)
 {
 	for (; cat; cat = cat->next) {
 		if (validate_value(cat->low, cats))
@@ -509,7 +509,7 @@ bad:
 	return -1;
 }
 
-static int validate_mls_semantic_level(mls_semantic_level_t *level, validate_t *sens, validate_t *cats)
+static int validate_mls_semantic_level(const mls_semantic_level_t *level, const validate_t *sens, const validate_t *cats)
 {
 	if (level->sens == 0)
 		return 0;
@@ -524,7 +524,7 @@ bad:
 	return -1;
 }
 
-static int validate_mls_semantic_range(mls_semantic_range_t *range, validate_t *sens, validate_t *cats)
+static int validate_mls_semantic_range(const mls_semantic_range_t *range, const validate_t *sens, const validate_t *cats)
 {
 	if (validate_mls_semantic_level(&range->level[0], sens, cats))
 		goto bad;
@@ -537,7 +537,7 @@ bad:
 	return -1;
 }
 
-static int validate_mls_level(mls_level_t *level, validate_t *sens, validate_t *cats)
+static int validate_mls_level(const mls_level_t *level, const validate_t *sens, const validate_t *cats)
 {
 	if (validate_value(level->sens, sens))
 		goto bad;
@@ -558,7 +558,7 @@ static int validate_level_datum(__attribute__ ((unused)) hashtab_key_t k, hashta
 	return validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]);
 }
 
-static int validate_mls_range(mls_range_t *range, validate_t *sens, validate_t *cats)
+static int validate_mls_range(const mls_range_t *range, const validate_t *sens, const validate_t *cats)
 {
 	if (validate_mls_level(&range->level[0], sens, cats))
 		goto bad;
@@ -571,7 +571,7 @@ static int validate_mls_range(mls_range_t *range, validate_t *sens, validate_t *
 	return -1;
 }
 
-static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[], policydb_t *p)
+static int validate_user_datum(sepol_handle_t *handle, const user_datum_t *user, validate_t flavors[], const policydb_t *p)
 {
 	if (validate_value(user->s.value, &flavors[SYM_USERS]))
 		goto bad;
@@ -602,7 +602,7 @@ static int validate_user_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_user_datum(margs->handle, d, margs->flavors, margs->policy);
 }
 
-static int validate_bool_datum(sepol_handle_t *handle, cond_bool_datum_t *boolean, validate_t flavors[])
+static int validate_bool_datum(sepol_handle_t *handle, const cond_bool_datum_t *boolean, validate_t flavors[])
 {
 	if (validate_value(boolean->s.value, &flavors[SYM_BOOLS]))
 		goto bad;
@@ -637,7 +637,7 @@ static int validate_bool_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_bool_datum(margs->handle, d, margs->flavors);
 }
 
-static int validate_datum_array_gaps(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+static int validate_datum_array_gaps(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
 {
 	unsigned int i;
 
@@ -687,7 +687,7 @@ static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum
 	return !value_isvalid(s->value, *nprim);
 }
 
-static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+static int validate_datum_array_entries(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
 {
 	map_arg_t margs = { flavors, handle, p };
 
@@ -726,7 +726,7 @@ bad:
  * Functions to validate a kernel policydb
  */
 
-static int validate_avtab_key(avtab_key_t *key, int conditional, validate_t flavors[])
+static int validate_avtab_key(const avtab_key_t *key, int conditional, validate_t flavors[])
 {
 	if (validate_value(key->source_type, &flavors[SYM_TYPES]))
 		goto bad;
@@ -771,7 +771,7 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *
 	return 0;
 }
 
-static int validate_avtab(sepol_handle_t *handle, avtab_t *avtab, validate_t flavors[])
+static int validate_avtab(sepol_handle_t *handle, const avtab_t *avtab, validate_t flavors[])
 {
 	if (avtab_map(avtab, validate_avtab_key_and_datum, flavors)) {
 		ERR(handle, "Invalid avtab");
@@ -781,9 +781,9 @@ static int validate_avtab(sepol_handle_t *handle, avtab_t *avtab, validate_t fla
 	return 0;
 }
 
-static int validate_cond_av_list(sepol_handle_t *handle, cond_av_list_t *cond_av, validate_t flavors[])
+static int validate_cond_av_list(sepol_handle_t *handle, const cond_av_list_t *cond_av, validate_t flavors[])
 {
-	avtab_ptr_t avtab_ptr;
+	const struct avtab_node *avtab_ptr;
 
 	for (; cond_av; cond_av = cond_av->next) {
 		for (avtab_ptr = cond_av->node; avtab_ptr; avtab_ptr = avtab_ptr->next) {
@@ -797,9 +797,9 @@ static int validate_cond_av_list(sepol_handle_t *handle, cond_av_list_t *cond_av
 	return 0;
 }
 
-static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, int conditional, validate_t flavors[])
+static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule, int conditional, validate_t flavors[])
 {
-	class_perm_node_t *class;
+	const class_perm_node_t *class;
 
 	for (; avrule; avrule = avrule->next) {
 		if (validate_type_set(&avrule->stypes, &flavors[SYM_TYPES]))
@@ -862,7 +862,7 @@ bad:
 	return -1;
 }
 
-static int validate_bool_id_array(sepol_handle_t *handle, uint32_t bool_ids[], unsigned int nbools, validate_t *bool)
+static int validate_bool_id_array(sepol_handle_t *handle, const uint32_t bool_ids[], unsigned int nbools, const validate_t *bool)
 {
 	unsigned int i;
 
@@ -881,7 +881,7 @@ bad:
 	return -1;
 }
 
-static int validate_cond_expr(sepol_handle_t *handle, struct cond_expr *expr, validate_t *bool)
+static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *expr, const validate_t *bool)
 {
 	int depth = -1;
 
@@ -922,7 +922,7 @@ bad:
 	return -1;
 }
 
-static int validate_cond_list(sepol_handle_t *handle, cond_list_t *cond, validate_t flavors[])
+static int validate_cond_list(sepol_handle_t *handle, const cond_list_t *cond, validate_t flavors[])
 {
 	for (; cond; cond = cond->next) {
 		if (validate_cond_expr(handle, cond->expr, &flavors[SYM_BOOLS]))
@@ -946,7 +946,7 @@ bad:
 	return -1;
 }
 
-static int validate_role_transes(sepol_handle_t *handle, role_trans_t *role_trans, validate_t flavors[])
+static int validate_role_transes(sepol_handle_t *handle, const role_trans_t *role_trans, validate_t flavors[])
 {
 	for (; role_trans; role_trans = role_trans->next) {
 		if (validate_value(role_trans->role, &flavors[SYM_ROLES]))
@@ -966,7 +966,7 @@ bad:
 	return -1;
 }
 
-static int validate_role_allows(sepol_handle_t *handle, role_allow_t *role_allow, validate_t flavors[])
+static int validate_role_allows(sepol_handle_t *handle, const role_allow_t *role_allow, validate_t flavors[])
 {
 	for (; role_allow; role_allow = role_allow->next) {
 		if (validate_value(role_allow->role, &flavors[SYM_ROLES]))
@@ -984,8 +984,8 @@ bad:
 
 static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d, void *args)
 {
-	filename_trans_key_t *ftk = (filename_trans_key_t *)k;
-	filename_trans_datum_t *ftd = d;
+	const filename_trans_key_t *ftk = (filename_trans_key_t *)k;
+	const filename_trans_datum_t *ftd = d;
 	validate_t *flavors = (validate_t *)args;
 
 	if (validate_value(ftk->ttype, &flavors[SYM_TYPES]))
@@ -1015,7 +1015,7 @@ static int validate_filename_trans_hashtab(sepol_handle_t *handle, hashtab_t fil
 	return 0;
 }
 
-static int validate_context(context_struct_t *con, validate_t flavors[], int mls)
+static int validate_context(const context_struct_t *con, validate_t flavors[], int mls)
 {
 	if (validate_value(con->user, &flavors[SYM_USERS]))
 		return -1;
@@ -1029,9 +1029,9 @@ static int validate_context(context_struct_t *con, validate_t flavors[], int mls
 	return 0;
 }
 
-static int validate_ocontexts(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
 {
-	ocontext_t *octx;
+	const ocontext_t *octx;
 	unsigned int i;
 
 	for (i = 0; i < OCON_NUM; i++) {
@@ -1067,10 +1067,10 @@ bad:
 	return -1;
 }
 
-static int validate_genfs(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+static int validate_genfs(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
 {
-	genfs_t *genfs;
-	ocontext_t *octx;
+	const genfs_t *genfs;
+	const ocontext_t *octx;
 
 	for (genfs = p->genfs; genfs; genfs = genfs->next) {
 		for (octx = genfs->head; octx; octx = octx->next) {
@@ -1090,7 +1090,7 @@ bad:
  * Functions to validate a module policydb
  */
 
-static int validate_role_trans_rules(sepol_handle_t *handle, role_trans_rule_t *role_trans, validate_t flavors[])
+static int validate_role_trans_rules(sepol_handle_t *handle, const role_trans_rule_t *role_trans, validate_t flavors[])
 {
 	for (; role_trans; role_trans = role_trans->next) {
 		if (validate_role_set(&role_trans->roles, &flavors[SYM_ROLES]))
@@ -1110,7 +1110,7 @@ bad:
 	return -1;
 }
 
-static int validate_role_allow_rules(sepol_handle_t *handle, role_allow_rule_t *role_allow, validate_t flavors[])
+static int validate_role_allow_rules(sepol_handle_t *handle, const role_allow_rule_t *role_allow, validate_t flavors[])
 {
 	for (; role_allow; role_allow = role_allow->next) {
 		if (validate_role_set(&role_allow->roles, &flavors[SYM_ROLES]))
@@ -1126,7 +1126,7 @@ bad:
 	return -1;
 }
 
-static int validate_range_trans_rules(sepol_handle_t *handle, range_trans_rule_t *range_trans, validate_t flavors[])
+static int validate_range_trans_rules(sepol_handle_t *handle, const range_trans_rule_t *range_trans, validate_t flavors[])
 {
 	for (; range_trans; range_trans = range_trans->next) {
 		if (validate_type_set(&range_trans->stypes, &flavors[SYM_TYPES]))
@@ -1146,7 +1146,7 @@ bad:
 	return -1;
 }
 
-static int validate_scope_index(sepol_handle_t *handle, scope_index_t *scope_index, validate_t flavors[])
+static int validate_scope_index(sepol_handle_t *handle, const scope_index_t *scope_index, validate_t flavors[])
 {
 	if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SYM_CLASSES]))
 		goto bad;
@@ -1173,7 +1173,7 @@ bad:
 }
 
 
-static int validate_filename_trans_rules(sepol_handle_t *handle, filename_trans_rule_t *filename_trans, validate_t flavors[])
+static int validate_filename_trans_rules(sepol_handle_t *handle, const filename_trans_rule_t *filename_trans, validate_t flavors[])
 {
 	for (; filename_trans; filename_trans = filename_trans->next) {
 		if (validate_type_set(&filename_trans->stypes, &flavors[SYM_TYPES]))
@@ -1197,7 +1197,7 @@ bad:
 	return -1;
 }
 
-static int validate_symtabs(sepol_handle_t *handle, symtab_t symtabs[], validate_t flavors[])
+static int validate_symtabs(sepol_handle_t *handle, const symtab_t symtabs[], validate_t flavors[])
 {
 	unsigned int i;
 
@@ -1211,9 +1211,9 @@ static int validate_symtabs(sepol_handle_t *handle, symtab_t symtabs[], validate
 	return 0;
 }
 
-static int validate_avrule_blocks(sepol_handle_t *handle, avrule_block_t *avrule_block, validate_t flavors[])
+static int validate_avrule_blocks(sepol_handle_t *handle, const avrule_block_t *avrule_block, validate_t flavors[])
 {
-	avrule_decl_t *decl;
+	const avrule_decl_t *decl;
 
 	for (; avrule_block; avrule_block = avrule_block->next) {
 		for (decl = avrule_block->branch_list; decl != NULL; decl = decl->next) {
@@ -1253,7 +1253,7 @@ bad:
 	return -1;
 }
 
-static int validate_permissives(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+static int validate_permissives(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
 {
 	ebitmap_node_t *node;
 	unsigned i;
@@ -1270,7 +1270,7 @@ bad:
 	return -1;
 }
 
-static int validate_properties(sepol_handle_t *handle, policydb_t *p)
+static int validate_properties(sepol_handle_t *handle, const policydb_t *p)
 {
 	switch (p->policy_type) {
 	case POLICY_KERN:
@@ -1330,7 +1330,7 @@ static void validate_array_destroy(validate_t flavors[])
 /*
  * Validate policydb
  */
-int policydb_validate(sepol_handle_t *handle, policydb_t *p)
+int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 {
 	validate_t flavors[SYM_NUM] = {};
 
diff --git a/libsepol/src/policydb_validate.h b/libsepol/src/policydb_validate.h
index b7f9f191..86a53168 100644
--- a/libsepol/src/policydb_validate.h
+++ b/libsepol/src/policydb_validate.h
@@ -4,4 +4,4 @@
 #include <sepol/policydb/policydb.h>
 
 int value_isvalid(uint32_t value, uint32_t nprim);
-int policydb_validate(sepol_handle_t *handle, policydb_t *p);
+int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
-- 
2.36.1

