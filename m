Return-Path: <SRS0=eLZI=A6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A24C433E0
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 10:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2222064B
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 10:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSx3awzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgGSKfT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Jul 2020 06:35:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41896 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgGSKfS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Jul 2020 06:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595154915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4oUrTAu9zBLaveA6E86erD2ib6tboBu4C4de9Vx6RgQ=;
        b=KSx3awzDrd9islCLrxVzkINPNnSHhnBkyf6BUmGu/XiVP2rMksoOssrDYe8kwrNLjV/IDZ
        Z5ChTM12LFZCKG9G7El23qg6CiBczdP1h0rj1gS8dr1Ts4t7op+7CslTyIXHc6VLFra2mA
        ICC6I9AubNh4i5Ql6tC3pRSAVC7QpwM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-WmKEatvEPR6icF3pB04RYQ-1; Sun, 19 Jul 2020 06:35:12 -0400
X-MC-Unique: WmKEatvEPR6icF3pB04RYQ-1
Received: by mail-wm1-f72.google.com with SMTP id g187so12999167wme.0
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 03:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4oUrTAu9zBLaveA6E86erD2ib6tboBu4C4de9Vx6RgQ=;
        b=r0OCqyXvsg78NNhKM9J8OLZMipGZsLiUU1YaWG/4Iv5TrGMzdj/9qJCY1JtzfWLV2O
         aLHc9UIImN4eDFvV1qdVS1RSKHxPxAElJzcgDQiGg0zNj55IanrvLd2JMMhWufGcMYN9
         JGay/6F49HnmlWB0tdwgey83DarbVrcN9PvPOiEAHx5BEjrR0MT2CsHcBe30azpfQXEa
         +1HR8XN7XkrMwQCNKXAorbzvNSC4Fl3J20b1bQAh+V63MwA64Ja52tTNPvYdvYYqEpRT
         f2RCFkACctvRSBlBEk8W5hjrhswphgp1jx1o9Gjp6teJr2sRoJmM9j0jHTSer7PbdZYB
         JVmw==
X-Gm-Message-State: AOAM533wT2yfbU7Y86MA6kW9h3ex/7PyKx6MV2+VdskXYUsHdsObW2f3
        kcMjTVWqiB8wksfqw74RGZE8yhvM2q+N5nH0hjgEnqcFZmoiAaVCp0FsJg3qA0nDw3U0SS7OXQs
        j9k3l1oNCTalTYUzMDg==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr16625830wru.147.1595154911047;
        Sun, 19 Jul 2020 03:35:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE8U+XexnxbxHI7UmMKCI+HwG0rQmqKodAPB/Sc+GXTg9QiS3eJfZhvKLOdm+rhEUSLOOAXQ==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr16625805wru.147.1595154910647;
        Sun, 19 Jul 2020 03:35:10 -0700 (PDT)
Received: from omos.redhat.com (adsl-dyn227.91-127-10.t-com.sk. [91.127.10.227])
        by smtp.gmail.com with ESMTPSA id n16sm28468498wra.19.2020.07.19.03.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 03:35:10 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v5 1/2] libsepol,checkpolicy: optimize storage of filename transitions
Date:   Sun, 19 Jul 2020 12:35:05 +0200
Message-Id: <20200719103506.865962-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719103506.865962-1-omosnace@redhat.com>
References: <20200719103506.865962-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In preparation to support a new policy format with a more optimal
representation of filename transition rules, this patch applies an
equivalent change from kernel commit c3a276111ea2 ("selinux: optimize
storage of filename transitions").

See the kernel commit's description [1] for the rationale behind this
representation. This change doesn't bring any measurable difference of
policy build performance (semodule -B) on Fedora.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 checkpolicy/policy_define.c                |  52 +++------
 checkpolicy/test/dispol.c                  |  20 ++--
 libsepol/cil/src/cil_binary.c              |  29 ++---
 libsepol/include/sepol/policydb/policydb.h |  15 ++-
 libsepol/src/expand.c                      |  60 +++--------
 libsepol/src/kernel_to_cil.c               |  24 ++++-
 libsepol/src/kernel_to_conf.c              |  24 ++++-
 libsepol/src/policydb.c                    | 117 +++++++++++++++------
 libsepol/src/write.c                       |  46 ++++----
 9 files changed, 212 insertions(+), 175 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index c6733fa4..01a90438 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3303,10 +3303,9 @@ int define_filename_trans(void)
 	ebitmap_t e_stypes, e_ttypes;
 	ebitmap_t e_tclasses;
 	ebitmap_node_t *snode, *tnode, *cnode;
-	filename_trans_t *ft;
-	filename_trans_datum_t *ftdatum;
 	filename_trans_rule_t *ftr;
 	type_datum_t *typdatum;
+	char *dup_name;
 	uint32_t otype;
 	unsigned int c, s, t;
 	int add, rc;
@@ -3388,40 +3387,21 @@ int define_filename_trans(void)
 	ebitmap_for_each_positive_bit(&e_tclasses, cnode, c) {
 		ebitmap_for_each_positive_bit(&e_stypes, snode, s) {
 			ebitmap_for_each_positive_bit(&e_ttypes, tnode, t) {
-				ft = calloc(1, sizeof(*ft));
-				if (!ft) {
-					yyerror("out of memory");
-					goto bad;
-				}
-				ft->stype = s+1;
-				ft->ttype = t+1;
-				ft->tclass = c+1;
-				ft->name = strdup(name);
-				if (!ft->name) {
-					yyerror("out of memory");
-					goto bad;
-				}
-
-				ftdatum = hashtab_search(policydbp->filename_trans,
-							 (hashtab_key_t)ft);
-				if (ftdatum) {
-					yyerror2("duplicate filename transition for: filename_trans %s %s %s:%s",
-						 name,
-						 policydbp->p_type_val_to_name[s],
-						 policydbp->p_type_val_to_name[t],
-						 policydbp->p_class_val_to_name[c]);
-					goto bad;
-				}
-
-				ftdatum = calloc(1, sizeof(*ftdatum));
-				if (!ftdatum) {
-					yyerror("out of memory");
-					goto bad;
-				}
-				rc = hashtab_insert(policydbp->filename_trans,
-						    (hashtab_key_t)ft,
-						    ftdatum);
-				if (rc) {
+				dup_name = NULL;
+				rc = policydb_filetrans_insert(
+					policydbp, s+1, t+1, c+1, name,
+					&dup_name, otype, NULL
+				);
+				free(dup_name);
+				if (rc != SEPOL_OK) {
+					if (rc == SEPOL_EEXIST) {
+						yyerror2("duplicate filename transition for: filename_trans %s %s %s:%s",
+							name,
+							policydbp->p_type_val_to_name[s],
+							policydbp->p_type_val_to_name[t],
+							policydbp->p_class_val_to_name[c]);
+						goto bad;
+					}
 					yyerror("out of memory");
 					goto bad;
 				}
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index d72d9fb3..8785b725 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -335,17 +335,25 @@ static int filenametr_display(hashtab_key_t key,
 			      hashtab_datum_t datum,
 			      void *ptr)
 {
-	struct filename_trans *ft = (struct filename_trans *)key;
+	struct filename_trans_key *ft = (struct filename_trans_key *)key;
 	struct filename_trans_datum *ftdatum = datum;
 	struct filenametr_display_args *args = ptr;
 	policydb_t *p = args->p;
 	FILE *fp = args->fp;
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
 
-	display_id(p, fp, SYM_TYPES, ft->stype - 1, "");
-	display_id(p, fp, SYM_TYPES, ft->ttype - 1, "");
-	display_id(p, fp, SYM_CLASSES, ft->tclass - 1, ":");
-	display_id(p, fp, SYM_TYPES, ftdatum->otype - 1, "");
-	fprintf(fp, " %s\n", ft->name);
 	return 0;
 }
 
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 62178d99..bedff628 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1131,13 +1131,13 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
 	class_datum_t *sepol_obj = NULL;
 	struct cil_list *class_list;
 	type_datum_t *sepol_result = NULL;
-	filename_trans_t *newkey = NULL;
-	filename_trans_datum_t *newdatum = NULL, *otype = NULL;
 	ebitmap_t src_bitmap, tgt_bitmap;
 	ebitmap_node_t *node1, *node2;
 	unsigned int i, j;
+	uint32_t otype;
 	struct cil_list_item *c;
 	char *name = DATUM(typetrans->name)->name;
+	char *dup_name;
 
 	if (name == CIL_KEY_STAR) {
 		struct cil_type_rule trans;
@@ -1176,22 +1176,16 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
 				rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
 				if (rc != SEPOL_OK) goto exit;
 
-				newkey = cil_calloc(1, sizeof(*newkey));
-				newdatum = cil_calloc(1, sizeof(*newdatum));
-				newkey->stype = sepol_src->s.value;
-				newkey->ttype = sepol_tgt->s.value;
-				newkey->tclass = sepol_obj->s.value;
-				newkey->name = cil_strdup(name);
-				newdatum->otype = sepol_result->s.value;
-
-				rc = hashtab_insert(pdb->filename_trans,
-						    (hashtab_key_t)newkey,
-						    newdatum);
+				dup_name = NULL;
+				rc = policydb_filetrans_insert(
+					pdb, sepol_src->s.value, sepol_tgt->s.value,
+					sepol_obj->s.value, name, &dup_name,
+					sepol_result->s.value, &otype
+				);
+				free(dup_name);
 				if (rc != SEPOL_OK) {
 					if (rc == SEPOL_EEXIST) {
-						otype = hashtab_search(pdb->filename_trans,
-								(hashtab_key_t)newkey);
-						if (newdatum->otype != otype->otype) {
+						if (sepol_result->s.value!= otype) {
 							cil_log(CIL_ERR, "Conflicting name type transition rules\n");
 						} else {
 							rc = SEPOL_OK;
@@ -1199,9 +1193,6 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
 					} else {
 						cil_log(CIL_ERR, "Out of memory\n");
 					}
-					free(newkey->name);
-					free(newkey);
-					free(newdatum);
 					if (rc != SEPOL_OK) {
 						goto exit;
 					}
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 81b63fef..c3180c61 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -162,15 +162,16 @@ typedef struct role_allow {
 } role_allow_t;
 
 /* filename_trans rules */
-typedef struct filename_trans {
-	uint32_t stype;
+typedef struct filename_trans_key {
 	uint32_t ttype;
 	uint32_t tclass;
 	char *name;
-} filename_trans_t;
+} filename_trans_key_t;
 
 typedef struct filename_trans_datum {
-	uint32_t otype;		/* expected of new object */
+	ebitmap_t stypes;
+	uint32_t otype;
+	struct filename_trans_datum *next;
 } filename_trans_datum_t;
 
 /* Type attributes */
@@ -591,6 +592,7 @@ typedef struct policydb {
 
 	/* file transitions with the last path component */
 	hashtab_t filename_trans;
+	uint32_t filename_trans_count;
 
 	ebitmap_t *type_attr_map;
 
@@ -650,6 +652,11 @@ extern int policydb_load_isids(policydb_t * p, sidtab_t * s);
 
 extern int policydb_sort_ocontexts(policydb_t *p);
 
+extern int policydb_filetrans_insert(policydb_t *p, uint32_t stype,
+				     uint32_t ttype, uint32_t tclass,
+				     const char *name, char **name_alloc,
+				     uint32_t otype, uint32_t *present_otype);
+
 /* Deprecated */
 extern int policydb_context_isvalid(const policydb_t * p,
 				    const context_struct_t * c);
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 529e1d35..28f93acb 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1371,16 +1371,15 @@ static int copy_role_trans(expand_state_t * state, role_trans_rule_t * rules)
 static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *rules)
 {
 	unsigned int i, j;
-	filename_trans_t key, *new_trans;
-	filename_trans_datum_t *otype;
 	filename_trans_rule_t *cur_rule;
 	ebitmap_t stypes, ttypes;
 	ebitmap_node_t *snode, *tnode;
+	char *name;
 	int rc;
 
 	cur_rule = rules;
 	while (cur_rule) {
-		uint32_t mapped_otype;
+		uint32_t mapped_otype, present_otype;
 
 		ebitmap_init(&stypes);
 		ebitmap_init(&ttypes);
@@ -1401,15 +1400,17 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
 
 		ebitmap_for_each_positive_bit(&stypes, snode, i) {
 			ebitmap_for_each_positive_bit(&ttypes, tnode, j) {
-				key.stype = i + 1;
-				key.ttype = j + 1;
-				key.tclass = cur_rule->tclass;
-				key.name = cur_rule->name;
-				otype = hashtab_search(state->out->filename_trans,
-						       (hashtab_key_t) &key);
-				if (otype) {
+				name = NULL;
+
+				rc = policydb_filetrans_insert(
+					state->out, i + 1, j + 1,
+					cur_rule->tclass, cur_rule->name,
+					&name, mapped_otype, &present_otype
+				);
+				free(name);
+				if (rc == SEPOL_EEXIST) {
 					/* duplicate rule, ignore */
-					if (otype->otype == mapped_otype)
+					if (present_otype == mapped_otype)
 						continue;
 
 					ERR(state->handle, "Conflicting name-based type_transition %s %s:%s \"%s\":  %s vs %s",
@@ -1417,44 +1418,11 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
 					    state->out->p_type_val_to_name[j],
 					    state->out->p_class_val_to_name[cur_rule->tclass - 1],
 					    cur_rule->name,
-					    state->out->p_type_val_to_name[otype->otype - 1],
+					    state->out->p_type_val_to_name[present_otype - 1],
 					    state->out->p_type_val_to_name[mapped_otype - 1]);
 					return -1;
-				}
-
-				new_trans = calloc(1, sizeof(*new_trans));
-				if (!new_trans) {
-					ERR(state->handle, "Out of memory!");
-					return -1;
-				}
-
-				new_trans->name = strdup(cur_rule->name);
-				if (!new_trans->name) {
-					ERR(state->handle, "Out of memory!");
-					free(new_trans);
-					return -1;
-				}
-				new_trans->stype = i + 1;
-				new_trans->ttype = j + 1;
-				new_trans->tclass = cur_rule->tclass;
-
-				otype = calloc(1, sizeof(*otype));
-				if (!otype) {
-					ERR(state->handle, "Out of memory!");
-					free(new_trans->name);
-					free(new_trans);
-					return -1;
-				}
-				otype->otype = mapped_otype;
-
-				rc = hashtab_insert(state->out->filename_trans,
-						    (hashtab_key_t)new_trans,
-						    otype);
-				if (rc) {
+				} else if (rc < 0) {
 					ERR(state->handle, "Out of memory!");
-					free(otype);
-					free(new_trans->name);
-					free(new_trans);
 					return -1;
 				}
 			}
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 958adc4c..c247b32f 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1841,21 +1841,35 @@ struct map_filename_trans_args {
 
 static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
 {
-	filename_trans_t *ft = (filename_trans_t *)key;
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
 	filename_trans_datum_t *datum = data;
 	struct map_filename_trans_args *map_args = arg;
 	struct policydb *pdb = map_args->pdb;
 	struct strs *strs = map_args->strs;
 	char *src, *tgt, *class, *filename, *new;
+	struct ebitmap_node *node;
+	uint32_t bit;
+	int rc;
 
-	src = pdb->p_type_val_to_name[ft->stype - 1];
 	tgt = pdb->p_type_val_to_name[ft->ttype - 1];
 	class = pdb->p_class_val_to_name[ft->tclass - 1];
 	filename = ft->name;
-	new =  pdb->p_type_val_to_name[datum->otype - 1];
+	do {
+		new = pdb->p_type_val_to_name[datum->otype - 1];
+
+		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
+			src = pdb->p_type_val_to_name[bit];
+			rc = strs_create_and_add(strs,
+						 "(typetransition %s %s %s %s %s)",
+						 5, src, tgt, class, filename, new);
+			if (rc)
+				return rc;
+		}
+
+		datum = datum->next;
+	} while (datum);
 
-	return strs_create_and_add(strs, "(typetransition %s %s %s %s %s)", 5,
-				   src, tgt, class, filename, new);
+	return 0;
 }
 
 static int write_filename_trans_rules_to_cil(FILE *out, struct policydb *pdb)
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 7cc91eb3..62bf706c 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1822,21 +1822,35 @@ struct map_filename_trans_args {
 
 static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
 {
-	filename_trans_t *ft = (filename_trans_t *)key;
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
 	filename_trans_datum_t *datum = data;
 	struct map_filename_trans_args *map_args = arg;
 	struct policydb *pdb = map_args->pdb;
 	struct strs *strs = map_args->strs;
 	char *src, *tgt, *class, *filename, *new;
+	struct ebitmap_node *node;
+	uint32_t bit;
+	int rc;
 
-	src = pdb->p_type_val_to_name[ft->stype - 1];
 	tgt = pdb->p_type_val_to_name[ft->ttype - 1];
 	class = pdb->p_class_val_to_name[ft->tclass - 1];
 	filename = ft->name;
-	new =  pdb->p_type_val_to_name[datum->otype - 1];
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
 
-	return strs_create_and_add(strs, "type_transition %s %s:%s %s \"%s\";", 5,
-				   src, tgt, class, new, filename);
+	return 0;
 }
 
 static int write_filename_trans_rules_to_conf(FILE *out, struct policydb *pdb)
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 3992ea56..e9409a41 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -789,12 +789,12 @@ partial_name_hash(unsigned long c, unsigned long prevhash)
 
 static unsigned int filenametr_hash(hashtab_t h, const_hashtab_key_t k)
 {
-	const struct filename_trans *ft = (const struct filename_trans *)k;
+	const filename_trans_key_t *ft = (const filename_trans_key_t *)k;
 	unsigned long hash;
 	unsigned int byte_num;
 	unsigned char focus;
 
-	hash = ft->stype ^ ft->ttype ^ ft->tclass;
+	hash = ft->ttype ^ ft->tclass;
 
 	byte_num = 0;
 	while ((focus = ft->name[byte_num++]))
@@ -805,14 +805,10 @@ static unsigned int filenametr_hash(hashtab_t h, const_hashtab_key_t k)
 static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
 			  const_hashtab_key_t k1, const_hashtab_key_t k2)
 {
-	const struct filename_trans *ft1 = (const struct filename_trans *)k1;
-	const struct filename_trans *ft2 = (const struct filename_trans *)k2;
+	const filename_trans_key_t *ft1 = (const filename_trans_key_t *)k1;
+	const filename_trans_key_t *ft2 = (const filename_trans_key_t *)k2;
 	int v;
 
-	v = ft1->stype - ft2->stype;
-	if (v)
-		return v;
-
 	v = ft1->ttype - ft2->ttype;
 	if (v)
 		return v;
@@ -1409,9 +1405,12 @@ common_destroy, class_destroy, role_destroy, type_destroy, user_destroy,
 static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
 			      void *p __attribute__ ((unused)))
 {
-	struct filename_trans *ft = (struct filename_trans *)key;
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
+	filename_trans_datum_t *fd = datum;
+
 	free(ft->name);
 	free(key);
+	ebitmap_destroy(&fd->stypes);
 	free(datum);
 	return 0;
 }
@@ -2595,12 +2594,77 @@ int role_allow_read(role_allow_t ** r, struct policy_file *fp)
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
+		if (!*name_alloc) {
+			*name_alloc = strdup(name);
+			if (!*name_alloc)
+				return SEPOL_ENOMEM;
+		}
+
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
+			ft = malloc(sizeof(*ft));
+			if (!ft) {
+				free(datum);
+				return SEPOL_ENOMEM;
+			}
+
+			ft->ttype = ttype;
+			ft->tclass = tclass;
+			ft->name = *name_alloc;
+
+			if (hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
+					   (hashtab_datum_t)datum)) {
+				free(datum);
+				free(ft);
+				return SEPOL_ENOMEM;
+			}
+			*name_alloc = NULL;
+		}
+	}
+
+	p->filename_trans_count++;
+	return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
+}
+
 int filename_trans_read(policydb_t *p, struct policy_file *fp)
 {
 	unsigned int i;
-	uint32_t buf[4], nel, len;
-	filename_trans_t *ft;
-	filename_trans_datum_t *otype;
+	uint32_t buf[4], nel, len, stype, ttype, tclass, otype;
 	int rc;
 	char *name;
 
@@ -2610,16 +2674,8 @@ int filename_trans_read(policydb_t *p, struct policy_file *fp)
 	nel = le32_to_cpu(buf[0]);
 
 	for (i = 0; i < nel; i++) {
-		ft = NULL;
-		otype = NULL;
 		name = NULL;
 
-		ft = calloc(1, sizeof(*ft));
-		if (!ft)
-			goto err;
-		otype = calloc(1, sizeof(*otype));
-		if (!otype)
-			goto err;
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
 			goto err;
@@ -2631,8 +2687,6 @@ int filename_trans_read(policydb_t *p, struct policy_file *fp)
 		if (!name)
 			goto err;
 
-		ft->name = name;
-
 		rc = next_entry(name, fp, len);
 		if (rc < 0)
 			goto err;
@@ -2641,13 +2695,13 @@ int filename_trans_read(policydb_t *p, struct policy_file *fp)
 		if (rc < 0)
 			goto err;
 
-		ft->stype = le32_to_cpu(buf[0]);
-		ft->ttype = le32_to_cpu(buf[1]);
-		ft->tclass = le32_to_cpu(buf[2]);
-		otype->otype = le32_to_cpu(buf[3]);
+		stype  = le32_to_cpu(buf[0]);
+		ttype  = le32_to_cpu(buf[1]);
+		tclass = le32_to_cpu(buf[2]);
+		otype  = le32_to_cpu(buf[3]);
 
-		rc = hashtab_insert(p->filename_trans, (hashtab_key_t) ft,
-				    otype);
+		rc = policydb_filetrans_insert(p, stype, ttype, tclass, name,
+					       &name, otype, NULL);
 		if (rc) {
 			if (rc != SEPOL_EEXIST)
 				goto err;
@@ -2657,16 +2711,11 @@ int filename_trans_read(policydb_t *p, struct policy_file *fp)
 			 * compatibility, do not reject such policies, just
 			 * ignore the duplicate.
 			 */
-			free(ft);
-			free(name);
-			free(otype);
-			/* continue, ignoring this one */
 		}
+		free(name);
 	}
 	return 0;
 err:
-	free(ft);
-	free(otype);
 	free(name);
 	return -1;
 }
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 1fd6a16a..d3aee8d5 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -571,44 +571,50 @@ static int role_allow_write(role_allow_t * r, struct policy_file *fp)
 
 static int filename_write_helper(hashtab_key_t key, void *data, void *ptr)
 {
-	uint32_t buf[4];
+	uint32_t bit, buf[4];
 	size_t items, len;
-	struct filename_trans *ft = (struct filename_trans *)key;
-	struct filename_trans_datum *otype = data;
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
+	filename_trans_datum_t *datum = data;
+	ebitmap_node_t *node;
 	void *fp = ptr;
 
 	len = strlen(ft->name);
-	buf[0] = cpu_to_le32(len);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return POLICYDB_ERROR;
+	do {
+		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
+			buf[0] = cpu_to_le32(len);
+			items = put_entry(buf, sizeof(uint32_t), 1, fp);
+			if (items != 1)
+				return POLICYDB_ERROR;
 
-	items = put_entry(ft->name, sizeof(char), len, fp);
-	if (items != len)
-		return POLICYDB_ERROR;
+			items = put_entry(ft->name, sizeof(char), len, fp);
+			if (items != len)
+				return POLICYDB_ERROR;
 
-	buf[0] = cpu_to_le32(ft->stype);
-	buf[1] = cpu_to_le32(ft->ttype);
-	buf[2] = cpu_to_le32(ft->tclass);
-	buf[3] = cpu_to_le32(otype->otype);
-	items = put_entry(buf, sizeof(uint32_t), 4, fp);
-	if (items != 4)
-		return POLICYDB_ERROR;
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
 
 	return 0;
 }
 
 static int filename_trans_write(struct policydb *p, void *fp)
 {
-	size_t nel, items;
+	size_t items;
 	uint32_t buf[1];
 	int rc;
 
 	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
 		return 0;
 
-	nel =  p->filename_trans->nel;
-	buf[0] = cpu_to_le32(nel);
+	buf[0] = cpu_to_le32(p->filename_trans_count);
 	items = put_entry(buf, sizeof(uint32_t), 1, fp);
 	if (items != 1)
 		return POLICYDB_ERROR;
-- 
2.26.2

