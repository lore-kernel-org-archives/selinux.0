Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2758C001B0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 21:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjHIVCG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHIVCF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 17:02:05 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC291724
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 14:02:05 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7679ea01e16so18638085a.2
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 14:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691614924; x=1692219724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVncr5g/siRUrfpZ4P6nPs2B7IIWHm/Vv/BX0GXt/w0=;
        b=XxXzN1kUULiCi9LZUg9WcLVqbRhIk4pDbCgMcltTwcOCS6AziwDmX6dNvaYchWXaUC
         OgrpyWADkdDNrguAQREpjrLgUBCqpdmUOO7eyXXoETJH7eg9iSFmV+h60vvFngEGl3Gu
         tmgeejnOIoEEsMtrMnw4C1Uydb9MYp8FmQWJfUSBpNz6tWJ2hUyjZmT6Mo3Jikbo1W5o
         3xQRb16W6m5a3yvzYX0PMxgCAYMUmiXeuh5NhhnpID3JNG4SISM3TvvZ727dsOjHdPpe
         +r00muatdfWpLBqoLUplkSKALr6Eg035hgADvZUFsBqV0CSDVnZ9vajIIR+iSn3V2AiX
         S1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614924; x=1692219724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVncr5g/siRUrfpZ4P6nPs2B7IIWHm/Vv/BX0GXt/w0=;
        b=Ac+gS85guMiNxHBD+uEFcTn9SA6D21eL7IoJTT7MuZjEXMOlc5qkNHyMYB3wcOj5tF
         nnyUi+2gZoLClMD2R3vzsx/46VSEDMoXTzrmRLYfiAvKWbkLH/a4/9KmLF9r+VwiF9fn
         NqdeJwyueIk3oFx5sF/qgG1I6+/FXt0Aad0B7t68jKNIXk8IJov4PKx4G8dZ3Cke1GNz
         f+H/N4UDcksp6snYfLlb9VGqJIEcBSm45xhvTCMklGlb4pejGamN4OMXEgHUczT1FlCe
         W0w9wcHSuTamHh5uchpULy+0bx0nY6plG3ZGaVuocpWqvIsaAOOO71wUiBLw2wXxn6kg
         g3ig==
X-Gm-Message-State: AOJu0Yxe7rD6sgvZvskiXirJniw/5KuH1m1DdpOTNLDI3Q8bNszhNkzX
        QpIRebK3PfkL79dwMw0wF7F/zB+9GnQ=
X-Google-Smtp-Source: AGHT+IGTiSnsQy38daLZOxhzuU12rG5eSD0F2ItYWFCr/WTiPFEzUyPU5oQYkHm6DwqnRoAhHG7yfA==
X-Received: by 2002:a05:620a:459e:b0:767:2471:c880 with SMTP id bp30-20020a05620a459e00b007672471c880mr194584qkb.28.1691614923987;
        Wed, 09 Aug 2023 14:02:03 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm4208287qkk.132.2023.08.09.14.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:02:03 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/9 v4] libsepol/cil: Add cil_tree_node_remove function
Date:   Wed,  9 Aug 2023 17:01:51 -0400
Message-ID: <20230809210157.112275-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809210157.112275-1-jwcart2@gmail.com>
References: <20230809210157.112275-1-jwcart2@gmail.com>
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
2.41.0

