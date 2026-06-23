Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137932609EE
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229795; cv=none; b=AczWwz/qlG6+ddVPSZBkdUTibfSi0xvndu4HzU+drsakN3wo6WzX5ydsXtaWI41AoN0YLiNaTgcLp+/ZOSl3Yy7fnIycourSNQlXhV3XCVpVjvup3/XQm8S63xOXXeDK0EpWfBcSV/VzCtyRLgLf3AZDvLqzzXPRD38s3BpQWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229795; c=relaxed/simple;
	bh=7VkLT6uuwzTnkBQUCH0T59RT7QUtIBA2PBCYCRk9OEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPW31N7F9R1sqINkfM5pRnnYWZsGZ4YU70SqxYfe/pic0+fd56mtEHMT44gaLXB4pvAObcpIbEyPmJ39ltDfhDnuBj0whhgobwqFAOT9tIxjj5WqcBCYiW0cEOLTynUly1efwNcAta14d5ObwsSqsnmnTPgOYD05U6k7VN5eT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3O2XQXm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3O2XQXm"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8dd586317ccso507386d6.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229793; x=1782834593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCD4ySkp2rwh2DVOTAOI+UZh/4Ik6sNej6BsxbJ0iyk=;
        b=k3O2XQXmi0leKE8X4RIRK3LzOHJqSU/Acy+yIPA2m1GrPfL/frHdubE0Dqo86C2TTr
         ZqymRlvepUO5WbSBdvArUDmCAU6qozOcRFIDuSmUiSeQ3v73h+cZgZhm9Co33IS5ZgR1
         hl9W1AoTA6RXnl2X8JR0TczaZm7yYbMPUSMIAMcsfXMGsEi8cl8OqWUihyJUgeJI3KBj
         2GPQQb40HQwKeSZ54XZ8ZNFspcMvsPhbxoE9Pc3yoOoPkgUu0zco/gTgPTG96q8djMmL
         A+v8kvqc5hAHeECxUtl8ZI6H60OxHGInDEqoQKN4/B9EN9raT3znLPM3Cf3WHYEya0G/
         yiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229793; x=1782834593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCD4ySkp2rwh2DVOTAOI+UZh/4Ik6sNej6BsxbJ0iyk=;
        b=XJmmzsf2iOKd7N3z9lUsdHozwsh0BCtWFSy1Qa6LXjbkyFeX8/YKgqvzHGXoZSj6pT
         TOd9HsEcMMN/u0kLf6KcSE4+5BdYW3r9W/aeKz2XCM277PkPjSh/uTz5ISdore+WguMm
         /qPAcI+w9Z5GlVKfTeYhYOSRfDsV0TRF0SoXHMXyxWrphAzghuPE7+pf3V2tRBgkAORy
         /ukZQmpMzzoWbQS/3cu1w0M4vAoFjyaxLEgZRLpoErSqX+0zBGWuoDyr/5FbQ+ZGm6ri
         XBpQtN7gztEXp10J82aer8AlhUjcwlq8AsjEbQes0jVs3J/WqH0B+BpBw4Cd1p3C9Q/G
         xvyA==
X-Gm-Message-State: AOJu0Yy1fFq+kMUwaLvJAzx+2LqeomyBSd4gzWY9zxtRxWWrent6I95A
	lkC7NzMnzJAkIQTQsC5IfdZLX9vnJOM/tphXiPs47YEEOI08LM9jbppj16gBIQ==
X-Gm-Gg: AfdE7cnFTX/K2eO6usvor1AokaAL+3ddku8fk1JG87h7I/pRHkVATzx/Hspp/4J6AhI
	ncS/fbVQq4Li557/bf5YB0q1nJz1Ow1BGCJoqT/FwnZ6BM+uo8SHOjuPSIlN678XmVpWt7L8+zw
	wD1whMdSRg22sEHxOFdZalREmwb4teuOnXx/m4+vsx1hD8mIzdWpPl6BMb72o6fvidqRfnGbgm5
	uC/QtXdhusoAoHOaQW8PmrJ1aHIL89YXVkaTEVuSFSiFemMW7unJ3Nrm+YoK9xXr0LMp4HePx7t
	YuCaZ1xjQA+9pTgvP+SC8QJRG//GkyKmqAh6FLQnJ/fdOq7L+RkUbPxY9sN/klolibxko8c1Gb2
	pJgiQRxlysffxbfgm5Gn1yFmhbCPqdiuUKNZSfygKJ2nVuPDtR8X1FI+YpzfVrHyYFiOEMdxiKE
	SHQDSBGB6nl6eKsq0sGAya+zPtSjhQPF1XBvs=
X-Received: by 2002:a05:6214:469d:b0:8ce:e098:d974 with SMTP id 6a1803df08f44-8e4337f6959mr48614446d6.6.1782229792905;
        Tue, 23 Jun 2026 08:49:52 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0164fasm128197266d6.8.2026.06.23.08.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:49:52 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/6 v4] libsepol: Add overflow checks
Date: Tue, 23 Jun 2026 11:49:37 -0400
Message-ID: <20260623154937.16913-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623154937.16913-1-jwcart2@gmail.com>
References: <20260623154937.16913-1-jwcart2@gmail.com>
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

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v4: Add temporary variable for the new size for stack_push()

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

