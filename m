Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52BB41C2F1
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319761; cv=none; b=eaqaywbvi49U5HYDjoS6h3Y1DitsAxIt1TpM+4xv9UqG+ZJVrXHy3VgNzjfiePZPd/efcySXEcgOn3AtDOq+RhWC1AemqbITaUVuyrgagtPWyi5NBg+8OylScVloIK2HGLegmdzKJZvc6TxXgR6/hEdDtU9QArd6aNaDGSpbXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319761; c=relaxed/simple;
	bh=6AKA9Ec8tLzMBmpKlpeoR/AjxAphLXg6hiEFnMLuo2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9TQrqooTMli7+Bu4sE90Qi4FIIoYWHBOxR2jS1LB/n3Rt1cUpXfpxFkyaqZMAVngNBWHNrjAjVAwDYlWEn7siK1xMBZDdZlaZPPWAxbgkNubvdw26f9Z01QljW/UCv8XI1WmDPUfLVWR71NPMTCfaDs+jcBhAJDrI7t3UFvCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=py6qu92l; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="py6qu92l"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50faeb8317bso62415761cf.2
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 12:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777319759; x=1777924559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KBVtDRZxOMahLqkkUoKcq69JtFGC/9Rond7PNbwpn5g=;
        b=py6qu92lJv56+yW+5GMRKkRNWAtxEoOtAvWkXx/gX1Bi781NeDvDc0y14Q1GA9urhC
         PY1eFblHb+ul3uLzlCZH7Hug1CasJaK193c+vNaGm5Q4bNcc3sqY3LehmRqoGJ+acp0j
         IDTUYWkb2KoNzda4YYhGmI5n5PccpObCxp9sEibrSm+rlBICc3YK4MWOPAdG/wmrviGT
         EkxwP14D8595VMgjoeEzCDU3Iy8eVJAse4x9cCg9UcnIxWxYUyyvR6rUpSveTZZiXvnI
         N5paBMYuz2os1QSMqxyv2szfvVib8Hq8rwRBUJ8rEo8hQ3Cs77PDegsLuY6/DHubcTh7
         QQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777319759; x=1777924559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBVtDRZxOMahLqkkUoKcq69JtFGC/9Rond7PNbwpn5g=;
        b=B6QlO25Srp6/ogWQP/6m7YmXJH1PGiN2ZoOVXlGN/lAUHlaN4d7zB8Lf4IkfQfv2PN
         WiGNr+zrvn7Ko8a/leNF7E6Lnqn3DdEc/aRfLf/QfKmjWGWoN3MNnSEow+CPfrwoDMdH
         IhnBweisNh/EqvsHRj6yt0d+itBZDtegRKYy7qRjnGu340yWVfPRoDmqjEtoulbDY2uQ
         QF87Lqi8sdY/K0V23M7spJO4J7qWAgW2lWObG5G5kxQYdzGjCKVVF7eW9nf1lITaGhZE
         slhQ5XjKqfMTZFlX7wmWLg0bZy2RjeG9gP8na3hRv3Q1wrOSgHNab3/Ol86Ss3lSK0x7
         4cAg==
X-Gm-Message-State: AOJu0YwFsFYGY5fSbIBTTPHMo4dmwL/knH/A5aBEb+PChPhvhRllC8sl
	5xjrglB3sE76swqxE3i0uaxNWVrua5pM6CYQureHfQP27bmGYm1N6DcfStcjvw==
X-Gm-Gg: AeBDietDTdqBbIeoF/AcI8pRN3dTNKKe2O6RnDY+PlwVK+dWqdiHumANG/sqeidKowT
	TdLIZgejeDaoybKlFMXE45tfhjgrNDvuoCFqGE5VT8KIgVJeeGJEnpma+v0kAH33Y0GRgL9vaQN
	d1oXFGF/DyOvCNP3NsqtU/U99UtlGtVbJlnqMvmSVBwvvrkmOip5JSU7kbRUYQ6Bc0VgPRmzkkO
	9DPAToveel7YKC5PQZ1AyEzq8h+j2EV5eZqviuViU5RkqEKLKgkmmFj6/0xc6di+7SLkaMltqgE
	GOE4n/SS3lMuWZ/G6aSA/8oaYDEXnvdU6yRHhy5VH8P4Cn/Wflek8DSuIZVCI2YzKoOgMhX2ZNC
	i2/stfNJuxc14nrsqrtlREiNcnN8SDtdfvvaCEkXrOM/hq57WnPgFaEqbeoc2zteqpnBZOOhy0m
	XCBqxJQpoRaUFk6dGIoCVdULdn35bZo0sAe2sNdOWrxgx8OSS/ts29VtVQ
X-Received: by 2002:a05:622a:a990:10b0:50d:a4e6:997f with SMTP id d75a77b69052e-5100c88a9d9mr9898091cf.15.1777319758866;
        Mon, 27 Apr 2026 12:55:58 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100db1ffd1sm1047601cf.14.2026.04.27.12.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 12:55:58 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com,
	James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 1/3] libsepol/cil: Add function to check CIL neverallows against binary policy
Date: Mon, 27 Apr 2026 15:55:44 -0400
Message-ID: <20260427195546.91395-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the function cil_check_neverallows_against_pdb() that will extract
the neverallows from a CIL db and check them against a kernel policydb.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/include/cil/cil.h |  1 +
 libsepol/cil/src/cil_binary.c  | 46 ++++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_binary.h  | 12 +++++++++
 libsepol/src/libsepol.map.in   |  5 ++++
 4 files changed, 64 insertions(+)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index 88e47e79..fc9cc504 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -65,6 +65,7 @@ extern int cil_write_parse_ast(FILE *out, cil_db_t *db);
 extern int cil_write_build_ast(FILE *out, cil_db_t *db);
 extern int cil_write_resolve_ast(FILE *out, cil_db_t *db);
 extern int cil_write_post_ast(FILE *out, cil_db_t *db);
+extern int cil_check_neverallows_against_pdb(const struct cil_db *db, policydb_t *pdb, int *violation);
 
 enum cil_log_level {
 	CIL_ERR = 1,
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 74ec3cd5..21cb07ad 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -5143,6 +5143,52 @@ exit:
 	return rc;
 }
 
+static int __cil_collect_neverallows_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
+{
+	if (node->flavor == CIL_BLOCK) {
+		struct cil_block *blk = node->data;
+		if (blk->is_abstract == CIL_TRUE) {
+			*finished = CIL_TREE_SKIP_HEAD;
+		}
+	} else if (node->flavor == CIL_MACRO) {
+		*finished = CIL_TREE_SKIP_HEAD;
+	} else if (node->flavor == CIL_BOOLEANIF) {
+		*finished = CIL_TREE_SKIP_HEAD;
+	} else if (node->flavor == CIL_AVRULE || node->flavor == CIL_AVRULEX) {
+		struct cil_avrule *rule = node->data;
+		if (rule->rule_kind == CIL_AVRULE_NEVERALLOW) {
+			struct cil_list *neverallows = extra_args;
+			cil_list_prepend(neverallows, CIL_LIST_ITEM, node);
+		}
+	}
+
+	return SEPOL_OK;
+}
+
+int cil_check_neverallows_against_pdb(const struct cil_db *db, policydb_t *pdb, int *violation)
+{
+	int rc = SEPOL_OK;
+	struct cil_list *neverallows;
+
+	if (db == NULL || pdb == NULL) {
+		cil_log(CIL_ERR,"CIL db and/or Policy db is NULL\n");
+		return SEPOL_ERR;
+	}
+
+	cil_list_init(&neverallows, CIL_LIST_ITEM);
+	rc = cil_tree_walk(db->ast->root, __cil_collect_neverallows_helper, NULL, NULL, neverallows);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_INFO, "Failure collecting neverallows\n");
+		goto exit;
+	}
+
+	rc = cil_check_neverallows(db, pdb, neverallows, violation);
+
+exit:
+	cil_list_destroy(&neverallows, CIL_FALSE);
+	return rc;
+}
+
 static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
 {
 	struct cil_classperms *cp;
diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
index e6826221..e8fff9b4 100644
--- a/libsepol/cil/src/cil_binary.h
+++ b/libsepol/cil/src/cil_binary.h
@@ -36,6 +36,18 @@
 #include "cil_tree.h"
 #include "cil_list.h"
 
+
+/**
+ * Check neverallows from a cil database against a policy database
+ *
+ * @param[in] db The cil database.
+ * @param[in] pdb The policy database.
+ * @param[out] violation 1 if a neverallow violation was found, 0 otherwise
+ *
+ * @return SEPOL_OK upon success or an error otherwise.
+ */
+int cil_check_neverallows_against_pdb(const struct cil_db *db, policydb_t *pdb, int *violation);
+
 /**
  * Create a binary policydb from the cil db.
  *
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index e5e6608c..2b103993 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -294,3 +294,8 @@ LIBSEPOL_3.6 {
   global:
 	cil_write_post_ast;
 } LIBSEPOL_3.4;
+
+LIBSEPOL_3.11 {
+  global:
+	cil_check_neverallows_against_pdb;
+} LIBSEPOL_3.6;
-- 
2.53.0

