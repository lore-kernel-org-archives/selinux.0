Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5603B42F1
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311778; cv=none; b=VM719C7WPwx2q63TYFcfVtONTq6OeeWYt0Z9r4p+fIR45YILkm6Zx1yHD1z8hRH2DzZ7jgb888PoBjBlNfwCZ7DusUSteNFbVLeSn5krnjQl8Pe4Jx36fBZASa3eMsHtMUz3SiOJYl8FU/0gVpUuJxHfZ05syLBZNWPuAQTY+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311778; c=relaxed/simple;
	bh=UXAzmJDtiYsZsWnVpSV5JKctHRNZtgcrfsxaZT3fYP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4wHfE8HbHGghlWlA3JVHIY3PCmKK1vKRFYYXACypJ7k2VPY4V+JpWzeOWUo9mKZ9h64j0tNevRya6AicgUUAi22igk+X68h/SblCDalsQTeKmbXALnLjCcw/ejCtu5NxxonydSNc8yz4WJHyWvm6cYYCrK/iwR3N09TSORjsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWUgrv7d; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWUgrv7d"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-517863a2edfso7212561cf.1
        for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311775; x=1782916575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIWYDSEnd+O/NKNLp5kLQu+ZjXCkrfolcSO0gR+J2ME=;
        b=BWUgrv7dKWZwU0ZOHTGhMa9GQNhAcvTJzPwh9qcANZX6thilNixzcXW8Nr8OTWihyi
         BF8CV/MWg4pgZpF9Afxe1jg3JkcVnJ1zp1WpZmnqwJH2aO46uegcuylkSBoFPzWC+Y9v
         UELm9dUGZfy2HvWMMjmH59c+9NXBXw0knGwmf33JL0YswwO2wPHzxv9IwccXkp6mWHs8
         pf8jlxau4WquC2ASkHW5DITFNBkUZ8oWz+qqiM/3Du24iDV2uZlKuRq+x8X7Y3B0iSTm
         YhMi8su0V+Tt8Kz7gnjXkk9TXe0CI6zvuRMjOm7vDljD0xXNXlI589dMsLz+nlLTUhNl
         HiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311775; x=1782916575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIWYDSEnd+O/NKNLp5kLQu+ZjXCkrfolcSO0gR+J2ME=;
        b=URve4IMrSMrQe3jayflMIofTzjDr9A/TfmcZQ9a5EnyB9X0JAXGpG9DpS7BZn4A3wC
         18cmiw+ovNPGtaLnZMa4XSTBPWpZkGhkSI98eED2ADkBLqc780kf/hmLv32LH1JZWyNL
         L+tuA0GY3CM6tLh9mWRy2jWOJYdecNzyjGBEXlmF5knE5/XNIiHY4qC26zL/WmsuMrFI
         PW6mF/ea+xWTOT8vrZReay7JzBU81+UKnYR49PwRzQMgx58FFK+1HNWag+VOc2neVuo7
         KL/b7I9540B63bBoqUtwm9El0WdWHDp2BFz2FzCC7XwXK7JjbSsFwJo+Y+cL14EHEH9U
         2Dqg==
X-Gm-Message-State: AOJu0YwOkWw2JzAudY+c657gKta5OIxrS7QfH0xaqgTXP25LAVnT0OOf
	uNkU59bqeeBfLt7GeejXDTZfH1q7QGhTKbpAwcxbKTWSJjdSdHfVCaEeFDN/2w==
X-Gm-Gg: AfdE7clCNWEfeX2DA23Kbr0licOZzH64Bv3PqH1S7poE3ejstPZfDWVRt0eK44x3NrI
	osu7cAECP44vMTDYoAJp8tvf+MiZbq4z43l4vXTZnheHtwv6NDMgNupoO+Ri0oa+D6nYHzDPbYL
	mxZQ/VEah/RBPFC8Ew/mPMKgtAQNK1m+A2ehRQD1xv7EAWezBFcRPVQDRzGtDFTvQs+1xOE4+NN
	693OG52blDXJZUZxoSYxSsfFm/RF8ZpsBhSUC7KIZL0MKo5+7NzQYJaqUu6IyLoF4kPPqCr4PIH
	8Iyp+oM+to4YL8fsh7BPKbPORSZ/mv6lWEADFVF373IX4vpIbWBGtjH3sKBIaJBqYa3v/kyGZVV
	hEzuzVOvouyfm0WxU4XbMYqRWCaXnfuT9zMW3BJW3Nr34MEhC6Mgvvbp/Z5Z1f02aO7XsZIb0rm
	u3cFBw5NgMu0yD5psp6NNaSOfO4FyqodfkARs=
X-Received: by 2002:ac8:5dcb:0:b0:517:6350:ed50 with SMTP id d75a77b69052e-51a06addd8bmr298201111cf.45.1782311774295;
        Wed, 24 Jun 2026 07:36:14 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51afc29csm48721611cf.27.2026.06.24.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:36:13 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/6 v6] libsepol/cil: Add overflow checks and cil_reallocarray
Date: Wed, 24 Jun 2026 10:35:58 -0400
Message-ID: <20260624143600.11282-4-jwcart2@gmail.com>
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
v6: No changes

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

