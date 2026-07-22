Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F20342538
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728033; cv=none; b=ptA4wRSCDlHdKy+We/y22Ci/DuQFaQ4jcABDUTOsGw3t3JoGnSdwKddHtPdoBKckNXuLr2QEsXaXERvfnAeVWK5K7MZe7iHiVOdYxdtevDBXamN8ifwJNO1Pak+Qd8BbTBX4OW2RfN/X6g245ivXLst5wf1z3Jk/53AU9Y59ArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728033; c=relaxed/simple;
	bh=jyLraxMRUnpMTJMAV6ocHMl027A5kdWdyMaOQlg0tXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAOlbyFjW6Vybvx39XEVJIpMRUFECSY4IKfnlRoFqBCfaO9ceILIAcRv3KF9jOfCJwuZjQ6jYv3K8EtUVa1iEf1LXu+IUiAuHbp5y6DnXiInk9YeunKzBenyF+yc5DB2xTUBD7RSdbdiQw89/Bwi9Na446kJuGhuO4pnWOI0F+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6TrGJX6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6TrGJX6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9063b380982so97049876d6.0
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728030; x=1785332830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1XLkN9lXLjYtMVKsEt4XyMEBc6X9XzdUYPLXxsD+jQ=;
        b=f6TrGJX69aJ3AeSO9CxgPWgK5/LhHL4KPzFK9BFEpnEJ2bzCZP5Wq5B3GEQBQnCFlx
         nvsadXUVljnakOSSm/DTk52y4wvfH82zO2+CZG3nFPCS3Edp05urIqPo0W5Ibq+iYgkz
         65TOxW+sBwhD7eZYN/Wu4EU2mtq2EeDp3nzhBVgmAE39e/BESNU+TEKOustM+LcF8eFb
         QbdbYn460JX4LbBLHt+XT6AocVBuYpvmQT/Qkw6Ryr/6wQS5dhvm4m4GAZgzJYxnjlus
         SxJeEZmdwtcvCkzlxOkh2CXMcS2fulBPW/48TxTuRsIzkQxf79Z0O2E0jDkKKRI41cV6
         VQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728030; x=1785332830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1XLkN9lXLjYtMVKsEt4XyMEBc6X9XzdUYPLXxsD+jQ=;
        b=gPCTMnAxwmEeJ9LwafKUmhhHbo/ELkEg0wkgQYwxHVikyUspWr8m6Y2EDAI14PCPCc
         VEhg8zEEIt2FFDJGXfEB+yG0kfHiLij6f1gKwv2XUeax77AUvn9m/LbLDjHgSi4suCeQ
         GjhHNZA3BzaayvXrNWCKMru6zxfU2rb8exj5tsWp88oALMd1bM8mdWwuw1Zw4EGOa2Q9
         mDBWCX/eKnj51vGAq5Hy/mNvhR4bAiGqxhlHy/Xz+KOBFuexiGmJLGhNBIomTgXqUWEk
         Sgf5MWcS4CuRMRGRusEQj+TeOT7ri+QBOa42PjTmcQnIWbqM6KvTotYipnypu5U+Qu9f
         epfA==
X-Gm-Message-State: AOJu0YzMCVeQHZLHfpOGeorWiBlEDRfb7LEOpa+Ple4Cbg3nqDidGQWR
	36ii4x41bX00YN9SdIlerxH+Bg8adY7PE6MWcB1L128FGzgANu1BHqNs27zl7g==
X-Gm-Gg: AR+sD12AD7jZuminLGmnHFgoB9QiP8uuI82RG/EZ24A826538q1YLh5CxZ+JgkGyutW
	rPnT06/ENhjouN4UG2iMt5soBDu1KDU6pGgpeO7QUQ0S0zpK25GclEUXX04MLxGVX6u3CanRmBW
	I+tbUQ+sB7j0X2C1yfqgDwW8dJrHro300yWD1dMbj1qM9YNRnOmkvHMZB03AmDlO0VzS7uh+r5v
	MouA2d6IOMwLT0Nr6LfPVOZ2l8/8FepnkqBQ5tcScEoIkb1hjO4uRipfu99AeYXknmWCMV5DChy
	LIH6HxOIJsVA9pbu5Y77iqAF1WFW2nv1Y4GqSdXsFuNpN9L1GYpzvc0o6j0CMiNn1f7C0j5dXyU
	KVts/Vri1wRy6aDzctSO3CuCLvifConys9B71giFsnQLo3JVNEZJCFkrTpgYL3rQorWltCGpcNu
	/u6ftmcB5kJjOPylmFrLAd3hrVuvSpQBVidLOspbFDqQ7LPbhCxLDZ17+3yMV7l2+zJrg1p4mV7
	GyxPA==
X-Received: by 2002:a0c:f201:0:b0:904:4e5e:904e with SMTP id 6a1803df08f44-907783dca2amr248638466d6.54.1784728029833;
        Wed, 22 Jul 2026 06:47:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa0a9f6sm21374076d6.38.2026.07.22.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:47:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libsemanage: block on store lock by default
Date: Wed, 22 Jul 2026 09:45:45 -0400
Message-ID: <20260722134544.73003-2-stephen.smalley.work@gmail.com>
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
v2 adds errno checking for the first flock() call so that we
do not ignore errors other than EAGAIN/EWOULDBLOCK.

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

