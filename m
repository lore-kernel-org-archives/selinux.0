Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B841D12E
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925110; cv=none; b=DWpmE7o972fCyn5edIQCZbNn2Z78xICBDoorL1417cSJDdPCW2t44XeFXOzwxj4Vr20oQp3Q+BYnfWzFYMZUBaKRjwBr39Vnn4iMVda6yvWSDuYhZ6nl1Y01LjGtTFB+xhQ7DFqNIqErN0ic+LPfshh45h3dZF8fAr5p65AJpYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925110; c=relaxed/simple;
	bh=UfFrHGYVSM3/rnCnZDoaFcPoLAH4s2oGZugDSllkcfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btv9bkUK3m0hx0c+6w/foFZqzABdIVOJqWC6Of7no13z65hYzzlOYGU7jdABHuzgKQYmQieiyqyNLpMfMC22GikHa0x41+RZ3ODcXn6QWoKldtnMe40lsbL+3Hiocx4lf2890VFJTWox42yNL6ZK7Vnu2unb06vEsG1Xx5RyhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEnLD85a; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEnLD85a"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c4436d02cso3723311cf.1
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785925101; x=1786529901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujpHs3PfRJjFFZCbSqMCngYpk4iOIUD/fatI+7nY3g8=;
        b=LEnLD85a9f9f+aNit46InpH+8yoo1pGrkJVkpwvEGRF/K2gEr67I7qsRxOAUNfPiX/
         Pqr2SUNZHG2WRq2vxm/x55zyxw7wQXERzwZkdnmUEHNeP6W5i1DKWnqDqi2R27HdQUAm
         Rg9ePjuque1IMmptKr8FpASul33Otl8XYilfOVUTg6oHEpg24kQBKkwIeH3pl7uRX/+5
         zQMJrBFIQLIyb/erbecqY8CixdRI6tVM/zjygPwAyk3UuGMBkwi/6IzolPq9VH6CfG+I
         pGt5S+/Fj6A5PduY+facASb7Rw9XuqXZpZ+Zq3N4HCGn2qG4iuu/LwbKlSMUnmtL1zJS
         fY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925101; x=1786529901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujpHs3PfRJjFFZCbSqMCngYpk4iOIUD/fatI+7nY3g8=;
        b=H+MIcIw8UtpUcOSoanwLSOGnmfjwTOR0y6aYqXFLE0ph4yTT4Sb/Xa1SOrY2CCOF96
         guZMX1H7xYC4rM+QcnnSuGMVmJjV8Wzk/0twYcNfZhCOxTDfJ8VSn9JDSzyORh6C1hGP
         zt5D3bpYrQ5E77nhzG3APkwK7cqRJJ+oOeVQJMYHoW58z/TPQ1OyOJQ4NHwomkV6mdik
         FnSY8je/y974tQx2apiEqVERReNbh5lLPHR6s5oO8MTzHpJc5c91OmA1AlLB8Whu+uM2
         qxroyqNgG1Aanh018hXxWviyCZhH0St5cUilNQMJ/RhpRRacdfWa281wg+Ot79qKh5+5
         YhAg==
X-Gm-Message-State: AOJu0YwNxl24yd3uQK+Q10Cr2FbnC+/yYxWPfXlwEzmsekDHY8AeKvBz
	TkH84jY7YdjsfsLGxBE9H4dtEabFfg9PNPzQolfoFSLwAXsV5lLck7u2SoS21g==
X-Gm-Gg: AR+sD13wdav8Vz+a5LTJ97rU5ToirYHUQ0utGALA/O+OpxnnZ8L313bcQN5lYFBqnrx
	IvA23tEosa7Sr30AElLCP99Q3LTHCwNqnR2loM2cRY3MgTHFEj4OcEseXrvzPmWu9jQ8PJe8qqz
	NXuGbj+bNAAibC7FO7WSc13kGSFYuJRb1fg6itaWBnTuLG0Sjk+b59lamkrioZbhvgh0KiUbgTw
	tnUukn8VXiDU2bPdSN0MBK9o2C41gPQQvJZYRk3/bpxJpx+pC7YmBVX9Q0z08HIg+VMa1L0aTHI
	quGhD0qj1zKPCIWqvRR2+jtgixlDeaZFwmeRqjcWj8VRdE6dZalTZcBLR/T4rt7kg9QAqhdVi2u
	QpCdIwnt/bm7BuXHCNrvWfCmPx7EeqLImJg781Q/DkcJAKp9r0NjyATmHgJF6q26VWsyopoXWfB
	ox5MXyGjHuVFycJ4O4QX288huf/UczmDAUSEOb+j/s2lUaJuVNw6FlzZoIHau9A6jm4JtTuiMdq
	FYIhGifC/uwN1/cSjzazyNU4huE+YfTdIoGIww=
X-Received: by 2002:a05:622a:60a:b0:52c:e0bf:dd79 with SMTP id d75a77b69052e-52ce5f7f999mr54221801cf.16.1785925100736;
        Wed, 05 Aug 2026 03:18:20 -0700 (PDT)
Received: from pmatyas-fedora.rhev.lab.eng.brq2.redhat.com ([85.93.121.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce9b0743dsm14393241cf.29.2026.08.05.03.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:18:20 -0700 (PDT)
From: Petr Matyas <p.matyas13@gmail.com>
X-Google-Original-From: Petr Matyas <pmatyas@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Matyas <pmatyas@redhat.com>
Subject: [PATCH] scripts/oss-fuzz: build PCRE2 from source with sanitizer instrumentation
Date: Wed,  5 Aug 2026 12:18:17 +0200
Message-ID: <20260805101817.2195037-1-pmatyas@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selabel_file fuzzers link against the system libpcre2, which is not
instrumented when building with -fsanitize=memory.  MSan requires all
libraries to be instrumented; uninstrumented libraries can produce false
positives because their writes do not update the sanitizer's shadow memory.

In practice this causes a spurious use-of-uninitialized-value report:
pcre2_compile() writes literal character bytes via direct assignment (not
through memset/memcpy), so MSan's shadow memory does not reflect those
writes.  pcre2_jit_compile() then calls memcmp() in detect_repeat() over
compiled bytecode containing those character bytes, and MSan flags the
comparison as reading uninitialized memory.

The PCRE2 maintainers confirmed this is a false positive per MSan
documentation and declined to change the library [1].

Fix by building PCRE2 from source with the same -fsanitize= flags as the
rest of the fuzzer build.  With instrumentation, all pcre2_compile()
writes are tracked, detect_repeat()'s memcmp() sees properly initialized
bytes, and the false positive disappears.  Both selabel_file fuzzers are
now linked against the resulting static libpcre2-8.a from DESTDIR instead
of the system shared library.

[1] https://github.com/KwisatzHaderach/pcre2/pull/1

Signed-off-by: Petr Matyas <pmatyas@redhat.com>
---
 scripts/oss-fuzz.sh | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 08e06975..57ac5c2d 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -43,6 +43,30 @@ mkdir -p "$OUT"
 export LIB_FUZZING_ENGINE=${LIB_FUZZING_ENGINE:--fsanitize=fuzzer}
 
 rm -rf "$DESTDIR"
+
+## Build PCRE2 from source so it is instrumented with the same sanitizer
+## as the fuzzer targets.  Using the system libpcre2 (uninstrumented) causes
+## MSan to report use-of-uninitialized-value false positives: pcre2_compile()
+## writes character bytes via direct assignment that the sanitizer cannot
+## track in uninstrumented code, so pcre2_jit_compile()'s memcmp()-based
+## repeat-detection reads them as "uninitialized".  Building from source
+## with the same -fsanitize= flags ensures all writes are properly tracked.
+PCRE2_SRC=/tmp/pcre2-src
+if [ ! -d "$PCRE2_SRC" ]; then
+    git clone --depth 1 https://github.com/PCRE2Project/pcre2.git "$PCRE2_SRC"
+    git -C "$PCRE2_SRC" submodule update --init
+fi
+cmake -S "$PCRE2_SRC" -B "$PCRE2_SRC/build" \
+    -DCMAKE_C_COMPILER="$CC" \
+    -DCMAKE_C_FLAGS="$flags" \
+    -DPCRE2_SUPPORT_JIT=ON \
+    -DPCRE2_BUILD_TESTS=OFF \
+    -DBUILD_SHARED_LIBS=OFF \
+    -DCMAKE_INSTALL_PREFIX=/usr \
+    -DCMAKE_INSTALL_LIBDIR=lib
+cmake --build "$PCRE2_SRC/build" -j"$(nproc)"
+cmake --install "$PCRE2_SRC/build"
+
 make -C libsepol clean
 make -C libselinux clean
 # LIBSO and LIBMAP shouldn't be expanded here because their values are unknown until Makefile
@@ -106,7 +130,7 @@ cp checkpolicy/fuzz/checkpolicy-fuzzer.dict "$OUT/"
 # shellcheck disable=SC2086
 $CC $CFLAGS -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 -c -o selabel_file_text-fuzzer.o libselinux/fuzz/selabel_file_text-fuzzer.c
 # shellcheck disable=SC2086
-$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_text-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" -lpcre2-8 -o "$OUT/selabel_file_text-fuzzer"
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_text-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" "$DESTDIR/usr/lib/libpcre2-8.a" -o "$OUT/selabel_file_text-fuzzer"
 
 zip -j "$OUT/selabel_file_text-fuzzer_seed_corpus.zip" libselinux/fuzz/input
 
@@ -117,6 +141,6 @@ zip -j "$OUT/selabel_file_text-fuzzer_seed_corpus.zip" libselinux/fuzz/input
 # shellcheck disable=SC2086
 $CC $CFLAGS -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 -c -o selabel_file_compiled-fuzzer.o libselinux/fuzz/selabel_file_compiled-fuzzer.c
 # shellcheck disable=SC2086
-$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_compiled-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" -lpcre2-8 -o "$OUT/selabel_file_compiled-fuzzer"
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_compiled-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" "$DESTDIR/usr/lib/libpcre2-8.a" -o "$OUT/selabel_file_compiled-fuzzer"
 
 zip -j "$OUT/selabel_file_compiled-fuzzer_seed_corpus.zip" libselinux/fuzz/input
-- 
2.55.0

