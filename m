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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E830C49EA5
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A18613B1
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhFXUAk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhFXUAj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Jun 2021 16:00:39 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F206C061574
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:58:19 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id x1so12778890qkp.7
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyfhxQYRr1c0ph2GN73qmvPkpuiobsHq1Nmo7cfwfYU=;
        b=nnYbv/GPPA+wiZkF7hrrsB2b4xPDY+rmkJDaVuAw0X0YPrqcxJ+s0frz4R5oZti0Lv
         noWK4M49swX2Y2gUM9BRGe6SHAnK2NRsNEaHdk9jR7Y+Ek3frdvccGKoeOpV6jDHWUfx
         BG3xbeHN5tfnQak6uk0Xhg9iDHqmI4/QGrh685Vm6sCX6b5Ec8ZsUWtUCbwzv2eghwlX
         TQ/OYITo+3FVjgeE5/ykCmd76dfvGFrImC66ev/l3MKLUWXCIW4A6d5BSZFjarMrh7MQ
         NGu/X+6SHmOzBgDNefmcnMO5THXzJtDZamTTGRdKsqegYLpRSPEovWOM3EZkopwH1WbP
         +aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyfhxQYRr1c0ph2GN73qmvPkpuiobsHq1Nmo7cfwfYU=;
        b=TQ5lMDW7hX/o8cy2axhtY4h2k2YX8FSADULNqz2rGfpwf8gF5KgVtod/IHEpzSvPil
         l3Er90Uh7eX6rE9vRFh93hm89CAig1FDK8HC99SqdMNpymsIW3X9/MMdrh7p5jcvtzQb
         rDMQYoePze/dIBug4w5IWsSaUaa7qODyOT0k7ubto4rxQRi7Vn5aztT73V4CRPr6VdY9
         1OAFMaojZ2eHCeoNi/EQhoc7LMg8M9oANh7vS+/GaNjgQ/7Up0Si0HQHxbEYI8pZXSHU
         AcIL65aprUeg/yL95/ZtGgEszR02cnskFRJc4mFlnF9VIJrOxFTTo22nCIVJUmRb5JIK
         X4ig==
X-Gm-Message-State: AOAM531z3YKDwlIIDCtU/ZQTtbJ+2Fe6tX2JR/TxlBVY1L645VgjV4JA
        XpJBFImdQ77zSto+gHSEMMCdFTAGxlNKPQ==
X-Google-Smtp-Source: ABdhPJyJZo2zhxpKBaallFphz/4ZqfyUejOia+6q+2A97OCG6iEMqYfDYlsPh7j+wAilGKvDszyxKQ==
X-Received: by 2002:a05:620a:5ee:: with SMTP id z14mr7398294qkg.83.1624564698282;
        Thu, 24 Jun 2021 12:58:18 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m19sm3257531qka.22.2021.06.24.12.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:58:18 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol/cil: Add function to determine if a subtree has a declaration
Date:   Thu, 24 Jun 2021 15:58:14 -0400
Message-Id: <20210624195815.148698-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create the function cil_tree_subtree_has_decl() that returns CIL_TRUE
if the subtree has a declaration in it and CIL_FALSE otherwise.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_tree.c | 16 ++++++++++++++++
 libsepol/cil/src/cil_tree.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 067268eb..4cf8dcc8 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -136,6 +136,22 @@ __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *n
 	cil_log(lvl,"\n");
 }
 
+int cil_tree_subtree_has_decl(struct cil_tree_node *node)
+{
+	while (node) {
+		if (node->flavor >= CIL_MIN_DECLARATIVE) {
+			return CIL_TRUE;
+		}
+		if (node->cl_head != NULL) {
+			if (cil_tree_subtree_has_decl(node->cl_head))
+				return CIL_TRUE;
+		}
+		node = node->next;
+	}
+
+	return CIL_FALSE;
+}
+
 int cil_tree_init(struct cil_tree **tree)
 {
 	struct cil_tree *new_tree = cil_malloc(sizeof(*new_tree));
diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
index bac9f1e4..f4d22071 100644
--- a/libsepol/cil/src/cil_tree.h
+++ b/libsepol/cil/src/cil_tree.h
@@ -54,6 +54,8 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
 char *cil_tree_get_cil_path(struct cil_tree_node *node);
 __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *node, enum cil_log_level lvl, const char* msg, ...);
 
+int cil_tree_subtree_has_decl(struct cil_tree_node *node);
+
 int cil_tree_init(struct cil_tree **tree);
 void cil_tree_destroy(struct cil_tree **tree);
 void cil_tree_subtree_destroy(struct cil_tree_node *node);
-- 
2.26.3

