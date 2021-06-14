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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143FCC48BE8
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 15:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA2560240
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 15:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhFNPI5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:08:57 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:46972 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhFNPI4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jun 2021 11:08:56 -0400
Received: by mail-qt1-f174.google.com with SMTP id a15so8721495qtx.13
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrTvLwpCAi1d94KNTiy8IzKm93bkkbSspOl/PDNYp7Y=;
        b=LEU7mc8KrG4Y0cuOG4y8SpXvsAavSZqM9kW1Y7P+4SOT25zWj31tEWWH9pSUrn06hA
         zTYBRCzea0TcFrJ3dwiqftMZkXCjUm3oKACSHLMRWdXhL5RHrP66LkufA/ulPDT53fYd
         fiUrlbKpDv8pdwTyPiFfZio4A/K3lEIc4wMDoexvLS5hxVksya/W+YW+/Gbd59DB+769
         Xg4a5WN9ZvGz5ps/pW8d+ZbnGDK0qnD2kOhm7HUSCvheLaLqvBHnN+q3mEQhAdaSTmHe
         c1U49hwuG0mpkawujQqo645OfVDGqiDB6ByB1u0xoWAVolonJD553CKdlo4T4op2L4Fo
         IkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrTvLwpCAi1d94KNTiy8IzKm93bkkbSspOl/PDNYp7Y=;
        b=IjkdbLTEVQDaYf0plIKOgkeZhhGP3QL6JH/xQkGSWFwhpMDfuV4g6sfKBPR8VrJGoZ
         unrGfkIY8H6KQFbNrir9Z8pqNuDCblsRPOHD0D/MtfhEeSI7hPBwo6hRljNo8cjC+3Gf
         8VdSmZB5Lz0P86pE0aBVBGlPGh719ZFPMypgEG1aCBYtB/DO7q6L4mZN/Ttufod7b6TT
         X7OKzXD7YEYHGeXt1iU8hPHD/+SU5S+7uCECNbxbNbRgYbT/+38gqiDJXMF9peNYWx2G
         vqR3YeSj7qSTzyN1cDXLVQMDVmCaMHr442OZlVDcX4lNgI7X4pHgUr5MN/6GF4YeFNYH
         12/Q==
X-Gm-Message-State: AOAM532CA71RBhZqiYD1Qtm/SK3c/AxiFDmWivjiGki56GKjxz2ehO6O
        50lqagC/iLKmyWZlMhB/5ytsMZh+gmpgpA==
X-Google-Smtp-Source: ABdhPJxtX8XdwouYAlF+L9WRwPjg25CpwNl94sVb6BFQGYyGlGIXVcgTE5g3SYp56epXJyhB3fsanA==
X-Received: by 2002:ac8:708e:: with SMTP id y14mr16891968qto.221.1623683153547;
        Mon, 14 Jun 2021 08:05:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id 75sm8221014qkm.57.2021.06.14.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:05:53 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/5] libsepol/cil: Reduce the initial symtab sizes for blocks
Date:   Mon, 14 Jun 2021 11:05:45 -0400
Message-Id: <20210614150546.512001-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210614150546.512001-1-jwcart2@gmail.com>
References: <20210614150546.512001-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It is possible to create bad behaving policy that can consume all
of a system's memory (one way is through the use of inheritance).
Analyzing these policies shows that most of the memory usage is for
the block symtabs.

Most of the nineteen symtabs will most likely never be used, so give
these symtabs an initial size of 1. The others are given more
appropriate sizes.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 0d351b49..c6674fc1 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -54,7 +54,7 @@
 
 int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
 	{64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
-	{64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
+	{8, 8, 8, 32, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
 	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
 	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
 	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
-- 
2.26.3

