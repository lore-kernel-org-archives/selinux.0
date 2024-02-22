Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8213BAE4
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646378; cv=none; b=AjNDIBtkAJBWmthMz2sdPRaTRT9s14KmgcfTcpW3yhMIlxKgJGbXifH18W9UzdRXrYst8LwQEUSi4/G1UexxOG/RFZ/eczv0CT1QCWlxo5U3Ryn0iXMtTW7mW3WRGPXcDhllsizf8YJhjHBmlqBw7yeAd0ESIIbzf084eaGceIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646378; c=relaxed/simple;
	bh=0fVSh2FjiZdmeQLP8Uxj8vTi9A5AAMiY1pz5LNo1qEU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrPNjOyZ6lArD9jfa6fRUA2XKhUE17+DFp93CwC48MyQHvZOz5HJlmiW6XmIIdJ/Zpqk6IaMHKkNoOlQH+k1W9NUo3SV0gUf7JolbgBWz2C0UfWiR147JAWOuHQ6xjt1pGcwpMkz791kep+q/jCL8UiSN8RafsBedsutnkbalpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WaSrDbYx; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WaSrDbYx"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68f41af71ebso3038386d6.1
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646375; x=1709251175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6NCNpAh9fK3zsSUfb8VZalzo09bT41aWRdPAN/2tmQ=;
        b=WaSrDbYxn8Scal0hMmPCRc1JSzfYd7V8VraLHPSOP5j1mYM6VcTv7bMLwWB7D7PfOA
         KbNehzI4zRdh0LeH495Odu7sEemTSjZWOGBIUgxwbyXwm1lblU9YXtwNM+Bh44+sC3pA
         9DKBb2gvPp1L//dXxL+WT7u37nPqnXG61dNzGavI1WFeWtyiQdcD/qNhigIRYZi1bWeX
         hDCekhmxc9NdoEjk8rMwEvo2ceNk9KGhc64YzyUZcWON7XBlyegR3MR+xLKgCpQ2C2kn
         UFbeo8w6qtB8vHDT1Y+Ue2FVmCWhuwbKgI4ctWPYoHVuvsE85O9lTKIaQ85E6BuaqJVd
         QAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646375; x=1709251175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6NCNpAh9fK3zsSUfb8VZalzo09bT41aWRdPAN/2tmQ=;
        b=sh7MyQPe+mGWNkwt0NYzKTjdMU4H/uCIwHGX5d5EGos/1rsg+i1DsMkPMof+0QMHWq
         nYvNOV+Cr8xs0TjAwMk9UvHHThrgG9Gefa3Oyd+2zE4oxaVVY1LivLq88Rd2lNsjVmD0
         zfmgAMewO3Qg2qNZqII6gA6wwVr+RlcEto7+kn0O1yURKuxDIEKQC7wuK2p5iEl+eHuz
         LLsSh8VVtmAo9rJECj8/1dpQWmp6O6t/sBxmQXu8znHZQVuS1gZ+VT5ty2utIbtgrYcO
         C71ZzAzvutgEtG1PWR2Pt+Xb1sucdNsc2mQ5whhed6W1muLqJxmCoB9Vqb2yfj1aX7la
         HcdA==
X-Gm-Message-State: AOJu0YyYJcL0NjRMkVTVtU7250lZFng7wrYmwj/VHq6lahCgbsTFIiNl
	x/hgcn+bKBt9z6Vqle/Yfp2nMEjqVyQREMgWPEYzujxHC2vmXdrcvM0S2drn7281Lp9jCQUN6dg
	=
X-Google-Smtp-Source: AGHT+IH+x3XLztcH74tchXvJjxeHF4/sC/GrP297WF8ShsdDG9kzYANrE6/VzHtN9xN3PxHqAeOrWQ==
X-Received: by 2002:a05:6214:29e4:b0:68f:2f2d:d01 with SMTP id jv4-20020a05621429e400b0068f2f2d0d01mr642666qvb.10.1708646375396;
        Thu, 22 Feb 2024 15:59:35 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d11-20020a05621416cb00b0068d11cf887bsm7475661qvz.55.2024.02.22.15.59.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:34 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 02/21] selinux: fix style issues in security/selinux/ss/avtab.c
Date: Thu, 22 Feb 2024 18:52:20 -0500
Message-ID: <20240222235708.386652-25-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10549; i=paul@paul-moore.com; h=from:subject; bh=0fVSh2FjiZdmeQLP8Uxj8vTi9A5AAMiY1pz5LNo1qEU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl199b8FKGaDhUD8aWuiNiaStUOCwmEHaGIu8+J y97UfoWjnaJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffWwAKCRDqIPLalzeJ c/BRD/9+nBy7Y5UgvcP5ZmvUctXWh8L4xFgdgBozWLi9fIJMMcBrOBuESacb6iapIk+TJ0UdC/e 9bkTAuqM+llbwu9Pb97bcwfkSFwRG0m0yvH6Pf7+ZAZXEeuGwIp88hKla35eSwBzOYRIuAdxa1a iFQU4sj1A5Fy5kmxs29zECBJATLPsVNUxktO0RDUZvQFKqBfQGDEnwDTjlCApMjW6ANaXk+qWgA yc1F7SXxuXUMhRabYcBKvaKoPh6uhx42USRkapbxYOo5PEADDxIbD5/ZRbtVXHXeU2EsfRXPP2b Drk0Wcla912rOiiw1lEx4HZ9oeKhHb6RRZsniIDT4CqmueIvsyn+72JJ5RZC+m3T0008xYJzBvV H1TaBz4fQSRU+8TLTQ1Y8dEN5AhjaNqPmBxSWeEUbAZ4iAJRadULqneaaKmtbHglaQvVyNJEUt0 588+1Z8XVyREIfi69UMKa5hGiIsmBZS/Gs8Z/6DHI/bj0pO4/+FmngGO9YnYd9zw4qVBOG8xinN EvexDjp1Q8uOOdjJUYfHW7gi6KlcwKw1yT/UepKx/i0k1H3htO92KTrKBQ96fGfWsPvekhUpg/R +N8UadfMznejM+h71q913vNPxzeoWGkDyEeIg1dQHcdH14cmlTtEa99US2uaRobER8h44REZDxA 14K6SBPAMhOgUxw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/avtab.c | 105 ++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 54 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 697eb4352439..2ad98732d052 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -1,20 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Implementation of the access vector table type.
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 
-/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
- *
- *	Added conditional policy language extensions
- *
- * Copyright (C) 2003 Tresys Technology, LLC
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation, version 2.
+/* Updated: Frank Mayer <mayerf@tresys.com> and
+ *          Karl MacMillan <kmacmillan@tresys.com>
+ *          Added conditional policy language extensions
+ *          Copyright (C) 2003 Tresys Technology, LLC
  *
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
- *	Tuned number of hash slots for avtab to reduce memory usage
+ *          Tuned number of hash slots for avtab to reduce memory usage
  */
 
 #include <linux/bitops.h>
@@ -36,19 +33,20 @@ static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
 	static const u32 c2 = 0x1b873593;
 	static const u32 r1 = 15;
 	static const u32 r2 = 13;
-	static const u32 m  = 5;
-	static const u32 n  = 0xe6546b64;
+	static const u32 m = 5;
+	static const u32 n = 0xe6546b64;
 
 	u32 hash = 0;
 
-#define mix(input) do { \
-		u32 v = input; \
-		v *= c1; \
-		v = (v << r1) | (v >> (32 - r1)); \
-		v *= c2; \
-		hash ^= v; \
+#define mix(input)                                         \
+	do {                                               \
+		u32 v = input;                             \
+		v *= c1;                                   \
+		v = (v << r1) | (v >> (32 - r1));          \
+		v *= c2;                                   \
+		hash ^= v;                                 \
 		hash = (hash << r2) | (hash >> (32 - r2)); \
-		hash = hash * m + n; \
+		hash = hash * m + n;                       \
 	} while (0)
 
 	mix(keyp->target_class);
@@ -66,9 +64,10 @@ static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
 	return hash & mask;
 }
 
-static struct avtab_node*
-avtab_insert_node(struct avtab *h, struct avtab_node **dst,
-		  const struct avtab_key *key, const struct avtab_datum *datum)
+static struct avtab_node *avtab_insert_node(struct avtab *h,
+					    struct avtab_node **dst,
+					    const struct avtab_key *key,
+					    const struct avtab_datum *datum)
 {
 	struct avtab_node *newnode;
 	struct avtab_extended_perms *xperms;
@@ -99,7 +98,7 @@ avtab_insert_node(struct avtab *h, struct avtab_node **dst,
 static int avtab_node_cmp(const struct avtab_key *key1,
 			  const struct avtab_key *key2)
 {
-	u16 specified = key1->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
+	u16 specified = key1->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
 
 	if (key1->source_type == key2->source_type &&
 	    key1->target_type == key2->target_type &&
@@ -129,8 +128,7 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 		return -EINVAL;
 
 	hvalue = avtab_hash(key, h->mask);
-	for (prev = NULL, cur = h->htable[hvalue];
-	     cur;
+	for (prev = NULL, cur = h->htable[hvalue]; cur;
 	     prev = cur, cur = cur->next) {
 		cmp = avtab_node_cmp(key, &cur->key);
 		/* extended perms may not be unique */
@@ -163,8 +161,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 	if (!h || !h->nslot || h->nel == U32_MAX)
 		return NULL;
 	hvalue = avtab_hash(key, h->mask);
-	for (prev = NULL, cur = h->htable[hvalue];
-	     cur;
+	for (prev = NULL, cur = h->htable[hvalue]; cur;
 	     prev = cur, cur = cur->next) {
 		cmp = avtab_node_cmp(key, &cur->key);
 		if (cmp <= 0)
@@ -188,8 +185,7 @@ struct avtab_node *avtab_search_node(struct avtab *h,
 		return NULL;
 
 	hvalue = avtab_hash(key, h->mask);
-	for (cur = h->htable[hvalue]; cur;
-	     cur = cur->next) {
+	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
 		cmp = avtab_node_cmp(key, &cur->key);
 		if (cmp == 0)
 			return cur;
@@ -199,8 +195,8 @@ struct avtab_node *avtab_search_node(struct avtab *h,
 	return NULL;
 }
 
-struct avtab_node*
-avtab_search_node_next(struct avtab_node *node, u16 specified)
+struct avtab_node *avtab_search_node_next(struct avtab_node *node,
+					  u16 specified)
 {
 	struct avtab_key tmp_key;
 	struct avtab_node *cur;
@@ -314,17 +310,19 @@ void avtab_hash_eval(struct avtab *h, const char *tag)
 
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
-			chain2_len_sum += (unsigned long long)chain_len * chain_len;
+			chain2_len_sum +=
+				(unsigned long long)chain_len * chain_len;
 		}
 	}
 
 	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
-	       "longest chain length %d, sum of chain length^2 %llu\n",
-	       tag, h->nel, slots_used, h->nslot, max_chain_len,
-	       chain2_len_sum);
+		 "longest chain length %d, sum of chain length^2 %llu\n",
+		 tag, h->nel, slots_used, h->nslot, max_chain_len,
+		 chain2_len_sum);
 }
 #endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
+/* clang-format off */
 static const uint16_t spec_order[] = {
 	AVTAB_ALLOWED,
 	AVTAB_AUDITDENY,
@@ -336,6 +334,7 @@ static const uint16_t spec_order[] = {
 	AVTAB_XPERMS_AUDITALLOW,
 	AVTAB_XPERMS_DONTAUDIT
 };
+/* clang-format on */
 
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
@@ -365,9 +364,8 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		if (items2 > ARRAY_SIZE(buf32)) {
 			pr_err("SELinux: avtab: entry overflow\n");
 			return -EINVAL;
-
 		}
-		rc = next_entry(buf32, fp, sizeof(u32)*items2);
+		rc = next_entry(buf32, fp, sizeof(u32) * items2);
 		if (rc) {
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
@@ -400,8 +398,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			pr_err("SELinux: avtab: null entry\n");
 			return -EINVAL;
 		}
-		if ((val & AVTAB_AV) &&
-		    (val & AVTAB_TYPE)) {
+		if ((val & AVTAB_AV) && (val & AVTAB_TYPE)) {
 			pr_err("SELinux: avtab: entry has both access vectors and types\n");
 			return -EINVAL;
 		}
@@ -428,7 +425,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		return 0;
 	}
 
-	rc = next_entry(buf16, fp, sizeof(u16)*4);
+	rc = next_entry(buf16, fp, sizeof(u16) * 4);
 	if (rc) {
 		pr_err("SELinux: avtab: truncated entry\n");
 		return rc;
@@ -454,10 +451,11 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	}
 
 	if ((vers < POLICYDB_VERSION_XPERMS_IOCTL) &&
-			(key.specified & AVTAB_XPERMS)) {
+	    (key.specified & AVTAB_XPERMS)) {
 		pr_err("SELinux:  avtab:  policy version %u does not "
-				"support extended permissions rules and one "
-				"was specified\n", vers);
+		       "support extended permissions rules and one "
+		       "was specified\n",
+		       vers);
 		return -EINVAL;
 	} else if (key.specified & AVTAB_XPERMS) {
 		memset(&xperms, 0, sizeof(struct avtab_extended_perms));
@@ -471,7 +469,8 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
-		rc = next_entry(buf32, fp, sizeof(u32)*ARRAY_SIZE(xperms.perms.p));
+		rc = next_entry(buf32, fp,
+				sizeof(u32) * ARRAY_SIZE(xperms.perms.p));
 		if (rc) {
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
@@ -507,7 +506,6 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 	__le32 buf[1];
 	u32 nel, i;
 
-
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc < 0) {
 		pr_err("SELinux: avtab: truncated table\n");
@@ -561,7 +559,8 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
 		return rc;
 
 	if (cur->key.specified & AVTAB_XPERMS) {
-		rc = put_entry(&cur->datum.u.xperms->specified, sizeof(u8), 1, fp);
+		rc = put_entry(&cur->datum.u.xperms->specified, sizeof(u8), 1,
+			       fp);
 		if (rc)
 			return rc;
 		rc = put_entry(&cur->datum.u.xperms->driver, sizeof(u8), 1, fp);
@@ -570,7 +569,7 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
 		for (i = 0; i < ARRAY_SIZE(cur->datum.u.xperms->perms.p); i++)
 			buf32[i] = cpu_to_le32(cur->datum.u.xperms->perms.p[i]);
 		rc = put_entry(buf32, sizeof(u32),
-				ARRAY_SIZE(cur->datum.u.xperms->perms.p), fp);
+			       ARRAY_SIZE(cur->datum.u.xperms->perms.p), fp);
 	} else {
 		buf32[0] = cpu_to_le32(cur->datum.u.data);
 		rc = put_entry(buf32, sizeof(u32), 1, fp);
@@ -593,8 +592,7 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 		return rc;
 
 	for (i = 0; i < a->nslot; i++) {
-		for (cur = a->htable[i]; cur;
-		     cur = cur->next) {
+		for (cur = a->htable[i]; cur; cur = cur->next) {
 			rc = avtab_write_item(p, cur, fp);
 			if (rc)
 				return rc;
@@ -606,10 +604,9 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 
 void __init avtab_cache_init(void)
 {
-	avtab_node_cachep = kmem_cache_create("avtab_node",
-					      sizeof(struct avtab_node),
-					      0, SLAB_PANIC, NULL);
-	avtab_xperms_cachep = kmem_cache_create("avtab_extended_perms",
-						sizeof(struct avtab_extended_perms),
-						0, SLAB_PANIC, NULL);
+	avtab_node_cachep = kmem_cache_create(
+		"avtab_node", sizeof(struct avtab_node), 0, SLAB_PANIC, NULL);
+	avtab_xperms_cachep = kmem_cache_create(
+		"avtab_extended_perms", sizeof(struct avtab_extended_perms), 0,
+		SLAB_PANIC, NULL);
 }
-- 
2.43.2

