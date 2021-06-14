Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C10CC2B9F4
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 15:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6041760240
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 15:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhFNPJF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:09:05 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:41649 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbhFNPJE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jun 2021 11:09:04 -0400
Received: by mail-qk1-f175.google.com with SMTP id 5so648058qkc.8
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyLMLxom8GIYOQxBOaARGRfkLyDPraV+lWjTWmmFHSk=;
        b=jK+1s8OZ1QsHakQNlq7q2wrAFzHNV6g7QgfidFkSB+3XKDK/GX6ZfKubbJlIWlBKoY
         NhmGBtptb83fNDlU89RlUDrb3OdPlxOoy3fbK76S86e5MdAzUzQRyBVApQ6YbtrIuFOY
         2ptJOYp3Qq8QkPGyAEHkYWc5Yj4zRY90mJFC0U/zX7V1fy1LzHwMTYDrd8Z0HLTrjJ1c
         kBBHjCbaT6WB68oiv7LjYXFm5Ek6KQoKS/uAFdH0IQt9//YA+zzvMvnFOfc/jGLhoC85
         b2KFNHviaWh7c8s7dSsH93aXy3j9a8rmUE6INx+AfqgdaXe58iqa9JEF8DkmUnF/h6Ds
         wygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyLMLxom8GIYOQxBOaARGRfkLyDPraV+lWjTWmmFHSk=;
        b=B2LaR00qzziXANKR0FQULuHTPc3+p5sJUdv4EbCEvuWxyfEz2SsAr9a/M/Dd2voxLN
         5ZhLtZe+JXDgHWWBHvXkVLLIfTIyAPoW0P628ysHUkSuIFkLA+YUPbKf7rH9bs3rg1q5
         mmPU3qZW75Me+qLCeNjMMBnEjBCxWKx7AEckXKPDx5Cy4MAEkp0d29MXl86mqgJEBpY4
         0xKCNlDr2P9WtLdwkkXdhOsjZKfD90YR0RI2lLUEl9xpZ3ewxy2sH44UKG121WV4hBUR
         2lvxYnlxxrQueRx1jOV/El5/m+TbyxKclwQvl/EoPgJem1NyyMEBMeoY88ZIG3poEQig
         KCug==
X-Gm-Message-State: AOAM5331mWSSGZ74WDRkoBj/0dnNgU/YtMe5TunqndTDZvkpN8H4sug3
        ZZITp6/Fb/EKnKfiq3+L69v7/ArJbxuBGQ==
X-Google-Smtp-Source: ABdhPJzj9BCttwGK6G+FaxiHRYXxHrdAQq0c59+NJwVBZzINaV58qANvOSsrb9Sn4oC/xOleRKBIqg==
X-Received: by 2002:a37:94e:: with SMTP id 75mr16702386qkj.127.1623683150979;
        Mon, 14 Jun 2021 08:05:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id 75sm8221014qkm.57.2021.06.14.08.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:05:50 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/5] Another round of secilc-fuzzer problems fixed
Date:   Mon, 14 Jun 2021 11:05:41 -0400
Message-Id: <20210614150546.512001-1-jwcart2@gmail.com>
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

James Carter (5):
  libsepol/cil: Properly check for loops in sets
  libsepol/cil: Fix syntax checking of defaultrange rule
  libsepol/cil: Check for empty list when marking neverallow attributes
  libsepol/cil: Reduce the initial symtab sizes for blocks
  libsepol/cil: Improve degenerate inheritance check

 libsepol/cil/src/cil.c             |   2 +-
 libsepol/cil/src/cil_build_ast.c   |   2 +-
 libsepol/cil/src/cil_internal.h    |   5 +-
 libsepol/cil/src/cil_post.c        |   4 +
 libsepol/cil/src/cil_resolve_ast.c | 229 +++++++++++++++++++----------
 libsepol/cil/src/cil_verify.c      |  48 ++++--
 6 files changed, 191 insertions(+), 99 deletions(-)

-- 
2.26.3

