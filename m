Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061EC433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA46061007
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhDSPQi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbhDSPQi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7228BC06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:08 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v7so8027470qkj.13
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkDOy7KA8MMWUI7tE6jfy8iTRxR+8mZicH0pWd7LevM=;
        b=LkQeSdGjYkHd6+D6EHDr+AOxiiJscjY3N/8O9nK2/iUgor5jZLRMWEkMus3iNwhzlH
         xi4fdYdqxZoOPAy2X8UY2kUvbLEnimiPQL4krxVcPR0nzgej22KMB9/3040RTiTYey/0
         wqZ18p+j2znrP/nxUQVGLF+2eQSR0wRxjAlAgSlSnz4S8GixQ1XXMtOxQSSpb/uQxKwA
         lop7eFVTs1cTSblGHOMqYSysQYTwQBOHo4gyfm1oFLmCDA2S04F19EznP8SkIz1v0xLZ
         JaH2uUo8Hcn3xaMX7ytAhMuNyw663gJ9gNVpWrhkaaJbmLkyENzF5+TmcQ/QuNvpAu+v
         7rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkDOy7KA8MMWUI7tE6jfy8iTRxR+8mZicH0pWd7LevM=;
        b=dFXxJ7YYUvNZ3jqJuB/G/8fehcT1egrK0Vpgag+wG+4Evk6Y5nRTlBqqBu8z6kS4it
         ueMrwLv8CVofVq/+p3q2XJs38byl4kNw4iEfVoQH/JjF6jLP+g6BTxKKx/SekF+tspVA
         RE0xuUA9iUs1odNu8efLrCeKwrtJVJTFqR7VEZ8QEaFMimTb05NX8lQEAUPt6CiVBMpK
         GwbyPbaq7VwMCdIFvVMfZj2Duggc+d4NXqK+3omm6L2tLpXFJY3LJ9fmKdgnnfrgJrMG
         nsmsT+NRCGjy2MfeFf3f0pG4jtpGfD7KYws6ocQOPglsoWmYgPluQEz5+hvOSPp0jQMf
         PqJg==
X-Gm-Message-State: AOAM533qk+uI6xbfqdbi+rDsoRIOil6PkTCGzr4qyav1lnt7Jl2oXFA5
        utnnCGCoygAUHboVyXxGfgmjvEIS7Dm5uA==
X-Google-Smtp-Source: ABdhPJzskjVOoTk7ehhXhlwS4Qw7/rUGKlADtofYXFQwJMIVrfr8Fb0INN10BCVMuuKwVY9UN4FBiQ==
X-Received: by 2002:a05:620a:448d:: with SMTP id x13mr12124780qkp.10.1618845367598;
        Mon, 19 Apr 2021 08:16:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:07 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 00/11 v2] Various CIL patches
Date:   Mon, 19 Apr 2021 11:15:46 -0400
Message-Id: <20210419151557.87561-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

All of these patches (except the first) have been sent to the list in the
last month. The first patch is a slight modification of an earlier patch
sent by Nicolas Iooss. I also corrected a couple of whitespace errors and
updated one patch that would not apply cleanly with one of the earlier
patches applied.

v2:
- Remove redundant parenthesis from patch 7 "Exit with an error if
declaration name is a reserved word" to satisfy clang

James Carter (11):
  libsepol/cil: Fix out-of-bound read of file context pattern ending
    with "\"
  libsepol/cil: Destroy classperms list when resetting classpermission
  libsepol/cil: Destroy classperm list when resetting map perms
  libsepol/cil: cil_reset_classperms_set() should not reset
    classpermission
  libsepol/cil: Set class field to NULL when resetting struct
    cil_classperms
  libsepol/cil: More strict verification of constraint leaf expressions
  libsepol/cil: Exit with an error if declaration name is a reserved
    word
  libsepol/cil: Allow permission expressions when using map classes
  libsepol/cil: Refactor helper function for cil_gen_node()
  libsepol/cil: Create function cil_add_decl_to_symtab() and refactor
  libsepol/cil: Move check for the shadowing of macro parameters

 libsepol/cil/src/cil_build_ast.c | 132 ++++++++++++-------------------
 libsepol/cil/src/cil_build_ast.h |   2 +
 libsepol/cil/src/cil_copy_ast.c  |  26 +++---
 libsepol/cil/src/cil_post.c      |  11 +++
 libsepol/cil/src/cil_reset_ast.c |  11 ++-
 libsepol/cil/src/cil_verify.c    |  78 +++++++++++++++++-
 libsepol/cil/src/cil_verify.h    |   3 +-
 7 files changed, 160 insertions(+), 103 deletions(-)

-- 
2.26.3

