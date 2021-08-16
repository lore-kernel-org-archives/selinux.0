Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B74C4338F
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF11960F38
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhHPT6c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPT6b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 15:58:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF22BC061764
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:57:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 14so20422656qkc.4
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4P8yVry5RwjXQvUPADAqTyzgwJflR9fxlPwo42wbf4A=;
        b=YYbFbIspPgElXCQvW4FRN1SViKoy4OarUTf0RtKvxA14aMQMXuHyh0wkwvpwVrh1av
         oT1c8e3LvtxNS6zWaVzi0m4XcPxF7I6Qnu61vlXNzX3dXQabPrpN8or7Jxrvyg79Lid9
         j5v5Zt39A+PNvVoyfncncC4ocsNqfDZjXQP2sXFq6r7F6kndKNXlufEK/5u5vAvBY0rw
         UAW57C+5YpMoMTfxAFNpYSBo3fymCXKs91fCsYdb/z/DTz0hViH1St1I8+DKDAEeQmoE
         tRqK8OsRN0sOl/b67d2iNaiCTzuOC25YGItMLfiUtvrwd2YPvj2mNVaP2YZkKb0tYudm
         3YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4P8yVry5RwjXQvUPADAqTyzgwJflR9fxlPwo42wbf4A=;
        b=UONhRe1526YMHGHMG+kTI4rW2locjBkw+oQSlYrQiKvlqso5C6SGeZb/T4EGBKgRb3
         fgOjX3uVkVJDiXKdAujD7g9rqVUOyUZF5zgjtB8Yg4Ca6vfNbMydZpbOea4ByziXszLj
         SxfAnV8PUFZtWbCegSsVGEQr8jpig9ughX3mz0UsuEJ/awcXNexpcqFlbHH2eLvaVR+h
         BvO+8Do71ETjGIgw0tiTGxo7zKEa9AHL2bH4oXAVeb6luMpZ/3muUM7r7OJpIaPlII/d
         fTayrBsgHQQ/VHdMcEodMha2ZOC84qeXxt0ryRu83UEy+ncRqvrgJNpuHuKldIPMa7dB
         cKXw==
X-Gm-Message-State: AOAM533Phi7hwIiGDN06aWZ7bGC+RKqyYujv+UtKyNoPoh7DHVPQl2tM
        9Eyh2sKhlOleKQrHG5Bavo7EtRarCMGrTg==
X-Google-Smtp-Source: ABdhPJwlPYtVYqLyalp0ysHEdCslqJsX323xP8Q9nYSeQCnYppJJsZNcxxneiUJlNjQafh3l+ChYZA==
X-Received: by 2002:a37:a48d:: with SMTP id n135mr47797qke.54.1629143877546;
        Mon, 16 Aug 2021 12:57:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f11sm135147qtf.45.2021.08.16.12.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:57:57 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/7 v2] libsepol/cil: Line mark cleanup and fix
Date:   Mon, 16 Aug 2021 15:57:45 -0400
Message-Id: <20210816195752.923028-1-jwcart2@gmail.com>
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

Changes in v2
In patch 6, use cil_strpool_add("1") instead of "1"
In patch 7, fix confusing usage of pre_hll_expand and pre_hll_offset; initialize pre_hll_offset, change format specifiers in cil_tree.c to use %u instead of %d.

James Carter (7):
  libsepol/cil: Check syntax of src_info statement
  libsepol/cil: Check the token type after getting the next token
  libsepol/cil: Check for valid line mark type immediately
  libsepol/cil: Push line mark state first when processing a line mark
  libsepol/cil: Create common string-to-unsigned-integer functions
  libsepol/cil: Add line mark kind and line number to src info
  libsepol/cil: Report correct high-level language line numbers

 libsepol/cil/src/cil.c           |  70 ++++++++++++++++-
 libsepol/cil/src/cil_binary.c    |   9 ++-
 libsepol/cil/src/cil_build_ast.c |  77 ++++++++++--------
 libsepol/cil/src/cil_copy_ast.c  |   5 +-
 libsepol/cil/src/cil_internal.h  |   9 ++-
 libsepol/cil/src/cil_parser.c    | 129 +++++++++++++++----------------
 libsepol/cil/src/cil_tree.c      |  57 +++++++++-----
 libsepol/cil/src/cil_tree.h      |   4 +-
 8 files changed, 226 insertions(+), 134 deletions(-)

-- 
2.31.1

