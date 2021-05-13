Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCAEC433ED
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72854610F8
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhEMSzg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 14:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhEMSzg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 14:55:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758EC061574
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y12so20508562qtx.11
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1l8q26/dWl4LYOjBwzHjpDidOuMWD5Rj5ss0EqDUgvw=;
        b=EF7JW4uzaBuH5j4ADjapfh4UHhapnKXIl2WNKsuqyIVb12qDTqZCHBqaybYsPGqDUA
         BdMQl1IM+EanztjUrpimvEZKOH8WJEKANg3NdBTst5Gp2O+CL8iiFHlTJlrq17FQwrtd
         p+/WZdh86YPXlGxpOrR+TLnClN8n6vW5Sofh0f3oCELecrlj5q7g+T8bd/ayJVGc9Z/E
         PRIoIaPqS51AXsLfa6xetsOjnaUqyznpQQnk1JJi53nonAC2ZfD0yNYRtxyUkZL3jJdE
         5F3qFUZ/EquNhj46ExGI0VMxgWccLtciJR/1Br9TdQUgMi3yep5M5n/WaYpjktZ7fHAa
         aZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1l8q26/dWl4LYOjBwzHjpDidOuMWD5Rj5ss0EqDUgvw=;
        b=SRzGKISFPHby/Uf049cJQkD5GzRE8E6gsdxh9s9UA2VnERPBiLTlEfdFpNyab4//h3
         NlgD77jAMi1tzBPwnkfLGgKn8gKMq28rFS17P3XKI0cp04W5uPofye3VoJtaLPbufKed
         2qBU/tYPfLMivBtRUTSHKfPD4CCCzwlENOkLyTp4XyalWAT8Mlg9HGaDfgqopkbnFu2k
         3tP4IAlovlXtA72mMcF6W47hCswrocPQCYhG1avd5StBPQCnBenKs6DGMK/TkU0QxVzr
         fK3n5Xj4hVWN6F3QSwQx1KiC+GGZT+5WGSwjeoHXhU1AwcAtEdWqHcwMjJT/HyDzlsG3
         RPsQ==
X-Gm-Message-State: AOAM533L/gcnglw6/zuLQUknHcK16008TyPtrEWizDR6D5YhbXn3uWzo
        zfnlpHWJ+by8ut/58FW3VwLkXZB5Na0Q3Q==
X-Google-Smtp-Source: ABdhPJyW4DNAK6zOnHaSmCQG4OIgYVq5aqOTXB2q2RQHXjXU7aEtDqresgTvfcZvJEooMQw3W+XFAg==
X-Received: by 2002:ac8:4e21:: with SMTP id d1mr38883290qtw.290.1620932065859;
        Thu, 13 May 2021 11:54:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h188sm1713767qkf.133.2021.05.13.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:54:04 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/6] libsepol/cil: Destroy the permission nodes when exiting with an error
Date:   Thu, 13 May 2021 14:52:50 -0400
Message-Id: <20210513185254.559588-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513185254.559588-1-jwcart2@gmail.com>
References: <20210513185254.559588-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When exiting with an error because a class or common has too many
permissions, destroy the permission nodes.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 87043a8f..71f14e20 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -444,6 +444,7 @@ int cil_gen_class(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		}
 		if (class->num_perms > CIL_PERMS_PER_CLASS) {
 			cil_tree_log(parse_current, CIL_ERR, "Too many permissions in class '%s'", class->datum.name);
+			cil_tree_children_destroy(ast_node);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -1019,6 +1020,7 @@ int cil_gen_common(struct cil_db *db, struct cil_tree_node *parse_current, struc
 	}
 	if (common->num_perms > CIL_PERMS_PER_CLASS) {
 		cil_tree_log(parse_current, CIL_ERR, "Too many permissions in common '%s'", common->datum.name);
+		cil_tree_children_destroy(ast_node);
 		rc = SEPOL_ERR;
 		goto exit;
 	}
-- 
2.26.3

