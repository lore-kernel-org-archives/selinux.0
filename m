Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40316F27F
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170312; cv=none; b=Hv3rnWL3awVD1upUWn4WbJLfOSGmN8Cwgozxq6qNjYUmpnMe7kSBJFU5hkNL0BznNNmtFZPOvJzi13Hn3ouigBu73ohVTArCYDHx/3m7BHSRS7fTmDZwhNkFeCQE50sK5GCbK+G1/2bEtO9a8uNfmob/rEcA67HXSmZl4Wm0C2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170312; c=relaxed/simple;
	bh=QpH37QsuRyGgUDQH+nP+7yE1SV9Gq1ZSevbnmjDpOGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFrPx4vCy2LxKcoPYUmoYFcZBtkfmu0rVB0yCK8PHTOdSjkup5clDs6aarJyaWq+djBmHXsn28cewf+kN2KwrG3Y09h13HMEn6IeCE8fVvSioPPQOeZx3D7b8GTo3r72DJSOrsISfkOjaaIVaITWn33gU5YJAOwrZSeIvsIlj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkVOkq6Z; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkVOkq6Z"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95695190911so305451241.2
        for <selinux@vger.kernel.org>; Thu, 07 May 2026 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778170309; x=1778775109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DMD5jnsrdwJe2I64QkNxrm/AbXdW0ur9KsowfIycIMU=;
        b=dkVOkq6ZABL9zjwpP2HLNMuAcp33GADza+8HNy/cBhkYVA3+cvr7Fo+bd9sK5cQ3JB
         N2Fyn+TqBGIk/0lDkyI/uKpjKeGtb3JqXv1dtC7d+SCUbbpbHrzAwowTyklJnibv0t0t
         9G46D8inSdoAS+i/eAHRh0OApswTWfvvlK4ApuF0zykpsUFsv4UmiO5xbTbqnsz9FFs7
         RRfFmBSrLdyC54dR/SUoMZqw1qhz1okqMjxkdHJVoBsqcvuEDWDcTJjGrAfDWiGkEmH8
         rWfJ8/bXyAOgAU/LcSg0nyEGVlc7MjH74StKiG6ulIGsRBOt3feImQFRVHZrJzUBYd+O
         HHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170309; x=1778775109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMD5jnsrdwJe2I64QkNxrm/AbXdW0ur9KsowfIycIMU=;
        b=in6ehxK8Gl1/8Noe/Z2kfR7qeKVQF4BnlqTlLlM/p3bKEOsBVmOY3ZEYIulHwiNyOA
         keWMNor6h/XRBS9G57L92nSeQ55BJy+nkvJopwDtKDw+RZgpwLC38F6hvq8Zy3FHDpa2
         1NYurGRIDaWV9B5StqaQUOcrdeCUgobpPdT3aYNAtOx8YTZ5nYoo7qdjA3Yt+2wUiVU0
         8tR70d78WAMVYHDV3KqZYGsbhdyFASmW5/cmI9IiQak6xalPSql2D9d2E1tqycn1g+73
         RGvQdEl9LGnI9a2rfoU+aR+meavUHN/J3CaX4Ou0ItZw0EK9I3wXrJ2Q4Mu0DDoiuWOV
         +9pQ==
X-Gm-Message-State: AOJu0Yx4zaYMOeAgExkUhIC9ifsJS3Sz/fjV0OXQxd0ffJlK47TIN6QN
	EucsZyIwfvuVW0q+JrAuKOlyk9dS1eNg4QtjeW1t/jSsJMvY2y7mz6f0HEKE3Q==
X-Gm-Gg: AeBDietpcEpAreXCuoYTKMoXuHEA7ZKbRPTJj6E2nJq406opL2WdApuF3Iwd/rkB18o
	pSZ0qMNjIkvEAyhrYTs7WWTHrRLET+iFfjzdYf1TlZMSng1O9jEw5c1ZuK6CrvY6d6pzSFN1yLj
	7ZMZCETl/hgE2iftCN8+4ggz+k6grx+cVb3p6pxiwzKTBCkHyDIrAFqwSfwpUli7WZhFE+y63AS
	/3n3W61CteaZLel5WLAAwDQpXygB+NZElf/1K3DeTB8nucLuPXE7rhzuKxnvjDmUVeHdijJjXiT
	FF+y0VfW6h7EIMvt2jnW33P+UU+1DtyCAQGALTnbTEHLQzCCK/Jl8K4epTcUCs4wmQRZCuf9v7w
	yRCkXX3wWz8iQItafz/EEqUq59VjWMwAS+XnuCvOwS1vrw9IYp/MvRxtMMWxgxeQHORK7HCu0vf
	grLh3cImQZ05NTmeCu8sP1hEEAyhydZlzqqOMHr2cxAGbUQEycGGSrbTnC0L2wkS02sZRN4nB4I
	L/ZgCwlcTkZgVrKsAi7BANLrsiX9z9YHCaMTq4g13uOTbnmf4WdYsA=
X-Received: by 2002:a67:e102:0:b0:5f5:40ab:2d65 with SMTP id ada2fe7eead31-630f902387amr4598268137.22.1778170309350;
        Thu, 07 May 2026 09:11:49 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253e04sm1965155985a.31.2026.05.07.09.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:11:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] selinux: tighten type validation during policy load
Date: Thu,  7 May 2026 12:06:16 -0400
Message-ID: <20260507160615.3218-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten type validation during policy load to improve robustness in
the face of ill-formed policies.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 re-bases on top of selinux/dev and drops the checks covered by
the merged patches from Christian.

 security/selinux/ss/policydb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ead504a639e3..994c78536cc4 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -604,10 +604,15 @@ static int type_index(void *key, void *datum, void *datap)
 	typdatum = datum;
 	p = datap;
 
+	if (!typdatum->value || typdatum->value > p->p_types.nprim ||
+		typdatum->bounds > p->p_types.nprim) {
+		pr_err("SELinux: %s had value %u bounds %u nprim %u\n",
+			(char *)key, typdatum->value, typdatum->bounds,
+			p->p_types.nprim);
+		return -EINVAL;
+	}
+
 	if (typdatum->primary) {
-		if (!typdatum->value || typdatum->value > p->p_types.nprim ||
-		    typdatum->bounds > p->p_types.nprim)
-			return -EINVAL;
 		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
 		p->type_val_to_struct[typdatum->value - 1] = typdatum;
 	}
@@ -1861,6 +1866,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 		}
 
 		upper = p->role_val_to_struct[upper->bounds - 1];
+
 		ebitmap_for_each_positive_bit(&role->types, node, bit)
 		{
 			if (ebitmap_get_bit(&upper->types, bit))
-- 
2.54.0

