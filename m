Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4686DEB64D8
	for <selinux@archiver.kernel.org>; Tue, 20 Jun 2023 09:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjFTJCz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjFTJCy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Jun 2023 05:02:54 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804631982
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 02:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687251757; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=M7YHtVDJKBu8I+65+grqA9pSoMeYyTHarLx/1b1gNYWgOgW+7Q0mqY4BRtXgtFU3xYxQYpC5ZD9SpA86lJxXhuknrex46D0wHSGDUqXzQDdjCfDxksvHav3Gz+ddxN4klZG/Y2/Z28vqimfDvA/YcKam2ebH1VSSxnmtYdsYeAg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1687251757; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=M+rOQtUva7ce3aRPNqzkCwCiI7RcxupWLajIV610Twc=; 
        b=ZAw7wG/pfFwbFqx/grVZmdD6XdiqN6QneXx4XoSpIWLosaVa9T3Wgk8J9Rxq6zdRgJmlN7CzdhHXEWG8Xo05YmOG1flCFC7EWd4zq6bjmTYGmn93UhnIQupPecZe3NkeTHDKjzPSFOXIN9wS5bplg1UIBRrStZCKTtyNv0BBp9M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687251757;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=M+rOQtUva7ce3aRPNqzkCwCiI7RcxupWLajIV610Twc=;
        b=GycyJgw9FXJCCxOsRxfDWcEIIcbT3JnjszNeIhD3Fy/FOMTwEspE6MTFHKokESIY
        tcDgqgTet2bzfdxa2USG99ymnz4R88voVp/5gHokbyBrZren4N9X2B5ZIcVGno/VVrk
        CRTmwzN2pv9TmsG8zODMeQdjfkSPlbs6to1VEA8I=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1687251755802595.8723386728121; Tue, 20 Jun 2023 11:02:35 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [213.175.37.12])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 44BF72081F76;
        Tue, 20 Jun 2023 09:02:35 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 8/8] libsepol/cil: add support for prefix/suffix filename transtions to CIL
Date:   Tue, 20 Jun 2023 11:01:23 +0200
Message-Id: <cb43ef8697225a444594f2d8d68ed572e5e34bd3.1687251081.git.juraj@jurajmarcin.com>
In-Reply-To: <cover.1687251081.git.juraj@jurajmarcin.com>
References: <cover.1687251081.git.juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch implements the support for prefix/suffix filename transitions
in the CIL structures as well as in the CIL policy parser.

Syntax of the new prefix/suffix filename transition rule:

    (typetransition source_type_id target_type_id class_id object_name ma=
tch_type default_type_id)

where match_type is either the keyword "prefix" or "suffix".

Examples:

    (typetransition ta tb CLASS01 "file01" prefix td)
    (typetransition td te CLASS01 "file02" suffix tf)

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 libsepol/cil/src/cil.c             |  6 ++++++
 libsepol/cil/src/cil_binary.c      |  8 ++++----
 libsepol/cil/src/cil_build_ast.c   | 26 +++++++++++++++++++++-----
 libsepol/cil/src/cil_copy_ast.c    |  1 +
 libsepol/cil/src/cil_internal.h    |  4 ++++
 libsepol/cil/src/cil_policy.c      | 17 ++++++++++++++++-
 libsepol/cil/src/cil_resolve_ast.c | 10 ++++++++++
 libsepol/cil/src/cil_write_ast.c   |  2 ++
 8 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 38edcf8e..fa693020 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -95,6 +95,8 @@ char *CIL_KEY_TUNABLEIF;
 char *CIL_KEY_ALLOW;
 char *CIL_KEY_DONTAUDIT;
 char *CIL_KEY_TYPETRANSITION;
+char *CIL_KEY_PREFIX;
+char *CIL_KEY_SUFFIX;
 char *CIL_KEY_TYPECHANGE;
 char *CIL_KEY_CALL;
 char *CIL_KEY_TUNABLE;
@@ -264,6 +266,8 @@ static void cil_init_keys(void)
 	CIL_KEY_ALLOW =3D cil_strpool_add("allow");
 	CIL_KEY_DONTAUDIT =3D cil_strpool_add("dontaudit");
 	CIL_KEY_TYPETRANSITION =3D cil_strpool_add("typetransition");
+	CIL_KEY_PREFIX =3D cil_strpool_add("prefix");
+	CIL_KEY_SUFFIX =3D cil_strpool_add("suffix");
 	CIL_KEY_TYPECHANGE =3D cil_strpool_add("typechange");
 	CIL_KEY_CALL =3D cil_strpool_add("call");
 	CIL_KEY_TUNABLE =3D cil_strpool_add("tunable");
@@ -2387,6 +2391,8 @@ void cil_nametypetransition_init(struct cil_nametyp=
etransition **nametypetrans)
 	(*nametypetrans)->obj =3D NULL;
 	(*nametypetrans)->name_str =3D NULL;
 	(*nametypetrans)->name =3D NULL;
+	(*nametypetrans)->name_match_str =3D NULL;
+	(*nametypetrans)->name_match =3D NAME_TRANS_MATCH_EXACT;
 	(*nametypetrans)->result_str =3D NULL;
 	(*nametypetrans)->result =3D NULL;
 }
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
index ffa44be7..ea0cef32 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1193,7 +1193,7 @@ static int __cil_typetransition_to_avtab_helper(pol=
icydb_t *pdb,
 						type_datum_t *sepol_src,
 						type_datum_t *sepol_tgt,
 						struct cil_list *class_list,
-						char *name,
+						char *name, uint8_t name_match,
 						type_datum_t *sepol_result)
 {
 	int rc;
@@ -1211,7 +1211,7 @@ static int __cil_typetransition_to_avtab_helper(pol=
icydb_t *pdb,
 		avt_key.target_type =3D sepol_tgt->s.value;
 		avt_key.target_class =3D sepol_obj->s.value;
 		rc =3D avtab_insert_filename_trans(&pdb->te_avtab, &avt_key,
-			sepol_result->s.value, name, NAME_TRANS_MATCH_EXACT,
+			sepol_result->s.value, name, name_match,
 			&otype);
 		if (rc !=3D SEPOL_OK) {
 			if (rc =3D=3D SEPOL_EEXIST) {
@@ -1280,7 +1280,7 @@ static int __cil_typetransition_to_avtab(policydb_t=
 *pdb, const struct cil_db *d
=20
 			rc =3D __cil_typetransition_to_avtab_helper(
 				pdb, sepol_src, sepol_src, class_list,
-				name, sepol_result
+				name, typetrans->name_match, sepol_result
 			);
 			if (rc !=3D SEPOL_OK) goto exit;
 		}
@@ -1298,7 +1298,7 @@ static int __cil_typetransition_to_avtab(policydb_t=
 *pdb, const struct cil_db *d
=20
 				rc =3D __cil_typetransition_to_avtab_helper(
 					pdb, sepol_src, sepol_tgt, class_list,
-					name, sepol_result
+					name, typetrans->name_match, sepol_result
 				);
 				if (rc !=3D SEPOL_OK) goto exit;
 			}
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
index 4177c9f6..67bbdcab 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -3334,10 +3334,11 @@ int cil_gen_typetransition(struct cil_db *db, str=
uct cil_tree_node *parse_curren
 		CIL_SYN_STRING,
 		CIL_SYN_STRING,
 		CIL_SYN_STRING | CIL_SYN_END,
-		CIL_SYN_END
+		CIL_SYN_STRING | CIL_SYN_END,
+		CIL_SYN_END,
 	};
 	size_t syntax_len =3D sizeof(syntax)/sizeof(*syntax);
-	char *s1, *s2, *s3, *s4, *s5;
+	char *s1, *s2, *s3, *s4, *s5, *s6;
=20
 	if (db =3D=3D NULL || parse_current =3D=3D NULL || ast_node =3D=3D NULL=
 ) {
 		goto exit;
@@ -3353,12 +3354,22 @@ int cil_gen_typetransition(struct cil_db *db, str=
uct cil_tree_node *parse_curren
 	s3 =3D parse_current->next->next->next->data;
 	s4 =3D parse_current->next->next->next->next->data;
 	s5 =3D NULL;
+	s6 =3D NULL;
=20
 	if (parse_current->next->next->next->next->next) {
 		if (s4 =3D=3D CIL_KEY_STAR) {
-			s4 =3D parse_current->next->next->next->next->next->data;
+			if (parse_current->next->next->next->next->next->next) {
+				s4 =3D parse_current->next->next->next->next->next->next->data;
+			} else {
+				s4 =3D parse_current->next->next->next->next->next->data;
+			}
 		} else {
-			s5 =3D parse_current->next->next->next->next->next->data;
+			if (parse_current->next->next->next->next->next->next) {
+				s5 =3D parse_current->next->next->next->next->next->data;
+				s6 =3D parse_current->next->next->next->next->next->next->data;
+			} else {
+				s5 =3D parse_current->next->next->next->next->next->data;
+			}
 		}
 	}
=20
@@ -3370,8 +3381,13 @@ int cil_gen_typetransition(struct cil_db *db, stru=
ct cil_tree_node *parse_curren
 		nametypetrans->src_str =3D s1;
 		nametypetrans->tgt_str =3D s2;
 		nametypetrans->obj_str =3D s3;
-		nametypetrans->result_str =3D s5;
 		nametypetrans->name_str =3D s4;
+		if (s6) {
+			nametypetrans->name_match_str =3D s5;
+			nametypetrans->result_str =3D s6;
+		} else {
+			nametypetrans->result_str =3D s5;
+		}
=20
 		ast_node->data =3D nametypetrans;
 		ast_node->flavor =3D CIL_NAMETYPETRANSITION;
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_=
ast.c
index 17f05021..a2d2fe40 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -726,6 +726,7 @@ int cil_copy_nametypetransition(__attribute__((unused=
)) struct cil_db *db, void
 	new->tgt_str =3D orig->tgt_str;
 	new->obj_str =3D orig->obj_str;
 	new->name_str =3D orig->name_str;
+	new->name_match_str =3D orig->name_match_str;
 	new->result_str =3D orig->result_str;
=20
=20
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_inter=
nal.h
index a7604762..a5ff808b 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -112,6 +112,8 @@ extern char *CIL_KEY_TUNABLEIF;
 extern char *CIL_KEY_ALLOW;
 extern char *CIL_KEY_DONTAUDIT;
 extern char *CIL_KEY_TYPETRANSITION;
+extern char *CIL_KEY_PREFIX;
+extern char *CIL_KEY_SUFFIX;
 extern char *CIL_KEY_TYPECHANGE;
 extern char *CIL_KEY_CALL;
 extern char *CIL_KEY_TUNABLE;
@@ -575,6 +577,8 @@ struct cil_nametypetransition {
 	struct cil_class *obj;
 	char *name_str;
 	struct cil_name *name;
+	char *name_match_str;
+	uint8_t name_match;
 	char *result_str;
 	void *result; /* type or alias */
=20
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
index feb97868..9ee40ba7 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1260,6 +1260,7 @@ static void cil_nametypetransition_to_policy(FILE *=
out, struct cil_nametypetrans
 	struct cil_name *name;
 	struct cil_list *class_list;
 	struct cil_list_item *i1;
+	const char *name_match_str =3D "";
=20
 	src =3D trans->src;
 	tgt =3D trans->tgt;
@@ -1268,7 +1269,21 @@ static void cil_nametypetransition_to_policy(FILE =
*out, struct cil_nametypetrans
=20
 	class_list =3D cil_expand_class(trans->obj);
 	cil_list_for_each(i1, class_list) {
-		fprintf(out, "type_transition %s %s : %s %s \"%s\";\n", src->fqn, tgt-=
>fqn, DATUM(i1->data)->fqn, res->fqn, name->datum.fqn);
+		switch (trans->name_match) {
+		case NAME_TRANS_MATCH_EXACT:
+			name_match_str =3D "";
+			break;
+		case NAME_TRANS_MATCH_PREFIX:
+			name_match_str =3D " PREFIX";
+			break;
+		case NAME_TRANS_MATCH_SUFFIX:
+			name_match_str =3D " SUFFIX";
+			break;
+		default:
+			name_match_str =3D "???";
+			break;
+		}
+		fprintf(out, "type_transition %s %s : %s %s \"%s\"%s;\n", src->fqn, tg=
t->fqn, DATUM(i1->data)->fqn, res->fqn, name->datum.fqn, name_match_str);
 	}
 	cil_list_destroy(&class_list, CIL_FALSE);
 }
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
index d2bfdc81..1ef0986c 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -668,6 +668,16 @@ int cil_resolve_nametypetransition(struct cil_tree_n=
ode *current, void *extra_ar
 		nametypetrans->name =3D (struct cil_name *)name_datum;
 	}
=20
+	if (nametypetrans->name_match_str =3D=3D NULL) {
+		nametypetrans->name_match =3D NAME_TRANS_MATCH_EXACT;
+	} else if (nametypetrans->name_match_str =3D=3D CIL_KEY_PREFIX) {
+		nametypetrans->name_match =3D NAME_TRANS_MATCH_PREFIX;
+	} else if (nametypetrans->name_match_str =3D=3D CIL_KEY_SUFFIX) {
+		nametypetrans->name_match =3D NAME_TRANS_MATCH_SUFFIX;
+	} else {
+		cil_tree_log(current, CIL_ERR, "Invalid name match type \"%s\"", namet=
ypetrans->name_match_str);
+	}
+
 	rc =3D cil_resolve_name(current, nametypetrans->result_str, CIL_SYM_TYP=
ES, extra_args, &result_datum);
 	if (rc !=3D SEPOL_OK) {
 		goto exit;
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
index b75784ef..d96f6c39 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1168,6 +1168,8 @@ void cil_write_ast_node(FILE *out, struct cil_tree_=
node *node)
 		fprintf(out, "%s ", datum_or_str(DATUM(rule->tgt), rule->tgt_str));
 		fprintf(out, "%s ", datum_or_str(DATUM(rule->obj), rule->obj_str));
 		fprintf(out, "\"%s\" ", datum_or_str(DATUM(rule->name), rule->name_str=
));
+		if (rule->name_match !=3D NAME_TRANS_MATCH_EXACT)
+			fprintf(out, "%s ", rule->name_match_str);
 		fprintf(out, "%s", datum_or_str(DATUM(rule->result), rule->result_str)=
);
 		fprintf(out, ")\n");
 		break;
--=20
2.40.0

