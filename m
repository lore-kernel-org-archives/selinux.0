Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28478C77B73
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjEaLuH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEaLuG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:50:06 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDECE5
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685533790; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=eOZ69bsr87Led+3yJj88fAAsFfHCATVAvjAABn7DwpdP/xWXL4X7WuRbWHLfTieIkGr3YlBvPn2dthQI6ObFTi2Yh6oXYFDZmGsJvURR+MZl9jqZrQ1KNB4GLWi7IMjVF/vtHLqSdt6CwjFwF0lJ7Httyw1VC9DO5woqX1UaoHE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685533790; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0gHxMwEe0R5fsSCPK6Ecusnh6EFKYo1ZdUc0Y21qMho=; 
        b=iZYuNAcI6TPwgySdWY5sOAbjjifzvGwSavZpFAqLoCXgY+PQb4AXLXtd3sEfWAp0Ij8yG9R93n8fn3fZOCOShfuoKrnRFWjgv9kP2qlW5AFHpsLatPBAGOGGlOj/KZvdl2WkaSLHtBQq8lFD2d2aArzrgZgA0coxLW1/yeDywP0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685533790;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=0gHxMwEe0R5fsSCPK6Ecusnh6EFKYo1ZdUc0Y21qMho=;
        b=cUq/Ib0s18+WD7kSZZqfeu4BmKlhD1kPZLSPTaD73ks5xRPD7cb97IKKvfztyRJ3
        WSxE8VRxrs5bBmcpzfuC02ZNqiwplBEW56PDx3JftFF84QnrLhy6SztDcq9TgZQdh8A
        cfdXwjww5Fk4fKXvE9PcCLfOw19iYZbXqtAY5wyU=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685533787770466.90415684581524; Wed, 31 May 2023 13:49:47 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 315BE2081F76;
        Wed, 31 May 2023 11:49:47 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 1/8] checkpolicy, libsepol: move transition to separate structure in avtab
Date:   Wed, 31 May 2023 13:49:07 +0200
Message-Id: <20230531114914.2237609-2-juraj@jurajmarcin.com>
In-Reply-To: <20230531114914.2237609-1-juraj@jurajmarcin.com>
References: <20230531114914.2237609-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

To move filename transitions to be part of avtab, we need to create
space for it in the avtab_datum structure which holds the rule for
a certain combination of stype, ttype and tclass.

As only type transitions have a special variant that uses a filename, it
would be suboptimal to add a (mostly empty) pointer to some structure to
all avtab rules.

Therefore, this patch adds a new structure to the avtab_datum and moves
the otype of the transition to this structure. In the next patch, this
structure will also hold filename transitions for the combination of
stype, ttype and tclass.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 checkpolicy/test/dispol.c               |  2 +-
 libsepol/cil/src/cil_binary.c           | 26 +++++++++++++++-----
 libsepol/include/sepol/policydb/avtab.h |  7 +++++-
 libsepol/src/avtab.c                    | 32 ++++++++++++++++++++++++-
 libsepol/src/expand.c                   |  8 +++++--
 libsepol/src/kernel_to_cil.c            |  3 ++-
 libsepol/src/kernel_to_conf.c           |  3 ++-
 libsepol/src/optimize.c                 |  4 ++++
 libsepol/src/policydb_validate.c        |  4 +++-
 libsepol/src/services.c                 |  5 +++-
 libsepol/src/write.c                    | 17 ++++++++++---
 11 files changed, 93 insertions(+), 18 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index b61f1b4b..dea4f8da 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -132,7 +132,7 @@ static int render_av_rule(avtab_key_t * key, avtab_da=
tum_t * datum, uint32_t wha
 		if (key->specified & AVTAB_TRANSITION) {
 			fprintf(fp, "type_transition ");
 			render_key(key, p, fp);
-			render_type(datum->data, p, fp);
+			render_type(datum->trans->otype, p, fp);
 			fprintf(fp, ";\n");
 		}
 		if (key->specified & AVTAB_MEMBER) {
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
index c4ee2380..3f264594 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -975,28 +975,34 @@ static int __cil_insert_type_rule(policydb_t *pdb, =
uint32_t kind, uint32_t src,
 	int rc =3D SEPOL_OK;
 	avtab_key_t avtab_key;
 	avtab_datum_t avtab_datum;
+	avtab_trans_t trans;
 	avtab_ptr_t existing;=09
=20
 	avtab_key.source_type =3D src;
 	avtab_key.target_type =3D tgt;
 	avtab_key.target_class =3D obj;
=20
+	memset(&avtab_datum, 0, sizeof(avtab_datum_t));
+	memset(&trans, 0, sizeof(avtab_trans_t));
+
 	switch (kind) {
 	case CIL_TYPE_TRANSITION:
 		avtab_key.specified =3D AVTAB_TRANSITION;
+		trans.otype =3D res;
+		avtab_datum.trans =3D &trans;
 		break;
 	case CIL_TYPE_CHANGE:
 		avtab_key.specified =3D AVTAB_CHANGE;
+		avtab_datum.data =3D res;
 		break;
 	case CIL_TYPE_MEMBER:
 		avtab_key.specified =3D AVTAB_MEMBER;
+		avtab_datum.data =3D res;
 		break;
 	default:
 		rc =3D SEPOL_ERR;
 		goto exit;
 	}
-
-	avtab_datum.data =3D res;
 =09
 	existing =3D avtab_search_node(&pdb->te_avtab, &avtab_key);
 	if (existing) {
@@ -1004,13 +1010,17 @@ static int __cil_insert_type_rule(policydb_t *pdb=
, uint32_t kind, uint32_t src,
 		 * A warning should have been previously given if there is a
 		 * non-duplicate rule using the same key.
 		 */
-		if (existing->datum.data !=3D res) {
+		uint32_t existing_otype =3D
+			existing->key.specified & AVTAB_TRANSITION
+			? existing->datum.trans->otype
+			: existing->datum.data;
+		if (existing_otype !=3D res) {
 			cil_log(CIL_ERR, "Conflicting type rules (scontext=3D%s tcontext=3D%s=
 tclass=3D%s result=3D%s), existing=3D%s\n",
 				pdb->p_type_val_to_name[src - 1],
 				pdb->p_type_val_to_name[tgt - 1],
 				pdb->p_class_val_to_name[obj - 1],
 				pdb->p_type_val_to_name[res - 1],
-				pdb->p_type_val_to_name[existing->datum.data - 1]);
+				pdb->p_type_val_to_name[existing_otype - 1]);
 			cil_log(CIL_ERR, "Expanded from type rule (scontext=3D%s tcontext=3D%=
s tclass=3D%s result=3D%s)\n",
 				cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->r=
esult_str);
 			rc =3D SEPOL_ERR;
@@ -1037,13 +1047,17 @@ static int __cil_insert_type_rule(policydb_t *pdb=
, uint32_t kind, uint32_t src,
=20
 			search_datum =3D cil_cond_av_list_search(&avtab_key, other_list);
 			if (search_datum =3D=3D NULL) {
-				if (existing->datum.data !=3D res) {
+				uint32_t existing_otype =3D
+					existing->key.specified & AVTAB_TRANSITION
+					? existing->datum.trans->otype
+					: existing->datum.data;
+				if (existing_otype !=3D res) {
 					cil_log(CIL_ERR, "Conflicting type rules (scontext=3D%s tcontext=3D=
%s tclass=3D%s result=3D%s), existing=3D%s\n",
 						pdb->p_type_val_to_name[src - 1],
 						pdb->p_type_val_to_name[tgt - 1],
 						pdb->p_class_val_to_name[obj - 1],
 						pdb->p_type_val_to_name[res - 1],
-						pdb->p_type_val_to_name[existing->datum.data - 1]);
+						pdb->p_type_val_to_name[existing_otype - 1]);
 					cil_log(CIL_ERR, "Expanded from type rule (scontext=3D%s tcontext=3D=
%s tclass=3D%s result=3D%s)\n",
 						cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule-=
>result_str);
 					rc =3D SEPOL_ERR;
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/s=
epol/policydb/avtab.h
index e4c48576..ca009c16 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -70,6 +70,10 @@ typedef struct avtab_key {
 	uint16_t specified;	/* what fields are specified */
 } avtab_key_t;
=20
+typedef struct avtab_trans {
+	uint32_t otype;		/* resulting type of the new object */
+} avtab_trans_t;
+
 typedef struct avtab_extended_perms {
=20
 #define AVTAB_XPERMS_IOCTLFUNCTION	0x01
@@ -81,7 +85,8 @@ typedef struct avtab_extended_perms {
 } avtab_extended_perms_t;
=20
 typedef struct avtab_datum {
-	uint32_t data;		/* access vector or type */
+	uint32_t data;		/* access vector, member or change value */
+	avtab_trans_t *trans;	/* transition value */
 	avtab_extended_perms_t *xperms;
 } avtab_datum_t;
=20
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 82fec783..4c292e8b 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -94,6 +94,7 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t =
prev, avtab_key_t * key,
 		  avtab_datum_t * datum)
 {
 	avtab_ptr_t newnode;
+	avtab_trans_t *trans;
 	avtab_extended_perms_t *xperms;
=20
 	newnode =3D (avtab_ptr_t) malloc(sizeof(struct avtab_node));
@@ -117,6 +118,16 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr=
_t prev, avtab_key_t * key,
 		 * So copy data so it is set in the avtab
 		 */
 		newnode->datum.data =3D datum->data;
+	} else if (key->specified & AVTAB_TRANSITION) {
+		trans =3D calloc(1, sizeof(*trans));
+		if (trans =3D=3D NULL) {
+			free(newnode);
+			return NULL;
+		}
+		if (datum->trans) /* else caller populates transition */
+			*trans =3D *(datum->trans);
+
+		newnode->datum.trans =3D trans;
 	} else {
 		newnode->datum =3D *datum;
 	}
@@ -317,6 +328,8 @@ void avtab_destroy(avtab_t * h)
 		while (cur !=3D NULL) {
 			if (cur->key.specified & AVTAB_XPERMS) {
 				free(cur->datum.xperms);
+			} else if (cur->key.specified & AVTAB_TRANSITION) {
+				free(cur->datum.trans);
 			}
 			temp =3D cur;
 			cur =3D cur->next;
@@ -440,6 +453,7 @@ int avtab_read_item(struct policy_file *fp, uint32_t =
vers, avtab_t * a,
 	uint32_t buf32[8], items, items2, val;
 	avtab_key_t key;
 	avtab_datum_t datum;
+	avtab_trans_t trans;
 	avtab_extended_perms_t xperms;
 	unsigned set;
 	unsigned int i;
@@ -447,6 +461,7 @@ int avtab_read_item(struct policy_file *fp, uint32_t =
vers, avtab_t * a,
=20
 	memset(&key, 0, sizeof(avtab_key_t));
 	memset(&datum, 0, sizeof(avtab_datum_t));
+	memset(&trans, 0, sizeof(avtab_trans_t));
 	memset(&xperms, 0, sizeof(avtab_extended_perms_t));
=20
 	if (vers < POLICYDB_VERSION_AVTAB) {
@@ -509,7 +524,14 @@ int avtab_read_item(struct policy_file *fp, uint32_t=
 vers, avtab_t * a,
 					return -1;
 				}
 				key.specified =3D spec_order[i] | enabled;
-				datum.data =3D le32_to_cpu(buf32[items++]);
+				if (key.specified & AVTAB_TRANSITION) {
+					trans.otype =3D
+						le32_to_cpu(buf32[items++]);
+					datum.trans =3D &trans;
+				} else {
+					datum.data =3D
+						le32_to_cpu(buf32[items++]);
+				}
 				rc =3D insertf(a, &key, &datum, p);
 				if (rc)
 					return rc;
@@ -571,6 +593,14 @@ int avtab_read_item(struct policy_file *fp, uint32_t=
 vers, avtab_t * a,
 		for (i =3D 0; i < ARRAY_SIZE(xperms.perms); i++)
 			xperms.perms[i] =3D le32_to_cpu(buf32[i]);
 		datum.xperms =3D &xperms;
+	} else if (key.specified & AVTAB_TRANSITION) {
+		rc =3D next_entry(buf32, fp, sizeof(uint32_t));
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
+			return -1;
+		}
+		trans.otype =3D le32_to_cpu(*buf32);
+		datum.trans =3D &trans;
 	} else {
 		rc =3D next_entry(buf32, fp, sizeof(uint32_t));
 		if (rc < 0) {
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index c08d3a35..065bfbcf 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1746,7 +1746,7 @@ static int expand_terule_helper(sepol_handle_t * ha=
ndle,
 		if (conflict) {
 			avdatump =3D &node->datum;
 			if (specified & AVRULE_TRANSITION) {
-				oldtype =3D avdatump->data;
+				oldtype =3D avdatump->trans->otype;
 			} else if (specified & AVRULE_MEMBER) {
 				oldtype =3D avdatump->data;
 			} else if (specified & AVRULE_CHANGE) {
@@ -1789,7 +1789,11 @@ static int expand_terule_helper(sepol_handle_t * h=
andle,
 		}
=20
 		avdatump =3D &node->datum;
-		avdatump->data =3D remapped_data;
+		if (specified & AVRULE_TRANSITION) {
+			avdatump->trans->otype =3D remapped_data;
+		} else {
+			avdatump->data =3D remapped_data;
+		}
=20
 		cur =3D cur->next;
 	}
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index e9cd89c2..d80f4cae 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1703,7 +1703,8 @@ static char *xperms_to_str(avtab_extended_perms_t *=
xperms)
=20
 static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, a=
vtab_datum_t *datum)
 {
-	uint32_t data =3D datum->data;
+	uint32_t data =3D key->specified & AVTAB_TRANSITION
+		? datum->trans->otype : datum->data;
 	type_datum_t *type;
 	const char *flavor, *tgt;
 	char *src, *class, *perms, *new;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
index c48a7114..edee311b 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1681,7 +1681,8 @@ exit:
=20
 static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, a=
vtab_datum_t *datum)
 {
-	uint32_t data =3D datum->data;
+	uint32_t data =3D key->specified & AVTAB_TRANSITION
+		? datum->trans->otype : datum->data;
 	type_datum_t *type;
 	const char *flavor, *src, *tgt, *class, *perms, *new;
 	char *rule =3D NULL;
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index a38025ec..2d4a2d7a 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -308,6 +308,8 @@ static void optimize_avtab(policydb_t *p, const struc=
t type_vec *type_map)
 				*cur =3D tmp->next;
 				if (tmp->key.specified & AVTAB_XPERMS)
 					free(tmp->datum.xperms);
+				if (tmp->key.specified & AVTAB_TRANSITION)
+					free(tmp->datum.trans);
 				free(tmp);
=20
 				tab->nel--;
@@ -427,6 +429,8 @@ static void optimize_cond_avtab(policydb_t *p, const =
struct type_vec *type_map)
 				*cur =3D tmp->next;
 				if (tmp->key.specified & AVTAB_XPERMS)
 					free(tmp->datum.xperms);
+				if (tmp->key.specified & AVTAB_TRANSITION)
+					free(tmp->datum.trans);
 				free(tmp);
=20
 				tab->nel--;
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
index 301aa200..519ab961 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -832,7 +832,9 @@ static int validate_avtab_key_and_datum(avtab_key_t *=
k, avtab_datum_t *d, void *
 	if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
 		return -1;
=20
-	if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, margs->=
policy, margs->flavors))
+	uint32_t otype =3D k->specified & AVTAB_TRANSITION
+		? d->trans->otype : d->data;
+	if ((k->specified & AVTAB_TYPE) && validate_simpletype(otype, margs->po=
licy, margs->flavors))
 		return -1;
=20
 	if ((k->specified & AVTAB_XPERMS) && validate_xperms(d->xperms))
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 062510ab..72772dbd 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1423,7 +1423,10 @@ static int sepol_compute_sid(sepol_security_id_t s=
sid,
=20
 	if (avdatum) {
 		/* Use the type from the type transition/member/change rule. */
-		newcontext.type =3D avdatum->data;
+		if (specified & AVTAB_TRANSITION)
+			newcontext.type =3D avdatum->trans->otype;
+		else
+			newcontext.type =3D avdatum->data;
 	}
=20
 	/* Check for class-specific changes. */
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 024fe628..0d3d5f14 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -190,14 +190,20 @@ static int avtab_write_item(policydb_t * p,
 						ERR(fp->handle, "missing node");
 						return POLICYDB_ERROR;
 					}
-					buf32[items++] =3D
-					    cpu_to_le32(node->datum.data);
+					uint32_t data =3D
+						node->key.specified & AVTAB_TRANSITION
+						? node->datum.trans->otype
+						: node->datum.data;
+					buf32[items++] =3D cpu_to_le32(data);
 					set--;
 					node->merged =3D 1;
 				}
 			}
 		} else {
-			buf32[items++] =3D cpu_to_le32(cur->datum.data);
+			uint32_t data =3D cur->key.specified & AVTAB_TRANSITION
+				? cur->datum.trans->otype
+				: cur->datum.data;
+			buf32[items++] =3D cpu_to_le32(data);
 			cur->merged =3D 1;
 			set--;
 		}
@@ -256,6 +262,11 @@ static int avtab_write_item(policydb_t * p,
 		items =3D put_entry(buf32, sizeof(uint32_t),8,fp);
 		if (items !=3D 8)
 			return POLICYDB_ERROR;
+	} else if (cur->key.specified & AVTAB_TRANSITION) {
+		buf32[0] =3D cpu_to_le32(cur->datum.trans->otype);
+		items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
+		if (items !=3D 1)
+			return POLICYDB_ERROR;
 	} else {
 		buf32[0] =3D cpu_to_le32(cur->datum.data);
 		items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
--=20
2.40.0

