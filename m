Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A63822BB
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580466; cv=none; b=igfYh8JuxO4RPvTBmQCvomhoxyRqzI+WTQ7mUFeeppyJPIIYVrKwbWQRuP9eZzP7EFIRL+t9buh68ZywAtmX0ER8U6sSoYSAGPjnB/lR9twPYM4oxFBJ6v+C1bEG3OAuTBIXr7SCBNBqFBbXUCN+aNvBkZ7ZmW3Eh1eIv/OTg2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580466; c=relaxed/simple;
	bh=Z45k+S+XmTgQL1TzA4nvvzYokZL2egbBE2OT+UpTc1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+pc0fvVB9jqQljH9gFJgddbEqGBAnkl6lkLKefkftYfWWAOpa7HlJovUgDFuxPOdIbjoY5NxvO1ofqXqyvY73PEhv1wwbRTUTFbMUcBmaMvX1+iOkozwENRp7YmH79ctTYgU2B/waILjuVegizJEL8YVfxDgnyMbcjOEg/EUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7mGx8Ct; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7mGx8Ct"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a016799d2cso13976506d6.1
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777580464; x=1778185264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDWuc8iCLn+DsVI1GelkdKNJgWnmzYlirzwwdVzktVA=;
        b=P7mGx8CtoRylAMabtDWJHfllKiSLXGV2ZGWBjIZ8xphZoey4H8ThQHDgqxZkw1bACa
         PLrYbhHbsqXLwVTk7FgJNYdscrILL3LXUiDrh91aO42GRSfMC7gVn7YuNuMnLpuGswoM
         kzl9bp77flPu+Ga5rPReSBDRuNu92/2hz4jc0z8acGSm07dOwl2ueyHhyJphqphbciVR
         wTMnPlQdi9hB0d+grUfuZaklxZBjt1lw3B5q94QJrfFvUdrQLOBh8vBX6FGhQfxgxq50
         4hjxgDZO15AjulKemnbmF9+Zax5Pv8rOEK9zEfXYA0C4oy+KXXTjejx2yb5bAfbPs+1K
         7D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777580464; x=1778185264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDWuc8iCLn+DsVI1GelkdKNJgWnmzYlirzwwdVzktVA=;
        b=Jq/9YHKMIWlfaRuU//wwCiyonIypqBHnETAcTeStQTxKpR/2L1dtrGHcKG7qKFXCLx
         hgzUCA4bYllgG4d6jxR10PXcOen4CUERJgxUWqaWjAKCmLrbo4NvMy9GjZ9mNuE62bQU
         KOfagv7B+mQtvGPSSYE54371fQKOKHafXa6a4HdvVmKkRufKUc7soQA53NbYyNKAqQq2
         9PzuCfLsxujiYSFzFofySRikOe8cpT38vg7aU1QU2KVaDgVZ6ljlFJGG00+0IVouCgaF
         8mZfNfO0RalsI1wIchY+KYa3Ld12YYUyYOAndyStgZVMLpPIcegrFZlZKpgk/BpW8Oj7
         7PYA==
X-Gm-Message-State: AOJu0Yz7UqHFwoT7bkwUqc3fYjjWOGDjn7U0ARn2NDzq5Ybj0/Rowxjn
	uqjGl95fwShpmbEaTYWPlZB7e2cSk6QMn90asPOSxtjjAEDwmhSSfrvZxQBH6g==
X-Gm-Gg: AeBDieuTnz05eN8CQ7TxMOzid/eHdHcjLVsJTjh0RyXh3ZeqCisIU/xzf+li/WcQGGr
	hFJyR5zSUDF5RVKEj+pbCS1fHCrDJi7W1+HwdwOAxUFovXUR3iwWWeXd4tJyj8DGuAMJIQXF6JE
	d7cSgqRqZ41mf5G/yz0mO4J2ytF1UxuLFT0KSH5zte39TCii4VL7drXqNj9s4SUYKWkMgpXBi2M
	pJsAGXc5SUxKC8trRyIOE3NtJwZs5HJtuzzNJUJH2rHsh1Wqyi7W50ThFMXMVHMWZ6Gvg1BXeVy
	iKDGCjNaFcaaqIJvhvD+wX6MTbKH3uskbylsZbKTvYwXayf/FKeB/9MPmGOIK+YtV6mRRezT2at
	kofHsx4gV3IkDbwKhduI/gXdVK5W0i15F86jJV4plYFPRayjK7TDKQUYwbwwjL+qGN99Gr+7Ht6
	7F+hsP8WY9fPMeiodQj813EHZ2QU0R0+PaQ71/X92+e6BNdTjF0C3HTbYsUY6Vcf/3EszwzQuA8
	Dkma3EzTXmoO4Bklx1qgyIKIqD0E0qUyDf1lg==
X-Received: by 2002:ac8:5c8d:0:b0:50d:7568:b904 with SMTP id d75a77b69052e-5102aae8e7emr68015341cf.2.1777580463585;
        Thu, 30 Apr 2026 13:21:03 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831ac7sm682246d6.49.2026.04.30.13.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:21:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: tighten type and boolean validation
Date: Thu, 30 Apr 2026 16:20:32 -0400
Message-ID: <20260430202033.1865-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten type and boolean validation during policy load
to improve robustness in the face of ill-formed policies.

Some or all of this might be redundant with the patches
previously posted in the series linked below:
https://lore.kernel.org/all/20250511173055.406906-15-cgoettsche@seltendoof.de/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/conditional.c |  7 +++++--
 security/selinux/ss/policydb.c    | 23 +++++++++++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 64f1bbb8caa0..342153ecdcb3 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -357,12 +357,15 @@ static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
 
 static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
 {
-	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
+	if (!expr->expr_type || expr->expr_type > COND_LAST) {
 		pr_err("SELinux: conditional expressions uses unknown operator.\n");
 		return 0;
 	}
 
-	if (expr->boolean > p->p_bools.nprim) {
+	if (expr->expr_type != COND_BOOL)
+		return 1;
+
+	if (!expr->boolean || expr->boolean > p->p_bools.nprim) {
 		pr_err("SELinux: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 738fd47f33e6..33ed75b92fa4 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -603,10 +603,15 @@ static int type_index(void *key, void *datum, void *datap)
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
@@ -1736,6 +1741,12 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 		}
 
 		upper = p->role_val_to_struct[upper->bounds - 1];
+		if (!upper) {
+			pr_err("SELinux: role %s: bounds wasn't defined\n",
+			       (char *)key);
+			return -EINVAL;
+		}
+
 		ebitmap_for_each_positive_bit(&role->types, node, bit)
 		{
 			if (ebitmap_get_bit(&upper->types, bit))
@@ -1770,7 +1781,11 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 		}
 
 		upper = p->type_val_to_struct[upper->bounds - 1];
-		BUG_ON(!upper);
+		if (!upper) {
+			pr_err("SELinux: type %s: bounds wasn't defined\n",
+				(char *)key);
+			return -EINVAL;
+		}
 
 		if (upper->attribute) {
 			pr_err("SELinux: type %s: "
-- 
2.53.0

