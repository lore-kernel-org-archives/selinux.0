Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6261FC433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BBC360E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhJKQ2i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhJKQ2e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8508BC061764
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d3so42460752edp.3
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xW0/0u0OzRrm/2nH3UPZcwq0R3g21WYD6qMNqSPyGuM=;
        b=gdLXL54iLMiUsvBNU15T4ewhchMRBPTfDUrKuatfsHzstABNjATowBue0Nzi2UdjOH
         G7PPxsfAw6XQ6Ze8j3Ac/dLc9Sv5xsQ/oO5lREYW3ANDb6e/6H3sac/YcRxdQiQeRV+/
         7nzllgS4pWidpbueLxERsQLMVdAC5utH2Ke0mrb6aW2Ya2BlijwZsu8Qotfu9NvGrtW7
         SApHy1O29bHEKpTJqWvshfEdkNKtXm3w8UcBKYdl9kemHk5Yy0kJhKDD0/3Rjc4tYBiC
         XGISFn5YM/auvb0TPRtlzf0V1dYObQd2ULlryQyWhiXHrn+7u/28ckMYxBqFH4SNld4M
         +Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xW0/0u0OzRrm/2nH3UPZcwq0R3g21WYD6qMNqSPyGuM=;
        b=fffgme6yyRgeeYLGCvgSFdsJLaxQtHHlvqXAzzqsuRKVEP/sBl4O2iWdjtnXil/J//
         L1ih6p0tyEPTGM/WVeDPpw9KjYlcbHeCQSL0xRqbccqrxqxc6BWikmTdvRj9QzjrHZ6/
         Km8INeD+4XITasZfOTmHAEhfD3STbtjyVlorsDjSroxXxCl0kRZB51gVMZjfbGM3yuAt
         flrsAq3r0O6BycPEh28ZvRwfAEkGjU590PHL+l9BvXmXvUoIQFUVgMN/ho99uZbjhLy5
         tulvhB1L77kQEVDhPyfP78T0cVwqlmwUNIrTLfBhlQ8Njk/rl7Jpn7EI6YsR/k8K4bgW
         BIcA==
X-Gm-Message-State: AOAM533VQ/p6Gk38Zx4Siq+M/tk6euCgaW5/5L9nObOnLrfSnykWMF22
        E3eryO31I53qnJbLSpcNWfcO1L0+ZVU=
X-Google-Smtp-Source: ABdhPJwrLB3fh3sWo4DjUmxbsyIyzP9tvSYV9+Vh3FTIdweZmjkizUQVFsYOww8b0MeInhOWR8tQXw==
X-Received: by 2002:a17:906:608e:: with SMTP id t14mr26409159ejj.441.1633969592013;
        Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 20/35] libsepol: do not crash on class gaps
Date:   Mon, 11 Oct 2021 18:25:18 +0200
Message-Id: <20211011162533.53404-21-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
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
2.33.0

