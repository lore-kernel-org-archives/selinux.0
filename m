Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F6C433FE
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F06E61108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhKEPsa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhKEPsa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35058C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v11so31970069edc.9
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b9FTARu2DlZy1P3z+H5oOpXuVIsNQKThaiuWCTyQnxE=;
        b=hGkMakSZYYxD0/PHOoZACJHFePwykmXu129B2SbfTllTjKasyql3Ti/yQyWaLRBIAj
         KOIYjI6KQQRP/Odn4Ld+epLRJ9eRK7+RYubnAUJFo2ClF2rb13m2Dl2mwey5Z5g66WNy
         YJUjAb6KsLxEwbh8wawKzTL8i8LeuljfAUxKgCZG4xlDfx+K06gX7Os8VPI0BFzn8S1o
         9ZKWjrR5B8Fh7zqit5XQUBpgIKqrOWAPNnRdbggjvXuTOjo4X/F5MOWnDSAmfgXjvCnO
         Actyopcb5/KUmTQTf1VDGwliS5gK7f1Z9B/30qJ1yF0PPaq9ZtlDtstZEJxfNl2FzJNR
         yg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9FTARu2DlZy1P3z+H5oOpXuVIsNQKThaiuWCTyQnxE=;
        b=2LR7CUbZ746P/Wv0JN87VppYfsoFIOI5WjoQVQ0aI+EZno+KPQewntVLPsTVmores1
         K7dBG3Mj9wOjnzpjsWrbWHPmqAx6WE4/tSq6kwgAoABU2Z5RXLW/ROy4m5GdoKdesLPS
         HOY3kmqj1LFt1XZb2Hc8Mbl+ifS9uN8F6TYJZMtuCJ+WRKdVFpYsPHTYrlyhDWVynkvh
         3yU5jHBiXpeSWaSArWPBDFKEWnWz+gNUNH6ZSXX3Vh6D70Oe8GJfIIwq9k3HwQPFAw+n
         TXARQg7J+h5zQsG/QCORg491pnFztBv4BgMjbpr1ZuAChUNsWHUzvoBzH5ULDGzwe7V3
         h/zQ==
X-Gm-Message-State: AOAM533J3xmF1RobQYPKVyXsfhpX3pR/HHYtgIBXqNKX7Wgz3ebF5SIo
        8HDvTMr4Nf+lQyuJR6QuecAOk8odbEk=
X-Google-Smtp-Source: ABdhPJzLQlDT4jaxaAmkLjT+7UCJNPLOCqNiUk/sgNpefk6mbO4OFNFX6ye/vkru09JxE3U0KvnZXA==
X-Received: by 2002:a50:950b:: with SMTP id u11mr79318779eda.121.1636127148648;
        Fri, 05 Nov 2021 08:45:48 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 04/36] libsepol: add libfuzz based fuzzer for reading binary policies
Date:   Fri,  5 Nov 2021 16:45:06 +0100
Message-Id: <20211105154542.38434-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
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
2.33.1

