Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AC0C43334
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 13:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiFPNOS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376992AbiFPNOP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jun 2022 09:14:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BBB37AB0
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 06:14:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so2726006ejk.5
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dcZ2AtcqOsdWps0nDzaRZDUGLstrpKouR5oIz5maUQ=;
        b=l6pVBhVrTrlIfunUk0tpMoIofpudLLmp502/K8S6BEMDa84WSv9qgFhWv5Vy1aec5b
         JnvL24HV2w4Yhl5BgRMXOAfEmjbJh6eLqOW/TQGHAP4EL3YRBRNwadXP91u/2sYngKWh
         ElzMZoSP+nrHeOgferYeU/QUfNaqT2xcXHBTOla/mmjgWrRy9HrTNNF+BP2yep/6eRhz
         rtHQyHkrUo7hIB+xRCC1pohnl1ZsAkaGp6RPwxCTODQLznbuEXesCg1wTwvCfI8Na9u/
         qY8vZEjwWQdQg/cbyeFKTXYNvuoQT9xvxdiPgYnr3Z36YSZgu9qlWUGp/aSyPaZO1vz6
         4c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dcZ2AtcqOsdWps0nDzaRZDUGLstrpKouR5oIz5maUQ=;
        b=I83vlMTQjahTSBzw+9qDOu2NP0xoUIJaPCoQ/eDobmcvXirKxQqoGNOoytBnMJI69J
         voo5nLgbBsDLaf32kkEjFp8qvvSis4/JLBSJfNjnvCEbomYt/2Ubsl7Ja0QVkzuN7642
         V51yP555zpOejPDuXgTfzMrb0xGm7REJHulq4mT7U/fx/W+OPRf6rl/vzLmVwuuP2tbN
         ZvrUHS7W1mBcju3UqYeizeqRNu9jPPyKuNYkpEQ/hH76uTwuIIw5G4ELDUlRKa3BuVy3
         Ayu+NKBfkPH9QITletrL+kxUSaTUGBw/72yooZ9dsvPbGSl50ngpguXGjuyOitaHoaxF
         Da/Q==
X-Gm-Message-State: AJIora9W3v15FVCIXiAGO7TW4ir5KzX9aUzPMgSRduRy2xOntPD7LccM
        IDk7KQ5ejMtLkDwmI1MI3pO6RR0t7qYp7Q==
X-Google-Smtp-Source: AGRyM1s7xrHy2EiuDUCk/jo5awawYfwc3x70AH742BVZw2qa2k+RXIf7CppysAztB1Rsa2c1wfC+Fg==
X-Received: by 2002:a17:906:e104:b0:711:d510:54ca with SMTP id gj4-20020a170906e10400b00711d51054camr4363913ejb.342.1655385252852;
        Thu, 16 Jun 2022 06:14:12 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-158-068.77.8.pool.telefonica.de. [77.8.158.68])
        by smtp.gmail.com with ESMTPSA id y11-20020a056402270b00b0042e1cbc4471sm1831530edd.3.2022.06.16.06.14.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:14:11 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/4] libsepol: refactor ebitmap conversion in link.c
Date:   Thu, 16 Jun 2022 15:14:06 +0200
Message-Id: <20220616131409.23271-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Refactor the ebitmap conversions in link.c into its own function.

Do not log an OOM message twice on type_set_or_convert() failure.

Drop the now unused state parameter from type_set_or_convert() and
type_set_convert().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/link.c | 140 +++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 93 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 7e8313cb..cbe4cea4 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -958,26 +958,28 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 
 /*********** callbacks that fix bitmaps ***********/
 
-static int type_set_convert(type_set_t * types, type_set_t * dst,
-			    policy_module_t * mod, link_state_t * state
-			    __attribute__ ((unused)))
+static int ebitmap_convert(const ebitmap_t *src, ebitmap_t *dst, const uint32_t *map)
 {
-	unsigned int i;
-	ebitmap_node_t *tnode;
-	ebitmap_for_each_positive_bit(&types->types, tnode, i) {
-		assert(mod->map[SYM_TYPES][i]);
-		if (ebitmap_set_bit
-		    (&dst->types, mod->map[SYM_TYPES][i] - 1, 1)) {
-			goto cleanup;
-		}
-	}
-	ebitmap_for_each_positive_bit(&types->negset, tnode, i) {
-		assert(mod->map[SYM_TYPES][i]);
-		if (ebitmap_set_bit
-		    (&dst->negset, mod->map[SYM_TYPES][i] - 1, 1)) {
-			goto cleanup;
-		}
+	unsigned int bit;
+	ebitmap_node_t *node;
+	ebitmap_for_each_positive_bit(src, node, bit) {
+		assert(map[bit]);
+		if (ebitmap_set_bit(dst, map[bit] - 1, 1))
+			return -1;
 	}
+
+	return 0;
+}
+
+static int type_set_convert(const type_set_t * types, type_set_t * dst,
+			    const policy_module_t * mod)
+{
+	if (ebitmap_convert(&types->types, &dst->types, mod->map[SYM_TYPES]))
+		goto cleanup;
+
+	if (ebitmap_convert(&types->negset, &dst->negset, mod->map[SYM_TYPES]))
+		goto cleanup;
+
 	dst->flags = types->flags;
 	return 0;
 
@@ -988,13 +990,13 @@ static int type_set_convert(type_set_t * types, type_set_t * dst,
 /* OR 2 typemaps together and at the same time map the src types to
  * the correct values in the dst typeset.
  */
-static int type_set_or_convert(type_set_t * types, type_set_t * dst,
-			       policy_module_t * mod, link_state_t * state)
+static int type_set_or_convert(const type_set_t * types, type_set_t * dst,
+			       const policy_module_t * mod)
 {
 	type_set_t ts_tmp;
 
 	type_set_init(&ts_tmp);
-	if (type_set_convert(types, &ts_tmp, mod, state) == -1) {
+	if (type_set_convert(types, &ts_tmp, mod) == -1) {
 		goto cleanup;
 	}
 	if (type_set_or_eq(dst, &ts_tmp)) {
@@ -1004,7 +1006,6 @@ static int type_set_or_convert(type_set_t * types, type_set_t * dst,
 	return 0;
 
       cleanup:
-	ERR(state->handle, "Out of memory!");
 	type_set_destroy(&ts_tmp);
 	return -1;
 }
@@ -1012,18 +1013,11 @@ static int type_set_or_convert(type_set_t * types, type_set_t * dst,
 static int role_set_or_convert(role_set_t * roles, role_set_t * dst,
 			       policy_module_t * mod, link_state_t * state)
 {
-	unsigned int i;
 	ebitmap_t tmp;
-	ebitmap_node_t *rnode;
 
 	ebitmap_init(&tmp);
-	ebitmap_for_each_positive_bit(&roles->roles, rnode, i) {
-		assert(mod->map[SYM_ROLES][i]);
-		if (ebitmap_set_bit
-		    (&tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
-			goto cleanup;
-		}
-	}
+	if (ebitmap_convert(&roles->roles, &tmp, mod->map[SYM_ROLES]))
+		goto cleanup;
 	if (ebitmap_union(&dst->roles, &tmp)) {
 		goto cleanup;
 	}
@@ -1088,13 +1082,11 @@ static int mls_range_convert(mls_semantic_range_t * src, mls_semantic_range_t *
 static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 			     void *data)
 {
-	unsigned int i;
 	char *id = key;
 	role_datum_t *role, *dest_role = NULL;
 	link_state_t *state = (link_state_t *) data;
 	ebitmap_t e_tmp;
 	policy_module_t *mod = state->cur;
-	ebitmap_node_t *rnode;
 	hashtab_t role_tab;
 
 	role = (role_datum_t *) datum;
@@ -1111,30 +1103,20 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 	}
 
 	ebitmap_init(&e_tmp);
-	ebitmap_for_each_positive_bit(&role->dominates, rnode, i) {
-		assert(mod->map[SYM_ROLES][i]);
-		if (ebitmap_set_bit
-		    (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
-			goto cleanup;
-		}
-	}
+	if (ebitmap_convert(&role->dominates, &e_tmp, mod->map[SYM_ROLES]))
+		goto cleanup;
 	if (ebitmap_union(&dest_role->dominates, &e_tmp)) {
 		goto cleanup;
 	}
-	if (type_set_or_convert(&role->types, &dest_role->types, mod, state)) {
+	if (type_set_or_convert(&role->types, &dest_role->types, mod)) {
 		goto cleanup;
 	}
 	ebitmap_destroy(&e_tmp);
 	
 	if (role->flavor == ROLE_ATTRIB) {
 		ebitmap_init(&e_tmp);
-		ebitmap_for_each_positive_bit(&role->roles, rnode, i) {
-			assert(mod->map[SYM_ROLES][i]);
-			if (ebitmap_set_bit
-			    (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
-				goto cleanup;
-			}
-		}
+		if (ebitmap_convert(&role->roles, &e_tmp, mod->map[SYM_ROLES]))
+			goto cleanup;
 		if (ebitmap_union(&dest_role->roles, &e_tmp)) {
 			goto cleanup;
 		}
@@ -1152,13 +1134,11 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 static int type_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 			     void *data)
 {
-	unsigned int i;
 	char *id = key;
 	type_datum_t *type, *new_type = NULL;
 	link_state_t *state = (link_state_t *) data;
 	ebitmap_t e_tmp;
 	policy_module_t *mod = state->cur;
-	ebitmap_node_t *tnode;
 	symtab_t *typetab;
 
 	type = (type_datum_t *) datum;
@@ -1181,13 +1161,8 @@ static int type_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 	}
 
 	ebitmap_init(&e_tmp);
-	ebitmap_for_each_positive_bit(&type->types, tnode, i) {
-		assert(mod->map[SYM_TYPES][i]);
-		if (ebitmap_set_bit
-		    (&e_tmp, mod->map[SYM_TYPES][i] - 1, 1)) {
-			goto cleanup;
-		}
-	}
+	if (ebitmap_convert(&type->types, &e_tmp, mod->map[SYM_TYPES]))
+		goto cleanup;
 	if (ebitmap_union(&new_type->types, &e_tmp)) {
 		goto cleanup;
 	}
@@ -1269,9 +1244,8 @@ static int copy_avrule_list(avrule_t * list, avrule_t ** dst,
 		new_rule->specified = cur->specified;
 		new_rule->flags = cur->flags;
 		if (type_set_convert
-		    (&cur->stypes, &new_rule->stypes, module, state) == -1
-		    || type_set_convert(&cur->ttypes, &new_rule->ttypes, module,
-					state) == -1) {
+		    (&cur->stypes, &new_rule->stypes, module) == -1
+		    || type_set_convert(&cur->ttypes, &new_rule->ttypes, module) == -1) {
 			goto cleanup;
 		}
 
@@ -1355,8 +1329,6 @@ static int copy_role_trans_list(role_trans_rule_t * list,
 				policy_module_t * module, link_state_t * state)
 {
 	role_trans_rule_t *cur, *new_rule = NULL, *tail;
-	unsigned int i;
-	ebitmap_node_t *cnode;
 
 	cur = list;
 	tail = *dst;
@@ -1374,19 +1346,12 @@ static int copy_role_trans_list(role_trans_rule_t * list,
 		if (role_set_or_convert
 		    (&cur->roles, &new_rule->roles, module, state)
 		    || type_set_or_convert(&cur->types, &new_rule->types,
-					   module, state)) {
+					   module)) {
 			goto cleanup;
 		}
 
-		ebitmap_for_each_positive_bit(&cur->classes, cnode, i) {
-			assert(module->map[SYM_CLASSES][i]);
-			if (ebitmap_set_bit(&new_rule->classes,
-					    module->
-					    map[SYM_CLASSES][i] - 1,
-					    1)) {
-				goto cleanup;
-			}
-		}
+		if (ebitmap_convert(&cur->classes, &new_rule->classes, module->map[SYM_CLASSES]))
+			goto cleanup;
 
 		new_rule->new_role = module->map[SYM_ROLES][cur->new_role - 1];
 
@@ -1476,8 +1441,8 @@ static int copy_filename_trans_list(filename_trans_rule_t * list,
 		if (!new_rule->name)
 			goto err;
 
-		if (type_set_or_convert(&cur->stypes, &new_rule->stypes, module, state) ||
-		    type_set_or_convert(&cur->ttypes, &new_rule->ttypes, module, state))
+		if (type_set_or_convert(&cur->stypes, &new_rule->stypes, module) ||
+		    type_set_or_convert(&cur->ttypes, &new_rule->ttypes, module))
 			goto err;
 
 		new_rule->tclass = module->map[SYM_CLASSES][cur->tclass - 1];
@@ -1497,8 +1462,6 @@ static int copy_range_trans_list(range_trans_rule_t * rules,
 				 policy_module_t * mod, link_state_t * state)
 {
 	range_trans_rule_t *rule, *new_rule = NULL;
-	unsigned int i;
-	ebitmap_node_t *cnode;
 
 	for (rule = rules; rule; rule = rule->next) {
 		new_rule =
@@ -1512,21 +1475,15 @@ static int copy_range_trans_list(range_trans_rule_t * rules,
 		*dst = new_rule;
 
 		if (type_set_convert(&rule->stypes, &new_rule->stypes,
-				     mod, state))
+				     mod))
 			goto cleanup;
 
 		if (type_set_convert(&rule->ttypes, &new_rule->ttypes,
-				     mod, state))
+				     mod))
 			goto cleanup;
 
-		ebitmap_for_each_positive_bit(&rule->tclasses, cnode, i) {
-			assert(mod->map[SYM_CLASSES][i]);
-			if (ebitmap_set_bit
-			    (&new_rule->tclasses,
-			     mod->map[SYM_CLASSES][i] - 1, 1)) {
-				goto cleanup;
-			}
-		}
+		if (ebitmap_convert(&rule->tclasses, &new_rule->tclasses, mod->map[SYM_CLASSES]))
+			goto cleanup;
 
 		if (mls_range_convert(&rule->trange, &new_rule->trange, mod, state))
 			goto cleanup;
@@ -1688,15 +1645,12 @@ static int copy_scope_index(scope_index_t * src, scope_index_t * dest,
 	}
 	dest->class_perms_len = largest_mapped_class_value;
 	for (i = 0; i < src->class_perms_len; i++) {
-		ebitmap_t *srcmap = src->class_perms_map + i;
+		const ebitmap_t *srcmap = src->class_perms_map + i;
 		ebitmap_t *destmap =
 		    dest->class_perms_map + module->map[SYM_CLASSES][i] - 1;
-		ebitmap_for_each_positive_bit(srcmap, node, j) {
-			if (ebitmap_set_bit(destmap, module->perm_map[i][j] - 1,
-					    1)) {
-				goto cleanup;
-			}
-		}
+
+		if (ebitmap_convert(srcmap, destmap, module->perm_map[i]))
+			goto cleanup;
 	}
 
 	return 0;
-- 
2.36.1

