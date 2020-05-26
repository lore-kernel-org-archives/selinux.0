Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6625CC433DF
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41372207FB
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqs3UoZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgEZSvS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 14:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgEZSvR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 14:51:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF1EC03E96D
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 11:51:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c185so7630735qke.7
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nh/MkUJcu80DgkPsl7+UP6STksdzuCJhFbxQPscqtPE=;
        b=gqs3UoZg1ypfLhcE2cmukCmlST9nbqo0uGVi4dJLD4L2CoLt4mXkJaf430GaAk/9Sx
         g3WhHfzcLKfuoIgC8ZcEOqZIKUQGivpuLE8Fsy7c3JBktIc1ric/sD859TjM8B8wqZzz
         idIfA20hcF/vVFFtYmywX347QauwtddgEW/QYOUqldmBUj3P5b3/AypK+zx7+NR7JUqS
         IzWvBe2dMlxJ24emYiShucPKFHeaF1bf8u5z0NUlls9sSswREDCHjQVx9mTPA7ojGzLy
         P+QiCZfDqVUJPB8CV30l47S558E/ZwwuBdqUpV9Tcx/KT2BBub8pzv0t11oxxUJc6bgV
         nSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nh/MkUJcu80DgkPsl7+UP6STksdzuCJhFbxQPscqtPE=;
        b=ZjZi8ThmFU4oAOsxxWuiksyJxJVPwWLbV3OECMwBxaNmInkTfWw5PDT3kZ56F0Jbjv
         unsjrst0lIM3oYoZY7IUz/emP+eg4NENfvEI8vdaFBBrnOyP9iI2QjETXlnGpZD4zeem
         O70UI7cI3U4GnaU4Yr6MJD+/0Rrko/SZq46Js4mWX4+sme7+6e/3bbbKrZli9q65m70Q
         paeqdqtdaBF/5bjYttJE+jzIft4dRSy2u9icPAC1gkL6zFKBgwlStGLAtWrpYJ+7I7Iv
         Kcl0aZ8nxdkYUqpL//FL0U5ry32vAAyhbzPiK/uqjKEqetMGejgDaZJOZbmVF76SH18n
         nbvg==
X-Gm-Message-State: AOAM533UQx2MLtjIartypIEkkIkrtAJ9txIYHuP6QtG5IN64sqpKLoot
        4S8aL7hA96SK7A8JU2/Z1R2Rxu3R
X-Google-Smtp-Source: ABdhPJxT2Ojsz35qWpCup24wmRrV13sTXzSeTr5g/bUpoY0BYhpWMIJixSnB7RMJhdaUaoljP4/80A==
X-Received: by 2002:a05:620a:1321:: with SMTP id p1mr240025qkj.476.1590519075508;
        Tue, 26 May 2020 11:51:15 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-97-86.bltmmd.east.verizon.net. [71.166.97.86])
        by smtp.gmail.com with ESMTPSA id n13sm488718qtb.20.2020.05.26.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:51:15 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v3 2/2] libsepol/cil: Return error when identifier declared as both type and attribute
Date:   Tue, 26 May 2020 14:50:58 -0400
Message-Id: <20200526185058.42827-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200526185058.42827-1-jwcart2@gmail.com>
References: <20200526185058.42827-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CIL allows a type to be redeclared when using the multiple declarations
option ("-m" or "--muliple-decls"), but make it an error for an identifier
to be declared as both a type and an attribute.

Change the error message so that it always gives the location and flavor
of both declarations. The flavors will be the same in all other cases,
but in this case they explain why there is an error even if multiple
declartions are allowed.

Fixes: Commit fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare types[attributes]")
Reported-by: Topi Miettinen <toiwoton@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Added these changes
v3: Removed the error message about not creating a node

 libsepol/cil/src/cil_build_ast.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index fcecdc4f..60ecaaff 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -87,7 +87,7 @@ exit:
  * datum, given the new datum and the one already present in a given symtab.
  */
 int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *cur,
-                               __attribute__((unused)) struct cil_symtab_datum *old,
+                               struct cil_symtab_datum *old,
                                enum cil_flavor f)
 {
 	int rc = CIL_FALSE;
@@ -95,8 +95,12 @@ int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *
 	switch (f) {
 	case CIL_TYPE:
 	case CIL_TYPEATTRIBUTE:
-		/* type and typeattribute statements insert empty datums, ret true */
-		rc = CIL_TRUE;
+		if (!old || f != FLAVOR(old)) {
+			rc = CIL_FALSE;
+		} else {
+			/* type and typeattribute statements insert empty datums */
+			rc = CIL_TRUE;
+		}
 		break;
 	default:
 		break;
@@ -126,19 +130,20 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 	if (symtab != NULL) {
 		rc = cil_symtab_insert(symtab, (hashtab_key_t)key, datum, ast_node);
 		if (rc == SEPOL_EEXIST) {
+			rc = cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev);
+			if (rc != SEPOL_OK) {
+				cil_log(CIL_ERR, "Re-declaration of %s %s, but previous declaration could not be found\n",cil_node_to_string(ast_node), key);
+				goto exit;
+			}
 			if (!db->multiple_decls ||
-			    cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev) != SEPOL_OK ||
 			    !cil_is_datum_multiple_decl(datum, prev, nflavor)) {
-
 				/* multiple_decls not ok, ret error */
+				struct cil_tree_node *node = NODE(prev);
 				cil_log(CIL_ERR, "Re-declaration of %s %s\n",
 					cil_node_to_string(ast_node), key);
-				if (cil_symtab_get_datum(symtab, key, &datum) == SEPOL_OK) {
-					if (sflavor == CIL_SYM_BLOCKS) {
-						struct cil_tree_node *node = datum->nodes->head->data;
-						cil_tree_log(node, CIL_ERR, "Previous declaration");
-					}
-				}
+				cil_tree_log(node, CIL_ERR, "Previous declaration of %s",
+					cil_node_to_string(node));
+				rc = SEPOL_ERR;
 				goto exit;
 			}
 			/* multiple_decls is enabled and works for this datum type, add node */
@@ -169,7 +174,6 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Failed to create node\n");
 	return rc;
 }
 
-- 
2.25.4

