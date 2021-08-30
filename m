Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EA0C4320A
	for <selinux@archiver.kernel.org>; Mon, 30 Aug 2021 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F3A60243
	for <selinux@archiver.kernel.org>; Mon, 30 Aug 2021 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhH3SZn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbhH3SZn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Aug 2021 14:25:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F816C06175F
        for <selinux@vger.kernel.org>; Mon, 30 Aug 2021 11:24:49 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id ay33so16670967qkb.10
        for <selinux@vger.kernel.org>; Mon, 30 Aug 2021 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qal8ta/dQWoFH8mlmeM5XshGflRUX5EjnQ57wvhJNCc=;
        b=vPxC7E6CuOx+senqDbV9tzp6bacbSzL8Sp7pmp33JlSg3rYA08v9MKkbyep2V/oFLt
         qybQh1bsOVpvQhjIMLynLTJ3eGsTMl+4UdNOb1yo5qcy/JRwxeoNESHNvHwp+HkaZjf1
         X0UbGuF5iUldqWdR3amsEedOCzafIfQy0KzXB3CCNsmE3QMwW6U7uKhYY2mHlRpauTRO
         efVD0AVt5qY7sBbn/OpQBH36ClKVbL8Jj5be6HBhHj/CuHlrG59RUtdCDt1oaivxNeys
         9WVT/x1OIHHcWw9y2dJdgpSIJ2/+mv5tvZsFkHUJOTgdDYErCaWoojvjVlyD/kqgEBBw
         pFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qal8ta/dQWoFH8mlmeM5XshGflRUX5EjnQ57wvhJNCc=;
        b=BVqiKpfn6DjV5UhYZWnsVY7S/jwnuA8lDjelvHHbuz3Ds5YAe7XHPtJUhLXz79rmjv
         u0vaDNaoOdCiiQGcfmzLTn1n/O/piYTfDzWpLGgaoDU9XFJW3f/cAQu68XnBMmOlZP/g
         YggPC85KiYI+9PH2sLhqsYDU5xwvOxceBdQeQUuaV98iI+zAdEEmCAbmN+bshLPLl5/s
         klnSKiRsPph4esPIKJYZ+dGMwPxQy2WrLeCAUIvmRu1AARQdINJuLqRb3FmmUzeFX/Q7
         HiUMcmdbEq+x+Qo9qTp62d0uBa/aLsJuaBWIQTsjtKLJvJNNbFtAn6AbXf2//DBkJni1
         BjlQ==
X-Gm-Message-State: AOAM532ayEk35dLHrsIUsuL3HPSy0utCPyvlELoFLndo7hYQgbrpShnK
        Ah9G4l07xbgWe3ICtmQNqQE+yD7ypls=
X-Google-Smtp-Source: ABdhPJweww4KlHTEUdZevjN4md3Nca3F6RBQz+5jVKs7jMAzol34zbPya/ZmlySuvGMvUnJ9NQVOEQ==
X-Received: by 2002:a37:e307:: with SMTP id y7mr23608613qki.211.1630347888158;
        Mon, 30 Aug 2021 11:24:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm11581572qkm.56.2021.08.30.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:24:47 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] libsepol/cil: Simplify cil_tree_children_destroy()
Date:   Mon, 30 Aug 2021 14:24:42 -0400
Message-Id: <20210830182442.491886-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830182442.491886-1-jwcart2@gmail.com>
References: <20210830182442.491886-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use a simpler recursive solution and set the head and tail pointers
of the starting node to NULL when done.

Remove the now uneeded setting of the head and tail pointers to NULL
in cil_resolve_in().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c |  2 --
 libsepol/cil/src/cil_tree.c        | 33 +++++++++---------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index aeedc7dd..60dbd163 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2440,8 +2440,6 @@ int cil_resolve_in(struct cil_tree_node *current, void *extra_args)
 	}
 
 	cil_tree_children_destroy(current);
-	current->cl_head = NULL;
-	current->cl_tail = NULL;
 
 	return SEPOL_OK;
 
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 75293005..075b1eb5 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -201,34 +201,21 @@ void cil_tree_subtree_destroy(struct cil_tree_node *node)
 
 void cil_tree_children_destroy(struct cil_tree_node *node)
 {
-	struct cil_tree_node *start_node = node;
-	struct cil_tree_node *next = NULL;
+	struct cil_tree_node *curr, *next;
 
-	if (node == NULL) {
+	if (!node) {
 		return;
 	}
 
-	if (node->cl_head != NULL) {
-		node = node->cl_head;
-	}
-
-	while (node != start_node) {
-		if (node->cl_head != NULL){
-			next = node->cl_head;
-		} else {
-			if (node->next == NULL) {
-				next = node->parent;
-				if (node->parent != NULL) {
-					node->parent->cl_head = NULL;
-				}
-				cil_tree_node_destroy(&node);
-			} else {
-				next = node->next;
-				cil_tree_node_destroy(&node);
-			}
-		}
-		node = next;
+	curr = node->cl_head;
+	while (curr) {
+		next = curr->next;
+		cil_tree_children_destroy(curr);
+		cil_tree_node_destroy(&curr);
+		curr = next;
 	}
+	node->cl_head = NULL;
+	node->cl_tail = NULL;
 }
 
 void cil_tree_node_init(struct cil_tree_node **node)
-- 
2.31.1

