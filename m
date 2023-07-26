Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F4C001B0
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 14:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjGZO0G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjGZO0E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 10:26:04 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972751A8
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:26:00 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63cf9eddbc6so4960936d6.0
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381559; x=1690986359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2/Nh8PqEQZ+U7m7RZqk9K32ypDfcQU4QQMlfCZfj3U=;
        b=WBFtJ3d6kz534WBSPUSug0xI66dnMSI+uwyn9A+5Nl4oNCwnuuMl7D97uDK4cl7EJE
         QH4FNcvJogn17Je2JXumyHS/3FcTiXMSC2/MNH2ASwrbz1bwm5GLDEXYDwZ/F1OQw7Zh
         1ILimZxGq1BPPXvv1fhYwOsBjVIIFfptl0vhgnEmNrcyHl5OL8C3QGSZP5XFo6duMg8a
         6vCPIvBlsZDmr38/l8tMFRyCy4CTgoXLfKg9IvCRw3Y6G9fZDSUd43wtbwvktQytNu01
         xApONArq3c5fxWHbPgZtqJKQoSFGUBFC8ETxrjCjPqabvBjgRlwp+ho4G9pyWeTZfQhA
         3dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381559; x=1690986359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2/Nh8PqEQZ+U7m7RZqk9K32ypDfcQU4QQMlfCZfj3U=;
        b=b1OMuV0xiUWDkmgPPKO0soq4HqBK4ld+t/OeSiGxDX6iBUjfXyeohbvmSyAqqaOO/c
         yg07lqhxWu/4rg5DvXyGf4cjRNW6Y0beqjoFRv2fj4WTA/s2qs/ryWXGoqnmufRL3eKU
         +bj9e+6vSdD7NVx3iTc1TVsJxnBvDQc5xvvH3YvsGi8QW9SuEl0eaCnwUjiMr01FAECf
         srEEIQpqASUciqSZtUiDT5GqN6Rui7sCUNZjx96lcYfBzV1MJJQf1JZkioTVhmLf2pYw
         iOwZ/H2eZ7BMk3fF60+llJrJ/UTEKjeGQ7m3N9kQlYvhUDlsmHSp7jlXrUl84jNU49N3
         0Alg==
X-Gm-Message-State: ABy/qLYvq1gKotCoqxHJDhGlX3bAsO83K/S4aLz3jlf3m2lOhyiwbUPc
        R9pwHoJq5SJ2+BbCvJKrqnNYZ5v0qk0v0Q==
X-Google-Smtp-Source: APBJJlFzZSs3iZDibmw5J2tM4UKriYbXpEfNHKkXX65JLoF0E2gSX+buW+69de2ZGsHP9LCezOtd2w==
X-Received: by 2002:a0c:dd12:0:b0:62d:ed86:154b with SMTP id u18-20020a0cdd12000000b0062ded86154bmr2993359qvk.5.1690381558836;
        Wed, 26 Jul 2023 07:25:58 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cf014000000b006362d4eeb6esm5066471qvk.144.2023.07.26.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:25:58 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/8] Revert "checkpolicy,libsepol: move filename transition rules to avrule"
Date:   Wed, 26 Jul 2023 10:25:47 -0400
Message-ID: <20230726142549.94685-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
References: <20230726142549.94685-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit 565d87489bc00cab2e624aae1a40872d2a2232ba.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/checkpolicy.c                  |   9 +
 checkpolicy/module_compiler.c              |  12 ++
 checkpolicy/module_compiler.h              |   1 +
 checkpolicy/policy_define.c                | 215 ++++++++++++++++++---
 checkpolicy/policy_define.h                |   3 +-
 checkpolicy/policy_parse.y                 |   8 +-
 checkpolicy/test/dismod.c                  |  25 ++-
 libsepol/cil/src/cil_binary.c              |   2 -
 libsepol/include/sepol/policydb/policydb.h |  16 +-
 libsepol/src/avrule_block.c                |   1 +
 libsepol/src/expand.c                      | 132 +++++++++----
 libsepol/src/link.c                        |  56 +++++-
 libsepol/src/module_to_cil.c               |  71 ++++++-
 libsepol/src/policydb.c                    |  70 +++++--
 libsepol/src/policydb_validate.c           |  27 +++
 libsepol/src/write.c                       |  86 ++++-----
 16 files changed, 580 insertions(+), 154 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 623ba8b2..83000bcb 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -615,6 +615,15 @@ int main(int argc, char **argv)
 		parse_policy.mls = mlspol;
 		parse_policy.handle_unknown = handle_unknown;
 
+		/*
+		 * Init and alloc te_avtab for filename transition duplicate
+		 * checking
+		 */
+		if (avtab_init(&parse_policy.te_avtab))
+			exit(1);
+		if (avtab_alloc(&parse_policy.te_avtab, 1 << 11))
+			exit(1);
+
 		policydbp = &parse_policy;
 
 		if (read_source_policy(policydbp, file, "checkpolicy") < 0)
diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 5fe1729a..3188af89 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -1278,6 +1278,18 @@ void append_role_allow(role_allow_rule_t * role_allow_rules)
 	decl->role_allow_rules = role_allow_rules;
 }
 
+/* this doesn't actually append, but really prepends it */
+void append_filename_trans(filename_trans_rule_t * filename_trans_rules)
+{
+	avrule_decl_t *decl = stack_top->decl;
+
+	/* filename transitions are not allowed within conditionals */
+	assert(stack_top->type == 1);
+
+	filename_trans_rules->next = decl->filename_trans_rules;
+	decl->filename_trans_rules = filename_trans_rules;
+}
+
 /* this doesn't actually append, but really prepends it */
 void append_range_trans(range_trans_rule_t * range_tr_rules)
 {
diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compiler.h
index 6f8bb9b9..29b824b4 100644
--- a/checkpolicy/module_compiler.h
+++ b/checkpolicy/module_compiler.h
@@ -83,6 +83,7 @@ void append_avrule(avrule_t * avrule);
 void append_role_trans(role_trans_rule_t * role_tr_rules);
 void append_role_allow(role_allow_rule_t * role_allow_rules);
 void append_range_trans(range_trans_rule_t * range_tr_rules);
+void append_filename_trans(filename_trans_rule_t * filename_trans_rules);
 
 /* Create a new optional block and add it to the global policy.
  * During the second pass resolve the block's requirements.  Return 0
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 25dbf25d..dc2ee8f3 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1601,7 +1601,7 @@ static int set_types(type_set_t * set, char *id, int *add, char starallowed)
 	return -1;
 }
 
-static int define_compute_type_helper(int which, avrule_t ** rule, int has_filename)
+static int define_compute_type_helper(int which, avrule_t ** rule)
 {
 	char *id;
 	type_datum_t *datum;
@@ -1669,14 +1669,6 @@ static int define_compute_type_helper(int which, avrule_t ** rule, int has_filen
 	}
 	free(id);
 
-	if (has_filename) {
-		avrule->object_name = queue_remove(id_queue);
-		if (!avrule->object_name) {
-			yyerror("no object_name?");
-			goto bad;
-		}
-	}
-
 	ebitmap_for_each_positive_bit(&tclasses, node, i) {
 		perm = malloc(sizeof(class_perm_node_t));
 		if (!perm) {
@@ -1700,7 +1692,7 @@ static int define_compute_type_helper(int which, avrule_t ** rule, int has_filen
 	return -1;
 }
 
-int define_compute_type(int which, int has_filename)
+int define_compute_type(int which)
 {
 	char *id;
 	avrule_t *avrule;
@@ -1714,14 +1706,10 @@ int define_compute_type(int which, int has_filename)
 			free(id);
 		id = queue_remove(id_queue);
 		free(id);
-		if (has_filename) {
-			id = queue_remove(id_queue);
-			free(id);
-		}
 		return 0;
 	}
 
-	if (define_compute_type_helper(which, &avrule, has_filename))
+	if (define_compute_type_helper(which, &avrule))
 		return -1;
 
 	append_avrule(avrule);
@@ -1745,7 +1733,7 @@ avrule_t *define_cond_compute_type(int which)
 		return (avrule_t *) 1;
 	}
 
-	if (define_compute_type_helper(which, &avrule, 0))
+	if (define_compute_type_helper(which, &avrule))
 		return COND_ERR;
 
 	return avrule;
@@ -2387,13 +2375,6 @@ static int avrule_cpy(avrule_t *dest, const avrule_t *src)
 		yyerror("out of memory");
 		return -1;
 	}
-	if (src->object_name) {
-		dest->object_name = strdup(src->object_name);
-		if (!dest->object_name) {
-			yyerror("out of memory");
-			return -1;
-		}
-	}
 	dest->line = src->line;
 	dest->source_filename = strdup(source_file);
 	if (!dest->source_filename) {
@@ -3362,6 +3343,194 @@ avrule_t *define_cond_filename_trans(void)
 	return COND_ERR;
 }
 
+int define_filename_trans(void)
+{
+	char *id, *name = NULL;
+	type_set_t stypes, ttypes;
+	ebitmap_t e_stypes, e_ttypes;
+	ebitmap_t e_tclasses;
+	ebitmap_node_t *snode, *tnode, *cnode;
+	filename_trans_rule_t *ftr;
+	type_datum_t *typdatum;
+	avtab_key_t avt_key;
+	uint32_t otype;
+	unsigned int c, s, t;
+	int add, self, rc;
+
+	if (pass == 1) {
+		/* stype */
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		/* ttype */
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		/* tclass */
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		/* otype */
+		id = queue_remove(id_queue);
+		free(id);
+		/* name */
+		id = queue_remove(id_queue);
+		free(id);
+		return 0;
+	}
+
+	type_set_init(&stypes);
+	type_set_init(&ttypes);
+	ebitmap_init(&e_stypes);
+	ebitmap_init(&e_ttypes);
+	ebitmap_init(&e_tclasses);
+
+	add = 1;
+	while ((id = queue_remove(id_queue))) {
+		if (set_types(&stypes, id, &add, 0))
+			goto bad;
+	}
+
+	self = 0;
+	add = 1;
+	while ((id = queue_remove(id_queue))) {
+		if (strcmp(id, "self") == 0) {
+			free(id);
+			if (add == 0) {
+				yyerror("-self is not supported");
+				goto bad;
+			}
+			self = 1;
+			continue;
+		}
+		if (set_types(&ttypes, id, &add, 0))
+			goto bad;
+	}
+
+	if (read_classes(&e_tclasses))
+		goto bad;
+
+	id = (char *)queue_remove(id_queue);
+	if (!id) {
+		yyerror("no otype in transition definition?");
+		goto bad;
+	}
+	if (!is_id_in_scope(SYM_TYPES, id)) {
+		yyerror2("type %s is not within scope", id);
+		free(id);
+		goto bad;
+	}
+	typdatum = hashtab_search(policydbp->p_types.table, id);
+	if (!typdatum) {
+		yyerror2("unknown type %s used in transition definition", id);
+		free(id);
+		goto bad;
+	}
+	free(id);
+	otype = typdatum->s.value;
+
+	name = queue_remove(id_queue);
+	if (!name) {
+		yyerror("no pathname specified in filename_trans definition?");
+		goto bad;
+	}
+
+	/* We expand the class set into separate rules.  We expand the types
+	 * just to make sure there are not duplicates.  They will get turned
+	 * into separate rules later */
+	if (type_set_expand(&stypes, &e_stypes, policydbp, 1))
+		goto bad;
+
+	if (type_set_expand(&ttypes, &e_ttypes, policydbp, 1))
+		goto bad;
+
+	ebitmap_for_each_positive_bit(&e_tclasses, cnode, c) {
+		ebitmap_for_each_positive_bit(&e_stypes, snode, s) {
+			ebitmap_for_each_positive_bit(&e_ttypes, tnode, t) {
+				avt_key.specified = AVTAB_TRANSITION;
+				avt_key.source_type = s + 1;
+				avt_key.target_type = t + 1;
+				avt_key.target_class = c + 1;
+				rc = avtab_insert_filename_trans(
+					&policydbp->te_avtab, &avt_key, otype,
+					name, NULL
+				);
+				if (rc != SEPOL_OK) {
+					if (rc == SEPOL_EEXIST) {
+						yyerror2("duplicate filename transition for: filename_trans %s %s %s:%s",
+							name,
+							policydbp->p_type_val_to_name[s],
+							policydbp->p_type_val_to_name[t],
+							policydbp->p_class_val_to_name[c]);
+						goto bad;
+					}
+					yyerror("out of memory");
+					goto bad;
+				}
+			}
+			if (self) {
+				avt_key.specified = AVTAB_TRANSITION;
+				avt_key.source_type = s + 1;
+				avt_key.target_type = t + 1;
+				avt_key.target_class = c + 1;
+				rc = avtab_insert_filename_trans(
+					&policydbp->te_avtab, &avt_key, otype,
+					name, NULL
+				);
+				if (rc != SEPOL_OK) {
+					if (rc == SEPOL_EEXIST) {
+						yyerror2("duplicate filename transition for: filename_trans %s %s %s:%s",
+							name,
+							policydbp->p_type_val_to_name[s],
+							policydbp->p_type_val_to_name[s],
+							policydbp->p_class_val_to_name[c]);
+						goto bad;
+					}
+					yyerror("out of memory");
+					goto bad;
+				}
+			}
+		}
+	
+		/* Now add the real rule since we didn't find any duplicates */
+		ftr = malloc(sizeof(*ftr));
+		if (!ftr) {
+			yyerror("out of memory");
+			goto bad;
+		}
+		filename_trans_rule_init(ftr);
+		append_filename_trans(ftr);
+
+		ftr->name = strdup(name);
+		if (type_set_cpy(&ftr->stypes, &stypes)) {
+			yyerror("out of memory");
+			goto bad;
+		}
+		if (type_set_cpy(&ftr->ttypes, &ttypes)) {
+			yyerror("out of memory");
+			goto bad;
+		}
+		ftr->tclass = c + 1;
+		ftr->otype = otype;
+		ftr->flags = self ? RULE_SELF : 0;
+	}
+
+	free(name);
+	ebitmap_destroy(&e_stypes);
+	ebitmap_destroy(&e_ttypes);
+	ebitmap_destroy(&e_tclasses);
+	type_set_destroy(&stypes);
+	type_set_destroy(&ttypes);
+
+	return 0;
+
+bad:
+	free(name);
+	ebitmap_destroy(&e_stypes);
+	ebitmap_destroy(&e_ttypes);
+	ebitmap_destroy(&e_tclasses);
+	type_set_destroy(&stypes);
+	type_set_destroy(&ttypes);
+	return -1;
+}
+
 static constraint_expr_t *constraint_expr_clone(const constraint_expr_t * expr)
 {
 	constraint_expr_t *h = NULL, *l = NULL, *newe;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 5d0f70e4..50a7ba78 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -28,7 +28,7 @@ int define_default_role(int which);
 int define_default_type(int which);
 int define_default_range(int which);
 int define_common_perms(void);
-int define_compute_type(int which, int has_filename);
+int define_compute_type(int which);
 int define_conditional(cond_expr_t *expr, avrule_t *t_list, avrule_t *f_list );
 int define_constraint(constraint_expr_t *expr);
 int define_dominance(void);
@@ -57,6 +57,7 @@ int define_role_trans(int class_specified);
 int define_role_types(void);
 int define_role_attr(void);
 int define_roleattribute(void);
+int define_filename_trans(void);
 int define_sens(void);
 int define_te_avtab(int which);
 int define_te_avtab_extended_perms(int which);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 2a14fc1e..da32a776 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -451,13 +451,13 @@ cond_dontaudit_def	: DONTAUDIT names names ':' names names ';'
 		        ;
 			;
 transition_def		: TYPE_TRANSITION  names names ':' names identifier filename ';'
-			{if (define_compute_type(AVRULE_TRANSITION, 1)) return -1; }
+			{if (define_filename_trans()) return -1; }
 			| TYPE_TRANSITION names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_TRANSITION, 0)) return -1;}
+                        {if (define_compute_type(AVRULE_TRANSITION)) return -1;}
                         | TYPE_MEMBER names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_MEMBER, 0)) return -1;}
+                        {if (define_compute_type(AVRULE_MEMBER)) return -1;}
                         | TYPE_CHANGE names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_CHANGE, 0)) return -1;}
+                        {if (define_compute_type(AVRULE_CHANGE)) return -1;}
     			;
 range_trans_def		: RANGE_TRANSITION names names mls_range_def ';'
 			{ if (define_range_trans(0)) return -1; }
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 8bab207c..fa7117f5 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -50,6 +50,7 @@
 #define DISPLAY_AVBLOCK_ROLE_ALLOW	4
 #define DISPLAY_AVBLOCK_REQUIRES	5
 #define DISPLAY_AVBLOCK_DECLARES	6
+#define DISPLAY_AVBLOCK_FILENAME_TRANS	7
 
 static policydb_t policydb;
 
@@ -86,6 +87,7 @@ static struct command {
 	{CMD,       'c', "Display policy capabilities"},
 	{CMD|NOOPT, 'l', "Link in a module"},
 	{CMD,       'u', "Display the unknown handling setting"},
+	{CMD,       'F', "Display filename_trans rules"},
 	{CMD,       'v', "display the version of policy and/or module"},
 	{HEADER, 0, ""},
 	{CMD|NOOPT, 'f',  "set output file"},
@@ -343,8 +345,6 @@ static int display_avrule(avrule_t * avrule, policydb_t * policy,
 				   policy, fp);
 	} else if (avrule->specified & AVRULE_TYPE) {
 		display_id(policy, fp, SYM_TYPES, avrule->perms->data - 1, "");
-		if (avrule->object_name)
-			fprintf(fp, " \"%s\"", avrule->object_name);
 	} else if (avrule->specified & AVRULE_XPERMS) {
 		avtab_extended_perms_t xperms;
 		int i;
@@ -562,6 +562,18 @@ static void display_role_allow(role_allow_rule_t * ra, policydb_t * p, FILE * fp
 	}
 }
 
+static void display_filename_trans(filename_trans_rule_t * tr, policydb_t * p, FILE * fp)
+{
+	fprintf(fp, "filename transition");
+	for (; tr; tr = tr->next) {
+		display_type_set(&tr->stypes, 0, p, fp);
+		display_type_set(&tr->ttypes, 0, p, fp);
+		display_id(p, fp, SYM_CLASSES, tr->tclass - 1, ":");
+		display_id(p, fp, SYM_TYPES, tr->otype - 1, "");
+		fprintf(fp, " %s\n", tr->name);
+	}
+}
+
 static int role_display_callback(hashtab_key_t key __attribute__((unused)),
 			  hashtab_datum_t datum, void *data)
 {
@@ -726,6 +738,10 @@ static int display_avdecl(avrule_decl_t * decl, int field,
 			}
 			break;
 		}
+	case DISPLAY_AVBLOCK_FILENAME_TRANS:
+		display_filename_trans(decl->filename_trans_rules, policy,
+				       out_fp);
+		break;
 	default:{
 			assert(0);
 		}
@@ -1059,6 +1075,11 @@ int main(int argc, char **argv)
 			if (out_fp != stdout)
 				printf("\nOutput to file: %s\n", OutfileName);
 			break;
+		case 'F':
+			fprintf(out_fp, "filename_trans rules:\n");
+			display_avblock(DISPLAY_AVBLOCK_FILENAME_TRANS,
+					&policydb, out_fp);
+			break;
 		case 'l':
 			link_module(&policydb, out_fp, ops? 0: 1);
 			break;
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 996bad70..7150d405 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4650,7 +4650,6 @@ static avrule_t *__cil_init_sepol_avrule(uint32_t kind, struct cil_tree_node *no
 	__cil_init_sepol_type_set(&avrule->stypes);
 	__cil_init_sepol_type_set(&avrule->ttypes);
 	avrule->perms = NULL;
-	avrule->object_name = NULL;
 	avrule->line = node->line;
 
 	avrule->source_filename = NULL;
@@ -4677,7 +4676,6 @@ static void __cil_destroy_sepol_avrules(avrule_t *curr)
 		ebitmap_destroy(&curr->stypes.negset);
 		ebitmap_destroy(&curr->ttypes.types);
 		ebitmap_destroy(&curr->ttypes.negset);
-		free(curr->object_name);
 		__cil_destroy_sepol_class_perms(curr->perms);
 		free(curr);
 		curr = next;
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index d30f26af..8bb11d18 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -278,7 +278,6 @@ typedef struct avrule {
 	type_set_t stypes;
 	type_set_t ttypes;
 	class_perm_node_t *perms;
-	char *object_name;	/* optional object name */
 	av_extended_perms_t *xperms;
 	unsigned long line;	/* line number from policy.conf where
 				 * this rule originated  */
@@ -302,6 +301,16 @@ typedef struct role_allow_rule {
 	struct role_allow_rule *next;
 } role_allow_rule_t;
 
+typedef struct filename_trans_rule {
+	uint32_t flags; /* may have RULE_SELF set */
+	type_set_t stypes;
+	type_set_t ttypes;
+	uint32_t tclass;
+	char *name;
+	uint32_t otype;	/* new type */
+	struct filename_trans_rule *next;
+} filename_trans_rule_t;
+
 typedef struct range_trans_rule {
 	type_set_t stypes;
 	type_set_t ttypes;
@@ -442,6 +451,9 @@ typedef struct avrule_decl {
 	scope_index_t required;	/* symbols needed to activate this block */
 	scope_index_t declared;	/* symbols declared within this block */
 
+	/* type transition rules with a 'name' component */
+	filename_trans_rule_t *filename_trans_rules;
+
 	/* for additive statements (type attribute, roles, and users) */
 	symtab_t symtab[SYM_NUM];
 
@@ -644,6 +656,8 @@ extern void avrule_destroy(avrule_t * x);
 extern void avrule_list_destroy(avrule_t * x);
 extern void role_trans_rule_init(role_trans_rule_t * x);
 extern void role_trans_rule_list_destroy(role_trans_rule_t * x);
+extern void filename_trans_rule_init(filename_trans_rule_t * x);
+extern void filename_trans_rule_list_destroy(filename_trans_rule_t * x);
 
 extern void role_datum_init(role_datum_t * x);
 extern void role_datum_destroy(role_datum_t * x);
diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index fce4e772..dcfce8b8 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -99,6 +99,7 @@ void avrule_decl_destroy(avrule_decl_t * x)
 	cond_list_destroy(x->cond_list);
 	avrule_list_destroy(x->avrules);
 	role_trans_rule_list_destroy(x->role_tr_rules);
+	filename_trans_rule_list_destroy(x->filename_trans_rules);
 	role_allow_rule_list_destroy(x->role_allow_rules);
 	range_trans_rule_list_destroy(x->range_tr_rules);
 	scope_index_destroy(&x->required);
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index a4c92f4f..878b0f21 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1407,6 +1407,94 @@ static int copy_role_trans(expand_state_t * state, role_trans_rule_t * rules)
 	return 0;
 }
 
+static int expand_filename_trans_helper(expand_state_t *state,
+					filename_trans_rule_t *rule,
+					unsigned int s, unsigned int t)
+{
+	uint32_t mapped_otype, present_otype;
+	int rc;
+	avtab_key_t avt_key;
+
+	mapped_otype = state->typemap[rule->otype - 1];
+
+	avt_key.specified = AVTAB_TRANSITION;
+	avt_key.source_type = s + 1;
+	avt_key.target_type = t + 1;
+	avt_key.target_class = rule->tclass;
+
+	rc = avtab_insert_filename_trans(&state->out->te_avtab, &avt_key,
+		mapped_otype, rule->name, &present_otype);
+	if (rc == SEPOL_EEXIST) {
+		/* duplicate rule, ignore */
+		if (present_otype == mapped_otype)
+			return 0;
+
+		ERR(state->handle, "Conflicting name-based type_transition %s %s:%s \"%s\":  %s vs %s",
+		    state->out->p_type_val_to_name[s],
+		    state->out->p_type_val_to_name[t],
+		    state->out->p_class_val_to_name[rule->tclass - 1],
+		    rule->name,
+		    state->out->p_type_val_to_name[present_otype - 1],
+		    state->out->p_type_val_to_name[mapped_otype - 1]);
+		return -1;
+	} else if (rc < 0) {
+		ERR(state->handle, "Out of memory!");
+		return -1;
+	}
+	return 0;
+}
+
+static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *rules)
+{
+	unsigned int i, j;
+	filename_trans_rule_t *cur_rule;
+	ebitmap_t stypes, ttypes;
+	ebitmap_node_t *snode, *tnode;
+	int rc;
+
+	cur_rule = rules;
+	while (cur_rule) {
+		ebitmap_init(&stypes);
+		ebitmap_init(&ttypes);
+
+		if (expand_convert_type_set(state->out, state->typemap,
+					    &cur_rule->stypes, &stypes, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		if (expand_convert_type_set(state->out, state->typemap,
+					    &cur_rule->ttypes, &ttypes, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+
+		ebitmap_for_each_positive_bit(&stypes, snode, i) {
+			ebitmap_for_each_positive_bit(&ttypes, tnode, j) {
+				rc = expand_filename_trans_helper(
+					state, cur_rule, i, j
+				);
+				if (rc)
+					return rc;
+			}
+			if (cur_rule->flags & RULE_SELF) {
+				rc = expand_filename_trans_helper(
+					state, cur_rule, i, i
+				);
+				if (rc)
+					return rc;
+			}
+		}
+
+		ebitmap_destroy(&stypes);
+		ebitmap_destroy(&ttypes);
+
+		cur_rule = cur_rule->next;
+	}
+	return 0;
+}
+
 static int exp_rangetr_helper(uint32_t stype, uint32_t ttype, uint32_t tclass,
 			      mls_semantic_range_t * trange,
 			      expand_state_t * state)
@@ -1620,7 +1708,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
 				uint32_t specified, cond_av_list_t ** cond,
 				cond_av_list_t ** other, uint32_t stype,
 				uint32_t ttype, class_perm_node_t * perms,
-				char *object_name, avtab_t * avtab, int enabled)
+				avtab_t * avtab, int enabled)
 {
 	avtab_key_t avkey;
 	avtab_datum_t *avdatump;
@@ -1644,34 +1732,6 @@ static int expand_terule_helper(sepol_handle_t * handle,
 		    typemap ? typemap[cur->data - 1] : cur->data;
 		avkey.target_class = cur->tclass;
 
-		/*
-		 * if expanded node is a filename transition, insert it, insert
-		 * function checks for duplicates
-		 */
-		if (specified & AVRULE_TRANSITION && object_name) {
-			int rc = avtab_insert_filename_trans(avtab, &avkey,
-							     remapped_data,
-							     object_name,
-							     &oldtype);
-			if (rc == SEPOL_EEXIST) {
-				ERR(handle, "conflicting filename transition %s %s:%s \"%s\": %s vs %s",
-				    p->p_type_val_to_name[avkey.source_type - 1],
-				    p->p_type_val_to_name[avkey.target_type - 1],
-				    p->p_class_val_to_name[avkey.target_class - 1],
-				    object_name,
-				    p->p_type_val_to_name[oldtype - 1],
-				    p->p_type_val_to_name[remapped_data - 1]);
-				return EXPAND_RULE_CONFLICT;
-			}
-			if (rc < 0)
-				return EXPAND_RULE_ERROR;
-			/*
-			 * filename transtion inserted, continue with next node
-			 */
-			cur = cur->next;
-			continue;
-		}
-
 		conflict = 0;
 		/* check to see if the expanded TE already exists --
 		 * either in the global scope or in another
@@ -1717,9 +1777,12 @@ static int expand_terule_helper(sepol_handle_t * handle,
 				    || node->parse_context == cond)
 					return EXPAND_RULE_SUCCESS;
 				ERR(handle, "duplicate TE rule for %s %s:%s %s",
-				    p->p_type_val_to_name[avkey.source_type - 1],
-				    p->p_type_val_to_name[avkey.target_type - 1],
-				    p->p_class_val_to_name[avkey.target_class - 1],
+				    p->p_type_val_to_name[avkey.source_type -
+							  1],
+				    p->p_type_val_to_name[avkey.target_type -
+							  1],
+				    p->p_class_val_to_name[avkey.target_class -
+							   1],
 				    p->p_type_val_to_name[oldtype - 1]);
 				return EXPAND_RULE_CONFLICT;
 			}
@@ -1884,7 +1947,6 @@ static int expand_rule_helper(sepol_handle_t * handle,
 				retval = expand_terule_helper(handle, p, typemap,
 							      source_rule->specified, cond,
 							      other, i, i, source_rule->perms,
-							      source_rule->object_name,
 							      dest_avtab, enabled);
 				if (retval != EXPAND_RULE_SUCCESS)
 					return retval;
@@ -1901,7 +1963,6 @@ static int expand_rule_helper(sepol_handle_t * handle,
 				retval = expand_terule_helper(handle, p, typemap,
 							      source_rule->specified, cond,
 							      other, i, j, source_rule->perms,
-							      source_rule->object_name,
 							      dest_avtab, enabled);
 				if (retval != EXPAND_RULE_SUCCESS)
 					return retval;
@@ -2730,6 +2791,9 @@ static int copy_and_expand_avrule_block(expand_state_t * state)
 			goto cleanup;
 		}
 
+		if (expand_filename_trans(state, decl->filename_trans_rules))
+			goto cleanup;
+
 		/* expand the range transition rules */
 		if (expand_range_trans(state, decl->range_tr_rules))
 			goto cleanup;
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 88b23594..3b7742bc 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1249,12 +1249,6 @@ static int copy_avrule_list(avrule_t * list, avrule_t ** dst,
 			goto cleanup;
 		}
 
-		if (cur->object_name) {
-			new_rule->object_name = strdup(cur->object_name);
-			if (!new_rule->object_name)
-				goto cleanup;
-		}
-
 		cur_perm = cur->perms;
 		tail_perm = NULL;
 		while (cur_perm) {
@@ -1418,6 +1412,51 @@ static int copy_role_allow_list(role_allow_rule_t * list,
 	return -1;
 }
 
+static int copy_filename_trans_list(filename_trans_rule_t * list,
+				    filename_trans_rule_t ** dst,
+				    policy_module_t * module,
+				    link_state_t * state)
+{
+	filename_trans_rule_t *cur, *new_rule, *tail;
+
+	cur = list;
+	tail = *dst;
+	while (tail && tail->next)
+		tail = tail->next;
+
+	while (cur) {
+		new_rule = malloc(sizeof(*new_rule));
+		if (!new_rule)
+			goto err;
+
+		filename_trans_rule_init(new_rule);
+
+		if (*dst == NULL)
+			*dst = new_rule;
+		else
+			tail->next = new_rule;
+		tail = new_rule;
+
+		new_rule->name = strdup(cur->name);
+		if (!new_rule->name)
+			goto err;
+
+		if (type_set_or_convert(&cur->stypes, &new_rule->stypes, module) ||
+		    type_set_or_convert(&cur->ttypes, &new_rule->ttypes, module))
+			goto err;
+
+		new_rule->tclass = module->map[SYM_CLASSES][cur->tclass - 1];
+		new_rule->otype = module->map[SYM_TYPES][cur->otype - 1];
+		new_rule->flags = cur->flags;
+
+		cur = cur->next;
+	}
+	return 0;
+err:
+	ERR(state->handle, "Out of memory!");
+	return -1;
+}
+
 static int copy_range_trans_list(range_trans_rule_t * rules,
 				 range_trans_rule_t ** dst,
 				 policy_module_t * mod, link_state_t * state)
@@ -1640,6 +1679,11 @@ static int copy_avrule_decl(link_state_t * state, policy_module_t * module,
 		return -1;
 	}
 
+	if (copy_filename_trans_list(src_decl->filename_trans_rules,
+				     &dest_decl->filename_trans_rules,
+				     module, state))
+		return -1;
+
 	if (copy_range_trans_list(src_decl->range_tr_rules,
 				  &dest_decl->range_tr_rules, module, state))
 		return -1;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ca96bb67..a6b6d66f 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -547,7 +547,7 @@ static int semantic_level_to_cil(struct policydb *pdb, int sens_offset, struct m
 	return 0;
 }
 
-static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const char *src, const char *tgt, const char *object_name, const struct class_perm_node *classperms)
+static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const char *src, const char *tgt, const struct class_perm_node *classperms)
 {
 	int rc = -1;
 	const char *rule;
@@ -597,12 +597,6 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 					rule, src, tgt,
 					pdb->p_class_val_to_name[classperm->tclass - 1],
 					perms + 1);
-		} else if (object_name) {
-			cil_println(indent, "(%s %s %s %s \"%s\" %s)",
-					rule, src, tgt,
-					pdb->p_class_val_to_name[classperm->tclass - 1],
-					object_name,
-					pdb->p_type_val_to_name[classperm->data - 1]);
 		} else {
 			cil_println(indent, "(%s %s %s %s %s)",
 					rule, src, tgt,
@@ -1205,7 +1199,7 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 				if (avrule->specified & AVRULE_XPERMS) {
 					rc = avrulex_to_cil(indent, pdb, avrule->specified, snames[s], tnames[t], avrule->perms, avrule->xperms);
 				} else {
-					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], tnames[t], avrule->object_name, avrule->perms);
+					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], tnames[t], avrule->perms);
 				}
 				if (rc != 0) {
 					goto exit;
@@ -1216,7 +1210,7 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 				if (avrule->specified & AVRULE_XPERMS) {
 					rc = avrulex_to_cil(indent, pdb, avrule->specified, snames[s], "self", avrule->perms, avrule->xperms);
 				} else {
-					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], "self", avrule->object_name, avrule->perms);
+					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], "self", avrule->perms);
 				}
 				if (rc != 0) {
 					goto exit;
@@ -1582,6 +1576,60 @@ exit:
 	return rc;
 }
 
+static int filename_trans_to_cil(int indent, struct policydb *pdb, struct filename_trans_rule *rules, struct list *attr_list)
+{
+	int rc = -1;
+	char **stypes = NULL;
+	unsigned int num_stypes = 0;
+	unsigned int stype;
+	char **ttypes = NULL;
+	unsigned int num_ttypes = 0;
+	unsigned int ttype;
+	struct type_set *ts;
+	struct filename_trans_rule *rule;
+
+	for (rule = rules; rule != NULL; rule = rule->next) {
+		ts = &rule->stypes;
+		rc = process_typeset(pdb, ts, attr_list, &stypes, &num_stypes);
+		if (rc != 0) {
+			goto exit;
+		}
+
+		ts = &rule->ttypes;
+		rc = process_typeset(pdb, ts, attr_list, &ttypes, &num_ttypes);
+		if (rc != 0) {
+			goto exit;
+		}
+
+		for (stype = 0; stype < num_stypes; stype++) {
+			for (ttype = 0; ttype < num_ttypes; ttype++) {
+				cil_println(indent, "(typetransition %s %s %s \"%s\" %s)",
+					    stypes[stype], ttypes[ttype],
+					    pdb->p_class_val_to_name[rule->tclass - 1],
+					    rule->name,
+					    pdb->p_type_val_to_name[rule->otype - 1]);
+			}
+			if (rule->flags & RULE_SELF) {
+				cil_println(indent, "(typetransition %s self %s \"%s\" %s)",
+					    stypes[stype],
+					    pdb->p_class_val_to_name[rule->tclass - 1],
+					    rule->name,
+					    pdb->p_type_val_to_name[rule->otype - 1]);
+			}
+		}
+
+		names_destroy(&stypes, &num_stypes);
+		names_destroy(&ttypes, &num_ttypes);
+	}
+
+	rc = 0;
+exit:
+	names_destroy(&stypes, &num_stypes);
+	names_destroy(&ttypes, &num_ttypes);
+
+	return rc;
+}
+
 struct class_perm_datum {
 	char *name;
 	uint32_t val;
@@ -3635,6 +3683,11 @@ static int block_to_cil(struct policydb *pdb, struct avrule_block *block, struct
 		goto exit;
 	}
 
+	rc = filename_trans_to_cil(indent, pdb, decl->filename_trans_rules, type_attr_list);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = cond_list_to_cil(indent, pdb, decl->cond_list, type_attr_list);
 	if (rc != 0) {
 		goto exit;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 4913ee21..c1ce9c34 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -638,7 +638,6 @@ void avrule_destroy(avrule_t * x)
 	}
 
 	free(x->xperms);
-	free(x->object_name);
 }
 
 void role_trans_rule_init(role_trans_rule_t * x)
@@ -668,6 +667,33 @@ void role_trans_rule_list_destroy(role_trans_rule_t * x)
 	}
 }
 
+void filename_trans_rule_init(filename_trans_rule_t * x)
+{
+	memset(x, 0, sizeof(*x));
+	type_set_init(&x->stypes);
+	type_set_init(&x->ttypes);
+}
+
+static void filename_trans_rule_destroy(filename_trans_rule_t * x)
+{
+	if (!x)
+		return;
+	type_set_destroy(&x->stypes);
+	type_set_destroy(&x->ttypes);
+	free(x->name);
+}
+
+void filename_trans_rule_list_destroy(filename_trans_rule_t * x)
+{
+	filename_trans_rule_t *next;
+	while (x) {
+		next = x->next;
+		filename_trans_rule_destroy(x);
+		free(x);
+		x = next;
+	}
+}
+
 void role_allow_rule_init(role_allow_rule_t * x)
 {
 	memset(x, 0, sizeof(role_allow_rule_t));
@@ -3467,32 +3493,31 @@ static int role_allow_rule_read(role_allow_rule_t ** r, struct policy_file *fp)
 	return 0;
 }
 
-static int filename_trans_rule_read(policydb_t *p, avrule_t **r,
+static int filename_trans_rule_read(policydb_t *p, filename_trans_rule_t **r,
 				    struct policy_file *fp)
 {
 	uint32_t buf[3], nel, i, len;
 	unsigned int entries;
-	avrule_t *cur;
+	filename_trans_rule_t *ftr, *lftr;
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof(uint32_t));
 	if (rc < 0)
 		return -1;
 	nel = le32_to_cpu(buf[0]);
+	lftr = NULL;
 	for (i = 0; i < nel; i++) {
-		cur = malloc(sizeof(avrule_t));
-		if (!cur)
+		ftr = malloc(sizeof(*ftr));
+		if (!ftr)
 			return -1;
-		avrule_init(cur);
 
-		cur->next = *r;
-		*r = cur;
+		filename_trans_rule_init(ftr);
 
-		cur->specified = AVRULE_TRANSITION;
-		cur->perms = malloc(sizeof(class_perm_node_t));
-		if (!cur->perms)
-			return -1;
-		class_perm_node_init(cur->perms);
+		if (lftr)
+			lftr->next = ftr;
+		else
+			*r = ftr;
+		lftr = ftr;
 
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
@@ -3502,14 +3527,19 @@ static int filename_trans_rule_read(policydb_t *p, avrule_t **r,
 		if (zero_or_saturated(len))
 			return -1;
 
-		rc = str_read(&cur->object_name, fp, len);
+		ftr->name = malloc(len + 1);
+		if (!ftr->name)
+			return -1;
+
+		rc = next_entry(ftr->name, fp, len);
 		if (rc)
 			return -1;
+		ftr->name[len] = 0;
 
-		if (type_set_read(&cur->stypes, fp))
+		if (type_set_read(&ftr->stypes, fp))
 			return -1;
 
-		if (type_set_read(&cur->ttypes, fp))
+		if (type_set_read(&ftr->ttypes, fp))
 			return -1;
 
 		if (p->policyvers >= MOD_POLICYDB_VERSION_SELF_TYPETRANS)
@@ -3520,10 +3550,10 @@ static int filename_trans_rule_read(policydb_t *p, avrule_t **r,
 		rc = next_entry(buf, fp, sizeof(uint32_t) * entries);
 		if (rc < 0)
 			return -1;
-		cur->perms->tclass = le32_to_cpu(buf[0]);
-		cur->perms->data = le32_to_cpu(buf[1]);
+		ftr->tclass = le32_to_cpu(buf[0]);
+		ftr->otype = le32_to_cpu(buf[1]);
 		if (p->policyvers >= MOD_POLICYDB_VERSION_SELF_TYPETRANS)
-			cur->flags = le32_to_cpu(buf[2]);
+			ftr->flags = le32_to_cpu(buf[2]);
 	}
 
 	return 0;
@@ -3626,7 +3656,7 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
 	}
 
 	if (p->policyvers >= MOD_POLICYDB_VERSION_FILENAME_TRANS &&
-	    filename_trans_rule_read(p, &decl->avrules, fp))
+	    filename_trans_rule_read(p, &decl->filename_trans_rules, fp))
 		return -1;
 
 	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 0b8e8eee..89306185 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1313,6 +1313,31 @@ bad:
 	return -1;
 }
 
+
+static int validate_filename_trans_rules(sepol_handle_t *handle, const filename_trans_rule_t *filename_trans, const policydb_t *p, validate_t flavors[])
+{
+	for (; filename_trans; filename_trans = filename_trans->next) {
+		if (validate_type_set(&filename_trans->stypes, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_type_set(&filename_trans->ttypes, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_value(filename_trans->tclass,&flavors[SYM_CLASSES] ))
+			goto bad;
+		if (validate_simpletype(filename_trans->otype, p, flavors))
+			goto bad;
+
+		/* currently only the RULE_SELF flag can be set */
+		if ((filename_trans->flags & ~RULE_SELF) != 0)
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid filename trans rule list");
+	return -1;
+}
+
 static int validate_symtabs(sepol_handle_t *handle, const symtab_t symtabs[], validate_t flavors[])
 {
 	unsigned int i;
@@ -1347,6 +1372,8 @@ static int validate_avrule_blocks(sepol_handle_t *handle, const avrule_block_t *
 				goto bad;
 			if (validate_scope_index(handle, &decl->declared, flavors))
 				goto bad;
+			if (validate_filename_trans_rules(handle, decl->filename_trans_rules, p, flavors))
+				goto bad;
 			if (validate_symtabs(handle, decl->symtab, flavors))
 				goto bad;
 		}
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 2035b350..c4d593ab 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1970,10 +1970,6 @@ static int avrule_write(policydb_t *p, avrule_t * avrule,
 	uint32_t buf[32], len;
 	class_perm_node_t *cur;
 
-	/* skip filename transitions for now */
-	if (avrule->specified & AVRULE_TRANSITION && avrule->object_name)
-		return POLICYDB_SUCCESS;
-
 	if (p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS &&
 	    (avrule->specified & AVRULE_TYPE) &&
 	    (avrule->flags & RULE_SELF)) {
@@ -2067,9 +2063,7 @@ static int avrule_write_list(policydb_t *p, avrule_t * avrules,
 	avrule = avrules;
 	len = 0;
 	while (avrule) {
-		if (!(avrule->specified & AVRULE_TRANSITION &&
-		      avrule->object_name))
-			len++;
+		len++;
 		avrule = avrule->next;
 	}
 
@@ -2168,67 +2162,55 @@ static int role_allow_rule_write(role_allow_rule_t * r, struct policy_file *fp)
 	return POLICYDB_SUCCESS;
 }
 
-static int filename_trans_rule_write(policydb_t *p, avrule_t *rules,
+static int filename_trans_rule_write(policydb_t *p, filename_trans_rule_t *t,
 				     struct policy_file *fp)
 {
 	int nel = 0;
 	size_t items, entries;
 	uint32_t buf[3], len;
-	avrule_t *rule;
-	class_perm_node_t *perm;
+	filename_trans_rule_t *ftr;
 
-	for (rule = rules; rule; rule = rule->next) {
-		if (rule->specified & AVRULE_TRANSITION && rule->object_name) {
-			for (perm = rule->perms; perm; perm = perm->next) {
-				nel++;
-			}
-		}
-	}
+	for (ftr = t; ftr; ftr = ftr->next)
+		nel++;
 
 	buf[0] = cpu_to_le32(nel);
 	items = put_entry(buf, sizeof(uint32_t), 1, fp);
 	if (items != 1)
 		return POLICYDB_ERROR;
 
-	for (rule = rules; rule; rule = rule->next) {
-		if (!(rule->specified & AVRULE_TRANSITION && rule->object_name))
-			continue;
-		len = strlen(rule->object_name);
-		for (perm = rule->perms; perm; perm = perm->next) {
-			buf[0] = cpu_to_le32(len);
-			items = put_entry(buf, sizeof(uint32_t), 1, fp);
-			if (items != 1)
-				return POLICYDB_ERROR;
+	for (ftr = t; ftr; ftr = ftr->next) {
+		len = strlen(ftr->name);
+		buf[0] = cpu_to_le32(len);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
 
-			items = put_entry(rule->object_name, sizeof(char), len,
-					  fp);
-			if (items != len)
-				return POLICYDB_ERROR;
+		items = put_entry(ftr->name, sizeof(char), len, fp);
+		if (items != len)
+			return POLICYDB_ERROR;
 
-			if (type_set_write(&rule->stypes, fp))
-				return POLICYDB_ERROR;
-			if (type_set_write(&rule->ttypes, fp))
-				return POLICYDB_ERROR;
+		if (type_set_write(&ftr->stypes, fp))
+			return POLICYDB_ERROR;
+		if (type_set_write(&ftr->ttypes, fp))
+			return POLICYDB_ERROR;
 
-			buf[0] = cpu_to_le32(perm->tclass);
-			buf[1] = cpu_to_le32(perm->data);
-			buf[2] = cpu_to_le32(rule->flags);
-
-			if (p->policyvers >=
-			    MOD_POLICYDB_VERSION_SELF_TYPETRANS) {
-				entries = 3;
-			} else if (!(rule->flags & RULE_SELF)) {
-				entries = 2;
-			} else {
-				ERR(fp->handle,
-				    "Module contains a self rule not supported by the target module policy version");
-				return POLICYDB_ERROR;
-			}
+		buf[0] = cpu_to_le32(ftr->tclass);
+		buf[1] = cpu_to_le32(ftr->otype);
+		buf[2] = cpu_to_le32(ftr->flags);
 
-			items = put_entry(buf, sizeof(uint32_t), entries, fp);
-			if (items != entries)
-				return POLICYDB_ERROR;
+		if (p->policyvers >= MOD_POLICYDB_VERSION_SELF_TYPETRANS) {
+			entries = 3;
+		} else if (!(ftr->flags & RULE_SELF)) {
+			entries = 2;
+		} else {
+			ERR(fp->handle,
+			    "Module contains a self rule not supported by the target module policy version");
+			return POLICYDB_ERROR;
 		}
+
+		items = put_entry(buf, sizeof(uint32_t), entries, fp);
+		if (items != entries)
+			return POLICYDB_ERROR;
 	}
 	return POLICYDB_SUCCESS;
 }
@@ -2302,7 +2284,7 @@ static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
 	}
 
 	if (p->policyvers >= MOD_POLICYDB_VERSION_FILENAME_TRANS &&
-	    filename_trans_rule_write(p, decl->avrules, fp))
+	    filename_trans_rule_write(p, decl->filename_trans_rules, fp))
 		return POLICYDB_ERROR;
 
 	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
-- 
2.41.0

