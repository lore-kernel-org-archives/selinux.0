Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A80AC77B7C
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjEaLuW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbjEaLuQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:50:16 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376B10F
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685533804; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=K+G9VIP3ZL1q8WL+hH5RCsT/2v0Usw1a9oiLhZQpNNKBtnrKoLX+xi0lHdmhQ8F7oJ9TIYhBbrTJkOcBMV8yN7rGdtWLoeLfCLtr6CoMqSJY7lXzlz8xjguzGV8vFJwY3PH34lxxu5x3XEKf9r0dg6/93ynosqHo2A4+RanEwWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685533804; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=D8BHtWLaW7A8ks/sLfMFyBI8GbQRBcdJaoeYy5LGjdU=; 
        b=c8DNoaN+NDzmic4Qx+tPyWbD6/5p34g4WRF97BnnouowkaZ9kH8sDuLRu8Iy9tVqiS4sQtZkdvRrdMQnmmz8JpCd9nTZcfB83b2RSMrYlIqjvr/pqpsF5RB6QOWxt0ojuab2ZIKNMgdY8+DMhZeT0FXVAR41dz7v9HD3vlohyJU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685533804;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=D8BHtWLaW7A8ks/sLfMFyBI8GbQRBcdJaoeYy5LGjdU=;
        b=VyjB5iVSSPAoLe9TZCC3+9/q4T2EPYeTIVlgSm9vQClPAKNGHhWRVWfKWmqp2hig
        Ai9hEMkAvU3WN84ZMB2HTx1efpW8ntWRxjB8zRErZHuQjKhvOjLDOdOcgRllPhrrNfx
        CceLL1DaJGIqBWv5GDAyPwX8uSQeFBQv+tBTM464=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685533792862376.46193496474586; Wed, 31 May 2023 13:49:52 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id E6AD02081F76;
        Wed, 31 May 2023 11:49:51 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 2/8] checkpolicy, libsepol: move filename transitions to avtab
Date:   Wed, 31 May 2023 13:49:08 +0200
Message-Id: <20230531114914.2237609-3-juraj@jurajmarcin.com>
In-Reply-To: <20230531114914.2237609-1-juraj@jurajmarcin.com>
References: <20230531114914.2237609-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, filename transitions are stored separately from other type
enforcement rules. This leads to possibly sub-optimal performance and
makes further improvements cumbersome.

This patch adds a symbol table with filename transitions to the
transition structure added to avtab in the previous patch. It also
implements functions required for reading and writing filename
transitions (either binary or source formats) and updates the code for
expanding attributes. Last but not least, it updates the conflict check
in the conditional avtab to account for empty transitions in the
non-conditional avtab.

These changes are expected to cause higher memory usage, as now there
needs to be a filename transition structure for every stype. This patch
effectively undoes most of the commit 42ae834a ("libsepol,checkpolicy:
optimize storage of filename transitions"), but this will be mitigated
by providing support for matching prefix/suffix of the filename for
filename transitions in future patches which will reduce to need to have
so many of them.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 checkpolicy/checkmodule.c                  |   9 +
 checkpolicy/checkpolicy.c                  |   9 +
 checkpolicy/policy_define.c                |  21 +-
 checkpolicy/test/dispol.c                  |  83 ++--
 libsepol/cil/src/cil_binary.c              |  27 +-
 libsepol/include/sepol/policydb/avtab.h    |   9 +
 libsepol/include/sepol/policydb/hashtab.h  |   6 +
 libsepol/include/sepol/policydb/policydb.h |  22 -
 libsepol/src/avtab.c                       | 197 +++++++++
 libsepol/src/conditional.c                 |   6 +-
 libsepol/src/expand.c                      |  27 +-
 libsepol/src/kernel_to_cil.c               | 159 ++-----
 libsepol/src/kernel_to_common.h            |   9 +
 libsepol/src/kernel_to_conf.c              | 155 ++-----
 libsepol/src/optimize.c                    |   8 +-
 libsepol/src/policydb.c                    | 343 +--------------
 libsepol/src/policydb_validate.c           |  69 ++-
 libsepol/src/write.c                       | 462 +++++++++++++++------
 18 files changed, 799 insertions(+), 822 deletions(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 3432608b..d68a56a1 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -275,6 +275,15 @@ int main(int argc, char **argv)
 		modpolicydb.mls =3D mlspol;
 		modpolicydb.handle_unknown =3D handle_unknown;
=20
+		/*
+		 * Init and alloc te_avtab for filename transition duplicate
+		 * checking
+		 */
+		if (avtab_init(&modpolicydb.te_avtab))
+			exit(1);
+		if (avtab_alloc(&modpolicydb.te_avtab, 1 << 11))
+			exit(1);
+
 		if (read_source_policy(&modpolicydb, file, argv[0]) =3D=3D -1) {
 			exit(1);
 		}
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 2485142d..6e8ed833 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -611,6 +611,15 @@ int main(int argc, char **argv)
 		parse_policy.mls =3D mlspol;
 		parse_policy.handle_unknown =3D handle_unknown;
=20
+		/*
+		 * Init and alloc te_avtab for filename transition duplicate
+		 * checking
+		 */
+		if (avtab_init(&parse_policy.te_avtab))
+			exit(1);
+		if (avtab_alloc(&parse_policy.te_avtab, 1 << 11))
+			exit(1);
+
 		policydbp =3D &parse_policy;
=20
 		if (read_source_policy(policydbp, file, "checkpolicy") < 0)
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index d4e376ad..acc78baf 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3341,6 +3341,7 @@ int define_filename_trans(void)
 	ebitmap_node_t *snode, *tnode, *cnode;
 	filename_trans_rule_t *ftr;
 	type_datum_t *typdatum;
+	avtab_key_t avt_key;
 	uint32_t otype;
 	unsigned int c, s, t;
 	int add, self, rc;
@@ -3432,9 +3433,13 @@ int define_filename_trans(void)
 	ebitmap_for_each_positive_bit(&e_tclasses, cnode, c) {
 		ebitmap_for_each_positive_bit(&e_stypes, snode, s) {
 			ebitmap_for_each_positive_bit(&e_ttypes, tnode, t) {
-				rc =3D policydb_filetrans_insert(
-					policydbp, s+1, t+1, c+1, name,
-					NULL, otype, NULL
+				avt_key.specified =3D AVTAB_TRANSITION;
+				avt_key.source_type =3D s + 1;
+				avt_key.target_type =3D t + 1;
+				avt_key.target_class =3D c + 1;
+				rc =3D avtab_insert_filename_trans(
+					&policydbp->te_avtab, &avt_key, otype,
+					name, NULL
 				);
 				if (rc !=3D SEPOL_OK) {
 					if (rc =3D=3D SEPOL_EEXIST) {
@@ -3450,9 +3455,13 @@ int define_filename_trans(void)
 				}
 			}
 			if (self) {
-				rc =3D policydb_filetrans_insert(
-					policydbp, s+1, s+1, c+1, name,
-					NULL, otype, NULL
+				avt_key.specified =3D AVTAB_TRANSITION;
+				avt_key.source_type =3D s + 1;
+				avt_key.target_type =3D t + 1;
+				avt_key.target_class =3D c + 1;
+				rc =3D avtab_insert_filename_trans(
+					&policydbp->te_avtab, &avt_key, otype,
+					name, NULL
 				);
 				if (rc !=3D SEPOL_OK) {
 					if (rc =3D=3D SEPOL_EEXIST) {
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index dea4f8da..4455407c 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -78,6 +78,26 @@ static int render_key(avtab_key_t * key, policydb_t * =
p, FILE * fp)
 	return 0;
 }
=20
+typedef struct {
+	avtab_key_t *key;
+	policydb_t *p;
+	FILE *fp;
+} render_name_trans_args_t;
+
+static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, =
void *a)
+{
+	char *name =3D k;
+	uint32_t *otype =3D d;
+	render_name_trans_args_t *args =3D a;
+
+	fprintf(args->fp, "type_transition ");
+	render_key(args->key, args->p, args->fp);
+	render_type(*otype, args->p, args->fp);
+	fprintf(args->fp, " \"%s\";\n", name);
+
+	return 0;
+}
+
 /* 'what' values for this function */
 #define	RENDER_UNCONDITIONAL	0x0001	/* render all regardless of enabled =
state */
 #define RENDER_ENABLED		0x0002
@@ -130,10 +150,19 @@ static int render_av_rule(avtab_key_t * key, avtab_=
datum_t * datum, uint32_t wha
 		}
 	} else if (key->specified & AVTAB_TYPE) {
 		if (key->specified & AVTAB_TRANSITION) {
-			fprintf(fp, "type_transition ");
-			render_key(key, p, fp);
-			render_type(datum->trans->otype, p, fp);
-			fprintf(fp, ";\n");
+			if (datum->trans->otype) {
+				fprintf(fp, "type_transition ");
+				render_key(key, p, fp);
+				render_type(datum->trans->otype, p, fp);
+				fprintf(fp, ";\n");
+			}
+			render_name_trans_args_t args =3D {
+				.key =3D key,
+				.p =3D p,
+				.fp =3D fp,
+			};
+			hashtab_map(datum->trans->name_trans.table,
+				    render_name_trans_helper, &args);
 		}
 		if (key->specified & AVTAB_MEMBER) {
 			fprintf(fp, "type_member ");
@@ -400,48 +429,6 @@ static void display_role_trans(policydb_t *p, FILE *=
fp)
 	}
 }
=20
-struct filenametr_display_args {
-	policydb_t *p;
-	FILE *fp;
-};
-
-static int filenametr_display(hashtab_key_t key,
-			      hashtab_datum_t datum,
-			      void *ptr)
-{
-	struct filename_trans_key *ft =3D (struct filename_trans_key *)key;
-	struct filename_trans_datum *ftdatum =3D datum;
-	struct filenametr_display_args *args =3D ptr;
-	policydb_t *p =3D args->p;
-	FILE *fp =3D args->fp;
-	ebitmap_node_t *node;
-	uint32_t bit;
-
-	do {
-		ebitmap_for_each_positive_bit(&ftdatum->stypes, node, bit) {
-			display_id(p, fp, SYM_TYPES, bit, "");
-			display_id(p, fp, SYM_TYPES, ft->ttype - 1, "");
-			display_id(p, fp, SYM_CLASSES, ft->tclass - 1, ":");
-			display_id(p, fp, SYM_TYPES, ftdatum->otype - 1, "");
-			fprintf(fp, " %s\n", ft->name);
-		}
-		ftdatum =3D ftdatum->next;
-	} while (ftdatum);
-
-	return 0;
-}
-
-
-static void display_filename_trans(policydb_t *p, FILE *fp)
-{
-	struct filenametr_display_args args;
-
-	fprintf(fp, "filename_trans rules:\n");
-	args.p =3D p;
-	args.fp =3D fp;
-	hashtab_map(p->filename_trans, filenametr_display, &args);
-}
-
 static int menu(void)
 {
 	printf("\nSelect a command:\n");
@@ -462,7 +449,6 @@ static int menu(void)
 	printf("a)  display type attributes\n");
 	printf("p)  display the list of permissive types\n");
 	printf("u)  display unknown handling setting\n");
-	printf("F)  display filename_trans rules\n");
 	printf("\n");
 	printf("f)  set output file\n");
 	printf("m)  display menu\n");
@@ -634,9 +620,6 @@ int main(int argc, char **argv)
 			if (out_fp !=3D stdout)
 				printf("\nOutput to file: %s\n", OutfileName);
 			break;
-		case 'F':
-			display_filename_trans(&policydb, out_fp);
-			break;
 		case 'q':
 			policydb_destroy(&policydb);
 			exit(0);
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
index 3f264594..7150d405 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1005,7 +1005,12 @@ static int __cil_insert_type_rule(policydb_t *pdb,=
 uint32_t kind, uint32_t src,
 	}
 =09
 	existing =3D avtab_search_node(&pdb->te_avtab, &avtab_key);
-	if (existing) {
+	/*
+	 * There might be empty transition node containing filename transitions
+	 * only. That is okay, we can merge them later.
+	 */
+	if (existing && !(existing->key.specified & AVTAB_TRANSITION &&
+	    !existing->datum.trans->otype)) {
 		/* Don't add duplicate type rule and warn if they conflict.
 		 * A warning should have been previously given if there is a
 		 * non-duplicate rule using the same key.
@@ -1029,7 +1034,13 @@ static int __cil_insert_type_rule(policydb_t *pdb,=
 uint32_t kind, uint32_t src,
 	}
=20
 	if (!cond_node) {
-		rc =3D avtab_insert(&pdb->te_avtab, &avtab_key, &avtab_datum);
+		/* If we have node from empty filename transition, use it */
+		if (existing && existing->key.specified & AVTAB_TRANSITION &&
+		    !existing->datum.trans->otype)
+			existing->datum.trans->otype =3D avtab_datum.trans->otype;
+		else
+			rc =3D avtab_insert(&pdb->te_avtab, &avtab_key,
+					  &avtab_datum);
 	} else {
 		existing =3D avtab_search_node(&pdb->te_cond_avtab, &avtab_key);
 		if (existing) {
@@ -1189,16 +1200,18 @@ static int __cil_typetransition_to_avtab_helper(p=
olicydb_t *pdb,
 	class_datum_t *sepol_obj =3D NULL;
 	uint32_t otype;
 	struct cil_list_item *c;
+	avtab_key_t avt_key;
=20
 	cil_list_for_each(c, class_list) {
 		rc =3D __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
 		if (rc !=3D SEPOL_OK) return rc;
=20
-		rc =3D policydb_filetrans_insert(
-			pdb, sepol_src->s.value, sepol_tgt->s.value,
-			sepol_obj->s.value, name, NULL,
-			sepol_result->s.value, &otype
-		);
+		avt_key.specified =3D AVTAB_TRANSITION;
+		avt_key.source_type =3D sepol_src->s.value;
+		avt_key.target_type =3D sepol_tgt->s.value;
+		avt_key.target_class =3D sepol_obj->s.value;
+		rc =3D avtab_insert_filename_trans(&pdb->te_avtab, &avt_key,
+			sepol_result->s.value, name, &otype);
 		if (rc !=3D SEPOL_OK) {
 			if (rc =3D=3D SEPOL_EEXIST) {
 				if (sepol_result->s.value!=3D otype) {
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/s=
epol/policydb/avtab.h
index ca009c16..5dc720cc 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -42,6 +42,7 @@
=20
 #include <sys/types.h>
 #include <stdint.h>
+#include <sepol/policydb/symtab.h>
=20
 #ifdef __cplusplus
 extern "C" {
@@ -72,6 +73,7 @@ typedef struct avtab_key {
=20
 typedef struct avtab_trans {
 	uint32_t otype;		/* resulting type of the new object */
+	symtab_t name_trans;	/* filename transitions */
 } avtab_trans_t;
=20
 typedef struct avtab_extended_perms {
@@ -115,6 +117,8 @@ extern int avtab_insert(avtab_t * h, avtab_key_t * k,=
 avtab_datum_t * d);
=20
 extern avtab_datum_t *avtab_search(avtab_t * h, avtab_key_t * k);
=20
+extern void avtab_trans_destroy(avtab_trans_t *trans);
+
 extern void avtab_destroy(avtab_t * h);
=20
 extern int avtab_map(const avtab_t * h,
@@ -148,6 +152,11 @@ extern avtab_ptr_t avtab_search_node_next(avtab_ptr_=
t node, int specified);
 /* avtab_alloc uses one bucket per 2-4 elements, so adjust to get maximu=
m buckets */
 #define MAX_AVTAB_SIZE (MAX_AVTAB_HASH_BUCKETS << 1)
=20
+extern int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
+				       uint32_t otype, const char *name,
+				       uint32_t *present_otype);
+extern int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a=
);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include=
/sepol/policydb/hashtab.h
index dca8c983..3a6b953e 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -110,6 +110,12 @@ extern int hashtab_map(hashtab_t h,
=20
 extern void hashtab_hash_eval(hashtab_t h, char *tag);
=20
+/* Checks if the hashtab is empty (its size is zero) */
+static inline int hashtab_is_empty(hashtab_t h)
+{
+	return !h || !h->size;
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
index b014b7a8..8bb11d18 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -161,19 +161,6 @@ typedef struct role_allow {
 	struct role_allow *next;
 } role_allow_t;
=20
-/* filename_trans rules */
-typedef struct filename_trans_key {
-	uint32_t ttype;
-	uint32_t tclass;
-	char *name;
-} filename_trans_key_t;
-
-typedef struct filename_trans_datum {
-	ebitmap_t stypes;
-	uint32_t otype;
-	struct filename_trans_datum *next;
-} filename_trans_datum_t;
-
 /* Type attributes */
 typedef struct type_datum {
 	symtab_datum_t s;
@@ -592,10 +579,6 @@ typedef struct policydb {
 	/* range transitions table (range_trans_key -> mls_range) */
 	hashtab_t range_tr;
=20
-	/* file transitions with the last path component */
-	hashtab_t filename_trans;
-	uint32_t filename_trans_count;
-
 	ebitmap_t *type_attr_map;
=20
 	ebitmap_t *attr_type_map;	/* not saved in the binary policy */
@@ -654,11 +637,6 @@ extern int policydb_load_isids(policydb_t * p, sidta=
b_t * s);
=20
 extern int policydb_sort_ocontexts(policydb_t *p);
=20
-extern int policydb_filetrans_insert(policydb_t *p, uint32_t stype,
-				     uint32_t ttype, uint32_t tclass,
-				     const char *name, char **name_alloc,
-				     uint32_t otype, uint32_t *present_otype);
-
 /* Deprecated */
 extern int policydb_context_isvalid(const policydb_t * p,
 				    const context_struct_t * c);
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 4c292e8b..3d8d6769 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -315,6 +315,20 @@ avtab_ptr_t avtab_search_node_next(avtab_ptr_t node,=
 int specified)
 	return NULL;
 }
=20
+static int avtab_trans_destroy_helper(hashtab_key_t k, hashtab_datum_t d=
,
+				      void *a __attribute__ ((unused)))
+{
+	free(k);
+	free(d);
+	return 0;
+}
+
+void avtab_trans_destroy(avtab_trans_t *trans)
+{
+	hashtab_map(trans->name_trans.table, avtab_trans_destroy_helper, NULL);
+	symtab_destroy(&trans->name_trans);
+}
+
 void avtab_destroy(avtab_t * h)
 {
 	unsigned int i;
@@ -329,6 +343,7 @@ void avtab_destroy(avtab_t * h)
 			if (cur->key.specified & AVTAB_XPERMS) {
 				free(cur->datum.xperms);
 			} else if (cur->key.specified & AVTAB_TRANSITION) {
+				avtab_trans_destroy(cur->datum.trans);
 				free(cur->datum.trans);
 			}
 			temp =3D cur;
@@ -660,3 +675,185 @@ int avtab_read(avtab_t * a, struct policy_file *fp,=
 uint32_t vers)
 	avtab_destroy(a);
 	return -1;
 }
+
+/* policydb filename transition compatibility */
+
+int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
+				uint32_t otype, const char *name,
+				uint32_t *present_otype)
+{
+	int rc =3D SEPOL_ENOMEM;
+	avtab_trans_t new_trans =3D {0};
+	avtab_datum_t new_datum =3D {.trans =3D &new_trans};
+	avtab_datum_t *datum;
+	avtab_ptr_t node;
+	char *name_key =3D NULL;
+	uint32_t *otype_datum =3D NULL;
+
+	datum =3D avtab_search(a, key);
+	if (!datum) {
+		/*
+		 * insert is actually unique, but with this function we can get
+		 * the inserted node and therefore the datum
+		 */
+		node =3D avtab_insert_nonunique(a, key, &new_datum);
+		if (!node)
+			return SEPOL_ENOMEM;
+		datum =3D &node->datum;
+	}
+
+	if (hashtab_is_empty(datum->trans->name_trans.table)) {
+		rc =3D symtab_init(&datum->trans->name_trans, 1 << 8);
+		if (rc < 0)
+			return rc;
+	}
+
+	name_key =3D strdup(name);
+	if (!name_key)
+		goto bad;
+
+	otype_datum =3D malloc(sizeof(*otype_datum));
+	if (!otype_datum)
+		goto bad;
+	*otype_datum =3D otype;
+
+	rc =3D hashtab_insert(datum->trans->name_trans.table, name_key,
+			    otype_datum);
+	if (rc < 0)
+		goto bad;
+
+	return SEPOL_OK;
+
+bad:
+	free(name_key);
+	free(otype_datum);
+	if (rc =3D=3D SEPOL_EEXIST && present_otype) {
+		otype_datum =3D hashtab_search(datum->trans->name_trans.table,
+					     name);
+		if (otype_datum)
+			*present_otype =3D *otype_datum;
+	}
+	return rc;
+}
+
+static int filename_trans_read_one(avtab_t *a, void *fp)
+{
+	int rc;
+	uint32_t buf[4], len, otype;
+	char *name =3D NULL;
+	avtab_key_t key;
+
+	/* read length of the name and the name */
+	rc =3D next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return SEPOL_ERR;
+	len =3D le32_to_cpu(*buf);
+	rc =3D str_read(&name, fp, len);
+	if (rc < 0)
+		return SEPOL_ERR;
+
+	/* read stype, ttype, tclass and otype */
+	rc =3D next_entry(buf, fp, sizeof(uint32_t) * 4);
+	if (rc < 0)
+		goto err;
+
+	key.specified =3D AVTAB_TRANSITION;
+	key.source_type =3D le32_to_cpu(buf[0]);
+	key.target_type =3D le32_to_cpu(buf[1]);
+	key.target_class =3D le32_to_cpu(buf[2]);
+	otype =3D le32_to_cpu(buf[3]);
+
+	rc =3D avtab_insert_filename_trans(a, &key, otype, name, NULL);
+	if (rc)
+		goto err;
+
+	free(name);
+	return SEPOL_OK;
+err:
+	free(name);
+	return SEPOL_ERR;
+}
+
+static int filename_trans_comp_read_one(avtab_t *a, void *fp)
+{
+	int rc;
+	uint32_t buf[3], len, ndatum, i, bit, otype;
+	char *name =3D NULL;
+	avtab_key_t key;
+	ebitmap_t stypes;
+	ebitmap_node_t *node;
+
+	/* read length of the name and the name */
+	rc =3D next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return SEPOL_ERR;
+	len =3D le32_to_cpu(*buf);
+	rc =3D str_read(&name, fp, len);
+	if (rc < 0)
+		return SEPOL_ERR;
+
+	/* read ttype, tclass, ndatum */
+	rc =3D next_entry(buf, fp, sizeof(uint32_t) * 3);
+	if (rc < 0)
+		goto err;
+
+	key.specified =3D AVTAB_TRANSITION;
+	key.target_type =3D le32_to_cpu(buf[0]);
+	key.target_class =3D le32_to_cpu(buf[1]);
+
+	ndatum =3D le32_to_cpu(buf[2]);
+	for (i =3D 0; i < ndatum; i++) {
+		rc =3D ebitmap_read(&stypes, fp);
+		if (rc < 0)
+			goto err;
+
+		rc =3D next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			goto err_ebitmap;
+		otype =3D le32_to_cpu(*buf);
+
+		ebitmap_for_each_positive_bit(&stypes, node, bit) {
+			key.source_type =3D bit + 1;
+
+			rc =3D avtab_insert_filename_trans(a, &key, otype, name,
+				NULL);
+			if (rc < 0)
+				goto err_ebitmap;
+		}
+	}
+
+	free(name);
+	return SEPOL_OK;
+
+err_ebitmap:
+	ebitmap_destroy(&stypes);
+err:
+	free(name);
+	return rc;
+}
+
+int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a)
+{
+	uint32_t buf[1], nel, i;
+	int rc;
+
+	rc =3D next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return rc;
+	nel =3D le32_to_cpu(*buf);
+
+	if (vers < POLICYDB_VERSION_COMP_FTRANS) {
+		for (i =3D 0; i < nel; i++) {
+			rc =3D filename_trans_read_one(a, fp);
+			if (rc < 0)
+				return rc;
+		}
+	} else {
+		for (i =3D 0; i < nel; i++) {
+			rc =3D filename_trans_comp_read_one(a, fp);
+			if (rc < 0)
+				return rc;
+		}
+	}
+	return SEPOL_OK;
+}
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 24380ea0..7900e928 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -624,6 +624,7 @@ static int cond_insertf(avtab_t * a
 	struct policydb *p =3D data->p;
 	cond_av_list_t *other =3D data->other, *list, *cur;
 	avtab_ptr_t node_ptr;
+	avtab_datum_t *existing;
 	uint8_t found;
=20
 	/*
@@ -632,7 +633,10 @@ static int cond_insertf(avtab_t * a
 	 * cond_te_avtab.
 	 */
 	if (k->specified & AVTAB_TYPE) {
-		if (avtab_search(&p->te_avtab, k)) {
+		existing =3D avtab_search(&p->te_avtab, k);
+		/* empty transition rule is not a conflict */
+		if (existing && !(k->specified & AVTAB_TRANSITION
+		    && !existing->trans->otype)) {
 			WARN(NULL, "security: type rule already exists outside of a condition=
al.");
 			return -1;
 		}
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 065bfbcf..8ffe1c90 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1413,14 +1413,17 @@ static int expand_filename_trans_helper(expand_st=
ate_t *state,
 {
 	uint32_t mapped_otype, present_otype;
 	int rc;
+	avtab_key_t avt_key;
=20
 	mapped_otype =3D state->typemap[rule->otype - 1];
=20
-	rc =3D policydb_filetrans_insert(
-		state->out, s + 1, t + 1,
-		rule->tclass, rule->name,
-		NULL, mapped_otype, &present_otype
-	);
+	avt_key.specified =3D AVTAB_TRANSITION;
+	avt_key.source_type =3D s + 1;
+	avt_key.target_type =3D t + 1;
+	avt_key.target_class =3D rule->tclass;
+
+	rc =3D avtab_insert_filename_trans(&state->out->te_avtab, &avt_key,
+		mapped_otype, rule->name, &present_otype);
 	if (rc =3D=3D SEPOL_EEXIST) {
 		/* duplicate rule, ignore */
 		if (present_otype =3D=3D mapped_otype)
@@ -1734,6 +1737,16 @@ static int expand_terule_helper(sepol_handle_t * h=
andle,
 		 * either in the global scope or in another
 		 * conditional AV tab */
 		node =3D avtab_search_node(&p->te_avtab, &avkey);
+
+		/*
+		 * if node does not already contain transition, it is not a
+		 * conflict and transition otype will be set to node found by
+		 * find_avtab_node()
+		 */
+		if (specified & AVRULE_TRANSITION && node &&
+		    !node->datum.trans->otype)
+			node =3D NULL;
+
 		if (node) {
 			conflict =3D 1;
 		} else {
@@ -1741,6 +1754,10 @@ static int expand_terule_helper(sepol_handle_t * h=
andle,
 			if (node && node->parse_context !=3D other) {
 				conflict =3D 2;
 			}
+			/*
+			 * conditional avtab does not contain filename
+			 * transitions, no need to check for otype =3D=3D 0
+			 */
 		}
=20
 		if (conflict) {
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index d80f4cae..655581ef 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1701,14 +1701,24 @@ static char *xperms_to_str(avtab_extended_perms_t=
 *xperms)
 	return xpermsbuf;
 }
=20
-static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, a=
vtab_datum_t *datum)
+static int name_trans_to_strs_helper(hashtab_key_t k, hashtab_datum_t d,=
 void *a)
 {
-	uint32_t data =3D key->specified & AVTAB_TRANSITION
-		? datum->trans->otype : datum->data;
+	char *name =3D k;
+	uint32_t *otype =3D d;
+	name_trans_to_strs_args_t *args =3D a;
+	return strs_create_and_add(args->strs, "(%s %s %s %s \"%s\" %s)", 6,
+				   args->flavor, args->src, args->tgt,
+				   args->class, name,
+				   args->pdb->p_type_val_to_name[*otype - 1]);
+}
+
+static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, av=
tab_datum_t *datum, struct strs *strs)
+{
+	int rc =3D SEPOL_OK;
+	uint32_t data =3D datum->data;
 	type_datum_t *type;
 	const char *flavor, *tgt;
 	char *src, *class, *perms, *new;
-	char *rule =3D NULL;
=20
 	switch (0xFFF & key->specified) {
 	case AVTAB_ALLOWED:
@@ -1741,7 +1751,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
 		break;
 	default:
 		sepol_log_err("Unknown avtab type: %i", key->specified);
-		goto exit;
+		return SEPOL_ERR;
 	}
=20
 	src =3D pdb->p_type_val_to_name[key->source_type - 1];
@@ -1758,33 +1768,44 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
 		perms =3D sepol_av_to_string(pdb, key->target_class, data);
 		if (perms =3D=3D NULL) {
 			sepol_log_err("Failed to generate permission string");
-			goto exit;
+			return SEPOL_ERR;
 		}
-		rule =3D create_str("(%s %s %s (%s (%s)))", 5,
-				  flavor, src, tgt, class, perms+1);
+		rc =3D strs_create_and_add(strs, "(%s %s %s (%s (%s)))", 5,
+					 flavor, src, tgt, class, perms + 1);
 	} else if (key->specified & AVTAB_XPERMS) {
 		perms =3D xperms_to_str(datum->xperms);
 		if (perms =3D=3D NULL) {
 			sepol_log_err("Failed to generate extended permission string");
-			goto exit;
+			return SEPOL_ERR;
 		}
=20
-		rule =3D create_str("(%s %s %s (%s %s (%s)))", 6,
-				  flavor, src, tgt, "ioctl", class, perms);
+		rc =3D strs_create_and_add(strs, "(%s %s %s (%s %s (%s)))", 6,
+					 flavor, src, tgt, "ioctl", class, perms);
+	} else if (key->specified & AVTAB_TRANSITION) {
+		if (datum->trans->otype) {
+			rc =3D strs_create_and_add(strs, "(%s %s %s %s %s)", 5,
+						 flavor, src, tgt, class,
+						 pdb->p_type_val_to_name[datum->trans->otype - 1]);
+			if (rc < 0)
+				return rc;
+		}
+		name_trans_to_strs_args_t args =3D {
+			.pdb =3D pdb,
+			.strs =3D strs,
+			.flavor =3D flavor,
+			.src =3D src,
+			.tgt =3D tgt,
+			.class =3D class,
+		};
+		rc =3D hashtab_map(datum->trans->name_trans.table,
+				 name_trans_to_strs_helper, &args);
 	} else {
 		new =3D pdb->p_type_val_to_name[data - 1];
=20
-		rule =3D create_str("(%s %s %s %s %s)", 5, flavor, src, tgt, class, ne=
w);
-	}
-
-	if (!rule) {
-		goto exit;
+		rc =3D strs_create_and_add(strs, "(%s %s %s %s %s)", 5, flavor, src, t=
gt, class, new);
 	}
=20
-	return rule;
-
-exit:
-	return NULL;
+	return rc;
 }
=20
 struct map_avtab_args {
@@ -1799,23 +1820,12 @@ static int map_avtab_write_helper(avtab_key_t *ke=
y, avtab_datum_t *datum, void *
 	uint32_t flavor =3D map_args->flavor;
 	struct policydb *pdb =3D map_args->pdb;
 	struct strs *strs =3D map_args->strs;
-	char *rule;
 	int rc =3D 0;
=20
 	if (key->specified & flavor) {
-		rule =3D avtab_node_to_str(pdb, key, datum);
-		if (!rule) {
-			rc =3D -1;
-			goto exit;
-		}
-		rc =3D strs_add(strs, rule);
-		if (rc !=3D 0) {
-			free(rule);
-			goto exit;
-		}
+		rc =3D avtab_node_to_strs(pdb, key, datum, strs);
 	}
=20
-exit:
 	return rc;
 }
=20
@@ -1869,77 +1879,6 @@ exit:
 	return rc;
 }
=20
-struct map_filename_trans_args {
-	struct policydb *pdb;
-	struct strs *strs;
-};
-
-static int map_filename_trans_to_str(hashtab_key_t key, void *data, void=
 *arg)
-{
-	filename_trans_key_t *ft =3D (filename_trans_key_t *)key;
-	filename_trans_datum_t *datum =3D data;
-	struct map_filename_trans_args *map_args =3D arg;
-	struct policydb *pdb =3D map_args->pdb;
-	struct strs *strs =3D map_args->strs;
-	char *src, *tgt, *class, *filename, *new;
-	struct ebitmap_node *node;
-	uint32_t bit;
-	int rc;
-
-	tgt =3D pdb->p_type_val_to_name[ft->ttype - 1];
-	class =3D pdb->p_class_val_to_name[ft->tclass - 1];
-	filename =3D ft->name;
-	do {
-		new =3D pdb->p_type_val_to_name[datum->otype - 1];
-
-		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
-			src =3D pdb->p_type_val_to_name[bit];
-			rc =3D strs_create_and_add(strs,
-						 "(typetransition %s %s %s \"%s\" %s)",
-						 5, src, tgt, class, filename, new);
-			if (rc)
-				return rc;
-		}
-
-		datum =3D datum->next;
-	} while (datum);
-
-	return 0;
-}
-
-static int write_filename_trans_rules_to_cil(FILE *out, struct policydb =
*pdb)
-{
-	struct map_filename_trans_args args;
-	struct strs *strs;
-	int rc =3D 0;
-
-	rc =3D strs_init(&strs, 100);
-	if (rc !=3D 0) {
-		goto exit;
-	}
-
-	args.pdb =3D pdb;
-	args.strs =3D strs;
-
-	rc =3D hashtab_map(pdb->filename_trans, map_filename_trans_to_str, &arg=
s);
-	if (rc !=3D 0) {
-		goto exit;
-	}
-
-	strs_sort(strs);
-	strs_write_each(strs, out);
-
-exit:
-	strs_free_all(strs);
-	strs_destroy(&strs);
-
-	if (rc !=3D 0) {
-		sepol_log_err("Error writing filename typetransition rules to CIL\n");
-	}
-
-	return rc;
-}
-
 static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 {
 	ebitmap_t *cats =3D &level->cat;
@@ -2059,7 +1998,6 @@ static int write_cond_av_list_to_cil(FILE *out, str=
uct policydb *pdb, cond_av_li
 	avtab_key_t *key;
 	avtab_datum_t *datum;
 	struct strs *strs;
-	char *rule;
 	unsigned i;
 	int rc;
=20
@@ -2075,14 +2013,8 @@ static int write_cond_av_list_to_cil(FILE *out, st=
ruct policydb *pdb, cond_av_li
 			key =3D &node->key;
 			datum =3D &node->datum;
 			if (key->specified & flavor) {
-				rule =3D avtab_node_to_str(pdb, key, datum);
-				if (!rule) {
-					rc =3D -1;
-					goto exit;
-				}
-				rc =3D strs_add(strs, rule);
+				rc =3D avtab_node_to_strs(pdb, key, datum, strs);
 				if (rc !=3D 0) {
-					free(rule);
 					goto exit;
 				}
 			}
@@ -3330,11 +3262,6 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct=
 policydb *pdb)
 		goto exit;
 	}
=20
-	rc =3D write_filename_trans_rules_to_cil(out, pdb);
-	if (rc !=3D 0) {
-		goto exit;
-	}
-
 	if (pdb->mls) {
 		rc =3D write_range_trans_rules_to_cil(out, pdb);
 		if (rc !=3D 0) {
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_com=
mon.h
index 159c4289..eee2e1a0 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -83,6 +83,15 @@ struct strs {
 	size_t size;
 };
=20
+typedef struct {
+	policydb_t *pdb;
+	struct strs *strs;
+	const char *flavor;
+	const char *src;
+	const char *tgt;
+	const char *class;
+} name_trans_to_strs_args_t;
+
 __attribute__ ((format(printf, 1, 2)))
 void sepol_log_err(const char *fmt, ...);
 void sepol_indent(FILE *out, int indent);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
index edee311b..065f84eb 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1679,13 +1679,24 @@ exit:
 	return rc;
 }
=20
-static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, a=
vtab_datum_t *datum)
+static int name_trans_to_strs_helper(hashtab_key_t k, hashtab_datum_t d,=
 void *a)
 {
-	uint32_t data =3D key->specified & AVTAB_TRANSITION
-		? datum->trans->otype : datum->data;
+	char *name =3D k;
+	uint32_t *otype =3D d;
+	name_trans_to_strs_args_t *args =3D a;
+	return strs_create_and_add(args->strs, "%s %s %s:%s %s \"%s\";", 6,
+				   args->flavor, args->src, args->tgt,
+				   args->class,
+				   args->pdb->p_type_val_to_name[*otype - 1],
+				   name);
+}
+
+static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, av=
tab_datum_t *datum, struct strs *strs)
+{
+	int rc =3D SEPOL_OK;
+	uint32_t data =3D datum->data;
 	type_datum_t *type;
 	const char *flavor, *src, *tgt, *class, *perms, *new;
-	char *rule =3D NULL;
=20
 	switch (0xFFF & key->specified) {
 	case AVTAB_ALLOWED:
@@ -1718,7 +1729,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
 		break;
 	default:
 		sepol_log_err("Unknown avtab type: %i", key->specified);
-		goto exit;
+		return SEPOL_ERR;
 	}
=20
 	src =3D pdb->p_type_val_to_name[key->source_type - 1];
@@ -1735,32 +1746,42 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
 		perms =3D sepol_av_to_string(pdb, key->target_class, data);
 		if (perms =3D=3D NULL) {
 			sepol_log_err("Failed to generate permission string");
-			goto exit;
+			return SEPOL_ERR;
 		}
-		rule =3D create_str("%s %s %s:%s { %s };", 5,
-				  flavor, src, tgt, class, perms+1);
+		rc =3D strs_create_and_add(strs, "%s %s %s:%s { %s };", 5,
+					 flavor, src, tgt, class, perms + 1);
 	} else if (key->specified & AVTAB_XPERMS) {
 		perms =3D sepol_extended_perms_to_string(datum->xperms);
 		if (perms =3D=3D NULL) {
 			sepol_log_err("Failed to generate extended permission string");
-			goto exit;
+			return SEPOL_ERR;
+		}
+		rc =3D strs_create_and_add(strs, "%s %s %s:%s %s;", 5, flavor, src, tg=
t, class, perms);
+	} else if (key->specified & AVTAB_TRANSITION) {
+		if (datum->trans->otype) {
+			rc =3D strs_create_and_add(strs, "%s %s %s:%s %s;", 5,
+						 flavor, src, tgt, class,
+						 pdb->p_type_val_to_name[datum->trans->otype - 1]);
+			if (rc < 0)
+				return rc;
 		}
-
-		rule =3D create_str("%s %s %s:%s %s;", 5, flavor, src, tgt, class, per=
ms);
+		name_trans_to_strs_args_t args =3D {
+			.pdb =3D pdb,
+			.strs =3D strs,
+			.flavor =3D flavor,
+			.src =3D src,
+			.tgt =3D tgt,
+			.class =3D class,
+		};
+		rc =3D hashtab_map(datum->trans->name_trans.table,
+				 name_trans_to_strs_helper, &args);
 	} else {
 		new =3D pdb->p_type_val_to_name[data - 1];
=20
-		rule =3D create_str("%s %s %s:%s %s;", 5, flavor, src, tgt, class, new=
);
+		rc =3D strs_create_and_add(strs, "%s %s %s:%s %s;", 5, flavor, src, tg=
t, class, new);
 	}
=20
-	if (!rule) {
-		goto exit;
-	}
-
-	return rule;
-
-exit:
-	return NULL;
+	return rc;
 }
=20
 struct map_avtab_args {
@@ -1775,23 +1796,12 @@ static int map_avtab_write_helper(avtab_key_t *ke=
y, avtab_datum_t *datum, void *
 	uint32_t flavor =3D map_args->flavor;
 	struct policydb *pdb =3D map_args->pdb;
 	struct strs *strs =3D map_args->strs;
-	char *rule;
 	int rc =3D 0;
=20
 	if (key->specified & flavor) {
-		rule =3D avtab_node_to_str(pdb, key, datum);
-		if (!rule) {
-			rc =3D -1;
-			goto exit;
-		}
-		rc =3D strs_add(strs, rule);
-		if (rc !=3D 0) {
-			free(rule);
-			goto exit;
-		}
+		rc =3D avtab_node_to_strs(pdb, key, datum, strs);
 	}
=20
-exit:
 	return rc;
 }
=20
@@ -1845,77 +1855,6 @@ exit:
 	return rc;
 }
=20
-struct map_filename_trans_args {
-	struct policydb *pdb;
-	struct strs *strs;
-};
-
-static int map_filename_trans_to_str(hashtab_key_t key, void *data, void=
 *arg)
-{
-	filename_trans_key_t *ft =3D (filename_trans_key_t *)key;
-	filename_trans_datum_t *datum =3D data;
-	struct map_filename_trans_args *map_args =3D arg;
-	struct policydb *pdb =3D map_args->pdb;
-	struct strs *strs =3D map_args->strs;
-	char *src, *tgt, *class, *filename, *new;
-	struct ebitmap_node *node;
-	uint32_t bit;
-	int rc;
-
-	tgt =3D pdb->p_type_val_to_name[ft->ttype - 1];
-	class =3D pdb->p_class_val_to_name[ft->tclass - 1];
-	filename =3D ft->name;
-	do {
-		new =3D pdb->p_type_val_to_name[datum->otype - 1];
-
-		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
-			src =3D pdb->p_type_val_to_name[bit];
-			rc =3D strs_create_and_add(strs,
-						 "type_transition %s %s:%s %s \"%s\";",
-						 5, src, tgt, class, new, filename);
-			if (rc)
-				return rc;
-		}
-
-		datum =3D datum->next;
-	} while (datum);
-
-	return 0;
-}
-
-static int write_filename_trans_rules_to_conf(FILE *out, struct policydb=
 *pdb)
-{
-	struct map_filename_trans_args args;
-	struct strs *strs;
-	int rc =3D 0;
-
-	rc =3D strs_init(&strs, 100);
-	if (rc !=3D 0) {
-		goto exit;
-	}
-
-	args.pdb =3D pdb;
-	args.strs =3D strs;
-
-	rc =3D hashtab_map(pdb->filename_trans, map_filename_trans_to_str, &arg=
s);
-	if (rc !=3D 0) {
-		goto exit;
-	}
-
-	strs_sort(strs);
-	strs_write_each(strs, out);
-
-exit:
-	strs_free_all(strs);
-	strs_destroy(&strs);
-
-	if (rc !=3D 0) {
-		sepol_log_err("Error writing filename typetransition rules to policy.c=
onf\n");
-	}
-
-	return rc;
-}
-
 static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 {
 	ebitmap_t *cats =3D &level->cat;
@@ -2035,7 +1974,6 @@ static int write_cond_av_list_to_conf(FILE *out, st=
ruct policydb *pdb, cond_av_l
 	avtab_key_t *key;
 	avtab_datum_t *datum;
 	struct strs *strs;
-	char *rule;
 	unsigned i;
 	int rc;
=20
@@ -2051,14 +1989,8 @@ static int write_cond_av_list_to_conf(FILE *out, s=
truct policydb *pdb, cond_av_l
 			key =3D &node->key;
 			datum =3D &node->datum;
 			if (key->specified & flavor) {
-				rule =3D avtab_node_to_str(pdb, key, datum);
-				if (!rule) {
-					rc =3D -1;
-					goto exit;
-				}
-				rc =3D strs_add(strs, rule);
+				rc =3D avtab_node_to_strs(pdb, key, datum, strs);
 				if (rc !=3D 0) {
-					free(rule);
 					goto exit;
 				}
 			}
@@ -3206,7 +3138,6 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct=
 policydb *pdb)
 	if (rc !=3D 0) {
 		goto exit;
 	}
-	write_filename_trans_rules_to_conf(out, pdb);
=20
 	if (pdb->mls) {
 		rc =3D write_range_trans_rules_to_conf(out, pdb);
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 2d4a2d7a..7948d983 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -308,8 +308,10 @@ static void optimize_avtab(policydb_t *p, const stru=
ct type_vec *type_map)
 				*cur =3D tmp->next;
 				if (tmp->key.specified & AVTAB_XPERMS)
 					free(tmp->datum.xperms);
-				if (tmp->key.specified & AVTAB_TRANSITION)
+				if (tmp->key.specified & AVTAB_TRANSITION) {
+					avtab_trans_destroy(tmp->datum.trans);
 					free(tmp->datum.trans);
+				}
 				free(tmp);
=20
 				tab->nel--;
@@ -429,8 +431,10 @@ static void optimize_cond_avtab(policydb_t *p, const=
 struct type_vec *type_map)
 				*cur =3D tmp->next;
 				if (tmp->key.specified & AVTAB_XPERMS)
 					free(tmp->datum.xperms);
-				if (tmp->key.specified & AVTAB_TRANSITION)
+				if (tmp->key.specified & AVTAB_TRANSITION) {
+					avtab_trans_destroy(tmp->datum.trans);
 					free(tmp->datum.trans);
+				}
 				free(tmp);
=20
 				tab->nel--;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index b79c19b9..91836183 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -801,47 +801,6 @@ static int roles_init(policydb_t * p)
 	goto out;
 }
=20
-ignore_unsigned_overflow_
-static inline unsigned long
-partial_name_hash(unsigned long c, unsigned long prevhash)
-{
-	return (prevhash + (c << 4) + (c >> 4)) * 11;
-}
-
-static unsigned int filenametr_hash(hashtab_t h, const_hashtab_key_t k)
-{
-	const filename_trans_key_t *ft =3D (const filename_trans_key_t *)k;
-	unsigned long hash;
-	unsigned int byte_num;
-	unsigned char focus;
-
-	hash =3D ft->ttype ^ ft->tclass;
-
-	byte_num =3D 0;
-	while ((focus =3D ft->name[byte_num++]))
-		hash =3D partial_name_hash(focus, hash);
-	return hash & (h->size - 1);
-}
-
-static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
-			  const_hashtab_key_t k1, const_hashtab_key_t k2)
-{
-	const filename_trans_key_t *ft1 =3D (const filename_trans_key_t *)k1;
-	const filename_trans_key_t *ft2 =3D (const filename_trans_key_t *)k2;
-	int v;
-
-	v =3D spaceship_cmp(ft1->ttype, ft2->ttype);
-	if (v)
-		return v;
-
-	v =3D spaceship_cmp(ft1->tclass, ft2->tclass);
-	if (v)
-		return v;
-
-	return strcmp(ft1->name, ft2->name);
-
-}
-
 static unsigned int rangetr_hash(hashtab_t h, const_hashtab_key_t k)
 {
 	const struct range_trans *key =3D (const struct range_trans *)k;
@@ -909,12 +868,6 @@ int policydb_init(policydb_t * p)
 	if (rc)
 		goto err;
=20
-	p->filename_trans =3D hashtab_create(filenametr_hash, filenametr_cmp, (=
1 << 10));
-	if (!p->filename_trans) {
-		rc =3D -ENOMEM;
-		goto err;
-	}
-
 	p->range_tr =3D hashtab_create(rangetr_hash, rangetr_cmp, 256);
 	if (!p->range_tr) {
 		rc =3D -ENOMEM;
@@ -926,7 +879,6 @@ int policydb_init(policydb_t * p)
=20
 	return 0;
 err:
-	hashtab_destroy(p->filename_trans);
 	hashtab_destroy(p->range_tr);
 	for (i =3D 0; i < SYM_NUM; i++) {
 		hashtab_destroy(p->symtab[i].table);
@@ -1412,23 +1364,6 @@ static int (*destroy_f[SYM_NUM]) (hashtab_key_t ke=
y, hashtab_datum_t datum,
 common_destroy, class_destroy, role_destroy, type_destroy, user_destroy,
 	    cond_destroy_bool, sens_destroy, cat_destroy,};
=20
-static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
-			      void *p __attribute__ ((unused)))
-{
-	filename_trans_key_t *ft =3D (filename_trans_key_t *)key;
-	filename_trans_datum_t *fd =3D datum, *next;
-
-	free(ft->name);
-	free(key);
-	do {
-		next =3D fd->next;
-		ebitmap_destroy(&fd->stypes);
-		free(fd);
-		fd =3D next;
-	} while (fd);
-	return 0;
-}
-
 static int range_tr_destroy(hashtab_key_t key, hashtab_datum_t datum,
 			    void *p __attribute__ ((unused)))
 {
@@ -1564,9 +1499,6 @@ void policydb_destroy(policydb_t * p)
 	if (lra)
 		free(lra);
=20
-	hashtab_map(p->filename_trans, filenametr_destroy, NULL);
-	hashtab_destroy(p->filename_trans);
-
 	hashtab_map(p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(p->range_tr);
=20
@@ -2596,279 +2528,6 @@ static int role_allow_read(role_allow_t ** r, str=
uct policy_file *fp)
 	return 0;
 }
=20
-int policydb_filetrans_insert(policydb_t *p, uint32_t stype, uint32_t tt=
ype,
-			      uint32_t tclass, const char *name,
-			      char **name_alloc, uint32_t otype,
-			      uint32_t *present_otype)
-{
-	filename_trans_key_t *ft, key;
-	filename_trans_datum_t *datum, *last;
-
-	key.ttype =3D ttype;
-	key.tclass =3D tclass;
-	key.name =3D (char *)name;
-
-	last =3D NULL;
-	datum =3D hashtab_search(p->filename_trans, (hashtab_key_t)&key);
-	while (datum) {
-		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
-			if (present_otype)
-				*present_otype =3D datum->otype;
-			return SEPOL_EEXIST;
-		}
-		if (datum->otype =3D=3D otype)
-			break;
-		last =3D datum;
-		datum =3D datum->next;
-	}
-	if (!datum) {
-		datum =3D malloc(sizeof(*datum));
-		if (!datum)
-			return SEPOL_ENOMEM;
-
-		ebitmap_init(&datum->stypes);
-		datum->otype =3D otype;
-		datum->next =3D NULL;
-
-		if (last) {
-			last->next =3D datum;
-		} else {
-			char *name_dup;
-
-			if (name_alloc) {
-				name_dup =3D *name_alloc;
-				*name_alloc =3D NULL;
-			} else {
-				name_dup =3D strdup(name);
-				if (!name_dup) {
-					free(datum);
-					return SEPOL_ENOMEM;
-				}
-			}
-
-			ft =3D malloc(sizeof(*ft));
-			if (!ft) {
-				free(name_dup);
-				free(datum);
-				return SEPOL_ENOMEM;
-			}
-
-			ft->ttype =3D ttype;
-			ft->tclass =3D tclass;
-			ft->name =3D name_dup;
-
-			if (hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
-					   (hashtab_datum_t)datum)) {
-				free(name_dup);
-				free(datum);
-				free(ft);
-				return SEPOL_ENOMEM;
-			}
-		}
-	}
-
-	p->filename_trans_count++;
-	return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
-}
-
-static int filename_trans_read_one_compat(policydb_t *p, struct policy_f=
ile *fp)
-{
-	uint32_t buf[4], len, stype, ttype, tclass, otype;
-	char *name =3D NULL;
-	int rc;
-
-	rc =3D next_entry(buf, fp, sizeof(uint32_t));
-	if (rc < 0)
-		return -1;
-	len =3D le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
-		return -1;
-
-	name =3D calloc(len + 1, sizeof(*name));
-	if (!name)
-		return -1;
-
-	rc =3D next_entry(name, fp, len);
-	if (rc < 0)
-		goto err;
-
-	rc =3D next_entry(buf, fp, sizeof(uint32_t) * 4);
-	if (rc < 0)
-		goto err;
-
-	stype =3D le32_to_cpu(buf[0]);
-	if (stype =3D=3D 0)
-		goto err;
-
-	ttype  =3D le32_to_cpu(buf[1]);
-	tclass =3D le32_to_cpu(buf[2]);
-	otype  =3D le32_to_cpu(buf[3]);
-
-	rc =3D policydb_filetrans_insert(p, stype, ttype, tclass, name, &name,
-				       otype, NULL);
-	if (rc) {
-		if (rc !=3D SEPOL_EEXIST)
-			goto err;
-		/*
-		 * Some old policies were wrongly generated with
-		 * duplicate filename transition rules.  For backward
-		 * compatibility, do not reject such policies, just
-		 * ignore the duplicate.
-		 */
-	}
-	free(name);
-	return 0;
-err:
-	free(name);
-	return -1;
-}
-
-static int filename_trans_check_datum(filename_trans_datum_t *datum)
-{
-	ebitmap_t stypes, otypes;
-	int rc =3D -1;
-
-	ebitmap_init(&stypes);
-	ebitmap_init(&otypes);
-
-	while (datum) {
-		if (ebitmap_get_bit(&otypes, datum->otype))
-			goto out;
-
-		if (ebitmap_set_bit(&otypes, datum->otype, 1))
-			goto out;
-
-		if (ebitmap_match_any(&stypes, &datum->stypes))
-			goto out;
-
-		if (ebitmap_union(&stypes, &datum->stypes))
-			goto out;
-
-		datum =3D datum->next;
-	}
-	rc =3D 0;
-out:
-	ebitmap_destroy(&stypes);
-	ebitmap_destroy(&otypes);
-	return rc;
-}
-
-static int filename_trans_read_one(policydb_t *p, struct policy_file *fp=
)
-{
-	filename_trans_key_t *ft =3D NULL;
-	filename_trans_datum_t **dst, *datum, *first =3D NULL;
-	unsigned int i;
-	uint32_t buf[3], len, ttype, tclass, ndatum;
-	char *name =3D NULL;
-	int rc;
-
-	rc =3D next_entry(buf, fp, sizeof(uint32_t));
-	if (rc < 0)
-		return -1;
-	len =3D le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
-		return -1;
-
-	name =3D calloc(len + 1, sizeof(*name));
-	if (!name)
-		return -1;
-
-	rc =3D next_entry(name, fp, len);
-	if (rc < 0)
-		goto err;
-
-	rc =3D next_entry(buf, fp, sizeof(uint32_t) * 3);
-	if (rc < 0)
-		goto err;
-
-	ttype =3D le32_to_cpu(buf[0]);
-	tclass =3D le32_to_cpu(buf[1]);
-	ndatum =3D le32_to_cpu(buf[2]);
-	if (ndatum =3D=3D 0)
-		goto err;
-
-	dst =3D &first;
-	for (i =3D 0; i < ndatum; i++) {
-		datum =3D malloc(sizeof(*datum));
-		if (!datum)
-			goto err;
-
-		datum->next =3D NULL;
-		*dst =3D datum;
-
-		/* ebitmap_read() will at least init the bitmap */
-		rc =3D ebitmap_read(&datum->stypes, fp);
-		if (rc < 0)
-			goto err;
-
-		rc =3D next_entry(buf, fp, sizeof(uint32_t));
-		if (rc < 0)
-			goto err;
-
-		datum->otype =3D le32_to_cpu(buf[0]);
-
-		p->filename_trans_count +=3D ebitmap_cardinality(&datum->stypes);
-
-		dst =3D &datum->next;
-	}
-
-	if (ndatum > 1 && filename_trans_check_datum(first))
-		goto err;
-
-	ft =3D malloc(sizeof(*ft));
-	if (!ft)
-		goto err;
-
-	ft->ttype =3D ttype;
-	ft->tclass =3D tclass;
-	ft->name =3D name;
-
-	rc =3D hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
-			    (hashtab_datum_t)first);
-	if (rc)
-		goto err;
-
-	return 0;
-err:
-	free(ft);
-	free(name);
-	while (first) {
-		datum =3D first;
-		first =3D first->next;
-
-		ebitmap_destroy(&datum->stypes);
-		free(datum);
-	}
-	return -1;
-}
-
-static int filename_trans_read(policydb_t *p, struct policy_file *fp)
-{
-	unsigned int i;
-	uint32_t buf[1], nel;
-	int rc;
-
-	rc =3D next_entry(buf, fp, sizeof(uint32_t));
-	if (rc < 0)
-		return -1;
-	nel =3D le32_to_cpu(buf[0]);
-
-	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
-		for (i =3D 0; i < nel; i++) {
-			rc =3D filename_trans_read_one_compat(p, fp);
-			if (rc < 0)
-				return -1;
-		}
-	} else {
-		for (i =3D 0; i < nel; i++) {
-			rc =3D filename_trans_read_one(p, fp);
-			if (rc < 0)
-				return -1;
-		}
-	}
-	return 0;
-}
-
 static int ocontext_read_xen(const struct policydb_compat_info *info,
 	policydb_t *p, struct policy_file *fp)
 {
@@ -4470,7 +4129,7 @@ int policydb_read(policydb_t * p, struct policy_fil=
e *fp, unsigned verbose)
 		if (role_allow_read(&p->role_allow, fp))
 			goto bad;
 		if (r_policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS &&
-		    filename_trans_read(p, fp))
+		    avtab_filename_trans_read(fp, r_policyvers, &p->te_avtab))
 			goto bad;
 	} else {
 		/* first read the AV rule blocks, then the scope tables */
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
index 519ab961..e7af3fb8 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -825,6 +825,18 @@ static int validate_xperms(const avtab_extended_perm=
s_t *xperms)
 bad:
 	return -1;
 }
+
+static int validate_name_trans_helper(hashtab_key_t k __attribute__ ((un=
used)),
+				      hashtab_datum_t d, void *a)
+{
+	uint32_t *otype =3D d;
+	map_arg_t *margs =3D a;
+
+	if (validate_simpletype(*otype, margs->policy, margs->flavors))
+		return -1;
+	return 0;
+}
+
 static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d=
, void *args)
 {
 	map_arg_t *margs =3D args;
@@ -832,10 +844,23 @@ static int validate_avtab_key_and_datum(avtab_key_t=
 *k, avtab_datum_t *d, void *
 	if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
 		return -1;
=20
-	uint32_t otype =3D k->specified & AVTAB_TRANSITION
-		? d->trans->otype : d->data;
-	if ((k->specified & AVTAB_TYPE) && validate_simpletype(otype, margs->po=
licy, margs->flavors))
+	if (k->specified & AVTAB_TRANSITION) {
+		/* if otype is set (non-zero), it must by a valid simple type */
+		if (d->trans->otype && validate_simpletype(d->trans->otype, margs->pol=
icy, margs->flavors))
+			return -1;
+
+		/* also each transition must be non empty */
+		if (!d->trans->otype &&
+		    (!d->trans->name_trans.table || !d->trans->name_trans.table->nel))
+			return -1;
+
+		/* and each filename transition must be also valid */
+		if (hashtab_map(d->trans->name_trans.table,
+				validate_name_trans_helper, margs))
+			return -1;
+	} else if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, =
margs->policy, margs->flavors)) {
 		return -1;
+	}
=20
 	if ((k->specified & AVTAB_XPERMS) && validate_xperms(d->xperms))
 		return -1;
@@ -1086,41 +1111,6 @@ bad:
 	return -1;
 }
=20
-static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d, v=
oid *args)
-{
-	const filename_trans_key_t *ftk =3D (filename_trans_key_t *)k;
-	const filename_trans_datum_t *ftd =3D d;
-	validate_t *flavors =3D (validate_t *)args;
-
-	if (validate_value(ftk->ttype, &flavors[SYM_TYPES]))
-		goto bad;
-	if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
-		goto bad;
-	if (!ftd)
-		goto bad;
-	for (; ftd; ftd =3D ftd->next) {
-		if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
-			goto bad;
-		if (validate_value(ftd->otype, &flavors[SYM_TYPES]))
-			goto bad;
-	}
-
-	return 0;
-
-bad:
-	return -1;
-}
-
-static int validate_filename_trans_hashtab(sepol_handle_t *handle, hasht=
ab_t filename_trans, validate_t flavors[])
-{
-	if (hashtab_map(filename_trans, validate_filename_trans, flavors)) {
-		ERR(handle, "Invalid filename trans");
-		return -1;
-	}
-
-	return 0;
-}
-
 static int validate_context(const context_struct_t *con, validate_t flav=
ors[], int mls)
 {
 	if (validate_value(con->user, &flavors[SYM_USERS]))
@@ -1520,9 +1510,6 @@ int policydb_validate(sepol_handle_t *handle, const=
 policydb_t *p)
 			goto bad;
 		if (validate_role_allows(handle, p->role_allow, flavors))
 			goto bad;
-		if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS)
-			if (validate_filename_trans_hashtab(handle, p->filename_trans, flavor=
s))
-				goto bad;
 	} else {
 		if (validate_avrule_blocks(handle, p->global, p, flavors))
 			goto bad;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 0d3d5f14..7f580685 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -116,6 +116,14 @@ static int avtab_write_item(policydb_t * p,
 				&& p->policyvers < POLICYDB_VERSION_AVTAB);
 	unsigned int i;
=20
+	/* skip entries which only contain filename transitions */
+	if (cur->key.specified & AVTAB_TRANSITION && !cur->datum.trans->otype) =
{
+		/* if oldvers, reduce nel, because this node will be skipped */
+		if (oldvers && nel)
+			(*nel)--;
+		return 0;
+	}
+
 	if (oldvers) {
 		/* Generate the old avtab format.
 		   Requires merging similar entries if uncond avtab. */
@@ -313,8 +321,23 @@ static int avtab_write(struct policydb *p, avtab_t *=
 a, struct policy_file *fp)
 		avtab_reset_merged(a);
 		nel =3D a->nel;
 	} else {
-		/* New avtab format.  nel is good to go. */
-		nel =3D cpu_to_le32(a->nel);
+		/*
+		 * New avtab format.  nel is good to go unless we need to skip
+		 * filename transitions.
+		 */
+		nel =3D a->nel;
+		/*
+		 * entries containing only filename transitions are skipped and
+		 * written out later
+		 */
+		for (i =3D 0; i < a->nslot; i++) {
+			for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+				if (cur->key.specified & AVTAB_TRANSITION &&
+				    !cur->datum.trans->otype)
+					nel--;
+			}
+		}
+		nel =3D cpu_to_le32(nel);
 		items =3D put_entry(&nel, sizeof(uint32_t), 1, fp);
 		if (items !=3D 1)
 			return POLICYDB_ERROR;
@@ -358,6 +381,306 @@ static int avtab_write(struct policydb *p, avtab_t =
* a, struct policy_file *fp)
 	return rc;
 }
=20
+/* policydb filename transition compatibility */
+
+typedef struct filenametr_key {
+	uint32_t ttype;
+	uint32_t tclass;
+	char *name;
+} filenametr_key_t;
+
+typedef struct filenametr_datum {
+	ebitmap_t stypes;
+	uint32_t otype;
+	struct filenametr_datum *next;
+} filenametr_datum_t;
+
+ignore_unsigned_overflow_
+static inline unsigned long
+partial_name_hash(unsigned long c, unsigned long prevhash)
+{
+	return (prevhash + (c << 4) + (c >> 4)) * 11;
+}
+
+static unsigned int filenametr_hash(hashtab_t h, const_hashtab_key_t k)
+{
+	const filenametr_key_t *ft =3D (const filenametr_key_t *)k;
+	unsigned long hash;
+	unsigned int byte_num;
+	unsigned char focus;
+
+	hash =3D ft->ttype ^ ft->tclass;
+
+	byte_num =3D 0;
+	while ((focus =3D ft->name[byte_num++]))
+		hash =3D partial_name_hash(focus, hash);
+	return hash & (h->size - 1);
+}
+
+static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
+			  const_hashtab_key_t k1, const_hashtab_key_t k2)
+{
+	const filenametr_key_t *ft1 =3D (const filenametr_key_t *)k1;
+	const filenametr_key_t *ft2 =3D (const filenametr_key_t *)k2;
+	int v;
+
+	v =3D spaceship_cmp(ft1->ttype, ft2->ttype);
+	if (v)
+		return v;
+
+	v =3D spaceship_cmp(ft1->tclass, ft2->tclass);
+	if (v)
+		return v;
+
+	return strcmp(ft1->name, ft2->name);
+}
+
+static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
+			      void *p __attribute__ ((unused)))
+{
+	filenametr_datum_t *fd =3D datum, *next;
+
+	free(key);
+	do {
+		next =3D fd->next;
+		ebitmap_destroy(&fd->stypes);
+		free(fd);
+		fd =3D next;
+	} while (fd);
+	return 0;
+}
+
+typedef struct {
+	void *fp;
+	avtab_key_t *key;
+} name_trans_write_args_t;
+
+static int name_trans_write_helper(hashtab_key_t k, hashtab_datum_t d, v=
oid *a)
+{
+	char *name =3D k;
+	uint32_t *otype =3D d;
+	name_trans_write_args_t *args =3D a;
+	size_t items;
+	uint32_t len, buf[4];
+
+	len =3D strlen(name);
+	buf[0] =3D cpu_to_le32(len);
+	items =3D put_entry(buf, sizeof(uint32_t), 1, args->fp);
+	if (items !=3D 1)
+		return -1;
+
+	items =3D put_entry(name, sizeof(char), len,args-> fp);
+	if (items !=3D len)
+		return -1;
+
+	buf[0] =3D cpu_to_le32(args->key->source_type);
+	buf[1] =3D cpu_to_le32(args->key->target_type);
+	buf[2] =3D cpu_to_le32(args->key->target_class);
+	buf[3] =3D cpu_to_le32(*otype);
+
+	items =3D put_entry(buf, sizeof(uint32_t), 4, args->fp);
+	if (items !=3D 4)
+		return -1;
+	return 0;
+}
+
+typedef struct {
+	hashtab_t fnts_tab;
+	avtab_key_t *av_key;
+} name_trans_insert_args_t;
+
+static int name_trans_insert_helper(hashtab_key_t k, hashtab_datum_t d, =
void *a)
+{
+	char *name =3D k;
+	uint32_t *otype =3D d;
+	name_trans_insert_args_t *args =3D a;
+	filenametr_key_t key, *ft =3D NULL;
+	filenametr_datum_t *last, *datum =3D NULL;
+	int rc;
+
+	key.ttype =3D args->av_key->target_type;
+	key.tclass =3D args->av_key->target_class;
+	key.name =3D name;
+
+	last =3D NULL;
+	datum =3D hashtab_search(args->fnts_tab, (hashtab_key_t)&key);
+	while (datum) {
+		if (ebitmap_get_bit(&datum->stypes, args->av_key->source_type - 1)) {
+			datum =3D NULL;
+			goto bad;
+		}
+		if (datum->otype =3D=3D *otype)
+			break;
+		last =3D datum;
+		datum =3D datum->next;
+	}
+	if (!datum) {
+		datum =3D malloc(sizeof(filenametr_datum_t));
+		if (!datum)
+			goto bad;
+
+		ebitmap_init(&datum->stypes);
+		datum->otype =3D *otype;
+		datum->next =3D NULL;
+
+		if (last) {
+			last->next =3D datum;
+		} else {
+			ft =3D malloc(sizeof(filenametr_key_t));
+			if (!ft)
+				goto bad;
+
+			ft->ttype =3D args->av_key->target_type;
+			ft->tclass =3D args->av_key->target_class;
+			ft->name =3D strdup(name);
+			if (!ft->name)
+				goto bad;
+
+			rc =3D hashtab_insert(args->fnts_tab, (hashtab_key_t)ft, datum);
+			if (rc)
+				goto bad;
+		}
+	}
+
+	return ebitmap_set_bit(&datum->stypes, args->av_key->source_type - 1, 1=
);
+
+bad:
+	if (ft !=3D NULL)
+		free(ft->name);
+	free(ft);
+	free(datum);
+	return -1;
+}
+
+static int filenametr_comp_write_one(hashtab_key_t key, void *data, void=
 *ptr)
+{
+	uint32_t buf[3];
+	size_t items, len, ndatum;
+	filenametr_key_t *ft =3D (filenametr_key_t *)key;
+	filenametr_datum_t *datum;
+	void *fp =3D ptr;
+
+	len =3D strlen(ft->name);
+	buf[0] =3D cpu_to_le32(len);
+	items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items !=3D 1)
+		return POLICYDB_ERROR;
+
+	items =3D put_entry(ft->name, sizeof(char), len, fp);
+	if (items !=3D len)
+		return POLICYDB_ERROR;
+
+	ndatum =3D 0;
+	datum =3D data;
+	do {
+		ndatum++;
+		datum =3D datum->next;
+	} while (datum);
+
+	buf[0] =3D cpu_to_le32(ft->ttype);
+	buf[1] =3D cpu_to_le32(ft->tclass);
+	buf[2] =3D cpu_to_le32(ndatum);
+	items =3D put_entry(buf, sizeof(uint32_t), 3, fp);
+	if (items !=3D 3)
+		return POLICYDB_ERROR;
+
+	datum =3D data;
+	do {
+		if (ebitmap_write(&datum->stypes, fp))
+			return POLICYDB_ERROR;
+
+		buf[0] =3D cpu_to_le32(datum->otype);
+		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items !=3D 1)
+			return POLICYDB_ERROR;
+
+		datum =3D datum->next;
+	} while (datum);
+
+	return 0;
+}
+
+static int avtab_filename_trans_write(policydb_t *pol, avtab_t *a,
+				      policy_file_t *fp)
+{
+	policydb_t *p =3D pol;
+	uint32_t buf[1];
+	int rc;
+	size_t items;
+	uint32_t i, nel =3D 0;
+	struct avtab_node *cur;
+	hashtab_t fnts_tab;
+	name_trans_write_args_t write_args =3D { .fp =3D fp };
+	name_trans_insert_args_t insert_args;
+
+	/* count number of filename transitions */
+	for (i =3D 0; i < a->nslot; i++) {
+		for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+			if (cur->key.specified & AVTAB_TRANSITION &&
+			    cur->datum.trans->name_trans.table) {
+				nel +=3D cur->datum.trans->name_trans.table->nel;
+			}
+		}
+	}
+
+	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+		buf[0] =3D cpu_to_le32(nel);
+		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items !=3D 1)
+			return -1;
+
+		/* write filename transitions */
+		for (i =3D 0; i < a->nslot; i++) {
+			for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+				if (cur->key.specified & AVTAB_TRANSITION) {
+					write_args.key =3D &cur->key;
+					rc =3D hashtab_map(cur->datum.trans->name_trans.table,
+							 name_trans_write_helper,
+							 &write_args);
+					if (rc)
+						return -1;
+				}
+			}
+		}
+		return 0;
+	}
+
+	/* init filename transitions */
+	fnts_tab =3D hashtab_create(filenametr_hash, filenametr_cmp, nel);
+	if (!fnts_tab)
+		return -1;
+	insert_args.fnts_tab =3D fnts_tab;
+
+	for (i =3D 0; i < a->nslot; i++) {
+		for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+			if (cur->key.specified & AVTAB_TRANSITION) {
+				insert_args.av_key =3D &cur->key;
+				rc =3D hashtab_map(cur->datum.trans->name_trans.table,
+						 name_trans_insert_helper,
+						 &insert_args);
+			}
+		}
+	}
+
+	rc =3D -1;
+	/* write compressed filename transitions */
+	buf[0] =3D cpu_to_le32(fnts_tab->nel);
+	items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items !=3D 1)
+		goto out;
+
+	rc =3D hashtab_map(fnts_tab, filenametr_comp_write_one, fp);
+
+out:
+	/* destroy temp filename transitions table */
+	hashtab_map(fnts_tab, filenametr_destroy, NULL);
+	hashtab_destroy(fnts_tab);
+
+	return rc ? -1 : 0;
+}
+
+/* end policydb filename transition compatibility */
+
 /*
  * Write a semantic MLS level structure to a policydb binary=20
  * representation file.
@@ -580,118 +903,6 @@ static int role_allow_write(role_allow_t * r, struc=
t policy_file *fp)
 	return POLICYDB_SUCCESS;
 }
=20
-static int filename_write_one_compat(hashtab_key_t key, void *data, void=
 *ptr)
-{
-	uint32_t bit, buf[4];
-	size_t items, len;
-	filename_trans_key_t *ft =3D (filename_trans_key_t *)key;
-	filename_trans_datum_t *datum =3D data;
-	ebitmap_node_t *node;
-	void *fp =3D ptr;
-
-	len =3D strlen(ft->name);
-	do {
-		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
-			buf[0] =3D cpu_to_le32(len);
-			items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
-			if (items !=3D 1)
-				return POLICYDB_ERROR;
-
-			items =3D put_entry(ft->name, sizeof(char), len, fp);
-			if (items !=3D len)
-				return POLICYDB_ERROR;
-
-			buf[0] =3D cpu_to_le32(bit + 1);
-			buf[1] =3D cpu_to_le32(ft->ttype);
-			buf[2] =3D cpu_to_le32(ft->tclass);
-			buf[3] =3D cpu_to_le32(datum->otype);
-			items =3D put_entry(buf, sizeof(uint32_t), 4, fp);
-			if (items !=3D 4)
-				return POLICYDB_ERROR;
-		}
-
-		datum =3D datum->next;
-	} while (datum);
-
-	return 0;
-}
-
-static int filename_write_one(hashtab_key_t key, void *data, void *ptr)
-{
-	uint32_t buf[3];
-	size_t items, len, ndatum;
-	filename_trans_key_t *ft =3D (filename_trans_key_t *)key;
-	filename_trans_datum_t *datum;
-	void *fp =3D ptr;
-
-	len =3D strlen(ft->name);
-	buf[0] =3D cpu_to_le32(len);
-	items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items !=3D 1)
-		return POLICYDB_ERROR;
-
-	items =3D put_entry(ft->name, sizeof(char), len, fp);
-	if (items !=3D len)
-		return POLICYDB_ERROR;
-
-	ndatum =3D 0;
-	datum =3D data;
-	do {
-		ndatum++;
-		datum =3D datum->next;
-	} while (datum);
-
-	buf[0] =3D cpu_to_le32(ft->ttype);
-	buf[1] =3D cpu_to_le32(ft->tclass);
-	buf[2] =3D cpu_to_le32(ndatum);
-	items =3D put_entry(buf, sizeof(uint32_t), 3, fp);
-	if (items !=3D 3)
-		return POLICYDB_ERROR;
-
-	datum =3D data;
-	do {
-		if (ebitmap_write(&datum->stypes, fp))
-			return POLICYDB_ERROR;
-
-		buf[0] =3D cpu_to_le32(datum->otype);
-		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items !=3D 1)
-			return POLICYDB_ERROR;
-
-		datum =3D datum->next;
-	} while (datum);
-
-	return 0;
-}
-
-static int filename_trans_write(struct policydb *p, void *fp)
-{
-	size_t items;
-	uint32_t buf[1];
-	int rc;
-
-	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
-		return 0;
-
-	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
-		buf[0] =3D cpu_to_le32(p->filename_trans_count);
-		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items !=3D 1)
-			return POLICYDB_ERROR;
-
-		rc =3D hashtab_map(p->filename_trans, filename_write_one_compat,
-				 fp);
-	} else {
-		buf[0] =3D cpu_to_le32(p->filename_trans->nel);
-		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items !=3D 1)
-			return POLICYDB_ERROR;
-
-		rc =3D hashtab_map(p->filename_trans, filename_write_one, fp);
-	}
-	return rc;
-}
-
 static int role_set_write(role_set_t * x, struct policy_file *fp)
 {
 	size_t items;
@@ -2202,6 +2413,21 @@ static int role_attr_uncount(hashtab_key_t key __a=
ttribute__ ((unused)),
 	return 0;
 }
=20
+static int avtab_has_filename_transitions(avtab_t *a)
+{
+	uint32_t i;
+	struct avtab_node *cur;
+	for (i =3D 0; i < a->nslot; i++) {
+		for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+			if (cur->key.specified & AVTAB_TRANSITION) {
+				if (hashtab_nel(cur->datum.trans->name_trans.table))
+					return 1;
+			}
+		}
+	}
+	return 0;
+}
+
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
@@ -2381,11 +2607,11 @@ int policydb_write(policydb_t * p, struct policy_=
file *fp)
 		if (role_allow_write(p->role_allow, fp))
 			return POLICYDB_ERROR;
 		if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS) {
-			if (filename_trans_write(p, fp))
+			if (avtab_filename_trans_write(p, &p->te_avtab, fp))
 				return POLICYDB_ERROR;
-		} else {
-			if (p->filename_trans)
-				WARN(fp->handle, "Discarding filename type transition rules");
+		} else if (avtab_has_filename_transitions(&p->te_avtab)) {
+			WARN(fp->handle,
+			     "Discarding filename type transition rules");
 		}
 	} else {
 		if (avrule_block_write(p->global, num_syms, p, fp) =3D=3D -1) {
--=20
2.40.0

