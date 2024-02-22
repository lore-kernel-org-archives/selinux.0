Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902017C6B
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646381; cv=none; b=Ai6OpWftRJSVqjRsYbG2OLLoB+caUJmV82EqUNsUtM0peX2vA8OEaaXQDf05CjFSF68xpPwNzb1sTsKapKgaXyeifRe6wAU9H+Sbqeo6blxppJ6FLLD2k0lN6mc6HtOQPpouq1MozI8al1ZkWv3f9y7zPB5iJwUsU1a2kjpGYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646381; c=relaxed/simple;
	bh=Iihe8s1sFaOvE4CS3K2TO5MWVkqI4zzguQZqRU/8ZzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFkkZFqmw5kmD2crMOfIfFg9BMZXZyQ/1DEiYr9H4s1bM/7bXb1kZF8Vx1fy/RCOx609mGgnmKjDrCse+vMimDTTGgZaC84S3z6kuu/y/3dprexEfgAFUTW5/ZzuSBUpN9TMv/Ep+NxsN70GIAwV7zDsmOOj7uxBPe1uH1HCt84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HtXSFk9N; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HtXSFk9N"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso302349276.0
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646378; x=1709251178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UW1y8eGbJV0lEMF+NxX+J6VP42PfeC1qW7qh9t/xVs=;
        b=HtXSFk9NSOAoSwatZ8il0eCIkoNYQ/T9ckDM+cM+XGIf0VnLMJceQT+lWvc50wsKwy
         8d0MjB4P7+d6iMzpCDywY0qYDmCSjeSvixV7H6g0lYupbSOTAHDkbdyRnn8FRSoc3ugF
         taFHHdfzLAi7JgmcC+Wc2tN+1SKRkeCS8l3w/bTYedh0yFHsVQwekVmsZ2qesGdQH07W
         Bpum5IMntjCPGaBUrMJB4pgGxF1080XxWhGecQLhJxxVDes2hgWUQJ207ClSFSz29HBP
         4FGmXC/1rxxU6n1sc31fk+bt/qP1r+RegZQrAmm6e8X0ohtseHUL1AAO/W73k7MYEEPl
         Ob3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646378; x=1709251178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UW1y8eGbJV0lEMF+NxX+J6VP42PfeC1qW7qh9t/xVs=;
        b=kyqfdPGLVUqsh1Ah+FB7FxFFDoJC0a71FNgsZfQ35yCuub96W4TJNLB4Lkw7r7ieOM
         fzSdNxw1/DvnCOrhosXYXuD3fmvf6umSTXYUWjilUMdA3n5SQPuzvz1Iw3sLyEbJfble
         m1oITIbfO2Bt73EBGXNSd34QBC9UjH6yxofrd8P0x4gOqNyy36gjOeppJcG2dFbBeIpa
         iK8o2Q9X0sLtZ6zJEW6t6lr+SuH9NDC+t2scaZcVctmSTcHKpVpcNCv2ckRQS5k5Xh/H
         sX3qulgeWWJyeGcwmh4lqMed/1jEAs8MLNI5fNq/Qps8yEGf4qbENX1Wvm5oEFAM0bBZ
         WH8Q==
X-Gm-Message-State: AOJu0YxIE6PsPaq85e+q2LvJlMwleNkfwYcSI7nCN5fucyWcNnPxeVq6
	jGDu+fnVcdVGl2z0T5c6+7IuYX6M1nvPkRO9qZVXdoylPF1nEPPrY9hw4iwQHt9d6ZT5IurPyqI
	=
X-Google-Smtp-Source: AGHT+IHbmBilW1WasHK5Bm1hy7x7bDsQQw9pxSFtg6kBl9wmXa3iX9UBOppil+x+3p3WcGY8ES9Vdg==
X-Received: by 2002:a81:bc45:0:b0:607:d46d:f8ac with SMTP id b5-20020a81bc45000000b00607d46df8acmr663090ywl.32.1708646378306;
        Thu, 22 Feb 2024 15:59:38 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id lr9-20020a0562145bc900b0068fd10638c0sm320559qvb.20.2024.02.22.15.59.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:37 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 05/21] selinux: fix style issues in security/selinux/ss/constraint.h
Date: Thu, 22 Feb 2024 18:52:23 -0500
Message-ID: <20240222235708.386652-28-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4000; i=paul@paul-moore.com; h=from:subject; bh=Iihe8s1sFaOvE4CS3K2TO5MWVkqI4zzguQZqRU/8ZzA=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl199tJazjAr2sUJW8+HDFz+gAx4XeQ3cj3NMuJ VqJ83RUzoyJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffbQAKCRDqIPLalzeJ c6HuEACjMQ4Vt7o7FLOBUreS0Ws0bAGFCDPl7DLTb39YZZVMn4TJ6O66il94s0Cgs4bDv7c0LRo vBcezRE8RCCmkVMZ74VKuO+5uAA7DEXKtO3rEzLeLewVfULQyzkJHqcu88zS6mfpkPpVyfCcfJC AUGW7uWwVJ6FQedHgqGZD7xBoBOuS8/OLFpfK9zuuT2zeex3PC0aCRZ6V24P0kcaIlacAFqn9GV Y/Hc9WypniHPDBhgqEwC1lIAIxfFT3us1aOWoDNZfIVGMPj6k+d0BAjgB4cYxlZYtpl+eYjl2OI trzB3ifwHMPYZHYU3esSjLfTYinU/u9eLlqiFzfBgkMrl7oBj+KSTbnqkcP6tvcBiy3bPfB8F7Z eNZgjz5k014o3slxoSx1x2wh0vLORRzGq3Lbts5gbtC/Moe9pa/bgKH/Vy9KURHabXZwd2b/z7/ /kIj0O6F3R4kQ0ROaE8CzHnVIx66VK0+4tFSTeZ47e+xK9iEWhCJdVx+CkMWqhRgc5Um2LVzh/r BCeH4FMzH174Ap314Ob2ypmOqgXEKM/TJnVeFqY8zsIzwpadSRHycij4ZfyF5tuXxeENZAETHXO dbny9cYGURYfnxt/ubOufNZpIPZzdKtXSzD22uRyjUmNwRYSvw5yfyP6oF/PvVPivPiUfhbNNg3 L4IV6f08GrRUOQg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/constraint.h | 61 ++++++++++++++++----------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
index f76eb3128ad5..203033cfad67 100644
--- a/security/selinux/ss/constraint.h
+++ b/security/selinux/ss/constraint.h
@@ -13,6 +13,7 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #ifndef _SS_CONSTRAINT_H_
 #define _SS_CONSTRAINT_H_
 
@@ -21,43 +22,43 @@
 #define CEXPR_MAXDEPTH 5
 
 struct constraint_expr {
-#define CEXPR_NOT		1 /* not expr */
-#define CEXPR_AND		2 /* expr and expr */
-#define CEXPR_OR		3 /* expr or expr */
-#define CEXPR_ATTR		4 /* attr op attr */
-#define CEXPR_NAMES		5 /* attr op names */
-	u32 expr_type;		/* expression type */
+#define CEXPR_NOT   1 /* not expr */
+#define CEXPR_AND   2 /* expr and expr */
+#define CEXPR_OR    3 /* expr or expr */
+#define CEXPR_ATTR  4 /* attr op attr */
+#define CEXPR_NAMES 5 /* attr op names */
+	u32 expr_type; /* expression type */
 
-#define CEXPR_USER 1		/* user */
-#define CEXPR_ROLE 2		/* role */
-#define CEXPR_TYPE 4		/* type */
-#define CEXPR_TARGET 8		/* target if set, source otherwise */
-#define CEXPR_XTARGET 16	/* special 3rd target for validatetrans rule */
-#define CEXPR_L1L2 32		/* low level 1 vs. low level 2 */
-#define CEXPR_L1H2 64		/* low level 1 vs. high level 2 */
-#define CEXPR_H1L2 128		/* high level 1 vs. low level 2 */
-#define CEXPR_H1H2 256		/* high level 1 vs. high level 2 */
-#define CEXPR_L1H1 512		/* low level 1 vs. high level 1 */
-#define CEXPR_L2H2 1024		/* low level 2 vs. high level 2 */
-	u32 attr;		/* attribute */
+#define CEXPR_USER    1 /* user */
+#define CEXPR_ROLE    2 /* role */
+#define CEXPR_TYPE    4 /* type */
+#define CEXPR_TARGET  8 /* target if set, source otherwise */
+#define CEXPR_XTARGET 16 /* special 3rd target for validatetrans rule */
+#define CEXPR_L1L2    32 /* low level 1 vs. low level 2 */
+#define CEXPR_L1H2    64 /* low level 1 vs. high level 2 */
+#define CEXPR_H1L2    128 /* high level 1 vs. low level 2 */
+#define CEXPR_H1H2    256 /* high level 1 vs. high level 2 */
+#define CEXPR_L1H1    512 /* low level 1 vs. high level 1 */
+#define CEXPR_L2H2    1024 /* low level 2 vs. high level 2 */
+	u32 attr; /* attribute */
 
-#define CEXPR_EQ     1		/* == or eq */
-#define CEXPR_NEQ    2		/* != */
-#define CEXPR_DOM    3		/* dom */
-#define CEXPR_DOMBY  4		/* domby  */
-#define CEXPR_INCOMP 5		/* incomp */
-	u32 op;			/* operator */
+#define CEXPR_EQ     1 /* == or eq */
+#define CEXPR_NEQ    2 /* != */
+#define CEXPR_DOM    3 /* dom */
+#define CEXPR_DOMBY  4 /* domby  */
+#define CEXPR_INCOMP 5 /* incomp */
+	u32 op; /* operator */
 
-	struct ebitmap names;	/* names */
+	struct ebitmap names; /* names */
 	struct type_set *type_names;
 
-	struct constraint_expr *next;   /* next expression */
+	struct constraint_expr *next; /* next expression */
 };
 
 struct constraint_node {
-	u32 permissions;	/* constrained permissions */
-	struct constraint_expr *expr;	/* constraint on permissions */
-	struct constraint_node *next;	/* next constraint */
+	u32 permissions; /* constrained permissions */
+	struct constraint_expr *expr; /* constraint on permissions */
+	struct constraint_node *next; /* next constraint */
 };
 
-#endif	/* _SS_CONSTRAINT_H_ */
+#endif /* _SS_CONSTRAINT_H_ */
-- 
2.43.2

