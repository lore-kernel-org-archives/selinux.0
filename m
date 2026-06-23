Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE321255A
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229794; cv=none; b=WLgLI/WXhmsAg9GSo6hNjySTr00Pe3XQOGCVomHLrkMdz/fWMNB1qWcNbMD/VAhsG4dogRM3keC4oJnJuAShKkYWAelV5hphDTh8pa3E4dVP1F8mHjYgBprI+L+nzQ8gUX8Lwcn7cMEONe15hHIsnx2ExEmi9n12Au3c3L0NQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229794; c=relaxed/simple;
	bh=6KDLoIfyoCZYZHSt93IiBao5T7bH0LgjzzJVrPOmBtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQMTJXKn1ibe+f+blqx9VYEDLI1ifx+R9MIgKKdK9RsumAVF9Pofo6P2OsoPVxSsQqd5eeMznvMFbnsqmescpBEWVuV1maJa75bOazaWJLjz8WZUzgzRSvWn8VYrgiaDnPEh+JDTmxX3Zr/zaSr1GTgehdPLad2g0syZtrDU1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcx4gmq2; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcx4gmq2"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-730ac3bec38so2653137.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229792; x=1782834592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYrBczke7L2vDAfb5VwfAIEiM4RRt1gPN7tu+x8uAFY=;
        b=Jcx4gmq2jKU8PtLO/APCpakzEfK0KPEYniuOR7ZdORYkbFzLs7nSkkdEhet0FhZ1xC
         0DizzfBkxV4smyPAZSVTMD+3XDHmWnTOer2ePKw+UED84iZNq1RAe9CiDEe5/tUVw38G
         YqMP9LTLa+hdTm1RidI5i3NtFw+tMbKlgcraFoX6FiKsGBhfptdtgL/5WaoPrDAZDEHD
         fYWFF4/Gc6oxsXqFOiHFP3317JIo/JN/ufj37Rqhk56GYddV1wx18FMGuGrAZe1XVuZy
         h2ffHCGOAh3XlEpl5iE5+7nUNNsg7aTBaGHKuFcj/UeIsanik0sf+VBXlwbRHdUUxv/I
         iLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229792; x=1782834592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYrBczke7L2vDAfb5VwfAIEiM4RRt1gPN7tu+x8uAFY=;
        b=iD8E3TwUlyZPrkrCaa9dOHaqBlxLJrvHo2kV9TDZXQMT9F4ViLFnR4vfyn4enV7yjS
         ymoWzV6lRjIPHIjuWpMexdtYX7+QijPRuuxkNS6u3DUg5oZ/lhAkJpqiyYrwjiVR3zgV
         Hjli94sNGgDmT8T7w0U4oETFtISj/oLrf9YcJZ+zR8edGA+mAQ0A2JQsz7JtFD6IfCb9
         mR6/RkhMYNXtWaayFxkdz3iXFq5li2Onj3DgspTl9mL+tG3Gqxz5O0gUXv655aAj8gwC
         /WD4z3FlgpKqLA5idKukVIBrLbMPd2pE2YsohtzNhyrC3BthjYZpyrd8HsMCRn1sFH6N
         Y5eQ==
X-Gm-Message-State: AOJu0YyyySzTAD8Ryae9oyXdNehz40aunnDWXG26FQowIp1Pg2CWVURL
	CKzQOSW7J4GZDQLXgmjKqRPsSVTX4YMLNVt9IBfwTL6h16jnC9P7466t3rCjKg==
X-Gm-Gg: AfdE7clxcAs/r52oZbbwam9bNJ/1ZTjnlcp/ztxHRdLHDhdu2TLlYlJyOAszd4FQmLb
	5cp4JzcL4I62aQ+NkqTA+lQNkdmtCvwTAqOAukarMGXLnsLTDQTcRyqZC2vtESP1KVS5Uh9VGhx
	j+HrpwkVsIiEHYDyhp0nbGzaOkIc89u7JYR4OSOWuZtueD3/cXyUnFnpaxSqsx8CQkfxjnOYXp9
	GtgIGmgWr2Z2OrqVVGUIifNn9KpgCybAxgtoKpti34naxo6jQKWJbVYYon7ug0IV0D2Tcei0sLN
	pEnjKqaYhqPLGqri3aMOK5JwbVi7X2IU314Z9fPDG0P5eKxAAYi4eIR4mdYQfFA7A441/VsB8Iu
	+VWIKgsn7GtWNm5t0/loGhJcEj4E8fMElgIqJFUL8j4EaforyVlIJmEhI+9yQi+Fyu7qV59S9MJ
	WpdG5mvMzyijv91ag33ZwGI/jb5k4WmbgJYYU=
X-Received: by 2002:a05:6102:580e:b0:6a2:cf9a:9221 with SMTP id ada2fe7eead31-72ff6a8ddb9mr1719188137.20.1782229791881;
        Tue, 23 Jun 2026 08:49:51 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0164fasm128197266d6.8.2026.06.23.08.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:49:51 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/6 v4] libsepol: Add overflow checks to strs_* family of functions
Date: Tue, 23 Jun 2026 11:49:36 -0400
Message-ID: <20260623154937.16913-5-jwcart2@gmail.com>
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
v4: Fix spelling in commit message
    Add temporary variables for the new size for strs_add() and
      strs_add_at_index()

 libsepol/src/kernel_to_common.c | 27 +++++++++++++++++++++------
 libsepol/src/kernel_to_conf.c   | 10 +++++++++-
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index adb7b661..9fc29cb9 100644
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
+		size_t new_size;
 		while (index >= strs->size) {
-			strs->size *= 2;
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

