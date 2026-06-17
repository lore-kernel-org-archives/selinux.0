Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760A3AFB11
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726228; cv=none; b=gEuzcUZ02VOOl3qzhX6iQzQeSnoTsBjSWFCNjT5lvV+rwS9JGwQs6eSdfKwQ0tfG8VRIBa0mvUVIJtZhkoHs6mdkq5w/RCtRc/EGYmsU3hzKhvN0eG/FLbbkQ2fr/ooHRBMUwgAXR64kgbktq6ho429Tv9hWqTjinX05TpjpnLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726228; c=relaxed/simple;
	bh=99EGMALpfSCb5kprFnphEsBdXVITwxhunh9da0Aa9e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsOgk4GikWMiwapsgnjxAnwlzRwZINJHDiAieV1JSEgVtiXOhg+LkFBSybluBVPns9AGFHUE0P05VyOCQI1q8FegEaGkWG5pvvrikinoymSwjl+FFFQf1sEK/G+jCB2wbhr2MsGDq/SDB63wdQx0NpLkkAr1lD2MFNhOM8UT1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nw4KLZUB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw4KLZUB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5175cb5946dso1195011cf.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 12:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726220; x=1782331020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKJIfJToOKWvkQMoezcOrzBd3+WDT8LYcQjEUWRPwZs=;
        b=Nw4KLZUBUAW7y08dDzND2FVPo/wpx5zPsljb/aTJle0TfRFo5Spd+vSlOIsLTy/Z9s
         5sAK18cY54tO/ZECndIZI2b54K/XpL5dpzHl5ryLvJZ+KLtkcDAcY42gYPSHpqy3IrPU
         k0qwqLL+uanoIv0eyrOU/Caph5rmF5RiWU4zbhwhT4JJBcErsvCeM8Z9sUYoA0rLQkn/
         BvOCZS2lPAczbNWsHrROmtzr7eWFfxn/g6W1PlOMhDZhu/5cC3kmXRZj5r7WCiK1Rb/t
         oTtlnpBYm9TnEl5sBnoamDT8gZrIZlO4ZCpI37o67P5loDlqPF3vwUwd7UpK7RXWOBNU
         2//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726220; x=1782331020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKJIfJToOKWvkQMoezcOrzBd3+WDT8LYcQjEUWRPwZs=;
        b=TM8U0XzJYc7FkBacm5Qvhroyf8j1Y7oWxtbE+9Z7Pe3O7CKmSPo5efNoAWtLSvaolp
         ZzhkWukiHZ3zig92P9bFqPf9EHhFrOm1qe9HnmioScxsigmAo2PKAAvP70aH6+cyCuHD
         hCPniRaMh4mcSxU/ZkZZfG8tjPaHU+w31hmB8F8p6sgVdSGLzJaXgVcfOgMikDf9M53Y
         XFYzBWQCWIdTti7RY5wAuumDnMoVvsxWC/sLjI2nCrrKpqlAh/z9VmO1aktyCQT5DTwv
         tZzSbjaMf4Sct+gb8Lx/GW0m4BA/tshtI7Y4m45dASmDgqVZcqKU1j4NqC+C8AhdAJIJ
         d5Zw==
X-Gm-Message-State: AOJu0YzOG0RBZ+135rAx7mEAYmkC6fr1Jfu/iM+E8W8JeVl1exn4hCwc
	aDHZWjH/vFDgGhyV2EEh8GfgGjfJ76myWmPReW1lZ3XVqJR6QpH8WKLtzo6Sbw==
X-Gm-Gg: Acq92OHwf4LVTmeFnHO+vV16a6LX2t9YhoLJ2ms8vi/tEiX8MUTuBW4a4mKLlQ1ybvj
	pnGNuVcPdn9MJSrDkgvdJ34Ds7IXD+gBSZ8Pmkhn5Pir803GDpb3G255i8e4RJOT05YNiuroTTS
	GF5JAc61Nuh0VqV7yEB7qE5pRw7UInxY6UoMi7kZToa0f7WY3MyuJydKwvVjGm5MMKvLrfi3WcT
	ySqswCLOyYmiSwNlu5Wu+yrrN26bktHPQYju03Z+sRlm4BTPIG2yrSZhaVa4MpOxf0KE8jUtC2W
	J2QiBTa+lEOYXKbvbq0zAKQHYizA9HHUqckclg3O0hGj0YexEzrJGBxMTcC9DSvBScFlM5fj5sj
	WEI/89KevshBIUUaU+C5Te8jbpzwHjwghV8/VvStDoDrOrF4dfWwz7kn0vi3verQeHnbKS5D6wF
	rAqIksuE6If3sHVJxm15pVJ7/rbk3zwSsvOak=
X-Received: by 2002:a05:622a:8f0b:b0:517:675f:3ee8 with SMTP id d75a77b69052e-519a8df0360mr79600981cf.12.1781726220301;
        Wed, 17 Jun 2026 12:57:00 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb79c5absm171767341cf.18.2026.06.17.12.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:56:59 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/4 v2] libsepol/cil: Add checks when growing lists to prevent wrapping
Date: Wed, 17 Jun 2026 15:56:44 -0400
Message-ID: <20260617195645.96604-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617195645.96604-1-jwcart2@gmail.com>
References: <20260617195645.96604-1-jwcart2@gmail.com>
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

