Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6152652A2
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451856; cv=none; b=pTfnJnEaqmTgpX3F3CIUvok1lO+ujy4ybeFESf3weLQRjCNPR8N3Sa+TLvxFefq2YvsFkrcFf8hAhcUH0OQSWu67uMMyOlDGCC5ehtC81e4WN0ty976GEocCICHMy9XZ1SoczLE1MoT09VGo1Bxh155oDHJwmjVYlaLC+qpB6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451856; c=relaxed/simple;
	bh=1PS0iQXrm3p9BlcQs5/f29H4h+fV/LMRJvgIEeYj8t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNoG1Nx+G+QzFfYguEueyUROTmjmy+QsEhi3YI5Oi7A4j9J3yzzIFz4fUUSMvSJFLyyWldM0IBGqXj2smqOFOLrYYk9SPkkSNq1pBwHAGXWi6+JypDEg71T03nJUdG9/2El5i5mQBYpCDW0CAWhM2WBnqT5z77P2mMg7lpFMB9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtMqmcFY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtMqmcFY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2cce930cso28160531cf.0
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786451853; x=1787056653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lyVpozWkEOXNfUn16tn5cuVGFy0gHQcsT3kA09fiINA=;
        b=EtMqmcFYhFpEGKmZAxG3jd7G+B3WaqT8X9WOKOllloiY/AkLF2kvZuJsDueGE+tvIs
         5LDbOua6eUcnihsIWInMJ6n6kQlpjHkttlojCCYZ1fj1P9U0M8/smDfnZobyODD7GlED
         nrNWnzVHrW6JkBQZgty1Gm6t8yD1qVXG62eJAeeCHasU9+s+VyowKEDhDIwbhnkAno4U
         zEPhvMupdWNcAUmlCpK2tcEBanQ4weoeOriLMmRUqQx0hySjbdZlJseIJX/516pWx4W4
         JG+sqxZdBcylgXv40KRpIRx3yXZJnhs6eraKFmsiskf6RuIIx4xnwLnLrd+sGgjWbi5o
         wQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786451853; x=1787056653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyVpozWkEOXNfUn16tn5cuVGFy0gHQcsT3kA09fiINA=;
        b=nDo25pHnGY3MfBHN4l3RgNl+xpWizC7vuBfWQt9VO1qRXvsearbe2pWP56ifVxxxPf
         7WIbAN+YGOrYuuVmqJO1OnUgWZ/rOPXk6oSK0vw5L40xhA7woCEU83/gyPFoqgkfablX
         EPCdQuJS3OW/Nvcf3y+zY0VU99oQNTO1rBxiSUiGwb1uBtzAUra+qgGKkQqeRjPLTPBx
         Q06vPON8mlpHAMKc4mFpA4yekZ9EIijNbqiXO1+G6DiQvgbZHKFWlvW3oc7KAboK1/zB
         rct9ujPza7vW9hp6XV+4wEtrVj6esFOsrHJlQd4J6JHUj0x8iI0Ooew4EW7Oc1pKW2/F
         MR8w==
X-Gm-Message-State: AOJu0YxQgijuplK7gr5xEEiz3zCgNNpkthTzkIwjgT7licRiYkKzxO+X
	DEEfP3F58deGMJ9QayhXg4tiH08GEQVDPRi1FOMLFWDkd+sna7DpJ1Q85H7xZw==
X-Gm-Gg: AR+sD13MXm8RVrEXFfd4vOJvTCrDHdWeP1v6fl0ODbalxyPLM/fE6CWcPjPvC0Bhp7V
	t1Kl3GbrxeLXWWLChD65ZtSVUqSqZnZm1AGSFtJAaUd8E00jfGeTCu42QQ1Ig8dRjudbPU0O7CM
	xqQjd8xtfZM0BPEFwqw92ew5PK4GQP/PStJw9VtIdDgazmmXE9XVShkVmexiP/Q8J5xCwwl05xs
	aZu0iXK3VkzUJyJE1L4RSQaBB71oYOl9SeNXDCizl1J6Ury9lm0i+kU2E/gi1ZUZCQd6IC0JrTu
	xnXKChgBlmYN1fnujct5moA3yqRWV5DwrNeExzcFh+8cXc85FYGW8Rdnt3Ut089d9vkxJlOsg88
	jhZ+CCobLLiYIt1qqao215s8KskeZVsqDo1K3zn2q2LjcF18ZcmWcJuxCeV5bi54U09eYIV2l9+
	TYUSCEYiYkY5k8FfQOZTRGAKpzE+io3oRb4DzXKDdTiDEQ2zy2ue4WZ5/UE/pnUNlGwsKD6j4xR
	rXpUSr3Q2CsT4Nb15B4bFx9XaF5yrQKhDI9eAdf7U659N2kVqLTFArsjzrBqTFE
X-Received: by 2002:a05:622a:2307:b0:51a:6feb:dc8f with SMTP id d75a77b69052e-52d58495a44mr24921311cf.9.1786451852993;
        Tue, 11 Aug 2026 05:37:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d57c6637asm10318481cf.30.2026.08.11.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:37:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: drop support for modular policy versions < 10
Date: Tue, 11 Aug 2026 08:37:12 -0400
Message-ID: <20260811123712.84028-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop support for modular policy versions < 10 (boundary alias, a bug
fix to the original boundary format in modular policy) to mirror what
was already done for the kernel policy versions. This brings a
consistent baseline across supported kernel and modular policy
versions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md                                  |   8 +-
 libsepol/include/sepol/policydb/policydb.h |  16 +-
 libsepol/src/policydb.c                    | 209 ++++-----------------
 libsepol/src/policydb_validate.c           |   2 -
 libsepol/src/write.c                       | 115 +++---------
 5 files changed, 74 insertions(+), 276 deletions(-)

diff --git a/README.md b/README.md
index f7e6f562..f256912c 100644
--- a/README.md
+++ b/README.md
@@ -31,8 +31,12 @@ Minimum Supported Policy Version
 --------------------------------
 Kernel policy version 24 (boundary) for the SELinux and Xen
 targets. Support for this policy version first shipped in Linux
-v2.6.28 and Xen 4.0.0. libsepol dropped support for policy versions
-older than 24 starting with libsepol 3.12.
+v2.6.28 and Xen 4.0.0. libsepol dropped support for kernel policy
+versions older than 24 starting with libsepol 3.12.
+
+Modular policy version 10 (boundary alias). Support for this modular
+policy version first shipped in libsepol 2.0.35. libsepol dropped
+support for modular policies older than 10 starting with libsepol 3.12
 
 Installation
 ------------
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 985a496e..9443aec6 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -770,14 +770,6 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_MAX POLICYDB_VERSION_NEVERAUDIT
 
 /* Module versions and specific changes*/
-#define MOD_POLICYDB_VERSION_BASE 4
-#define MOD_POLICYDB_VERSION_VALIDATETRANS 5
-#define MOD_POLICYDB_VERSION_MLS 5
-#define MOD_POLICYDB_VERSION_RANGETRANS 6
-#define MOD_POLICYDB_VERSION_MLS_USERS 6
-#define MOD_POLICYDB_VERSION_POLCAP 7
-#define MOD_POLICYDB_VERSION_PERMISSIVE 8
-#define MOD_POLICYDB_VERSION_BOUNDARY 9
 #define MOD_POLICYDB_VERSION_BOUNDARY_ALIAS 10
 #define MOD_POLICYDB_VERSION_FILENAME_TRANS 11
 #define MOD_POLICYDB_VERSION_ROLETRANS 12
@@ -794,7 +786,7 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_NEVERAUDIT 23
 #define MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS 24
 
-#define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
+#define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BOUNDARY_ALIAS
 #define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS
 
 #define POLICYDB_CONFIG_MLS 1
@@ -803,12 +795,6 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 
 /* TODO: add other features here */
 
-#define policydb_has_boundary_feature(p)                   \
-	(((p)->policy_type == POLICY_KERN &&               \
-	  (p)->policyvers >= POLICYDB_VERSION_BOUNDARY) || \
-	 ((p)->policy_type != POLICY_KERN &&               \
-	  (p)->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY))
-
 #define policydb_has_cond_xperms_feature(p)                   \
 	(((p)->policy_type == POLICY_KERN &&                  \
 	  (p)->policyvers >= POLICYDB_VERSION_COND_XPERMS) || \
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 84b7ac1e..3dd3ac4f 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -160,48 +160,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.ocon_num = OCON_IBENDPORT + 1,
 		.target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_BASE,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_MLS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_MLS_USERS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_POLCAP,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_PERMISSIVE,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_BOUNDARY,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 		.type = POLICY_BASE,
 		.version = MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
@@ -307,48 +265,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.ocon_num = OCON_IBENDPORT + 1,
 		.target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_BASE,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_MLS,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_MLS_USERS,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_POLCAP,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_PERMISSIVE,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_BOUNDARY,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 		.type = POLICY_MOD,
 		.version = MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
@@ -2026,8 +1942,7 @@ static int context_read_and_validate(context_struct_t *c, policydb_t *p,
 	c->role = le32_to_cpu(buf[1]);
 	c->type = le32_to_cpu(buf[2]);
 	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policy_type == POLICY_BASE &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
+	    (p->policy_type == POLICY_BASE)) {
 		if (mls_read_range_helper(&c->range, fp)) {
 			ERR(fp->handle, "error reading MLS range "
 					"of context");
@@ -2285,8 +2200,7 @@ static int class_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 		goto bad;
 
 	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policy_type == POLICY_BASE &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_VALIDATETRANS)) {
+	    (p->policy_type == POLICY_BASE)) {
 		/* grab the validatetrans rules */
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
@@ -2334,16 +2248,13 @@ static int role_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 	role_datum_t *role;
 	uint32_t buf[3];
 	size_t len;
-	int rc, to_read = 2;
+	int rc;
 
 	role = calloc(1, sizeof(role_datum_t));
 	if (!role)
 		return -1;
 
-	if (policydb_has_boundary_feature(p))
-		to_read = 3;
-
-	rc = next_entry(buf, fp, sizeof(uint32_t) * to_read);
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
 	if (rc < 0)
 		goto bad;
 
@@ -2353,8 +2264,7 @@ static int role_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 		goto bad;
 
 	role->s.value = le32_to_cpu(buf[1]);
-	if (policydb_has_boundary_feature(p))
-		role->bounds = le32_to_cpu(buf[2]);
+	role->bounds = le32_to_cpu(buf[2]);
 
 	if (ebitmap_read(&role->dominates, fp))
 		goto bad;
@@ -2413,15 +2323,7 @@ static int type_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 	if (!typdatum)
 		return -1;
 
-	if (policydb_has_boundary_feature(p)) {
-		if (p->policy_type != POLICY_KERN &&
-		    p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY_ALIAS)
-			to_read = 5;
-		else
-			to_read = 4;
-	} else if (p->policy_type == POLICY_KERN)
-		to_read = 3;
-	else if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
+	if (p->policy_type != POLICY_KERN)
 		to_read = 5;
 	else
 		to_read = 4;
@@ -2432,42 +2334,32 @@ static int type_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 
 	len = le32_to_cpu(buf[pos]);
 	typdatum->s.value = le32_to_cpu(buf[++pos]);
-	if (policydb_has_boundary_feature(p)) {
-		uint32_t properties;
+	uint32_t properties;
 
-		if (p->policy_type != POLICY_KERN &&
-		    p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY_ALIAS) {
-			typdatum->primary = le32_to_cpu(buf[++pos]);
-			properties = le32_to_cpu(buf[++pos]);
-		} else {
-			properties = le32_to_cpu(buf[++pos]);
-
-			if (properties & TYPEDATUM_PROPERTY_PRIMARY)
-				typdatum->primary = 1;
-		}
-
-		if (properties & TYPEDATUM_PROPERTY_ATTRIBUTE)
-			typdatum->flavor = TYPE_ATTRIB;
-		if (properties & TYPEDATUM_PROPERTY_ALIAS &&
-		    p->policy_type != POLICY_KERN)
-			typdatum->flavor = TYPE_ALIAS;
-		if (properties & TYPEDATUM_PROPERTY_PERMISSIVE &&
-		    p->policy_type != POLICY_KERN)
-			typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
-		if (properties & TYPEDATUM_PROPERTY_NEVERAUDIT &&
-		    p->policy_type != POLICY_KERN)
-			typdatum->flags |= TYPE_FLAGS_NEVERAUDIT;
-
-		typdatum->bounds = le32_to_cpu(buf[++pos]);
-	} else {
+	if (p->policy_type != POLICY_KERN) {
 		typdatum->primary = le32_to_cpu(buf[++pos]);
-		if (p->policy_type != POLICY_KERN) {
-			typdatum->flavor = le32_to_cpu(buf[++pos]);
-			if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
-				typdatum->flags = le32_to_cpu(buf[++pos]);
-		}
+		properties = le32_to_cpu(buf[++pos]);
+	} else {
+		properties = le32_to_cpu(buf[++pos]);
+
+		if (properties & TYPEDATUM_PROPERTY_PRIMARY)
+			typdatum->primary = 1;
 	}
 
+	if (properties & TYPEDATUM_PROPERTY_ATTRIBUTE)
+		typdatum->flavor = TYPE_ATTRIB;
+	if (properties & TYPEDATUM_PROPERTY_ALIAS &&
+	    p->policy_type != POLICY_KERN)
+		typdatum->flavor = TYPE_ALIAS;
+	if (properties & TYPEDATUM_PROPERTY_PERMISSIVE &&
+	    p->policy_type != POLICY_KERN)
+		typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
+	if (properties & TYPEDATUM_PROPERTY_NEVERAUDIT &&
+	    p->policy_type != POLICY_KERN)
+		typdatum->flags |= TYPE_FLAGS_NEVERAUDIT;
+
+	typdatum->bounds = le32_to_cpu(buf[++pos]);
+
 	if (p->policy_type != POLICY_KERN) {
 		if (ebitmap_read(&typdatum->types, fp))
 			goto bad;
@@ -3266,16 +3158,13 @@ static int user_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 	user_datum_t *usrdatum;
 	uint32_t buf[3];
 	size_t len;
-	int rc, to_read = 2;
+	int rc;
 
 	usrdatum = calloc(1, sizeof(user_datum_t));
 	if (!usrdatum)
 		return -1;
 
-	if (policydb_has_boundary_feature(p))
-		to_read = 3;
-
-	rc = next_entry(buf, fp, sizeof(uint32_t) * to_read);
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
 	if (rc < 0)
 		goto bad;
 
@@ -3285,8 +3174,7 @@ static int user_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 		goto bad;
 
 	usrdatum->s.value = le32_to_cpu(buf[1]);
-	if (policydb_has_boundary_feature(p))
-		usrdatum->bounds = le32_to_cpu(buf[2]);
+	usrdatum->bounds = le32_to_cpu(buf[2]);
 
 	if (p->policy_type == POLICY_KERN) {
 		if (ebitmap_read(&usrdatum->roles.roles, fp))
@@ -3296,17 +3184,7 @@ static int user_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 			goto bad;
 	}
 
-	/* users were not allowed in mls modules before version
-	 * MOD_POLICYDB_VERSION_MLS_USERS, but they could have been
-	 * required - the mls fields will be empty.  user declarations in
-	 * non-mls modules will also have empty mls fields */
-	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policy_type == POLICY_MOD &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
-	     p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS) ||
-	    (p->policy_type == POLICY_BASE &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
-	     p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS)) {
+	if (p->policy_type == POLICY_KERN) {
 		if (mls_read_range_helper(&usrdatum->exp_range, fp))
 			goto bad;
 		if (mls_read_level(&usrdatum->exp_dfltlevel, fp))
@@ -3319,10 +3197,7 @@ static int user_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 						  &usrdatum->dfltlevel))
 				goto bad;
 		}
-	} else if ((p->policy_type == POLICY_MOD &&
-		    p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS) ||
-		   (p->policy_type == POLICY_BASE &&
-		    p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS)) {
+	} else {
 		if (mls_read_semantic_range_helper(&usrdatum->range, fp))
 			goto bad;
 		if (mls_read_semantic_level_helper(&usrdatum->dfltlevel, fp))
@@ -3906,8 +3781,7 @@ static int avrule_decl_read(policydb_t *p, avrule_decl_t *decl,
 	    filename_trans_rule_read(p, &decl->filename_trans_rules, fp))
 		return -1;
 
-	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
-	    range_trans_rule_read(&decl->range_tr_rules, fp) == -1) {
+	if (range_trans_rule_read(&decl->range_tr_rules, fp) == -1) {
 		return -1;
 	}
 	if (scope_index_read(&decl->required, num_scope_syms, fp) == -1 ||
@@ -4294,14 +4168,8 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 	}
 
-	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
-	     p->policy_type == POLICY_BASE) ||
-	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
-	     p->policy_type == POLICY_MOD)) {
-		if (ebitmap_read(&p->policycaps, fp))
-			goto bad;
-	}
+	if (ebitmap_read(&p->policycaps, fp))
+		goto bad;
 
 	if (p->policy_type == POLICY_KERN) {
 		if (ebitmap_read(&p->permissive_map, fp))
@@ -4417,10 +4285,7 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 		goto bad;
 	}
 
-	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policy_type == POLICY_BASE &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
-	     p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS)) {
+	if (p->policy_type == POLICY_KERN) {
 		if (range_read(p, fp)) {
 			goto bad;
 		}
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5687c82b..d457acdb 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1979,8 +1979,6 @@ static int validate_properties(sepol_handle_t *handle, const policydb_t *p)
 		if (p->policyvers < MOD_POLICYDB_VERSION_MIN ||
 		    p->policyvers > MOD_POLICYDB_VERSION_MAX)
 			goto bad;
-		if (p->mls && p->policyvers < MOD_POLICYDB_VERSION_MLS)
-			goto bad;
 		break;
 	default:
 		goto bad;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 4e180ef3..4bb39f99 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -728,9 +728,7 @@ static int context_write(struct policydb *p, context_struct_t *c,
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items2 != items)
 		return POLICYDB_ERROR;
-	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
-	     p->policy_type == POLICY_BASE))
+	if ((p->policy_type == POLICY_KERN) || (p->policy_type == POLICY_BASE))
 		if (mls_write_range_helper(&c->range, fp))
 			return POLICYDB_ERROR;
 
@@ -902,8 +900,7 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 		return POLICYDB_ERROR;
 
 	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policy_type == POLICY_BASE &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_VALIDATETRANS)) {
+	    (p->policy_type == POLICY_BASE)) {
 		/* write out the validatetrans rule */
 		ncons = 0;
 		for (c = cladatum->validatetrans; c; c = c->next) {
@@ -983,8 +980,7 @@ static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
 	buf[items++] = cpu_to_le32(role->s.value);
-	if (policydb_has_boundary_feature(p))
-		buf[items++] = cpu_to_le32(role->bounds);
+	buf[items++] = cpu_to_le32(role->bounds);
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
 		return POLICYDB_ERROR;
@@ -1059,52 +1055,32 @@ static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 		     "types, but one was defined",
 		     p->policyvers);
 
-	if (policydb_has_boundary_feature(p)) {
-		uint32_t properties = 0;
-
-		if (p->policy_type != POLICY_KERN &&
-		    p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY_ALIAS) {
-			buf[items++] = cpu_to_le32(typdatum->primary);
-		}
+	uint32_t properties = 0;
 
-		if (typdatum->primary)
-			properties |= TYPEDATUM_PROPERTY_PRIMARY;
+	if (p->policy_type != POLICY_KERN)
+		buf[items++] = cpu_to_le32(typdatum->primary);
 
-		if (typdatum->flavor == TYPE_ATTRIB) {
-			properties |= TYPEDATUM_PROPERTY_ATTRIBUTE;
-		} else if (typdatum->flavor == TYPE_ALIAS &&
-			   p->policy_type != POLICY_KERN)
-			properties |= TYPEDATUM_PROPERTY_ALIAS;
+	if (typdatum->primary)
+		properties |= TYPEDATUM_PROPERTY_PRIMARY;
 
-		if (typdatum->flags & TYPE_FLAGS_PERMISSIVE &&
-		    p->policy_type != POLICY_KERN)
-			properties |= TYPEDATUM_PROPERTY_PERMISSIVE;
+	if (typdatum->flavor == TYPE_ATTRIB) {
+		properties |= TYPEDATUM_PROPERTY_ATTRIBUTE;
+	} else if (typdatum->flavor == TYPE_ALIAS &&
+		   p->policy_type != POLICY_KERN)
+		properties |= TYPEDATUM_PROPERTY_ALIAS;
 
-		if (typdatum->flags & TYPE_FLAGS_NEVERAUDIT &&
-		    p->policy_type != POLICY_KERN &&
-		    p->policyvers >= MOD_POLICYDB_VERSION_NEVERAUDIT)
-			properties |= TYPEDATUM_PROPERTY_NEVERAUDIT;
+	if (typdatum->flags & TYPE_FLAGS_PERMISSIVE &&
+	    p->policy_type != POLICY_KERN)
+		properties |= TYPEDATUM_PROPERTY_PERMISSIVE;
 
-		buf[items++] = cpu_to_le32(properties);
-		buf[items++] = cpu_to_le32(typdatum->bounds);
-	} else {
-		buf[items++] = cpu_to_le32(typdatum->primary);
+	if (typdatum->flags & TYPE_FLAGS_NEVERAUDIT &&
+	    p->policy_type != POLICY_KERN &&
+	    p->policyvers >= MOD_POLICYDB_VERSION_NEVERAUDIT)
+		properties |= TYPEDATUM_PROPERTY_NEVERAUDIT;
 
-		if (p->policy_type != POLICY_KERN) {
-			buf[items++] = cpu_to_le32(typdatum->flavor);
+	buf[items++] = cpu_to_le32(properties);
+	buf[items++] = cpu_to_le32(typdatum->bounds);
 
-			if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
-				buf[items++] =
-					cpu_to_le32(typdatum->flags &
-						    ~TYPE_FLAGS_NEVERAUDIT);
-			else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
-				WARN(fp->handle,
-				     "Warning! Module policy "
-				     "version %d cannot support permissive "
-				     "types, but one was defined",
-				     p->policyvers);
-		}
-	}
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
 		return POLICYDB_ERROR;
@@ -1136,8 +1112,7 @@ static int user_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
 	buf[items++] = cpu_to_le32(usrdatum->s.value);
-	if (policydb_has_boundary_feature(p))
-		buf[items++] = cpu_to_le32(usrdatum->bounds);
+	buf[items++] = cpu_to_le32(usrdatum->bounds);
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
 		return POLICYDB_ERROR;
@@ -1154,21 +1129,12 @@ static int user_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 			return POLICYDB_ERROR;
 	}
 
-	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
-	     p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS &&
-	     p->policy_type == POLICY_MOD) ||
-	    (p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
-	     p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS &&
-	     p->policy_type == POLICY_BASE)) {
+	if (p->policy_type == POLICY_KERN) {
 		if (mls_write_range_helper(&usrdatum->exp_range, fp))
 			return POLICYDB_ERROR;
 		if (mls_write_level(&usrdatum->exp_dfltlevel, fp))
 			return POLICYDB_ERROR;
-	} else if ((p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS &&
-		    p->policy_type == POLICY_MOD) ||
-		   (p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS &&
-		    p->policy_type == POLICY_BASE)) {
+	} else {
 		if (mls_write_semantic_range_helper(&usrdatum->range, fp))
 			return -1;
 		if (mls_write_semantic_level_helper(&usrdatum->dfltlevel, fp))
@@ -1916,8 +1882,7 @@ static int avrule_decl_write(avrule_decl_t *decl, int num_scope_syms,
 	    filename_trans_rule_write(p, decl->filename_trans_rules, fp))
 		return POLICYDB_ERROR;
 
-	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
-	    range_trans_rule_write(decl->range_tr_rules, fp) == -1) {
+	if (range_trans_rule_write(decl->range_tr_rules, fp) == -1) {
 		return POLICYDB_ERROR;
 	}
 	if (scope_index_write(&decl->required, num_scope_syms, fp) == -1 ||
@@ -2051,19 +2016,8 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 	pd.p = p;
 
 	config = 0;
-	if (p->mls) {
-		if ((p->policyvers < MOD_POLICYDB_VERSION_MLS &&
-		     p->policy_type == POLICY_BASE) ||
-		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
-		     p->policy_type == POLICY_MOD)) {
-			ERR(fp->handle,
-			    "%spolicy version %d cannot support MLS",
-			    p->policy_type == POLICY_KERN ? "" : "module ",
-			    p->policyvers);
-			return POLICYDB_ERROR;
-		}
+	if (p->mls)
 		config |= POLICYDB_CONFIG_MLS;
-	}
 
 	config |= (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown);
 
@@ -2132,14 +2086,8 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 			return POLICYDB_ERROR;
 	}
 
-	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
-	     p->policy_type == POLICY_BASE) ||
-	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
-	     p->policy_type == POLICY_MOD)) {
-		if (ebitmap_write(&p->policycaps, fp) == -1)
-			return POLICYDB_ERROR;
-	}
+	if (ebitmap_write(&p->policycaps, fp) == -1)
+		return POLICYDB_ERROR;
 
 	if (p->policy_type == POLICY_KERN) {
 		if (ebitmap_write(&p->permissive_map, fp) == -1)
@@ -2222,10 +2170,7 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 		return POLICYDB_ERROR;
 	}
 
-	if ((p->policy_type == POLICY_KERN) ||
-	    (p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
-	     p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS &&
-	     p->policy_type == POLICY_BASE)) {
+	if (p->policy_type == POLICY_KERN) {
 		if (range_write(p, fp)) {
 			return POLICYDB_ERROR;
 		}
-- 
2.55.0

