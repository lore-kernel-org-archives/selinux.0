Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F59C4320A
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1DD60EE0
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhHPT6f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhHPT6c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 15:58:32 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E55FC0613CF
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:57:59 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 14so20422725qkc.4
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjBl9mguH+i1u3Ey1Gjg/Kzz47+b97m7foNy6YKoWBA=;
        b=Xyi/x2nQuXIybBkmgPELz2+nAGVWey2k06biGuigLsVzSAGe7iTpZn7q/3xSy81uLe
         6oFpS00EHC5f5OFXq/3jEwX0QjQE5Frk2xyBtkRPdhxwXgbuv4o/8VssX0IPztph1x5N
         fIydaLHctoerJiu1ZzyKeLve96fzFbG7FQZyL1sVOIcz0o6XkO3P+1v+NKR/WEzXW0h2
         EKjbkpisSAHKY6eVU5M340lga0Y/cq7vQpT5eGXLKkxN08TKV7AdfcQU/da8MIgN8B71
         3vytu/e2p9OYAsvxbkJGRWRRQ8oElNaMqElqxLI+87QIjQCDCsu3MZJJmL4vnc9AR0KQ
         v/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjBl9mguH+i1u3Ey1Gjg/Kzz47+b97m7foNy6YKoWBA=;
        b=HK21lg+dCzG+YJrfB/RpC6vtTceJTwfaDTt+Rj8E5VSruXlRCHax0OGd4F7pYQERre
         p471lMpvJCcT/4YCT/+XqNg0p0QJEu6CZhYaRnF+I0A1lFn9avNoAOEsDi7M2jNP8KlR
         8c7IvpHzbO47wuU3TA1CJmwvCttCzC2aN5CE5NyZUXHN+ug7ZD6fplINn/bHIzhVx+zd
         ycMCp0p2t7cOg6LibitGAoHjJIYktFaiAiw+3n5p/4qw57YFs/9uEhpYQE1rgTHgszqK
         027ER07fUAO3ZwsZl1sZU1cL10WdvC5aYWwAgL5c2B7x8t8UY4MV6qCn2ghPGrSDxWoW
         Vw6Q==
X-Gm-Message-State: AOAM532DN0jduyHV0jUsPugQrCA6DunhEclaBzM1MKDtE5PPavhIzlJt
        ylhXE3rMVgM+J73YEu0jTXZnLBxVsS2pbw==
X-Google-Smtp-Source: ABdhPJz7AssQNM3WsS8ipMGsxYTdiZxxQm0cl9GLXbz6h5HEufpJs37TCQp6Ius6QoxaKr9FwffyVg==
X-Received: by 2002:ae9:c015:: with SMTP id u21mr1566qkk.205.1629143878640;
        Mon, 16 Aug 2021 12:57:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f11sm135147qtf.45.2021.08.16.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:57:58 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/7 v2] libsepol/cil: Check the token type after getting the next token
Date:   Mon, 16 Aug 2021 15:57:47 -0400
Message-Id: <20210816195752.923028-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816195752.923028-1-jwcart2@gmail.com>
References: <20210816195752.923028-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In add_hll_linemark(), cil_lexer_next() is called and the token
type is not checked after the call for the expected type (SYMBOL).

Check that the token type is SYMBOL after calling cil_lexer_next().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_parser.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index fb95f401..fc90caec 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -111,6 +111,10 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 	unsigned long val;
 
 	cil_lexer_next(&tok);
+	if (tok.type != SYMBOL) {
+		cil_log(CIL_ERR, "Invalid line mark syntax\n");
+		goto exit;
+	}
 	hll_type = cil_strpool_add(tok.value);
 	if (hll_type == CIL_KEY_HLL_LME) {
 		if (cil_stack_is_empty(stack)) {
-- 
2.31.1

