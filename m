Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEB369D6E
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731802; cv=none; b=dqQ7VHdaKgvzSOu4SEigbYjTx5C/04Ny+QTbsRFmEzQFg9hfD4TUyUDhO7ERK7Ag865Kv/4XyU5dfHxagk6mTlojoz/6BfSc22FpVjH7V/+G6nC1zY4O/oDygi1qpiMwM0pyXKf/gHuCKaCrL/IcsLu6yyIYRaPS+ANVc06V/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731802; c=relaxed/simple;
	bh=YPS8Gcyaz+EOs3zyOMJwHElmL1m1egTugG4biAbAiVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDcnwRxobFTWDy7nK/bSjhWpN5DGUQas2PsUFohBvOye8dhS34ekehztXG+UW4OvfZ2KnmA641TkpuOSLjDf7+jOV/qRxZMAiInrCZlnI+9GZxrXXT9VDCdEclJVT89afn08cxifmRodxcRD0m+v/B3+vxmyjzfMgxe+UMjRuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwr6PU71; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwr6PU71"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so127723926d6.2
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784731799; x=1785336599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxZKYQ5YIQLzaXYFGFBWxzp4wY6MFn5BxXRvlrXob9s=;
        b=gwr6PU71HwyITHR5FdbtFbULq2/KRvV8qmcjRTg9j4ikMksBdwWcfw7U/kRmO52zCd
         J9bELeGSsquT7lCDW+IJM+ZFhw+rUys/5C4FiKC+/cFzR5SAMRi80AFJGJehpl+C97Pf
         /meYqd4kfIZ1zHljaFT5Mz7U31O1s4nkEUnUvJVY/ZXaXsZLDJncPTn1ilpuUWnpejNp
         K30pVz1zA0qHAft/SRkdkSqK4XmuW2LWbIJog/Yy0+97I24cnnqC0JFNtygOWQen0tX4
         Mh7Mo2UWc6mtEim8exMx3nVAuxCG9mA2uhxq0/UGLAUlFR0zhwPybJiZW6+dJOjlbxIx
         nnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784731799; x=1785336599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxZKYQ5YIQLzaXYFGFBWxzp4wY6MFn5BxXRvlrXob9s=;
        b=sP6C5z5hH5zFqdw61ttz7QSQR2q7myTuiXrSajslpeesRnbaX8JJSXdOOfc1XielAw
         tpfrYVMEHnvolkT8vAjj/pOPxF3iBZcmWEzZb2t6tSL/1WOXHzq3yVy/rK4+NRtec+Ch
         iRSxH8LOGr+lEWvfPk5yy0R0CU/t3M3lem0O5ZN9Vk8j84/a056ORK6KTQkKJq/nIHZJ
         an0ZwnqCTRicKfMuwE9+tOMLyji+MZeJYXLrkRS2RkUgaDQzrhw1ShBC5RxAhLWHIL4X
         EYoVgkbn80QuY/Kjif1feXvYomL+iaAqxaRoD9jDpBuWrI9CkHw0odv2uBQymzisnkwf
         VNyA==
X-Gm-Message-State: AOJu0YxzpAdz7HpfSgZSos67+eWLNnxj4ebwIknx+e4dCaLajjXl1ze6
	3g72qG65etyNC0t5+3FK+N1LiSprxgT+z4oeYS0xjS3rA7PekJhVwwab/64sEQ==
X-Gm-Gg: AR+sD10943igdOfaJ08kWY2hSEaBkYGSzrL5tG3RSrhNCCdU4/DdPYM5iI6Sc3aUBB+
	yu8yyOcNObA3GaSBjBr559zEjIt4rjh8P2QnMBf9XjrTyoUSAO1CWkPNSg6ZmyPD7/2afxDUL1U
	PP0aW77K2Vj5Q49V5hAjbtvkDQS90xCVxsrRbbMlqkedBg+xz4FQpEn7FTNfv93+6nXsEKS6y4t
	LXkjVhP0Jfzag1vaOq15o/2msIDBfR+WG9qz2IDSg0NH99CxKzV9WSphF7FYdn4L1E9dubD3Wz4
	eP5SuzH54NMm1RowFATdG6snCeYw6FH9xq3ZP+qoaubWQmJBJMq75zH88pi3rEzTmHCQJclhX/F
	YW5rJl72l3ePeVd7Qp4kKrlA0R+o2A9xss9RmzaRONzRNPN7swFz3hCjDpzn8G9m3vgczzEawDe
	SUEetoVwN4+5JzhlWca+IBOXQJppY5rotxebcFOIAzCqvvEF8VqTay9tDzqRGtbwv53SEGlU+wU
	Wrrvg==
X-Received: by 2002:a05:620a:4887:b0:92e:e2fc:26d3 with SMTP id af79cd13be357-930b41cf282mr2253708385a.46.1784731799135;
        Wed, 22 Jul 2026 07:49:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a0371asm179775385a.27.2026.07.22.07.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:49:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3] libsemanage: block on store lock by default
Date: Wed, 22 Jul 2026 10:49:19 -0400
Message-ID: <20260722144918.73394-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semanage_get_lock() polls the store lock once per second and gives up
after sh->timeout seconds, which is hard-coded to 5 with no
configuration setting to control it. A single semodule transaction on
a real policy routinely takes more than 5 seconds, so any overlap
makes the second caller fail. This makes rpm scriptlets, ansible,
or other scripted usage of semodule fragile.

Change the default timeout to -1 (wait indefinitely) and in that case
use a blocking flock() instead of polling. Try a non-blocking flock()
first for the common case where the lock is not held and if it is
held, inform the user so they know why it may be taking longer than
normal. Retain the timeout logic in case we decide to re-introduce
other configurable settings in the future.

Several other minor cleanups are included as well, e.g. there is no
need to pass O_TRUNC for the lock file, and there is no need to set
O_CLOEXEC a second time via fcntl() since open() already passed it.

Fixes: https://github.com/SELinuxProject/selinux/issues/181
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 fixes the description (s/requires/makes/).

 libsemanage/src/handle.c         |  2 +-
 libsemanage/src/semanage_store.c | 81 +++++++++++++++-----------------
 2 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 77d0ed8a..1ff86e60 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -37,7 +37,7 @@
 #include "semanage_conf.h"
 #include "semanage_store.h"
 
-#define SEMANAGE_COMMIT_READ_WAIT 5
+#define SEMANAGE_COMMIT_READ_WAIT -1
 
 static char *private_semanage_root = NULL;
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f14ebe97..f6ca1afb 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -50,6 +50,7 @@ typedef struct dbase_policydb dbase_t;
 #include <stdio_ext.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 #include <unistd.h>
 #include <sys/file.h>
 #include <sys/stat.h>
@@ -1944,61 +1945,55 @@ static int semanage_get_lock(semanage_handle_t *sh, const char *lock_name,
 			     const char *lock_file)
 {
 	int fd;
-	struct timeval origtime, curtime;
-	int got_lock = 0;
+	int left;
 
-	if ((fd = open(lock_file, O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC,
+	if ((fd = open(lock_file, O_RDWR | O_CREAT | O_CLOEXEC,
 		       S_IRUSR | S_IWUSR)) == -1) {
 		ERR(sh, "Could not open direct %s at %s.", lock_name,
 		    lock_file);
 		return -1;
 	}
-	if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) {
-		ERR(sh, "Could not set close-on-exec for %s at %s.", lock_name,
-		    lock_file);
-		close(fd);
-		return -1;
-	}
+
+	if (flock(fd, LOCK_EX | LOCK_NB) == 0)
+		return fd;
+	if (errno != EAGAIN && errno != EWOULDBLOCK)
+		goto err;
 
 	if (sh->timeout == 0) {
-		/* return immediately */
-		origtime.tv_sec = 0;
-	} else {
-		origtime.tv_sec = sh->timeout;
-	}
-	origtime.tv_usec = 0;
-	do {
-		curtime.tv_sec = 1;
-		curtime.tv_usec = 0;
-		if (flock(fd, LOCK_EX | LOCK_NB) == 0) {
-			got_lock = 1;
-			break;
-		} else if (errno != EAGAIN) {
-			ERR(sh, "Error obtaining direct %s at %s.", lock_name,
-			    lock_file);
-			close(fd);
-			return -1;
-		}
-		if (origtime.tv_sec > 0 || sh->timeout == -1) {
-			if (select(0, NULL, NULL, NULL, &curtime) == -1) {
-				if (errno == EINTR) {
-					continue;
-				}
-				ERR(sh,
-				    "Error while waiting to get direct %s at %s.",
-				    lock_name, lock_file);
-				close(fd);
-				return -1;
-			}
-			origtime.tv_sec--;
-		}
-	} while (origtime.tv_sec > 0 || sh->timeout == -1);
-	if (!got_lock) {
 		ERR(sh, "Could not get direct %s at %s.", lock_name, lock_file);
 		close(fd);
 		return -1;
 	}
-	return fd;
+
+	INFO(sh, "Waiting for semanage %s at %s (held by another process).",
+	     lock_name, lock_file);
+
+	if (sh->timeout < 0) {
+		while (flock(fd, LOCK_EX) != 0) {
+			if (errno != EINTR)
+				goto err;
+		}
+		return fd;
+	}
+
+	for (left = sh->timeout; left > 0; left--) {
+		const struct timespec ts = { 1, 0 };
+
+		nanosleep(&ts, NULL);
+		if (flock(fd, LOCK_EX | LOCK_NB) == 0)
+			return fd;
+		if (errno != EAGAIN && errno != EWOULDBLOCK)
+			goto err;
+	}
+
+	ERR(sh, "Could not get direct %s at %s after %d seconds.", lock_name,
+	    lock_file, sh->timeout);
+	close(fd);
+	return -1;
+err:
+	ERR(sh, "Error obtaining direct %s at %s.", lock_name, lock_file);
+	close(fd);
+	return -1;
 }
 
 /* Locking for the module store for transactions.  This is very basic
-- 
2.55.0

