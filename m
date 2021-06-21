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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05261C48BE5
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85A461040
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhFUTVB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhFUTVA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 15:21:00 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D1C061760
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id j62so33270605qke.10
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9XqI5wZGakGMMkN4si3z7paKzFX04xLDcWEiucRdVY=;
        b=rcE/r/cCxYy8agvCtfZYse3TloIxZjEtPKOwBYgy9Ib7N8DMIrgv4241gVclMtW5VR
         4mFiepbObs4+wL6+AlzlW/DSoR2/VxdvXhSvFeFTCetMHVKfcO/nTk2ZaswWlgRQGp7k
         W9ALZFa0JOrDr0PKdaFc7pPQTSfgI3wPs/wVHZvU8+EKbjeI97l1Gi5/URJooJP15bvE
         u8CFg2aEVbnc3fcomHRrZrO1Mir01cN6J41qWU3G9gQ2nexCuzQ1nFHNkv6TqJZE6jRZ
         zpjJ4+NTuiqD9oibJqwWQbZQ1FP3zeaoNPTUClqrPVbirtvxvUHINSSr+IYCkkdYfwUW
         52NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9XqI5wZGakGMMkN4si3z7paKzFX04xLDcWEiucRdVY=;
        b=tz4wuQ4/cbjUupO52f/6I65flSa8h+WcKpDr1Mxtl8eMnZ2w0TpyeCYnQcihxDlS75
         iriisVrfNv83veiWiKz3UJtifLN8GXlEw18vD6WywRyndHfF6GcCkrf+m0AVR1veoi9w
         MOLYcjj/tC5jK+tbDtuq4Ty+Z2NqqCcQeCfDDt7LTZngEGwhhIPJAiwCgNI0eJh1pbjz
         6YSra8oF7hRbE2XNo2/kU+4mqykrvKnQ/Pxo7X+eI/AG35MGhZv8QPbVMmoupQFZfgk0
         Hvb34dT3gZswr9k86Kj395sMXl+5oVGJGQ7XYRodl4M39ng2WGBcVPgVuF18bbjwB/sd
         fN1w==
X-Gm-Message-State: AOAM533V0IKr9+Yk+8GNqIc1ahG1MaaSGLPQEQx7go5R00SGLHBkMmqW
        jpQZ8Dg2JY4aeRo0kNEb22DmY/fP3/E9Vw==
X-Google-Smtp-Source: ABdhPJz2CZQgymaj/fhEA0fv+qzq2MKdPq1kImY1r+pa5jGnZAo2UPSrmgvaIbXHhmDfOstX1aKTyw==
X-Received: by 2002:a37:bb82:: with SMTP id l124mr178901qkf.119.1624303124597;
        Mon, 21 Jun 2021 12:18:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o5sm10449124qkl.25.2021.06.21.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:18:44 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/5 v2] libsepol/cil: Reduce the initial symtab sizes for blocks
Date:   Mon, 21 Jun 2021 15:18:32 -0400
Message-Id: <20210621191833.282874-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210621191833.282874-1-jwcart2@gmail.com>
References: <20210621191833.282874-1-jwcart2@gmail.com>
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
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
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

