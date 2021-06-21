Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC28C48BE5
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0EE61040
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhFUTU7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhFUTU6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 15:20:58 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F3C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:43 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w21so19532071qkb.9
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mWIT5afHlljCpg4a12oL0OVKsHoITi4LoCD214PZgbk=;
        b=cTEyrrPh0gZeCSQMGxrDiLEg12fAaSZ+xwA7pq5hA67zmvUCv9IHxFmnA+zknKuxMk
         syKRdBmZjQXLxnYombeGEJKU+tHRmB2je1dOHtNi2Jiu3SlCeaSrAyh6pMQDchhnCxqq
         /mS4//TOMMdnnWgcFlzpka0wdgCEhDPfX7fKrwd3EzTWK2lw3OCYZM3i7pJST+ZZgWv+
         G861OC9DpkXYfWHbOO/f/Y+UXtLYVuEUQBDlgw3lnbzh/hH5rHAyjk3CTrkP9LQZ4XWu
         bwYAc21nO3SvfKi3G7LdtPpo/AioN2ua97gwzmdK0mhRHfOhDxZ08ZSGY6evxQ0wQa7m
         S17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mWIT5afHlljCpg4a12oL0OVKsHoITi4LoCD214PZgbk=;
        b=Pi21SHp2XM5K9wXdIvl7ZkVO4Y3Bbzj6reyyhiji7c/KYFfYI0R37iTFXJb5CvKPLS
         qn6zdWyC7C4gfUQFBRkSQpPPGnJlQRgmOMKtWUZDPyqATaQBr0PonbNUhjE5zqtUy9v5
         S4BaYEMS/H1Y5kux6J4RfmzqrHNuV8MFTqD8/yG6Q64f63InUhrmRNaC1KTtpFZ98A3x
         JdNg4g4UoXoBsk2aJcxF8DXQDJ46mEJIJJac7q2vtBJ08GCju2Tc8d2V9un/mHnYL9D9
         wy+kEwBPm1mMHfveEe8UCzM9JbDvOR3fP7OhWCJrZdO2+ZjOWhK4CvtoHpczgC+X3vcY
         KasQ==
X-Gm-Message-State: AOAM530SMPe5spuI70xJAIzROW+ftsZIP1lvrDqQEvmxDXDffJbJQ3It
        i+DnKaCtQntBaYls9AHJcCn60DykwP53Tg==
X-Google-Smtp-Source: ABdhPJy8JD2sD2O2hjxL9w/RzBBcGzcjNO+uZKYaLez7XY0+S6BJ45fCqqgg/7w8u740MaQdVikVbg==
X-Received: by 2002:a05:620a:218e:: with SMTP id g14mr206306qka.290.1624303122050;
        Mon, 21 Jun 2021 12:18:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o5sm10449124qkl.25.2021.06.21.12.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:18:41 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/5 v2] Another round of secilc-fuzzer problems fixed
Date:   Mon, 21 Jun 2021 15:18:28 -0400
Message-Id: <20210621191833.282874-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Patch 1 fixes the check for self-referential loops that didn't work in all cases
Patches 2 and 3 fix a couple of bugs
Patches 4 and 5 make it harder to create small policies that expand into large
policies that consume all of a system's memory.

Only patches 2 and 5 are changed in v2.

James Carter (5):
  libsepol/cil: Properly check for loops in sets
  libsepol/cil: Fix syntax checking of defaultrange rule
  libsepol/cil: Check for empty list when marking neverallow attributes
  libsepol/cil: Reduce the initial symtab sizes for blocks
  libsepol/cil: Improve degenerate inheritance check

 libsepol/cil/src/cil.c             |   2 +-
 libsepol/cil/src/cil_build_ast.c   |  10 ++
 libsepol/cil/src/cil_internal.h    |   5 +-
 libsepol/cil/src/cil_post.c        |   4 +
 libsepol/cil/src/cil_resolve_ast.c | 226 +++++++++++++++++++----------
 libsepol/cil/src/cil_verify.c      |  48 ++++--
 6 files changed, 198 insertions(+), 97 deletions(-)

-- 
2.26.3

