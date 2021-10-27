Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABB2C433EF
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1126D6109F
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhJ0SPQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhJ0SPP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Oct 2021 14:15:15 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC7C061570
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:49 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id d6so2376860qvb.3
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11sKQkCHAIdW1oub2Q/OnFGqoW0sq3lOKK/jQiHICbw=;
        b=guFNdZpbeL5E4EmVxiefM36XsWzUMDMFEzccaPiMxloHbNQzF51p6ksBj+bKPAMEpU
         OjnbQ5c4mq63h7IIGkCB8NWSImIrDOj29jjWLTUGoFZjKBKtpVFGKz2oMuDbmF1uSzSW
         ul71+3+8kvIF/MqFK0y1s62/8lW+BTtL/4ilbQB4TnWAnb+oTGGnVnSfXfMgRioOCF7r
         v0Z+JAk8cMDJ5Qy3GOB/ZiKOz2z0rI2f3XbXeKDh7PdoF1wrt3dP0Iwsvv0qNvv2EuR0
         bMK+XAGet6DiXeWCCKas32wuX3s9N1W/MLcTJ5YyBTk3HanXFbNpq95AcEAE0AJjdV82
         2C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11sKQkCHAIdW1oub2Q/OnFGqoW0sq3lOKK/jQiHICbw=;
        b=OWWNNlE+fO/1w7N5LptYzn4SAzLsEM+iC0JLSjQTjJiKtRZUsfMQMYRUiHEXhbSw7r
         ybyL43LJLR0q+itTmkQDPuBBIHoNJsiy6uXBVaT0C1KA6Cp5W7mxDjcxng2n/tJuNED9
         +xahy5bTV7B1amX87ZxKLJ9MLW2yA0pw7PRwzimNvcdHzVph7FNZKcouWeGGl0PBatrt
         OU+GaItqc23wvpxBSAhBQIKBn80sEd4Z/0Ib//kn4H8m1H+fwkC8kceZlvZU/F+FAorO
         yxt9I2qJi/2GsHQWk2dCkykbtq3HEwPpsnvrhEH9QfW2xnFWtkbXqcPvbARvWt5B0AGf
         ngxg==
X-Gm-Message-State: AOAM532qQxytLYw2Hv9j3lCxvtpO0Y6m0HytMxBl2CY3qTrgQ/gleZZS
        ELyTSbA1//jS8lVy/Hdquz9fIkN2EYY=
X-Google-Smtp-Source: ABdhPJyMMGSA1ONZUN4XdqLHMKGrziTuP/p97xqmMco77p3CL1NVffZVQXL3H19Vu5QxAHWfB9gfTg==
X-Received: by 2002:a05:6214:4112:: with SMTP id kc18mr30726812qvb.11.1635358368745;
        Wed, 27 Oct 2021 11:12:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id l15sm440561qtk.41.2021.10.27.11.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:12:45 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/4] libsepol: Add support for file types in writing out policy.conf
Date:   Wed, 27 Oct 2021 14:12:07 -0400
Message-Id: <20211027181210.1019597-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027181210.1019597-1-jwcart2@gmail.com>
References: <20211027181210.1019597-1-jwcart2@gmail.com>
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
 libsepol/src/kernel_to_conf.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index eb72e4ac..aa963ca5 100644
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
+				if (strcmp(class_name, "blk_file") == 0) {
+					file_type = "-b";
+				} else if (strcmp(class_name, "chr_file") == 0) {
+					file_type = "-c";
+				} else if (strcmp(class_name, "dir") == 0) {
+					file_type = "-d";
+				} else if (strcmp(class_name, "fifo_file") == 0) {
+					file_type = "-p";
+				} else if (strcmp(class_name, "lnk_file") == 0) {
+					file_type = "-l";
+				} else if (strcmp(class_name, "sock_file") == 0) {
+					file_type = "-s";
+				} else if (strcmp(class_name, "file") == 0) {
+					file_type = "--";
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

