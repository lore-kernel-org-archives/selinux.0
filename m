Return-Path: <SRS0=jqI3=4O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D19C4BA21
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8340F20656
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 19:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0qNC/K3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgBZTRE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:17:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40265 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZTRE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Feb 2020 14:17:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so591223qka.7
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2020 11:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sfwHcdKetwk3+yXB6dXsU3hntgoEn4+MsCuEQPR5fAY=;
        b=Y0qNC/K3t7mu/HzER6pOfjyO/sFvxFRTtbfw4GrYElTxU4/nJ5Tm/dlF8dFTeWt9C7
         1uyVv/ZoFnJVVjGH7NTBkkyKCNljkyansLAQ9w4HP5rddRXa7pfxtaiJ3jJz2NaaXuxw
         Hy9/PcQ0BfOXGnJrnK/HcFBzmkw5PSh6TueBlf4I752Pr8/o4y80Z/VdZLAdCKQv0TMB
         2j3gEKLp6WPK5II8F3Vawgg7ThVNtZ6vIkkKwHjL74y7UZsnLFDRbDaeuLk+JHeuBGuy
         sK/78cjPpxWDUYpAFhjHrQg9htOTWftt57nrCjnyWNbf+fwvq2s1uXplZ0bKLScpmZ4Q
         FVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sfwHcdKetwk3+yXB6dXsU3hntgoEn4+MsCuEQPR5fAY=;
        b=WWkkmb5ppUss+aN3LOzh7XODJSkMK5N+r79ucgrcphRngn/2I1RZsl59hFHVsZWEjB
         7cRTHnExdRo8OhdL3CzkJljg5OfyWoM58HPf9MW0nASaYBIiwrVlTs4LmlBdQ7KIdxSQ
         7N/+9QpqHEDcO0pRnwzjJ8jho7KleCysGC9AOQzYrZ63bDUOf5RJogZRJDpqql24qHx4
         P0WdF+eU4BdMRXmGIbVj7Me//OHOS7GPizBwUl3ZsbD4wsCcYMIIg4VbBGM2RL8KHSf8
         HPRg/hdyfjlHoTXODtIgrBjjF+u1jhblfWHuykDZ8P9F03jb7LFbFHoqkjlGMFlipRom
         BkOw==
X-Gm-Message-State: APjAAAWTHPEJailR1uOZNC2rkBt+9m9KFX0C3YQe+4pca5ykhL0u76bw
        DHaHYJmTNghYmJ3qnFbS+Jo4sh/aX1Q=
X-Google-Smtp-Source: APXvYqzFGqtLurPENW97JVkIgBrCv4U1cur2zF9MKSVKLtDT1139Bln6Jsos+bxBEEMf75A91l1+6A==
X-Received: by 2002:a37:2710:: with SMTP id n16mr683604qkn.235.1582744622445;
        Wed, 26 Feb 2020 11:17:02 -0800 (PST)
Received: from r21-ubuntu-01.ltsnet.net ([65.127.220.137])
        by smtp.googlemail.com with ESMTPSA id t37sm1688425qth.0.2020.02.26.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 11:17:01 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov, James Carter <jwcart2@gmail.com>
Subject: [PATCH V2] libsepol: Create the macro ebitmap_is_empty() and use it where needed
Date:   Wed, 26 Feb 2020 14:16:59 -0500
Message-Id: <20200226191659.6552-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create the macro ebitmap_is_empty() to check if an ebitmap is empty.
Use ebitmap_is_empty(), instead of ebitmap_cardinality() or
ebitmap_length(), to check whether or not an ebitmap is empty.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
V2: Removed unnecessary parentheses

 libsepol/include/sepol/policydb/ebitmap.h |  1 +
 libsepol/src/assertion.c                  | 12 ++++++------
 libsepol/src/expand.c                     |  2 +-
 libsepol/src/kernel_to_cil.c              | 10 +++++-----
 libsepol/src/kernel_to_conf.c             |  8 ++++----
 libsepol/src/module_to_cil.c              | 22 +++++++++++-----------
 6 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 53fafdaa..1abfdd71 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -40,6 +40,7 @@ typedef struct ebitmap {
 	unsigned int cardinality;	/* cached value of cardinality */
 } ebitmap_t;
 
+#define ebitmap_is_empty(e) (((e)->highbit) == 0)
 #define ebitmap_length(e) ((e)->highbit)
 #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
 #define ebitmap_startnode(e) ((e)->node)
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 1181edc2..266f67d7 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -234,7 +234,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	if (rc)
 		goto oom;
 
-	if (ebitmap_length(&src_matches) == 0)
+	if (ebitmap_is_empty(&src_matches))
 		goto exit;
 
 	rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
@@ -249,14 +249,14 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 		if (rc)
 			goto oom;
 
-		if (ebitmap_length(&self_matches) > 0) {
+		if (!ebitmap_is_empty(&self_matches)) {
 			rc = ebitmap_union(&tgt_matches, &self_matches);
 			if (rc)
 				goto oom;
 		}
 	}
 
-	if (ebitmap_length(&tgt_matches) == 0)
+	if (ebitmap_is_empty(&tgt_matches))
 		goto exit;
 
 	for (cp = avrule->perms; cp; cp = cp->next) {
@@ -394,7 +394,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	if (rc)
 		goto oom;
 
-	if (ebitmap_length(&src_matches) == 0)
+	if (ebitmap_is_empty(&src_matches))
 		goto exit;
 
 	rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types,
@@ -411,14 +411,14 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		if (rc)
 			goto oom;
 
-		if (ebitmap_length(&self_matches) > 0) {
+		if (!ebitmap_is_empty(&self_matches)) {
 			rc = ebitmap_union(&tgt_matches, &self_matches);
 			if (rc)
 				goto oom;
 		}
 	}
 
-	if (ebitmap_length(&tgt_matches) == 0)
+	if (ebitmap_is_empty(&tgt_matches))
 		goto exit;
 
 	for (cp = avrule->perms; cp; cp = cp->next) {
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 5738b598..529e1d35 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2504,7 +2504,7 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 	unsigned int i;
 	ebitmap_t types, neg_types;
 	ebitmap_node_t *tnode;
-	unsigned char expand = alwaysexpand || ebitmap_length(&set->negset) || set->flags;
+	unsigned char expand = alwaysexpand || !ebitmap_is_empty(&set->negset) || set->flags;
 	type_datum_t *type;
 	int rc =-1;
 
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ca2e4a9b..89933807 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1101,7 +1101,7 @@ static int write_sensitivitycategory_rules_to_cil(FILE *out, struct policydb *pd
 		}
 		if (level->isalias) continue;
 
-		if (ebitmap_cardinality(&level->level->cat) > 0) {
+		if (!ebitmap_is_empty(&level->level->cat)) {
 			cats = cats_ebitmap_to_str(&level->level->cat, pdb->p_cat_val_to_name);
 			sepol_printf(out, "(sensitivitycategory %s %s)\n", name, cats);
 			free(cats);
@@ -1502,7 +1502,7 @@ static int write_type_attribute_sets_to_cil(FILE *out, struct policydb *pdb)
 		if (attr->flavor != TYPE_ATTRIB) continue;
 		name = pdb->p_type_val_to_name[i];
 		typemap = &pdb->attr_type_map[i];
-		if (ebitmap_cardinality(typemap) == 0) continue;
+		if (ebitmap_is_empty(typemap)) continue;
 		types = ebitmap_to_str(typemap, pdb->p_type_val_to_name, 1);
 		if (!types) {
 			rc = -1;
@@ -1879,7 +1879,7 @@ static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 	char *sens_str = pdb->p_sens_val_to_name[level->sens - 1];
 	char *cats_str;
 
-	if (ebitmap_cardinality(cats) > 0) {
+	if (!ebitmap_is_empty(cats)) {
 		cats_str = cats_ebitmap_to_str(cats, pdb->p_cat_val_to_name);
 		level_str = create_str("(%s %s)", 2, sens_str, cats_str);
 		free(cats_str);
@@ -2188,7 +2188,7 @@ static int write_role_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 			goto exit;
 		}
 		types = &role->types.types;
-		if (types && (ebitmap_cardinality(types) > 0)) {
+		if (types && !ebitmap_is_empty(types)) {
 			rc = strs_init(&type_strs, pdb->p_types.nprim);
 			if (rc != 0) {
 				goto exit;
@@ -2373,7 +2373,7 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 		}
 
 		roles = &user->roles.roles;
-		if (roles && (ebitmap_cardinality(roles) > 0)) {
+		if (roles && !ebitmap_is_empty(roles)) {
 			rc = strs_init(&role_strs, pdb->p_roles.nprim);
 			if (rc != 0) {
 				goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index b4966162..b96a9b76 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1090,7 +1090,7 @@ static int write_level_rules_to_conf(FILE *out, struct policydb *pdb)
 		}
 		if (level->isalias) continue;
 
-		if (ebitmap_cardinality(&level->level->cat) > 0) {
+		if (!ebitmap_is_empty(&level->level->cat)) {
 			cats = cats_ebitmap_to_str(&level->level->cat, pdb->p_cat_val_to_name);
 			sepol_printf(out, "level %s:%s;\n", name, cats);
 			free(cats);
@@ -1859,7 +1859,7 @@ static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 	char *sens_str = pdb->p_sens_val_to_name[level->sens - 1];
 	char *cats_str;
 
-	if (ebitmap_cardinality(cats) > 0) {
+	if (!ebitmap_is_empty(cats)) {
 		cats_str = cats_ebitmap_to_str(cats, pdb->p_cat_val_to_name);
 		level_str = create_str("%s:%s", 2, sens_str, cats_str);
 		free(cats_str);
@@ -2145,7 +2145,7 @@ static int write_role_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 			rc = -1;
 			goto exit;
 		}
-		if (ebitmap_cardinality(&role->types.types) == 0) continue;
+		if (ebitmap_is_empty(&role->types.types)) continue;
 		types = ebitmap_to_str(&role->types.types, pdb->p_type_val_to_name, 1);
 		if (!types) {
 			rc = -1;
@@ -2298,7 +2298,7 @@ static int write_user_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 		}
 		sepol_printf(out, "user %s", name);
 
-		if (ebitmap_cardinality(&user->roles.roles) > 0) {
+		if (!ebitmap_is_empty(&user->roles.roles)) {
 			roles = ebitmap_to_str(&user->roles.roles,
 					       pdb->p_role_val_to_name, 1);
 			if (!roles) {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index e20c3d44..6fe7d336 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -829,8 +829,8 @@ static int cil_print_attr_strs(int indent, struct policydb *pdb, int is_type, vo
 		pos = &ts->types;
 		neg = &ts->negset;
 		flags = ts->flags;
-		has_positive = pos && (ebitmap_length(pos) > 0);
-		has_negative = neg && (ebitmap_length(neg) > 0);
+		has_positive = pos && !ebitmap_is_empty(pos);
+		has_negative = neg && !ebitmap_is_empty(neg);
 	} else {
 		kind = "role";
 		val_to_name = pdb->p_role_val_to_name;
@@ -838,7 +838,7 @@ static int cil_print_attr_strs(int indent, struct policydb *pdb, int is_type, vo
 		pos = &rs->roles;
 		neg = NULL;
 		flags = rs->flags;
-		has_positive = pos && (ebitmap_length(pos) > 0);
+		has_positive = pos && !ebitmap_is_empty(pos);
 		has_negative = 0;
 	}
 
@@ -1056,7 +1056,7 @@ static int process_typeset(struct policydb *pdb, struct type_set *ts, struct lis
 	*names = NULL;
 	*num_names = 0;
 
-	if (ebitmap_length(&ts->negset) > 0 || ts->flags != 0) {
+	if (!ebitmap_is_empty(&ts->negset) || ts->flags != 0) {
 		rc = set_to_names(pdb, 1, ts, attr_list, names, num_names);
 		if (rc != 0) {
 			goto exit;
@@ -2069,7 +2069,7 @@ static int class_order_to_cil(int indent, struct policydb *pdb, struct ebitmap o
 	struct ebitmap_node *node;
 	uint32_t i;
 
-	if (ebitmap_cardinality(&order) == 0) {
+	if (ebitmap_is_empty(&order)) {
 		return 0;
 	}
 
@@ -2175,7 +2175,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			cil_println(indent, "(roleattribute %s)", key);
 		}
 
-		if (ebitmap_cardinality(&role->roles) > 0) {
+		if (!ebitmap_is_empty(&role->roles)) {
 			cil_indent(indent);
 			cil_printf("(roleattributeset %s (", key);
 			ebitmap_for_each_positive_bit(&role->roles, node, i) {
@@ -2269,7 +2269,7 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			cil_printf(")\n");
 		}
 
-		if (ebitmap_cardinality(&type->types) > 0) {
+		if (!ebitmap_is_empty(&type->types)) {
 			cil_indent(indent);
 			cil_printf("(typeattributeset %s (", key);
 			ebitmap_to_cil(pdb, &type->types, SYM_TYPES);
@@ -2372,7 +2372,7 @@ static int sens_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 		}
 	}
 
-	if (ebitmap_cardinality(&level->level->cat) > 0) {
+	if (!ebitmap_is_empty(&level->level->cat)) {
 		cil_indent(indent);
 		cil_printf("(sensitivitycategory %s (", key);
 		ebitmap_to_cil(pdb, &level->level->cat, SYM_CATS);
@@ -2387,7 +2387,7 @@ static int sens_order_to_cil(int indent, struct policydb *pdb, struct ebitmap or
 	struct ebitmap_node *node;
 	uint32_t i;
 
-	if (ebitmap_cardinality(&order) == 0) {
+	if (ebitmap_is_empty(&order)) {
 		return 0;
 	}
 
@@ -2427,7 +2427,7 @@ static int cat_order_to_cil(int indent, struct policydb *pdb, struct ebitmap ord
 	struct ebitmap_node *node;
 	uint32_t i;
 
-	if (ebitmap_cardinality(&order) == 0) {
+	if (ebitmap_is_empty(&order)) {
 		rc = 0;
 		goto exit;
 	}
@@ -2478,7 +2478,7 @@ static int level_to_cil(struct policydb *pdb, struct mls_level *level)
 
 	cil_printf("(%s", pdb->p_sens_val_to_name[level->sens - 1]);
 
-	if (ebitmap_cardinality(map) > 0) {
+	if (!ebitmap_is_empty(map)) {
 		cil_printf("(");
 		ebitmap_to_cil(pdb, map, SYM_CATS);
 		cil_printf(")");
-- 
2.17.1

