Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F2364EBF
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564998; cv=none; b=IqNtDAnPblWPHpW0I7GeyE1IKrX5CxN54uw3tXyfaguuJOqn8s/8NOCn5TkGgm4OVbgiFQWP4LSFOBKDRC+VfEsxchwHU0QjC7lDkGvq45nmuTIM3Ulct04A08oExjSNUaQJhwXeDuU6rHP7B8+WQqHYQ3BpKxhgesKGz+f2p9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564998; c=relaxed/simple;
	bh=59k+/lrk0C5lhqdDij9tm85v5zALswCCd/+/BWpNCo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZA2BLKqBGBWoQ4hjemOFCGg/lBFvc1WzciuS7WnW3IXImY3KB4orxCCUn3Y//8PwEnb59aVv80bFQsgHjPG5u3PXOA9KEIFsGp50oyS+i3ul54BLLNiROgmbWW4R/SDoq/MSsxaYWq53DIFypX0xnzJpYbwa7NtQjF7QCHaOkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF9/KLt2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF9/KLt2"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2cce930cso14045391cf.0
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564996; x=1787169796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLPcIX1U9QfCOUOcv+E9TIc/NIje6OkdXMsRNgpeKMU=;
        b=HF9/KLt2FETctDloZfLVNqvIgOE300MspJ6FErgNfIcXWRdifJQEbbUZR1JEU7tRN3
         KhKm8JbgGVwbI0sEPJpD087X3MeGo6YK+eAn8hPUG9aZoRE1GktpOZF/aEcHnAKK8aVw
         bmbSM3wqrHABctMOM8VxKpwD7Mb2LjGe9w/Gr/CD67eJx/8DcAy+E21jC5JSBkablYBn
         26N74m8Ewkpx8Aoti6um4tY/fZRxExbLGmV6EQJpgzuDejRtnNFEUrUQGWq+sydl/q/Z
         jnGFzXpfs4+7Dpg7qPE4mpgUaoYB5mj5Nfv07sqi97W+Fl6gYQfQpMEnLmVfIJLA/zu1
         PUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564996; x=1787169796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLPcIX1U9QfCOUOcv+E9TIc/NIje6OkdXMsRNgpeKMU=;
        b=kLElHTjHUbPD5Z0L9fipXeqeEyAoKVIGR6THZQDDsOmnG86fZqYXA/U4O8cCdbqdfU
         KGJ9BaSaVvvKrDUku20CAYjEtYPv2shGvWvYp3mgcnQwyOiNq6yXMoGn97jr86fC8lyN
         V1tz5Oy+t0knQuOu83avFTRXoddf8J6r81O1UVKbdOqAQRyBGc5/esCeOOpDnbk910mT
         XeWNs2SBwT9cGDLS2y3iN3QuHaHImxGsifbT+RI8m3q2xxBaecoFhuO04cPbP8oOldxX
         qixeppQ/CSS28FP9wFhNx22L/PdB8kJyP5szmqtltsX6GEJQSp2guKu6A0kltF7INECd
         UiuQ==
X-Gm-Message-State: AOJu0YxAWVhhOJZHyZoNIWfzIgtTerXTTo8zECM00Zt1d+nEozHVIrZd
	XRt9PicP2/MbVtbezrbTbkTTfPy2Oj491SznnszsYVtpAELZG/fe7mlIMGd8uA==
X-Gm-Gg: AR+sD13TXhKJ9VKFj3kn6euh6WSk9J2fuUPQYCOGKV0GgjfV4Hb1xL+A+GMxPOycn0l
	y5Vpk33Oxv8npbTC968wDKBklOdySZyI3QXqoNqGcFUZoC2clxo8j3VEzvVwnINUC5lVzj2YTzO
	Nok0Mc2t8lZNYQ3M5WfoTclGHWqeo706R/ZziV3BDHAgv1yY/bEi3ym/Dn00CHwAQAf7y0FsV97
	+7WBkToWxgINIDBRzl0jjYyCgSVwi3FjGh/7bKk1LkF7qzGfySPwNc/mC2O/QNVVNDeUOQ5csEO
	FlChyB2jXpDs2TH0kW+UacMKF1KWWW8NHrIe7stzkAZvh6GVRwZc4Q+Ey1rPJKW2byNVlwEyEwj
	wvuWcaQhk7pmbJcTYhhVNcMNxlRAB96uTu28Vp7mgFCPHX3JNmwBx7t7xvejICn+gQyato7hMDK
	u7auFMEa6JcoBW3i0uXN+fyL13SVJ1Synxa0JUBlyrXN6SaU5hwuxtHE8HdJrbvZIhSKo667Naz
	cpBvsk+C5Y=
X-Received: by 2002:a05:622a:1a82:b0:52d:70b4:2e1a with SMTP id d75a77b69052e-52d73c1bbecmr8507861cf.1.1786564995866;
        Wed, 12 Aug 2026 13:03:15 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d73e2c41bsm1996151cf.8.2026.08.12.13.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:03:14 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Check that a module does not have any commons when validating
Date: Wed, 12 Aug 2026 16:03:01 -0400
Message-ID: <20260812200301.15904-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since a common cannot be declared in a module and cannot be
required, there should not be any commons in a policy module. But
a maliciously crafted policy could add one which could cause
problems when processing the module.

Check that a module does not contain any commons when validating
the module after reading it in and quit with an error if it does.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 0469b0c1..fe8bf1cf 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -2092,6 +2092,8 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 			if (validate_filename_trans_hashtab(handle, p, flavors))
 				goto bad;
 	} else {
+		if ((p->policy_type == POLICY_MOD) && (p->p_commons.nprim > 0))
+			goto bad;
 		if (validate_avrule_blocks(handle, p->global, p, flavors))
 			goto bad;
 	}
-- 
2.55.0

