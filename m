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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20F5C433C1
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFF361953
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhC3RkB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhC3Rj2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B38C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:27 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g20so16700140qkk.1
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ech7HsHonbPixWe1neyIZhWoNSlCZjCrFz7eGNgoeZs=;
        b=aNRnoZ91xtht3pAkUlimytup54EwgeJImZ59Ky81ienKWcggF20Pvq85m/WcJ8qDnr
         BrC7CzALAdpYQn7Y8Mim9CdPLhwwBLvDT6L/XGjz2cKHaaQmelPsYWGaTLIE7nub/HF8
         cCjhaEL1tDXqVrv1WAw8/KNamVLDj8vD3m72+kHCI9bcOMV5wR4ZpfzPqhXYwioKjxSo
         rsPZW+THBVV4D+KcVhtKI6g9+7fVeSEOG23oP1pPXwtgwm/kGRU9w+Sj51VmNQzUfssp
         HahyHm5M5tiQmIyZAh1SjCVO7LU6ygayj0j4IjHaGOqeiHzbU/PwzNtdAjWZUf7lAmb8
         UYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ech7HsHonbPixWe1neyIZhWoNSlCZjCrFz7eGNgoeZs=;
        b=eY5wwISmdal8WDzMd+/KZ6GMia3PZoz6uOvokkebVfz8SF0yBFPB2JCny/RxA2P2D0
         p0xnR4BQP8okjwePlBGB7a1gVx4DAiaVHISPNUnpScpfdsO4xPlo4WQEr3lzVtX8xAmh
         07vWxcRBJtoMzvYLZWagLoJlz6puedOtJCzfjAOowrixw4ORaGEy0aCNk2MIRfatySMO
         j84WJb45+OClht1eBB4lUAXg8pc1w99QrjGf1zK47UHFam7GUFgp92lv2UCFxfdu4hSi
         JMBTjzfuYI8hok0koSqdJQsd96LhAVbbEbYwzNc79OcUr02eyzL9tHHl88+3EXQ665xa
         EQ4g==
X-Gm-Message-State: AOAM533cqqGJ2SPWU9x31RYYD4I4ZwWdXRiku9jUORUqhbLotyWQn/Q8
        L9bW9vV6U+DLDn9uNjDKg+7Ce9MZB2PomA==
X-Google-Smtp-Source: ABdhPJxh4QxNvUrtlWrMJCp1WExXWNqwCKG+WT7eqgVay33VC7xhACjSPep10t4zLa4j886VrQma8w==
X-Received: by 2002:a37:4396:: with SMTP id q144mr30212649qka.441.1617125966931;
        Tue, 30 Mar 2021 10:39:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:26 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 00/12] Update checks for invalid rules in blocks
Date:   Tue, 30 Mar 2021 13:39:11 -0400
Message-Id: <20210330173920.281531-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Looking into a bug that OSS-Fuzz found led to patch 7, Check for
statements not allowed in optional blocks, which is the most important
patch in this series. Working on patch 7 led to fixing some other
problems with the checks for invalid rules, cleaning up some of the code,
and improving the CIL documentation.

Patches 1, 2, 4, 5, and 10 are doing various cleanups.
Patch 3 fixes a bug that prevents the first rule in a block from being checked.
Patches 6, 7, 8, and 9 update the checks for invalid rules.
Patch 11 fixes a bug that prevented some error messages from being displayed.
Patch 12 updates the CIL documentation.

There is still work to do in this area. I am not sure why sensitivity and
category statements are not allowed in blocks, but everything else is. That
is why I didn't add those checks when building the AST. It is not clear if
mls, handleunknown, defaultuser, defaultrole, defaulttype, defaultrange,
and policycap should be restricted to the global namespace.

James Carter (12):
  libsepol/cil: Reorder checks for invalid rules when building AST
  libsepol/cil: Cleanup build AST helper functions
  libsepol/cil: Create new first child helper function for building AST
  libsepol/cil: Use AST to track blocks and optionals when resolving
  libsepol/cil: Reorder checks for invalid rules when resolving AST
  libsepol/cil: Sync checks for invalid rules in booleanifs
  libsepol/cil: Check for statements not allowed in optional blocks
  libsepol/cil: Sync checks for invalid rules in macros
  libsepol/cil: Do not allow tunable declarations in in-statements
  libsepol/cil: Make invalid statement error messages consistent
  libsepol/cil: Use CIL_ERR for error messages in cil_compile()
  secilc/docs: Update the CIL documentation for various blocks

 libsepol/cil/src/cil.c                    |   8 +-
 libsepol/cil/src/cil_build_ast.c          | 193 ++++++++++++----------
 libsepol/cil/src/cil_resolve_ast.c        | 174 ++++++++-----------
 secilc/docs/cil_call_macro_statements.md  |   2 +
 secilc/docs/cil_conditional_statements.md |   6 +
 secilc/docs/cil_container_statements.md   |  28 ++--
 6 files changed, 205 insertions(+), 206 deletions(-)

-- 
2.26.3

