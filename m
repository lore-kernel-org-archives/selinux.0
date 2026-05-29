Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F63016E9
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084979; cv=none; b=pc/8SLKGZJ9izDwu5Tmm65ccVxVlY0FbjMzDCgXxoaB10PmpgNQMrwEvIeRqG0+f541jghWThSxAHDuxS/UU5NAHZpHSM66AoqJx+P4awXxHhhDWZJMP1YLbtPmfhvsxIzzNmBWiZPvHoT4cVnbKCMiWdK/02KWioRnmnVNKrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084979; c=relaxed/simple;
	bh=g4GiaiLgCQyuLDgiCXee8+tzplIWVVz75DgP6PBu2bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q7tuZfHJnenjLXmwLGT2YQxFH/wOwOhSLdvq3HLQkSzPVJWzVA5hG+kGSgbKAYfkp9cgfGsZVVKd3XBKyQG3KyYzOcc5cQWwEkEngIInS4psoR5skp555+UnXiC6P+OX2tvyXNdLhZBx3edA2/yibOAJ5Oc6+taYx6nzEwhn8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2vIDxkC; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2vIDxkC"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516cc5471bdso116802861cf.2
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780084977; x=1780689777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JP5zbFkLxC21cpPTE322NnjlVxp2m7RWG4lcO4Wu/o=;
        b=N2vIDxkChwkDquqKHq2cOD2rmbAsFRhwp9uORccuPae5tuaxgAGOXRVudQEChFCIhq
         e6c094ohFJs7mo2fl1XaFlP1QONEqhr/Z0o7JkzBJK7NqQIa1eGuG76afciwabK5B6dX
         /+XA2yPv/YQnEH4EyIfVJlW9ezbuPxxZzyKvOV52YANHJogzwuWORUhj4A2ZZmOe1dEX
         TXQh9d932HIWFuHRPnHhgVCvkCuZFbTA0+FnaDGQRtcfYwblzpgF1INtaN3JZbXnNEMS
         I96rI3v3bSTFEDmCcV8SwEX5MdebbDsJU2LsLIQMZe2SeikCtH/ZgjwUhHZbLBWt05+o
         g5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084977; x=1780689777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JP5zbFkLxC21cpPTE322NnjlVxp2m7RWG4lcO4Wu/o=;
        b=RcLKFXl8B1nd532UxfYq3h/UEGvM5uOLSn6SlCFZtdev+jjRO558t+ElgZRAkxuMsF
         RORMY1DTcw9EOSDFPDVon+U8N/L9p7+SIy5fArG9mMwdUakY1YwA2yl4/+MVBnrIIQT2
         SMnvYx4CsIQO7BdxqHRwN9rZbOtCY+PHjP9rBPoMip6lYc5knbaej1jjWEFD9imfV48w
         uZ4eJn0WJ67065j33IYf5AnxTYzsYhw2XvAiYuGkE+wCLyYCg8S8GkWLZEo0Y5Bl55WH
         fletUhlWNNh4HKHWpQLbDIIpaPH2gJkkLfmn8qnL7AnVZDH3Nws7791fbMONKZPpCQ74
         A1cA==
X-Gm-Message-State: AOJu0YznbOqf8bRrZNVWyOHLB47dim8dIurV2iOaAk7Jyd8d0uEsf1O4
	dOZQihKIovnVnNi+aLLjf4BmxprgJc6rdqTw/JKwSHdgYhQGHBNcjGFYFaYblw==
X-Gm-Gg: Acq92OG2PdDR4p69gkmNFdbjaetPEAZdvovsAiD6Na8x2aoDpvTb6Dcv/60iPowtlJW
	mjOqB0Akl12YV4CfON6Sp5jscnaki9x+b5yfr8Kj3f44vADUN4Z7oty+tzR2gLAyoOqC40ON7Iy
	yf2aUns0WHDKy41ceEq8FnElITU8BjM2QQQIRCqvzCq8PiBuL27vJ4FtBrghAeMimop3LDLTtli
	PEJe/nMPIm+aTUnbjm4+shtCG5A9v9LsCxxNxLmhXgNpC+2SFVojH9vKZ3dBs91cMiWy8f/VUqF
	W2JGkyGVnrPZb27PhHnmauDvcvq4NCdKfBsoBrBfaIPC7m94/BzgoRD8QPvJ8iiUj2edfm2eA51
	MYZIa/NZNaZ9PVhwJEahClqhtB5QU0nL0FyAEf6PGLmEjRXqlZ/JO9sToA0aKWAyHMHz5qL7nxD
	M3RyPSa5rzOUgXZUBHFxHKQXxtrYFzZKjperht5i1AhtyYwCY9Muvlh8gP
X-Received: by 2002:a05:622a:2cf:b0:50f:c5d3:a18c with SMTP id d75a77b69052e-5173a73d2fcmr14163531cf.20.1780084977337;
        Fri, 29 May 2026 13:02:57 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5172eb28540sm30242741cf.18.2026.05.29.13.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:02:56 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3 v2] libsepol/cil: Add function to check CIL neverallows against binary policy
Date: Fri, 29 May 2026 16:02:42 -0400
Message-ID: <20260529200244.65895-1-jwcart2@gmail.com>
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

