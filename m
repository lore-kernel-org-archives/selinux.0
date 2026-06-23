Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8338E10C
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237011; cv=none; b=l6XEjqkAFKzkn1EOmMnxXTuSh1YNpmwrnlj7ixJuTPS9Kbi5XsQ0/4mjumthcBpaUht9qMkC0KK4lHy77oi9IALVIEwis1fL1w/4WM6O8aTYhrJWrYAGb/YDdAjVq7xW6YXDGla5lCYuC+h9w8Gvn7jcYC9FFKZSQUKbhDW0w/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237011; c=relaxed/simple;
	bh=UkPBuMCpOp0hyn2km4XIV75Ql9M80rY6i1eHzyeTzlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fu0zt1iHkjQzChcDC7fnTTJlFXk40E3cZLx1h+I1ihWXgy/44evdADSHPQ30wbJRgBvWzoPo8p7igCnaM2tWwTXHp3kGzH6E/zo9H97LvM6K1L7++BcK7mmPO4w23IVnDZLDKtP9y9Q4DSwVE/9B7CoCUFRPA1IG5kRi8/nRxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC9Hdgmw; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC9Hdgmw"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51a1fe8f578so433721cf.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237008; x=1782841808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=novBdpHynbWdF2/NRNGUZSc3dyt4owWtMDKL6IR0GQQ=;
        b=cC9HdgmwifRxYnnoimbl9wMYkp3wuk/i614fYIxeUclSSAGq8r4hUtCUMBMeylgobG
         /Ev0Gd7SBkMz2Z112OsOp9RWQgFN7/yGIANIApSDNAFuuKiwRloKNn9uUFjs95c3cIAz
         TLvdFiQx9zhEMhsLKKP8RIFVo1U9VzAspRUNX2GCHgnIhiQglyyL3ptJHGg2TxU0VXFl
         EDXYVGMwYHBt1/3zfuOi/HfSHjye1XI05DN6kgeOa0YXQ0W45ya2vkWOmUrue9QpPI8j
         J2D2Gy25QdbcWWyC2rxoNKAT4CJefc2ZhFZm4ZN21J0gfBqgDPQuusRX0s86GpghHP5n
         N3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237008; x=1782841808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=novBdpHynbWdF2/NRNGUZSc3dyt4owWtMDKL6IR0GQQ=;
        b=qKwNJV7DadY7+gTEgoOykumHNc2TXJSFnT2GWPqpq13D+1esSavQ8G9LV90/xGMZQb
         /cuRfJ0xd+CDQObNL4uMKB1OlrV6N8WtXytVVk21aqNYaOn/ZYzBLDrJf/qZ3yDh4lQ/
         9+714tLBkbUUXyCvm13BERJjS8MADvkPGWvvjbdG2n1bblUFnaFZDtc9eGM8alCrvFIJ
         pC8Wc/r7q5m3M37v0085zpVgPzi4nAIJg7K4uHIyHGo+LfOdOBf2VgBqdvGH4CW/mbPK
         jJDt9uASPnEbbyj+iiy9oM7yVh3lKz0KLH+lAxNuJqMjxeE7GSMg+zbWhUtEpZ7TzCix
         A81w==
X-Gm-Message-State: AOJu0YwDiwnF2OOSVRvaIdqb0iRBlc8gjBeYMwYRXWRU/E/mmHO8lyJf
	R0SeKD192mt5uOQBFBJQHTVLK8btPoSnhBqzMl1Sfxd8ptw/mlRuNkiceHhvNw==
X-Gm-Gg: AfdE7cm90VVJIX2/eOKz3X7Zvyerl6A7sPQoj80c2v5iptyz24csZeiJCZ+rGzeaAjv
	psXwYhs6A4J5oqD34jrvPnQQ3s3+JOj0LPezI2K1Pi2c47zwzh+ANnitR+Z9c0JJ0EhOtHOIjMS
	3vd5lKNGVDgPhGk1ueMn3cXnPekSFZTLjvc7hIYzd5zx79J/iVUhPn2OaAm/10kw+weaSQwpCd5
	puqLqItJIpfQarodYV8ML4/4ipsJF4/Sf5FvQQ1vhY+QeGTw4yY11FeiPJ41ZUHewP+0eBinvVb
	zNpmlbJcdjEyYu6zkaLQMwi9sf7yGs5dQSS8mHkpFOt5WpUa5nd4nQ8XRVc3rL3urTmlCvRsJ+Z
	aRVqm5Tqc5iyHS5F9hp91da49XPVPg3joqwSppQyt1L4JBBXiS0jg8GVc4WJqVMiMmqwl96jGEK
	TK9hUOZ2oWorUu42OCVJ0HivhHAyinyaeeMZQ=
X-Received: by 2002:a05:622a:150:b0:516:d955:ea6 with SMTP id d75a77b69052e-51a54701387mr55131691cf.14.1782237007993;
        Tue, 23 Jun 2026 10:50:07 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df826927cesm130109646d6.41.2026.06.23.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:07 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/6 v5] libsepol: Add overflow checks to strs_* family of functions
Date: Tue, 23 Jun 2026 13:49:50 -0400
Message-ID: <20260623174951.22074-5-jwcart2@gmail.com>
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

The strs_* family of functions provide convenient functions for
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
v5: Use new_size in the while loop conditional for strs_add_at_index()

 libsepol/src/kernel_to_common.c | 29 ++++++++++++++++++++++-------
 libsepol/src/kernel_to_conf.c   | 10 +++++++++-
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index adb7b661..17376f8d 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -117,13 +117,18 @@ int strs_add(struct strs *strs, char *s)
 	if (strs->num + 1 > strs->size) {
 		char **new;
 		size_t i = strs->size;
-		strs->size *= 2;
-		new = reallocarray(strs->list, strs->size, sizeof(char *));
+		size_t new_size;
+		if (__builtin_mul_overflow(strs->size, 2, &new_size)) {
+			ERR(NULL, "Overflow");
+			return -1;
+		}
+		new = reallocarray(strs->list, new_size, sizeof(char *));
 		if (!new) {
 			ERR(NULL, "Out of memory");
 			return -1;
 		}
 		strs->list = new;
+		strs->size = new_size;
 		memset(&strs->list[i], 0, sizeof(char *) * (strs->size - i));
 	}
 
@@ -172,15 +177,20 @@ int strs_add_at_index(struct strs *strs, char *s, size_t index)
 	if (index >= strs->size) {
 		char **new;
 		size_t i = strs->size;
-		while (index >= strs->size) {
-			strs->size *= 2;
+		size_t new_size = strs->size;
+		while (index >= new_size) {
+			if (__builtin_mul_overflow(strs->size, 2, &new_size)) {
+				ERR(NULL, "Overflow");
+				return -1;
+			}
 		}
-		new = reallocarray(strs->list, strs->size, sizeof(char *));
+		new = reallocarray(strs->list, new_size, sizeof(char *));
 		if (!new) {
 			ERR(NULL, "Out of memory");
 			return -1;
 		}
 		strs->list = new;
+		strs->size = new_size;
 		memset(&strs->list[i], 0, sizeof(char *) * (strs->size - i));
 	}
 
@@ -229,7 +239,9 @@ size_t strs_len_items(const struct strs *strs)
 	for (i = 0; i < strs->num; i++) {
 		if (!strs->list[i])
 			continue;
-		len += strlen(strs->list[i]);
+		if (__builtin_add_overflow(len, strlen(strs->list[i]), &len)) {
+			return SIZE_MAX;
+		}
 	}
 
 	return len;
@@ -248,7 +260,10 @@ char *strs_to_str(const struct strs *strs)
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

