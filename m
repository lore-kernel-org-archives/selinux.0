Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BE4C433ED
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE5B61132
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhDOUeH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbhDOUeG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Apr 2021 16:34:06 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C12C061574
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:33:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x11so26614556qkp.11
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tL4rOK1UkDlX/9Yu+VMh1Dtk/a2F/k21pomxslOU8EE=;
        b=KC/RC+6eIl0FNR/JGFPonEppEFqbHnbXN+4cyJEo5yey2/DXujy4e7IKDadRgXERpc
         5d8uDKavMmgpMZYf9MB5u8pqNXLhaDUhaQxX28TKdi7XtMt4dGGXlJLLYTXA5aUPoRfO
         TAdpHf851Em7jYbSwLPKk7aHaPAGol3Zq8l7qqsZsoiIillKl6GuZVVkYjPJvdYo8/mM
         qC7Lp8eFaR5WkT4Ix7OhUMiTokQwH3xjqtGq2kkS0My+DZSeM5nh3o44mNlutqL/Ux40
         lArq96+YUuCfKnC8ZPdkenXoMHGKsyWiELMzShv49DjFcaYul9IWRtnOtDx3FJARNPvr
         qXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tL4rOK1UkDlX/9Yu+VMh1Dtk/a2F/k21pomxslOU8EE=;
        b=q8inAEHs6IPeBK7SWBLjz2BSSOF/hYfeeKydHBayU15jEdeQnCb20q9plNXOIqnX2O
         WbHBCAcsADjPPcFWBo4nlkTCKx7jEgAQDCVIPCirs25lio/DXfdUqUm82PI7wAKfyJXO
         5O8X2mDGB0kLOAdMNOoqRBYmckS1YlruZnMgIomblnjoVm+fXwDA48yZPcafpPqx5ZJp
         JF9pnbljH5xlvXE0EjNahn+HZFXbh3DNUstfT7XZMKgQ4eBOrRIQhCPkmHbH5TfBv1NL
         QVPs5/LO/KSIXzi09sQLMCJdiqzIL6Pvwsop8d5MbC0R/Ks8KbFPmGcRANKR8UHrrWWP
         8fZw==
X-Gm-Message-State: AOAM5300dcf9r4T0P3M6Y/6vMzQnQU7lh0jum3r74OtmaGj9O0bDcEPE
        CeEa0vUI2ESGNcz3mUXk6gL+dv0K55GwoA==
X-Google-Smtp-Source: ABdhPJwzI4WByhxOW2UK+roXAy4uhTN7SH0Wsyv4UyT9KMf/BYNwagxz9nTdHFyk2g1TfjGV7rSA+g==
X-Received: by 2002:ae9:f50d:: with SMTP id o13mr5506864qkg.488.1618518821053;
        Thu, 15 Apr 2021 13:33:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c27sm2763469qko.71.2021.04.15.13.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:33:40 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/3] Create secil2tree to write CIL AST
Date:   Thu, 15 Apr 2021 16:33:29 -0400
Message-Id: <20210415203332.191302-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For debugging purposes it would be useful to be able to write out
the CIL AST at various points in the build process.

This patch set creates secil2tree which can write the CIL parse tree,
the CIL AST after the build phase, or the CIL AST after the resolve
phase (with names fully-qualified).

Within CIL the function cil_print_tree() has existed from early in
CIL's development, but it was not exported in libsepol and there was no
way to use it except by adding a call to it where you wanted to print
out the CIL AST and then recompiling everything. It also used cil_log()
as its output, so other messages could be mixed in with the output. This
patch set moves all of this code to its own file, updates it, renames it
as cil_write_ast(), and adds libsepol functions that can be used to call
it after each one of the phases mentioned above.

Both the parse and build CIL AST are valid CIL policies that can be
compiled with secilc, but the resolve CIL AST is not always a valid CIL
policy. The biggest problem is that fully-qualified names can contain
dots and CIL does not allow dots in declaration names. There are other
problems as well. It would be nice to get to the point where the output
for all of the trees are valid CIL, but that is a goal for the future.

James Carter (3):
  libsepol/cil: Create functions to write the CIL AST
  libsepol/cil: Add functions to make use of cil_write_ast()
  secilc: Create the new program called secil2tree to write out CIL AST

 libsepol/cil/include/cil/cil.h   |    3 +
 libsepol/cil/src/cil.c           |   92 ++
 libsepol/cil/src/cil_tree.c      | 1471 ----------------------------
 libsepol/cil/src/cil_tree.h      |    2 -
 libsepol/cil/src/cil_write_ast.c | 1558 ++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_write_ast.h |   47 +
 libsepol/src/libsepol.map.in     |    3 +
 secilc/.gitignore                |    2 +
 secilc/Makefile                  |   20 +-
 secilc/secil2tree.8.xml          |   81 ++
 secilc/secil2tree.c              |  206 ++++
 11 files changed, 2010 insertions(+), 1475 deletions(-)
 create mode 100644 libsepol/cil/src/cil_write_ast.c
 create mode 100644 libsepol/cil/src/cil_write_ast.h
 create mode 100644 secilc/secil2tree.8.xml
 create mode 100644 secilc/secil2tree.c

-- 
2.26.3

