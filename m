Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D6C433F5
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 13:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577551AbiAYNeV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577260AbiAYNaW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 08:30:22 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0EC0613E5
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 05:30:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j2so62485330edj.8
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0ZCG2x9BIhts3HuaEeVlkcy24Io6AoekIyXorcz4T5o=;
        b=lSPi6PdoUAbEHY5PVyDrWnpiEmzmxYhgADl2bFC+89pl/srOOxM2foS8moIKGWXgwd
         JJX+yzIdbP7bdmuYELkmEl/HxQdzKYzuBkJUq3nySC1BQe5RBT5WVqhCLiWIha4gQahu
         Hb4A64B+i0FaMc9Fr9p86HflN2EnNp/oVlmKl+Cn9gNbw7uuEQ+YORbvivuA4NyTLyWs
         HnHfJOSy42GsuCDYPsA40lDtcSF3yFLQTT+XsJihVLPYk6iaNxSz+bvub3zx7TD26P13
         nm2I0hMiKyj/0p6Oa5VFGcONrcAsYwjUb7aOthmdCujEB5Qv5FmROA/y9NgA7tHnNqGc
         Qgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZCG2x9BIhts3HuaEeVlkcy24Io6AoekIyXorcz4T5o=;
        b=akT5pdOCD6vhZlGKTA9776sLFT0fDrKpS1dxWu+e7EsLfQdzqA5xRCyG8XSF5LhlyQ
         Y2fgFPh5mCBKe+uIQIqm1ZfSRb8QTCyZg1o1m5Zlni3QCx31JBHxB/NcwwNQWcNDwNcF
         YB8eGzHasu3y9owYR+zwXtc7riBmUVA4YuIvdCWIkbviwB5coQOKTogNNIiR5+E+f6hR
         7Mv2GfsNwevI154xU2rwv/HO1cAWJmyDPbQzRlQRmPZ7DN/gcD6pK+7ZhsJA5l2fUoBD
         1QdqQmxEe3NQZvP3Y6Zg2kIBcsOFb9yWbryyMw6MtopleG4lROw71vPOsOTl3CqsLNge
         PCXA==
X-Gm-Message-State: AOAM532QdfOJ+H5b1sESqThhCh7BXbd7lbNnt+vO0ta1MwSm9PliJdkB
        +7426zrtechqsdkYfvZHEbFNdPHGprY=
X-Google-Smtp-Source: ABdhPJz+C7YYBTK/vVzLAPzQTUfKyCuO8oLaOoQYRZ2A3P6tA8RISBZ13rs2FooUcUlBzLtk6PDJOQ==
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr9489260edd.8.1643117419386;
        Tue, 25 Jan 2022 05:30:19 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id t15sm6218090eju.1.2022.01.25.05.30.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 05:30:18 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3] libsepol: handle type gaps
Date:   Tue, 25 Jan 2022 14:30:09 +0100
Message-Id: <20220125133009.21405-1-cgzones@googlemail.com>
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
v3:
   - drop extra error blocks in kernel_to_(cil|conf).c in favor of a
     simple non-NULL check, as writing policies between version 20 and
     23 is not supported and previously checked
   - refuse to optimize policies between version 20 and 23 altogether
     and simplify NULL checks

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c  | 10 +++++-----
 libsepol/src/kernel_to_conf.c |  8 ++++----
 libsepol/src/optimize.c       | 21 +++++++++++++++++++--
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 18294a9a..693206d2 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1227,7 +1227,7 @@ static int write_type_attributes_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
-		if (type->flavor == TYPE_ATTRIB) {
+		if (type && type->flavor == TYPE_ATTRIB) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
 				goto exit;
@@ -1357,7 +1357,7 @@ static int write_type_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
-		if (type->flavor == TYPE_TYPE && type->primary) {
+		if (type && type->flavor == TYPE_TYPE && type->primary) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
 				goto exit;
@@ -1486,7 +1486,7 @@ static int write_type_bounds_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
-		if (type->flavor == TYPE_TYPE) {
+		if (type && type->flavor == TYPE_TYPE) {
 			if (type->bounds > 0) {
 				rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 				if (rc != 0) {
@@ -1540,7 +1540,7 @@ static int write_type_attribute_sets_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		attr = pdb->type_val_to_struct[i];
-		if (attr->flavor != TYPE_ATTRIB) continue;
+		if (!attr || attr->flavor != TYPE_ATTRIB) continue;
 		name = pdb->p_type_val_to_name[i];
 		typemap = &pdb->attr_type_map[i];
 		if (ebitmap_is_empty(typemap)) continue;
@@ -2273,7 +2273,7 @@ static int write_role_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type_datum = pdb->type_val_to_struct[i];
-		if (type_datum->flavor == TYPE_TYPE && type_datum->primary) {
+		if (type_datum && type_datum->flavor == TYPE_TYPE && type_datum->primary) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
 				goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index a92ba9fd..52b6c60f 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1210,7 +1210,7 @@ static int write_type_attributes_to_conf(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
-		if (type->flavor == TYPE_ATTRIB) {
+		if (type && type->flavor == TYPE_ATTRIB) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
 				goto exit;
@@ -1340,7 +1340,7 @@ static int write_type_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
-		if (type->flavor == TYPE_TYPE && type->primary) {
+		if (type && type->flavor == TYPE_TYPE && type->primary) {
 			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 			if (rc != 0) {
 				goto exit;
@@ -1460,7 +1460,7 @@ static int write_type_bounds_rules_to_conf(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
-		if (type->flavor == TYPE_TYPE) {
+		if (type && type->flavor == TYPE_TYPE) {
 			if (type->bounds > 0) {
 				rc = strs_add(strs, pdb->p_type_val_to_name[i]);
 				if (rc != 0) {
@@ -1583,7 +1583,7 @@ static int write_type_attribute_sets_to_conf(FILE *out, struct policydb *pdb)
 
 	for (i=0; i < pdb->p_types.nprim; i++) {
 		type = pdb->type_val_to_struct[i];
-		if (type->flavor != TYPE_TYPE || !type->primary) continue;
+		if (!type || type->flavor != TYPE_TYPE || !type->primary) continue;
 		if (ebitmap_cardinality(&pdb->type_attr_map[i]) == 1) continue;
 
 		rc = ebitmap_cpy(&attrmap, &pdb->type_attr_map[i]);
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 8a048702..93ff2116 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -31,6 +31,7 @@
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
 
+#include "debug.h"
 #include "private.h"
 
 #define TYPE_VEC_INIT_SIZE 16
@@ -104,6 +105,9 @@ static struct type_vec *build_type_map(const policydb_t *p)
 		if (type_vec_init(&map[i]))
 			goto err;
 
+		if (!p->type_val_to_struct[i])
+			continue;
+
 		if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
 			ebitmap_for_each_positive_bit(&p->type_attr_map[i],
 						      n, k) {
@@ -114,11 +118,13 @@ static struct type_vec *build_type_map(const policydb_t *p)
 			ebitmap_t *types_i = &p->attr_type_map[i];
 
 			for (k = 0; k < p->p_types.nprim; k++) {
-				ebitmap_t *types_k = &p->attr_type_map[k];
+				const ebitmap_t *types_k;
 
-				if (p->type_val_to_struct[k]->flavor != TYPE_ATTRIB)
+				if (!p->type_val_to_struct[k] || p->type_val_to_struct[k]->flavor != TYPE_ATTRIB)
 					continue;
 
+				types_k = &p->attr_type_map[k];
+
 				if (ebitmap_contains(types_k, types_i)) {
 					if (type_vec_append(&map[i], k))
 						goto err;
@@ -438,6 +444,17 @@ int policydb_optimize(policydb_t *p)
 	if (p->policy_type != POLICY_KERN)
 		return -1;
 
+	if (p->policyvers >= POLICYDB_VERSION_AVTAB && p->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+		/*
+		 * For policy versions between 20 and 23, attributes exist in the policy,
+		 * but only in the type_attr_map. This means that there are gaps in both
+		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
+		 * can refer to those gaps.
+		 */
+		ERR(NULL, "Optimizing policy versions between 20 and 23 is not supported");
+		return -1;
+	}
+
 	type_map = build_type_map(p);
 	if (!type_map)
 		return -1;
-- 
2.34.1

