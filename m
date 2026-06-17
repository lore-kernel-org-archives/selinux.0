Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F137C91F
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722562; cv=none; b=DywdtZl0IKta7odxmQ1nbqWsZvsuCG1VFnMTPadnoO1EYZFYSzmKOY3eJbutkmcQT/c4b/ZmWJ7DuCvxdlbyO9BoRyPxsY+/LvvIPmQ8xPCNLKxctdrnPw+y8ycxS1q9a+cKbv+t3PZtzdCF1ygi/le/pvHbYB6tjqpy7QjwZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722562; c=relaxed/simple;
	bh=99EGMALpfSCb5kprFnphEsBdXVITwxhunh9da0Aa9e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJzHeWC86hNmTox9zcByFZ6LOKf9/SeAtMa7U6Yl4qwNpgepkUK1VQY0lNBGJdUwBLcA1LSF9ujAIAY5c8eqbGnbASfErg9BkrMeWqTSAtu8l5jleb/ukHB1JNXc0Nrp0qRH1Z6eRRG+FZkF/xl3aKEp6FRd79eA1prKZ/xLeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6+26Ksv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6+26Ksv"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5176a2fd597so861291cf.1
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781722560; x=1782327360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKJIfJToOKWvkQMoezcOrzBd3+WDT8LYcQjEUWRPwZs=;
        b=d6+26KsvLMiQl3lh02NSvCQzOBb+2nzAVkklecuOV76R7nWD5pfPCIWpC9eA3RQ4U8
         /aJiqmSTiJuHT9cCZiSeJ3o6YsCZ746oKvwm8ngtKCLFrnz1E6ULvfH9OvLtFNeOgOtc
         +aR0cVoCW1Y6CKHW58++I0hiQPFIWwfI5Q+oVz2jWQz8xwSvgCdvb1Tvqa0ttyIY63NG
         Liw/rknL+x5DToFsnS+2zQljfMSZcMeD7aZttG0vmvR+QBnkHJrJHhXO5QY+TRBoCbKO
         +y8mLggFN5FCshE6xU1+kFc5n+SqfGRxBwyzymM7PzRON8L0z25CzDNIcs/6Or+y2NKI
         tEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781722560; x=1782327360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKJIfJToOKWvkQMoezcOrzBd3+WDT8LYcQjEUWRPwZs=;
        b=YnDzbxakSAJC391iuswb2I1FJKM+X5r1uLd85u+8syueyFX6Pu+QbgfnwbcFXYWXVl
         g5mzVYSjtVzje2x18bV2P/h07KLlZhzEr8hf2X2LBeW5ZQQODhCopZKm68yckfnyKVFv
         43HtCGqTxUBWeUPvspMm910jkxKC0xLiB7QMWg59KhRKHBBKz0DD8Px7n2BtqfRp4zl4
         Bzuao1vGIY4SYGFURgTR7/fRZKfOKZQizCCOXUyOfdS+Q7xELJJZgWB4t79x3dWLVDMf
         eXQLu9GvPaV2QrIgJBCJJqimF+h9b4q/26DpJokIFqQ1MJau4gkixRhw6AzsG2aLRjww
         DI9g==
X-Gm-Message-State: AOJu0YzVJnCx621OTEPoykeB4z5nmKEuYNBxhZJFykbGHa7G9cH0MhtX
	n8cZiGeHaZFybIjAZEYkIQD02K1FUuBjhnQCdFizMQ6GHxKqsncXZLpB0wHRoQ==
X-Gm-Gg: Acq92OGc5FOgf+ouF0qiehzraciGbLUjaixJHYgetGzmq/hL+14+ZVwVoYBaqeKJjd0
	KZtteST2Jt4OyKN5NXrBI2lK9/PILN10rzwztwlG7dqv/Z0OCnrI/sxONlwXbxnJ2qaYzFPOk/a
	HOtB2HO1+EGuNKXr8fiS2w0ej0a0MBCu6S130Gzg3yqmWpfsYaX9pIF0pEyY9w2qJsza7NGgKyZ
	GT1kcznRYsteW50b8VX2z3OJjtVYKDlQQFpSHNs9+4ke/PUyW/9UKOc0HebXISDWMD9MW0DTM6n
	wGsjQWcbe4yhWqz6MRsM+lxW38LzDQnkhmRUoavATa85pMKS41hG+jUUkYtqy5zeWLDB9bPmhjt
	R/EugjJ4JpPeumFbJu/m+mzztNphUZuDj+SHxUY6Uya+2Ghs5XYeGK81llILLm27HJ61pc5dkqB
	uvdJDOz3bAzE/D6dktGPPtnFdfIfJX2+LfptQ=
X-Received: by 2002:a05:622a:512:b0:516:d955:ea6 with SMTP id d75a77b69052e-519ac2101b7mr64230141cf.14.1781722560218;
        Wed, 17 Jun 2026 11:56:00 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dacdfsm182953451cf.20.2026.06.17.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:55:59 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/4] libsepol/cil: Add checks when growing lists to prevent wrapping
Date: Wed, 17 Jun 2026 14:55:42 -0400
Message-ID: <20260617185543.91749-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617185543.91749-1-jwcart2@gmail.com>
References: <20260617185543.91749-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common idiom to grow a list or buffer is to use "len *= 2", but
it is possible for the multiplication to wrap on overflow. This
would result in the new len being smaller than the old len and
could lead to problems.

Add checks to prevent doing the multiplication if it would wrap.
The multiplication can always be done if len <= MAX / 2 and
should not be done if len > MAX / 2.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c |  7 +++++++
 libsepol/cil/src/cil_stack.c       |  4 ++++
 libsepol/cil/src/cil_verify.c      | 28 ++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index bdbb871a..23faf33f 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -652,6 +652,13 @@ static int cil_resolve_alias_to_actual(struct cil_tree_node *current,
 		}
 
 		if (steps == limit) {
+			if (limit > INT_MAX / 2) {
+				cil_tree_log(
+					current, CIL_ERR,
+					"Alias checking did not resolve for %s",
+					alias->datum.name);
+				return SEPOL_ERR;
+			}
 			steps = 0;
 			limit *= 2;
 			a2 = a1;
diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_stack.c
index d9c7b0c0..c80ed7ad 100644
--- a/libsepol/cil/src/cil_stack.c
+++ b/libsepol/cil/src/cil_stack.c
@@ -77,6 +77,10 @@ void cil_stack_push(struct cil_stack *stack, enum cil_flavor flavor, void *data)
 	stack->pos++;
 
 	if (stack->pos == stack->size) {
+		if (stack->size > INT_MAX / 2) {
+			cil_log(CIL_ERR, "Stack too large\n");
+			exit(1);
+		}
 		stack->size *= 2;
 		stack->stack = cil_realloc(stack->stack,
 					   sizeof(*stack->stack) * stack->size);
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index eb732e44..ee90b0ce 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -975,6 +975,13 @@ static int __cil_verify_user_pre_eval(struct cil_tree_node *node)
 			}
 
 			if (steps == limit) {
+				if (limit > INT_MAX / 2) {
+					cil_log(CIL_ERR,
+						"User bounds checking failed "
+						"to finish for user %s\n",
+						user->datum.name);
+					goto exit;
+				}
 				steps = 0;
 				limit *= 2;
 				u1 = u2;
@@ -1028,6 +1035,13 @@ static int __cil_verify_role(struct cil_tree_node *node)
 		}
 
 		if (steps == limit) {
+			if (limit > INT_MAX / 2) {
+				cil_log(CIL_ERR,
+					"Role bounds checking failed "
+					"to finish for role %s\n",
+					role->datum.name);
+				goto exit;
+			}
 			steps = 0;
 			limit *= 2;
 			r1 = r2;
@@ -1060,6 +1074,13 @@ static int __cil_verify_type(struct cil_tree_node *node)
 		}
 
 		if (steps == limit) {
+			if (limit > INT_MAX / 2) {
+				cil_log(CIL_ERR,
+					"Type bounds checking failed "
+					"to finish for type %s\n",
+					type->datum.name);
+				goto exit;
+			}
 			steps = 0;
 			limit *= 2;
 			t1 = t2;
@@ -2112,6 +2133,13 @@ static int __cil_verify_classperms(struct cil_list *classperms,
 	} else {
 		steps++;
 		if (steps > limit) {
+			if (limit > INT_MAX / 2) {
+				cil_log(CIL_ERR,
+					"Class permission circular reference "
+					"checking failed to finish for %s",
+					cur->name);
+				goto exit;
+			}
 			steps = 1;
 			limit *= 2;
 			orig = cur;
-- 
2.54.0

