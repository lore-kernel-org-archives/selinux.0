Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7717C6B
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646379; cv=none; b=cmyQKK2aRrjyMHd6WwlgMQasFb7nYMlX/Dvu9M6x05xF8nhojnvYRzqDmAkpLr4dRB49IoM5kaPTnWUr2URZDDbR405poszSeMcrsvCz+CkJxEPlDqdxh6kIhppmKb1usdV+T+0huY8ZLGysoZkSz/ffto8ILDPGIDLN+tJNhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646379; c=relaxed/simple;
	bh=rU4Aoj8b7obCE5FUPb2bH8cgy59sAqCvEFGT8kXfjRE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3d/eocf9DBpaSX19pnz7Dcfw2PMZp9GbJFDVNfMvqPBF3i0ESf2D4CAUumqUgJjwHsdzduc13QJGG0RJ49A/IsuQPT8kVkwyFrHVD9Jx36A5js2VPWJRpCFn0zXxb3VXde+8xpzhfUXRmvE29Phpb82q/U8djJiF+lbMGuv1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dTytBrS2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dTytBrS2"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-785bdb57dfaso125085985a.1
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646376; x=1709251176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUFfgvT2p2NGB9BEp7fJ7yIOIoBEkH6tXFA3/vA00Ys=;
        b=dTytBrS2RXubgPL6Q6Dr13ptmf53RvT+c6IAFMKBgNBFp60j1bxAFmBV0m1sZGAbUD
         rm2sWG+B+kB3692ypPERhIFHD05OUme9rrhrQHVw8FQ3KuKUdDJK7R6Ve0vamo+mgksV
         Cu70ZAYBtDMCC9sssQ5he/sHO3gy3vBUKCMh+G9vJrroZRs3b7BXv9uVyAdTqIH5Y84j
         LTgcJmpO02KfDR0GVJL9LvjaxasUSh0cwuZpOz+bzY2zeh7NpL7+A14PWpBb1XOtVUen
         pc/JNsR+zI1Sfqx2INHLjfkGxNdSLbI1Jn5Z+RtrQQjUgKTYKM2vUXu6iZQTU0O/lzO8
         XWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646376; x=1709251176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUFfgvT2p2NGB9BEp7fJ7yIOIoBEkH6tXFA3/vA00Ys=;
        b=p9e/j45Ym6Sx1FJwyVRCNPPFKBisnyMXHGqsTRwcxI10Z2Bf3tBPYpluaVwM+EYpKt
         SfgXjdkUKUleKxyMKiSlj282BrVJNVafNnY5gJr/+osFKVnO7+OAWfmehR4O0X6ZbjhG
         sVZL1B1opvEsftDM6nTxEiG3dQpvQnWVfSMjH1JlEXOMRP/jvuTti3UsR7oE+NpyjBAo
         oo8CzM2l/wcQcd2dDlLEOqshUBiYz+JwRAJIR803r9wxs10WihnLnAojTSRNX+jLCsyo
         gTpeaOL6P1dGef2kraPND7tEDdBMnm8KiOZ+IjKvSto97wrNUt6UAST7KEJbOxh8Uyuk
         f3kw==
X-Gm-Message-State: AOJu0YwRFQUREdtGZhLI62r0FQFiogSHrVzZX4frwvdkMJPXkG1FezxR
	KHcgdC4B1kvzvIH70uJqIZUaT9ZaR/AzQmP0xNZAJbQC+UfSheqROs5VIP2CsCsegWxTtw7h1xg
	=
X-Google-Smtp-Source: AGHT+IESExn85nftMTHIY7lVJ7LSuhUFW2BYIYi/4pND1MyaitPe7HbqfmXp2pjj0K5nTJ8u8ikpUg==
X-Received: by 2002:a0c:f04b:0:b0:68f:30ec:f357 with SMTP id b11-20020a0cf04b000000b0068f30ecf357mr860302qvl.32.1708646376242;
        Thu, 22 Feb 2024 15:59:36 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ny13-20020a056214398d00b0068f133f4120sm7483604qvb.126.2024.02.22.15.59.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:35 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 03/21] selinux: fix style issues in security/selinux/ss/conditional.h
Date: Thu, 22 Feb 2024 18:52:21 -0500
Message-ID: <20240222235708.386652-26-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2563; i=paul@paul-moore.com; h=from:subject; bh=rU4Aoj8b7obCE5FUPb2bH8cgy59sAqCvEFGT8kXfjRE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl199h/48DdJ7ez7VOy4xLLHd4Gy7daIParF/JL snvSm5aljuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffYQAKCRDqIPLalzeJ c3VWEADbAZdp5CEUoJ+6ffNAkFrLfeVqHxRx6II2fPlx9Wjsd5NzH+ZfvBgGEVTyMLqZ90CJ1/D HcOSY7DLJ8OUb3pJ3Fu3DHogQmIhC9G38k/Z0DgxZDN4joc8uApXdoWAEuKj/UFEZoqBYuVw+Lj sGd0tIKtt0e0NVst8GNDDDhjxPHdMyTVSjJ9IoFY4H6CtJlgMQPDtCtlP96I1vEgcztkdKVgKrE aHAKHD+hc81d1dwKxzlAxhign/Pnkdi2zXWZqb7cpVR6LHuym89y2DK87/nsMSFDUziaYWoMdtO DCneQj1mGAf5tUbIaPQD4EWFBcIA55etl5csUXQ0R26S/DqCEOUvmEMbJJ1i1/nt/euDMmhhnGB 9xcw9hNos3iyVNhbu69bqPb2f2LHVqXaY0vFeMhUOZ9iH+3cBSuLaZi6vnHsxIDQTwwrIboBKMd 816u9YsrSs7u4bPN8MXzeddMsilwDzn2D+NRQ5uiwDWRH7giHJbDPl9T6vH9br9tSWukcZTR41V R186+1iV7K6U/gRei2FlTh52DDUjjl1dMk6uZO7hHUWYiav28cdxGUJSxrMaP6iIA09Z1MEY79X Of/1M9GrfgUMm7+kSU16aQvwcSyD2CCfMyUCL+LxUEZns6gGGaoEelOWVi+0UlmcuwqJF345hur gbHon29CcwC0/5w==
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
 security/selinux/ss/conditional.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 5a7b51278dc6..b972ce40db18 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -1,8 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Authors: Karl MacMillan <kmacmillan@tresys.com>
  *          Frank Mayer <mayerf@tresys.com>
- *
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *          Copyright (C) 2003 - 2004 Tresys Technology, LLC
  */
 
 #ifndef _CONDITIONAL_H_
@@ -20,14 +19,14 @@
  * in reverse polish notation.
  */
 struct cond_expr_node {
-#define COND_BOOL	1 /* plain bool */
-#define COND_NOT	2 /* !bool */
-#define COND_OR		3 /* bool || bool */
-#define COND_AND	4 /* bool && bool */
-#define COND_XOR	5 /* bool ^ bool */
-#define COND_EQ		6 /* bool == bool */
-#define COND_NEQ	7 /* bool != bool */
-#define COND_LAST	COND_NEQ
+#define COND_BOOL 1 /* plain bool */
+#define COND_NOT  2 /* !bool */
+#define COND_OR	  3 /* bool || bool */
+#define COND_AND  4 /* bool && bool */
+#define COND_XOR  5 /* bool ^ bool */
+#define COND_EQ	  6 /* bool == bool */
+#define COND_NEQ  7 /* bool != bool */
+#define COND_LAST COND_NEQ
 	u32 expr_type;
 	u32 boolean;
 };
@@ -75,9 +74,9 @@ int cond_write_bool(void *key, void *datum, void *ptr);
 int cond_write_list(struct policydb *p, void *fp);
 
 void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
-		struct av_decision *avd, struct extended_perms *xperms);
+		     struct av_decision *avd, struct extended_perms *xperms);
 void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
-		struct extended_perms_decision *xpermd);
+			 struct extended_perms_decision *xpermd);
 void evaluate_cond_nodes(struct policydb *p);
 void cond_policydb_destroy_dup(struct policydb *p);
 int cond_policydb_dup(struct policydb *new, struct policydb *orig);
-- 
2.43.2

