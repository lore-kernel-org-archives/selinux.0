Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CA8C001DE
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 21:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjHIVCJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjHIVCI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 17:02:08 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7121BD9
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 14:02:08 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63d30b90197so1576396d6.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691614927; x=1692219727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCsmGNE2yHK/QORqFKg6ZdtZBsQJIjnpnbFGKlqJMSU=;
        b=gVq4v4xbFOeKpJO0hVvcbGPg9dYbnbjzdbRbqai6L6Z78FaIrjCEfdP/W0nRix+MWY
         NQLYTY5V3a6sT/UcrhVLh4ORnsuyN0dRJViS81Bc481UvM7l/rykpuD+nMMQWo5ocrcx
         6f2eLvP9wBT0n+DTqh3dtGU8wbeeyEOfeEbNl3wciT96rAoKUKjrJF+8Sl/RI9u1b6YF
         /4pmK9hG7GBeyIZij8g2D+8iA82FJ+EI5irWrLsKYKbmzFHPzfAIUt+ZDQ8qMyK/mBX3
         ISAaXUjt9HKEHJ1rzt6GmKASVHU+RR1Whp1opgIs6BiT7Ey/2MwBtEqsK9yQsYxHECpW
         gj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614927; x=1692219727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCsmGNE2yHK/QORqFKg6ZdtZBsQJIjnpnbFGKlqJMSU=;
        b=Z1XWsK2Cgz3YrdptEHGQ9mekGByLxQHtxPjN/Uk9nWrHxNmtAegHyvJmiPdQGDYci8
         fccZUbPEw3Z3OusdBl1e67dUS+X6n7YH6BEDQFKwpnbTvt5oW+qCZXzBeb+W7VWfZ2Xw
         hBx4HUc5wvLMkiJ1jSnz9N/efyNWnncHTIsfjllCZv8JaERw8+7eNhfDYFEvh6odSWCe
         83MtYMv+GM+q8S0llPAdJ8x97r1P1akFijjNLL7w+snRFcsWlHO5zo2OohtmJA7PM0h3
         StbXnukMYKXvoUKuBBmgPkx7v5hcM1ZaXPNGF5LUYjfqzpZo+Ppz3xq152q2Fiq3zZ8y
         iCuQ==
X-Gm-Message-State: AOJu0YxDKnAv3fB9scqXP7lGLwPqUUJbetfxQhNEs2Mqaa19p1FWhAto
        9Kb9uX2uGY6cB8tekuBZE+4Bdx6sGt4=
X-Google-Smtp-Source: AGHT+IEVxTFqYnh6RhvmEKCaWR7nA2/YXN94yEM3aYQ3cCRqWdLFMqgwqMJls/+nMWZW2vzGx0F3kQ==
X-Received: by 2002:a05:6214:1418:b0:63d:77d:be74 with SMTP id pr24-20020a056214141800b0063d077dbe74mr366524qvb.59.1691614926826;
        Wed, 09 Aug 2023 14:02:06 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm4208287qkk.132.2023.08.09.14.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:02:06 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/9 v4] libsepol: Export the cil_write_post_ast function
Date:   Wed,  9 Aug 2023 17:01:54 -0400
Message-ID: <20230809210157.112275-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809210157.112275-1-jwcart2@gmail.com>
References: <20230809210157.112275-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/libsepol.map.in | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 844924fc..6ad68f0b 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -289,3 +289,8 @@ LIBSEPOL_3.4 {
 	sepol_string_to_security_class;
 	sepol_validate_transition_reason_buffer;
 } LIBSEPOL_3.0;
+
+LIBSEPOL_3.5 {
+  global:
+	cil_write_post_ast;
+} LIBSEPOL_3.4;
-- 
2.41.0

