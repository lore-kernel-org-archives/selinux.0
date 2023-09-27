Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C25E82CB7
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjI0TAl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0TAh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F530F5
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4135f3d1213so66517141cf.1
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841232; x=1696446032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZJtHWi0fi7+e6zoQOU0v05Z8tFLU2vgBOzf3VwXzDc=;
        b=WidEHjE4IDoWxlK72KR5oW9A+XW+YpGPpMM22kaRYcPEn1Rx5zmqr14HLF6JGkC8ur
         y5JXpjh/sNbLxyYDvvRKyVfzS4G67dqnuq890i4ei7lKZMYO+sRua5l+kj24Op2EKH3E
         WA60HgMbjHGPzh6F0E8uwmXdYH/QrASLLNmJwCQdWxXKy9hJiu2E4wrsMhgCX3FiKOw0
         TDrXx+dti7sYS0AY+OSx8AKosi+CzSTcF/QhzPP59uyw6e38L6lOIBTqgVj8Zz4okala
         x0PsLJtDZk6FYc6H/ZZD9kG6/Xm3vM6tKDW7Vgj3h6pxirSK67/1VKfwpgHrLjbcIeoK
         Kxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841232; x=1696446032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZJtHWi0fi7+e6zoQOU0v05Z8tFLU2vgBOzf3VwXzDc=;
        b=grFEt1q+WncSQSPZTXgWxmmisP41m5mKFPBsi1bTRg3zd3cf7qF+2awkGpfTUSZ+Tu
         7y1lAUZPB6sKtfsPQYu9lw5mdXDwfIH9iUhUKdqBrCABNbIHe6DWeLNHxCEiAXt+7k9t
         T5aUE5x41N3Z2Bjl4WkEvPEv/KcpxFE+VrTGzjVNkZ3l+FGQjw2993NGtiSyeXwJSlBl
         ntF2IszvGLAF0yXCzQPvGzKTSMZDp4+FCrjk77vb9awkVwg9Mi4GsJKbKkeBh9L2ty2m
         XxwOpoeKvMPS7UGRoHJsbbd70atTISUo20rOo9ktNYw33rdWvGPnBaVQY5yk+5LGTSpH
         +puw==
X-Gm-Message-State: AOJu0Yzno6U8rJEn7keUqnGuqew2WXi9Je2xoWFbX3VoO+36g5orJWbz
        EhbYpgPKpls3WD7aumiNe8a5z5LUa7E=
X-Google-Smtp-Source: AGHT+IGPtaH4Gox+J9Gaht5dQ8KPfGISnS6XxeCGB1m6kFDVWlbzJ/s+kdT7UNcAG3oJh7CLRp9gQw==
X-Received: by 2002:a05:622a:1756:b0:412:1e0a:772a with SMTP id l22-20020a05622a175600b004121e0a772amr3319837qtk.17.1695841231892;
        Wed, 27 Sep 2023 12:00:31 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:31 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/9] libsepol/cil: Allow paths in filecon rules to be passed as arguments
Date:   Wed, 27 Sep 2023 15:00:18 -0400
Message-ID: <20230927190021.1164278-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927190021.1164278-1-jwcart2@gmail.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Allow paths in filecon rules to be passed as arguments in macro calls
just like filenames can be passed for named type transition rules.

The paths are handled just like the filenames in named type transition
rules.

Example/
  (macro m1 ((string ARG1))
    (filecon ARG1 dir (USER ROLE TYPE ((SENS)(SENS))))
  )
  (call m1 ("/usr/bin"))

  Results in the following equivalent rule:
  (filecon "/usr/bin" dir (USER ROLE TYPE ((SENS)(SENS))))

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c             |  8 ++++----
 libsepol/cil/src/cil_build_ast.c   |  8 +++++---
 libsepol/cil/src/cil_copy_ast.c    |  1 +
 libsepol/cil/src/cil_internal.h    |  1 +
 libsepol/cil/src/cil_post.c        | 14 +++++++++-----
 libsepol/cil/src/cil_resolve_ast.c |  9 +++++++++
 libsepol/cil/src/cil_write_ast.c   |  6 +++++-
 7 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index d2219f77..ac548d15 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -1806,8 +1806,8 @@ int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size)
 	for (i = 0; i < filecons->count; i++) {
 		struct cil_filecon *filecon = filecons->array[i];
 		struct cil_context *ctx = filecon->context;
-
-		str_len += strlen(filecon->path_str);
+		char *path_str = filecon->path ? DATUM(filecon->path)->fqn : filecon->path_str;
+		str_len += strlen(path_str);
 
 		if (filecon->type != CIL_FILECON_ANY) {
 			/* If a type is specified,
@@ -1845,8 +1845,8 @@ int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size)
 		struct cil_filecon *filecon = filecons->array[i];
 		struct cil_context *ctx = filecon->context;
 		const char *str_type = NULL;
-
-		buf_pos = sprintf(str_tmp, "%s", filecon->path_str);
+		char *path_str = filecon->path ? DATUM(filecon->path)->fqn : filecon->path_str;
+		buf_pos = sprintf(str_tmp, "%s", path_str);
 		str_tmp += buf_pos;
 
 		switch(filecon->type) {
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index ec430743..be260a31 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4148,7 +4148,12 @@ int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 	type = parse_current->next->next->data;
 	cil_filecon_init(&filecon);
 
+	ast_node->data = filecon;
+	ast_node->flavor = CIL_FILECON;
+
 	filecon->path_str = parse_current->next->data;
+	/* filecon->path will be NULL if in a macro and the path is an argument */
+	filecon->path = cil_gen_declared_string(db, filecon->path_str, ast_node);
 
 	if (type == CIL_KEY_ANY) {
 		filecon->type = CIL_FILECON_ANY;
@@ -4187,9 +4192,6 @@ int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		}
 	}
 
-	ast_node->data = filecon;
-	ast_node->flavor = CIL_FILECON;
-
 	return SEPOL_OK;
 
 exit:
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index b6e13f3c..f025de2f 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -1124,6 +1124,7 @@ int cil_copy_filecon(struct cil_db *db, void *data, void **copy, __attribute__((
 	cil_filecon_init(&new);
 
 	new->path_str = orig->path_str;
+	new->path = orig->path;
 	new->type = orig->type;
 
 	if (orig->context_str != NULL) {
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 6d578cea..4193ee99 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -740,6 +740,7 @@ enum cil_filecon_types {
 
 struct cil_filecon {
 	char *path_str;
+	struct cil_symtab_datum *path;
 	enum cil_filecon_types type;
 	char *context_str;
 	struct cil_context *context;
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index da97a392..7f45299a 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -213,12 +213,16 @@ int cil_post_filecon_compare(const void *a, const void *b)
 	struct cil_filecon *b_filecon = *(struct cil_filecon**)b;
 	struct fc_data *a_data = cil_malloc(sizeof(*a_data));
 	struct fc_data *b_data = cil_malloc(sizeof(*b_data));
-	char *a_path = cil_malloc(strlen(a_filecon->path_str) + 1);
-	char *b_path = cil_malloc(strlen(b_filecon->path_str) + 1);
+	char *a_path_str, *a_path, *b_path_str, *b_path;
+
+	a_path_str = a_filecon->path ? DATUM(a_filecon->path)->fqn : a_filecon->path_str;
+	b_path_str = b_filecon->path ? DATUM(b_filecon->path)->fqn : b_filecon->path_str;
+	a_path = cil_malloc(strlen(a_path_str) + 1);
+	b_path = cil_malloc(strlen(b_path_str) + 1);
 	a_path[0] = '\0';
 	b_path[0] = '\0';
-	strcat(a_path, a_filecon->path_str);
-	strcat(b_path, b_filecon->path_str);
+	strcat(a_path, a_path_str);
+	strcat(b_path, b_path_str);
 	cil_post_fc_fill_data(a_data, a_path);
 	cil_post_fc_fill_data(b_data, b_path);
 	if (a_data->meta && !b_data->meta) {
@@ -238,7 +242,7 @@ int cil_post_filecon_compare(const void *a, const void *b)
 	} else if (b_filecon->type < a_filecon->type) {
 		rc = 1;
 	} else {
-		rc = strcmp(a_filecon->path_str, b_filecon->path_str);
+		rc = strcmp(a_path_str, b_path_str);
 	}
 
 	free(a_path);
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index bdff044a..d52c106a 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -1811,8 +1811,17 @@ int cil_resolve_filecon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_filecon *filecon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
+	struct cil_symtab_datum *path_datum = NULL;
 	int rc = SEPOL_ERR;
 
+	if (!filecon->path) {
+		rc = cil_resolve_name(current, filecon->path_str, CIL_SYM_STRINGS, db, &path_datum);
+		if (rc != SEPOL_OK) {
+			return rc;
+		}
+		filecon->path = path_datum;
+	}
+
 	if (filecon->context_str != NULL) {
 		rc = cil_resolve_name(current, filecon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index d867fa8b..161c53e9 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1265,7 +1265,11 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	case CIL_FILECON: {
 		struct cil_filecon *filecon = node->data;
 		fprintf(out, "(filecon ");
-		fprintf(out, "\"%s\" ", filecon->path_str);
+		if (filecon->path) {
+			fprintf(out, "\"%s\" ", DATUM(filecon->path)->fqn);
+		} else {
+			fprintf(out, "%s ", filecon->path_str);
+		}
 		switch (filecon->type) {
 		case CIL_FILECON_ANY:
 			fprintf(out, "%s ", CIL_KEY_ANY);
-- 
2.41.0

