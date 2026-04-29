Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93834221721
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490347; cv=none; b=hW2xA4P0VLbZZ3Ya2D+UFfH5cbYvgsHgZ0PTNcH9/Z8SyXvGD8LnlwItBhsQCDNtsEdiPAAY7zoKuC+DRvbV6+EMCVPpjdOci2BSAhHwopgWGaiL7q7L+518lwORS8BW2xRswjmKdzj6R5P4YJG76J5MIFENI7drV1ocFdQPX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490347; c=relaxed/simple;
	bh=/5RL88Ap0L/fmbjMcyDB97bFoI07RRFVyAbG8NM+jbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAp1GHrJbZSE7DM47viW18xRf7BXIDqF6owj+JeGtC++QaCUIsriyvvUgOAY7DQLw4ONrO0D4myzCwPIhGK17dj+CIIshNsCky9GF8OM6fO8ORlCcV6vFrzytt7O3zAOOR0E4Xpa0bxUr5aRXGeHjIi00B4UrOkRxF7b4j3QwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPM4rbDP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPM4rbDP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8f15e900586so6052885a.1
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777490344; x=1778095144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ok7fXkpil8v850pWGkPCXHYe4IvgzM5pTbtZdSypQI=;
        b=JPM4rbDPjB4kVRTRm1bQxO6/tVhEDinsFQ5fB5/VZ2L2u/ykXm3kkGKaneD3CNZJrb
         lOjMD4x/AamlPvxwita9AMEDq57Y4Tje8VcFEoROA34wiG+q10YVX/qETk2KYtLgOxIY
         KXTPh5zCzDMp0i+CrUHLL25M15fdt2R1iOrEMmNSCFCtjIDGgJZBrhFt6DaIJy9PEEY1
         FoWS2mxv7Bjbe2CKLRlLCYKz4r4GGQsJlNalxCbBLyXtzD97UXaie1ODmif+CRveDm1Q
         iHJeeLPW4VwNRECG8/PbeQsEPWnEwIFRspiUa9R5QYmkx7r3XXsvGw1iKRb9PXj4zn3Y
         B9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777490344; x=1778095144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ok7fXkpil8v850pWGkPCXHYe4IvgzM5pTbtZdSypQI=;
        b=ogNNY0WEumco6rthUJaFb+V18d8CJdkcvNKdh8E32ZSfJWd8144+HZ/B/PJmI49PhY
         lOJDAmRxEooWBet2k+ACoFACRYRbSJOVgE8qjeDCNpX7OZUo0ySljR3wZQZJX/8K4b9W
         RGxOJgsfcKe142pclbo0WJ6S7L1Ij+nxLsfK4TeYUyovzoIG9wimfPxIMym1jFBY3QAp
         1iUh+vvP+C12Zv21mG7Y0qEP2fPV8wFt5MGXXqJZX7XabCqeRu4u5yN17M2xIUJL2ac1
         MmyzXM7mH0R0+XX4K0vKaBgl2flSv4HwyQTXU8Tj6tvUzrSuL8WK8sjZC0r1dXBD041Q
         SCYg==
X-Gm-Message-State: AOJu0YwmTEERhq6mNxcltWc0qbdbkeQUBnPaMyYwEZZJFEWPf1tu+XmG
	riBApFHVpHwUME0JjmBLtbJ7qFX4hcSg0wV0x9H9WPVX6/uUIsj0OLOB2oOjKQ==
X-Gm-Gg: AeBDietLYH9DsG8cJnvU/32pgbYMfRrAwhfjDRntdj02NvQX3zuobug1vQO8Aefe6n3
	o7v9Yi5NvU3avK42jwqz5psZsuApkSiutXUwL6HWd3+712eeRi3ESFvNuQJdXKN9DNFwB/BTAYK
	8leWTc5atiAkUjHsyXKKx6wdFblkXY/VkUG+8eX2j/OJd8N9ZHt80/URx5ZCEqKvJMcXRNUxoS5
	uwKQAjatHzEalXkQh8Fn2WD6JKntIe/o8Ox7TjHlLnBa/g+4eQI4cgHTn6/sperOezHRfFBFzwx
	US+leMYJIVsy4qD2n6ivDAgB/WDF2+UWpzWR60OnU23UriIQjvaYemrOkbknJiv5ZDMpFQfTmRG
	gqkNHs2PMktjcjcv/Xy4/IMy2tyKXAsOKbgNbli7Lw+Pts/K7odAB+pdWj+IiRD6wMX9Eo5jKjx
	dqVNi9irVsBj2VAQ4hiAhHHOyPCrgn4pMlda4nRBG/7fQq8PM0SEf/Vofaif02lilPD0VGGKPNt
	hEpTOzzdCQWnLJy9WldbOo6sixQE0SolPMARUzOrN7LdHzyvcaCbUAUgjjjTxG3/Q==
X-Received: by 2002:a05:620a:4447:b0:8de:c429:552d with SMTP id af79cd13be357-8fa872a882amr11087885a.20.1777490344091;
        Wed, 29 Apr 2026 12:19:04 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93c712c24sm256754185a.10.2026.04.29.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:19:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: switch two allocations to use kzalloc_objs()
Date: Wed, 29 Apr 2026 15:18:40 -0400
Message-ID: <20260429191840.13959-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These were the only two allocations in the policy loading logic
that were not already using kzalloc_objs() for the policy
data structures. Fix these to be consistent with the rest and
to protect against ill-formed policy.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/conditional.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 824c3f896151..64f1bbb8caa0 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -165,7 +165,7 @@ void cond_policydb_destroy(struct policydb *p)
 int cond_init_bool_indexes(struct policydb *p)
 {
 	kfree(p->bool_val_to_struct);
-	p->bool_val_to_struct = kmalloc_objs(*p->bool_val_to_struct,
+	p->bool_val_to_struct = kzalloc_objs(*p->bool_val_to_struct,
 					     p->p_bools.nprim);
 	if (!p->bool_val_to_struct)
 		return -ENOMEM;
@@ -709,7 +709,7 @@ static int duplicate_policydb_bools(struct policydb *newdb,
 	struct cond_bool_datum **cond_bool_array;
 	int rc;
 
-	cond_bool_array = kmalloc_objs(*orig->bool_val_to_struct,
+	cond_bool_array = kzalloc_objs(*orig->bool_val_to_struct,
 				       orig->p_bools.nprim);
 	if (!cond_bool_array)
 		return -ENOMEM;
-- 
2.54.0

