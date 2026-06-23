Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748738E10F
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237011; cv=none; b=D7DoNyOSXC/QIddeOWo20keLQ+uC+l+kyS6blnEf5Qp634NK2KlYv2YJSgtSt93vw5LmS89uCrd6G2RNmlevAPdb0gvBZ/rcyilEviLNUESmTCmpGLL9BTuIqWONnuC9i5vmC9jhsW2+A5Hw9XrAmwcHGwMGBxHvUjByc/zO8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237011; c=relaxed/simple;
	bh=fCJWQyxmCcmrBn5XVj2GtMqEFsKwPX8zBMd+4pEpJlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMK0VYHag+ec2xJbmIGE1iXz/Cy92Wa99HF+SSnYFpPZOZhRkSGOlyV6YPM+z9d9KEGXZuRMwFGGwziLp0baoGLDN+5OSVIbp4VmzTFe1zHCowNlLHdAI+c6sYvuMJyJR2j6mX7mSKcVbTHOf6Rme00f3CugwP2HY7AWLTwEebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAualJ3O; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAualJ3O"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8df7a3a6fc3so2533016d6.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237009; x=1782841809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmXQqkx4LJ/qOVzHWy7yDuNmKgw+GvesJdBQSY8utsM=;
        b=ZAualJ3O/pRFNHvZUeaYqqq8FQp2CIsC4YKi6er9V+BCjtr+5zyXZF0YIbexNryrXJ
         2xJ8PzKjTQQPz9Uz/mH20geMzMFsWToJQMtRrKrltYI6NJoDnsWGqc0gx9fCq1s//9G+
         hQ/VCI58hF8opfCO/0/jxwHcQhBZJMJnFiq6bLKRMMITsitBTHEEUX7RIIYUt0z1PM1U
         +MxITRCR5YfHC5JntLtr1h1/eFWBFnTiJRoVhZKZN0KSrX/+J5lgBLcJTP6TLJBk1ZIh
         KhrDULyiM0ek7QZc+fIdw+npkV//3M1Bvophhjt2Oa2c5VMY8wyU+uvZaRPPy+tY7fcS
         hT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237009; x=1782841809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OmXQqkx4LJ/qOVzHWy7yDuNmKgw+GvesJdBQSY8utsM=;
        b=QzZmjGscuOQ8k4FOhhaZrbR0gUNDgS+S9ryupI9Lp7hRMNFa2aJJ9jlVXUDkkgR9d5
         zY4IaVBC4ZAnntONjR+hD7nnPFc021nJEI481pa2dSKQ12IQDrkYrVVP+U36wwhhrUbt
         zRGn8wTkinErltd7VvirSey0OdGQbKEREHKv2MMhcrDKNKWv+4uJCXBvIRTkcadKdsFv
         dVqbM2V6nF0RA+J4F28vg/dKZjstEpTWDUVXAKp7472LEoTOYB1A+wqAMjBNoTVx03E5
         iR5WqzYH+vHZc+npdVt3wMB/9/IyGNDTlbRhvwWzfYX8mfZIUjcqa3G38CwmjecQd6c9
         CgeA==
X-Gm-Message-State: AOJu0Yx1LvIBbPyB9F1tXS3EEkXcqOEmIuvB3tC0Q2T0Gdrxap+6wuHO
	OqQbda0PE36HWuLoJHOFNYMKvFPlN8oOT0Drrch9LrsJbU8lCW4Do6BEmUd2Bw==
X-Gm-Gg: AfdE7clFlNHgEh+3PojVUUQDQVvqsNIZXoqBDrFz2eupBJ8kvuewD+aHPqfy6+H+6hC
	SI9b+2//mbaOwiQKGyNoGkXuVF0AqQ9cUkchtJa9pvjk7Aa6E97noe89M7BP6hPo2BQuu1hmmhT
	c/nWQGE1wxjWlPpy/KwuqnLst+j9x4A7fatq360d4TgLlXxdw/sPJ31lhSA1/jgIN47xdjMKL7d
	B4MjCS5iq1lfE2MywXNPQ0xRcwVCFagsRb2gETLxNRxOmdPgPpTlvLlV2NapJTJY4xpTppVX5hl
	KY+vaXd0X9X30Qv3hgyxF879Da/2Q3iOuOifw1EC1cTDtGPweo9IyCkvH2VJ/beLeE2hpXRdZi9
	3Lpi+sMfY0NT/7KefXned1UkM96s1g2jjPYoO5DZMYozu+QeFZJGOFd6FJn/b1PkFPh87B/OJhj
	z7pUO4qsMOtkhnsP/Mf6YTjJ+9j8OZDExLVvI=
X-Received: by 2002:a05:6214:21e9:b0:8df:1814:3a1d with SMTP id 6a1803df08f44-8df9133bb77mr280784266d6.22.1782237008931;
        Tue, 23 Jun 2026 10:50:08 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df826927cesm130109646d6.41.2026.06.23.10.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:08 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/6 v5] libsepol: Add overflow checks
Date: Tue, 23 Jun 2026 13:49:51 -0400
Message-ID: <20260623174951.22074-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623174951.22074-1-jwcart2@gmail.com>
References: <20260623174951.22074-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function stack_push() uses the common idiom of "*= 2" to grow
the size of the stack, but there is not check for overflow. Use the
__builtin_smul_overflow() function to report an overflow and return
an error.

There are several calls of stack_push() that does not check for
an error. Add checks for an error for these calls.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v5: No changes

 libsepol/src/module_to_cil.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 00db3d7f..2aaf4feb 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -445,15 +445,21 @@ static int stack_push(struct stack *stack, void *ptr)
 {
 	int rc = -1;
 	void *new_stack;
+	int new_size;
 
 	if (stack->pos + 1 == stack->size) {
-		new_stack = reallocarray(stack->stack, stack->size * 2,
+		if (__builtin_smul_overflow(stack->size, 2, &new_size)) {
+			ERR(NULL, "Overflow");
+			goto exit;
+		}
+		new_stack = reallocarray(stack->stack, new_size,
 					 sizeof(*stack->stack));
 		if (new_stack == NULL) {
+			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 		stack->stack = new_stack;
-		stack->size *= 2;
+		stack->size = new_size;
 	}
 
 	stack->pos++;
@@ -1482,7 +1488,6 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb,
 
 		rc = stack_push(stack, new_val);
 		if (rc != 0) {
-			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 		new_val = NULL;
@@ -2163,7 +2168,6 @@ static int constraint_expr_to_string(struct policydb *pdb,
 
 		rc = stack_push(stack, new_val);
 		if (rc != 0) {
-			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 
@@ -4183,7 +4187,10 @@ static int module_block_to_cil(struct policydb *pdb, struct avrule_block *block,
 		(*indent)++;
 	}
 
-	stack_push(stack, decl);
+	rc = stack_push(stack, decl);
+	if (rc != 0) {
+		goto exit;
+	}
 
 	rc = block_to_cil(pdb, block, stack, *indent);
 	if (rc != 0) {
@@ -4210,7 +4217,10 @@ static int global_block_to_cil(struct policydb *pdb, struct avrule_block *block,
 		    "Warning: 'else' not allowed in global block. Dropping from output.");
 	}
 
-	stack_push(stack, decl);
+	rc = stack_push(stack, decl);
+	if (rc != 0) {
+		goto exit;
+	}
 
 	// type aliases and commons are only stored in the global symtab.
 	// However, to get scoping correct, we assume they are in the
@@ -4284,7 +4294,10 @@ static int linked_block_to_cil(struct policydb *pdb, struct avrule_block *block,
 		}
 	}
 
-	stack_push(stack, decl);
+	rc = stack_push(stack, decl);
+	if (rc != 0) {
+		goto exit;
+	}
 
 	rc = block_to_cil(pdb, block, stack, 0);
 	if (rc != 0) {
@@ -4595,7 +4608,11 @@ static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
 	while ((read_len = fread(d + d_len, 1, max_len - d_len, fp)) > 0) {
 		d_len += read_len;
 		if (d_len == max_len) {
-			max_len *= 2;
+			if (__builtin_mul_overflow(max_len, 2, &max_len)) {
+				ERR(NULL, "Overflow");
+				rc = -1;
+				goto exit;
+			}
 			d_tmp = realloc(d, max_len);
 			if (d_tmp == NULL) {
 				ERR(NULL, "Out of memory");
-- 
2.54.0

