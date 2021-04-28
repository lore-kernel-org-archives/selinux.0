Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FF7C433B4
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43327611BE
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhD1USn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 16:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhD1USn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 16:18:43 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02DC061573
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:17:57 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x14so8134911qvr.5
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dHeXOGppbe3l9MK/BGs5ZYr3N2JB4i3gW9AA0KO8Wwg=;
        b=I9qpxtdcW8E/eZD8yddXkQZcQgarLomeIE2/oYTHb1dQ67UK2CGyGo1Xrgl+nX/6ZU
         PRvszA59QLxG3Dt+NyLxGQ+i5h71MtTXs16jSgkC8EqYREtvfD45fVaypvgkKpXNej3/
         sezHrZ8Iqr+zTXN7ayoBRcMvjRwIi5jVXjzZ5233Jq8BcWa3XEVrfJ+fm5zVkrzQymmE
         tzZMrOsYuB0bX1Ep1bJxV6yaxJ9DDETgdTTyjykZR4yEOOWo6cI8/fWZtXTyHdzh03AL
         JRUl6sOOHjhWWf43jgR/5LnZCc9MMpxxHscq+roX+7JI/t8ZovUFexHhO41dmypmAxY8
         vkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dHeXOGppbe3l9MK/BGs5ZYr3N2JB4i3gW9AA0KO8Wwg=;
        b=qyP0IRtIeIXs4d3jRr9ZlPvo6rur+5fH2nDQVMBuR3U9ZsAz8PldP32qPSgvEvyQkw
         LLTxCR9jt30ZzwJUCfJewHhtf21opgDCr6UPwHMAzwN0CFMtzpwi/+eU+qxjTB1QEAQU
         NqHZj2u/+1ajqRIK8ckLqoRMB+Ijtiwdmqr6CDOQI0/LvyJc/aa921Tvou8GCED8lHkd
         2oNu7TDH95F8sxSRoKy8J5Gmjxp71X8AYLKATqQ26I7Vf9TKUfdb1FWeVL7cmkye8XUe
         aCsElWw0X8p759Pk7FKqtwrR3SIoP4nyKtt8BQoteZy+ufhrpuL1qNbrBnmgS0gZxFFf
         +sxg==
X-Gm-Message-State: AOAM531CpNRfEqxS/1vkn+6cWGG/2I/UX9Cc4dOamhYocF4FjxM4jNiX
        iwjqMRW3TVDVjRWhRa0DhOhcaWWjh4Ed7A==
X-Google-Smtp-Source: ABdhPJwu3C1wkjB0TWhIXmKLYMdk3NAay585HDcaT11oKsEyMrj2pcJ95Q6/9Z08drNdMca1y011kg==
X-Received: by 2002:a0c:a425:: with SMTP id w34mr31001888qvw.2.1619641076608;
        Wed, 28 Apr 2021 13:17:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q126sm616666qkd.48.2021.04.28.13.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:17:56 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/5] Fix bugs identified by the secilc-fuzzer
Date:   Wed, 28 Apr 2021 16:17:48 -0400
Message-Id: <20210428201753.282831-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches are all related by the fact that the secilc-fuzzer
identified the bugs that led to them. Wherever possible I have
tried to fix all of the issues related to the specific one found.

James Carter (5):
  libsepol/cil: Fix instances where an error returns SEPOL_OK
  libsepol/cil: Detect degenerate inheritance and exit with an error
  libsepol/cil: Check datum in ordered list for expected flavor
  libsepol/cil: Check for self-referential loops in sets
  libsepol/cil: Return an error if a call argument fails to resolve

 libsepol/cil/src/cil_build_ast.c   |   3 +
 libsepol/cil/src/cil_internal.h    |   2 +
 libsepol/cil/src/cil_resolve_ast.c | 107 ++++++++++++++++++++---------
 libsepol/cil/src/cil_verify.c      |  97 ++++++++++++++++++--------
 libsepol/cil/src/cil_verify.h      |   1 -
 5 files changed, 151 insertions(+), 59 deletions(-)

-- 
2.26.3

