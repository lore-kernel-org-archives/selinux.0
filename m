Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A07C433EF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAC6610A2
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhKJOuX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhKJOuW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 09:50:22 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA914C061764
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:34 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f20so1996198qtb.4
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWsaWRS1bbSVBlqyz0DEc6hz4C9Ezc/cvwumyntL4oc=;
        b=QMdVo6kBYDYRlcNE+MhO5cGzwFj7PKswATbszjC2Q21F6E5V2ri8EmBDfGP6QVYIrY
         jxvMyjlaQC/LvWp1FFNd+G7cJBFmUG54Gwx3qHdOIRfj8oFA0Dj43cXQSItXdR9TItoC
         y1JBhSLOp7fMD5Ky4hmXcgK/vYvsjlFRi444C6B8IM+gnCrrJvt2tmFYslJBMLlvFNYy
         zw7H0GzvKlOwxLviPDTJl+1ppLJxMHniAtU7UKfdsBAnHwhq0OjHd0pw22eIv9Pw36we
         i7VB/7jB82hSiJq8skYWVStPYMCGCdzjGNjgaAN1SGRI/XNues9ayggutVFA+gRuOML7
         xcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWsaWRS1bbSVBlqyz0DEc6hz4C9Ezc/cvwumyntL4oc=;
        b=YmvjM+ik9cUX0QTC2wHPFpg4ovUOkkwPSe2bVC03UR3KUdNNFFiXvzdehgSz38+P+L
         QRiUIgYXYRKQa40z91s5C+qehzh4rskSTtHs2qaPw+mWE/pZ42L9BL4DiVm9SuXg7dgs
         O+SWuhR3miQf1+fp1yTALvHqtAI2RAq34ClH4eA9odu4exzpdH+5nL0jZdSfk8KC6cDj
         EPsSr9VwCUG5FTYzkFLtXsDQ16ygvqX+L7yhmeITKZQInQv1kCiMLm0jdhbbkL1LW9Ju
         +YxeDj5E0vyK0ku1nrqbknqhpwaP1NiRz3DQ72m0t/xEFApIoN94IEXkpebhSlbRuljF
         oLjg==
X-Gm-Message-State: AOAM5317BUc4ZXbHdryB+LgxTAV4xnlqdEvyLqeY3CMdXFp2u4qpW8V2
        auRIey9/9dB4yKD3S2mxKMmV90rfwjw=
X-Google-Smtp-Source: ABdhPJzB+UgPzmVJqf8aCs6v7QB60R+JZOiglMaAnJIpnG9OAiSvkPdwPhyWkFid+YlM5ETIjkKyOw==
X-Received: by 2002:ac8:18c:: with SMTP id x12mr141026qtf.378.1636555654035;
        Wed, 10 Nov 2021 06:47:34 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r10sm58633qta.27.2021.11.10.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:47:33 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, stephen.smalley.work@gmail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/5 v2] libsepol/cil: Refactor filecon file type handling
Date:   Wed, 10 Nov 2021 09:47:24 -0500
Message-Id: <20211110144727.1467744-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110144727.1467744-1-jwcart2@gmail.com>
References: <20211110144727.1467744-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Prepare for the addition of an optional file type in genfscon rules
by refactoring filecon file type handling.

Make the "any" file type be the first value in enum cil_filecon_types
because it will be the most common file type.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: New patch

 libsepol/cil/src/cil.c           |  5 ++++-
 libsepol/cil/src/cil_build_ast.c |  6 +++---
 libsepol/cil/src/cil_internal.h  |  4 ++--
 libsepol/cil/src/cil_write_ast.c | 30 ++++++++++++++++++++----------
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 4cc7f87f..a152d689 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -1765,6 +1765,9 @@ int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size)
 		str_tmp += buf_pos;
 
 		switch(filecon->type) {
+		case CIL_FILECON_ANY:
+			str_type = "";
+			break;
 		case CIL_FILECON_FILE:
 			str_type = "\t--";
 			break;
@@ -2530,7 +2533,7 @@ void cil_filecon_init(struct cil_filecon **filecon)
 	*filecon = cil_malloc(sizeof(**filecon));
 
 	(*filecon)->path_str = NULL;
-	(*filecon)->type = 0;
+	(*filecon)->type = CIL_FILECON_ANY;
 	(*filecon)->context_str = NULL;
 	(*filecon)->context = NULL;
 }
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 9c34be23..6a6f4f33 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4229,7 +4229,9 @@ int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 
 	filecon->path_str = parse_current->next->data;
 
-	if (type == CIL_KEY_FILE) {
+	if (type == CIL_KEY_ANY) {
+		filecon->type = CIL_FILECON_ANY;
+	} else if (type == CIL_KEY_FILE) {
 		filecon->type = CIL_FILECON_FILE;
 	} else if (type == CIL_KEY_DIR) {
 		filecon->type = CIL_FILECON_DIR;
@@ -4243,8 +4245,6 @@ int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		filecon->type = CIL_FILECON_PIPE;
 	} else if (type == CIL_KEY_SYMLINK) {
 		filecon->type = CIL_FILECON_SYMLINK;
-	} else if (type == CIL_KEY_ANY) {
-		filecon->type = CIL_FILECON_ANY;
 	} else {
 		cil_log(CIL_ERR, "Invalid file type\n");
 		rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 6f1d3cb5..fb2856d6 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -730,14 +730,14 @@ struct cil_context {
 };
 
 enum cil_filecon_types {
-	CIL_FILECON_FILE = 1,
+	CIL_FILECON_ANY = 0,
+	CIL_FILECON_FILE,
 	CIL_FILECON_DIR,
 	CIL_FILECON_CHAR,
 	CIL_FILECON_BLOCK,
 	CIL_FILECON_SOCKET,
 	CIL_FILECON_PIPE,
 	CIL_FILECON_SYMLINK,
-	CIL_FILECON_ANY
 };
 
 struct cil_filecon {
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index d7f00bcc..40effcdc 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1232,24 +1232,34 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		struct cil_filecon *filecon = node->data;
 		fprintf(out, "(filecon ");
 		fprintf(out, "\"%s\" ", filecon->path_str);
-		if (filecon->type == CIL_FILECON_FILE)
+		switch (filecon->type) {
+		case CIL_FILECON_ANY:
+			fprintf(out, "%s ", CIL_KEY_ANY);
+			break;
+		case CIL_FILECON_FILE:
 			fprintf(out, "%s ", CIL_KEY_FILE);
-		else if (filecon->type == CIL_FILECON_DIR)
+			break;
+		case CIL_FILECON_DIR:
 			fprintf(out, "%s ", CIL_KEY_DIR);
-		else if (filecon->type == CIL_FILECON_CHAR)
+			break;
+		case CIL_FILECON_CHAR:
 			fprintf(out, "%s ", CIL_KEY_CHAR);
-		else if (filecon->type == CIL_FILECON_BLOCK)
+			break;
+		case CIL_FILECON_BLOCK:
 			fprintf(out, "%s ", CIL_KEY_BLOCK);
-		else if (filecon->type == CIL_FILECON_SOCKET)
+			break;
+		case CIL_FILECON_SOCKET:
 			fprintf(out, "%s ", CIL_KEY_SOCKET);
-		else if (filecon->type == CIL_FILECON_PIPE)
+			break;
+		case CIL_FILECON_PIPE:
 			fprintf(out, "%s ", CIL_KEY_PIPE);
-		else if (filecon->type == CIL_FILECON_SYMLINK)
+			break;
+		case CIL_FILECON_SYMLINK:
 			fprintf(out, "%s ", CIL_KEY_SYMLINK);
-		else if (filecon->type == CIL_FILECON_ANY)
-			fprintf(out, "%s ", CIL_KEY_ANY);
-		else
+			break;
+		default:
 			fprintf(out, "<?FILETYPE> ");
+		}
 		if (filecon->context)
 			write_context(out, filecon->context, CIL_TRUE);
 		else if (filecon->context_str)
-- 
2.31.1

