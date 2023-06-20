Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D123EB64DB
	for <selinux@archiver.kernel.org>; Tue, 20 Jun 2023 09:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjFTJCg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjFTJCd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Jun 2023 05:02:33 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEDE1706
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 02:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687251743; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=bXSrxpEHdZhQ6cEQB9WHCyt6MiOslmMyKHhh7/m5tQaXPmxmgm1Pz1Qjv4p+BQa/abWn1u7eYrqbDNpVY0e7j7Qed9t0VWcr2o+r+VKcgJqkjaiAN+R6YEsEIneNYscHdtsULtGNziMvsEjHFUbnyRuPdwCj+OegF+Cz+mj9P4U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1687251743; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=41DagNBY51Sv6DxbtPcGnCsly9E3PsHLL7ATv5HFqXI=; 
        b=fPaL+ZGQXnz2WBNBgNyFWFL+pTTnx1j+SfeHe5wAKB7fQOkpoja4bWdNwMfc2F2sTJaB1+S7StlbYLT73KdIEwXf0oAThJs1PO210fZqSIiSLo92+QwUEp88oB6HZsf5XuTGFA7XtSuqpFDzaICI798cyHc464+aBibKsucY77M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687251743;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=41DagNBY51Sv6DxbtPcGnCsly9E3PsHLL7ATv5HFqXI=;
        b=V0n7BkVabACIrdtWf0Hpk6vNVBmDqN/cztArtGiUi2/N4LOQEvqYDH975y7h+3vN
        aLwpdzBBuAmacsbw0TSLmVpqmUQCRSDXDkRiJwqrL225gHpowsl8j99wWSeTxT6eg6a
        6xU0Gn5Sl1AsaFgVtkmg71v8pZouhkh1wzBrEc+s=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1687251742559691.6562824648195; Tue, 20 Jun 2023 11:02:22 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [213.175.37.12])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 03F982081F76;
        Tue, 20 Jun 2023 09:02:22 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 3/8] checkpolicy,libsepol: move filename transition rules to avrule
Date:   Tue, 20 Jun 2023 11:01:18 +0200
Message-Id: <d59ca7606adbb1c01f2187b9965cd847656bc026.1687251081.git.juraj@jurajmarcin.com>
In-Reply-To: <cover.1687251081.git.juraj@jurajmarcin.com>
References: <cover.1687251081.git.juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Similarly to the previous patch, filename transition rules are stored
and parsed separately from other type enforcement rules. Moving them to
avrule makes it consistent with the filename transitions in avtab and
makes future improvements easier to implement.

This patch adds an optional object name attribute to the avrule
structure and uses this new attribute to move filename transition rules
to avrule. It also updates functions for parsing type enforcement rules
to accept rules with a filename as their last argument (filename
transition rules), separate functions for parsing filename transitions
are therefore no longer needed.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 checkpolicy/checkpolicy.c                  |   9 -
 checkpolicy/module_compiler.c              |  12 --
 checkpolicy/module_compiler.h              |   1 -
 checkpolicy/policy_define.c                | 215 +++------------------
 checkpolicy/policy_define.h                |   3 +-
 checkpolicy/policy_parse.y                 |   8 +-
 checkpolicy/test/dismod.c                  |  25 +--
 libsepol/cil/src/cil_binary.c              |   2 +
 libsepol/include/sepol/policydb/policydb.h |  16 +-
 libsepol/src/avrule_block.c                |   1 -
 libsepol/src/expand.c                      | 132 ++++---------
 libsepol/src/link.c                        |  56 +-----
 libsepol/src/module_to_cil.c               |  71 +------
 libsepol/src/policydb.c                    |  70 ++-----
 libsepol/src/policydb_validate.c           |  27 ---
 libsepol/src/write.c                       |  86 +++++----
 16 files changed, 154 insertions(+), 580 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 6e8ed833..2485142d 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -611,15 +611,6 @@ int main(int argc, char **argv)
 		parse_policy.mls =3D mlspol;
 		parse_policy.handle_unknown =3D handle_unknown;
=20
-		/*
-		 * Init and alloc te_avtab for filename transition duplicate
-		 * checking
-		 */
-		if (avtab_init(&parse_policy.te_avtab))
-			exit(1);
-		if (avtab_alloc(&parse_policy.te_avtab, 1 << 11))
-			exit(1);
-
 		policydbp =3D &parse_policy;
=20
 		if (read_source_policy(policydbp, file, "checkpolicy") < 0)
diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
index 3188af89..5fe1729a 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -1278,18 +1278,6 @@ void append_role_allow(role_allow_rule_t * role_al=
low_rules)
 	decl->role_allow_rules =3D role_allow_rules;
 }
=20
-/* this doesn't actually append, but really prepends it */
-void append_filename_trans(filename_trans_rule_t * filename_trans_rules)
-{
-	avrule_decl_t *decl =3D stack_top->decl;
-
-	/* filename transitions are not allowed within conditionals */
-	assert(stack_top->type =3D=3D 1);
-
-	filename_trans_rules->next =3D decl->filename_trans_rules;
-	decl->filename_trans_rules =3D filename_trans_rules;
-}
-
 /* this doesn't actually append, but really prepends it */
 void append_range_trans(range_trans_rule_t * range_tr_rules)
 {
diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compiler.=
h
index 29b824b4..6f8bb9b9 100644
--- a/checkpolicy/module_compiler.h
+++ b/checkpolicy/module_compiler.h
@@ -83,7 +83,6 @@ void append_avrule(avrule_t * avrule);
 void append_role_trans(role_trans_rule_t * role_tr_rules);
 void append_role_allow(role_allow_rule_t * role_allow_rules);
 void append_range_trans(range_trans_rule_t * range_tr_rules);
-void append_filename_trans(filename_trans_rule_t * filename_trans_rules)=
;
=20
 /* Create a new optional block and add it to the global policy.
  * During the second pass resolve the block's requirements.  Return 0
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index dc2ee8f3..25dbf25d 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1601,7 +1601,7 @@ static int set_types(type_set_t * set, char *id, in=
t *add, char starallowed)
 	return -1;
 }
=20
-static int define_compute_type_helper(int which, avrule_t ** rule)
+static int define_compute_type_helper(int which, avrule_t ** rule, int h=
as_filename)
 {
 	char *id;
 	type_datum_t *datum;
@@ -1669,6 +1669,14 @@ static int define_compute_type_helper(int which, a=
vrule_t ** rule)
 	}
 	free(id);
=20
+	if (has_filename) {
+		avrule->object_name =3D queue_remove(id_queue);
+		if (!avrule->object_name) {
+			yyerror("no object_name?");
+			goto bad;
+		}
+	}
+
 	ebitmap_for_each_positive_bit(&tclasses, node, i) {
 		perm =3D malloc(sizeof(class_perm_node_t));
 		if (!perm) {
@@ -1692,7 +1700,7 @@ static int define_compute_type_helper(int which, av=
rule_t ** rule)
 	return -1;
 }
=20
-int define_compute_type(int which)
+int define_compute_type(int which, int has_filename)
 {
 	char *id;
 	avrule_t *avrule;
@@ -1706,10 +1714,14 @@ int define_compute_type(int which)
 			free(id);
 		id =3D queue_remove(id_queue);
 		free(id);
+		if (has_filename) {
+			id =3D queue_remove(id_queue);
+			free(id);
+		}
 		return 0;
 	}
=20
-	if (define_compute_type_helper(which, &avrule))
+	if (define_compute_type_helper(which, &avrule, has_filename))
 		return -1;
=20
 	append_avrule(avrule);
@@ -1733,7 +1745,7 @@ avrule_t *define_cond_compute_type(int which)
 		return (avrule_t *) 1;
 	}
=20
-	if (define_compute_type_helper(which, &avrule))
+	if (define_compute_type_helper(which, &avrule, 0))
 		return COND_ERR;
=20
 	return avrule;
@@ -2375,6 +2387,13 @@ static int avrule_cpy(avrule_t *dest, const avrule=
_t *src)
 		yyerror("out of memory");
 		return -1;
 	}
+	if (src->object_name) {
+		dest->object_name =3D strdup(src->object_name);
+		if (!dest->object_name) {
+			yyerror("out of memory");
+			return -1;
+		}
+	}
 	dest->line =3D src->line;
 	dest->source_filename =3D strdup(source_file);
 	if (!dest->source_filename) {
@@ -3343,194 +3362,6 @@ avrule_t *define_cond_filename_trans(void)
 	return COND_ERR;
 }
=20
-int define_filename_trans(void)
-{
-	char *id, *name =3D NULL;
-	type_set_t stypes, ttypes;
-	ebitmap_t e_stypes, e_ttypes;
-	ebitmap_t e_tclasses;
-	ebitmap_node_t *snode, *tnode, *cnode;
-	filename_trans_rule_t *ftr;
-	type_datum_t *typdatum;
-	avtab_key_t avt_key;
-	uint32_t otype;
-	unsigned int c, s, t;
-	int add, self, rc;
-
-	if (pass =3D=3D 1) {
-		/* stype */
-		while ((id =3D queue_remove(id_queue)))
-			free(id);
-		/* ttype */
-		while ((id =3D queue_remove(id_queue)))
-			free(id);
-		/* tclass */
-		while ((id =3D queue_remove(id_queue)))
-			free(id);
-		/* otype */
-		id =3D queue_remove(id_queue);
-		free(id);
-		/* name */
-		id =3D queue_remove(id_queue);
-		free(id);
-		return 0;
-	}
-
-	type_set_init(&stypes);
-	type_set_init(&ttypes);
-	ebitmap_init(&e_stypes);
-	ebitmap_init(&e_ttypes);
-	ebitmap_init(&e_tclasses);
-
-	add =3D 1;
-	while ((id =3D queue_remove(id_queue))) {
-		if (set_types(&stypes, id, &add, 0))
-			goto bad;
-	}
-
-	self =3D 0;
-	add =3D 1;
-	while ((id =3D queue_remove(id_queue))) {
-		if (strcmp(id, "self") =3D=3D 0) {
-			free(id);
-			if (add =3D=3D 0) {
-				yyerror("-self is not supported");
-				goto bad;
-			}
-			self =3D 1;
-			continue;
-		}
-		if (set_types(&ttypes, id, &add, 0))
-			goto bad;
-	}
-
-	if (read_classes(&e_tclasses))
-		goto bad;
-
-	id =3D (char *)queue_remove(id_queue);
-	if (!id) {
-		yyerror("no otype in transition definition?");
-		goto bad;
-	}
-	if (!is_id_in_scope(SYM_TYPES, id)) {
-		yyerror2("type %s is not within scope", id);
-		free(id);
-		goto bad;
-	}
-	typdatum =3D hashtab_search(policydbp->p_types.table, id);
-	if (!typdatum) {
-		yyerror2("unknown type %s used in transition definition", id);
-		free(id);
-		goto bad;
-	}
-	free(id);
-	otype =3D typdatum->s.value;
-
-	name =3D queue_remove(id_queue);
-	if (!name) {
-		yyerror("no pathname specified in filename_trans definition?");
-		goto bad;
-	}
-
-	/* We expand the class set into separate rules.  We expand the types
-	 * just to make sure there are not duplicates.  They will get turned
-	 * into separate rules later */
-	if (type_set_expand(&stypes, &e_stypes, policydbp, 1))
-		goto bad;
-
-	if (type_set_expand(&ttypes, &e_ttypes, policydbp, 1))
-		goto bad;
-
-	ebitmap_for_each_positive_bit(&e_tclasses, cnode, c) {
-		ebitmap_for_each_positive_bit(&e_stypes, snode, s) {
-			ebitmap_for_each_positive_bit(&e_ttypes, tnode, t) {
-				avt_key.specified =3D AVTAB_TRANSITION;
-				avt_key.source_type =3D s + 1;
-				avt_key.target_type =3D t + 1;
-				avt_key.target_class =3D c + 1;
-				rc =3D avtab_insert_filename_trans(
-					&policydbp->te_avtab, &avt_key, otype,
-					name, NULL
-				);
-				if (rc !=3D SEPOL_OK) {
-					if (rc =3D=3D SEPOL_EEXIST) {
-						yyerror2("duplicate filename transition for: filename_trans %s %s =
%s:%s",
-							name,
-							policydbp->p_type_val_to_name[s],
-							policydbp->p_type_val_to_name[t],
-							policydbp->p_class_val_to_name[c]);
-						goto bad;
-					}
-					yyerror("out of memory");
-					goto bad;
-				}
-			}
-			if (self) {
-				avt_key.specified =3D AVTAB_TRANSITION;
-				avt_key.source_type =3D s + 1;
-				avt_key.target_type =3D t + 1;
-				avt_key.target_class =3D c + 1;
-				rc =3D avtab_insert_filename_trans(
-					&policydbp->te_avtab, &avt_key, otype,
-					name, NULL
-				);
-				if (rc !=3D SEPOL_OK) {
-					if (rc =3D=3D SEPOL_EEXIST) {
-						yyerror2("duplicate filename transition for: filename_trans %s %s =
%s:%s",
-							name,
-							policydbp->p_type_val_to_name[s],
-							policydbp->p_type_val_to_name[s],
-							policydbp->p_class_val_to_name[c]);
-						goto bad;
-					}
-					yyerror("out of memory");
-					goto bad;
-				}
-			}
-		}
-=09
-		/* Now add the real rule since we didn't find any duplicates */
-		ftr =3D malloc(sizeof(*ftr));
-		if (!ftr) {
-			yyerror("out of memory");
-			goto bad;
-		}
-		filename_trans_rule_init(ftr);
-		append_filename_trans(ftr);
-
-		ftr->name =3D strdup(name);
-		if (type_set_cpy(&ftr->stypes, &stypes)) {
-			yyerror("out of memory");
-			goto bad;
-		}
-		if (type_set_cpy(&ftr->ttypes, &ttypes)) {
-			yyerror("out of memory");
-			goto bad;
-		}
-		ftr->tclass =3D c + 1;
-		ftr->otype =3D otype;
-		ftr->flags =3D self ? RULE_SELF : 0;
-	}
-
-	free(name);
-	ebitmap_destroy(&e_stypes);
-	ebitmap_destroy(&e_ttypes);
-	ebitmap_destroy(&e_tclasses);
-	type_set_destroy(&stypes);
-	type_set_destroy(&ttypes);
-
-	return 0;
-
-bad:
-	free(name);
-	ebitmap_destroy(&e_stypes);
-	ebitmap_destroy(&e_ttypes);
-	ebitmap_destroy(&e_tclasses);
-	type_set_destroy(&stypes);
-	type_set_destroy(&ttypes);
-	return -1;
-}
-
 static constraint_expr_t *constraint_expr_clone(const constraint_expr_t =
* expr)
 {
 	constraint_expr_t *h =3D NULL, *l =3D NULL, *newe;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 50a7ba78..5d0f70e4 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -28,7 +28,7 @@ int define_default_role(int which);
 int define_default_type(int which);
 int define_default_range(int which);
 int define_common_perms(void);
-int define_compute_type(int which);
+int define_compute_type(int which, int has_filename);
 int define_conditional(cond_expr_t *expr, avrule_t *t_list, avrule_t *f_=
list );
 int define_constraint(constraint_expr_t *expr);
 int define_dominance(void);
@@ -57,7 +57,6 @@ int define_role_trans(int class_specified);
 int define_role_types(void);
 int define_role_attr(void);
 int define_roleattribute(void);
-int define_filename_trans(void);
 int define_sens(void);
 int define_te_avtab(int which);
 int define_te_avtab_extended_perms(int which);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index da32a776..2a14fc1e 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -451,13 +451,13 @@ cond_dontaudit_def	: DONTAUDIT names names ':' name=
s names ';'
 		        ;
 			;
 transition_def		: TYPE_TRANSITION  names names ':' names identifier file=
name ';'
-			{if (define_filename_trans()) return -1; }
+			{if (define_compute_type(AVRULE_TRANSITION, 1)) return -1; }
 			| TYPE_TRANSITION names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_TRANSITION)) ret=
urn -1;}
+                        {if (define_compute_type(AVRULE_TRANSITION, 0)) =
return -1;}
                         | TYPE_MEMBER names names ':' names identifier '=
;'
-                        {if (define_compute_type(AVRULE_MEMBER)) return =
-1;}
+                        {if (define_compute_type(AVRULE_MEMBER, 0)) retu=
rn -1;}
                         | TYPE_CHANGE names names ':' names identifier '=
;'
-                        {if (define_compute_type(AVRULE_CHANGE)) return =
-1;}
+                        {if (define_compute_type(AVRULE_CHANGE, 0)) retu=
rn -1;}
     			;
 range_trans_def		: RANGE_TRANSITION names names mls_range_def ';'
 			{ if (define_range_trans(0)) return -1; }
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 515fc9a5..cde80f95 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -50,7 +50,6 @@
 #define DISPLAY_AVBLOCK_ROLE_ALLOW	4
 #define DISPLAY_AVBLOCK_REQUIRES	5
 #define DISPLAY_AVBLOCK_DECLARES	6
-#define DISPLAY_AVBLOCK_FILENAME_TRANS	7
=20
 static policydb_t policydb;
 extern unsigned int ss_initialized;
@@ -90,7 +89,6 @@ static struct command {
 	{CMD,       'c', "Display policy capabilities"},
 	{CMD|NOOPT, 'l', "Link in a module"},
 	{CMD,       'u', "Display the unknown handling setting"},
-	{CMD,       'F', "Display filename_trans rules"},
 	{HEADER, 0, ""},
 	{CMD|NOOPT, 'f',  "set output file"},
 	{CMD|NOOPT, 'm',  "display menu"},
@@ -339,6 +337,8 @@ static int display_avrule(avrule_t * avrule, policydb=
_t * policy,
 				   policy, fp);
 	} else if (avrule->specified & AVRULE_TYPE) {
 		display_id(policy, fp, SYM_TYPES, avrule->perms->data - 1, "");
+		if (avrule->object_name)
+			fprintf(fp, " \"%s\"", avrule->object_name);
 	} else if (avrule->specified & AVRULE_XPERMS) {
 		avtab_extended_perms_t xperms;
 		int i;
@@ -556,18 +556,6 @@ static void display_role_allow(role_allow_rule_t * r=
a, policydb_t * p, FILE * fp
 	}
 }
=20
-static void display_filename_trans(filename_trans_rule_t * tr, policydb_=
t * p, FILE * fp)
-{
-	fprintf(fp, "filename transition");
-	for (; tr; tr =3D tr->next) {
-		display_type_set(&tr->stypes, 0, p, fp);
-		display_type_set(&tr->ttypes, 0, p, fp);
-		display_id(p, fp, SYM_CLASSES, tr->tclass - 1, ":");
-		display_id(p, fp, SYM_TYPES, tr->otype - 1, "");
-		fprintf(fp, " %s\n", tr->name);
-	}
-}
-
 static int role_display_callback(hashtab_key_t key __attribute__((unused=
)),
 			  hashtab_datum_t datum, void *data)
 {
@@ -732,10 +720,6 @@ static int display_avdecl(avrule_decl_t * decl, int =
field,
 			}
 			break;
 		}
-	case DISPLAY_AVBLOCK_FILENAME_TRANS:
-		display_filename_trans(decl->filename_trans_rules, policy,
-				       out_fp);
-		break;
 	default:{
 			assert(0);
 		}
@@ -1061,11 +1045,6 @@ int main(int argc, char **argv)
 			if (out_fp !=3D stdout)
 				printf("\nOutput to file: %s\n", OutfileName);
 			break;
-		case 'F':
-			fprintf(out_fp, "filename_trans rules:\n");
-			display_avblock(DISPLAY_AVBLOCK_FILENAME_TRANS,
-					&policydb, out_fp);
-			break;
 		case 'l':
 			link_module(&policydb, out_fp);
 			break;
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
index 7150d405..996bad70 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4650,6 +4650,7 @@ static avrule_t *__cil_init_sepol_avrule(uint32_t k=
ind, struct cil_tree_node *no
 	__cil_init_sepol_type_set(&avrule->stypes);
 	__cil_init_sepol_type_set(&avrule->ttypes);
 	avrule->perms =3D NULL;
+	avrule->object_name =3D NULL;
 	avrule->line =3D node->line;
=20
 	avrule->source_filename =3D NULL;
@@ -4676,6 +4677,7 @@ static void __cil_destroy_sepol_avrules(avrule_t *c=
urr)
 		ebitmap_destroy(&curr->stypes.negset);
 		ebitmap_destroy(&curr->ttypes.types);
 		ebitmap_destroy(&curr->ttypes.negset);
+		free(curr->object_name);
 		__cil_destroy_sepol_class_perms(curr->perms);
 		free(curr);
 		curr =3D next;
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
index 8bb11d18..d30f26af 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -278,6 +278,7 @@ typedef struct avrule {
 	type_set_t stypes;
 	type_set_t ttypes;
 	class_perm_node_t *perms;
+	char *object_name;	/* optional object name */
 	av_extended_perms_t *xperms;
 	unsigned long line;	/* line number from policy.conf where
 				 * this rule originated  */
@@ -301,16 +302,6 @@ typedef struct role_allow_rule {
 	struct role_allow_rule *next;
 } role_allow_rule_t;
=20
-typedef struct filename_trans_rule {
-	uint32_t flags; /* may have RULE_SELF set */
-	type_set_t stypes;
-	type_set_t ttypes;
-	uint32_t tclass;
-	char *name;
-	uint32_t otype;	/* new type */
-	struct filename_trans_rule *next;
-} filename_trans_rule_t;
-
 typedef struct range_trans_rule {
 	type_set_t stypes;
 	type_set_t ttypes;
@@ -451,9 +442,6 @@ typedef struct avrule_decl {
 	scope_index_t required;	/* symbols needed to activate this block */
 	scope_index_t declared;	/* symbols declared within this block */
=20
-	/* type transition rules with a 'name' component */
-	filename_trans_rule_t *filename_trans_rules;
-
 	/* for additive statements (type attribute, roles, and users) */
 	symtab_t symtab[SYM_NUM];
=20
@@ -656,8 +644,6 @@ extern void avrule_destroy(avrule_t * x);
 extern void avrule_list_destroy(avrule_t * x);
 extern void role_trans_rule_init(role_trans_rule_t * x);
 extern void role_trans_rule_list_destroy(role_trans_rule_t * x);
-extern void filename_trans_rule_init(filename_trans_rule_t * x);
-extern void filename_trans_rule_list_destroy(filename_trans_rule_t * x);
=20
 extern void role_datum_init(role_datum_t * x);
 extern void role_datum_destroy(role_datum_t * x);
diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index dcfce8b8..fce4e772 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -99,7 +99,6 @@ void avrule_decl_destroy(avrule_decl_t * x)
 	cond_list_destroy(x->cond_list);
 	avrule_list_destroy(x->avrules);
 	role_trans_rule_list_destroy(x->role_tr_rules);
-	filename_trans_rule_list_destroy(x->filename_trans_rules);
 	role_allow_rule_list_destroy(x->role_allow_rules);
 	range_trans_rule_list_destroy(x->range_tr_rules);
 	scope_index_destroy(&x->required);
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 878b0f21..a4c92f4f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1407,94 +1407,6 @@ static int copy_role_trans(expand_state_t * state,=
 role_trans_rule_t * rules)
 	return 0;
 }
=20
-static int expand_filename_trans_helper(expand_state_t *state,
-					filename_trans_rule_t *rule,
-					unsigned int s, unsigned int t)
-{
-	uint32_t mapped_otype, present_otype;
-	int rc;
-	avtab_key_t avt_key;
-
-	mapped_otype =3D state->typemap[rule->otype - 1];
-
-	avt_key.specified =3D AVTAB_TRANSITION;
-	avt_key.source_type =3D s + 1;
-	avt_key.target_type =3D t + 1;
-	avt_key.target_class =3D rule->tclass;
-
-	rc =3D avtab_insert_filename_trans(&state->out->te_avtab, &avt_key,
-		mapped_otype, rule->name, &present_otype);
-	if (rc =3D=3D SEPOL_EEXIST) {
-		/* duplicate rule, ignore */
-		if (present_otype =3D=3D mapped_otype)
-			return 0;
-
-		ERR(state->handle, "Conflicting name-based type_transition %s %s:%s \"=
%s\":  %s vs %s",
-		    state->out->p_type_val_to_name[s],
-		    state->out->p_type_val_to_name[t],
-		    state->out->p_class_val_to_name[rule->tclass - 1],
-		    rule->name,
-		    state->out->p_type_val_to_name[present_otype - 1],
-		    state->out->p_type_val_to_name[mapped_otype - 1]);
-		return -1;
-	} else if (rc < 0) {
-		ERR(state->handle, "Out of memory!");
-		return -1;
-	}
-	return 0;
-}
-
-static int expand_filename_trans(expand_state_t *state, filename_trans_r=
ule_t *rules)
-{
-	unsigned int i, j;
-	filename_trans_rule_t *cur_rule;
-	ebitmap_t stypes, ttypes;
-	ebitmap_node_t *snode, *tnode;
-	int rc;
-
-	cur_rule =3D rules;
-	while (cur_rule) {
-		ebitmap_init(&stypes);
-		ebitmap_init(&ttypes);
-
-		if (expand_convert_type_set(state->out, state->typemap,
-					    &cur_rule->stypes, &stypes, 1)) {
-			ERR(state->handle, "Out of memory!");
-			return -1;
-		}
-
-		if (expand_convert_type_set(state->out, state->typemap,
-					    &cur_rule->ttypes, &ttypes, 1)) {
-			ERR(state->handle, "Out of memory!");
-			return -1;
-		}
-
-
-		ebitmap_for_each_positive_bit(&stypes, snode, i) {
-			ebitmap_for_each_positive_bit(&ttypes, tnode, j) {
-				rc =3D expand_filename_trans_helper(
-					state, cur_rule, i, j
-				);
-				if (rc)
-					return rc;
-			}
-			if (cur_rule->flags & RULE_SELF) {
-				rc =3D expand_filename_trans_helper(
-					state, cur_rule, i, i
-				);
-				if (rc)
-					return rc;
-			}
-		}
-
-		ebitmap_destroy(&stypes);
-		ebitmap_destroy(&ttypes);
-
-		cur_rule =3D cur_rule->next;
-	}
-	return 0;
-}
-
 static int exp_rangetr_helper(uint32_t stype, uint32_t ttype, uint32_t t=
class,
 			      mls_semantic_range_t * trange,
 			      expand_state_t * state)
@@ -1708,7 +1620,7 @@ static int expand_terule_helper(sepol_handle_t * ha=
ndle,
 				uint32_t specified, cond_av_list_t ** cond,
 				cond_av_list_t ** other, uint32_t stype,
 				uint32_t ttype, class_perm_node_t * perms,
-				avtab_t * avtab, int enabled)
+				char *object_name, avtab_t * avtab, int enabled)
 {
 	avtab_key_t avkey;
 	avtab_datum_t *avdatump;
@@ -1732,6 +1644,34 @@ static int expand_terule_helper(sepol_handle_t * h=
andle,
 		    typemap ? typemap[cur->data - 1] : cur->data;
 		avkey.target_class =3D cur->tclass;
=20
+		/*
+		 * if expanded node is a filename transition, insert it, insert
+		 * function checks for duplicates
+		 */
+		if (specified & AVRULE_TRANSITION && object_name) {
+			int rc =3D avtab_insert_filename_trans(avtab, &avkey,
+							     remapped_data,
+							     object_name,
+							     &oldtype);
+			if (rc =3D=3D SEPOL_EEXIST) {
+				ERR(handle, "conflicting filename transition %s %s:%s \"%s\": %s vs =
%s",
+				    p->p_type_val_to_name[avkey.source_type - 1],
+				    p->p_type_val_to_name[avkey.target_type - 1],
+				    p->p_class_val_to_name[avkey.target_class - 1],
+				    object_name,
+				    p->p_type_val_to_name[oldtype - 1],
+				    p->p_type_val_to_name[remapped_data - 1]);
+				return EXPAND_RULE_CONFLICT;
+			}
+			if (rc < 0)
+				return EXPAND_RULE_ERROR;
+			/*
+			 * filename transtion inserted, continue with next node
+			 */
+			cur =3D cur->next;
+			continue;
+		}
+
 		conflict =3D 0;
 		/* check to see if the expanded TE already exists --
 		 * either in the global scope or in another
@@ -1777,12 +1717,9 @@ static int expand_terule_helper(sepol_handle_t * h=
andle,
 				    || node->parse_context =3D=3D cond)
 					return EXPAND_RULE_SUCCESS;
 				ERR(handle, "duplicate TE rule for %s %s:%s %s",
-				    p->p_type_val_to_name[avkey.source_type -
-							  1],
-				    p->p_type_val_to_name[avkey.target_type -
-							  1],
-				    p->p_class_val_to_name[avkey.target_class -
-							   1],
+				    p->p_type_val_to_name[avkey.source_type - 1],
+				    p->p_type_val_to_name[avkey.target_type - 1],
+				    p->p_class_val_to_name[avkey.target_class - 1],
 				    p->p_type_val_to_name[oldtype - 1]);
 				return EXPAND_RULE_CONFLICT;
 			}
@@ -1947,6 +1884,7 @@ static int expand_rule_helper(sepol_handle_t * hand=
le,
 				retval =3D expand_terule_helper(handle, p, typemap,
 							      source_rule->specified, cond,
 							      other, i, i, source_rule->perms,
+							      source_rule->object_name,
 							      dest_avtab, enabled);
 				if (retval !=3D EXPAND_RULE_SUCCESS)
 					return retval;
@@ -1963,6 +1901,7 @@ static int expand_rule_helper(sepol_handle_t * hand=
le,
 				retval =3D expand_terule_helper(handle, p, typemap,
 							      source_rule->specified, cond,
 							      other, i, j, source_rule->perms,
+							      source_rule->object_name,
 							      dest_avtab, enabled);
 				if (retval !=3D EXPAND_RULE_SUCCESS)
 					return retval;
@@ -2791,9 +2730,6 @@ static int copy_and_expand_avrule_block(expand_stat=
e_t * state)
 			goto cleanup;
 		}
=20
-		if (expand_filename_trans(state, decl->filename_trans_rules))
-			goto cleanup;
-
 		/* expand the range transition rules */
 		if (expand_range_trans(state, decl->range_tr_rules))
 			goto cleanup;
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 3b7742bc..88b23594 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1249,6 +1249,12 @@ static int copy_avrule_list(avrule_t * list, avrul=
e_t ** dst,
 			goto cleanup;
 		}
=20
+		if (cur->object_name) {
+			new_rule->object_name =3D strdup(cur->object_name);
+			if (!new_rule->object_name)
+				goto cleanup;
+		}
+
 		cur_perm =3D cur->perms;
 		tail_perm =3D NULL;
 		while (cur_perm) {
@@ -1412,51 +1418,6 @@ static int copy_role_allow_list(role_allow_rule_t =
* list,
 	return -1;
 }
=20
-static int copy_filename_trans_list(filename_trans_rule_t * list,
-				    filename_trans_rule_t ** dst,
-				    policy_module_t * module,
-				    link_state_t * state)
-{
-	filename_trans_rule_t *cur, *new_rule, *tail;
-
-	cur =3D list;
-	tail =3D *dst;
-	while (tail && tail->next)
-		tail =3D tail->next;
-
-	while (cur) {
-		new_rule =3D malloc(sizeof(*new_rule));
-		if (!new_rule)
-			goto err;
-
-		filename_trans_rule_init(new_rule);
-
-		if (*dst =3D=3D NULL)
-			*dst =3D new_rule;
-		else
-			tail->next =3D new_rule;
-		tail =3D new_rule;
-
-		new_rule->name =3D strdup(cur->name);
-		if (!new_rule->name)
-			goto err;
-
-		if (type_set_or_convert(&cur->stypes, &new_rule->stypes, module) ||
-		    type_set_or_convert(&cur->ttypes, &new_rule->ttypes, module))
-			goto err;
-
-		new_rule->tclass =3D module->map[SYM_CLASSES][cur->tclass - 1];
-		new_rule->otype =3D module->map[SYM_TYPES][cur->otype - 1];
-		new_rule->flags =3D cur->flags;
-
-		cur =3D cur->next;
-	}
-	return 0;
-err:
-	ERR(state->handle, "Out of memory!");
-	return -1;
-}
-
 static int copy_range_trans_list(range_trans_rule_t * rules,
 				 range_trans_rule_t ** dst,
 				 policy_module_t * mod, link_state_t * state)
@@ -1679,11 +1640,6 @@ static int copy_avrule_decl(link_state_t * state, =
policy_module_t * module,
 		return -1;
 	}
=20
-	if (copy_filename_trans_list(src_decl->filename_trans_rules,
-				     &dest_decl->filename_trans_rules,
-				     module, state))
-		return -1;
-
 	if (copy_range_trans_list(src_decl->range_tr_rules,
 				  &dest_decl->range_tr_rules, module, state))
 		return -1;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 1a490089..1e002c4e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -547,7 +547,7 @@ static int semantic_level_to_cil(struct policydb *pdb=
, int sens_offset, struct m
 	return 0;
 }
=20
-static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type=
, const char *src, const char *tgt, const struct class_perm_node *classpe=
rms)
+static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type=
, const char *src, const char *tgt, const char *object_name, const struct=
 class_perm_node *classperms)
 {
 	int rc =3D -1;
 	const char *rule;
@@ -597,6 +597,12 @@ static int avrule_to_cil(int indent, struct policydb=
 *pdb, uint32_t type, const
 					rule, src, tgt,
 					pdb->p_class_val_to_name[classperm->tclass - 1],
 					perms + 1);
+		} else if (object_name) {
+			cil_println(indent, "(%s %s %s %s \"%s\" %s)",
+					rule, src, tgt,
+					pdb->p_class_val_to_name[classperm->tclass - 1],
+					object_name,
+					pdb->p_type_val_to_name[classperm->data - 1]);
 		} else {
 			cil_println(indent, "(%s %s %s %s %s)",
 					rule, src, tgt,
@@ -1199,7 +1205,7 @@ static int avrule_list_to_cil(int indent, struct po=
licydb *pdb, struct avrule *a
 				if (avrule->specified & AVRULE_XPERMS) {
 					rc =3D avrulex_to_cil(indent, pdb, avrule->specified, snames[s], tn=
ames[t], avrule->perms, avrule->xperms);
 				} else {
-					rc =3D avrule_to_cil(indent, pdb, avrule->specified, snames[s], tna=
mes[t], avrule->perms);
+					rc =3D avrule_to_cil(indent, pdb, avrule->specified, snames[s], tna=
mes[t], avrule->object_name, avrule->perms);
 				}
 				if (rc !=3D 0) {
 					goto exit;
@@ -1210,7 +1216,7 @@ static int avrule_list_to_cil(int indent, struct po=
licydb *pdb, struct avrule *a
 				if (avrule->specified & AVRULE_XPERMS) {
 					rc =3D avrulex_to_cil(indent, pdb, avrule->specified, snames[s], "s=
elf", avrule->perms, avrule->xperms);
 				} else {
-					rc =3D avrule_to_cil(indent, pdb, avrule->specified, snames[s], "se=
lf", avrule->perms);
+					rc =3D avrule_to_cil(indent, pdb, avrule->specified, snames[s], "se=
lf", avrule->object_name, avrule->perms);
 				}
 				if (rc !=3D 0) {
 					goto exit;
@@ -1576,60 +1582,6 @@ exit:
 	return rc;
 }
=20
-static int filename_trans_to_cil(int indent, struct policydb *pdb, struc=
t filename_trans_rule *rules, struct list *attr_list)
-{
-	int rc =3D -1;
-	char **stypes =3D NULL;
-	unsigned int num_stypes =3D 0;
-	unsigned int stype;
-	char **ttypes =3D NULL;
-	unsigned int num_ttypes =3D 0;
-	unsigned int ttype;
-	struct type_set *ts;
-	struct filename_trans_rule *rule;
-
-	for (rule =3D rules; rule !=3D NULL; rule =3D rule->next) {
-		ts =3D &rule->stypes;
-		rc =3D process_typeset(pdb, ts, attr_list, &stypes, &num_stypes);
-		if (rc !=3D 0) {
-			goto exit;
-		}
-
-		ts =3D &rule->ttypes;
-		rc =3D process_typeset(pdb, ts, attr_list, &ttypes, &num_ttypes);
-		if (rc !=3D 0) {
-			goto exit;
-		}
-
-		for (stype =3D 0; stype < num_stypes; stype++) {
-			for (ttype =3D 0; ttype < num_ttypes; ttype++) {
-				cil_println(indent, "(typetransition %s %s %s \"%s\" %s)",
-					    stypes[stype], ttypes[ttype],
-					    pdb->p_class_val_to_name[rule->tclass - 1],
-					    rule->name,
-					    pdb->p_type_val_to_name[rule->otype - 1]);
-			}
-			if (rule->flags & RULE_SELF) {
-				cil_println(indent, "(typetransition %s self %s \"%s\" %s)",
-					    stypes[stype],
-					    pdb->p_class_val_to_name[rule->tclass - 1],
-					    rule->name,
-					    pdb->p_type_val_to_name[rule->otype - 1]);
-			}
-		}
-
-		names_destroy(&stypes, &num_stypes);
-		names_destroy(&ttypes, &num_ttypes);
-	}
-
-	rc =3D 0;
-exit:
-	names_destroy(&stypes, &num_stypes);
-	names_destroy(&ttypes, &num_ttypes);
-
-	return rc;
-}
-
 struct class_perm_datum {
 	char *name;
 	uint32_t val;
@@ -3683,11 +3635,6 @@ static int block_to_cil(struct policydb *pdb, stru=
ct avrule_block *block, struct
 		goto exit;
 	}
=20
-	rc =3D filename_trans_to_cil(indent, pdb, decl->filename_trans_rules, t=
ype_attr_list);
-	if (rc !=3D 0) {
-		goto exit;
-	}
-
 	rc =3D cond_list_to_cil(indent, pdb, decl->cond_list, type_attr_list);
 	if (rc !=3D 0) {
 		goto exit;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index c1ce9c34..4913ee21 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -638,6 +638,7 @@ void avrule_destroy(avrule_t * x)
 	}
=20
 	free(x->xperms);
+	free(x->object_name);
 }
=20
 void role_trans_rule_init(role_trans_rule_t * x)
@@ -667,33 +668,6 @@ void role_trans_rule_list_destroy(role_trans_rule_t =
* x)
 	}
 }
=20
-void filename_trans_rule_init(filename_trans_rule_t * x)
-{
-	memset(x, 0, sizeof(*x));
-	type_set_init(&x->stypes);
-	type_set_init(&x->ttypes);
-}
-
-static void filename_trans_rule_destroy(filename_trans_rule_t * x)
-{
-	if (!x)
-		return;
-	type_set_destroy(&x->stypes);
-	type_set_destroy(&x->ttypes);
-	free(x->name);
-}
-
-void filename_trans_rule_list_destroy(filename_trans_rule_t * x)
-{
-	filename_trans_rule_t *next;
-	while (x) {
-		next =3D x->next;
-		filename_trans_rule_destroy(x);
-		free(x);
-		x =3D next;
-	}
-}
-
 void role_allow_rule_init(role_allow_rule_t * x)
 {
 	memset(x, 0, sizeof(role_allow_rule_t));
@@ -3493,31 +3467,32 @@ static int role_allow_rule_read(role_allow_rule_t=
 ** r, struct policy_file *fp)
 	return 0;
 }
=20
-static int filename_trans_rule_read(policydb_t *p, filename_trans_rule_t=
 **r,
+static int filename_trans_rule_read(policydb_t *p, avrule_t **r,
 				    struct policy_file *fp)
 {
 	uint32_t buf[3], nel, i, len;
 	unsigned int entries;
-	filename_trans_rule_t *ftr, *lftr;
+	avrule_t *cur;
 	int rc;
=20
 	rc =3D next_entry(buf, fp, sizeof(uint32_t));
 	if (rc < 0)
 		return -1;
 	nel =3D le32_to_cpu(buf[0]);
-	lftr =3D NULL;
 	for (i =3D 0; i < nel; i++) {
-		ftr =3D malloc(sizeof(*ftr));
-		if (!ftr)
+		cur =3D malloc(sizeof(avrule_t));
+		if (!cur)
 			return -1;
+		avrule_init(cur);
=20
-		filename_trans_rule_init(ftr);
+		cur->next =3D *r;
+		*r =3D cur;
=20
-		if (lftr)
-			lftr->next =3D ftr;
-		else
-			*r =3D ftr;
-		lftr =3D ftr;
+		cur->specified =3D AVRULE_TRANSITION;
+		cur->perms =3D malloc(sizeof(class_perm_node_t));
+		if (!cur->perms)
+			return -1;
+		class_perm_node_init(cur->perms);
=20
 		rc =3D next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
@@ -3527,19 +3502,14 @@ static int filename_trans_rule_read(policydb_t *p=
, filename_trans_rule_t **r,
 		if (zero_or_saturated(len))
 			return -1;
=20
-		ftr->name =3D malloc(len + 1);
-		if (!ftr->name)
-			return -1;
-
-		rc =3D next_entry(ftr->name, fp, len);
+		rc =3D str_read(&cur->object_name, fp, len);
 		if (rc)
 			return -1;
-		ftr->name[len] =3D 0;
=20
-		if (type_set_read(&ftr->stypes, fp))
+		if (type_set_read(&cur->stypes, fp))
 			return -1;
=20
-		if (type_set_read(&ftr->ttypes, fp))
+		if (type_set_read(&cur->ttypes, fp))
 			return -1;
=20
 		if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRANS)
@@ -3550,10 +3520,10 @@ static int filename_trans_rule_read(policydb_t *p=
, filename_trans_rule_t **r,
 		rc =3D next_entry(buf, fp, sizeof(uint32_t) * entries);
 		if (rc < 0)
 			return -1;
-		ftr->tclass =3D le32_to_cpu(buf[0]);
-		ftr->otype =3D le32_to_cpu(buf[1]);
+		cur->perms->tclass =3D le32_to_cpu(buf[0]);
+		cur->perms->data =3D le32_to_cpu(buf[1]);
 		if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRANS)
-			ftr->flags =3D le32_to_cpu(buf[2]);
+			cur->flags =3D le32_to_cpu(buf[2]);
 	}
=20
 	return 0;
@@ -3656,7 +3626,7 @@ static int avrule_decl_read(policydb_t * p, avrule_=
decl_t * decl,
 	}
=20
 	if (p->policyvers >=3D MOD_POLICYDB_VERSION_FILENAME_TRANS &&
-	    filename_trans_rule_read(p, &decl->filename_trans_rules, fp))
+	    filename_trans_rule_read(p, &decl->avrules, fp))
 		return -1;
=20
 	if (p->policyvers >=3D MOD_POLICYDB_VERSION_RANGETRANS &&
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
index 89306185..0b8e8eee 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1313,31 +1313,6 @@ bad:
 	return -1;
 }
=20
-
-static int validate_filename_trans_rules(sepol_handle_t *handle, const f=
ilename_trans_rule_t *filename_trans, const policydb_t *p, validate_t fla=
vors[])
-{
-	for (; filename_trans; filename_trans =3D filename_trans->next) {
-		if (validate_type_set(&filename_trans->stypes, &flavors[SYM_TYPES]))
-			goto bad;
-		if (validate_type_set(&filename_trans->ttypes, &flavors[SYM_TYPES]))
-			goto bad;
-		if (validate_value(filename_trans->tclass,&flavors[SYM_CLASSES] ))
-			goto bad;
-		if (validate_simpletype(filename_trans->otype, p, flavors))
-			goto bad;
-
-		/* currently only the RULE_SELF flag can be set */
-		if ((filename_trans->flags & ~RULE_SELF) !=3D 0)
-			goto bad;
-	}
-
-	return 0;
-
-bad:
-	ERR(handle, "Invalid filename trans rule list");
-	return -1;
-}
-
 static int validate_symtabs(sepol_handle_t *handle, const symtab_t symta=
bs[], validate_t flavors[])
 {
 	unsigned int i;
@@ -1372,8 +1347,6 @@ static int validate_avrule_blocks(sepol_handle_t *h=
andle, const avrule_block_t *
 				goto bad;
 			if (validate_scope_index(handle, &decl->declared, flavors))
 				goto bad;
-			if (validate_filename_trans_rules(handle, decl->filename_trans_rules,=
 p, flavors))
-				goto bad;
 			if (validate_symtabs(handle, decl->symtab, flavors))
 				goto bad;
 		}
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index c4d593ab..2035b350 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1970,6 +1970,10 @@ static int avrule_write(policydb_t *p, avrule_t * =
avrule,
 	uint32_t buf[32], len;
 	class_perm_node_t *cur;
=20
+	/* skip filename transitions for now */
+	if (avrule->specified & AVRULE_TRANSITION && avrule->object_name)
+		return POLICYDB_SUCCESS;
+
 	if (p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS &&
 	    (avrule->specified & AVRULE_TYPE) &&
 	    (avrule->flags & RULE_SELF)) {
@@ -2063,7 +2067,9 @@ static int avrule_write_list(policydb_t *p, avrule_=
t * avrules,
 	avrule =3D avrules;
 	len =3D 0;
 	while (avrule) {
-		len++;
+		if (!(avrule->specified & AVRULE_TRANSITION &&
+		      avrule->object_name))
+			len++;
 		avrule =3D avrule->next;
 	}
=20
@@ -2162,55 +2168,67 @@ static int role_allow_rule_write(role_allow_rule_=
t * r, struct policy_file *fp)
 	return POLICYDB_SUCCESS;
 }
=20
-static int filename_trans_rule_write(policydb_t *p, filename_trans_rule_=
t *t,
+static int filename_trans_rule_write(policydb_t *p, avrule_t *rules,
 				     struct policy_file *fp)
 {
 	int nel =3D 0;
 	size_t items, entries;
 	uint32_t buf[3], len;
-	filename_trans_rule_t *ftr;
+	avrule_t *rule;
+	class_perm_node_t *perm;
=20
-	for (ftr =3D t; ftr; ftr =3D ftr->next)
-		nel++;
+	for (rule =3D rules; rule; rule =3D rule->next) {
+		if (rule->specified & AVRULE_TRANSITION && rule->object_name) {
+			for (perm =3D rule->perms; perm; perm =3D perm->next) {
+				nel++;
+			}
+		}
+	}
=20
 	buf[0] =3D cpu_to_le32(nel);
 	items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
 	if (items !=3D 1)
 		return POLICYDB_ERROR;
=20
-	for (ftr =3D t; ftr; ftr =3D ftr->next) {
-		len =3D strlen(ftr->name);
-		buf[0] =3D cpu_to_le32(len);
-		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items !=3D 1)
-			return POLICYDB_ERROR;
+	for (rule =3D rules; rule; rule =3D rule->next) {
+		if (!(rule->specified & AVRULE_TRANSITION && rule->object_name))
+			continue;
+		len =3D strlen(rule->object_name);
+		for (perm =3D rule->perms; perm; perm =3D perm->next) {
+			buf[0] =3D cpu_to_le32(len);
+			items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
+			if (items !=3D 1)
+				return POLICYDB_ERROR;
=20
-		items =3D put_entry(ftr->name, sizeof(char), len, fp);
-		if (items !=3D len)
-			return POLICYDB_ERROR;
+			items =3D put_entry(rule->object_name, sizeof(char), len,
+					  fp);
+			if (items !=3D len)
+				return POLICYDB_ERROR;
=20
-		if (type_set_write(&ftr->stypes, fp))
-			return POLICYDB_ERROR;
-		if (type_set_write(&ftr->ttypes, fp))
-			return POLICYDB_ERROR;
+			if (type_set_write(&rule->stypes, fp))
+				return POLICYDB_ERROR;
+			if (type_set_write(&rule->ttypes, fp))
+				return POLICYDB_ERROR;
=20
-		buf[0] =3D cpu_to_le32(ftr->tclass);
-		buf[1] =3D cpu_to_le32(ftr->otype);
-		buf[2] =3D cpu_to_le32(ftr->flags);
+			buf[0] =3D cpu_to_le32(perm->tclass);
+			buf[1] =3D cpu_to_le32(perm->data);
+			buf[2] =3D cpu_to_le32(rule->flags);
+
+			if (p->policyvers >=3D
+			    MOD_POLICYDB_VERSION_SELF_TYPETRANS) {
+				entries =3D 3;
+			} else if (!(rule->flags & RULE_SELF)) {
+				entries =3D 2;
+			} else {
+				ERR(fp->handle,
+				    "Module contains a self rule not supported by the target module =
policy version");
+				return POLICYDB_ERROR;
+			}
=20
-		if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRANS) {
-			entries =3D 3;
-		} else if (!(ftr->flags & RULE_SELF)) {
-			entries =3D 2;
-		} else {
-			ERR(fp->handle,
-			    "Module contains a self rule not supported by the target module p=
olicy version");
-			return POLICYDB_ERROR;
+			items =3D put_entry(buf, sizeof(uint32_t), entries, fp);
+			if (items !=3D entries)
+				return POLICYDB_ERROR;
 		}
-
-		items =3D put_entry(buf, sizeof(uint32_t), entries, fp);
-		if (items !=3D entries)
-			return POLICYDB_ERROR;
 	}
 	return POLICYDB_SUCCESS;
 }
@@ -2284,7 +2302,7 @@ static int avrule_decl_write(avrule_decl_t * decl, =
int num_scope_syms,
 	}
=20
 	if (p->policyvers >=3D MOD_POLICYDB_VERSION_FILENAME_TRANS &&
-	    filename_trans_rule_write(p, decl->filename_trans_rules, fp))
+	    filename_trans_rule_write(p, decl->avrules, fp))
 		return POLICYDB_ERROR;
=20
 	if (p->policyvers >=3D MOD_POLICYDB_VERSION_RANGETRANS &&
--=20
2.40.0

