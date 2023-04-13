Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62484C77B77
	for <selinux@archiver.kernel.org>; Thu, 13 Apr 2023 19:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDMTey (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Apr 2023 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDMTex (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Apr 2023 15:34:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A55959F9
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54fbee98814so54341847b3.8
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681414491; x=1684006491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYDTjUIqkhx42mRkYhUi7ptoBdjbJO9ujfNEp70J9m0=;
        b=CoZFvOGWdHVfm3albhzX6MTzr41oVSrJr6kI3wflpceXmrU0iLI+1Ga5gD2wi5mnk1
         +5vV//Tv1BzryS+7XIRijYkVbz9fGT/UdVKjjWMRfQ++s0wIcfq/prb3HR7aiRLKqCCo
         m4WQTAcNoi4p31tgjftUxafl6cwlk7lPLIK3OnTbeTh+axzDEoAgvkGNgSBQtZp4dOzi
         TaSQgUZi4pk/JQvqqwhQTGU91y/+irmi3TXUDcUr55c0qCDnSV/gNn9sBnWZPAc+5A7q
         wDlsgI9axrM7WKeK7d/kMExiYMrzo1TtX8RvYR9GI5LY1ktek5FG9C8TCxEMg3vUBJbT
         wZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414491; x=1684006491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYDTjUIqkhx42mRkYhUi7ptoBdjbJO9ujfNEp70J9m0=;
        b=EkYlMnOEly063YScJkv1tIUCz6PHkA6CebPbTJGTBl7tDeV2YD6SmXVYazW7AGlEqf
         Wdetkj8Acn2HtdgyPr+yKbOqmUgbcvmSXHmMLsiMDs4EJZJADfO7UbmwuIlmVnNRfD/W
         sQO6fBI7FceDscEHeMK8+BiHgz02b/QTQt8MXqAQwz1moRrLcYL8D2cFA0g7us2jigGG
         uRcQz+JreaD2yx8aDTW39R9zLGSBF8w26LL000P66pJGG6cFTaSvkncTEOw9UbaOGInd
         BUtmccvUPqLgtvXkwqfYMdnAvoXHTlkH7Bhbt1St69iowrp1Qfedzw07g3ZLgr1Hlx+k
         qWvw==
X-Gm-Message-State: AAQBX9fZ6l3t1b9SNKmflcvT7v4660ndGpL76hFiw5+VVOMt93THZeGh
        VbCpz91RzdqAkHCXrinf8P5WXrWqQvg=
X-Google-Smtp-Source: AKy350Y/exqmqo2ftrxY2nSi6UzbqipJUYlfxraVvLx6DlRa3bTmz5Cn4yQxVo8FsHrULSR+6q+/wg==
X-Received: by 2002:a0d:db4a:0:b0:53c:de05:2237 with SMTP id d71-20020a0ddb4a000000b0053cde052237mr2977971ywe.38.1681414491008;
        Thu, 13 Apr 2023 12:34:51 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id 21-20020a811615000000b0054c0f46b24bsm691350yww.5.2023.04.13.12.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:34:50 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/9 v3] libsepol/cil: Add cil_tree_node_remove function
Date:   Thu, 13 Apr 2023 15:34:39 -0400
Message-Id: <20230413193445.588395-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413193445.588395-1-jwcart2@gmail.com>
References: <20230413193445.588395-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the function cil_tree_node_remove() which takes a node pointer
as an input, finds the parent, walks the list of nodes to the node
prior to the given node, updates that node's next pointer to remove
the given node from the tree, and then destroys the node.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v3:
 - Check for cl_tail pointing to the node
 - Destroy the node before returning if cl_head points to the node

 libsepol/cil/src/cil_tree.c | 35 +++++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_tree.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 6376c208..1155e311 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -248,6 +248,41 @@ void cil_tree_node_destroy(struct cil_tree_node **node)
 	*node = NULL;
 }
 
+void cil_tree_node_remove(struct cil_tree_node *node)
+{
+	struct cil_tree_node *parent, *curr;
+
+	if (node == NULL || node->parent == NULL) {
+		return;
+	}
+
+	parent = node->parent;
+
+	if (parent->cl_head == node) {
+		if (parent->cl_tail == node) {
+			parent->cl_tail = NULL;
+		}
+		parent->cl_head = node->next;
+		cil_tree_node_destroy(&node);
+		return;
+	}
+
+	curr = parent->cl_head;
+	while (curr && curr->next != node) {
+		curr = curr->next;
+	}
+
+	if (curr == NULL) {
+		return;
+	}
+
+	if (parent->cl_tail == node) {
+		parent->cl_tail = curr;
+	}
+	curr->next = node->next;
+	cil_tree_node_destroy(&node);
+}
+
 /* Perform depth-first walk of the tree
    Parameters:
    start_node:          root node to start walking from
diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
index 5a98da55..cb6a0d24 100644
--- a/libsepol/cil/src/cil_tree.h
+++ b/libsepol/cil/src/cil_tree.h
@@ -63,6 +63,7 @@ void cil_tree_children_destroy(struct cil_tree_node *node);
 
 void cil_tree_node_init(struct cil_tree_node **node);
 void cil_tree_node_destroy(struct cil_tree_node **node);
+void cil_tree_node_remove(struct cil_tree_node *node);
 
 //finished values
 #define CIL_TREE_SKIP_NOTHING	0
-- 
2.39.2

