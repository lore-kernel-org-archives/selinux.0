Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0D4C432BE
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F8960231
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhHJSWG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbhHJSVz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 14:21:55 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8FC07AF59
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e14so23393377qkg.3
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oW1AswY8jRNtRxkWGMjfa0LvMIj8H4wFjuk298s54p4=;
        b=PIf1r+dJQcsETeCg+yKTP79zmA0s25+YzrkcF9/JkWAHaJ5KD1c9Xy1DCy+tc2VNXY
         envvZTw27vbXIVycJhZaBskrxaLU4xDpZ4cmqUoN3CJ+K6Z3glTpUWZ41fWUcg3l9M55
         u9CL+BgSrkgOB4y5beEmaC301K1LXCfijHsm5ELeBQaFLwAVe3nl3VinyBbtNfzi5iZa
         LbNc7u/ok4eSx72KCSMouto3XVe+NkKa2NV2cjLB7o6boh1P9hrxytwpTLoP/3KBn4tK
         ZzQHFW+w09flrxlV/rCXXhOAL9cwHbSh/MTHqzk0xUIYcQBsbzl+CV6dCG/HG5e6A0/f
         G4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oW1AswY8jRNtRxkWGMjfa0LvMIj8H4wFjuk298s54p4=;
        b=aLqnNwqVeWDXzy4+p/PUmLhRPTaBeTNH5qjbTHM7uSXG/0xGlD9i5uBlgw0VY6eDlv
         ti4+buww8p1adMD6Vdly7tkZt0bELZKF3egSe3p1fKKr8iEYj8erXm1kgmcGpmRtRnA5
         AIuVJDpsY4/1u5RsQu30xo8kbLGoOT5tkBuhpjFAbKEkZqP48qln2lgg3BgfcKOesTVJ
         mqSwDy4t3X9DKDlNNO5jAyucl48FnJliEDDj3eq0SXqk0Gy4fwa1q2pJtnnZSufx2A0Z
         /GIEaa5qE/MVn9fPNLgvP/ZqRW4O8fay+xQR/GQZxrseNH2oWLKOkVNZ4pA2tB+dwrXO
         QcLA==
X-Gm-Message-State: AOAM531xGqeB/bmsTU/UedBaUmRYmD7pSjBkVDOkfBZ65Tv6sLt1A9oa
        haKjxk/v60s4XI2dbzmSzB9/n4U23rD2rQ==
X-Google-Smtp-Source: ABdhPJxIY+0ghniRNSJmrqzmtyavAYQp279oDmU4ImyQ+yOMo4Y7yVMnRgRxm8UL7LVAUQSiL0g8CQ==
X-Received: by 2002:a05:620a:3d9:: with SMTP id r25mr2835821qkm.76.1628618742776;
        Tue, 10 Aug 2021 11:05:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m16sm3057415qki.19.2021.08.10.11.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:05:42 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/8] libsepol/cil: Line mark cleanup and fix
Date:   Tue, 10 Aug 2021 14:05:29 -0400
Message-Id: <20210810180537.669439-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Patches 1-5 cleanup minor issues with CIL's line marks.

Patches 6-7 fix the way line mark works so that the correct line
numbers will be given for nested line marks.

Patch 8 writes out line mark information when writing out the AST.

James Carter (8):
  libsepol/cil: Check syntax of src_info statement
  libsepol/cil: Check the token type after getting the next token
  libsepol/cil: Check for valid line mark type immediately
  libsepol/cil: Push line mark state first when processing a line mark
  libsepol/cil: Create common string-to-unsigned-integer functions
  libsepol/cil: Add line mark kind and line number to src info
  libsepol/cil: Report correct high-level language line numbers
  libsepol/cil: When writing AST use line marks for src_info nodes

 libsepol/cil/src/cil.c           |  70 ++++++++++++++++-
 libsepol/cil/src/cil_binary.c    |   9 ++-
 libsepol/cil/src/cil_build_ast.c |  77 ++++++++++--------
 libsepol/cil/src/cil_copy_ast.c  |   5 +-
 libsepol/cil/src/cil_internal.h  |   9 ++-
 libsepol/cil/src/cil_parser.c    | 131 +++++++++++++++----------------
 libsepol/cil/src/cil_tree.c      |  53 +++++++++----
 libsepol/cil/src/cil_tree.h      |   4 +-
 libsepol/cil/src/cil_write_ast.c |  21 ++++-
 9 files changed, 245 insertions(+), 134 deletions(-)

-- 
2.31.1

