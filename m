Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFD3C48BE5
	for <selinux@archiver.kernel.org>; Sat, 12 Jun 2021 08:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771DA611CA
	for <selinux@archiver.kernel.org>; Sat, 12 Jun 2021 08:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFLIQb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Jun 2021 04:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhFLIQb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Jun 2021 04:16:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC692C061574
        for <selinux@vger.kernel.org>; Sat, 12 Jun 2021 01:14:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x14so12756394ljp.7
        for <selinux@vger.kernel.org>; Sat, 12 Jun 2021 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOrIK3Ubmggagwp2+KcOTlR6oy2Zo5aw+Ixc0eacXBY=;
        b=oWHTogezevMFtd+WF39c8Kdk4xQ5+wwWZ9EOCDN/qHuXbsAGHIpGZj6VHPM0KM9Oy/
         WS3tR4YgGZVx8W6YAgpTvNmRyeT2lPz+tTFSNhexLvmy1b3jx+dDGZ4QkDcxuS5/2TeO
         eyO4xH9VuEg+ssNYp09eq4TgiHS88E0n9MEM5jHkUcVc5xJqG6SME3JyWBYNYYdui1fl
         JHUcajD5whoiw8AFgmBwgmjRWmNYudEvGFGzmWdjcWWg2TJ2DmI0SZipOkgn+iatxt7Q
         jf2qedHi5P6Nj3yBltVbRIIqHCmQpPsKml39yL1cnKY5imGsy7EXQ0CQvTmn+86gJ05S
         //2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOrIK3Ubmggagwp2+KcOTlR6oy2Zo5aw+Ixc0eacXBY=;
        b=qGgQq2J+GrmkyS9NobcRFhdVXGlCTU6bmiLAZNmmJ3aPCER3fALS8Ub3va/GPavAsA
         xLKutkZ4SZooZQZeFmk61lIuzBCKOqT0QUBvjQRGujSbEBbJ93+V2dQWcH0fgRgFTNAY
         yqK7I4xoX/Khw64WTt28wcFOtS7oxCq5GuDCk6bSQAfFK5ORMnX3DpKDdpKm4Se3fiZf
         dET1c0lPNemXj3RqC7p300rP7b0QvHnYKKMFbjcitRYAJrxq/3GvlNZ6KSxk6mR/svyt
         h7HlwNX0U92e75y+mZeTluTy2RDGcfmMHZte9HAynQNLV5vZyVeJeY1+qRZSorJgzrT9
         Dtjw==
X-Gm-Message-State: AOAM531R/S4cq7Nu9NeWrVgIaDpyU7jayyWXiVBS/Duic+xDdus22c4I
        IFDoKHP9k49ol9iv72v5t77oSQ4u0Po=
X-Google-Smtp-Source: ABdhPJyjnGAg3Eoc4Wc3hBuSkjsOxUaoBk25N3GpETy/s7fCwj6wKXciwMBPQO5d/I+7ic+SQRolnA==
X-Received: by 2002:a2e:6c1a:: with SMTP id h26mr6104677ljc.34.1623485653843;
        Sat, 12 Jun 2021 01:14:13 -0700 (PDT)
Received: from localhost.localdomain (88-114-216-93.elisa-laajakaista.fi. [88.114.216.93])
        by smtp.gmail.com with ESMTPSA id f20sm837739lfc.94.2021.06.12.01.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 01:14:13 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] selinux-notebook: describe nosuid and NNP transitions
Date:   Sat, 12 Jun 2021 11:14:03 +0300
Message-Id: <20210612081403.16732-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Describe cases where nosuid_transition or nnp_transition are needed.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 src/computing_security_contexts.md | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
index bb946b5..7bd1d87 100644
--- a/src/computing_security_contexts.md
+++ b/src/computing_security_contexts.md
@@ -84,7 +84,14 @@ Processes inherit their security context as follows:
    *default_type* (policy version 28) or if a security-aware process,
    by calling ***setexeccon**(3)* if permitted by policy prior to
    invoking exec.
-3. At any time, a security-aware process may invoke ***setcon**(3)* to
+3. If the file system is mounted with *nosuid* flag, type transitions
+   require permission *nosuid_transition*. If the thread has
+   *no_new_privs* attribute set, the transition requires
+   *nnp_transition*. For both transitions, policy capability
+   *nnp_nosuid_transition* is also required. See also
+   [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
+   section.
+4. At any time, a security-aware process may invoke ***setcon**(3)* to
    switch its security context (if permitted by policy) although this
    practice is generally discouraged - exec-based transitions are
    preferred.
-- 
2.30.2

