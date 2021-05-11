Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E375AC433B4
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E9861433
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEKUEU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 May 2021 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhEKUEU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 May 2021 16:04:20 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F4C061574
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:12 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id k10so2033595qtp.9
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dXS6L48VuTAxb2+PywL09hLpA+KUqpD3muGHMKw1AA=;
        b=aPA/IPpI9Q8ULZ9BIjIh3IGfBYilChexoLibDQJQjvFd2gavA5k/ACQZEK7aqLbOBn
         OxVqWUYEtK9r5QhcsTXqiyOfzY9gQ+aZn1akSizrY4uJI3+4d+4LAh2z6wYlWPFtRhqQ
         OB8csB+1oObD+gvCwzQkSGKLcClz9gwU93j7tbtYG0e87v6xH/tXIpVeefxYT1sTj3ET
         PlOdGpqAFPIlBKvN0kc1z9kTBoXFQzWQgbEbu5u3EkSWnlFR9bWR+ax58PHpdKIByL9i
         3eDLzEb/vScnXqmKFfA3s1f1TSGq0gy/5GRHkvMEsrYkeSQEw96w2heo0MEFfhrWghpt
         0Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dXS6L48VuTAxb2+PywL09hLpA+KUqpD3muGHMKw1AA=;
        b=rtBZ4cKqhR6PmR2CVzYji3oR87Zyn9AYDiyGelZgFuGQpue3NzhzR896YGYeeY/87k
         DIQY+apPClc1JSjAYLss+tELBpxS51WARNvEu28U1SZ3ZqzDa2jV2d2O9CwbXrwGyX6t
         M1wvkiB2EjwwEsbfpOL2fZc+aOkQTp4WHok13XvEV8VG6PjwM1KBwz1zX7o4Ems4CPkI
         Ly8USrw+MNVqbxiSIY+dn+WnLozub/R/s5GKBEYpE6hZs2tvcy3tR6o9P3g2Dk/kVL1Z
         5oiUg7ANyAQDP4INaHcw+500hhFHYzwMg0D74he6t1j8NPS0Dye5QiNYFphZj9qZXDvE
         G1rg==
X-Gm-Message-State: AOAM531M4AEBtk6fOrwjJwyTb9QTyi31kY7GwWrZ9sqPfZk4rjiIL4E3
        3lXdWy9DhsaXidND688UXRfm6LL3mhM1dw==
X-Google-Smtp-Source: ABdhPJz5KJ1At7uAGGR79PeuevPCJh5Z9SkXO7UkY6Pwq/60MmtI89Ej4VG3I9Cee3yljEXnirsISA==
X-Received: by 2002:a05:622a:253:: with SMTP id c19mr29573175qtx.53.1620763391592;
        Tue, 11 May 2021 13:03:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z9sm4642533qtf.10.2021.05.11.13.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:03:10 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/5 v2] secilc/cil: Fix name resolution for macro calls
Date:   Tue, 11 May 2021 16:02:56 -0400
Message-Id: <20210511200301.407855-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch series fixes name resolution within expanded macro calls and
with call arguments.

The first patch is same as in v1.
Patches 2-4 replace patch 2 in v1. The original way of fixing name
resolution of call arguments did not work if a disabled optional
forced a reset.
Patch 5 is the same as patch 3 in v1.

James Carter (5):
  libsepol/cil: Make name resolution in macros work as documented
  libsepol/cil: Do not add NULL node when inserting key into symtab
  libsepo/cil: Refactor macro call resolution
  libsepol/cil: Do not resolve arguments to declarations in the call
  secilc/docs: Relocate and reword macro call name resolution order

 libsepol/cil/src/cil_internal.h          |   1 -
 libsepol/cil/src/cil_resolve_ast.c       | 635 ++++++++++++-----------
 libsepol/cil/src/cil_symtab.c            |   8 +-
 secilc/docs/cil_call_macro_statements.md |  24 +-
 4 files changed, 354 insertions(+), 314 deletions(-)

-- 
2.26.3

