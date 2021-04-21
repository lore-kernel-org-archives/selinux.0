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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D094FC433B4
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D8E61440
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 17:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbhDURVu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhDURVu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 13:21:50 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1100C06174A
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 10:21:16 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id gv2so11392820qvb.8
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4crirPQyi/8fFoSCINNQyNR2RVInRdCCA39bMX/Sk4=;
        b=SQw57ManoLy3dmcG/O7xdVLPkglzAWtsEWI51nQRod8nT40IEbwWqjROmJyacvvVqV
         UX3VHgf7juiUynvgt1Iddwc/cthXnTYu0I83Ra/w95wqMsOA7qGLxtvDnWzwJhtVtIPZ
         a3hOyj9534JxWtDb0yOLyfe8b6HmrOhKesXlLBmyJior9dKCF6S9u93OyFzMSoV+IxiD
         dUy9Yssu1hENTDFBf2PPZ6qYkNqx59c73t7bNjhPg320Kd2lTqW5nVhmiAKqQQvIw3ec
         aaGVx++efrsqHtCACGs2L1v01PWrBrF7rzHxIfss2OrZwCNp4cks+76AF6w0IcgiSgzM
         OI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4crirPQyi/8fFoSCINNQyNR2RVInRdCCA39bMX/Sk4=;
        b=G2a4hiH5451PTJwSvioNYNtbOA7C21zxKeQvpxG23OaCFSSEkbcsbW9bFHR3iUEeL+
         ubn/Q9C/2PHt4qOjT5rS49b2sj7oArxvzIIsrrqqEG8gKpYCq5Y5WOEE5a35PKHhYN6C
         lBBKiwfGuEKBTrEbT1TMTy2YQV+f3FVSxFT4lJ6B2EqBnlD0KkSIcqZFWCS0OKkuDP1U
         sY2oNJkRIDTB5sKE3wUK+cnSRAKOsu9NKl9EHjcti5pyyUZkcaRiY7ea1QHlvP+0w8Zn
         9rlD+elRfvosWg3Gk62AIMrWw02qC8xcTh67+4zidy6PS+UW3+7nRIaI7bmUywy+CEQn
         YHIA==
X-Gm-Message-State: AOAM531W83CGYkJpzFSPQMbLBOLF6YowKR5rCZrdZz3jL9Zrwf4+GmW7
        OwWsg4jzxc3pEc0wi/kOvdF1snWuEA0EHw==
X-Google-Smtp-Source: ABdhPJy4IOuywhHNToTmDSzwezyZ5iRbMCQdQDY6TJeBQsxlVRSAwUvXdS9bURl2tA58hjQt5A4agw==
X-Received: by 2002:a05:6214:962:: with SMTP id do2mr9237423qvb.1.1619025676021;
        Wed, 21 Apr 2021 10:21:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r25sm143051qtm.18.2021.04.21.10.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:21:15 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/3 v3] Create secil2tree to write CIL AST
Date:   Wed, 21 Apr 2021 13:21:09 -0400
Message-Id: <20210421172112.13277-1-jwcart2@gmail.com>
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

v3:
- -use "-ast-phase=<phase>" in the usage message and man pages instead
of "-ast-phase <phase>"

v2:
- Remove whitespace errors in cil_write_ast.h
- Use "const char*" instead of just "char*" when dealing with string
literals to satisfy clang.

James Carter (3):
  libsepol/cil: Create functions to write the CIL AST
  libsepol/cil: Add functions to make use of cil_write_ast()
  secilc: Create the new program called secil2tree to write out CIL AST

 libsepol/cil/include/cil/cil.h   |    3 +
 libsepol/cil/src/cil.c           |   92 ++
 libsepol/cil/src/cil_tree.c      | 1471 ----------------------------
 libsepol/cil/src/cil_tree.h      |    2 -
 libsepol/cil/src/cil_write_ast.c | 1573 ++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_write_ast.h |   46 +
 libsepol/src/libsepol.map.in     |    3 +
 secilc/.gitignore                |    2 +
 secilc/Makefile                  |   20 +-
 secilc/secil2tree.8.xml          |   81 ++
 secilc/secil2tree.c              |  206 ++++
 11 files changed, 2024 insertions(+), 1475 deletions(-)
 create mode 100644 libsepol/cil/src/cil_write_ast.c
 create mode 100644 libsepol/cil/src/cil_write_ast.h
 create mode 100644 secilc/secil2tree.8.xml
 create mode 100644 secilc/secil2tree.c

-- 
2.26.3

