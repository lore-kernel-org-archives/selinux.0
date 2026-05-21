Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFB4014BB
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390408; cv=none; b=c62BwrhK8ytfy0USArFpQR0lnecbV/lMsiUwEkTmEj5jbv6WB0wO9cBMMpT3NifqNrLJkd8Ag850MkQpep3O4a4Ne8EOpo1dw3xbKVqA5xuIUVHxhN4oEmniMypVrQkdkgRonZRpA+Qpb3lQ/dPUTecPrjRBN8l/N8+crSlRUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390408; c=relaxed/simple;
	bh=I0Xod7Mro60/lbsp2YUaYpe+7Mn+/vWbgOOxriy+JTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqeqT1ULUdwfkwQ48c+4XhzhE6qC/wk3IWldxg7wjcN1PytERVhKL9CGRr2XSkWmE3mZ527Tm0E1JoZXy8PSyxEnal4G1OIlpExROyJeSyf2xGgxjy8k3HYr6NZvF0liaWoNA2CAo1RYXqP/B4BRX9avBL4O+FW6RqyAdhS4mMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p39zOw+j; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p39zOw+j"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91066394ef8so511506785a.1
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779390400; x=1779995200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxsJYtBOit9gbR7nE/NiDVkW3ed1Al5YYnH2miCw3kw=;
        b=p39zOw+js/hxOKOqCWLluILvZQoRiPHYf206JRoDk7NP+fLZmNtOIw0DYeA9kYH7CP
         irHD+CsnEPL7xfWCwlHvzlEH6AbtlJpHn2mh8v6sH92AT6xuRw6nSo5R/1BxE+SbrDOg
         FFJsBukGpB2YZrQKem0ZEGO+KuR4B3f1tNSihoqkEt4a3iPplgYFsZZfGEiFXafBqbat
         +L2XU+sxOdRB8twwwCqpVsVFj2i+y37tMwa5ou/x/mzNZJoFKgqvTdRAnWIHf6q/uQ6U
         tq/Cfolq+CnXB7t8/G9z/QR/Ac60csnQFUStxn5VWHsCnVKYHRs2L86sG0zJ6RVKEFNy
         E+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390400; x=1779995200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxsJYtBOit9gbR7nE/NiDVkW3ed1Al5YYnH2miCw3kw=;
        b=kFj22xcLAs5Wquorb5cS/dJHJ5UzMmyRfhM6Tc5c6GlmbjdUoDLm1IIE9dCq23UX2p
         e9zP1GvoPcJEy8d9jWJeC42N4Je9XS5CPKdCfRjH4Sh3+prion2xKaPXLWM2KQCv0XBV
         zllFOk6XJ+uSaXUXhjDCeQMbsIOkaaGFUG7O2Sf9xQf3SD2lz76vDAflno06+x4XFz8B
         uxjBJdX0enOyMqrENa5fnDQ9FI1SgA0pWyqmQxaDh4nQ4OtFXT/iPCZXGnUShf7ic8DN
         4MApvgyPuZxHvnGiVc0c3qD+aEdbHB5bxTxvUUtxIYeoK/ZoUdLZPISrP066zkJPr/8U
         wMtg==
X-Gm-Message-State: AOJu0Ywo6zgff3cIed2/GGU72KwS2m8lv+C3UAqVQJ5lBpLrhaY1hLHx
	MSV9cFe9MyJLzFB+qOjovI9Eor6NQAATfkwPPbdedmaH/UJW1rXZ4DPaA1rPeg==
X-Gm-Gg: Acq92OFcp07JMqm6PKaRNwO1+XauI2L7+qK15IfLIJXz4wDv5n/NlqU9Fg9eMeA3nd1
	PDJNcXvSY2gZQFjU4oyE+fNnQ8bG4EJWEjuzQGuoJFFNi2PhbBSLplCYPvm11B3a7BvvLk1WwW0
	ncyXUbWMHXpfeeEoja6sxLtvEsBtpFjsMBkSw4cDQ+exNIqo5eFmTa99SUoPdZ4pnGKbLCyepv4
	jqPA6wXPULcxYx9+9MnbsdR/HyBCorVX95rHNHqYROy1ilVmnnvmLotCi6NqhfXbdviPBv632JU
	XQ6omBpbSLxF3r+7gvNOdIeLSKqm7oGaDdiMGRb9pEehNwkV9QXFOWcfcMXfF0dF/ozNAW/bwEs
	fXgq2dLkWGhM+R/2EF3M3kl0H0CPki2EV3hJ5/uU+Qg6f2iMIpO/KI6dvIxthMWfFVTlw/N58FF
	FzqNEqgDrDh1ih+K5kRumset5fGjEezwFTrJ7DmwAvpNqMJh8zzsUUtTM+
X-Received: by 2002:a05:620a:7109:b0:90d:75ff:7d7f with SMTP id af79cd13be357-914b49dff5bmr64602085a.51.1779390399566;
        Thu, 21 May 2026 12:06:39 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914abcc8884sm170674385a.45.2026.05.21.12.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 12:06:39 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol: In module_to_cil skip empty conditional blocks
Date: Thu, 21 May 2026 15:06:25 -0400
Message-ID: <20260521190627.34885-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When converting a module to CIL, skip conditional blocks that do
not have either a true block or a false block.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module_to_cil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 89cd0b9b..5f1e4dbf 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1426,6 +1426,8 @@ static int cond_list_to_cil(int indent, struct policydb *pdb, struct cond_node *
 	struct cond_node *cond;
 
 	for (cond = cond_list; cond != NULL; cond = cond->next) {
+		if (!cond->avtrue_list && !cond->avfalse_list)
+			continue;
 
 		rc = cond_expr_to_cil(indent, pdb, cond->expr, cond->flags);
 		if (rc != 0) {
-- 
2.54.0

