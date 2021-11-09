Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B6DC433F5
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497B461051
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbhKISp0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhKISp0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 13:45:26 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47B0C061764
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 10:42:39 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso97807otj.1
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 10:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fcx5oV+Twv5voocRC0fONjnPI2CI9pzKLvnFYJ35Pyg=;
        b=adH7AkNFc2GKd8dDz3p2rDQNYmrXefiySPtmepo1GylD4lc1tgu3pSugQvpAjJQAb2
         2y+6XoyLFaQcDwrj+408G5Lk52FoqnWdr1sTF+GGr+mnr98qkosZfGdQC5jvBcZCsfoW
         7W56oy+hlo1cNtYC4VUZ5XD+D0PfGPdkcZ2GfZh534csfcbjNOIG/qmedw/nCNjFyKnE
         ZzJa08sX8STSWEabvOqo9AdKMkqU7jloegsTyrT9Hs8ZGnh+E0svp1Uh5SJQqpXyVZix
         tJ3tpnxTIBip74rMS6hZAs70kD39DTF7JVBND41bJZLmQpvaPKyGZW1DgI7Pl5GGKw6b
         nGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fcx5oV+Twv5voocRC0fONjnPI2CI9pzKLvnFYJ35Pyg=;
        b=NzdH4DmxoogpICeJucQcy8L7k8xaFb1ezqA2eLnxjHNc9RrENxBxNv3KW3SpbDPBhX
         lF46a/FW1UhwCf6VBw70tQLOksc0aEAVk95qxnVRLe+Sh4aiLJs4ubtyQnpLPPV55Oem
         X90Q07Ws92uCiCydp8PurW9I+W8bQFYN3ICPKoHJik6OWMLjF1xBPxr6XufYyoyBVmtB
         4cZ+LvbQ4PM0DkBDGDJmRE4GgaOaVht2UE4L4APQnBdTmHRXDZNRdOXEmrCxvx65U9lU
         bGZHzEDbjrGJGSIG8VSpoGz8mKHY8VfU1WFSAcpuP0ffWaOkpgGXk7R4Hl2UrZi0ctui
         5kUw==
X-Gm-Message-State: AOAM5314C6u/GtjwjEdG5f10aUEgFi8+bFaI5wrGOji74ZmPahNd7cx1
        tIEhbN9iddtuQTOfuXxEgyzJm7Osjff+rnsJyyI=
X-Google-Smtp-Source: ABdhPJySZHjJIsts4zdKAEjl4aH36JMbFM3pqQtXI22xUCmMkL5fLXi/mXqtleXPMuV2/0dwrCkUiqEgNi11BTMUj1Y=
X-Received: by 2002:a9d:6346:: with SMTP id y6mr8072562otk.154.1636483358517;
 Tue, 09 Nov 2021 10:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211105154542.38434-1-cgzones@googlemail.com>
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Nov 2021 13:42:27 -0500
Message-ID: <CAP+JOzRNuqCbRuNYz-=E-aj8zgLFY_h6kXnfcd1842LOZVs6-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/36] libsepol: add fuzzer for reading binary policies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 5, 2021 at 12:11 PM Christian G=C3=B6ttsche
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
> v2:
>   - reorder patches
>     1. oss-fuzz related
>     2. libsepol parsing and other crashesand UB
>     3. enhance policy validation
>   - misc changes based on review by James Carter
>

I have comments on patch 02 and 30, everything else looks good. It was
a little hard to work through the reordering, but it does seem like
you addressed all my previous comments.

Thanks,
Jim


> Christian G=C3=B6ttsche (36):
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
>   libsepol: clean memory on conditional insertion failure
>   libsepol: reject abnormal huge sid ids
>   libsepol: reject invalid filetrans source type
>   libsepol: zero member before potential dereference
>   libsepol: use size_t for indexes in strs helpers
>   libsepol: do not underflow on short format arguments
>   libsepol: do not crash on class gaps
>   libsepol: do not crash on user gaps
>   libsepol: use correct size for initial string list
>   libsepol: do not create a string list with initial size zero
>   libsepol: split validation of datum array gaps and entries
>   libsepol: validate MLS levels
>   libsepol: validate expanded user range and level
>   libsepol: validate permission count of classes
>   libsepol: resolve log message mismatch
>   libsepol: validate avtab and avrule types
>   libsepol: validate constraint expression operators and attributes
>   libsepol: validate type of avtab type rules
>   libsepol: validate ocontexts
>   libsepol: validate genfs contexts
>   libsepol: validate permissive types
>   libsepol: validate policy properties
>   libsepol: validate categories
>   libsepol: validate fsuse types
>   libsepol: validate class default targets
>
>  .github/workflows/cifuzz.yml     |   3 +-
>  libsepol/fuzz/binpolicy-fuzzer.c |  63 ++++
>  libsepol/fuzz/policy.bin         | Bin 0 -> 1552 bytes
>  libsepol/fuzz/secilc-fuzzer.c    |   5 +
>  libsepol/src/Makefile            |   6 +
>  libsepol/src/avtab.c             |   6 +
>  libsepol/src/conditional.c       |  53 ++--
>  libsepol/src/ebitmap.c           |  27 +-
>  libsepol/src/expand.c            |   4 +-
>  libsepol/src/hashtab.c           |   4 +-
>  libsepol/src/kernel_to_cil.c     |  10 +
>  libsepol/src/kernel_to_common.c  |  23 +-
>  libsepol/src/kernel_to_common.h  |   4 +-
>  libsepol/src/kernel_to_conf.c    |  13 +-
>  libsepol/src/link.c              |   3 +-
>  libsepol/src/module.c            |   4 +-
>  libsepol/src/module_to_cil.c     |  13 +-
>  libsepol/src/optimize.c          |  11 +-
>  libsepol/src/policydb.c          |  27 +-
>  libsepol/src/policydb_validate.c | 475 +++++++++++++++++++++++++++----
>  libsepol/src/private.h           |  27 +-
>  libsepol/src/services.c          |  12 +-
>  libsepol/src/sidtab.c            |   3 +-
>  libsepol/src/user_record.c       |   8 +-
>  libsepol/src/users.c             |  12 +-
>  libsepol/src/util.c              |  11 +-
>  libsepol/src/write.c             |   2 +-
>  scripts/oss-fuzz.sh              |  17 +-
>  28 files changed, 684 insertions(+), 162 deletions(-)
>  create mode 100644 libsepol/fuzz/binpolicy-fuzzer.c
>  create mode 100644 libsepol/fuzz/policy.bin
>
> --
> 2.33.1
>
