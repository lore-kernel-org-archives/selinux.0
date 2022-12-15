Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBCCC4332F
	for <selinux@archiver.kernel.org>; Thu, 15 Dec 2022 21:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLOVej (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLOVei (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Dec 2022 16:34:38 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197021C437
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:38 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id u10so357460qvp.4
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8aCn4zSQtLtE3OrjEiYgRX+R0VGMiALs5ZCjBvXB7Q=;
        b=qRiaEa8ihmtrOjJGMk7hpN0iungBEfJ8FGC7mIKBPnN/gW3+Seewghdio15W5TIPGv
         lRlUWCh2mQc78nSksW6LaWY0BpZcXRn5flRjGGzzNC2dm7SmSEpAFmsFXDlNu+xaCHzi
         kjp/RqcyYTFqaheH1KrC8u/C3ivRR8vyK4FvI7LTjqD8E0YaHBPRrni6KLsjzmydx70M
         LMcG4s4Lnb/94lLbIOz2kNOke/lAnVIzHEcuR8Uovl2AGtztwmRKOgzmvMljwiUjYpAg
         Xs46i026g+vMSaIYsg7cuBi154G2pTdwIB+gO+aNiuyVaFqE+9lcWtWfCb+P5iZmHmzu
         wK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8aCn4zSQtLtE3OrjEiYgRX+R0VGMiALs5ZCjBvXB7Q=;
        b=4iPnSB+9mGjhmyVDDByPshGvGdw1/3A0Le7AdoKuLQqIniKJxtcw3DFkAZ9eIXeJeo
         5vgXl+mnIbc7OBSzmenSRjN908tOpZvktSIwt2v0kCE+ZIe4gqZyg7LrYd89h4dx1NBJ
         ccft8EgKhMX5X+FLCMzHmeguRGtnt5Fkswr0HsIaPYLymxqlepNDuA1lf9gZTCW/2J9b
         iTy2269o5C7GKNmsqLtAJQrd01KwnJZb5rejeIqNTKWdjyAVmBV8IsWirYDqGxNkmCxA
         sFZV5N2lgMlJAhBlwtCgkKWah9UAjc6yjnHqgOqfSebxqUPRZnk1kmckB/7ERwW2YzbF
         KpHg==
X-Gm-Message-State: ANoB5pmcYQrMfuvzCKF9UdRJluAm959bfAd0PUyYkDEDvFrM8P/bnB3g
        nncA34msb2AqldE+4Kt/t8ojPv8Y76o=
X-Google-Smtp-Source: AA0mqf4Px4wPFZPB/6pFPENUY66UNlqfoBTO8N164FrQxOIsDoH13k1gkf6grNzpGDG7jQwZq2uW3A==
X-Received: by 2002:ad4:4e22:0:b0:4c7:5df:27b7 with SMTP id dm2-20020ad44e22000000b004c705df27b7mr39757704qvb.13.1671140076810;
        Thu, 15 Dec 2022 13:34:36 -0800 (PST)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b006a6ebde4799sm21066qko.90.2022.12.15.13.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:34:36 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 0/9] Add CIL Deny Rule
Date:   Thu, 15 Dec 2022 16:34:20 -0500
Message-Id: <20221215213429.998948-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I don't expect this to be part of the upcoming userspace release,
but I did want to see if this is going to be what Cascade needs.

This series of patches implements a deny rule in CIL. A deny rule will remove
the stated permissions in it from the policy. CIL does this by searching for
allow rules that match the deny rule and then writing new allow rules that
correspond to the matched allow rule with the permissions from the deny rule
removed. The rule uses the same syntax as an allow rule, but with "deny"
instead of "allow".

  (deny SRC TGT (CLASS (PERMS)))

Deny rules are processed during post processing (after the AST is resolved,
but before the binary policy is written). This means that neverallow checking
is done after deny rules are resolved. Deny rules are complimentary to
neverallow checking. When an allow rule is found that matches, a deny rule
removes permissions while a neverallow rule reports an error.

Patch 4 is biggest and most complex since it is the one doing the processing.

James Carter (9):
  libsepol/cil: Parse and add deny rule to AST, but do not process
  libsepol/cil: Add cil_list_is_empty macro
  libsepol/cil: Add cil_tree_remove_node function
  libsepol/cil: Process deny rules
  libsepol/cil: Add cil_write_post_ast function
  libsepol: Export the cil_write_post_ast function
  secilc/secil2tree: Add option to write CIL AST after post processing
  secilc/test: Add a deny rule test
  secilc/docs: Add deny rule to CIL documentation

 libsepol/cil/include/cil/cil.h         |   1 +
 libsepol/cil/src/cil.c                 |  68 ++
 libsepol/cil/src/cil_build_ast.c       |  56 ++
 libsepol/cil/src/cil_build_ast.h       |   2 +
 libsepol/cil/src/cil_copy_ast.c        |  19 +
 libsepol/cil/src/cil_copy_ast.h        |   1 +
 libsepol/cil/src/cil_deny.c            | 957 +++++++++++++++++++++++++
 libsepol/cil/src/cil_deny.h            |  34 +
 libsepol/cil/src/cil_flavor.h          |   1 +
 libsepol/cil/src/cil_internal.h        |  10 +
 libsepol/cil/src/cil_list.h            |   3 +
 libsepol/cil/src/cil_post.c            |   7 +
 libsepol/cil/src/cil_reset_ast.c       |   8 +
 libsepol/cil/src/cil_resolve_ast.c     |  44 ++
 libsepol/cil/src/cil_resolve_ast.h     |   1 +
 libsepol/cil/src/cil_tree.c            |  27 +
 libsepol/cil/src/cil_tree.h            |   1 +
 libsepol/cil/src/cil_verify.c          |   9 +
 libsepol/cil/src/cil_write_ast.c       |  10 +
 libsepol/cil/src/cil_write_ast.h       |   1 +
 libsepol/src/libsepol.map.in           |   5 +
 secilc/docs/cil_access_vector_rules.md |  68 ++
 secilc/secil2tree.c                    |   8 +-
 secilc/test/deny_rule_test.cil         | 384 ++++++++++
 24 files changed, 1724 insertions(+), 1 deletion(-)
 create mode 100644 libsepol/cil/src/cil_deny.c
 create mode 100644 libsepol/cil/src/cil_deny.h
 create mode 100644 secilc/test/deny_rule_test.cil

-- 
2.38.1

