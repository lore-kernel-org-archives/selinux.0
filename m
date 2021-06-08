Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D45C47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05929610A2
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhFHQBO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFHQBN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD52AC061574
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ba2so23376015edb.2
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0cjQsxG0pkMqJ9jOeiXTHxjyIBAZkz9JQ/5Kdnizz4=;
        b=ooMzAu+g9gxS1RZtp3pmLXx8nwSlAwg2KNtFgQYKp3BusPo+9k5OPdqy5RrxmCmWgy
         m9CISrlc3xoaCMpREnBmU1lKM+xjCaIpCmCw+CuBcK+nawIKhzzwmEu0BomWrT/gZ5RD
         GeZxP/Bwl2HO4n459ZB2TxRZfa5SaYd0KbHx1SgEPt83i1JuYZaDtozo0Oxw8mHZB+Oj
         oV8rm+eM2QJOxXS51FaHholHV0Vnkmn87B9AWG1lGvxogiA+AXDWMtSdsstXgIVbkRqN
         Qb9SFvU5rR+RDbE9oMYniQTEIzsRtOsx6geGJTeCAqAk3XoQcIGJPVdgrdLxbSxQD8V4
         44oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0cjQsxG0pkMqJ9jOeiXTHxjyIBAZkz9JQ/5Kdnizz4=;
        b=QaQp+sdOkaJZ08A0tIjWoCxIpPigqEXj9SIoSC8qvEqvKW9FaWj4IN3LxzCyasyZRK
         0FLkoftbZG5Vch9ElZbOvaaqpNRaRzIQjre9klXEGh1IIstvznUXoV7OWRIsfchUVdYP
         1JupIvA/zLQJuc+TYkshQLQAThxY3nMkKYx4LU1tcQ1AfIKNOcNtFVwfDaaLmY/LjauS
         m2KKDBODLipqKiTZYnCqpB5FU/9CpryTyE9mGAFR78ng+kDcJFQ7dCwDYPpyCMsY5V+r
         KVrhYwhaC5eeSCdRy8MJdWhxteoVTt8XwFAXtXpdTe8Q1IyQ4S4KvTF7xq04qnfcFplq
         I9/g==
X-Gm-Message-State: AOAM5333qJIBGUvIoXuX+xGxgf0x7cny8taxWAg2eBhem7a073Yt+cXL
        BKp/nJqiZx5fV0WnM0u/TJCi0Y2GB8E=
X-Google-Smtp-Source: ABdhPJwqQ/ZsZuE4T7gwd2DXAeXGqZApTng6plpFFxsoe1Z4YWrJd1ni6gRcDThOVt0B1yB9GbvN+g==
X-Received: by 2002:a50:fa8c:: with SMTP id w12mr26358466edr.350.1623167959321;
        Tue, 08 Jun 2021 08:59:19 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 00/23] libsepol: miscellaneous cleanup
Date:   Tue,  8 Jun 2021 17:58:49 +0200
Message-Id: <20210608155912.32047-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clean up several code smells, compiler warnings, static analyzer issues
and UBSAN findings in libsepol.

Also declare local functions and variables static and some interface
parameters const to improve maintainability.

Christian Göttsche (23):
  libsepol: fix typos
  libsepol: resolve missing prototypes
  libsepol: remove unused functions
  libsepol: ignore UBSAN false-positives
  libsepol: avoid implicit conversions
  libsepol: avoid unsigned integer overflow
  libsepol: follow declaration-after-statement
  libsepol/cil: follow declaration-after-statement
  libsepol: remove dead stores
  libsepol: mark read-only parameters of ebitmap interfaces const
  libsepol: mark read-only parameters of type_set_ interfaces const
  libsepol: do not allocate memory of size 0
  libsepol: assure string NUL-termination
  libsepol: remove dead stores
  libsepol/cil: silence cast warning
  libsepol/cil: drop extra semicolon
  libsepol/cil: drop dead store
  libsepol/cil: drop unnecessary casts
  libsepol/cil: avoid using maybe uninitialized variables
  libsepol: drop repeated semicolons
  libsepol: drop unnecessary casts
  libsepol: declare file local variable static
  libsepol: declare read-only arrays const

 libsepol/cil/src/cil_binary.c                 |  19 +--
 libsepol/cil/src/cil_build_ast.c              |   9 +-
 libsepol/cil/src/cil_fqn.c                    |   3 +-
 libsepol/cil/src/cil_list.c                   |   7 +-
 libsepol/cil/src/cil_post.c                   |   2 +-
 libsepol/cil/src/cil_resolve_ast.c            |   8 +-
 libsepol/cil/src/cil_strpool.c                |  16 +--
 libsepol/cil/src/cil_write_ast.c              |   4 +-
 libsepol/include/sepol/policydb/conditional.h |   2 +-
 libsepol/include/sepol/policydb/ebitmap.h     |  16 +--
 libsepol/include/sepol/policydb/policydb.h    |   6 +-
 libsepol/src/assertion.c                      |   2 +-
 libsepol/src/avrule_block.c                   |   2 +-
 libsepol/src/avtab.c                          |   8 +-
 libsepol/src/booleans.c                       |   6 +-
 libsepol/src/conditional.c                    |   3 -
 libsepol/src/context_internal.h               |   1 +
 libsepol/src/debug.c                          |   2 +-
 libsepol/src/ebitmap.c                        |  29 +++--
 libsepol/src/expand.c                         |   8 +-
 libsepol/src/ibendport_record.c               |   4 +-
 libsepol/src/kernel_to_cil.c                  |   7 +-
 libsepol/src/kernel_to_conf.c                 |   5 +-
 libsepol/src/link.c                           |   2 +-
 libsepol/src/module.c                         |   2 +-
 libsepol/src/module_to_cil.c                  |  14 +-
 libsepol/src/nodes.c                          |   6 +-
 libsepol/src/polcaps.c                        |   2 +-
 libsepol/src/policydb.c                       |  70 +++++-----
 libsepol/src/policydb_internal.h              |   2 +-
 libsepol/src/policydb_validate.c              |   2 +-
 libsepol/src/private.h                        |   6 +-
 libsepol/src/services.c                       | 120 ++++++------------
 libsepol/src/sidtab.c                         |  31 -----
 libsepol/src/symtab.c                         |   6 +
 libsepol/src/util.c                           |   2 +-
 libsepol/src/write.c                          |   8 +-
 37 files changed, 187 insertions(+), 255 deletions(-)

-- 
2.32.0

