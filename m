Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F63E3DBB
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544977; cv=none; b=oMbzTVBOcAKLau824IAgSVdF0mgQFALi8G3BB7kfOqQ5EtyY/51+3n941oT4xJEIYCgxr5v8DVEfnHtH7IcGGcpMi9hIj73PkDC5Q80DE8XK2/Sz69YudBJmdoebKfl/Mn7EYoDaDu+1GqzN/LYjOBpBoA3CbP+dvAIKb4w1bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544977; c=relaxed/simple;
	bh=J/tUkEVlem0rH1eKOLXcj4o2oJNB+U0t6hRuH+Oe5Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1l2kAc6vGfZk6vaQIurH76azYUiZaAT6uS1JLxU2x11TErloR5uorqvSS2GT6Dmm5g3RzrWbDXbGRonxiH+aoAx5ccDRXVwlDJuKXeNYHb8mYwsKZU8tAYeSzZEczLInI/+lG/1QCUaWM5cQ1BRvhdv+JALBIxjScTrEUx04w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao1ImlTc; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao1ImlTc"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f256eaedf8so117043666d6.2
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784544969; x=1785149769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FcVCYasWq6JUzhvtp40Sca5ijlaTmt5nSh5trF/Mx0o=;
        b=Ao1ImlTcWZL+ws9jgQq7jzL0CFZiSYAJmfdwwoTQRC3c6SW8HcjVwzhDApN7SdMoLj
         LVIvhmoZuMr5wSgmzikrWHFrpVKJApOyD5j60h2yhxWazth0KCrPiuYGwicl/IE39BXL
         gPc7A++bz+9f46cx+UkDEQxaVHeLMIWRYmxPUc9Gq8NyF+j7XvYoqtcMWWnG8BUSft1B
         1BSvAZWqCh1Z9CXv6K5ljfGufdkdcG2+7+NYt/Aq/mSIs+319TpqSDPfM/5gW5D1sqta
         5uSFQfT3wXRFijUBh1n+Ey/a2PMMXU9mEZk1ERWTYtArapSdvLzk6+mJrFd0GhC2uqmj
         ZDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544969; x=1785149769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FcVCYasWq6JUzhvtp40Sca5ijlaTmt5nSh5trF/Mx0o=;
        b=ggVUYNYuofXQTDWe0QdVPLC2+Zp88uHWLfF933qczoVuHeAR1kA22y1cFv+ikdKkBN
         sQwUFx3LCN3zTV06EEbSEVA0n0QKeAcyUG+hyf0Y3k2BbJEJ4Pfz72jU81RLDE0bi2w5
         rei3ge7Gmta2jkh37+Up/k/cdTwEm3a3ZBMQYBe1+IpaeCxaralKSb51Z2u1pbsBOIx2
         VpA4iefFUNlSjfCriJbtljmMe8t2sw17VIV56pXk03Q88/Lm3mPWLsAcSPsFp2mZksfe
         3SGR5gqQDohNjyr5FCIsQ+Q1PyrVC2RK2eDSrpuyRCk+ejnshn+499PFeNY4gIOxE054
         /ZBg==
X-Gm-Message-State: AOJu0Yw3+3X7EqQIZN5wFkQbnsr6SXNaeLewWBcT2E4u5dLkB2k/dLJa
	qUQVXpMCR5LuLCXsu/Fq4tzHLdCaqZS4/ahYabdVqLYMEFVbz5i1WNzQqe0EFg==
X-Gm-Gg: AR+sD10LMhc+cKvsLLWPoNNZQK5fSMs6rZ1MqKzR4xATMOYV6v9YuR2iYgRcV8iZsYR
	BFp+ke5SHQ8r5zXybGBFyEO1pdqk6QUDwUmnCCFGMpwVev+8BEuN778hi6/bu0zZnAKFDksczRP
	1VxdkERAXVDdTT1BLvntqyl9p9CaHEDCJ0vbRtyA14pd8bUBQVofqqibn+UNIYCrIDRnSPLxTeE
	x1iRYcmQEAsbE7Wy0OXjtdZ0xzBUmcbv4ODBVxIHl3zXy9Yh6cGwqwk7rW6ZyTXl1/Lp8QkLc3G
	bghz+bHll7JbGX/qI6kfjdJxMFs5AGCkPOHiMktVPhi1Wb54hHlGeXmS/fEZPRi8GBjDidjYBCZ
	Bfb53dPisqxlO9WkKa1WTSE78y+spf7Gs9oLihzAl6n5MLHIhkUT21H9zx3MGi24ZUAf8jkO4aR
	QmxP8tfrD9WMAZteWvtRPXBY7k41Z7Sh3iaRCwfqAxnQ==
X-Received: by 2002:a05:6214:4990:b0:8e6:d3a:ef84 with SMTP id 6a1803df08f44-90778315997mr154093976d6.6.1784544969474;
        Mon, 20 Jul 2026 03:56:09 -0700 (PDT)
Received: from pmatyas-fedora.rhev.lab.eng.brq2.redhat.com ([85.93.121.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077853f48esm88866406d6.8.2026.07.20.03.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:56:08 -0700 (PDT)
From: Petr Matyas <p.matyas13@gmail.com>
X-Google-Original-From: Petr Matyas <pmatyas@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Matyas <pmatyas@redhat.com>
Subject: [PATCH] libsepol: add module package fuzzer
Date: Mon, 20 Jul 2026 12:56:06 +0200
Message-ID: <20260720105606.305073-1-pmatyas@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a libFuzzer target for the binary module package format
(.mod/.pp) read by sepol_module_package_read(). On a valid package,
also exercises sepol_module_package_to_cil() to cover the CIL
conversion path for module policies.

The seed corpus contains a minimal module package produced by
checkmodule + semodule_package to give the fuzzer a structurally
correct starting point.

Wire the new fuzzer into scripts/oss-fuzz.sh alongside the existing
libsepol and checkpolicy fuzzers.

Signed-off-by: Petr Matyas <pmatyas@redhat.com>
---
 libsepol/fuzz/min_mod.pp              | Bin 0 -> 859 bytes
 libsepol/fuzz/module-package-fuzzer.c |  44 ++++++++++++++++++++++++++
 scripts/oss-fuzz.sh                   |  11 +++++++
 3 files changed, 55 insertions(+)
 create mode 100644 libsepol/fuzz/min_mod.pp
 create mode 100644 libsepol/fuzz/module-package-fuzzer.c

diff --git a/libsepol/fuzz/min_mod.pp b/libsepol/fuzz/min_mod.pp
new file mode 100644
index 0000000000000000000000000000000000000000..264bd4406bf94b1c0044d46d0ca82fcdc4716f88
GIT binary patch
literal 859
zcmb`FOA5k35Jbxl=uVd|J%Q*A+_=+~2MCyq;4dTjfQwu~Jg+OIFa^zEK*a~mbWhh*
zC(yS?b#DP+3;|pp)qMb9y%;ZdX?Yp1d{Q1=8^EZR_3@$y;IvDllTSJTW|Qf>?pS0_
zHBrrzoHHN0Jnz=6t<MgUaFAqvvv+Y3Wp+eUE^I&aR86ez;Ih;mqe31{=)Jy=*gJYM
z)YoZe5nJ0l^b4_C<_yiy`HMz`Zw0+SohO>SzP<k!{0FXMy?QKdaP72i-21Sn6|wj4
Fcmk%9EE)g+

literal 0
HcmV?d00001

diff --git a/libsepol/fuzz/module-package-fuzzer.c b/libsepol/fuzz/module-package-fuzzer.c
new file mode 100644
index 00000000..18d645bb
--- /dev/null
+++ b/libsepol/fuzz/module-package-fuzzer.c
@@ -0,0 +1,44 @@
+#include <sepol/debug.h>
+#include <sepol/module.h>
+#include <sepol/module_to_cil.h>
+
+extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+// set to 1 to enable more verbose libsepol logging
+#define VERBOSE 0
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	sepol_module_package_t *mod = NULL;
+	struct sepol_policy_file *spf = NULL;
+	FILE *devnull = NULL;
+
+	sepol_debug(VERBOSE);
+
+	if (sepol_policy_file_create(&spf))
+		goto exit;
+
+	sepol_policy_file_set_mem(spf, (char *)data, size);
+
+	if (sepol_module_package_create(&mod))
+		goto exit;
+
+	if (sepol_module_package_read(mod, spf, VERBOSE))
+		goto exit;
+
+	devnull = fopen("/dev/null", "we");
+	if (!devnull)
+		goto exit;
+
+	if (sepol_module_package_to_cil(devnull, mod))
+		abort();
+
+exit:
+	if (devnull)
+		fclose(devnull);
+	sepol_module_package_free(mod);
+	sepol_policy_file_free(spf);
+
+	/* Non-zero return values are reserved for future use. */
+	return 0;
+}
diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 9376b6e4..08e06975 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -74,6 +74,17 @@ $CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.o "$DESTDIR/usr/lib/libsepol
 
 zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bin
 
+## module package fuzzer ##
+
+# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
+# the compiler/linker so they shouldn't be quoted
+# shellcheck disable=SC2086
+$CC $CFLAGS -c -o module-package-fuzzer.o libsepol/fuzz/module-package-fuzzer.c
+# shellcheck disable=SC2086
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE module-package-fuzzer.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/module-package-fuzzer"
+
+zip -j "$OUT/module-package-fuzzer_seed_corpus.zip" libsepol/fuzz/min_mod.pp
+
 ## checkpolicy fuzzer ##
 
 make -C checkpolicy clean
-- 
2.55.0

