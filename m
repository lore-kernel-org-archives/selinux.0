Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2836C433EF
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE1A61108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhKEPs2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhKEPs1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CAAC061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f8so34733887edy.4
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=beJc14KwxA2EdDx4ghv5UwmxleErIgYhJt7seTOVjZs=;
        b=lpsDM+XzLuEYb1RXFO64O6WhqYEeGZyqlMqr967mSkE37pvwAloucp/xCJM6wwLGz4
         4AQvQJ3VItQHeYYjGKwCYMwnK+2Ylj7I14kY+CtkphnyTdl/idjG5AVMVqESK30kd7Ka
         kuy2w3TTt3YmjAz/BwGWmiiMv9k6asKghoPaA63dC3PjCoolVpAMICeGUwvX79XaojiI
         +UzhyDDyn3ZqrldEx4fcG9hyJH0N+Y/8agcPFU6goPPLQGzC0Iea5ITXHm0K7NfA3vK9
         4g5JJmlN+WN21mgZDVLk7KRSHy8z+pA9E+IPz3vQL/x4gYVAGdUHDTN9dI4YdO0fp8Hl
         d73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beJc14KwxA2EdDx4ghv5UwmxleErIgYhJt7seTOVjZs=;
        b=tNwXUu+MiJeVnpxZO8QP/CPK2e0TTw0EaJv9JH8kvfHIzcIdGQNySCvdVvWZjBG12h
         2azmoGCK0Vmfc0um4Lf7izWD3dz2hbw7yu2t8PVUJ6qQXKrT9oc96ksUL6ubQlhdVhyW
         IGatgeu58fiCNJpakq8CdZfB3ucJ2ruJz8UN8svEbBYroP4DsjLPF5YbzVgrgfkgSTTI
         YNZPqezw8T3bNe9u/hIqmwnubPg39aXBmKv0kl5JhMXPfUQidd6JVg6Dg38fJ4waMLBd
         Hh5BFfsfQ6iwh8YbORnn9BC7JtPw14ENZmbBK1yFud5jDzTVOQ9Wauyx129rriZjG5FL
         XYyQ==
X-Gm-Message-State: AOAM530jOmDuBQ5DmJfoP670f620fFZIaTeeGTGfHp1Xp15IeQ78uVOm
        tWSH1JNYqZb7YbMejetyhghGWYpKp94=
X-Google-Smtp-Source: ABdhPJwvM96piBgVvtB1gl1hxR0fSSyDbnQWyj+82n6rupQc9arJxyxVYr2knXMy+0euOQuMvkFZqA==
X-Received: by 2002:a50:e0c3:: with SMTP id j3mr79056069edl.97.1636127146513;
        Fri, 05 Nov 2021 08:45:46 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 00/36] libsepol: add fuzzer for reading binary policies
Date:   Fri,  5 Nov 2021 16:45:02 +0100
Message-Id: <20211105154542.38434-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
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

v2:
  - reorder patches
    1. oss-fuzz related
    2. libsepol parsing and other crashesand UB
    3. enhance policy validation
  - misc changes based on review by James Carter

Christian Göttsche (36):
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
  libsepol: clean memory on conditional insertion failure
  libsepol: reject abnormal huge sid ids
  libsepol: reject invalid filetrans source type
  libsepol: zero member before potential dereference
  libsepol: use size_t for indexes in strs helpers
  libsepol: do not underflow on short format arguments
  libsepol: do not crash on class gaps
  libsepol: do not crash on user gaps
  libsepol: use correct size for initial string list
  libsepol: do not create a string list with initial size zero
  libsepol: split validation of datum array gaps and entries
  libsepol: validate MLS levels
  libsepol: validate expanded user range and level
  libsepol: validate permission count of classes
  libsepol: resolve log message mismatch
  libsepol: validate avtab and avrule types
  libsepol: validate constraint expression operators and attributes
  libsepol: validate type of avtab type rules
  libsepol: validate ocontexts
  libsepol: validate genfs contexts
  libsepol: validate permissive types
  libsepol: validate policy properties
  libsepol: validate categories
  libsepol: validate fsuse types
  libsepol: validate class default targets

 .github/workflows/cifuzz.yml     |   3 +-
 libsepol/fuzz/binpolicy-fuzzer.c |  63 ++++
 libsepol/fuzz/policy.bin         | Bin 0 -> 1552 bytes
 libsepol/fuzz/secilc-fuzzer.c    |   5 +
 libsepol/src/Makefile            |   6 +
 libsepol/src/avtab.c             |   6 +
 libsepol/src/conditional.c       |  53 ++--
 libsepol/src/ebitmap.c           |  27 +-
 libsepol/src/expand.c            |   4 +-
 libsepol/src/hashtab.c           |   4 +-
 libsepol/src/kernel_to_cil.c     |  10 +
 libsepol/src/kernel_to_common.c  |  23 +-
 libsepol/src/kernel_to_common.h  |   4 +-
 libsepol/src/kernel_to_conf.c    |  13 +-
 libsepol/src/link.c              |   3 +-
 libsepol/src/module.c            |   4 +-
 libsepol/src/module_to_cil.c     |  13 +-
 libsepol/src/optimize.c          |  11 +-
 libsepol/src/policydb.c          |  27 +-
 libsepol/src/policydb_validate.c | 475 +++++++++++++++++++++++++++----
 libsepol/src/private.h           |  27 +-
 libsepol/src/services.c          |  12 +-
 libsepol/src/sidtab.c            |   3 +-
 libsepol/src/user_record.c       |   8 +-
 libsepol/src/users.c             |  12 +-
 libsepol/src/util.c              |  11 +-
 libsepol/src/write.c             |   2 +-
 scripts/oss-fuzz.sh              |  17 +-
 28 files changed, 684 insertions(+), 162 deletions(-)
 create mode 100644 libsepol/fuzz/binpolicy-fuzzer.c
 create mode 100644 libsepol/fuzz/policy.bin

-- 
2.33.1

