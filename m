Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5421C84BB
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149763; cv=none; b=r0tJKfWtkeAyRu96aUdbn14KlP9OLmY1M5gPdwtbgV5b987MkZm8l1GBjN4TVnRCCeLHUH7TU1JRhXfaqMLgJUEl67xaENHrqEF9M0gS305yO1HEX0gZMHX+ywUTQwxlgNyhFMJES17thk/locv2m1+u3RA6ara1chYaepB0vA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149763; c=relaxed/simple;
	bh=P6yFBYqihuu5uBShfY3zbXJ9jQNZu+4RLvXmybnFYCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s66PkaGrPwtRGlV55WPQIsN2csI68G69mSfKzah1QNaGiBdK8vYxC2VRdg+Bejnt9OFQMvONA82MZkHX2TRhIS3dk5IvJoCnmq0/2HT1nfHXkJtvq6h+lk3FcLT2MrVCpcsl+oczrkzDgRQzgvS6jlYMkO1j4rP/deF34iUoEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApwTpu1e; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApwTpu1e"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9159951f05aso527503785a.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782149761; x=1782754561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI55XeaK4Jf+yZNrH82nK7pTDzcJvMij7bn/Hcw9+2M=;
        b=ApwTpu1eK1q9xpckdorMtTlPT08TqFyg9p+IhSzHZmaa42IOh2tNifz2vsuU72/8ej
         7IfurrGgEB95iEhJ6Jqw+dex1Uh/n0eHfO+GYuoqQcioHDv6zTPBd5YLpnyK6fDEu9Y9
         jop1COrCRNRYgXS/twx8fkdrCtAhFaHA97qNaTMph67L0iSZ3ouAkauk1rMkxjC5WYgE
         NxhNMd4nUqAOHOCcTKFGPJVO22mqUGeQwCFIsjkdGKiFXF6nxChQfjic6/qx14FEPB9v
         LbMcyFvjkCLeoMrSdDLLdcbm1MPTp8xpy39Sg6BSFFoDQKOnCJClHJVME9xpFYdlkjdz
         gfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782149761; x=1782754561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YI55XeaK4Jf+yZNrH82nK7pTDzcJvMij7bn/Hcw9+2M=;
        b=fRyi6TMRZDX9NsT/DZYT27gVKpPAIa5jZBoceRsfR4BK4FvgcCNIcDt2x3Vk3mCFFT
         TgLWOuff9G/QpN2mhBEXWzFi55eQQZjPsox65ldVWZusk44Caj3quRpXPl/xhOYXhEmn
         FNc/xHAWUjl7wB7YC8dA66ERxCX3iv+4xpzqsoopLqhGcmbXgziWGiwoH4BoncPrJ3FZ
         gk4qhauN6JEeZGnUKUtQpUF1I1F3a9glI5UXm+wsAOlziUR2eTclWtQ2qA/HWWWqIrUm
         fazcB33EatXoKSGuUQuGeRxUBVBoYHl8nnAHHSvI31YfEarYexU5jnWbnDojmE5qlZsE
         XoOg==
X-Gm-Message-State: AOJu0Yx6yfWj+6fP3dUA2r/NRQS1I4ydHYexYKKaV9nupCiYxCUgU4yu
	8LbFqvXUHCn+NS6Y8uxMfwedsg00IqvOIYxLgvxOMHYoU3YfLZBXbC0IfvhSdg==
X-Gm-Gg: AfdE7cklAT7LJMiY9wfjFy0QvRxg35SyNt7kUP43ZUDLSlkQWIbGIXPoDgsF+A/Nyt1
	njUiHKnYvKE+k7ulIN+OGhSQnf8ImiWCpSZHznpi9qeR5d9pL4PzVWoUEZ5IVMqPAVYhO2tY+wY
	EqZ1KwBibTNcxGaTfyDyxAUCs0dgQxifKs80dNj0JMBHPV55v8nnn5GE5tTftbZW38MnpSQmXoE
	T6HfgJcimVx9gz7Gj2I/ieXUSO9JD5a6UZA4JghURuGklXTxZN8+qsHITDwuUPRubEzMjhAc8It
	qZ/l/qcXHXEYCUDxClcSYNhXsZug7g7kwKMHQmKFPx+YaVTRFnxQr1hCgM0VKtj74LoAVTtnRSD
	4XkZ5+84dVFzt7kwCamMp75uOEDq7DkS7yKiNvsrfqMxOESGs4PdS/wVSCEGGSft+lp5b7K1O9r
	1JLldgOZG6EWiz+k5b4J1mPNys3ose3mVsf4uDN/VyE3PhOw==
X-Received: by 2002:a05:620a:4049:b0:90d:6234:caa2 with SMTP id af79cd13be357-920d3d4d787mr2200204085a.40.1782149761440;
        Mon, 22 Jun 2026 10:36:01 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39188csm34813485a.6.2026.06.22.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 10:36:00 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/6 v3] libsepol: Add overflow checks to strs_* family of functions
Date: Mon, 22 Jun 2026 13:35:40 -0400
Message-ID: <20260622173541.174998-5-jwcart2@gmail.com>
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

The strs_* family of functions provide convient functions for
handling an array of strings which is used in kernel_to_conf and
kernel_to_cil. It uses the common idiom of "*= 2" to grow the
array without any checks for overflow. There is also the function
strs_add_at_index() which can cause multiple iterations of the
"*= 2" idiom.

Use the __builtin_mul_overflow() function that will do the
multiplication while checking for overflow.

In addition, the function strs_len_items() adds up the lengths
of all the strings in the array which can overflow.

Use the __builtin_add_overflow() function that will do the addition
while checking for overflow.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v3: Previously in patch 0004
    Use __builtin_mul_overflow() family of functions
    Just check for overflow and don't set a maximum number of strings
    All check for addition overflow using __builtin_add_overflow()

 libsepol/src/kernel_to_common.c | 20 ++++++++++++++++----
 libsepol/src/kernel_to_conf.c   | 10 +++++++++-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index adb7b661..bcd13c9a 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -117,7 +117,10 @@ int strs_add(struct strs *strs, char *s)
 	if (strs->num + 1 > strs->size) {
 		char **new;
 		size_t i = strs->size;
-		strs->size *= 2;
+		if (__builtin_mul_overflow(strs->size, 2, &strs->size)) {
+			ERR(NULL, "Overflow");
+			return -1;
+		}
 		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
 			ERR(NULL, "Out of memory");
@@ -173,7 +176,11 @@ int strs_add_at_index(struct strs *strs, char *s, size_t index)
 		char **new;
 		size_t i = strs->size;
 		while (index >= strs->size) {
-			strs->size *= 2;
+			if (__builtin_mul_overflow(strs->size, 2,
+						   &strs->size)) {
+				ERR(NULL, "Overflow");
+				return -1;
+			}
 		}
 		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
@@ -229,7 +236,9 @@ size_t strs_len_items(const struct strs *strs)
 	for (i = 0; i < strs->num; i++) {
 		if (!strs->list[i])
 			continue;
-		len += strlen(strs->list[i]);
+		if (__builtin_add_overflow(len, strlen(strs->list[i]), &len)) {
+			return SIZE_MAX;
+		}
 	}
 
 	return len;
@@ -248,7 +257,10 @@ char *strs_to_str(const struct strs *strs)
 	}
 
 	/* strs->num added because either ' ' or '\0' follows each item */
-	len = strs_len_items(strs) + strs->num;
+	if (__builtin_add_overflow(strs_len_items(strs), strs->num, &len)) {
+		ERR(NULL, "Overflow");
+		goto exit;
+	}
 	str = malloc(len);
 	if (!str) {
 		ERR(NULL, "Out of memory");
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 3e6bcb33..9bfe5b38 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1663,7 +1663,15 @@ static char *attr_strs_to_str(struct strs *strs)
 	}
 
 	/* 2*strs->num - 1 because ", " follows all but last attr (followed by '\0') */
-	len = strs_len_items(strs) + 2 * strs->num - 1;
+	if (__builtin_mul_overflow(strs->num, 2, &len)) {
+		ERR(NULL, "Overflow");
+		goto exit;
+	}
+	len -= 1;
+	if (__builtin_add_overflow(len, strs_len_items(strs), &len)) {
+		ERR(NULL, "Overflow");
+		goto exit;
+	}
 	str = malloc(len);
 	if (!str) {
 		ERR(NULL, "Out of memory");
-- 
2.54.0

