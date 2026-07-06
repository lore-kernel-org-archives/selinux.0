Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA139EF1F
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348744; cv=none; b=D/sjNd8vqzi9aYXj6qSggFViO+6nwlGkhMGnWkLcJVJNWaEzC6T6rORGiXGXXm7NQuOABMll3+Mbx+brCEMQRnCNVgBV9kSLZVIes+iNJrK+P2xkUFT9X8jZLD00uWk97CXYnwRZuAmJQpT/nHatvHArcBi8TJcko8GhM3MDefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348744; c=relaxed/simple;
	bh=wrCvqdC66OW3tJLe9zdxulfyeEQo9MW0u/RlzarUiME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPS81p0wXvAeCX2QeCSAj0nxP+cQEJMzALTHjV23gtEjXxgINs71+N8cnbtwfG081/X5e2zLErKw5b9RHZfjxDsPj80tbkLWOBQYLSS7OZAfgBvPjdvKzmnUTWziKnc7ET3ObYA1E154OMtYJ+PkzM4v7ke7XgkmivL4+/hKgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQbgx9UP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQbgx9UP"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-517dc520840so23473021cf.3
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348742; x=1783953542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQPovHl8lj5qsLfwyBIdAPxVpRytpb083ahUsW/+C3s=;
        b=KQbgx9UPvMA00gpF/kqqAoNCGMpsmOdYYs+4dlfJj/p0GqIqhgTQWEJrSJ5apG42bY
         O6y8po8MoaFjrMWpHiLIY+CZlLGIlntAxQ+HIWnGMa4L80Y1QrydJz1LGqwhZmBAWXpF
         uhohChdSO75Yy7i/dewhOacM7osec/umqkE+cH6yGSvhFzzHCSRbHnvm2A11DG9ynHEq
         bTWPDXkqTJg68q8/1g7FN/OWPS2pm0faTipgtLtPVerdt83AL6fVLzUu8M+tZgIqfoiT
         roYL8C1nQcY28iL4QSEqtcYkTuO6MWrA6GagsOclmVQ/xkcgE+tZG5KQXs4EhJuc0vQ3
         aX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348742; x=1783953542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQPovHl8lj5qsLfwyBIdAPxVpRytpb083ahUsW/+C3s=;
        b=UQWgQxMb0obQLIlIEDNFoPaxuu+u2SDSQXadPKlWYHdntzbknXkLkwTPqPeuiJX/y4
         Tiy1wn5vvesIgqYvITqLjZdmMGqLU/LT1nlZcUoen4gnR+pm+cgc1B4tCd4B9SQLSGKq
         neOn7bBGzaadRdhXtCe37Q/JoeDR6/LK4pS3W6Xw5aMubFLnZc6XL2IcSfm86uoLLMkc
         KSehcfjJDnuwMjegOqEn+vdsqBfBh2yxjk1aGfbIiYaOjpwMJYtliieRtYXCsF6Q+0EY
         Lp9wBXSkyIVMLoVc/47v066SkYhESCGG/FAaoKDrdB6Utq1hAw79JXfK/7RK4CTddTG5
         8fPg==
X-Gm-Message-State: AOJu0YxXMS9tJbst2m1gJr91elSkIVTkowIUtxppr7MLkjYC1EQKai5V
	TheLbkP5jHWEGPrt+SVQ2jDHf78HUqqsrXzRWhnqbt9Vax1mxE/pjK6SMvQ3eQ==
X-Gm-Gg: AfdE7cmv213P6ZI1oqNB5JQ8zVNADZFjjfpAwPUluTSesZVSwOkjUbBc6K5UNWWsf3C
	BrCQpjC0zsYbAbp8fp74dY2uRQ461eXozLKuJG8DeSl+qc8sUENsmt/LjOosJXaFAcrVcMjemPM
	tYTYWq5CphmahgMcOJ2q+r/7Bjb3M0yVUyg2+VaRASu9ndN/IQ+9xWcEH0xjDFPmtnyIckx82aD
	0+dVo0XRZtmJc9+QSlQS37UNSITTL0kyGbpm13wgR2/aUe6rTy29u14sgEOiIBKy7Ncyu2h5Mel
	AygvKuCTAodRyWjWVF03luxYPlcVNGU39/o/dVp0aifN7otJtiUcR/BgLuptMCaTOGQNLfYV9xt
	bUmEUcsDN6sOGuDfsoE9/dGVZYE0EWxSee8VPTcZ/cPeClR6f0N3KJE5aADkCHFikIwKssqX9gz
	nRwAsD5SZy+Q9fZ7N/XQKzyut8Viqt7Kdhcvk=
X-Received: by 2002:a05:622a:1209:b0:51b:7af7:77de with SMTP id d75a77b69052e-51c747b9c56mr10935991cf.14.1783348741525;
        Mon, 06 Jul 2026 07:39:01 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b19a66sm89839431cf.7.2026.07.06.07.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:39:01 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/6 v7] libsepol: Add overflow checks to strs_* family of functions
Date: Mon,  6 Jul 2026 10:38:43 -0400
Message-ID: <20260706143844.25956-5-jwcart2@gmail.com>
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
v7: Remove uneccessary check for len > 0 before subtracting 1

 libsepol/src/kernel_to_common.c | 29 ++++++++++++++++++++++-------
 libsepol/src/kernel_to_conf.c   | 10 +++++++++-
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index adb7b661..c7b6d73a 100644
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
+			if (__builtin_mul_overflow(new_size, 2, &new_size)) {
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
2.55.0

