Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDE44C6A
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169044; cv=none; b=i51uUTZkyiOWnuQxqm7HSHZ13qEB/v840V3U79PPuZueABDGaYVBVKoo9184hI+0c736CPaNGJUgFJBiRTbF51s2GXU6M8ffPMisaVty9/YBKAlfv85oAPw8pvp2WBaQ6QGO2vFJXgsZj3+38HBeAPXcF9eoU2NcquoNZOJCKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169044; c=relaxed/simple;
	bh=GdVfQ2RAFeIccrX5lLcssS3Urq48dB7KXw2XVUcGyPQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGVUZ9ftpKM1bEkajjS6zcj141kTg5PXCsTO3MmQ4wHS08qu5Z7dw1Wls0Tplg9o3RJtVjFmMbnJT7SH0lS0PGhBy4WZfYhCXPgKZkCCpFPl+uiaPN6xsQ4s7veOP4iQPuG8hHs/5CtoVHwrCv+oGT3smth/PVY1SkZ58PGLGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=b33Ur30U; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b33Ur30U"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a45f257b81fso362290066b.0
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710169040; x=1710773840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0iYYYdvG5cWiYGJ9sNkOrrkthB52qPTCP52aLWK3Q4=;
        b=b33Ur30UUJTOgUMjIgu/OkK+H5zyITPaI37v3ci6maRUaDc69asAO5rj8cEr8VAxvK
         EDzqjCZnerrE42IXotl3HfLyMozpcNjbowkJBUDPClgl7IG5H/9C60lFmwcgGvab5451
         x4+PJxaFqhArGMloXi3zgk2TSD1Ua8kahoKt5pSDgwM1k/1yktkyN6X/tCT4xHrZ43BJ
         wZeS6cHs/kk5qvFGT8sIUjWg1yH8c4C/m1Iyu/GvKaFrDfuBoNw4hVJHQPE1DH9BDocv
         WkRIuFnMyKb5ggjx5vzAYU8k8Y35qROgrXpqrsA7ZLVdipDpNa6Qc/N1SFAw/Xp3DtfT
         7avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169040; x=1710773840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0iYYYdvG5cWiYGJ9sNkOrrkthB52qPTCP52aLWK3Q4=;
        b=gBtMC3IBCCL/a6VPGLbaj/OAix4SpjdLhEk8+YqyjxaD7CXN2c/3CmTzPKLwAi+D9t
         jRb/TjbH6mhWW8bQnLEhL3WayAYuWX92iBR699N1OVYcqMKc2NKU1B9nA3dVwY18c7xj
         RBmX5I/45kD8byYvt47j8DpZ3p1KOrFoK2hDB1d9TZW2ySvL2nYXQDNTI3MQ/+LW4eEY
         P1d6Ez/fZX7bcHRRAPhHOfIsAYmuIj2MsCSbsIoUBXLyCQVhU7AgaNS65xpZzT5nuI+3
         0LABBit5vt0OiAnhjb3OrZuRsX6RrCR8Cx1idt/OtawMt2OzSKPQmngeLVVxu4ro9hVf
         RwKQ==
X-Gm-Message-State: AOJu0YwdPv3RepjnAtAx/g7z3Oher3H3AlcjUNZvKeT1Y4pPc+DW4vJw
	6gs3Nj44Mlx1i1cnAS0JTTU8KB9/XuZ3w8U/F/iF7ir7hI8g5JEaOW/YJHWzslE=
X-Google-Smtp-Source: AGHT+IEgwfNAJ+K9LsXzm/LU3jZOGQ5l0UbN+HN/B+DT94Eusp48Pb5iQXm0VECYwJXqYCR5r84vow==
X-Received: by 2002:a17:906:3ad3:b0:a44:9fe3:d7d1 with SMTP id z19-20020a1709063ad300b00a449fe3d7d1mr3391918ejd.43.1710169040395;
        Mon, 11 Mar 2024 07:57:20 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-112-075-004.95.112.pool.telefonica.de. [95.112.75.4])
        by smtp.gmail.com with ESMTPSA id r24-20020a170906549800b00a45a62e0ed0sm2945240ejo.98.2024.03.11.07.57.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:57:20 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/5] checkpolicy: clone level only once
Date: Mon, 11 Mar 2024 15:57:03 +0100
Message-ID: <20240311145706.34885-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311145706.34885-1-cgzones@googlemail.com>
References: <20240311145706.34885-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In case of aliases clone the level only once to avoid leaking the fist
one.

Example policy:

    class p sid h class p{d}sensitivity d alias s0;dominance{s0}level d;level s0;

Reported-by: oss-fuzz (issue #67308)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 614b7706..0cf938ea 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1038,7 +1038,7 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
 	level_datum_t *levdatum = (level_datum_t *) datum;
 	mls_level_t *level = (mls_level_t *) arg, *newlevel;
 
-	if (levdatum->level == level) {
+	if (levdatum->notdefined && levdatum->level == level) {
 		if (!levdatum->isalias) {
 			levdatum->notdefined = FALSE;
 			return 0;
-- 
2.43.0

