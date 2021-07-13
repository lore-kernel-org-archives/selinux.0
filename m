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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73200C07E9A
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 00:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F85C61152
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 00:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhGMAHq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 20:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhGMAHq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 20:07:46 -0400
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2640DC0613DD
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 17:04:57 -0700 (PDT)
Received: from sas1-cf895df4fa0e.qloud-c.yandex.net (sas1-cf895df4fa0e.qloud-c.yandex.net [IPv6:2a02:6b8:c14:390f:0:640:cf89:5df4])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id C0A1250E0B9B
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 03:04:51 +0300 (MSK)
Received: from sas1-37da021029ee.qloud-c.yandex.net (sas1-37da021029ee.qloud-c.yandex.net [2a02:6b8:c08:1612:0:640:37da:210])
        by sas1-cf895df4fa0e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id k0L7mn4EXl-4pH83Cmb;
        Tue, 13 Jul 2021 03:04:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1626134691;
        bh=uTiw33Xe4AoFKSEM2fnCS0cEJuVFGA6kk5tM8HF3p7M=;
        h=Date:Subject:To:From:Message-Id;
        b=lvRUUU5T8hUSBcUt2BmGX3IB55EXDRuw0JWmNWsEafkjYX0N9AxyeknqsTib3l1NV
         WJudmHFmFiJq5D87Ku713wI0KtnKJKFJeEKhHmIr7CtLGr56jpifUZaNQZ4Otlhoad
         AeAVnG7ru6g5UeuC5hi2azvoeV6CtYTpNO8+4B8A=
Authentication-Results: sas1-cf895df4fa0e.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Received: by sas1-37da021029ee.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id uLMHUkMTjw-4pPuPDjS;
        Tue, 13 Jul 2021 03:04:51 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Evgeny Vereshchagin <evvers@ya.ru>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: move the fuzz target and build script to the selinux repository
Date:   Tue, 13 Jul 2021 00:04:51 +0000
Message-Id: <20210713000451.8039-1-evvers@ya.ru>
X-Mailer: git-send-email 2.31.1
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

Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>
---
 libsepol/fuzz/secilc-fuzzer.c | 69 +++++++++++++++++++++++++++++++++++
 scripts/oss-fuzz.sh           | 28 ++++++++++++++
 2 files changed, 97 insertions(+)
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
index 00000000..9e720a5c
--- /dev/null
+++ b/scripts/oss-fuzz.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+set -eux
+
+export DESTDIR=$(pwd)/DESTDIR
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
+export LDFLAGS="${LDFLAGS:-} $CFLAGS"
+
+export OUT=${OUT:-$(pwd)/out}
+mkdir -p $OUT
+
+export LIB_FUZZING_ENGINE=${LIB_FUZZING_ENGINE:--fsanitize=fuzzer}
+
+find -name Makefile | xargs sed -i 's/,-z,defs//'
+make V=1 -j$(nproc) install
+
+$CC $CFLAGS -I$DESTDIR/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -c -o secilc-fuzzer.o libsepol/fuzz/secilc-fuzzer.c
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE secilc-fuzzer.o $DESTDIR/usr/lib/libsepol.a -o $OUT/secilc-fuzzer
+zip -r $OUT/secilc-fuzzer_seed_corpus.zip secilc/test
-- 
2.31.1

