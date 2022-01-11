Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3D1C433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 22:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbiAKWIg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 17:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345484AbiAKWIf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 17:08:35 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A0C06173F
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 14:08:35 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 82so395738qki.10
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 14:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYhyCylSYakgFJJy92qkRmLJ3aXZGxZRlM/FcqiHFm8=;
        b=qeTEEiaoooVoMwbhvz3Rjgflp1DH5EE3Fl2ptm1imLNfiaTM2yu62Ba3BvBjLANQp8
         yC94EVjpVNWmdLjZ+80zKNt4t9qXN2Vrzo+0cuU3hRY29JCC3r3WUiQfKPSH56RapPLc
         cxe9LkqBaEJA9jbri3SIC5E23OaGfPz9ibN7pXu/f98t7iTYcILmXyq69jm43kx7vqB9
         2hcSYGbSGg52c7AOpBtyIJjvzcn15O/cYj/fdVMialA53uQAJEwr2XMDsbNIo4FnTsjQ
         DVpxnChFwdjnZgBUGkMtdD777+pwHM67B0yOHAt2G2P2PxqbEpWxS+SLEs1oCcVmRIsk
         jEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYhyCylSYakgFJJy92qkRmLJ3aXZGxZRlM/FcqiHFm8=;
        b=WHW4bkSdrHe90f73/vRRLxQnSOTgZKzpzi3jhIzDNVThFX3pNfGnczakOuQgf9fEoa
         BuS2l34aYTxBzjYeDICt6vgHO9wdFI3ijInRVlK6KfIg0R2xPiCWbJLlxXClewPgPDE4
         jgQwLFrppFdgcDvrpRTktu2z/9KtId76aeF1rlk1NLqlHECF3T3F8VlESBN/MC4KLkOk
         qc7hZwMxzUpaJpLXbN8g9ARN9GTz4IoPKvYMydEZDl1jWgUBntVOD6u5scdHRZutk/iy
         rx1kWqyPhNjI91pk5Yhexftig27TwwTQiBSiB33zEUa7LLgo4gnTi/ij2FfNASGExFg7
         lPmg==
X-Gm-Message-State: AOAM531rhXE12xmFimFhYE3zLOPDyxjgisMnqv5CKeEnhUkItOv5XHpc
        gpAJS8+spf8eAsb038ChUmK/hxmTOHY=
X-Google-Smtp-Source: ABdhPJzKvR4AfdsH9ZjMIyK2c4XvqlM2BKtSnSkmfYGnFiwjXb2ZkwV2Cjn5WhPEhVntYp2Nskx+2A==
X-Received: by 2002:a05:620a:136c:: with SMTP id d12mr2285036qkl.688.1641938914372;
        Tue, 11 Jan 2022 14:08:34 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id t3sm8211068qtc.7.2022.01.11.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:08:34 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2 RFC] libsepol/cil: Add notself and minusself support to CIL
Date:   Tue, 11 Jan 2022 17:08:23 -0500
Message-Id: <20220111220823.596065-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111220823.596065-1-jwcart2@gmail.com>
References: <20220111220823.596065-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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

Signed-off-by: James Carter <jwcart2@gmail.com>
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
index 4ac8ce8d..f26bcf66 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1437,6 +1437,46 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
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
@@ -1793,10 +1833,51 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct ci
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
@@ -4705,8 +4786,16 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct
 
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
index 5f9392d1..70c91a91 100644
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
index 3898725f..408d47e5 100644
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
@@ -308,30 +438,56 @@ int cil_find_matching_avrule(struct cil_tree_node *node, struct cil_avrule *avru
 
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
index e97a9f46..30ae6f90 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -332,6 +332,10 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 		
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
index d994d717..102b0d73 100644
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
2.31.1

