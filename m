Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F8CC07E95
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 19:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B8F611AC
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 19:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhGMTyP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:54:15 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:34511 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMTyP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 15:54:15 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EF55C56121C
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 21:51:16 +0200 (CEST)
Received: by mail-il1-f171.google.com with SMTP id e13so24433061ilc.1
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 12:51:16 -0700 (PDT)
X-Gm-Message-State: AOAM532t3s48VPZEtFxv8/uuOQcVNNmlllAeM8BoAQ2y4P7iTmxNGWQw
        Gnj9JNTlnXDfgUZomIjzaFf+4+ENiEEqzFPZVxs=
X-Google-Smtp-Source: ABdhPJznXfURhPu0kx2gLOBzGuUhHcLvyhSWqHG1DTCghANNLRDsOut8PjuFKEb4zPu+mmXEZUlA4QdQhcy39Z6gmmM=
X-Received: by 2002:a92:dc8e:: with SMTP id c14mr4186805iln.91.1626205875857;
 Tue, 13 Jul 2021 12:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210713000451.8039-1-evvers@ya.ru>
In-Reply-To: <20210713000451.8039-1-evvers@ya.ru>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 21:51:03 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nfrUqbvO_HMZUL0QLtu9GOND7X5-kM1ntnwLX7Le_bhg@mail.gmail.com>
Message-ID: <CAJfZ7=nfrUqbvO_HMZUL0QLtu9GOND7X5-kM1ntnwLX7Le_bhg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: move the fuzz target and build script to
 the selinux repository
To:     Evgeny Vereshchagin <evvers@ya.ru>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 21:51:17 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 13, 2021 at 2:05 AM Evgeny Vereshchagin <evvers@ya.ru> wrote:
>
> It should make it easier to reproduce bugs found by OSS-Fuzz locally
> without docker. The fuzz target can be built and run with the corpus
> OSS-Fuzz has accumulated so far by running the following commands:
> ```
> ./scripts/oss-fuzz.sh
> wget https://storage.googleapis.com/selinux-backup.clusterfuzz-external.appspot.com/corpus/libFuzzer/selinux_secilc-fuzzer/public.zip
> unzip -d CORPUS public.zip
> ./out/secilc-fuzzer CORPUS/
> ```

Hello,
Thanks for this patch! I have a couple of comments to improve it.

First, the instructions you gave (with wget + unzip) are useful and in
my humble opinion, they could be documented for example in a comment
at the beginning of scripts/oss-fuzz.sh ("# Usage: ...").

Second, shellcheck (https://www.shellcheck.net/)  reports many
warnings, such as missing quotes:

In scripts/oss-fuzz.sh line 19:
mkdir -p $OUT
         ^--^ SC2086: Double quote to prevent globbing and word splitting.

Even though naming directories with spaces breaks many tools, it is
good practice to avoid introducing more breakage, which is why quoting
paths is required. Could you please take a look at shellcheck output
and fix the issues it identifies?

More comments below...

> It was tested in https://github.com/google/oss-fuzz/pull/6026
> by pointing OSS-Fuzz to the branch containing the patch and
> running all the tests with all the sanitizers and fuzzing engines
> there: https://github.com/google/oss-fuzz/actions/runs/1024673143
>
> Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>
> ---
>  libsepol/fuzz/secilc-fuzzer.c | 69 +++++++++++++++++++++++++++++++++++
>  scripts/oss-fuzz.sh           | 28 ++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 libsepol/fuzz/secilc-fuzzer.c
>  create mode 100755 scripts/oss-fuzz.sh
>
> diff --git a/libsepol/fuzz/secilc-fuzzer.c b/libsepol/fuzz/secilc-fuzzer.c
> new file mode 100644
> index 00000000..255b3241
> --- /dev/null
> +++ b/libsepol/fuzz/secilc-fuzzer.c
> @@ -0,0 +1,69 @@
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <sys/stat.h>
> +
> +#include <sepol/cil/cil.h>
> +#include <sepol/policydb.h>
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
> +       enum cil_log_level log_level = CIL_ERR;
> +       struct sepol_policy_file *pf = NULL;
> +       FILE *dev_null = NULL;
> +       int target = SEPOL_TARGET_SELINUX;
> +       int disable_dontaudit = 0;
> +       int multiple_decls = 0;
> +       int disable_neverallow = 0;
> +       int preserve_tunables = 0;
> +       int policyvers = POLICYDB_VERSION_MAX;
> +       int mls = -1;
> +       int attrs_expand_generated = 0;
> +       struct cil_db *db = NULL;
> +       sepol_policydb_t *pdb = NULL;
> +
> +       cil_set_log_level(log_level);
> +
> +       cil_db_init(&db);
> +       cil_set_disable_dontaudit(db, disable_dontaudit);
> +       cil_set_multiple_decls(db, multiple_decls);
> +       cil_set_disable_neverallow(db, disable_neverallow);
> +       cil_set_preserve_tunables(db, preserve_tunables);
> +       cil_set_mls(db, mls);
> +       cil_set_target_platform(db, target);
> +       cil_set_policy_version(db, policyvers);
> +       cil_set_attrs_expand_generated(db, attrs_expand_generated);
> +
> +       if (cil_add_file(db, "fuzz", (const char *)data, size) != SEPOL_OK)
> +               goto exit;
> +
> +       if (cil_compile(db) != SEPOL_OK)
> +               goto exit;
> +
> +       if (cil_build_policydb(db, &pdb) != SEPOL_OK)
> +               goto exit;
> +
> +       if (sepol_policydb_optimize(pdb) != SEPOL_OK)
> +               goto exit;
> +
> +       dev_null = fopen("/dev/null", "w");
> +       if (dev_null == NULL)
> +               goto exit;
> +
> +       if (sepol_policy_file_create(&pf) != 0)
> +               goto exit;
> +
> +       sepol_policy_file_set_fp(pf, dev_null);
> +
> +       if (sepol_policydb_write(pdb, pf) != 0)
> +               goto exit;
> +exit:
> +       if (dev_null != NULL)
> +               fclose(dev_null);
> +
> +       cil_db_destroy(&db);
> +       sepol_policydb_free(pdb);
> +       sepol_policy_file_free(pf);
> +       return 0;
> +}
> diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
> new file mode 100755
> index 00000000..9e720a5c
> --- /dev/null
> +++ b/scripts/oss-fuzz.sh
> @@ -0,0 +1,28 @@
> +#!/bin/bash
> +
> +set -eux
> +
> +export DESTDIR=$(pwd)/DESTDIR

It is strange that $OUT is configurable but not $DESTDIR. Please add a
way to specify DESTDIR too.

> +
> +SANITIZER=${SANITIZER:-address}
> +flags="-O1 -fno-omit-frame-pointer -gline-tables-only -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fsanitize=$SANITIZER -fsanitize=fuzzer-no-link"
> +
> +export CC=${CC:-clang}
> +export CFLAGS=${CFLAGS:-$flags}
> +
> +export CXX=${CXX:-clang++}
> +export CXXFLAGS=${CXXFLAGS:-$flags}
> +
> +export LDFLAGS="${LDFLAGS:-} $CFLAGS"

Why do you need to include CFLAGS in LDFLAGS?

> +
> +export OUT=${OUT:-$(pwd)/out}
> +mkdir -p $OUT
> +
> +export LIB_FUZZING_ENGINE=${LIB_FUZZING_ENGINE:--fsanitize=fuzzer}
> +
> +find -name Makefile | xargs sed -i 's/,-z,defs//'

This is horrible for two reasons: it touches libsemanage/src/Makefile
even though the fuzzer only needs libsepol, and it modifies in-place
files which are versionned (with git).
I understand the issue you are trying to fix here is that building
with sanitizers leads to undefined symbols, but there are other
options:

* The most straightforward one is to prevent make from setting the
variable which adds "-z,defs", by building with "make ...
LD_SONAME_FLAGS="
* Another one consists in introducing a new Makefile variable, for
example named "ALLOW_UNDEFINED_SYMBOLS" and to modify the Makefiles to
only add -z,defs when this option is not defined.

> +make V=1 -j$(nproc) install

You do not need to build every sub-project. You can restrict the build
to libsepol with "make -C libsepol ...".

Moreover if the script is being launched from scripts/ ("cd scripts &&
./oss-fuzz.sh") this does not work. If you intend to be run from the
root directory, please insert a command which changes to the root
directory somewhere, like:

cd "$(dirname -- "$0")/.."

Or (if you do not want to chdir) please use a reference to this base
directory when you are using make and when you are compiling files.

Moreover if libsepol was already built, "make" will not rebuild it
even if the compiling option changed. Adding "make -C libsepol clean"
before invoking make could be useful.

> +
> +$CC $CFLAGS -I$DESTDIR/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -c -o secilc-fuzzer.o libsepol/fuzz/secilc-fuzzer.c
> +$CXX $CXXFLAGS $LIB_FUZZING_ENGINE secilc-fuzzer.o $DESTDIR/usr/lib/libsepol.a -o $OUT/secilc-fuzzer

Why are you using a C++ compiler to link the files? To my knowledge,
the fuzzing/sanitizing options available to clang++ linker are the
same as with clang. It would make the script easier to use if only one
compiler was used, but you have a reason to prefer using clang++,
please add a comment (in the script) about this.

> +zip -r $OUT/secilc-fuzzer_seed_corpus.zip secilc/test
> --
> 2.31.1
>

So I believe there are few things to improve in your patch. If you
have questions or if you disagree with some of my comments, feel free
to discuss. (And if other SELinux maintainers/members want to comment,
feel free to do so too ;) ).

Thanks,
Nicolas

