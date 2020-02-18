Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1EBC34047
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 20:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394EF2173E
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 20:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="O7VLfwMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBRUo7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:44:59 -0500
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:4401 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgBRUo6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 15:44:58 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 15:44:57 EST
X-EEMSG-check-017: 78921480|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,457,1574121600"; 
   d="scan'208";a="78921480"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 20:37:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582058265; x=1613594265;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QhbJ6F6uJjsA4zi92JW0cXD12t2Zzibt7dRKvIBlRmg=;
  b=O7VLfwMGj/hNXNUCkmAgzpIl1Wt25Sdza9VABzC+bI7PPuGb/M6wDk+a
   M/xLsnARK12ClURsQYOEUXb//I0Qxa2K4bk/F+J4hWOUz+8vKHxKfXy5e
   /v/C0brINm50B+L78AjPhlPhbEkbL+9kOkyv0oQvioJPsE7XdksqpwWrR
   voCqsf2dB4CjZQ7uMMvwo8sPZJSoJgGVBA6IlLWz/t4RNwaDoaFTHQbEs
   hdZtHYikvg8V6cnWNvVaNwRPrjZgVDoCTbulC2A3NO+7nsiddT/+6+YLD
   Uled7jmETSsRInaeKxcsiT09Dm5vg5R5zRcdEhNKsu7LvGGd/S4zpl5Y3
   A==;
X-IronPort-AV: E=Sophos;i="5.70,457,1574121600"; 
   d="scan'208";a="39253593"
IronPort-PHdr: =?us-ascii?q?9a23=3Awyj91hVT2i3FpL9LfxsAIea3ATbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYxyCt8tkgFKBZ4jH8fUM07OQ7/m8HzNQqs/a4TgrS99laV?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4lvJ6U+xh?=
 =?us-ascii?q?fUrHZFf/ldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U7NVCSktPn?=
 =?us-ascii?q?426sP2qxTNVBOD6XQAXGoYlBpIGBXF4wrhXpjtqCv6t/Fy1zecMMbrUL07Qz?=
 =?us-ascii?q?Wi76NsSB/1lCcKMiMy/W/LhsBsiq9QvRyupwZ7w4XJfo+bMvRwdb7Zcd8DRW?=
 =?us-ascii?q?dMWsNdWipcCY2+coQPFfIMM+ZGoYfgqVUArhywCgajCu701jNFhWX70bEg3u?=
 =?us-ascii?q?g9DQ3L2hErEdIUsHTTqdX4LKMcXvqwzKbW1jXIcu1b1i3n6IjUbB8hu+yHUL?=
 =?us-ascii?q?Vyccvf1UYgDRnFjkmOpYH+IzOU1vgCs2ic7+Z6U+KvkHQopxt+ojio2Mchk4?=
 =?us-ascii?q?/EjZ8WxFDc7Sh13Yk4KNKiREN7fNKoCoVcui6EO4dsX88vRXxjtjwgxb0co5?=
 =?us-ascii?q?G7eTAHyJEgxxHCdfOKa5OI4hf/VOaJJjd4mW5ldKq/hxms9UigzfXxVtWu31?=
 =?us-ascii?q?ZQrypFj8LMumoM1xzV5MiHTeB98Vm91jqVywDS6v1LIUAzlabBLZ4u3qUwmY?=
 =?us-ascii?q?YJvUTGHy/2nF36jK6Qdko65uil8/nrb7rpq5OGN4J4lxvyProhl8ChG+g0Lx?=
 =?us-ascii?q?ACX22B9uS90L3j81f5QLJPjvAukKnYvozVKt4Bpq6lHQNYyZoj6hajADem19?=
 =?us-ascii?q?QUh38HLElfdx6dgIjpPE/OLOjiDfijm1SsjCtrx/feM736HJrNKnnDkLH8fb?=
 =?us-ascii?q?dy8ENc1gUzws5F555OCbEOPujzWknvu9zcFBM5NBa0w+m0QOl6g5gTXWOJH7?=
 =?us-ascii?q?+xLqzfqxmL6/gpLu3KY5Ua6xjnLP1wxffrgGRxslYHYaSzlc8Vd3uxBOg8C1?=
 =?us-ascii?q?mIanrrxNEaGCEFuRRoH7+is0GLTTMGPyX6ZKk7/DxuTd/3AA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BkBQCISkxe/wHyM5BmHQEBAQkBEQUFAYF7AoF7gWwBI?=
 =?us-ascii?q?BIqjReGXwMGiyeRSgkBAQEBAQEBAQEbHAQBAYZpOBMCEAEBAQUBAQEBAQUDA?=
 =?us-ascii?q?QFshUNCARABgWcpgzALAYIXgmc/glclrmgzhUqDVoE+gTgBh0WFcYEHgRE2g?=
 =?us-ascii?q?xuKOQSBPwGVLoEql3IGgj+NGIk1DBybJQEtrA8igVgrCAIYKYFogU5QGA2cY?=
 =?us-ascii?q?h8jAzCHB4liAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Feb 2020 20:37:44 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IKaiEI177990
        for <selinux@vger.kernel.org>; Tue, 18 Feb 2020 15:36:44 -0500
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: Use ebitmap_length() to check for an empty ebitmap
Date:   Tue, 18 Feb 2020 15:39:11 -0500
Message-Id: <20200218203911.30502-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When checking whether or not an ebitmap has any bits set, use
ebitmap_length() instead of ebitmap_cardinality().

There is no need to find out how many bits are set, if all that is
needed is to determine if any bits are set at all.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/kernel_to_cil.c  | 10 +++++-----
 libsepol/src/kernel_to_conf.c |  8 ++++----
 libsepol/src/module_to_cil.c  | 16 ++++++++--------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ca2e4a9b..28577faf 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1101,7 +1101,7 @@ static int write_sensitivitycategory_rules_to_cil(FILE *out, struct policydb *pd
 		}
 		if (level->isalias) continue;
 
-		if (ebitmap_cardinality(&level->level->cat) > 0) {
+		if (ebitmap_length(&level->level->cat) > 0) {
 			cats = cats_ebitmap_to_str(&level->level->cat, pdb->p_cat_val_to_name);
 			sepol_printf(out, "(sensitivitycategory %s %s)\n", name, cats);
 			free(cats);
@@ -1502,7 +1502,7 @@ static int write_type_attribute_sets_to_cil(FILE *out, struct policydb *pdb)
 		if (attr->flavor != TYPE_ATTRIB) continue;
 		name = pdb->p_type_val_to_name[i];
 		typemap = &pdb->attr_type_map[i];
-		if (ebitmap_cardinality(typemap) == 0) continue;
+		if (ebitmap_length(typemap) == 0) continue;
 		types = ebitmap_to_str(typemap, pdb->p_type_val_to_name, 1);
 		if (!types) {
 			rc = -1;
@@ -1879,7 +1879,7 @@ static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 	char *sens_str = pdb->p_sens_val_to_name[level->sens - 1];
 	char *cats_str;
 
-	if (ebitmap_cardinality(cats) > 0) {
+	if (ebitmap_length(cats) > 0) {
 		cats_str = cats_ebitmap_to_str(cats, pdb->p_cat_val_to_name);
 		level_str = create_str("(%s %s)", 2, sens_str, cats_str);
 		free(cats_str);
@@ -2188,7 +2188,7 @@ static int write_role_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 			goto exit;
 		}
 		types = &role->types.types;
-		if (types && (ebitmap_cardinality(types) > 0)) {
+		if (types && (ebitmap_length(types) > 0)) {
 			rc = strs_init(&type_strs, pdb->p_types.nprim);
 			if (rc != 0) {
 				goto exit;
@@ -2373,7 +2373,7 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 		}
 
 		roles = &user->roles.roles;
-		if (roles && (ebitmap_cardinality(roles) > 0)) {
+		if (roles && (ebitmap_length(roles) > 0)) {
 			rc = strs_init(&role_strs, pdb->p_roles.nprim);
 			if (rc != 0) {
 				goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index b4966162..cf42f94c 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1090,7 +1090,7 @@ static int write_level_rules_to_conf(FILE *out, struct policydb *pdb)
 		}
 		if (level->isalias) continue;
 
-		if (ebitmap_cardinality(&level->level->cat) > 0) {
+		if (ebitmap_length(&level->level->cat) > 0) {
 			cats = cats_ebitmap_to_str(&level->level->cat, pdb->p_cat_val_to_name);
 			sepol_printf(out, "level %s:%s;\n", name, cats);
 			free(cats);
@@ -1859,7 +1859,7 @@ static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 	char *sens_str = pdb->p_sens_val_to_name[level->sens - 1];
 	char *cats_str;
 
-	if (ebitmap_cardinality(cats) > 0) {
+	if (ebitmap_length(cats) > 0) {
 		cats_str = cats_ebitmap_to_str(cats, pdb->p_cat_val_to_name);
 		level_str = create_str("%s:%s", 2, sens_str, cats_str);
 		free(cats_str);
@@ -2145,7 +2145,7 @@ static int write_role_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 			rc = -1;
 			goto exit;
 		}
-		if (ebitmap_cardinality(&role->types.types) == 0) continue;
+		if (ebitmap_length(&role->types.types) == 0) continue;
 		types = ebitmap_to_str(&role->types.types, pdb->p_type_val_to_name, 1);
 		if (!types) {
 			rc = -1;
@@ -2298,7 +2298,7 @@ static int write_user_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 		}
 		sepol_printf(out, "user %s", name);
 
-		if (ebitmap_cardinality(&user->roles.roles) > 0) {
+		if (ebitmap_length(&user->roles.roles) > 0) {
 			roles = ebitmap_to_str(&user->roles.roles,
 					       pdb->p_role_val_to_name, 1);
 			if (!roles) {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index e20c3d44..b1cbef08 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2069,7 +2069,7 @@ static int class_order_to_cil(int indent, struct policydb *pdb, struct ebitmap o
 	struct ebitmap_node *node;
 	uint32_t i;
 
-	if (ebitmap_cardinality(&order) == 0) {
+	if (ebitmap_length(&order) == 0) {
 		return 0;
 	}
 
@@ -2149,7 +2149,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			}
 		}
 
-		if (ebitmap_cardinality(&role->dominates) > 1) {
+		if (ebitmap_length(&role->dominates) > 1) {
 			log_err("Warning: role 'dominance' statement unsupported in CIL. Dropping from output.");
 		}
 
@@ -2175,7 +2175,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			cil_println(indent, "(roleattribute %s)", key);
 		}
 
-		if (ebitmap_cardinality(&role->roles) > 0) {
+		if (ebitmap_length(&role->roles) > 0) {
 			cil_indent(indent);
 			cil_printf("(roleattributeset %s (", key);
 			ebitmap_for_each_positive_bit(&role->roles, node, i) {
@@ -2269,7 +2269,7 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			cil_printf(")\n");
 		}
 
-		if (ebitmap_cardinality(&type->types) > 0) {
+		if (ebitmap_length(&type->types) > 0) {
 			cil_indent(indent);
 			cil_printf("(typeattributeset %s (", key);
 			ebitmap_to_cil(pdb, &type->types, SYM_TYPES);
@@ -2372,7 +2372,7 @@ static int sens_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 		}
 	}
 
-	if (ebitmap_cardinality(&level->level->cat) > 0) {
+	if (ebitmap_length(&level->level->cat) > 0) {
 		cil_indent(indent);
 		cil_printf("(sensitivitycategory %s (", key);
 		ebitmap_to_cil(pdb, &level->level->cat, SYM_CATS);
@@ -2387,7 +2387,7 @@ static int sens_order_to_cil(int indent, struct policydb *pdb, struct ebitmap or
 	struct ebitmap_node *node;
 	uint32_t i;
 
-	if (ebitmap_cardinality(&order) == 0) {
+	if (ebitmap_length(&order) == 0) {
 		return 0;
 	}
 
@@ -2427,7 +2427,7 @@ static int cat_order_to_cil(int indent, struct policydb *pdb, struct ebitmap ord
 	struct ebitmap_node *node;
 	uint32_t i;
 
-	if (ebitmap_cardinality(&order) == 0) {
+	if (ebitmap_length(&order) == 0) {
 		rc = 0;
 		goto exit;
 	}
@@ -2478,7 +2478,7 @@ static int level_to_cil(struct policydb *pdb, struct mls_level *level)
 
 	cil_printf("(%s", pdb->p_sens_val_to_name[level->sens - 1]);
 
-	if (ebitmap_cardinality(map) > 0) {
+	if (ebitmap_length(map) > 0) {
 		cil_printf("(");
 		ebitmap_to_cil(pdb, map, SYM_CATS);
 		cil_printf(")");
-- 
2.21.1

