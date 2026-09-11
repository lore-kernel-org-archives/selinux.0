Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B546EF9F
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130007; cv=none; b=fMJ2HeUbwd00GnZOqy8CgBccKqSO/hleRZ30SJnxQF0dZ3EOcLoG0WxaHPZTenLTWjFfZf8FCDXOgHInyE3F538qO9XkcquH8FaYq8x9RjUoQT04sYmN58xaDafBQUywMDziZHu3RvYwp7vA4P/9KfC1WU5oNDTiiumIvSHOgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130007; c=relaxed/simple;
	bh=a4HRIf6ptCb1oUvDPZZKNvcMljygUO++J/TyySVuTzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izP9w6Dn75pgOpdNaFigkOMTyMwUAxLEHc/4D5p19J+zsOepEF6pqLVOlgokV2K4dgTSYoMtP9k4xB0irCHutvDyIHzpCwsbiJjxsO++gLvaxEdTn/hDBvGFmCU+lJ0r4nJAp7ibqgApLYDXS/fauBR2na2dJpk13bEQWK6JmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3udCLuG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3udCLuG"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-939ebaf1956so74162485a.2
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789130000; x=1789734800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VAmWyl/JUb/TgQ7Ghs+Eib8khybekjEDe0wigo77i1g=;
        b=f3udCLuGr8ZWnciPG5k7f9wwZdnGo6ip30+4RqU/rK5XKkASCudS9aLQuoG1R7yA6k
         +hjVzlxYVVewD1OW6Lr8pE2Rz7GmZxnxzdpKMKobEFRJ0DlUuYDrWi2IH72mTA5pR1dO
         SbzkrVqb3XRijzj6brND3DD/5TCnwF2hc+/mMf6ikOoVlHD+I9ZH/1SRr0suArEVv72n
         27TEOPXRv6Mb5z6O9GnwuexynEGsTIpfqsTgzDto4lDGwyiF0m/a0TgMTsJRoyYv0Z7i
         psfN4ZaO0aDV8AXsMp4o/YqN7qfRxIdjtswTbNB1dqedeGi21wW4z4vma3hdYahRjvXN
         Ynlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130000; x=1789734800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VAmWyl/JUb/TgQ7Ghs+Eib8khybekjEDe0wigo77i1g=;
        b=n1pgWfY7OJlBKImShKN3q+ngY7MWJs3OxDflZkcBQ31K0i2dP9L0lgEtji6QZM5xUH
         d5sIJNT12uCymtTIvcWlhHNXZKC4gY0Ua58EXjv/gbhiwoKa5lBkqxK5cbnahpsrHrnE
         jktkp17gkv9rxV8jwWbkgx9mJVoHoyTx69IaYJmN6Sga+wKPu74Hhs2VjepNinJPF5hE
         2usn6bnNhBYyUTRCY6KyL7C5a9+ZWvwJwSpEv5iYoo6WzepoIMqO2/8CwEsBOs2c9dE/
         bT1JXIudgxkcD8S51PIMahQbTPBIA2c8BjcYJoK9INAQAcrOB0meZhufcLngNu0Mwtj0
         6JfQ==
X-Gm-Message-State: AFuF++lYJ01iOAHu1AUcsMFv4xkMo+tLKyX3K1pIiY6Pwo2m+pjD4uCi
	AXWTvgF1Mg2gTK4GAOtTP5n+ppy4W7CYGMbCGzrtaR7KvGRhli1aID3809kthJfi
X-Gm-Gg: AYBFou1odX1BZsX2ItA9EIvVmTRVnnZffVdfbb+MuxRpiQAAWAgrSJwmlyh7KegmTFf
	roRzWDKecsdQLnNKwYLuJLqubAvm8d59pnAQkJXwYWvKjPix5tJZxeYPEnH9LqoqvXOsojXPTmL
	6w7XMk0PMe/T4vZbxn5+7Ic7PUoI2QWA6vXOTRvjr5vxj5Q0Bg/XPFo8vNRWlc26rGgScq7ZQWA
	s6UxWpy4YGgDBkXV0WtRjFwbEnQrS9DnPlVlTYikGvdJvWjx/ypNrN7UTKGWNMh81MzNq1Z3wW6
	er37HGDk7koainxY4p4VIC78sFW8TfHpw/KEUrijTyZ3hHnIcPcUjy629qfyv3rn8zmxCuqUq3O
	ZWQMQJkWqkTKsLAuqFj9Sd4Z8QvHKbVqzHfQAySab4vFP+Z6ZqgaPwByfH/LWW77VcGp1T748Bd
	52ctGCkwsZDEBqtd3IDaafycYS1o1d70ES7NfmlQ/0jd8WU5bc/k3wEgUhJzNIyxxSGAebMtoLE
	zNrpmLEj3KDLgEIMO8gGivpWW6pOY25y8SwIFKbgd/9rzoIKfa8N4NM+9Xv7cq/anT2e2eYLB8=
X-Received: by 2002:a05:620a:650a:b0:939:97bc:5645 with SMTP id af79cd13be357-939ea13b453mr442429585a.31.1789130000058;
        Fri, 11 Sep 2026 05:33:20 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f18628sm231391485a.13.2026.09.11.05.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:33:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/3] libsepol/fuzz: add POLICY_BASE and POLICY_MOD seed corpus entries
Date: Fri, 11 Sep 2026 08:32:59 -0400
Message-ID: <20260911123301.69171-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shipped binpolicy-fuzzer seed is a POLICY_KERN policy, so
link_modules() and sepol_module_policydb_to_cil() only get exercised
once the fuzzer happens to mutate the magic and type fields into a
valid module header.  Ship a small base and module policy (compiled
from libsepol/tests/policies/test-deps/) so those paths are covered
from the first iteration.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/fuzz/policy-base.bin | Bin 0 -> 10780 bytes
 libsepol/fuzz/policy-mod.bin  | Bin 0 -> 1014 bytes
 scripts/oss-fuzz.sh           |   3 ++-
 3 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 libsepol/fuzz/policy-base.bin
 create mode 100644 libsepol/fuzz/policy-mod.bin

diff --git a/libsepol/fuzz/policy-base.bin b/libsepol/fuzz/policy-base.bin
new file mode 100644
index 0000000000000000000000000000000000000000..19601d57564b1d756e74aeedc54135bb7e92471b
GIT binary patch
literal 10780
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

literal 0
HcmV?d00001

diff --git a/libsepol/fuzz/policy-mod.bin b/libsepol/fuzz/policy-mod.bin
new file mode 100644
index 0000000000000000000000000000000000000000..145156a7397e49f932c3595b4766096af9b0d1d6
GIT binary patch
literal 1014
zcmb_a!AiqG6dbK+3kC7!v0otd4|?fMPkz9XG^<z=AKh$0p}*h<ds3#&$TPH3!GT8}
zJF{<Il6n8!d|U!}m{0DWU)Haad#l!UJOywK-~_-BJ6r*1tV(eetXzht+RCCH0Jy!G
z&N__;@3JT%*mEw6Xk&BU9WPQWa=hrsDz-V<o9@$}Jz?cCE^<iT?@%vzp1ZI{-BTWf
z*ELp!vPdCQ$c29sKAMF*b|P)tpSb&EA#1ZkkeTKXIwLrjC0<|D`|Z=6ZBKu`DWTc=
zQyzY1-&g*9jqulV&g*+<r(<VPr@a^`;@G?Y4er7H+t{%6#ZW8EK3@vwcK|)fFp}5?
O&JzqD2?fk^`|t%KBS2;V

literal 0
HcmV?d00001

diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 08e06975..3e3532c9 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -72,7 +72,8 @@ $CC $CFLAGS -c -o binpolicy-fuzzer.o libsepol/fuzz/binpolicy-fuzzer.c
 # shellcheck disable=SC2086
 $CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/binpolicy-fuzzer"
 
-zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bin
+zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bin \
+	libsepol/fuzz/policy-base.bin libsepol/fuzz/policy-mod.bin
 
 ## module package fuzzer ##
 
-- 
2.55.0

