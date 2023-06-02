Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61EBC7EE24
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 13:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjFBNU2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjFBNU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 09:20:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24E1B3
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 06:20:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so2797072a12.3
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685712023; x=1688304023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GrT5uwldauU0mSaxYb+MBwFp4IQXI7HFlSGG43knGTc=;
        b=mcJP7oJBcu9jzYWWzGhVZdAX3DujUHbES5qoDW8YiiNGH/bFsK4z22MW54heb93UZz
         AKn7w1HxW2X9Lspm4Wa3EZ2vm4/81rZLn/BAjyFBjTazHurwPtuKHKRALm8xvpb3gcEr
         QcNIP/reaJRbXHFdpFoqloWKo+Agr6fQD8S66IMstAt1sbGNH00OmWvA7LrRIddavl87
         Wfs+GtlSH7hQ3vlwZ/7YCQQYIFp82SXFqbxNDLJXSs+NWxBuo1u5aRgM9G2dphpnWWxZ
         +ndNiwrnMqShu2dN0nAesuTiDHFNGdUmYNVPqIkwB173XiduveGzjAkjW4jM/KP0jaoU
         7P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685712023; x=1688304023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrT5uwldauU0mSaxYb+MBwFp4IQXI7HFlSGG43knGTc=;
        b=NvsHELeY/04Afwfad9x1zRLBytxAy0hprdJ0zOg0Vi7JS58/xfTrXwrvXPcEdg/B2O
         U4FJBfnx6BHGkphiuM9QeSKsXj8bi456nP9YPOq6ARt8/VEjqOgiI9SAtET/c5EPrzP8
         u2loVj6nemJ8ncDNF2kpm5IU3o1ZD/Ni+0ChwR+HfgMJbFU4vKR18+kfJsehtC3d+uaI
         2re+N1B+/h5TaFeguJn9/kylxIJ7QtkMwKNddyRdjG/gPclqvJYnIU6zULuok2QzZUYy
         wxNaEb6XmCr6u1J/XeCUTyLHOzycP2ELNsFT/3246RsjVusjHFIvVRZuDjSITWq7a959
         JIWw==
X-Gm-Message-State: AC+VfDx9xusJovMtr/kNZxnE8tlF+Ssq3ADn7yKw8UpemIqvfvYGLfzZ
        CQpfKOf2NeDq4z7fIOelIT5ocsoku3heoQ==
X-Google-Smtp-Source: ACHHUZ6SMUVAiX26mvQ5V8nfny+xhLo47/Y+1xpxL5pubfzEk3MsDcF3dQRKh1DQPgRikleENMwU5Q==
X-Received: by 2002:a05:6402:14c3:b0:514:8eb3:8c09 with SMTP id f3-20020a05640214c300b005148eb38c09mr1915269edx.17.1685712022653;
        Fri, 02 Jun 2023 06:20:22 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-062-107.95.112.pool.telefonica.de. [95.112.62.107])
        by smtp.gmail.com with ESMTPSA id i15-20020aa7dd0f000000b005163a6c9f18sm684077edv.53.2023.06.02.06.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:20:22 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Juraj Marcin <juraj@jurajmarcin.com>
Subject: [RFC PATCH] checkpolicy, libsepol: support name based type transitions in conditional policies
Date:   Fri,  2 Jun 2023 15:20:15 +0200
Message-Id: <20230602132015.26462-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the move of the name based type transition to the avtab structure
also support such statements in conditional policies.

TODO: CIL support

CC: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Based on top of patchset from Juraj Marcin [1].

Requires kernel support patch.

[1]: https://patchwork.kernel.org/project/selinux/list/?series=752719
---
 checkpolicy/policy_define.c             | 16 +++++-------
 checkpolicy/policy_define.h             |  3 +--
 checkpolicy/policy_parse.y              | 29 +++++++++++++--------
 checkpolicy/test/dispol.c               | 21 ++++++++++-----
 libsepol/cil/src/cil_binary.c           |  2 +-
 libsepol/include/sepol/policydb/avtab.h |  7 ++++-
 libsepol/src/avtab.c                    | 34 ++++++++++++++++++++-----
 libsepol/src/expand.c                   | 13 +++++++---
 libsepol/src/policydb.c                 |  2 +-
 9 files changed, 86 insertions(+), 41 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index c3c6af72..c294097c 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1731,7 +1731,7 @@ int define_compute_type(int which, int has_filename, uint8_t name_match)
 	return 0;
 }
 
-avrule_t *define_cond_compute_type(int which)
+avrule_t *define_cond_compute_type(int which, int has_filename, uint8_t name_match)
 {
 	char *id;
 	avrule_t *avrule;
@@ -1745,11 +1745,14 @@ avrule_t *define_cond_compute_type(int which)
 			free(id);
 		id = queue_remove(id_queue);
 		free(id);
+		if (has_filename) {
+			id = queue_remove(id_queue);
+			free(id);
+		}
 		return (avrule_t *) 1;
 	}
 
-	if (define_compute_type_helper(which, &avrule, 0,
-				       NAME_TRANS_MATCH_EXACT))
+	if (define_compute_type_helper(which, &avrule, has_filename, name_match))
 		return COND_ERR;
 
 	return avrule;
@@ -3349,13 +3352,6 @@ int define_role_allow(void)
 	return 0;
 }
 
-avrule_t *define_cond_filename_trans(void)
-{
-	yyerror("type transitions with a filename not allowed inside "
-		"conditionals\n");
-	return COND_ERR;
-}
-
 static constraint_expr_t *constraint_expr_clone(const constraint_expr_t * expr)
 {
 	constraint_expr_t *h = NULL, *l = NULL, *newe;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index c1314871..fe709061 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -12,10 +12,9 @@
 #define TRUE 1
 #define FALSE 0
 
-avrule_t *define_cond_compute_type(int which);
+avrule_t *define_cond_compute_type(int which, int has_filename, uint8_t name_match);
 avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *stmt);
 avrule_t *define_cond_te_avtab(int which);
-avrule_t *define_cond_filename_trans(void);
 cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* arg2);
 int define_attrib(void);
 int define_attrib_role(void);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 12dff7af..5bd50c16 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -414,17 +414,26 @@ cond_rule_def           : cond_transition_def
 			{ $$ = NULL; }
                         ;
 cond_transition_def	: TYPE_TRANSITION names names ':' names identifier filename ';'
-                        { $$ = define_cond_filename_trans() ;
-                          if ($$ == COND_ERR) return -1;}
+			{ $$ = define_cond_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MATCH_EXACT);
+			  if ($$ == COND_ERR) return -1;}
+			| TYPE_TRANSITION names names ':' names identifier filename MATCH_EXACT ';'
+			{ $$ = define_cond_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MATCH_EXACT);
+			  if ($$ == COND_ERR) return -1;}
+			| TYPE_TRANSITION names names ':' names identifier filename MATCH_PREFIX ';'
+			{ $$ = define_cond_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MATCH_PREFIX);
+			  if ($$ == COND_ERR) return -1;}
+			| TYPE_TRANSITION names names ':' names identifier filename MATCH_SUFFIX ';'
+			{ $$ = define_cond_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MATCH_SUFFIX);
+			  if ($$ == COND_ERR) return -1; }
 			| TYPE_TRANSITION names names ':' names identifier ';'
-                        { $$ = define_cond_compute_type(AVRULE_TRANSITION) ;
-                          if ($$ == COND_ERR) return -1;}
-                        | TYPE_MEMBER names names ':' names identifier ';'
-                        { $$ = define_cond_compute_type(AVRULE_MEMBER) ;
-                          if ($$ ==  COND_ERR) return -1;}
-                        | TYPE_CHANGE names names ':' names identifier ';'
-                        { $$ = define_cond_compute_type(AVRULE_CHANGE) ;
-                          if ($$ == COND_ERR) return -1;}
+			{ $$ = define_cond_compute_type(AVRULE_TRANSITION, 0, NAME_TRANS_MATCH_EXACT) ;
+			  if ($$ == COND_ERR) return -1;}
+			| TYPE_MEMBER names names ':' names identifier ';'
+			{ $$ = define_cond_compute_type(AVRULE_MEMBER, 0, NAME_TRANS_MATCH_EXACT) ;
+			  if ($$ ==  COND_ERR) return -1;}
+			| TYPE_CHANGE names names ':' names identifier ';'
+			{ $$ = define_cond_compute_type(AVRULE_CHANGE, 0, NAME_TRANS_MATCH_EXACT) ;
+			  if ($$ == COND_ERR) return -1;}
     			;
 cond_te_avtab_def	: cond_allow_def
                           { $$ = $1; }
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 87cd6a32..9e35b33a 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -78,11 +78,18 @@ static int render_key(avtab_key_t * key, policydb_t * p, FILE * fp)
 	return 0;
 }
 
+/* 'what' values for this function */
+#define	RENDER_UNCONDITIONAL	0x0001	/* render all regardless of enabled state */
+#define RENDER_ENABLED		0x0002
+#define RENDER_DISABLED		0x0004
+#define RENDER_CONDITIONAL	(RENDER_ENABLED|RENDER_DISABLED)
+
 typedef struct {
 	avtab_key_t *key;
 	policydb_t *p;
 	FILE *fp;
 	uint8_t match;
+	uint32_t what;
 } render_name_trans_args_t;
 
 static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
@@ -91,6 +98,13 @@ static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
 	uint32_t *otype = d;
 	render_name_trans_args_t *args = a;
 
+	if (!(args->what & RENDER_UNCONDITIONAL)) {
+		if (args->key->specified & AVTAB_ENABLED)
+			fprintf(args->fp, "[enabled] ");
+		else if (!(args->key->specified & AVTAB_ENABLED))
+			fprintf(args->fp, "[disabled] ");
+	}
+
 	fprintf(args->fp, "type_transition ");
 	render_key(args->key, args->p, args->fp);
 	render_type(*otype, args->p, args->fp);
@@ -114,12 +128,6 @@ static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
 	return 0;
 }
 
-/* 'what' values for this function */
-#define	RENDER_UNCONDITIONAL	0x0001	/* render all regardless of enabled state */
-#define RENDER_ENABLED		0x0002
-#define RENDER_DISABLED		0x0004
-#define RENDER_CONDITIONAL	(RENDER_ENABLED|RENDER_DISABLED)
-
 static int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t what,
 		   policydb_t * p, FILE * fp)
 {
@@ -177,6 +185,7 @@ static int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t wha
 				.p = p,
 				.fp = fp,
 				.match = NAME_TRANS_MATCH_EXACT,
+				.what = what,
 			};
 			hashtab_map(datum->trans->name_trans.table,
 				    render_name_trans_helper, &args);
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ea0cef32..432ab307 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1210,7 +1210,7 @@ static int __cil_typetransition_to_avtab_helper(policydb_t *pdb,
 		avt_key.source_type = sepol_src->s.value;
 		avt_key.target_type = sepol_tgt->s.value;
 		avt_key.target_class = sepol_obj->s.value;
-		rc = avtab_insert_filename_trans(&pdb->te_avtab, &avt_key,
+		rc = avtab_insert_filename_trans(&pdb->te_avtab, &avt_key, NULL, 0,
 			sepol_result->s.value, name, name_match,
 			&otype);
 		if (rc != SEPOL_OK) {
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 7d892879..f70e25fd 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -154,11 +154,16 @@ extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
 /* avtab_alloc uses one bucket per 2-4 elements, so adjust to get maximum buckets */
 #define MAX_AVTAB_SIZE (MAX_AVTAB_HASH_BUCKETS << 1)
 
+/* forward declaration to avoid avtab.h <-> conditional.h include cycle */
+struct cond_av_list;
+typedef struct cond_av_list cond_av_list_t;
+
 extern int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
+				       cond_av_list_t ** cond, int enabled,
 				       uint32_t otype, const char *name,
 				       uint8_t name_match,
 				       uint32_t *present_otype);
-extern int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a);
+extern int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a, cond_av_list_t ** cond, int enabled);
 
 #ifdef __cplusplus
 }
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 5dc7cc59..a9fd46d7 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -43,6 +43,7 @@
 
 #include <stdlib.h>
 #include <sepol/policydb/avtab.h>
+#include <sepol/policydb/conditional.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/errcodes.h>
 
@@ -770,6 +771,7 @@ int avtab_read(avtab_t * a, struct policy_file *fp, uint32_t vers)
 /* policydb filename transition compatibility */
 
 int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
+				cond_av_list_t ** cond, int enabled,
 				uint32_t otype, const char *name,
 				uint8_t name_match, uint32_t *present_otype)
 {
@@ -792,6 +794,24 @@ int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
 		if (!node)
 			return SEPOL_ENOMEM;
 		datum = &node->datum;
+		if (cond) {
+			cond_av_list_t *nl;
+
+			node->parse_context = cond;
+			nl = malloc(sizeof(cond_av_list_t));
+			if (!nl)
+				return SEPOL_ENOMEM;
+			*nl = (cond_av_list_t) {
+				.node = node,
+				.next = *cond,
+			};
+			*cond = nl;
+
+			if (enabled)
+				node->key.specified |= AVTAB_ENABLED;
+			else
+				node->key.specified &= ~AVTAB_ENABLED;
+		}
 	}
 
 	switch (name_match) {
@@ -841,7 +861,7 @@ bad:
 	return rc;
 }
 
-static int filename_trans_read_one(avtab_t *a, void *fp)
+static int filename_trans_read_one(avtab_t *a, cond_av_list_t ** cond, int enabled, void *fp)
 {
 	int rc;
 	uint32_t buf[4], len, otype;
@@ -868,7 +888,7 @@ static int filename_trans_read_one(avtab_t *a, void *fp)
 	key.target_class = le32_to_cpu(buf[2]);
 	otype = le32_to_cpu(buf[3]);
 
-	rc = avtab_insert_filename_trans(a, &key, otype, name,
+	rc = avtab_insert_filename_trans(a, &key, cond, enabled, otype, name,
 					 NAME_TRANS_MATCH_EXACT, NULL);
 	if (rc)
 		goto err;
@@ -880,7 +900,7 @@ err:
 	return SEPOL_ERR;
 }
 
-static int filename_trans_comp_read_one(avtab_t *a, void *fp)
+static int filename_trans_comp_read_one(avtab_t *a, cond_av_list_t ** cond, int enabled, void *fp)
 {
 	int rc;
 	uint32_t buf[3], len, ndatum, i, bit, otype;
@@ -921,7 +941,7 @@ static int filename_trans_comp_read_one(avtab_t *a, void *fp)
 		ebitmap_for_each_positive_bit(&stypes, node, bit) {
 			key.source_type = bit + 1;
 
-			rc = avtab_insert_filename_trans(a, &key, otype, name,
+			rc = avtab_insert_filename_trans(a, &key, cond, enabled, otype, name,
 							 NAME_TRANS_MATCH_EXACT,
 							 NULL);
 			if (rc < 0)
@@ -939,7 +959,7 @@ err:
 	return rc;
 }
 
-int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a)
+int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a, cond_av_list_t ** cond, int enabled)
 {
 	uint32_t buf[1], nel, i;
 	int rc;
@@ -951,13 +971,13 @@ int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a)
 
 	if (vers < POLICYDB_VERSION_COMP_FTRANS) {
 		for (i = 0; i < nel; i++) {
-			rc = filename_trans_read_one(a, fp);
+			rc = filename_trans_read_one(a, cond, enabled, fp);
 			if (rc < 0)
 				return rc;
 		}
 	} else {
 		for (i = 0; i < nel; i++) {
-			rc = filename_trans_comp_read_one(a, fp);
+			rc = filename_trans_comp_read_one(a, cond, enabled, fp);
 			if (rc < 0)
 				return rc;
 		}
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 43f8ab3f..854aba35 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1651,6 +1651,8 @@ static int expand_terule_helper(sepol_handle_t * handle,
 		 */
 		if (specified & AVRULE_TRANSITION && object_name) {
 			int rc = avtab_insert_filename_trans(avtab, &avkey,
+							     cond,
+							     enabled,
 							     remapped_data,
 							     object_name,
 							     name_match,
@@ -1692,10 +1694,15 @@ static int expand_terule_helper(sepol_handle_t * handle,
 			if (node && node->parse_context != other) {
 				conflict = 2;
 			}
+
 			/*
-			 * conditional avtab does not contain filename
-			 * transitions, no need to check for otype == 0
-			 */
+			* if node does not already contain transition, it is not a
+			* conflict and transition otype will be set to node found by
+			* find_avtab_node()
+			*/
+			if (specified & AVRULE_TRANSITION && node &&
+			         !node->datum.trans->otype)
+				conflict = 0;
 		}
 
 		if (conflict) {
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 594b875e..6c23eee2 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4163,7 +4163,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 		if (r_policyvers >= POLICYDB_VERSION_FILENAME_TRANS &&
 		    r_policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
-		    avtab_filename_trans_read(fp, r_policyvers, &p->te_avtab))
+		    avtab_filename_trans_read(fp, r_policyvers, &p->te_avtab, NULL, 0))
 			goto bad;
 	} else {
 		/* first read the AV rule blocks, then the scope tables */
-- 
2.40.1

