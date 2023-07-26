Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C00C001DC
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 14:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjGZO0H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjGZO0G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 10:26:06 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D88E1B0
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:26:02 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-635eb3a1d93so49474146d6.1
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381560; x=1690986360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB6fFNftsol6VpHSlCqZ5i19m6hZJ6I4TaExXox3MOU=;
        b=FDsE3Yz5qXglGXsvPkTaWO70JKqYl1K8iDeOM2fuYmEst4mcmWN5nXw++7ey0JyXIn
         05azZjYjMSl9gL+m2iDtqoOlXR0DTuZhVG6rC7YnFoexwM7r/dyDAKLJnE5dYkWfe7jM
         6ySySBJbAy8eewnTMQjiETgUrgkc5+OxfoNwnS3Il9XE1qXD+XCKECAQoz0imo2WXD6e
         DTH07NFZWrjnGu4CK7rKwWiuBCi6dom+s6x+3xXEyHw1n+pO1CKnHNY25Iu7OGBNXqKU
         qDFdwfifCJ6ilfQI+RzqrS3cYwTPofPtPlLvhAycaPztFPa4hoYmTzwpuxIJXs1dBbLD
         FVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381560; x=1690986360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB6fFNftsol6VpHSlCqZ5i19m6hZJ6I4TaExXox3MOU=;
        b=Ep466aPZ+7z1j5z1bKmoPD395gfzIFzVMj9MrsoyPj+8H0hJ5qQYfdagtD33wKS23w
         g258iNMyDNUZg7RIQQxuQBIpjQu1gEOBt0g9tv0yhBNJREyEcWsPPBvI4kb0V5gc0l9y
         0pk6VAIaTv7zVMt0YLNBscE7jC1xzgDv79ognIRA1+oYkQGH5DMizKldId5K0FdZLuXy
         XITQIzUSKnhERYCUu7LzLCHyevG64PQa3Vw0NYgu+IgBvzhe6K2no3X23aTt3Hqtj1Wb
         M1pOJHldApfSVdJIR1QfytnQsFX1u3RdKGOV3L+qrk4Vu4GYIuvsMflUIMgl4tdCgETb
         v0/w==
X-Gm-Message-State: ABy/qLbYit7LaJLXsu4EvUNjBJL0Smml+d/5RBoJ3BLJUz8Y1AcvaOXY
        OMy+Hv2ef8faPhsdZKZpy7zGW9za5xBYyg==
X-Google-Smtp-Source: APBJJlFDvh0zrJtm41D2SC7WOtNzwvLE/dwpcOIgYPHNkwsX1HTReMW/hmFIDMw3foL5HaI2PRTdyA==
X-Received: by 2002:a0c:f086:0:b0:63c:eef6:8565 with SMTP id g6-20020a0cf086000000b0063ceef68565mr2429614qvk.39.1690381559625;
        Wed, 26 Jul 2023 07:25:59 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cf014000000b006362d4eeb6esm5066471qvk.144.2023.07.26.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:25:59 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 7/8] Revert "checkpolicy,libsepol: move filename transitions to avtab"
Date:   Wed, 26 Jul 2023 10:25:48 -0400
Message-ID: <20230726142549.94685-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
References: <20230726142549.94685-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit e169fe26530ef2c6b3dd126788cc81676359a3b3.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/checkmodule.c                  |   9 -
 checkpolicy/checkpolicy.c                  |   9 -
 checkpolicy/policy_define.c                |  21 +-
 checkpolicy/test/dispol.c                  |  83 ++--
 libsepol/cil/src/cil_binary.c              |  27 +-
 libsepol/include/sepol/policydb/avtab.h    |   9 -
 libsepol/include/sepol/policydb/hashtab.h  |   8 -
 libsepol/include/sepol/policydb/policydb.h |  22 +
 libsepol/src/avtab.c                       | 199 ---------
 libsepol/src/conditional.c                 |   6 +-
 libsepol/src/expand.c                      |  27 +-
 libsepol/src/kernel_to_cil.c               | 159 +++++--
 libsepol/src/kernel_to_common.h            |   9 -
 libsepol/src/kernel_to_conf.c              | 155 +++++--
 libsepol/src/optimize.c                    |   8 +-
 libsepol/src/policydb.c                    | 343 ++++++++++++++-
 libsepol/src/policydb_validate.c           |  69 +--
 libsepol/src/write.c                       | 463 ++++++---------------
 18 files changed, 822 insertions(+), 804 deletions(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index d81d8c97..14e6c891 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -280,15 +280,6 @@ int main(int argc, char **argv)
 		modpolicydb.mls = mlspol;
 		modpolicydb.handle_unknown = handle_unknown;
 
-		/*
-		 * Init and alloc te_avtab for filename transition duplicate
-		 * checking
-		 */
-		if (avtab_init(&modpolicydb.te_avtab))
-			exit(1);
-		if (avtab_alloc(&modpolicydb.te_avtab, 1 << 11))
-			exit(1);
-
 		if (read_source_policy(&modpolicydb, file, argv[0]) == -1) {
 			exit(1);
 		}
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 83000bcb..623ba8b2 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -615,15 +615,6 @@ int main(int argc, char **argv)
 		parse_policy.mls = mlspol;
 		parse_policy.handle_unknown = handle_unknown;
 
-		/*
-		 * Init and alloc te_avtab for filename transition duplicate
-		 * checking
-		 */
-		if (avtab_init(&parse_policy.te_avtab))
-			exit(1);
-		if (avtab_alloc(&parse_policy.te_avtab, 1 << 11))
-			exit(1);
-
 		policydbp = &parse_policy;
 
 		if (read_source_policy(policydbp, file, "checkpolicy") < 0)
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index dc2ee8f3..cef8f3c4 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3352,7 +3352,6 @@ int define_filename_trans(void)
 	ebitmap_node_t *snode, *tnode, *cnode;
 	filename_trans_rule_t *ftr;
 	type_datum_t *typdatum;
-	avtab_key_t avt_key;
 	uint32_t otype;
 	unsigned int c, s, t;
 	int add, self, rc;
@@ -3444,13 +3443,9 @@ int define_filename_trans(void)
 	ebitmap_for_each_positive_bit(&e_tclasses, cnode, c) {
 		ebitmap_for_each_positive_bit(&e_stypes, snode, s) {
 			ebitmap_for_each_positive_bit(&e_ttypes, tnode, t) {
-				avt_key.specified = AVTAB_TRANSITION;
-				avt_key.source_type = s + 1;
-				avt_key.target_type = t + 1;
-				avt_key.target_class = c + 1;
-				rc = avtab_insert_filename_trans(
-					&policydbp->te_avtab, &avt_key, otype,
-					name, NULL
+				rc = policydb_filetrans_insert(
+					policydbp, s+1, t+1, c+1, name,
+					NULL, otype, NULL
 				);
 				if (rc != SEPOL_OK) {
 					if (rc == SEPOL_EEXIST) {
@@ -3466,13 +3461,9 @@ int define_filename_trans(void)
 				}
 			}
 			if (self) {
-				avt_key.specified = AVTAB_TRANSITION;
-				avt_key.source_type = s + 1;
-				avt_key.target_type = t + 1;
-				avt_key.target_class = c + 1;
-				rc = avtab_insert_filename_trans(
-					&policydbp->te_avtab, &avt_key, otype,
-					name, NULL
+				rc = policydb_filetrans_insert(
+					policydbp, s+1, s+1, c+1, name,
+					NULL, otype, NULL
 				);
 				if (rc != SEPOL_OK) {
 					if (rc == SEPOL_EEXIST) {
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 861fa903..e45528b9 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -63,6 +63,7 @@ static struct command {
 	{CMD,       'a',  "display type attributes"},
 	{CMD,       'p',  "display the list of permissive types"},
 	{CMD,       'u',  "display unknown handling setting"},
+	{CMD,       'F',  "display filename_trans rules"},
 	{HEADER, 0, ""},
 	{CMD|NOOPT, 'f',  "set output file"},
 	{CMD|NOOPT, 'm',  "display menu"},
@@ -125,26 +126,6 @@ static int render_key(avtab_key_t * key, policydb_t * p, FILE * fp)
 	return 0;
 }
 
-typedef struct {
-	avtab_key_t *key;
-	policydb_t *p;
-	FILE *fp;
-} render_name_trans_args_t;
-
-static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
-{
-	char *name = k;
-	uint32_t *otype = d;
-	render_name_trans_args_t *args = a;
-
-	fprintf(args->fp, "type_transition ");
-	render_key(args->key, args->p, args->fp);
-	render_type(*otype, args->p, args->fp);
-	fprintf(args->fp, " \"%s\";\n", name);
-
-	return 0;
-}
-
 /* 'what' values for this function */
 #define	RENDER_UNCONDITIONAL	0x0001	/* render all regardless of enabled state */
 #define RENDER_ENABLED		0x0002
@@ -197,19 +178,10 @@ static int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t wha
 		}
 	} else if (key->specified & AVTAB_TYPE) {
 		if (key->specified & AVTAB_TRANSITION) {
-			if (datum->trans->otype) {
-				fprintf(fp, "type_transition ");
-				render_key(key, p, fp);
-				render_type(datum->trans->otype, p, fp);
-				fprintf(fp, ";\n");
-			}
-			render_name_trans_args_t args = {
-				.key = key,
-				.p = p,
-				.fp = fp,
-			};
-			hashtab_map(datum->trans->name_trans.table,
-				    render_name_trans_helper, &args);
+			fprintf(fp, "type_transition ");
+			render_key(key, p, fp);
+			render_type(datum->trans->otype, p, fp);
+			fprintf(fp, ";\n");
 		}
 		if (key->specified & AVTAB_MEMBER) {
 			fprintf(fp, "type_member ");
@@ -476,6 +448,48 @@ static void display_role_trans(policydb_t *p, FILE *fp)
 	}
 }
 
+struct filenametr_display_args {
+	policydb_t *p;
+	FILE *fp;
+};
+
+static int filenametr_display(hashtab_key_t key,
+			      hashtab_datum_t datum,
+			      void *ptr)
+{
+	struct filename_trans_key *ft = (struct filename_trans_key *)key;
+	struct filename_trans_datum *ftdatum = datum;
+	struct filenametr_display_args *args = ptr;
+	policydb_t *p = args->p;
+	FILE *fp = args->fp;
+	ebitmap_node_t *node;
+	uint32_t bit;
+
+	do {
+		ebitmap_for_each_positive_bit(&ftdatum->stypes, node, bit) {
+			display_id(p, fp, SYM_TYPES, bit, "");
+			display_id(p, fp, SYM_TYPES, ft->ttype - 1, "");
+			display_id(p, fp, SYM_CLASSES, ft->tclass - 1, ":");
+			display_id(p, fp, SYM_TYPES, ftdatum->otype - 1, "");
+			fprintf(fp, " %s\n", ft->name);
+		}
+		ftdatum = ftdatum->next;
+	} while (ftdatum);
+
+	return 0;
+}
+
+
+static void display_filename_trans(policydb_t *p, FILE *fp)
+{
+	struct filenametr_display_args args;
+
+	fprintf(fp, "filename_trans rules:\n");
+	args.p = p;
+	args.fp = fp;
+	hashtab_map(p->filename_trans, filenametr_display, &args);
+}
+
 static int menu(void)
 {
 	unsigned int i;
@@ -678,6 +692,9 @@ int main(int argc, char **argv)
 			if (out_fp != stdout)
 				printf("\nOutput to file: %s\n", OutfileName);
 			break;
+		case 'F':
+			display_filename_trans(&policydb, out_fp);
+			break;
 		case 'q':
 			policydb_destroy(&policydb);
 			exit(0);
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 7150d405..3f264594 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1005,12 +1005,7 @@ static int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src,
 	}
 	
 	existing = avtab_search_node(&pdb->te_avtab, &avtab_key);
-	/*
-	 * There might be empty transition node containing filename transitions
-	 * only. That is okay, we can merge them later.
-	 */
-	if (existing && !(existing->key.specified & AVTAB_TRANSITION &&
-	    !existing->datum.trans->otype)) {
+	if (existing) {
 		/* Don't add duplicate type rule and warn if they conflict.
 		 * A warning should have been previously given if there is a
 		 * non-duplicate rule using the same key.
@@ -1034,13 +1029,7 @@ static int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src,
 	}
 
 	if (!cond_node) {
-		/* If we have node from empty filename transition, use it */
-		if (existing && existing->key.specified & AVTAB_TRANSITION &&
-		    !existing->datum.trans->otype)
-			existing->datum.trans->otype = avtab_datum.trans->otype;
-		else
-			rc = avtab_insert(&pdb->te_avtab, &avtab_key,
-					  &avtab_datum);
+		rc = avtab_insert(&pdb->te_avtab, &avtab_key, &avtab_datum);
 	} else {
 		existing = avtab_search_node(&pdb->te_cond_avtab, &avtab_key);
 		if (existing) {
@@ -1200,18 +1189,16 @@ static int __cil_typetransition_to_avtab_helper(policydb_t *pdb,
 	class_datum_t *sepol_obj = NULL;
 	uint32_t otype;
 	struct cil_list_item *c;
-	avtab_key_t avt_key;
 
 	cil_list_for_each(c, class_list) {
 		rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
 		if (rc != SEPOL_OK) return rc;
 
-		avt_key.specified = AVTAB_TRANSITION;
-		avt_key.source_type = sepol_src->s.value;
-		avt_key.target_type = sepol_tgt->s.value;
-		avt_key.target_class = sepol_obj->s.value;
-		rc = avtab_insert_filename_trans(&pdb->te_avtab, &avt_key,
-			sepol_result->s.value, name, &otype);
+		rc = policydb_filetrans_insert(
+			pdb, sepol_src->s.value, sepol_tgt->s.value,
+			sepol_obj->s.value, name, NULL,
+			sepol_result->s.value, &otype
+		);
 		if (rc != SEPOL_OK) {
 			if (rc == SEPOL_EEXIST) {
 				if (sepol_result->s.value!= otype) {
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 5dc720cc..ca009c16 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -42,7 +42,6 @@
 
 #include <sys/types.h>
 #include <stdint.h>
-#include <sepol/policydb/symtab.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -73,7 +72,6 @@ typedef struct avtab_key {
 
 typedef struct avtab_trans {
 	uint32_t otype;		/* resulting type of the new object */
-	symtab_t name_trans;	/* filename transitions */
 } avtab_trans_t;
 
 typedef struct avtab_extended_perms {
@@ -117,8 +115,6 @@ extern int avtab_insert(avtab_t * h, avtab_key_t * k, avtab_datum_t * d);
 
 extern avtab_datum_t *avtab_search(avtab_t * h, avtab_key_t * k);
 
-extern void avtab_trans_destroy(avtab_trans_t *trans);
-
 extern void avtab_destroy(avtab_t * h);
 
 extern int avtab_map(const avtab_t * h,
@@ -152,11 +148,6 @@ extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
 /* avtab_alloc uses one bucket per 2-4 elements, so adjust to get maximum buckets */
 #define MAX_AVTAB_SIZE (MAX_AVTAB_HASH_BUCKETS << 1)
 
-extern int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
-				       uint32_t otype, const char *name,
-				       uint32_t *present_otype);
-extern int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a);
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
index 354ebb43..dca8c983 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -110,14 +110,6 @@ extern int hashtab_map(hashtab_t h,
 
 extern void hashtab_hash_eval(hashtab_t h, char *tag);
 
-/* Returns number of elements in the hashtab h or 0 is h is NULL */
-static inline uint32_t hashtab_nel(hashtab_t h)
-{
-	if (!h)
-		return 0;
-	return h->nel;
-}
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 8bb11d18..b014b7a8 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -161,6 +161,19 @@ typedef struct role_allow {
 	struct role_allow *next;
 } role_allow_t;
 
+/* filename_trans rules */
+typedef struct filename_trans_key {
+	uint32_t ttype;
+	uint32_t tclass;
+	char *name;
+} filename_trans_key_t;
+
+typedef struct filename_trans_datum {
+	ebitmap_t stypes;
+	uint32_t otype;
+	struct filename_trans_datum *next;
+} filename_trans_datum_t;
+
 /* Type attributes */
 typedef struct type_datum {
 	symtab_datum_t s;
@@ -579,6 +592,10 @@ typedef struct policydb {
 	/* range transitions table (range_trans_key -> mls_range) */
 	hashtab_t range_tr;
 
+	/* file transitions with the last path component */
+	hashtab_t filename_trans;
+	uint32_t filename_trans_count;
+
 	ebitmap_t *type_attr_map;
 
 	ebitmap_t *attr_type_map;	/* not saved in the binary policy */
@@ -637,6 +654,11 @@ extern int policydb_load_isids(policydb_t * p, sidtab_t * s);
 
 extern int policydb_sort_ocontexts(policydb_t *p);
 
+extern int policydb_filetrans_insert(policydb_t *p, uint32_t stype,
+				     uint32_t ttype, uint32_t tclass,
+				     const char *name, char **name_alloc,
+				     uint32_t otype, uint32_t *present_otype);
+
 /* Deprecated */
 extern int policydb_context_isvalid(const policydb_t * p,
 				    const context_struct_t * c);
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index eef259cf..4c292e8b 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -315,20 +315,6 @@ avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified)
 	return NULL;
 }
 
-static int avtab_trans_destroy_helper(hashtab_key_t k, hashtab_datum_t d,
-				      void *a __attribute__ ((unused)))
-{
-	free(k);
-	free(d);
-	return 0;
-}
-
-void avtab_trans_destroy(avtab_trans_t *trans)
-{
-	hashtab_map(trans->name_trans.table, avtab_trans_destroy_helper, NULL);
-	symtab_destroy(&trans->name_trans);
-}
-
 void avtab_destroy(avtab_t * h)
 {
 	unsigned int i;
@@ -343,7 +329,6 @@ void avtab_destroy(avtab_t * h)
 			if (cur->key.specified & AVTAB_XPERMS) {
 				free(cur->datum.xperms);
 			} else if (cur->key.specified & AVTAB_TRANSITION) {
-				avtab_trans_destroy(cur->datum.trans);
 				free(cur->datum.trans);
 			}
 			temp = cur;
@@ -675,187 +660,3 @@ int avtab_read(avtab_t * a, struct policy_file *fp, uint32_t vers)
 	avtab_destroy(a);
 	return -1;
 }
-
-/* policydb filename transition compatibility */
-
-int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
-				uint32_t otype, const char *name,
-				uint32_t *present_otype)
-{
-	int rc = SEPOL_ENOMEM;
-	avtab_trans_t new_trans = {0};
-	avtab_datum_t new_datum = {.trans = &new_trans};
-	avtab_datum_t *datum;
-	avtab_ptr_t node;
-	char *name_key = NULL;
-	uint32_t *otype_datum = NULL;
-
-	datum = avtab_search(a, key);
-	if (!datum) {
-		/*
-		 * insert is actually unique, but with this function we can get
-		 * the inserted node and therefore the datum
-		 */
-		node = avtab_insert_nonunique(a, key, &new_datum);
-		if (!node)
-			return SEPOL_ENOMEM;
-		datum = &node->datum;
-	}
-
-	if (!datum->trans->name_trans.table) {
-		rc = symtab_init(&datum->trans->name_trans, 1 << 8);
-		if (rc < 0)
-			return rc;
-	}
-
-	rc = SEPOL_ENOMEM;
-	name_key = strdup(name);
-	if (!name_key)
-		goto bad;
-
-	rc = SEPOL_ENOMEM;
-	otype_datum = malloc(sizeof(*otype_datum));
-	if (!otype_datum)
-		goto bad;
-	*otype_datum = otype;
-
-	rc = hashtab_insert(datum->trans->name_trans.table, name_key,
-			    otype_datum);
-	if (rc < 0)
-		goto bad;
-
-	return SEPOL_OK;
-
-bad:
-	free(name_key);
-	free(otype_datum);
-	if (rc == SEPOL_EEXIST && present_otype) {
-		otype_datum = hashtab_search(datum->trans->name_trans.table,
-					     name);
-		if (otype_datum)
-			*present_otype = *otype_datum;
-	}
-	return rc;
-}
-
-static int filename_trans_read_one(avtab_t *a, void *fp)
-{
-	int rc;
-	uint32_t buf[4], len, otype;
-	char *name = NULL;
-	avtab_key_t key;
-
-	/* read length of the name and the name */
-	rc = next_entry(buf, fp, sizeof(uint32_t));
-	if (rc < 0)
-		return SEPOL_ERR;
-	len = le32_to_cpu(*buf);
-	rc = str_read(&name, fp, len);
-	if (rc < 0)
-		return SEPOL_ERR;
-
-	/* read stype, ttype, tclass and otype */
-	rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
-	if (rc < 0)
-		goto err;
-
-	key.specified = AVTAB_TRANSITION;
-	key.source_type = le32_to_cpu(buf[0]);
-	key.target_type = le32_to_cpu(buf[1]);
-	key.target_class = le32_to_cpu(buf[2]);
-	otype = le32_to_cpu(buf[3]);
-
-	rc = avtab_insert_filename_trans(a, &key, otype, name, NULL);
-	if (rc)
-		goto err;
-
-	free(name);
-	return SEPOL_OK;
-err:
-	free(name);
-	return SEPOL_ERR;
-}
-
-static int filename_trans_comp_read_one(avtab_t *a, void *fp)
-{
-	int rc;
-	uint32_t buf[3], len, ndatum, i, bit, otype;
-	char *name = NULL;
-	avtab_key_t key;
-	ebitmap_t stypes;
-	ebitmap_node_t *node;
-
-	/* read length of the name and the name */
-	rc = next_entry(buf, fp, sizeof(uint32_t));
-	if (rc < 0)
-		return SEPOL_ERR;
-	len = le32_to_cpu(*buf);
-	rc = str_read(&name, fp, len);
-	if (rc < 0)
-		return SEPOL_ERR;
-
-	/* read ttype, tclass, ndatum */
-	rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
-	if (rc < 0)
-		goto err;
-
-	key.specified = AVTAB_TRANSITION;
-	key.target_type = le32_to_cpu(buf[0]);
-	key.target_class = le32_to_cpu(buf[1]);
-
-	ndatum = le32_to_cpu(buf[2]);
-	for (i = 0; i < ndatum; i++) {
-		rc = ebitmap_read(&stypes, fp);
-		if (rc < 0)
-			goto err;
-
-		rc = next_entry(buf, fp, sizeof(uint32_t));
-		if (rc < 0)
-			goto err_ebitmap;
-		otype = le32_to_cpu(*buf);
-
-		ebitmap_for_each_positive_bit(&stypes, node, bit) {
-			key.source_type = bit + 1;
-
-			rc = avtab_insert_filename_trans(a, &key, otype, name,
-				NULL);
-			if (rc < 0)
-				goto err_ebitmap;
-		}
-	}
-
-	free(name);
-	return SEPOL_OK;
-
-err_ebitmap:
-	ebitmap_destroy(&stypes);
-err:
-	free(name);
-	return rc;
-}
-
-int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a)
-{
-	uint32_t buf[1], nel, i;
-	int rc;
-
-	rc = next_entry(buf, fp, sizeof(uint32_t));
-	if (rc < 0)
-		return rc;
-	nel = le32_to_cpu(*buf);
-
-	if (vers < POLICYDB_VERSION_COMP_FTRANS) {
-		for (i = 0; i < nel; i++) {
-			rc = filename_trans_read_one(a, fp);
-			if (rc < 0)
-				return rc;
-		}
-	} else {
-		for (i = 0; i < nel; i++) {
-			rc = filename_trans_comp_read_one(a, fp);
-			if (rc < 0)
-				return rc;
-		}
-	}
-	return SEPOL_OK;
-}
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 7900e928..24380ea0 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -624,7 +624,6 @@ static int cond_insertf(avtab_t * a
 	struct policydb *p = data->p;
 	cond_av_list_t *other = data->other, *list, *cur;
 	avtab_ptr_t node_ptr;
-	avtab_datum_t *existing;
 	uint8_t found;
 
 	/*
@@ -633,10 +632,7 @@ static int cond_insertf(avtab_t * a
 	 * cond_te_avtab.
 	 */
 	if (k->specified & AVTAB_TYPE) {
-		existing = avtab_search(&p->te_avtab, k);
-		/* empty transition rule is not a conflict */
-		if (existing && !(k->specified & AVTAB_TRANSITION
-		    && !existing->trans->otype)) {
+		if (avtab_search(&p->te_avtab, k)) {
 			WARN(NULL, "security: type rule already exists outside of a conditional.");
 			return -1;
 		}
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 878b0f21..6793a27d 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1413,17 +1413,14 @@ static int expand_filename_trans_helper(expand_state_t *state,
 {
 	uint32_t mapped_otype, present_otype;
 	int rc;
-	avtab_key_t avt_key;
 
 	mapped_otype = state->typemap[rule->otype - 1];
 
-	avt_key.specified = AVTAB_TRANSITION;
-	avt_key.source_type = s + 1;
-	avt_key.target_type = t + 1;
-	avt_key.target_class = rule->tclass;
-
-	rc = avtab_insert_filename_trans(&state->out->te_avtab, &avt_key,
-		mapped_otype, rule->name, &present_otype);
+	rc = policydb_filetrans_insert(
+		state->out, s + 1, t + 1,
+		rule->tclass, rule->name,
+		NULL, mapped_otype, &present_otype
+	);
 	if (rc == SEPOL_EEXIST) {
 		/* duplicate rule, ignore */
 		if (present_otype == mapped_otype)
@@ -1737,16 +1734,6 @@ static int expand_terule_helper(sepol_handle_t * handle,
 		 * either in the global scope or in another
 		 * conditional AV tab */
 		node = avtab_search_node(&p->te_avtab, &avkey);
-
-		/*
-		 * if node does not already contain transition, it is not a
-		 * conflict and transition otype will be set to node found by
-		 * find_avtab_node()
-		 */
-		if (specified & AVRULE_TRANSITION && node &&
-		    !node->datum.trans->otype)
-			node = NULL;
-
 		if (node) {
 			conflict = 1;
 		} else {
@@ -1754,10 +1741,6 @@ static int expand_terule_helper(sepol_handle_t * handle,
 			if (node && node->parse_context != other) {
 				conflict = 2;
 			}
-			/*
-			 * conditional avtab does not contain filename
-			 * transitions, no need to check for otype == 0
-			 */
 		}
 
 		if (conflict) {
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 8ed695f1..316679cc 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1700,24 +1700,14 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 	return xpermsbuf;
 }
 
-static int name_trans_to_strs_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
+static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_datum_t *datum)
 {
-	char *name = k;
-	uint32_t *otype = d;
-	name_trans_to_strs_args_t *args = a;
-	return strs_create_and_add(args->strs, "(%s %s %s %s \"%s\" %s)", 6,
-				   args->flavor, args->src, args->tgt,
-				   args->class, name,
-				   args->pdb->p_type_val_to_name[*otype - 1]);
-}
-
-static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, avtab_datum_t *datum, struct strs *strs)
-{
-	int rc = SEPOL_OK;
-	uint32_t data = datum->data;
+	uint32_t data = key->specified & AVTAB_TRANSITION
+		? datum->trans->otype : datum->data;
 	type_datum_t *type;
 	const char *flavor, *tgt;
 	char *src, *class, *perms, *new;
+	char *rule = NULL;
 
 	switch (0xFFF & key->specified) {
 	case AVTAB_ALLOWED:
@@ -1750,7 +1740,7 @@ static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, avtab_datu
 		break;
 	default:
 		ERR(NULL, "Unknown avtab type: %i", key->specified);
-		return SEPOL_ERR;
+		goto exit;
 	}
 
 	src = pdb->p_type_val_to_name[key->source_type - 1];
@@ -1767,44 +1757,33 @@ static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, avtab_datu
 		perms = sepol_av_to_string(pdb, key->target_class, data);
 		if (perms == NULL) {
 			ERR(NULL, "Failed to generate permission string");
-			return SEPOL_ERR;
+			goto exit;
 		}
-		rc = strs_create_and_add(strs, "(%s %s %s (%s (%s)))", 5,
-					 flavor, src, tgt, class, perms + 1);
+		rule = create_str("(%s %s %s (%s (%s)))", 5,
+				  flavor, src, tgt, class, perms+1);
 	} else if (key->specified & AVTAB_XPERMS) {
 		perms = xperms_to_str(datum->xperms);
 		if (perms == NULL) {
 			ERR(NULL, "Failed to generate extended permission string");
-			return SEPOL_ERR;
+			goto exit;
 		}
 
-		rc = strs_create_and_add(strs, "(%s %s %s (%s %s (%s)))", 6,
-					 flavor, src, tgt, "ioctl", class, perms);
-	} else if (key->specified & AVTAB_TRANSITION) {
-		if (datum->trans->otype) {
-			rc = strs_create_and_add(strs, "(%s %s %s %s %s)", 5,
-						 flavor, src, tgt, class,
-						 pdb->p_type_val_to_name[datum->trans->otype - 1]);
-			if (rc < 0)
-				return rc;
-		}
-		name_trans_to_strs_args_t args = {
-			.pdb = pdb,
-			.strs = strs,
-			.flavor = flavor,
-			.src = src,
-			.tgt = tgt,
-			.class = class,
-		};
-		rc = hashtab_map(datum->trans->name_trans.table,
-				 name_trans_to_strs_helper, &args);
+		rule = create_str("(%s %s %s (%s %s (%s)))", 6,
+				  flavor, src, tgt, "ioctl", class, perms);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
-		rc = strs_create_and_add(strs, "(%s %s %s %s %s)", 5, flavor, src, tgt, class, new);
+		rule = create_str("(%s %s %s %s %s)", 5, flavor, src, tgt, class, new);
 	}
 
-	return rc;
+	if (!rule) {
+		goto exit;
+	}
+
+	return rule;
+
+exit:
+	return NULL;
 }
 
 struct map_avtab_args {
@@ -1819,12 +1798,23 @@ static int map_avtab_write_helper(avtab_key_t *key, avtab_datum_t *datum, void *
 	uint32_t flavor = map_args->flavor;
 	struct policydb *pdb = map_args->pdb;
 	struct strs *strs = map_args->strs;
+	char *rule;
 	int rc = 0;
 
 	if (key->specified & flavor) {
-		rc = avtab_node_to_strs(pdb, key, datum, strs);
+		rule = avtab_node_to_str(pdb, key, datum);
+		if (!rule) {
+			rc = -1;
+			goto exit;
+		}
+		rc = strs_add(strs, rule);
+		if (rc != 0) {
+			free(rule);
+			goto exit;
+		}
 	}
 
+exit:
 	return rc;
 }
 
@@ -1878,6 +1868,77 @@ exit:
 	return rc;
 }
 
+struct map_filename_trans_args {
+	struct policydb *pdb;
+	struct strs *strs;
+};
+
+static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
+{
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
+	filename_trans_datum_t *datum = data;
+	struct map_filename_trans_args *map_args = arg;
+	struct policydb *pdb = map_args->pdb;
+	struct strs *strs = map_args->strs;
+	char *src, *tgt, *class, *filename, *new;
+	struct ebitmap_node *node;
+	uint32_t bit;
+	int rc;
+
+	tgt = pdb->p_type_val_to_name[ft->ttype - 1];
+	class = pdb->p_class_val_to_name[ft->tclass - 1];
+	filename = ft->name;
+	do {
+		new = pdb->p_type_val_to_name[datum->otype - 1];
+
+		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
+			src = pdb->p_type_val_to_name[bit];
+			rc = strs_create_and_add(strs,
+						 "(typetransition %s %s %s \"%s\" %s)",
+						 5, src, tgt, class, filename, new);
+			if (rc)
+				return rc;
+		}
+
+		datum = datum->next;
+	} while (datum);
+
+	return 0;
+}
+
+static int write_filename_trans_rules_to_cil(FILE *out, struct policydb *pdb)
+{
+	struct map_filename_trans_args args;
+	struct strs *strs;
+	int rc = 0;
+
+	rc = strs_init(&strs, 100);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	args.pdb = pdb;
+	args.strs = strs;
+
+	rc = hashtab_map(pdb->filename_trans, map_filename_trans_to_str, &args);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	strs_sort(strs);
+	strs_write_each(strs, out);
+
+exit:
+	strs_free_all(strs);
+	strs_destroy(&strs);
+
+	if (rc != 0) {
+		ERR(NULL, "Error writing filename typetransition rules to CIL");
+	}
+
+	return rc;
+}
+
 static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 {
 	ebitmap_t *cats = &level->cat;
@@ -1997,6 +2058,7 @@ static int write_cond_av_list_to_cil(FILE *out, struct policydb *pdb, cond_av_li
 	avtab_key_t *key;
 	avtab_datum_t *datum;
 	struct strs *strs;
+	char *rule;
 	unsigned i;
 	int rc;
 
@@ -2012,8 +2074,14 @@ static int write_cond_av_list_to_cil(FILE *out, struct policydb *pdb, cond_av_li
 			key = &node->key;
 			datum = &node->datum;
 			if (key->specified & flavor) {
-				rc = avtab_node_to_strs(pdb, key, datum, strs);
+				rule = avtab_node_to_str(pdb, key, datum);
+				if (!rule) {
+					rc = -1;
+					goto exit;
+				}
+				rc = strs_add(strs, rule);
 				if (rc != 0) {
+					free(rule);
 					goto exit;
 				}
 			}
@@ -3261,6 +3329,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
+	rc = write_filename_trans_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	if (pdb->mls) {
 		rc = write_range_trans_rules_to_cil(out, pdb);
 		if (rc != 0) {
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index b8ea237d..9e567eb8 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -83,15 +83,6 @@ struct strs {
 	size_t size;
 };
 
-typedef struct {
-	policydb_t *pdb;
-	struct strs *strs;
-	const char *flavor;
-	const char *src;
-	const char *tgt;
-	const char *class;
-} name_trans_to_strs_args_t;
-
 void sepol_indent(FILE *out, int indent);
 __attribute__ ((format(printf, 2, 3)))
 void sepol_printf(FILE *out, const char *fmt, ...);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index eb14ccf1..aa161b08 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1678,24 +1678,13 @@ exit:
 	return rc;
 }
 
-static int name_trans_to_strs_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
+static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_datum_t *datum)
 {
-	char *name = k;
-	uint32_t *otype = d;
-	name_trans_to_strs_args_t *args = a;
-	return strs_create_and_add(args->strs, "%s %s %s:%s %s \"%s\";", 6,
-				   args->flavor, args->src, args->tgt,
-				   args->class,
-				   args->pdb->p_type_val_to_name[*otype - 1],
-				   name);
-}
-
-static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, avtab_datum_t *datum, struct strs *strs)
-{
-	int rc = SEPOL_OK;
-	uint32_t data = datum->data;
+	uint32_t data = key->specified & AVTAB_TRANSITION
+		? datum->trans->otype : datum->data;
 	type_datum_t *type;
 	const char *flavor, *src, *tgt, *class, *perms, *new;
+	char *rule = NULL;
 
 	switch (0xFFF & key->specified) {
 	case AVTAB_ALLOWED:
@@ -1728,7 +1717,7 @@ static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, avtab_datu
 		break;
 	default:
 		ERR(NULL, "Unknown avtab type: %i", key->specified);
-		return SEPOL_ERR;
+		goto exit;
 	}
 
 	src = pdb->p_type_val_to_name[key->source_type - 1];
@@ -1745,42 +1734,32 @@ static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, avtab_datu
 		perms = sepol_av_to_string(pdb, key->target_class, data);
 		if (perms == NULL) {
 			ERR(NULL, "Failed to generate permission string");
-			return SEPOL_ERR;
+			goto exit;
 		}
-		rc = strs_create_and_add(strs, "%s %s %s:%s { %s };", 5,
-					 flavor, src, tgt, class, perms + 1);
+		rule = create_str("%s %s %s:%s { %s };", 5,
+				  flavor, src, tgt, class, perms+1);
 	} else if (key->specified & AVTAB_XPERMS) {
 		perms = sepol_extended_perms_to_string(datum->xperms);
 		if (perms == NULL) {
 			ERR(NULL, "Failed to generate extended permission string");
-			return SEPOL_ERR;
-		}
-		rc = strs_create_and_add(strs, "%s %s %s:%s %s;", 5, flavor, src, tgt, class, perms);
-	} else if (key->specified & AVTAB_TRANSITION) {
-		if (datum->trans->otype) {
-			rc = strs_create_and_add(strs, "%s %s %s:%s %s;", 5,
-						 flavor, src, tgt, class,
-						 pdb->p_type_val_to_name[datum->trans->otype - 1]);
-			if (rc < 0)
-				return rc;
+			goto exit;
 		}
-		name_trans_to_strs_args_t args = {
-			.pdb = pdb,
-			.strs = strs,
-			.flavor = flavor,
-			.src = src,
-			.tgt = tgt,
-			.class = class,
-		};
-		rc = hashtab_map(datum->trans->name_trans.table,
-				 name_trans_to_strs_helper, &args);
+
+		rule = create_str("%s %s %s:%s %s;", 5, flavor, src, tgt, class, perms);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
-		rc = strs_create_and_add(strs, "%s %s %s:%s %s;", 5, flavor, src, tgt, class, new);
+		rule = create_str("%s %s %s:%s %s;", 5, flavor, src, tgt, class, new);
 	}
 
-	return rc;
+	if (!rule) {
+		goto exit;
+	}
+
+	return rule;
+
+exit:
+	return NULL;
 }
 
 struct map_avtab_args {
@@ -1795,12 +1774,23 @@ static int map_avtab_write_helper(avtab_key_t *key, avtab_datum_t *datum, void *
 	uint32_t flavor = map_args->flavor;
 	struct policydb *pdb = map_args->pdb;
 	struct strs *strs = map_args->strs;
+	char *rule;
 	int rc = 0;
 
 	if (key->specified & flavor) {
-		rc = avtab_node_to_strs(pdb, key, datum, strs);
+		rule = avtab_node_to_str(pdb, key, datum);
+		if (!rule) {
+			rc = -1;
+			goto exit;
+		}
+		rc = strs_add(strs, rule);
+		if (rc != 0) {
+			free(rule);
+			goto exit;
+		}
 	}
 
+exit:
 	return rc;
 }
 
@@ -1854,6 +1844,77 @@ exit:
 	return rc;
 }
 
+struct map_filename_trans_args {
+	struct policydb *pdb;
+	struct strs *strs;
+};
+
+static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
+{
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
+	filename_trans_datum_t *datum = data;
+	struct map_filename_trans_args *map_args = arg;
+	struct policydb *pdb = map_args->pdb;
+	struct strs *strs = map_args->strs;
+	char *src, *tgt, *class, *filename, *new;
+	struct ebitmap_node *node;
+	uint32_t bit;
+	int rc;
+
+	tgt = pdb->p_type_val_to_name[ft->ttype - 1];
+	class = pdb->p_class_val_to_name[ft->tclass - 1];
+	filename = ft->name;
+	do {
+		new = pdb->p_type_val_to_name[datum->otype - 1];
+
+		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
+			src = pdb->p_type_val_to_name[bit];
+			rc = strs_create_and_add(strs,
+						 "type_transition %s %s:%s %s \"%s\";",
+						 5, src, tgt, class, new, filename);
+			if (rc)
+				return rc;
+		}
+
+		datum = datum->next;
+	} while (datum);
+
+	return 0;
+}
+
+static int write_filename_trans_rules_to_conf(FILE *out, struct policydb *pdb)
+{
+	struct map_filename_trans_args args;
+	struct strs *strs;
+	int rc = 0;
+
+	rc = strs_init(&strs, 100);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	args.pdb = pdb;
+	args.strs = strs;
+
+	rc = hashtab_map(pdb->filename_trans, map_filename_trans_to_str, &args);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	strs_sort(strs);
+	strs_write_each(strs, out);
+
+exit:
+	strs_free_all(strs);
+	strs_destroy(&strs);
+
+	if (rc != 0) {
+		ERR(NULL, "Error writing filename typetransition rules to policy.conf");
+	}
+
+	return rc;
+}
+
 static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 {
 	ebitmap_t *cats = &level->cat;
@@ -1973,6 +2034,7 @@ static int write_cond_av_list_to_conf(FILE *out, struct policydb *pdb, cond_av_l
 	avtab_key_t *key;
 	avtab_datum_t *datum;
 	struct strs *strs;
+	char *rule;
 	unsigned i;
 	int rc;
 
@@ -1988,8 +2050,14 @@ static int write_cond_av_list_to_conf(FILE *out, struct policydb *pdb, cond_av_l
 			key = &node->key;
 			datum = &node->datum;
 			if (key->specified & flavor) {
-				rc = avtab_node_to_strs(pdb, key, datum, strs);
+				rule = avtab_node_to_str(pdb, key, datum);
+				if (!rule) {
+					rc = -1;
+					goto exit;
+				}
+				rc = strs_add(strs, rule);
 				if (rc != 0) {
+					free(rule);
 					goto exit;
 				}
 			}
@@ -3135,6 +3203,7 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 	if (rc != 0) {
 		goto exit;
 	}
+	write_filename_trans_rules_to_conf(out, pdb);
 
 	if (pdb->mls) {
 		rc = write_range_trans_rules_to_conf(out, pdb);
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 7948d983..2d4a2d7a 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -308,10 +308,8 @@ static void optimize_avtab(policydb_t *p, const struct type_vec *type_map)
 				*cur = tmp->next;
 				if (tmp->key.specified & AVTAB_XPERMS)
 					free(tmp->datum.xperms);
-				if (tmp->key.specified & AVTAB_TRANSITION) {
-					avtab_trans_destroy(tmp->datum.trans);
+				if (tmp->key.specified & AVTAB_TRANSITION)
 					free(tmp->datum.trans);
-				}
 				free(tmp);
 
 				tab->nel--;
@@ -431,10 +429,8 @@ static void optimize_cond_avtab(policydb_t *p, const struct type_vec *type_map)
 				*cur = tmp->next;
 				if (tmp->key.specified & AVTAB_XPERMS)
 					free(tmp->datum.xperms);
-				if (tmp->key.specified & AVTAB_TRANSITION) {
-					avtab_trans_destroy(tmp->datum.trans);
+				if (tmp->key.specified & AVTAB_TRANSITION)
 					free(tmp->datum.trans);
-				}
 				free(tmp);
 
 				tab->nel--;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index c1ce9c34..605d290a 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -801,6 +801,47 @@ static int roles_init(policydb_t * p)
 	goto out;
 }
 
+ignore_unsigned_overflow_
+static inline unsigned long
+partial_name_hash(unsigned long c, unsigned long prevhash)
+{
+	return (prevhash + (c << 4) + (c >> 4)) * 11;
+}
+
+static unsigned int filenametr_hash(hashtab_t h, const_hashtab_key_t k)
+{
+	const filename_trans_key_t *ft = (const filename_trans_key_t *)k;
+	unsigned long hash;
+	unsigned int byte_num;
+	unsigned char focus;
+
+	hash = ft->ttype ^ ft->tclass;
+
+	byte_num = 0;
+	while ((focus = ft->name[byte_num++]))
+		hash = partial_name_hash(focus, hash);
+	return hash & (h->size - 1);
+}
+
+static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
+			  const_hashtab_key_t k1, const_hashtab_key_t k2)
+{
+	const filename_trans_key_t *ft1 = (const filename_trans_key_t *)k1;
+	const filename_trans_key_t *ft2 = (const filename_trans_key_t *)k2;
+	int v;
+
+	v = spaceship_cmp(ft1->ttype, ft2->ttype);
+	if (v)
+		return v;
+
+	v = spaceship_cmp(ft1->tclass, ft2->tclass);
+	if (v)
+		return v;
+
+	return strcmp(ft1->name, ft2->name);
+
+}
+
 static unsigned int rangetr_hash(hashtab_t h, const_hashtab_key_t k)
 {
 	const struct range_trans *key = (const struct range_trans *)k;
@@ -868,6 +909,12 @@ int policydb_init(policydb_t * p)
 	if (rc)
 		goto err;
 
+	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp, (1 << 10));
+	if (!p->filename_trans) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
 	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
 	if (!p->range_tr) {
 		rc = -ENOMEM;
@@ -879,6 +926,7 @@ int policydb_init(policydb_t * p)
 
 	return 0;
 err:
+	hashtab_destroy(p->filename_trans);
 	hashtab_destroy(p->range_tr);
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_destroy(p->symtab[i].table);
@@ -1364,6 +1412,23 @@ static int (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
 common_destroy, class_destroy, role_destroy, type_destroy, user_destroy,
 	    cond_destroy_bool, sens_destroy, cat_destroy,};
 
+static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
+			      void *p __attribute__ ((unused)))
+{
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
+	filename_trans_datum_t *fd = datum, *next;
+
+	free(ft->name);
+	free(key);
+	do {
+		next = fd->next;
+		ebitmap_destroy(&fd->stypes);
+		free(fd);
+		fd = next;
+	} while (fd);
+	return 0;
+}
+
 static int range_tr_destroy(hashtab_key_t key, hashtab_datum_t datum,
 			    void *p __attribute__ ((unused)))
 {
@@ -1499,6 +1564,9 @@ void policydb_destroy(policydb_t * p)
 	if (lra)
 		free(lra);
 
+	hashtab_map(p->filename_trans, filenametr_destroy, NULL);
+	hashtab_destroy(p->filename_trans);
+
 	hashtab_map(p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(p->range_tr);
 
@@ -2528,6 +2596,279 @@ static int role_allow_read(role_allow_t ** r, struct policy_file *fp)
 	return 0;
 }
 
+int policydb_filetrans_insert(policydb_t *p, uint32_t stype, uint32_t ttype,
+			      uint32_t tclass, const char *name,
+			      char **name_alloc, uint32_t otype,
+			      uint32_t *present_otype)
+{
+	filename_trans_key_t *ft, key;
+	filename_trans_datum_t *datum, *last;
+
+	key.ttype = ttype;
+	key.tclass = tclass;
+	key.name = (char *)name;
+
+	last = NULL;
+	datum = hashtab_search(p->filename_trans, (hashtab_key_t)&key);
+	while (datum) {
+		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
+			if (present_otype)
+				*present_otype = datum->otype;
+			return SEPOL_EEXIST;
+		}
+		if (datum->otype == otype)
+			break;
+		last = datum;
+		datum = datum->next;
+	}
+	if (!datum) {
+		datum = malloc(sizeof(*datum));
+		if (!datum)
+			return SEPOL_ENOMEM;
+
+		ebitmap_init(&datum->stypes);
+		datum->otype = otype;
+		datum->next = NULL;
+
+		if (last) {
+			last->next = datum;
+		} else {
+			char *name_dup;
+
+			if (name_alloc) {
+				name_dup = *name_alloc;
+				*name_alloc = NULL;
+			} else {
+				name_dup = strdup(name);
+				if (!name_dup) {
+					free(datum);
+					return SEPOL_ENOMEM;
+				}
+			}
+
+			ft = malloc(sizeof(*ft));
+			if (!ft) {
+				free(name_dup);
+				free(datum);
+				return SEPOL_ENOMEM;
+			}
+
+			ft->ttype = ttype;
+			ft->tclass = tclass;
+			ft->name = name_dup;
+
+			if (hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
+					   (hashtab_datum_t)datum)) {
+				free(name_dup);
+				free(datum);
+				free(ft);
+				return SEPOL_ENOMEM;
+			}
+		}
+	}
+
+	p->filename_trans_count++;
+	return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
+}
+
+static int filename_trans_read_one_compat(policydb_t *p, struct policy_file *fp)
+{
+	uint32_t buf[4], len, stype, ttype, tclass, otype;
+	char *name = NULL;
+	int rc;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	len = le32_to_cpu(buf[0]);
+	if (zero_or_saturated(len))
+		return -1;
+
+	name = calloc(len + 1, sizeof(*name));
+	if (!name)
+		return -1;
+
+	rc = next_entry(name, fp, len);
+	if (rc < 0)
+		goto err;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
+	if (rc < 0)
+		goto err;
+
+	stype = le32_to_cpu(buf[0]);
+	if (stype == 0)
+		goto err;
+
+	ttype  = le32_to_cpu(buf[1]);
+	tclass = le32_to_cpu(buf[2]);
+	otype  = le32_to_cpu(buf[3]);
+
+	rc = policydb_filetrans_insert(p, stype, ttype, tclass, name, &name,
+				       otype, NULL);
+	if (rc) {
+		if (rc != SEPOL_EEXIST)
+			goto err;
+		/*
+		 * Some old policies were wrongly generated with
+		 * duplicate filename transition rules.  For backward
+		 * compatibility, do not reject such policies, just
+		 * ignore the duplicate.
+		 */
+	}
+	free(name);
+	return 0;
+err:
+	free(name);
+	return -1;
+}
+
+static int filename_trans_check_datum(filename_trans_datum_t *datum)
+{
+	ebitmap_t stypes, otypes;
+	int rc = -1;
+
+	ebitmap_init(&stypes);
+	ebitmap_init(&otypes);
+
+	while (datum) {
+		if (ebitmap_get_bit(&otypes, datum->otype))
+			goto out;
+
+		if (ebitmap_set_bit(&otypes, datum->otype, 1))
+			goto out;
+
+		if (ebitmap_match_any(&stypes, &datum->stypes))
+			goto out;
+
+		if (ebitmap_union(&stypes, &datum->stypes))
+			goto out;
+
+		datum = datum->next;
+	}
+	rc = 0;
+out:
+	ebitmap_destroy(&stypes);
+	ebitmap_destroy(&otypes);
+	return rc;
+}
+
+static int filename_trans_read_one(policydb_t *p, struct policy_file *fp)
+{
+	filename_trans_key_t *ft = NULL;
+	filename_trans_datum_t **dst, *datum, *first = NULL;
+	unsigned int i;
+	uint32_t buf[3], len, ttype, tclass, ndatum;
+	char *name = NULL;
+	int rc;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	len = le32_to_cpu(buf[0]);
+	if (zero_or_saturated(len))
+		return -1;
+
+	name = calloc(len + 1, sizeof(*name));
+	if (!name)
+		return -1;
+
+	rc = next_entry(name, fp, len);
+	if (rc < 0)
+		goto err;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
+	if (rc < 0)
+		goto err;
+
+	ttype = le32_to_cpu(buf[0]);
+	tclass = le32_to_cpu(buf[1]);
+	ndatum = le32_to_cpu(buf[2]);
+	if (ndatum == 0)
+		goto err;
+
+	dst = &first;
+	for (i = 0; i < ndatum; i++) {
+		datum = malloc(sizeof(*datum));
+		if (!datum)
+			goto err;
+
+		datum->next = NULL;
+		*dst = datum;
+
+		/* ebitmap_read() will at least init the bitmap */
+		rc = ebitmap_read(&datum->stypes, fp);
+		if (rc < 0)
+			goto err;
+
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			goto err;
+
+		datum->otype = le32_to_cpu(buf[0]);
+
+		p->filename_trans_count += ebitmap_cardinality(&datum->stypes);
+
+		dst = &datum->next;
+	}
+
+	if (ndatum > 1 && filename_trans_check_datum(first))
+		goto err;
+
+	ft = malloc(sizeof(*ft));
+	if (!ft)
+		goto err;
+
+	ft->ttype = ttype;
+	ft->tclass = tclass;
+	ft->name = name;
+
+	rc = hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
+			    (hashtab_datum_t)first);
+	if (rc)
+		goto err;
+
+	return 0;
+err:
+	free(ft);
+	free(name);
+	while (first) {
+		datum = first;
+		first = first->next;
+
+		ebitmap_destroy(&datum->stypes);
+		free(datum);
+	}
+	return -1;
+}
+
+static int filename_trans_read(policydb_t *p, struct policy_file *fp)
+{
+	unsigned int i;
+	uint32_t buf[1], nel;
+	int rc;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	nel = le32_to_cpu(buf[0]);
+
+	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+		for (i = 0; i < nel; i++) {
+			rc = filename_trans_read_one_compat(p, fp);
+			if (rc < 0)
+				return -1;
+		}
+	} else {
+		for (i = 0; i < nel; i++) {
+			rc = filename_trans_read_one(p, fp);
+			if (rc < 0)
+				return -1;
+		}
+	}
+	return 0;
+}
+
 static int ocontext_read_xen(const struct policydb_compat_info *info,
 	policydb_t *p, struct policy_file *fp)
 {
@@ -4129,7 +4470,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (role_allow_read(&p->role_allow, fp))
 			goto bad;
 		if (r_policyvers >= POLICYDB_VERSION_FILENAME_TRANS &&
-		    avtab_filename_trans_read(fp, r_policyvers, &p->te_avtab))
+		    filename_trans_read(p, fp))
 			goto bad;
 	} else {
 		/* first read the AV rule blocks, then the scope tables */
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 89306185..f402b506 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -829,18 +829,6 @@ static int validate_xperms(const avtab_extended_perms_t *xperms)
 bad:
 	return -1;
 }
-
-static int validate_name_trans_helper(hashtab_key_t k __attribute__ ((unused)),
-				      hashtab_datum_t d, void *a)
-{
-	uint32_t *otype = d;
-	map_arg_t *margs = a;
-
-	if (validate_simpletype(*otype, margs->policy, margs->flavors))
-		return -1;
-	return 0;
-}
-
 static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *args)
 {
 	map_arg_t *margs = args;
@@ -848,23 +836,10 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *
 	if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
 		return -1;
 
-	if (k->specified & AVTAB_TRANSITION) {
-		/* if otype is set (non-zero), it must by a valid simple type */
-		if (d->trans->otype && validate_simpletype(d->trans->otype, margs->policy, margs->flavors))
-			return -1;
-
-		/* also each transition must be non empty */
-		if (!d->trans->otype &&
-		    !hashtab_nel(d->trans->name_trans.table))
-			return -1;
-
-		/* and each filename transition must be also valid */
-		if (hashtab_map(d->trans->name_trans.table,
-				validate_name_trans_helper, margs))
-			return -1;
-	} else if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, margs->policy, margs->flavors)) {
+	uint32_t otype = k->specified & AVTAB_TRANSITION
+		? d->trans->otype : d->data;
+	if ((k->specified & AVTAB_TYPE) && validate_simpletype(otype, margs->policy, margs->flavors))
 		return -1;
-	}
 
 	if ((k->specified & AVTAB_XPERMS) && validate_xperms(d->xperms))
 		return -1;
@@ -1117,6 +1092,41 @@ bad:
 	return -1;
 }
 
+static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	const filename_trans_key_t *ftk = (filename_trans_key_t *)k;
+	const filename_trans_datum_t *ftd = d;
+	validate_t *flavors = (validate_t *)args;
+
+	if (validate_value(ftk->ttype, &flavors[SYM_TYPES]))
+		goto bad;
+	if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
+		goto bad;
+	if (!ftd)
+		goto bad;
+	for (; ftd; ftd = ftd->next) {
+		if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_value(ftd->otype, &flavors[SYM_TYPES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	return -1;
+}
+
+static int validate_filename_trans_hashtab(sepol_handle_t *handle, hashtab_t filename_trans, validate_t flavors[])
+{
+	if (hashtab_map(filename_trans, validate_filename_trans, flavors)) {
+		ERR(handle, "Invalid filename trans");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int validate_context(const context_struct_t *con, validate_t flavors[], int mls)
 {
 	if (validate_value(con->user, &flavors[SYM_USERS]))
@@ -1546,6 +1556,9 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 			goto bad;
 		if (validate_role_allows(handle, p->role_allow, flavors))
 			goto bad;
+		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS)
+			if (validate_filename_trans_hashtab(handle, p->filename_trans, flavors))
+				goto bad;
 	} else {
 		if (validate_avrule_blocks(handle, p->global, p, flavors))
 			goto bad;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index c4d593ab..0d3d5f14 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -116,14 +116,6 @@ static int avtab_write_item(policydb_t * p,
 				&& p->policyvers < POLICYDB_VERSION_AVTAB);
 	unsigned int i;
 
-	/* skip entries which only contain filename transitions */
-	if (cur->key.specified & AVTAB_TRANSITION && !cur->datum.trans->otype) {
-		/* if oldvers, reduce nel, because this node will be skipped */
-		if (oldvers && nel)
-			(*nel)--;
-		return 0;
-	}
-
 	if (oldvers) {
 		/* Generate the old avtab format.
 		   Requires merging similar entries if uncond avtab. */
@@ -321,23 +313,8 @@ static int avtab_write(struct policydb *p, avtab_t * a, struct policy_file *fp)
 		avtab_reset_merged(a);
 		nel = a->nel;
 	} else {
-		/*
-		 * New avtab format.  nel is good to go unless we need to skip
-		 * filename transitions.
-		 */
-		nel = a->nel;
-		/*
-		 * entries containing only filename transitions are skipped and
-		 * written out later
-		 */
-		for (i = 0; i < a->nslot; i++) {
-			for (cur = a->htable[i]; cur; cur = cur->next) {
-				if (cur->key.specified & AVTAB_TRANSITION &&
-				    !cur->datum.trans->otype)
-					nel--;
-			}
-		}
-		nel = cpu_to_le32(nel);
+		/* New avtab format.  nel is good to go. */
+		nel = cpu_to_le32(a->nel);
 		items = put_entry(&nel, sizeof(uint32_t), 1, fp);
 		if (items != 1)
 			return POLICYDB_ERROR;
@@ -381,307 +358,6 @@ static int avtab_write(struct policydb *p, avtab_t * a, struct policy_file *fp)
 	return rc;
 }
 
-/* policydb filename transition compatibility */
-
-typedef struct filenametr_key {
-	uint32_t ttype;
-	uint32_t tclass;
-	char *name;
-} filenametr_key_t;
-
-typedef struct filenametr_datum {
-	ebitmap_t stypes;
-	uint32_t otype;
-	struct filenametr_datum *next;
-} filenametr_datum_t;
-
-ignore_unsigned_overflow_
-static inline unsigned long
-partial_name_hash(unsigned long c, unsigned long prevhash)
-{
-	return (prevhash + (c << 4) + (c >> 4)) * 11;
-}
-
-static unsigned int filenametr_hash(hashtab_t h, const_hashtab_key_t k)
-{
-	const filenametr_key_t *ft = (const filenametr_key_t *)k;
-	unsigned long hash;
-	unsigned int byte_num;
-	unsigned char focus;
-
-	hash = ft->ttype ^ ft->tclass;
-
-	byte_num = 0;
-	while ((focus = ft->name[byte_num++]))
-		hash = partial_name_hash(focus, hash);
-	return hash & (h->size - 1);
-}
-
-static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
-			  const_hashtab_key_t k1, const_hashtab_key_t k2)
-{
-	const filenametr_key_t *ft1 = (const filenametr_key_t *)k1;
-	const filenametr_key_t *ft2 = (const filenametr_key_t *)k2;
-	int v;
-
-	v = spaceship_cmp(ft1->ttype, ft2->ttype);
-	if (v)
-		return v;
-
-	v = spaceship_cmp(ft1->tclass, ft2->tclass);
-	if (v)
-		return v;
-
-	return strcmp(ft1->name, ft2->name);
-}
-
-static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
-			      void *p __attribute__ ((unused)))
-{
-	filenametr_key_t *ft = (filenametr_key_t *)key;
-	filenametr_datum_t *fd = datum, *next;
-
-	free(ft->name);
-	free(key);
-	do {
-		next = fd->next;
-		ebitmap_destroy(&fd->stypes);
-		free(fd);
-		fd = next;
-	} while (fd);
-	return 0;
-}
-
-typedef struct {
-	void *fp;
-	avtab_key_t *key;
-} name_trans_write_args_t;
-
-static int name_trans_write_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
-{
-	char *name = k;
-	uint32_t *otype = d;
-	name_trans_write_args_t *args = a;
-	size_t items;
-	uint32_t len, buf[4];
-
-	len = strlen(name);
-	buf[0] = cpu_to_le32(len);
-	items = put_entry(buf, sizeof(uint32_t), 1, args->fp);
-	if (items != 1)
-		return -1;
-
-	items = put_entry(name, sizeof(char), len,args-> fp);
-	if (items != len)
-		return -1;
-
-	buf[0] = cpu_to_le32(args->key->source_type);
-	buf[1] = cpu_to_le32(args->key->target_type);
-	buf[2] = cpu_to_le32(args->key->target_class);
-	buf[3] = cpu_to_le32(*otype);
-
-	items = put_entry(buf, sizeof(uint32_t), 4, args->fp);
-	if (items != 4)
-		return -1;
-	return 0;
-}
-
-typedef struct {
-	hashtab_t fnts_tab;
-	avtab_key_t *av_key;
-} name_trans_insert_args_t;
-
-static int name_trans_insert_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
-{
-	char *name = k;
-	uint32_t *otype = d;
-	name_trans_insert_args_t *args = a;
-	filenametr_key_t key, *ft = NULL;
-	filenametr_datum_t *last, *datum = NULL;
-	int rc;
-
-	key.ttype = args->av_key->target_type;
-	key.tclass = args->av_key->target_class;
-	key.name = name;
-
-	last = NULL;
-	datum = hashtab_search(args->fnts_tab, (hashtab_key_t)&key);
-	while (datum) {
-		if (ebitmap_get_bit(&datum->stypes, args->av_key->source_type - 1)) {
-			datum = NULL;
-			goto bad;
-		}
-		if (datum->otype == *otype)
-			break;
-		last = datum;
-		datum = datum->next;
-	}
-	if (!datum) {
-		datum = malloc(sizeof(filenametr_datum_t));
-		if (!datum)
-			goto bad;
-
-		ebitmap_init(&datum->stypes);
-		datum->otype = *otype;
-		datum->next = NULL;
-
-		if (last) {
-			last->next = datum;
-		} else {
-			ft = malloc(sizeof(filenametr_key_t));
-			if (!ft)
-				goto bad;
-
-			ft->ttype = args->av_key->target_type;
-			ft->tclass = args->av_key->target_class;
-			ft->name = strdup(name);
-			if (!ft->name)
-				goto bad;
-
-			rc = hashtab_insert(args->fnts_tab, (hashtab_key_t)ft, datum);
-			if (rc)
-				goto bad;
-		}
-	}
-
-	return ebitmap_set_bit(&datum->stypes, args->av_key->source_type - 1, 1);
-
-bad:
-	if (ft != NULL)
-		free(ft->name);
-	free(ft);
-	free(datum);
-	return -1;
-}
-
-static int filenametr_comp_write_one(hashtab_key_t key, void *data, void *ptr)
-{
-	uint32_t buf[3];
-	size_t items, len, ndatum;
-	filenametr_key_t *ft = (filenametr_key_t *)key;
-	filenametr_datum_t *datum;
-	void *fp = ptr;
-
-	len = strlen(ft->name);
-	buf[0] = cpu_to_le32(len);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return POLICYDB_ERROR;
-
-	items = put_entry(ft->name, sizeof(char), len, fp);
-	if (items != len)
-		return POLICYDB_ERROR;
-
-	ndatum = 0;
-	datum = data;
-	do {
-		ndatum++;
-		datum = datum->next;
-	} while (datum);
-
-	buf[0] = cpu_to_le32(ft->ttype);
-	buf[1] = cpu_to_le32(ft->tclass);
-	buf[2] = cpu_to_le32(ndatum);
-	items = put_entry(buf, sizeof(uint32_t), 3, fp);
-	if (items != 3)
-		return POLICYDB_ERROR;
-
-	datum = data;
-	do {
-		if (ebitmap_write(&datum->stypes, fp))
-			return POLICYDB_ERROR;
-
-		buf[0] = cpu_to_le32(datum->otype);
-		items = put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return POLICYDB_ERROR;
-
-		datum = datum->next;
-	} while (datum);
-
-	return 0;
-}
-
-static int avtab_filename_trans_write(policydb_t *pol, avtab_t *a,
-				      policy_file_t *fp)
-{
-	policydb_t *p = pol;
-	uint32_t buf[1];
-	int rc;
-	size_t items;
-	uint32_t i, nel = 0;
-	struct avtab_node *cur;
-	hashtab_t fnts_tab;
-	name_trans_write_args_t write_args = { .fp = fp };
-	name_trans_insert_args_t insert_args;
-
-	/* count number of filename transitions */
-	for (i = 0; i < a->nslot; i++) {
-		for (cur = a->htable[i]; cur; cur = cur->next) {
-			if (cur->key.specified & AVTAB_TRANSITION) {
-				nel += hashtab_nel(cur->datum.trans->name_trans.table);
-			}
-		}
-	}
-
-	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
-		buf[0] = cpu_to_le32(nel);
-		items = put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return -1;
-
-		/* write filename transitions */
-		for (i = 0; i < a->nslot; i++) {
-			for (cur = a->htable[i]; cur; cur = cur->next) {
-				if (cur->key.specified & AVTAB_TRANSITION) {
-					write_args.key = &cur->key;
-					rc = hashtab_map(cur->datum.trans->name_trans.table,
-							 name_trans_write_helper,
-							 &write_args);
-					if (rc)
-						return -1;
-				}
-			}
-		}
-		return 0;
-	}
-
-	/* init filename transitions */
-	fnts_tab = hashtab_create(filenametr_hash, filenametr_cmp, nel);
-	if (!fnts_tab)
-		return -1;
-	insert_args.fnts_tab = fnts_tab;
-
-	for (i = 0; i < a->nslot; i++) {
-		for (cur = a->htable[i]; cur; cur = cur->next) {
-			if (cur->key.specified & AVTAB_TRANSITION) {
-				insert_args.av_key = &cur->key;
-				rc = hashtab_map(cur->datum.trans->name_trans.table,
-						 name_trans_insert_helper,
-						 &insert_args);
-			}
-		}
-	}
-
-	rc = -1;
-	/* write compressed filename transitions */
-	buf[0] = cpu_to_le32(fnts_tab->nel);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		goto out;
-
-	rc = hashtab_map(fnts_tab, filenametr_comp_write_one, fp);
-
-out:
-	/* destroy temp filename transitions table */
-	hashtab_map(fnts_tab, filenametr_destroy, NULL);
-	hashtab_destroy(fnts_tab);
-
-	return rc ? -1 : 0;
-}
-
-/* end policydb filename transition compatibility */
-
 /*
  * Write a semantic MLS level structure to a policydb binary 
  * representation file.
@@ -904,6 +580,118 @@ static int role_allow_write(role_allow_t * r, struct policy_file *fp)
 	return POLICYDB_SUCCESS;
 }
 
+static int filename_write_one_compat(hashtab_key_t key, void *data, void *ptr)
+{
+	uint32_t bit, buf[4];
+	size_t items, len;
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
+	filename_trans_datum_t *datum = data;
+	ebitmap_node_t *node;
+	void *fp = ptr;
+
+	len = strlen(ft->name);
+	do {
+		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
+			buf[0] = cpu_to_le32(len);
+			items = put_entry(buf, sizeof(uint32_t), 1, fp);
+			if (items != 1)
+				return POLICYDB_ERROR;
+
+			items = put_entry(ft->name, sizeof(char), len, fp);
+			if (items != len)
+				return POLICYDB_ERROR;
+
+			buf[0] = cpu_to_le32(bit + 1);
+			buf[1] = cpu_to_le32(ft->ttype);
+			buf[2] = cpu_to_le32(ft->tclass);
+			buf[3] = cpu_to_le32(datum->otype);
+			items = put_entry(buf, sizeof(uint32_t), 4, fp);
+			if (items != 4)
+				return POLICYDB_ERROR;
+		}
+
+		datum = datum->next;
+	} while (datum);
+
+	return 0;
+}
+
+static int filename_write_one(hashtab_key_t key, void *data, void *ptr)
+{
+	uint32_t buf[3];
+	size_t items, len, ndatum;
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
+	filename_trans_datum_t *datum;
+	void *fp = ptr;
+
+	len = strlen(ft->name);
+	buf[0] = cpu_to_le32(len);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return POLICYDB_ERROR;
+
+	items = put_entry(ft->name, sizeof(char), len, fp);
+	if (items != len)
+		return POLICYDB_ERROR;
+
+	ndatum = 0;
+	datum = data;
+	do {
+		ndatum++;
+		datum = datum->next;
+	} while (datum);
+
+	buf[0] = cpu_to_le32(ft->ttype);
+	buf[1] = cpu_to_le32(ft->tclass);
+	buf[2] = cpu_to_le32(ndatum);
+	items = put_entry(buf, sizeof(uint32_t), 3, fp);
+	if (items != 3)
+		return POLICYDB_ERROR;
+
+	datum = data;
+	do {
+		if (ebitmap_write(&datum->stypes, fp))
+			return POLICYDB_ERROR;
+
+		buf[0] = cpu_to_le32(datum->otype);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+
+		datum = datum->next;
+	} while (datum);
+
+	return 0;
+}
+
+static int filename_trans_write(struct policydb *p, void *fp)
+{
+	size_t items;
+	uint32_t buf[1];
+	int rc;
+
+	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
+		return 0;
+
+	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+		buf[0] = cpu_to_le32(p->filename_trans_count);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+
+		rc = hashtab_map(p->filename_trans, filename_write_one_compat,
+				 fp);
+	} else {
+		buf[0] = cpu_to_le32(p->filename_trans->nel);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+
+		rc = hashtab_map(p->filename_trans, filename_write_one, fp);
+	}
+	return rc;
+}
+
 static int role_set_write(role_set_t * x, struct policy_file *fp)
 {
 	size_t items;
@@ -2414,21 +2202,6 @@ static int role_attr_uncount(hashtab_key_t key __attribute__ ((unused)),
 	return 0;
 }
 
-static int avtab_has_filename_transitions(avtab_t *a)
-{
-	uint32_t i;
-	struct avtab_node *cur;
-	for (i = 0; i < a->nslot; i++) {
-		for (cur = a->htable[i]; cur; cur = cur->next) {
-			if (cur->key.specified & AVTAB_TRANSITION) {
-				if (hashtab_nel(cur->datum.trans->name_trans.table))
-					return 1;
-			}
-		}
-	}
-	return 0;
-}
-
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
@@ -2608,11 +2381,11 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 		if (role_allow_write(p->role_allow, fp))
 			return POLICYDB_ERROR;
 		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS) {
-			if (avtab_filename_trans_write(p, &p->te_avtab, fp))
+			if (filename_trans_write(p, fp))
 				return POLICYDB_ERROR;
-		} else if (avtab_has_filename_transitions(&p->te_avtab)) {
-			WARN(fp->handle,
-			     "Discarding filename type transition rules");
+		} else {
+			if (p->filename_trans)
+				WARN(fp->handle, "Discarding filename type transition rules");
 		}
 	} else {
 		if (avrule_block_write(p->global, num_syms, p, fp) == -1) {
-- 
2.41.0

