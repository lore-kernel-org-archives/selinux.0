Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9932BC433F5
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E99860EDF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhKJOuW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhKJOuV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 09:50:21 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A12BC061766
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:34 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j17so2305647qtx.2
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIVilonRoXtUWDGADdMpwASXCRPbhm0qPBpXub2SVMo=;
        b=h6CSzQgEJAe6M1b9YUhj0Zltpv2KYVdtDi+hBf+j4n2K33h6+CHx7XCpVEIUNq2I4C
         w6aLxaBFr9SKjgI6tnU9RvQk4WgULRV35wxlrruEQ1/QnS2YMEuuSBx2FTy8foSpiat4
         kxcDNdMoIehZByhIk+QAui3mfHe5X3c+2YtNfeEsmDJrv4TQaqoY0wqYBH9Vqwg8pnOb
         6If4j/z39JMCcgLFSOq6DpjiPs/bIDgeUReME9+MpUlzXYmm/okch4uWcmmGjmmy9YQo
         oGKlYaxof9DPonX4PjeunH5tazwh3d4GMvU5SH5jxa/8gz8Vk/HRKelHDLTjkIWwq/e3
         wXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIVilonRoXtUWDGADdMpwASXCRPbhm0qPBpXub2SVMo=;
        b=JgXh00qETDswoSEP3AysVRGqWmbTetQzjJPc3Fej/6HPE07jf/r8sSSZ4zrkZSMAxq
         Iy6KREzvZ37laGzT3ufG4moh0amUKao4M1Q3cRNn7bBsJGj8ikYfvtTMIgZPBaIvCiM+
         zGqqptFc+h9zSerKXnxxqjVJ5Pis8IOG9i+4298iOavnWOsc+2sY5g+NJehlBsHOjNIP
         ndPXgojUQFhYwrbnl9aexwLKMYU+YR8o00PdVJV5VzhQ5BSZHB1kzRnJT8YOBvyAbI6u
         2eCP0Qag4T6CWyrttkcARpv5ldHTQvlPVSI72LtUK/jUUQ0BJrZIdn5vTWypY7IzW2Pg
         iyLA==
X-Gm-Message-State: AOAM530BirNLSLp9k0qV8y1Cf46qVFZkw7OEIef9RK84Af+U7ktBRp32
        chRdmbytOhiv/LaoDnBbg+xmZI5Xyoc=
X-Google-Smtp-Source: ABdhPJxNWiJSyyi5aCYRcKJMy3OS0ojO44V9M/DIX+zo0jb4QZDPxMaanzD928Gyno2lV5W5qMEf+g==
X-Received: by 2002:ac8:4d87:: with SMTP id a7mr143656qtw.410.1636555653185;
        Wed, 10 Nov 2021 06:47:33 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r10sm58633qta.27.2021.11.10.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:47:32 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, stephen.smalley.work@gmail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/5 v2] libsepol: Add support for file types in writing out policy.conf
Date:   Wed, 10 Nov 2021 09:47:23 -0500
Message-Id: <20211110144727.1467744-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110144727.1467744-1-jwcart2@gmail.com>
References: <20211110144727.1467744-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Although rarely used, genfscon rules support the specification of a
file type just like the rules in a file context file. The file type
is used to make the genfscon rule apply only for a specific security
class. Currently, when writing out a policy.conf file from a kernel
policy, it is assumed that every genfscon rule applies to all security
classes and no file type will be added to the genfscon rule.

Write out the appropriate file type if the genfscon rule is only for
a specific security class (file, dir, blk_file, chr_file, fifo_file,
lnk_file, or sock_file).

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Reordered if else block to have a consistent ordering.

 libsepol/src/kernel_to_conf.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index eb72e4ac..9f04961a 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2513,6 +2513,8 @@ static int write_genfscon_rules_to_conf(FILE *out, struct policydb *pdb)
 	struct ocontext *ocon;
 	struct strs *strs;
 	char *fstype, *name, *ctx;
+	uint32_t sclass;
+	const char *file_type;
 	int rc;
 
 	rc = strs_init(&strs, 32);
@@ -2525,14 +2527,43 @@ static int write_genfscon_rules_to_conf(FILE *out, struct policydb *pdb)
 			fstype = genfs->fstype;
 			name = ocon->u.name;
 
+			sclass = ocon->v.sclass;
+			file_type = NULL;
+			if (sclass) {
+				const char *class_name = pdb->p_class_val_to_name[sclass-1];
+				if (strcmp(class_name, "file") == 0) {
+					file_type = "--";
+				} else if (strcmp(class_name, "dir") == 0) {
+					file_type = "-d";
+				} else if (strcmp(class_name, "chr_file") == 0) {
+					file_type = "-c";
+				} else if (strcmp(class_name, "blk_file") == 0) {
+					file_type = "-b";
+				} else if (strcmp(class_name, "sock_file") == 0) {
+					file_type = "-s";
+				} else if (strcmp(class_name, "fifo_file") == 0) {
+					file_type = "-p";
+				} else if (strcmp(class_name, "lnk_file") == 0) {
+					file_type = "-l";
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
 
-			rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s", 3,
-						 fstype, name, ctx);
+			if (file_type) {
+				rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s %s", 4,
+										 fstype, name, file_type, ctx);
+			} else {
+				rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s", 3,
+										 fstype, name, ctx);
+			}
 			free(ctx);
 			if (rc != 0) {
 				goto exit;
-- 
2.31.1

