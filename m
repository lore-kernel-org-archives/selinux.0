Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2161C433F1
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93AF61990
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhCVQrZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhCVQrO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Mar 2021 12:47:14 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABCC061574
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:47:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h7so12811377qtx.3
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3BVy6eCcH2VdWncMMj8ueW588K2nd/fa7oCaIFcUamM=;
        b=YO+agmV3QxISNECasnQw734+aU3KlwKr4uC+0pbjgxiCwi/1IXq+E6OdXNHZFB59IG
         mYMbukVWRDP6AC7CFXHAU+8l+UKKEKjRIUYGAxxXQ6CTz7IVUMh4uGFgJNWW9RmAF1dd
         lAl5dIdKVs6dObcNyvKBmaRQbtINCOHox5aKHEdJt52hEyvBSYIEQZPrub7HGw4+5Y+6
         vJ2jXsjSXlwSQiHzTXd2n7glrpONRfTuIowLFnwM+jCSKWS/ROFVfZWQkUtiFuFzUgLe
         kQcH8j6IkImI4lFK4kkzrxIlQcDuh6FLY77V4KRiseE4XPIVRZZGeKscTla3HH1BqpLl
         eZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3BVy6eCcH2VdWncMMj8ueW588K2nd/fa7oCaIFcUamM=;
        b=cGXuBaOEFp7o3TD0ahn0YThmdIYvBXLcu3HjsuESjK3bCWiJBMlqKlCqt08a80TCll
         nWWdSvGOg1wH/iXV5WIylpf7Zq8aDcRy58uphztbwQmZOUkl8a9NYHEgWOYND6lUbnex
         7loI2vwhIMP+fNDoMREXlkmYmDz2JuoL3tb9Ux0Z/xVMc/hzoWWvZocBfCRdkN7GfX5D
         mRupjZtF2IPwJJ7RgHk3ZPvUiW4RD6vactb87jpJbhUQ1DTTqkLaUiXxtpE92N/2WmQV
         mm/uhxExQsB5lw8BdSq8dSQORbfPVTfUX4Mcj9WIcwXSCikSaN4wAWiY7QzOH1oeooaK
         OIMw==
X-Gm-Message-State: AOAM532G8BJiAbNj72c9W5zMwjfZXlt4lTNjmkDTu0STrt0N7povajv8
        gQDnl3liUR1hVvxT+Hb2fWDQpX9p9BmAKg==
X-Google-Smtp-Source: ABdhPJyPp+/nqSNXEjK/4oNctVexLIVwynIW3YkJlAFvBzFfctU9i1r8AY2i4wJ0qFdKYdk1MusDxQ==
X-Received: by 2002:ac8:4ccc:: with SMTP id l12mr728205qtv.137.1616431632848;
        Mon, 22 Mar 2021 09:47:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f9sm10964106qkk.115.2021.03.22.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:47:11 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol/cil: Refactor helper function for cil_gen_node()
Date:   Mon, 22 Mar 2021 12:47:01 -0400
Message-Id: <20210322164703.29564-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322164703.29564-1-jwcart2@gmail.com>
References: <20210322164703.29564-1-jwcart2@gmail.com>
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
index 4e53f06a..764719d0 100644
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
2.26.2

