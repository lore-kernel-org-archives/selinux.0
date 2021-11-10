Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D505C4332F
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E934D60EDF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhKJOuX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhKJOuX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 09:50:23 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2426C061764
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:35 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id j2so2664534qkl.7
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LV8d5Kob0qPFfJjFhk4yydMeDy6GOZxcVaIyLSOrUCg=;
        b=peqBnyU5WZe+c8D/vMpmNd5S9pX9BtWzg/mOWB5fqkpHfjvuWOfie3cccanMrMcy4x
         Wi30TUdDgxd96r7272DAwfcinpeAHJLOzIpak8YWlBCzKxsiWwjSf/jEUyFMX1rdr77H
         Nb1xRowEWYie5nFJD8XArssNEGLeN/T/pYxDGKFcgWPseUwjlUbAayn/pz6nm12RWOLK
         Wv4HrmlELxgzMFrju3qto1xtMM3eAXiFuixUT60+LlYkkP8BHp1vRKkeCnxr0V/BzDaq
         J9/qS/ET9GtQgJJilIaud6xPg54qurbR84kwE2Lw3eRaqYGUuM21zORL+XpPx0AVvuop
         fySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LV8d5Kob0qPFfJjFhk4yydMeDy6GOZxcVaIyLSOrUCg=;
        b=mPaqqP1K+DFEYS0fNvSKYLu+mqbCxL9qA9Yo6rAGyc5/XLIuWVyRr32azrtYxHVj7Y
         VP+ISph3/UCTGRD8eZnW8DAgOIJqSwEScq0F5riPTpVm+uLTS/cQHv53vS3/C+IGxANM
         K8vTBt5r0Zh240zCrtuwphfRqTL+ngVFpiHBWppVnO053T5BO/8+6UR2+Fzlb1L+V/DJ
         V/VXKWOS6sQVP/X8HqEuezWLEm3ci/v6ZqulgubpmElyni+WbiC2ndBrP/YxuMNwB7KA
         VLyY8EqK69LqJ+DmrA35+gDQ85BlEJvy+Vd7dHzEx+T6kmTDIAJWqz6ywcSY596+tGh5
         Pu0g==
X-Gm-Message-State: AOAM533LvWAeoLIEBhurfEpUMbTnTPNj5Zlc9Wdw1E1YRC2xPpBDmrmm
        9STbs43PJagdSEd8g9c69yDqlcKfn6Q=
X-Google-Smtp-Source: ABdhPJxmCsZ/R8MeyPvk9M9Svwa6bQBJDncTrrNKkMxi2HKsrpiEj2QDf0XrCr9q4iZCKfa2B/vJ4w==
X-Received: by 2002:a05:620a:280a:: with SMTP id f10mr267698qkp.118.1636555654767;
        Wed, 10 Nov 2021 06:47:34 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r10sm58633qta.27.2021.11.10.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:47:34 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, stephen.smalley.work@gmail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/5 v2] libsepol/cil: Allow optional file type in genfscon rules
Date:   Wed, 10 Nov 2021 09:47:25 -0500
Message-Id: <20211110144727.1467744-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110144727.1467744-1-jwcart2@gmail.com>
References: <20211110144727.1467744-1-jwcart2@gmail.com>
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
                any        Same as not specifying a file type
                file       file
                dir        dir
                char       chr_file
                block      blk_file
                socket     sock_file
                pipe       fifo_file
                symlink    lnk_file
  CONTEXT    - Either a previously declared security context identifier
               or an anonymous security context.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Initialize file_type field
    Reordered if else block to start with "any"
    Write out file type when writing AST

 libsepol/cil/src/cil.c           |  1 +
 libsepol/cil/src/cil_binary.c    | 37 +++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c | 43 +++++++++++++++++++++++++++++---
 libsepol/cil/src/cil_internal.h  |  1 +
 libsepol/cil/src/cil_write_ast.c | 27 ++++++++++++++++++++
 5 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index a152d689..9916cbee 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -2577,6 +2577,7 @@ void cil_genfscon_init(struct cil_genfscon **genfscon)
 
 	(*genfscon)->fs_str = NULL;
 	(*genfscon)->path_str = NULL;
+	(*genfscon)->file_type = CIL_FILECON_ANY;
 	(*genfscon)->context_str = NULL;
 	(*genfscon)->context = NULL;
 }
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index d8aa495a..4ac8ce8d 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3462,6 +3462,43 @@ int cil_genfscon_to_policydb(policydb_t *pdb, struct cil_sort *genfscons)
 
 		new_ocon->u.name = cil_strdup(cil_genfscon->path_str);
 
+		if (cil_genfscon->file_type != CIL_FILECON_ANY) {
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
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			class_datum = hashtab_search(pdb->p_classes.table, class_name);
+			if (!class_datum) {
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
index 6a6f4f33..4a501b8f 100644
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
+		if (file_type == CIL_KEY_ANY) {
+			genfscon->file_type = CIL_FILECON_ANY;
+		} else if (file_type == CIL_KEY_FILE) {
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
index fb2856d6..a7604762 100644
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
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 40effcdc..bebb2670 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1328,6 +1328,33 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		struct cil_genfscon *genfscon = node->data;
 		fprintf(out, "(genfscon ");
 		fprintf(out, "%s \"%s\" ", genfscon->fs_str, genfscon->path_str);
+		if (genfscon->file_type != CIL_FILECON_ANY) {
+			switch (genfscon->file_type) {
+			case CIL_FILECON_FILE:
+				fprintf(out, "%s ", CIL_KEY_FILE);
+				break;
+			case CIL_FILECON_DIR:
+				fprintf(out, "%s ", CIL_KEY_DIR);
+				break;
+			case CIL_FILECON_CHAR:
+				fprintf(out, "%s ", CIL_KEY_CHAR);
+				break;
+			case CIL_FILECON_BLOCK:
+				fprintf(out, "%s ", CIL_KEY_BLOCK);
+				break;
+			case CIL_FILECON_SOCKET:
+				fprintf(out, "%s ", CIL_KEY_SOCKET);
+				break;
+			case CIL_FILECON_PIPE:
+				fprintf(out, "%s ", CIL_KEY_PIPE);
+				break;
+			case CIL_FILECON_SYMLINK:
+				fprintf(out, "%s ", CIL_KEY_SYMLINK);
+				break;
+			default:
+				fprintf(out, "<?FILETYPE> ");
+			}
+		}
 		if (genfscon->context)
 			write_context(out, genfscon->context, CIL_TRUE);
 		else
-- 
2.31.1

