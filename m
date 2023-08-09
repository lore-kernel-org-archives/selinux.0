Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E918DC41513
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjHIUky (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIUkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:40:53 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56912A6
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:40:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40fd2de0ddcso932781cf.2
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691613649; x=1692218449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ0/YG3gLWpY0C8Yy2IFIsdeBP7URnrVgcg/UM80qGI=;
        b=HKW9dE/WTnEmDpcOqW4dWujnkrNw8rjPk0Z56AXM/a8AgRJ3Qa+0zyhLrmg7rhiyil
         2zbWI0mHANW0EMwvi0v68PP1OVeJs1q7ERQDGfCJr29+6hGWYTZl4yamFHGK001OAKZP
         H76kNiP3NKvkAKqo/NZuWwOHVcxerl/bfagXsUA8LjedE0wF1x9e9JpekrRz4XvsOvHD
         rNr5lLBSTxIRhxryYv9Z299ogbowcDRWeXuP2WQV1kHeh5SUqdRci8sGhGKGAUJm2U5U
         W4PaermGg1X/c2hmwhk1fUDDFwdzB7NfOQNZRU2bvxkj30IaJ9PIc8Mxxo2rCTy1lDcK
         0n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613649; x=1692218449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZ0/YG3gLWpY0C8Yy2IFIsdeBP7URnrVgcg/UM80qGI=;
        b=F9jvVWaWF2AFR6zhogk+l1ddBLj7PUaH5/k2aXwKxAj/Ufg5WjhSQGqsjBY/34W3Va
         lw/XprOA0veaORN5LJPHd3UwGvKPV8W4HQCr6aDKcWVXPDZnWZx3Kb+ETrZgNXon65DF
         lBojHJb91kT9xarCgJBk8H4r2PW5ToPCNaz18yH0Z0pIBgVQmkpU5Bz5340KMK0wq3ww
         EZgxeVqMNuJ4nkeNTBPWdnMTkHHRPedRRPr1gk0AStkP0Fb9efef2KvNK61JFsc4a5GP
         nNcw8nUZJLOW87EtLO0wz8dWblDipgGR2lnmDCjmcvlMmSA/6S+rSH/06XqqfF6LErEN
         HnVw==
X-Gm-Message-State: AOJu0YzGx8PyXg7r+JAtqU5h0EYf9WzY+RH5yC9wDobHBQhcrrRp9IBG
        9/weWfe5gf+CrkhycUFZpx8NbcqdJlo=
X-Google-Smtp-Source: AGHT+IFHNlMNZE3A+ZSuNwEgcYci2oLT+1Ykaq8hrKrMKuPzZNY9IcSylv2yGL4/LWWVCDkLx3PibA==
X-Received: by 2002:a05:622a:1009:b0:403:b5a1:7ee0 with SMTP id d9-20020a05622a100900b00403b5a17ee0mr614949qte.32.1691613649006;
        Wed, 09 Aug 2023 13:40:49 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a14d200b0041020e8e261sm711295qtx.1.2023.08.09.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:40:48 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, cgzones@googlemail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/7 v2] Add support for notself and other to CIL
Date:   Wed,  9 Aug 2023 16:40:39 -0400
Message-ID: <20230809204046.110783-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch set adds support for using notself and other in AV rules.
See patch 3 for more details.

Patches 1-4, 6-7 are the same as the patches from April 12th, see:
https://lore.kernel.org/selinux/20230412210406.522892-1-jwcart2@gmail.com/

Patch 5 updates Christian's patch to use ERR() instead of log_err(), see:
https://lore.kernel.org/selinux/20230602130608.24586-4-cgzones@googlemail.com/

Nothing else has changed.

Christian Göttsche (1):
  libsepol: update CIL generation for trivial not-self rules

James Carter (6):
  libsepol: Changes to ebitmap.h to fix compiler warnings
  libsepol/cil: Do not call ebitmap_init twice for an ebitmap
  libsepol/cil: Add notself and other support to CIL
  libsepol: Use ERR() instead of log_err()
  secilc/docs: Add notself and other keywords to CIL documentation
  secilc/test: Add notself and other tests

 libsepol/cil/src/cil.c                    |  12 ++
 libsepol/cil/src/cil_binary.c             |  91 +++++++-
 libsepol/cil/src/cil_build_ast.c          |  10 +-
 libsepol/cil/src/cil_find.c               | 246 ++++++++++++++++++----
 libsepol/cil/src/cil_internal.h           |   4 +
 libsepol/cil/src/cil_resolve_ast.c        |   4 +
 libsepol/cil/src/cil_verify.c             |   3 +-
 libsepol/include/sepol/policydb/ebitmap.h |   4 +-
 libsepol/src/module_to_cil.c              |  30 ++-
 secilc/docs/README.md                     |   1 -
 secilc/docs/cil_access_vector_rules.md    | 244 +++------------------
 secilc/docs/cil_reference_guide.md        |   9 -
 secilc/docs/secil.xml                     |   2 +
 secilc/test/notself_and_other.cil         |  65 ++++++
 14 files changed, 444 insertions(+), 281 deletions(-)
 create mode 100644 secilc/test/notself_and_other.cil

-- 
2.41.0

