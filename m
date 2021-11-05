Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C357BC433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75C861183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhKEPsp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhKEPsl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8772C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r4so33724415edi.5
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P9XC6zTxORKByCdyHSA20Qhzw9U5tKnSO5rDOttqLZo=;
        b=H+dNzxmQkXsnan59hVxlSoa+dsGob3/1uQwgcpR24j2YqAhzwBJu7enMFtWzfrxv4R
         88V1aHZ6VE+wsxtsk0OfM9x4b4EpGARhtxAVduK4YdkisjOQlE049uAxtm2b19y8Dfo3
         61BBX2Zwx6jj7p+OamG239hpJd+/LZjRcgeINmm9wCvBk3NoDu8J+5KX24tuRm/ZRw61
         TxAMReMKKA739Hjiw3xFLLkwUFovSxSuS/C2fv4Fgd2YiPAUw8KRwsXmJiR7uhJrJEIP
         nLxQSfa+nQ+z3H5x/KNpvF786LiX8So8bC+2ChKg8TGOM5Xr5B4LljLhIgzU4SumJ9d6
         txDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9XC6zTxORKByCdyHSA20Qhzw9U5tKnSO5rDOttqLZo=;
        b=UfbFSi17RuoTVC8H4Lw6D6w0pY/wEnCywg09Bh/1wVe5v7GIavB3j9z8e9xhG3n8Bl
         +1H+4qitf5OUMxWQzMXpfwWmAvQlS0vs62cEy/wLRwhe0HGF9xe2Jqe0ou2K82GZc47O
         JOSU7zZN2e+qWpFzXCdIS41kXNQ0+LyB8jvDBo3Ea2SWIf9Y9L/mgnDKGzUotZxs829u
         hVq1GkYuCy5b9FnTs/pmHDNneB+B+uVREVRVGShn65sjwdmxObYWBi6ISft7dXif+uR9
         7ZZrMDxtczRoIYR6yYUMRZS+q7E6UT9nbSLr9pH3Vud32r+DVMMe76s2KE/INZzfLK/U
         bIJQ==
X-Gm-Message-State: AOAM530oGjOXodNlfWj1Nt5SY4gdingZUXsux0+PXpXdS82YTM9ybNgj
        9GADUkNyWCDHGF9i15f9y+OERbaesSM=
X-Google-Smtp-Source: ABdhPJzqQPEesZ+O2vLp0xlt8mcJWTq+lvMM9Cr01s8zrZcpJ8Iku6ZUuKT/CLCz6VPWixMqqXidaQ==
X-Received: by 2002:a17:906:314e:: with SMTP id e14mr73317106eje.165.1636127156561;
        Fri, 05 Nov 2021 08:45:56 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 18/36] libsepol: do not crash on class gaps
Date:   Fri,  5 Nov 2021 16:45:20 +0100
Message-Id: <20211105154542.38434-19-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Handle gaps in the class table while printing a policy configuration.

    ==21763==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000028 (pc 0x00000055b696 bp 0x7ffe69e8ab50 sp 0x7ffe69e8aa60 T0)
    ==21763==The signal is caused by a READ memory access.
    ==21763==Hint: address points to the zero page.
        #0 0x55b696 in constraint_rules_to_strs ./libsepol/src/kernel_to_conf.c:361:14
        #1 0x55ac80 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3063:7
        #2 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #3 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #4 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #5 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #6 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #7 0x7fc60d39e7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #8 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c  |  9 +++++++++
 libsepol/src/kernel_to_conf.c | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 305567a5..bb167647 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -358,6 +358,7 @@ static int constraint_rules_to_strs(struct policydb *pdb, struct strs *mls_strs,
 
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->constraints) {
 			name = pdb->p_class_val_to_name[i];
 			rc = class_constraint_rules_to_strs(pdb, name, class, class->constraints, mls_strs, non_mls_strs);
@@ -383,6 +384,7 @@ static int validatetrans_rules_to_strs(struct policydb *pdb, struct strs *mls_st
 
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->validatetrans) {
 			name = pdb->p_class_val_to_name[i];
 			rc = class_validatetrans_rules_to_strs(pdb, name, class->validatetrans, mls_strs, non_mls_strs);
@@ -461,6 +463,7 @@ static int write_class_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 	/* class */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		name = pdb->p_class_val_to_name[i];
 		perms = class_or_common_perms_to_str(&class->permissions);
 		if (perms) {
@@ -488,6 +491,7 @@ static int write_class_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 	/* classcommon */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		name = pdb->p_class_val_to_name[i];
 		if (class->comkey != NULL) {
 			sepol_printf(out, "(classcommon %s %s)\n", name, class->comkey);
@@ -503,6 +507,7 @@ static int write_class_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 	}
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		name = class->comkey;
 		if (name != NULL) {
 			common = hashtab_search(pdb->p_commons.table, name);
@@ -727,6 +732,7 @@ static int write_default_rules_to_cil(FILE *out, struct policydb *pdb)
 	/* default_user */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_user != 0) {
 			rc = write_default_user_to_cil(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
@@ -738,6 +744,7 @@ static int write_default_rules_to_cil(FILE *out, struct policydb *pdb)
 	/* default_role */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_role != 0) {
 			rc = write_default_role_to_cil(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
@@ -749,6 +756,7 @@ static int write_default_rules_to_cil(FILE *out, struct policydb *pdb)
 	/* default_type */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_type != 0) {
 			rc = write_default_type_to_cil(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
@@ -764,6 +772,7 @@ static int write_default_rules_to_cil(FILE *out, struct policydb *pdb)
 	/* default_range */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_range) {
 			rc = write_default_range_to_cil(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index eb72e4ac..b2a42606 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -358,7 +358,7 @@ static int constraint_rules_to_strs(struct policydb *pdb, struct strs *mls_strs,
 
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
-		if (class->constraints) {
+		if (class && class->constraints) {
 			name = pdb->p_class_val_to_name[i];
 			rc = class_constraint_rules_to_strs(pdb, name, class, class->constraints, mls_strs, non_mls_strs);
 			if (rc != 0) {
@@ -383,7 +383,7 @@ static int validatetrans_rules_to_strs(struct policydb *pdb, struct strs *mls_st
 
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
-		if (class->validatetrans) {
+		if (class && class->validatetrans) {
 			name = pdb->p_class_val_to_name[i];
 			rc = class_validatetrans_rules_to_strs(pdb, name, class->validatetrans, mls_strs, non_mls_strs);
 			if (rc != 0) {
@@ -551,6 +551,7 @@ static int write_class_and_common_rules_to_conf(FILE *out, struct policydb *pdb)
 	}
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		name = class->comkey;
 		if (!name) continue;
 		common = hashtab_search(pdb->p_commons.table, name);
@@ -577,6 +578,7 @@ static int write_class_and_common_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* class */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		name = pdb->p_class_val_to_name[i];
 		sepol_printf(out, "class %s", name);
 		if (class->comkey) {
@@ -702,6 +704,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* default_user */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_user != 0) {
 			rc = write_default_user_to_conf(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
@@ -713,6 +716,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* default_role */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_role != 0) {
 			rc = write_default_role_to_conf(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
@@ -724,6 +728,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* default_type */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_type != 0) {
 			rc = write_default_type_to_conf(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
@@ -739,6 +744,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* default_range */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_range != 0) {
 			rc = write_default_range_to_conf(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
-- 
2.33.1

