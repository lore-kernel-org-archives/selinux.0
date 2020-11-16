Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCFFC388F9
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0D3223C7
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo9RX1kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKPWHK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgKPWHK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Nov 2020 17:07:10 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20DC0613CF
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:10 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id z17so9636092qvy.11
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gIdY/HZeLPpmuWY10kI8/O698zSfUdm0NtRoQWKT9Vk=;
        b=Xo9RX1kp2nkvUlQPZV4jKk5Hy+8fXuQxCSGprJfzYZcIEtkRYIGFlLpHswO9xc3D6c
         0Jz3Yv3hJ6g4tDkKMwSkwY40i8+YYVXCWvyEAFvzxUF8k4d5ebg4TxL5MoNLQ1QwloKk
         Dlhw82/aVOLx4YEA3ipYJUKL85HIiozxGKqzRlwcKycDsQXd7NWxK9cMJioIKceQwqTa
         5xHJ/TJKKbgK71GrI5NOzJDAFq6INiGDaKIsBuZ+qqmcrjD+SNPCVHF7ERkG3bn2V7sy
         BE5ZsVU7Yo/vhUIg6cWon+ij7ohSN6QZlQ+uLZPRM6jUMShCQ/aftddLpCmdlRQPRq4P
         6H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gIdY/HZeLPpmuWY10kI8/O698zSfUdm0NtRoQWKT9Vk=;
        b=QqBs6LRCWME0Hoa0j45KYDvU0gWABpYAstsOABMKtmq9TwKH9ikqIsTWanqy+Ja+Kw
         GfPBg2tIm6JSG5oqrqtxYpwO0Wx5kfu090NMJh12mqCwjZxuE3PiV9Rd/WZv+/Od6P9/
         FURoWIahkDYe8QfHyqF0Kf9WqBbZ4QDiJ6BVhON3mwyyoEaTc4gwbwUyKnvstlGAlvZr
         o4t04OE6W5Lcx8XncYZRKMZGHtJrfS3GZWIMuSM3j3Y+ZNJL3vUpua0z+PL9PkvLovgb
         lRYojzQnXycU4ZK69gwfhjCnTjmKOgIl54BCwz9pq/7NM3bscjDvk1HFjxeBdgigdeVt
         l/SQ==
X-Gm-Message-State: AOAM532aLFhDPyVo+b/d8dd+O5bSGLYcQ4hLu0TiI0HWBj+zNFfhsuxR
        mzeSePJ6Fb2sQYSOelJeq22yavxRbsI=
X-Google-Smtp-Source: ABdhPJwHyDmxD5nUY9gOlzzSMEmonaQoPgIy/sPfIqbSXKZgcNvbHwabf7tV73T0vsXKXwyRivaV8A==
X-Received: by 2002:ad4:56ee:: with SMTP id cr14mr18126237qvb.15.1605564429241;
        Mon, 16 Nov 2020 14:07:09 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm12653330qtp.47.2020.11.16.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:07:08 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/6] libsepol/cil: Various CIL cleanups
Date:   Mon, 16 Nov 2020 17:06:56 -0500
Message-Id: <20201116220702.174765-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Cleaning up the CIL codebase a bit. No changes to how CIL works.

James Carter (6):
  libsepol/cil: cil_tree_walk() helpers should use CIL_TREE_SKIP_*
  libsepol/cil: Git rid of unnecessary check in cil_gen_node()
  libsepol/cil: Remove unused field from struct cil_args_resolve
  libsepol/cil: Remove unnecessary assignment in
    cil_resolve_name_keep_aliases()
  libsepol/cil: Use the macro NODE() whenever possible
  libspepol/cil: Use the macro FLAVOR() whenever possible

 libsepol/cil/src/cil.c             |  2 +-
 libsepol/cil/src/cil_binary.c      | 12 +++----
 libsepol/cil/src/cil_build_ast.c   |  6 ++--
 libsepol/cil/src/cil_find.c        | 10 +++---
 libsepol/cil/src/cil_post.c        |  2 +-
 libsepol/cil/src/cil_resolve_ast.c | 55 +++++++++++++-----------------
 libsepol/cil/src/cil_tree.c        |  2 +-
 7 files changed, 41 insertions(+), 48 deletions(-)

-- 
2.25.4

