Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC99C63697
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44974223BF
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbN67Se3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgKPWHT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgKPWHS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Nov 2020 17:07:18 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A8DC0613CF
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:18 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id m65so14222268qte.11
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKWeqO/Fddpm7TbpKRoOvm2BUHb0yMtMdIL9FDKnGHE=;
        b=vbN67Se3IHjw7ppce+9Saj03qXpkTnXTJXtwrb2ovOjWIeWbJm2qghqEFEmZhbEkPD
         84qQ2vS100wd1hPDedn+HuBgWifgzgkjiudl2LqznVRtXVdzmvFgisP/E7RvZotXdh71
         ZNs7yZgZ4M6LNZBjOsEI9FghccWVTue3t+IjYWzLIqfu6jBT2Kd2xokMLj9BhO73sZSm
         XmAuwkt/s3xJRPtoL4QgNJAs0L4WgkjVpoQd1L6Zw4FZKrFvCE+m0Kb2ygP7X/vGDy+7
         +/wDyGIgoPvZejEUf96+ME+SVl/l2RMAA8ppymZkiB8Yyt1pVXqZ400tuG0OZY036k4n
         1XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKWeqO/Fddpm7TbpKRoOvm2BUHb0yMtMdIL9FDKnGHE=;
        b=PKGA4mGAZr52qOIaqKGEg4SG9u+toxz7M5EXWbW1efrWVrsJxMl99VRDm9uVmA9Eua
         IcOMJXEtqi3ghjBrDPBoRSFQjux/alRY0eo24hdxbooVm5ddqiMrTkeX+6jRkWzGngkw
         gtRENfz+11gZSEdTxFQXCufhCm0Ix9aSCkC5P4DyAwqmfWYtJfH9gq37ic7fQdXrB3wq
         Qx6qVI01jwg4gy/QCyUe22lPpktXu7IQYg/Rhzt6pr4PXbaeObCAQEGowgwfzCjHcQnR
         jtJMxi5LBmeaWrroGLWuw72chyAuCKFmUibL3Du0xAU7UwCOIKbxnQEvuqN/5jf0HifK
         xpHA==
X-Gm-Message-State: AOAM532UJW6NKEZi1fCJf5Dzn9gTt2Gz39GO+kXqeH8+x4Gyfj4dBeW/
        g9hM7OIbdhNMAn6UUKFuTjkgmwHOkkQ=
X-Google-Smtp-Source: ABdhPJzmPMi18l2NcdlviX0EuWZepH2soraHbo1QPqMaUrfEsUG85hdW+0Pru5gmuncajgOOQ3hasg==
X-Received: by 2002:a05:622a:18d:: with SMTP id s13mr16112870qtw.151.1605564437717;
        Mon, 16 Nov 2020 14:07:17 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm12653330qtp.47.2020.11.16.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:07:17 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/6] libsepol/cil: Remove unused field from struct cil_args_resolve
Date:   Mon, 16 Nov 2020 17:06:59 -0500
Message-Id: <20201116220702.174765-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201116220702.174765-1-jwcart2@gmail.com>
References: <20201116220702.174765-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When resolving names, the struct cil_args_resolve is passed to the
various resolve functions. The field last_resolved_name is not used.

Remove the last_resolved_name field from struct cil_args_resolve.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index daf873be..410b8c87 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -51,7 +51,6 @@ struct cil_args_resolve {
 	struct cil_db *db;
 	enum cil_pass pass;
 	uint32_t *changed;
-	char *last_resolved_name;
 	struct cil_tree_node *optstack;
 	struct cil_tree_node *boolif;
 	struct cil_tree_node *macro;
@@ -3905,7 +3904,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.db = db;
 	extra_args.pass = pass;
 	extra_args.changed = &changed;
-	extra_args.last_resolved_name = NULL;
 	extra_args.optstack = NULL;
 	extra_args.boolif= NULL;
 	extra_args.macro = NULL;
@@ -4234,7 +4232,5 @@ exit:
 		*datum = NULL;
 	}
 
-	args->last_resolved_name = name;
-
 	return rc;
 }
-- 
2.25.4

