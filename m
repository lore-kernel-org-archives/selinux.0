Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9F3E5A2E
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414408; cv=none; b=sa9vDrT/limWATWqHZO1relV/iRh54nJkcIsm9q7j03YzK+AJ6kC1O/UjgJIY8vQqxzVE5eI4KKKoHVfKtScdRkw2iIuH8BZPoaUm4dogX52LYwQk12rq2MsIRbmA1tNEAIcCQQWOUlBuOC6hXfjEG5G9VXRDl267iRNeHMHoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414408; c=relaxed/simple;
	bh=xM5+LXK6USq2YWuyn/geyAE1S2tTwLMom8Tx0CPIwb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y2mH17Oiufhp3Mw7TR4XSV+yvQN87rJNXssGg3GopLeRUO4EOzM/kD3aFs9u0Vuu8bzWKcOO4hCaNMnrxAYx0IR8DrJQFR0d39LlsX/7KZxN2X4GkGJFGeM2AjGal9bYdesxJHTlD3pXHeYIRfhW7QhdjXc/7ewRikZOkVeHr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKySc+dU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKySc+dU"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91550dda53cso396341185a.1
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780414406; x=1781019206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVfLQJezzu8Yv+EQebW82pmcgHzyHoKq/BsxE7jH5Fs=;
        b=GKySc+dUVhp02la8s2UQbA9TjsSxJsldbztVdCfeqMI6RJSaLx7dw9OXmQrvzTxWcm
         REToN2hfNLDw862rOPQnOBs0b+69yGI4jGvS1egLLANPP4Nb//l1T7Kbsu3gWzlTFbUg
         28DYHesP96lLU+rAIqgVFq5hG0XiOTCSMCFrmmg7CzexiHxCPxTESBGPkyT4ZzNVOcTN
         r6kmabi9wFr5NgKZMEPdoW63iY3TGY9VzfzmiB0V4UQTEOcwjhIY8SK5dIwr8d8zz6b4
         hZr5OZoaQTy0hFj01vzZdVXKXK/s86Rz00d6ymWOHp+Qmu5P49ldjGRzBGxB+EwuMoJy
         MSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414406; x=1781019206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVfLQJezzu8Yv+EQebW82pmcgHzyHoKq/BsxE7jH5Fs=;
        b=s56fwvKNHmevLKg9aroSVDQhBjv0TaXqKs3+m326QSCibZO8QvtZLNUMKY3WDeUbfa
         QG425nQ+x5S+9GUQXJeiTikDwIyv1nL/8eWzl2ptbR/9fMX+XXGKOHxEUYeoWGfmJORN
         3Oy96goM9O7lK4C+WSD+C9YYGFqEJOffr1NSX0cCJL+jPsqkZipjCWjB7fXzntoTlZkI
         rN1ZOZR+fb9fgp0Kpx4hWS9KTcUrwqrAJ51iwYdwRNIeeZS1wrKHjBo2h7SLyMri2R+q
         mNYkDbdllFcCeGhc82bvp8qirvAqGsNCL5Fcoc0jCaExo2mbBialBwTvNphOv+YdcGaC
         Q5AQ==
X-Gm-Message-State: AOJu0YyUGY6BnjgKTic7mSQ/LtGcOrpxRVjCzxwAGJ8yxUiF4TZObzTS
	wSOH12TdLDPBThzAhjCcfHYInyU9pMt/PQ2MKBmwoBZ96bNh8Hw9i5LEHDIwFg==
X-Gm-Gg: Acq92OEeCtSmSrwnXowGTZY4j9ClNM4KULbQDp58FfdtsyBDVDGfdru7iakc8k66PQO
	howOoobyVKvVTgABnmpqaVbewWUZDLUgG9o8wQZoi+cYzFJewZkBur+YsUrnNn/8uFNfUmuK2n5
	aWb/8k5E1StYqlOr0DvW1hhb/VK7eViBoaIpHKqRyLEJd2SS1NyzQc3MPTrJUhOPWNG3jPeSdtt
	zqlMRsz0zy9dBphbgd7oi1YfHfGnKLV0NaxPPBAL8/aO4+CAVvhHph/3FAZFDvzrV6kYqvgOxPk
	UE6YpOIUwg/mOEjc2Ya2r1ju6WCU6Kuutoc+4lwuwOQiy+6h3+kQVHCFs0LbwjgKsa3ZGEt7urG
	QIFigOudMDaIAgm8bOG9/Fi7TYDqfkG0IKXpV+Be/uDop1PzYpFZIMvzUJR0i7Wy8SsBNlvcOXi
	fPix2IFPPItn1upBG/hvbvNMS/6Vmed7ZnuElPGsXdeT9f+P/TjA8lhF2R
X-Received: by 2002:a05:620a:27cf:b0:915:6cf9:5630 with SMTP id af79cd13be357-9156cf956aamr924104485a.34.1780414406107;
        Tue, 02 Jun 2026 08:33:26 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91586c6aabesm64888385a.40.2026.06.02.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:33:25 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com,
	stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3 v4] libsepol/cil: Add function to check CIL neverallows against binary policy
Date: Tue,  2 Jun 2026 11:33:07 -0400
Message-ID: <20260602153309.157348-1-jwcart2@gmail.com>
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
index dca1937a..4e9b0227 100644
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

