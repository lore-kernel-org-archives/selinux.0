Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F3CC433FE
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949706109F
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbhJ0SPR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhJ0SPQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Oct 2021 14:15:16 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D1C061570
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:51 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id t1so2383981qvb.1
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPggv6zCYBbQxTUNZt7tcHPra8bmol1DYLivtlCvfsA=;
        b=ROcN0k5hPp1/Znp0At3jgc3lDeEQ1vp5B39/y5ROjOmNQxQfIx47Q0rHg4rtTO4BCt
         urTWp39YmJxM8dz6O+KdnR2R8Gc1330CMHparP6YPLAYrOZo3qzeqbsLEFbgKYzFJ1MY
         3ubmeBugIc0cAHhwMoM3XSaYJFecVmchMAw08fxMpOEXlZDq6AUMTduGjYgZY3STnhyO
         WbFvoIIKwFUoHvQHs2VveL3/5jFIkyRNF71kS+oZhjeVpGWEOe4Qh2dnpYsp5cH39Ra2
         bmngXO1SQwOxrCLbshcOh07u5ksrSY9FzRZduoi25NhRKmCF7QAREvwadal0w/CMmM5Z
         n12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPggv6zCYBbQxTUNZt7tcHPra8bmol1DYLivtlCvfsA=;
        b=G6yo8ZzYQJVwqYTgtharQCMFWL4EWzb07pe6H3g/zbD2k8nkOohe/jz/KaZMhnMZT9
         eYE/RChXU8TsuNJ6DDXO9tPOifukuzqxVNacr4CNmuYn775vv6s9gtOJfcN3Hxs08KHY
         05yWpI2bwlVz/dkh4jWmkm4wVpKXNyrn5yI1eFQqvpIofwqkEc9U19qyqHTJWzLWhG6i
         OULH+7gMFppu8IL3C0vyKTN5oPiu7QMOD/zb3wODAIg6R1U1NT9PHk2SfnH9CEpXdf3M
         DYazFtV893G/FZhN2T/L7nA//ShJWCPmIeHpLnexJbGUJVN93ok4NIjJM42VwPCsAHr1
         UxDA==
X-Gm-Message-State: AOAM532d95b/ZDVYKD0Mop0jxiTHnwyjfa531j3YN4NBOODf8g0of3+G
        XdnruViTUB2nj8nfb+BpKadULv8XAFY=
X-Google-Smtp-Source: ABdhPJxmEdaTeX/47PdDrr1NDLxHo3SxCbgnC7X/z7jQGXfJ0Ho7AkOXOz35zLzVDRZZzSQxOYQLAQ==
X-Received: by 2002:a05:6214:80f:: with SMTP id df15mr8289701qvb.37.1635358370257;
        Wed, 27 Oct 2021 11:12:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id l15sm440561qtk.41.2021.10.27.11.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:12:49 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/4] libsepol/cil: Allow optional file type in genfscon rules
Date:   Wed, 27 Oct 2021 14:12:08 -0400
Message-Id: <20211027181210.1019597-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027181210.1019597-1-jwcart2@gmail.com>
References: <20211027181210.1019597-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The optional specification of a file type for a genfscon rule to
make it apply only to a specific security class is allowed by
checkpolicy and checkmodule and should be allowed for CIL policies
as well.

Allow an optional file type to be specified for a genfscon rule.
The new syntax:
  (genfscon FSNAME PATH [FILE_TYPE] CONTEXT)

  FSNAME    - The name of the supported filesystem
  PATH      - If FSNAME is proc then this is the partial path,
              othewise this must be "/".
  FILE_TYPE - A single keyword representing the file type.
              file type  security class
                file       file
                dir        dir
                char       chr_file
                block      blk_file
                socket     sock_file
                pipe       fifo_file
                symlink    lnk_file
                any        Same as not specifying a file type
  CONTEXT    - Either a previously declared security context identifier
               or an anonymous security context.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c    | 39 +++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c | 43 +++++++++++++++++++++++++++++---
 libsepol/cil/src/cil_internal.h  |  1 +
 3 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index d8aa495a..b6ed750f 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3462,6 +3462,45 @@ int cil_genfscon_to_policydb(policydb_t *pdb, struct cil_sort *genfscons)
 
 		new_ocon->u.name = cil_strdup(cil_genfscon->path_str);
 
+		if (cil_genfscon->file_type && cil_genfscon->file_type != CIL_FILECON_ANY) {
+			class_datum_t *class_datum;
+			const char *class_name;
+			switch (cil_genfscon->file_type) {
+			case CIL_FILECON_FILE:
+				class_name = "file";
+				break;
+			case CIL_FILECON_DIR:
+				class_name = "dir";
+				break;
+			case CIL_FILECON_CHAR:
+				class_name = "chr_file";
+				break;
+			case CIL_FILECON_BLOCK:
+				class_name = "blk_file";
+				break;
+			case CIL_FILECON_SOCKET:
+				class_name = "sock_file";
+				break;
+			case CIL_FILECON_PIPE:
+				class_name = "fifo_file";
+				break;
+			case CIL_FILECON_SYMLINK:
+				class_name = "lnk_file";
+				break;
+			default:
+				fprintf(stderr, "What is going on?\n");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			class_datum = hashtab_search(pdb->p_classes.table, class_name);
+			if (!class_datum) {
+				fprintf(stderr, "What is going on?\n");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			new_ocon->v.sclass = class_datum->s.value;
+		}
+
 		rc = __cil_context_to_sepol_context(pdb, cil_genfscon->context, &new_ocon->context[0]);
 		if (rc != SEPOL_OK) {
 			goto exit;
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 9c34be23..a7d973df 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4572,9 +4572,11 @@ int cil_gen_genfscon(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_STRING,
 		CIL_SYN_STRING,
 		CIL_SYN_STRING | CIL_SYN_LIST,
+		CIL_SYN_STRING | CIL_SYN_LIST | CIL_SYN_END,
 		CIL_SYN_END
 	};
 	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
+	struct cil_tree_node *context_node;
 	int rc = SEPOL_ERR;
 	struct cil_genfscon *genfscon = NULL;
 
@@ -4592,15 +4594,48 @@ int cil_gen_genfscon(struct cil_db *db, struct cil_tree_node *parse_current, str
 	genfscon->fs_str = parse_current->next->data;
 	genfscon->path_str = parse_current->next->next->data;
 
-	if (parse_current->next->next->next->cl_head == NULL ) {
-		genfscon->context_str = parse_current->next->next->next->data;
+	if (parse_current->next->next->next->next) {
+		/* (genfscon <FS_STR> <PATH_STR> <FILE_TYPE> ... */
+		char *file_type = parse_current->next->next->next->data;
+		if (file_type == CIL_KEY_FILE) {
+			genfscon->file_type = CIL_FILECON_FILE;
+		} else if (file_type == CIL_KEY_DIR) {
+			genfscon->file_type = CIL_FILECON_DIR;
+		} else if (file_type == CIL_KEY_CHAR) {
+			genfscon->file_type = CIL_FILECON_CHAR;
+		} else if (file_type == CIL_KEY_BLOCK) {
+			genfscon->file_type = CIL_FILECON_BLOCK;
+		} else if (file_type == CIL_KEY_SOCKET) {
+			genfscon->file_type = CIL_FILECON_SOCKET;
+		} else if (file_type == CIL_KEY_PIPE) {
+			genfscon->file_type = CIL_FILECON_PIPE;
+		} else if (file_type == CIL_KEY_SYMLINK) {
+			genfscon->file_type = CIL_FILECON_SYMLINK;
+		} else if (file_type == CIL_KEY_ANY) {
+			genfscon->file_type = CIL_FILECON_ANY;
+		} else {
+			if (parse_current->next->next->next->cl_head) {
+				cil_log(CIL_ERR, "Expecting file type, but found a list\n");
+			} else {
+				cil_log(CIL_ERR, "Invalid file type \"%s\"\n", file_type);
+			}
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+		context_node = parse_current->next->next->next->next;
 	} else {
-		cil_context_init(&genfscon->context);
+		/* (genfscon <FS_STR> <PATH_STR> ... */
+		context_node = parse_current->next->next->next;
+	}
 
-		rc = cil_fill_context(parse_current->next->next->next->cl_head, genfscon->context);
+	if (context_node->cl_head) {
+		cil_context_init(&genfscon->context);
+		rc = cil_fill_context(context_node->cl_head, genfscon->context);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
+	} else {
+		genfscon->context_str = context_node->data;
 	}
 
 	ast_node->data = genfscon;
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 6f1d3cb5..0e92ccae 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -791,6 +791,7 @@ struct cil_ipaddr {
 struct cil_genfscon {
 	char *fs_str;
 	char *path_str;
+	enum cil_filecon_types file_type;
 	char *context_str;
 	struct cil_context *context;
 };
-- 
2.31.1

