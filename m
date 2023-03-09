Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2A8C6FD19
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCIVva (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCIVvW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:51:22 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9649DFAFBF
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:51:21 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id f1so2407366qvx.13
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hl7wZEpn0uzrEpQ2vQvclnkzlHeeWcJsnC2L7TGv/k=;
        b=LjBmvE2GIt9Ht6OHownvAa+hfsCzJD/p+Ho605IW8hak1dDGBYPIsIgD+3C2h40FyG
         TuYpR0NNStLVYgK9WRHgNNDheqYoklSKUaJbd4oyHveZuTQgyg1UfmGy0gSv5Y4pss6Y
         iO25K3vve8DRMO+gCathY3hl23iB4Qdj8ON8V/3K86W1uyY7mUM1Nb8u6fNgbi/Qv5P/
         UhoItwI1D2qJxqoLbcp5i9v/wst8PugEnA7klWOqLImHq2Tc9FDiwr9vPV5Z2c9VWMG7
         B0rTYivDZ3jPUO0B+lsAdJ4yjnZZ+YxTIlrY8ABtfIXwM2FOUoF6XBpeIJ0IK3KOFewX
         EI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Hl7wZEpn0uzrEpQ2vQvclnkzlHeeWcJsnC2L7TGv/k=;
        b=cgY1fsAmKAheQa+bNQ5PPmE12hDDlt5DvTqSBBOtN1YsCapGH81pM5I3xXktK8Lxy8
         ri3Zf4d2MRQnHBVvJQd5l8bVd8BjZG29vdswn0BE8neDFybyuRDvDdk67BPShLjbjbIN
         W683Lhf87idwQ7jgAneLnl5XDiR5/TLarN9LxwJQXS/w3vxmN/pufvvM1cp+zupRXxzj
         AqbRDbKJaS+aK7pDsMqTkyI1E7XCPVBFs7YLxhklyIySTGYJb/bn1xG8f58CGLzAQgXF
         LtNCfVfJ8olQVJspiLSsRAeX3edQQnAPpH9sVxOm7vjxWUYiECcFd0cNI9oWFdEGeFpf
         excw==
X-Gm-Message-State: AO0yUKUbt7zykTham784/lXF0r3/bwpCbITRF5xoazPObkCrhRk50ZU3
        3yRQSF8C1soSXqgu05k8sNV/bGb2nzM=
X-Google-Smtp-Source: AK7set8B9bD1iMvhpYAca37QMkU8qKrfuFS4akfzOcaGuzS5xlhck5d0TFUBOZq/L6JIt6/D0SD8Iw==
X-Received: by 2002:a05:6214:c46:b0:56e:b273:fb3c with SMTP id r6-20020a0562140c4600b0056eb273fb3cmr36696579qvj.47.1678398680272;
        Thu, 09 Mar 2023 13:51:20 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007422fa6376bsm25731qkk.77.2023.03.09.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:19 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 3/9 v2] libsepol/cil: Add cil_tree_node_remove function
Date:   Thu,  9 Mar 2023 16:51:08 -0500
Message-Id: <20230309215114.357831-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309215114.357831-1-jwcart2@gmail.com>
References: <20230309215114.357831-1-jwcart2@gmail.com>
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
v2:
Renamed cil_tree_remove_node() as cil_tree_node_remove() to fit the naming
    convention in cil_tree.c
Have cil_tree_node_remove() call cil_tree_node_destroy() to destroy the
    node after it has been removed as suggested by Daniel Burgener.

 libsepol/cil/src/cil_tree.c | 28 ++++++++++++++++++++++++++++
 libsepol/cil/src/cil_tree.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 6376c208..f2703a75 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -248,6 +248,34 @@ void cil_tree_node_destroy(struct cil_tree_node **node)
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
+		parent->cl_head = node->next;
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

