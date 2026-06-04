Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB873463
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598556; cv=none; b=r6iVxypTpYY0oHHWQSf77XSRkIJtgrlIEYUH+/HAtj3+9PGVjQm7rswXal2tsthyrYkdH+K4/nG+JCP4FmMbvTQHgM7hb7oexnT4SI8pFJPutlsgqxNZQSnTNpPdI4jXH7Z+3blZE1qHxzVnjfZGEyozxtWNxFvQKjyWhyUJzTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598556; c=relaxed/simple;
	bh=y2X15E+JmEFP8bhpWgqIZcgpzUfhZxLmIrylHfN+uGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lf+jTv3K9ker/iAjnbY9EA7dcT0IzlLTVeGSNqmRXV7pmERB+CJ2FUPz1E2bCNR0fJV5D16kxrfwb4AruYaku9xrgm6UFHYMMGMSHi/2MJJ4yKlDkMf95AGHhkRel43lwbxWEOUKBwbqfiG4PHsaLNmK/Lp/0ERn+d28tEsoPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plgs6Yrf; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plgs6Yrf"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ccea53f35cso11494316d6.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780598554; x=1781203354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8UB2sDC8FkqWW0cMWeA2CQxKacBkzHyDQtBLg40bL0=;
        b=plgs6YrflFdnFPDL8t8NpdBMu0e9n6o1Fxgh0eYJvOhzO6bMG7DNRPr2CeFFYjPpFO
         DVcd9flrmdYkzvduOJHpD+3gQBxw20sq6WM5WA2PjTH6HcsgO0kIQKl09AHQ9FdQZKBa
         SceoyGiNSOwgV1u8iZrL7XI59o1et1Z+bG+u4nfUnKL2eHFsKIRbpZV6avblUY9+lS9q
         uIFjsRr6pe4vbvgKGkPj4+acXkXdgsdJj6UET+rUC57SO61nMAIhZtL60Mefmw3Pef0B
         tCESuFfj3BR0ecKY0W7GpUlJGKyL7FtNrhd7X4azs0H4gZ83+KMG1S+ZjFE7PTjDy6vE
         3hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780598554; x=1781203354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8UB2sDC8FkqWW0cMWeA2CQxKacBkzHyDQtBLg40bL0=;
        b=eIrjSmFczh1Le6DPP7Uc9Pbc8Iiha3brepUfesgz3HEyOBpT/HvWiuy6zvM6hPLXAW
         Vox8I6l8SvKFJo68cUujwlY2OlHp0Dliw2Ov3MWxUfWQwIk++4hIG2/KrHzH/KOG4kT3
         iad2y3Lotyc4N6NCUzZ1nOXJKRLOjQ4JocNwxwJYl/jVWUBnhhdWJSVggz4mZ1EWu2B/
         JwqSJxV5JcFFE8jB3bodBGlWtdEn5ceRG1eCjdq/J9jULvtI1JEyqDpCQairQOw6/WCn
         UjLof+AJra025aZb/H83xsnvxWCKrVhj30e55XqLR8z7xT1p6OtJRRQT0fOQMee7E8Vr
         Sehw==
X-Gm-Message-State: AOJu0Yx5ZvmMrzj2osulwEgw9Ac1f+aDbOpBlsF+ab4kn1s7mbx5dFhp
	eOOHN/KHTQr7uXYPzgCybRGFJD2FPyBd74FQJCWFMYj+dbtQxcaRdY6EGZtvSw==
X-Gm-Gg: Acq92OEsA+E8WkwSZH4fSWvtHNE/JooZ1XjVeQfC9ahMQab7MI2DxISuJlOHlU7/0nm
	2ytbN8ccbBO8fW24KEcawQrVe8FXv7Hl3gWPZfitY693gmSdgJyWaEw0oOeP+4uMfJwuE3SoLPV
	4dyEB4xQIz9i01/l1dPne63H5x6aRk2dwOnpI7ArEu1xLTV9XI+hQd4N3R0mbpjqNJnCYraUUK3
	EgrQUY/QL3nPagtWqkHNUKTDRd1a+KMRlvgxPhmGv1k4Ps9g6/dzcMPGLwljuauAeDS9nG0QwMN
	S3z13KTPgXAkxEOm16oKRXx3RAbVCDJFQKlYZxV0hHYjn+/vVBMKPb0wJyCry7680PuirLNYCVD
	da3So9Oc/3Ti44k++ZLIQcqX6h+sgWpkMnOWiJ1BVrZ6VQRE6P1B3jLvhpI2kPhLnbQfZS68pV2
	wjhGJqh+lX0B7nxO3kiboGoDAkIPrnAZcxRb5WuNok+1Ocgw8Jb1i0K+TF72GnuonNIWkYeqAgl
	9dMXmse+GMjq2ZuQA2isHWBpbQFTtueJNBMpw==
X-Received: by 2002:ad4:5f08:0:b0:8ce:a93c:e1ad with SMTP id 6a1803df08f44-8cee6265720mr5802586d6.32.1780598554123;
        Thu, 04 Jun 2026 11:42:34 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd054d2asm59448266d6.23.2026.06.04.11.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:42:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: fix REQUIRESEUSERS true/false handling
Date: Thu,  4 Jun 2026 14:42:19 -0400
Message-ID: <20260604184219.265741-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The man page only describes setting it to 0 or 1, but the code
allows for false and true as well, but reverses the sense of the
comparison. Fix it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 364e7dc8..1d3a441f 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -210,9 +210,9 @@ static void init_selinux_config(void)
 
 			if (isdigit((unsigned char)*value))
 				*intptr = atoi(value);
-			else if (strncasecmp(value, "true", sizeof("true") - 1))
+			else if (!strncasecmp(value, "true", sizeof("true") - 1))
 				*intptr = 1;
-			else if (strncasecmp(value, "false",
+			else if (!strncasecmp(value, "false",
 					     sizeof("false") - 1))
 				*intptr = 0;
 		}
-- 
2.54.0

