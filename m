Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA014C4320E
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 20:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09D461027
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 20:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhIAUn5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhIAUn4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Sep 2021 16:43:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB2CC061575
        for <selinux@vger.kernel.org>; Wed,  1 Sep 2021 13:42:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id dt3so627436qvb.6
        for <selinux@vger.kernel.org>; Wed, 01 Sep 2021 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHKdZ7QPEdV6CqdZ6/C9gpYCLQ5VwVWDm1Y9wKQuAdQ=;
        b=QKBmupNBHJ8ORcAAmKiulVWOMlAAzPY2jKdjRdaT5yF2cKkphj5I7PcYH13Y/uinqt
         9efrf0S1WaFb16SsGr51x0ZinnAzM7zkWF5QQgvzY/RO51/uJagAtS44dP1c83zJt84h
         fX59jNn//JBz/dUk+F3Lldr6XFM7HmfA1ozVUg/9FSEX8pTxnxPr0K4YTI394Gv0E1Mx
         WekZG8oEhwTKSn+j8XuBypMalf209EwhzI/fX9QinyuA2J484oXZElCBanvCnxgFNGe/
         vVmPlYHOqPzc+Q4wPO68aiyGZfqGVE6dr8iEATkJmnP5uzD1DFCs2iaXAUJIMeIS+0Lx
         eA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHKdZ7QPEdV6CqdZ6/C9gpYCLQ5VwVWDm1Y9wKQuAdQ=;
        b=RIoBiP41JD+Xhd3LDtkNAjyyVHi5Am/whiMrLCOw/tZ+L/J0fZPH8FCUNeZOJDwPRs
         t25HU6iP912pXrOAhYfDYQ5wRfyjTkEB157J3d9YcdjImjoOiiTg3Mu1ljP95B4yC2Yw
         0lVjLXbOwp4CuOtBPYmV8ukDlXhlDhHiW5yFHjTSkVMMVRWeWXdfGojoLjXW1yCw8k7q
         xV6hrP+UqprqQ0re01RaDVNQ/86wa+eAFoxNLSzi3QPxZpNq7wtKk3D0rlNmrv8Q1qsX
         c29uUTQUaG6HORJfu+W6dYpT9M04gbXzz/tnZN+PGSu0rVK/iZo24eaApwWjVFiZb9U0
         wqQg==
X-Gm-Message-State: AOAM532k/zV9lc4mfqWxeyBF/y4gPqCEmXEfIvvs7ezMowDvNWphjk8h
        Y5iHD9s53ifR+M7KRdRpuhiwVq/uek8=
X-Google-Smtp-Source: ABdhPJyxBM/bukw98b+HIWex+hAs8C1M1m7zjtGxdNccPTxjTncn1Ls80x14XbVzS5YRZOvCP36gxw==
X-Received: by 2002:a0c:e70f:: with SMTP id d15mr1729714qvn.47.1630528978099;
        Wed, 01 Sep 2021 13:42:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id x23sm500098qkn.29.2021.09.01.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:42:57 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3 v2] libsepol/cil: Use size_t for len in __cil_verify_syntax()
Date:   Wed,  1 Sep 2021 16:42:51 -0400
Message-Id: <20210901204252.635570-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901204252.635570-1-jwcart2@gmail.com>
References: <20210901204252.635570-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since the value passed into __cil_verify_syntax() as the len
parameter is always calculated from sizeof(syntax)/sizeof(*syntax),
use size_t for the calculated value in the calling function and for
the len parameter. In __cil_verify_syntax(), the variable i is only
compared to len, so make that size_t as well.

Suggested by Nicolas Iooss <nicolas.iooss@m4x.org>

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: This patch is new
 
 libsepol/cil/src/cil_build_ast.c | 180 +++++++++++++++----------------
 libsepol/cil/src/cil_verify.c    |   4 +-
 libsepol/cil/src/cil_verify.h    |   2 +-
 3 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index f0bb8c0c..fea950d7 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -64,7 +64,7 @@ int cil_fill_list(struct cil_tree_node *current, enum cil_flavor flavor, struct
 		CIL_SYN_N_STRINGS,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
  
 	rc = __cil_verify_syntax(current, syntax, syntax_len);
 	if (rc != SEPOL_OK) {
@@ -195,7 +195,7 @@ int cil_gen_block(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_N_LISTS | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_block *block = NULL;
 	int rc = SEPOL_ERR;
@@ -271,7 +271,7 @@ int cil_gen_blockinherit(struct cil_db *db, struct cil_tree_node *parse_current,
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_blockinherit *inherit = NULL;
 	int rc = SEPOL_ERR;
 
@@ -333,7 +333,7 @@ int cil_gen_blockabstract(struct cil_db *db, struct cil_tree_node *parse_current
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_blockabstract *abstract = NULL;
 	int rc = SEPOL_ERR;
 
@@ -383,7 +383,7 @@ int cil_gen_in(struct cil_db *db, struct cil_tree_node *parse_current, struct ci
 		CIL_SYN_N_LISTS,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_in *in = NULL;
 
@@ -434,7 +434,7 @@ int cil_gen_class(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_LIST | CIL_SYN_EMPTY_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_class *class = NULL;
 	struct cil_tree_node *perms = NULL;
@@ -502,7 +502,7 @@ int cil_gen_classorder(struct cil_db *db, struct cil_tree_node *parse_current, s
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_classorder *classorder = NULL;
 	struct cil_list_item *curr = NULL;
 	struct cil_list_item *head = NULL;
@@ -653,7 +653,7 @@ int cil_fill_perms(struct cil_tree_node *start_perm, struct cil_list **perms)
 		CIL_SYN_N_STRINGS | CIL_SYN_N_LISTS,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	rc = __cil_verify_syntax(start_perm->cl_head, syntax, syntax_len);
 	if (rc != SEPOL_OK) {
@@ -680,7 +680,7 @@ int cil_fill_classperms(struct cil_tree_node *parse_current, struct cil_classper
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
 	if (rc != SEPOL_OK) {
@@ -801,7 +801,7 @@ int cil_gen_classpermission(struct cil_db *db, struct cil_tree_node *parse_curre
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	if (db == NULL || parse_current == NULL || ast_node == NULL) {
 		goto exit;
@@ -859,7 +859,7 @@ int cil_gen_classpermissionset(struct cil_db *db, struct cil_tree_node *parse_cu
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	if (db == NULL || parse_current == NULL || ast_node == NULL) {
 		goto exit;
@@ -909,7 +909,7 @@ int cil_gen_map_class(struct cil_db *db, struct cil_tree_node *parse_current, st
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_class *map = NULL;
 	int rc = SEPOL_ERR;
@@ -953,7 +953,7 @@ int cil_gen_classmapping(struct cil_db *db, struct cil_tree_node *parse_current,
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	if (db == NULL || parse_current == NULL || ast_node == NULL) {
 		goto exit;
@@ -1005,7 +1005,7 @@ int cil_gen_common(struct cil_db *db, struct cil_tree_node *parse_current, struc
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_class *common = NULL;
 	int rc = SEPOL_ERR;
@@ -1057,7 +1057,7 @@ int cil_gen_classcommon(struct cil_db *db, struct cil_tree_node *parse_current,
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_classcommon *clscom = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1103,7 +1103,7 @@ int cil_gen_sid(struct cil_db *db, struct cil_tree_node *parse_current, struct c
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_sid *sid = NULL;
 	int rc = SEPOL_ERR;
@@ -1153,7 +1153,7 @@ int cil_gen_sidcontext(struct cil_db *db, struct cil_tree_node *parse_current, s
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_sidcontext *sidcon = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1212,7 +1212,7 @@ int cil_gen_sidorder(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_sidorder *sidorder = NULL;
 	struct cil_list_item *curr = NULL;
 	int rc = SEPOL_ERR;
@@ -1272,7 +1272,7 @@ int cil_gen_user(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_user *user = NULL;
 	int rc = SEPOL_ERR;
@@ -1323,7 +1323,7 @@ int cil_gen_userattribute(struct cil_db *db, struct cil_tree_node *parse_current
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_userattribute *attr = NULL;
 	int rc = SEPOL_ERR;
@@ -1390,7 +1390,7 @@ int cil_gen_userattributeset(struct cil_db *db, struct cil_tree_node *parse_curr
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_userattributeset *attrset = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1443,7 +1443,7 @@ int cil_gen_userlevel(struct cil_db *db, struct cil_tree_node *parse_current, st
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_userlevel *usrlvl = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1503,7 +1503,7 @@ int cil_gen_userrange(struct cil_db *db, struct cil_tree_node *parse_current, st
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_userrange *userrange = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1563,7 +1563,7 @@ int cil_gen_userprefix(struct cil_db *db, struct cil_tree_node *parse_current, s
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_userprefix *userprefix = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1609,7 +1609,7 @@ int cil_gen_selinuxuser(struct cil_db *db, struct cil_tree_node *parse_current,
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_selinuxuser *selinuxuser = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1656,7 +1656,7 @@ int cil_gen_selinuxuserdefault(struct cil_db *db, struct cil_tree_node *parse_cu
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_selinuxuser *selinuxuser = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1715,7 +1715,7 @@ int cil_gen_role(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_role *role = NULL;
 	int rc = SEPOL_ERR;
@@ -1767,7 +1767,7 @@ int cil_gen_roletype(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_roletype *roletype = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1813,7 +1813,7 @@ int cil_gen_userrole(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_userrole *userrole = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1861,7 +1861,7 @@ int cil_gen_roletransition(struct cil_tree_node *parse_current, struct cil_tree_
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_roletransition *roletrans = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1909,7 +1909,7 @@ int cil_gen_roleallow(struct cil_db *db, struct cil_tree_node *parse_current, st
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_roleallow *roleallow = NULL;
 	int rc = SEPOL_ERR;
 
@@ -1954,7 +1954,7 @@ int cil_gen_roleattribute(struct cil_db *db, struct cil_tree_node *parse_current
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_roleattribute *attr = NULL;
 	int rc = SEPOL_ERR;
@@ -2018,7 +2018,7 @@ int cil_gen_roleattributeset(struct cil_db *db, struct cil_tree_node *parse_curr
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_roleattributeset *attrset = NULL;
 	int rc = SEPOL_ERR;
 
@@ -2072,7 +2072,7 @@ int cil_gen_avrule(struct cil_tree_node *parse_current, struct cil_tree_node *as
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_avrule *rule = NULL;
 	int rc = SEPOL_ERR;
 
@@ -2134,7 +2134,7 @@ int cil_fill_permissionx(struct cil_tree_node *parse_current, struct cil_permiss
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 
 	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
@@ -2172,7 +2172,7 @@ int cil_gen_permissionx(struct cil_db *db, struct cil_tree_node *parse_current,
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_permissionx *permx = NULL;
 	int rc = SEPOL_ERR;
@@ -2232,7 +2232,7 @@ int cil_gen_avrulex(struct cil_tree_node *parse_current, struct cil_tree_node *a
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_avrule *rule = NULL;
 	int rc = SEPOL_ERR;
 
@@ -2284,7 +2284,7 @@ int cil_gen_type_rule(struct cil_tree_node *parse_current, struct cil_tree_node
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_type_rule *rule = NULL;
 	int rc = SEPOL_ERR;
 
@@ -2332,7 +2332,7 @@ int cil_gen_type(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_type *type = NULL;
 	int rc = SEPOL_ERR;
@@ -2380,7 +2380,7 @@ int cil_gen_typeattribute(struct cil_db *db, struct cil_tree_node *parse_current
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_typeattribute *attr = NULL;
 	int rc = SEPOL_ERR;
@@ -2445,7 +2445,7 @@ int cil_gen_bool(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_bool *boolean = NULL;
 	int rc = SEPOL_ERR;
@@ -2509,7 +2509,7 @@ int cil_gen_tunable(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_tunable *tunable = NULL;
 	int rc = SEPOL_ERR;
@@ -2849,7 +2849,7 @@ int cil_gen_boolif(struct cil_db *db, struct cil_tree_node *parse_current, struc
 		CIL_SYN_LIST | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_booleanif *bif = NULL;
 	struct cil_tree_node *next = NULL;
 	int rc = SEPOL_ERR;
@@ -2917,7 +2917,7 @@ int cil_gen_tunif(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_LIST | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_tunableif *tif = NULL;
 	struct cil_tree_node *next = NULL;
 	int rc = SEPOL_ERR;
@@ -2978,7 +2978,7 @@ int cil_gen_condblock(struct cil_db *db, struct cil_tree_node *parse_current, st
 		CIL_SYN_N_LISTS,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_condblock *cb = NULL;
 
@@ -3030,7 +3030,7 @@ int cil_gen_alias(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_alias *alias = NULL;
 	enum cil_sym_index sym_index;
@@ -3089,7 +3089,7 @@ int cil_gen_aliasactual(struct cil_db *db, struct cil_tree_node *parse_current,
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_aliasactual *aliasactual = NULL;
 
 	if (db == NULL || parse_current == NULL || ast_node == NULL) {
@@ -3141,7 +3141,7 @@ int cil_gen_typeattributeset(struct cil_db *db, struct cil_tree_node *parse_curr
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_typeattributeset *attrset = NULL;
 	int rc = SEPOL_ERR;
 
@@ -3194,7 +3194,7 @@ int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_node *parse_c
 		CIL_SYN_END
 	};
 	char *expand_str;
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_expandtypeattribute *expandattr = NULL;
 	int rc = SEPOL_ERR;
 
@@ -3262,7 +3262,7 @@ int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node *parse_curren
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_typepermissive *typeperm = NULL;
 	int rc = SEPOL_ERR;
 
@@ -3311,7 +3311,7 @@ int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_curren
 		CIL_SYN_STRING | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *s1, *s2, *s3, *s4, *s5;
 
 	if (db == NULL || parse_current == NULL || ast_node == NULL ) {
@@ -3401,7 +3401,7 @@ int cil_gen_rangetransition(struct cil_db *db, struct cil_tree_node *parse_curre
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_rangetransition *rangetrans = NULL;
 	int rc = SEPOL_ERR;
 
@@ -3464,7 +3464,7 @@ int cil_gen_sensitivity(struct cil_db *db, struct cil_tree_node *parse_current,
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_sens *sens = NULL;
 	int rc = SEPOL_ERR;
@@ -3516,7 +3516,7 @@ int cil_gen_category(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_cat *cat = NULL;
 	int rc = SEPOL_ERR;
@@ -3566,7 +3566,7 @@ int cil_gen_catset(struct cil_db *db, struct cil_tree_node *parse_current, struc
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_catset *catset = NULL;
 	int rc = SEPOL_ERR;
@@ -3623,7 +3623,7 @@ int cil_gen_catorder(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_catorder *catorder = NULL;
 	struct cil_list_item *curr = NULL;
 	int rc = SEPOL_ERR;
@@ -3683,7 +3683,7 @@ int cil_gen_sensitivityorder(struct cil_db *db, struct cil_tree_node *parse_curr
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_sensorder *sensorder = NULL;
 	struct cil_list_item *curr = NULL;
 	int rc = SEPOL_ERR;
@@ -3744,7 +3744,7 @@ int cil_gen_senscat(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_senscat *senscat = NULL;
 	int rc = SEPOL_ERR;
 
@@ -3796,7 +3796,7 @@ int cil_gen_level(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_level *level = NULL;
 	int rc = SEPOL_ERR;
@@ -3854,7 +3854,7 @@ int cil_fill_levelrange(struct cil_tree_node *low, struct cil_levelrange *lvlran
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 
 	if (low == NULL || lvlrange == NULL) {
@@ -3902,7 +3902,7 @@ int cil_gen_levelrange(struct cil_db *db, struct cil_tree_node *parse_current, s
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_levelrange *lvlrange = NULL;
 	int rc = SEPOL_ERR;
@@ -3966,7 +3966,7 @@ int cil_gen_constrain(struct cil_db *db, struct cil_tree_node *parse_current, st
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_constrain *cons = NULL;
 	int rc = SEPOL_ERR;
 
@@ -4023,7 +4023,7 @@ int cil_gen_validatetrans(struct cil_db *db, struct cil_tree_node *parse_current
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_validatetrans *validtrans = NULL;
 	int rc = SEPOL_ERR;
 
@@ -4080,7 +4080,7 @@ int cil_fill_context(struct cil_tree_node *user_node, struct cil_context *contex
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 
 	if (user_node == NULL || context == NULL) {
@@ -4124,7 +4124,7 @@ int cil_gen_context(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_context *context = NULL;
 	int rc = SEPOL_ERR;
@@ -4185,7 +4185,7 @@ int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		CIL_SYN_STRING | CIL_SYN_LIST | CIL_SYN_EMPTY_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_filecon *filecon = NULL;
 	char *type = NULL;
@@ -4275,7 +4275,7 @@ int cil_gen_ibpkeycon(__attribute__((unused)) struct cil_db *db, struct cil_tree
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax) / sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax) / sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_ibpkeycon *ibpkeycon = NULL;
 
@@ -4358,7 +4358,7 @@ int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_portcon *portcon = NULL;
 	char *proto;
@@ -4460,7 +4460,7 @@ int cil_gen_nodecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_nodecon *nodecon = NULL;
 
@@ -4549,7 +4549,7 @@ int cil_gen_genfscon(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_genfscon *genfscon = NULL;
 
@@ -4612,7 +4612,7 @@ int cil_gen_netifcon(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_netifcon *netifcon = NULL;
 
@@ -4688,7 +4688,7 @@ int cil_gen_ibendportcon(__attribute__((unused)) struct cil_db *db, struct cil_t
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax) / sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax) / sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_ibendportcon *ibendportcon = NULL;
 
@@ -4749,7 +4749,7 @@ int cil_gen_pirqcon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_pirqcon *pirqcon = NULL;
 
@@ -4812,7 +4812,7 @@ int cil_gen_iomemcon(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_iomemcon *iomemcon = NULL;
 
@@ -4897,7 +4897,7 @@ int cil_gen_ioportcon(struct cil_db *db, struct cil_tree_node *parse_current, st
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_ioportcon *ioportcon = NULL;
 
@@ -4982,7 +4982,7 @@ int cil_gen_pcidevicecon(struct cil_db *db, struct cil_tree_node *parse_current,
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_pcidevicecon *pcidevicecon = NULL;
 
@@ -5045,7 +5045,7 @@ int cil_gen_devicetreecon(struct cil_db *db, struct cil_tree_node *parse_current
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	int rc = SEPOL_ERR;
 	struct cil_devicetreecon *devicetreecon = NULL;
 
@@ -5106,7 +5106,7 @@ int cil_gen_fsuse(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *type = NULL;
 	struct cil_fsuse *fsuse = NULL;
 	int rc = SEPOL_ERR;
@@ -5195,7 +5195,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_N_LISTS | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/ sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/ sizeof(*syntax);
 
 	if (db == NULL || parse_current == NULL || ast_node == NULL) {
 		goto exit;
@@ -5340,7 +5340,7 @@ int cil_gen_call(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		CIL_SYN_LIST | CIL_SYN_EMPTY_LIST | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_call *call = NULL;
 	int rc = SEPOL_ERR;
 
@@ -5445,7 +5445,7 @@ int cil_gen_optional(struct cil_db *db, struct cil_tree_node *parse_current, str
 		CIL_SYN_N_LISTS | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_optional *optional = NULL;
 	int rc = SEPOL_ERR;
@@ -5493,7 +5493,7 @@ int cil_gen_policycap(struct cil_db *db, struct cil_tree_node *parse_current, st
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_policycap *polcap = NULL;
 	int rc = SEPOL_ERR;
@@ -5542,7 +5542,7 @@ int cil_gen_ipaddr(struct cil_db *db, struct cil_tree_node *parse_current, struc
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	char *key = NULL;
 	struct cil_ipaddr *ipaddr = NULL;
 	int rc = SEPOL_ERR;
@@ -5664,7 +5664,7 @@ int cil_fill_level(struct cil_tree_node *curr, struct cil_level *level)
 		CIL_SYN_STRING | CIL_SYN_LIST | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	if (curr == NULL) {
 		goto exit;
@@ -5725,7 +5725,7 @@ int cil_gen_bounds(struct cil_db *db, struct cil_tree_node *parse_current, struc
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_bounds *bounds = NULL;
 	int rc = SEPOL_ERR;
 
@@ -5787,7 +5787,7 @@ int cil_gen_default(struct cil_tree_node *parse_current, struct cil_tree_node *a
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
 	if (rc != SEPOL_OK) {
@@ -5856,7 +5856,7 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 		CIL_SYN_STRING | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
 	if (rc != SEPOL_OK) {
@@ -5952,7 +5952,7 @@ int cil_gen_handleunknown(struct cil_tree_node *parse_current, struct cil_tree_n
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_handleunknown *unknown = NULL;
 	char *unknown_key;
 
@@ -6004,7 +6004,7 @@ int cil_gen_mls(struct cil_tree_node *parse_current, struct cil_tree_node *ast_n
 		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_mls *mls = NULL;
 
 	if (parse_current == NULL || ast_node == NULL) {
@@ -6055,7 +6055,7 @@ int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *
 		CIL_SYN_N_LISTS | CIL_SYN_END,
 		CIL_SYN_END
 	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_src_info *info = NULL;
 
 	if (parse_current == NULL || ast_node == NULL) {
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index fc8a8a40..6438ceba 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -144,12 +144,12 @@ exit:
 	return rc;
 }
 
-int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], int len)
+int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], size_t len)
 {
 	int rc = SEPOL_ERR;
 	int num_extras = 0;
 	struct cil_tree_node *c = parse_current;
-	int i = 0;
+	size_t i = 0;
 	while (i < len) {
 		if ((s[i] & CIL_SYN_END) && c == NULL) {
 			break;
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index 26e195a9..bb1a072c 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -57,7 +57,7 @@ struct cil_args_verify {
 };
 
 int cil_verify_name(const struct cil_db *db, const char *name, enum cil_flavor flavor);
-int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], int len);
+int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], size_t len);
 int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, enum cil_flavor expr_flavor);
 int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_flavor r_flavor, enum cil_flavor op, enum cil_flavor expr_flavor);
 int cil_verify_constraint_expr_syntax(struct cil_tree_node *current, enum cil_flavor op);
-- 
2.31.1

