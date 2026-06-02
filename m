Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356183E8324
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411717; cv=none; b=IyY2+WthjS+NWVnd0ihbu0cW3tV+KWErtshbomxaFfpwCqQ3QmhH9YUrSHi5AbPsfo6MIp1P1YvvZG1lyxigNIszdFSYHY2crG+iVEnDhlYKsp/yVDP/Gsv1nURgT5/PrA9XLlFJjudSTSwArzoSJDoHb7hj0K9fv+SLRhVSb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411717; c=relaxed/simple;
	bh=g4GiaiLgCQyuLDgiCXee8+tzplIWVVz75DgP6PBu2bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pIS2RYid7lWWLBw4AU4zNylmhS+XW9P7L9T8ADaSFonBCwWDfW51OLRXYY5j+VqLAufF29hjwIeD5ajdz09z/gp0K+V9/0NzkP3e4oXZ6n7+v03Bi55e63qZGQnphcFEFPQ8jltgcniQ6P+WvifjOpW9O/qNlGQLYiJ23U5gsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSdTcx6B; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSdTcx6B"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-915660e5b8eso250105385a.3
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780411715; x=1781016515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JP5zbFkLxC21cpPTE322NnjlVxp2m7RWG4lcO4Wu/o=;
        b=XSdTcx6B71pdydh/dqtUnYmj1THZdBOa3fe9R+FjXJbiuvwVqv2/QjMRLIFGFFFkDq
         QNNaptg32RZUG9gQIOL2nT70ffJAi262USpxQiiCWU+h9FRJ2WYUB6UxYOQZy4/dBvRY
         yR/tJ/q++dJLuLTOJTu/8x3Xiwr1vd6/cOIx+QbCGk7kizbLItP0U9fnbve0CZMa1At1
         RwU9u/9KMrH9EVrg7wtTQ1dGQpyKnYAqqp4eI5QxlEkcoTgOLZaWt78UolngUxXYsymo
         qMP6pXYrMhD7YSPOVMfF7lpw2SWrHnE+m8RsGU7OOFY7PCLO4P+j1jo+u9HOk3sTp98+
         a8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780411715; x=1781016515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JP5zbFkLxC21cpPTE322NnjlVxp2m7RWG4lcO4Wu/o=;
        b=fpM/1pVXf3X8CAx+YOzrOjDD5ijO3FyAkwGfmW4lYF/bVlClLIjH7iFnXYTmK866JX
         d01fW5sY84EJ4tXqKJKrB9CkOfvQLEv0raXrODHirKV0AxN1Cihg8ySmlMrFPemmGd1Y
         8EJdVGHAoW9sM+u0jSVKiwLZbq2hj2bWu/ndiyzGxGmMq7CXwLQivsaH5rr8upaahR+o
         4f3tZo99FijZhH2QEsNnAp2z1r8ou5f5lPBMT2lAtxJ1hs8E9X07hvWC6RTOAi+F0U4V
         tiNEpX5kaCv2200fpwQPFGBMcKiuXehEAJ4EAaYMANvlvrkwOhpV04ehc2Gv7RH5N/ft
         UJ5g==
X-Gm-Message-State: AOJu0YxUGfVzzbJdTsVG8M7A+I0nWv/a9pX2zD8S6PjK1q5r/aK2wAQt
	C1SWkjeI6gFwXE0sYDUeGM6WZ9oN9s40bTACKZcTFnlKXhvzxgJo00pbDbNg/w==
X-Gm-Gg: Acq92OH9wMDNpaWtA49/JpvriaEnNV2809r1+103XrecDCmdUWrZRSyqjlgbyb1MQ3E
	1yBrw0RGswCGg2qFPSAnASyM7P4j+gpgChXUNFpvg8q7FHFAuMO0eofTtZbA3Tkc6clWM0wjoGD
	J2FuqFUOaxrsG/FXtL0/GpjlmOeycxrQxLKNH6LMuSHHGXIqb1eQMXmFTn024jXXkZ09G1Q501N
	lxIjoeXiP5RI/o1CGdytfW81AW886gDM5zyHlz1cAMia4FrfIRPfP8IywdR9i92w0cFfYpf8tMb
	ovUM0+O7HO67PRnRNpPbrglkGly/k7wamrafrDPHpbsfeC+9gQ32IQ7gHsK7eD3kSpAJEIlzWki
	yUR2gcVtgbk59hiZg8wPVmiYEddZIWnPF/mMo2gadfAKswrCDXpY6aVpfLvZuiqRvlYvwNkFrTr
	0N9sMWqYTCdAWyctbBl28tPGqKX99Bv7mbnSTvwfivNt0badelUtxdS1f5
X-Received: by 2002:a05:620a:4487:b0:915:2b46:eec0 with SMTP id af79cd13be357-9153d9caf6fmr2521977285a.11.1780411715025;
        Tue, 02 Jun 2026 07:48:35 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244de53sm1344015285a.8.2026.06.02.07.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:48:34 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com,
	stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3 v3] libsepol/cil: Add function to check CIL neverallows against binary policy
Date: Tue,  2 Jun 2026 10:48:18 -0400
Message-ID: <20260602144820.147382-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the function cil_check_neverallows_against_pdb() that will extract
the neverallows from a CIL db and check them against a kernel policydb.

Android has the requirement of validating policies from partners
against the standard AOSP assertions. While this is done at build
time, the requirement is also enforced during certification via the
Compatibility Test Suite.

Currently, this validation is done by manually parsing the neverallow
assertions which is brittle and does not support neverallowx assertions.

This function will allow a CIL db with the neverallow and
neverallowxperm rules to be used to check a kernel policydb for
violations as part of the Compatibility Test Suite.

Suggested-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Add more context to commit msg
    Add error messages for when type or class-permission look-ups fail
    Set violation to CIL_FALSE initially to ensure it gets set
    Add more description in cil_binary.h for the function

 libsepol/cil/include/cil/cil.h |  1 +
 libsepol/cil/src/cil_binary.c  | 48 ++++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_binary.h  | 15 +++++++++++
 libsepol/src/libsepol.map.in   |  5 ++++
 4 files changed, 69 insertions(+)

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
index 74ec3cd5..79abef2c 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -5143,6 +5143,54 @@ exit:
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
+	*violation = CIL_FALSE;
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
index e6826221..2bd19102 100644
--- a/libsepol/cil/src/cil_binary.h
+++ b/libsepol/cil/src/cil_binary.h
@@ -36,6 +36,21 @@
 #include "cil_tree.h"
 #include "cil_list.h"
 
+
+/**
+ * Check neverallows from a CIL database against a policy database.
+ *
+ * The types, classes, and permissions used in the CIL neverallow rules must
+ * be declared in the policy database.
+ *
+ * @param[in] db The cil database containing the neverallows to be used.
+ * @param[in] pdb The policy database to be checked for violations.
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
2.54.0

