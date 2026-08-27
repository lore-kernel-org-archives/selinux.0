Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814A35294E
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856731; cv=none; b=tm78BDI9CNfTB+8b1WRERCdwA3ylAYdeYfJad59ixni19OmLYl8GyQaAp/atRzbUl6gcM+GMjr3B5AOPLnr8RzF8udZOv80NRJtJK2C62hWow5/OcYA9Zk+h0jnpl1JatQ3QiAWmRLfoTm/BjVIyJJl2c0iI1cV02IR7Ov4Sri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856731; c=relaxed/simple;
	bh=RvSuSg8Ltavn/WbYiecuJnLvNSWcM0whYztVs2yysnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdNLs+NPzT7CEhEEF2gDLR4LnhsO9sRv0HyV8sRj3FKGvGJH/swUUBEDAhuq+ewVUpSJxO5H11HYWf4+f3t12DwBPwiT4cz5ZHBydPRxnbcX9RCIUOWeHbxcw8n0ErH2gac/GYb0Kx1XAd/L0eNRionDHGL5PS4gd7JBZeOUrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmr/Pvtd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmr/Pvtd"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c8e2e39easo46711cf.0
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787856726; x=1788461526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwCArpbCGfPs550miPmJzvEnBXEj1dKTT4N4NhhKApI=;
        b=nmr/PvtdJCZ/cioQ+wWq6pIjSTb7RkfFZ+iKTFJSZGlSje3OuOxB23OqDId+COQ2HQ
         Ycn2/CDSlhpbU0tMokNr7SFFA66joMZWks73QqO7FuAM/Ev6opsbUabK+JHMggJzlw5B
         lYkFSqFPHqkE4Qe1pP5dvl6Kx50z5Iyhqkp1+HiFvhHHXnIsHJwdtVAFKwNQUHi+wDde
         6tTdquArD2LNP4BLwZBocfW34bAWhAEl5NQkKWCFkttqHjDdSOH5r0VMP4Dr3lbxMEqD
         5h9SQ9+6MpOpbn0GCdWI+5kE/KkvoPotJDOp+mPdNAVMoAuqMahljq/N59I2lClcjdud
         HJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856726; x=1788461526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwCArpbCGfPs550miPmJzvEnBXEj1dKTT4N4NhhKApI=;
        b=QQ5o8xZksXIrLDpaMmBS/UKfPbISnLeXpYg3N3VMlGtvVqwtql6QE+ys99RrekWGxI
         B150T3iAlEsapOwDvB/5XVBo+X8T4ED8RQFCsHz5geilxpRe5GFbcDm6/WPcIRio4/qq
         QxlFaECmVih+PB4Wd/jVZw3oVf148C1vZDLSYJr8AK6o/oJuaosnM2Om2nbSqnDRKsj+
         pki25ONsrpSwqpk6OZy7rTJ6BesLyCI2uQJQafviRAHHH24VaEAdHWopfyQLckVgjyCV
         O1LhQV1J2RE3qp1rYCqMoSN9AxoRxFreOwH7fBJLBlB8Zmc4e/yrohTYgRPwZlk8CLVs
         GAAA==
X-Gm-Message-State: AFuF++lNh2Xq5/Ic9MyzFz7oGhD/1yX0Szpm4aGjoi8F1hNsotH6EmAi
	xYzK5IB1nSZVJLxSm9jmMszSSDwt1GVMP6wpSQ4i7G3mrdm7UgF/iFIbPG6BCg==
X-Gm-Gg: AR+sD13tgl+jvUMaPiyQzRabipQOix9Jdaxjx/KBOPQwRfaXBuLFV2Vh0uG3tuydIKt
	9Fr2muoUbqiPveJOGpL57SZmHURrUXrwzDIxn7tnuAKhsER0ju8l8AKSwHXeJPFYW8fnAg091sm
	clAG1rHiRGTuh79tDSAe3ofazhCsJbYdohAVxbGk8LW6arGctWmcOR7A2IbGwm551dx6x+0/0Cl
	GUOS7GvfcMZfg4Lh6qC90mu/HP5HEYBvgQdF0e4qfwDwCXEebbhMUwBLtDX+Z05/rmE6O2fvNHu
	nt/G4Po1JPrATy0YFVR5l2SrugDYhqd16Eg9DT40Jif1JlZ211qXgbQglMNzNLZMjpeLexbPf0S
	jvndEOtauuZrvzEd6HTBIeVr7e9YsmAwNLVCluvGAKihmWZP3xjMK/mXq9YO52O38Zk3ewgdZXd
	xy0mMk1++grsUIAkW/+0+y2kk/8Oir21Mp3SGVd3iOM8WpyRMrG5hdXEdJzjgarfJTClBAxY8iI
	UQvTdrKqOiCi7ZSls+imik/DeyD/vxUm28uN07cSlkAv3yGX5qUoxYCDlDolIVX
X-Received: by 2002:a05:622a:44e:b0:52e:2d4f:2219 with SMTP id d75a77b69052e-52fb93cf62dmr13919641cf.9.1787856726488;
        Thu, 27 Aug 2026 11:52:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fb9c665cesm2439781cf.11.2026.08.27.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:52:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	p.matyas13@gmail.com,
	pmatyas@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] scripts/oss-fuzz.sh: revert building PCRE2
Date: Thu, 27 Aug 2026 14:51:50 -0400
Message-ID: <20260827185151.21459-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit dd3d5dfbde4d ("scripts/oss-fuzz: build PCRE2 from
source with sanitizer instrumentation"). This is no longer needed
since PCRE2 JIT is no longer default-enabled and was breaking some
builds [1].

Link: https://oss-fuzz-build-logs.storage.googleapis.com/log-2ce3e78c-3e53-41ac-8009-41d836af8130.txt
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 scripts/oss-fuzz.sh | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 57ac5c2d..08e06975 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -43,30 +43,6 @@ mkdir -p "$OUT"
 export LIB_FUZZING_ENGINE=${LIB_FUZZING_ENGINE:--fsanitize=fuzzer}
 
 rm -rf "$DESTDIR"
-
-## Build PCRE2 from source so it is instrumented with the same sanitizer
-## as the fuzzer targets.  Using the system libpcre2 (uninstrumented) causes
-## MSan to report use-of-uninitialized-value false positives: pcre2_compile()
-## writes character bytes via direct assignment that the sanitizer cannot
-## track in uninstrumented code, so pcre2_jit_compile()'s memcmp()-based
-## repeat-detection reads them as "uninitialized".  Building from source
-## with the same -fsanitize= flags ensures all writes are properly tracked.
-PCRE2_SRC=/tmp/pcre2-src
-if [ ! -d "$PCRE2_SRC" ]; then
-    git clone --depth 1 https://github.com/PCRE2Project/pcre2.git "$PCRE2_SRC"
-    git -C "$PCRE2_SRC" submodule update --init
-fi
-cmake -S "$PCRE2_SRC" -B "$PCRE2_SRC/build" \
-    -DCMAKE_C_COMPILER="$CC" \
-    -DCMAKE_C_FLAGS="$flags" \
-    -DPCRE2_SUPPORT_JIT=ON \
-    -DPCRE2_BUILD_TESTS=OFF \
-    -DBUILD_SHARED_LIBS=OFF \
-    -DCMAKE_INSTALL_PREFIX=/usr \
-    -DCMAKE_INSTALL_LIBDIR=lib
-cmake --build "$PCRE2_SRC/build" -j"$(nproc)"
-cmake --install "$PCRE2_SRC/build"
-
 make -C libsepol clean
 make -C libselinux clean
 # LIBSO and LIBMAP shouldn't be expanded here because their values are unknown until Makefile
@@ -130,7 +106,7 @@ cp checkpolicy/fuzz/checkpolicy-fuzzer.dict "$OUT/"
 # shellcheck disable=SC2086
 $CC $CFLAGS -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 -c -o selabel_file_text-fuzzer.o libselinux/fuzz/selabel_file_text-fuzzer.c
 # shellcheck disable=SC2086
-$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_text-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" "$DESTDIR/usr/lib/libpcre2-8.a" -o "$OUT/selabel_file_text-fuzzer"
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_text-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" -lpcre2-8 -o "$OUT/selabel_file_text-fuzzer"
 
 zip -j "$OUT/selabel_file_text-fuzzer_seed_corpus.zip" libselinux/fuzz/input
 
@@ -141,6 +117,6 @@ zip -j "$OUT/selabel_file_text-fuzzer_seed_corpus.zip" libselinux/fuzz/input
 # shellcheck disable=SC2086
 $CC $CFLAGS -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 -c -o selabel_file_compiled-fuzzer.o libselinux/fuzz/selabel_file_compiled-fuzzer.c
 # shellcheck disable=SC2086
-$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_compiled-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" "$DESTDIR/usr/lib/libpcre2-8.a" -o "$OUT/selabel_file_compiled-fuzzer"
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE selabel_file_compiled-fuzzer.o "$DESTDIR/usr/lib/libselinux.a" -lpcre2-8 -o "$OUT/selabel_file_compiled-fuzzer"
 
 zip -j "$OUT/selabel_file_compiled-fuzzer_seed_corpus.zip" libselinux/fuzz/input
-- 
2.55.0

