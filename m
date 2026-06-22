Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E543115BD
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149762; cv=none; b=tFfdSSR0WqP1mukbz5Su/mkEeG5syeAaBV3M6htCYb7Rfbv4pM8yAlIORvolR17KmRcJoDlS1MOhfQAgM47kH2Q+VMpRx3MUGsXVlQ0luuxYFh8H69LhSyOVccaICgLJO+Eca3Nksu9XxHCDUf6gFP0dr38RvWcoVc70dTuqhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149762; c=relaxed/simple;
	bh=KlV9U7DaUlY8jtlijZXkDlXlv7moxXyJA61qUf657Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JU06lHkWo3J17RDDRSyCKnWZVI+1XImWQzoFtuPD2ToT2FS4BeUqw9DfBy/eed5xZwpd8lONfV6hJhYoiNOzAr+nRI2jzsTzblj070WzFe1lQMhY09cTnu3ciL7VRFzXgEL0pZA9tWYIdWZpKEMNOZrD+sViFh3KZhzShksYh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+8OG4dK; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+8OG4dK"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9157d3f2098so511283185a.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782149761; x=1782754561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcJeEGHUlcE2hbWim1jd7J54bEkZ/ECF7p3l5/D3Rtw=;
        b=c+8OG4dKWAHjCuVtCKOV4ZifSsqaPbABEi57NlVPuIsKtDxPENe60iQgH2DHgXHOrF
         33gcRREIH/XHU72EivYrQsWWGlapryzYs/J91NNFVmLlMKxDad4uJiRUtzB7x2oAGD/N
         cCHvmUKHMZNTogEUW8sMOhB029YoZbfjRsP44Q/29iGeYOxdH6eW8PHpaIeAaXunylBK
         PyLBVDLK0AMajtMFi1UjfBuSipTVPqMd31F+1B2x+2WwCZLMSQFRiTxAzOuHove+FhfE
         VRRZ0+cBNJAHxCA4+ps1svTWXK8j09Q8cRtTSNTmlHZjnS7p1Ze0+mg7cyuH+h4hitNZ
         +Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782149761; x=1782754561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcJeEGHUlcE2hbWim1jd7J54bEkZ/ECF7p3l5/D3Rtw=;
        b=qeA1jHZdUqx/Ph0aVNoq43d19bYhN9synPzBJXNsmhqCUbbYJ4/RLqdaEegy+1bJHS
         LJ6vlOat+WpM8Oczm1JVKDXJUhjSyTGoRuM2iEuwgzTC09q1QcDTv9vFrT1Aqly3SO3U
         8yIa3nG3tG9Uo1008RTbRPKAsXscINiqKOS1zTzWIXCcnfurE5KE8x8sX39rtdGSIYTG
         qjspNoePmlZysainIQ8o6Wkfrcd3M6DSkFIEjMu8UEO6mJ10h6I40t2Qsfuo93/3p/0a
         sC8oem81ratqv0NqcksuTb+yzWnGyeRiuteJZi8o6zV5KRqLvKQym8cusx9QDkCMUcMj
         /EHQ==
X-Gm-Message-State: AOJu0Yynk/jDzPU382UN70/cIrEEiw+dmsMCRC3l8r+tuYj4yEnds3iF
	9QTTRrxPYE/riIbXYlxzmy5E92SfsXNdAziAbYmXAiaF5sdahu7nHgxrPhHDQA==
X-Gm-Gg: AfdE7clOalqmd8UY8UXPDoTwQgga0231F8O33iAppTKS3GFGH+q8Mrbu5X4AOaEvoEn
	dU2dnYGmzVPEDHLc6cfrNXomphD41TwODXniZch1u9qvi1YJknodhEyRE5juL269FFirtTfOGK/
	yg7br9LAhiiWgDeqFYMLy2J0MB0kPh6XNnJHisJonFHw6rrvNmQCad3kUqWouGubMsj07CyaUU6
	1Bfu/9pjtG6VVaB8zQNJKCja6wG+f9x1E9yo2kge659GCY7kK14tYFOoYZOR8pvhJW1ogqq4m5O
	Ub12bU+myYOHiof+FYs8sWtp1TVX7N7ezZDIBkB9AI0lUJxu0WC5HZjgCJveSecnrmRcrOQ44wC
	EW3YOOWJkfLS7Qp37wahKKBpB6WKDXHwMFpC228T/D7dvvPRHjwTp1fDfpHm77MxEBs5tqrar53
	DNV119v+WVmyWKlGlCTfo8N7H+M2lYpdhgRFN20jS22+nFJw==
X-Received: by 2002:a05:620a:4888:b0:915:e2a7:bea5 with SMTP id af79cd13be357-920d43323ecmr1978947085a.50.1782149760408;
        Mon, 22 Jun 2026 10:36:00 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39188csm34813485a.6.2026.06.22.10.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 10:35:59 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/6 v3] libsepol/cil: Add overflow checks and cil_reallocarray
Date: Mon, 22 Jun 2026 13:35:39 -0400
Message-ID: <20260622173541.174998-4-jwcart2@gmail.com>
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
v3: Previously in patch 0003
    Use the __builtin_mul_overflow() family of functions
    Add a cil_reallocarray() function

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
index d9c7b0c0..6fd051f8 100644
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
+		stack->stack = cil_reallocarray(
+			stack->stack, sizeof(*stack->stack), stack->size);
 	}
 
 	stack->stack[stack->pos].flavor = flavor;
-- 
2.54.0

