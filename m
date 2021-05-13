Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FC1C433ED
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3805610F8
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhEMSy7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEMSy6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 14:54:58 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6175C061574
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:53:47 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v8so8560295qkv.1
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpBH6EkvSaxtqezBW6KjeMnwAo6V3U1mmME2GB6bfVQ=;
        b=pgs4W0cPY2pCF6/ww1WTwzqG1XUKgPZftI5sXYVq9NP8Iv7P9DCtgnqysso9u5UlGK
         +liSq3AJHh0euGTkyPdX8ndgwpDExBBmyG7VdIaheVTXq+fh7+0PD+UKN7n0rxSDv7R0
         imvTyozOZUJI50gBF8QsAQSRaFiFVVoifnlGOD2GMkTqec37cXK5WD8GCkmYNclatWxb
         2oZMOikGyENk0Pi70yjhOIma97wZA1tVwehKNqNGMw03q4GvLOqfM+FYrpua5DLB7zfS
         Ec3oPsZpTw6wz6tREMLatTdal/uinGSEvkeyxwuHejlgbFoBfqjy7KeC5k0rpDZ8JQL9
         tMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpBH6EkvSaxtqezBW6KjeMnwAo6V3U1mmME2GB6bfVQ=;
        b=C0aKvuGcupH8t9amDPF36+pX8QFstGXma3i+yN2z9poEKJhVFxG2H8SzqaEK8mWRBP
         uKz6epS2j7U6BTYVv93d+AjgAiRxsbUBC+w5XLWeKYZq1Thy3hX5v7zDrKx9lJ6tvMU3
         7mhtB4CUWWVFfviGdaFvQThnfyHhvHMriJN4I011tGALRjgbpu7uKBjjwO+/j/HCN56d
         GSuu/HQTIczF+RyNA0yY7Iu7/He9O8CUs63LGDCUUQ+sq+Ko1hN3ZGGVRiwIDkInxCd/
         t7lt9DqlyHrdHbbk/kHTrUqbyfiGN7O01N6xuUidZ1kk3jSHv9Fo7DfPgKpACrt0sYCi
         Ws6Q==
X-Gm-Message-State: AOAM530B5l2uExeU9+vo0VznMIpMv4h/a6Dl8kshBXqg9SbVfPa1kcJ0
        o43NbYZCVTCjZuN1PGFxyT3Nb2MeZ/G/EQ==
X-Google-Smtp-Source: ABdhPJzo6wVRy425fKnTkE33Hoe0qx7w3bh+et769fKEbYRexuSL5yilR5IH/qBFnMsUPZEDvODedA==
X-Received: by 2002:a05:620a:2191:: with SMTP id g17mr35615320qka.296.1620932026720;
        Thu, 13 May 2021 11:53:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h188sm1713767qkf.133.2021.05.13.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:53:32 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/6] More secilc-fuzzer problems fixed
Date:   Thu, 13 May 2021 14:52:48 -0400
Message-Id: <20210513185254.559588-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Patches 1-4 fix bug found directly by the secilc-fuzzer.
Patch 6 is the same class of bug as that fixed with patch 4.
Patch 5 fixes problems found while investigating patch 4 and 6.

James Carter (6):
  libsepol/cil: Handle disabled optional blocks in earlier passes
  libsepol/cil: Destroy the permission nodes when exiting with an error
  libsepol/cil: Limit the number of open parenthesis allowed
  libsepol/cil: Resolve anonymous class permission sets only once
  libsepol/cil: Pointers to datums should be set to NULL when resetting
  libsepol/cil: Resolve anonymous levels only once

 libsepol/cil/src/cil_build_ast.c   |  2 +
 libsepol/cil/src/cil_parser.c      |  7 +++-
 libsepol/cil/src/cil_reset_ast.c   | 56 +++++++++++++++++++++++++--
 libsepol/cil/src/cil_resolve_ast.c | 62 +++++++++++++++++-------------
 4 files changed, 97 insertions(+), 30 deletions(-)

-- 
2.26.3

