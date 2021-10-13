Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE2C433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 14:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC71F60F94
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 14:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhJMOJq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 10:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhJMOJo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 10:09:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99601C061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 07:07:41 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id m67so3982369oif.6
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m1AGrRKAiS8oqRXU6pb/Hu6+ewOZCN9NOycwLDxSoqw=;
        b=ok4xHLnukWJP2euPDAh+6PyDmh5dFX7gkcKQ/DWAy8H5tpK4dJrZ6tyU/borjKu2q5
         LyfgCSlio0XwCbRt0TuyvJKSrIHpBp1bsaQXXS2LscIEv9ZbKeb3cUvss1nJNQTlPRN7
         2mxLulsgZe1VgCaBgsIZWsDemfz0XjXRzAS7kAR8g2DHMIse7Hx6HsQ95lJgE/XT84S8
         dDMBqODImNJyZr4WYfD77949O1qj4vyL+uOa+BFqu6AqDaR06c2mWVdduDgyZdIVw5z5
         orfh3jptrb/mUGlTqamxqN2aG8LluZNBBNd6eeewGdjw4n2Tog6mSBqnJEFmwy8cBvB+
         5Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m1AGrRKAiS8oqRXU6pb/Hu6+ewOZCN9NOycwLDxSoqw=;
        b=FOErVz9fBwG7dqIibgvla6R1u7opCCf+8tA+6WLadquhDL8A+A0vOj7zNoLRkEUNJM
         pMhFWhdXG9xk8xA9RLDssS4MhnHcmYbzYQnPqsLL/MRyj5wb5R6dbT8JCzAWSRkzUXDs
         JTKL/jZPzvGjDgKNJzzuyYhf2HEDOEw8i9dR5jrwSULCX/pqwEAIeKZB3cXGD92WczPm
         4kI9Jkl2jVN71kprFTwP7bRUAwzcH+A2rqDXkwlG0hZ11Fg9oCeAs61WJGdrCpa6FCKQ
         GI7pe3NA5K84EdwDkTGbyt/r2mlRoQX3r+B56y1WdkhiEGRLGH0IIjJg6JOEvr/a5VCZ
         NTQw==
X-Gm-Message-State: AOAM532O3giEBCHHHDOic1weyCcVUQ+IV5ovzxTUuWFU3OE2oJkNRDvA
        X6F0cky33J/bqaB5jZEH/bL7Vpqzr+LzJlAWrah070KS
X-Google-Smtp-Source: ABdhPJz2KUjBPo8o+7Vdc/57/fmXpKHt0dVZoOq00KelywrrMVK7m1gho/gFuvAw6ZnsldlkcUliGIC11aDVYrQ/aIM=
X-Received: by 2002:aca:c288:: with SMTP id s130mr8343829oif.138.1634134060902;
 Wed, 13 Oct 2021 07:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 13 Oct 2021 10:07:29 -0400
Message-ID: <CAP+JOzTD1ZSH4ZjYKbPE+BJZyo-UbaqmUHTVi4Hw4gfYrP1PEg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] libsepol: add fuzzer for reading binary policies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This needs to be broken up into three patch sets.

1) libfuzz: patches 1-5
2) policydb_validate improvements: patches 13, 16, 17, 22, 23, 25-31, 33
3) General libsepol fixes: patches 6-12, 14, 15, 18-21, 24, 32, 34, 35

I have some comments on the individual patches which will be coming soon.

Thanks,
Jim

On Mon, Oct 11, 2021 at 12:42 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a libfuzz[1] based fuzzer testing the reading and parsing of binary p=
olicy
> files. This fuzzer will be run within the OSS-Fuzz service.
>
> Handle and reject a variety of edge cases causing crashes or resource lea=
ks.
>
> The fifth patch ("libsepol/fuzz: limit element sizes for fuzzing") needs =
some
> discussion: To avoid oom reports from the fuzzer, caused by huge memory
> allocations, all identifiers are limited to a length of 2^16 for the fuzz=
er
> build only.  Probably there should be a limit for the release build too.
> Is there a specification for the binary policy format saying something ab=
out
> the maximum length of identifiers?
> After a quick look at the kernel sources (most interesting is str_read())=
 I
> could not find any limits either.
>
> [1]: https://llvm.org/docs/LibFuzzer.html
>
> Christian G=C3=B6ttsche (35):
>   cifuzz: enable report-unreproducible-crashes
>   cifuzz: use the default runtime of 600 seconds
>   libsepol/fuzz: silence secilc-fuzzer
>   libsepol: add libfuzz based fuzzer for reading binary policies
>   libsepol/fuzz: limit element sizes for fuzzing
>   libsepol: use logging framework in conditional.c
>   libsepol: use logging framework in ebitmap.c
>   libsepol: use mallocarray wrapper to avoid overflows
>   libsepol: use reallocarray wrapper to avoid overflows
>   libsepol: add checks for read sizes
>   libsepol: enforce avtab item limit
>   libsepol: clean memory on conditional read failure
>   libsepol: validate MLS levels
>   libsepol: reject invalid fsuse types
>   libsepol: reject invalid default targets
>   libsepol: validate expanded user range and level
>   libsepol: validate types
>   libsepol: use size_t for indexes in strs helpers
>   libsepol: reject abnormal huge sid ids
>   libsepol: do not crash on class gaps
>   libsepol: do not crash on user gaps
>   libsepol: validate permission count of classes
>   libsepol: resolve log message mismatch
>   libsepol: zero member before potential dereference
>   libsepol: validate avtab types
>   libsepol: validate constraint expression operators and attributes
>   libsepol: validate type of avtab type rules
>   libsepol: validate ocontexts
>   libsepol: validate genfs contexts
>   libsepol: validate permissive types
>   libsepol: validate policy properties
>   libsepol: do not underflow on short format arguments
>   libsepol: validate categories
>   libsepol: use correct size for initial string list
>   libsepol: do not create a string list with initial size zero
>
>  .github/workflows/cifuzz.yml     |   3 +-
>  libsepol/fuzz/binpolicy-fuzzer.c |  63 +++++++
>  libsepol/fuzz/policy.bin         | Bin 0 -> 1552 bytes
>  libsepol/fuzz/secilc-fuzzer.c    |   5 +
>  libsepol/src/Makefile            |   6 +
>  libsepol/src/avtab.c             |   6 +
>  libsepol/src/conditional.c       |  36 ++--
>  libsepol/src/ebitmap.c           |  27 ++-
>  libsepol/src/expand.c            |   4 +-
>  libsepol/src/hashtab.c           |   4 +-
>  libsepol/src/kernel_to_cil.c     |  10 ++
>  libsepol/src/kernel_to_common.c  |  23 ++-
>  libsepol/src/kernel_to_common.h  |   4 +-
>  libsepol/src/kernel_to_conf.c    |  13 +-
>  libsepol/src/link.c              |   3 +-
>  libsepol/src/module.c            |   4 +-
>  libsepol/src/module_to_cil.c     |  13 +-
>  libsepol/src/optimize.c          |  11 +-
>  libsepol/src/policydb.c          |  68 +++++++-
>  libsepol/src/policydb_validate.c | 274 +++++++++++++++++++++++++++++--
>  libsepol/src/private.h           |  27 ++-
>  libsepol/src/services.c          |  12 +-
>  libsepol/src/sidtab.c            |   3 +-
>  libsepol/src/user_record.c       |   8 +-
>  libsepol/src/users.c             |  12 +-
>  libsepol/src/util.c              |  11 +-
>  libsepol/src/write.c             |   2 +-
>  scripts/oss-fuzz.sh              |  19 ++-
>  28 files changed, 556 insertions(+), 115 deletions(-)
>  create mode 100644 libsepol/fuzz/binpolicy-fuzzer.c
>  create mode 100644 libsepol/fuzz/policy.bin
>
> --
> 2.33.0
>
