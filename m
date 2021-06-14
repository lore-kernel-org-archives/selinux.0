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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BDC48BE6
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 15:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA76128C
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 15:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhFNPI4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:08:56 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:41648 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbhFNPIz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jun 2021 11:08:55 -0400
Received: by mail-qk1-f170.google.com with SMTP id 5so648150qkc.8
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnteHTbE/SOn55CRc7MFSXv/V54p00tAQXnSbbVVqzE=;
        b=hvV/wTev1zBxu6wg72ZKl/wxKgtjFXvQo+jYlN5Aiorxp5B/RaBcft6OAKml3tPZ6y
         7x0EdkPJvv6ULfJIOkAk1ResN5OT7CL+RIEW13QF6IrlGzYvFzVxxlTqr0KUGhwupbfj
         TXf2viYgB+WSt0o560/sRbGwDWoheqCZQdTjODgNE2zI3WBM7GV0s9eX9zSdjOGIP9Fe
         WFEaW6Jps37ljnfl4kQ2Hahv41Ma3Fi9RSshuhnQJ5c4iSE84aDg8mMuJ4Q1oSbRbp//
         jCgEJqDwEg4DY6mitzcqDGtTouVyqdihn8k5NPrF3p6gmpgfi3sDNIGq7q4pDjiVeXqy
         Q3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnteHTbE/SOn55CRc7MFSXv/V54p00tAQXnSbbVVqzE=;
        b=hOzPVLvBs9Ex/4ytSHmhD1lNdwrMc/8wk5pOAsZpKVxUwSA8dBLopd8KyhmR0B2n/p
         dvZEbpdK8vljR3M7bFAFAXOwkxHxS99kX4rKJc1/WnQlsSR1y1lg0Z+V1c4mQGL2v08N
         ROjPqJ2Wv/Gq9OO4RUWf2wyLpPuHjiD6HoJp8mL/v0NffiJa40bc8EJ3eL1YfO48GHKq
         uFQ7KhdnMvNx0+yTmhMtaS0MJ8+5K6donB7YbSzCdBu5FH+VR1r7KL6FlKkJq5F6Nsxa
         oD1sR4VgBruD6Fsyg0fwvoF7890VNjsXtmT8rkAESF8UOzdY9saJcLC8suGkadkeFrLJ
         H47g==
X-Gm-Message-State: AOAM531Fe24uLJHf8JMkITLN7HcwIJc9H5PIHxvGm0ZSgbrfH5M4M1vN
        zIvV90VO8dwHB8kUSvJUE3/KwkKxImOxiQ==
X-Google-Smtp-Source: ABdhPJxPyT03RV6xr8YFYgT4bwSnNjTav8SBevKt5fDxC1hLeeoDoARi4vhlSlCtWxLzoEiJDaYG5Q==
X-Received: by 2002:ae9:eb45:: with SMTP id b66mr16603439qkg.339.1623683152410;
        Mon, 14 Jun 2021 08:05:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id 75sm8221014qkm.57.2021.06.14.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:05:52 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/5] libsepol/cil: Fix syntax checking of defaultrange rule
Date:   Mon, 14 Jun 2021 11:05:43 -0400
Message-Id: <20210614150546.512001-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210614150546.512001-1-jwcart2@gmail.com>
References: <20210614150546.512001-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The syntax array that cil_gen_defaultrange() called __cil_verify_syntax()
with was wrong. It had the range (which should be low, high, or low-high)
as optional when it is not.

Use the correct syntax array to check the syntax of the defaultrange rule.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 71f14e20..a5f617d8 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5862,7 +5862,7 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 		CIL_SYN_STRING,
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_STRING,
-		CIL_SYN_STRING | CIL_SYN_END,
+		CIL_SYN_STRING,
 		CIL_SYN_END
 	};
 	int syntax_len = sizeof(syntax)/sizeof(*syntax);
-- 
2.26.3

