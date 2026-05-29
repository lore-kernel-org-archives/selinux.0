Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199253AFAEB
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084980; cv=none; b=YfG0LbaWAXGaG31G81HWR2O3Wls3y8w4y+P6pLNwX8JLUe1wvqp+ZCx9+ws/zeYj6wFFz1Tk+EVs8V6/mtoKNckK8wW1qMMDsZmZus44xIWU5WSmGqzy5CDSu62XocrOAsvWnr1CK3GfKbvjmW89JZbjhZN73sP8Z0uDL5N+1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084980; c=relaxed/simple;
	bh=RDHjkOOM9+qnHt+FnYzqMQ80giM7ANrSmlO5Uj2AgpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpOfIKhH/6IVwQxThxZTgysLG277MOjvfUlRyfZ9UIPneOB2wWmB5NoaUKE8mjKd83bqjbX089zJTfpJLh6ovbBV+AVS8E6jZuETyiFqY2TdFBmFK/mUi4cVd0qLd22DKtqbd6+z3hehK19Iq6Dj27fOxQNO/eKs5UYEhjxT79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHvpW1v4; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHvpW1v4"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516de78c4dcso71321651cf.2
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780084978; x=1780689778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDXwUBPR2Ao1yNgqjk1jgMB0aj6eUhqyUXmWnForj+0=;
        b=MHvpW1v407whQfT0ocBtx/Rt7zSmOR9QFS17vgO6MR2d3BWV7j5TPiicyr7Zq+IyTZ
         klbj/RA+lpewDQCbUuNaYTggVejDdUnZyuSKJVuMjR1Q82G9EPJNkwKjkmMu3GHn9SVR
         032aXRaY8+/+yvve53NdGV0cKaCLnrnl8O0OgfvgNA5cGbFAI43T49U0dXYP9VU+iUeK
         Iy6zUjRBJ7NlpdltGvLZFHbsv3VJr0/VsDIR5t3SI1fReVEsiWm3wuxBc6OEZFS9TEyi
         QmpwdS5HTYCg5mxy6pvoqN5w4xtUL9rDcKOY92RxYxKkCA6YBj0GgdrM28oj7r+1p7wz
         cmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084978; x=1780689778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VDXwUBPR2Ao1yNgqjk1jgMB0aj6eUhqyUXmWnForj+0=;
        b=i3UhrnunRlzo5gONRDkjOgQJMAYMc1VkLQUo9HnqWYbz7gm5aeWdIdAHa6CSR0hjrf
         fMnxXzFEAjMAa/2AO2Wj0NIQwNvbO25AsSt0zjvXwGRXy/VUJIjYtT5LwcO5JN8Ny9TF
         Xu2uJPHXfQoT36JmYCbQHEDxLv594f19vbAYDeegVYhZycNr9s1FnOuRziseSfkrnd5e
         n70FtyminYUk8R2pVwvJV7Nn/fsVHtGFyVZplclUBwhg8IYv5KWch2cM4TW9jOc5tc9V
         ZE0+4DVDVltwefXq1s0wRBbGAtA2Nz3CpenDjwM7EGIy/01PKusXTm815ABD3VrVbpiR
         1mjg==
X-Gm-Message-State: AOJu0Yxd5jmXtcdQtFDiHZIz2GL2/Ejg6Sp7eYdstUFBY1fHFlHCXsCq
	7DXym01+wbpy3mKZbG/23cSUQVIoPkxy1VAINpQANkVtjh2X/gYbgWlqewJOKA==
X-Gm-Gg: Acq92OF3uMjL+PiZ08m/p+X0N952hDnVHBTaH6W1+AhN32otoqjqL17C6D2xyjLFs2f
	eS8KIzNe+S32I+KiWymYtQCEmnT/LPxchuFSiuT5Xm9S1+DHA7ht1b7csB+ZCAPIhF/uUtVa69d
	k03oa4uEDuq0QdqxhV0aSnpupYSO/EtSQ9nxLbl9636rYpJpJeJZ8rdfZa1gKfd0aXzdqetnsU/
	ImUR9CP/q4NAhaqi5WPxtqFCO4T3n9q5AFXOx77Dnzz/ay6/451+GyD5ddVBwhXf1MvXsO3ydic
	pDh0Dqs8ZISG8yPeC5M9/LCuYqWi8r4kF0EfcfIn8UI+xZd+2uqKetNxJ5wh/RXnAQfyYR2f25r
	/itNwECC95fC8MoUN50jfhRQr2rS7g7u8ThU+UIz31VVlLnTmTWvOkfXK5l4yIMbCvEWgcw0GFo
	v0zYa4Z7/wVl3E1EDvlo9bW0IQ/INaL6ZCmZeCoVmraTX8+REQx5Zj0txx
X-Received: by 2002:a05:622a:14d1:b0:516:f4ef:5d8 with SMTP id d75a77b69052e-5173a869fd4mr14158021cf.58.1780084978126;
        Fri, 29 May 2026 13:02:58 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5172eb28540sm30242741cf.18.2026.05.29.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:02:57 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3 v2] libsepol: Add a function to output CIL declarations from a binary policy
Date: Fri, 29 May 2026 16:02:43 -0400
Message-ID: <20260529200244.65895-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529200244.65895-1-jwcart2@gmail.com>
References: <20260529200244.65895-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the function sepol_kernel_policydb_decls_to_cil() that takes a
binary policy as input and outputs the declarations in CIL format.

Also split out some of the common functionality into static functions
to reduce the amount of code duplication.

In the near-term this will be used get the declarations from a
policydb so they can be used along with neverallows written in CIL
to check for neverallow and neverallowx violations in the binary policy.

Suggested-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Added more explanation to the commit msg
    Split out common functionality

 libsepol/include/sepol/kernel_to_cil.h |   3 +-
 libsepol/src/kernel_to_cil.c           | 152 +++++++++++++++++--------
 libsepol/src/kernel_to_common.c        |  26 +++++
 libsepol/src/kernel_to_common.h        |   2 +
 libsepol/src/kernel_to_conf.c          |  29 +----
 libsepol/src/libsepol.map.in           |   1 +
 6 files changed, 141 insertions(+), 72 deletions(-)

diff --git a/libsepol/include/sepol/kernel_to_cil.h b/libsepol/include/sepol/kernel_to_cil.h
index 60346ad1..1db0383a 100644
--- a/libsepol/include/sepol/kernel_to_cil.h
+++ b/libsepol/include/sepol/kernel_to_cil.h
@@ -2,4 +2,5 @@
 
 #include <sepol/policydb/policydb.h>
 
-int sepol_kernel_policydb_to_cil(FILE *fp, struct policydb *pdb);
+int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb);
+int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb);
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 49040ae4..cd69913b 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -3254,142 +3254,157 @@ exit:
 	return rc;
 }
 
-int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
+static int write_base_decls_to_cil(FILE *out, struct policydb *pdb)
 {
-	struct strs *mls_constraints = NULL;
-	struct strs *non_mls_constraints = NULL;
-	struct strs *mls_validatetrans = NULL;
-	struct strs *non_mls_validatetrans = NULL;
-	int rc = 0;
+	int rc;
 
-	rc = strs_init(&mls_constraints, 32);
+	rc = write_sid_decl_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = strs_init(&non_mls_constraints, 32);
+	rc = write_class_decl_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = strs_init(&mls_validatetrans, 32);
+	rc = write_mls_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = strs_init(&non_mls_validatetrans, 32);
+exit:
+	return rc;
+}
+
+static int write_type_decls_to_cil(FILE *out, struct policydb *pdb)
+{
+	int rc;
+
+	rc = write_type_decl_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	if (pdb == NULL) {
-		ERR(NULL, "No policy");
-		rc = -1;
+	rc = write_type_alias_rules_to_cil(out, pdb);
+	if (rc != 0) {
 		goto exit;
 	}
 
-	if (pdb->policy_type != SEPOL_POLICY_KERN) {
-		ERR(NULL, "Policy is not a kernel policy");
-		rc = -1;
+	rc = write_type_attributes_to_cil(out, pdb);
+	if (rc != 0) {
 		goto exit;
 	}
 
-	if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
-		/*
-		 * For policy versions between 20 and 23, attributes exist in the policy,
-		 * but only in the type_attr_map. This means that there are gaps in both
-		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
-		 * can refer to those gaps.
-		 */
-		ERR(NULL, "Writing policy versions between 20 and 23 as CIL is not supported");
-		rc = -1;
+	rc = write_type_attribute_sets_to_cil(out, pdb);
+	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
+	rc = write_type_bounds_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = validatetrans_rules_to_strs(pdb, mls_validatetrans, non_mls_validatetrans);
+	rc = write_type_permissive_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_handle_unknown_to_cil(out, pdb);
+	rc = write_type_neveraudit_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_class_decl_rules_to_cil(out, pdb);
+exit:
+	return rc;
+}
+
+static int write_role_decls_to_cil(FILE *out, struct policydb *pdb)
+{
+	int rc;
+
+	rc = write_role_decl_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_sid_decl_rules_to_cil(out, pdb);
+	rc = write_role_attributes_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_default_rules_to_cil(out, pdb);
+exit:
+	return rc;
+}
+
+int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
+{
+	struct strs *mls_constraints = NULL;
+	struct strs *non_mls_constraints = NULL;
+	struct strs *mls_validatetrans = NULL;
+	struct strs *non_mls_validatetrans = NULL;
+	int rc = 0;
+
+	rc = check_for_supported_policy(pdb);
 	if (rc != 0) {
-		goto exit;
+		return rc;
 	}
 
-	rc = write_mls_rules_to_cil(out, pdb);
+	rc = strs_init(&mls_constraints, 32);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	strs_write_each(mls_constraints, out);
-	strs_write_each(mls_validatetrans, out);
-
-	rc = write_polcap_rules_to_cil(out, pdb);
+	rc = strs_init(&non_mls_constraints, 32);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_type_attributes_to_cil(out, pdb);
+	rc = strs_init(&mls_validatetrans, 32);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_role_attributes_to_cil(out, pdb);
+	rc = strs_init(&non_mls_validatetrans, 32);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_boolean_decl_rules_to_cil(out, pdb);
+	rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_type_decl_rules_to_cil(out, pdb);
+	rc = validatetrans_rules_to_strs(pdb, mls_validatetrans, non_mls_validatetrans);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_type_alias_rules_to_cil(out, pdb);
+	rc = write_handle_unknown_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_type_bounds_rules_to_cil(out, pdb);
+	rc = write_polcap_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_type_attribute_sets_to_cil(out, pdb);
+	rc = write_base_decls_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_type_permissive_rules_to_cil(out, pdb);
+	rc = write_default_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_type_neveraudit_rules_to_cil(out, pdb);
+	strs_write_each(mls_constraints, out);
+	strs_write_each(mls_validatetrans, out);
+
+	rc = write_type_decls_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -3411,12 +3426,17 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 		}
 	}
 
+	rc = write_boolean_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = write_cond_nodes_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	rc = write_role_decl_rules_to_cil(out, pdb);
+	rc = write_role_decls_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -3533,3 +3553,41 @@ exit:
 
 	return rc;
 }
+
+int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb)
+{
+	int rc = 0;
+
+	rc = check_for_supported_policy(pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_base_decls_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_boolean_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_decls_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_role_decls_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_user_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+exit:
+	return 0;
+}
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 99e46865..b267b5d7 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -751,3 +751,29 @@ exit:
 
 	return rc;
 }
+
+int check_for_supported_policy(struct policydb *pdb)
+{
+	if (pdb == NULL) {
+		ERR(NULL, "No policy");
+		return -1;
+	}
+
+	if (pdb->policy_type != SEPOL_POLICY_KERN) {
+		ERR(NULL, "Policy is not a kernel policy");
+		return -1;
+	}
+
+	if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+		/*
+		 * For policy versions between 20 and 23, attributes exist in the policy,
+		 * but only in the type_attr_map. This means that there are gaps in both
+		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
+		 * can refer to those gaps.
+		 */
+		ERR(NULL, "Writing out CIL or policy.conf from policy versions between 20 and 23 is not supported");
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index d3283658..53f398b7 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -117,3 +117,5 @@ int strs_stack_empty(const struct strs *stack);
 
 struct strs *isids_to_strs(const char *const *sid_to_str, unsigned num_sids, struct ocontext *isids);
 int sort_ocontexts(struct policydb *pdb);
+
+int check_for_supported_policy(struct policydb *pdb);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index a8126d58..628a792e 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -3116,6 +3116,11 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 	struct strs *non_mls_validatetrans = NULL;
 	int rc = 0;
 
+	rc = check_for_supported_policy(pdb);
+	if (rc != 0) {
+		return rc;
+	}
+
 	rc = strs_init(&mls_constraints, 32);
 	if (rc != 0) {
 		goto exit;
@@ -3136,30 +3141,6 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
-	if (pdb == NULL) {
-		ERR(NULL, "No policy");
-		rc = -1;
-		goto exit;
-	}
-
-	if (pdb->policy_type != SEPOL_POLICY_KERN) {
-		ERR(NULL, "Policy is not a kernel policy");
-		rc = -1;
-		goto exit;
-	}
-
-	if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
-		/*
-		 * For policy versions between 20 and 23, attributes exist in the policy,
-		 * but only in the type_attr_map. This means that there are gaps in both
-		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
-		 * can refer to those gaps.
-		 */
-		ERR(NULL, "Writing policy versions between 20 and 23 as a policy.conf is not supported");
-		rc = -1;
-		goto exit;
-	}
-
 	rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
 	if (rc != 0) {
 		goto exit;
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 2b103993..8785cff1 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -297,5 +297,6 @@ LIBSEPOL_3.6 {
 
 LIBSEPOL_3.11 {
   global:
+	sepol_kernel_policydb_decls_to_cil;
 	cil_check_neverallows_against_pdb;
 } LIBSEPOL_3.6;
-- 
2.54.0

