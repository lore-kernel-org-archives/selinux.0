Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81773CB57D
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957353; cv=none; b=k4fELhA14U1VKQ8jFK/inwzMmrw7l6fI6fNM9+aMaQIjEv7TYP4MMLXBTc2v+QNN1Nu5qxOdWrAZsEbOyAutyYHwrXVWrRgo1AmBQigMUmNuSoMZVxzeyNc7iygePi2hFEI0GAVEH6fLL10Diskhv7zvx+EY+3H2dqLRsRLdOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957353; c=relaxed/simple;
	bh=IxneZPxien09W134g5COYpTmlNoLP9F0GdAVJqtsn7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UxCRZg6t6lc4o2Z3P4/vfnOEnuDKxcZI0zT/FnHe+CrXH3YoFNDo6GZtz2g0pSLXQTiEPUdDWB3lTWfkfMQxTOQsACkr/3T9yagmMjXtnBPSs/Jle6omArrR+MgR2PHm+WeflnIgRbG5lqBFuizX3en+UTQezIQCEjCfnh4q/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP8hxjy0; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP8hxjy0"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso9552756d6.3
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785957341; x=1786562141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JzoZflJdEjZs3ZSuVVB/1WAA4CldduzKAQaRNIgR8xA=;
        b=jP8hxjy0eavou/CAZRISfTjeIMhBb9Eksd6f7kei0YR2RBjNXkG7zSat6GMrKPyPXg
         s/xBwMlUgKNa/4ocJWwghk1zFMiCqWs7o4KK9yAgF7kYyoaqEPAPVpMTTQlk5ZnoHROe
         nvOkJl+dtzJOLzt/XWmeFxXi+lFk+Y+/oRT31ESFyy1huDEDngvbb+JM1Lf99v/bSR4M
         lUT3dTZ12zZAL+PPf0PHqlFdz2bO+xWyiTizE8Qq83GpK1LKCXoSkckk2dF/MHQO29xB
         eho7PEVL+SNLq80xOllqgbj+jrLPJlc55gpshQIX4TnhpcvK9fH2B9F3RDyetQUrqjGd
         urqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957341; x=1786562141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JzoZflJdEjZs3ZSuVVB/1WAA4CldduzKAQaRNIgR8xA=;
        b=ps/9OLGJ2K+7YoblfOYoaL/Af+zjtYRVu9hQCPoeNcwMgT24fsNkUozYLr3uy2p8s8
         EGTjHez4OhwgtU3udouv5u3akqi2EqfiRifBLPI87iN/ygBT13W1ZhKNrzBLj9PbZwzd
         t0myjKXBx+7E1OwujmscGQtMvDhkeh5dkIfmwqU2v+CeGgic+t4WCkQYirh5DvuHRBW5
         yQcwpnGSW7xkQzuAnw0aUuf3TRA+ezwEF1+PakIderpIg4DuPh7dm+CWbXS6Ot6/qahN
         5QCBk2zd7pKf18ms2z6tvbOHoMikiOVriT/SfZgIns6rZUVjVMeWxMtCEMm29GYAZ6eJ
         04Fg==
X-Gm-Message-State: AOJu0Ywi5ddDi3J1gCxEWYHkERRyOfIJx5uo1iQADMx2kDortC9qb8IV
	ZY4qvC251RNJz8L8Fz0FiTDfzN4FwB7gltDzEV7mmGmL7Q5N6fhZtR8oBVEDow==
X-Gm-Gg: AR+sD13QIjdkN05NK6VFN9gaP6EYAUHw4HyFi1nWBjiAqNf06pUcF9AvuuOpn2lTWwi
	iDowS7VNSqOrsc+Tq5CUvr0f6cLhtJEHR1MTVjzt89oOAROPUjlqIFPOR9qcHjVChOTbf63WLD8
	QBATL8ZMIlijTR4Pb5454aFt1Q8e8dL17hKug+XjwNadF0tnTyzBjG05+TJq4+HmzSpaxa99MRC
	0Ap4tr2hKXoWZ+lLmc3d8IKP1V9WVsfKV0VsiZXdyV6l5LOwhoG79itozLMdQjU/P5QXXLDcxA0
	s5mBUcevsKbTJT+M54wQZws2KYXp7/ZU+5PAtXt4/VD3sW2Mcmv4T/sfv8shm2JEIbgqKzXxImu
	yudmG9SnChMJKoeers38Rh/pK3thtwwmTUhrQiTHsxc7gMWIfqzTfNAVga76Q21dNkuZuuPqRvC
	sbUxLM+QvM82DrWeH8hiroRYKfv1alD4vIqOW8i7dmg2AyC3ahLsdQnRdlxD/ohmtHOxozpzrC7
	JKaHMC4HCMo7XvtRU3rFyvnOxCTw8ouHZXlrKQvpEEi0ANE9iB+swUwpjxAdkAk
X-Received: by 2002:a05:6214:29c7:b0:907:c6bb:5ce4 with SMTP id 6a1803df08f44-908813abaa3mr96016936d6.32.1785957340873;
        Wed, 05 Aug 2026 12:15:40 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908800ab3fasm31952976d6.34.2026.08.05.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 12:15:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Chen Gong <reister@ruc.edu.cn>
Subject: [PATCH v2] libsepol,checkpolicy: drop support for kernel policy versions < 24
Date: Wed,  5 Aug 2026 15:14:38 -0400
Message-ID: <20260805191438.77935-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given the recently reported bugs in libsepol's support for policy
versions 20 through 23, let's drop support for kernel policy versions
< 24. This also aligns the minimum SELinux kernel policy version with
the minimum Xen policy version. This makes libsepol's minimum
supported kernel version v2.6.28 which is older than the v3.0 minimum
we already set for libselinux.

Reported-by: Chen Gong <reister@ruc.edu.cn>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes up a duplicated validate_filename_trans_hashtab() call and
an incorrectly removed mls check for binary modules.

 checkpolicy/checkpolicy.c                  |  14 +-
 libsepol/include/sepol/policydb/policydb.h |  12 +-
 libsepol/src/avtab.c                       |  92 +------
 libsepol/src/kernel_to_common.c            |  13 -
 libsepol/src/optimize.c                    |  13 -
 libsepol/src/policydb.c                    | 129 ++-------
 libsepol/src/policydb_validate.c           |  43 +--
 libsepol/src/write.c                       | 290 ++-------------------
 libsepol/tests/test-downgrade.c            |   7 -
 9 files changed, 64 insertions(+), 549 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index c1b33869..b5a6da3a 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -605,18 +605,8 @@ int main(int argc, char **argv)
 			}
 		}
 
-		if (policydbp->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
-			if (policyvers > policydbp->policyvers) {
-				fprintf(stderr,
-					"Binary policies with version <= %u cannot be upgraded\n",
-					POLICYDB_VERSION_PERMISSIVE);
-			} else if (policyvers) {
-				policydbp->policyvers = policyvers;
-			}
-		} else {
-			policydbp->policyvers =
-				policyvers ? policyvers : POLICYDB_VERSION_MAX;
-		}
+		policydbp->policyvers = policyvers ? policyvers :
+						     POLICYDB_VERSION_MAX;
 	} else {
 		if (conf) {
 			fprintf(stderr,
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index a1b5e99b..985a496e 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -750,16 +750,6 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define PERM_SYMTAB_SIZE 32
 
 /* Identify specific policy version changes */
-#define POLICYDB_VERSION_BASE 15
-#define POLICYDB_VERSION_BOOL 16
-#define POLICYDB_VERSION_IPV6 17
-#define POLICYDB_VERSION_NLCLASS 18
-#define POLICYDB_VERSION_VALIDATETRANS 19
-#define POLICYDB_VERSION_MLS 19
-#define POLICYDB_VERSION_AVTAB 20
-#define POLICYDB_VERSION_RANGETRANS 21
-#define POLICYDB_VERSION_POLCAP 22
-#define POLICYDB_VERSION_PERMISSIVE 23
 #define POLICYDB_VERSION_BOUNDARY 24
 #define POLICYDB_VERSION_FILENAME_TRANS 25
 #define POLICYDB_VERSION_ROLETRANS 26
@@ -776,7 +766,7 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_NEVERAUDIT 35 /* neveraudit domains */
 
 /* Range of policy versions we understand*/
-#define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
+#define POLICYDB_VERSION_MIN POLICYDB_VERSION_BOUNDARY
 #define POLICYDB_VERSION_MAX POLICYDB_VERSION_NEVERAUDIT
 
 /* Module versions and specific changes*/
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 4a81e551..2bb67599 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -417,23 +417,14 @@ void avtab_hash_eval(avtab_t *h, char *tag)
 	       tag, h->nel, slots_used, h->nslot, max_chain_len);
 }
 
-/* Ordering of datums in the original avtab format in the policy file. */
-static const uint16_t spec_order[] = {
-	AVTAB_ALLOWED,	       AVTAB_AUDITDENY,
-	AVTAB_AUDITALLOW,      AVTAB_TRANSITION,
-	AVTAB_CHANGE,	       AVTAB_MEMBER,
-	AVTAB_XPERMS_ALLOWED,  AVTAB_XPERMS_AUDITALLOW,
-	AVTAB_XPERMS_DONTAUDIT
-};
-
 int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t *a,
 		    int (*insertf)(avtab_t *a, avtab_key_t *k, avtab_datum_t *d,
 				   void *p),
 		    void *p)
 {
 	uint8_t buf8;
-	uint16_t buf16[4], enabled;
-	uint32_t buf32[8], items, items2, val;
+	uint16_t buf16[4];
+	uint32_t buf32[8], items;
 	avtab_key_t key;
 	avtab_datum_t datum;
 	avtab_extended_perms_t xperms;
@@ -444,85 +435,6 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t *a,
 	memset(&datum, 0, sizeof(avtab_datum_t));
 	memset(&xperms, 0, sizeof(avtab_extended_perms_t));
 
-	if (vers < POLICYDB_VERSION_AVTAB) {
-		rc = next_entry(buf32, fp, sizeof(uint32_t));
-		if (rc < 0) {
-			ERR(fp->handle, "truncated entry");
-			return -1;
-		}
-		items2 = le32_to_cpu(buf32[0]);
-
-		if (items2 < 5 || items2 > ARRAY_SIZE(buf32)) {
-			ERR(fp->handle, "invalid item count");
-			return -1;
-		}
-
-		rc = next_entry(buf32, fp, sizeof(uint32_t) * items2);
-		if (rc < 0) {
-			ERR(fp->handle, "truncated entry");
-			return -1;
-		}
-
-		items = 0;
-		val = le32_to_cpu(buf32[items++]);
-		key.source_type = (uint16_t)val;
-		if (key.source_type != val) {
-			ERR(fp->handle, "truncated source type");
-			return -1;
-		}
-		val = le32_to_cpu(buf32[items++]);
-		key.target_type = (uint16_t)val;
-		if (key.target_type != val) {
-			ERR(fp->handle, "truncated target type");
-			return -1;
-		}
-		val = le32_to_cpu(buf32[items++]);
-		key.target_class = (uint16_t)val;
-		if (key.target_class != val) {
-			ERR(fp->handle, "truncated target class");
-			return -1;
-		}
-
-		val = le32_to_cpu(buf32[items++]);
-		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
-
-		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
-			ERR(fp->handle, "null entry");
-			return -1;
-		}
-		if ((val & AVTAB_AV) && (val & AVTAB_TYPE)) {
-			ERR(fp->handle, "entry has both access "
-					"vectors and types");
-			return -1;
-		}
-
-		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
-			if (val & spec_order[i]) {
-				if (items >=
-				    items2) { /* items is index, items2 is total number */
-					ERR(fp->handle,
-					    "entry has too many items (%d/%d)",
-					    items + 1, items2);
-					return -1;
-				}
-				key.specified = spec_order[i] | enabled;
-				datum.data = le32_to_cpu(buf32[items++]);
-				rc = insertf(a, &key, &datum, p);
-				if (rc)
-					return rc;
-			}
-		}
-
-		if (items != items2) {
-			ERR(fp->handle,
-			    "entry only had %d items, "
-			    "expected %d",
-			    items2, items);
-			return -1;
-		}
-		return 0;
-	}
-
 	rc = next_entry(buf16, fp, sizeof(uint16_t) * 4);
 	if (rc < 0) {
 		ERR(fp->handle, "truncated entry");
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index c7b6d73a..338dcef6 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -795,18 +795,5 @@ int check_for_supported_policy(struct policydb *pdb)
 		return -1;
 	}
 
-	if (pdb->policyvers >= POLICYDB_VERSION_AVTAB &&
-	    pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
-		/*
-		 * For policy versions between 20 and 23, attributes exist in the policy,
-		 * but only in the type_attr_map. This means that there are gaps in both
-		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
-		 * can refer to those gaps.
-		 */
-		ERR(NULL,
-		    "Writing out CIL or policy.conf from policy versions between 20 and 23 is not supported");
-		return -1;
-	}
-
 	return 0;
 }
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 7a961ca4..eeffee7d 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -453,19 +453,6 @@ int policydb_optimize(policydb_t *p)
 	if (p->policy_type != POLICY_KERN)
 		return -1;
 
-	if (p->policyvers >= POLICYDB_VERSION_AVTAB &&
-	    p->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
-		/*
-		 * For policy versions between 20 and 23, attributes exist in the policy,
-		 * but only in the type_attr_map. This means that there are gaps in both
-		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
-		 * can refer to those gaps.
-		 */
-		ERR(NULL,
-		    "Optimizing policy versions between 20 and 23 is not supported");
-		return -1;
-	}
-
 	type_map = build_type_map(p);
 	if (!type_map)
 		return -1;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 44e26f4f..84b7ac1e 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -76,69 +76,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.ocon_num = OCON_XEN_DEVICETREE + 1,
 		.target_platform = SEPOL_TARGET_XEN,
 	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_BASE,
-		.sym_num = SYM_NUM - 3,
-		.ocon_num = OCON_FSUSE + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_BOOL,
-		.sym_num = SYM_NUM - 2,
-		.ocon_num = OCON_FSUSE + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_IPV6,
-		.sym_num = SYM_NUM - 2,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_NLCLASS,
-		.sym_num = SYM_NUM - 2,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_MLS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_AVTAB,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_RANGETRANS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_POLCAP,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_PERMISSIVE,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 		.type = POLICY_KERN,
 		.version = POLICYDB_VERSION_BOUNDARY,
@@ -2088,8 +2025,7 @@ static int context_read_and_validate(context_struct_t *c, policydb_t *p,
 	c->user = le32_to_cpu(buf[0]);
 	c->role = le32_to_cpu(buf[1]);
 	c->type = le32_to_cpu(buf[2]);
-	if ((p->policy_type == POLICY_KERN &&
-	     p->policyvers >= POLICYDB_VERSION_MLS) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policy_type == POLICY_BASE &&
 	     p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
 		if (mls_read_range_helper(&c->range, fp)) {
@@ -2348,8 +2284,7 @@ static int class_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 	if (read_cons_helper(p, &cladatum->constraints, ncons, 0, fp))
 		goto bad;
 
-	if ((p->policy_type == POLICY_KERN &&
-	     p->policyvers >= POLICYDB_VERSION_VALIDATETRANS) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policy_type == POLICY_BASE &&
 	     p->policyvers >= MOD_POLICYDB_VERSION_VALIDATETRANS)) {
 		/* grab the validatetrans rules */
@@ -3365,8 +3300,7 @@ static int user_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 	 * MOD_POLICYDB_VERSION_MLS_USERS, but they could have been
 	 * required - the mls fields will be empty.  user declarations in
 	 * non-mls modules will also have empty mls fields */
-	if ((p->policy_type == POLICY_KERN &&
-	     p->policyvers >= POLICYDB_VERSION_MLS) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policy_type == POLICY_MOD &&
 	     p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
 	     p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS) ||
@@ -3603,8 +3537,7 @@ static int range_read(policydb_t *p, struct policy_file *fp)
 	struct mls_range *r = NULL;
 	range_trans_rule_t *rtr = NULL, *lrtr = NULL;
 	unsigned int i;
-	int new_rangetr = (p->policy_type == POLICY_KERN &&
-			   p->policyvers >= POLICYDB_VERSION_RANGETRANS);
+	int new_rangetr = (p->policy_type == POLICY_KERN);
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof(uint32_t));
@@ -4361,8 +4294,7 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 	}
 
-	if ((p->policyvers >= POLICYDB_VERSION_POLCAP &&
-	     p->policy_type == POLICY_KERN) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
 	     p->policy_type == POLICY_BASE) ||
 	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
@@ -4371,8 +4303,7 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 	}
 
-	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
-	    p->policy_type == POLICY_KERN) {
+	if (p->policy_type == POLICY_KERN) {
 		if (ebitmap_read(&p->permissive_map, fp))
 			goto bad;
 	}
@@ -4422,9 +4353,8 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 	if (policy_type == POLICY_KERN) {
 		if (avtab_read(&p->te_avtab, fp, r_policyvers))
 			goto bad;
-		if (r_policyvers >= POLICYDB_VERSION_BOOL)
-			if (cond_read_list(p, &p->cond_list, fp))
-				goto bad;
+		if (cond_read_list(p, &p->cond_list, fp))
+			goto bad;
 		if (role_trans_read(p, fp))
 			goto bad;
 		if (role_allow_read(&p->role_allow, fp))
@@ -4487,8 +4417,7 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 		goto bad;
 	}
 
-	if ((p->policy_type == POLICY_KERN &&
-	     p->policyvers >= POLICYDB_VERSION_MLS) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policy_type == POLICY_BASE &&
 	     p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
 	     p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS)) {
@@ -4503,30 +4432,28 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 		if (!p->type_attr_map || !p->attr_type_map)
 			goto bad;
 		for (i = 0; i < p->p_types.nprim; i++) {
-			if (r_policyvers >= POLICYDB_VERSION_AVTAB) {
-				if (ebitmap_read(&p->type_attr_map[i], fp))
+			if (ebitmap_read(&p->type_attr_map[i], fp))
+				goto bad;
+			ebitmap_for_each_positive_bit(&p->type_attr_map[i],
+						      tnode, j) {
+				if (i == j)
+					continue;
+
+				if (j >= p->p_types.nprim)
+					goto bad;
+
+				if (p->type_val_to_struct[i] &&
+				    p->type_val_to_struct[i]->flavor ==
+					    TYPE_ATTRIB) {
+					ERR(fp->handle,
+					    "Invalid to have type attributes associated with an attribute for a kernel policy");
 					goto bad;
-				ebitmap_for_each_positive_bit(
-					&p->type_attr_map[i], tnode, j) {
-					if (i == j)
-						continue;
-
-					if (j >= p->p_types.nprim)
-						goto bad;
-
-					if (p->type_val_to_struct[i] &&
-					    p->type_val_to_struct[i]->flavor ==
-						    TYPE_ATTRIB) {
-						ERR(fp->handle,
-						    "Invalid to have type attributes associated with an attribute for a kernel policy");
-						goto bad;
-					}
-
-					if (ebitmap_set_bit(
-						    &p->attr_type_map[j], i, 1))
-						goto bad;
 				}
+
+				if (ebitmap_set_bit(&p->attr_type_map[j], i, 1))
+					goto bad;
 			}
+
 			/* add the type itself as the degenerate case */
 			if (p->type_val_to_struct[i] &&
 			    ebitmap_set_bit(&p->type_attr_map[i], i, 1))
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 4cdf0b78..5687c82b 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -77,21 +77,9 @@ static int validate_array_init(const policydb_t *p, validate_t flavors[])
 	if (validate_init(&flavors[SYM_ROLES], p->p_role_val_to_name,
 			  p->p_roles.nprim))
 		goto bad;
-	if (p->policy_type != POLICY_KERN ||
-	    p->policyvers < POLICYDB_VERSION_AVTAB ||
-	    p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
-		if (validate_init(&flavors[SYM_TYPES], p->p_type_val_to_name,
-				  p->p_types.nprim))
-			goto bad;
-	} else {
-		/*
-		 * For policy versions between 20 and 23, attributes exist in the policy,
-		 * but they only exist in the type_attr_map, so there will be references
-		 * to gaps and we just have to treat this case as if there were no gaps.
-		 */
-		flavors[SYM_TYPES].nprim = p->p_types.nprim;
-		ebitmap_init(&flavors[SYM_TYPES].gaps);
-	}
+	if (validate_init(&flavors[SYM_TYPES], p->p_type_val_to_name,
+			  p->p_types.nprim))
+		goto bad;
 	if (validate_init(&flavors[SYM_USERS], p->p_user_val_to_name,
 			  p->p_users.nprim))
 		goto bad;
@@ -954,19 +942,10 @@ static int validate_datum_array_gaps(sepol_handle_t *handle,
 			goto bad;
 	}
 
-	/*
-	 * For policy versions between 20 and 23, attributes exist in the policy,
-	 * but only in the type_attr_map, so all gaps must be assumed to be valid.
-	 */
-	if (p->policy_type != POLICY_KERN ||
-	    p->policyvers < POLICYDB_VERSION_AVTAB ||
-	    p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
-		for (i = 0; i < p->p_types.nprim; i++) {
-			if (bool_xnor(p->type_val_to_struct[i],
-				      ebitmap_get_bit(&flavors[SYM_TYPES].gaps,
-						      i)))
-				goto bad;
-		}
+	for (i = 0; i < p->p_types.nprim; i++) {
+		if (bool_xnor(p->type_val_to_struct[i],
+			      ebitmap_get_bit(&flavors[SYM_TYPES].gaps, i)))
+			goto bad;
 	}
 
 	for (i = 0; i < p->p_users.nprim; i++) {
@@ -1994,8 +1973,6 @@ static int validate_properties(sepol_handle_t *handle, const policydb_t *p)
 		if (p->policyvers < POLICYDB_VERSION_MIN ||
 		    p->policyvers > POLICYDB_VERSION_MAX)
 			goto bad;
-		if (p->mls && p->policyvers < POLICYDB_VERSION_MLS)
-			goto bad;
 		break;
 	case POLICY_BASE:
 	case POLICY_MOD:
@@ -2086,10 +2063,8 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 	if (p->policy_type == POLICY_KERN) {
 		if (validate_avtab(handle, &p->te_avtab, p, flavors))
 			goto bad;
-		if (p->policyvers >= POLICYDB_VERSION_BOOL)
-			if (validate_cond_list(handle, p->cond_list, p,
-					       flavors))
-				goto bad;
+		if (validate_cond_list(handle, p->cond_list, p, flavors))
+			goto bad;
 		if (validate_role_transes(handle, p->role_tr, flavors))
 			goto bad;
 		if (validate_role_allows(handle, p->role_allow, flavors))
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index adec6caf..4e180ef3 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -92,126 +92,15 @@ static int ebitmap_write(ebitmap_t *e, struct policy_file *fp)
 	return POLICYDB_SUCCESS;
 }
 
-/* Ordering of datums in the original avtab format in the policy file. */
-static uint16_t spec_order[] = { AVTAB_ALLOWED,	   AVTAB_AUDITDENY,
-				 AVTAB_AUDITALLOW, AVTAB_TRANSITION,
-				 AVTAB_CHANGE,	   AVTAB_MEMBER };
-
 static int avtab_write_item(policydb_t *p, avtab_ptr_t cur,
-			    struct policy_file *fp, unsigned merge,
-			    unsigned commit, unsigned conditional,
-			    uint32_t *nel)
+			    struct policy_file *fp, unsigned conditional)
 {
-	avtab_ptr_t node;
 	uint8_t buf8;
 	uint16_t buf16[4];
-	uint32_t buf32[10], lookup, val;
-	size_t items, items2;
-	unsigned set;
-	unsigned int oldvers = (p->policy_type == POLICY_KERN &&
-				p->policyvers < POLICYDB_VERSION_AVTAB);
+	uint32_t buf32[10];
+	size_t items;
 	unsigned int i;
 
-	if (oldvers) {
-		/* Generate the old avtab format.
-		   Requires merging similar entries if uncond avtab. */
-		if (merge) {
-			if (cur->merged)
-				return POLICYDB_SUCCESS; /* already merged by prior merge */
-		}
-
-		items = 1; /* item 0 is used for the item count */
-		val = cur->key.source_type;
-		buf32[items++] = cpu_to_le32(val);
-		val = cur->key.target_type;
-		buf32[items++] = cpu_to_le32(val);
-		val = cur->key.target_class;
-		buf32[items++] = cpu_to_le32(val);
-
-		val = cur->key.specified & ~AVTAB_ENABLED;
-		if (cur->key.specified & AVTAB_ENABLED)
-			val |= AVTAB_ENABLED_OLD;
-		set = 1;
-
-		if (merge) {
-			/* Merge specifier values for all similar (av or type)
-			   entries that have the same key. */
-			if (val & AVTAB_AV)
-				lookup = AVTAB_AV;
-			else if (val & AVTAB_TYPE)
-				lookup = AVTAB_TYPE;
-			else
-				return POLICYDB_ERROR;
-			for (node = avtab_search_node_next(cur, lookup); node;
-			     node = avtab_search_node_next(node, lookup)) {
-				val |= (node->key.specified & ~AVTAB_ENABLED);
-				set++;
-				if (node->key.specified & AVTAB_ENABLED)
-					val |= AVTAB_ENABLED_OLD;
-			}
-		}
-
-		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
-			ERR(fp->handle, "null entry");
-			return POLICYDB_ERROR;
-		}
-		if ((val & AVTAB_AV) && (val & AVTAB_TYPE)) {
-			ERR(fp->handle, "entry has both access "
-					"vectors and types");
-			return POLICYDB_ERROR;
-		}
-
-		buf32[items++] = cpu_to_le32(val);
-
-		if (merge) {
-			/* Include datums for all similar (av or type)
-			   entries that have the same key. */
-			for (i = 0;
-			     i < (sizeof(spec_order) / sizeof(spec_order[0]));
-			     i++) {
-				if (val & spec_order[i]) {
-					if (cur->key.specified & spec_order[i])
-						node = cur;
-					else {
-						node = avtab_search_node_next(
-							cur, spec_order[i]);
-						if (nel)
-							(*nel)--; /* one less node */
-					}
-
-					if (!node) {
-						ERR(fp->handle, "missing node");
-						return POLICYDB_ERROR;
-					}
-					buf32[items++] =
-						cpu_to_le32(node->datum.data);
-					set--;
-					node->merged = 1;
-				}
-			}
-		} else {
-			buf32[items++] = cpu_to_le32(cur->datum.data);
-			cur->merged = 1;
-			set--;
-		}
-
-		if (set) {
-			ERR(fp->handle, "data count wrong");
-			return POLICYDB_ERROR;
-		}
-
-		buf32[0] = cpu_to_le32(items - 1);
-
-		if (commit) {
-			/* Commit this item to the policy file. */
-			items2 = put_entry(buf32, sizeof(uint32_t), items, fp);
-			if (items != items2)
-				return POLICYDB_ERROR;
-		}
-
-		return POLICYDB_SUCCESS;
-	}
-
 	/* Generate the new avtab format. */
 	buf16[0] = cpu_to_le16(cur->key.source_type);
 	buf16[1] = cpu_to_le16(cur->key.target_type);
@@ -271,86 +160,30 @@ static int avtab_write_item(policydb_t *p, avtab_ptr_t cur,
 	return POLICYDB_SUCCESS;
 }
 
-static inline void avtab_reset_merged(avtab_t *a)
-{
-	unsigned int i;
-	avtab_ptr_t cur;
-	for (i = 0; i < a->nslot; i++) {
-		for (cur = a->htable[i]; cur; cur = cur->next)
-			cur->merged = 0;
-	}
-}
-
 static int avtab_write(struct policydb *p, avtab_t *a, struct policy_file *fp)
 {
 	unsigned int i;
 	int rc;
-	avtab_t expa;
 	avtab_ptr_t cur;
 	uint32_t nel;
 	size_t items;
-	unsigned int oldvers = (p->policy_type == POLICY_KERN &&
-				p->policyvers < POLICYDB_VERSION_AVTAB);
-
-	if (oldvers) {
-		/* Old avtab format.
-		   First, we need to expand attributes.  Then, we need to
-		   merge similar entries, so we need to track merged nodes 
-		   and compute the final nel. */
-		if (avtab_init(&expa))
-			return POLICYDB_ERROR;
-		if (expand_avtab(p, a, &expa)) {
-			rc = -1;
-			goto out;
-		}
-		a = &expa;
-		avtab_reset_merged(a);
-		nel = a->nel;
-	} else {
-		/* New avtab format.  nel is good to go. */
-		nel = cpu_to_le32(a->nel);
-		items = put_entry(&nel, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return POLICYDB_ERROR;
-	}
+
+	nel = cpu_to_le32(a->nel);
+	items = put_entry(&nel, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return POLICYDB_ERROR;
 
 	for (i = 0; i < a->nslot; i++) {
 		for (cur = a->htable[i]; cur; cur = cur->next) {
-			/* If old format, compute final nel.
-			   If new format, write out the items. */
-			if (avtab_write_item(p, cur, fp, 1, !oldvers, 0,
-					     &nel)) {
+			if (avtab_write_item(p, cur, fp, 0)) {
 				rc = -1;
 				goto out;
 			}
 		}
 	}
 
-	if (oldvers) {
-		/* Old avtab format.
-		   Write the computed nel value, then write the items. */
-		nel = cpu_to_le32(nel);
-		items = put_entry(&nel, sizeof(uint32_t), 1, fp);
-		if (items != 1) {
-			rc = -1;
-			goto out;
-		}
-		avtab_reset_merged(a);
-		for (i = 0; i < a->nslot; i++) {
-			for (cur = a->htable[i]; cur; cur = cur->next) {
-				if (avtab_write_item(p, cur, fp, 1, 1, 0,
-						     NULL)) {
-					rc = -1;
-					goto out;
-				}
-			}
-		}
-	}
-
 	rc = 0;
 out:
-	if (oldvers)
-		avtab_destroy(&expa);
 	return rc;
 }
 
@@ -770,21 +603,10 @@ static int cond_write_av_list(policydb_t *p, cond_av_list_t *list,
 			      struct policy_file *fp)
 {
 	uint32_t buf[4];
-	cond_av_list_t *cur_list, *new_list = NULL;
-	avtab_t expa;
+	cond_av_list_t *cur_list;
 	uint32_t len, items;
-	unsigned int oldvers = (p->policy_type == POLICY_KERN &&
-				p->policyvers < POLICYDB_VERSION_AVTAB);
 	int rc = -1;
 
-	if (oldvers) {
-		if (avtab_init(&expa))
-			return POLICYDB_ERROR;
-		if (expand_cond_av_list(p, list, &new_list, &expa))
-			goto out;
-		list = new_list;
-	}
-
 	len = 0;
 	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
 		if (cur_list->node->parse_context)
@@ -803,18 +625,12 @@ static int cond_write_av_list(policydb_t *p, cond_av_list_t *list,
 
 	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
 		if (cur_list->node->parse_context)
-			if (avtab_write_item(p, cur_list->node, fp, 0, 1, 1,
-					     NULL))
+			if (avtab_write_item(p, cur_list->node, fp, 1))
 				goto out;
 	}
 
 	rc = 0;
 out:
-	if (oldvers) {
-		cond_av_list_destroy(new_list);
-		avtab_destroy(&expa);
-	}
-
 	return rc;
 }
 
@@ -912,8 +728,7 @@ static int context_write(struct policydb *p, context_struct_t *c,
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items2 != items)
 		return POLICYDB_ERROR;
-	if ((p->policyvers >= POLICYDB_VERSION_MLS &&
-	     p->policy_type == POLICY_KERN) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
 	     p->policy_type == POLICY_BASE))
 		if (mls_write_range_helper(&c->range, fp))
@@ -1086,8 +901,7 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	if (write_cons_helper(p, cladatum->constraints, 0, fp))
 		return POLICYDB_ERROR;
 
-	if ((p->policy_type == POLICY_KERN &&
-	     p->policyvers >= POLICYDB_VERSION_VALIDATETRANS) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policy_type == POLICY_BASE &&
 	     p->policyvers >= MOD_POLICYDB_VERSION_VALIDATETRANS)) {
 		/* write out the validatetrans rule */
@@ -1231,15 +1045,6 @@ static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 
 	typdatum = (type_datum_t *)datum;
 
-	/*
-	 * The kernel policy version less than 24 (= POLICYDB_VERSION_BOUNDARY)
-	 * does not support to load entries of attribute, so we skip to write it.
-	 */
-	if (p->policy_type == POLICY_KERN &&
-	    p->policyvers < POLICYDB_VERSION_BOUNDARY &&
-	    typdatum->flavor == TYPE_ATTRIB)
-		return POLICYDB_SUCCESS;
-
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
@@ -1349,8 +1154,7 @@ static int user_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 			return POLICYDB_ERROR;
 	}
 
-	if ((p->policyvers >= POLICYDB_VERSION_MLS &&
-	     p->policy_type == POLICY_KERN) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
 	     p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS &&
 	     p->policy_type == POLICY_MOD) ||
@@ -1759,8 +1563,7 @@ static int range_write(policydb_t *p, struct policy_file *fp)
 {
 	size_t items;
 	uint32_t buf[2];
-	int new_rangetr = (p->policy_type == POLICY_KERN &&
-			   p->policyvers >= POLICYDB_VERSION_RANGETRANS);
+	int new_rangetr = (p->policy_type == POLICY_KERN);
 	struct rangetrans_write_args args;
 	int rc;
 
@@ -2214,19 +2017,6 @@ err:
 	return rc;
 }
 
-static int type_attr_uncount(hashtab_key_t key __attribute__((unused)),
-			     hashtab_datum_t datum, void *args)
-{
-	type_datum_t *typdatum = datum;
-	uint32_t *p_nel = args;
-
-	if (typdatum->flavor == TYPE_ATTRIB) {
-		/* uncount attribute from total number of types */
-		(*p_nel)--;
-	}
-	return 0;
-}
-
 static int role_attr_uncount(hashtab_key_t key __attribute__((unused)),
 			     hashtab_datum_t datum, void *args)
 {
@@ -2262,9 +2052,7 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 
 	config = 0;
 	if (p->mls) {
-		if ((p->policyvers < POLICYDB_VERSION_MLS &&
-		     p->policy_type == POLICY_KERN) ||
-		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
+		if ((p->policyvers < MOD_POLICYDB_VERSION_MLS &&
 		     p->policy_type == POLICY_BASE) ||
 		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
 		     p->policy_type == POLICY_MOD)) {
@@ -2344,8 +2132,7 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 			return POLICYDB_ERROR;
 	}
 
-	if ((p->policyvers >= POLICYDB_VERSION_POLCAP &&
-	     p->policy_type == POLICY_KERN) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
 	     p->policy_type == POLICY_BASE) ||
 	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
@@ -2355,18 +2142,7 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 	}
 
 	if (p->policy_type == POLICY_KERN) {
-		if (p->policyvers < POLICYDB_VERSION_PERMISSIVE) {
-			ebitmap_node_t *tnode;
-
-			ebitmap_for_each_positive_bit(&p->permissive_map, tnode,
-						      i) {
-				WARN(fp->handle,
-				     "Warning! Policy version %d cannot "
-				     "support permissive types, but some were defined",
-				     p->policyvers);
-				break;
-			}
-		} else if (ebitmap_write(&p->permissive_map, fp) == -1)
+		if (ebitmap_write(&p->permissive_map, fp) == -1)
 			return POLICYDB_ERROR;
 
 		if (p->policyvers < POLICYDB_VERSION_NEVERAUDIT) {
@@ -2389,19 +2165,6 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
 		buf[1] = p->symtab[i].table->nel;
 
-		/*
-		 * A special case when writing type/attribute symbol table.
-		 * The kernel policy version less than 24 does not support
-		 * to load entries of attribute, so we have to re-calculate
-		 * the actual number of types except for attributes.
-		 */
-		if (i == SYM_TYPES &&
-		    p->policyvers < POLICYDB_VERSION_BOUNDARY &&
-		    p->policy_type == POLICY_KERN) {
-			hashtab_map(p->symtab[i].table, type_attr_uncount,
-				    &buf[1]);
-		}
-
 		/*
 		 * Another special case when writing role/attribute symbol
 		 * table, role attributes are redundant for policy.X, or
@@ -2426,15 +2189,8 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 	if (p->policy_type == POLICY_KERN) {
 		if (avtab_write(p, &p->te_avtab, fp))
 			return POLICYDB_ERROR;
-		if (p->policyvers < POLICYDB_VERSION_BOOL) {
-			if (p->p_bools.nprim)
-				WARN(fp->handle,
-				     "Discarding "
-				     "booleans and conditional rules");
-		} else {
-			if (cond_write_list(p, p->cond_list, fp))
-				return POLICYDB_ERROR;
-		}
+		if (cond_write_list(p, p->cond_list, fp))
+			return POLICYDB_ERROR;
 		if (role_trans_write(p, fp))
 			return POLICYDB_ERROR;
 		if (role_allow_write(p->role_allow, fp))
@@ -2466,8 +2222,7 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 		return POLICYDB_ERROR;
 	}
 
-	if ((p->policyvers >= POLICYDB_VERSION_MLS &&
-	     p->policy_type == POLICY_KERN) ||
+	if ((p->policy_type == POLICY_KERN) ||
 	    (p->policyvers >= MOD_POLICYDB_VERSION_MLS &&
 	     p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS &&
 	     p->policy_type == POLICY_BASE)) {
@@ -2476,8 +2231,7 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 		}
 	}
 
-	if (p->policy_type == POLICY_KERN &&
-	    p->policyvers >= POLICYDB_VERSION_AVTAB) {
+	if (p->policy_type == POLICY_KERN) {
 		for (i = 0; i < p->p_types.nprim; i++) {
 			if (ebitmap_write(&p->type_attr_map[i], fp) == -1)
 				return POLICYDB_ERROR;
diff --git a/libsepol/tests/test-downgrade.c b/libsepol/tests/test-downgrade.c
index bf747780..5f879b39 100644
--- a/libsepol/tests/test-downgrade.c
+++ b/libsepol/tests/test-downgrade.c
@@ -155,13 +155,6 @@ int do_downgrade_test(int mls)
 			/* Write out modified binary policy */
 			if (write_binary_policy(POLICY_BIN_LO, &policydb) !=
 			    0) {
-				/*
-				 * Error from MLS to pre-MLS is expected due
-				 * to MLS re-implementation in version 19.
-				 */
-				if (mls && lo < POLICYDB_VERSION_MLS)
-					continue;
-
 				fprintf(stderr,
 					"error writing %spolicy binary, version %d (downgraded from %d)\n",
 					mls ? "mls " : "", lo, hi);
-- 
2.55.0

