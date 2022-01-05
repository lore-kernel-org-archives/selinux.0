Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F009EC4332F
	for <selinux@archiver.kernel.org>; Wed,  5 Jan 2022 21:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbiAEVQR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244377AbiAEVQP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Jan 2022 16:16:15 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BC7C061201
        for <selinux@vger.kernel.org>; Wed,  5 Jan 2022 13:16:15 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 131so744367qkk.2
        for <selinux@vger.kernel.org>; Wed, 05 Jan 2022 13:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76MauF8kdtXPkR+xoMbR8/fIK4qjtBHmkxy7ooSHQ50=;
        b=elplV5j+EBX+EKWQhLTALO/efZEAif7icdR+t9VXcpxGUJ9M46BR5p0OKKJ0td2pTJ
         RDSruo4hMn1bRHj+zhUsqeYwLl9jQvQNhMOmR7IHuosOCO9r+2oz8/KXS+b3r9VrnbUq
         0yLeAiKWiYGczzU92SearoHHO8C/LNR1sOZefRxhmX1JeMlLAoq32URKiUNQ5l/eb1t4
         wfwntA6ndOVCENKz0S5DUA0Z/aje8rXS1KjJoYy6YYpQiGhk4x1qPpyhbrRZPWKUNamF
         vZZfj3HijpU4ZY0wr2vENMezabZoRer8ZvZ88vU6LeZGKzNMaD2BsnK5QGnsDqPEXdqe
         yQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76MauF8kdtXPkR+xoMbR8/fIK4qjtBHmkxy7ooSHQ50=;
        b=isH0mO8KjP1QvUibk6u5frV+dpB8z3U7NuKoSyAuHR3sTzIs6Rlb+3QXhAYHfCD7ZD
         RS5SLMjzyfbq3i6sOvuBz3N8UWq9e2BsflBncY0zU8hIcz75k0pyBKuVy58h6yE0X4TY
         L5moAkLOF8TfhVS2smpQvvGBziUvzUX91Q0QelIL43szh+zzkayz6WhP2pn2QVLc0Zvs
         oYwbJ1u06PF6zpK1EEyJ15tYhzpY/1IE9eqkMeZYIkNs9K7ec4Xa8Q4wNdNNzJ2I71y4
         L0RjflZInd5ZFaceVml9DIOKJ8DwxMWYngCI1MsSOIBMKO4IHxhoJYMzyOghvT77UEez
         28Fg==
X-Gm-Message-State: AOAM530OKmuzW0pWUT4ZjaDu4hS58/A8cLJsCEwRrZgWAvunXh6V7opQ
        JLKJbgpP+Q9gyD2OcQVBlW464aHMy6U=
X-Google-Smtp-Source: ABdhPJy7LYFva8eEX0MxPOcYRR6rSpuzJCJRFeq0mSD7yGgHZDBb7zX+vUt6xM55Tw2SiqLhQFhleQ==
X-Received: by 2002:a05:620a:4111:: with SMTP id j17mr39556996qko.593.1641417373198;
        Wed, 05 Jan 2022 13:16:13 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id m1sm36148502qkn.115.2022.01.05.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 13:16:12 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol/cil: Do not copy blockabstracts when inheriting a block
Date:   Wed,  5 Jan 2022 16:16:00 -0500
Message-Id: <20220105211602.359300-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not copy any blockabstract statements when copying a block to
resolve a blockinherit statement. Inheriting a block from what was
just inherited does not work, so there is no reason to create an
abstract block.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_copy_ast.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 2fad972c..a4ead9db 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -1725,6 +1725,12 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished, void
 		copy_func = &cil_copy_block;
 		break;
 	case CIL_BLOCKABSTRACT:
+		if (args->orig_dest->flavor == CIL_BLOCKINHERIT) {
+			/* When inheriting a block, don't copy any blockabstract
+			 * statements. Inheriting a block from a block that was
+			 * just inherited never worked. */
+			return SEPOL_OK;
+		}
 		copy_func = &cil_copy_blockabstract;
 		break;
 	case CIL_BLOCKINHERIT:
-- 
2.31.1

