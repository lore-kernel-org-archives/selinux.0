Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CF8C77B61
	for <selinux@archiver.kernel.org>; Thu, 13 Apr 2023 19:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDMTex (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Apr 2023 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDMTeu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Apr 2023 15:34:50 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3C1212F
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:49 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54f6a796bd0so187871087b3.12
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681414488; x=1684006488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3SxtQzXJY3hzbf9mLS2PckiT0wxiXnsF6fW+cGpY6E=;
        b=F4Rb2AH1db5qMW1i939TnldTohkY4xjwTJKK5mADqnkH2q0HH/yy6tN9+mU2rF4GrY
         frdJ+GKcTszBBKihFtbwX91M9RVvnBRBShVHlIKuw7NoGgC4nwZQRh4cv0ezhZu0LZC6
         FzUamNtO/ihVWeu7e/TXk1kfsm46H1vExf2fcZuqeCEU3qtIdOEMlujAymAQXkjQJaOb
         jFs3r/gZB3iDO8YL4Uh3bVJs0J7Q+fdB2k6RYAHRnvaz+vOvLkv6tLmx/FHJdZJm0ZO7
         4l7D2qXfK3NeQltr0ElVtYItM2cJw2U8NwHpxwcn7uZ8EEQNK3e1Ywh5Gdmy9m2XjtSU
         6jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414488; x=1684006488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3SxtQzXJY3hzbf9mLS2PckiT0wxiXnsF6fW+cGpY6E=;
        b=cDXtaRqD8Kl0y9qFju/Lo5TS38Dl5omkBHn51pVAPY2bYlk+W/9mdQgON7CMdp1j96
         78C1buHgN2feA4Ii2vMftep6pW2cbV0GrFJiyJWlqOkqQYLaKVK2S+y3+t9nOfaXAOp7
         F1WJ0VbR9YzQppTwd/zDSmCKDQQaMDOvrQ0YdgTVKhNAZvAEDAPHY4pkdRv5K9g1m8Rd
         1ZWxKvAH6y5QCry+FcR+737jnn5HYOQ4WGNjVME839WqasWEdH9lEFb6HiqyztFWrpZE
         /u+k8KSyEbpmYOu+xbFKatPWcwCF4Gna9txTmoEXisuQXZoqBtQBUYttspgHwAabzGMd
         869Q==
X-Gm-Message-State: AAQBX9cpgTL+hJkEO9w4PRRnd316ucIpoQ7Pj2a2a5+SrcKRm+7hr9Ja
        iymhniFJlJl/BSi6TeXrVdPuvyjTmWA=
X-Google-Smtp-Source: AKy350aaPHeVGqgBPRi1jH9PlgnOTpkk5mUtXd/9oxA/6LEdDJGBVE0irdYz+FTjtoMFP1kuIsyPkg==
X-Received: by 2002:a0d:ea55:0:b0:54f:e109:7153 with SMTP id t82-20020a0dea55000000b0054fe1097153mr412848ywe.48.1681414488642;
        Thu, 13 Apr 2023 12:34:48 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id 21-20020a811615000000b0054c0f46b24bsm691350yww.5.2023.04.13.12.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:34:48 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/9 v3] Add CIL Deny Rule
Date:   Thu, 13 Apr 2023 15:34:36 -0400
Message-Id: <20230413193445.588395-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch series depends on the "Add support for notself and other to
CIL" patch series from April 12th.

These patches add a deny rule to CIL. Deny rules will be processed after
everything except for neverallow rules. Unlike neverallow rules, they
remove the permissions in the deny rule rather than reporting an error.

See the individual patches for an explanation of what they do.

Patches 2, 5, 6, and 7 are unchanged from v2. For the other patches, see
the patch for a list of the changes from v2.

James Carter (9):
  libsepol/cil: Parse and add deny rule to AST, but do not process
  libsepol/cil: Add cil_list_is_empty macro
  libsepol/cil: Add cil_tree_node_remove function
  libsepol/cil: Process deny rules
  libsepol/cil: Add cil_write_post_ast function
  libsepol: Export the cil_write_post_ast function
  secilc/secil2tree: Add option to write CIL AST after post processing
  secilc/test: Add deny rule tests
  secilc/docs: Add deny rule to CIL documentation

 libsepol/cil/include/cil/cil.h         |    1 +
 libsepol/cil/src/cil.c                 |   68 ++
 libsepol/cil/src/cil_build_ast.c       |   56 +
 libsepol/cil/src/cil_build_ast.h       |    2 +
 libsepol/cil/src/cil_copy_ast.c        |   19 +
 libsepol/cil/src/cil_copy_ast.h        |    1 +
 libsepol/cil/src/cil_deny.c            | 1413 ++++++++++++++++++++++++
 libsepol/cil/src/cil_deny.h            |   36 +
 libsepol/cil/src/cil_flavor.h          |    1 +
 libsepol/cil/src/cil_internal.h        |   10 +
 libsepol/cil/src/cil_list.h            |    3 +
 libsepol/cil/src/cil_post.c            |    7 +
 libsepol/cil/src/cil_reset_ast.c       |    8 +
 libsepol/cil/src/cil_resolve_ast.c     |   48 +
 libsepol/cil/src/cil_resolve_ast.h     |    1 +
 libsepol/cil/src/cil_tree.c            |   35 +
 libsepol/cil/src/cil_tree.h            |    1 +
 libsepol/cil/src/cil_verify.c          |    9 +
 libsepol/cil/src/cil_write_ast.c       |   10 +
 libsepol/cil/src/cil_write_ast.h       |    1 +
 libsepol/src/libsepol.map.in           |    5 +
 secilc/docs/cil_access_vector_rules.md |   67 ++
 secilc/secil2tree.c                    |    8 +-
 secilc/test/deny_rule_test1.cil        |  580 ++++++++++
 secilc/test/deny_rule_test2.cil        |  418 +++++++
 25 files changed, 2807 insertions(+), 1 deletion(-)
 create mode 100644 libsepol/cil/src/cil_deny.c
 create mode 100644 libsepol/cil/src/cil_deny.h
 create mode 100644 secilc/test/deny_rule_test1.cil
 create mode 100644 secilc/test/deny_rule_test2.cil

-- 
2.39.2

