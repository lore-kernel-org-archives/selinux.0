Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062A2C7EE32
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjEaLuY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjEaLuU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:50:20 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB2512E
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685533812; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=BAUodeSLJnhMJ2ibiCnbo2NyU9QP/zUfd+yVJxLH7gF2sNlJPX+6UhYqRxQ2zDjUOjcMIXgPofaty0mBOBAiXXMa1BGmUoVSvxRALUrpCAhoANECyarSobNk0ZziRlRJTmNSFSL4xkPQt1U/U7jDGK2DDWjI5omd6zr2IaB6RXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685533812; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=zTjSuG6H/3UGlixBbeS4SsN3meu6icBei8evXcezSM4=; 
        b=Gob/4OJYSsRyOX4pVaUvsAVJRlm1xlhrfdQ/QLp5M9K9Bj8dpXfJj1cAeKlJI5iRxKWd07IvTBOsa2FXxqt+6cBxzwTRudteUtLPH8lb8Ot0YsIlbx+0SnrveRCNgiuISq3wOQT0wt/woVQUH1SG1FQsQQzS44C9HUSHqX1MAK4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685533812;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=zTjSuG6H/3UGlixBbeS4SsN3meu6icBei8evXcezSM4=;
        b=QzcZtZhWzLKDNDTphiJ7S6Zej7blD6Yqe+8BHt20EsrPPY2Y+awaDma4FhStGe4o
        lcWfmfJoze9na8teTyAuZg7wj5z2dh1p3m6KWkmJShID4zzS8bQO0X3dz6CN1Z/Y3eq
        MQYrjmt6CDGzUzYq9YKieczVPJsQvh9D4Sw9LdKY=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685533810833663.9243711343653; Wed, 31 May 2023 13:50:10 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 440D42081F76;
        Wed, 31 May 2023 11:50:10 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 7/8] checkpolicy, libsepol: add prefix/suffix support to module policy
Date:   Wed, 31 May 2023 13:49:13 +0200
Message-Id: <20230531114914.2237609-8-juraj@jurajmarcin.com>
In-Reply-To: <20230531114914.2237609-1-juraj@jurajmarcin.com>
References: <20230531114914.2237609-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch extends the structures for module and base policy (avrule_t)
to support prefix/suffix transitions. In addition to this, it implements
the necessary changes to functions for reading and writing the binary
policy as well as parsing the policy conf.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 checkpolicy/policy_define.c                | 13 ++++---
 checkpolicy/policy_define.h                |  2 +-
 checkpolicy/policy_parse.y                 | 15 +++++---
 checkpolicy/policy_scan.l                  |  6 ++++
 checkpolicy/test/dismod.c                  | 14 ++++++++
 checkpolicy/test/dispol.c                  |  2 +-
 libsepol/cil/src/cil_binary.c              |  4 ++-
 libsepol/include/sepol/policydb/avtab.h    |  1 +
 libsepol/include/sepol/policydb/policydb.h | 13 ++++---
 libsepol/src/avtab.c                       | 30 ++++++++++++----
 libsepol/src/expand.c                      |  6 +++-
 libsepol/src/kernel_to_common.h            |  2 +-
 libsepol/src/link.c                        |  1 +
 libsepol/src/module_to_cil.c               | 25 +++++++++++---
 libsepol/src/policydb.c                    | 23 ++++++++++++-
 libsepol/src/write.c                       | 40 ++++++++++++++++------
 16 files changed, 154 insertions(+), 43 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 455255ba..c3c6af72 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1601,7 +1601,8 @@ static int set_types(type_set_t * set, char *id, in=
t *add, char starallowed)
 	return -1;
 }
=20
-static int define_compute_type_helper(int which, avrule_t ** rule, int h=
as_filename)
+static int define_compute_type_helper(int which, avrule_t ** rule,
+				      int has_filename, uint8_t name_match)
 {
 	char *id;
 	type_datum_t *datum;
@@ -1676,6 +1677,7 @@ static int define_compute_type_helper(int which, av=
rule_t ** rule, int has_filen
 			goto bad;
 		}
 	}
+	avrule->name_match =3D name_match;
=20
 	ebitmap_for_each_positive_bit(&tclasses, node, i) {
 		perm =3D malloc(sizeof(class_perm_node_t));
@@ -1700,7 +1702,7 @@ static int define_compute_type_helper(int which, av=
rule_t ** rule, int has_filen
 	return -1;
 }
=20
-int define_compute_type(int which, int has_filename)
+int define_compute_type(int which, int has_filename, uint8_t name_match)
 {
 	char *id;
 	avrule_t *avrule;
@@ -1721,7 +1723,8 @@ int define_compute_type(int which, int has_filename=
)
 		return 0;
 	}
=20
-	if (define_compute_type_helper(which, &avrule, has_filename))
+	if (define_compute_type_helper(which, &avrule, has_filename,
+				       name_match))
 		return -1;
=20
 	append_avrule(avrule);
@@ -1745,7 +1748,8 @@ avrule_t *define_cond_compute_type(int which)
 		return (avrule_t *) 1;
 	}
=20
-	if (define_compute_type_helper(which, &avrule, 0))
+	if (define_compute_type_helper(which, &avrule, 0,
+				       NAME_TRANS_MATCH_EXACT))
 		return COND_ERR;
=20
 	return avrule;
@@ -2394,6 +2398,7 @@ static int avrule_cpy(avrule_t *dest, const avrule_=
t *src)
 			return -1;
 		}
 	}
+	dest->name_match =3D src->name_match;
 	dest->line =3D src->line;
 	dest->source_filename =3D strdup(source_file);
 	if (!dest->source_filename) {
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 5d0f70e4..c1314871 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -28,7 +28,7 @@ int define_default_role(int which);
 int define_default_type(int which);
 int define_default_range(int which);
 int define_common_perms(void);
-int define_compute_type(int which, int has_filename);
+int define_compute_type(int which, int has_filename, uint8_t name_match)=
;
 int define_conditional(cond_expr_t *expr, avrule_t *t_list, avrule_t *f_=
list );
 int define_constraint(constraint_expr_t *expr);
 int define_dominance(void);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index fccbc052..12dff7af 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -109,6 +109,7 @@ typedef int (* require_func_t)(int pass);
 %token IF
 %token ELSE
 %token TYPE_TRANSITION
+%token MATCH_EXACT MATCH_PREFIX MATCH_SUFFIX
 %token TYPE_MEMBER
 %token TYPE_CHANGE
 %token ROLE_TRANSITION
@@ -452,13 +453,19 @@ cond_dontaudit_def	: DONTAUDIT names names ':' name=
s names ';'
 		        ;
 			;
 transition_def		: TYPE_TRANSITION  names names ':' names identifier file=
name ';'
-			{if (define_compute_type(AVRULE_TRANSITION, 1)) return -1; }
+			{if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MATCH_EXACT=
)) return -1;}
+            | TYPE_TRANSITION names names ':' names identifier filename =
MATCH_EXACT ';'
+            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MA=
TCH_EXACT)) return -1;}
+            | TYPE_TRANSITION names names ':' names identifier filename =
MATCH_PREFIX ';'
+            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MA=
TCH_PREFIX)) return -1;}
+            | TYPE_TRANSITION names names ':' names identifier filename =
MATCH_SUFFIX ';'
+            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MA=
TCH_SUFFIX)) return -1;}
 			| TYPE_TRANSITION names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_TRANSITION, 0)) =
return -1;}
+                        {if (define_compute_type(AVRULE_TRANSITION, 0, N=
AME_TRANS_MATCH_EXACT)) return -1;}
                         | TYPE_MEMBER names names ':' names identifier '=
;'
-                        {if (define_compute_type(AVRULE_MEMBER, 0)) retu=
rn -1;}
+                        {if (define_compute_type(AVRULE_MEMBER, 0, NAME_=
TRANS_MATCH_EXACT)) return -1;}
                         | TYPE_CHANGE names names ':' names identifier '=
;'
-                        {if (define_compute_type(AVRULE_CHANGE, 0)) retu=
rn -1;}
+                        {if (define_compute_type(AVRULE_CHANGE, 0, NAME_=
TRANS_MATCH_EXACT)) return -1;}
     			;
 range_trans_def		: RANGE_TRANSITION names names mls_range_def ';'
 			{ if (define_range_trans(0)) return -1; }
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 9fefea7b..3f568701 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -125,6 +125,12 @@ EXPANDATTRIBUTE |
 expandattribute                 { return(EXPANDATTRIBUTE); }
 TYPE_TRANSITION |
 type_transition			{ return(TYPE_TRANSITION); }
+MATCH_EXACT |
+match_exact			{ return(MATCH_EXACT); }
+MATCH_PREFIX |
+match_prefix			{ return(MATCH_PREFIX); }
+MATCH_SUFFIX |
+match_suffix			{ return(MATCH_SUFFIX); }
 TYPE_MEMBER |
 type_member			{ return(TYPE_MEMBER); }
 TYPE_CHANGE |
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index f26f360c..53edecee 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -293,6 +293,20 @@ static int display_avrule(avrule_t * avrule, policyd=
b_t * policy,
 		display_id(policy, fp, SYM_TYPES, avrule->perms->data - 1, "");
 		if (avrule->object_name)
 			fprintf(fp, " \"%s\"", avrule->object_name);
+		switch (avrule->name_match) {
+		case NAME_TRANS_MATCH_EXACT:
+			/* do nothing */
+			break;
+		case NAME_TRANS_MATCH_PREFIX:
+			fprintf(fp, " MATCH_PREFIX");
+			break;
+		case NAME_TRANS_MATCH_SUFFIX:
+			fprintf(fp, " MATCH_SUFFIX");
+			break;
+		default:
+			fprintf(fp, "     ERROR: no valid name match type specified\n");
+			return -1;
+		}
 	} else if (avrule->specified & AVRULE_XPERMS) {
 		avtab_extended_perms_t xperms;
 		int i;
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 064cbd4e..87cd6a32 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -82,7 +82,7 @@ typedef struct {
 	avtab_key_t *key;
 	policydb_t *p;
 	FILE *fp;
-	name_trans_match_t match;
+	uint8_t match;
 } render_name_trans_args_t;
=20
 static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, =
void *a)
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
index 996bad70..ffa44be7 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1211,7 +1211,8 @@ static int __cil_typetransition_to_avtab_helper(pol=
icydb_t *pdb,
 		avt_key.target_type =3D sepol_tgt->s.value;
 		avt_key.target_class =3D sepol_obj->s.value;
 		rc =3D avtab_insert_filename_trans(&pdb->te_avtab, &avt_key,
-			sepol_result->s.value, name, &otype);
+			sepol_result->s.value, name, NAME_TRANS_MATCH_EXACT,
+			&otype);
 		if (rc !=3D SEPOL_OK) {
 			if (rc =3D=3D SEPOL_EEXIST) {
 				if (sepol_result->s.value!=3D otype) {
@@ -4651,6 +4652,7 @@ static avrule_t *__cil_init_sepol_avrule(uint32_t k=
ind, struct cil_tree_node *no
 	__cil_init_sepol_type_set(&avrule->ttypes);
 	avrule->perms =3D NULL;
 	avrule->object_name =3D NULL;
+	avrule->name_match =3D NAME_TRANS_MATCH_EXACT;
 	avrule->line =3D node->line;
=20
 	avrule->source_filename =3D NULL;
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/s=
epol/policydb/avtab.h
index 870fb08a..7d892879 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -156,6 +156,7 @@ extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t=
 node, int specified);
=20
 extern int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
 				       uint32_t otype, const char *name,
+				       uint8_t name_match,
 				       uint32_t *present_otype);
 extern int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a=
);
=20
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
index a2df4a62..48b7b8bb 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -252,12 +252,6 @@ typedef struct av_extended_perms {
 	uint32_t perms[EXTENDED_PERMS_LEN];
 } av_extended_perms_t;
=20
-typedef enum name_trans_match {
-	NAME_TRANS_MATCH_EXACT,
-	NAME_TRANS_MATCH_PREFIX,
-	NAME_TRANS_MATCH_SUFFIX,
-} name_trans_match_t;
-
 typedef struct avrule {
 /* these typedefs are almost exactly the same as those in avtab.h - they=
 are
  * here because of the need to include neverallow and dontaudit messages=
 */
@@ -285,6 +279,10 @@ typedef struct avrule {
 	type_set_t ttypes;
 	class_perm_node_t *perms;
 	char *object_name;	/* optional object name */
+#define NAME_TRANS_MATCH_EXACT 0
+#define NAME_TRANS_MATCH_PREFIX 1
+#define NAME_TRANS_MATCH_SUFFIX 2
+	uint8_t name_match;
 	av_extended_perms_t *xperms;
 	unsigned long line;	/* line number from policy.conf where
 				 * this rule originated  */
@@ -757,9 +755,10 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
 #define MOD_POLICYDB_VERSION_AVRULE_FTRANS	22
+#define MOD_POLICYDB_VERSION_PREFIX_SUFFIX	23 /* preffix/suffix support =
for filename transitions */
=20
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_AVRULE_FTRANS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_PREFIX_SUFFIX
=20
 #define POLICYDB_CONFIG_MLS    1
=20
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 45cbb3a1..5dc7cc59 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -771,7 +771,7 @@ int avtab_read(avtab_t * a, struct policy_file *fp, u=
int32_t vers)
=20
 int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
 				uint32_t otype, const char *name,
-				uint32_t *present_otype)
+				uint8_t name_match, uint32_t *present_otype)
 {
 	int rc =3D SEPOL_ENOMEM;
 	avtab_trans_t new_trans =3D {0};
@@ -780,6 +780,7 @@ int avtab_insert_filename_trans(avtab_t *a, avtab_key=
_t *key,
 	avtab_ptr_t node;
 	char *name_key =3D NULL;
 	uint32_t *otype_datum =3D NULL;
+	symtab_t *target_symtab;
=20
 	datum =3D avtab_search(a, key);
 	if (!datum) {
@@ -793,8 +794,22 @@ int avtab_insert_filename_trans(avtab_t *a, avtab_ke=
y_t *key,
 		datum =3D &node->datum;
 	}
=20
-	if (hashtab_is_empty(datum->trans->name_trans.table)) {
-		rc =3D symtab_init(&datum->trans->name_trans, 1 << 8);
+	switch (name_match) {
+	case NAME_TRANS_MATCH_EXACT:
+		target_symtab =3D &datum->trans->name_trans;
+		break;
+	case NAME_TRANS_MATCH_PREFIX:
+		target_symtab =3D &datum->trans->prefix_trans;
+		break;
+	case NAME_TRANS_MATCH_SUFFIX:
+		target_symtab =3D &datum->trans->suffix_trans;
+		break;
+	default:
+		return SEPOL_ERR;
+	}
+
+	if (hashtab_is_empty(target_symtab->table)) {
+		rc =3D symtab_init(target_symtab, 1 << 8);
 		if (rc < 0)
 			return rc;
 	}
@@ -808,8 +823,7 @@ int avtab_insert_filename_trans(avtab_t *a, avtab_key=
_t *key,
 		goto bad;
 	*otype_datum =3D otype;
=20
-	rc =3D hashtab_insert(datum->trans->name_trans.table, name_key,
-			    otype_datum);
+	rc =3D hashtab_insert(target_symtab->table, name_key, otype_datum);
 	if (rc < 0)
 		goto bad;
=20
@@ -854,7 +868,8 @@ static int filename_trans_read_one(avtab_t *a, void *=
fp)
 	key.target_class =3D le32_to_cpu(buf[2]);
 	otype =3D le32_to_cpu(buf[3]);
=20
-	rc =3D avtab_insert_filename_trans(a, &key, otype, name, NULL);
+	rc =3D avtab_insert_filename_trans(a, &key, otype, name,
+					 NAME_TRANS_MATCH_EXACT, NULL);
 	if (rc)
 		goto err;
=20
@@ -907,7 +922,8 @@ static int filename_trans_comp_read_one(avtab_t *a, v=
oid *fp)
 			key.source_type =3D bit + 1;
=20
 			rc =3D avtab_insert_filename_trans(a, &key, otype, name,
-				NULL);
+							 NAME_TRANS_MATCH_EXACT,
+							 NULL);
 			if (rc < 0)
 				goto err_ebitmap;
 		}
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index f3417547..43f8ab3f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1620,7 +1620,8 @@ static int expand_terule_helper(sepol_handle_t * ha=
ndle,
 				uint32_t specified, cond_av_list_t ** cond,
 				cond_av_list_t ** other, uint32_t stype,
 				uint32_t ttype, class_perm_node_t * perms,
-				char *object_name, avtab_t * avtab, int enabled)
+				char *object_name, uint8_t name_match,
+				avtab_t * avtab, int enabled)
 {
 	avtab_key_t avkey;
 	avtab_datum_t *avdatump;
@@ -1652,6 +1653,7 @@ static int expand_terule_helper(sepol_handle_t * ha=
ndle,
 			int rc =3D avtab_insert_filename_trans(avtab, &avkey,
 							     remapped_data,
 							     object_name,
+							     name_match,
 							     &oldtype);
 			if (rc =3D=3D SEPOL_EEXIST) {
 				ERR(handle, "conflicting filename transition %s %s:%s \"%s\": %s vs =
%s",
@@ -1881,6 +1883,7 @@ static int expand_rule_helper(sepol_handle_t * hand=
le,
 							      source_rule->specified, cond,
 							      other, i, i, source_rule->perms,
 							      source_rule->object_name,
+							      source_rule->name_match,
 							      dest_avtab, enabled);
 				if (retval !=3D EXPAND_RULE_SUCCESS)
 					return retval;
@@ -1898,6 +1901,7 @@ static int expand_rule_helper(sepol_handle_t * hand=
le,
 							      source_rule->specified, cond,
 							      other, i, j, source_rule->perms,
 							      source_rule->object_name,
+							      source_rule->name_match,
 							      dest_avtab, enabled);
 				if (retval !=3D EXPAND_RULE_SUCCESS)
 					return retval;
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_com=
mon.h
index 2a1cae85..c0a72107 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -90,7 +90,7 @@ typedef struct {
 	const char *src;
 	const char *tgt;
 	const char *class;
-	name_trans_match_t match;
+	uint8_t match;
 } name_trans_to_strs_args_t;
=20
 __attribute__ ((format(printf, 1, 2)))
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 88b23594..332d62b2 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1254,6 +1254,7 @@ static int copy_avrule_list(avrule_t * list, avrule=
_t ** dst,
 			if (!new_rule->object_name)
 				goto cleanup;
 		}
+		new_rule->name_match =3D cur->name_match;
=20
 		cur_perm =3D cur->perms;
 		tail_perm =3D NULL;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 653b4b33..4b15bca1 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -560,12 +560,13 @@ static int semantic_level_to_cil(struct policydb *p=
db, int sens_offset, struct m
 	return 0;
 }
=20
-static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type=
, const char *src, const char *tgt, const char *object_name, const struct=
 class_perm_node *classperms)
+static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type=
, const char *src, const char *tgt, const char *object_name, uint8_t name=
_match, const struct class_perm_node *classperms)
 {
 	int rc =3D -1;
 	const char *rule;
 	const struct class_perm_node *classperm;
 	char *perms;
+	const char *match_str =3D "";
=20
 	switch (type) {
 	case AVRULE_ALLOWED:
@@ -611,10 +612,24 @@ static int avrule_to_cil(int indent, struct policyd=
b *pdb, uint32_t type, const
 					pdb->p_class_val_to_name[classperm->tclass - 1],
 					perms + 1);
 		} else if (object_name) {
-			cil_println(indent, "(%s %s %s %s \"%s\" %s)",
+			switch (name_match) {
+			case NAME_TRANS_MATCH_EXACT:
+				match_str =3D "";
+				break;
+			case NAME_TRANS_MATCH_PREFIX:
+				match_str =3D " match_prefix";
+				break;
+			case NAME_TRANS_MATCH_SUFFIX:
+				match_str =3D " match_suffix";
+				break;
+			default:
+				log_err("Unknown name match type: %" PRIu8,
+						name_match);
+			}
+			cil_println(indent, "(%s %s %s %s \"%s\"%s %s)",
 					rule, src, tgt,
 					pdb->p_class_val_to_name[classperm->tclass - 1],
-					object_name,
+					object_name, match_str,
 					pdb->p_type_val_to_name[classperm->data - 1]);
 		} else {
 			cil_println(indent, "(%s %s %s %s %s)",
@@ -1218,7 +1233,7 @@ static int avrule_list_to_cil(int indent, struct po=
licydb *pdb, struct avrule *a
 				if (avrule->specified & AVRULE_XPERMS) {
 					rc =3D avrulex_to_cil(indent, pdb, avrule->specified, snames[s], tn=
ames[t], avrule->perms, avrule->xperms);
 				} else {
-					rc =3D avrule_to_cil(indent, pdb, avrule->specified, snames[s], tna=
mes[t], avrule->object_name, avrule->perms);
+					rc =3D avrule_to_cil(indent, pdb, avrule->specified, snames[s], tna=
mes[t], avrule->object_name, avrule->name_match, avrule->perms);
 				}
 				if (rc !=3D 0) {
 					goto exit;
@@ -1229,7 +1244,7 @@ static int avrule_list_to_cil(int indent, struct po=
licydb *pdb, struct avrule *a
 				if (avrule->specified & AVRULE_XPERMS) {
 					rc =3D avrulex_to_cil(indent, pdb, avrule->specified, snames[s], "s=
elf", avrule->perms, avrule->xperms);
 				} else {
-					rc =3D avrule_to_cil(indent, pdb, avrule->specified, snames[s], "se=
lf", avrule->object_name, avrule->perms);
+					rc =3D avrule_to_cil(indent, pdb, avrule->specified, snames[s], "se=
lf", avrule->object_name, avrule->name_match, avrule->perms);
 				}
 				if (rc !=3D 0) {
 					goto exit;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index bd1a151d..594b875e 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -355,6 +355,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 	 .ocon_num =3D OCON_IBENDPORT + 1,
 	 .target_platform =3D SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type =3D POLICY_BASE,
+	 .version =3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX,
+	 .sym_num =3D SYM_NUM,
+	 .ocon_num =3D OCON_IBENDPORT + 1,
+	 .target_platform =3D SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type =3D POLICY_MOD,
 	 .version =3D MOD_POLICYDB_VERSION_BASE,
@@ -488,6 +495,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 	 .ocon_num =3D 0,
 	 .target_platform =3D SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type =3D POLICY_MOD,
+	 .version =3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX,
+	 .sym_num =3D SYM_NUM,
+	 .ocon_num =3D 0,
+	 .target_platform =3D SEPOL_TARGET_SELINUX,
+	},
 };
=20
 #if 0
@@ -3171,6 +3185,7 @@ common_read, class_read, role_read, type_read, user=
_read,
 static avrule_t *avrule_read(policydb_t * p, struct policy_file *fp)
 {
 	unsigned int i;
+	uint8_t buf8;
 	uint32_t buf[2], len;
 	class_perm_node_t *cur, *tail =3D NULL;
 	avrule_t *avrule;
@@ -3234,10 +3249,15 @@ static avrule_t *avrule_read(policydb_t * p, stru=
ct policy_file *fp)
 			if (rc < 0)
 				goto bad;
 		}
+		if (p->policyvers >=3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX) {
+			rc =3D next_entry(&buf8, fp, sizeof(uint8_t));
+			if (rc < 0)
+				goto bad;
+			avrule->name_match =3D buf8;
+		}
 	}
=20
 	if (avrule->specified & AVRULE_XPERMS) {
-		uint8_t buf8;
 		size_t nel =3D ARRAY_SIZE(avrule->xperms->perms);
 		uint32_t buf32[nel];
=20
@@ -3546,6 +3566,7 @@ static int filename_trans_rule_read(policydb_t *p, =
avrule_t **r,
 		rc =3D str_read(&cur->object_name, fp, len);
 		if (rc)
 			return -1;
+		cur->name_match =3D NAME_TRANS_MATCH_EXACT;
=20
 		if (type_set_read(&cur->stypes, fp))
 			return -1;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 92a7b6cf..da83257d 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -2048,6 +2048,7 @@ static int avrule_write(policydb_t *p, avrule_t * a=
vrule,
 			struct policy_file *fp)
 {
 	size_t items, items2;
+	uint8_t buf8;
 	uint32_t buf[32], len;
 	class_perm_node_t *cur;
=20
@@ -2055,6 +2056,11 @@ static int avrule_write(policydb_t *p, avrule_t * =
avrule,
 	if (p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
 	    avrule->specified & AVRULE_TRANSITION && avrule->object_name)
 		return POLICYDB_SUCCESS;
+	/* skip prefix/suffix name transition if writing older version */
+	if (p->policyvers < MOD_POLICYDB_VERSION_PREFIX_SUFFIX &&
+	    avrule->specified & AVRULE_TRANSITION &&
+	    avrule->object_name && avrule->name_match !=3D NAME_TRANS_MATCH_EXA=
CT)
+		return POLICYDB_SUCCESS;
=20
 	if (p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS &&
 	    (avrule->specified & AVRULE_TYPE) &&
@@ -2113,12 +2119,17 @@ static int avrule_write(policydb_t *p, avrule_t *=
 avrule,
 			if (items !=3D len)
 				return POLICYDB_ERROR;
 		}
+		if (p->policyvers >=3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX) {
+			buf8 =3D avrule->name_match;
+			items =3D put_entry(&buf8, sizeof(uint8_t), 1, fp);
+			if (items !=3D 1)
+				return POLICYDB_ERROR;
+		}
 	}
=20
 	if (avrule->specified & AVRULE_XPERMS) {
 		size_t nel =3D ARRAY_SIZE(avrule->xperms->perms);
 		uint32_t buf32[nel];
-		uint8_t buf8;
 		unsigned int i;
=20
 		if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {
@@ -2163,12 +2174,17 @@ static int avrule_write_list(policydb_t *p, avrul=
e_t * avrules,
=20
 	avrule =3D avrules;
 	len =3D 0;
-	while (avrule) {
-		if (p->policyvers >=3D MOD_POLICYDB_VERSION_AVRULE_FTRANS ||
-		    !(avrule->specified & AVRULE_TRANSITION &&
-		      avrule->object_name))
-			len++;
-		avrule =3D avrule->next;
+	for (avrule =3D avrules; avrule; avrule =3D avrule->next) {
+		if (p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
+		    (avrule->specified & AVTAB_TRANSITION) &&
+		    avrule->object_name)
+			continue;
+		if (p->policyvers < MOD_POLICYDB_VERSION_PREFIX_SUFFIX &&
+		    (avrule->specified & AVTAB_TRANSITION) &&
+		    avrule->object_name &&
+		    avrule->name_match !=3D NAME_TRANS_MATCH_EXACT)
+			continue;
+		len++;
 	}
=20
 	buf[0] =3D cpu_to_le32(len);
@@ -2276,7 +2292,8 @@ static int filename_trans_rule_write(policydb_t *p,=
 avrule_t *rules,
 	class_perm_node_t *perm;
=20
 	for (rule =3D rules; rule; rule =3D rule->next) {
-		if (rule->specified & AVRULE_TRANSITION && rule->object_name) {
+		if (rule->specified & AVRULE_TRANSITION && rule->object_name &&
+		    rule->name_match =3D=3D NAME_TRANS_MATCH_EXACT) {
 			for (perm =3D rule->perms; perm; perm =3D perm->next) {
 				nel++;
 			}
@@ -2289,7 +2306,9 @@ static int filename_trans_rule_write(policydb_t *p,=
 avrule_t *rules,
 		return POLICYDB_ERROR;
=20
 	for (rule =3D rules; rule; rule =3D rule->next) {
-		if (!(rule->specified & AVRULE_TRANSITION && rule->object_name))
+		if (!(rule->specified & AVRULE_TRANSITION &&
+		      rule->object_name &&
+		      rule->name_match =3D=3D NAME_TRANS_MATCH_EXACT))
 			continue;
 		len =3D strlen(rule->object_name);
 		for (perm =3D rule->perms; perm; perm =3D perm->next) {
@@ -2728,7 +2747,8 @@ int policydb_write(policydb_t * p, struct policy_fi=
le *fp)
 	if (p->policy_type =3D=3D POLICY_KERN) {
 		if (avtab_write(p, &p->te_avtab, fp))
 			return POLICYDB_ERROR;
-		if (avtab_has_prefix_suffix_filename_transitions(&p->te_avtab)) {
+		if (p->policyvers < POLICYDB_VERSION_PREFIX_SUFFIX &&
+		    avtab_has_prefix_suffix_filename_transitions(&p->te_avtab)) {
 			WARN(fp->handle,
 			     "Discarding filename prefix/suffix type transition rules");
 		}
--=20
2.40.0

