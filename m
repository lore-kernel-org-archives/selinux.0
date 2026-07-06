Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E53DDAED
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348745; cv=none; b=f7+B4wIszyoPxsMkayQnlRkhkl6LQhY6cbxsToSPZs7Qr0lXgGZzu3F9IIZQhagID4AVI7lql61BP39GhK99rDxcBkiaapbQuf6mNs5AT8qfw4hbvu//pVJd18aPkqy1Fv4aFa89kGx6LMaqeejf3Oubmm4Io2hP3H2X+gXEEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348745; c=relaxed/simple;
	bh=aSn2zHx4ql2jMH52gY8zCpBAEi+J7Z+W/4maFAHy4xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0gZ75F5Lo7cOABune8lyEMnHe8Fps0xVQ1VRpjml9ErLA6RxqXBpDfYd+LiHT88jHFVma60XzJeX7Av2NQ0Zv+uA2bYSRxC3oHYvoBNvxT/LKwVbH1jvOe0iacJS873wHHKj5h+wxGehoppNVuVPD13Dj6wqfvG1v/uyUTaErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOZnY9qW; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOZnY9qW"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c04bf4711so31115521cf.2
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348743; x=1783953543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p7IjqqBtTdDwcvgamY7XsaXc3Jb+lkc8JHKKELs0rA=;
        b=lOZnY9qWnVkdBAjUvt6f4r73Y/N5Xi++DOQs/QRXHFaUCx8nO92SQ8b+Xz6ld3CfzW
         eKCkad8vPD6mGInR2KB76j/KhaKRRM3I1x9vP/zF2MYkDlczC1qk8HA8tJOdcPlOpQFn
         TuSkRArHH6Ikmal7n6P1H67UYkFHZUvnG2+X2YtknyVJtCqKuSgKcFA2W6s/g9+R0FZ5
         ukTTMx1+dQh3oZkZ8VuoFJxMEJdNxmTQYV+CTrQPFh9G2Xak7KLp2TqkI6jirEY+2b+G
         +dWkCb49/0jJXJL0knk+DxMpAu7UMVeeVvTDnZFfUw73WU2rTnKNtObtoC4Yy6cApP9f
         a/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348743; x=1783953543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5p7IjqqBtTdDwcvgamY7XsaXc3Jb+lkc8JHKKELs0rA=;
        b=qIm2AMsGDUQSkZA3jZD1cwUJGKVnkvSAB4qrvS8ej5e2m+Bc59MxGq5AkK/RUbmLFU
         YJYRGcKu0Qj/rLeWmhrnFaOmiWu839NIkfCMeXQBbZWQ1QNi74gwXxsPweKWHxjQYP2s
         toWJ1z8zfgZJ1Bs6sCp/GizX9n/Mrz5FUWX6Ge99fMyK7Yz/6GKj+DohLuKjc8gHC7A3
         a2SXTbGbymlsymARIYSTYT5yYgOapjcsTIwe2quHGdTtH75ydWRqN9beaWoOaxFfPOGm
         /IJ1f7gpylEBE0K1kpTh97VIqVD+DhBcvkE8J/GbxqW/J/brDEUlXPpU6DedqFzbdpzf
         sP0A==
X-Gm-Message-State: AOJu0YyLtxNvgc4DftjsdxeAat2kuPe4zL+I7xlGF/Lh4i4GERjAXHdf
	qe5fbaPBxBU6mF0eSx5i4ZPBD4Ru2KUTnuqkkyb7eHNeKQ1gs2eQLouhhPHPvg==
X-Gm-Gg: AfdE7cnUeCcMZ8BRUtA4qw1nfQ5PPbxaXkveUT2Y5ieSQ8Gdg5qfg1GJReYLMB+WGJF
	BTtrm6KahKuEp9lk8ttxrglVENqHjAH94rUEBiHffXV+UjX1lPf+BtwRPiH5fbZ4IFT0rx0hFlM
	fmRCb8vhZ3wYI1mqaKggBSmJp9RoOqROGsEtucxIfA6OzOkhtHttJbCZ/wgoe6LpuCpZRKK77ll
	yR89xeITcCgyFnut7eiCwEf30zoqh3OnL4WNFGhN3OWacYUXsl4r9V+w6SnILuXDx49b9BYIXMx
	5g3OrD0JmezQ2gcxSSdototP8GGdyn1kcIbtXiPy8g1Si3mht/PSx8bGep2o+lPK2AzNsfD1MXf
	sXLk/uC4//zyY6N6zZhXY098QWvsNGp7UtIQUDCmLsNbWq9kdtecX8jrfbYy0aAKQzsoaXVlaOd
	as1e9jK90eHaMtVxZLtI0tijN9+6+fcwMtT4U=
X-Received: by 2002:ac8:5ad4:0:b0:51c:1a11:75cf with SMTP id d75a77b69052e-51c747ae66cmr9969071cf.7.1783348742489;
        Mon, 06 Jul 2026 07:39:02 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b19a66sm89839431cf.7.2026.07.06.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:39:02 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/6 v7] libsepol: Add overflow checks
Date: Mon,  6 Jul 2026 10:38:44 -0400
Message-ID: <20260706143844.25956-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706143844.25956-1-jwcart2@gmail.com>
References: <20260706143844.25956-1-jwcart2@gmail.com>
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
v7: No changes

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
2.55.0

