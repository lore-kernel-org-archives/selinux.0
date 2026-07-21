Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0D2E974D
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632128; cv=none; b=dZOIW/NfxAddPG/7+N5BiF0LHLggDwZOYMhLcdtIURIHZBgZ+On0HNeocJD4e4yv6Uh+XW9DeCh7pL9auqYWPlhD7pv/KLGl0LSm0KX4EsJ0FXajdZD6CxjZVWmEBuYc22Wr2+0TP8uqXgO0Gx0NagnptjNw5rF4zRuS82GdR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632128; c=relaxed/simple;
	bh=KCSbzV7/Kzk12rcNSfBS1m5zp9r+I0dXBfuZpvrduAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwKgUCHtCniButWuiqVNA04kBsLX8fVylNgTGDMSpzT8gwc6wz8IFjImUxPw0A6bjjsfVGDJ+ReOwLmFrKNgi6/8N7xHKSERhS68//2TvuzZh3roezCRwmIDzn1bb4+ek22+GijYjLGQXZauVRYsCFsBH/Ccy4ddAaQrg8Lxg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fseSQAyX; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fseSQAyX"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8eeb4508f29so113313936d6.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 04:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632123; x=1785236923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XMh+tw+4j+ys3a87BIYaZHxoLzZuuNu06WR3nc/xc+o=;
        b=fseSQAyXftR0lZz2OrCvyj9VRTkG0Vhvr2jb/SgD+FF1HkFgT/prxjsIxnj+0G3tqZ
         70d7oyuuGTJ6ffBqE5ahIHSqm8/UFoLAqTqjQE5NtmKyaOdwOR9UBJv3Me8kB43skFGQ
         lNDN05J4I8xwAXqT6plbv9/xQwBZ4MsDqbOzwhZj3ol6r4/Lhib5WuUNviKOZlVa4j8u
         PX1nRi+SwOvYh3ZzvCEWbTA0qyouEkMlp0mcYVMUo2rodqaseYu+b8w1Q8G5lLTUYMsV
         pTCqPjd5GmyijgrDlq3aA5K//wnSVMWA+9oXmgBLz8UE68w2RZk95CGZDCJvJQUjIwSK
         EGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632123; x=1785236923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XMh+tw+4j+ys3a87BIYaZHxoLzZuuNu06WR3nc/xc+o=;
        b=OkZNW1RsRmFuAxf1daY8/QvYeW6zXD/NTlNC7Q2m0xpx4dcvRWQi3Q/51PK/Xj9YyX
         WFwn1iV+VpAuB3hvP+PK81ReIM+WZrcssEEnSq6kGc4/LwlbUW+lDZdmzLt7ZTvg/T17
         WF6GWfrvQnvWdkg4qcdjDpBksMuAq75uT0JBFxfuwgn6NavD8xmQfIEpmcHaslJiDGTW
         P0J3YZE0N18HOXuRBxqU5Q8QUTlJFDsg8sP8RMgxZg+SJZugcrfyO0DlHIYQzc6CN1cH
         94Zxe9csGklbwRQQKLhSDQaYNN1z7Q+yu4Jk/3zTz4Mm0KSSZxxk5Wy4ILeg7llcKrpO
         7Q5A==
X-Gm-Message-State: AOJu0Yw06IHywFeIIX5k1Uj5+4p2Mi+dYAW0aUtIYwlspPAo9TEJ867/
	yTCV7L1GXjkzVR+dXe8wJepM25qG5Wl650BQaKfTOWngUBpWLOOOh18c/tCzVT31
X-Gm-Gg: AR+sD12PN3d7f591CxKnIZXSnb9KAAnUM5z01OHq3ITMC8rR0URXoycWAvmekqfTQX6
	tmvQZy9sNppIdrpWRxjUDC7mL+9+dwIuvCjiF1u4IBvrwiP0ZUX2+cUCfDJVod4027C0xfMemil
	iBcFShqWI8ntcSK92s4gsaOa56Z7legKwj8Ros5eUP5t+8WYWYHofTiaf9LZQ40H+IL+d3SlA+5
	7J8f5DAkzugHR8MJTts22Ihx/ALopxp9jOMLwoU5+Twqf0Uo1UMCzstO756tUvC6sXhOGXnvzZb
	ZqP3jkqYmOTGzF1Lb0mnj1ZmZSpwdNqmbGT3tLU1dWYwJa0OOPSln2RNoPx9reU1Yv6AzeiFS6r
	7vDvznaU6GDj7ybH1STF2oG80zTIzPNGDyPs0ouM+5rNjgMLVOOwshHVTkUmUUD2QlvMLvZv6Sx
	pbbO54OOze/OSjDSByDiyDZaVp1F9SAzWUpZs7e0wETQ==
X-Received: by 2002:a05:6214:5b8a:b0:8ee:f81e:7927 with SMTP id 6a1803df08f44-9077851aac5mr218120136d6.48.1784632123346;
        Tue, 21 Jul 2026 04:08:43 -0700 (PDT)
Received: from pmatyas-fedora.rhev.lab.eng.brq2.redhat.com ([85.93.121.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90778562524sm113313496d6.13.2026.07.21.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:08:43 -0700 (PDT)
From: Petr Matyas <p.matyas13@gmail.com>
X-Google-Original-From: Petr Matyas <pmatyas@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Matyas <pmatyas@redhat.com>
Subject: [PATCH v2] libsepol: add module package fuzzer
Date: Tue, 21 Jul 2026 13:08:39 +0200
Message-ID: <20260721110839.431114-1-pmatyas@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720105606.305073-1-pmatyas@redhat.com>
References: <20260720105606.305073-1-pmatyas@redhat.com>
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
 libsepol/fuzz/module-package-fuzzer.c |  47 ++++++++++++++++++++++++++
 scripts/oss-fuzz.sh                   |  11 ++++++
 3 files changed, 58 insertions(+)
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
index 00000000..2516970b
--- /dev/null
+++ b/libsepol/fuzz/module-package-fuzzer.c
@@ -0,0 +1,47 @@
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
+	/* sepol_module_package_read() stores contexts sections as raw blobs
+	 * without validating their text syntax; sepol_module_package_to_cil()
+	 * is the first place that parses them, so a graceful error return here
+	 * is expected behaviour for malformed input, not a bug. */
+	(void)sepol_module_package_to_cil(devnull, mod);
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

