Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341D2C433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198CC60F70
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhINMwB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhINMwB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1AFC061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n27so28658290eja.5
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6dpsVb37/7GH3f8ojJTIwjXVP/ohg0IHgn8UwSG2Q24=;
        b=THZxkbAMswOY3tlo0T4QwDN99ZAmlN2vRq5v2RWiYsrG9bSnbs6AWIqt+jZVYCCVbA
         FJ88iM14quuuFgGTYc7Cme8ObL4dflB2SErgkTfu+ofExA5LvX0Yc+WTKv1WSo03l8Jl
         ezOE+8KX0ftLKH+4kjskAX7jLe2pLxXg/1RimCt1TadFuFvZetSpgupmsrfOTiBw0rTb
         3plniJudEbL4w916G+O2+FslOO2sVj76FavcRp+LIYk7jDhC/Yzm69Mz0ULhOtTWLSNS
         rrMFJ73CLu+3oqdlDGTLB6SRJnJGT7kJw9SkRUKIwFfz9fDU6+zA8nvR2bH7u02nkAiW
         WTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6dpsVb37/7GH3f8ojJTIwjXVP/ohg0IHgn8UwSG2Q24=;
        b=nvp6D4lwm2zrW1qYeplM6Gvlu47lRorwFtHt0UKjTctW6zUxuNJG8KnUFpuLoc4O32
         aUn9u2KlvRHP1lHPVbX39yfkr5O7qi5VmNptJIhzknpJa7mzmstm/4tEYwgz7pTzNCam
         qF2M7ZJxXZ+yXU8fCazel9gnKngzKNLGieA802buNuI4pVpQlqUOsNeO8NVHRY67DHYU
         szDS8VPWrRNbO5ulqlovWWH+/L3ZTHNcKfNJuXTPfA98Q89zeRflJs7IKALUd0SkEQqa
         SaiLlKzV6SOoJJZiXEyiYqsal+TgxTKauskSpTceH3a5hOAGOIH7dmDp8LYCeknnWcqw
         XjPA==
X-Gm-Message-State: AOAM530jGzWW9rE+VlXFzORyhHU19bZFprwcZdNBAyOGkK2i3cHJszk6
        tCJA9M+VGcbxqoERdVmYVyFfVn7B9Jg=
X-Google-Smtp-Source: ABdhPJzuuEggKAgT3T1NkaGgNyBoaphksL7GNMYa23Pugx0ZpXkDlVfn4juVB8oUfnmjTLsv/eIysw==
X-Received: by 2002:a17:906:27cf:: with SMTP id k15mr19578078ejc.123.1631623842650;
        Tue, 14 Sep 2021 05:50:42 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 00/13] checkpolicy improvements
Date:   Tue, 14 Sep 2021 14:48:15 +0200
Message-Id: <20210914124828.19488-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Miscellaneous improvements to the checkpolicy subproject, affecting the
traditional language compilers checkmodule(8) and checkpolicy(8).

Avoid implicit conversions, free leaked memory, resolve several compiler
warnings, use strict integer parsing.

The last patch is an adoption of a patch proposed by liwugang [1], with
the requested changes integrated.


[1]: https://patchwork.kernel.org/project/selinux/patch/20210601151704.2688389-1-liwugang@163.com/

Christian Göttsche (13):
  libsepol: avoid implicit conversions
  libsepol: free memory after policy validation
  checkpolicy: enclose macro argument in parentheses
  checkpolicy: misc checkmodule tweaks
  checkpolicy: misc checkpolicy tweaks
  checkpolicy: mark read-only parameters in module compiler const
  checkpolicy: mark file local functions in policy_define static
  checkpolicy: add missing function declarations
  checkpolicy: resolve dismod memory leaks
  checkpolicy: avoid implicit conversion
  checkpolicy: error out on parsing too big integers
  checkpolicy: print warning on source line overflow
  checkpolicy: free extended permission memory

 checkpolicy/checkmodule.c        | 18 +++----
 checkpolicy/checkpolicy.c        | 26 +++++-----
 checkpolicy/module_compiler.c    | 26 +++++-----
 checkpolicy/module_compiler.h    |  4 +-
 checkpolicy/policy_define.c      | 87 ++++++++++++++++----------------
 checkpolicy/policy_parse.y       | 16 +++++-
 checkpolicy/policy_scan.l        | 25 ++++++---
 checkpolicy/test/dismod.c        |  7 ++-
 libsepol/src/policydb_validate.c | 14 ++++-
 libsepol/src/util.c              |  2 +-
 10 files changed, 131 insertions(+), 94 deletions(-)

-- 
2.33.0

