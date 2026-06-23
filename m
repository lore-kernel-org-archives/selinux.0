Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460F26E165
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237009; cv=none; b=OCkBhtYncnwi7w0mReaAa5Rb3fetowf3UQoXvTQd5TWbmIeWT6vf/C8gPGOZJMTUBdius/7M31Tvb+Yg8fb4ds1keW/IrsRl492ySVF8YN+9ydDWPO4c5IfNlQ9X/uxZNVt8G1f6t54wC526bdm2lK6q0x31jt/z8OfC8e3fXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237009; c=relaxed/simple;
	bh=asCr4DMmVFPxwA86toFwsXD2YKkbZoehAE5/4ffVG7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrgvN0KocnsSDYdX+ONaOR/WJ/AaukjQvVg49AKvq2Qvq4XCpr4Wz19s0MWFqKKtD3IHz0KWFGDf+xPSZ1uoC+wmBpOj5lkfc9XcGyTszjYrfqwhe8gi8LufMIaXp6QkmE2PrksEcWNuPK0ryYvpuH1XzC3WzPwzwqNkhmcHSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKQOg6xP; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKQOg6xP"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-59cfbfe64baso63498e0c.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237007; x=1782841807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V35yLYG1HkBUc5ZMn4HRL37jIyur1nN6E1DXJFmCvCs=;
        b=BKQOg6xPKR38YXOKRikQgIVmPMxqQXz4N8ki5s+TMt0BBck6BWvlvJl5M/n/02cT1o
         9jWnrsZ0Svzf8heEjfKJ2NPePOrOL+Sg/Yxdx8hN3ikPZBqCUbG8w3fl/yDaLccQgz3u
         Ru4JnPLciTv24rgppiJAktjrbZHwPa0s0ED8IX7kAFMhSfVXAv822+Q9DaN3Q7f01ONo
         4XBMIClxdNpuhOR979Vu/4eGW4nfDfdf8a4QOhkLsaJMwm8Ur8cOOiGAkwSRotCQfoen
         AWaM5wlWE8N+7lWZdt7VsfvGVpOhmSxvtBnZNRmXJvqP5pDbZ0IpiYXJhy/VYWnyQIhm
         iY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237007; x=1782841807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V35yLYG1HkBUc5ZMn4HRL37jIyur1nN6E1DXJFmCvCs=;
        b=gaB5/KXMfnCykhg/S21Dvya95vMKFxYAXYdswWDkw4jZAnHGVx5Binb9BR7Bb+SW9C
         b6oNDEsvgTOuJrbUw+WWcrsXoAocBs1w6IItWip+mx10LWnIz4q5AoWjhimoyaxv7Wfh
         WCHGSaFKsUC1vIKsoadgErqetZ++6sTJCNkA4eMPhs3EPhi4NGv2Y3pnENkHwHcbhQ+s
         kJ+Y6iLwIJ/t0dY8xRvVEUt0RiiE/tVG0MwOI0O2uL8pxPDivXkzgqehgRFPmeN5fEC+
         ZMaeGixRib4kMUGRBh2S2rrJogpN5WzLGa3rfA8vhqRIpOQnmGvi4nG0xonpUS8kLL9g
         tOYg==
X-Gm-Message-State: AOJu0Yx9M/2DLetcKw5w5mHqt1PMrvqB61xJzNEApMpp/7GtMqvOZvek
	5CbG6fbAm0ce+UjF3SAAy5li/nzxeoRJJya/nDYQ0UK/k1t3WnSuYGVaCqBK/Q==
X-Gm-Gg: AfdE7cnMfbag1+9wFN0e06OH97ZjI8r5rq/+scp9uwVApSNSfJO6buyeuNtOLKSS+RV
	H3sFrKQX+Q4FAD3suRd/m7HBLpjVlya71mwz9dY8c7Xzquy9jCPo9iFgXlKmE6tfXQyNGUBaKh6
	dic5c4J0OKgd4kYpbTteUArRG6myT7ODG4ImW/XjSi3cl7qONQH+6170ee+TD7nMo19mA6KCITa
	7MkpEcnqWtvM1Ra6i1CimB7hbVQpjK7Gmt5FoOZK5vuXWtgwA5n3ehnQZMqlNqzzNEVqpUiqwHj
	8cQgWnfS5HZkn14ekcr20d0cmBYxzQnTDkWkJWyZnCa/Z95Km6ay085H2jI8q84KCPDL/ZeQlXs
	Rz/Y/9bQJZu2hX3NSMe7joftu6TbrL0XGA8LlETX1A4N97TdAtoYs0z2zRZupeVAhtjBroMdZ9Z
	RD1/0eZr4ibBvtIOw2b1v/XfbeegEuQWpk/z0=
X-Received: by 2002:a05:6102:3fa6:b0:726:ec78:94fa with SMTP id ada2fe7eead31-72ff2e789femr2641361137.3.1782237007147;
        Tue, 23 Jun 2026 10:50:07 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df826927cesm130109646d6.41.2026.06.23.10.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:06 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/6 v5] libsepol/cil: Add overflow checks and cil_reallocarray
Date: Tue, 23 Jun 2026 13:49:49 -0400
Message-ID: <20260623174951.22074-4-jwcart2@gmail.com>
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

The CIL stack implementation uses "stack->size *= 2" to grow the
size of the stack without checking for overflow and calls
cil_realloc() using a multiplcation that could overflow.

Use __builtin_smul_overflow() to grow the stack size and exit
with an error if there is an overflow. Add the function
cil_reallocarray() that checks for overflow of the multiplication
of the array member size with the number of members and exits with
an error if there is an overflow.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v5: No changes

 libsepol/cil/src/cil_mem.c   | 12 ++++++++++++
 libsepol/cil/src/cil_mem.h   |  1 +
 libsepol/cil/src/cil_stack.c |  9 ++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
index aeffdae2..4f75122a 100644
--- a/libsepol/cil/src/cil_mem.c
+++ b/libsepol/cil/src/cil_mem.c
@@ -74,6 +74,18 @@ void *cil_realloc(void *ptr, size_t size)
 	return mem;
 }
 
+void *cil_reallocarray(void *ptr, size_t nmemb, size_t size)
+{
+	size_t array_size;
+
+	if (__builtin_mul_overflow(nmemb, size, &array_size)) {
+		cil_log(CIL_ERR, "Overflow\n");
+		exit(1);
+	}
+
+	return cil_realloc(ptr, array_size);
+}
+
 char *cil_strdup(const char *str)
 {
 	char *mem = NULL;
diff --git a/libsepol/cil/src/cil_mem.h b/libsepol/cil/src/cil_mem.h
index 7ec316af..f3f40c46 100644
--- a/libsepol/cil/src/cil_mem.h
+++ b/libsepol/cil/src/cil_mem.h
@@ -34,6 +34,7 @@
 void *cil_malloc(size_t size);
 void *cil_calloc(size_t num_elements, size_t element_size);
 void *cil_realloc(void *ptr, size_t size);
+void *cil_reallocarray(void *ptr, size_t nmemb, size_t size);
 char *cil_strdup(const char *str);
 int cil_asprintf(char **strp, const char *fmt, ...);
 
diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_stack.c
index d9c7b0c0..da2efa5f 100644
--- a/libsepol/cil/src/cil_stack.c
+++ b/libsepol/cil/src/cil_stack.c
@@ -77,9 +77,12 @@ void cil_stack_push(struct cil_stack *stack, enum cil_flavor flavor, void *data)
 	stack->pos++;
 
 	if (stack->pos == stack->size) {
-		stack->size *= 2;
-		stack->stack = cil_realloc(stack->stack,
-					   sizeof(*stack->stack) * stack->size);
+		if (__builtin_smul_overflow(stack->size, 2, &stack->size)) {
+			cil_log(CIL_ERR, "Overflow\n");
+			exit(1);
+		}
+		stack->stack = cil_reallocarray(stack->stack, stack->size,
+						sizeof(*stack->stack));
 	}
 
 	stack->stack[stack->pos].flavor = flavor;
-- 
2.54.0

