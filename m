Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AFDC433B4
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D9761103
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhDHTQe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhDHTQd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34267C061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:22 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v70so3401254qkb.8
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XB0XuAPaRpqWnSNxtRc0h3FB7+OTtP9LOGXj2P3Dzqc=;
        b=Cf5LebxONkW6witW3wrxfhEgLuiyjM3qRzErHtptCyYO5K0bIkUH9v9e4/JGBLXwX/
         8EoHjCF+BETeVDFP3jXlFCZ7oC7CklNNkSiaOd0LSa4TZXcFkgDDB1GkETE6J6qEIX7X
         fAbXkIyAJZ1qUF7FVYf8C2tCGNoi1WeG3wgKkggwHMkLx6EevKn0sv6dciN2bQ3sprV3
         NUjiQ3XayP6YKYx13x6Fwa0Or2dM9q7HXyDIE34IfzleB0N9aMRw1fbRmJDj/CXH3juM
         nud4UGxZgyrfZKsHKWqi+2wf18qjzk92I7j17mf4ovpc2heHASKqW57J+BKmYBEmYNu/
         MbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XB0XuAPaRpqWnSNxtRc0h3FB7+OTtP9LOGXj2P3Dzqc=;
        b=KsKvY7C+qriZlxI/gfQ+mf4hycPnmSyoWt/Q1uj9nU3zi8muwmNOiBY1DYcwY9TEGl
         a1AOknHzsWuIqNjHuvlRiW4d+8mhx9jgAGsn7JZP5ELs9Vv8BX5qNUie2ubKXqZQLSgG
         r9T/BbaEgpZJP0tFS/Ij4LBwAQyvkfwcgUgqG952lDa2kp3PdBQjiyD2tCNlFQIX4r12
         XvIyhp0jYZrMv8+Sr0hM/4sjIVrqiOlJFL6OKSspPEZuyXYDQxKcANzqcD63x/Sba51O
         YMAZyoFORGhYR6bShe0aSjHn5wypxot0ltiVsinoLEZLzDYtO8Itf+7rKC2QkjMP0C8l
         4mZQ==
X-Gm-Message-State: AOAM5328x1n2R58QZ0jnfRhSmD4/q74bte8p7UksiheOmOKigwS5+wsq
        w6rCIfv4kc7YQhoUE6BZ7AABVy/sTsfvyQ==
X-Google-Smtp-Source: ABdhPJzIDO/BDewcHLJ+6LYibPXFd4EspalDYVPGcWPsaoKkIHgchdhdgd8r8iINWM+ln/7wPYCl/g==
X-Received: by 2002:a37:66cd:: with SMTP id a196mr10432383qkc.374.1617909381348;
        Thu, 08 Apr 2021 12:16:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:20 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 00/11] Various CIL patches
Date:   Thu,  8 Apr 2021 15:16:03 -0400
Message-Id: <20210408191614.262173-1-jwcart2@gmail.com>
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

