Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85F5C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF4C60E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhJKQ2Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhJKQ2Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C136CC06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w19so10006043edd.2
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xajaQmopyTOLAu+vJNeq5dQLJ9VvvQH/FyCEGg7UM4s=;
        b=d8A0nrbPD7k7hx/HbThMndlBvMTqJnPgm7vrbJxwznhehSHWJPrAsRSKpENBxduDhW
         NEcRK6Ocf3orKyPcVaFmQPsXjuG3y9V93nQLuGCv07+R9FzxjPddCU9jFWmSaGX5J4Vd
         XwZDXz4QxY/hx2jndT1PFk20klHpytiwZ9/5161FEOc0gok8PuGxXXNRw8LUxE/SUFFL
         elFf+YiqPFZWe+rBD6b/smlk12WlGqBmFvz/aZcXe9CzdgQYpSLP6FSF1rhHeLmlSG7z
         6aEIfcjqbW7gEywR9DYJEXv+ZJjgBWkX7q+aXAA2P9IRqtevKXOSg9WpDrfZvaN9tmgO
         ZNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xajaQmopyTOLAu+vJNeq5dQLJ9VvvQH/FyCEGg7UM4s=;
        b=ejy0bOWR0UXyo9hkpBVS13z57OYTKZKXUhhZ9MTn/lweZsNKeZSRhaDkXKoRfBZWgQ
         ebgXoE3Pp5D7Ec7DKNI8dWgYDe8v/r7oJVKPedUrgnpIQU3zbTVm06AplJsJ73Pr2NMw
         8wgqZDgXJAMl82Z4Ia0KGpknh8Vr2doXo+JE0Ag6YrYtY2ZuVG/DkNJR17Q/mBqRI1Sz
         5IUuzwTTHEhvLvyhkJPeqWBbVYH1YQJNA9vAtwJet8VHnq/Ln7uNKHVIIM/khcm0ZuI+
         rtnEkNxSvldu7thcc+UlAaXbAbgoc93KxkhPXpvmzjGAQEefTCsQRsZD8eDYJF6SSaW8
         XYLw==
X-Gm-Message-State: AOAM530Mm4VtaLbKINdboQDRjmeXG15BDTw6O7PRQ3wn2AFFogGfkH0t
        LpNdIWokhTxPxDToMT6KM4SZnvn4+A4=
X-Google-Smtp-Source: ABdhPJywKDk5NUF9z/yLS5snwKuaSvnzVXYms1WGxgI0YdF09+Oc7IIopROj1JO2sJxwnaglUmOhwQ==
X-Received: by 2002:a05:6402:4409:: with SMTP id y9mr32347002eda.184.1633969583288;
        Mon, 11 Oct 2021 09:26:23 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 04/35] libsepol: add libfuzz based fuzzer for reading binary policies
Date:   Mon, 11 Oct 2021 18:25:02 +0200
Message-Id: <20211011162533.53404-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Introduce a libfuzz[1] based fuzzer testing the parsing of a binary
policy.

Build the fuzzer in the oss-fuzz script.

[1]: https://llvm.org/docs/LibFuzzer.html

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/fuzz/binpolicy-fuzzer.c |  63 +++++++++++++++++++++++++++++++
 libsepol/fuzz/policy.bin         | Bin 0 -> 1552 bytes
 scripts/oss-fuzz.sh              |  19 ++++++++--
 3 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 libsepol/fuzz/binpolicy-fuzzer.c
 create mode 100644 libsepol/fuzz/policy.bin

diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
new file mode 100644
index 00000000..85c59645
--- /dev/null
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -0,0 +1,63 @@
+#include <sepol/debug.h>
+#include <sepol/kernel_to_cil.h>
+#include <sepol/kernel_to_conf.h>
+#include <sepol/policydb/policydb.h>
+
+extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+static int write_binary_policy(policydb_t *p, FILE *outfp)
+{
+	struct policy_file pf;
+
+	policy_file_init(&pf);
+	pf.type = PF_USE_STDIO;
+	pf.fp = outfp;
+	return policydb_write(p, &pf);
+}
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	policydb_t policydb = {};
+	sidtab_t sidtab = {};
+	struct policy_file pf;
+	FILE *devnull = NULL;
+
+	sepol_debug(0);
+
+	policy_file_init(&pf);
+	pf.type = PF_USE_MEMORY;
+	pf.data = (char *) data;
+	pf.len = size;
+
+	if (policydb_init(&policydb))
+		goto exit;
+
+	if (policydb_read(&policydb, &pf, /*verbose=*/0))
+		goto exit;
+
+	if (policydb_load_isids(&policydb, &sidtab))
+		goto exit;
+
+	if (policydb.policy_type == POLICY_KERN)
+		(void) policydb_optimize(&policydb);
+
+	devnull = fopen("/dev/null", "w");
+	if (!devnull)
+		goto exit;
+
+	(void) write_binary_policy(&policydb, devnull);
+
+	(void) sepol_kernel_policydb_to_conf(devnull, &policydb);
+
+	(void) sepol_kernel_policydb_to_cil(devnull, &policydb);
+
+exit:
+	if (devnull != NULL)
+		fclose(devnull);
+
+	policydb_destroy(&policydb);
+	sepol_sidtab_destroy(&sidtab);
+
+	/* Non-zero return values are reserved for future use. */
+	return 0;
+}
diff --git a/libsepol/fuzz/policy.bin b/libsepol/fuzz/policy.bin
new file mode 100644
index 0000000000000000000000000000000000000000..6f977ef34479daa9bf2e848c502ecea8d96f7912
GIT binary patch
literal 1552
zcma)5OLBuS3?==4PtZ+{&?9)$U3WbIlYnX65X0D})6Db;y>M5p9{5ov4Nx%;$<mW$
z3H<r}@pX|T$<xE~(b(pFDfU7D-=#naD2m2Fg9jW(-^m~bGdGSNY)e53<fv2qdtGkQ
z!jzhhLpdx(PWIwvbIwVQy0qhU$VF|O4}e{}D%0NI#$~><!L6(}!BqAt@_s$c!a#sw
zC$j7XLx!Aos(%-zs7Bl3l+Sv4XN--GML2e*`6?Tq1A9jjY>40a)K#TcVgu}o@qItz
z*n@Vpe$`n>9k>)lLo|5!#vC+5dA)f~edbIZ(r^=r47z&T$5@O7acJXBjy1qIauI91
zZV#hm%^Wra%{;^@N(_Mfp@x57&=A0V{XH^N#4uZ2$+ZB!To<dR3|?FRA3At3Wr~g%
zz~016vi3X+@#ERQVqoAOx)TgDxswt<g<podAL6jTDGsjGTrHewj)RLe$3eey9G;aL
td_V~(^i6Tdr3M$kUC#Ae9okPlwF6@KhlL%sbur5q>K{?!0dQgn^$*KOS$hBg

literal 0
HcmV?d00001

diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 16cc3c0a..14bad14d 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -32,10 +32,10 @@ SANITIZER=${SANITIZER:-address}
 flags="-O1 -fno-omit-frame-pointer -gline-tables-only -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fsanitize=$SANITIZER -fsanitize=fuzzer-no-link"
 
 export CC=${CC:-clang}
-export CFLAGS=${CFLAGS:-$flags}
+export CFLAGS="${CFLAGS:-$flags} -I$DESTDIR/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64"
 
 export CXX=${CXX:-clang++}
-export CXXFLAGS=${CXXFLAGS:-$flags}
+export CXXFLAGS="${CXXFLAGS:-$flags}"
 
 export OUT=${OUT:-$(pwd)/out}
 mkdir -p "$OUT"
@@ -49,11 +49,24 @@ make -C libsepol clean
 # shellcheck disable=SC2016
 make -C libsepol V=1 LD_SONAME_FLAGS='-soname,$(LIBSO),--version-script=$(LIBMAP)' -j"$(nproc)" install
 
+## secilc fuzzer ##
+
 # CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
 # the compiler/linker so they shouldn't be quoted
 # shellcheck disable=SC2086
-$CC $CFLAGS -I"$DESTDIR/usr/include" -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -c -o secilc-fuzzer.o libsepol/fuzz/secilc-fuzzer.c
+$CC $CFLAGS -c -o secilc-fuzzer.o libsepol/fuzz/secilc-fuzzer.c
 # shellcheck disable=SC2086
 $CXX $CXXFLAGS $LIB_FUZZING_ENGINE secilc-fuzzer.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/secilc-fuzzer"
 
 zip -r "$OUT/secilc-fuzzer_seed_corpus.zip" secilc/test
+
+## binary policy fuzzer ##
+
+# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
+# the compiler/linker so they shouldn't be quoted
+# shellcheck disable=SC2086
+$CC $CFLAGS -c -o binpolicy-fuzzer.o libsepol/fuzz/binpolicy-fuzzer.c
+# shellcheck disable=SC2086
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/binpolicy-fuzzer"
+
+zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bin
-- 
2.33.0

