Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A509C07E96
	for <selinux@archiver.kernel.org>; Thu, 15 Jul 2021 06:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C23F61358
	for <selinux@archiver.kernel.org>; Thu, 15 Jul 2021 06:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhGOGOc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Jul 2021 02:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhGOGOc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Jul 2021 02:14:32 -0400
Received: from forward103p.mail.yandex.net (forward103p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58015C06175F
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 23:11:39 -0700 (PDT)
Received: from sas1-0e0150e31af0.qloud-c.yandex.net (sas1-0e0150e31af0.qloud-c.yandex.net [IPv6:2a02:6b8:c14:392a:0:640:e01:50e3])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id D789E18C15A2;
        Thu, 15 Jul 2021 09:11:36 +0300 (MSK)
Received: from sas2-34ddad429748.qloud-c.yandex.net (sas2-34ddad429748.qloud-c.yandex.net [2a02:6b8:c08:b787:0:640:34dd:ad42])
        by sas1-0e0150e31af0.qloud-c.yandex.net (mxback/Yandex) with ESMTP id nFcLnsTc4s-BaI0dDhv;
        Thu, 15 Jul 2021 09:11:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1626329496;
        bh=fn6kNEoJ0DOu1lTD2zCVPJ7str4nyOy7jxDkpFOjvW4=;
        h=In-Reply-To:Subject:To:From:Message-Id:Cc:References:Date;
        b=AuFNo6DaPBk0XnvXyDA8C3n6EspDR91KDiwGBb/w61LvkMw4KcYhsyXEEAlwmoZA2
         dDEb4O89+O402yKXOx7pmi5vg7k1+to6oIc22YNQ0GrQf93IlUtmmUHt4PLevwwxc7
         FiGXvX43e6i6up8J2pflGpcXwn3TO2xUNeDSRY40=
Authentication-Results: sas1-0e0150e31af0.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Received: by sas2-34ddad429748.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id GTfB2r3fRe-BZ309C2f;
        Thu, 15 Jul 2021 09:11:35 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Evgeny Vereshchagin <evvers@ya.ru>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org
Subject: [PATCH v2] libsepol/cil: move the fuzz target and build script to the selinux repository
Date:   Thu, 15 Jul 2021 06:11:35 +0000
Message-Id: <20210715061135.2756-1-evvers@ya.ru>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAJfZ7=nfrUqbvO_HMZUL0QLtu9GOND7X5-kM1ntnwLX7Le_bhg@mail.gmail.com>
References: <CAJfZ7=nfrUqbvO_HMZUL0QLtu9GOND7X5-kM1ntnwLX7Le_bhg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It should make it easier to reproduce bugs found by OSS-Fuzz locally
without docker. The fuzz target can be built and run with the corpus
OSS-Fuzz has accumulated so far by running the following commands:
```
./scripts/oss-fuzz.sh
wget https://storage.googleapis.com/selinux-backup.clusterfuzz-external.appspot.com/corpus/libFuzzer/selinux_secilc-fuzzer/public.zip
unzip -d CORPUS public.zip
./out/secilc-fuzzer CORPUS/
```

It was tested in https://github.com/google/oss-fuzz/pull/6026
by pointing OSS-Fuzz to the branch containing the patch and
running all the tests with all the sanitizers and fuzzing engines
there: https://github.com/google/oss-fuzz/actions/runs/1024673143

[v2]
[1] oss-fuzz: make shellcheck happy

[2] oss-fuzz: build libsepol only

The fuzz target covers libsepol so it's unnecessary to build everything
else. Apart from that, the "LDFLAGS" kludge was removed since libsepol
is compatible with the sanitizers flags passed via CFLAGS only. It
should be brought back one way or another eventually though to fix
build failures like
```
clang -L/home/vagrant/selinux/selinux/DESTDIR/usr/lib -L/home/vagrant/selinux/selinux/DESTDIR/usr/lib -L../src  sefcontext_compile.o ../src/regex.o  -lselinux  -lpcre  ../src/libselinux.a -lsepol -o sefcontext_compile
/usr/bin/ld: sefcontext_compile.o: in function `usage':
/home/vagrant/selinux/selinux/libselinux/utils/sefcontext_compile.c:271: undefined reference to `__asan_report_load8'
/usr/bin/ld: /home/vagrant/selinux/selinux/libselinux/utils/sefcontext_compile.c:292: undefined reference to `__asan_handle_no_return'
/usr/bin/ld: sefcontext_compile.o: in function `asan.module_ctor':
```

[3] oss-fuzz: make it possible to run the script more than once
by removing various build artifacts

[4] oss-fuzz: make it possible to run the script from any directory

[5] oss-fuzz: be a little bit more specific about what the script does

[6] oss-fuzz: stop overwriting all the Makefiles

Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>
---
 libsepol/fuzz/secilc-fuzzer.c | 69 +++++++++++++++++++++++++++++++++++
 scripts/oss-fuzz.sh           | 59 ++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 libsepol/fuzz/secilc-fuzzer.c
 create mode 100755 scripts/oss-fuzz.sh

diff --git a/libsepol/fuzz/secilc-fuzzer.c b/libsepol/fuzz/secilc-fuzzer.c
new file mode 100644
index 00000000..255b3241
--- /dev/null
+++ b/libsepol/fuzz/secilc-fuzzer.c
@@ -0,0 +1,69 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <getopt.h>
+#include <sys/stat.h>
+
+#include <sepol/cil/cil.h>
+#include <sepol/policydb.h>
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
+	enum cil_log_level log_level = CIL_ERR;
+	struct sepol_policy_file *pf = NULL;
+	FILE *dev_null = NULL;
+	int target = SEPOL_TARGET_SELINUX;
+	int disable_dontaudit = 0;
+	int multiple_decls = 0;
+	int disable_neverallow = 0;
+	int preserve_tunables = 0;
+	int policyvers = POLICYDB_VERSION_MAX;
+	int mls = -1;
+	int attrs_expand_generated = 0;
+	struct cil_db *db = NULL;
+	sepol_policydb_t *pdb = NULL;
+
+	cil_set_log_level(log_level);
+
+	cil_db_init(&db);
+	cil_set_disable_dontaudit(db, disable_dontaudit);
+	cil_set_multiple_decls(db, multiple_decls);
+	cil_set_disable_neverallow(db, disable_neverallow);
+	cil_set_preserve_tunables(db, preserve_tunables);
+	cil_set_mls(db, mls);
+	cil_set_target_platform(db, target);
+	cil_set_policy_version(db, policyvers);
+	cil_set_attrs_expand_generated(db, attrs_expand_generated);
+
+	if (cil_add_file(db, "fuzz", (const char *)data, size) != SEPOL_OK)
+		goto exit;
+
+	if (cil_compile(db) != SEPOL_OK)
+		goto exit;
+
+	if (cil_build_policydb(db, &pdb) != SEPOL_OK)
+		goto exit;
+
+	if (sepol_policydb_optimize(pdb) != SEPOL_OK)
+		goto exit;
+
+	dev_null = fopen("/dev/null", "w");
+	if (dev_null == NULL)
+		goto exit;
+
+	if (sepol_policy_file_create(&pf) != 0)
+		goto exit;
+
+	sepol_policy_file_set_fp(pf, dev_null);
+
+	if (sepol_policydb_write(pdb, pf) != 0)
+		goto exit;
+exit:
+	if (dev_null != NULL)
+		fclose(dev_null);
+
+	cil_db_destroy(&db);
+	sepol_policydb_free(pdb);
+	sepol_policy_file_free(pf);
+	return 0;
+}
diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
new file mode 100755
index 00000000..16cc3c0a
--- /dev/null
+++ b/scripts/oss-fuzz.sh
@@ -0,0 +1,59 @@
+#!/bin/bash
+
+# The script is used to build the fuzz targets run on ClusterFuzz. It has to be
+# compatible with the "build.sh" script described at
+# https://google.github.io/oss-fuzz/getting-started/new-project-guide/#buildsh
+# More precisely, it should use environment variables like OUT, LIB_FUZZING_ENGINE
+# and so on (https://google.github.io/oss-fuzz/getting-started/new-project-guide/#buildsh-script-environment),
+# and the fuzz targets have to be linked with $CXX even though the project is written
+# in C: https://google.github.io/oss-fuzz/getting-started/new-project-guide/#Requirements
+
+# To make it easier to build the fuzz targets locally, the script can also work in "local"
+# mode. To run secilc-fuzzer against a test case (named, say, CRASH) triggering an issue
+# the following commands should be run
+#
+# $ ./scripts/oss-fuzz.sh
+# $ ./out/secilc-fuzzer CRASH
+
+# To run the fuzzer against the corpus OSS-Fuzz has accumulated so far it should be
+# downloaded, unpacked and passed to the fuzzer:
+#
+# $ wget https://storage.googleapis.com/selinux-backup.clusterfuzz-external.appspot.com/corpus/libFuzzer/selinux_secilc-fuzzer/public.zip
+# $ unzip -d CORPUS public.zip
+# $ ./out/secilc-fuzzer CORPUS/
+
+set -eux
+
+cd "$(dirname -- "$0")/.."
+
+export DESTDIR=${DESTDIR:-$(pwd)/DESTDIR}
+
+SANITIZER=${SANITIZER:-address}
+flags="-O1 -fno-omit-frame-pointer -gline-tables-only -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fsanitize=$SANITIZER -fsanitize=fuzzer-no-link"
+
+export CC=${CC:-clang}
+export CFLAGS=${CFLAGS:-$flags}
+
+export CXX=${CXX:-clang++}
+export CXXFLAGS=${CXXFLAGS:-$flags}
+
+export OUT=${OUT:-$(pwd)/out}
+mkdir -p "$OUT"
+
+export LIB_FUZZING_ENGINE=${LIB_FUZZING_ENGINE:--fsanitize=fuzzer}
+
+rm -rf "$DESTDIR"
+make -C libsepol clean
+# LIBSO and LIBMAP shouldn't be expanded here because their values are unknown until Makefile
+# has been read by make
+# shellcheck disable=SC2016
+make -C libsepol V=1 LD_SONAME_FLAGS='-soname,$(LIBSO),--version-script=$(LIBMAP)' -j"$(nproc)" install
+
+# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
+# the compiler/linker so they shouldn't be quoted
+# shellcheck disable=SC2086
+$CC $CFLAGS -I"$DESTDIR/usr/include" -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -c -o secilc-fuzzer.o libsepol/fuzz/secilc-fuzzer.c
+# shellcheck disable=SC2086
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE secilc-fuzzer.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/secilc-fuzzer"
+
+zip -r "$OUT/secilc-fuzzer_seed_corpus.zip" secilc/test
-- 
2.31.1

