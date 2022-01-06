Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D74C433F5
	for <selinux@archiver.kernel.org>; Thu,  6 Jan 2022 20:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbiAFUmg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jan 2022 15:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243837AbiAFUmg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jan 2022 15:42:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33420C061245
        for <selinux@vger.kernel.org>; Thu,  6 Jan 2022 12:42:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bm14so14074785edb.5
        for <selinux@vger.kernel.org>; Thu, 06 Jan 2022 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xCUUlbNxhWPHgD71Ej/U1JLPPac4TiAGsaoV4AvwREQ=;
        b=O3Y3mvSDp40Ps35hSxTzKhWFfj+7n7spNeT+Qi/Y8wenErNhkZhgvNXnq3zxZCZ5a+
         QNaAMUJ6mcnNjhG1s7YJlG9k7+IxdUgMBLqGyl2HM0dDIUuKFG2lGzpAh4TVq9Xd/dZ8
         DU4o98uLqMmx7hQozTmQKVYJfqDfbQ1AmQIHFGlXVhCdHu2sx7+0vSep3eAHmmLbLKg0
         qxoMEY7+Vf3GJZWrzt7OvVHN8mWvShMvZNmHyWNVG2tZyV0RJ0XCCYbad/fs6X7AreTF
         7D/yWjBQ+oDtg/spcDhni366UH0pvaTyBWSy+HZgoIyZRDL307tapPqVeslX5swPfs4e
         XnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCUUlbNxhWPHgD71Ej/U1JLPPac4TiAGsaoV4AvwREQ=;
        b=cNdE5HD6wJNSf4u/6Iv8L2PelsSUEdmjbBc0AZZHfNknkqVlxptn0xChJBImCTVdNF
         ffTje5vLL+SA3MydrPjI836+Xj9OEjoDjtLRyA/L9SXWs4at9seZuAsp7bVrW63HG5AK
         2ZPq/FliR7nkrcW9LC89BsqsJexmE/XRgQJUaj6rRNrYBWg6SL4ZbVdunjimE2IDEpi5
         06qCAQsuQbEiJPhHFjmmJbzum6ftS3YuURJASI2/hHqNYbFGsJWZ/CRVMX9u/bWVpFAZ
         pc78oXGj4i4rb5Qc7+RbiPhb2hpSpHZL1rsgUk/wBf72qitNm+rynm+Ma56rnVw8zHAo
         Qh9A==
X-Gm-Message-State: AOAM530Xarl/E6crXV4lWw6FoE0/3ZiGh3YCsQJgWKu180VpjdBH8Nfa
        UieAYWLOO8q35JYuXdYvRdDz/hXxFSU=
X-Google-Smtp-Source: ABdhPJyM3Q3qh/8STCeHAAyv8NQ+Oa7Xx7f+aCX+SbyAuLbyI48fEWvPoB7F2W/p3om+Lj+nKo7KuQ==
X-Received: by 2002:a17:906:17c6:: with SMTP id u6mr6331605eje.263.1641501754712;
        Thu, 06 Jan 2022 12:42:34 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-024-211.77.1.pool.telefonica.de. [77.1.24.211])
        by smtp.gmail.com with ESMTPSA id 4sm769858ejc.168.2022.01.06.12.42.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 12:42:34 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libsepol: handle type gaps
Date:   Thu,  6 Jan 2022 21:42:26 +0100
Message-Id: <20220106204226.146879-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211223185004.77862-1-cgzones@googlemail.com>
References: <20211223185004.77862-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For policy versions between 20 and 23 the type_val_to_struct array might
contain gaps. Skip those gaps to avoid NULL pointer dereferences:

    ==1250==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000008 (pc 0x00000058560b bp 0x7ffdca60c110 sp 0x7ffdca60bfc0 T0)
    ==1250==The signal is caused by a READ memory access.
    ==1250==Hint: address points to the zero page.
        #0 0x58560b in build_type_map selinux/libsepol/src/optimize.c:107:33
        #1 0x58560b in policydb_optimize selinux/libsepol/src/optimize.c:441:13
        #2 0x55e63e in LLVMFuzzerTestOneInput selinux/libsepol/fuzz/binpolicy-fuzzer.c:42:10
        #3 0x455283 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) cxa_noexception.cpp:0
        #4 0x440ec2 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:324:6
        #5 0x44671c in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) cxa_noexception.cpp:0
        #6 0x46f522 in main /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:10
        #7 0x7f9c160d00b2 in __libc_start_main /build/glibc-eX1tMB/glibc-2.31/csu/libc-start.c:308:16
        #8 0x41f67d in _start

Found by oss-fuzz (#42697)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
@Jim:
    I hope I have interpreted and implemented your feedback correctly, but I
    am not sure I have seen through the whole gaps logic yet.
---
 libsepol/src/kernel_to_cil.c  | 40 +++++++++++++++++++++++++++++++++++
 libsepol/src/kernel_to_conf.c | 32 ++++++++++++++++++++++++++++
 libsepol/src/optimize.c       | 18 +++++++++++++++-
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 18294a9a..1353e77f 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1227,6 +1227,14 @@ static int write_type_attributes_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!type) {
+			if (pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+				rc = -1;
+				goto exit;
+			}
+			continue;
+		}
 		if (type->flavor == TYPE_ATTRIB) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
@@ -1357,6 +1365,14 @@ static int write_type_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!type) {
+			if (pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+				rc = -1;
+				goto exit;
+			}
+			continue;
+		}
 		if (type->flavor == TYPE_TYPE && type->primary) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
@@ -1486,6 +1502,14 @@ static int write_type_bounds_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!type) {
+			if (pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+				rc = -1;
+				goto exit;
+			}
+			continue;
+		}
 		if (type->flavor == TYPE_TYPE) {
 			if (type->bounds > 0) {
 				rc = strs_add(strs, pdb->p_type_val_to_name[i]);
@@ -1540,6 +1564,14 @@ static int write_type_attribute_sets_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		attr = pdb->type_val_to_struct[i];
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!attr) {
+			if (pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+				rc = -1;
+				goto exit;
+			}
+			continue;
+		}
 		if (attr->flavor != TYPE_ATTRIB) continue;
 		name = pdb->p_type_val_to_name[i];
 		typemap = &pdb->attr_type_map[i];
@@ -2273,6 +2305,14 @@ static int write_role_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type_datum = pdb->type_val_to_struct[i];
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!type_datum) {
+			if (pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+				rc = -1;
+				goto exit;
+			}
+			continue;
+		}
 		if (type_datum->flavor == TYPE_TYPE && type_datum->primary) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index a92ba9fd..235b4556 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1210,6 +1210,14 @@ static int write_type_attributes_to_conf(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!type) {
+			if (pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+				rc = -1;
+				goto exit;
+			}
+			continue;
+		}
 		if (type->flavor == TYPE_ATTRIB) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
@@ -1340,6 +1348,14 @@ static int write_type_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!type) {
+			if (pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+				rc = -1;
+				goto exit;
+			}
+			continue;
+		}
 		if (type->flavor == TYPE_TYPE && type->primary) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
@@ -1460,6 +1476,14 @@ static int write_type_bounds_rules_to_conf(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!type) {
+			if (pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+				rc = -1;
+				goto exit;
+			}
+			continue;
+		}
 		if (type->flavor == TYPE_TYPE) {
 			if (type->bounds > 0) {
 				rc = strs_add(strs, pdb->p_type_val_to_name[i]);
@@ -1583,6 +1607,14 @@ static int write_type_attribute_sets_to_conf(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!type) {
+			if (pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+				rc = -1;
+				goto exit;
+			}
+			continue;
+		}
 		if (type->flavor != TYPE_TYPE || !type->primary) continue;
 		if (ebitmap_cardinality(&pdb->type_attr_map[i]) == 1) continue;
 
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 8a048702..f8c28313 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -104,6 +104,13 @@ static struct type_vec *build_type_map(const policydb_t *p)
 		if (type_vec_init(&map[i]))
 			goto err;
 
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!p->type_val_to_struct[i]) {
+			if (p->policyvers <= POLICYDB_VERSION_PERMISSIVE)
+				goto err;
+			continue;
+		}
+
 		if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
 			ebitmap_for_each_positive_bit(&p->type_attr_map[i],
 						      n, k) {
@@ -114,11 +121,20 @@ static struct type_vec *build_type_map(const policydb_t *p)
 			ebitmap_t *types_i = &p->attr_type_map[i];
 
 			for (k = 0; k < p->p_types.nprim; k++) {
-				ebitmap_t *types_k = &p->attr_type_map[k];
+				ebitmap_t *types_k;
+
+				/* Gap in types for policy versions between 20 and 23 */
+				if (!p->type_val_to_struct[k]) {
+					if (p->policyvers <= POLICYDB_VERSION_PERMISSIVE)
+						goto err;
+					continue;
+				}
 
 				if (p->type_val_to_struct[k]->flavor != TYPE_ATTRIB)
 					continue;
 
+				types_k = &p->attr_type_map[k];
+
 				if (ebitmap_contains(types_k, types_i)) {
 					if (type_vec_append(&map[i], k))
 						goto err;
-- 
2.34.1

