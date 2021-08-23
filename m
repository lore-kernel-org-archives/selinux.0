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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103DDC432BE
	for <selinux@archiver.kernel.org>; Mon, 23 Aug 2021 20:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E430D61246
	for <selinux@archiver.kernel.org>; Mon, 23 Aug 2021 20:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhHWUtb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHWUta (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Aug 2021 16:49:30 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC66C0613C1
        for <selinux@vger.kernel.org>; Mon, 23 Aug 2021 13:48:47 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g11so14979437qtk.5
        for <selinux@vger.kernel.org>; Mon, 23 Aug 2021 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u25FyanEsf38vfn6VhTnFJZ914tLP5tvvMKUUOTmJW4=;
        b=LVnRVI8tVL5aOrMNXdRFdu23b9h+oerae7PwP9dK4BVrTytv83n0TAk0/H6wmCEbDi
         HMz9eFARIvF+hiMjSsB39OYGECUjSn0tolkO9nAunE/toLx0ojO0Lqft3YixT8HymCj/
         3YySAm9Sg6IAzm0tHby07y0s9j7MaAzxRwrc86wywxRoy63omDWCS9vwAShTy0FzU5w+
         mpA2i6mF70JHt/Ge3xt35ZodlUW+/6oZlaZwwC6CkJir0TI6b4TP8rLdnXt4+c5ziue+
         FjUJjvlPOoWdEZolstY8kEj/5xBIywYxQRr0eFRw7ObQYPCzSvbKwR/C850am7CiNWZg
         3MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u25FyanEsf38vfn6VhTnFJZ914tLP5tvvMKUUOTmJW4=;
        b=kfXTVRe/FhRGHSKqLTsgtCAlIBYlvb4NoElLxfgXVkmOFyDh8usmnPo/fOf+AoCu/A
         /gDLhAMluUZbx//3BbjEkU0AGBqQGo/5cPbwxm3MB8+yWc5hiXBmyOdiQOYEYk93eScM
         PIOQay+75x8h8M1ijot1BG3Ccx07vuAULrOaWvn2S2etALKuUQOSUihU9eQTwFsWu4uI
         oVslA8SAVFgM6Gz9pS7cv7baNt6Jv7zUYxIBmCdwPDhMOOAbRFkAUe7//0MPcEbEdGyc
         AaOmNJuBLdSJkqX9oAtVQ/NiHULBGIKiKRcowXLBKLQBwipp25JUtfrGwgDfPyUa2878
         Ndug==
X-Gm-Message-State: AOAM533+wdSTiGQiJ8hXQ+v78Qxmq752Wnb/E7/nbCpBz1J00Z58+H1C
        TER6BL2zxF5JF054a0EOzl1GHNcq76U=
X-Google-Smtp-Source: ABdhPJwL+dy7Ryoz+4UgiQ7R+kk6LRbXrt8qZerPI4DYbR8A4PGfOqQLrATpcDmvBCFCGmyeu/Y5yA==
X-Received: by 2002:a05:622a:1704:: with SMTP id h4mr31138200qtk.9.1629751726545;
        Mon, 23 Aug 2021 13:48:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v10sm1025460qkj.79.2021.08.23.13.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:48:46 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Properly check parse tree when printing error messages
Date:   Mon, 23 Aug 2021 16:48:41 -0400
Message-Id: <20210823204841.175324-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function cil_tree_get_next_path() does not check whether the
parse tree node that stores the high-level language file path of a
src_info rule actually exists before trying to read the path. This
can result in a NULL dereference.

Check that all of the parse tree nodes of a src_info rule exist
before reading the data from them.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 75293005..3fcf5d12 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -62,7 +62,10 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
 
 	while (node) {
 		if (node->flavor == CIL_NODE && node->data == NULL) {
-			if (node->cl_head->data == CIL_KEY_SRC_INFO && node->cl_head->next != NULL && node->cl_head->next->next != NULL) {
+			if (node->cl_head->data == CIL_KEY_SRC_INFO) {
+				if (node->cl_head->next == NULL || node->cl_head->next->next == NULL || node->cl_head->next->next->next == NULL) {
+					goto exit;
+				}
 				/* Parse Tree */
 				*info_kind = node->cl_head->next->data;
 				rc = cil_string_to_uint32(node->cl_head->next->next->data, hll_line, 10);
-- 
2.31.1

