Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6FAE82CBB
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjI0TAe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjI0TAd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD2F5
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:27 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4181059349bso49482211cf.3
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841226; x=1696446026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iqyrbhhYDni9icA4dC+Qu9ycafALmMyAAkZpOQjYqO0=;
        b=W5s/kn2tdw6i46s7/Ou/cODFbv4kijj9NaHKCWRk6bO2IQyDOvZqLRG6TIZEMlFQAP
         G0d0q+yZuL3P0t0yY0u4f9FoLmfigT6MX1Jd6hKurcAq60SsSNNp+y9EBtSJB7+ycpta
         XGME7Om11lWyw67aensWTgcReFuujlexd61HxkeKg1JQZmXQ290gP+qM8fUdFngmI5VW
         lv/YF9GB9jfkz/4FBOvK106tme9JWKHTG6YzmAaXi8odzsph8V2EOisPVIcgI0R8QzFT
         vzaOKlWNwEQtB/E7fyUJFUfB218R07xDbVaZgz3VyVGJcbnEj0yOeJjfJB9Lwm/x6Mci
         oBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841226; x=1696446026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqyrbhhYDni9icA4dC+Qu9ycafALmMyAAkZpOQjYqO0=;
        b=VtQTkh3hxqOy4ccuJENrr1jZRV5M1KWidQwZnJKMU4oy6kbwfMp9Wcbt8oWG7BRygl
         pWEBnqsWaFxgJv4bF+yoP4IQDoQpu3b7ZZ2lTlBpJi2BVZ+/T0pQUo+zCHev2nIylXiZ
         AmYJtmv+WZq+sUYyLI0pOAhNPVFeuQPAHjJAmpqUuIISf81FCQvB6G41unyvJc+1JoP9
         QL1oSwHl3En5GlyO3wkcP9qLA+khBXYRXpq77E58lZT1WDgdUgQqqskk0sTcAXLbeClF
         nYtZ7tsgSnMsVEBBIBJMPD9jVaz15gXrY7kNGrf48SpjPdwsKVPEUZGTGMnmf5PtPVUx
         S1cA==
X-Gm-Message-State: AOJu0YyLwFoEAnxwn6IdmkMgiOHTD3OoX3Wqon2CxECKvK8zskGV1fcc
        UJTEFOnnv1m5ceEUDIhfsKoLKIuvKvE=
X-Google-Smtp-Source: AGHT+IFbNkaIYNIG86M73npeTYUtC2P/viDxRl7/p0k2rMJ280HpVjl18Y77Ndd9pttTMMcc+NP5hQ==
X-Received: by 2002:a05:622a:204:b0:418:178d:a10f with SMTP id b4-20020a05622a020400b00418178da10fmr3660483qtx.29.1695841225987;
        Wed, 27 Sep 2023 12:00:25 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:25 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/9] CIL Cleanups and Improved Argument handling
Date:   Wed, 27 Sep 2023 15:00:12 -0400
Message-ID: <20230927190021.1164278-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Patches 1 and 2 are cleanups
Patch 3 allows IP address and mask values to be directly written.
Patches 4 and 7 update and fix the CIL documentation.
Patch 5 improves the handling of strings passed into a call for named
  type transitions.
Patch 6 allows the path of a filecon rule to be passed as an argument
  in a call.
Patch 8 improves writing out statements in macros and macro arguments.
Patch 9 adds a warning when an identifier has the same name as a call
  argument even though it has a different flavor.

See the individual patches for more details.

James Carter (9):
  libsepol/cil: Use struct cil_db * instead of void *
  libsepol/cil: Refactor and improve handling of order rules
  libsepol/cil: Allow IP address and mask values to be directly written
  secilc/docs: Update syntax for IP addresses and nodecon
  libsepol/cil: Refactor Named Type Transition Filename Creation
  libsepol/cil: Allow paths in filecon rules to be passed as arguments
  secilc/docs: Fix and update the documentation for macro parameters
  libsepol/cil: Add pointers to datums to improve writing out AST
  libsepol/cil: Give warning for name that has different flavor

 libsepol/cil/src/cil.c                        |  108 +-
 libsepol/cil/src/cil_build_ast.c              |  461 +++-----
 libsepol/cil/src/cil_build_ast.h              |   13 +-
 libsepol/cil/src/cil_copy_ast.c               |   96 +-
 libsepol/cil/src/cil_copy_ast.h               |    5 +-
 libsepol/cil/src/cil_flavor.h                 |    2 +-
 libsepol/cil/src/cil_fqn.c                    |    2 +-
 libsepol/cil/src/cil_internal.h               |   58 +-
 libsepol/cil/src/cil_policy.c                 |    5 +-
 libsepol/cil/src/cil_post.c                   |   14 +-
 libsepol/cil/src/cil_reset_ast.c              |   16 +-
 libsepol/cil/src/cil_resolve_ast.c            | 1027 +++++++----------
 libsepol/cil/src/cil_resolve_ast.h            |  124 +-
 libsepol/cil/src/cil_verify.c                 |   80 +-
 libsepol/cil/src/cil_verify.h                 |    1 +
 libsepol/cil/src/cil_write_ast.c              |  125 +-
 secilc/docs/cil_call_macro_statements.md      |    6 +-
 .../docs/cil_network_labeling_statements.md   |    6 +-
 18 files changed, 982 insertions(+), 1167 deletions(-)

-- 
2.41.0

