Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E006AC433ED
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB13610F9
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhDHTQs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhDHTQs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:48 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1358C061761
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id j7so2319191qtx.5
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2uGQ4SMR7NT/I1qLKeRT+vuzQsg1knGf1Lzc4GrxRc=;
        b=ZY3kHRPzEA6TaOsp12A3IIxnW5ghjWf2zwn56Qcqe+QzWi3fRPvwXVUA66Z3DfHV/u
         3uWb5RY1hv74SdB/PiqwmKmBkUTHx8o8t/FPTAJ7tnQSgTWC1K6YtUWPChbV7PmHUDao
         jJ7ofwgpVb3pGZLwaD57mCrsUHVrjo9Tword6E6Od5P/eMqZQsbNLln39VEIwsN2gaEs
         ZgCT7do7R6NKwVF1IwDlq4llRgDbIJvSayfnglPZ83/BwbnvRXluNAQlhTGgEcvLoWk+
         0u1wsvsr7Rb3qdBvkQx1rBnazKvY3TFcUQzVkPGUYTdEzbo514Bfcu2m4TRExQH3ZfBV
         k4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2uGQ4SMR7NT/I1qLKeRT+vuzQsg1knGf1Lzc4GrxRc=;
        b=OgUZm9PvltKo2H2dTkK2qCtkgVyQuNl6kbM4sEqu9Y8LSmjK514Nhp3CGWtdn7bV4a
         GrCk+o0H4uOXXXwLRU+rYBTi3PYLsMRC1HXS94rBmgPZum0oPUOphgHOVEfd8T0qN2Dl
         rwqK7zZ1WgWOuk/jeD1gtZPOW6EB0VKbMLXok1YtpKXHqnSzdPwp3Pi7Al33rkMQFppq
         NfdcqNUTbqICXioxxjyZLbYI3CQFkUokDgRCHKRHMPW/pGyXXKlMlmci0uDFFylnjGec
         stqIpsxM72l7PzZZNsM+Q9xP7z3NvfPaAS6cuC1E6P6ePzQZ1WsuTBSVUxMEZGR6tSUV
         4TUQ==
X-Gm-Message-State: AOAM530jei+T4rqvGBRrprMTM53U4XVn28xdElHjyD/i5+H8/Vsfs+uE
        lv8/EI6e5R82XbbXYTXcaKGzrcjArJ6TKQ==
X-Google-Smtp-Source: ABdhPJws7IXmQPioOlZKiQrnl+qicVH8EVXyLq0jbc2g14PBVhXBvEkkFUEnffatxaO6yXGBDvTCeQ==
X-Received: by 2002:a05:622a:1347:: with SMTP id w7mr2554466qtk.199.1617909396090;
        Thu, 08 Apr 2021 12:16:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:35 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 09/11] libsepol/cil: Refactor helper function for cil_gen_node()
Date:   Thu,  8 Apr 2021 15:16:12 -0400
Message-Id: <20210408191614.262173-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the name of cil_is_datum_multiple_decl() to
cil_allow_multiple_decls() and make it static. The new function
takes the CIL db and the flavors of the old and new datum as
arguments. Also, put all of the logic of determining if multiple
declarations are allowed into the new function. Finally, update
the call from cil_gen_node().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index e57de662..14cdce14 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -82,30 +82,24 @@ exit:
 	return rc;
 }
 
-/*
- * Determine whether or not multiple declarations of the same key can share a
- * datum, given the new datum and the one already present in a given symtab.
- */
-int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *cur,
-                               struct cil_symtab_datum *old,
-                               enum cil_flavor f)
+static int cil_allow_multiple_decls(struct cil_db *db, enum cil_flavor f_new, enum cil_flavor f_old)
 {
-	int rc = CIL_FALSE;
+	if (f_new != f_old) {
+		return CIL_FALSE;
+	}
 
-	switch (f) {
+	switch (f_new) {
 	case CIL_TYPE:
 	case CIL_TYPEATTRIBUTE:
-		if (!old || f != FLAVOR(old)) {
-			rc = CIL_FALSE;
-		} else {
-			/* type and typeattribute statements insert empty datums */
-			rc = CIL_TRUE;
+		if (db->multiple_decls) {
+			return CIL_TRUE;
 		}
 		break;
 	default:
 		break;
 	}
-	return rc;
+
+	return CIL_FALSE;
 }
 
 int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_symtab_datum *datum, hashtab_key_t key, enum cil_sym_index sflavor, enum cil_flavor nflavor)
@@ -135,8 +129,7 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 				cil_log(CIL_ERR, "Re-declaration of %s %s, but previous declaration could not be found\n",cil_node_to_string(ast_node), key);
 				goto exit;
 			}
-			if (!db->multiple_decls ||
-			    !cil_is_datum_multiple_decl(datum, prev, nflavor)) {
+			if (!cil_allow_multiple_decls(db, nflavor, FLAVOR(prev))) {
 				/* multiple_decls not ok, ret error */
 				struct cil_tree_node *node = NODE(prev);
 				cil_log(CIL_ERR, "Re-declaration of %s %s\n",
-- 
2.26.3

