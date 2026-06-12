Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD84403AEF
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284157; cv=none; b=lB0mMZutysLRlEkSvE3JgWdRc+bNE/tOnEiL1eTAvlCHQ1hVYdgxoXaKBsmhXYZLLnc0bgDGZaWGUW+iNSlgrMxIa/zLEMGWZM4ZKkPR2IZ9MvbP5ZvGIThqElfBQbPPik7E7/qb0JDFKIXRCSRcjT5ksRmA34oS5nRHEHU67Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284157; c=relaxed/simple;
	bh=ooOW22rFDcdT0lZ9CW26uSde+GjLWJ7ewBm/JRRg3yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPTWPWJM1S3iz4H224UUKabCK34ATtbwiUjXHwjGLGTJcenQBPl9BFytjiAmhJ3XNiSEOnFL2uLqEfYj7bkmYIgnZQW3s0ls/MsOWLeX+c4XW9yDncz0NqIZn+3PfFz4DMtNNTO0c8FrAopjqz3s17w6e6yq6aniJdXKPiZ0W8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAPjPDA6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAPjPDA6"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9157b949fc7so122704685a.3
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781284155; x=1781888955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgfMnwyc6KK0k/aAd3Xm7lMy8zGGQmqwQyyPTy0p9fg=;
        b=ZAPjPDA6TRWNbsHAFZKymNOq4u7IBf0iB8aG2ZEf5gQ1OCta1QqSsQh5Q6VkSvBRnF
         T6vLz4QNkuZE6WXYNoqiX9+CNcZGGP7dANTAqQI0ksUPdOCf/DJ0aiRtMAyK1X5n7byc
         jowOzl24f3jPn6YeVoH0jTDLg3Wcyn7n2oNls25t3P4Na5obfqQqzCgsEZwXqfkXZj3Q
         JUnjC+FgwrrcMHWfiaMeECW5jFKr2qKREVtqu/DGbzPbDIVUAjcm9OKdqVXvVxF2Uf8A
         DksAjW7rXdKO0RUVRXc0ceLzyoFecEHQI1x21SY7dPRJYLeVvpQLVtCs4oIe4c290s+n
         iUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284155; x=1781888955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgfMnwyc6KK0k/aAd3Xm7lMy8zGGQmqwQyyPTy0p9fg=;
        b=L2z4F4SdYqBmX9arn1pcYrezCJ0hA+QQ8c+qVIeiBQweU/5O/5zVkWX07eQ6XnPrze
         uyVd9B/G1NWr2LuyBLn85G5UNTsQFWQV/zg7KxXbEyo0vTnBlxxVKuHM8SSRVG9H/P1S
         hBsiQDGxwD8CbIeBKpcPiCYSsMfsS/oLUvIXmSRnHSOuuFZ1eC9yWUdW/49gAnwhis2P
         Rjb8CXYqc6iGxebI9SrM8B8L0iyldAsEGG8cLTCttAq84AM9J3Qn6BKqvC9NaRT3tXAV
         TgIIyjxj+3EnmuTqw+L8XxxldnyAccoZuPFDKYItwnOABi6S17zARWcrLcVtSHaCCMcd
         gWbg==
X-Gm-Message-State: AOJu0YzkrnKuC7MjBC7dcxmtcVXrR+rwsCsiuDi7W9L8+EQ8TwnaPaU2
	C6/6FvGIXLLunaOSpAXVlJZ4E/HGBlSKyc/LobXGPadrLiir4JN/3/wdfo+knA==
X-Gm-Gg: Acq92OGCl7LYZCb3GV2bUO4TKeAwOh1/FH45xI680k64HdESoT2rFg32d7adPjCJQz4
	wQIVDWIAA6W2NvGB+6TV0MkzXitAex5JlL48nT9AO4bQEgtYrCtSyZc0MPinJeVSpkpXn8FO4mw
	6YE3YSc2WtqjoxmiulH+gMO88W8NrFki+EpvmjLw6pHlSYkvA0HuI/rQZaIdvtN+7+0hnezMSKv
	pYyNRrHZhROQrupRIVwSYY3Tewbdv94TMFtXqScKIF53KV1FGdcomOjgR/TyDYj81GYLVHDLYdA
	c+tw5Nsnn1HASmbTf34goX6NtPULpEMZ6UzeoiMJHaJctxKD9nfkYJFi3BS1b53LSNy1a/lo3im
	eY/KXbAk4r/rlyt4pW9EBC2JGqr7azyh4ywPCsJgBRr7OFIQTQWSPzWVVlbx16k+G8JUUwHEbbz
	fphoE244fdYL1Q+vFrczkBpl0g/OT2b1pzlhD/uugxmF7mdf7ezBs4HJumrQz+lFrSSyMVtl0cP
	KTJgLcM7BtpxIylTU8K1IHQUznUDhLrqX4nOw==
X-Received: by 2002:a05:620a:394b:b0:915:7f9f:8d94 with SMTP id af79cd13be357-9161bcd747emr520981985a.47.1781284155242;
        Fri, 12 Jun 2026 10:09:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed8aa6sm265590085a.2.2026.06.12.10.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:09:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Seth Moore <sethmo@google.com>,
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [RFC PATCH 1/3] libselinux: avc: use pthread mutexes by default when no lock callbacks set
Date: Fri, 12 Jun 2026 13:08:54 -0400
Message-ID: <20260612170856.17904-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612170856.17904-1-stephen.smalley.work@gmail.com>
References: <20260612170856.17904-1-stephen.smalley.work@gmail.com>
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
 libselinux/src/avc_internal.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index 719be934..1eb9d0be 100644
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
+	m = malloc(sizeof(*m));
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
+		free(lock);
+	}
 }
 
 /* statistics helper routines */
-- 
2.54.0

