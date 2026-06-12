Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49F39023D
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291528; cv=none; b=Oik/Zxub4dfpKWswK7hlelkhqQYWHFLjjpPEt4tGa72Ktpad5jVfe+3/nPUkCCFZz1D9agtwnSRkuZllcaKwVgSUa8A14LTZi54Qh8K2dI1wG1z8zDlsE4u307/wTQioJqf8nh8CaD5AINY2m4G+LNQPqqajkr4ZCOeyNje6cFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291528; c=relaxed/simple;
	bh=fPVy2qfKqLnZyAHrYouo2caNPQN9kw1QmM5lnH4K8xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se5A2iEcoENPWddJrTU+XIwzByVfnjZJ9uHpMOBJbtyveVg85sSdqvAA9bM/feKKyPLcNvB6ZjUPMwqHcMhjPGrvSatvPaREIkgSP90GEGyD3NVguDTbmdeOb8wZvZDW+k8wIVblJ0BCqssFhPs4txkNz2LLVztW0c4HDQ3qsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5L1a58L; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5L1a58L"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-915c36e32abso117882685a.2
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291526; x=1781896326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTnadRSr9MaI3QVNx5n5xhXVhNRFLlGzOllbkrhetMw=;
        b=E5L1a58L/BoBNk/+X114uS3RGB1Bdipi4Ahf8MS2jDyjgvirSUiC6t56eI0RNe3LVU
         lw8+IJwcycvuC6O3YWAGpduxIXqmC/TXhUNkyyQxX8wbVZzUXU9l5ZSugqgaM1xcbyCR
         4tWSqKIib4M1nBC19Y+rIJmXWmdoIK21kO0/QIuowMsCjkBCc93VRyqf7n8SvyFy53ux
         rcsaS4Tc5GZgvMD7f3osLlkihEsQwVhLJlPlVTm+uZITvtMt1G9jGHUe9SsoywVXsVTX
         +G3vzoyutFxnmNizSOVDpaCRLplQ4XtwwNFFg0YSXQqwNKDK2oCYE+WXKxNx7cglSziP
         WuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291526; x=1781896326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTnadRSr9MaI3QVNx5n5xhXVhNRFLlGzOllbkrhetMw=;
        b=Cjml9yVqRuxdofepBFBcOMb2fJtyCBy6/NNbI/amgZoJ7K1cT15CBK+O5WafKkQCfg
         R+wKDHlb06W2Wmjq2Y+nM1UPF796cTColNMU5R6mW3aaqzk2auRlWhYRk79kUFOwQLSm
         O3i0xxgrHb0cQxQoXlS4LpuQm0HYYDUeaR2cVD6LtkiwQgeG0ESDB4Oi8SZ+SFMMMjmL
         CBIWDiYVguJ8qWV6R8Dgpx1Vo+Altcbvk+PSvkpJTqJfVKjyJSLWkYS5bzus1LDHandY
         ROiW1gA0PG5zW267Fb5uK6rIi+B9Wdtqhh7yz0mo2Vu1QWeWwyUTjbY0Z2JNjkAUcmpC
         ZIjQ==
X-Gm-Message-State: AOJu0Yzy3+mGEwuIpixavqc/EzZU++4KO0CYqK3snJA0OOp1H0OYemOx
	otPQ6AuyCLmn5TOr6HLIk8Kqbrchky5e3X8UtVxgEZqXNO5JcqH2mbtSlKLG1w==
X-Gm-Gg: Acq92OFgOCZx2uKj71vQH0N9OftemcxM988fywJkoJ8B2N320YaUC4iwgzpRuP5CFnE
	3ceq5y6wW1nINHMjyy9wWbczBBSdTTwNHQXPBLwVBLyEIEDS2X4S44y1ItR/LfTt8GxiqRJVAXn
	e5U1YPU+Y1XGCCtigzzDrhA1jlzq4SvQPY7125XJYuZnKO8B9yo514o7/o37jA7aBa2U2pbF8gm
	rjguw8nBFdvrfhO2M/XghZxmLnCPInu8TJ35YVWGrv+/X/TnH03yLr39Gvo8alm2zGqxz3sTXj1
	UkxXUBB+Q/xE1FeA8CIe+G1iKwjAsCikfZwH29TYZinHhjCVuv6jSQD6uttyQcUjOD2xT1kU7Ct
	l3dUeMkHirNWy8lww1vMZQiWoPpvHasnb8oCBeUeN3CAY+6fR7pFCOG+xgLAysBk5nTUb07SIYO
	d4GE1blm9WWa/nZna2h2XQmwQ+XO2x+j4vSA3KZ31y2XAEkfGylLbseuWxvjkRppzYLPlfHf2rY
	r9IHED2NWlmtfQVwEBb4FMtiUGFfkJWFcKAQA==
X-Received: by 2002:a05:620a:4095:b0:915:8865:dc01 with SMTP id af79cd13be357-9161bd1c865mr618592585a.46.1781291526275;
        Fri, 12 Jun 2026 12:12:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a04b472sm295086885a.37.2026.06.12.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:12:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Seth Moore <sethmo@google.com>,
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [RFC PATCH v2 1/3] libselinux: avc: use pthread mutexes by default when no lock callbacks set
Date: Fri, 12 Jun 2026 15:11:44 -0400
Message-ID: <20260612191146.20122-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612191146.20122-1-stephen.smalley.work@gmail.com>
References: <20260612191146.20122-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AVC has a set of locking calls but defaults to no locking, and
only the deprecated avc_init() allowed applications to set their own
locking callbacks. Since selinux_check_access() is now commonly used
by applications implementing userspace SELinux permission checks and
it uses avc_open() internally, such calls are currently not
thread-safe.  Provide fallbacks to using pthread mutexes by
default. Single-threaded programs that do not link -lpthread will be
unaffected due to the existing __pthread_mutex() helpers. Applications
that explicitly specify locking callbacks via the deprecated
avc_init() will also be unaffected.

This is the first step toward a thread-safe selinux_check_access();
the class-string cache and status-page transition handling are
addressed in follow-up changes.

Fixes: #287 #335 #336
Link: https://lore.kernel.org/selinux/CAJsHiNx1E7x1jaBkS0i4L1nBWXp8YXLHRWcCaDaH4LOn=zm+Zw@mail.gmail.com/
Link: https://lore.kernel.org/selinux/20220120073329.15234-1-purushottamchoudhary29@gmail.com/
Reported-by: Seth Moore <sethmo@google.com>
Reported-by: Purushottam Choudhary <purushottamchoudhary29@gmail.com>

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 uses avc_malloc/avc_free when allocating the lock rather
than direct malloc/free; this only makes a difference if the
caller set their own avc malloc/free callbacks.

 libselinux/src/avc_internal.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index 719be934..3c21ffef 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -14,6 +14,7 @@
 #include <string.h>
 #include <selinux/avc.h>
 #include "callbacks.h"
+#include "selinux_internal.h"
 
 /* callback pointers */
 extern void *(*avc_func_malloc)(size_t);
@@ -115,25 +116,41 @@ static inline void avc_stop_thread(void *thread)
 
 static inline void *avc_alloc_lock(void)
 {
-	return avc_func_alloc_lock ? avc_func_alloc_lock() : NULL;
+	pthread_mutex_t *m;
+
+	if (avc_func_alloc_lock)
+		return avc_func_alloc_lock();
+
+	m = avc_malloc(sizeof(*m));
+	if (m)
+		__pthread_mutex_init(m, NULL);
+	return m;
 }
 
 static inline void avc_get_lock(void *lock)
 {
 	if (avc_func_get_lock)
 		avc_func_get_lock(lock);
+	else if (lock)
+		__pthread_mutex_lock((pthread_mutex_t *)lock);
 }
 
 static inline void avc_release_lock(void *lock)
 {
 	if (avc_func_release_lock)
 		avc_func_release_lock(lock);
+	else if (lock)
+		__pthread_mutex_unlock((pthread_mutex_t *)lock);
 }
 
 static inline void avc_free_lock(void *lock)
 {
 	if (avc_func_free_lock)
 		avc_func_free_lock(lock);
+	else if (lock) {
+		__pthread_mutex_destroy((pthread_mutex_t *)lock);
+		avc_free(lock);
+	}
 }
 
 /* statistics helper routines */
-- 
2.54.0

