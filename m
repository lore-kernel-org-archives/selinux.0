Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7E3C9ED8
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311780; cv=none; b=hFsrlZSRcs2XuMXhPd+Jaj5Q98Vaj9jVKajoQ2ruIPRSDTVVvYOuKqh/ak5t83lFzBKrrvEZncwEIQWoKoa43zlswnEiO6n9RluCeWnUERUDV+bqv4iT5kzM68UFk6AaVd+69Mswu0sUO+ERi4EJtmke6bLY/aa5pn2JfcfwPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311780; c=relaxed/simple;
	bh=o5NXI8hYqRH7tXLCppzXtE9L97Cd8XNZBJzw0bFvC74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIh9qG4r+s5/TIF46yt9ihr48ZgDPFwyM+P9NTXhzW4/Qw+A5s6R8EjBPqfBCQWoPLyjJ9R9QZNRkrYU7UqVfRmeC/lX6Whg5ZCTkVWveruyIHyAXZnWgYKz/GL5J+V40lACesiQ5dkFfd6/Cr3t1tKq+Tm7N+Jg7JDsxzhpiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ro6aoxTY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro6aoxTY"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-519b63eff15so8503511cf.2
        for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311777; x=1782916577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgODYcaf73EUbUQICO9ua3eOP1Qo5ZzdA3AkWASteFk=;
        b=ro6aoxTYcBa7vZyI3r0IEXUievzY5fhHjvKKzIyk9rV4tYGmeCmCV8v9T/XInbb+8z
         2s1Q6/GcfaHJITNVvsGb9ejDTa7x7y10ClH5egAR1KH7vgodiaSPS2HIfK9LoD+ZA35H
         jnPUGfGIQjAT7mzuaXA2K6VOqKAv47Z+teorGvnSPcMPDStFsFcoF6iwRQW5p88vMGOC
         0MnSkxV501COEmWOHjlrJgPzYDQDcshSfn7FEaiPhOjGUvxqlixssSOj5R267wSsMJuC
         FSO5MZd5o0cgNna1RWEtx9fDGdCUEgWp90HNKCozypuXe4uDlCt/Ued1gPylIBxXwnLv
         wcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311777; x=1782916577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xgODYcaf73EUbUQICO9ua3eOP1Qo5ZzdA3AkWASteFk=;
        b=n3iX/c4cBQlEO647gVFsOBg/zIiZQHUhbZZaxT2XWJFKycO0uETn7YQV1qcxOG/yGn
         ryoYrawTCrshktVaDkh5iZfYVL0ys0SACXRegyFiSZk/+ELOiXZGCppFQsu2Hm3td84T
         OECF4RglHfWW2cg1kfvhRjv3vjY9rFX0DwERH+Fy8IjtRHelBrSeBEjsD2nBU4FdGMFs
         PLy8bw+8ijGgmJiPrlpWlQ6Pq3XFTimPe0Dl959s4ZLM6fc0970W4yoT9Je6bj3Q0WlN
         WmQ0TJ2Bb/eGEuRmyCU2mjeKQTv/elKeZczk9NFmTku3CYPhQdeoiceMM+xKrhmiXdk4
         49jw==
X-Gm-Message-State: AOJu0YynnaqM13V0/5/luuAcReyaSNttblPNBbJNfw7OBBtHeeEr26rF
	oTr/p9t40GQ8QbdtQGneSBX4Zyj8pC4dwQxmGeMftT1haIcCvcY3uI2dDue+LQ==
X-Gm-Gg: AfdE7clwGulVjp+KOpCCOj6mTFAE52rvqu5Pul7aAt4u4D9F5gInRb03e2tfIhXbCvN
	jjRgsUzqk4NgMk+OVOvvOivr5AX4BjLsJylJQp11Cqfnp3/KhfcBDfb46ToFJop/fLQWZhluAU6
	A6L+FDdPD87pm6tibXx0yOvrj46f4Fw58yQtRI21eWtIxCH9jGK/rCjM6HcF2K/04S6XZoaHjGN
	zfUPDTNZMWfNh3a/O3enKhxXaGSDiExE/Oj/1ifRbANiRwZTHrTMmevVqyLrxEvz9jh39hB6uFq
	rkXjh57HL7844GLot9zx71cE7+vYjnXN1cV3pl7w6+FcPZO7fczaUmkzXImHrstpmup4C5fBXxq
	lAXAWZBQijO975K/D1xoobrYr3Z4bz6Nd9+HCNa1+XgWC456N9SleQDRSJN6R9i115ONjpA7xwE
	xk4A9iXCScHuzYAVjF3mfB4epQFV58nUj3Xsg=
X-Received: by 2002:a05:622a:c0a:b0:517:6550:2a0 with SMTP id d75a77b69052e-51a61b3f6e6mr54741731cf.19.1782311776390;
        Wed, 24 Jun 2026 07:36:16 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51afc29csm48721611cf.27.2026.06.24.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:36:15 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/6 v6] libsepol: Add overflow checks
Date: Wed, 24 Jun 2026 10:36:00 -0400
Message-ID: <20260624143600.11282-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624143600.11282-1-jwcart2@gmail.com>
References: <20260624143600.11282-1-jwcart2@gmail.com>
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
v6: No changes

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

