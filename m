Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61265C4167B
	for <selinux@archiver.kernel.org>; Thu, 15 Dec 2022 21:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiLOVeo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLOVem (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Dec 2022 16:34:42 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D61C437
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:40 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id b189so496013vsc.10
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyJf3sFuQ17+ebZFqnz1KFM7FAV4Fmy9itraTxE+MMU=;
        b=k3OlyEfz9MYPW77dCHDEEwWGd4LS9IdNaCeD/wKemRaB9v7tZMXT81DFLgTLAA6zHN
         d5PDqSuYnOBNhJdojaNSry/wb4o3SQpGwAFTD8Ol4fVBXazX+v3Zw+WYD+g0MuNV7URf
         FchDlC5dp2nA5mDaWNfpq0XITUqBSvi7dyHPEZA016IPQhYo3894wOPAPclh8C1ifyhc
         VdowUJDi0O7oWC/52FQR/ZiDZva6Vef46vAFMqWMZ8qYY1CG1WkT0fcC8e0YH0Jw4kDB
         Gb6k2ChILkxsDy9QC5oJQfoT6nqeFBo5FafJmPpWG/bvyk0fhJFPjLWuGcXwVCV9kdMT
         1WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyJf3sFuQ17+ebZFqnz1KFM7FAV4Fmy9itraTxE+MMU=;
        b=KE/e26yxxm14ihxYEpIyeC0VoS9Sf3x+wb+wShxpNl3vvvCLtz70DK0OsKiztBp7Vj
         +f6Zz2BEHXMJ4okR1iA+tAXNSwruYxTqC+LBEF/iTpeOjza9qRX3tAaUWpnEfQsf8ERM
         XD/x/wrDPF2LerBbs7LVbeBSlDA7GlioWpIqpxOBffWynnvcErdmy/rgiO73yJWjn/QY
         UTMM+cTxOP/pzWcy0uK2L/5dEGSBvgrFGMA1+ocoZZIN9VvIB0quiGwwWjbxNW7FEVi0
         VdmpLMXLm+lOKPChLxs9ULeM9i9xL5jqm1OaiCfm1HbydpCzDvAfaEe+BQWYQRNgLt+o
         gHYg==
X-Gm-Message-State: ANoB5plBwcymXPrbCVh+Z478EduYFke+TV6SNy4yMDFTWTKNVsEEgNOR
        vb/CdIy/oyCPHD7wvD8Qed5Mc4v7FD4=
X-Google-Smtp-Source: AA0mqf7ANWKF6BwVNQykuz9NOF4yCvR7P6UpNIhAotIi/FIwOrtQG8ZQ+igABDc/oWBtgq+bT8zHqA==
X-Received: by 2002:a05:6102:7a5:b0:3b1:4b76:5b45 with SMTP id x5-20020a05610207a500b003b14b765b45mr17626716vsg.33.1671140079410;
        Thu, 15 Dec 2022 13:34:39 -0800 (PST)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b006a6ebde4799sm21066qko.90.2022.12.15.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:34:38 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 3/9] libsepol/cil: Add cil_tree_remove_node function
Date:   Thu, 15 Dec 2022 16:34:23 -0500
Message-Id: <20221215213429.998948-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215213429.998948-1-jwcart2@gmail.com>
References: <20221215213429.998948-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the function cil_tree_remove_node() which takes a node pointer
as an input, finds the parent, walks the list of nodes to the node
prior to the given node, and then updates that nodes next pointer
to remove the given node from the tree.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_tree.c | 27 +++++++++++++++++++++++++++
 libsepol/cil/src/cil_tree.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 6376c208..73b4e135 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -248,6 +248,33 @@ void cil_tree_node_destroy(struct cil_tree_node **node)
 	*node = NULL;
 }
 
+void cil_tree_remove_node(struct cil_tree_node *node)
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
+}
+
 /* Perform depth-first walk of the tree
    Parameters:
    start_node:          root node to start walking from
diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
index 5a98da55..e4b3fd04 100644
--- a/libsepol/cil/src/cil_tree.h
+++ b/libsepol/cil/src/cil_tree.h
@@ -63,6 +63,7 @@ void cil_tree_children_destroy(struct cil_tree_node *node);
 
 void cil_tree_node_init(struct cil_tree_node **node);
 void cil_tree_node_destroy(struct cil_tree_node **node);
+void cil_tree_remove_node(struct cil_tree_node *node);
 
 //finished values
 #define CIL_TREE_SKIP_NOTHING	0
-- 
2.38.1

