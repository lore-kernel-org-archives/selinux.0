Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B5EC4338F
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F171F604AC
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 18:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhHQSmv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhHQSmu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Aug 2021 14:42:50 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557EC061764
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 11:42:17 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so26033667oth.7
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fr51enrrMR+bBuV5L65mxuNjE7zH/pawpfGQxytC7K8=;
        b=YecfaneIRkvhCxUL1EmSnsLZ/k5Znc4soeEE/eUp3NQpMoJnsN94ntkJSAlO9EZ+p+
         G2XUN5r5qcKE1j9tyNWTOIQZBJFIzVT6GqJcUtZTl3XYOIVXx0nMaJitRgwWwJX8Cl0j
         O0FNCLkUZ/qlr1j3dCoQJY/AkkJaafHov7VuxObymyEwx4ecSz7FViks8gpbajDWNSXO
         nGVgcisMf+gksAjctAbnEeA3k6nEvyH09Zi/vtJvE5Tug1l9E9AL2ybl7YdC9mZTzXuU
         +dYExWdpc0svBYCP8cllWX310uDuCuiCUDhi6eUF+KUjfQz9v2qeYX9QxRDEFtBlU6hr
         pKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fr51enrrMR+bBuV5L65mxuNjE7zH/pawpfGQxytC7K8=;
        b=rrNdRw7mcEmA/3ZxfKe0Ctkqt1CwnKXq0sVNIvb0IZJvyPdGz6AK7W0aWtExigBTh3
         smQSikGTtsSVGZJOYCr6BDBO9eJxWqBL11rhZgLSzFQjQ1BQ3NKysQoNZ6SaVzFBp3PQ
         yLQPCNpKmZCsuR36T9f+JMspjZRK6PtqdRn4YmB4nbisPUyuSnU723hCb4uXFIw35E4J
         5XnhpFJydjtQsWTO24qIinpsZSs2L5tU2araAsejoB+cqcqqPLh4sYVeOmvfoZbtIFLK
         KF69i6GNYqHdNbsOWdr1lZk4U5BDVy8pqPEXnOPkEzGPEEP6yH/IKc8qWWVZR9ktztJm
         lF4A==
X-Gm-Message-State: AOAM531pLri3W9xze9ksKEzLFpcuDAiXZqpwH0Arxm8ntwinnOmDgo50
        WUL6CiAjRVmVQJyRzZrnxJ1yJexBJxtDYHr8qjo=
X-Google-Smtp-Source: ABdhPJxBkswqPIitESavF1citV4vRA7qaYZRZUiPydjlUkA4sCdQvw8+9Lh64u/q/k1aq7t09ycejKdioNSa+eujmZs=
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr3645458otq.59.1629225736958;
 Tue, 17 Aug 2021 11:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=nfrUqbvO_HMZUL0QLtu9GOND7X5-kM1ntnwLX7Le_bhg@mail.gmail.com>
 <20210715061135.2756-1-evvers@ya.ru> <CAJfZ7=mDwifrEnFpcJxznSHTDbPwYhkzo1MyZ+-pvsUyiCTBWA@mail.gmail.com>
In-Reply-To: <CAJfZ7=mDwifrEnFpcJxznSHTDbPwYhkzo1MyZ+-pvsUyiCTBWA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 17 Aug 2021 14:42:06 -0400
Message-ID: <CAP+JOzQ_SUGHFVr_xJx3xipHOjCpmMifn9cTbJBS4BnEUB4jCw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: move the fuzz target and build script to
 the selinux repository
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Evgeny Vereshchagin <evvers@ya.ru>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 16, 2021 at 5:16 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jul 15, 2021 at 8:11 AM Evgeny Vereshchagin <evvers@ya.ru> wrote:
> >
> > It should make it easier to reproduce bugs found by OSS-Fuzz locally
> > without docker. The fuzz target can be built and run with the corpus
> > OSS-Fuzz has accumulated so far by running the following commands:
> > ```
> > ./scripts/oss-fuzz.sh
> > wget https://storage.googleapis.com/selinux-backup.clusterfuzz-external.appspot.com/corpus/libFuzzer/selinux_secilc-fuzzer/public.zip
> > unzip -d CORPUS public.zip
> > ./out/secilc-fuzzer CORPUS/
> > ```
> >
> > It was tested in https://github.com/google/oss-fuzz/pull/6026
> > by pointing OSS-Fuzz to the branch containing the patch and
> > running all the tests with all the sanitizers and fuzzing engines
> > there: https://github.com/google/oss-fuzz/actions/runs/1024673143
> >
> > [v2]
> > [1] oss-fuzz: make shellcheck happy
> >
> > [2] oss-fuzz: build libsepol only
> >
> > The fuzz target covers libsepol so it's unnecessary to build everything
> > else. Apart from that, the "LDFLAGS" kludge was removed since libsepol
> > is compatible with the sanitizers flags passed via CFLAGS only. It
> > should be brought back one way or another eventually though to fix
> > build failures like
> > ```
> > clang -L/home/vagrant/selinux/selinux/DESTDIR/usr/lib -L/home/vagrant/selinux/selinux/DESTDIR/usr/lib -L../src  sefcontext_compile.o ../src/regex.o  -lselinux  -lpcre  ../src/libselinux.a -lsepol -o sefcontext_compile
> > /usr/bin/ld: sefcontext_compile.o: in function `usage':
> > /home/vagrant/selinux/selinux/libselinux/utils/sefcontext_compile.c:271: undefined reference to `__asan_report_load8'
> > /usr/bin/ld: /home/vagrant/selinux/selinux/libselinux/utils/sefcontext_compile.c:292: undefined reference to `__asan_handle_no_return'
> > /usr/bin/ld: sefcontext_compile.o: in function `asan.module_ctor':
> > ```
> >
> > [3] oss-fuzz: make it possible to run the script more than once
> > by removing various build artifacts
> >
> > [4] oss-fuzz: make it possible to run the script from any directory
> >
> > [5] oss-fuzz: be a little bit more specific about what the script does
> >
> > [6] oss-fuzz: stop overwriting all the Makefiles
> >
> > Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>
>
> Sorry for the delay. I have now been able to review and test your
> script and it seems to work perfectly. Thanks!
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged.
Thanks,
Jim

> Thanks,
> Nicolas
>
> > ---
> >  libsepol/fuzz/secilc-fuzzer.c | 69 +++++++++++++++++++++++++++++++++++
> >  scripts/oss-fuzz.sh           | 59 ++++++++++++++++++++++++++++++
> >  2 files changed, 128 insertions(+)
> >  create mode 100644 libsepol/fuzz/secilc-fuzzer.c
> >  create mode 100755 scripts/oss-fuzz.sh
> >
> > diff --git a/libsepol/fuzz/secilc-fuzzer.c b/libsepol/fuzz/secilc-fuzzer.c
> > new file mode 100644
> > index 00000000..255b3241
> > --- /dev/null
> > +++ b/libsepol/fuzz/secilc-fuzzer.c
> > @@ -0,0 +1,69 @@
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <stdint.h>
> > +#include <string.h>
> > +#include <getopt.h>
> > +#include <sys/stat.h>
> > +
> > +#include <sepol/cil/cil.h>
> > +#include <sepol/policydb.h>
> > +
> > +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
> > +       enum cil_log_level log_level = CIL_ERR;
> > +       struct sepol_policy_file *pf = NULL;
> > +       FILE *dev_null = NULL;
> > +       int target = SEPOL_TARGET_SELINUX;
> > +       int disable_dontaudit = 0;
> > +       int multiple_decls = 0;
> > +       int disable_neverallow = 0;
> > +       int preserve_tunables = 0;
> > +       int policyvers = POLICYDB_VERSION_MAX;
> > +       int mls = -1;
> > +       int attrs_expand_generated = 0;
> > +       struct cil_db *db = NULL;
> > +       sepol_policydb_t *pdb = NULL;
> > +
> > +       cil_set_log_level(log_level);
> > +
> > +       cil_db_init(&db);
> > +       cil_set_disable_dontaudit(db, disable_dontaudit);
> > +       cil_set_multiple_decls(db, multiple_decls);
> > +       cil_set_disable_neverallow(db, disable_neverallow);
> > +       cil_set_preserve_tunables(db, preserve_tunables);
> > +       cil_set_mls(db, mls);
> > +       cil_set_target_platform(db, target);
> > +       cil_set_policy_version(db, policyvers);
> > +       cil_set_attrs_expand_generated(db, attrs_expand_generated);
> > +
> > +       if (cil_add_file(db, "fuzz", (const char *)data, size) != SEPOL_OK)
> > +               goto exit;
> > +
> > +       if (cil_compile(db) != SEPOL_OK)
> > +               goto exit;
> > +
> > +       if (cil_build_policydb(db, &pdb) != SEPOL_OK)
> > +               goto exit;
> > +
> > +       if (sepol_policydb_optimize(pdb) != SEPOL_OK)
> > +               goto exit;
> > +
> > +       dev_null = fopen("/dev/null", "w");
> > +       if (dev_null == NULL)
> > +               goto exit;
> > +
> > +       if (sepol_policy_file_create(&pf) != 0)
> > +               goto exit;
> > +
> > +       sepol_policy_file_set_fp(pf, dev_null);
> > +
> > +       if (sepol_policydb_write(pdb, pf) != 0)
> > +               goto exit;
> > +exit:
> > +       if (dev_null != NULL)
> > +               fclose(dev_null);
> > +
> > +       cil_db_destroy(&db);
> > +       sepol_policydb_free(pdb);
> > +       sepol_policy_file_free(pf);
> > +       return 0;
> > +}
> > diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
> > new file mode 100755
> > index 00000000..16cc3c0a
> > --- /dev/null
> > +++ b/scripts/oss-fuzz.sh
> > @@ -0,0 +1,59 @@
> > +#!/bin/bash
> > +
> > +# The script is used to build the fuzz targets run on ClusterFuzz. It has to be
> > +# compatible with the "build.sh" script described at
> > +# https://google.github.io/oss-fuzz/getting-started/new-project-guide/#buildsh
> > +# More precisely, it should use environment variables like OUT, LIB_FUZZING_ENGINE
> > +# and so on (https://google.github.io/oss-fuzz/getting-started/new-project-guide/#buildsh-script-environment),
> > +# and the fuzz targets have to be linked with $CXX even though the project is written
> > +# in C: https://google.github.io/oss-fuzz/getting-started/new-project-guide/#Requirements
> > +
> > +# To make it easier to build the fuzz targets locally, the script can also work in "local"
> > +# mode. To run secilc-fuzzer against a test case (named, say, CRASH) triggering an issue
> > +# the following commands should be run
> > +#
> > +# $ ./scripts/oss-fuzz.sh
> > +# $ ./out/secilc-fuzzer CRASH
> > +
> > +# To run the fuzzer against the corpus OSS-Fuzz has accumulated so far it should be
> > +# downloaded, unpacked and passed to the fuzzer:
> > +#
> > +# $ wget https://storage.googleapis.com/selinux-backup.clusterfuzz-external.appspot.com/corpus/libFuzzer/selinux_secilc-fuzzer/public.zip
> > +# $ unzip -d CORPUS public.zip
> > +# $ ./out/secilc-fuzzer CORPUS/
> > +
> > +set -eux
> > +
> > +cd "$(dirname -- "$0")/.."
> > +
> > +export DESTDIR=${DESTDIR:-$(pwd)/DESTDIR}
> > +
> > +SANITIZER=${SANITIZER:-address}
> > +flags="-O1 -fno-omit-frame-pointer -gline-tables-only -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fsanitize=$SANITIZER -fsanitize=fuzzer-no-link"
> > +
> > +export CC=${CC:-clang}
> > +export CFLAGS=${CFLAGS:-$flags}
> > +
> > +export CXX=${CXX:-clang++}
> > +export CXXFLAGS=${CXXFLAGS:-$flags}
> > +
> > +export OUT=${OUT:-$(pwd)/out}
> > +mkdir -p "$OUT"
> > +
> > +export LIB_FUZZING_ENGINE=${LIB_FUZZING_ENGINE:--fsanitize=fuzzer}
> > +
> > +rm -rf "$DESTDIR"
> > +make -C libsepol clean
> > +# LIBSO and LIBMAP shouldn't be expanded here because their values are unknown until Makefile
> > +# has been read by make
> > +# shellcheck disable=SC2016
> > +make -C libsepol V=1 LD_SONAME_FLAGS='-soname,$(LIBSO),--version-script=$(LIBMAP)' -j"$(nproc)" install
> > +
> > +# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
> > +# the compiler/linker so they shouldn't be quoted
> > +# shellcheck disable=SC2086
> > +$CC $CFLAGS -I"$DESTDIR/usr/include" -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -c -o secilc-fuzzer.o libsepol/fuzz/secilc-fuzzer.c
> > +# shellcheck disable=SC2086
> > +$CXX $CXXFLAGS $LIB_FUZZING_ENGINE secilc-fuzzer.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/secilc-fuzzer"
> > +
> > +zip -r "$OUT/secilc-fuzzer_seed_corpus.zip" secilc/test
> > --
> > 2.31.1
> >
>
