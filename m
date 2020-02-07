Return-Path: <SRS0=TwHm=33=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78109C04EB5
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 14:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEA321741
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 14:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE2WPHai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBGO6X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:58:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27698 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbgBGO6X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Feb 2020 09:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581087502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jK0Xucw33mi5YB6J0Kk7Ef//mbWU6/GciANCN+KWpzQ=;
        b=JE2WPHai3ExnOjsR2JF/o406QoGl8TDN+bArGUrbgyPovu088vDk/8PEkypJqQmnSn90qU
        3/Ohix4B2NXMY8JyTsw2vbNyU4QxE0e743dEgY5EnRMlfkOCJQhHFc+oB+OHiT4zx2SPES
        894EABfgXb45e1LLGWMyyLYsq5HnXKM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-theZ0WDvNJqueKU2X_eezQ-1; Fri, 07 Feb 2020 09:58:20 -0500
X-MC-Unique: theZ0WDvNJqueKU2X_eezQ-1
Received: by mail-wr1-f70.google.com with SMTP id t3so1340688wrm.23
        for <selinux@vger.kernel.org>; Fri, 07 Feb 2020 06:58:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jK0Xucw33mi5YB6J0Kk7Ef//mbWU6/GciANCN+KWpzQ=;
        b=kv3g/6PYKm0lY3PTHM8yxcdD5f64iHaAICHVSKI8kMCFF+YK5brJXgEJh6WbMCLsMc
         kZr28JwgAZcqsP7DnXHsB7k1fVc6/OKiP4SRH6LovNUbqTFqaWacXb5CbujV9y9H15h0
         Wum2mZqM4+SISJwfalD0KTRlw060I2pVT5uDDtZJUuArWTlwAUZTsRoZD0C8RPFoX2hY
         pYI3SM5G7MQnMLbVAj+TCi7Y6+78eJj1Ju3oTps5gfXZiS4l+uLk8+CtC59H0D8EXdKP
         D6CeQRoZuBwO2wWwb0459MoVl7C/rOnL+Lz9oy6r3NJQabxF1/MgezOVBN8HI0FT4HKm
         SWuA==
X-Gm-Message-State: APjAAAXkR9xdAWoji5SO9RJeXsxikMBXmrVpxwxQJxId36HOaRXY2tyr
        LxbJI4zMqgJjUOk12vfONTpI9BO+5gcu7SAY4t+LpKQf9YI4aj1kGtBZ9ULzGTY1bNY+yG5etR2
        Pyqm/S3hyPjR8UW/pdw==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr5039283wrm.131.1581087498659;
        Fri, 07 Feb 2020 06:58:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGYuwtQXDZLAEJTrShtBulPHFcevSXm78G7FeDBTGTfacNKx4umiSxrwpmbViX8Xi6mdP5LQ==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr5039256wrm.131.1581087498169;
        Fri, 07 Feb 2020 06:58:18 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 2sm3510520wrq.31.2020.02.07.06.58.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 06:58:17 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] libsepol/cil: remove unnecessary hash tables
Date:   Fri,  7 Feb 2020 15:58:16 +0100
Message-Id: <20200207145816.43814-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The filename_- and range_trans_table ancillary hash tables in
cil_binary.c just duplicate the final policydb content and can be simply
removed.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Maybe I'm missing something, but it seems to me that these two hash
tables serve no purpose and can be removed.

 libsepol/cil/src/cil_binary.c | 123 +++++-----------------------------
 libsepol/cil/src/cil_binary.h |   6 +-
 2 files changed, 20 insertions(+), 109 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 376491f7..03d53e1f 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -59,8 +59,6 @@
 /* There are 44000 filename_trans in current fedora policy. 1.33 times this is the recommended
  * size of a hashtable. The next power of 2 of this is 2 ** 16.
  */
-#define FILENAME_TRANS_TABLE_SIZE (1 << 16)
-#define RANGE_TRANS_TABLE_SIZE (1 << 13)
 #define ROLE_TRANS_TABLE_SIZE (1 << 10)
 #define AVRULEX_TABLE_SIZE (1 <<  10)
 #define PERMS_PER_CLASS 32
@@ -70,8 +68,6 @@ struct cil_args_binary {
 	policydb_t *pdb;
 	struct cil_list *neverallows;
 	int pass;
-	hashtab_t filename_trans_table;
-	hashtab_t range_trans_table;
 	hashtab_t role_trans_table;
 	hashtab_t avrulex_ioctl_table;
 	void **type_value_to_cil;
@@ -82,7 +78,6 @@ struct cil_args_booleanif {
 	policydb_t *pdb;
 	cond_node_t *cond_node;
 	enum cil_flavor cond_flavor;
-	hashtab_t filename_trans_table;
 };
 
 static int __cil_get_sepol_user_datum(policydb_t *pdb, struct cil_symtab_datum *datum, user_datum_t **sepol_user)
@@ -1129,7 +1124,7 @@ int cil_type_rule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	return  __cil_type_rule_to_avtab(pdb, db, cil_rule, NULL, CIL_FALSE);
 }
 
-int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_nametypetransition *typetrans, cond_node_t *cond_node, enum cil_flavor cond_flavor, hashtab_t filename_trans_table)
+int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_nametypetransition *typetrans, cond_node_t *cond_node, enum cil_flavor cond_flavor)
 {
 	int rc = SEPOL_ERR;
 	type_datum_t *sepol_src = NULL;
@@ -1179,7 +1174,6 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
 			if (rc != SEPOL_OK) goto exit;
 
 			cil_list_for_each(c, class_list) {
-				int add = CIL_TRUE;
 				rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
 				if (rc != SEPOL_OK) goto exit;
 
@@ -1191,11 +1185,13 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
 				newkey->name = cil_strdup(name);
 				newdatum->otype = sepol_result->s.value;
 
-				rc = hashtab_insert(filename_trans_table, (hashtab_key_t)newkey, newdatum);
+				rc = hashtab_insert(pdb->filename_trans,
+						    (hashtab_key_t)newkey,
+						    newdatum);
 				if (rc != SEPOL_OK) {
 					if (rc == SEPOL_EEXIST) {
-						add = CIL_FALSE;
-						otype = hashtab_search(filename_trans_table, (hashtab_key_t)newkey);
+						otype = hashtab_search(pdb->filename_trans,
+								(hashtab_key_t)newkey);
 						if (newdatum->otype != otype->otype) {
 							cil_log(CIL_ERR, "Conflicting name type transition rules\n");
 						} else {
@@ -1204,17 +1200,6 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
 					} else {
 						cil_log(CIL_ERR, "Out of memory\n");
 					}
-				}
-
-				if (add == CIL_TRUE) {
-					rc = hashtab_insert(pdb->filename_trans,
-							    (hashtab_key_t)newkey,
-							    newdatum);
-					if (rc != SEPOL_OK) {
-						cil_log(CIL_ERR, "Out of memory\n");
-						goto exit;
-					}
-				} else {
 					free(newkey->name);
 					free(newkey);
 					free(newdatum);
@@ -1235,9 +1220,9 @@ exit:
 	return rc;
 }
 
-int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_nametypetransition *typetrans, hashtab_t filename_trans_table)
+int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_nametypetransition *typetrans)
 {
-	return  __cil_typetransition_to_avtab(pdb, db, typetrans, NULL, CIL_FALSE, filename_trans_table);
+	return  __cil_typetransition_to_avtab(pdb, db, typetrans, NULL, CIL_FALSE);
 }
 
 int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t *datum)
@@ -1925,7 +1910,6 @@ int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unu
 	struct cil_type_rule *cil_type_rule;
 	struct cil_avrule *cil_avrule;
 	struct cil_nametypetransition *cil_typetrans;
-	hashtab_t filename_trans_table = args->filename_trans_table;
 
 	flavor = node->flavor;
 	switch (flavor) {
@@ -1936,7 +1920,7 @@ int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unu
 			cil_tree_log(node, CIL_ERR,"Invalid typetransition statement");
 			goto exit;
 		}
-		rc = __cil_typetransition_to_avtab(pdb, db, cil_typetrans, cond_node, cond_flavor, filename_trans_table);
+		rc = __cil_typetransition_to_avtab(pdb, db, cil_typetrans, cond_node, cond_flavor);
 		if (rc != SEPOL_OK) {
 			cil_tree_log(node, CIL_ERR, "Failed to insert type transition into avtab");
 			goto exit;
@@ -2205,7 +2189,7 @@ static int __cil_cond_expr_to_sepol_expr(policydb_t *pdb, struct cil_list *cil_e
 	return SEPOL_OK;
 }
 
-int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node, hashtab_t filename_trans_table)
+int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
 	struct cil_args_booleanif bool_args;
@@ -2280,7 +2264,6 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	bool_args.db = db;
 	bool_args.pdb = pdb;
 	bool_args.cond_node = cond_node;
-	bool_args.filename_trans_table = filename_trans_table;
 
 	if (true_node != NULL) {
 		bool_args.cond_flavor = CIL_CONDTRUE;
@@ -3089,7 +3072,7 @@ exit:
 	return rc;
 }
 
-int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_rangetransition *rangetrans, hashtab_t range_trans_table)
+int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_rangetransition *rangetrans)
 {
 	int rc = SEPOL_ERR;
 	type_datum_t *sepol_src = NULL;
@@ -3121,7 +3104,6 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, st
 			if (rc != SEPOL_OK) goto exit;
 
 			cil_list_for_each(c, class_list) {
-				int add = CIL_TRUE;
 				rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_class);
 				if (rc != SEPOL_OK) goto exit;
 
@@ -3137,11 +3119,10 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, st
 					goto exit;
 				}
 
-				rc = hashtab_insert(range_trans_table, (hashtab_key_t)newkey, newdatum);
+				rc = hashtab_insert(pdb->range_tr, (hashtab_key_t)newkey, newdatum);
 				if (rc != SEPOL_OK) {
 					if (rc == SEPOL_EEXIST) {
-						add = CIL_FALSE;
-						o_range = hashtab_search(range_trans_table, (hashtab_key_t)newkey);
+						o_range = hashtab_search(pdb->range_tr, (hashtab_key_t)newkey);
 						if (!mls_range_eq(newdatum, o_range)) {
 							cil_log(CIL_ERR, "Conflicting Range transition rules\n");
 						} else {
@@ -3150,27 +3131,13 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, st
 					} else {
 						cil_log(CIL_ERR, "Out of memory\n");
 					}
-				}
-
-				if (add == CIL_TRUE) {
-					rc = hashtab_insert(pdb->range_tr,
-							    (hashtab_key_t)newkey,
-							    newdatum);
-					if (rc != SEPOL_OK) {
-						mls_range_destroy(newdatum);
-						free(newdatum);
-						free(newkey);
-						cil_log(CIL_ERR, "Out of memory\n");
-						goto exit;
-					}
-				} else {
 					mls_range_destroy(newdatum);
 					free(newdatum);
 					free(newkey);
 					if (rc != SEPOL_OK) {
 						goto exit;
 					}
-				}	
+				}
 			}
 		}
 	}
@@ -3639,16 +3606,12 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 	struct cil_args_binary *args = extra_args;
 	const struct cil_db *db;
 	policydb_t *pdb;
-	hashtab_t filename_trans_table;
-	hashtab_t range_trans_table;
 	hashtab_t role_trans_table;
 	void **type_value_to_cil;
 
 	db = args->db;
 	pdb = args->pdb;
 	pass = args->pass;
-	filename_trans_table = args->filename_trans_table;
-	range_trans_table = args->range_trans_table;
 	role_trans_table = args->role_trans_table;
 	type_value_to_cil = args->type_value_to_cil;
 
@@ -3747,7 +3710,7 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 		  /*rc = cil_roleattributeset_to_policydb(pdb, node->data);*/
 			break;
 		case CIL_NAMETYPETRANSITION:
-			rc = cil_typetransition_to_policydb(pdb, db, node->data, filename_trans_table);
+			rc = cil_typetransition_to_policydb(pdb, db, node->data);
 			break;
 		case CIL_CONSTRAIN:
 			rc = cil_constrain_to_policydb(pdb, db, node->data);
@@ -3767,7 +3730,7 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 			break;
 		case CIL_RANGETRANSITION:
 			if (pdb->mls == CIL_TRUE) {
-				rc = cil_rangetransition_to_policydb(pdb, db, node->data, range_trans_table);
+				rc = cil_rangetransition_to_policydb(pdb, db, node->data);
 			}
 			break;
 		case CIL_DEFAULTUSER:
@@ -3785,7 +3748,7 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 	case 3:
 		switch (node->flavor) {
 		case CIL_BOOLEANIF:
-			rc = cil_booleanif_to_policydb(pdb, db, node, filename_trans_table);
+			rc = cil_booleanif_to_policydb(pdb, db, node);
 			break;
 		case CIL_AVRULE: {
 				struct cil_avrule *rule = node->data;
@@ -4193,40 +4156,6 @@ exit:
 	return rc;
 }
 
-static unsigned int filename_trans_hash(hashtab_t h, const_hashtab_key_t key)
-{
-	const filename_trans_t *k = (const filename_trans_t *)key;
-	return ((k->tclass + (k->ttype << 2) +
-				(k->stype << 9)) & (h->size - 1));
-}
-
-static int filename_trans_compare(hashtab_t h
-             __attribute__ ((unused)), const_hashtab_key_t key1,
-			              const_hashtab_key_t key2)
-{
-	const filename_trans_t *a = (const filename_trans_t *)key1;
-	const filename_trans_t *b = (const filename_trans_t *)key2;
-
-	return a->stype != b->stype || a->ttype != b->ttype || a->tclass != b->tclass || strcmp(a->name, b->name);
-}
-
-static unsigned int range_trans_hash(hashtab_t h, const_hashtab_key_t key)
-{
-	const range_trans_t *k = (const range_trans_t *)key;
-	return ((k->target_class + (k->target_type << 2) +
-				(k->source_type << 5)) & (h->size - 1));
-}
-
-static int range_trans_compare(hashtab_t h
-             __attribute__ ((unused)), const_hashtab_key_t key1,
-			              const_hashtab_key_t key2)
-{
-	const range_trans_t *a = (const range_trans_t *)key1;
-	const range_trans_t *b = (const range_trans_t *)key2;
-
-	return a->source_type != b->source_type || a->target_type != b->target_type || a->target_class != b->target_class;
-}
-
 static unsigned int role_trans_hash(hashtab_t h, const_hashtab_key_t key)
 {
 	const role_trans_t *k = (const role_trans_t *)key;
@@ -4872,8 +4801,6 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 	struct cil_args_binary extra_args;
 	policydb_t *pdb = &policydb->p;
 	struct cil_list *neverallows = NULL;
-	hashtab_t filename_trans_table = NULL;
-	hashtab_t range_trans_table = NULL;
 	hashtab_t role_trans_table = NULL;
 	hashtab_t avrulex_ioctl_table = NULL;
 	void **type_value_to_cil = NULL;
@@ -4911,18 +4838,6 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 		goto exit;
 	}
 
-	filename_trans_table = hashtab_create(filename_trans_hash, filename_trans_compare, FILENAME_TRANS_TABLE_SIZE);
-	if (!filename_trans_table) {
-		cil_log(CIL_INFO, "Failure to create hashtab for filename_trans\n");
-		goto exit;
-	}
-
-	range_trans_table = hashtab_create(range_trans_hash, range_trans_compare, RANGE_TRANS_TABLE_SIZE);
-	if (!range_trans_table) {
-		cil_log(CIL_INFO, "Failure to create hashtab for range_trans\n");
-		goto exit;
-	}
-
 	role_trans_table = hashtab_create(role_trans_hash, role_trans_compare, ROLE_TRANS_TABLE_SIZE);
 	if (!role_trans_table) {
 		cil_log(CIL_INFO, "Failure to create hashtab for role_trans\n");
@@ -4940,8 +4855,6 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 	extra_args.db = db;
 	extra_args.pdb = pdb;
 	extra_args.neverallows = neverallows;
-	extra_args.filename_trans_table = filename_trans_table;
-	extra_args.range_trans_table = range_trans_table;
 	extra_args.role_trans_table = role_trans_table;
 	extra_args.avrulex_ioctl_table = avrulex_ioctl_table;
 	extra_args.type_value_to_cil = type_value_to_cil;
@@ -5039,8 +4952,6 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 	rc = SEPOL_OK;
 
 exit:
-	hashtab_destroy(filename_trans_table);
-	hashtab_destroy(range_trans_table);
 	hashtab_destroy(role_trans_table);
 	hashtab_destroy(avrulex_ioctl_table);
 	free(type_value_to_cil);
diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
index 1004df45..0b6e3b79 100644
--- a/libsepol/cil/src/cil_binary.h
+++ b/libsepol/cil/src/cil_binary.h
@@ -263,7 +263,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_
  *
  * @return SEPOL_OK upon success or an error otherwise.
  */
-int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node, hashtab_t filename_trans_table);
+int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node);
 
 /**
  * Insert cil role transition structure into sepol policydb.
@@ -293,7 +293,7 @@ int cil_roleallow_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
  *
  * @return SEPOL_OK upon success or SEPOL_ERR upon error.
  */
-int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_nametypetransition *typetrans, hashtab_t filename_trans_table);
+int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_nametypetransition *typetrans);
 
 /**
  * Insert cil constrain/mlsconstrain structure(s) into sepol policydb.
@@ -327,7 +327,7 @@ int cil_sepol_level_define(policydb_t *pdb, struct cil_sens *cil_sens);
  *
  * @return SEPOL_OK upon success or an error otherwise.
  */
-int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_rangetransition *rangetrans, hashtab_t range_trans_table);
+int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_rangetransition *rangetrans);
 
 /**
  * Insert cil ibpkeycon structure into sepol policydb.
-- 
2.24.1

