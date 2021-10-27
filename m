Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBFDC433FE
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125696109F
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbhJ0SPT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhJ0SPT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Oct 2021 14:15:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C2C061745
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:53 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id c3so2350654qvh.7
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2eCYgNRKXswXFfWPQ92SfTVbVOmqP45FGZ7P8DE/ns=;
        b=qN74CtCzkKNWDLIvAABRK4DyFdjdG2pmklEwsQ73n44Kx8siUlkJtn3s5S9L4hY5gh
         6D+sxX8HSHyNIrzvR8nc8+tYaDpbVo6QwR7oyFcecuDwW5SkDb28lwEvQHbJUAklnxUG
         qMSEzg6xo9yzaIkmrI8F2dAeoYpSE85mGZpA6A7o/GAILcpfcx2LIm7egindoPSddOyR
         AqMeDgeUJjrKzRam2vDYoAftDsw9BFQcoz/uXiBpTv6IkwOYNKwZG9nkPodHualb/Erc
         Ct1QM7cJkkgn7SKfm4dgZUpoGXJsx0lNXxNxMZ/8KMnmNPKv9pNqqms1czTvzTLoLwTq
         1FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2eCYgNRKXswXFfWPQ92SfTVbVOmqP45FGZ7P8DE/ns=;
        b=w4UfFwnCcAsUdVv7w1boTEKBWRSaUUIBHPgoHmew7/8pH/a7UDWHmjCZIwxmnQDnZX
         zZ3GVwxiglzIfO6n8spy7kYCtzliZfSt63GlCsgpbAYu6Q739JCf16sq6VzD/UW1ImSa
         39hMj0Vg7w5/0mVbw37/Z3ZwROB3JPGBvQDOGUuoHmt4CGlGRp7NeVpXOvOtaqnW6NdM
         sQ/E2pcevvw1zhHfJ6N381mn/VccES6KfUgmW6MhO3zT8DrjoBQx41Lo4lc7fsqGshwx
         eStREvG6v6Dnscp+BVEJMjoe2R3/m4jaiog+/KXexjvwpC5TPI8xpdq8Edun24C88bC2
         s2Bg==
X-Gm-Message-State: AOAM532L0ByotDKoMrcjUA4eOtqEeVgCcvKrzueDmCtuwTepVjSvj9Wf
        C8mODW23K/UM8wOPPGa3Wcj+pDDWSqQ=
X-Google-Smtp-Source: ABdhPJwr7hb7LhdZe4NzdRcm1Wf8nCpIVW5Wdnsx+H9Tm0oN8iz7T1nSm47dk6dTiW0Grp5aFtPnvA==
X-Received: by 2002:ad4:43e8:: with SMTP id f8mr11371365qvu.41.1635358372555;
        Wed, 27 Oct 2021 11:12:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id l15sm440561qtk.41.2021.10.27.11.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:12:51 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/4] libsepol: Write out genfscon file type when writing out CIL policy
Date:   Wed, 27 Oct 2021 14:12:10 -0400
Message-Id: <20211027181210.1019597-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027181210.1019597-1-jwcart2@gmail.com>
References: <20211027181210.1019597-1-jwcart2@gmail.com>
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
 libsepol/src/kernel_to_cil.c | 35 +++++++++++++++++++++++++++++++++--
 libsepol/src/module_to_cil.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 305567a5..ef66b2fb 100644
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
+				if (strcmp(class_name, "blk_file") == 0) {
+					file_type = "block";
+				} else if (strcmp(class_name, "chr_file") == 0) {
+					file_type = "char";
+				} else if (strcmp(class_name, "dir") == 0) {
+					file_type = "dir";
+				} else if (strcmp(class_name, "fifo_file") == 0) {
+					file_type = "pipe";
+				} else if (strcmp(class_name, "lnk_file") == 0) {
+					file_type = "symlink";
+				} else if (strcmp(class_name, "sock_file") == 0) {
+					file_type = "socket";
+				} else if (strcmp(class_name, "file") == 0) {
+					file_type = "file";
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
index 16e4004e..33c198b9 100644
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
+				if (strcmp(class_name, "blk_file") == 0) {
+					file_type = "block";
+				} else if (strcmp(class_name, "chr_file") == 0) {
+					file_type = "char";
+				} else if (strcmp(class_name, "dir") == 0) {
+					file_type = "dir";
+				} else if (strcmp(class_name, "fifo_file") == 0) {
+					file_type = "pipe";
+				} else if (strcmp(class_name, "lnk_file") == 0) {
+					file_type = "symlink";
+				} else if (strcmp(class_name, "sock_file") == 0) {
+					file_type = "socket";
+				} else if (strcmp(class_name, "file") == 0) {
+					file_type = "file";
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

