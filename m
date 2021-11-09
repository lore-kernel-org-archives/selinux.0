Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABEBC433EF
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0C461052
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbhKISqT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhKISqS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 13:46:18 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B6AC061764
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 10:43:32 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so4479otk.13
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=usRUaqeSSJX1QHTwxGe5BD+eV0l//VKRf8/PVMSx4bM=;
        b=UHhgidIIpnHdPgxVtowdSqtJkUUGcEXeR0Pslg/DGz7lWCwsdLGQCnnQlNqfl7jUtx
         aAnP9/1RADEq9lBnxdbWSsJ5X6iIVzx0d2+e5qxgNcIsW1DyHfKEDFPSRdfNGkihPS3u
         5AknMd60qYMoVcbdMevTifnin9hLFgpKchb/d0pKVrCaEYyBxi9BsBXVVzrClX0j8Ebb
         WSI5WILvWN9jC8paXx1JSAyE8/CqlXD9TUx52naB8ve3w04Dq7Zb/McS/tTaH6GFncPB
         YgOW9CrRxEoo4b846EwxOtnU71qtvIE7ATbrLslz96AozeFFwLIXKuUwIVPO5RuHi/TU
         Ilwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=usRUaqeSSJX1QHTwxGe5BD+eV0l//VKRf8/PVMSx4bM=;
        b=XXS5mmvSj9jiAWtm2/LXHl1q8vyDNvQDYQ4H63cFLrwAPWRlzJjzuk+tK5vrQQYBkQ
         3morjudW5NkOXjElUKoIPl8cLibZD6ZmnSor72kY8lJTmiH1lm74gxWeE+q9qtCi1LBz
         OE32NUnEBVfYS3rT5JdS03Ht08cSRwUOhXwaYeQgO/0Iad4ZdUQrR+77ArXHQmwotX77
         hmvG+9SV7EJHf39+BtUbjxKKEGzqLhExsNpdHHhn/omyXjroO5P1HLKOgb1N+f/Wtj/n
         p04kS1XZwgyjlKV+h3BTyzrv/90LOKEl+pxMb3qS2TRrbULQPgw/ZwACgMtLSgVcZlLd
         z7kA==
X-Gm-Message-State: AOAM531orujYeT/g/v8wGwgxUyz/eTbnmhcvfkQZSjH6KEkRfabIpnwt
        0ME+YoX+rKfJnROxawQP1KSqp8mJJuI36SlaIoEItNVV
X-Google-Smtp-Source: ABdhPJxVPrbh0FD0CS4aDJwpiVmtFifgE1dacLDy6o9wToMBRNrmyF2C/We5Oy1zM0wjPENKVfhRIbdLEHM9TfkqoaM=
X-Received: by 2002:a9d:7182:: with SMTP id o2mr7830782otj.53.1636483412102;
 Tue, 09 Nov 2021 10:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com> <CAP+JOzRNuqCbRuNYz-=E-aj8zgLFY_h6kXnfcd1842LOZVs6-Q@mail.gmail.com>
In-Reply-To: <CAP+JOzRNuqCbRuNYz-=E-aj8zgLFY_h6kXnfcd1842LOZVs6-Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Nov 2021 13:43:21 -0500
Message-ID: <CAP+JOzTUq8-qidqauX3LH6ZA9KSJuCRZv21LwQ2k3+_FJsO7Jw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/36] libsepol: add fuzzer for reading binary policies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 9, 2021 at 1:42 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Nov 5, 2021 at 12:11 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add a libfuzz[1] based fuzzer testing the reading and parsing of binary=
 policy
> > files. This fuzzer will be run within the OSS-Fuzz service.
> >
> > Handle and reject a variety of edge cases causing crashes or resource l=
eaks.
> >
> > The fifth patch ("libsepol/fuzz: limit element sizes for fuzzing") need=
s some
> > discussion: To avoid oom reports from the fuzzer, caused by huge memory
> > allocations, all identifiers are limited to a length of 2^16 for the fu=
zzer
> > build only.  Probably there should be a limit for the release build too=
.
> > Is there a specification for the binary policy format saying something =
about
> > the maximum length of identifiers?
> > After a quick look at the kernel sources (most interesting is str_read(=
)) I
> > could not find any limits either.
> >
> > [1]: https://llvm.org/docs/LibFuzzer.html
> >
> > v2:
> >   - reorder patches
> >     1. oss-fuzz related
> >     2. libsepol parsing and other crashesand UB
> >     3. enhance policy validation
> >   - misc changes based on review by James Carter
> >
>
> I have comments on patch 02 and 30, everything else looks good. It was

I meant patches 10 and 30.
Jim

> a little hard to work through the reordering, but it does seem like
> you addressed all my previous comments.
>
> Thanks,
> Jim
>
>
> > Christian G=C3=B6ttsche (36):
> >   cifuzz: enable report-unreproducible-crashes
> >   cifuzz: use the default runtime of 600 seconds
> >   libsepol/fuzz: silence secilc-fuzzer
> >   libsepol: add libfuzz based fuzzer for reading binary policies
> >   libsepol/fuzz: limit element sizes for fuzzing
> >   libsepol: use logging framework in conditional.c
> >   libsepol: use logging framework in ebitmap.c
> >   libsepol: use mallocarray wrapper to avoid overflows
> >   libsepol: use reallocarray wrapper to avoid overflows
> >   libsepol: add checks for read sizes
> >   libsepol: enforce avtab item limit
> >   libsepol: clean memory on conditional insertion failure
> >   libsepol: reject abnormal huge sid ids
> >   libsepol: reject invalid filetrans source type
> >   libsepol: zero member before potential dereference
> >   libsepol: use size_t for indexes in strs helpers
> >   libsepol: do not underflow on short format arguments
> >   libsepol: do not crash on class gaps
> >   libsepol: do not crash on user gaps
> >   libsepol: use correct size for initial string list
> >   libsepol: do not create a string list with initial size zero
> >   libsepol: split validation of datum array gaps and entries
> >   libsepol: validate MLS levels
> >   libsepol: validate expanded user range and level
> >   libsepol: validate permission count of classes
> >   libsepol: resolve log message mismatch
> >   libsepol: validate avtab and avrule types
> >   libsepol: validate constraint expression operators and attributes
> >   libsepol: validate type of avtab type rules
> >   libsepol: validate ocontexts
> >   libsepol: validate genfs contexts
> >   libsepol: validate permissive types
> >   libsepol: validate policy properties
> >   libsepol: validate categories
> >   libsepol: validate fsuse types
> >   libsepol: validate class default targets
> >
> >  .github/workflows/cifuzz.yml     |   3 +-
> >  libsepol/fuzz/binpolicy-fuzzer.c |  63 ++++
> >  libsepol/fuzz/policy.bin         | Bin 0 -> 1552 bytes
> >  libsepol/fuzz/secilc-fuzzer.c    |   5 +
> >  libsepol/src/Makefile            |   6 +
> >  libsepol/src/avtab.c             |   6 +
> >  libsepol/src/conditional.c       |  53 ++--
> >  libsepol/src/ebitmap.c           |  27 +-
> >  libsepol/src/expand.c            |   4 +-
> >  libsepol/src/hashtab.c           |   4 +-
> >  libsepol/src/kernel_to_cil.c     |  10 +
> >  libsepol/src/kernel_to_common.c  |  23 +-
> >  libsepol/src/kernel_to_common.h  |   4 +-
> >  libsepol/src/kernel_to_conf.c    |  13 +-
> >  libsepol/src/link.c              |   3 +-
> >  libsepol/src/module.c            |   4 +-
> >  libsepol/src/module_to_cil.c     |  13 +-
> >  libsepol/src/optimize.c          |  11 +-
> >  libsepol/src/policydb.c          |  27 +-
> >  libsepol/src/policydb_validate.c | 475 +++++++++++++++++++++++++++----
> >  libsepol/src/private.h           |  27 +-
> >  libsepol/src/services.c          |  12 +-
> >  libsepol/src/sidtab.c            |   3 +-
> >  libsepol/src/user_record.c       |   8 +-
> >  libsepol/src/users.c             |  12 +-
> >  libsepol/src/util.c              |  11 +-
> >  libsepol/src/write.c             |   2 +-
> >  scripts/oss-fuzz.sh              |  17 +-
> >  28 files changed, 684 insertions(+), 162 deletions(-)
> >  create mode 100644 libsepol/fuzz/binpolicy-fuzzer.c
> >  create mode 100644 libsepol/fuzz/policy.bin
> >
> > --
> > 2.33.1
> >
