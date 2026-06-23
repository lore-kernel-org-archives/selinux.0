Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC137CD3C
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222157; cv=none; b=RxLoqwX9DgmTtvpTPNoT50OaLC3wgZ3DOAIOFzQm1NJYVakgmME/mFcdnzyDFFwk+L5xtn078tXV69gdejoHq4BKV25P8Wa9C7uCaxdoqKY0dWfOzHB+M7F+CuRDRI193zgdM3MDpbA2LPUqbJHjRVh9S5p8wBmKsjDIjqLVIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222157; c=relaxed/simple;
	bh=I/sI2E3z1/NDegyiWe6neM3yWUb5S0XriQwCiBZRx70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCwqXnJYyoMVfCQhN+p2hCjMZOf7AYlK86I98GpZUONJq5mnSx5VyR+jzDubEt8nioQoUA1QeSO3KHmrhuXj0Vwk4Rq/a5OKIxsF7kwEej+MinViAI5lpCmUdpnNnvVJybP3t1ruKkCWSjSU4i8xUVFZfpEftOv2Eu3mi/YkiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=k8AJkd7W; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="k8AJkd7W"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222152;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OMfLwy1jxeEHWvLn38c+wVXTqgpdqux3/GFGJNVJOs=;
	b=k8AJkd7WrtzBpD5inABjmUxmKmfGDMOnYG/y5TcvevOya2IHIX5njPyViPIS05+JbFpqMn
	gB7I+LO6QvU12/fMGd+gkB5Wrf98iYKb4oQceZsd4SeAW9aZc19x22405wfgFAdEtpNcur
	rTYHCMjPl8ib2eij9DjaJ1nPAfhQ6r7a8uerU6lhYa2h5QoAtEb/ztAAycYy5T8Bi9HD4m
	cmPAROcCeWF4EmfhL8r/sbqiOJrhgjXODz2IEc+57B5K+a5FPx1hesDrmlyS4CSc7ghk7X
	Jh5WNuCpe0+SksIJfz9F7sejEalBi+ePRlku5cZqIH32SMg7SWQ1QESwnMaw8A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 15/24] libselinux: fall back to a default page size if sysconf() fails
Date: Tue, 23 Jun 2026 15:42:04 +0200
Message-ID: <20260623134215.98273-14-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

selinux_page_size is used as an allocation size by several callers; a
sysconf(_SC_PAGE_SIZE) failure (-1) or implausible value should not
propagate into those. Clamp to 4096 in that case.

Also change its type to size_t since it is used as such in all except
one place. Convert that usage in validatetrans.c too.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/init.c             | 10 ++++++++--
 libselinux/src/selinux_internal.h |  2 +-
 libselinux/src/validatetrans.c    |  5 +++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index abed3088..bd0803dd 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -17,7 +17,7 @@
 #include "setrans_internal.h"
 
 char *selinux_mnt = NULL;
-int selinux_page_size = 0;
+size_t selinux_page_size = 0;
 
 int has_selinux_config = 0;
 
@@ -145,8 +145,14 @@ void set_selinuxmnt(const char *mnt)
 static void init_lib(void) __attribute__((constructor));
 static void init_lib(void)
 {
+	long page_size;
+
 	SELINUX_PROTECT_ERRNO;
-	selinux_page_size = sysconf(_SC_PAGE_SIZE);
+	page_size = sysconf(_SC_PAGE_SIZE);
+	/* Fall back to a sane default if sysconf() fails or returns an implausible value. */
+	selinux_page_size = (page_size > 0 && page_size <= INT_MAX) ?
+				    (size_t)page_size :
+				    4096;
 	init_selinuxmnt();
 #ifndef ANDROID
 	has_selinux_config = (access(SELINUXCONFIG, F_OK) == 0);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index ce04b128..b0ef5a75 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -7,7 +7,7 @@
 #include <stdio.h>
 
 extern int require_seusers;
-extern int selinux_page_size;
+extern size_t selinux_page_size;
 
 /* Make pthread_once optional */
 #pragma weak pthread_once
diff --git a/libselinux/src/validatetrans.c b/libselinux/src/validatetrans.c
index add381e6..d837b9f3 100644
--- a/libselinux/src/validatetrans.c
+++ b/libselinux/src/validatetrans.c
@@ -15,7 +15,8 @@ int security_validatetrans_raw(const char *scon, const char *tcon,
 {
 	char path[PATH_MAX];
 	char *buf = NULL;
-	int size, bufsz;
+	size_t size;
+	int bufsz;
 	int fd, ret = -1;
 	errno = ENOENT;
 
@@ -38,7 +39,7 @@ int security_validatetrans_raw(const char *scon, const char *tcon,
 
 	bufsz = snprintf(buf, size, "%s %s %hu %s", scon, tcon,
 			 unmap_class(tclass), newcon);
-	if (bufsz >= size || bufsz < 0) {
+	if (bufsz < 0 || (size_t)bufsz >= size) {
 		// It got truncated or there was an encoding error
 		goto out;
 	}
-- 
2.53.0

