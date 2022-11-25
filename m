Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB758C4332F
	for <selinux@archiver.kernel.org>; Fri, 25 Nov 2022 15:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiKYPuF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 10:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiKYPuD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Nov 2022 10:50:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805F847333
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:50:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e27so11153391ejc.12
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsjh+UqfF7FkOUnRv1VDPr5SdC//cnCnu7Oafn+3Cc4=;
        b=abzVr6HF/agbvAlhSHYtlAdZJxhkSGsy1f3B60wxyIychq+dGOtUYG+JzLWf0KaPjW
         i/2xbPJNMZd8G2UJTSGdt0Y1RfzC73B/KvdEmXPRNpQGmOVKmhxYjpa4N/2NfCDfL7cs
         TU3ST09w3wZlJg2vtTbDCKSDADSkuXW1JYtE+F3rZtVBva7V5KcXmWxKBgitxusiBKhY
         lsuaPiDdW+K16yYFbvboXVGzMI0NXmPHvdS0G0DlXqf3O6SZ6Y9bQOX4tpybL6nVmxQD
         5u9lndzQkFu52ZtzL76RxAjv63Sui79VTwqbQtGhfjqJySahCPwa1BLFhI1SAB5bcS1L
         9RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsjh+UqfF7FkOUnRv1VDPr5SdC//cnCnu7Oafn+3Cc4=;
        b=GE0pKdzRLheNqr1/zakrNNkTaqmMRhxugv+PkBHFvVuBPr7190OmCmPUtHUBAMtMKE
         67PjAGDbsX9WJ1tb6Gj9ndZS9b2pWgjP/isf2oVyIztL0DMPrSy7TR/BIFIg8chIT6TS
         s9q206wYzcJE1feAfhYSvtFjoIswkr3ADnwT/vYiGUMJ3m5GzxuirAehG2UX20YPjNES
         Tf9Z4nZ+C/nU2rEmNaMKUs/2NBQDhu9KP3PnsOaUYBL8rdcTWYtG/qUFyRLhZGAXjpAD
         eHZY9jTWAiI1UkjVZl5Z428RKsINbv3UF/fy8JSs5CkXOtU/uI0zXfyFp1dxY8edUnzC
         NRGQ==
X-Gm-Message-State: ANoB5pnFBpF9uPR4MnqTbaC2MTyPhrEaizCGWJT3/WVZwS0HjvlZceKB
        0i2ieTQAo7NaAFWAnxZDRVk65aGGnjM=
X-Google-Smtp-Source: AA0mqf4cF5dYJ5Xl17faTBIDbx/D1ZRrHS/caU0pZ7OEu7kxYoUFq+4RdAOwiEuVQd0FuvcMq4TtoQ==
X-Received: by 2002:a17:906:2817:b0:7ba:da1f:a727 with SMTP id r23-20020a170906281700b007bada1fa727mr8526863ejc.276.1669391399796;
        Fri, 25 Nov 2022 07:49:59 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-154-194.77.3.pool.telefonica.de. [77.3.154.194])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090630ce00b0078df26efb7dsm1677136ejb.107.2022.11.25.07.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:49:59 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH v4 2/6] libsepol/cil: Add notself and minusself support to CIL
Date:   Fri, 25 Nov 2022 16:49:48 +0100
Message-Id: <20221125154952.20910-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125154952.20910-1-cgzones@googlemail.com>
References: <20221125154952.20910-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: James Carter <jwcart2@gmail.com>

Like "self", both of these reserved words can be used as a target
in an access vector rule. "notself" means all types other than
the source type. "minuself" is meant to be used with an attribute
and its use results in the rule being expanded with each type of
the attribute being used as the source type with each of the other
types being used as the target type. Using "minusself" with just
a type will result in no rule.

Example 1
  (allow TYPE1 notself (CLASS (PERM)))

This rule is expanded to a number of rules with TYPE1 as the source
and every type except for TYPE1 as the target.

Example 2
  (allow ATTR1 notself (CLASS (PERM)))

Like Example 1, this rule will be expanded to each type in ATTR1
being the source with every type except for the type used as the
source being the target.

Example 3
  (allow TYPE1 minusself (CLASS (PERM)))

This expands to no rule.

Example 4
  (allow ATTR1 minusself (CLASS (PERM)))

Like Example 2, but the target types will be limited to the types
in the attribute ATTR1 instead of all types. So if ATTR1 has the
type t1, t2, and t3, then this rule expands to the following rules.
  (allow t1 t2 (CLASS (PERM)))
  (allow t1 t3 (CLASS (PERM)))
  (allow t2 t1 (CLASS (PERM)))
  (allow t2 t3 (CLASS (PERM)))
  (allow t3 t1 (CLASS (PERM)))
  (allow t3 t2 (CLASS (PERM)))

Original patch from James Carter <jwcart2@gmail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil.c             |  12 ++
 libsepol/cil/src/cil_binary.c      |  91 ++++++++++++-
 libsepol/cil/src/cil_build_ast.c   |  10 +-
 libsepol/cil/src/cil_find.c        | 206 +++++++++++++++++++++++++----
 libsepol/cil/src/cil_internal.h    |   4 +
 libsepol/cil/src/cil_resolve_ast.c |   4 +
 libsepol/cil/src/cil_verify.c      |   3 +-
 7 files changed, 300 insertions(+), 30 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 38edcf8e..d807a2c4 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -84,6 +84,8 @@ char *CIL_KEY_CONS_INCOMP;
 char *CIL_KEY_CONDTRUE;
 char *CIL_KEY_CONDFALSE;
 char *CIL_KEY_SELF;
+char *CIL_KEY_NOTSELF;
+char *CIL_KEY_MINUSSELF;
 char *CIL_KEY_OBJECT_R;
 char *CIL_KEY_STAR;
 char *CIL_KEY_TCP;
@@ -253,6 +255,8 @@ static void cil_init_keys(void)
 	CIL_KEY_CONDTRUE = cil_strpool_add("true");
 	CIL_KEY_CONDFALSE = cil_strpool_add("false");
 	CIL_KEY_SELF = cil_strpool_add("self");
+	CIL_KEY_NOTSELF = cil_strpool_add("notself");
+	CIL_KEY_MINUSSELF = cil_strpool_add("minusself");
 	CIL_KEY_OBJECT_R = cil_strpool_add("object_r");
 	CIL_KEY_STAR = cil_strpool_add("*");
 	CIL_KEY_UDP = cil_strpool_add("udp");
@@ -430,6 +434,12 @@ void cil_db_init(struct cil_db **db)
 	cil_type_init(&(*db)->selftype);
 	(*db)->selftype->datum.name = CIL_KEY_SELF;
 	(*db)->selftype->datum.fqn = CIL_KEY_SELF;
+	cil_type_init(&(*db)->notselftype);
+	(*db)->notselftype->datum.name = CIL_KEY_NOTSELF;
+	(*db)->notselftype->datum.fqn = CIL_KEY_NOTSELF;
+	cil_type_init(&(*db)->minusselftype);
+	(*db)->minusselftype->datum.name = CIL_KEY_MINUSSELF;
+	(*db)->minusselftype->datum.fqn = CIL_KEY_MINUSSELF;
 	(*db)->num_types_and_attrs = 0;
 	(*db)->num_classes = 0;
 	(*db)->num_types = 0;
@@ -483,6 +493,8 @@ void cil_db_destroy(struct cil_db **db)
 	cil_list_destroy(&(*db)->names, CIL_TRUE);
 
 	cil_destroy_type((*db)->selftype);
+	cil_destroy_type((*db)->notselftype);
+	cil_destroy_type((*db)->minusselftype);
 
 	cil_strpool_destroy();
 	free((*db)->val_to_type);
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 40615db2..29b00336 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1519,6 +1519,46 @@ static int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struc
 			}
 		}
 		ebitmap_destroy(&src_bitmap);
+	} else if (tgt->fqn == CIL_KEY_NOTSELF) {
+		rc = __cil_expand_type(src, &src_bitmap);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+		ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
+			src = DATUM(db->val_to_type[s]);
+			for (t = 0; t < (unsigned int)db->num_types; t++) {
+				if (s != t) {
+					tgt = DATUM(db->val_to_type[t]);
+					rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
+					if (rc != SEPOL_OK) {
+						ebitmap_destroy(&src_bitmap);
+						goto exit;
+					}
+				}
+			}
+		}
+		ebitmap_destroy(&src_bitmap);
+	} else if (tgt->fqn == CIL_KEY_MINUSSELF) {
+		rc = __cil_expand_type(src, &src_bitmap);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+		ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
+			src = DATUM(db->val_to_type[s]);
+			ebitmap_for_each_positive_bit(&src_bitmap, tnode, t) {
+				if (s != t) {
+					tgt = DATUM(db->val_to_type[t]);
+					rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
+					if (rc != SEPOL_OK) {
+						ebitmap_destroy(&src_bitmap);
+						goto exit;
+					}
+				}
+			}
+		}
+		ebitmap_destroy(&src_bitmap);
 	} else {
 		int expand_src = __cil_should_expand_attribute(db, src);
 		int expand_tgt = __cil_should_expand_attribute(db, tgt);
@@ -1875,10 +1915,51 @@ static int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, st
 			src = DATUM(db->val_to_type[s]);
 			rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, src, cil_avrulex->perms.x.permx, args);
 			if (rc != SEPOL_OK) {
+				ebitmap_destroy(&src_bitmap);
 				goto exit;
 			}
 		}
 		ebitmap_destroy(&src_bitmap);
+	} else if (tgt->fqn == CIL_KEY_NOTSELF) {
+		rc = __cil_expand_type(src, &src_bitmap);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+		ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
+			src = DATUM(db->val_to_type[s]);
+			for (t = 0; t < (unsigned int)db->num_types; t++) {
+				if (s != t) {
+					tgt = DATUM(db->val_to_type[t]);
+					rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
+					if (rc != SEPOL_OK) {
+						ebitmap_destroy(&src_bitmap);
+						goto exit;
+					}
+				}
+			}
+		}
+		ebitmap_destroy(&src_bitmap);
+	} else if (tgt->fqn == CIL_KEY_MINUSSELF) {
+		rc = __cil_expand_type(src, &src_bitmap);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+		ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
+			src = DATUM(db->val_to_type[s]);
+			ebitmap_for_each_positive_bit(&src_bitmap, tnode, t) {
+				if (s != t) {
+					tgt = DATUM(db->val_to_type[t]);
+					rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
+					if (rc != SEPOL_OK) {
+						ebitmap_destroy(&src_bitmap);
+						goto exit;
+					}
+				}
+			}
+		}
+		ebitmap_destroy(&src_bitmap);
 	} else {
 		int expand_src = __cil_should_expand_attribute(db, src);
 		int expand_tgt = __cil_should_expand_attribute(db, tgt);
@@ -4813,8 +4894,16 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct
 
 	if (tgt->fqn == CIL_KEY_SELF) {
 		rule->flags = RULE_SELF;
+	} else if (tgt->fqn == CIL_KEY_NOTSELF) {
+		rule->flags = RULE_NOTSELF;
+	} else if (tgt->fqn == CIL_KEY_MINUSSELF) {
+		rule->flags = RULE_NOTSELF;
+		rc = __cil_add_sepol_type(pdb, db, cil_rule->src, &rule->ttypes.types);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
 	} else {
-		rc = __cil_add_sepol_type(pdb, db, cil_rule->tgt, &rule->ttypes.types);
+		rc = __cil_add_sepol_type(pdb, db, tgt, &rule->ttypes.types);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 4177c9f6..ca9f80c7 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -3126,9 +3126,13 @@ int cil_gen_aliasactual(struct cil_db *db, struct cil_tree_node *parse_current,
 		goto exit;
 	}
 
-	if ((flavor == CIL_TYPEALIAS && parse_current->next->data == CIL_KEY_SELF) || parse_current->next->next->data == CIL_KEY_SELF) {
-		cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_KEY_SELF);
-		rc = SEPOL_ERR;
+	rc = cil_verify_name(db, parse_current->next->data, flavor);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	rc = cil_verify_name(db, parse_current->next->next->data, flavor);
+	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 
diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
index 8b755277..1518d33d 100644
--- a/libsepol/cil/src/cil_find.c
+++ b/libsepol/cil/src/cil_find.c
@@ -115,12 +115,13 @@ static int cil_type_matches(ebitmap_t *matches, struct cil_symtab_datum *d1, str
 
 /* s1 is the src type that is matched with a self
  * s2, and t2 are the source and type of the other rule
+ * Assumes there is a match between s1 and s2
  */
 static int cil_self_match_any(struct cil_symtab_datum *s1, struct cil_symtab_datum *s2, struct cil_symtab_datum *t2)
 {
 	int rc;
-	struct cil_tree_node *n1 = NODE(s1);
-	if (n1->flavor != CIL_TYPEATTRIBUTE) {
+
+	if (FLAVOR(s1) != CIL_TYPEATTRIBUTE) {
 		rc = cil_type_match_any(s1, t2);
 	} else {
 		struct cil_typeattribute *a = (struct cil_typeattribute *)s1;
@@ -129,20 +130,149 @@ static int cil_self_match_any(struct cil_symtab_datum *s1, struct cil_symtab_dat
 		rc = cil_type_matches(&map, s2, t2);
 		if (rc < 0) {
 			ebitmap_destroy(&map);
-			goto exit;
+			return rc;
 		}
-		if (map.node == NULL) {
-			rc = CIL_FALSE;
-			goto exit;
+		if (!ebitmap_startnode(&map)) {
+			ebitmap_destroy(&map);
+			return CIL_FALSE;
 		}
 		rc = ebitmap_match_any(&map, a->types);
 		ebitmap_destroy(&map);
 	}
 
-exit:
 	return rc;
 }
 
+/* s1 is the src type that is matched with a notself
+ * s2 and t2 are the source and type of the other rule
+ * Assumes there is a match between s1 and s2
+ */
+static int cil_notself_match_any(struct cil_symtab_datum *s1, struct cil_symtab_datum *s2, struct cil_symtab_datum *t2)
+{
+	int rc;
+	ebitmap_node_t *snode, *tnode;
+	unsigned int s,t;
+
+	if (FLAVOR(s1) != CIL_TYPEATTRIBUTE) {
+		struct cil_type *ts1 = (struct cil_type *)s1;
+		if (FLAVOR(t2) != CIL_TYPEATTRIBUTE) {
+			struct cil_type *tt2 = (struct cil_type *)t2;
+			if (ts1->value != tt2->value) {
+				return CIL_TRUE;
+			}
+		} else {
+			struct cil_typeattribute *at2 = (struct cil_typeattribute *)t2;
+			ebitmap_for_each_positive_bit(at2->types, tnode, t) {
+				if (t != (unsigned int)ts1->value) {
+					return CIL_TRUE;
+				}
+			}
+		}
+	} else {
+		ebitmap_t smap;
+		ebitmap_init(&smap);
+		rc = cil_type_matches(&smap, s1, s2);
+		if (rc < 0) {
+			ebitmap_destroy(&smap);
+			return rc;
+		}
+		if (!ebitmap_startnode(&smap)) {
+			ebitmap_destroy(&smap);
+			return CIL_FALSE;
+		}
+		if (FLAVOR(t2) != CIL_TYPEATTRIBUTE) {
+			struct cil_type *tt2 = (struct cil_type *)t2;
+			ebitmap_for_each_positive_bit(&smap, snode, s) {
+				if (s != (unsigned int)tt2->value) {
+					ebitmap_destroy(&smap);
+					return CIL_TRUE;
+				}
+			}
+		} else {
+			struct cil_typeattribute *at2 = (struct cil_typeattribute *)t2;
+			ebitmap_for_each_positive_bit(&smap, snode, s) {
+				ebitmap_for_each_positive_bit(at2->types, tnode, t) {
+					if (s != t) {
+						ebitmap_destroy(&smap);
+						return CIL_TRUE;
+					}
+				}
+			}
+		}
+		ebitmap_destroy(&smap);
+	}
+
+	return CIL_FALSE;
+}
+
+/* s1 is the src type that is matched with a minusself
+ * s2, and t2 are the source and type of the other rule
+ * Assumes there is a match between s1 and s2
+ */
+static int cil_minusself_match_any(struct cil_symtab_datum *s1, struct cil_symtab_datum *s2, struct cil_symtab_datum *t2)
+{
+	int rc;
+
+	if (FLAVOR(s1) != CIL_TYPEATTRIBUTE) {
+		return CIL_FALSE;
+	} else {
+		ebitmap_t smap, tmap;
+		ebitmap_node_t *snode, *tnode;
+		unsigned int s,t;
+
+		ebitmap_init(&smap);
+		rc = cil_type_matches(&smap, s1, s2);
+		if (rc < 0) {
+			ebitmap_destroy(&smap);
+			return rc;
+		}
+
+		ebitmap_init(&tmap);
+		rc = cil_type_matches(&tmap, s1, t2);
+		if (rc < 0) {
+			ebitmap_destroy(&smap);
+			ebitmap_destroy(&tmap);
+			return rc;
+		}
+
+		if (!ebitmap_startnode(&smap) || !ebitmap_startnode(&tmap)) {
+			ebitmap_destroy(&smap);
+			ebitmap_destroy(&tmap);
+			return CIL_FALSE;
+		}
+
+		ebitmap_for_each_positive_bit(&smap, snode, s) {
+			ebitmap_for_each_positive_bit(&tmap, tnode, t) {
+				if (s != t) {
+					ebitmap_destroy(&smap);
+					ebitmap_destroy(&tmap);
+					return CIL_TRUE;
+				}
+			}
+		}
+
+		ebitmap_destroy(&smap);
+		ebitmap_destroy(&tmap);
+	}
+
+	return CIL_FALSE;
+}
+
+/* s2 is the src type that is matched with a minusself
+ * Assumes there is a match between s1 and s2
+ * s1 is not needed, since it is known that there is a match
+ */
+static int cil_notself_minusself_match_any(struct cil_symtab_datum *s2)
+{
+	if (FLAVOR(s2) == CIL_TYPEATTRIBUTE) {
+		struct cil_typeattribute *as2 = (struct cil_typeattribute *)s2;
+		if (ebitmap_cardinality(as2->types) > 1) {
+			return CIL_TRUE;
+		}
+	}
+	return CIL_FALSE;
+}
+
 static int cil_classperms_match_any(struct cil_classperms *cp1, struct cil_classperms *cp2)
 {
 	struct cil_class *c1 = cp1->class;
@@ -308,30 +438,56 @@ static int cil_find_matching_avrule(struct cil_tree_node *node, struct cil_avrul
 
 	if (!cil_type_match_any(s1, s2)) goto exit;
 
-	if (t1->fqn != CIL_KEY_SELF && t2->fqn != CIL_KEY_SELF) {
-		if (!cil_type_match_any(t1, t2)) goto exit;
-	} else {
-		if (t1->fqn == CIL_KEY_SELF && t2->fqn == CIL_KEY_SELF) {
+	if (t1->fqn == CIL_KEY_SELF) {
+		if (t2->fqn == CIL_KEY_SELF) {
 			/* The earlier check whether s1 and s2 matches is all that is needed */
-		} else if (t1->fqn == CIL_KEY_SELF) {
+			rc = CIL_TRUE;
+		} else if (t2->fqn == CIL_KEY_NOTSELF || t2->fqn == CIL_KEY_MINUSSELF) {
+			rc = CIL_FALSE;
+		} else {
 			rc = cil_self_match_any(s1, s2, t2);
-			if (rc < 0) {
-				goto exit;
-			} else if (rc == CIL_FALSE) {
-				rc = SEPOL_OK;
-				goto exit;
-			}
-		} else if (t2->fqn == CIL_KEY_SELF) {
+		}
+	} else if (t1->fqn == CIL_KEY_NOTSELF) {
+		if (t2->fqn == CIL_KEY_SELF) {
+			rc = CIL_FALSE;
+		} else if (t2->fqn == CIL_KEY_NOTSELF) {
+			/* The earlier check whether s1 and s2 matches is all that is needed */
+			rc = CIL_TRUE;
+		} else if (t2->fqn == CIL_KEY_MINUSSELF) {
+			rc = cil_notself_minusself_match_any(s2);
+		} else {
+			rc = cil_notself_match_any(s1, s2, t2);
+		}
+	} else if (t1->fqn == CIL_KEY_MINUSSELF) {
+		if (t2->fqn == CIL_KEY_SELF) {
+			rc = CIL_FALSE;
+		} else if (t2->fqn == CIL_KEY_NOTSELF) {
+			rc = cil_notself_minusself_match_any(s1);
+		} else if (t2->fqn == CIL_KEY_MINUSSELF) {
+			/* The earlier check whether s1 and s2 matches is all that is needed */
+			rc = CIL_TRUE;
+		} else {
+			rc = cil_minusself_match_any(s1, s2, t2);
+		}
+	} else {
+		if (t2->fqn == CIL_KEY_SELF) {
 			rc = cil_self_match_any(s2, s1, t1);
-			if (rc < 0) {
-				goto exit;
-			} else if (rc == CIL_FALSE) {
-				rc = SEPOL_OK;
-				goto exit;
-			}
+		} else if (t2->fqn == CIL_KEY_NOTSELF) {
+			rc = cil_notself_match_any(s2, s1, t1);
+		} else if (t2->fqn == CIL_KEY_MINUSSELF) {
+			rc = cil_minusself_match_any(s2, s1, t1);
+		} else {
+			rc = cil_type_match_any(t1, t2);
 		}
 	}
 
+	if (rc < 0) {
+		goto exit;
+	} else if (rc == CIL_FALSE) {
+		rc = SEPOL_OK;
+		goto exit;
+	}
+
 	if (!target->is_extended) {
 		if (cil_classperms_list_match_any(avrule->perms.classperms, target->perms.classperms)) {
 			cil_list_append(matching, CIL_NODE, node);
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index a7604762..d293b9ba 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -101,6 +101,8 @@ extern char *CIL_KEY_CONS_INCOMP;
 extern char *CIL_KEY_CONDTRUE;
 extern char *CIL_KEY_CONDFALSE;
 extern char *CIL_KEY_SELF;
+extern char *CIL_KEY_NOTSELF;
+extern char *CIL_KEY_MINUSSELF;
 extern char *CIL_KEY_OBJECT_R;
 extern char *CIL_KEY_STAR;
 extern char *CIL_KEY_TCP;
@@ -289,6 +291,8 @@ struct cil_db {
 	struct cil_tree *parse;
 	struct cil_tree *ast;
 	struct cil_type *selftype;
+	struct cil_type *notselftype;
+	struct cil_type *minusselftype;
 	struct cil_list *sidorder;
 	struct cil_list *classorder;
 	struct cil_list *catorder;
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index f5e22c97..9065fe09 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -333,6 +333,10 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 		
 	if (rule->tgt_str == CIL_KEY_SELF) {
 		rule->tgt = db->selftype;
+	} else if (rule->tgt_str == CIL_KEY_NOTSELF) {
+		rule->tgt = db->notselftype;
+	} else if (rule->tgt_str == CIL_KEY_MINUSSELF) {
+		rule->tgt = db->minusselftype;
 	} else {
 		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, args, &tgt_datum);
 		if (rc != SEPOL_OK) {
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 4640dc59..1706fbf2 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -68,7 +68,8 @@ static int __cil_is_reserved_name(const char *name, enum cil_flavor flavor)
 	case CIL_TYPE:
 	case CIL_TYPEATTRIBUTE:
 	case CIL_TYPEALIAS:
-		if ((name == CIL_KEY_ALL) || (name == CIL_KEY_SELF))
+		if ((name == CIL_KEY_ALL) || (name == CIL_KEY_SELF) || (name == CIL_KEY_NOTSELF)
+			|| (name == CIL_KEY_MINUSSELF))
 			return CIL_TRUE;
 		break;
 	case CIL_CAT:
-- 
2.38.1

