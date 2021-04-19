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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FEEC433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B806D61157
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbhDSP2Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhDSP2Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:28:24 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDECC06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:27:54 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y136so4054490qkb.1
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+WPeU4vz01u/YtlHbzZm8Pukmp9EFFXLPjUbjMUZmOA=;
        b=JYjZlWyn4tUx6IA3PvxiuaiZzW3BdCkJl2xlqrz+vRTbF2+xo0ACtV9nxIMU3daGVG
         UwigzCaWcHmH222dD3rJE76HffaZhfDTik62Utih2juG8x0CkIpete7Iz7HrCt5hEKQs
         v5rlEQosFsG9M9NknHA0stCCvCRi7rV23q6uUa0vRYNWCmULkhF3UuY8Mb5KAaJMlOsJ
         ddm2cZ3rpfacREW0/a+rdLdWG5PhBDAkjCuykHROnUvjxizrEnxt9C62ILKR8yqAMjpr
         bKboNbXigh3pYtYyWwg89OoZJbzgtwo6GoFmV/F8igzCU5Ms3XtQOFUGeegS2E0H9YqK
         j9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+WPeU4vz01u/YtlHbzZm8Pukmp9EFFXLPjUbjMUZmOA=;
        b=kWS6glOmBX2haEkuZ+t6cswKJbb9LIMo2JyrBciEOvemHZRzO2Ica8UJhduAxgmioH
         srY6OC/cncV2O6IUHYrAIFzUJYBWUpis4VRE9SqeBmE7/HT1Uor0CvvD/hdaq+0/ZLzC
         e4D0Lm7yZExnPwcprXxQ/QQr7zo2gkAbegZJUybFa2+juyo6zX+eEEzTJI+FO1SEjR77
         9w7Gc+y9hOdC069vwYAH4ERjnaWVHW2q/r7/rIido89zpbyvwzpmecGb+UES6OMtf3VX
         K9uvR6zzo6q2Ndgq6rZ+fn+oJ2aXiuxYzBSECr2R5Ep0664VNOh7KlDGTxGPT2KIa27D
         EJSA==
X-Gm-Message-State: AOAM531zDmzYijm/5Xnh9VyCTgSE4WWCnVn8x1IQTGCM/nw5chMwcZ2e
        l7VvUQosdAWdA2W0aBqUdSLmPdc9uM43Iw==
X-Google-Smtp-Source: ABdhPJzmtP7H977R/ueTLGJ9dqQt4YnMT74n+ylvCnmUxvwt4YMVogf6tLNva+p7OWXsUKIwWYLbgw==
X-Received: by 2002:a05:620a:7d4:: with SMTP id 20mr9718638qkb.58.1618846073747;
        Mon, 19 Apr 2021 08:27:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id p23sm5959249qtl.8.2021.04.19.08.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:27:53 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/3 v2] Create secil2tree to write CIL AST
Date:   Mon, 19 Apr 2021 11:27:46 -0400
Message-Id: <20210419152749.88086-1-jwcart2@gmail.com>
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

