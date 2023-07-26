Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8EBC0015E
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 14:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGZOZ4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjGZOZz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 10:25:55 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED5F196
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:54 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-635f293884cso42685946d6.3
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381553; x=1690986353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EELDVhBJO/SIole/+SGRAC7v0ytSbR3SPdVuwPxz9nM=;
        b=KPDLkgqjzRXTx2sLFMnqM5MEvY9AmuEUgIFc5Wg0Qql4fPPDwsr+aKzSOXmR6TC3C1
         /He6S4kEVC2urANUqv3/wKOa7PQcwilgQDY1rKQ0TnjPxIYY/WHKQRqfZhrmIGNF/+Ls
         ocUTzpaNIIED+7iuaJDjghhkS3nIbBuR+1yYAwiguJ48e+/mMRdfCj6PDUiixW+53n5W
         Q1+/X92AJ+9jWsERAUtvQynbIY2pAms2B9IG1Xm1vRBY6HLnT/4fsTBjXmB6DjEnXrRR
         XWcVesC3ylRPs+d0md/66qtne9ciX14xeaduyxZitWMSOfw2mnwTmW9bYK1Jl++X2YHL
         7QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381553; x=1690986353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EELDVhBJO/SIole/+SGRAC7v0ytSbR3SPdVuwPxz9nM=;
        b=JmcFTDXYA+HN0VOLYakMKUlJ3nGsgaE4yY3NYsJnYNXBmudsMYL8dhoQYdPrjzwmul
         5nX/4YXz8365/ZZMztgpJaHTZl3XhIsmDWE/fiDw1AcjYLjJvqXhRGRAPni5NnJzm2AP
         SmJJfPOu7QzZkY1XLTXZ+GCru6m3X4e92MWzbuEO2w84G97Zwl4TygMY5Y31hadHMhtp
         NEoSZw3uFCQjisoP0HxMlIG4snsOrjTMcyV8nuY8uQf2T5zCRnDRcYeSYvEElwo6Ev+c
         SjjiRnOktzdx56/LxulZLhcRrl7433bo2c0S120JKUW6TzZvnEJIUAWnP2/drLDePF2x
         na1g==
X-Gm-Message-State: ABy/qLZd/CHgq/hlfgTeKUEtr9lu0MjLa+vEzjXuhLFSObHXKpXcnkZa
        284oOJF63554vI75cS9zqZVql2u//DAqgA==
X-Google-Smtp-Source: APBJJlG8cpxBv0+wBdfTyJTx2JACUN8qoK+Tghp/KELNQqCFLOeVqgR7fRu+Hh+HI4ESRmFJlK2mIQ==
X-Received: by 2002:a0c:f006:0:b0:63d:e3:414a with SMTP id z6-20020a0cf006000000b0063d00e3414amr1918761qvk.25.1690381553313;
        Wed, 26 Jul 2023 07:25:53 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cf014000000b006362d4eeb6esm5066471qvk.144.2023.07.26.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:25:52 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/8] Revert the prefix/suffix filename transition patches
Date:   Wed, 26 Jul 2023 10:25:41 -0400
Message-ID: <20230726142549.94685-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since the kernel patches have not been accepted yet, it seems better to
revert these patches while they can still be cleanly reverted just in
case the kernel patches are not accepted.

If the kernel patches get accepted, then I will re-apply these patches.

I should have waited for the kernel patches to be accepted before committing
these in the first place.

James Carter (8):
  Revert "libsepol/cil: add support for prefix/suffix filename
    transtions to CIL"
  Revert "checkpolicy,libsepol: add prefix/suffix support to module
    policy"
  Revert "checkpolicy,libsepol: add prefix/suffix support to kernel
    policy"
  Revert "libsepol: implement new module binary format of avrule"
  Revert "libsepol: implement new kernel binary format for avtab"
  Revert "checkpolicy,libsepol: move filename transition rules to
    avrule"
  Revert "checkpolicy,libsepol: move filename transitions to avtab"
  Revert "checkpolicy,libsepol: move transition to separate structure in
    avtab"

 checkpolicy/checkmodule.c                  |   9 -
 checkpolicy/module_compiler.c              |  12 +
 checkpolicy/module_compiler.h              |   1 +
 checkpolicy/policy_define.c                | 211 +++++-
 checkpolicy/policy_define.h                |   3 +-
 checkpolicy/policy_parse.y                 |  13 +-
 checkpolicy/policy_scan.l                  |   4 -
 checkpolicy/test/dismod.c                  |  39 +-
 checkpolicy/test/dispol.c                  | 106 ++-
 libsepol/cil/src/cil.c                     |   6 -
 libsepol/cil/src/cil_binary.c              |  63 +-
 libsepol/cil/src/cil_build_ast.c           |  26 +-
 libsepol/cil/src/cil_copy_ast.c            |   1 -
 libsepol/cil/src/cil_internal.h            |   4 -
 libsepol/cil/src/cil_policy.c              |  17 +-
 libsepol/cil/src/cil_resolve_ast.c         |  10 -
 libsepol/cil/src/cil_write_ast.c           |   2 -
 libsepol/include/sepol/policydb/avtab.h    |  19 +-
 libsepol/include/sepol/policydb/hashtab.h  |   8 -
 libsepol/include/sepol/policydb/policydb.h |  50 +-
 libsepol/src/avrule_block.c                |   1 +
 libsepol/src/avtab.c                       | 338 +---------
 libsepol/src/conditional.c                 |   6 +-
 libsepol/src/expand.c                      | 153 +++--
 libsepol/src/kernel_to_cil.c               | 182 +++--
 libsepol/src/kernel_to_common.h            |  10 -
 libsepol/src/kernel_to_conf.c              | 178 +++--
 libsepol/src/link.c                        |  57 +-
 libsepol/src/module_to_cil.c               |  86 ++-
 libsepol/src/optimize.c                    |   8 -
 libsepol/src/policydb.c                    | 479 +++++++++++---
 libsepol/src/policydb_validate.c           | 101 ++-
 libsepol/src/services.c                    |   5 +-
 libsepol/src/write.c                       | 735 +++++----------------
 34 files changed, 1390 insertions(+), 1553 deletions(-)

-- 
2.41.0

