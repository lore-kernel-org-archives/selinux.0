Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD55C4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241342AbhLIQzU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhLIQzU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:20 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB16C0617A2
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v1so21771287edx.2
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WXG7EiXb1kMGnHSKuSVv8YNkA0eGeqB190yhbehi3aY=;
        b=NIPUxAek/LnGIzZJCHihssWgLUdw2rfK+vgkEfORMA7y/jcVNjwHQQNd/lS7b+cwyt
         Wc7KiEEDZBL1pWXpL6hh6jfq8bNvIHr4R/oa42K8vlHXUwiPvieUDiE7QQb1PX37euR1
         P3dcI8c1m6g3uZFZj3qDMgyde72O1G31f8xzW16+Q2JyVgELml30xwpe91ak/elVaPUC
         iP7PfeIpFzSkS5jkK1KlK/SSlm2VfN1Yjh1Al4b0ofxwbcVvg7nL5hw3o4yt5vfV6e32
         81WqTi+6w3A0hzZJ3jp0UIG5jUng/lv3DrDH0M2QyP/NQqb8Samzw7+AgIcr+xTHiUX0
         i3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXG7EiXb1kMGnHSKuSVv8YNkA0eGeqB190yhbehi3aY=;
        b=gvfuwj/QnxkAfoC5ZcBs2AgTfG4FKIjpoqt6C6Oh4555MwoLkjTIrSmznTtMJfcqph
         e25wa64sLUD5Gu/cj3m1JHAMvmccjhHoWIsHruBYeKUdGDV9Hup7i05Rix2D18/xBqtj
         R9Voq+yLJ0OS8LiS1JqYknD+1RFAOMxthEeQ3KIg3qPGzBzn9dx4wMgv2yyVy4SthIUt
         6l2qbbOWNWOhyfqbi9tdHlnery3XcMOSV9AG+vAYkUPfl4af5xozVkPrfaNnBzdUW4/n
         JHED3ZHbSFFBGoXDhQI0jE4F50Wr56fm9IGvAM/8MO6hTBH2CkiVrDBL1L2r74ASV28g
         qLfg==
X-Gm-Message-State: AOAM532sPbFf+EONwruUjYHw5AniPbcLTPMal5sc4bapRzFtNIKTrgjS
        d6LIuYBTjqJY59ngDK1tjATmYQO+YE8=
X-Google-Smtp-Source: ABdhPJxcmdrm37rUiaa7tqAedI7AWr0sx/xmdoV0620GTeSu4SYfkEcsvSYVDdh93FctTDEu/+yC6w==
X-Received: by 2002:a17:906:3b54:: with SMTP id h20mr16788924ejf.468.1639068587392;
        Thu, 09 Dec 2021 08:49:47 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:47 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 18/36] libsepol: do not crash on class gaps
Date:   Thu,  9 Dec 2021 17:49:10 +0100
Message-Id: <20211209164928.87459-19-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
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
index b81cdb22..d9afdda6 100644
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
index 460209c8..92a342d1 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -362,7 +362,7 @@ static int constraint_rules_to_strs(struct policydb *pdb, struct strs *mls_strs,
 
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
-		if (class->constraints) {
+		if (class && class->constraints) {
 			name = pdb->p_class_val_to_name[i];
 			rc = class_constraint_rules_to_strs(pdb, name, class, class->constraints, mls_strs, non_mls_strs);
 			if (rc != 0) {
@@ -387,7 +387,7 @@ static int validatetrans_rules_to_strs(struct policydb *pdb, struct strs *mls_st
 
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
-		if (class->validatetrans) {
+		if (class && class->validatetrans) {
 			name = pdb->p_class_val_to_name[i];
 			rc = class_validatetrans_rules_to_strs(pdb, name, class->validatetrans, mls_strs, non_mls_strs);
 			if (rc != 0) {
@@ -555,6 +555,7 @@ static int write_class_and_common_rules_to_conf(FILE *out, struct policydb *pdb)
 	}
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		name = class->comkey;
 		if (!name) continue;
 		common = hashtab_search(pdb->p_commons.table, name);
@@ -581,6 +582,7 @@ static int write_class_and_common_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* class */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		name = pdb->p_class_val_to_name[i];
 		sepol_printf(out, "class %s", name);
 		if (class->comkey) {
@@ -706,6 +708,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* default_user */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_user != 0) {
 			rc = write_default_user_to_conf(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
@@ -717,6 +720,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* default_role */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_role != 0) {
 			rc = write_default_role_to_conf(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
@@ -728,6 +732,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* default_type */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_type != 0) {
 			rc = write_default_type_to_conf(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
@@ -743,6 +748,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 	/* default_range */
 	for (i=0; i < pdb->p_classes.nprim; i++) {
 		class = pdb->class_val_to_struct[i];
+		if (!class) continue;
 		if (class->default_range != 0) {
 			rc = write_default_range_to_conf(out, pdb->p_class_val_to_name[i], class);
 			if (rc != 0) {
-- 
2.34.1

