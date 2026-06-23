Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EEC2F8E84
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229793; cv=none; b=a94I73FkNxQo+gzSa96fQ99V/UWDQkWYHNsloDWujDr14iTQ0fK321v0mnp4xzLCVQ8u5Ug/OB08LElyPQoqrCKeyeJfOC9KkQpiC5yRxk4ZqFJdrhAuhtZqvADW2GG9sgceCoQgjLza2dN7DIB+k/jTndsgYKkN8kcDDyycIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229793; c=relaxed/simple;
	bh=kRwaS6Jt/9ne+8wbO6SJDPp2hfaDuJVDBU495OxDWEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugT4uPjougemk/xSAijMCT1r6sVmGxt8hD0YMz8jiIWNbBpmNHdyjjxFg1YJYIZn4WiNqOvWBgRzFKbPT89iDlcMctiNfzO2PLyJKxlAV0WdFJCQlBMkGqx87OsL6jcs9p9DZwhvjxRo29IIeu30Zf3WJGs7rj4xzhlbLxmZopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tD3yJQod; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD3yJQod"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8dc87f7d68bso692056d6.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229791; x=1782834591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZu6gasOTJDhl1AcotlcwiMZmniaAIPO9v/pYKEwerk=;
        b=tD3yJQodmkaVxxOTqvwFFNknRk1rUjAEz7zyj+HnhEhKYz/SW7mRxdoI4Te+1JY62Y
         gEs0vW6gzce0L4XZ47B02Hx7EIgk24Yqbv4ugGCn/bcno3p1HAxkpXncjTHqNo+gXyfq
         qLTOnvtPzu5WKqLZJYk3CbO/nuqEe2yCG0U5P7ZI/UrP5f7FabcX7yivEB4mUGSR8Syr
         thJk4rCxgskOojTZjHZ4tEdZeLXAtOZPRotcAGVxlpczMYhshWJbvaxtoialJQeSQexP
         fQkX9wPa+BnESlrW/cn5/h92Sd0GsuQj/FTwBudeWoOahV2JIFjqu9mfZXG9ETzpsHgo
         ZETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229791; x=1782834591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZu6gasOTJDhl1AcotlcwiMZmniaAIPO9v/pYKEwerk=;
        b=ZYx6uNSK0twB9aLYdtExDA/lb4weP8ufr9LhGvcSmjr+zSwk2catkCaiNeF6l1U92n
         NGAX60OkD3ukrurQH7YcHN0YXPbACegx5DxWeGVc4o03c6oe7D4HipC3zZdHkgnBwnTn
         1HSAEuhDm2WNWfMOfJGA3djjZXgcAJRQhXuhCNZOptfRecy8oGPDj8ZK9TkijMCJ5Xdm
         zaM4emaGZiM4zm5R8u3wSErZfPxjl/gFa1qkyoT5bCsL1XeNm1sur7JhZcD6LueKtQ56
         LcorBILP4C0rAmdOOjrDmlOjHYbQZYduuiFAPHXegOaDrLYpHQVPKISFif1dfnEPyR6u
         z9aw==
X-Gm-Message-State: AOJu0Ywyez9CCDyBKngtQ7mvLBcZxffIa8vZz/DZ1ZJjaFj3YX/I0MYz
	ZCydMeTr4wHfGQrfGWi+cCyBqaKsX3BPziQF9ejH/agG99VWMcsVYerJaqCEPg==
X-Gm-Gg: AfdE7cmkWR5SR6XwlQ+pU0XM7xc/lwZmErf05O9b2HTnAOT9PxBC9pkE8YG1iDHMR6i
	xO9kMKv8RzIUAVvfVDcbS/cvMG1sGOx052OpfyFrimRRb1t/r4+6XOei0PoJp/vsrd4ol/e7oS2
	kNkEQkmD3rr9nVA3w9EP5YWC+VwuNPD6AnM2c+2PcwRry13VYO6kwcgLXW3+5KgPon0oFZL1Yca
	8642Z8oD9my7lG3IvjjDpnlUNNZx1Dtr5qMBZ62X5IkeOIgfCFUNvgGzH2uv+NN+3ykdoHPCcFh
	mmOPfHjFxJb4A0OE2gSuT/R3bbgYTwU/4m8fGjTVVW2JeZnBkMQVOSCwsj/UviZ4C3uBbEb2xdp
	7LDR79ph4NzBlXdBQgJPH/JRzFSmPBxCJRXZAdaaPcUqXqNolITwjV2pag9Q7oEgv7fbczkO22i
	Od8XNIiZBxC6+X4Yum4lsDWioEqNFk20jR+S0=
X-Received: by 2002:ad4:5746:0:b0:8da:e8ff:1a1e with SMTP id 6a1803df08f44-8de3f1be3c2mr331122336d6.43.1782229791093;
        Tue, 23 Jun 2026 08:49:51 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0164fasm128197266d6.8.2026.06.23.08.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:49:50 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/6 v4] libsepol/cil: Add overflow checks and cil_reallocarray
Date: Tue, 23 Jun 2026 11:49:35 -0400
Message-ID: <20260623154937.16913-4-jwcart2@gmail.com>
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

The CIL stack implementation uses "stack->size *= 2" to grow the
size of the stack without checking for overflow and calls
cil_realloc() using a multiplcation that could overflow.

Use __builtin_smul_overflow() to grow the stack size and exit
with an error if there is an overflow. Add the function
cil_reallocarray() that checks for overflow of the multiplication
of the array member size with the number of members and exits with
an error if there is an overflow.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v4: Switch args for call to cil_reallocarray() to the correct order

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

