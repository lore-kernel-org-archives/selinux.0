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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC9C388F9
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F10223BF
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg9f/nR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKPWHU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgKPWHU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Nov 2020 17:07:20 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FAFC0613CF
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:20 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y197so18585564qkb.7
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVG58xhZnDvxvzqoUlfgNm/LHRJP3qzWbhK1/tZSAkM=;
        b=Eg9f/nR18lURQcl7ml/NNikqClLZzZW1vp3AhqodW8y27i65uPBHHYgDL01gHjn8zi
         ZBSE/wkZhilWYPr0qaL0Bittt/RKw2pM2apw+WAPG4zDHZQiZAd1aCZOesP7Qvp5w17j
         umYowiX/Dg54PZZ5/+92DlSlRbSyVrG1IkMkoaWebVweZp1n33Zl2F0PWwhV2HKnbF+j
         Ir7nhoYVP5X8e5eXG0cWm4a4275R7ttMqz4JovKvSWtB+rpHf+NV1D1xkGJg2TYq92Vg
         34cZ96jiJHeUKHgOjk+EFVwPd2i/Bd5EUzUZGvEfGpPYPo9FWFm2t1VbLyKfzGhQIhqD
         IfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVG58xhZnDvxvzqoUlfgNm/LHRJP3qzWbhK1/tZSAkM=;
        b=cgI9P8hobVfOJBVyrUre1PcLahyHt8m5Qk84hI2BqW2MyqaTgrVA2BMUoLekHulUD8
         PrOvW5g9Y4k3VukYd649f+UVKDsnPxzu2W0fVtOTA6Mh/QqtsfdmwJSFZ/TXrIybi2id
         Ie4yJiXrNXjX+RXYJ1Nk5iPcCAhXlTQaWyVTv1SZW662iHQzHMPuPRwHyPelCrXLKH3X
         TWeNg4LLa6PnG9DClReJQBi+vsqWyR2bQM71Mr4xVikNEeD8jsRzm7zMPFCbEajn7PCV
         xneBEJ0Q4QpvrV2Px3+wKU1U1QwAM/hHmw5fFaLPRG4OCoLnZi9rWoV1zz0wASEi58Fl
         qL1w==
X-Gm-Message-State: AOAM530FmE0J4f0LLWw368y1NLMbkzc9Yz8SNqmmEuxasqJZvkAplS5h
        8iI55+5yo5ZdMrvYpYXXWmZJsy3tJo8=
X-Google-Smtp-Source: ABdhPJycs5bRtTaqVktfCX83qFaMYAC+CdncKGmR8ZfVhhAh+ySl7QposGvwpKav5e2IGfas+/IEMA==
X-Received: by 2002:a37:634a:: with SMTP id x71mr4348463qkb.51.1605564439635;
        Mon, 16 Nov 2020 14:07:19 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm12653330qtp.47.2020.11.16.14.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:07:19 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/6] libsepol/cil: Remove unnecessary assignment in cil_resolve_name_keep_aliases()
Date:   Mon, 16 Nov 2020 17:07:00 -0500
Message-Id: <20201116220702.174765-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201116220702.174765-1-jwcart2@gmail.com>
References: <20201116220702.174765-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Block, macro, and optional names are all in stored in a block symtab. A
declarations fully-qualified name includes all of the block names from
the root node to the declaration separated by dots. Macro and optional
names are only used when trying to determine the block referred to by
an "in" block. An optional block name might be stored in a macro's
symtab, but optional blocks have no symtab and (*datum)->symtab just
refers to the symtab of the datum which would be the current symtab.

Since the assignment is not needed, remove it so the code is clearer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 410b8c87..9e6afca9 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4209,9 +4209,6 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
 				if (node->flavor == CIL_MACRO) {
 					struct cil_macro *macro = node->data;
 					symtab = &macro->symtab[sym_index];
-				} else {
-					/* optional */
-					symtab = (*datum)->symtab;
 				}
 			}
 			current = next;
-- 
2.25.4

