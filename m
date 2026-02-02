Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6F3644D0
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042255; cv=none; b=oPDlc9SNmpXV9IkAruthOESSayvrCnExhtV0YGjyKNFsWoV8eqtAaV9L4H5ono950H2Mvd4l3ArCPOdfI9beLySwYxesml/Tvk4w+e4ivksUDAnNoBPpA2Fmd1jkW/DC8SLU+dLSTfxgk64s0ODrIWF0c0C/lcYehLUj6WAnhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042255; c=relaxed/simple;
	bh=WlC0pXpXIe7fw5OkcM9e5o19O4Ug9s1BzyWtYAZ/Y8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmIODT/JNiyDsCCAqsyxT0OCzcjwd5Nwr8+sTQYwK8+vWo8BZjsNZ2YvjW/h/nmxHrvGZscsR7b2Pu7Bco03N2YQbvdyHQENcoIUzWQmlVc8/9KZVlIjk2CKDIkgl4Blyv6nhFF1eVuSGVygFI6S1QvAHTkG2O33ZSSH+qTcRI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ROKWHdlk; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ROKWHdlk"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042252;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bvLxwq7plI4wum3Bw31QnDgl1ShmM2QjQcPZjVi5S4=;
	b=ROKWHdlk0/ks/kv4FwxG/OOBobnYXRv7YrN8/FXbpqx5ax8hdSDP+ZtDWZs8+RsSWSIf5Y
	w0qKfotmTV+hrkVcfuJodRSsaBjXF6cuFmrUURNRBAAiOZIOWob1qCwmv1+IwqmTfvqz/V
	o7dB0n8uuJAXYgZSoGh956HpIiHU0Frf7xet+WZ+NkWxaD/9jDRjnsGTVlYXlmy2uFinpQ
	Sm8Fp8/nnXsteMG9B91RqBpStxuT6AsDpkROQMpr4XLqbsICkBnO/FCGGdk63ZOxwxj3dI
	QmzdCyVNkbeZrfH5kBreHNLJ3AODoUqPykC3fbzCNtX1SDe7xajKeogikv4i5A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/8] libselinux: enclose macros and macro arguments
Date: Mon,  2 Feb 2026 15:23:58 +0100
Message-ID: <20260202142404.92347-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260202142404.92347-1-cgoettsche@seltendoof.de>
References: <20260202142404.92347-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Avoid evaluation order surprises.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc_internal.h | 2 +-
 libselinux/src/procattr.c     | 6 +++---
 libselinux/src/stringrep.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index 54f0ce28..166a5d99 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -144,7 +144,7 @@ static inline void avc_free_lock(void *lock)
   } while (0)
 #define avc_cache_stats_add(field, num) \
   do { \
-    cache_stats.field += num; \
+    cache_stats.field += (num); \
   } while (0)
 
 #else
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index f8e8f191..f72cfb2c 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -11,7 +11,7 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
-#define UNSET (char *) -1
+#define UNSET ((char *) -1)
 
 /* Cached values so that when a thread calls set*con() then gen*con(), the value
  * which was set is directly returned.
@@ -267,11 +267,11 @@ static int setprocattrcon(const char *context, const char *attr,
 #define setselfattr_def(fn, attr, prev_context) \
 	int set##fn##_raw(const char * c) \
 	{ \
-		return setprocattrcon_raw(c, attr, &prev_context); \
+		return setprocattrcon_raw(c, attr, &(prev_context)); \
 	} \
 	int set##fn(const char * c) \
 	{ \
-		return setprocattrcon(c, attr, &prev_context); \
+		return setprocattrcon(c, attr, &(prev_context)); \
 	}
 
 #define all_selfattr_def(fn, attr, prev_context) \
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 1b460224..19dd9acc 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -17,7 +17,7 @@
 #include "policy.h"
 #include "mapping.h"
 
-#define MAXVECTORS 8*sizeof(access_vector_t)
+#define MAXVECTORS (8 * sizeof(access_vector_t))
 
 struct discover_class_node {
 	char *name;
-- 
2.51.0

