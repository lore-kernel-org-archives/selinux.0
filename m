Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47552C433EF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E02760EDF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhKJOuZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhKJOuZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 09:50:25 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B3CC061766
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:37 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 132so2641684qkj.11
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FLde+TUN2GD7WYpi90EFLOAF2vnWrJbea/kbbF4RLUs=;
        b=RqUtdIp3o/CtzyvZlYda7cumKEKMftHjFkG/fDcf/E5Ii55YVXIQqz17HY39Sz5D1g
         Fz76L6uaU6IpRKi0raTl99sGf//rn9rRTHOh5XJ1PLmPV2PulpK84rPxatpTITEWQD+e
         Ehs6ns3EFu2BJLDiJLmnyEFJnATFCZ9nyUqPsEhcZFmv/lT6Tdt263MUYuBzjtFa+nwi
         SVr3kB4f5KnEnqTjD3MaHX1LELo4dcZqk+MeLX5V1zsmMPd10LvUP5dbxFgCqEjtjIgS
         bzQWDxgBZ/CPkYxccdPwLIa95mTWI1o59aohnRQ0SaPzS9IdV+EG/wvXWqmJVtf1WV//
         yVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLde+TUN2GD7WYpi90EFLOAF2vnWrJbea/kbbF4RLUs=;
        b=mC0hw1FGrBLLvxyKHZzzhLHHRcWj3iyGwBcPRURItBDH2gQRLkO89XqIfe6OvlzESy
         gV4dyfxwXoCiyhOlDp2yTEelIosYJbt5h+g3cMy2WXKdhfmsR2YngnGpWueyRPCt3+26
         Ee16qiTgpu3tgxyrNMfSaUfWqv+MkCLXOV+PjBZmAJ79IX2tsZXnxf0wHyX9rCZwsCst
         EMEKDGK8dl6TRslBmMAIIhiVN7UB6ge9wzSck4xIz3rpBUn0yFQUCfr2oG4rfFr848yi
         W0seAJgl0PnVJU80+w+a3yeLb5TsD/s11Rx/HUVUVIZQPvlJDETWKQMaNwa1MMicYsAP
         kvRg==
X-Gm-Message-State: AOAM531hrWrYImFBCCm1byvn1PTcK6PkBQSJ8tMkaAxZ26G5EjfiWJJn
        wLQ5yzkKtmxtqEnAVqDoacvPHaRhHjw=
X-Google-Smtp-Source: ABdhPJzQO5ZLGST8oRTr0kbShyotlgfXF8shrmir51qNn/CYTBzapWZwCf/lbyX4Asdn12lLD6Rz3g==
X-Received: by 2002:a37:f902:: with SMTP id l2mr176449qkj.511.1636555656710;
        Wed, 10 Nov 2021 06:47:36 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r10sm58633qta.27.2021.11.10.06.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:47:36 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, stephen.smalley.work@gmail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/5] libsepol: Write out genfscon file type when writing out CIL policy
Date:   Wed, 10 Nov 2021 09:47:27 -0500
Message-Id: <20211110144727.1467744-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110144727.1467744-1-jwcart2@gmail.com>
References: <20211110144727.1467744-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With an optional file type being added to CIL genfscon rules, it
should be used when writing out a kernel policy or module to CIL
when a genfscon rule should only apply to a single security class.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Reordered if else blocks to have consistent ordering.

 libsepol/src/kernel_to_cil.c | 35 +++++++++++++++++++++++++++++++++--
 libsepol/src/module_to_cil.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 305567a5..ad92a7bc 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2640,6 +2640,8 @@ static int write_genfscon_rules_to_cil(FILE *out, struct policydb *pdb)
 	struct ocontext *ocon;
 	struct strs *strs;
 	char *fstype, *name, *ctx;
+	uint32_t sclass;
+	const char *file_type;
 	int rc;
 
 	rc = strs_init(&strs, 32);
@@ -2652,14 +2654,43 @@ static int write_genfscon_rules_to_cil(FILE *out, struct policydb *pdb)
 			fstype = genfs->fstype;
 			name = ocon->u.name;
 
+			sclass = ocon->v.sclass;
+			file_type = NULL;
+			if (sclass) {
+				const char *class_name = pdb->p_class_val_to_name[sclass-1];
+				if (strcmp(class_name, "file") == 0) {
+					file_type = "file";
+				} else if (strcmp(class_name, "dir") == 0) {
+					file_type = "dir";
+				} else if (strcmp(class_name, "chr_file") == 0) {
+					file_type = "char";
+				} else if (strcmp(class_name, "blk_file") == 0) {
+					file_type = "block";
+				} else if (strcmp(class_name, "sock_file") == 0) {
+					file_type = "socket";
+				} else if (strcmp(class_name, "fifo_file") == 0) {
+					file_type = "pipe";
+				} else if (strcmp(class_name, "lnk_file") == 0) {
+					file_type = "symlink";
+				} else {
+					rc = -1;
+					goto exit;
+				}
+			}
+
 			ctx = context_to_str(pdb, &ocon->context[0]);
 			if (!ctx) {
 				rc = -1;
 				goto exit;
 			}
 
-			rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s)", 3,
-						 fstype, name, ctx);
+			if (file_type) {
+				rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s %s)", 4,
+										 fstype, name, file_type, ctx);
+			} else {
+				rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s)", 3,
+										 fstype, name, ctx);
+			}
 			free(ctx);
 			if (rc != 0) {
 				goto exit;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 16e4004e..c80937e8 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2961,10 +2961,35 @@ static int genfscon_to_cil(struct policydb *pdb)
 {
 	struct genfs *genfs;
 	struct ocontext *ocon;
+	uint32_t sclass;
 
 	for (genfs = pdb->genfs; genfs != NULL; genfs = genfs->next) {
 		for (ocon = genfs->head; ocon != NULL; ocon = ocon->next) {
-			cil_printf("(genfscon %s \"%s\" ", genfs->fstype, ocon->u.name);
+			sclass = ocon->v.sclass;
+			if (sclass) {
+				const char *file_type;
+				const char *class_name = pdb->p_class_val_to_name[sclass-1];
+				if (strcmp(class_name, "file") == 0) {
+					file_type = "file";
+				} else if (strcmp(class_name, "dir") == 0) {
+					file_type = "dir";
+				} else if (strcmp(class_name, "chr_file") == 0) {
+					file_type = "char";
+				} else if (strcmp(class_name, "blk_file") == 0) {
+					file_type = "block";
+				} else if (strcmp(class_name, "sock_file") == 0) {
+					file_type = "socket";
+				} else if (strcmp(class_name, "fifo_file") == 0) {
+					file_type = "pipe";
+				} else if (strcmp(class_name, "lnk_file") == 0) {
+					file_type = "symlink";
+				} else {
+					return -1;
+				}
+				cil_printf("(genfscon %s \"%s\" %s ", genfs->fstype, ocon->u.name, file_type);
+			} else {
+				cil_printf("(genfscon %s \"%s\" ", genfs->fstype, ocon->u.name);
+			}
 			context_to_cil(pdb, &ocon->context[0]);
 			cil_printf(")\n");
 		}
-- 
2.31.1

