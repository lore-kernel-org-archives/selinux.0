Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0628F77
	for <selinux@vger.kernel.org>; Wed, 20 Nov 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106061; cv=none; b=dSXEjou1ZuHbTaRDNHXzlaegeSjsvRmmm7XgDegjGquWDPLyB91MZsFzOx73wkWcdLNyIvYT+CsydgtjM1dF/nKwvqtMERH/xupynI3izPUbJwaG07Aq1GlXtpzGas4QH/w5w7uBKXFXt5OON0eQrsht66R6UU0O1bRZ/b0PAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106061; c=relaxed/simple;
	bh=MomE7SiPwehpizzvEUAWRLMr8Rxscl21DGTRU5jlsPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eQlTCV0OWdeJM/tj8wKKKgC6LgRCAZiawDlvV2RDdGVzyF9LbQxq0DGSp2W7cgGX3QS9PjjefdjPRUoJqP9mgeyScAGzE8xyr4r4gC9SNWjS9oQpRWgaFmtrpjJXDy0wYpePxdRcrE1pRx2hXkXmvQqgdataPIIS4ayXrz7SJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Vvi/r8+X; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Vvi/r8+X"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732106056;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=41psCaiz435E0ytR/0Jqwbiy7F/Lk4FAV0dXeV33y0E=;
	b=Vvi/r8+X0SIe9tBCqBZhBwUMN2ppA6ttJQoCaUraAbi4clKILlk208F8Pey9PjKUHeUr9K
	C7avwnk944POe5QCqT1/3no41tdiTQZHXNDFi0AyK5PkTM/u1+Fpop20kXOQibJtbN/cfP
	XQ2/gDA5WWvU4AqZKWHx87rHjADWU6xz2sNvsYfM1uJcvtffJC+6F08MXfvOpLTo8epbCl
	TAvUAFskVWudACvqQNFghEzzudu9zJO9cr4OatO8e5i13PCozSD4vMBdHrPRiNesHqZl9P
	oaYwCV8HemvGiwboxmqV0zF+VwMo083iu8lT6UghxIMVd3EYmjnrlH4DcoESwQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 2/3] libselinux: avoid dynamic allocation in openattr()
Date: Wed, 20 Nov 2024 13:34:12 +0100
Message-ID: <20241120123412.50088-1-cgoettsche@seltendoof.de>
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

openattr() supplies the simplementation for the getcon(3) interface
family.  Use a short local buffer instead of descend into memory
allocation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - use sizeof(uint32_t) instead of magic number
v2:
  - minimize buffer from 56 to 44 characters and assert pid_t is not
    wider than 32bit
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/procattr.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index ddcc7f8d..aa16c934 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -1,9 +1,11 @@
+#include <assert.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <errno.h>
 #include "selinux_internal.h"
@@ -86,32 +88,34 @@ static void init_procattr(void)
 static int openattr(pid_t pid, const char *attr, int flags)
 {
 	int fd, rc;
-	char *path;
+	char path[44];  /* must hold "/proc/self/task/%d/attr/sockcreate" */
 	pid_t tid;
 
+	static_assert(sizeof(pid_t) <= sizeof(uint32_t), "content written to path might get truncated");
+
 	if (pid > 0) {
-		rc = asprintf(&path, "/proc/%d/attr/%s", pid, attr);
+		rc = snprintf(path, sizeof(path), "/proc/%d/attr/%s", pid, attr);
 	} else if (pid == 0) {
-		rc = asprintf(&path, "/proc/thread-self/attr/%s", attr);
-		if (rc < 0)
+		rc = snprintf(path, sizeof(path), "/proc/thread-self/attr/%s", attr);
+		if (rc < 0 || (size_t)rc >= sizeof(path)) {
+			errno = EOVERFLOW;
 			return -1;
+		}
 		fd = open(path, flags | O_CLOEXEC);
 		if (fd >= 0 || errno != ENOENT)
-			goto out;
-		free(path);
+			return fd;
 		tid = selinux_gettid();
-		rc = asprintf(&path, "/proc/self/task/%d/attr/%s", tid, attr);
+		rc = snprintf(path, sizeof(path), "/proc/self/task/%d/attr/%s", tid, attr);
 	} else {
 		errno = EINVAL;
 		return -1;
 	}
-	if (rc < 0)
+	if (rc < 0 || (size_t)rc >= sizeof(path)) {
+		errno = EOVERFLOW;
 		return -1;
+	}
 
-	fd = open(path, flags | O_CLOEXEC);
-out:
-	free(path);
-	return fd;
+	return open(path, flags | O_CLOEXEC);
 }
 
 static int getprocattrcon_raw(char **context, pid_t pid, const char *attr,
-- 
2.45.2

