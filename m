Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA731DF971
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610032; cv=none; b=hrNmRB7WUyAIROJrlvFHf7PlsHK+CFuW3DHGsMWEh8m/oU/1ZgEwYEXF+w3BwFQL+/4ZzIdSYtWap/zrC6iPmi+z4StqIssRXtx8vLxUHE98SlT9vFmsSKFFCbMwTQxSB0F3SlSaJd+UCsLIpHU/AA04mLqHNe5U/GoXlXX8RKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610032; c=relaxed/simple;
	bh=GcxwYrxYqR4/PT9aEyEfrUcEAcrN7ELhHRxtju64CmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQhCYCU/6tzbCoWQ28aKG9E6dZToTBeamS896P3f5B7iaL3yYbOkqHYWncgDttvkLaKrmJ8iBM0sZJKqnGbI8zdsLhgRxhZN5SbYnQnKpXhJ/CjpGBjig9GM9Edb1TxaiH5dw8aiQZ4c9i6K294fJkbjqRsXivQIinfeA0Gtkp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7f1Mk+2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7f1Mk+2"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c546334bdeso247633485a.2
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745610028; x=1746214828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4C9pDUS+AxKelOQYDdlTPh/3cZD9T0FkCBjGJ/hQn8E=;
        b=O7f1Mk+2vBKSBXcv8SyXBg1VZ2xrq2CXjJ5sMzlyCkNM38yWmaag4nPz4bWXFr8fjY
         0CDjKwVMrlhlidr8uPufvFwVJFM/eIZFwTkX2WWfyvseubzvAOfgB3R/gwKjA5tGYASw
         eSi6KE7SkMI5+izMomSEH/a4zewfkBirgivk68IPH6laxfP2FupTlx/hcJwkS3EgZVJR
         3zjZX0C33Qw5IuBNjei01YjU8jaQr7K7AXIyoaMG8WWHcF3d2lVx6pSyYsU3O/Ty4qsm
         qXzR7Vlwu8dG2W8vZNOphy2oX2jkGHJ6XP0XNrRAZJCBXC+QLUeVLe0uq3V9YwUmuVqa
         Mxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745610028; x=1746214828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4C9pDUS+AxKelOQYDdlTPh/3cZD9T0FkCBjGJ/hQn8E=;
        b=IdUXozPAlzfGBtEOT5I1/fiemOg4G/GCpB25jMgn9nDmMg8DTIzGwEJU2eL/oaQ4q9
         SQfhoO+iwxnthxthWy9VPpxw9GpufLP/gaIr41gI62ARlj1PYEz63+BZsfuuHcO0h1cf
         cXOREY5037/COuq+6qL495EaN2CvA2HhQJ3Nc4VWX6xMZp0HlGDgUDXlqu1ZAo75cTdj
         dED+yFA9cXwwmgSmn5OhVxTQsiP1F9CO129m6K3M4YYV5PcG7jPwUJ5/wRdKaVlgqbns
         N3+jMD7FMbaMX1ee+FL93B18cSpvp9oK3OvfAoncfOEnx+PIwOMFCZLnsbY7SGSksDgj
         LPrQ==
X-Gm-Message-State: AOJu0YwzYLDB8Z/GI2WwGESwXfQXOXjjD3BVWNK4JBT+GBjk7rdUiBDy
	dfYuRmRibqbW7ZztFhuUtGuk1YFI7gYlr4wN4ypAS6cbyEtVgsEzMSqLB6Kt
X-Gm-Gg: ASbGnct4FUCjsLcIDoNdCtPT1RbF1vweJNNkywcuyUyK1q0grMWTD8NqT4Sz8q5Odz+
	nNpDMeG/IqPsJVDK+BC215IfRqI2Pk91oHGXT4cB1rmG5JvJF97NkLqFHjX3HODIc++ZLejy5A3
	ZBWP5OzSkVpZWgicStXdUAPUNEMWpfCLXY2YqAsKYStsXeb1y81QWYPWC0Yn6nEcfDmqgzJLnyu
	ziigw2U1Fs1u3GGSMAVHiXJU6gZ89Y7rR0PEAVpSnQATXWO37yWUcGZM9N70Bs0R2oOWcEie8HD
	urF5dTH7vs1jLBOX4ORPMNoarzC8kQnUP5oky2LZMZDLGxPZbkmUfLNlFmMChnK5EG463/hUYZ2
	YGty6YEu+5+LpuNeDTo31oQYmrhbQvEvqTe5SoegHU9eXPPitalUyUs9TTiB9s66kldYB
X-Google-Smtp-Source: AGHT+IFEFY7MHnkCKSrgFzCOpOCDiTQAbkt1cHSYC/68JlQSx+gcHnYmLSi1XTwiFZ/jqa3Gws8VbA==
X-Received: by 2002:a05:620a:c4e:b0:7c5:65ab:4ff2 with SMTP id af79cd13be357-7c9668c82b4mr130589985a.46.1745610028086;
        Fri, 25 Apr 2025 12:40:28 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ea9208sm255785285a.113.2025.04.25.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:40:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] libsepol,checkpolicy: introduce neveraudit types
Date: Fri, 25 Apr 2025 15:40:05 -0400
Message-ID: <20250425194005.19148-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce neveraudit types i.e. types that should never trigger
audit messages. This allows the AVC to skip all audit-related
processing for such types. Note that neveraudit differs from
dontaudit not only wrt being applied for all checks with a given
source type but also in that it disables all auditing, not just
permission denials.

When a type is both a permissive type and a neveraudit type,
the security server can short-circuit the security_compute_av()
logic, rendering the type equivalent to an unconfined type.

Test and doc updates still TBD.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/policy_define.c                | 43 ++++++++++++++++++++
 checkpolicy/policy_define.h                |  1 +
 checkpolicy/policy_parse.y                 |  4 ++
 checkpolicy/policy_scan.l                  |  2 +
 libsepol/cil/src/cil.c                     | 15 +++++++
 libsepol/cil/src/cil_binary.c              | 24 +++++++++++
 libsepol/cil/src/cil_binary.h              | 12 ++++++
 libsepol/cil/src/cil_build_ast.c           | 46 +++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.h           |  2 +
 libsepol/cil/src/cil_copy_ast.c            | 17 ++++++++
 libsepol/cil/src/cil_copy_ast.h            |  1 +
 libsepol/cil/src/cil_flavor.h              |  1 +
 libsepol/cil/src/cil_internal.h            |  7 ++++
 libsepol/cil/src/cil_policy.c              | 14 +++++++
 libsepol/cil/src/cil_resolve_ast.c         | 31 ++++++++++++++
 libsepol/cil/src/cil_resolve_ast.h         |  1 +
 libsepol/cil/src/cil_write_ast.c           |  7 ++++
 libsepol/include/sepol/policydb/policydb.h | 11 ++++-
 libsepol/src/expand.c                      | 12 ++++++
 libsepol/src/kernel_to_cil.c               | 47 ++++++++++++++++++++++
 libsepol/src/kernel_to_conf.c              | 47 ++++++++++++++++++++++
 libsepol/src/module_to_cil.c               |  4 ++
 libsepol/src/policydb.c                    | 33 ++++++++++++++-
 libsepol/src/policydb_validate.c           | 21 ++++++++++
 libsepol/src/write.c                       | 44 +++++++++++++++++---
 25 files changed, 438 insertions(+), 9 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 78adbec0..4e0ddcc6 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -257,6 +257,49 @@ out:
 	return rc;
 }
 
+int define_neveraudit(void)
+{
+	char *type = NULL;
+	struct type_datum *t;
+	int rc = 0;
+
+	type = queue_remove(id_queue);
+
+	if (!type) {
+		yyerror2("forgot to include type in neveraudit definition?");
+		rc = -1;
+		goto out;
+	}
+
+	if (pass == 1)
+		goto out;
+
+	if (!is_id_in_scope(SYM_TYPES, type)) {
+		yyerror2("type %s is not within scope", type);
+		rc = -1;
+		goto out;
+	}
+
+	t = hashtab_search(policydbp->p_types.table, type);
+	if (!t) {
+		yyerror2("type is not defined: %s", type);
+		rc = -1;
+		goto out;
+	}
+
+	if (t->flavor == TYPE_ATTRIB) {
+		yyerror2("attributes may not be neveraudit: %s", type);
+		rc = -1;
+		goto out;
+	}
+
+	t->flags |= TYPE_FLAGS_NEVERAUDIT;
+
+out:
+	free(type);
+	return rc;
+}
+
 int define_polcap(void)
 {
 	char *id = 0;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 216da3ad..59a19169 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -45,6 +45,7 @@ int define_ipv6_cidr_node_context(void);
 int define_level(void);
 int define_netif_context(void);
 int define_permissive(void);
+int define_neveraudit(void);
 int define_polcap(void);
 int define_ibpkey_context(unsigned int low, unsigned int high);
 int define_ibendport_context(unsigned int port);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 7e117222..a88a6a7f 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -152,6 +152,7 @@ typedef int (* require_func_t)(int pass);
 %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
 %token POLICYCAP
 %token PERMISSIVE
+%token NEVERAUDIT
 %token FILESYSTEM
 %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
 %token LOW_HIGH LOW HIGH GLBLUB
@@ -330,6 +331,7 @@ te_decl			: attribute_def
                         | range_trans_def
                         | te_avtab_def
 			| permissive_def
+			| neveraudit_def
 			;
 attribute_def           : ATTRIBUTE identifier ';'
                         { if (define_attrib()) YYABORT;}
@@ -934,6 +936,8 @@ policycap_def		: POLICYCAP identifier ';'
 			;
 permissive_def		: PERMISSIVE identifier ';'
 			{if (define_permissive()) YYABORT;}
+neveraudit_def		: NEVERAUDIT identifier ';'
+			{if (define_neveraudit()) YYABORT;}
 
 /*********** module grammar below ***********/
 
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 5fb9ff37..1658830c 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -270,6 +270,8 @@ policycap |
 POLICYCAP			{ return(POLICYCAP); }
 permissive |
 PERMISSIVE			{ return(PERMISSIVE); }
+neveraudit |
+NEVERAUDIT			{ return(NEVERAUDIT); }
 default_user |
 DEFAULT_USER			{ return(DEFAULT_USER); }
 default_role |
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 5521c7ea..9662cf45 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -171,6 +171,7 @@ char *CIL_KEY_TYPEALIAS;
 char *CIL_KEY_TYPEALIASACTUAL;
 char *CIL_KEY_TYPEBOUNDS;
 char *CIL_KEY_TYPEPERMISSIVE;
+char *CIL_KEY_TYPENEVERAUDIT;
 char *CIL_KEY_RANGETRANSITION;
 char *CIL_KEY_USERROLE;
 char *CIL_KEY_ROLETYPE;
@@ -320,6 +321,7 @@ static void cil_init_keys(void)
 	CIL_KEY_TYPEALIASACTUAL = cil_strpool_add("typealiasactual");
 	CIL_KEY_TYPEBOUNDS = cil_strpool_add("typebounds");
 	CIL_KEY_TYPEPERMISSIVE = cil_strpool_add("typepermissive");
+	CIL_KEY_TYPENEVERAUDIT = cil_strpool_add("typeneveraudit");
 	CIL_KEY_RANGETRANSITION = cil_strpool_add("rangetransition");
 	CIL_KEY_USERROLE = cil_strpool_add("userrole");
 	CIL_KEY_ROLETYPE = cil_strpool_add("roletype");
@@ -939,6 +941,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_TYPEPERMISSIVE:
 		cil_destroy_typepermissive(*data);
 		break;
+	case CIL_TYPENEVERAUDIT:
+		cil_destroy_typeneveraudit(*data);
+		break;
 	case CIL_SENS:
 		cil_destroy_sensitivity(*data);
 		break;
@@ -1310,6 +1315,8 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		return CIL_KEY_TYPEBOUNDS;
 	case CIL_TYPEPERMISSIVE:
 		return CIL_KEY_TYPEPERMISSIVE;
+	case CIL_TYPENEVERAUDIT:
+		return CIL_KEY_TYPENEVERAUDIT;
 	case CIL_SENS:
 		return CIL_KEY_SENSITIVITY;
 	case CIL_SENSALIAS:
@@ -2451,6 +2458,14 @@ void cil_typepermissive_init(struct cil_typepermissive **typeperm)
 	(*typeperm)->type = NULL;
 }
 
+void cil_typeneveraudit_init(struct cil_typeneveraudit **typeperm)
+{
+	*typeperm = cil_malloc(sizeof(**typeperm));
+
+	(*typeperm)->type_str = NULL;
+	(*typeperm)->type = NULL;
+}
+
 void cil_nametypetransition_init(struct cil_nametypetransition **nametypetrans)
 {
 	*nametypetrans = cil_malloc(sizeof(**nametypetrans));
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index e84188a0..a8770aa5 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -564,6 +564,27 @@ exit:
 
 }
 
+int cil_typeneveraudit_to_policydb(policydb_t *pdb, struct cil_typeneveraudit *cil_typeperm)
+{
+	int rc = SEPOL_ERR;
+	type_datum_t *sepol_type = NULL;
+
+	rc = __cil_get_sepol_type_datum(pdb, DATUM(cil_typeperm->type), &sepol_type);
+	if (rc != SEPOL_OK) goto exit;
+
+	if (ebitmap_set_bit(&pdb->neveraudit_map, sepol_type->s.value, 1)) {
+		goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	type_datum_destroy(sepol_type);
+	free(sepol_type);
+	return rc;
+
+}
+
 int cil_typeattribute_to_policydb(policydb_t *pdb, struct cil_typeattribute *cil_attr, void *type_value_to_cil[])
 {
 	int rc = SEPOL_ERR;
@@ -4101,6 +4122,9 @@ static int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 		case CIL_TYPEPERMISSIVE:
 			rc = cil_typepermissive_to_policydb(pdb, node->data);
 			break;
+		case CIL_TYPENEVERAUDIT:
+			rc = cil_typeneveraudit_to_policydb(pdb, node->data);
+			break;
 		case CIL_TYPEATTRIBUTE:
 			rc = cil_typeattribute_to_bitmap(pdb, db, node->data);
 			break;
diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
index 0b6e3b79..e6826221 100644
--- a/libsepol/cil/src/cil_binary.h
+++ b/libsepol/cil/src/cil_binary.h
@@ -136,6 +136,18 @@ int cil_typealias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alias);
  */
 int cil_typepermissive_to_policydb(policydb_t *pdb, struct cil_typepermissive *cil_typeperm);
 
+/**
+ * Insert cil typeneveraudit structure into sepol policydb.
+ * The function looks up the previously inserted type and flips the bit
+ * in the neveraudit types bitmap that corresponds to that type's value.
+ *
+ * @param[in] pdb The policy database to insert the typeneveraudit into.
+ * @param[in] datum The cil_typeneveraudit datum.
+ *
+ * @return SEPOL_OK upon success or an error otherwise.
+ */
+int cil_typeneveraudit_to_policydb(policydb_t *pdb, struct cil_typeneveraudit *cil_typeperm);
+
 /**
  * Insert cil attribute structure into sepol policydb.
  *
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 072d2622..af6b96c3 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -3374,6 +3374,50 @@ void cil_destroy_typepermissive(struct cil_typepermissive *typeperm)
 	free(typeperm);
 }
 
+int cil_gen_typeneveraudit(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_END
+	};
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
+	struct cil_typeneveraudit *typeperm = NULL;
+	int rc = SEPOL_ERR;
+
+	if (db == NULL || parse_current == NULL || ast_node == NULL) {
+		goto exit;
+	}
+
+	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_typeneveraudit_init(&typeperm);
+
+	typeperm->type_str = parse_current->next->data;
+
+	ast_node->data = typeperm;
+	ast_node->flavor = CIL_TYPENEVERAUDIT;
+
+	return SEPOL_OK;
+
+exit:
+	cil_tree_log(parse_current, CIL_ERR, "Bad typeneveraudit declaration");
+	cil_destroy_typeneveraudit(typeperm);
+	return rc;
+}
+
+void cil_destroy_typeneveraudit(struct cil_typeneveraudit *typeperm)
+{
+	if (typeperm == NULL) {
+		return;
+	}
+
+	free(typeperm);
+}
+
 int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	int rc = SEPOL_ERR;
@@ -6255,6 +6299,8 @@ static struct cil_tree_node * parse_statement(struct cil_db *db, struct cil_tree
 		rc = cil_gen_bounds(db, parse_current, new_ast_node, CIL_TYPE);
 	} else if (parse_current->data == CIL_KEY_TYPEPERMISSIVE) {
 		rc = cil_gen_typepermissive(db, parse_current, new_ast_node);
+	} else if (parse_current->data == CIL_KEY_TYPENEVERAUDIT) {
+		rc = cil_gen_typeneveraudit(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_RANGETRANSITION) {
 		rc = cil_gen_rangetransition(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_ROLE) {
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 7fa4299c..96be0116 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -146,7 +146,9 @@ int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_node *parse_c
 void cil_destroy_expandtypeattribute(struct cil_expandtypeattribute *expandattr);
 int cil_gen_typebounds(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
+int cil_gen_typeneveraudit(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_typepermissive(struct cil_typepermissive *typeperm);
+void cil_destroy_typeneveraudit(struct cil_typeneveraudit *typeperm);
 int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_typetransition(struct cil_nametypetransition *nametypetrans);
 int cil_gen_rangetransition(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 1507edb4..2911523e 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -608,6 +608,20 @@ int cil_copy_typepermissive(__attribute__((unused)) struct cil_db *db, void *dat
 	return SEPOL_OK;
 }
 
+int cil_copy_typeneveraudit(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_typeneveraudit *orig = data;
+	struct cil_typeneveraudit *new = NULL;
+
+	cil_typeneveraudit_init(&new);
+
+	new->type_str = orig->type_str;
+
+	*copy = new;
+
+	return SEPOL_OK;
+}
+
 int cil_copy_typeattribute(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_typeattribute *new;
@@ -1807,6 +1821,9 @@ static int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished
 	case CIL_TYPEPERMISSIVE:
 		copy_func = cil_copy_typepermissive;
 		break;
+	case CIL_TYPENEVERAUDIT:
+		copy_func = cil_copy_typeneveraudit;
+		break;
 	case CIL_TYPEATTRIBUTE:
 		copy_func = &cil_copy_typeattribute;
 		break;
diff --git a/libsepol/cil/src/cil_copy_ast.h b/libsepol/cil/src/cil_copy_ast.h
index 9e6be5ac..be33d99e 100644
--- a/libsepol/cil/src/cil_copy_ast.h
+++ b/libsepol/cil/src/cil_copy_ast.h
@@ -72,6 +72,7 @@ int cil_copy_roleallow(struct cil_db *db, void *data, void **copy, symtab_t *sym
 int cil_copy_type(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typebounds(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typepermissive(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
+int cil_copy_typeneveraudit(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typeattribute(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typeattributeset(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typealias(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index 155d7c80..c5a472e7 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -77,6 +77,7 @@ enum cil_flavor {
 	CIL_TYPEALIASACTUAL,
 	CIL_TYPEBOUNDS,
 	CIL_TYPEPERMISSIVE,
+	CIL_TYPENEVERAUDIT,
 	CIL_SENSALIASACTUAL,
 	CIL_SENSITIVITYORDER,
 	CIL_SENSCAT,
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 959b31e3..ae3ab824 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -188,6 +188,7 @@ extern char *CIL_KEY_TYPEALIAS;
 extern char *CIL_KEY_TYPEALIASACTUAL;
 extern char *CIL_KEY_TYPEBOUNDS;
 extern char *CIL_KEY_TYPEPERMISSIVE;
+extern char *CIL_KEY_TYPENEVERAUDIT;
 extern char *CIL_KEY_RANGETRANSITION;
 extern char *CIL_KEY_USERROLE;
 extern char *CIL_KEY_ROLETYPE;
@@ -580,6 +581,11 @@ struct cil_typepermissive {
 	void *type; /* type or alias */
 };
 
+struct cil_typeneveraudit {
+	char *type_str;
+	void *type; /* type or alias */
+};
+
 struct cil_nametypetransition {
 	char *src_str;
 	void *src; /* type, alias, or attribute */
@@ -1045,6 +1051,7 @@ void cil_expandtypeattribute_init(struct cil_expandtypeattribute **expandattr);
 void cil_alias_init(struct cil_alias **alias);
 void cil_aliasactual_init(struct cil_aliasactual **aliasactual);
 void cil_typepermissive_init(struct cil_typepermissive **typeperm);
+void cil_typeneveraudit_init(struct cil_typeneveraudit **typeperm);
 void cil_nametypetransition_init(struct cil_nametypetransition **nametypetrans);
 void cil_rangetransition_init(struct cil_rangetransition **rangetrans);
 void cil_bool_init(struct cil_bool **cilbool);
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index c497c8ab..ca73bd28 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1297,6 +1297,11 @@ static void cil_typepermissive_to_policy(FILE *out, struct cil_typepermissive *r
 	fprintf(out, "permissive %s;\n", DATUM(rule->type)->fqn);
 }
 
+static void cil_typeneveraudit_to_policy(FILE *out, struct cil_typeneveraudit *rule)
+{
+	fprintf(out, "neveraudit %s;\n", DATUM(rule->type)->fqn);
+}
+
 struct block_te_rules_extra {
 	FILE *out;
 	enum cil_flavor flavor;
@@ -1359,6 +1364,11 @@ static int __cil_block_te_rules_to_policy_helper(struct cil_tree_node *node, uin
 			cil_typepermissive_to_policy(args->out, node->data);
 		}
 		break;
+	case CIL_TYPENEVERAUDIT:
+		if (args->flavor == node->flavor) {
+			cil_typeneveraudit_to_policy(args->out, node->data);
+		}
+		break;
 	default:
 		break;
 	}
@@ -1376,6 +1386,10 @@ static void cil_block_te_rules_to_policy(FILE *out, struct cil_tree_node *start,
 	args.rule_kind = 0;
 	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
 
+	args.flavor = CIL_TYPENEVERAUDIT;
+	args.rule_kind = 0;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+
 	args.flavor = CIL_AVRULE;
 	args.rule_kind = CIL_AVRULE_ALLOWED;
 	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index a8fa89df..30a571d8 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -624,6 +624,34 @@ exit:
 	return rc;
 }
 
+int cil_resolve_typeneveraudit(struct cil_tree_node *current, struct cil_db *db)
+{
+	struct cil_typeneveraudit *typeperm = current->data;
+	struct cil_symtab_datum *type_datum = NULL;
+	struct cil_tree_node *type_node = NULL;
+	int rc = SEPOL_ERR;
+
+	rc = cil_resolve_name(current, typeperm->type_str, CIL_SYM_TYPES, db, &type_datum);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	type_node = NODE(type_datum);
+
+	if (type_node->flavor != CIL_TYPE && type_node->flavor != CIL_TYPEALIAS) {
+		cil_log(CIL_ERR, "Typeneveraudit must be a type or type alias\n");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	typeperm->type = type_datum;
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 int cil_resolve_nametypetransition(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_nametypetransition *nametypetrans = current->data;
@@ -3652,6 +3680,9 @@ static int __cil_resolve_ast_node(struct cil_tree_node *node, struct cil_args_re
 		case CIL_TYPEPERMISSIVE:
 			rc = cil_resolve_typepermissive(node, db);
 			break;
+		case CIL_TYPENEVERAUDIT:
+			rc = cil_resolve_typeneveraudit(node, db);
+			break;
 		case CIL_NAMETYPETRANSITION:
 			rc = cil_resolve_nametypetransition(node, db);
 			break;
diff --git a/libsepol/cil/src/cil_resolve_ast.h b/libsepol/cil/src/cil_resolve_ast.h
index 2f6b7e86..074fc4a4 100644
--- a/libsepol/cil/src/cil_resolve_ast.h
+++ b/libsepol/cil/src/cil_resolve_ast.h
@@ -46,6 +46,7 @@ int cil_resolve_typeattributeset(struct cil_tree_node *current, struct cil_db *d
 int cil_resolve_typealias(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_typebounds(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_typepermissive(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_typeneveraudit(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_nametypetransition(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_rangetransition(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_classcommon(struct cil_tree_node *current, struct cil_db *db);
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 15d8bbaf..a3c3aef8 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1125,6 +1125,13 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		fprintf(out, ")\n");
 		break;
 	}
+	case CIL_TYPENEVERAUDIT: {
+		struct cil_typeneveraudit *tp = node->data;
+		fprintf(out, "(typeneveraudit ");
+		fprintf(out, "%s", datum_or_str(DATUM(tp->type), tp->type_str));
+		fprintf(out, ")\n");
+		break;
+	}
 	case CIL_TYPEBOUNDS: {
 		struct cil_bounds *bounds = node->data;
 		fprintf(out, "(typebounds ");
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index f833354b..f1c4edac 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -188,6 +188,7 @@ typedef struct type_datum {
 #define TYPE_FLAGS_EXPAND_ATTR_FALSE	(1 << 2)
 #define TYPE_FLAGS_EXPAND_ATTR (TYPE_FLAGS_EXPAND_ATTR_TRUE | \
 				TYPE_FLAGS_EXPAND_ATTR_FALSE)
+#define TYPE_FLAGS_NEVERAUDIT		(1 << 3)
 	uint32_t flags;
 	uint32_t bounds;	/* bounds type, if exist */
 } type_datum_t;
@@ -200,6 +201,7 @@ typedef struct type_datum {
 #define TYPEDATUM_PROPERTY_ATTRIBUTE	0x0002
 #define TYPEDATUM_PROPERTY_ALIAS	0x0004	/* userspace only */
 #define TYPEDATUM_PROPERTY_PERMISSIVE	0x0008	/* userspace only */
+#define TYPEDATUM_PROPERTY_NEVERAUDIT	0x0010	/* userspace only */
 
 /* User attributes */
 typedef struct user_datum {
@@ -607,6 +609,9 @@ typedef struct policydb {
 	   bitmaps.  Someday the 0 bit may be used for global permissive */
 	ebitmap_t permissive_map;
 
+	/* ditto */
+	ebitmap_t neveraudit_map;
+
 	unsigned policyvers;
 
 	unsigned handle_unknown;
@@ -760,10 +765,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitions */
 #define POLICYDB_VERSION_COND_XPERMS	34 /* extended permissions in conditional policies */
+#define POLICYDB_VERSION_NEVERAUDIT	35 /* neveraudit domains */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_COND_XPERMS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_NEVERAUDIT
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
@@ -787,9 +793,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
 #define MOD_POLICYDB_VERSION_COND_XPERMS	22
+#define MOD_POLICYDB_VERSION_NEVERAUDIT		23
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_COND_XPERMS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_NEVERAUDIT
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 7032a83f..8695540c 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -170,6 +170,12 @@ static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			return -1;
 		}
 
+	if (new_type->flags & TYPE_FLAGS_NEVERAUDIT)
+		if (ebitmap_set_bit(&state->out->neveraudit_map, new_type->s.value, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
 	return 0;
 }
 
@@ -732,6 +738,12 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			return -1;
 		}
 
+	if (new_alias->flags & TYPE_FLAGS_NEVERAUDIT)
+		if (ebitmap_set_bit(&state->out->neveraudit_map, new_alias->s.value, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
 	return 0;
 }
 
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ddca2b62..6fea2c6f 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1637,6 +1637,48 @@ exit:
 	return rc;
 }
 
+static int write_type_neveraudit_rules_to_cil(FILE *out, struct policydb *pdb)
+{
+	struct strs *strs;
+	char *name;
+	struct ebitmap_node *node;
+	unsigned i, num;
+	int rc = 0;
+
+	rc = strs_init(&strs, pdb->p_types.nprim);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	ebitmap_for_each_positive_bit(&pdb->neveraudit_map, node, i) {
+		rc = strs_add(strs, pdb->p_type_val_to_name[i-1]);
+		if (rc != 0) {
+			goto exit;
+		}
+	}
+
+	strs_sort(strs);
+
+	num = strs_num_items(strs);
+	for (i=0; i<num; i++) {
+		name = strs_read_at_index(strs, i);
+		if (!name) {
+			rc = -1;
+			goto exit;
+		}
+		sepol_printf(out, "(typeneveraudit %s)\n", name);
+	}
+
+exit:
+	strs_destroy(&strs);
+
+	if (rc != 0) {
+		ERR(NULL, "Error writing typeneveraudit rules to CIL");
+	}
+
+	return rc;
+}
+
 #define next_bit_in_range(i, p) (((i) + 1 < sizeof(p)*8) && xperm_test(((i) + 1), p))
 
 static char *xperms_to_str(const avtab_extended_perms_t *xperms)
@@ -3362,6 +3404,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
+	rc = write_type_neveraudit_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = write_avtab_to_cil(out, pdb, 0);
 	if (rc != 0) {
 		goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 661546af..b3b0f224 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1690,6 +1690,48 @@ exit:
 	return rc;
 }
 
+static int write_type_neveraudit_rules_to_conf(FILE *out, struct policydb *pdb)
+{
+	struct strs *strs;
+	char *name;
+	struct ebitmap_node *node;
+	unsigned i, num;
+	int rc = 0;
+
+	rc = strs_init(&strs, pdb->p_types.nprim);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	ebitmap_for_each_positive_bit(&pdb->neveraudit_map, node, i) {
+		rc = strs_add(strs, pdb->p_type_val_to_name[i-1]);
+		if (rc != 0) {
+			goto exit;
+		}
+	}
+
+	strs_sort(strs);
+
+	num = strs_num_items(strs);
+	for (i=0; i<num; i++) {
+		name = strs_read_at_index(strs, i);
+		if (!name) {
+			rc = -1;
+			goto exit;
+		}
+		sepol_printf(out, "neveraudit %s;\n", name);
+	}
+
+exit:
+	strs_destroy(&strs);
+
+	if (rc != 0) {
+		ERR(NULL, "Error writing typeneveraudit rules to policy.conf");
+	}
+
+	return rc;
+}
+
 static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_datum_t *datum)
 {
 	uint32_t data = datum->data;
@@ -3217,6 +3259,11 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
+	rc = write_type_neveraudit_rules_to_conf(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = write_avtab_to_conf(out, pdb, 0);
 	if (rc != 0) {
 		goto exit;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ae9a2b5d..a85d947b 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2277,6 +2277,10 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			cil_println(indent, "(typepermissive %s)", key);
 		}
 
+		if (type->flags & TYPE_FLAGS_NEVERAUDIT) {
+			cil_println(indent, "(typeneveraudit %s)", key);
+		}
+
 		if (type->bounds > 0) {
 			cil_println(indent, "(typebounds %s %s)", pdb->p_type_val_to_name[type->bounds - 1], key);
 		}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 8443380b..a0ad0cae 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -215,6 +215,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_NEVERAUDIT,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBENDPORT + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -348,6 +355,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_NEVERAUDIT,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBENDPORT + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -481,6 +495,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_NEVERAUDIT,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
@@ -944,6 +965,7 @@ int policydb_init(policydb_t * p)
 
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
+	ebitmap_init(&p->neveraudit_map);
 
 	return 0;
 err:
@@ -1520,7 +1542,7 @@ void policydb_destroy(policydb_t * p)
 
 	ebitmap_destroy(&p->policycaps);
 
-	ebitmap_destroy(&p->permissive_map);
+	ebitmap_destroy(&p->neveraudit_map);
 
 	symtabs_destroy(p->symtab);
 
@@ -2483,6 +2505,9 @@ static int type_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		if (properties & TYPEDATUM_PROPERTY_PERMISSIVE
 		    && p->policy_type != POLICY_KERN)
 			typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
+		if (properties & TYPEDATUM_PROPERTY_NEVERAUDIT
+		    && p->policy_type != POLICY_KERN)
+			typdatum->flags |= TYPE_FLAGS_NEVERAUDIT;
 
 		typdatum->bounds = le32_to_cpu(buf[++pos]);
 	} else {
@@ -4337,6 +4362,12 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_NEVERAUDIT &&
+	    p->policy_type == POLICY_KERN) {
+		if (ebitmap_read(&p->neveraudit_map, fp))
+			goto bad;
+	}
+
 	for (i = 0; i < info->sym_num; i++) {
 		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 		if (rc < 0)
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 9ee4b948..a1f277b7 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -593,6 +593,7 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 
 	switch (type->flags) {
 	case 0:
+	case TYPE_FLAGS_NEVERAUDIT:
 	case TYPE_FLAGS_PERMISSIVE:
 	case TYPE_FLAGS_EXPAND_ATTR_TRUE:
 	case TYPE_FLAGS_EXPAND_ATTR_FALSE:
@@ -1600,6 +1601,23 @@ bad:
 	return -1;
 }
 
+static int validate_neveraudit(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
+{
+	ebitmap_node_t *node;
+	uint32_t i;
+
+	ebitmap_for_each_positive_bit(&p->neveraudit_map, node, i) {
+		if (validate_simpletype(i, p, flavors))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid neveraudit type");
+	return -1;
+}
+
 static int validate_range_transition(hashtab_key_t key, hashtab_datum_t data, void *args)
 {
 	const range_trans_t *rt = (const range_trans_t *)key;
@@ -1805,6 +1823,9 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 	if (validate_permissives(handle, p, flavors))
 		goto bad;
 
+	if (validate_neveraudit(handle, p, flavors))
+		goto bad;
+
 	if (validate_range_transitions(handle, p, flavors))
 		goto bad;
 
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 89c80e7e..04dea4bd 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1261,6 +1261,10 @@ static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 		    && p->policy_type != POLICY_KERN)
 			properties |= TYPEDATUM_PROPERTY_PERMISSIVE;
 
+		if (typdatum->flags & TYPE_FLAGS_NEVERAUDIT
+		    && p->policy_type != POLICY_KERN)
+			properties |= TYPEDATUM_PROPERTY_NEVERAUDIT;
+
 		buf[items++] = cpu_to_le32(properties);
 		buf[items++] = cpu_to_le32(typdatum->bounds);
 	} else {
@@ -1269,13 +1273,23 @@ static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 		if (p->policy_type != POLICY_KERN) {
 			buf[items++] = cpu_to_le32(typdatum->flavor);
 
-			if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+			if (p->policyvers >= MOD_POLICYDB_VERSION_NEVERAUDIT)
 				buf[items++] = cpu_to_le32(typdatum->flags);
-			else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
-				WARN(fp->handle, "Warning! Module policy "
-				     "version %d cannot support permissive "
-				     "types, but one was defined",
-				     p->policyvers);
+			else {
+				if (typdatum->flags & TYPE_FLAGS_NEVERAUDIT)
+					WARN(fp->handle, "Warning! Module policy "
+						"version %d cannot support neveraudit "
+						"types, but one was defined",
+						p->policyvers);
+
+				if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+					buf[items++] = cpu_to_le32(typdatum->flags & TYPE_FLAGS_NEVERAUDIT);
+				else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
+					WARN(fp->handle, "Warning! Module policy "
+						"version %d cannot support permissive "
+						"types, but one was defined",
+						p->policyvers);
+			}
 		}
 	}
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
@@ -2332,12 +2346,30 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 		}
 	}
 
+	if (p->policyvers < POLICYDB_VERSION_NEVERAUDIT &&
+	    p->policy_type == POLICY_KERN) {
+		ebitmap_node_t *tnode;
+
+		ebitmap_for_each_positive_bit(&p->neveraudit_map, tnode, i) {
+			WARN(fp->handle, "Warning! Policy version %d cannot "
+			     "support neveraudit types, but some were defined",
+			     p->policyvers);
+			break;
+		}
+	}
+
 	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
 	    p->policy_type == POLICY_KERN) {
 		if (ebitmap_write(&p->permissive_map, fp) == -1)
 			return POLICYDB_ERROR;
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_NEVERAUDIT &&
+	    p->policy_type == POLICY_KERN) {
+		if (ebitmap_write(&p->neveraudit_map, fp) == -1)
+			return POLICYDB_ERROR;
+	}
+
 	num_syms = info->sym_num;
 	for (i = 0; i < num_syms; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
-- 
2.49.0

