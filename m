Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CB4C0015E
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 14:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjGZO0D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGZO0D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 10:26:03 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9721D188
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:26:01 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5607cdb0959so3194896eaf.2
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381560; x=1690986360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ProxwXLHiDD6tEuJsFFfAMwgc3dFJs/MvjHgL0tX2ks=;
        b=GiJiCxPLi5Fh5Fnuy8RVNrp8htto/+8W0mL+s4wDOg98OQtTqAPc91ECx2iDaoUxsE
         PNzMVkk+KShNcbvFDB7zJUT9xa7G1R3nJo+gjLH+tK62mS7EjPWfN1QXH5qp5yYTF/zm
         UZTjG5Y3MHaEV66Vd5uIsFuUaJt8SMNtcBeAkbfFOjn4+ftjorD69fcNkmDaU5oOHmkd
         htXzXXbdXhxbo9Gzfy6oNB/+KnFjLUA+i4W8Fn8fya1ZG1WQBmRJnLh4uRHYHZ1JK3HQ
         fVUox5KB/GCyAchiI2J0iy018hplqFcQOjSpALbGfNxlsRgjxfA6JPvLubGlool3i9QK
         I1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381560; x=1690986360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ProxwXLHiDD6tEuJsFFfAMwgc3dFJs/MvjHgL0tX2ks=;
        b=fi0bHz2anLgxfpzGpPVFInOy08M/Zr7BxRG9jXsKwyGumg3XLIo3frhMjDTZFf18kI
         VtKQs2gHQuOdVqHimqIoV0Ij3A9qJoLUnzALAhos13HqUAj540m7/JhUS0ycj9G05o7v
         my6hc3Ir2FqizbfKqJB0NMUMuScZdu6YpTB5LqU2OZA57WUpfxLjdiOoc67oY8PV/gHA
         LZEutKVRCVjSwr+p1a6xXnR+rWp2t7YL3GQOgQ5DeHiqxIcyG0/KEj2u2awG3FRsdt/J
         Qf0v05yeBY1KOkTX1HBWXlk/SEYt+CSZ+dUY/1Qn/U59wc7i2oFXoPnXJ8zJA1ryLhOK
         jj0A==
X-Gm-Message-State: ABy/qLaWhf3bowQjl34X3IMHUlZZYniaatvYwV/raDVgPY5CteP4tej/
        uu4r60O0KWW4JPaA7L8u3Y9Ip0e4sB9UkQ==
X-Google-Smtp-Source: APBJJlHr93b+NLYh5W2w3mazBPbswqg5/rgfgYd6MJDgogxk34EVTHtXjrvZg5neo7iQQ1ND/X6Lsg==
X-Received: by 2002:a05:6808:4399:b0:3a1:cbea:3bf2 with SMTP id dz25-20020a056808439900b003a1cbea3bf2mr1563981oib.11.1690381560328;
        Wed, 26 Jul 2023 07:26:00 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cf014000000b006362d4eeb6esm5066471qvk.144.2023.07.26.07.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:25:59 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 8/8] Revert "checkpolicy,libsepol: move transition to separate structure in avtab"
Date:   Wed, 26 Jul 2023 10:25:49 -0400
Message-ID: <20230726142549.94685-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
References: <20230726142549.94685-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit de708edf527be7e5142e5a9ae09879d58d65f50b.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/test/dispol.c               |  2 +-
 libsepol/cil/src/cil_binary.c           | 26 +++++---------------
 libsepol/include/sepol/policydb/avtab.h |  7 +-----
 libsepol/src/avtab.c                    | 32 +------------------------
 libsepol/src/expand.c                   |  8 ++-----
 libsepol/src/kernel_to_cil.c            |  3 +--
 libsepol/src/kernel_to_conf.c           |  3 +--
 libsepol/src/optimize.c                 |  4 ----
 libsepol/src/policydb_validate.c        |  4 +---
 libsepol/src/services.c                 |  5 +---
 libsepol/src/write.c                    | 17 +++----------
 11 files changed, 18 insertions(+), 93 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index e45528b9..b567ce77 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -180,7 +180,7 @@ static int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t wha
 		if (key->specified & AVTAB_TRANSITION) {
 			fprintf(fp, "type_transition ");
 			render_key(key, p, fp);
-			render_type(datum->trans->otype, p, fp);
+			render_type(datum->data, p, fp);
 			fprintf(fp, ";\n");
 		}
 		if (key->specified & AVTAB_MEMBER) {
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 3f264594..c4ee2380 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -975,34 +975,28 @@ static int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src,
 	int rc = SEPOL_OK;
 	avtab_key_t avtab_key;
 	avtab_datum_t avtab_datum;
-	avtab_trans_t trans;
 	avtab_ptr_t existing;	
 
 	avtab_key.source_type = src;
 	avtab_key.target_type = tgt;
 	avtab_key.target_class = obj;
 
-	memset(&avtab_datum, 0, sizeof(avtab_datum_t));
-	memset(&trans, 0, sizeof(avtab_trans_t));
-
 	switch (kind) {
 	case CIL_TYPE_TRANSITION:
 		avtab_key.specified = AVTAB_TRANSITION;
-		trans.otype = res;
-		avtab_datum.trans = &trans;
 		break;
 	case CIL_TYPE_CHANGE:
 		avtab_key.specified = AVTAB_CHANGE;
-		avtab_datum.data = res;
 		break;
 	case CIL_TYPE_MEMBER:
 		avtab_key.specified = AVTAB_MEMBER;
-		avtab_datum.data = res;
 		break;
 	default:
 		rc = SEPOL_ERR;
 		goto exit;
 	}
+
+	avtab_datum.data = res;
 	
 	existing = avtab_search_node(&pdb->te_avtab, &avtab_key);
 	if (existing) {
@@ -1010,17 +1004,13 @@ static int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src,
 		 * A warning should have been previously given if there is a
 		 * non-duplicate rule using the same key.
 		 */
-		uint32_t existing_otype =
-			existing->key.specified & AVTAB_TRANSITION
-			? existing->datum.trans->otype
-			: existing->datum.data;
-		if (existing_otype != res) {
+		if (existing->datum.data != res) {
 			cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s), existing=%s\n",
 				pdb->p_type_val_to_name[src - 1],
 				pdb->p_type_val_to_name[tgt - 1],
 				pdb->p_class_val_to_name[obj - 1],
 				pdb->p_type_val_to_name[res - 1],
-				pdb->p_type_val_to_name[existing_otype - 1]);
+				pdb->p_type_val_to_name[existing->datum.data - 1]);
 			cil_log(CIL_ERR, "Expanded from type rule (scontext=%s tcontext=%s tclass=%s result=%s)\n",
 				cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
 			rc = SEPOL_ERR;
@@ -1047,17 +1037,13 @@ static int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src,
 
 			search_datum = cil_cond_av_list_search(&avtab_key, other_list);
 			if (search_datum == NULL) {
-				uint32_t existing_otype =
-					existing->key.specified & AVTAB_TRANSITION
-					? existing->datum.trans->otype
-					: existing->datum.data;
-				if (existing_otype != res) {
+				if (existing->datum.data != res) {
 					cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s), existing=%s\n",
 						pdb->p_type_val_to_name[src - 1],
 						pdb->p_type_val_to_name[tgt - 1],
 						pdb->p_class_val_to_name[obj - 1],
 						pdb->p_type_val_to_name[res - 1],
-						pdb->p_type_val_to_name[existing_otype - 1]);
+						pdb->p_type_val_to_name[existing->datum.data - 1]);
 					cil_log(CIL_ERR, "Expanded from type rule (scontext=%s tcontext=%s tclass=%s result=%s)\n",
 						cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
 					rc = SEPOL_ERR;
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index ca009c16..e4c48576 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -70,10 +70,6 @@ typedef struct avtab_key {
 	uint16_t specified;	/* what fields are specified */
 } avtab_key_t;
 
-typedef struct avtab_trans {
-	uint32_t otype;		/* resulting type of the new object */
-} avtab_trans_t;
-
 typedef struct avtab_extended_perms {
 
 #define AVTAB_XPERMS_IOCTLFUNCTION	0x01
@@ -85,8 +81,7 @@ typedef struct avtab_extended_perms {
 } avtab_extended_perms_t;
 
 typedef struct avtab_datum {
-	uint32_t data;		/* access vector, member or change value */
-	avtab_trans_t *trans;	/* transition value */
+	uint32_t data;		/* access vector or type */
 	avtab_extended_perms_t *xperms;
 } avtab_datum_t;
 
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 4c292e8b..82fec783 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -94,7 +94,6 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t prev, avtab_key_t * key,
 		  avtab_datum_t * datum)
 {
 	avtab_ptr_t newnode;
-	avtab_trans_t *trans;
 	avtab_extended_perms_t *xperms;
 
 	newnode = (avtab_ptr_t) malloc(sizeof(struct avtab_node));
@@ -118,16 +117,6 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t prev, avtab_key_t * key,
 		 * So copy data so it is set in the avtab
 		 */
 		newnode->datum.data = datum->data;
-	} else if (key->specified & AVTAB_TRANSITION) {
-		trans = calloc(1, sizeof(*trans));
-		if (trans == NULL) {
-			free(newnode);
-			return NULL;
-		}
-		if (datum->trans) /* else caller populates transition */
-			*trans = *(datum->trans);
-
-		newnode->datum.trans = trans;
 	} else {
 		newnode->datum = *datum;
 	}
@@ -328,8 +317,6 @@ void avtab_destroy(avtab_t * h)
 		while (cur != NULL) {
 			if (cur->key.specified & AVTAB_XPERMS) {
 				free(cur->datum.xperms);
-			} else if (cur->key.specified & AVTAB_TRANSITION) {
-				free(cur->datum.trans);
 			}
 			temp = cur;
 			cur = cur->next;
@@ -453,7 +440,6 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 	uint32_t buf32[8], items, items2, val;
 	avtab_key_t key;
 	avtab_datum_t datum;
-	avtab_trans_t trans;
 	avtab_extended_perms_t xperms;
 	unsigned set;
 	unsigned int i;
@@ -461,7 +447,6 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 
 	memset(&key, 0, sizeof(avtab_key_t));
 	memset(&datum, 0, sizeof(avtab_datum_t));
-	memset(&trans, 0, sizeof(avtab_trans_t));
 	memset(&xperms, 0, sizeof(avtab_extended_perms_t));
 
 	if (vers < POLICYDB_VERSION_AVTAB) {
@@ -524,14 +509,7 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 					return -1;
 				}
 				key.specified = spec_order[i] | enabled;
-				if (key.specified & AVTAB_TRANSITION) {
-					trans.otype =
-						le32_to_cpu(buf32[items++]);
-					datum.trans = &trans;
-				} else {
-					datum.data =
-						le32_to_cpu(buf32[items++]);
-				}
+				datum.data = le32_to_cpu(buf32[items++]);
 				rc = insertf(a, &key, &datum, p);
 				if (rc)
 					return rc;
@@ -593,14 +571,6 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 		for (i = 0; i < ARRAY_SIZE(xperms.perms); i++)
 			xperms.perms[i] = le32_to_cpu(buf32[i]);
 		datum.xperms = &xperms;
-	} else if (key.specified & AVTAB_TRANSITION) {
-		rc = next_entry(buf32, fp, sizeof(uint32_t));
-		if (rc < 0) {
-			ERR(fp->handle, "truncated entry");
-			return -1;
-		}
-		trans.otype = le32_to_cpu(*buf32);
-		datum.trans = &trans;
 	} else {
 		rc = next_entry(buf32, fp, sizeof(uint32_t));
 		if (rc < 0) {
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 6793a27d..8795229a 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1746,7 +1746,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
 		if (conflict) {
 			avdatump = &node->datum;
 			if (specified & AVRULE_TRANSITION) {
-				oldtype = avdatump->trans->otype;
+				oldtype = avdatump->data;
 			} else if (specified & AVRULE_MEMBER) {
 				oldtype = avdatump->data;
 			} else if (specified & AVRULE_CHANGE) {
@@ -1789,11 +1789,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
 		}
 
 		avdatump = &node->datum;
-		if (specified & AVRULE_TRANSITION) {
-			avdatump->trans->otype = remapped_data;
-		} else {
-			avdatump->data = remapped_data;
-		}
+		avdatump->data = remapped_data;
 
 		cur = cur->next;
 	}
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 316679cc..8fcc385d 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1702,8 +1702,7 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 
 static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_datum_t *datum)
 {
-	uint32_t data = key->specified & AVTAB_TRANSITION
-		? datum->trans->otype : datum->data;
+	uint32_t data = datum->data;
 	type_datum_t *type;
 	const char *flavor, *tgt;
 	char *src, *class, *perms, *new;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index aa161b08..b0ae16d9 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1680,8 +1680,7 @@ exit:
 
 static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_datum_t *datum)
 {
-	uint32_t data = key->specified & AVTAB_TRANSITION
-		? datum->trans->otype : datum->data;
+	uint32_t data = datum->data;
 	type_datum_t *type;
 	const char *flavor, *src, *tgt, *class, *perms, *new;
 	char *rule = NULL;
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 2d4a2d7a..a38025ec 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -308,8 +308,6 @@ static void optimize_avtab(policydb_t *p, const struct type_vec *type_map)
 				*cur = tmp->next;
 				if (tmp->key.specified & AVTAB_XPERMS)
 					free(tmp->datum.xperms);
-				if (tmp->key.specified & AVTAB_TRANSITION)
-					free(tmp->datum.trans);
 				free(tmp);
 
 				tab->nel--;
@@ -429,8 +427,6 @@ static void optimize_cond_avtab(policydb_t *p, const struct type_vec *type_map)
 				*cur = tmp->next;
 				if (tmp->key.specified & AVTAB_XPERMS)
 					free(tmp->datum.xperms);
-				if (tmp->key.specified & AVTAB_TRANSITION)
-					free(tmp->datum.trans);
 				free(tmp);
 
 				tab->nel--;
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index f402b506..3540f34a 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -836,9 +836,7 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *
 	if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
 		return -1;
 
-	uint32_t otype = k->specified & AVTAB_TRANSITION
-		? d->trans->otype : d->data;
-	if ((k->specified & AVTAB_TYPE) && validate_simpletype(otype, margs->policy, margs->flavors))
+	if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, margs->policy, margs->flavors))
 		return -1;
 
 	if ((k->specified & AVTAB_XPERMS) && validate_xperms(d->xperms))
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 6bddc287..07ae051b 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1423,10 +1423,7 @@ static int sepol_compute_sid(sepol_security_id_t ssid,
 
 	if (avdatum) {
 		/* Use the type from the type transition/member/change rule. */
-		if (specified & AVTAB_TRANSITION)
-			newcontext.type = avdatum->trans->otype;
-		else
-			newcontext.type = avdatum->data;
+		newcontext.type = avdatum->data;
 	}
 
 	/* Check for class-specific changes. */
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 0d3d5f14..024fe628 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -190,20 +190,14 @@ static int avtab_write_item(policydb_t * p,
 						ERR(fp->handle, "missing node");
 						return POLICYDB_ERROR;
 					}
-					uint32_t data =
-						node->key.specified & AVTAB_TRANSITION
-						? node->datum.trans->otype
-						: node->datum.data;
-					buf32[items++] = cpu_to_le32(data);
+					buf32[items++] =
+					    cpu_to_le32(node->datum.data);
 					set--;
 					node->merged = 1;
 				}
 			}
 		} else {
-			uint32_t data = cur->key.specified & AVTAB_TRANSITION
-				? cur->datum.trans->otype
-				: cur->datum.data;
-			buf32[items++] = cpu_to_le32(data);
+			buf32[items++] = cpu_to_le32(cur->datum.data);
 			cur->merged = 1;
 			set--;
 		}
@@ -262,11 +256,6 @@ static int avtab_write_item(policydb_t * p,
 		items = put_entry(buf32, sizeof(uint32_t),8,fp);
 		if (items != 8)
 			return POLICYDB_ERROR;
-	} else if (cur->key.specified & AVTAB_TRANSITION) {
-		buf32[0] = cpu_to_le32(cur->datum.trans->otype);
-		items = put_entry(buf32, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return POLICYDB_ERROR;
 	} else {
 		buf32[0] = cpu_to_le32(cur->datum.data);
 		items = put_entry(buf32, sizeof(uint32_t), 1, fp);
-- 
2.41.0

