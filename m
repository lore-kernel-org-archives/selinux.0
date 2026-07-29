Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B903BB67F
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353853; cv=none; b=m3zuaedYej62ahqhLjsEfnZ4yp4jXSwYDtCesnM9MzsyvBlkNc2JaK91RDJTciKsl8Yuyvmpje6FbusMkpiJAQgaH0z3SmD+iNncaZUEn0yAD0z6ziu8GXg24aZr1Nca1OPvUJA0q7kmXosaF5w1JX5cIiZp5HoG6TDd/fsgjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353853; c=relaxed/simple;
	bh=eOApWBGYP2ItZcRPDG2v/b5LqdsCKwYILK8o7uNfqnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljA7y6RAA4F8aor6IGOfDLwH+qfgBva7mmPtE+m4SPvELlyziYcNI05jRPYyczQnP1QUzs2fomu+UiDUvwoHyh5GTEijnF6dy0C2AVsAineI1fJNOWjFtcR4xwhAHjNBZWeQCoHrKea6a68G4kbUqLDvU8wSKrUIMmYdh+nBb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCOsfwHQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCOsfwHQ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-902f92b8504so9595606d6.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353847; x=1785958647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1F4zwlaYZ2STnfXumUPOX1mm8cRmZF9r9VbNKL492c=;
        b=WCOsfwHQlZEEJDsAWM/ancqcEfGsVHej6Sj7iuG3sKdpG5a30cwhosajo8GQbV19qN
         8aFwybAccyY0qmgwR5YP8dCyEhypFm6WUhAm+dSKbJjhcg1YP0zcnrjPmmQxV3TATkLY
         LtEkXz7+j3YaNnFDAb7VGqPaLzzF/OftED0+pid67HN3ohrEGFjte0XDlkVRyA+zvRIb
         VFhfbv+4DTyGJjJz1Y0m+NLfJMVTl+K8yOa4RjN5KkNuzryhNzNCMsPJMydoAyyxPfWO
         hKGSAuDTVab7Ha23xwVm4VvmzvcpdMpekAcPRrJQOhD5y/cZ2SGa9eCJibJWy9mCnxP7
         dMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353847; x=1785958647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1F4zwlaYZ2STnfXumUPOX1mm8cRmZF9r9VbNKL492c=;
        b=U84it9yNRlY72WWUupwh6qrBSoohGVqcHs8iHk0dvbJ+3EWVrak40G5P4BfMVixlQb
         0n4TZ4lCwpS2Q7uSSdBuyu8uK3p6SRTkTW0pyo5E7qcldWUAaX5/2QQmZKGaLA8eOGaK
         aIxHumJ18gyHgF4W6gTN+Wn1Kp9dx/Ptt7AzjdME1OMw7uej923LCrtK5XTzYbQpzwH0
         U5/mKNh7ti56Ia2WUcq9+jJsfz03a4R2A60BMW+Off0A0gKUN4GSB4TNsw80EuxW3rSh
         3to/pZVOxLKUS9aN/9gZ/ADoyp4qcMNZypOI/GTROtxI8lKcwqHgb/LPhkeVttpDU+5o
         cibw==
X-Gm-Message-State: AOJu0Yxl8mEsmfNn9A9Lcv2YsxT0+G0jdV7AbcvCUX6v9O3WKngWM6vA
	zg2y3SJiZE9TDggajykZsDVmLqJAvTyh4KnMvx6J3EKk3rMDBfyn8eE5GhpUyw==
X-Gm-Gg: AR+sD11L47xRUtN5nWCiwON+pl23qiYg7HX4LjGH6TLrloZPzlV9zn2FwzIZDNK8k+l
	dX3qRjnN77Xz43EpuIxutSHY+iaOipZ8MVAj9Efg3COi8J+m/4iDKMEJH6pd5SvY016U4nf9SLd
	BeRq3PkqtFjO1Q4maOYp+NsWHIPLMjLaYkZ7qR4WX97f7EgN4yUmX8tFzYFbsZSAZF3bXSVIPSp
	EX/2mjCN5e/kWFjc1Hudm+vHTjFqjm7WxWr4zBW80kD3btobAEmMP523IGEefYHI41WR1pZkZLz
	9s7w3LCVbYDHzNjqcC0Yz3GuqQiFREwO+vc8ZgH/la6tPOA4e9ev+q2UdQu8a3u6qU4YH4dmbuj
	BgpfBH1IVGSI2XOLIwFLxCf/Ggyx037c9RczsR3pxmg8IBlDWgLANWbWG9sC75b6XfnIJGYgWZX
	UefcBre1Ez609OrJ4cuY9w9L0gVpBm+wsYtDF7qTi3JdeXPoU7wCB2m5CVtkzEDIsHnxXjtBnDC
	mv2ZreoowQ=
X-Received: by 2002:ad4:4ead:0:b0:8fe:b7a6:4ff3 with SMTP id 6a1803df08f44-908301b6068mr3210096d6.23.1785353847566;
        Wed, 29 Jul 2026 12:37:27 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd905a0sm31616376d6.44.2026.07.29.12.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:37:27 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Turn assert into error in type_set_expand()
Date: Wed, 29 Jul 2026 15:37:13 -0400
Message-ID: <20260729193713.23187-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assertion in function type_set_expand() can only be violated by
a malformed policy. Since it is called before the policy has been
validated just return an error.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8d7fe519..19b5fdcc 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2827,8 +2827,8 @@ int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p,
 		for (i = 0; i < p->p_types.nprim; i++) {
 			if (p->type_val_to_struct[i] &&
 			    p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
-				assert(!ebitmap_get_bit(t, i));
-				continue;
+				if (ebitmap_get_bit(t, i))
+					goto err_neg;
 			}
 			if (ebitmap_get_bit(t, i)) {
 				if (ebitmap_set_bit(t, i, 0))
-- 
2.55.0

