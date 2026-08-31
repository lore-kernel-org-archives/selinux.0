Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D0471261
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191049; cv=none; b=LK6h+FDyMr0jZNQp/XgUMc3jDihj96KLUM+D9DMphlpuZ6T2bh1O+lbt8AQq72C5KwfgbSjdtOjhBCFFCYDtP1s/fsBu/EIZSbTVcX3hItOPcpzJAcX1EQ94WHyjKLUUw1rGVX+PXgc8YrRuG0iFO13F5c4ZvxbE/fUXjBtlG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191049; c=relaxed/simple;
	bh=dPxT6KKHwMEwVTgYXUUgKi/r0G1cbnSFIjNLpEMs+SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYDjfjxI+gbBL1B9uw1bCepOBpMytfR4ILyLtMvsfR58dGlA3+XL0GEW58gVQwYBwZuNKbnRM4ZC/qaV+OlqDn4+NqAMXF2PELgXudQjGSSMOs0Gx6TyqkWTTnUjwpq43kgIIQCwQS3Pt/A3VL9EAszmxel0R7uVtV9nqGVIHUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlB7A8oT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlB7A8oT"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52f83889a93so38212391cf.2
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191047; x=1788795847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WO2v3OM9lQ/t+0x1+PhGjkKrKdfvtxze7mLP+KHTi3A=;
        b=XlB7A8oTmOjvEygPvQcApozH+oLUd2vFWsxV6UXZHLoo820z16vr+8++Ai1gQRCme4
         neR8ax51R43jJOfS2GFnGvaXZoqN6k5MHrNJUx0m4ominMXoDmrnlmW+JdaEHQWNmC1w
         UMUKQ/jOY9SiO92Mn7BRjDUBZ+AP48QvuUW4EaWPp13XG/0KC4mvxwBly2p/I7CNitgW
         k/sho+l0zY/UAcLus3E/4v9dEADE2RJF/EJDHk1TssA4U3FcdK2Xhl+GisMvMtSBq4o9
         36NRctkjO4NEMT7n46UUTTlgNekhRlft1cbkJKK4HgIyQO85dfSQiFCuB334xpIpHg+D
         pD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191047; x=1788795847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WO2v3OM9lQ/t+0x1+PhGjkKrKdfvtxze7mLP+KHTi3A=;
        b=sr4xxh5HPJ9WRQWGy8Ol/rMgNDJ79wsF2bWiCettLFy9U94L0IB1EZvLqPo6LOgyqO
         14ms0/ZS28r8bTA7uFnCbDRu/GVk512ngbs/Rar7Gq39WRhYTNueTLL5spSmdm7QXvKJ
         Br4zB6Ta7LZxfJ0c6iIQq7dcmaeEq7Hwr31ThXiYtU//eiGAJJxoMb2ne4gUN/CQZ06h
         oGgTtoyHojNqMoEzqd6xYHirpvv1HCaQzptFz7Ih6o9nZuMc6TahKf2GJIRgWiEz/etn
         HTEFlRGCQ+lFUfHpBU1JLSRMIeOA0JxFSBGzET09EsnZHYKQLssnnWtGExke/hsMaOpE
         8oDg==
X-Gm-Message-State: AFuF++lv50D8FGd0bGGENTcJyssp+aEQO/rMadCVpS7QW3X2ToNQwahT
	0MT+Xr76F7bavPUS31uox1UJ9ENa6HeAYQQYiVFw4zE5KeynzphphlM/baGVmw==
X-Gm-Gg: AR+sD12/Nh9TsB5ka0U1k0xwSQdGcJg4LlEfbSC91vN4wZlC4Ejs3/ZqGMilzi6Wr9T
	LANCHYQ60ZlvN7KfuEZ76h2wyjJYYORl2XpEADqBvLhs1qSwzaRq/NTh43ZG+kwe9xocFQ/TjYq
	BHZWctp7tR0pbKHPsyIalpjqIpfCOxAvFKkuNuOjM3wWSt+J1hsdYWkuPs/2aYJDps5T9qBEgS/
	Th9xZP2nSCAZ1Is8Z4OQT2x+/FOZ+7OE6O+LuaiCDXaU+jqF3aqzFkNijDzDhL+6HgE75enDsEg
	Ocf4RLPeJKJoV4XIIr6oJMrik2QCMxZ1y2UhHXh0cyLPaq7Z5q/A61ILImBLDD7q83hJurfHWLN
	p14dES15Qe09nyCtBPwxmVdAcx653nv4sThR+40CKtiKR9mvgsGoS/w1QSq6ZtZsXXkDfb/MnOJ
	ZleDmVmLjkyvVuVmVY/eFNJo+JOA6e7cvPK+iL/9JTl4AAkpUyuq48mFNVXqzoR7V5vJpg9bzWH
	GokzlV555bqu++0nYgAFY0=
X-Received: by 2002:a05:622a:13d2:b0:51b:e92f:ec5 with SMTP id d75a77b69052e-52fb93d26f0mr322268021cf.3.1788191047168;
        Mon, 31 Aug 2026 08:44:07 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ff73ae220sm56902301cf.23.2026.08.31.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:44:06 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] checkpolicy: Check for mls constraint expression in non-mls policy
Date: Mon, 31 Aug 2026 11:43:52 -0400
Message-ID: <20260831154352.49412-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a constraint expression l1, l2, h1, and h2 all refer to levels
and should only appear in mls policies.

Return an error if a mls constraint expression is found in a non-
mls policy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Fix typo in commit message.

 checkpolicy/policy_define.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 30157826..1984c52f 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4055,6 +4055,12 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
 		e1->next = expr;
 		return arg1;
 	case CEXPR_ATTR:
+		if (!mlspol && (arg1 >= CEXPR_L1L2)) {
+			yyerror("MLS constraint expression "
+				"in non-MLS configuration");
+			constraint_expr_destroy(expr);
+			return 0;
+		}
 		expr->attr = arg1;
 		expr->op = arg2;
 		return (uintptr_t)expr;
-- 
2.55.0

