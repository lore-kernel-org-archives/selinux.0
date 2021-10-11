Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B581C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7E260EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhJKQ2X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhJKQ2X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A14C06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a25so54087074edx.8
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPfLQeriQeS1w03uhCayH4gvwfaK5ehVrV0cIUrSzXI=;
        b=Wr0cBpM0zgdUWK81clXZt2RD4WMJJuA1H30fN7Gv+o0jw5twbU/CcY0R7q8p19GxW4
         rFSR28aSbula/dFvF87AW7VIxM30k9bo3MVRW79DWvalK0YbQ/iYVCu4egSROeMRQJUo
         /EUS1p1KFaKTi6N7dghC94h8iIBO28HA9MycgMZ4u9Iw6xIM4yLyRDr7jv6R/Uu8TyVk
         ShT0iguVIJ+ssXqmOLCBEjcHenaGqz3tjuy2obBEHYb8sL9HrOVnui99qDB2vD5jdNeA
         g24Dntwymb/ilumO+gVNN4h59yN4ZUiiLx3sPlpLOaxnF7yoOTtmbF6HWPZoAcokw/yy
         a0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPfLQeriQeS1w03uhCayH4gvwfaK5ehVrV0cIUrSzXI=;
        b=z4W1MBuyKL6ELT2ye8ckdzSJcvwFhgMuIkjZdLHhqPtpbHqILebkPfhod4L15VD078
         fgqHCIZWqqm4o6urXr29+npZzF1hP94C+XSinpYdT4ITc8LhDfK28LGnr3L7c6wZLZCh
         wQTwbsH269eVObtP+IRSIuVeNpuLjhSYy6NlIXG9aKsZjO0UG+U4XHlBKqa/jjH4RbWX
         5W8vMZBZyqDBZ+xgZ98EoqULaXsVHP9WfMlRL0QAwkNJb8GHn67OZQ5RYwrjtU/Bd1UX
         C69LKXMbq3nNsicOEgl/4OMKZeTvHwwkY7PQhZeOSBm1u030kp2kjbzDCGlqM7BEOEpa
         0IBw==
X-Gm-Message-State: AOAM530be+YK/UBBm2SO02B0b0HqMxFABQ3zZzjQzgbzykCdlIkPKGb6
        k9CLkxQhy1QeksZKBQlBUngwWkS0LBc=
X-Google-Smtp-Source: ABdhPJy1/FkePu/HeI7k/pPf85B9OcbiNKzcB0lcb+bu17rrwAfcFKzcuQdHabqqV9v9rkGYYT90cg==
X-Received: by 2002:aa7:c783:: with SMTP id n3mr42521580eds.122.1633969581329;
        Mon, 11 Oct 2021 09:26:21 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:20 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 00/35] libsepol: add fuzzer for reading binary policies
Date:   Mon, 11 Oct 2021 18:24:58 +0200
Message-Id: <20211011162533.53404-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a libfuzz[1] based fuzzer testing the reading and parsing of binary policy
files. This fuzzer will be run within the OSS-Fuzz service.

Handle and reject a variety of edge cases causing crashes or resource leaks.

The fifth patch ("libsepol/fuzz: limit element sizes for fuzzing") needs some
discussion: To avoid oom reports from the fuzzer, caused by huge memory
allocations, all identifiers are limited to a length of 2^16 for the fuzzer
build only.  Probably there should be a limit for the release build too.
Is there a specification for the binary policy format saying something about
the maximum length of identifiers?
After a quick look at the kernel sources (most interesting is str_read()) I
could not find any limits either.

[1]: https://llvm.org/docs/LibFuzzer.html

Christian Göttsche (35):
  cifuzz: enable report-unreproducible-crashes
  cifuzz: use the default runtime of 600 seconds
  libsepol/fuzz: silence secilc-fuzzer
  libsepol: add libfuzz based fuzzer for reading binary policies
  libsepol/fuzz: limit element sizes for fuzzing
  libsepol: use logging framework in conditional.c
  libsepol: use logging framework in ebitmap.c
  libsepol: use mallocarray wrapper to avoid overflows
  libsepol: use reallocarray wrapper to avoid overflows
  libsepol: add checks for read sizes
  libsepol: enforce avtab item limit
  libsepol: clean memory on conditional read failure
  libsepol: validate MLS levels
  libsepol: reject invalid fsuse types
  libsepol: reject invalid default targets
  libsepol: validate expanded user range and level
  libsepol: validate types
  libsepol: use size_t for indexes in strs helpers
  libsepol: reject abnormal huge sid ids
  libsepol: do not crash on class gaps
  libsepol: do not crash on user gaps
  libsepol: validate permission count of classes
  libsepol: resolve log message mismatch
  libsepol: zero member before potential dereference
  libsepol: validate avtab types
  libsepol: validate constraint expression operators and attributes
  libsepol: validate type of avtab type rules
  libsepol: validate ocontexts
  libsepol: validate genfs contexts
  libsepol: validate permissive types
  libsepol: validate policy properties
  libsepol: do not underflow on short format arguments
  libsepol: validate categories
  libsepol: use correct size for initial string list
  libsepol: do not create a string list with initial size zero

 .github/workflows/cifuzz.yml     |   3 +-
 libsepol/fuzz/binpolicy-fuzzer.c |  63 +++++++
 libsepol/fuzz/policy.bin         | Bin 0 -> 1552 bytes
 libsepol/fuzz/secilc-fuzzer.c    |   5 +
 libsepol/src/Makefile            |   6 +
 libsepol/src/avtab.c             |   6 +
 libsepol/src/conditional.c       |  36 ++--
 libsepol/src/ebitmap.c           |  27 ++-
 libsepol/src/expand.c            |   4 +-
 libsepol/src/hashtab.c           |   4 +-
 libsepol/src/kernel_to_cil.c     |  10 ++
 libsepol/src/kernel_to_common.c  |  23 ++-
 libsepol/src/kernel_to_common.h  |   4 +-
 libsepol/src/kernel_to_conf.c    |  13 +-
 libsepol/src/link.c              |   3 +-
 libsepol/src/module.c            |   4 +-
 libsepol/src/module_to_cil.c     |  13 +-
 libsepol/src/optimize.c          |  11 +-
 libsepol/src/policydb.c          |  68 +++++++-
 libsepol/src/policydb_validate.c | 274 +++++++++++++++++++++++++++++--
 libsepol/src/private.h           |  27 ++-
 libsepol/src/services.c          |  12 +-
 libsepol/src/sidtab.c            |   3 +-
 libsepol/src/user_record.c       |   8 +-
 libsepol/src/users.c             |  12 +-
 libsepol/src/util.c              |  11 +-
 libsepol/src/write.c             |   2 +-
 scripts/oss-fuzz.sh              |  19 ++-
 28 files changed, 556 insertions(+), 115 deletions(-)
 create mode 100644 libsepol/fuzz/binpolicy-fuzzer.c
 create mode 100644 libsepol/fuzz/policy.bin

-- 
2.33.0

