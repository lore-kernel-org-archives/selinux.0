Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995C1AAE17
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141381; cv=none; b=E7akegRUb73H5okWp5RyJdBXdh3ebV5USlfMdnyCU/Z/TNEL3H5iPU70HoziZK+jfFqZqpD/3uHkZptGFkBsj0IwRv8jw6UL/QY5B60nJGi3NczKNwKz8HpmTGTbRtbx1iTo81NC4TEtwyNezpQ6LyUmeIcrrL7ap9gKgZqayWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141381; c=relaxed/simple;
	bh=CGjJ22sTQHCDmow4JlPvsG4/o4GL1aVv3+kyKF7BEYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUWoqqh/MOuM43S6wErAhwVd3Akrt/uAkGcJaRmBbNGn4Qf8HVA9btiJQ+WChj8og5rMmuZWs1WQDBhHeA73KtO7qkRcFR0m4Nv99oSvwOKIOie+GHkBjV/D71lU73Sewkk9/81QGEM3Jot6H0RJpG+OUGAaN4p4t1guhfsIdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoFaH3bg; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoFaH3bg"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0c45c580so49105491cf.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784141376; x=1784746176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jEaPCPIQljcXegjBnJVIWkaNAB/G8ZNE49Aizd2Z/EY=;
        b=XoFaH3bgeglfFEdxneT/RXyRaTRHSFiIkE+k8i7Er6Vh6gPEtd4OIhh+U/b6m3ygTM
         K4YBxVkmkWM9uhfUUcdX2GBkrUAgGjfA2QQnER56jxaE2rqA9hj/VJT3mrcXtcueQgQo
         MEPsBWwJ2B7+/jfNsmFac5WGTVzfcfSKVpRtrt+JRTHs+wgAGSmZrHVL4G1KbujjCrEk
         KPOK2zEWExbvKV6nmsA0uVa6D2mM0eogbp0eOSJfqolxtida3KWTf4FPHi3VvwR2fwby
         qNLQrctPpUB834/05kE89iOIaWTAyiLsF4gKAtXARP54IjjYp/3SfM1slPAQXb4yseau
         w7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141376; x=1784746176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jEaPCPIQljcXegjBnJVIWkaNAB/G8ZNE49Aizd2Z/EY=;
        b=onRwWA7i+GygbLA0Slfot6Mcr6AnJlDuivGwWSrLV+6/chuPkD4YBQIo84X/ihRpCJ
         6vSclIaVwpRo+P6ROyfsTWCmXwGoUAVMN7Ua+bEhCRLWQ6MgmLvO3zqmir2RjpJjqrc3
         v5qDORuqvpvlV5kV672BPVp8IfIv/mgCC6apSi1icq+K700EZ6uo9oTSCiRra2MJEDvc
         bAhB7iWZSmosh/wFdmo38RqVVHzDw7Ac4C5Fp1rRX4dH7Rk0MCo4RMnP/D8wZeq9qIYg
         yO+l53EkE4/5b40FfcN0Uvi2Y045ztlbsr9qOSr84rZuJ6iGAUYyH3j3nFn7hE/ewWqV
         WkJA==
X-Gm-Message-State: AOJu0YwTFDH+F+F9KJVAX7HRJYhkkqAR+C3IyG6pck3Jo8mhgvf4Nss8
	yIPCp7gD25vO6kr8vL6W4H/ZxADAsqnUFxLfg2ZJX5jwbXKWda+QZjHZmuUruw==
X-Gm-Gg: AfdE7cnhb6cp7QV9wLzOTDXyZ8T5WTe++wbolkKaKvtbVOZOjVRf6UnHXFF0ZUtcIeT
	N9QMHmq9OserexjYescWUNGWiLn74EvNkPxwhWiH0Ffd/SnLS55M37lBH8ErGZ5O54qXNBP9tmc
	Bpn9cixXkP4uTy1AtiuNiZMGnkNfyWQx6lgpodENQf/oJZpxyg6RSLjViD+Ssnh3jdrvrIjulA1
	GomMgwdT0n05YSJRr2mZrI2QkejSuheIvfuW9a8MY1JmG5sWgW4gFxg21H5D9hkpJ6LJU735kUe
	Qv73YF/UATCsbxWvsV75xagPJSsf4kZfbAQ96H9w+1xVyjHDbh1kHyCGf7x7hMIi6kUuiO5wMmo
	PtHU/v5/hK9NWCPIbzQ7NT9gdOkiJEZ4VmCbwVFqdmZSira66xEZCW4thtRDVqr+AEQhCJ6d3Q3
	4EelZcrtkQB/mtHrFyM3DAnnOAm3XlkkjHGddbanc1FQTtRKLVYTPhZcVP+NOiIC6qwO29KEuQY
	ByF3w6OkNwZR96M
X-Received: by 2002:ac8:5791:0:b0:51c:13d6:b4e3 with SMTP id d75a77b69052e-51e3c339b20mr92562221cf.64.1784141376613;
        Wed, 15 Jul 2026 11:49:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm198015696d6.42.2026.07.15.11.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:49:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 5/5] libselinux: label_db: prevent integer overflows on resizing
Date: Wed, 15 Jul 2026 14:49:14 -0400
Message-ID: <20260715184914.45524-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
References: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The label db backend resizing logic for the catalog is also prone to
integer overflows currently. Fix it in a similar manner as we have
done elsewhere. Note that the catalog_t contains the number of specs ,
the limit of the array, and an embedded variable length array of
spec_t, so we are doubling the old limit, then computing the size of
the array, then adding the catalog_t size.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_db.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index bafa9328..feadb76e 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -318,10 +318,17 @@ static catalog_t *db_init(const struct selinux_opt *opts, unsigned nopts,
 		 */
 		if (catalog->limit == catalog->nspec) {
 			size_t length;
-			unsigned int new_limit = 2 * catalog->limit;
+			unsigned int new_limit;
 			catalog_t *new_catalog;
 
-			length = sizeof(catalog_t) + new_limit * sizeof(spec_t);
+			if (catalog->limit > UINT_MAX / 2)
+				goto out_error;
+			new_limit = 2 * catalog->limit;
+			if (__builtin_mul_overflow(new_limit, sizeof(spec_t),
+						   &length) ||
+			    __builtin_add_overflow(length, sizeof(catalog_t),
+						   &length))
+				goto out_error;
 			new_catalog = realloc(catalog, length);
 			if (!new_catalog)
 				goto out_error;
-- 
2.55.0

