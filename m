Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CB43B6ED
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855885; cv=none; b=jNS4YcaoTauZEDe4K8YUXDoZHqXkgyikK0R1ZX3nsiSckHQaRnraGZUlvjhDLvMOFnGoyh9oyEi/gPm5LQgsS5e+zlsSYjJn69FOy/ITBu3wJaKtDd6mnrSA/Yu73cJIrelLBCecKl893QbK8rv/L5I5WkkbsdqH4+mR/ZvAyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855885; c=relaxed/simple;
	bh=9qBqU4QjZ7BsC1YEUhV/1VD/yLmEKpToXyCQoKqIZBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edRZ4jx/dvaveWvmucPEClfK5BQuuPzzGM0g11pLhRgQAYmerPbjQpFWyRd1eSpz/ZNNzaXFEPoRAxZCaTPbMgjGeZ0manWx7X5pwyP9cThC43XVYtO0BqUgFePGW+NxuJ/rkfnwvyEq6IvM1yNf5bkkYryDs+/xeolnJv4PJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pM75adic; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pM75adic"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f186025973so46509656d6.0
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785855875; x=1786460675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zE5NGP3EFI5qTGUft+5Zd8UyZi3m7XcRIniryB3NZWk=;
        b=pM75adicTSY3t2oivY1QLuSIMke4xXZxMKyae9wnJwFTtAOYxxnSs8CyKAGqrm1yFJ
         fxoI3bP6lKuqGB7UFiEg5Vx/oZGS5douBElMtjgE76RsnfKUguMOG6r0YbFfH6yJ8jCY
         Gtis2fzCe+QiVOCnhYYJM12FcYb4pS0MJznRe7bcJPatrtq9sBSzXXtARx0hqy7kN4CY
         Sj2Oqwvq5Af3qV4Sh1AOOl851MNORobZXUnaeRfJWV0ECGGy/5J7sOlOSKVGS2ml/6o3
         zUI4vXlthEI87bKyqp/N0MP/A4ADpHf423iOAgCVudPSRqOqzzLy9b3vM3ujOQIAkVvU
         ykuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855875; x=1786460675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zE5NGP3EFI5qTGUft+5Zd8UyZi3m7XcRIniryB3NZWk=;
        b=gBr4DXN6Kgs1XXnypOPDhXp/PqjS92TwLHAVPfRk6Pv2LxzvfySwFJ/8cj+rgrWYLR
         zNcca8tW13I6dJJbr8iCNgEbyo8V2RV2Lq4HEWU3jUp0lo+pFEOS+x8XfIiXBqKo1bkc
         FP75ic29QtH04TueoRX70O3IJxkWTrM7fiJalJr3Iz7BfbkVjv6jTe6OV/xtciWPfZUz
         ObFlzUFiRb0b42mY55FDtJVpYWnyJoMRDMTWuLuqh/Y5GzRJcIVKcGdfWOtWd4ziCbIs
         nHoDkIZqKTZV06wapTIvKav19NmQXowseRHQtNlu+K2BG5ukgD+kycGEnky2hYjCSch+
         PVaw==
X-Gm-Message-State: AOJu0YxtxlRwI9Miyk9zD9d9+qsTWcKXCM8b8vGEJzPISSh+saJv0vpJ
	tZ+v7hVU+bbKvCCgVhZpHjDUEgwtP/cD5UIqs07NShaZVxpsRkmYsiF7pgJIJQ==
X-Gm-Gg: AR+sD10kTxUBVB6rbU8mPRSbqqNXyCRS+2UY7UArvC8MT8+cZ/x3kwdwOmdxfhCKQyY
	XSJYa8ZC4KzYjKlCuIS2niqz6EjmDapJnnLZorGSKKonVIXWH+rTIZ54Rg4xhegUouWHv9NuzQU
	zZAcfQKt6mFvgBtVCpLEcs8ESgc/I87PCeGriMdvmpQYBO2YLlhUotgjyKHF5MB0WNTBARdtbgB
	heQnRlWomzddvQnfII4tGIH06fUsBcEmxuT/n7dAKCzDTGBC5YaHt3jApgGHIxHgf72/2fwf185
	VjE5q8tc2SUG3CkpWvbEIOlW6kGmo/jqb41JRea2jqeGxS42ky+t/4uO6vOhraRsZwz51VQCM5B
	gVD89BIPvr/s0Er4+XLp/jhiip0xpeyKBec6rAcj3B611DKp3V38I5bpVB738qmOlV18aDBbhW/
	1ENzcTWS3s63ImkCITGYAvo7rP9DSVevWYjtr4AAzFzccXjmTAeGCvgonZ0wNnZFLagUNL8V2Bh
	pH48oV+WTY8fcrQgk3EhmRxCX0mrMQYlc7Hh0VY6iaMtRmkf1bgfQWLJM+cyTX85hpoBdf08aI=
X-Received: by 2002:ac8:5ccc:0:b0:527:809c:f9cf with SMTP id d75a77b69052e-52b5673f0abmr294687551cf.21.1785855874653;
        Tue, 04 Aug 2026 08:04:34 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce537df05sm650811cf.17.2026.08.04.08.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 08:04:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: reject policies with no avtab entries in expand_module()
Date: Tue,  4 Aug 2026 11:04:19 -0400
Message-ID: <20260804150419.20254-1-stephen.smalley.work@gmail.com>
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

Reported-by: oss-fuzz (issue 541553475)
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/expand.c | 5 +++++
 1 file changed, 5 insertions(+)

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
-- 
2.55.0

