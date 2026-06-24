Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66833C81B9
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311780; cv=none; b=CqfXZ4QFE/4YpP8mu39L1GTR7MwxzqDRfhanvgADIYnyQxAMcaYbgjlhyejVdBe0hF+zhJKZA0cuQPpcFTI1WoUlgXoT86GQPbCeNCbRXY21g1Jv+NblYP+gVF/TA7gkUASXH02j8mO8ylZKaphMTKv48f8TlxvSQkVIRe9C5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311780; c=relaxed/simple;
	bh=ZEZO+w8s4VeEOOMN9YY8W79ybCq0B9IEYqkkNGPZAVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdE12l+z1d+cIHmYbFbIEQZSoFDaq4bd8v5OfP0nqIcJZLMguqYiq6JoZBso3+ZhyF50nBQvH6j6LTJsXE4R0f1efbNKbSbAqe/7hBygcVHAQWuiOPSh1J+vcVZRrfw3zM/9YBqNntaqz0E1+f6sKvgRQqxhLIKr+GKJAkVge48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqLyOESD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqLyOESD"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177945a279so8227621cf.0
        for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311775; x=1782916575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwASkffOzwCB2oG1gtFaH+uUcSK07rptBzsgujSVCHw=;
        b=RqLyOESDVuuRq6rva55HTyRUfG4l5GU31JE6g7HMEBlz6bxbs/UPY0l2OeNHLyovpP
         QSLTn8biF6QJFMs0pLPO1UrVbFMDSSJw0Wql3aINWa7Mz9spYWGDhW3IKL/wZEaQGrT5
         P0UX191626MpB1oTYwKxZdqIpCbjJTrBgqBK+kYodEo6V5dsXq/8BxlSn9D2qViB+ubT
         Szm1SyUhjzr/Kdb4ZnLTQFCVvFKObmfnXekBGRDAwip+kTioNdVDGFkw/s8Lsvci9kyg
         fABrvzZKQaSRqABlWOK0qo4IPVB4vWwLavEU+TPp07lqIsZzn1Cc2GSg04kTm+Mczxdv
         Ozfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311775; x=1782916575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gwASkffOzwCB2oG1gtFaH+uUcSK07rptBzsgujSVCHw=;
        b=JnhkRC80DdCLzoaw2OPfpDD7HERy+Cfu8rL2s+vvZSwaeIcsCp0gauYShHXj+EGd1+
         TuJYbhu08tpNstYZplh0SUGX/nCMR/ALEiJi2OkuXZ/nrxgHeK4mshXpIzSnlAZPkbo7
         e/8RZD7uROcOwRyp5sbqDq+vLiQafc3dqzo6xD9oH6CN1qfHKqsOMN/b0nLd3LJMM4d8
         TZ14Hsdyjc1Cqj+heJEIe2fB9Ixx/XqncLSEIK0u1QFz76ryEBvvvBPsRVj97ga6gbgM
         PZWtouHSNs9kTaMEosXMt3P/NTwUvXAuy5iTQMyjxz60vlV6WH7WJnXUg6h40LyQ5+4T
         oN+g==
X-Gm-Message-State: AOJu0Yx8seXT6JCc9oSLaZIcY1hRAkCXTnnrWq9+JOWSbMNiPfi0VttK
	nufUQ/QlPppOCcUHSbfRMUqatqxsNMM3XBb3OU0VhlQMxa3GZPJ2uvmnzzTMXg==
X-Gm-Gg: AfdE7cmtzMo9mTOt20GrQUb/rYXWOJJtSjXO/AN7+DvTsgAb975FC5TKXJKje0Ki/4c
	Xm6rQMnq3HMbiHIeTpeU/MFGpkZdpK7KU95boPyIWPwEaMxE/8TyWrzJ6ztIk+G78xqZprihLD/
	FBxEV8Nkl+Tzra0eHsnJ83zLcOdh0XePwkYVCFbQQgDdtuOIvOd6LAklY7q5814D5hj+r9xT/Pn
	VEJVazdwSFddy0FF96eCD2EJoUpVOgAHq51bwx+BdiZ/qiLRPKFeWgp35oW5stDtiJR2AD2dFKQ
	QK3udIvBDOQ5pWvUwoOoWIxOW2QmKC+QRamCZ2RV+Ryy54luifrUm9REI6wgQPtcBuUICNz7cHS
	2TBpiXFdZwyQD3AF3aoVgxwHCA00OwaJS1flltk0PyiPN8FlOV7U2bmHWHjMG2/FzhUTaID4b4F
	HbfAc1hTgGNvRD2O7tL0WkiT5Y1k4JVR4Qknw=
X-Received: by 2002:a05:622a:2304:b0:517:8541:8b70 with SMTP id d75a77b69052e-51a61f19e93mr52798501cf.45.1782311775491;
        Wed, 24 Jun 2026 07:36:15 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51afc29csm48721611cf.27.2026.06.24.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:36:15 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/6 v6] libsepol: Add overflow checks to strs_* family of functions
Date: Wed, 24 Jun 2026 10:35:59 -0400
Message-ID: <20260624143600.11282-5-jwcart2@gmail.com>
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
v6: Now actually multiplying new_size by 2, so the loop will end
    Added a check that len > 0 before subtracting 1
    Checked the patch with Google Gemini

 libsepol/src/kernel_to_common.c | 29 ++++++++++++++++++++++-------
 libsepol/src/kernel_to_conf.c   | 12 +++++++++++-
 2 files changed, 33 insertions(+), 8 deletions(-)

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
index 3e6bcb33..89425d36 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1663,7 +1663,17 @@ static char *attr_strs_to_str(struct strs *strs)
 	}
 
 	/* 2*strs->num - 1 because ", " follows all but last attr (followed by '\0') */
-	len = strs_len_items(strs) + 2 * strs->num - 1;
+	if (__builtin_mul_overflow(strs->num, 2, &len)) {
+		ERR(NULL, "Overflow");
+		goto exit;
+	}
+	if (len > 0) {
+		len -= 1;
+	}
+	if (__builtin_add_overflow(len, strs_len_items(strs), &len)) {
+		ERR(NULL, "Overflow");
+		goto exit;
+	}
 	str = malloc(len);
 	if (!str) {
 		ERR(NULL, "Out of memory");
-- 
2.54.0

