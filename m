Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5963403EA
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149764; cv=none; b=MqFGNy8zuaYvnHKeJJbo5FxEjCrtWMP2ZgZdF8E4xdhesf1O1n3tduTv3w6kxBkCWnB18pZyyWSaUYdKdRoOsvAhpEfMab4IYSN64j9uQFodHMifnbp1gbObWUxpLf7XPeDZaamXKWd8L+eoDUu05XhAgJcd/lnRNqfMrfTV1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149764; c=relaxed/simple;
	bh=+bQfegl3ysPPWRDnHxV8jfGi5boDgRLihJUKzKMIRhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOSmcZ+BrxI0Gzcvazt5Qhx4mM+b/7vTsvLi0YLO/6En7wgNtsfGtt/zY9TLWJfDB5CR44QfBgdq4EEbi20aGlLsXFkmdrlIvu0PDfzqjxN/oyiblheodP6Q1TbQz6LYuN4zpRU6x002TtOHRIF5v4KY13NHFPn15dQQLSqMc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGnGCvaB; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGnGCvaB"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9159da9bba5so353050085a.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782149763; x=1782754563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX9I/MNwECSwy+z/brtUJzUGDT5ZT66XdBETUf8xaeU=;
        b=TGnGCvaBwi7LxHRFb4GZ6uYy/QL7QCByeTidFHsp3K5w3343U6SmmLPrwBxPWO+HTz
         PPhyuL3eRKlfWeNdlWmoqN95+jyAz9sTv3FYj/ZSCnrr93VB4KebFR7yOIel99E6Zuj9
         rO8AM2wyjSuJZBOPFb8cHv76OkcCIIbPLmcYGaOt9Rvgc86lES2EgwJ24/lQz1b4nR4u
         QWMBA9dyy2/Uz9W1Figp4P8GtVry0GIrG5Lv0ExisaoKqa/uCnVrVcifwLKye7beGmCY
         1LA68Xs5lPj1xLMpIEVUo9LkqlVjKmLuai8YOy6srAQUnIFdq9o5hQZLY5yZn5+QUiA9
         ja3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782149763; x=1782754563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eX9I/MNwECSwy+z/brtUJzUGDT5ZT66XdBETUf8xaeU=;
        b=W+SP0pzqFOD3SZu6M8yA/ZlgNqVIz5jwHk2AdXxh36MLA5oqzNMX+cb4w17RQKGqls
         HPUFo7tKjmqH9yjjNbPerPcvFu+A60iJ9zWXC7dyXF4L3xyP9l9fOnZ4EKmFnBLbHmmw
         rNrRqCIkIG8gzHXzB3V75nIMtp/8xdzeXoEHgUQCmbYVUdp3a6ruzYNtwaXDlBugoEoD
         oYWgM02F2bHlW8GCSCQWWaqfloqBfp16EqkuIllPTuqBvu/AC+iBwM/n8UMqXTHo++Vu
         ot+GeNGI7HFS3gWKQFTvQb6Zc5l/leQ33+PbVOkt6cC8GLwQP/FayCZP0uBtRWt2ot3w
         gT6g==
X-Gm-Message-State: AOJu0YyuXPTLm1ruoCzHCv2kVs/0S+nInq4i4MuOYbWS23387W0MIgtY
	lHeIcaedVTk25qYh1Yowo9spV7EAHTyzPGESAEawS8qqehAALHqBgZH6LjcZxg==
X-Gm-Gg: AfdE7cne5EXREnnXnRb3HjEzKTI7fTRLMv0k388XD0wBASbywk5X7SqmOyqanbRfE0X
	nYSpMzex45z3rRmeXwPMVnWH5eh/F8IoxOnvHm1BF0OYHq1/hlyBm/8uGhgqqo6loASew4L6gfn
	ssy1UGa7DCeaXQP8SjIdui98lxzCv/0p8wQrB7Emj6W85Ubf3n3d4Px5uqhWNlC6aS3EEp6WmoG
	Nn9eu/sS+eU7438iq85+SoQWsREaFW7zC3PSQGFZIWSDCBwsNWdHJ0DOdDauw9CVsOxwCfpSL0M
	vK0E3ZEMZcqDqIPrqa9vrwkZJuMTnc3lRXXIIBxoa+QKw3sgIbrckHZaYuZQ9Ren7UuLyPIavok
	v0Sp5Pij8g53mLDSObeLTdOqJ0O8rInFTJgmWcS4NqpJnuAYaNhYJWRsjFhKtVShULni6jJf4Pz
	oqX8k6gLZnyIa9T6uZug+0EkuDa6ZLwk6WCnU=
X-Received: by 2002:a05:620a:230f:10b0:921:24d9:a953 with SMTP id af79cd13be357-92124d9bddbmr1602279585a.18.1782149762490;
        Mon, 22 Jun 2026 10:36:02 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39188csm34813485a.6.2026.06.22.10.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 10:36:01 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/6 v3] libsepol: Add overflow checks
Date: Mon, 22 Jun 2026 13:35:41 -0400
Message-ID: <20260622173541.174998-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622173541.174998-1-jwcart2@gmail.com>
References: <20260622173541.174998-1-jwcart2@gmail.com>
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
v3: Previously in patch 0004
    Use __builtin_mul_overflow() family of functions
    Add checks for an error for all calls to stack_push()

 libsepol/src/module_to_cil.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 00db3d7f..5b34186b 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -447,13 +447,17 @@ static int stack_push(struct stack *stack, void *ptr)
 	void *new_stack;
 
 	if (stack->pos + 1 == stack->size) {
-		new_stack = reallocarray(stack->stack, stack->size * 2,
+		if (__builtin_smul_overflow(stack->size, 2, &stack->size)) {
+			ERR(NULL, "Overflow");
+			goto exit;
+		}
+		new_stack = reallocarray(stack->stack, stack->size,
 					 sizeof(*stack->stack));
 		if (new_stack == NULL) {
+			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 		stack->stack = new_stack;
-		stack->size *= 2;
 	}
 
 	stack->pos++;
@@ -1482,7 +1486,6 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb,
 
 		rc = stack_push(stack, new_val);
 		if (rc != 0) {
-			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 		new_val = NULL;
@@ -2163,7 +2166,6 @@ static int constraint_expr_to_string(struct policydb *pdb,
 
 		rc = stack_push(stack, new_val);
 		if (rc != 0) {
-			ERR(NULL, "Out of memory");
 			goto exit;
 		}
 
@@ -4183,7 +4185,10 @@ static int module_block_to_cil(struct policydb *pdb, struct avrule_block *block,
 		(*indent)++;
 	}
 
-	stack_push(stack, decl);
+	rc = stack_push(stack, decl);
+	if (rc != 0) {
+		goto exit;
+	}
 
 	rc = block_to_cil(pdb, block, stack, *indent);
 	if (rc != 0) {
@@ -4210,7 +4215,10 @@ static int global_block_to_cil(struct policydb *pdb, struct avrule_block *block,
 		    "Warning: 'else' not allowed in global block. Dropping from output.");
 	}
 
-	stack_push(stack, decl);
+	rc = stack_push(stack, decl);
+	if (rc != 0) {
+		goto exit;
+	}
 
 	// type aliases and commons are only stored in the global symtab.
 	// However, to get scoping correct, we assume they are in the
@@ -4284,7 +4292,10 @@ static int linked_block_to_cil(struct policydb *pdb, struct avrule_block *block,
 		}
 	}
 
-	stack_push(stack, decl);
+	rc = stack_push(stack, decl);
+	if (rc != 0) {
+		goto exit;
+	}
 
 	rc = block_to_cil(pdb, block, stack, 0);
 	if (rc != 0) {
@@ -4595,7 +4606,11 @@ static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
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

