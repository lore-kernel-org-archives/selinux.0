Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353C420872
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348340; cv=none; b=B19gnduTO4AxDwr5H73GpufWoGTsFezKPl/NWFxXUyHbIklUEsnWSDykl1JOGCGrlkR2b5Wpu+naM125Z2uoBz2rjHRblVDVRvdyDnas+AWSBXawWgqjrFSIbRcTsMqirEvTGwTyTAIrppEopwWjf46Yy8i/a9Cx+6y6+3nsp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348340; c=relaxed/simple;
	bh=uy9hVW9Lrg/9jnsaUZ8yWCjmpiS1HdGeOhdszsTn/DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCHPtyNTQr8n+CvB/tXZ2H1ZwmpScxgN/BI90tGc0TG0Gm2U9NPbepTmtwUFckEAslm0NqAfuw/dYgsWP0UNbWvI3ov/ajRZVojS7J8j8VLuldCSX8t86Ab+fO3ogG8s/QQpMxzlhQzga9A/4C31tTSySMgE7mVANI6dECFixxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKKFOSad; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKKFOSad"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51bfe810293so15071431cf.1
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348338; x=1783953138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jzj+H5Fuk7VCFNW+/WX7pwtcAr49L0zFb5iwGi7KWK0=;
        b=hKKFOSadrHTR8rvwXmRah9cwqctSa4WXKNJJldssUEs3HbZmthlPqanE56hcp6uGqI
         VHFn+7auNdsbycF1LbjAfFxCwAsWNI+eWpOXYeVkxDXIhHUAMXA7SKgPSMT8ORqxJxwI
         ij1AkgDw1vFpNgl/y9ahc1pk7VDnxQgWainb9mK/pV+TzynJFS2m+gW4XR1GNqggPO1r
         g67ENnBSXk+XPgI4gHe0IcuHiC0XttzL3kzOd2dBVquPIMx6He9QWUQ4ID6vrpe61ZM9
         01Y3HLJkqGrvgglAiWNlabXj34KNkBHUQbTkO+FKP04oNIJp46ldYwqxzztSYzHoC0ZE
         LGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348338; x=1783953138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jzj+H5Fuk7VCFNW+/WX7pwtcAr49L0zFb5iwGi7KWK0=;
        b=cV5kxIvD7+S20veermWEC822f95DPofuptClfkXPAqYUGUE66o8vIT7d1pt+5hUiQF
         UfjSRGpIjujPZHYMix3Y6oZKR8Cyl1pbiI/igCsIaP3aZ/UGEeG6YANNFl80L69XRAw2
         BvFdqy6nUNwN6tsyf+6N86OD8oxkCtIDNk0XP6YqfgHzpSCD2h22L63UqCYDsmdJ+EVM
         YRCm2OEEzYb3MNzSKzIm6bmie2BdjYG2K+eOEDZu4znyOpOkliVxWNbbS7hOwANApBDn
         nmrG3UcbOptLtHSSoVbv/vgzYNbYDWoBhLWjrFF2bT2MQPJOdJ5q9jCptJAlyBaa0pvu
         y2eg==
X-Gm-Message-State: AOJu0YzDzPDK5i8PAsGWVrTLo0H177sZBRhElTUDQqW9wWtKpSZM064G
	hEEOc23mRpOrIwBEJw7BHbcRLNL61O+MMAUn2knXicrX5WHR9m4jANLrNRQKDA==
X-Gm-Gg: AfdE7cn4gHQr1fPnJ/JM7pb710LpcuzEKBesqkmGbuGF20BjLgg90IjuPb6yZve9Cxq
	bRO/fWyjk9NGGyEs3FX6OQFG4jklQX9UF/d8/aY19omxlOQoVYqJu3q+9UmB43s0EDqr8iahWwW
	Ho72No5jy+5kmoJJOsC2HsDpPdwsYQyWechHhkJJLpS2F00rEEXmDqLuRkhOgGNI+clqgcnIBPy
	Njt74XWCM8r4CEp4lF1oeyjvTqlmj/7lw1LFzLa/DvmcYleNgPkWcZ8ZwAuswxBIAzOJoOWncpX
	M10jdqw8GcTsqJOa4KucQYTnVYMcyYRGj5I5G53f/d1GEdYSXRRC8erYbCW3k6N+bylBC1kMUJy
	e/4PXKE51cmlUB5f+cccsBidRE+hRgH7fm3/Hc+MEzZi9CTSDrDS26AJHw6+OLwqdHqcBxK0gpe
	poXDBYz1YldJlLw7+Q/vZIERZsdYQ8kQJ/Kib6sJurt+raVBFAKCbkZhAwRdf3i1l/gaveI0bVj
	kZntPLwzju6dFtk2AigDMCUOTQ=
X-Received: by 2002:a05:622a:1e0e:b0:51c:ecf:4eb3 with SMTP id d75a77b69052e-51c74826e1emr8302001cf.44.1783348338043;
        Mon, 06 Jul 2026 07:32:18 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41ab77e7sm92790761cf.3.2026.07.06.07.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:32:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Seth Moore <sethmo@google.com>,
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [PATCH v3 1/5] libselinux: avc: use pthread mutexes by default when no lock callbacks set
Date: Mon,  6 Jul 2026 10:31:51 -0400
Message-ID: <20260706143155.36629-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
References: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
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

