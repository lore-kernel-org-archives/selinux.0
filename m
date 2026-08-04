Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B947A0BA
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862433; cv=none; b=fMK/sBRzPRC95H7ctBB1jVCjUx/f3I5mzWr+Fp6qh82sVskbbmQZKva/JOovUCMIuUfKpvUyCXaZbqJMN+g3IrRdj3CnaW+bEY/jorB/yrRt/xpWVHZ6hVFDPANh8QmIofe52iaxcc6ZTqZwHiYc4aXFKFYCjl58xYb5AAPX0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862433; c=relaxed/simple;
	bh=bs3CUNAkd2ZZY2V1yxw5M6h8dahTrDfuN+C8dfYHvNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JoGv6E/exoSwmwzl3u/0mjuogYXt2TcvTdDq0fjVu/qZvDo5WeOB2GfR1FqwJ2HD+RNhvyhGzMuVqtPGYytG7WdiZ43ram15pd0vRyAgoxqkCaa2SoLLc5nCvGKDGGxGCTcMsb/yQSgKzTKxoHkIrnTufOJrXx7TXM9au2SDWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPFzrFKp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPFzrFKp"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so179286d6.1
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862413; x=1786467213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccNVN8OsiUbuT7HaN0yORFAVLs/1tSkVCWxThG5/Bzk=;
        b=TPFzrFKp/kDdCP+YIl5A11I75BbuJzdvWaeX7NZSJs8h8fXXqvSp59oRncNSvWkRSH
         8yV9lZxGbKYVru+I5ZaWU7Bwh462cocV46WohrEy8MKuzqkBgQZpSJjYspMZ+jbbTrJc
         /WULl6l17Htu373ptaIAwYs6Rjjw/c9XDOCcXhIn8XbNV+yF/18wtS+9Sp0OJdgI9564
         vEGS7c1vhe5tTR5+FI5lj6pCgw+g3WIdo5UstwBHiW4d6qjkiRUXlEZjwy/DjD+9+2n4
         +NpowJUQ0xL7eNLhwwbiWzONnk/g0rasPd2H59Pdj3tY81uoJ4W9a1yyV/tSgYsL3pUi
         4TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862413; x=1786467213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccNVN8OsiUbuT7HaN0yORFAVLs/1tSkVCWxThG5/Bzk=;
        b=QZOP3cimnpS+BJ8oQTLIxBfpX01ezYWOBXPoy+thkPrOf66iSf6OEC+2APaemqw0Wp
         53ykDNfDOwqetMmK3CUfPodZ6jnoRd1XbT1TGrbl16UPS6YoTx8R8RmJuU1aKMgqXejq
         sy3WNTFo+/EQimVOSkYY9WyiYY0w4gijnfJse/GVKbWCgZT4cgSwqoTY2TD7s1qbkS2A
         lx12Ooep4AURFKSQf2aTCPSe9PY5jM+5pPd2HEI07rY2NiG+yW1vU9t0RsVsgwkW5FmT
         OkStz+7WKlHzRRC67nl1ETx2kypGvkX57Jc5/ZVvZsHJ6NFfriuv+v3nHgsDdRWpIG2q
         YEtw==
X-Gm-Message-State: AOJu0YyRnuDXLtfkqX4ssfkOz1IEFrAs5P3e3DaTy0dbl9tILDGxFPF3
	wPQ1K9qLvGYVp+twEn7wQ+5qXfMJsy2t/gJnh3GfenxlulxbZY8nUaVq7iU0kw==
X-Gm-Gg: AR+sD10IC2RbFL/KCswNQmsLnPEXJibTgjN2QjfT/yxPAqk3u2dkwJK7PAMMKFuYMRW
	1XurSAvuxYSNgqX+OigpZOLDpZAP6IsPqXa7jl+hV/90avrvwR762apbF/110KFQ1tvdkGmu5UI
	d8zW8mdjLrpRtj5inYwJAlsCxsTTn1hgUuzFU1+M4cOg+X3YrGuTufIxsMhM9dWeNXgmxo/gZMa
	XMkqKuRwXnVHlU793ThD5ZBnNvXuQQt8//Vro2T0Mu8l+SdzdmGUlUeIF1Qn8ugOAzxICZ/CW0E
	5a65gJ/y37/4c7GXX49EQXOVlscmDnOHna4o/4Ni/yjoNqoqZTKMapdBIS/N/5BRpXUbIalbuLj
	Eg0j3SheGOkKPqu2VwYCjxiTgdvrWq6lSBsgOKjqdZDpO/WFo4rp8hyKsZ+CmcTbWdykf2OoLTY
	XzWeQGzXQtG16ek0saW+iher2Peo53a8WcjU8g/74krSJj0YIuaszCEETKc2s7htjlwtfxAHtfX
	axkzA/SBg+haCda9Xa060mrUshWIv+pWEw4SLIu9lCH1c0sKjdguCcQi1RAxuNO
X-Received: by 2002:a05:6214:3116:b0:8f1:1081:a950 with SMTP id 6a1803df08f44-90881398d9fmr7274386d6.22.1785862412666;
        Tue, 04 Aug 2026 09:53:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9088008e8cdsm5381536d6.23.2026.08.04.09.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:53:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libsepol: reject policies with no avtab entries in expand_module()
Date: Tue,  4 Aug 2026 12:53:18 -0400
Message-ID: <20260804165318.22973-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

avtab_read() already rejects policies that have no avtab entries in
both libsepol and the kernel, but expand_module() can produce a
policydb that has none. Check and reject such policies in
expand_module() so that checkpolicy (and its fuzzer) will fail rather
than writing out an invalid binary policy.

Update the libsepol test-expander policies to include at least one av
rule so that they produce at least one avtab entry.

Reported-by: oss-fuzz (issue 541553475)
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/expand.c                                     | 5 +++++
 libsepol/tests/policies/test-expander/alias-base.conf     | 3 +++
 libsepol/tests/policies/test-expander/base-base-only.conf | 2 ++
 libsepol/tests/policies/test-expander/role-base.conf      | 3 +++
 libsepol/tests/policies/test-expander/user-base.conf      | 3 +++
 5 files changed, 16 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8cb62d82..466d5bc1 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -3494,6 +3494,11 @@ int expand_module(sepol_handle_t *handle, policydb_t *base, policydb_t *out,
 		goto cleanup;
 	}
 
+	if (out->te_avtab.nel == 0) {
+		ERR(handle, "avtab must contain at least one entry");
+		goto cleanup;
+	}
+
 	/* copy constraints */
 	if (hashtab_map(state.base->p_classes.table, constraint_copy_callback,
 			&state)) {
diff --git a/libsepol/tests/policies/test-expander/alias-base.conf b/libsepol/tests/policies/test-expander/alias-base.conf
index 34955924..36016e64 100644
--- a/libsepol/tests/policies/test-expander/alias-base.conf
+++ b/libsepol/tests/policies/test-expander/alias-base.conf
@@ -420,6 +420,9 @@ type alias_check_1_t;
 type alias_check_2_t;
 type alias_check_3_t;
 
+# Need at least one av rule
+allow alias_check_1_t self:process fork;
+
 typealias alias_check_1_t alias alias_check_1_a;
 
 optional {
diff --git a/libsepol/tests/policies/test-expander/base-base-only.conf b/libsepol/tests/policies/test-expander/base-base-only.conf
index 4eae73ea..6657c532 100644
--- a/libsepol/tests/policies/test-expander/base-base-only.conf
+++ b/libsepol/tests/policies/test-expander/base-base-only.conf
@@ -34,6 +34,8 @@ mlsconstrain file { read }
 
 attribute myattr;
 type mytype_t;
+# Need at least one av rule
+allow mytype_t self:file read;
 role myrole_r;
 role myrole_r types mytype_t;
 bool mybool true;
diff --git a/libsepol/tests/policies/test-expander/role-base.conf b/libsepol/tests/policies/test-expander/role-base.conf
index a387c8c0..57efe2c5 100644
--- a/libsepol/tests/policies/test-expander/role-base.conf
+++ b/libsepol/tests/policies/test-expander/role-base.conf
@@ -418,6 +418,9 @@ type role_check_1_1_t;
 role role_check_1;
 role role_check_1 types role_check_1_1_t;
 
+# Need at least one av rule
+allow role_check_1_1_t self:process fork;
+
 ########
 type fs_t;
 type system_t;
diff --git a/libsepol/tests/policies/test-expander/user-base.conf b/libsepol/tests/policies/test-expander/user-base.conf
index 789a59a2..05827b09 100644
--- a/libsepol/tests/policies/test-expander/user-base.conf
+++ b/libsepol/tests/policies/test-expander/user-base.conf
@@ -421,6 +421,9 @@ role user_check_1_2_r;
 role user_check_1_1_r types user_check_1_1_t;
 role user_check_1_2_r types user_check_1_2_t;
 
+# Need at least one av rule
+allow user_check_1_1_t self:process fork;
+
 ########
 type fs_t;
 type system_t;
-- 
2.55.0

