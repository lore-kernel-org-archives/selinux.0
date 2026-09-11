Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58310353A65
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137238; cv=none; b=BkneqzYwEePchlCGScWE1Fi3zWuuR8W4i7qP6obuo+J4Pvg+Gr32ZodohKxqyA9koc4fXsRc0RUqumXrV6qsol2LRd96NPPNwRjtMJyVql1vT5siVuVtuds9pHKBLN6DdsWi3cvk+O6dY4L15MSo/9PActCwGHEcA9ra+xizu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137238; c=relaxed/simple;
	bh=Um7yaCL5rSIMKC5YtgAf92wJfsKCtDzwIPQS1YLl2zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjxMAxl2UezjYh1Sq6ofHbjhi67veFOvdWPl0u/0mUlctLMfuabXYtdpynAHDjXEOWr56yJSodaiOdSvAGL5qSxmE9GYXHKCeYGbQMi7FhOwcmQaiVaUlxL3PXTzO2AxWwxh78dJ50jIBqHQFAtIncxSnfvd8g5UlLnZy5l9cKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHuQvUQt; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHuQvUQt"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-784980b88acso234656137.0
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789137235; x=1789742035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qU2X5pkN1Rjk+pmLYPBc+VaHjWBcfHZTipSa1HNjYks=;
        b=mHuQvUQtsUWVYaJIlADX6MtdilLOWXnzdqnoARG418WPksEQpDg3xlyHcoeOmt9ZxT
         vSsgvYSST7HKfCGFY48d4P36qAnfpq9UR5Z2s4vMqczJoRxsqtwMUZ7EW12xaZ3487kc
         lNU8FciBJk0uwEQVT41iqxCT92VLsRhEThwS9TGMGZzmEwuRfCANcBJLDtnbbG4g7Ur4
         azv2lSoql6etxj+wRakVnt+ii9bNE+btEt3Vv0Uc3E0RklnkFEGglRg8zdchH0eoHdoy
         4SyH2BuUwWMrjI2nf4uI278ajP8HNxu4Kj/YIhSTDcW0kyTmDoPfULdZk/GTxKdFRpNZ
         x58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137235; x=1789742035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qU2X5pkN1Rjk+pmLYPBc+VaHjWBcfHZTipSa1HNjYks=;
        b=aRQKeqirqXDUwGIP6mouMEXLxOJju7oANOfk6xZehdIjKE+YEDarZE80m8p5zc8FrR
         l7iq/VwkAj7GJp8jOIVFjzbmzOzF1xQrMbZVX+Uu9EWRuNKYXwf/wJhLo8v4Vkl+jHXn
         COpB+FKETijgiDBT2KCzKByVeWgnfJtrjaguWIakPV9DeQQAOGkViBybRVcN1BbZXp9J
         5Gfr09MDmP17hVH5+87nScfDUNySgWyzYdl/ezgHj1LsD5WdkIRWOwxcVMb0BSuoxGpQ
         iow8Fp9pTachQyJE1gMF6gxy/RObVDaFijczpzY+rPyPdm8c1GcQ+hm8izjrepAF5Swh
         zRog==
X-Gm-Message-State: AFuF++kdhwLir9ba7Sbc6jvlYvScUU8nyosQQV9c8Qb6Um+XH80n1usz
	TziKCLelcXW9Nbnu1ePuzCMfjto7eLLncwgaJLMP15SyGyRMJiCwnbarbgnQzzdA
X-Gm-Gg: AYBFou3LdpPhf8tO6GDafXuDyBv4YlHyeAj/vjFa9PrOquIOhzeZcR80QgAQsKAfGpE
	YHLqUuSaWOMHSSrl1+kmPwZI7LdzHTMcl/0ICHCDReLZYIo6jhXtu/BSNW2BBudxxwVVRoT43Rq
	wv3bWbeNFDqT8sAgBf5pHy+d0nkr8tcagZRk/i/o+6r3HnpbP1cVoCrODdvEtKB2oOb7QkNFWfE
	+VQxyciMlCMZLgsDP2It2lBswba87zd5sVlP7v0X3MQs0kK1KmK0Zi7s90Xqq00d/oiNLj39E8E
	hi9XWWa70rbZfD6E74/2vyzjq2PotPDJwVflu5DaGFO9Ln+U4QIRf62LMuS0DCzV4Mqf52MuMQe
	lUpSs3yQFt6ZVSNkxwsRIRf+LRS8bjoxhiDRjckp+SfbRGuKyaS/HQyeqLdrPg3SJs+4D5DbqUC
	cYEsxBr5xDLlAj+RfdhZYQdyBzXnF9+511ikNZTHbgXTPK2MmXqXpagt/yKXiaA976SJvles91H
	LWG+gZR70L4IC607V08qIrAEpWDNmLte0nEWogKv3STz7St+2ggt2RuSdeiswrB97Zlsvim4KY=
X-Received: by 2002:a05:6102:6402:b0:790:c7bb:43fd with SMTP id ada2fe7eead31-792a93b09acmr4183436137.8.1789137234956;
        Fri, 11 Sep 2026 07:33:54 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d35a9sm22029506d6.41.2026.09.11.07.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:33:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/3] libsepol/fuzz: add Xen, v30 kernel and v18 module seed corpus entries
Date: Fri, 11 Sep 2026 10:32:28 -0400
Message-ID: <20260911143226.17807-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911143226.17807-3-stephen.smalley.work@gmail.com>
References: <20260911143226.17807-3-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binpolicy fuzzer had no seed for the Xen target platform, so
ocontext_read_xen() was effectively unreachable (the fuzzer would have
to mutate the full "SE Linux" target string into "XenFlask" unaided).
Similarly the oldest supported kernel format (v30) and the module/base
format (v18) have version-specific read paths that the existing
v32/v24 seeds cannot reach without also mutating the coordinated
sym_num/ocon_num header fields to match the compat table.

Add small seed policies for each of these and switch the seed-corpus
zip to a glob so future additions do not need to touch the script.

Generated with:
  checkpolicy -t Xen -c 30 checkpolicy/tests/policy_allonce_xen.conf
  checkpolicy -c 30 checkpolicy/tests/policy_minimal.conf
  checkpolicy -M -c 30 checkpolicy/tests/policy_minimal_mls.conf
  checkmodule -b -M -c 18 libsepol/fuzz/policy-base.bin

checkmodule -b unconditionally writes POLICY_BASE (it rejects -m, and
write_binary_policy() overwrites p->policy_type from getopt), so the
v18 non-base module is compiled from a minimal source instead:
$ cat minmod.te
module minmod 1.0;
require {
	type base_t;
	class file { read };
}
type mod_t;
allow mod_t base_t:file read;
$ checkmodule -m -M -c 18 -o minmod minmod.te
mv minmod libsepol/fuzz/policy-mod-v18.bin

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 changed the way the non-base module is generated and
regenerated it due to a limitation in checkmodule.

 libsepol/fuzz/policy-base-v18.bin     | Bin 0 -> 10772 bytes
 libsepol/fuzz/policy-kern-mls-v30.bin | Bin 0 -> 618 bytes
 libsepol/fuzz/policy-kern-v30.bin     | Bin 0 -> 518 bytes
 libsepol/fuzz/policy-mod-v18.bin      | Bin 0 -> 914 bytes
 libsepol/fuzz/policy-xen.bin          | Bin 0 -> 2085 bytes
 scripts/oss-fuzz.sh                   |   3 +--
 6 files changed, 1 insertion(+), 2 deletions(-)
 create mode 100644 libsepol/fuzz/policy-base-v18.bin
 create mode 100644 libsepol/fuzz/policy-kern-mls-v30.bin
 create mode 100644 libsepol/fuzz/policy-kern-v30.bin
 create mode 100644 libsepol/fuzz/policy-mod-v18.bin
 create mode 100644 libsepol/fuzz/policy-xen.bin

diff --git a/libsepol/fuzz/policy-base-v18.bin b/libsepol/fuzz/policy-base-v18.bin
new file mode 100644
index 0000000000000000000000000000000000000000..4057e406a2768a660050daec0069c0d5557df175
GIT binary patch
literal 10772
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

literal 0
HcmV?d00001

diff --git a/libsepol/fuzz/policy-kern-mls-v30.bin b/libsepol/fuzz/policy-kern-mls-v30.bin
new file mode 100644
index 0000000000000000000000000000000000000000..22748058bb1f76701a5c0c7682e6a4c2a0be8654
GIT binary patch
literal 618
zcmZ`!%L>9U5S)syuaJI%{R2gEi&zppcoHlg^q}AaJopLzuqS0orUq>$ESc=iZf2kF
z$7=|{o80b?xBCb{27tK%fC;{cxj-$W9};@&p4qAQMK7pI<K~4*T>yC~w4npk!De#8
zEvzZ%gTX<Biobc)xr_K|d)QUi%{ksB<}xS8>RYZ$(>Pa=Sb5`;j_6Di<6lxvsf~4l
iW@yvPSW2qNiTEbh??hF1WX<^pI~3~FyUkMysog#d@)sBY

literal 0
HcmV?d00001

diff --git a/libsepol/fuzz/policy-kern-v30.bin b/libsepol/fuzz/policy-kern-v30.bin
new file mode 100644
index 0000000000000000000000000000000000000000..9bd8662127e38184a21ae3861b1590156ec368c6
GIT binary patch
literal 518
zcma)&O$x#=6ojXOKc^^OAvaJYyGTo-3s-{TLKg}}!G%Zg!mgBQGZ3SKUwOR$yrK8!
z?J)un?AYy(mura*)`kEkF(+v(3ZS(?EGVZZGdB&v^y5@*{oKUP8$F;k4l*Xba@O!B
zP4B6h*VU(P#iz|-w>__$RCgM4jwW^5TdZnp@+MgZ>whZJc6x#2`8T>_Mf^UI7<&Ez
O<>a6D1!rm8C-N^iAQYwm

literal 0
HcmV?d00001

diff --git a/libsepol/fuzz/policy-mod-v18.bin b/libsepol/fuzz/policy-mod-v18.bin
new file mode 100644
index 0000000000000000000000000000000000000000..924741a2c7bb217b873b653b8aa15f8e789b2833
GIT binary patch
literal 914
zcmb_aOA5kJ5Q|^j37()Q5WRsLce?TbrL|9}^aHg87hb^wyHa8s7)lET4GizSnM`I{
z@_avDO8}?6cZjp<?j7@}O57O03cv`!0yX9U(l|@=XaZon-t3x!1sfRCCaE`1;u0s0
zHNFcMM5=R$IC*$==h82%e&1cNbuQ1~!qS(v<%Pk``Q@x(i%D2knn!-AF?~?8#t_O8
z6lAE*^^~`0^Tf9c5z<!O!g7b`4dn=JeSy3Ds>ObNQ`bN0n{D&|0{5U*X<6QF(5|v6
U_f$=`tF5IhPulEjB}?zZ2cvE%^#A|>

literal 0
HcmV?d00001

diff --git a/libsepol/fuzz/policy-xen.bin b/libsepol/fuzz/policy-xen.bin
new file mode 100644
index 0000000000000000000000000000000000000000..6e7dec3adb1d4b4a7f79e748e3992f877a2f5204
GIT binary patch
literal 2085
zcmb7_QEyT~5QT^Kf>vYfLlfV$kG>JWAJAKJn>4xfHb4{mWGcNzw2=mgPyGr0VUs49
zZ`p(6ZGn24&F;>eIWs#0^w;9<_j5D*SpGP<xte`{YfE5jnAuTWwP@dod)2-l?eJL7
z;;wtQ==F-T7Lu5{=UKlOZdj5ST#vi(WqecW?14BS*5h_M8I`k{HwjP)+cgVspa{^-
z)4`w<t0O-T48=vl3PeZ+k`zEtX-5?~NX5&zvrs>X=W6@j$23*DZ?}i+g1@UP%BwvT
z8QzE`yisNOGCAvgoaOT=c$x<~9`Y0GaXp^;t3YR<s{f#0<XLM|JMbwlpH_f?awE{G
z3aB9Lg0cgG+SMSb`ygz}KKcBu9L+yXz2Bc1$cwmC02p4LXK8+#4qA9s_dlKw6h|I;
z)8Vk+R-e2v3>Jf`LOq0&(i;QQ>%#0{pis|jzl=Q<Ruy;B^{!(iSjqt|23ddYIF-{k
z4fwl6wIhC96#0Yi>0Wq9-D<WI$cZ&<*Aly5EEb6+RttZ8;2Ku5{WyNkhoJ#W`%$!e
zog^qyKw|ZkrV8>qSn~en<NL#692$wgtNGr>r|jf3&(6|bMvUgm+53oH=Yy+BJQnAD
z<d%-=;2q$xVQk~PihbC`!w2sv+&5<S?msjEx`20Vssn9+KG?>`|CE~Hy*9Jv?bZBi
ob3SQamp{j&a+|zB+gb2|c0Z0PhmnG+-T#nzP5tw(@(-iVA0|Oz2><{9

literal 0
HcmV?d00001

diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 3e3532c9..c8ab9ee1 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -72,8 +72,7 @@ $CC $CFLAGS -c -o binpolicy-fuzzer.o libsepol/fuzz/binpolicy-fuzzer.c
 # shellcheck disable=SC2086
 $CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/binpolicy-fuzzer"
 
-zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bin \
-	libsepol/fuzz/policy-base.bin libsepol/fuzz/policy-mod.bin
+zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/*.bin
 
 ## module package fuzzer ##
 
-- 
2.55.0

