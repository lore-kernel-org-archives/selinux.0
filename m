Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30774652D
	for <selinux@vger.kernel.org>; Mon,  1 Apr 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984188; cv=none; b=T6u+w28Ai9Wp31LBCO0PiUMN/wkuxEx/e2UeGxtHeKa8e9UdnTvo3Y/sLOYPswT0XMgTnadeuFHWCenFD3vHmS8jKrYFUSMnUWzhuicLiuZId2mnH+hxrNPUTkMZwbe5PyNOrdjFbuIJFoGZ6f3IwRg7SeBqZlCteWNOIozdPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984188; c=relaxed/simple;
	bh=Q5yFOq+d38iH15Bbz1VCcqyA+NpAP29SUDKqd8/M7K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azAFVxe3RhwNIxhL6wlesLyrP3zb14DV4LR4/bd+HDHe7ip8WsatP+PZXsNhdFd6xEQixRAAFisqg/qjiBd3budOUT+yWGca9hvCNhisnSdU2c1cDpwH8qmgf64eGY3jWYeoP9Lianx71TVK8yDT6PQBAPU6bTQhGLMGlGrgsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMIfU+1Y; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMIfU+1Y"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22215ccbafeso2527003fac.0
        for <selinux@vger.kernel.org>; Mon, 01 Apr 2024 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711984185; x=1712588985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zyp4p/p9dVFyeMX8AV95n2wVr9iH4Us7IDEBXhtJajQ=;
        b=NMIfU+1YicP+kRLHwArpGHG55wt1DP9YpcPLcgegRfs4I2aN2415W9HxZ28wxBkfCY
         sjbw9I6lVrwAzgZI9CN8HVfrHyD7+J/moh7tZlbId0Stn7zl9aPGqb6aSyha8YuF9EKe
         rXTNErwBvv3ctlTC4E61UOELS37SQaYATnkD/siIWYHMzbD+QwO9bgT5RlRCMH2x/2ao
         igEiK9i1sdb4jKx9LT8LDaqJecwtws2OC5QsLdGE+Dsqz9UBXscpPqR4XcKhBIQsm9sO
         xHVrqVglmVnDubdDrGGg4BRiWXtEjaLizyZ9EctXjZ9Cj1xSL56MGYQEc/sitBpWwZ9O
         rYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711984185; x=1712588985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zyp4p/p9dVFyeMX8AV95n2wVr9iH4Us7IDEBXhtJajQ=;
        b=Z0lbmXHKmrAMPjq9OIm9ikSp/ZtSTGpeRkAkXBjF4kCd37uQTKWt1saAqmkhCqiPUd
         QVsZjruTX7dwGNoSw9BPerljzBuU6U8K3oKRaNI/iZBNJQJg9M/jsonJjKCICaFyFtj8
         XDR4GqvyYdtjA68dE/i38zt/qm1OjT3kS4pzCOcsObiNSr6iNWPX/a8b/wOtUSmN7Hk5
         EytBqWT/AJYDckBW4fovsYAp5rANrPFtVwtFnX57byFGF8Sbbx5THNng/2hzj0majpnK
         COVCXsSd0yu7Ej4PZtRWg6cb2ufcstHVNVKbU2a4ZLg5byKEsiWcctEqTGBn/xToFMtb
         SM1A==
X-Gm-Message-State: AOJu0Yz6pheRpB1W6/YYIm+0B6ruxxf7DtbMyJiB/Jpe0NMMkGLnAowb
	hPYB22MHisdoTkcgcitUlPjM9E5PZuhRr1Tq5r90vIdunJxXuGPNkAbC3pQC
X-Google-Smtp-Source: AGHT+IEkyHLhA/ydbOgOBSKOSujDw0OfkysT/BhFHgWNHj0L1mjkddlo7fQ0HhyJvBeITTH0vIBBeQ==
X-Received: by 2002:a05:6808:1244:b0:3c4:f08d:545d with SMTP id o4-20020a056808124400b003c4f08d545dmr1523059oiv.25.1711984185538;
        Mon, 01 Apr 2024 08:09:45 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id az6-20020a05620a170600b00789e6cc73e6sm3497764qkb.48.2024.04.01.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:09:44 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: bcressey@amazon.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Check common perms when verifiying "all"
Date: Mon,  1 Apr 2024 11:09:42 -0400
Message-ID: <20240401150942.549026-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e81c466 "Fix class permission verification in CIL", added a
check for the use of "all" in a permission expression for a class
that had no permissions. Unfortunately, that change did not take
into account a class that had common permissions, so a class that
has no permmissions of its own, but inherits permissions from a
common, will fail the verification check.

If the class inherits from a common, then add those permissions to
the permmission list when verifying the permission expression.

Example/
(common co1 (cop1))
(class cl1 ())
(classcommon cl1 co1)
(classorder (CLASS cl1))

(classpermission cp1)
(classpermissionset cp1 (cl1 (all)))

(classmap cm1 (cmp1))
(classmapping cm1 cmp1 (cl1 (all)))

Previously, both the classpermissionset and the classmapping rules
would fail verification, but now they pass as expected.

Patch originally from Ben Cressey <bcressey@amazon.com>, I have
expanded the explanation.

Reported-by: Ben Cressey <bcressey@amazon.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_verify.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 0c6d50a1..4ef2cbab 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1842,6 +1842,9 @@ static int __cil_verify_perms(struct cil_class *class, struct cil_list *perms, s
 				int count2 = 0;
 				cil_list_init(&perm_list, CIL_MAP_PERM);
 				cil_symtab_map(&class->perms, __add_perm_to_list, perm_list);
+				if (class->common != NULL) {
+					cil_symtab_map(&class->common->perms, __add_perm_to_list, perm_list);
+				}
 				cil_list_for_each(j, perm_list) {
 					count2++;
 					struct cil_perm *perm = j->data;
-- 
2.44.0

