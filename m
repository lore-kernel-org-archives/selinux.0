Return-Path: <SRS0=Ozag=TN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C968AC04AA7
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 10:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8BF21019
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 10:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfEMKno (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 May 2019 06:43:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46266 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfEMKnn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 May 2019 06:43:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so14028992wrr.13
        for <selinux@vger.kernel.org>; Mon, 13 May 2019 03:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vmvdPpI+SbemTqWnaDpbHVOQBtbh6P95+ju9ZqxRoP8=;
        b=hd6MRIRPftV7o0zgP3Rvv+xtpnPzHnkLSSWlVyPIBoA+ny557S0QgN0uUMc0jodyVY
         FpH2vB5shbxggKY7KFZfsg75laRlUr7HIi3BLmLUPhWTWVZbKGWqoQuhM9uLXsSBmXPE
         sLbJHhtIf0LBnqeKSWXSI2XyoQMob5XTJRdkf7tjiKn1XCP1Q7HcXJXgI2V9r0OP3Ihb
         lBzX6rapXRnWoR05OEwPsUkj6f3SXCd10mUp72ed3zFUXS1Dn53iSAuXhNIUoetRuZv/
         VthOLCaruO7+1rkyB8Ept0qHBaw5aeaB17Ukbv1g2q9wQjnPa42iVgOtdZN1HeBdKPGx
         kvyg==
X-Gm-Message-State: APjAAAUAxPEQum3eGdfQYWU9CFmurcwdUoBP13eUlMEKw2Ix3w7C+joh
        0Ea9QoEmKsGihPnFUKPTF3NlC7o9bRU=
X-Google-Smtp-Source: APXvYqz9VQUA8TzxgceEfehobQHwih1rpD7bftftlSU5RYfdg5Z31DWMNmkIG3JlcemX1p5LtRVwCQ==
X-Received: by 2002:adf:8385:: with SMTP id 5mr3299991wre.194.1557744216978;
        Mon, 13 May 2019 03:43:36 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a125sm24176809wmc.47.2019.05.13.03.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 03:43:36 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH userspace] libsepol: add ebitmap_for_each_set_bit macro
Date:   Mon, 13 May 2019 12:43:34 +0200
Message-Id: <20190513104334.19677-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Most of the users of ebitmap_for_each_bit() macro only care for the set
bits, so introduce a new ebitmap_for_each_set_bit() macro that skips the
unset bits. Replace uses of ebitmap_for_each_bit() with the new macro
where appropriate.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 checkpolicy/policy_define.c               | 159 +++++++-----------
 checkpolicy/test/dismod.c                 |  14 +-
 checkpolicy/test/dispol.c                 |  24 ++-
 libsepol/cil/src/cil_binary.c             | 107 ++++--------
 libsepol/cil/src/cil_policy.c             |  12 +-
 libsepol/cil/src/cil_post.c               |  12 +-
 libsepol/include/sepol/policydb/ebitmap.h |   3 +
 libsepol/src/assertion.c                  |  34 +---
 libsepol/src/expand.c                     | 189 ++++++++--------------
 libsepol/src/genusers.c                   |  17 +-
 libsepol/src/hierarchy.c                  |   8 +-
 libsepol/src/kernel_to_cil.c              |  17 +-
 libsepol/src/kernel_to_common.c           |   4 +-
 libsepol/src/kernel_to_conf.c             |  17 +-
 libsepol/src/link.c                       | 186 +++++++++------------
 libsepol/src/mls.c                        |  50 +++---
 libsepol/src/module_to_cil.c              |  88 +++-------
 libsepol/src/policydb.c                   |   7 +-
 libsepol/src/services.c                   |  16 +-
 libsepol/src/users.c                      |  19 +--
 libsepol/src/write.c                      |  17 +-
 libsepol/tests/test-common.c              |  46 +++---
 libsepol/tests/test-expander-users.c      |  16 +-
 libsepol/tests/test-linker-roles.c        |   8 +-
 24 files changed, 383 insertions(+), 687 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index ece10e7a..97949229 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1210,10 +1210,7 @@ int expand_attrib(void)
 		flags = TYPE_FLAGS_EXPAND_ATTR_FALSE;
 	}
 
-	ebitmap_for_each_bit(&attrs, node, i) {
-		if (!ebitmap_node_get_bit(node, i)){
-			continue;
-		}
+	ebitmap_for_each_set_bit(&attrs, node, i) {
 		attr = hashtab_search(policydbp->p_types.table,
 				policydbp->sym_val_to_name[SYM_TYPES][i]);
 		attr->flags |= flags;
@@ -1673,19 +1670,17 @@ int define_compute_type_helper(int which, avrule_t ** rule)
 	}
 	free(id);
 
-	ebitmap_for_each_bit(&tclasses, node, i) {
-		if (ebitmap_node_get_bit(node, i)) {
-			perm = malloc(sizeof(class_perm_node_t));
-			if (!perm) {
-				yyerror("out of memory");
-				goto bad;
-			}
-			class_perm_node_init(perm);
-			perm->tclass = i + 1;
-			perm->data = datum->s.value;
-			perm->next = avrule->perms;
-			avrule->perms = perm;
+	ebitmap_for_each_set_bit(&tclasses, node, i) {
+		perm = malloc(sizeof(class_perm_node_t));
+		if (!perm) {
+			yyerror("out of memory");
+			goto bad;
 		}
+		class_perm_node_init(perm);
+		perm->tclass = i + 1;
+		perm->data = datum->s.value;
+		perm->next = avrule->perms;
+		avrule->perms = perm;
 	}
 	ebitmap_destroy(&tclasses);
 
@@ -2101,9 +2096,7 @@ int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 
 	perms = NULL;
 	id = queue_head(id_queue);
-	ebitmap_for_each_bit(&tclasses, node, i) {
-		if (!ebitmap_node_get_bit(node, i))
-			continue;
+	ebitmap_for_each_set_bit(&tclasses, node, i) {
 		cur_perms =
 		    (class_perm_node_t *) malloc(sizeof(class_perm_node_t));
 		if (!cur_perms) {
@@ -2565,9 +2558,7 @@ int define_te_avtab_helper(int which, avrule_t ** rule)
 		goto out;
 
 	perms = NULL;
-	ebitmap_for_each_bit(&tclasses, node, i) {
-		if (!ebitmap_node_get_bit(node, i))
-			continue;
+	ebitmap_for_each_set_bit(&tclasses, node, i) {
 		cur_perms =
 		    (class_perm_node_t *) malloc(sizeof(class_perm_node_t));
 		if (!cur_perms) {
@@ -2586,9 +2577,7 @@ int define_te_avtab_helper(int which, avrule_t ** rule)
 
 	while ((id = queue_remove(id_queue))) {
 		cur_perms = perms;
-		ebitmap_for_each_bit(&tclasses, node, i) {
-			if (!ebitmap_node_get_bit(node, i))
-				continue;
+		ebitmap_for_each_set_bit(&tclasses, node, i) {
 			cladatum = policydbp->class_val_to_struct[i];
 
 			if (strcmp(id, "*") == 0) {
@@ -2930,17 +2919,13 @@ static int dominate_role_recheck(hashtab_key_t key __attribute__ ((unused)),
 			return -1;
 		}
 		/* raise types and dominates from dominated role */
-		ebitmap_for_each_bit(&rdp->dominates, node, i) {
-			if (ebitmap_node_get_bit(node, i))
-				if (ebitmap_set_bit
-				    (&rdatum->dominates, i, TRUE))
-					goto oom;
+		ebitmap_for_each_set_bit(&rdp->dominates, node, i) {
+			if (ebitmap_set_bit(&rdatum->dominates, i, TRUE))
+				goto oom;
 		}
-		ebitmap_for_each_bit(&types, node, i) {
-			if (ebitmap_node_get_bit(node, i))
-				if (ebitmap_set_bit
-				    (&rdatum->types.types, i, TRUE))
-					goto oom;
+		ebitmap_for_each_set_bit(&types, node, i) {
+			if (ebitmap_set_bit(&rdatum->types.types, i, TRUE))
+				goto oom;
 		}
 		ebitmap_destroy(&types);
 	}
@@ -3018,20 +3003,17 @@ role_datum_t *define_role_dom(role_datum_t * r)
 	if (r) {
 		ebitmap_t types;
 		ebitmap_init(&types);
-		ebitmap_for_each_bit(&r->dominates, node, i) {
-			if (ebitmap_node_get_bit(node, i))
-				if (ebitmap_set_bit(&role->dominates, i, TRUE))
-					goto oom;
+		ebitmap_for_each_set_bit(&r->dominates, node, i) {
+			if (ebitmap_set_bit(&role->dominates, i, TRUE))
+				goto oom;
 		}
 		if (type_set_expand(&r->types, &types, policydbp, 1)) {
 			ebitmap_destroy(&types);
 			return NULL;
 		}
-		ebitmap_for_each_bit(&types, node, i) {
-			if (ebitmap_node_get_bit(node, i))
-				if (ebitmap_set_bit
-				    (&role->types.types, i, TRUE))
-					goto oom;
+		ebitmap_for_each_set_bit(&types, node, i) {
+			if (ebitmap_set_bit(&role->types.types, i, TRUE))
+				goto oom;
 		}
 		ebitmap_destroy(&types);
 		if (!r->s.value) {
@@ -3214,15 +3196,9 @@ int define_role_trans(int class_specified)
 	if (type_set_expand(&types, &e_types, policydbp, 1))
 		goto bad;
 
-	ebitmap_for_each_bit(&e_roles, rnode, i) {
-		if (!ebitmap_node_get_bit(rnode, i))
-			continue;
-		ebitmap_for_each_bit(&e_types, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
-			ebitmap_for_each_bit(&e_classes, cnode, k) {
-				if (!ebitmap_node_get_bit(cnode, k))
-					continue;
+	ebitmap_for_each_set_bit(&e_roles, rnode, i) {
+		ebitmap_for_each_set_bit(&e_types, tnode, j) {
+			ebitmap_for_each_set_bit(&e_classes, cnode, k) {
 				for (tr = policydbp->role_tr; tr;
 				     tr = tr->next) {
 					if (tr->role == (i + 1) &&
@@ -3410,16 +3386,9 @@ int define_filename_trans(void)
 	if (type_set_expand(&ttypes, &e_ttypes, policydbp, 1))
 		goto bad;
 
-	ebitmap_for_each_bit(&e_tclasses, cnode, c) {
-		if (!ebitmap_node_get_bit(cnode, c))
-			continue;
-		ebitmap_for_each_bit(&e_stypes, snode, s) {
-			if (!ebitmap_node_get_bit(snode, s))
-				continue;
-			ebitmap_for_each_bit(&e_ttypes, tnode, t) {
-				if (!ebitmap_node_get_bit(tnode, t))
-					continue;
-
+	ebitmap_for_each_set_bit(&e_tclasses, cnode, c) {
+		ebitmap_for_each_set_bit(&e_stypes, snode, s) {
+			ebitmap_for_each_set_bit(&e_ttypes, tnode, t) {
 				ft = calloc(1, sizeof(*ft));
 				if (!ft) {
 					yyerror("out of memory");
@@ -3652,39 +3621,36 @@ int define_constraint(constraint_expr_t * expr)
 	}
 
 	while ((id = queue_remove(id_queue))) {
-		ebitmap_for_each_bit(&classmap, enode, i) {
-			if (ebitmap_node_get_bit(enode, i)) {
-				cladatum = policydbp->class_val_to_struct[i];
-				node = cladatum->constraints;
-
-				perdatum =
-				    (perm_datum_t *) hashtab_search(cladatum->
-								    permissions.
-								    table,
-								    (hashtab_key_t)
-								    id);
+		ebitmap_for_each_set_bit(&classmap, enode, i) {
+			cladatum = policydbp->class_val_to_struct[i];
+			node = cladatum->constraints;
+
+			perdatum =
+			    (perm_datum_t *) hashtab_search(cladatum->
+							    permissions.
+							    table,
+							    (hashtab_key_t)
+							    id);
+			if (!perdatum) {
+				if (cladatum->comdatum) {
+					perdatum =
+					    (perm_datum_t *)
+					    hashtab_search(cladatum->
+							   comdatum->
+							   permissions.
+							   table,
+							   (hashtab_key_t)
+							   id);
+				}
 				if (!perdatum) {
-					if (cladatum->comdatum) {
-						perdatum =
-						    (perm_datum_t *)
-						    hashtab_search(cladatum->
-								   comdatum->
-								   permissions.
-								   table,
-								   (hashtab_key_t)
-								   id);
-					}
-					if (!perdatum) {
-						yyerror2("permission %s is not"
-							 " defined", id);
-						free(id);
-						ebitmap_destroy(&classmap);
-						return -1;
-					}
+					yyerror2("permission %s is not"
+						 " defined", id);
+					free(id);
+					ebitmap_destroy(&classmap);
+					return -1;
 				}
-				node->permissions |=
-				    (1 << (perdatum->s.value - 1));
 			}
+			node->permissions |= (1 << (perdatum->s.value - 1));
 		}
 		free(id);
 	}
@@ -4179,10 +4145,9 @@ static int set_user_roles(role_set_t * set, char *id)
 	}
 
 	/* set the role and every role it dominates */
-	ebitmap_for_each_bit(&r->dominates, node, i) {
-		if (ebitmap_node_get_bit(node, i))
-			if (ebitmap_set_bit(&set->roles, i, TRUE))
-				goto oom;
+	ebitmap_for_each_set_bit(&r->dominates, node, i) {
+		if (ebitmap_set_bit(&set->roles, i, TRUE))
+			goto oom;
 	}
 	free(id);
 	return 0;
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 075bd85d..7d5abf5c 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -825,15 +825,13 @@ static void display_policycaps(policydb_t * p, FILE * fp)
 	unsigned int i;
 
 	fprintf(fp, "policy capabilities:\n");
-	ebitmap_for_each_bit(&p->policycaps, node, i) {
-		if (ebitmap_node_get_bit(node, i)) {
-			capname = sepol_polcap_getname(i);
-			if (capname == NULL) {
-				snprintf(buf, sizeof(buf), "unknown (%d)", i);
-				capname = buf;
-			}
-			fprintf(fp, "\t%s\n", capname);
+	ebitmap_for_each_set_bit(&p->policycaps, node, i) {
+		capname = sepol_polcap_getname(i);
+		if (capname == NULL) {
+			snprintf(buf, sizeof(buf), "unknown (%d)", i);
+			capname = buf;
 		}
+		fprintf(fp, "\t%s\n", capname);
 	}
 }
 
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index ee0f5f64..40e29a17 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -282,15 +282,13 @@ static void display_policycaps(policydb_t * p, FILE * fp)
 	unsigned int i;
 
 	fprintf(fp, "policy capabilities:\n");
-	ebitmap_for_each_bit(&p->policycaps, node, i) {
-		if (ebitmap_node_get_bit(node, i)) {
-			capname = sepol_polcap_getname(i);
-			if (capname == NULL) {
-				snprintf(buf, sizeof(buf), "unknown (%d)", i);
-				capname = buf;
-			}
-			fprintf(fp, "\t%s\n", capname);
+	ebitmap_for_each_set_bit(&p->policycaps, node, i) {
+		capname = sepol_polcap_getname(i);
+		if (capname == NULL) {
+			snprintf(buf, sizeof(buf), "unknown (%d)", i);
+			capname = buf;
 		}
+		fprintf(fp, "\t%s\n", capname);
 	}
 }
 
@@ -307,12 +305,10 @@ static void display_permissive(policydb_t *p, FILE *fp)
 	unsigned int i;
 
 	fprintf(fp, "permissive sids:\n");
-	ebitmap_for_each_bit(&p->permissive_map, node, i) {
-		if (ebitmap_node_get_bit(node, i)) {
-			fprintf(fp, "\t");
-			display_id(p, fp, SYM_TYPES, i - 1, "");
-			fprintf(fp, "\n");
-		}
+	ebitmap_for_each_set_bit(&p->permissive_map, node, i) {
+		fprintf(fp, "\t");
+		display_id(p, fp, SYM_TYPES, i - 1, "");
+		fprintf(fp, "\n");
 	}
 }
 
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index e2eb3ebe..7a8f7af0 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -441,9 +441,7 @@ int cil_roletype_to_policydb(policydb_t *pdb, const struct cil_db *db, struct ci
 		rc = __cil_get_sepol_role_datum(pdb, DATUM(role), &sepol_role);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(role->types, tnode, i) {
-			if (!ebitmap_get_bit(role->types, i)) continue;
-
+		ebitmap_for_each_set_bit(role->types, tnode, i) {
 			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_type);
 			if (rc != SEPOL_OK) goto exit;
 
@@ -652,9 +650,7 @@ int cil_typeattribute_to_bitmap(policydb_t *pdb, const struct cil_db *db, struct
 
 	value = sepol_type->s.value;
 
-	ebitmap_for_each_bit(cil_attr->types, tnode, i) {
-		if (!ebitmap_get_bit(cil_attr->types, i)) continue;
-
+	ebitmap_for_each_set_bit(cil_attr->types, tnode, i) {
 		rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_type);
 		if (rc != SEPOL_OK) goto exit;
 
@@ -748,11 +744,7 @@ int cil_userrole_to_policydb(policydb_t *pdb, const struct cil_db *db, struct ci
 			goto exit;
 		}
 
-		ebitmap_for_each_bit(user->roles, rnode, i) {
-			if (!ebitmap_get_bit(user->roles, i)) {
-				continue;
-			}
-
+		ebitmap_for_each_set_bit(user->roles, rnode, i) {
 			rc = __cil_get_sepol_role_datum(pdb, DATUM(db->val_to_role[i]), &sepol_role);
 			if (rc != SEPOL_OK) {
 				goto exit;
@@ -1105,15 +1097,11 @@ int __cil_type_rule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct ci
 	rc = __cil_get_sepol_type_datum(pdb, DATUM(cil_rule->result), &sepol_result);
 	if (rc != SEPOL_OK) goto exit;
 
-	ebitmap_for_each_bit(&src_bitmap, node1, i) {
-		if (!ebitmap_get_bit(&src_bitmap, i)) continue;
-
+	ebitmap_for_each_set_bit(&src_bitmap, node1, i) {
 		rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_src);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&tgt_bitmap, node2, j) {
-			if (!ebitmap_get_bit(&tgt_bitmap, j)) continue;
-
+		ebitmap_for_each_set_bit(&tgt_bitmap, node2, j) {
 			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[j]), &sepol_tgt);
 			if (rc != SEPOL_OK) goto exit;
 
@@ -1182,15 +1170,11 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
 	rc = __cil_get_sepol_type_datum(pdb, DATUM(typetrans->result), &sepol_result);
 	if (rc != SEPOL_OK) goto exit;
 
-	ebitmap_for_each_bit(&src_bitmap, node1, i) {
-		if (!ebitmap_get_bit(&src_bitmap, i)) continue;
-
+	ebitmap_for_each_set_bit(&src_bitmap, node1, i) {
 		rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_src);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&tgt_bitmap, node2, j) {
-			if (!ebitmap_get_bit(&tgt_bitmap, j)) continue;
-
+		ebitmap_for_each_set_bit(&tgt_bitmap, node2, j) {
 			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[j]), &sepol_tgt);
 			if (rc != SEPOL_OK) goto exit;
 
@@ -1475,9 +1459,7 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
 			goto exit;
 		}
 
-		ebitmap_for_each_bit(&src_bitmap, snode, s) {
-			if (!ebitmap_get_bit(&src_bitmap, s)) continue;
-
+		ebitmap_for_each_set_bit(&src_bitmap, snode, s) {
 			src = DATUM(db->val_to_type[s]);
 			rc = __cil_avrule_expand(pdb, kind, src, src, classperms, cond_node, cond_flavor);
 			if (rc != SEPOL_OK) {
@@ -1506,11 +1488,9 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
 				goto exit;
 			}
 
-			ebitmap_for_each_bit(&src_bitmap, snode, s) {
-				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
+			ebitmap_for_each_set_bit(&src_bitmap, snode, s) {
 				src = DATUM(db->val_to_type[s]);
-				ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
-					if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
+				ebitmap_for_each_set_bit(&tgt_bitmap, tnode, t) {
 					tgt = DATUM(db->val_to_type[t]);
 
 					rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
@@ -1529,8 +1509,7 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
 				goto exit;
 			}
 
-			ebitmap_for_each_bit(&src_bitmap, snode, s) {
-				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
+			ebitmap_for_each_set_bit(&src_bitmap, snode, s) {
 				src = DATUM(db->val_to_type[s]);
 
 				rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
@@ -1546,8 +1525,7 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
 				goto exit;
 			}
 
-			ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
-				if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
+			ebitmap_for_each_set_bit(&tgt_bitmap, tnode, t) {
 				tgt = DATUM(db->val_to_type[t]);
 
 				rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
@@ -1619,9 +1597,7 @@ int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct cil_list *
 
 	start_new_range = 1;
 
-	ebitmap_for_each_bit(xperms, node, i) {
-		if (!ebitmap_get_bit(xperms, i)) continue;
-
+	ebitmap_for_each_set_bit(xperms, node, i) {
 		if (start_new_range) {
 			low = i;
 			start_new_range = 0;
@@ -1852,9 +1828,7 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct ci
 		rc = __cil_expand_type(src, &src_bitmap);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&src_bitmap, snode, s) {
-			if (!ebitmap_get_bit(&src_bitmap, s)) continue;
-
+		ebitmap_for_each_set_bit(&src_bitmap, snode, s) {
 			src = DATUM(db->val_to_type[s]);
 			rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, src, cil_avrulex->perms.x.permx, args);
 			if (rc != SEPOL_OK) {
@@ -1883,11 +1857,9 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct ci
 				goto exit;
 			}
 
-			ebitmap_for_each_bit(&src_bitmap, snode, s) {
-				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
+			ebitmap_for_each_set_bit(&src_bitmap, snode, s) {
 				src = DATUM(db->val_to_type[s]);
-				ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
-					if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
+				ebitmap_for_each_set_bit(&tgt_bitmap, tnode, t) {
 					tgt = DATUM(db->val_to_type[t]);
 
 					rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
@@ -1906,8 +1878,7 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct ci
 				goto exit;
 			}
 
-			ebitmap_for_each_bit(&src_bitmap, snode, s) {
-				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
+			ebitmap_for_each_set_bit(&src_bitmap, snode, s) {
 				src = DATUM(db->val_to_type[s]);
 
 				rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
@@ -1923,8 +1894,7 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct ci
 				goto exit;
 			}
 
-			ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
-				if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
+			ebitmap_for_each_set_bit(&tgt_bitmap, tnode, t) {
 				tgt = DATUM(db->val_to_type[t]);
 
 				rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
@@ -2367,15 +2337,11 @@ int cil_roletrans_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	rc = __cil_get_sepol_role_datum(pdb, DATUM(roletrans->result), &sepol_result);
 	if (rc != SEPOL_OK) goto exit;
 
-	ebitmap_for_each_bit(&role_bitmap, rnode, i) {
-		if (!ebitmap_get_bit(&role_bitmap, i)) continue;
-
+	ebitmap_for_each_set_bit(&role_bitmap, rnode, i) {
 		rc = __cil_get_sepol_role_datum(pdb, DATUM(db->val_to_role[i]), &sepol_src);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&type_bitmap, tnode, j) {
-			if (!ebitmap_get_bit(&type_bitmap, j)) continue;
-
+		ebitmap_for_each_set_bit(&type_bitmap, tnode, j) {
 			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[j]), &sepol_tgt);
 			if (rc != SEPOL_OK) goto exit;
 
@@ -2444,15 +2410,11 @@ int cil_roleallow_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	rc = __cil_expand_role(roleallow->tgt, &tgt_bitmap);
 	if (rc != SEPOL_OK) goto exit;
 
-	ebitmap_for_each_bit(&src_bitmap, node1, i) {
-		if (!ebitmap_get_bit(&src_bitmap, i)) continue;
-
+	ebitmap_for_each_set_bit(&src_bitmap, node1, i) {
 		rc = __cil_get_sepol_role_datum(pdb, DATUM(db->val_to_role[i]), &sepol_src);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&tgt_bitmap, node2, j) {
-			if (!ebitmap_get_bit(&tgt_bitmap, j)) continue;
-
+		ebitmap_for_each_set_bit(&tgt_bitmap, node2, j) {
 			rc = __cil_get_sepol_role_datum(pdb, DATUM(db->val_to_role[j]), &sepol_tgt);
 			if (rc != SEPOL_OK) goto exit;
 
@@ -2487,11 +2449,7 @@ int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, const struct cil_d
 		rc = __cil_expand_user(item->data, &user_bitmap);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&user_bitmap, unode, i) {
-			if (!ebitmap_get_bit(&user_bitmap, i)) {
-				continue;
-			}
-
+		ebitmap_for_each_set_bit(&user_bitmap, unode, i) {
 			rc = __cil_get_sepol_user_datum(pdb, DATUM(db->val_to_user[i]), &sepol_user);
 			if (rc != SEPOL_OK) {
 				ebitmap_destroy(&user_bitmap);
@@ -2513,9 +2471,7 @@ int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, const struct cil_d
 		rc = __cil_expand_role(item->data, &role_bitmap);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&role_bitmap, rnode, i) {
-			if (!ebitmap_get_bit(&role_bitmap, i)) continue;
-
+		ebitmap_for_each_set_bit(&role_bitmap, rnode, i) {
 			rc = __cil_get_sepol_role_datum(pdb, DATUM(db->val_to_role[i]), &sepol_role);
 			if (rc != SEPOL_OK) {
 				ebitmap_destroy(&role_bitmap);
@@ -2557,9 +2513,7 @@ int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, const struct cil_d
 		rc = __cil_expand_type(item->data, &type_bitmap);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&type_bitmap, tnode, i) {
-			if (!ebitmap_get_bit(&type_bitmap, i)) continue;
-
+		ebitmap_for_each_set_bit(&type_bitmap, tnode, i) {
 			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_type);
 			if (rc != SEPOL_OK) {
 				ebitmap_destroy(&type_bitmap);
@@ -3156,15 +3110,11 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, st
 
 	class_list = cil_expand_class(rangetrans->obj);
 
-	ebitmap_for_each_bit(&src_bitmap, node1, i) {
-		if (!ebitmap_get_bit(&src_bitmap, i)) continue;
-
+	ebitmap_for_each_set_bit(&src_bitmap, node1, i) {
 		rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[i]), &sepol_src);
 		if (rc != SEPOL_OK) goto exit;
 
-		ebitmap_for_each_bit(&tgt_bitmap, node2, j) {
-			if (!ebitmap_get_bit(&tgt_bitmap, j)) continue;
-
+		ebitmap_for_each_set_bit(&tgt_bitmap, node2, j) {
 			rc = __cil_get_sepol_type_datum(pdb, DATUM(db->val_to_type[j]), &sepol_tgt);
 			if (rc != SEPOL_OK) goto exit;
 
@@ -4493,8 +4443,7 @@ static int __cil_add_sepol_type(policydb_t *pdb, const struct cil_db *db, struct
 		ebitmap_node_t *tnode;
 		unsigned int i;
 		struct cil_typeattribute *attr = (struct cil_typeattribute *)datum;
-		ebitmap_for_each_bit(attr->types, tnode, i) {
-			if (!ebitmap_get_bit(attr->types, i)) continue;
+		ebitmap_for_each_set_bit(attr->types, tnode, i) {
 			datum = DATUM(db->val_to_type[i]);
 			rc = __cil_get_sepol_type_datum(pdb, datum, &sepol_datum);
 			if (rc != SEPOL_OK) goto exit;
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 5edab5e0..48e8ba5c 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -342,9 +342,7 @@ static size_t __cil_userattribute_len(struct cil_db *db, struct cil_userattribut
 	unsigned int i;
 	size_t len = 0;
 
-	ebitmap_for_each_bit(attr->users, unode, i) {
-		if (!ebitmap_get_bit(attr->users, i))
-			continue;
+	ebitmap_for_each_set_bit(attr->users, unode, i) {
 		len += strlen(DATUM(db->val_to_user[i])->fqn);
 		len++;
 	}
@@ -454,9 +452,7 @@ static char *__cil_userattribute_to_string(struct cil_db *db, struct cil_useratt
 	char *str;
 	size_t len;
 
-	ebitmap_for_each_bit(attr->users, unode, i) {
-		if (!ebitmap_get_bit(attr->users, i))
-			continue;
+	ebitmap_for_each_set_bit(attr->users, unode, i) {
 		str = DATUM(db->val_to_user[i])->fqn;
 		len = strlen(str);
 		memcpy(new, str, len);
@@ -1118,9 +1114,7 @@ static void cil_xperms_to_policy(FILE *out, struct cil_permissionx *permx)
 
 	fprintf(out, "%s %s {", DATUM(permx->obj)->fqn, kind);
 
-	ebitmap_for_each_bit(permx->perms, node, i) {
-		if (!ebitmap_get_bit(permx->perms, i))
-			continue;
+	ebitmap_for_each_set_bit(permx->perms, node, i) {
 		if (need_first == CIL_TRUE) {
 			first = i;
 			need_first = CIL_FALSE;
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 0b09cecc..22046dc5 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1654,13 +1654,9 @@ static int __cil_post_db_roletype_helper(struct cil_tree_node *node, uint32_t *f
 			ebitmap_node_t *rnode;
 			unsigned int i;
 	
-			ebitmap_for_each_bit(attr->roles, rnode, i) {
+			ebitmap_for_each_set_bit(attr->roles, rnode, i) {
 				struct cil_role *role = NULL;
 
-				if (!ebitmap_get_bit(attr->roles, i)) {
-					continue;
-				}
-
 				role = db->val_to_role[i];
 
 				rc = __cil_role_assign_types(role, type_datum);
@@ -1751,11 +1747,7 @@ static int __cil_post_db_userrole_helper(struct cil_tree_node *node, uint32_t *f
 		if (user_node->flavor == CIL_USERATTRIBUTE) {
 			u_attr = userrole->user;
 
-			ebitmap_for_each_bit(u_attr->users, unode, i) {
-				if (!ebitmap_get_bit(u_attr->users, i)) {
-					continue;
-				}
-
+			ebitmap_for_each_set_bit(u_attr->users, unode, i) {
 				user = db->val_to_user[i];
 
 				rc = __cil_user_assign_roles(user, role_datum);
diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 94fb7efe..74d3e80b 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -76,6 +76,9 @@ static inline int ebitmap_node_get_bit(ebitmap_node_t * n, unsigned int bit)
 #define ebitmap_for_each_bit(e, n, bit) \
 	for (bit = ebitmap_start(e, &n); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
 
+#define ebitmap_for_each_set_bit(e, n, bit) \
+	ebitmap_for_each_bit(e, n, bit) if (ebitmap_node_get_bit(n, bit)) \
+
 extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index b08757bf..a734baab 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -157,12 +157,8 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	memcpy(&tmp_key, k, sizeof(avtab_key_t));
 	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
 
-	ebitmap_for_each_bit(sattr, snode, i) {
-		if (!ebitmap_node_get_bit(snode, i))
-			continue;
-		ebitmap_for_each_bit(tattr, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+	ebitmap_for_each_set_bit(sattr, snode, i) {
+		ebitmap_for_each_set_bit(tattr, tnode, j) {
 			tmp_key.source_type = i + 1;
 			tmp_key.target_type = j + 1;
 			for (node = avtab_search_node(avtab, &tmp_key);
@@ -270,13 +266,8 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 			continue;
 		}
 
-		ebitmap_for_each_bit(&src_matches, snode, i) {
-			if (!ebitmap_node_get_bit(snode, i))
-				continue;
-			ebitmap_for_each_bit(&tgt_matches, tnode, j) {
-				if (!ebitmap_node_get_bit(tnode, j))
-					continue;
-
+		ebitmap_for_each_set_bit(&src_matches, snode, i) {
+			ebitmap_for_each_set_bit(&tgt_matches, tnode, j) {
 				if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 					a->errors += report_assertion_extended_permissions(handle,p, avrule,
 											i, j, cp, perms, k, avtab);
@@ -345,12 +336,8 @@ static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t
 	memcpy(&tmp_key, k, sizeof(avtab_key_t));
 	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
 
-	ebitmap_for_each_bit(sattr, snode, i) {
-		if (!ebitmap_node_get_bit(snode, i))
-			continue;
-		ebitmap_for_each_bit(tattr, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+	ebitmap_for_each_set_bit(sattr, snode, i) {
+		ebitmap_for_each_set_bit(tattr, tnode, j) {
 			tmp_key.source_type = i + 1;
 			tmp_key.target_type = j + 1;
 			for (node = avtab_search_node(avtab, &tmp_key);
@@ -437,13 +424,8 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	for (cp = avrule->perms; cp; cp = cp->next) {
 		if (cp->tclass != k->target_class)
 			continue;
-		ebitmap_for_each_bit(&src_matches, snode, i) {
-			if (!ebitmap_node_get_bit(snode, i))
-				continue;
-			ebitmap_for_each_bit(&tgt_matches, tnode, j) {
-				if (!ebitmap_node_get_bit(tnode, j))
-					continue;
-
+		ebitmap_for_each_set_bit(&src_matches, snode, i) {
+			ebitmap_for_each_set_bit(&tgt_matches, tnode, j) {
 				ret = check_assertion_extended_permissions_avtab(
 						avrule, avtab, i, j, k, p);
 				if (ret)
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 312d137b..91b2d326 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -62,9 +62,7 @@ static int map_ebitmap(ebitmap_t * src, ebitmap_t * dst, uint32_t * map)
 	ebitmap_node_t *tnode;
 	ebitmap_init(dst);
 
-	ebitmap_for_each_bit(src, tnode, i) {
-		if (!ebitmap_node_get_bit(tnode, i))
-			continue;
+	ebitmap_for_each_set_bit(src, tnode, i) {
 		if (!map[i])
 			continue;
 		if (ebitmap_set_bit(dst, map[i] - 1, 1))
@@ -771,22 +769,20 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 	}
 	ebitmap_destroy(&mapped_roles);
 
-	ebitmap_for_each_bit(&role->roles, rnode, i) {
-		if (ebitmap_node_get_bit(rnode, i)) {
-			/* take advantage of sym_val_to_name[]
-			 * of the base module */
-			base_reg_role_id = state->base->p_role_val_to_name[i];
-			regular_role = (role_datum_t *)hashtab_search(
-						state->out->p_roles.table,
-						base_reg_role_id);
-			assert(regular_role != NULL && 
-			       regular_role->flavor == ROLE_ROLE);
-
-			if (ebitmap_union(&regular_role->types.types, 
-					  &new_role->types.types)) {
-				ERR(state->handle, "Out of memory!");
-				return -1;
-			}
+	ebitmap_for_each_set_bit(&role->roles, rnode, i) {
+		/* take advantage of sym_val_to_name[]
+		 * of the base module */
+		base_reg_role_id = state->base->p_role_val_to_name[i];
+		regular_role = (role_datum_t *)hashtab_search(
+					state->out->p_roles.table,
+					base_reg_role_id);
+		assert(regular_role != NULL && 
+		       regular_role->flavor == ROLE_ROLE);
+
+		if (ebitmap_union(&regular_role->types.types, 
+				  &new_role->types.types)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
 		}
 	}
 	
@@ -1244,12 +1240,8 @@ static int copy_role_allows(expand_state_t * state, role_allow_rule_t * rules)
 			return -1;
 		}
 
-		ebitmap_for_each_bit(&roles, snode, i) {
-			if (!ebitmap_node_get_bit(snode, i))
-				continue;
-			ebitmap_for_each_bit(&new_roles, tnode, j) {
-				if (!ebitmap_node_get_bit(tnode, j))
-					continue;
+		ebitmap_for_each_set_bit(&roles, snode, i) {
+			ebitmap_for_each_set_bit(&new_roles, tnode, j) {
 				/* check for duplicates */
 				cur_allow = state->out->role_allow;
 				while (cur_allow) {
@@ -1312,16 +1304,9 @@ static int copy_role_trans(expand_state_t * state, role_trans_rule_t * rules)
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
-		ebitmap_for_each_bit(&roles, rnode, i) {
-			if (!ebitmap_node_get_bit(rnode, i))
-				continue;
-			ebitmap_for_each_bit(&types, tnode, j) {
-				if (!ebitmap_node_get_bit(tnode, j))
-					continue;
-				ebitmap_for_each_bit(&cur->classes, cnode, k) {
-					if (!ebitmap_node_get_bit(cnode, k))
-						continue;
-
+		ebitmap_for_each_set_bit(&roles, rnode, i) {
+			ebitmap_for_each_set_bit(&types, tnode, j) {
+				ebitmap_for_each_set_bit(&cur->classes, cnode, k) {
 					cur_trans = state->out->role_tr;
 					while (cur_trans) {
 						unsigned int mapped_role;
@@ -1414,13 +1399,8 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
 
 		mapped_otype = state->typemap[cur_rule->otype - 1];
 
-		ebitmap_for_each_bit(&stypes, snode, i) {
-			if (!ebitmap_node_get_bit(snode, i))
-				continue;
-			ebitmap_for_each_bit(&ttypes, tnode, j) {
-				if (!ebitmap_node_get_bit(tnode, j))
-					continue;
-
+		ebitmap_for_each_set_bit(&stypes, snode, i) {
+			ebitmap_for_each_set_bit(&ttypes, tnode, j) {
 				key.stype = i + 1;
 				key.ttype = j + 1;
 				key.tclass = cur_rule->tclass;
@@ -1585,18 +1565,11 @@ static int expand_range_trans(expand_state_t * state,
 		}
 
 		/* loop on source type */
-		ebitmap_for_each_bit(&stypes, snode, i) {
-			if (!ebitmap_node_get_bit(snode, i))
-				continue;
+		ebitmap_for_each_set_bit(&stypes, snode, i) {
 			/* loop on target type */
-			ebitmap_for_each_bit(&ttypes, tnode, j) {
-				if (!ebitmap_node_get_bit(tnode, j))
-					continue;
+			ebitmap_for_each_set_bit(&ttypes, tnode, j) {
 				/* loop on target class */
-				ebitmap_for_each_bit(&rule->tclasses, cnode, k) {
-					if (!ebitmap_node_get_bit(cnode, k))
-						continue;
-
+				ebitmap_for_each_set_bit(&rule->tclasses, cnode, k) {
 					if (exp_rangetr_helper(i + 1,
 							       j + 1,
 							       k + 1,
@@ -1912,9 +1885,7 @@ static int expand_rule_helper(sepol_handle_t * handle,
 	int retval;
 	ebitmap_node_t *snode, *tnode;
 
-	ebitmap_for_each_bit(stypes, snode, i) {
-		if (!ebitmap_node_get_bit(snode, i))
-			continue;
+	ebitmap_for_each_set_bit(stypes, snode, i) {
 		if (source_rule->flags & RULE_SELF) {
 			if (source_rule->specified & (AVRULE_AV | AVRULE_XPERMS)) {
 				retval = expand_avrule_helper(handle, source_rule->specified,
@@ -1931,9 +1902,7 @@ static int expand_rule_helper(sepol_handle_t * handle,
 					return retval;
 			}
 		}
-		ebitmap_for_each_bit(ttypes, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+		ebitmap_for_each_set_bit(ttypes, tnode, j) {
 			if (source_rule->specified & (AVRULE_AV | AVRULE_XPERMS)) {
 				retval = expand_avrule_helper(handle, source_rule->specified,
 							      cond, i, j, source_rule->perms,
@@ -2362,9 +2331,7 @@ static int type_attr_map(hashtab_key_t key
 			if (ebitmap_cpy(&p->attr_type_map[value - 1], &type->types)) {
 				goto oom;
 			}
-			ebitmap_for_each_bit(&type->types, tnode, i) {
-				if (!ebitmap_node_get_bit(tnode, i))
-					continue;
+			ebitmap_for_each_set_bit(&type->types, tnode, i) {
 				if (ebitmap_set_bit(&p->type_attr_map[i], value - 1, 1)) {
 					goto oom;
 				}
@@ -2475,20 +2442,18 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t
 	
 	if (rolemap) {
 		assert(base != NULL);
-		ebitmap_for_each_bit(&x->roles, rnode, i) {
-			if (ebitmap_node_get_bit(rnode, i)) {
-				/* take advantage of p_role_val_to_struct[]
-				 * of the base module */
-				role = base->role_val_to_struct[i];
-				assert(role != NULL);
-				if (role->flavor == ROLE_ATTRIB) {
-					if (ebitmap_union(&roles,
-							  &role->roles))
-						goto bad;
-				} else {
-					if (ebitmap_set_bit(&roles, i, 1))
-						goto bad;
-				}
+		ebitmap_for_each_set_bit(&x->roles, rnode, i) {
+			/* take advantage of p_role_val_to_struct[]
+			 * of the base module */
+			role = base->role_val_to_struct[i];
+			assert(role != NULL);
+			if (role->flavor == ROLE_ATTRIB) {
+				if (ebitmap_union(&roles,
+						  &role->roles))
+					goto bad;
+			} else {
+				if (ebitmap_set_bit(&roles, i, 1))
+					goto bad;
 			}
 		}
 		if (map_ebitmap(&roles, &mapped_roles, rolemap))
@@ -2498,11 +2463,9 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t
 			goto bad;
 	}
 
-	ebitmap_for_each_bit(&mapped_roles, rnode, i) {
-		if (ebitmap_node_get_bit(rnode, i)) {
-			if (ebitmap_set_bit(r, i, 1))
-				goto bad;
-		}
+	ebitmap_for_each_set_bit(&mapped_roles, rnode, i) {
+		if (ebitmap_set_bit(r, i, 1))
+			goto bad;
 	}
 
 	ebitmap_destroy(&mapped_roles);
@@ -2549,10 +2512,7 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 	ebitmap_init(t);
 
 	/* First go through the types and OR all the attributes to types */
-	ebitmap_for_each_bit(&set->types, tnode, i) {
-		if (!ebitmap_node_get_bit(tnode, i))
-			continue;
-
+	ebitmap_for_each_set_bit(&set->types, tnode, i) {
 		/*
 		 * invalid policies might have more types set in the ebitmap than
 		 * what's available in the type_val_to_struct mapping
@@ -2580,19 +2540,17 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 
 	/* Now do the same thing for negset */
 	ebitmap_init(&neg_types);
-	ebitmap_for_each_bit(&set->negset, tnode, i) {
-		if (ebitmap_node_get_bit(tnode, i)) {
-			if (p->type_val_to_struct[i] &&
-			    p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
-				if (ebitmap_union
-				    (&neg_types,
-				     &p->type_val_to_struct[i]->types)) {
-					goto err_neg;
-				}
-			} else {
-				if (ebitmap_set_bit(&neg_types, i, 1)) {
-					goto err_neg;
-				}
+	ebitmap_for_each_set_bit(&set->negset, tnode, i) {
+		if (p->type_val_to_struct[i] &&
+		    p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
+			if (ebitmap_union
+			    (&neg_types,
+			     &p->type_val_to_struct[i]->types)) {
+				goto err_neg;
+			}
+		} else {
+			if (ebitmap_set_bit(&neg_types, i, 1)) {
+				goto err_neg;
 			}
 		}
 	}
@@ -2611,9 +2569,8 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 		goto out;
 	}
 
-	ebitmap_for_each_bit(&types, tnode, i) {
-		if (ebitmap_node_get_bit(tnode, i)
-		    && (!ebitmap_get_bit(&neg_types, i)))
+	ebitmap_for_each_set_bit(&types, tnode, i) {
+		if (!ebitmap_get_bit(&neg_types, i))
 			if (ebitmap_set_bit(t, i, 1))
 				goto err_neg;
 	}
@@ -3316,9 +3273,7 @@ static int expand_avtab_node(avtab_key_t * k, avtab_datum_t * d, void *args)
 	if (stype && stype->flavor != TYPE_ATTRIB) {
 		/* Source is an individual type, target is an attribute. */
 		newkey.source_type = k->source_type;
-		ebitmap_for_each_bit(tattr, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+		ebitmap_for_each_set_bit(tattr, tnode, j) {
 			newkey.target_type = j + 1;
 			rc = expand_avtab_insert(expa, &newkey, d);
 			if (rc)
@@ -3330,9 +3285,7 @@ static int expand_avtab_node(avtab_key_t * k, avtab_datum_t * d, void *args)
 	if (ttype && ttype->flavor != TYPE_ATTRIB) {
 		/* Target is an individual type, source is an attribute. */
 		newkey.target_type = k->target_type;
-		ebitmap_for_each_bit(sattr, snode, i) {
-			if (!ebitmap_node_get_bit(snode, i))
-				continue;
+		ebitmap_for_each_set_bit(sattr, snode, i) {
 			newkey.source_type = i + 1;
 			rc = expand_avtab_insert(expa, &newkey, d);
 			if (rc)
@@ -3342,12 +3295,8 @@ static int expand_avtab_node(avtab_key_t * k, avtab_datum_t * d, void *args)
 	}
 
 	/* Both source and target type are attributes. */
-	ebitmap_for_each_bit(sattr, snode, i) {
-		if (!ebitmap_node_get_bit(snode, i))
-			continue;
-		ebitmap_for_each_bit(tattr, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+	ebitmap_for_each_set_bit(sattr, snode, i) {
+		ebitmap_for_each_set_bit(tattr, tnode, j) {
 			newkey.source_type = i + 1;
 			newkey.target_type = j + 1;
 			rc = expand_avtab_insert(expa, &newkey, d);
@@ -3446,9 +3395,7 @@ int expand_cond_av_node(policydb_t * p,
 	if (stype && stype->flavor != TYPE_ATTRIB) {
 		/* Source is an individual type, target is an attribute. */
 		newkey.source_type = k->source_type;
-		ebitmap_for_each_bit(tattr, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+		ebitmap_for_each_set_bit(tattr, tnode, j) {
 			newkey.target_type = j + 1;
 			rc = expand_cond_insert(newl, expa, &newkey, d);
 			if (rc)
@@ -3460,9 +3407,7 @@ int expand_cond_av_node(policydb_t * p,
 	if (ttype && ttype->flavor != TYPE_ATTRIB) {
 		/* Target is an individual type, source is an attribute. */
 		newkey.target_type = k->target_type;
-		ebitmap_for_each_bit(sattr, snode, i) {
-			if (!ebitmap_node_get_bit(snode, i))
-				continue;
+		ebitmap_for_each_set_bit(sattr, snode, i) {
 			newkey.source_type = i + 1;
 			rc = expand_cond_insert(newl, expa, &newkey, d);
 			if (rc)
@@ -3472,12 +3417,8 @@ int expand_cond_av_node(policydb_t * p,
 	}
 
 	/* Both source and target type are attributes. */
-	ebitmap_for_each_bit(sattr, snode, i) {
-		if (!ebitmap_node_get_bit(snode, i))
-			continue;
-		ebitmap_for_each_bit(tattr, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+	ebitmap_for_each_set_bit(sattr, snode, i) {
+		ebitmap_for_each_set_bit(tattr, tnode, j) {
 			newkey.source_type = i + 1;
 			newkey.target_type = j + 1;
 			rc = expand_cond_insert(newl, expa, &newkey, d);
diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
index 9bea83fd..072af5b3 100644
--- a/libsepol/src/genusers.c
+++ b/libsepol/src/genusers.c
@@ -169,15 +169,14 @@ static int load_users(struct policydb *policydb, const char *path)
 				continue;
 			}
 			/* Set the role and every role it dominates */
-			ebitmap_for_each_bit(&roldatum->dominates, rnode, bit) {
-				if (ebitmap_node_get_bit(rnode, bit))
-					if (ebitmap_set_bit
-					    (&usrdatum->roles.roles, bit, 1)) {
-						ERR(NULL, "out of memory");
-						free(buffer);
-						fclose(fp);
-						return -1;
-					}
+			ebitmap_for_each_set_bit(&roldatum->dominates, rnode, bit) {
+				if (ebitmap_set_bit
+				    (&usrdatum->roles.roles, bit, 1)) {
+					ERR(NULL, "out of memory");
+					free(buffer);
+					fclose(fp);
+					return -1;
+				}
 			}
 		} while (islist);
 		if (oldc == 0)
diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
index 778541a2..797b717c 100644
--- a/libsepol/src/hierarchy.c
+++ b/libsepol/src/hierarchy.c
@@ -111,9 +111,7 @@ static int bounds_expand_rule(sepol_handle_t *handle, policydb_t *p,
 
 	if (ebitmap_get_bit(&p->attr_type_map[src - 1], parent - 1)) {
 		avtab_key.source_type = parent;
-		ebitmap_for_each_bit(&p->attr_type_map[tgt - 1], tnode, i) {
-			if (!ebitmap_node_get_bit(tnode, i))
-				continue;
+		ebitmap_for_each_set_bit(&p->attr_type_map[tgt - 1], tnode, i) {
 			avtab_key.target_type = i + 1;
 			rc = bounds_insert_rule(handle, avtab, global, other,
 						&avtab_key, &datum);
@@ -298,9 +296,7 @@ static int bounds_check_rule(sepol_handle_t *handle, policydb_t *p,
 
 	if (ebitmap_get_bit(&p->attr_type_map[src - 1], child - 1)) {
 		avtab_key.source_type = parent;
-		ebitmap_for_each_bit(&p->attr_type_map[tgt - 1], tnode, i) {
-			if (!ebitmap_node_get_bit(tnode, i))
-				continue;
+		ebitmap_for_each_set_bit(&p->attr_type_map[tgt - 1], tnode, i) {
 			td = p->type_val_to_struct[i];
 			if (td && td->bounds) {
 				avtab_key.target_type = td->bounds;
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 48b571a5..48cb17f2 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -993,10 +993,7 @@ static size_t cats_ebitmap_len(struct ebitmap *cats, char **val_to_name)
 	size_t len = 0;
 
 	range = 0;
-	ebitmap_for_each_bit(cats, node, i) {
-		if (!ebitmap_get_bit(cats, i))
-			continue;
-
+	ebitmap_for_each_set_bit(cats, node, i) {
 		if (range == 0)
 			start = i;
 
@@ -1044,10 +1041,7 @@ static char *cats_ebitmap_to_str(struct ebitmap *cats, char **val_to_name)
 	remaining--;;
 
 	range = 0;
-	ebitmap_for_each_bit(cats, node, i) {
-		if (!ebitmap_get_bit(cats, i))
-			continue;
-
+	ebitmap_for_each_set_bit(cats, node, i) {
 		if (range == 0)
 			start = i;
 
@@ -1164,9 +1158,7 @@ static int write_polcap_rules_to_cil(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
-	ebitmap_for_each_bit(&pdb->policycaps, node, i) {
-		if (!ebitmap_get_bit(&pdb->policycaps, i)) continue;
-
+	ebitmap_for_each_set_bit(&pdb->policycaps, node, i) {
 		name = sepol_polcap_getname(i);
 		if (name == NULL) {
 			sepol_log_err("Unknown policy capability id: %i", i);
@@ -1545,8 +1537,7 @@ static int write_type_permissive_rules_to_cil(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
-	ebitmap_for_each_bit(&pdb->permissive_map, node, i) {
-		if (!ebitmap_get_bit(&pdb->permissive_map, i)) continue;
+	ebitmap_for_each_set_bit(&pdb->permissive_map, node, i) {
 		rc = strs_add(strs, pdb->p_type_val_to_name[i-1]);
 		if (rc != 0) {
 			goto exit;
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 891e139c..6938c987 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -360,9 +360,7 @@ int ebitmap_to_strs(struct ebitmap *map, struct strs *strs, char **val_to_name)
 	uint32_t i;
 	int rc;
 
-	ebitmap_for_each_bit(map, node, i) {
-		if (!ebitmap_get_bit(map, i)) continue;
-
+	ebitmap_for_each_set_bit(map, node, i) {
 		rc = strs_add(strs, val_to_name[i]);
 		if (rc != 0) {
 			return -1;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index afadca6b..4d83178a 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -978,10 +978,7 @@ static size_t cats_ebitmap_len(struct ebitmap *cats, char **val_to_name)
 	size_t len = 0;
 
 	range = 0;
-	ebitmap_for_each_bit(cats, node, i) {
-		if (!ebitmap_get_bit(cats, i))
-			continue;
-
+	ebitmap_for_each_set_bit(cats, node, i) {
 		if (range == 0)
 			start = i;
 
@@ -1020,10 +1017,7 @@ static char *cats_ebitmap_to_str(struct ebitmap *cats, char **val_to_name)
 
 	first = 1;
 	range = 0;
-	ebitmap_for_each_bit(cats, node, i) {
-		if (!ebitmap_get_bit(cats, i))
-			continue;
-
+	ebitmap_for_each_set_bit(cats, node, i) {
 		if (range == 0)
 			start = i;
 
@@ -1138,9 +1132,7 @@ static int write_polcap_rules_to_conf(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
-	ebitmap_for_each_bit(&pdb->policycaps, node, i) {
-		if (!ebitmap_get_bit(&pdb->policycaps, i)) continue;
-
+	ebitmap_for_each_set_bit(&pdb->policycaps, node, i) {
 		name = sepol_polcap_getname(i);
 		if (name == NULL) {
 			sepol_log_err("Unknown policy capability id: %i", i);
@@ -1590,8 +1582,7 @@ static int write_type_permissive_rules_to_conf(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
-	ebitmap_for_each_bit(&pdb->permissive_map, node, i) {
-		if (!ebitmap_get_bit(&pdb->permissive_map, i)) continue;
+	ebitmap_for_each_set_bit(&pdb->permissive_map, node, i) {
 		rc = strs_add(strs, pdb->p_type_val_to_name[i-1]);
 		if (rc != 0) {
 			goto exit;
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 3f1d610b..6e298b7b 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -962,22 +962,18 @@ static int type_set_convert(type_set_t * types, type_set_t * dst,
 {
 	unsigned int i;
 	ebitmap_node_t *tnode;
-	ebitmap_for_each_bit(&types->types, tnode, i) {
-		if (ebitmap_node_get_bit(tnode, i)) {
-			assert(mod->map[SYM_TYPES][i]);
-			if (ebitmap_set_bit
-			    (&dst->types, mod->map[SYM_TYPES][i] - 1, 1)) {
-				goto cleanup;
-			}
+	ebitmap_for_each_set_bit(&types->types, tnode, i) {
+		assert(mod->map[SYM_TYPES][i]);
+		if (ebitmap_set_bit
+		    (&dst->types, mod->map[SYM_TYPES][i] - 1, 1)) {
+			goto cleanup;
 		}
 	}
-	ebitmap_for_each_bit(&types->negset, tnode, i) {
-		if (ebitmap_node_get_bit(tnode, i)) {
-			assert(mod->map[SYM_TYPES][i]);
-			if (ebitmap_set_bit
-			    (&dst->negset, mod->map[SYM_TYPES][i] - 1, 1)) {
-				goto cleanup;
-			}
+	ebitmap_for_each_set_bit(&types->negset, tnode, i) {
+		assert(mod->map[SYM_TYPES][i]);
+		if (ebitmap_set_bit
+		    (&dst->negset, mod->map[SYM_TYPES][i] - 1, 1)) {
+			goto cleanup;
 		}
 	}
 	dst->flags = types->flags;
@@ -1019,13 +1015,11 @@ static int role_set_or_convert(role_set_t * roles, role_set_t * dst,
 	ebitmap_node_t *rnode;
 
 	ebitmap_init(&tmp);
-	ebitmap_for_each_bit(&roles->roles, rnode, i) {
-		if (ebitmap_node_get_bit(rnode, i)) {
-			assert(mod->map[SYM_ROLES][i]);
-			if (ebitmap_set_bit
-			    (&tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
-				goto cleanup;
-			}
+	ebitmap_for_each_set_bit(&roles->roles, rnode, i) {
+		assert(mod->map[SYM_ROLES][i]);
+		if (ebitmap_set_bit
+		    (&tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
+			goto cleanup;
 		}
 	}
 	if (ebitmap_union(&dst->roles, &tmp)) {
@@ -1115,13 +1109,11 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 	}
 
 	ebitmap_init(&e_tmp);
-	ebitmap_for_each_bit(&role->dominates, rnode, i) {
-		if (ebitmap_node_get_bit(rnode, i)) {
-			assert(mod->map[SYM_ROLES][i]);
-			if (ebitmap_set_bit
-			    (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
-				goto cleanup;
-			}
+	ebitmap_for_each_set_bit(&role->dominates, rnode, i) {
+		assert(mod->map[SYM_ROLES][i]);
+		if (ebitmap_set_bit
+		    (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
+			goto cleanup;
 		}
 	}
 	if (ebitmap_union(&dest_role->dominates, &e_tmp)) {
@@ -1134,13 +1126,11 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 	
 	if (role->flavor == ROLE_ATTRIB) {
 		ebitmap_init(&e_tmp);
-		ebitmap_for_each_bit(&role->roles, rnode, i) {
-			if (ebitmap_node_get_bit(rnode, i)) {
-				assert(mod->map[SYM_ROLES][i]);
-				if (ebitmap_set_bit
-				    (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
-					goto cleanup;
-				}
+		ebitmap_for_each_set_bit(&role->roles, rnode, i) {
+			assert(mod->map[SYM_ROLES][i]);
+			if (ebitmap_set_bit
+			    (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
+				goto cleanup;
 			}
 		}
 		if (ebitmap_union(&dest_role->roles, &e_tmp)) {
@@ -1189,13 +1179,11 @@ static int type_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 	}
 
 	ebitmap_init(&e_tmp);
-	ebitmap_for_each_bit(&type->types, tnode, i) {
-		if (ebitmap_node_get_bit(tnode, i)) {
-			assert(mod->map[SYM_TYPES][i]);
-			if (ebitmap_set_bit
-			    (&e_tmp, mod->map[SYM_TYPES][i] - 1, 1)) {
-				goto cleanup;
-			}
+	ebitmap_for_each_set_bit(&type->types, tnode, i) {
+		assert(mod->map[SYM_TYPES][i]);
+		if (ebitmap_set_bit
+		    (&e_tmp, mod->map[SYM_TYPES][i] - 1, 1)) {
+			goto cleanup;
 		}
 	}
 	if (ebitmap_union(&new_type->types, &e_tmp)) {
@@ -1388,15 +1376,13 @@ static int copy_role_trans_list(role_trans_rule_t * list,
 			goto cleanup;
 		}
 
-		ebitmap_for_each_bit(&cur->classes, cnode, i) {
-			if (ebitmap_node_get_bit(cnode, i)) {
-				assert(module->map[SYM_CLASSES][i]);
-				if (ebitmap_set_bit(&new_rule->classes,
-						    module->
-						    map[SYM_CLASSES][i] - 1,
-						    1)) {
-					goto cleanup;
-				}
+		ebitmap_for_each_set_bit(&cur->classes, cnode, i) {
+			assert(module->map[SYM_CLASSES][i]);
+			if (ebitmap_set_bit(&new_rule->classes,
+					    module->
+					    map[SYM_CLASSES][i] - 1,
+					    1)) {
+				goto cleanup;
 			}
 		}
 
@@ -1530,14 +1516,12 @@ static int copy_range_trans_list(range_trans_rule_t * rules,
 				     mod, state))
 			goto cleanup;
 
-		ebitmap_for_each_bit(&rule->tclasses, cnode, i) {
-			if (ebitmap_node_get_bit(cnode, i)) {
-				assert(mod->map[SYM_CLASSES][i]);
-				if (ebitmap_set_bit
-				    (&new_rule->tclasses,
-				     mod->map[SYM_CLASSES][i] - 1, 1)) {
-					goto cleanup;
-				}
+		ebitmap_for_each_set_bit(&rule->tclasses, cnode, i) {
+			assert(mod->map[SYM_CLASSES][i]);
+			if (ebitmap_set_bit
+			    (&new_rule->tclasses,
+			     mod->map[SYM_CLASSES][i] - 1, 1)) {
+				goto cleanup;
 			}
 		}
 
@@ -1678,20 +1662,18 @@ static int copy_scope_index(scope_index_t * src, scope_index_t * dest,
 		if (copy_callback_f[i] == NULL) {
 			continue;
 		}
-		ebitmap_for_each_bit(srcmap, node, j) {
-			if (ebitmap_node_get_bit(node, j)) {
-				assert(module->map[i][j] != 0);
-				if (ebitmap_set_bit
-				    (destmap, module->map[i][j] - 1, 1) != 0) {
+		ebitmap_for_each_set_bit(srcmap, node, j) {
+			assert(module->map[i][j] != 0);
+			if (ebitmap_set_bit
+			    (destmap, module->map[i][j] - 1, 1) != 0) {
 
-					goto cleanup;
-				}
-				if (i == SYM_CLASSES &&
-				    largest_mapped_class_value <
-				    module->map[SYM_CLASSES][j]) {
-					largest_mapped_class_value =
-					    module->map[SYM_CLASSES][j];
-				}
+				goto cleanup;
+			}
+			if (i == SYM_CLASSES &&
+			    largest_mapped_class_value <
+			    module->map[SYM_CLASSES][j]) {
+				largest_mapped_class_value =
+				    module->map[SYM_CLASSES][j];
 			}
 		}
 	}
@@ -1710,9 +1692,8 @@ static int copy_scope_index(scope_index_t * src, scope_index_t * dest,
 		ebitmap_t *srcmap = src->class_perms_map + i;
 		ebitmap_t *destmap =
 		    dest->class_perms_map + module->map[SYM_CLASSES][i] - 1;
-		ebitmap_for_each_bit(srcmap, node, j) {
-			if (ebitmap_node_get_bit(node, j) &&
-			    ebitmap_set_bit(destmap, module->perm_map[i][j] - 1,
+		ebitmap_for_each_set_bit(srcmap, node, j) {
+			if (ebitmap_set_bit(destmap, module->perm_map[i][j] - 1,
 					    1)) {
 				goto cleanup;
 			}
@@ -2012,11 +1993,7 @@ static int is_decl_requires_met(link_state_t * state,
 			continue;
 		}
 		bitmap = &decl->required.scope[i];
-		ebitmap_for_each_bit(bitmap, node, j) {
-			if (!ebitmap_node_get_bit(node, j)) {
-				continue;
-			}
-
+		ebitmap_for_each_set_bit(bitmap, node, j) {
 			/* check base's scope table */
 			id = pol->sym_val_to_name[i][j];
 			if (!is_id_enabled(id, state->base, i)) {
@@ -2033,16 +2010,13 @@ static int is_decl_requires_met(link_state_t * state,
 	for (i = 0; i < decl->required.class_perms_len; i++) {
 
 		bitmap = decl->required.class_perms_map + i;
-		ebitmap_for_each_bit(bitmap, node, j) {
+		ebitmap_for_each_set_bit(bitmap, node, j) {
 			struct find_perm_arg fparg;
 			class_datum_t *cladatum;
 			uint32_t perm_value = j + 1;
 			int rc;
 			scope_datum_t *scope;
 
-			if (!ebitmap_node_get_bit(node, j)) {
-				continue;
-			}
 			id = pol->p_class_val_to_name[i];
 			cladatum = pol->class_val_to_struct[i];
 
@@ -2439,32 +2413,30 @@ static int expand_role_attributes(hashtab_key_t key, hashtab_datum_t datum,
 		INFO(state->handle, "expanding role attribute %s", id);
 
 restart:
-	ebitmap_for_each_bit(&role->roles, rnode, i) {
-		if (ebitmap_node_get_bit(rnode, i)) {
-			sub_attr = state->base->role_val_to_struct[i];
-			if (sub_attr->flavor != ROLE_ATTRIB)
-				continue;
-			
-			/* remove the sub role attribute from the parent
-			 * role attribute's roles ebitmap */
-			if (ebitmap_set_bit(&role->roles, i, 0))
-				return -1;
+	ebitmap_for_each_set_bit(&role->roles, rnode, i) {
+		sub_attr = state->base->role_val_to_struct[i];
+		if (sub_attr->flavor != ROLE_ATTRIB)
+			continue;
+		
+		/* remove the sub role attribute from the parent
+		 * role attribute's roles ebitmap */
+		if (ebitmap_set_bit(&role->roles, i, 0))
+			return -1;
 
-			/* loop dependency of role attributes */
-			if (sub_attr->s.value == role->s.value)
-				continue;
+		/* loop dependency of role attributes */
+		if (sub_attr->s.value == role->s.value)
+			continue;
 
-			/* now go on to expand a sub role attribute
-			 * by escalating its roles ebitmap */
-			if (ebitmap_union(&role->roles, &sub_attr->roles)) {
-				ERR(state->handle, "Out of memory!");
-				return -1;
-			}
-			
-			/* sub_attr->roles may contain other role attributes,
-			 * re-scan the parent role attribute's roles ebitmap */
-			goto restart;
+		/* now go on to expand a sub role attribute
+		 * by escalating its roles ebitmap */
+		if (ebitmap_union(&role->roles, &sub_attr->roles)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
 		}
+		
+		/* sub_attr->roles may contain other role attributes,
+		 * re-scan the parent role attribute's roles ebitmap */
+		goto restart;
 	}
 
 	return 0;
diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index bf1fdbd5..e4d722f3 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -289,17 +289,15 @@ int mls_context_isvalid(const policydb_t * p, const context_struct_t * c)
 		if (!levdatum)
 			return 0;
 
-		ebitmap_for_each_bit(&c->range.level[l].cat, cnode, i) {
-			if (ebitmap_node_get_bit(cnode, i)) {
-				if (i > p->p_cats.nprim)
-					return 0;
-				if (!ebitmap_get_bit(&levdatum->level->cat, i))
-					/*
-					 * Category may not be associated with
-					 * sensitivity in low level.
-					 */
-					return 0;
-			}
+		ebitmap_for_each_set_bit(&c->range.level[l].cat, cnode, i) {
+			if (i > p->p_cats.nprim)
+				return 0;
+			if (!ebitmap_get_bit(&levdatum->level->cat, i))
+				/*
+				 * Category may not be associated with
+				 * sensitivity in low level.
+				 */
+				return 0;
 		}
 	}
 
@@ -579,23 +577,21 @@ int mls_convert_context(policydb_t * oldp,
 		c->range.level[l].sens = levdatum->level->sens;
 
 		ebitmap_init(&bitmap);
-		ebitmap_for_each_bit(&c->range.level[l].cat, cnode, i) {
-			if (ebitmap_node_get_bit(cnode, i)) {
-				int rc;
+		ebitmap_for_each_set_bit(&c->range.level[l].cat, cnode, i) {
+			int rc;
 
-				catdatum =
-				    (cat_datum_t *) hashtab_search(newp->p_cats.
-								   table,
-								   oldp->
-								   p_cat_val_to_name
-								   [i]);
-				if (!catdatum)
-					return -EINVAL;
-				rc = ebitmap_set_bit(&bitmap,
-						     catdatum->s.value - 1, 1);
-				if (rc)
-					return rc;
-			}
+			catdatum =
+			    (cat_datum_t *) hashtab_search(newp->p_cats.
+							   table,
+							   oldp->
+							   p_cat_val_to_name
+							   [i]);
+			if (!catdatum)
+				return -EINVAL;
+			rc = ebitmap_set_bit(&bitmap,
+					     catdatum->s.value - 1, 1);
+			if (rc)
+				return rc;
 		}
 		ebitmap_destroy(&c->range.level[l].cat);
 		c->range.level[l].cat = bitmap;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index f04589ed..7458085d 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -732,10 +732,7 @@ static int ebitmap_to_cil(struct policydb *pdb, struct ebitmap *map, int type)
 	uint32_t i;
 	char **val_to_name = pdb->sym_val_to_name[type];
 
-	ebitmap_for_each_bit(map, node, i) {
-		if (!ebitmap_get_bit(map, i)) {
-			continue;
-		}
+	ebitmap_for_each_set_bit(map, node, i) {
 		cil_printf("%s ", val_to_name[i]);
 	}
 
@@ -862,10 +859,7 @@ static int cil_print_attr_strs(int indent, struct policydb *pdb, int is_type, vo
 
 	if (has_positive) {
 		cil_printf("(");
-		ebitmap_for_each_bit(pos, node, i) {
-			if (!ebitmap_get_bit(pos, i)) {
-				continue;
-			}
+		ebitmap_for_each_set_bit(pos, node, i) {
 			cil_printf("%s ", val_to_name[i]);
 		}
 		cil_printf(") ");
@@ -874,10 +868,7 @@ static int cil_print_attr_strs(int indent, struct policydb *pdb, int is_type, vo
 	if (has_negative) {
 		cil_printf("(not (");
 
-		ebitmap_for_each_bit(neg, node, i) {
-			if (!ebitmap_get_bit(neg, i)) {
-				continue;
-			}
+		ebitmap_for_each_set_bit(neg, node, i) {
 			cil_printf("%s ", val_to_name[i]);
 		}
 
@@ -999,15 +990,13 @@ static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, char ***n
 	char **name_arr;
 
 	num = 0;
-	ebitmap_for_each_bit(map, node, i) {
-		if (ebitmap_get_bit(map, i)) {
-			if (num >= UINT32_MAX / sizeof(*name_arr)) {
-				log_err("Overflow");
-				rc = -1;
-				goto exit;
-			}
-			num++;
+	ebitmap_for_each_set_bit(map, node, i) {
+		if (num >= UINT32_MAX / sizeof(*name_arr)) {
+			log_err("Overflow");
+			rc = -1;
+			goto exit;
 		}
+		num++;
 	}
 
 	if (!num) {
@@ -1024,11 +1013,9 @@ static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, char ***n
 	}
 
 	num = 0;
-	ebitmap_for_each_bit(map, node, i) {
-		if (ebitmap_get_bit(map, i)) {
-			name_arr[num] = vals_to_names[i];
-			num++;
-		}
+	ebitmap_for_each_set_bit(map, node, i) {
+		name_arr[num] = vals_to_names[i];
+		num++;
 	}
 
 	*names = name_arr;
@@ -1469,10 +1456,7 @@ static int role_trans_to_cil(int indent, struct policydb *pdb, struct role_trans
 
 		for (role = 0; role < num_role_names; role++) {
 			for (type = 0; type < num_type_names; type++) {
-				ebitmap_for_each_bit(&rule->classes, node, i) {
-					if (!ebitmap_get_bit(&rule->classes, i)) {
-						continue;
-					}
+				ebitmap_for_each_set_bit(&rule->classes, node, i) {
 					cil_println(indent, "(roletransition %s %s %s %s)",
 						    role_names[role], type_names[type],
 						    pdb->p_class_val_to_name[i],
@@ -1568,11 +1552,7 @@ static int range_trans_to_cil(int indent, struct policydb *pdb, struct range_tra
 
 		for (stype = 0; stype < num_stypes; stype++) {
 			for (ttype = 0; ttype < num_ttypes; ttype++) {
-				ebitmap_for_each_bit(&rule->tclasses, node, i) {
-					if (!ebitmap_get_bit(&rule->tclasses, i)) {
-						continue;
-					}
-
+				ebitmap_for_each_set_bit(&rule->tclasses, node, i) {
 					cil_indent(indent);
 					cil_printf("(rangetransition %s %s %s ", stypes[stype], ttypes[ttype], pdb->p_class_val_to_name[i]);
 
@@ -2094,10 +2074,7 @@ static int class_order_to_cil(int indent, struct policydb *pdb, struct ebitmap o
 	cil_indent(indent);
 	cil_printf("(classorder (");
 
-	ebitmap_for_each_bit(&order, node, i) {
-		if (!ebitmap_get_bit(&order, i)) {
-			continue;
-		}
+	ebitmap_for_each_set_bit(&order, node, i) {
 		cil_printf("%s ", pdb->sym_val_to_name[SYM_CLASSES][i]);
 	}
 
@@ -2199,10 +2176,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 		if (ebitmap_cardinality(&role->roles) > 0) {
 			cil_indent(indent);
 			cil_printf("(roleattributeset %s (", key);
-			ebitmap_for_each_bit(&role->roles, node, i) {
-				if (!ebitmap_get_bit(&role->roles, i)) {
-					continue;
-				}
+			ebitmap_for_each_set_bit(&role->roles, node, i) {
 				cil_printf("%s ", pdb->p_role_val_to_name[i]);
 			}
 			cil_printf("))\n");
@@ -2331,10 +2305,7 @@ static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *bl
 		cil_println(indent, "(userrole %s " DEFAULT_OBJECT ")", key);
 	}
 
-	ebitmap_for_each_bit(&roles, node, i) {
-		if (!ebitmap_get_bit(&roles, i)) {
-			continue;
-		}
+	ebitmap_for_each_set_bit(&roles, node, i) {
 		cil_println(indent, "(userrole %s %s)", key, pdb->p_role_val_to_name[i]);
 	}
 
@@ -2421,10 +2392,7 @@ static int sens_order_to_cil(int indent, struct policydb *pdb, struct ebitmap or
 	cil_indent(indent);
 	cil_printf("(sensitivityorder (");
 
-	ebitmap_for_each_bit(&order, node, i) {
-		if (!ebitmap_get_bit(&order, i)) {
-			continue;
-		}
+	ebitmap_for_each_set_bit(&order, node, i) {
 		cil_printf("%s ", pdb->p_sens_val_to_name[i]);
 	}
 
@@ -2465,10 +2433,7 @@ static int cat_order_to_cil(int indent, struct policydb *pdb, struct ebitmap ord
 	cil_indent(indent);
 	cil_printf("(categoryorder (");
 
-	ebitmap_for_each_bit(&order, node, i) {
-		if (!ebitmap_get_bit(&order, i)) {
-			continue;
-		}
+	ebitmap_for_each_set_bit(&order, node, i) {
 		cil_printf("%s ", pdb->p_cat_val_to_name[i]);
 	}
 
@@ -2489,10 +2454,7 @@ static int polcaps_to_cil(struct policydb *pdb)
 
 	map = &pdb->policycaps;
 
-	ebitmap_for_each_bit(map, node, i) {
-		if (!ebitmap_get_bit(map, i)) {
-			continue;
-		}
+	ebitmap_for_each_set_bit(map, node, i) {
 		name = sepol_polcap_getname(i);
 		if (name == NULL) {
 			log_err("Unknown policy capability id: %i", i);
@@ -3427,10 +3389,7 @@ static int declared_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 		}
 
 		map = decl->declared.scope[sym];
-		ebitmap_for_each_bit(&map, node, i) {
-			if (!ebitmap_get_bit(&map, i)) {
-				continue;
-			}
+		ebitmap_for_each_set_bit(&map, node, i) {
 			key = pdb->sym_val_to_name[sym][i];
 			datum = hashtab_search(pdb->symtab[sym].table, key);
 			if (datum == NULL) {
@@ -3494,10 +3453,7 @@ static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 		}
 
 		map = decl->required.scope[sym];
-		ebitmap_for_each_bit(&map, node, i) {
-			if (!ebitmap_get_bit(&map, i)) {
-				continue;
-			}
+		ebitmap_for_each_set_bit(&map, node, i) {
 			key = pdb->sym_val_to_name[sym][i];
 
 			scope_datum = hashtab_search(pdb->scope[sym].table, key);
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 96176d80..775d4b0a 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4245,10 +4245,9 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			if (r_policyvers >= POLICYDB_VERSION_AVTAB) {
 				if (ebitmap_read(&p->type_attr_map[i], fp))
 					goto bad;
-				ebitmap_for_each_bit(&p->type_attr_map[i],
-						     tnode, j) {
-					if (!ebitmap_node_get_bit(tnode, j)
-					    || i == j)
+				ebitmap_for_each_set_bit(&p->type_attr_map[i],
+							 tnode, j) {
+					if (i == j)
 						continue;
 
 					if (j >= p->p_types.nprim)
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index d40793e3..966d1ff3 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -933,12 +933,8 @@ static int context_struct_compute_av(context_struct_t * scontext,
 	avkey.specified = AVTAB_AV;
 	sattr = &policydb->type_attr_map[scontext->type - 1];
 	tattr = &policydb->type_attr_map[tcontext->type - 1];
-	ebitmap_for_each_bit(sattr, snode, i) {
-		if (!ebitmap_node_get_bit(snode, i))
-			continue;
-		ebitmap_for_each_bit(tattr, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+	ebitmap_for_each_set_bit(sattr, snode, i) {
+		ebitmap_for_each_set_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;
 			avkey.target_type = j + 1;
 			for (node =
@@ -2194,14 +2190,10 @@ int hidden sepol_get_user_sids(sepol_security_id_t fromsid,
 	}
 	memset(mysids, 0, maxnel * sizeof(sepol_security_id_t));
 
-	ebitmap_for_each_bit(&user->roles.roles, rnode, i) {
-		if (!ebitmap_node_get_bit(rnode, i))
-			continue;
+	ebitmap_for_each_set_bit(&user->roles.roles, rnode, i) {
 		role = policydb->role_val_to_struct[i];
 		usercon.role = i + 1;
-		ebitmap_for_each_bit(&role->types.types, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+		ebitmap_for_each_set_bit(&role->types.types, tnode, j) {
 			usercon.type = j + 1;
 			if (usercon.type == fromcon->type)
 				continue;
diff --git a/libsepol/src/users.c b/libsepol/src/users.c
index 1929399b..1a10076d 100644
--- a/libsepol/src/users.c
+++ b/libsepol/src/users.c
@@ -37,12 +37,10 @@ static int user_to_record(sepol_handle_t * handle,
 		goto err;
 
 	/* Extract roles */
-	ebitmap_for_each_bit(roles, rnode, bit) {
-		if (ebitmap_node_get_bit(rnode, bit)) {
-			char *role = policydb->p_role_val_to_name[bit];
-			if (sepol_user_add_role(handle, tmp_record, role) < 0)
-				goto err;
-		}
+	ebitmap_for_each_set_bit(roles, rnode, bit) {
+		char *role = policydb->p_role_val_to_name[bit];
+		if (sepol_user_add_role(handle, tmp_record, role) < 0)
+			goto err;
 	}
 
 	/* Extract MLS info */
@@ -170,12 +168,9 @@ int sepol_user_modify(sepol_handle_t * handle,
 		}
 
 		/* Set the role and every role it dominates */
-		ebitmap_for_each_bit(&roldatum->dominates, rnode, bit) {
-			if (ebitmap_node_get_bit(rnode, bit)) {
-				if (ebitmap_set_bit
-				    (&(usrdatum->roles.roles), bit, 1))
-					goto omem;
-			}
+		ebitmap_for_each_set_bit(&roldatum->dominates, rnode, bit) {
+			if (ebitmap_set_bit(&(usrdatum->roles.roles), bit, 1))
+				goto omem;
 		}
 	}
 
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 1fb30957..3f9ce09a 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1759,9 +1759,8 @@ static int only_process(ebitmap_t *in)
 	unsigned int i;
 	ebitmap_node_t *node;
 
-	ebitmap_for_each_bit(in, node, i) {
-		if (ebitmap_node_get_bit(node, i) &&
-		    i != SECCLASS_PROCESS - 1)
+	ebitmap_for_each_set_bit(in, node, i) {
+		if (i != SECCLASS_PROCESS - 1)
 			return 0;
 	}
 	return 1;
@@ -2183,13 +2182,11 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 	    p->policy_type == POLICY_KERN) {
 		ebitmap_node_t *tnode;
 
-		ebitmap_for_each_bit(&p->permissive_map, tnode, i) {
-			if (ebitmap_node_get_bit(tnode, i)) {
-				WARN(fp->handle, "Warning! Policy version %d cannot "
-				     "support permissive types, but some were defined",
-				     p->policyvers);
-				break;
-			}
+		ebitmap_for_each_set_bit(&p->permissive_map, tnode, i) {
+			WARN(fp->handle, "Warning! Policy version %d cannot "
+			     "support permissive types, but some were defined",
+			     p->policyvers);
+			break;
 		}
 	}
 
diff --git a/libsepol/tests/test-common.c b/libsepol/tests/test-common.c
index 81074031..d61bc0da 100644
--- a/libsepol/tests/test-common.c
+++ b/libsepol/tests/test-common.c
@@ -197,20 +197,19 @@ role_datum_t *test_role_type_set(policydb_t * p, const char *id, avrule_decl_t *
 
 	CU_ASSERT_FATAL(role != NULL);
 
-	ebitmap_for_each_bit(&role->types.types, tnode, i) {
-		if (ebitmap_node_get_bit(tnode, i)) {
-			new = 0;
-			for (j = 0; j < len; j++) {
-				if (strcmp(p->sym_val_to_name[SYM_TYPES][i], types[j]) == 0) {
-					found++;
-					new = 1;
-				}
-			}
-			if (new == 0) {
-				printf("\nRole %s had type %s not in types array\n", id, p->sym_val_to_name[SYM_TYPES][i]);
+	ebitmap_for_each_set_bit(&role->types.types, tnode, i) {
+		new = 0;
+		for (j = 0; j < len; j++) {
+			if (strcmp(p->sym_val_to_name[SYM_TYPES][i], types[j]) == 0) {
+				found++;
+				new = 1;
 			}
-			CU_ASSERT(new == 1);
 		}
+		if (new == 0) {
+			printf("\nRole %s had type %s not in types array\n",
+			       id, p->sym_val_to_name[SYM_TYPES][i]);
+		}
+		CU_ASSERT(new == 1);
 	}
 	CU_ASSERT(found == len);
 	if (found != len)
@@ -240,20 +239,19 @@ void test_attr_types(policydb_t * p, const char *id, avrule_decl_t * decl, const
 	CU_ASSERT(attr->flavor == TYPE_ATTRIB);
 	CU_ASSERT(attr->primary == 1);
 
-	ebitmap_for_each_bit(&attr->types, tnode, i) {
-		if (ebitmap_node_get_bit(tnode, i)) {
-			new = 0;
-			for (j = 0; j < len; j++) {
-				if (strcmp(p->sym_val_to_name[SYM_TYPES][i], types[j]) == 0) {
-					found++;
-					new = 1;
-				}
-			}
-			if (new == 0) {
-				printf("\nattr %s had type %s not in types array\n", id, p->sym_val_to_name[SYM_TYPES][i]);
+	ebitmap_for_each_set_bit(&attr->types, tnode, i) {
+		new = 0;
+		for (j = 0; j < len; j++) {
+			if (strcmp(p->sym_val_to_name[SYM_TYPES][i], types[j]) == 0) {
+				found++;
+				new = 1;
 			}
-			CU_ASSERT(new == 1);
 		}
+		if (new == 0) {
+			printf("\nattr %s had type %s not in types array\n",
+			       id, p->sym_val_to_name[SYM_TYPES][i]);
+		}
+		CU_ASSERT(new == 1);
 	}
 	CU_ASSERT(found == len);
 	if (found != len)
diff --git a/libsepol/tests/test-expander-users.c b/libsepol/tests/test-expander-users.c
index f3b98a6c..e8321a41 100644
--- a/libsepol/tests/test-expander-users.c
+++ b/libsepol/tests/test-expander-users.c
@@ -45,15 +45,13 @@ static void check_user_roles(policydb_t * p, const char *user_name, const char *
 	}
 	found = calloc(num_roles, sizeof(unsigned char));
 	CU_ASSERT_FATAL(found != NULL);
-	ebitmap_for_each_bit(&user->roles.roles, tnode, i) {
-		if (ebitmap_node_get_bit(tnode, i)) {
-			extra++;
-			for (j = 0; j < num_roles; j++) {
-				if (strcmp(role_names[j], p->p_role_val_to_name[i]) == 0) {
-					extra--;
-					found[j] += 1;
-					break;
-				}
+	ebitmap_for_each_set_bit(&user->roles.roles, tnode, i) {
+		extra++;
+		for (j = 0; j < num_roles; j++) {
+			if (strcmp(role_names[j], p->p_role_val_to_name[i]) == 0) {
+				extra--;
+				found[j] += 1;
+				break;
 			}
 		}
 	}
diff --git a/libsepol/tests/test-linker-roles.c b/libsepol/tests/test-linker-roles.c
index c9e2f2ba..f7018f6f 100644
--- a/libsepol/tests/test-linker-roles.c
+++ b/libsepol/tests/test-linker-roles.c
@@ -58,11 +58,9 @@ static void only_dominates_self(policydb_t * p, role_datum_t * role)
 	unsigned int i;
 	int found = 0;
 
-	ebitmap_for_each_bit(&role->dominates, tnode, i) {
-		if (ebitmap_node_get_bit(tnode, i)) {
-			found++;
-			CU_ASSERT(i == role->s.value - 1);
-		}
+	ebitmap_for_each_set_bit(&role->dominates, tnode, i) {
+		found++;
+		CU_ASSERT(i == role->s.value - 1);
 	}
 	CU_ASSERT(found == 1);
 }
-- 
2.20.1

