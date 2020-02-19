Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8DEC34047
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0412206E2
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Wy6RSFsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgBSQfL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:35:11 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:16361 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBSQfL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 11:35:11 -0500
X-EEMSG-check-017: 79298129|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,461,1574121600"; 
   d="scan'208";a="79298129"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Feb 2020 16:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582130109; x=1613666109;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qerTDfPh/ODeBCtYqpbxzs5A8h72TvoQh1WvNZEtsUM=;
  b=Wy6RSFsZ/FzmvNWuobpJoeGr8sZk7VRWogJbxzH0gl8IhOZ6F8GKgmsI
   ftJ3wnysH+cpPauU+wz+NAOPSHPO21fYiiPP7ySZgGSvrJRnT509hZQA4
   g0a/NO9WGvRM9NsU97SqKh46GfHC/j5Uu6qqvnmL926P+PVCLV6buLd/1
   vR5WLFqtmEzSHRQUIOALZNGzqOnT5RBV+T35xCz2vegcsVLfE4E0grimn
   ToUgfIcQP0j3o4N8HTM8qsc2mdK1SypsQeZRPv1nRYxhkVXbdO8BbDV2M
   8bAjZkMvv3CJZZ9Bphd5UEcH3+/XyH0BsBO4oXgnEf0C3mjqit9HYfdFG
   g==;
X-IronPort-AV: E=Sophos;i="5.70,461,1574121600"; 
   d="scan'208";a="33215487"
IronPort-PHdr: =?us-ascii?q?9a23=3ARu77sR+NhT9SnP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B42+gcTK2v8tzYMVDF4r011RmVBNmdu6oP27qempujcFJDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTWwbalxIRmqognctcobipZ+J6gszR?=
 =?us-ascii?q?fEvnRHd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMODAj8GHTl8d+kqRVrhy8rBB72oLZYIWYOP94c6jAf90VWH?=
 =?us-ascii?q?BBU95RWSJfH42yYYgBAe0OMuhXtITxu1gDoAGiCQS2GO/j1jlFjWL2060g1O?=
 =?us-ascii?q?QhFBnL0gg6ENILrnvUt8j+ObkIXuCv0KnH0y/DZO5R1Df/5onHbgouoeuQXb?=
 =?us-ascii?q?5uasfR1UkuGB/FjlWXs4DlOSiV2f4Xv2iU6OpgS/uihmg6oA9yujii3togh4?=
 =?us-ascii?q?bGi44Pyl3I6D91zJg6KNGmUkJ3fNipG4ZKuS6ALYt5WMYiTnltuCY917IJp4?=
 =?us-ascii?q?a2fDMPyJQ73x7fbOGHc5SQ7hLjSumRJTB4iWp5eL2lnRay8FWgyvbmWsm11l?=
 =?us-ascii?q?ZKoC1FksLSuX8RzRDT9siGRed9/kemwzqP0Rzc6vpYLkwukKrbKpohzqYxlp?=
 =?us-ascii?q?oVr0vDAjf7lFj5gaKZbEkp+vWk5/75brjpuJOQLZJ4hhn7Mqs0m8y/Beo4Mh?=
 =?us-ascii?q?IJX2ie4em81rPi8lHjT7VQkv06jLLUsIzaJMsHpq65BBVZ0oA46xmlFTum39?=
 =?us-ascii?q?MYnWcfIFJfZB2Hl5TpO03JIP3gFvewnVCskDZtx/DbMbzsGYvNLnfdn7f7Z7?=
 =?us-ascii?q?p96FBTyBA1zd9B45JYELYBIOj8Why5iNuNFRI9Mgqp0875B9hnkIATQ2SCBu?=
 =?us-ascii?q?meKqyBn0WP47cNKuyBf8c+sSzhJuJts/zxhnYjhQU1Ybii3ZxRbmuxWPthPR?=
 =?us-ascii?q?PKMjLXnt4dHDJS7UIFR+vwhQjHDG9e?=
X-IPAS-Result: =?us-ascii?q?A2DtAwBWY01e/wHyM5BmHQEBAQkBEQUFAYF7gX2BbAEyK?=
 =?us-ascii?q?o0XhlIBAQEBAQEGiyeKJ4cjCQEBAQEBAQEBARscBAEBhmo4EwIQAQEBBQEBA?=
 =?us-ascii?q?QEBBQMBAWyFQ4I7KYMwCwGCF4JnP4JXJa8YM4VKg3OBPoE4h0aFcYEHgRE2g?=
 =?us-ascii?q?xuKOQSBPwGMKokJgSqXdAaCP40ciTgMHJsqAS2sGCKBWCsIAhgpgWiBTlAYD?=
 =?us-ascii?q?Y4pF44iHyMDMI8TAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Feb 2020 16:35:00 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01JGXwTt231606
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 11:33:58 -0500
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: Create the macro ebitmap_is_empty() and use it where needed
Date:   Wed, 19 Feb 2020 11:36:25 -0500
Message-Id: <20200219163625.19834-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create the macro ebitmap_is_empty() to check if an ebitmap is empty.
Use ebitmap_is_empty(), instead of ebitmap_cardinality() or
ebitmap_length(), to check whether or not an ebitmap is empty.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
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
index ca2e4a9b..f1618ff0 100644
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
+		if (types && (!ebitmap_is_empty(types))) {
 			rc = strs_init(&type_strs, pdb->p_types.nprim);
 			if (rc != 0) {
 				goto exit;
@@ -2373,7 +2373,7 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 		}
 
 		roles = &user->roles.roles;
-		if (roles && (ebitmap_cardinality(roles) > 0)) {
+		if (roles && (!ebitmap_is_empty(roles))) {
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
2.21.1

