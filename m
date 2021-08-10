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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BEBC43214
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7E660231
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbhHJSWJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbhHJSWB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 14:22:01 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA12C07AF5B
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:45 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id e14so23393462qkg.3
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjBl9mguH+i1u3Ey1Gjg/Kzz47+b97m7foNy6YKoWBA=;
        b=dC1F/nPVq/sBMhuaV343dxlFhzvLyiTVZKCH1sBF7J+2MfhW+HYN5wCLdUkxTd5Psu
         GJYjUuc7yc5NVo08eUoj0XWA4YQWuMGhMgEvqt3k4hYavmICDZpya1h45YkScK2ql3o2
         xRL9HaDw5P7wohuVZUy64ksLdLHpu+qVWD0QKjCqNx1HKB2/nsE/rcYL8UtEy0ImXU8u
         MNUUae2JmEfp5MzZ/NFPyZSGcLZul3OpJvBUyUP54xRPKXkATOhyqpkfQgdVkpz0dYDE
         uobQ4/SjeocZ6vPL1qcsUPT9jzql3jg7v1/IpEKxA5LPDT81TuHaUArXYF9yP95EVic1
         oQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjBl9mguH+i1u3Ey1Gjg/Kzz47+b97m7foNy6YKoWBA=;
        b=PozqdIjSEl8mA+mQIIb85kMbryI/5p/I5heNYUeOTf4qLxIhpvgb9xliIph/q7KL+A
         o50BmbChblJCe0dfMEFYwegcU+FZR5nN/eXuIE3bBIro2QOWSFgY7vCgEUnjc4WE1c87
         NYMdS07nAIH5wGz0FmkyQ53gEmXLZ+qp5VdItYBYV2dD3YF1mnDyHuyx41FjzRp0YCBC
         tnSMqbLeskzO6rlAbCbI//Sa36XRIIe5AMeOqf1aWw7nsRDa5l2c+HEQwJdue5XY9peD
         tXLkNPN2GmtynJzocp8Ap2/2X+KRouP7P3Hy9Jl77NsWYM7NFzwtvL+QMhAXTgW/FJ+u
         nlnA==
X-Gm-Message-State: AOAM530rWY4/eT/KswgCCMk8bvfX9p3+NbMnfMzw9t/E4gdkQTdeq0ip
        ai8GeSX6AoQcK8TWjqlVHJGWjzzy+AMKdA==
X-Google-Smtp-Source: ABdhPJybFMdfMyvswinGXkwjgx5f771wqYJZ1T9JMgv87dPJU3Hf3/4CD1WnPAxGrkAh2yujcuuDyQ==
X-Received: by 2002:a05:620a:12f6:: with SMTP id f22mr10247215qkl.159.1628618744215;
        Tue, 10 Aug 2021 11:05:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m16sm3057415qki.19.2021.08.10.11.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:05:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/8] libsepol/cil: Check the token type after getting the next token
Date:   Tue, 10 Aug 2021 14:05:31 -0400
Message-Id: <20210810180537.669439-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810180537.669439-1-jwcart2@gmail.com>
References: <20210810180537.669439-1-jwcart2@gmail.com>
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

