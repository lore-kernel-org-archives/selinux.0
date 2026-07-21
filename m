Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30246DFE7
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650622; cv=none; b=dOtGlhgTW22kH/xJL+D1RdrzxZH41ItT4vBqijy5l6feJNkPgYxje9MspF7QvpXkuAlBFvzrt8g31v5L8LAgoS7o5oRrKz88gYcBBrQrdhLB9gV1uP8gIwNd5KP7VUDZ0qofbO70WPXE1kvpWeZe4AkrhGVfHfQxuff3feF4w3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650622; c=relaxed/simple;
	bh=AdU5O69EU1qXmivDDeYLhptN+caQrCYH6p/zhKaqfgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYR/fVILUhgjobGQgAYPpX3vc1g5jLqaKLUCxNDuzrygZQ3OqX4AW8HWr4RU7N5KeOqr3hOyeSAExf+E2xAcBlrfTGAhP/nttjwq/jkufuiw1Wk/vT6yGuGHABMT1/SSAMt8UgxQfD5y2pJh8GbRXF8pkPf1Z0YKKAWqNV/Znjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMmLlcKl; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMmLlcKl"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7ff05e5d009so134465607b3.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784650620; x=1785255420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRrqUCIWR5uxhbYjPAk2NybmC5zmar4XypspujHK/08=;
        b=iMmLlcKlld5F6FnfHfNyM9u35p9+gi/OfS4giZ1nKXmWsCxwkiC4Q+RkFRiWPpJg2b
         5psvn3BgFO+vIiNVSBbj5bWCvBtWMGRsRID3yllepuog9EeIvrUbzWFJW7SWVx+xWo/q
         pTErx16DUEldrrKoYVJpPzIygNiGJUCzCKSeUEHSv3h92ykEBtT1tZ1oUaAA77c8rFqY
         dMdxsOZdZDSPcIk6Pwe36KgNJtWEoN0U8r8QzURv9SKQWph9XEFQwnUHJz3cLiLZcou3
         AxfKLt3+nwQ4TXljHWeuDx0tMoCw/ZIJuGHimRsYmW57LlOcCUc+uAQDe/Ttmn+LyHcO
         ffZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784650620; x=1785255420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRrqUCIWR5uxhbYjPAk2NybmC5zmar4XypspujHK/08=;
        b=lS+ix5oU+xBcMkfZsf5E/NMWR9Dple7wPzkifAlu2nfV9mLUynA27kwLpK9WQ8Uucr
         y4cxa9LZYxoDGTbhW/qaJCr7Z/E/U5H5YbyWyG8xO8fdOJeT/dWgJumE81/Zlav6qRHw
         h0nJVFos9SO/HrC6702bnq+950NnKYpT5R0Ae0B+ZbXmAGqna+LkXzdT5afx/yDi44uZ
         91lfSxjjTrIAytuwWnH6p8D7KOGaHqng2niyhmuYlGPWS5MCxK+drno7uSdP97x5pPsf
         1rHhpfXItPMiz6arh5KEQNG2VJv66ogZaVaAGDk/WlSVNMTS8n5fcIHYoNmTzbIStU+R
         Y4cA==
X-Gm-Message-State: AOJu0Yxx32KyZ9jiJwKwfoW/zAlLaZjgTo3zAyH0uj/2qz/Lnabilm3j
	mxc7FlE7l+YX/SE/FJokVRFGmcYjiejUAX/AcHo0OqQ6rIbEjF8296g74iptVg==
X-Gm-Gg: AR+sD13MeulK3d6WTKiyNXyLjFQFmfzBCJ/1GqNLRd4uUKmYwFt4bpAn92+UFpMp3CI
	ebae0fWBGRGOvH7yhmQZ0LDN16uAt7daDp64LxaHU3p4VDlQFyJ97hUHTy67+hVzCMudK1baRUo
	gd5jyE6uyxezQcIfjA1ni03e0/NI5RbtkXM1iYy85vSfl4bQItNCL77yX51B2zcPKEKQ8FRNrbE
	y9bIZzkAfjzLrV6C0Yu6uP+WZkh6xnfqVEpMXtBg/JB0rAKrRK900ONVSpW989HSj6YbpJUc9TZ
	Y9p93lNBamiJLdNVHmEgboDSE8UA4BsPZuB9Lz2suJLtBhDh/F3h/RRP00QSNKgLvO2mSZwNPc+
	KIW7Ff2FtbYEIfLtIvadfrmnEf4XGMJ3UtiqL9rvViXp/Gdl5oKYQ/W7z6V4OYUSapAF79hbm3G
	SHLX5TPSKaFp8cD4RKmpmMXq0OuRTUKBB8l/G4d/2Pmnr06H7HnbI5VZ8G4lJGa9s9jop7HSlUV
	W7XqA==
X-Received: by 2002:a05:690c:7244:b0:81e:d1dd:b44f with SMTP id 00721157ae682-81ef285017dmr63411537b3.54.1784650620167;
        Tue, 21 Jul 2026 09:17:00 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90778588a39sm120126556d6.20.2026.07.21.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:16:59 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: block on store lock by default
Date: Tue, 21 Jul 2026 12:16:44 -0400
Message-ID: <20260721161644.59749-1-stephen.smalley.work@gmail.com>
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
makes the second caller fail. This requires rpm scriptlets, ansible,
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
 libsemanage/src/handle.c         |  2 +-
 libsemanage/src/semanage_store.c | 79 +++++++++++++++-----------------
 2 files changed, 37 insertions(+), 44 deletions(-)

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
index f14ebe97..910a0807 100644
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
@@ -1944,61 +1945,53 @@ static int semanage_get_lock(semanage_handle_t *sh, const char *lock_name,
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

