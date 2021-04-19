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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E76BC43461
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213BD6113C
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbhDSPQ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbhDSPQz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:55 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08636C06138B
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:24 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f12so26329902qtf.2
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2uGQ4SMR7NT/I1qLKeRT+vuzQsg1knGf1Lzc4GrxRc=;
        b=GbBCDarp/g+rtbVOPeQ5ee//vQWyzjr2tbQ8BYGrjDC381/tAT/1AbPi6Ydb6uvk9O
         QhnefBaLVRdbKCMsXUHIvsA8aIrEBKwM+1VE6RxTuLZa9a6iN24Ww33DkiKrljP7dbVz
         g7hEC68Ei+I53i6CLxdR82ChW0MSJf0LYut8iFQXEomPz8b00f8A4a7BzeALrMw2FveP
         BC3PFXSbddAzGETa6cVdcYrN9Ur3air1D+Z9vDzR3ydtt+migR7N9f31Jxel0JaST7mW
         /zQrUA10UrWUNBccKEHLFsv4B1v58d8wurh4SIeqHbID9+Akzlb3HmoOYTOx89u4xMJm
         mSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2uGQ4SMR7NT/I1qLKeRT+vuzQsg1knGf1Lzc4GrxRc=;
        b=GY5JHB73dHXLALTYvrj8lPywRGo4Jr3fdETfPiDevSy8j/+dLfIp8i+xJIuydmFhBX
         dRilfVI9NFsRczXmfAuQLv09IhKGSE8qPy4T2hfwVXhYT4vToSIVF/gh1I5e5GFX2RtU
         cE/6XFo6F6laSKqN/CgRAzh0/eSN/HkqRiegluE8Ulfb288CbBhpWPaJqDoUiyAY1XnP
         GIelzcj0PCRgE7eFRO/P4DNd3A3On5sN4BeHbJ56S5Bp0yrzJstWs3GyOxQtADGw6izS
         apx9dqxCzktY9SxnMh+HQYPLGtBxSqYx98a2N3hv1A/oIk7B3f2wuDU9LPofZk8x8vr1
         j9YQ==
X-Gm-Message-State: AOAM530HqD2WVpUfX0PABj3nycJG5ahbB7rJP0UqyvByhvmHiqf9HeDY
        oLT5B8BW0Hq7651BYQZ156oQ2TEdyyhT5g==
X-Google-Smtp-Source: ABdhPJxgJyIYj/JIy0FkL5FsKxVLMo7uu2Id1qv1kzF/mx+I2E0WlPRp8ouQrldnE2dtAIzesKmg/g==
X-Received: by 2002:ac8:5745:: with SMTP id 5mr12085172qtx.252.1618845383943;
        Mon, 19 Apr 2021 08:16:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:23 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 09/11 v2] libsepol/cil: Refactor helper function for cil_gen_node()
Date:   Mon, 19 Apr 2021 11:15:55 -0400
Message-Id: <20210419151557.87561-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
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

