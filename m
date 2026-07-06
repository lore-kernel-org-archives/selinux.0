Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0C42643C
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348743; cv=none; b=kFo3ciXwCMsrq6Q21LPzIC7UqeEk/aoq+L0PddbD0lJGhCHF4OjprbhArjz4WiH+lt8wqzZaiHW4DVRBa42CdWJpOrn5WwwDoJUydAx2LWAtC9qxwRIBsxZbliGTjwEBlLXctdnyuFAkLf/C5lJIWTV16z/fQaJ+XiJjg+qyrw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348743; c=relaxed/simple;
	bh=pU/jVFF/dWoBd32wjVD77mhLo3w7HEAI1pFP31ui4yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGTJMUIiHG2N699GLCcNVALiw923m7Dc7zVifZXz6Ww75CMRqf6s4NCKJBZFLB3ENhUVVI+7pcytuiz/FJ0D3mYxnp0vD3BH7xAEuor5JCWoVdvd+1MKx9mq0Zfabp053OfBzGFkskuLu+IFeBy1mhumGbUVP1QrQui84Ln3+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXgLqgec; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXgLqgec"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso29953076d6.1
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348741; x=1783953541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k2tPCX4h8Va+CZkBkA9pKCTSKLPuJbiGzIzinRw8MM=;
        b=AXgLqgecFT9yrX+lUP9j+1GI5PzywkLncaEtW3me7SvWeXJn6moTxl/3tAphDvGG28
         YeiHKnBfUyYbPCbmkulYXzxqq6O5Dq7BbScOVIVFrI5tJh3Y/CoQ8rXcSIB0LTBjOW3J
         +4QvkIHnLLaT1RSKkYC4Ng1vC3+Tf3qWazOqarYZ0Ydo242jb/yNO9JRtaxQqd9HaL/C
         gSNZZGh5pMOJM0m1H+Ral7gFCt8ZrWQmNRppmLr+yePH7fZLNh9PewTpn2lmDJWC8YTh
         lWPTlN7birrC/DQOCn5FjigRaB/Nu50Jv7Irw86XFY7BKXQ1kJtpRbtezfaowJalhWfy
         zAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348741; x=1783953541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/k2tPCX4h8Va+CZkBkA9pKCTSKLPuJbiGzIzinRw8MM=;
        b=fVdoBm5Iuz04i97WHdXKxRRAOsub5o3K90Zl2ZthMbXr4vjbGSh0PByOLR8R0GR3q7
         iqdemRBaGwa+RGvHyNA9gJasCHRY+wiOsmVmZB7el5OuKmtJSN3HftQSD6bUbYWvE5gS
         2pbSGlTJNZzEdtrwS/sB4/2qkMLSJjCzf6got/0Gi2QJt5CzqBy3UUVqm3NiMMYMym+Y
         3vO9CHoIKI8C31GilIfo6d2kTwbeC/77Etkbf6pFsWEYJvJ60VBHPS3wv8G4SLS0zn8c
         HxbfvUompiJcCxSl5J7KJsexftuAH/cApAik31QCaX6TJewq0ioYonWQ1o9VpVaFK7Vh
         RHUw==
X-Gm-Message-State: AOJu0YwzTqHWnhGQjaxghdDHi8ZDDCnbDzYZYu7trFo86Y5WAOT3idkt
	xtZAkWAeEBtfZJd2aDgTPbfaGK0f6rLjFh3dNV/leMvZaF9sno4SxjBLBa4pcg==
X-Gm-Gg: AfdE7ckV7sm47KTVcMvsqpUmN0BfXbVJ88KGHatEFvPSGNVhqJPtWYEqNMDPDQH05y4
	yIw5wXQeOCiC7tl6/1a3h2vugOkt7hBdmnbgDiatweq45q92YGUFNM23TEZ4oU7YTbvePupW055
	SQj3Y//V1MzDJn2mIW5kTfRf8oFgzCj7kgH5YXPNL4rE6vaRa8PfcCaHoczUZm4JZMHnh2iM/b8
	bTgC5VFSPIN2l6TA6OcnPv/7yY3+tOjAoZrMClFl7KZ1TrvEadydUqTVbxN2pXfznpima/LdEQJ
	Ah1Eyc+y/Uk4alc5BczXUBZyBMJB4EHs29qSIvNUWHPYWyE0rFj0K2jRTrRHWxyjgjFa6ASR31G
	OX8ehn1JQEfTHGewBXCLQXTpnNTKS4fZIBtWOZAM294zaR3G2nqxbHdDAiNLKp7vpqcUHk5GZTB
	pSvnGK0EQlBAhg2/P4IL4eVRg3kygFJxhULbc=
X-Received: by 2002:a05:622a:1313:b0:51b:fdc0:ddee with SMTP id d75a77b69052e-51c3c339381mr183911771cf.30.1783348740729;
        Mon, 06 Jul 2026 07:39:00 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b19a66sm89839431cf.7.2026.07.06.07.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:39:00 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/6 v7] libsepol/cil: Add overflow checks and cil_reallocarray
Date: Mon,  6 Jul 2026 10:38:42 -0400
Message-ID: <20260706143844.25956-4-jwcart2@gmail.com>
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
v7: No changes

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
2.55.0

