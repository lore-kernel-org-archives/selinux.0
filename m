Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEED155342
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520756; cv=none; b=f73jcFiSG25q4iPUOqyLSoIgHPOjZPaS/d3tzfRFoqcAe0f0IlP2E37uaFBt4WKINnyRc9cGC0b5b7mE+n892OJO0An690oo51ec/U1Xkg0tYDdVn9pA658r/Ec/7sC6JUfJq2hOmruxjU3Sv5DRL9u8ICebE/vkFPXVmga47ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520756; c=relaxed/simple;
	bh=TQzY0iPPdTWPNaU1UYAArYfAmA5taAOnoUa9BvP7lEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HnphYTshpo8kLne7q6oRgiYgDx49cVh+olm9GoCladRJuvYUxj5JJZJehdk1cjraEs6DkrOVzMSOgTljUlCN1nW4KBrTqrh8ie0iEQb27S/Zeqdh2uScv+Fbhk4mlnb2b96dMsDKQonu7spRrFXgrw8tZzc+D1uEszlq/oi7YIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH8NM1G/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH8NM1G/"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be49f6b331so158118785a.1
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745520752; x=1746125552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ualhcYbzknYJ42vIDSn+S/Ru+BYmjQBRh63tXjdqWk=;
        b=VH8NM1G/UwumcmqFapra86kEgce+IymLItk4X6Cf14DENhhHpRrShtxpZ460rvFxkT
         cTxIJq8tVAf26CAOtp2UXWmXoPEM1zjAdMH3Qd97Z7t7YFgp6g6quH3YyXI2oknBy4TE
         eUKQR1PVbDmgHCcTst1ABUEC280E8l1LMaPUDEEFFpe/wTOF0kzTFJWBpEinBCgDqZN+
         /5amSAYWUvy6ps0EhdaaIS/00NNNH4OPlmCjzFD1nQ5HfTDmAGy+TUJjE6vowztJxDC7
         huJmyP3CMaLClbrhj++rhta3AuyCuOxDsW/vbU4LtqfG5LnMDgdL1KHU4+7j0/0fh31B
         +Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745520752; x=1746125552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ualhcYbzknYJ42vIDSn+S/Ru+BYmjQBRh63tXjdqWk=;
        b=JyXW/hlnkHIfed8TzTQOa98un6wPmyNcZabnZxTisrMC19LPHtOI8NsZrHneF7onjQ
         8RzdmibIcI7dcrHM5LDTMvUwzntf0jgQ4i9OUwcAnz+2yw8Q460nRKSN9tg+WZO+pepy
         Zq/IctC2xhPRrKeJO66O55kJP6fdE5oa4pRlx6kKEI1MrFQIbWdYz6LeHZ3PbvsZKtt6
         obW/BUKHALAG0qA57qNTnrQCYiVpXZ73RuXlr/KZVTuOe//L8+VYswEL8m18LsejtKsV
         ZUYR4V5G8K9c9EU7K+5wwo2QRPMpYuyWMioxozfxNI3JQRGgnxh9dLBcy95EkFgbnuLo
         Ci9Q==
X-Gm-Message-State: AOJu0YyKbxENy2WGJWqkxePaQVZxL6pUWs4gUN/37sPTU9z/JmL8RtVS
	tnbZq23aDXELopCvSY4y1t87TR6rcqt+bZ4dG9Gwed5lG1sZYtjuHMQvUFWO
X-Gm-Gg: ASbGncurChBwg1oYABxq5il3OrvClNwa13PDmPcfJwlTQ2+C84ROgfeXKkj+XvoeS70
	GXGrtcvcFfojU49bWTZFw9VhNaDIlFUp/ICSgfUxfT350cF4zJmeY43l6VvVWi7fab74P2gGvV1
	6S1VGcLQDq3Yapp7eZIhoDw7bFqMolv6536WDvDLPzu10GBhgRrmkp1PQ3tsdFNPQQ1pRIAYbff
	SEZhM0+r/qMfEVCjGIJkTQb3vE2Vek/dr9rK4abvu8M5B9LDUc1qBKERkAxKpMKS0a1qkJt3CSx
	0F9YwgVgO1JpZCi9O9Ln1fE5aLCBmp9A0H1BXb50ESQfeDvu/yTFFNB4V9D6k9MwRUIGAlNp3Jd
	kAhFoXU77pKZ7BhZqbst3TMNtvkUSLeWzJDozNT1zB/23MGqyvyEh97l2oyRt4h/e4cxT2zC0oo
	91Xgc=
X-Google-Smtp-Source: AGHT+IEuPGxkQFX0A2TbRhwKvEchXQgs/sC5BPLgosNdLHOmVyzQwq2nJ8Ng2icGUZO8+/HExnK2tw==
X-Received: by 2002:a05:620a:370c:b0:7c5:a29e:3477 with SMTP id af79cd13be357-7c956f60f87mr683054785a.53.1745520751422;
        Thu, 24 Apr 2025 11:52:31 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d87791sm119864685a.74.2025.04.24.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:52:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol,checkpolicy: introduce unconfined as a first class concept to SELinux
Date: Thu, 24 Apr 2025 14:52:12 -0400
Message-ID: <20250424185213.17910-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce unconfined as a first class concept to SELinux. Previously,
SELinux had no such concept and unconfined domains were solely defined
by policy.

Advantages of elevating to a first class concept:
1. Explicit allow rules for unconfined domains can be omitted, shrinking the policy.
2. The kernel can leverage this knowledge to further optimize checking on unconfined processes.

Disadvantages:
1. Yet another juicy target for exploit writers, similar to permissive types.
2. Requires a new policy version/format and bitmap.

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
index 78adbec0..e1a197a2 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -257,6 +257,49 @@ out:
 	return rc;
 }
 
+int define_unconfined(void)
+{
+	char *type = NULL;
+	struct type_datum *t;
+	int rc = 0;
+
+	type = queue_remove(id_queue);
+
+	if (!type) {
+		yyerror2("forgot to include type in unconfined definition?");
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
+		yyerror2("attributes may not be unconfined: %s", type);
+		rc = -1;
+		goto out;
+	}
+
+	t->flags |= TYPE_FLAGS_UNCONFINED;
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
index 216da3ad..805ec9d4 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -45,6 +45,7 @@ int define_ipv6_cidr_node_context(void);
 int define_level(void);
 int define_netif_context(void);
 int define_permissive(void);
+int define_unconfined(void);
 int define_polcap(void);
 int define_ibpkey_context(unsigned int low, unsigned int high);
 int define_ibendport_context(unsigned int port);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 7e117222..5c35dcbb 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -152,6 +152,7 @@ typedef int (* require_func_t)(int pass);
 %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
 %token POLICYCAP
 %token PERMISSIVE
+%token UNCONFINED
 %token FILESYSTEM
 %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
 %token LOW_HIGH LOW HIGH GLBLUB
@@ -330,6 +331,7 @@ te_decl			: attribute_def
                         | range_trans_def
                         | te_avtab_def
 			| permissive_def
+			| unconfined_def
 			;
 attribute_def           : ATTRIBUTE identifier ';'
                         { if (define_attrib()) YYABORT;}
@@ -934,6 +936,8 @@ policycap_def		: POLICYCAP identifier ';'
 			;
 permissive_def		: PERMISSIVE identifier ';'
 			{if (define_permissive()) YYABORT;}
+unconfined_def		: UNCONFINED identifier ';'
+			{if (define_unconfined()) YYABORT;}
 
 /*********** module grammar below ***********/
 
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 5fb9ff37..74545365 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -270,6 +270,8 @@ policycap |
 POLICYCAP			{ return(POLICYCAP); }
 permissive |
 PERMISSIVE			{ return(PERMISSIVE); }
+unconfined |
+UNCONFINED			{ return(UNCONFINED); }
 default_user |
 DEFAULT_USER			{ return(DEFAULT_USER); }
 default_role |
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 5521c7ea..6fd24300 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -171,6 +171,7 @@ char *CIL_KEY_TYPEALIAS;
 char *CIL_KEY_TYPEALIASACTUAL;
 char *CIL_KEY_TYPEBOUNDS;
 char *CIL_KEY_TYPEPERMISSIVE;
+char *CIL_KEY_TYPEUNCONFINED;
 char *CIL_KEY_RANGETRANSITION;
 char *CIL_KEY_USERROLE;
 char *CIL_KEY_ROLETYPE;
@@ -320,6 +321,7 @@ static void cil_init_keys(void)
 	CIL_KEY_TYPEALIASACTUAL = cil_strpool_add("typealiasactual");
 	CIL_KEY_TYPEBOUNDS = cil_strpool_add("typebounds");
 	CIL_KEY_TYPEPERMISSIVE = cil_strpool_add("typepermissive");
+	CIL_KEY_TYPEUNCONFINED = cil_strpool_add("typeunconfined");
 	CIL_KEY_RANGETRANSITION = cil_strpool_add("rangetransition");
 	CIL_KEY_USERROLE = cil_strpool_add("userrole");
 	CIL_KEY_ROLETYPE = cil_strpool_add("roletype");
@@ -939,6 +941,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_TYPEPERMISSIVE:
 		cil_destroy_typepermissive(*data);
 		break;
+	case CIL_TYPEUNCONFINED:
+		cil_destroy_typeunconfined(*data);
+		break;
 	case CIL_SENS:
 		cil_destroy_sensitivity(*data);
 		break;
@@ -1310,6 +1315,8 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		return CIL_KEY_TYPEBOUNDS;
 	case CIL_TYPEPERMISSIVE:
 		return CIL_KEY_TYPEPERMISSIVE;
+	case CIL_TYPEUNCONFINED:
+		return CIL_KEY_TYPEUNCONFINED;
 	case CIL_SENS:
 		return CIL_KEY_SENSITIVITY;
 	case CIL_SENSALIAS:
@@ -2451,6 +2458,14 @@ void cil_typepermissive_init(struct cil_typepermissive **typeperm)
 	(*typeperm)->type = NULL;
 }
 
+void cil_typeunconfined_init(struct cil_typeunconfined **typeperm)
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
index e84188a0..6d662f18 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -564,6 +564,27 @@ exit:
 
 }
 
+int cil_typeunconfined_to_policydb(policydb_t *pdb, struct cil_typeunconfined *cil_typeperm)
+{
+	int rc = SEPOL_ERR;
+	type_datum_t *sepol_type = NULL;
+
+	rc = __cil_get_sepol_type_datum(pdb, DATUM(cil_typeperm->type), &sepol_type);
+	if (rc != SEPOL_OK) goto exit;
+
+	if (ebitmap_set_bit(&pdb->unconfined_map, sepol_type->s.value, 1)) {
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
+		case CIL_TYPEUNCONFINED:
+			rc = cil_typeunconfined_to_policydb(pdb, node->data);
+			break;
 		case CIL_TYPEATTRIBUTE:
 			rc = cil_typeattribute_to_bitmap(pdb, db, node->data);
 			break;
diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
index 0b6e3b79..dc11ec7d 100644
--- a/libsepol/cil/src/cil_binary.h
+++ b/libsepol/cil/src/cil_binary.h
@@ -136,6 +136,18 @@ int cil_typealias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alias);
  */
 int cil_typepermissive_to_policydb(policydb_t *pdb, struct cil_typepermissive *cil_typeperm);
 
+/**
+ * Insert cil typeunconfined structure into sepol policydb.
+ * The function looks up the previously inserted type and flips the bit
+ * in the unconfined types bitmap that corresponds to that type's value.
+ *
+ * @param[in] pdb The policy database to insert the typeunconfined into.
+ * @param[in] datum The cil_typeunconfined datum.
+ *
+ * @return SEPOL_OK upon success or an error otherwise.
+ */
+int cil_typeunconfined_to_policydb(policydb_t *pdb, struct cil_typeunconfined *cil_typeperm);
+
 /**
  * Insert cil attribute structure into sepol policydb.
  *
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 072d2622..dd0dd5ad 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -3374,6 +3374,50 @@ void cil_destroy_typepermissive(struct cil_typepermissive *typeperm)
 	free(typeperm);
 }
 
+int cil_gen_typeunconfined(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_END
+	};
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
+	struct cil_typeunconfined *typeperm = NULL;
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
+	cil_typeunconfined_init(&typeperm);
+
+	typeperm->type_str = parse_current->next->data;
+
+	ast_node->data = typeperm;
+	ast_node->flavor = CIL_TYPEUNCONFINED;
+
+	return SEPOL_OK;
+
+exit:
+	cil_tree_log(parse_current, CIL_ERR, "Bad typeunconfined declaration");
+	cil_destroy_typeunconfined(typeperm);
+	return rc;
+}
+
+void cil_destroy_typeunconfined(struct cil_typeunconfined *typeperm)
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
+	} else if (parse_current->data == CIL_KEY_TYPEUNCONFINED) {
+		rc = cil_gen_typeunconfined(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_RANGETRANSITION) {
 		rc = cil_gen_rangetransition(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_ROLE) {
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 7fa4299c..91b5b84b 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -146,7 +146,9 @@ int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_node *parse_c
 void cil_destroy_expandtypeattribute(struct cil_expandtypeattribute *expandattr);
 int cil_gen_typebounds(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
+int cil_gen_typeunconfined(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_typepermissive(struct cil_typepermissive *typeperm);
+void cil_destroy_typeunconfined(struct cil_typeunconfined *typeperm);
 int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_typetransition(struct cil_nametypetransition *nametypetrans);
 int cil_gen_rangetransition(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 1507edb4..e4980a03 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -608,6 +608,20 @@ int cil_copy_typepermissive(__attribute__((unused)) struct cil_db *db, void *dat
 	return SEPOL_OK;
 }
 
+int cil_copy_typeunconfined(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_typeunconfined *orig = data;
+	struct cil_typeunconfined *new = NULL;
+
+	cil_typeunconfined_init(&new);
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
+	case CIL_TYPEUNCONFINED:
+		copy_func = cil_copy_typeunconfined;
+		break;
 	case CIL_TYPEATTRIBUTE:
 		copy_func = &cil_copy_typeattribute;
 		break;
diff --git a/libsepol/cil/src/cil_copy_ast.h b/libsepol/cil/src/cil_copy_ast.h
index 9e6be5ac..17ee98ce 100644
--- a/libsepol/cil/src/cil_copy_ast.h
+++ b/libsepol/cil/src/cil_copy_ast.h
@@ -72,6 +72,7 @@ int cil_copy_roleallow(struct cil_db *db, void *data, void **copy, symtab_t *sym
 int cil_copy_type(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typebounds(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typepermissive(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
+int cil_copy_typeunconfined(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typeattribute(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typeattributeset(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_typealias(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index 155d7c80..31468289 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -77,6 +77,7 @@ enum cil_flavor {
 	CIL_TYPEALIASACTUAL,
 	CIL_TYPEBOUNDS,
 	CIL_TYPEPERMISSIVE,
+	CIL_TYPEUNCONFINED,
 	CIL_SENSALIASACTUAL,
 	CIL_SENSITIVITYORDER,
 	CIL_SENSCAT,
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 959b31e3..4d8b1d13 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -188,6 +188,7 @@ extern char *CIL_KEY_TYPEALIAS;
 extern char *CIL_KEY_TYPEALIASACTUAL;
 extern char *CIL_KEY_TYPEBOUNDS;
 extern char *CIL_KEY_TYPEPERMISSIVE;
+extern char *CIL_KEY_TYPEUNCONFINED;
 extern char *CIL_KEY_RANGETRANSITION;
 extern char *CIL_KEY_USERROLE;
 extern char *CIL_KEY_ROLETYPE;
@@ -580,6 +581,11 @@ struct cil_typepermissive {
 	void *type; /* type or alias */
 };
 
+struct cil_typeunconfined {
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
+void cil_typeunconfined_init(struct cil_typeunconfined **typeperm);
 void cil_nametypetransition_init(struct cil_nametypetransition **nametypetrans);
 void cil_rangetransition_init(struct cil_rangetransition **rangetrans);
 void cil_bool_init(struct cil_bool **cilbool);
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index c497c8ab..9d7a0f07 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1297,6 +1297,11 @@ static void cil_typepermissive_to_policy(FILE *out, struct cil_typepermissive *r
 	fprintf(out, "permissive %s;\n", DATUM(rule->type)->fqn);
 }
 
+static void cil_typeunconfined_to_policy(FILE *out, struct cil_typeunconfined *rule)
+{
+	fprintf(out, "unconfined %s;\n", DATUM(rule->type)->fqn);
+}
+
 struct block_te_rules_extra {
 	FILE *out;
 	enum cil_flavor flavor;
@@ -1359,6 +1364,11 @@ static int __cil_block_te_rules_to_policy_helper(struct cil_tree_node *node, uin
 			cil_typepermissive_to_policy(args->out, node->data);
 		}
 		break;
+	case CIL_TYPEUNCONFINED:
+		if (args->flavor == node->flavor) {
+			cil_typeunconfined_to_policy(args->out, node->data);
+		}
+		break;
 	default:
 		break;
 	}
@@ -1376,6 +1386,10 @@ static void cil_block_te_rules_to_policy(FILE *out, struct cil_tree_node *start,
 	args.rule_kind = 0;
 	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
 
+	args.flavor = CIL_TYPEUNCONFINED;
+	args.rule_kind = 0;
+	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
+
 	args.flavor = CIL_AVRULE;
 	args.rule_kind = CIL_AVRULE_ALLOWED;
 	cil_tree_walk(start, __cil_block_te_rules_to_policy_helper, NULL, NULL, &args);
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index a8fa89df..dd1b9ccb 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -624,6 +624,34 @@ exit:
 	return rc;
 }
 
+int cil_resolve_typeunconfined(struct cil_tree_node *current, struct cil_db *db)
+{
+	struct cil_typeunconfined *typeperm = current->data;
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
+		cil_log(CIL_ERR, "Typeunconfined must be a type or type alias\n");
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
+		case CIL_TYPEUNCONFINED:
+			rc = cil_resolve_typeunconfined(node, db);
+			break;
 		case CIL_NAMETYPETRANSITION:
 			rc = cil_resolve_nametypetransition(node, db);
 			break;
diff --git a/libsepol/cil/src/cil_resolve_ast.h b/libsepol/cil/src/cil_resolve_ast.h
index 2f6b7e86..ef28f0a8 100644
--- a/libsepol/cil/src/cil_resolve_ast.h
+++ b/libsepol/cil/src/cil_resolve_ast.h
@@ -46,6 +46,7 @@ int cil_resolve_typeattributeset(struct cil_tree_node *current, struct cil_db *d
 int cil_resolve_typealias(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_typebounds(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_typepermissive(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_typeunconfined(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_nametypetransition(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_rangetransition(struct cil_tree_node *current, struct cil_db *db);
 int cil_resolve_classcommon(struct cil_tree_node *current, struct cil_db *db);
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 15d8bbaf..215db233 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1125,6 +1125,13 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		fprintf(out, ")\n");
 		break;
 	}
+	case CIL_TYPEUNCONFINED: {
+		struct cil_typeunconfined *tp = node->data;
+		fprintf(out, "(typeunconfined ");
+		fprintf(out, "%s", datum_or_str(DATUM(tp->type), tp->type_str));
+		fprintf(out, ")\n");
+		break;
+	}
 	case CIL_TYPEBOUNDS: {
 		struct cil_bounds *bounds = node->data;
 		fprintf(out, "(typebounds ");
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index f833354b..7dbe362e 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -188,6 +188,7 @@ typedef struct type_datum {
 #define TYPE_FLAGS_EXPAND_ATTR_FALSE	(1 << 2)
 #define TYPE_FLAGS_EXPAND_ATTR (TYPE_FLAGS_EXPAND_ATTR_TRUE | \
 				TYPE_FLAGS_EXPAND_ATTR_FALSE)
+#define TYPE_FLAGS_UNCONFINED		(1 << 3)
 	uint32_t flags;
 	uint32_t bounds;	/* bounds type, if exist */
 } type_datum_t;
@@ -200,6 +201,7 @@ typedef struct type_datum {
 #define TYPEDATUM_PROPERTY_ATTRIBUTE	0x0002
 #define TYPEDATUM_PROPERTY_ALIAS	0x0004	/* userspace only */
 #define TYPEDATUM_PROPERTY_PERMISSIVE	0x0008	/* userspace only */
+#define TYPEDATUM_PROPERTY_UNCONFINED	0x0010	/* userspace only */
 
 /* User attributes */
 typedef struct user_datum {
@@ -607,6 +609,9 @@ typedef struct policydb {
 	   bitmaps.  Someday the 0 bit may be used for global permissive */
 	ebitmap_t permissive_map;
 
+	/* ditto */
+	ebitmap_t unconfined_map;
+
 	unsigned policyvers;
 
 	unsigned handle_unknown;
@@ -760,10 +765,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitions */
 #define POLICYDB_VERSION_COND_XPERMS	34 /* extended permissions in conditional policies */
+#define POLICYDB_VERSION_UNCONFINED	35 /* unconfined domains */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_COND_XPERMS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_UNCONFINED
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
@@ -787,9 +793,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
 #define MOD_POLICYDB_VERSION_COND_XPERMS	22
+#define MOD_POLICYDB_VERSION_UNCONFINED		23
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_COND_XPERMS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_UNCONFINED
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 7032a83f..136f26e6 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -170,6 +170,12 @@ static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			return -1;
 		}
 
+	if (new_type->flags & TYPE_FLAGS_UNCONFINED)
+		if (ebitmap_set_bit(&state->out->unconfined_map, new_type->s.value, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
 	return 0;
 }
 
@@ -732,6 +738,12 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			return -1;
 		}
 
+	if (new_alias->flags & TYPE_FLAGS_UNCONFINED)
+		if (ebitmap_set_bit(&state->out->unconfined_map, new_alias->s.value, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
 	return 0;
 }
 
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ddca2b62..68165684 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1637,6 +1637,48 @@ exit:
 	return rc;
 }
 
+static int write_type_unconfined_rules_to_cil(FILE *out, struct policydb *pdb)
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
+	ebitmap_for_each_positive_bit(&pdb->unconfined_map, node, i) {
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
+		sepol_printf(out, "(typeunconfined %s)\n", name);
+	}
+
+exit:
+	strs_destroy(&strs);
+
+	if (rc != 0) {
+		ERR(NULL, "Error writing typeunconfined rules to CIL");
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
 
+	rc = write_type_unconfined_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = write_avtab_to_cil(out, pdb, 0);
 	if (rc != 0) {
 		goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 661546af..5801543f 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1690,6 +1690,48 @@ exit:
 	return rc;
 }
 
+static int write_type_unconfined_rules_to_conf(FILE *out, struct policydb *pdb)
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
+	ebitmap_for_each_positive_bit(&pdb->unconfined_map, node, i) {
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
+		sepol_printf(out, "unconfined %s;\n", name);
+	}
+
+exit:
+	strs_destroy(&strs);
+
+	if (rc != 0) {
+		ERR(NULL, "Error writing typeunconfined rules to policy.conf");
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
 
+	rc = write_type_unconfined_rules_to_conf(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = write_avtab_to_conf(out, pdb, 0);
 	if (rc != 0) {
 		goto exit;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ae9a2b5d..b7035343 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2277,6 +2277,10 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			cil_println(indent, "(typepermissive %s)", key);
 		}
 
+		if (type->flags & TYPE_FLAGS_UNCONFINED) {
+			cil_println(indent, "(typeunconfined %s)", key);
+		}
+
 		if (type->bounds > 0) {
 			cil_println(indent, "(typebounds %s %s)", pdb->p_type_val_to_name[type->bounds - 1], key);
 		}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 8443380b..997eb4d7 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -215,6 +215,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_UNCONFINED,
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
+	 .version = MOD_POLICYDB_VERSION_UNCONFINED,
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
+	 .version = MOD_POLICYDB_VERSION_UNCONFINED,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
@@ -944,6 +965,7 @@ int policydb_init(policydb_t * p)
 
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
+	ebitmap_init(&p->unconfined_map);
 
 	return 0;
 err:
@@ -1520,7 +1542,7 @@ void policydb_destroy(policydb_t * p)
 
 	ebitmap_destroy(&p->policycaps);
 
-	ebitmap_destroy(&p->permissive_map);
+	ebitmap_destroy(&p->unconfined_map);
 
 	symtabs_destroy(p->symtab);
 
@@ -2483,6 +2505,9 @@ static int type_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		if (properties & TYPEDATUM_PROPERTY_PERMISSIVE
 		    && p->policy_type != POLICY_KERN)
 			typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
+		if (properties & TYPEDATUM_PROPERTY_UNCONFINED
+		    && p->policy_type != POLICY_KERN)
+			typdatum->flags |= TYPE_FLAGS_UNCONFINED;
 
 		typdatum->bounds = le32_to_cpu(buf[++pos]);
 	} else {
@@ -4337,6 +4362,12 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_UNCONFINED &&
+	    p->policy_type == POLICY_KERN) {
+		if (ebitmap_read(&p->unconfined_map, fp))
+			goto bad;
+	}
+
 	for (i = 0; i < info->sym_num; i++) {
 		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 		if (rc < 0)
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 9ee4b948..6678e29c 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -593,6 +593,7 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 
 	switch (type->flags) {
 	case 0:
+	case TYPE_FLAGS_UNCONFINED:
 	case TYPE_FLAGS_PERMISSIVE:
 	case TYPE_FLAGS_EXPAND_ATTR_TRUE:
 	case TYPE_FLAGS_EXPAND_ATTR_FALSE:
@@ -1600,6 +1601,23 @@ bad:
 	return -1;
 }
 
+static int validate_unconfined(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
+{
+	ebitmap_node_t *node;
+	uint32_t i;
+
+	ebitmap_for_each_positive_bit(&p->unconfined_map, node, i) {
+		if (validate_simpletype(i, p, flavors))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid unconfined type");
+	return -1;
+}
+
 static int validate_range_transition(hashtab_key_t key, hashtab_datum_t data, void *args)
 {
 	const range_trans_t *rt = (const range_trans_t *)key;
@@ -1805,6 +1823,9 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 	if (validate_permissives(handle, p, flavors))
 		goto bad;
 
+	if (validate_unconfined(handle, p, flavors))
+		goto bad;
+
 	if (validate_range_transitions(handle, p, flavors))
 		goto bad;
 
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 89c80e7e..8b1c9659 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1261,6 +1261,10 @@ static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 		    && p->policy_type != POLICY_KERN)
 			properties |= TYPEDATUM_PROPERTY_PERMISSIVE;
 
+		if (typdatum->flags & TYPE_FLAGS_UNCONFINED
+		    && p->policy_type != POLICY_KERN)
+			properties |= TYPEDATUM_PROPERTY_UNCONFINED;
+
 		buf[items++] = cpu_to_le32(properties);
 		buf[items++] = cpu_to_le32(typdatum->bounds);
 	} else {
@@ -1269,13 +1273,23 @@ static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 		if (p->policy_type != POLICY_KERN) {
 			buf[items++] = cpu_to_le32(typdatum->flavor);
 
-			if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+			if (p->policyvers >= MOD_POLICYDB_VERSION_UNCONFINED)
 				buf[items++] = cpu_to_le32(typdatum->flags);
-			else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
-				WARN(fp->handle, "Warning! Module policy "
-				     "version %d cannot support permissive "
-				     "types, but one was defined",
-				     p->policyvers);
+			else {
+				if (typdatum->flags & TYPE_FLAGS_UNCONFINED)
+					WARN(fp->handle, "Warning! Module policy "
+						"version %d cannot support unconfined "
+						"types, but one was defined",
+						p->policyvers);
+
+				if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+					buf[items++] = cpu_to_le32(typdatum->flags & TYPE_FLAGS_UNCONFINED);
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
 
+	if (p->policyvers < POLICYDB_VERSION_UNCONFINED &&
+	    p->policy_type == POLICY_KERN) {
+		ebitmap_node_t *tnode;
+
+		ebitmap_for_each_positive_bit(&p->unconfined_map, tnode, i) {
+			WARN(fp->handle, "Warning! Policy version %d cannot "
+			     "support unconfined types, but some were defined",
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
 
+	if (p->policyvers >= POLICYDB_VERSION_UNCONFINED &&
+	    p->policy_type == POLICY_KERN) {
+		if (ebitmap_write(&p->unconfined_map, fp) == -1)
+			return POLICYDB_ERROR;
+	}
+
 	num_syms = info->sym_num;
 	for (i = 0; i < num_syms; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
-- 
2.49.0

