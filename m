Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B66C433EF
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 14:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhLQOAJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 09:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLQOAJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 09:00:09 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37035C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 06:00:09 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id t19so3748906oij.1
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 06:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sAnYNJ2HWzA28ti2pwIMLca3ldTthYg7oAg+QGdfpq4=;
        b=X/pe38BfonlaYl2G5pZtiuHoFg2zyOB8Z0ZD7CtJW25HBvDLVkpbuVDAo5q9g++Tqe
         FuOeauGDsusUbx2H7h8dd3kmvKXCY2ZMgyVH7wNfTKnN8Yi+sAfQyWka1JnVpMy1KKE9
         6B2yomifMXOR7NMFFvIlWzj7A3gFblKfuUA6f+6ZZcYtAcCYQv4Zu4RmhzYw/5r66xfG
         uCgybGwDUtKihj9/ugz7s4gerDjYJnQtwppjeUtUxWb+0wv/AK/MNgAJ+/qZ7UmUIlHZ
         LMpfYHCkY8jEdjFhyWlnuBG8pyyy9wsKteVlu4diPKrYYG5F7L2mN9ofS4Mnb0JhyQFm
         2Z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sAnYNJ2HWzA28ti2pwIMLca3ldTthYg7oAg+QGdfpq4=;
        b=ZqBi9piF7eZ5hAdSS3HTPEa2NoGUdVCP/bQHyAB2iKoFxzX0FA7BWP38eO5qZLLjrs
         2b1DsmEF74QgdYyQC0yUP5BPXC3pdq9+uhYwMQ8Rdjy83Jk6O0M2qTaauYFAIs1w45Yd
         77Y/xSCgmlnEB2mUfQG/Qa1W4uYXQMBE0GPdafhH8uIo4R6bq7civAsTDs7intRBPQtV
         zncBGuSjki+z38DUWzgOPj0Qbs4dcGT3bZBmWeUgC8FMj5Wd8+A4miImh/BNOzWa8EnE
         N6PPrqPF0Uw/lEU2sJR4LCzoql9CgOVwA1WAP6xyBzZAT3zyENJnmAvfUGrNHJEBaqke
         kr0A==
X-Gm-Message-State: AOAM5322kelRzQCl8H812Kh1YoAAQtwfR3d2lEebgKPyLUX39g2aKgxS
        J7mH5MXJAXuxq+jtV73svGkaKrsIExj6qXx3B2wO7n2t
X-Google-Smtp-Source: ABdhPJwa+pX4vp8tlNM8BRynoSJuUXVg6lDYYWU6HYh+S9s4Ip8rbAPS64bNYfdOOcrgv8prRVutH/BIocrd8Ozs99g=
X-Received: by 2002:a05:6808:179d:: with SMTP id bg29mr7776766oib.138.1639749608501;
 Fri, 17 Dec 2021 06:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com> <CAP+JOzTpxm-EDhB=6NZob06+=c2PxtkxmYYUgHbM=U-t-h=Gow@mail.gmail.com>
In-Reply-To: <CAP+JOzTpxm-EDhB=6NZob06+=c2PxtkxmYYUgHbM=U-t-h=Gow@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 17 Dec 2021 08:59:57 -0500
Message-ID: <CAP+JOzQrn2s6R3_th7S9Cc_Z4x-qAn0SamYy-wHYd15DPTMt4w@mail.gmail.com>
Subject: Re: [PATCH v3 00/36] libsepol: add fuzzer for reading binary policies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 15, 2021 at 12:41 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Dec 9, 2021 at 2:07 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add a libfuzz[1] based fuzzer testing the reading and parsing of binary=
 policy
> > files. This fuzzer will be run within the OSS-Fuzz service.
> >
> > Handle and reject a variety of edge cases causing crashes or resource l=
eaks.
> >
> > The fifth patch ("libsepol/fuzz: limit element sizes for fuzzing") limi=
ts, to
> > avoid oom reports from the fuzzer, caused by huge memory allocations, a=
ll
> > identifiers to a length of 2^16 for the fuzzer build only.
> > A potential limit for the release build needs further discussion.
> >
> > [1]: https://llvm.org/docs/LibFuzzer.html
> >
> > v3:
> >   - Drop RFC status
> >   - [10] libsepol: add checks for read sizes
> >     use PERM_SYMTAB_SIZE instead of bare 32 as limit
> >   - [11] libsepol: enforce avtab item limit
> >     take zero based numbering of variable items into account
> >   - [30] libsepol: validate ocontexts
> >     only check FS and NETIF ocons in selinux policies (not xen)
> >
> > v2:
> >   - reorder patches
> >     1. oss-fuzz related
> >     2. libsepol parsing and other crashesand UB
> >     3. enhance policy validation
> >   - misc changes based on review by James Carter
> >
> >
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
> >  libsepol/src/policydb_validate.c | 477 +++++++++++++++++++++++++++----
> >  libsepol/src/private.h           |  27 +-
> >  libsepol/src/services.c          |  12 +-
> >  libsepol/src/sidtab.c            |   3 +-
> >  libsepol/src/user_record.c       |   8 +-
> >  libsepol/src/users.c             |  12 +-
> >  libsepol/src/util.c              |  11 +-
> >  libsepol/src/write.c             |   2 +-
> >  scripts/oss-fuzz.sh              |  17 +-
> >  28 files changed, 686 insertions(+), 162 deletions(-)
> >  create mode 100644 libsepol/fuzz/binpolicy-fuzzer.c
> >  create mode 100644 libsepol/fuzz/policy.bin
> >
> > --
> > 2.34.1
> >
>
> For the series:
> Acked-by: James Carter <jwcart2@gmail.com>
>
> As I noted, I will move the comment out of the expression when I apply pa=
tch 11.
>
> Thanks,
> Jim

This series has been merged.
Thanks,
Jim
