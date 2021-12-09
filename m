Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7A1C433FE
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhLIQzG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbhLIQzF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B10C0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l25so21579351eda.11
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=thmUdQlFoJs9efM2nchB5gnDJZxq/4Vysko9GqLtnH4=;
        b=QVd0f/Wr+4KHdsQvrBV9Yi8nfpPsu21oSqwlp0kojl5g0TRBPhAAIbkQEAWIkdEN0N
         tEOknC+V5w+lLHfqigRJNT0jpU9Un5dgeab6H3hFNm2SVNA8SxctaiqOHEG8m/Jqsi3J
         sOi7YbygbzbDn+J8aGyRCPSUz6PNLAcpqU4xdVEThJvNx+Rdlvm8OkP6HNUDCon9ffs7
         1tPPwDytit3yGNgkrZfoLUVN+11yN521Whz3gtUq3DRW6IGkP40FaV8Nf3e5R6gTBnPV
         1UCdSfjHo6IwVMvS+h8ft2CN7XUBTHCbC0z3MOHAHJd8nOqYIuuKKZ9tIPI/l77hBeKk
         5wRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thmUdQlFoJs9efM2nchB5gnDJZxq/4Vysko9GqLtnH4=;
        b=whhQ4+lMDy8/ezkSY9AC4xWvtOux3Jj5nxgjzgtTZUF+6bAeKadOJTBN99sDnKygLX
         vy2GogWfjb0xEtFmfEc0NizvzC5/e8xFPplFuAie1B6YSbJj0ryrm4LwUdNkNcbcoTK9
         2OxqaEOXSDaox73TOet51HkHVpdRsTKuQAI1LHY0skEO22+129v8P14eJTW7Y6riLRpG
         oSv5zOLSkVkv3bWS2bYK3IgwH2iozONCEs1+6WstV3ZimYjAEjeMxiAmLWZ+Jkk1tpLi
         INkr5Rw/KWKPmaLegYS2Ah8JMA5JQwiru6R5BY0h2u3X1/UU3Li/jwZezf0kPuBwCoUf
         jPyg==
X-Gm-Message-State: AOAM531bWKrHvneHo5CpTxSV4pVF1Pvnlt8Ort4f3voL6jMGxJxx5ijF
        K/CJxknNV5fGoJveTFjpu9cG60/tBV4=
X-Google-Smtp-Source: ABdhPJxItLt3LlnUJukY3P72bR0YFI13EtIKBgU7R9+YwM6w9qpzFkqCQY42PiUuSHzMWulH0L5f2w==
X-Received: by 2002:a05:6402:1ca2:: with SMTP id cz2mr29574158edb.302.1639068577926;
        Thu, 09 Dec 2021 08:49:37 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:37 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 04/36] libsepol: add libfuzz based fuzzer for reading binary policies
Date:   Thu,  9 Dec 2021 17:48:56 +0100
Message-Id: <20211209164928.87459-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
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
 scripts/oss-fuzz.sh              |  17 ++++++++-
 3 files changed, 78 insertions(+), 2 deletions(-)
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
index 16cc3c0a..72d275e8 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -32,7 +32,7 @@ SANITIZER=${SANITIZER:-address}
 flags="-O1 -fno-omit-frame-pointer -gline-tables-only -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fsanitize=$SANITIZER -fsanitize=fuzzer-no-link"
 
 export CC=${CC:-clang}
-export CFLAGS=${CFLAGS:-$flags}
+export CFLAGS="${CFLAGS:-$flags} -I$DESTDIR/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64"
 
 export CXX=${CXX:-clang++}
 export CXXFLAGS=${CXXFLAGS:-$flags}
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
2.34.1

