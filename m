Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8DDC001B0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 21:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjHIVCD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHIVCC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 17:02:02 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429961724
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 14:02:02 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76d072daea2so19141985a.1
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691614921; x=1692219721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zw80kIIqHRocmqrLdMxZvb+tL5fEl1948rPKHXd9K7s=;
        b=Q1XRj6hXzAoU9hMv3uU79Wlnc6deUJlFblc6wsyV5bFmIXsEfFrxJ/W6r79nTpLtWQ
         QxX1OHwvxj8GuaKL3NZyhNmlgk96XKpMvO6KGPBPgvKRcJu8r584Tg8BnHpHpIOBJfPr
         rXRwMNnrWLm46hY3Hj7/8qe2DceVIZQ80UyvvoyhkED+X/FSwBmkrpvWRLqzKjoDx8Od
         6vSfjUUA0xkXijcAaxzTMYfhhWGqn7CX2WTZgG5gw7f4rOXkL+QhQb61TzjPAQKr0oW/
         1az0uTSP1T82lGlprLhfDnL4+AMtJugrJYbm/fpvkPacyUfSEdHlCGzNdmFWmzMnu3wW
         tJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614921; x=1692219721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zw80kIIqHRocmqrLdMxZvb+tL5fEl1948rPKHXd9K7s=;
        b=PSNxzucAjLwNZyrOPAQQ7wMkQZLZGYubd7EQGgToABbxty+U3DaVaCt+h7itiIA6hK
         dLzJDNQlgYS4bgM8nZ+9tglDa2CTaiDhcUPIlioHW73TZ6f+U5RtDEVhSJ9ZaRw8/YQc
         b5/6BQRWS3dtKy3u1ARJVr6zYLoz4CyxopFOYYrqb1L6vKaPD560xxl375K0kfXnBLPD
         o1GDmRMnC2fWyNniYMjd7W8PsLZDd7fFccKtJAOCkU7sv5uYlMuzvnAKWsioLG4zw9Jt
         swEo1O/XYtOl6EnlkrouscwlQgdwa+5JKwcdnULGbVCx2dtJM7fLMoLmrtgZm/y2OKi9
         8HFg==
X-Gm-Message-State: AOJu0YyuSP3K8qDA21OcDfLUNzfu4L17P94nDTfd2u8ge41Xgq1Kpn25
        JOj6CkbAEFqj2QMOJ0KDuxEoOxlzybE=
X-Google-Smtp-Source: AGHT+IFXvtdpNJ7+CdolB91wtbAwzWo5Hf+oLsx3P3t6gvzQEXq6aoZOr4+DlnjUPcZoCsDdPX3Ytg==
X-Received: by 2002:a05:620a:4108:b0:767:f1de:293c with SMTP id j8-20020a05620a410800b00767f1de293cmr216642qko.59.1691614920916;
        Wed, 09 Aug 2023 14:02:00 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm4208287qkk.132.2023.08.09.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:02:00 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/9 v4] Add CIL Deny Rule
Date:   Wed,  9 Aug 2023 17:01:48 -0400
Message-ID: <20230809210157.112275-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch series depends on the "Add support for notself and other to
CIL" patch series from August 9th

These patches add a deny rule to CIL. Deny rules will be processed after
everything except for neverallow rules. Unlike neverallow rules, they
remove the permissions in the deny rule rather than reporting an error.

See the individual patches for an explanation of what they do.

Patches 1-8 are unchanged from v3, see:
https://lore.kernel.org/selinux/20230413193445.588395-1-jwcart2@gmail.com/

Previously, patch 9, as Daniel Burgener noted, did not do what it said it
was going to do. Now it does.

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
 secilc/docs/cil_access_vector_rules.md |   41 +-
 secilc/secil2tree.c                    |    8 +-
 secilc/test/deny_rule_test1.cil        |  580 ++++++++++
 secilc/test/deny_rule_test2.cil        |  418 +++++++
 25 files changed, 2780 insertions(+), 2 deletions(-)
 create mode 100644 libsepol/cil/src/cil_deny.c
 create mode 100644 libsepol/cil/src/cil_deny.h
 create mode 100644 secilc/test/deny_rule_test1.cil
 create mode 100644 secilc/test/deny_rule_test2.cil

-- 
2.41.0

