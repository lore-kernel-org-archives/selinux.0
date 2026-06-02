Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE73630B3
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414409; cv=none; b=a5/02ZBgQJYxQs8P7ANO8fWV2SM+B1NoSRSiM4v+fggfMtxhHKTAKHEwxCWiS/PottxG1RoPPNoiNKghfn+LOtnFleYfpLuaiKcSRI5shz83fuQvSEccdhxjb9LkMZbTH8x0d3hMPXMVEbt3ag9JKggQwJq65LnDi8tyXMUoYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414409; c=relaxed/simple;
	bh=UvzII7hktDTP/9e6kwjdd6ODOToQ1+NQrKjNvcSEg3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQ8vSC2QpfD+Hth2aFsFQtluhCTDPA06N2ZlOAwv1+dVhLUhYVsaV4cbJCDM7U7oEeTXy/UB0SdAGzq0XK/z0ybHqWF0l3KoAYylxozs146NgMMnXp17A4wv6tFvcClvhrlm9JGLmC7klKanIDkTpCGRZ8BhbfVetyCFqnJl6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCrWplrX; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCrWplrX"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91541fa94aaso378924285a.2
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780414407; x=1781019207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdgX0yyG2f6Tv7Z4Ck3K5QIHIj/aIFS59kNkriXb8C8=;
        b=cCrWplrXYsmOYbFCcFb/A4pxXNBKzb5qBf85LbwTzxIdPcdz0CsEdSdDnx1KIT3e+W
         lEutEs3JddzRlokahJQaCWNx+pYAB9na8loYNas3SPcuagwtk1Z6TEDjyTI4a7rdiePb
         ijdf2X5vRbDSWgeegiUvLuPifXEQGacmWTGYmtzkz9igyLiuk2P0Hpl1ZdSI3ELmWVsL
         K1f7ZqAfx/V0VaNFXW0mZe4108ZJJPaslRrkYBK/bM0SiJoOwTUYQIIbNsd8Czm3tu34
         0OFnc17qGsie9hJFP1rQM5PTnTKDNPbX8A5n5LcOnRuPOAfy1hjLQK1Tc3bZj7ALGvNE
         cG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414407; x=1781019207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdgX0yyG2f6Tv7Z4Ck3K5QIHIj/aIFS59kNkriXb8C8=;
        b=FffrNvdKAZN0VwYapgS+in6eRqaYIAzOZ/IGak5OH5G5hjGveQdDAe+PjhraLfhRSD
         uBhAO6lIYFbk/+WpLIfmVJrz9sd5/YfHhyIBgBZJBlPZJI+2WoDrigJdnEhNP2J+qEER
         lV9Aizk59p75V97V4oIz5tpBaQgasBAel59qK6I3EIIzki44zQHBo/ZEcBtIsN3S3EIw
         pUg6ozLayDhE/rltyidXPW0ti/nlzehLhFpApjyWhYZ2TDLAQ40fRztgjBfBZ23tMhfH
         aTlduaT0wthQLv+30lfVtpWSecNpZf1SRyDs8+W2VebJbvQ4Un4fSnitoEHKF8OxWE52
         gQyQ==
X-Gm-Message-State: AOJu0YygEFiYoQltI1WXfulCQmQFkBqWaTEnICRU0pJYY0HTKY2yF97J
	fstFnCdX9vU5gLgx8s2RApwZlxgAo/XlcDQa2Fs7+BxOdcjU+AW61UZNxD156Q==
X-Gm-Gg: Acq92OENyzuHLmWXuWhfmoOt98eC/mAIfz0sKccEvFUNScInzw0pkuAlyCAQYvf78ux
	+2i0xVjxAGvMWeyBAFSk/d6lwQzY6SBV1/tWJVvGCay/WTKCO+uuaNgSDk4iAkuLTNRA3rBDrz8
	JKMiqNMaEhKVjHsnEW0MYKNRSSLdz1o2uJfmAdNr0AMPbngydqEFha5FKNlU0ld7YEATwfguSdO
	3HqcHW6D/EFcwUai+wexrQmyIzq3s3f2ouIVQ/cSqo77tOl6JrP96LCFvTfx8eI7weJ4Hb3e6bT
	76vaqxONA9b9jGAHHTIFJXff89b3lgFl4TnegcAE0mTDLgX1PRKO5F+kFgz6Xmm73nLU3upMhC0
	pT7R0crvTX49x2h6uHkI/n48XpziuMQX7jVdTbddsOCbp3TS4aZJG2Ow2xmyziSKVMOpjPuXn9t
	E5BVe6WaFg1If6FoGx7L4nbzwjW/V0wDpbWwzG8CdmeYhVZ3FYxU5IMq52
X-Received: by 2002:a05:620a:f0f:b0:914:c8aa:34ea with SMTP id af79cd13be357-9153db6a056mr2601693685a.56.1780414407097;
        Tue, 02 Jun 2026 08:33:27 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91586c6aabesm64888385a.40.2026.06.02.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:33:26 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com,
	stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3 v4] libsepol: Add a function to output CIL declarations from a binary policy
Date: Tue,  2 Jun 2026 11:33:08 -0400
Message-ID: <20260602153309.157348-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602153309.157348-1-jwcart2@gmail.com>
References: <20260602153309.157348-1-jwcart2@gmail.com>
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

Also move the checks for a supported policy to a new common function
and use that function in kernel_to_conf and kernel_to_cil.

In the near-term this will be used get the declarations from a
policydb so they can be used along with neverallows written in CIL
to check for neverallow and neverallowx violations in the binary policy.

Suggested-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v4: Don't delete the Python swig exception stuff like an idiot
v3: Split out less common functionality to keep the same order for the rules
    to prevent breaking existing tests (even though CIL is not dependent on
    order.)
v2: Added more explanation to the commit msg
    Split out common functionality
 libsepol/include/sepol/kernel_to_cil.h |  3 +-
 libsepol/src/kernel_to_cil.c           | 97 +++++++++++++++++++-------
 libsepol/src/kernel_to_common.c        | 26 +++++++
 libsepol/src/kernel_to_common.h        |  2 +
 libsepol/src/kernel_to_conf.c          | 29 ++------
 libsepol/src/libsepol.map.in           |  1 +
 6 files changed, 109 insertions(+), 49 deletions(-)

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
index 49040ae4..db63ac3f 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -3262,6 +3262,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
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
@@ -3282,30 +3287,6 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
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
-		ERR(NULL, "Writing policy versions between 20 and 23 as CIL is not supported");
-		rc = -1;
-		goto exit;
-	}
-
 	rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
 	if (rc != 0) {
 		goto exit;
@@ -3533,3 +3514,71 @@ exit:
 
 	return rc;
 }
+
+int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb)
+{
+	int rc = 0;
+
+	rc = check_for_supported_policy(pdb);
+	if (rc != 0) {
+		return rc;
+	}
+
+	rc = write_sid_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_class_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_mls_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_boolean_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_alias_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_attributes_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_type_attribute_sets_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_role_decl_rules_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_role_attributes_to_cil(out, pdb);
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
+	return rc;
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

