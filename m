Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6401A304A
	for <selinux@vger.kernel.org>; Wed, 20 Nov 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104009; cv=none; b=Jadx3FP3eKkyf7M4VaMtC+4ssEp/ts/PbK6MQ3fS5uBqnQHciOJ9DlgJXE00xuaE2ZBER9irTDpCRLIubAqFpvEgPjKsy+RgxJAVpvAiqQEKYUzNz5wbdBpTzBIzXKFOeyXoV6IfcxMorfnUVtca5TjWeRan7doQxYBXeHAeUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104009; c=relaxed/simple;
	bh=EfQ7pK6H9YpoRBwPI8SnLEvOBMtI8vhlF2AE66fqNAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9qLx4X8ETTRVz54TYuRMBQe9nbHg65VVasFcNCVH6a/kiccm7qZwZjUDsdn8O8fGYCA2fkBE/43iKgp9JqlAt20ALqRiLiHTmsRWkjff023eatxk3SyLvYu8fHfZ2LL98tnAWQo9X1enKmrJgRSTx2lI6LSRQ+7T0eVvwfgZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Dm/FUqiX; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Dm/FUqiX"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732103997;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7YQJpHwARV1qjeXpQlQtFPQFwcSXUfx7symzkpKA34=;
	b=Dm/FUqiXtaA3J89gpVjCQdGjcgJpDhXnEEFpS+0MKyK0i3vqAt7BME+T6j3tIwKmwNVveH
	ezy6q/x294WAruLrnquIiVvGOVpzxVdoqoJH9hPHAcns54pZUCH1fp6Xm1h//9YrE+Ulha
	zg+hekkqECeCRDkicjpE4rqdEvY8ww5PFp/6QaJzW0ZVi9cI6mMwJD0LHNMxRos57OhdH+
	iczQqEIbV+6O98WEKMgQ0VRYjciXMAh7yEGGfSlSdBDQ8b0ytXOl1qTy6gU4/2IsJjMNe6
	gl46GocOcjO0yccnRSgncL3BQYxa6iWBjAe6PmVBu9LOVRnDAt3kl0hs4XRQKw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/3] libselinux: avoid dynamic allocation in openattr()
Date: Wed, 20 Nov 2024 12:59:49 +0100
Message-ID: <20241120115951.42445-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241120115951.42445-1-cgoettsche@seltendoof.de>
References: <20241120115951.42445-1-cgoettsche@seltendoof.de>
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
v2:
  - minimize buffer from 56 to 44 characters and assert pid_t is not
    wider than 32bit
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/procattr.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index ddcc7f8d..21c810d2 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -1,3 +1,4 @@
+#include <assert.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -86,32 +87,34 @@ static void init_procattr(void)
 static int openattr(pid_t pid, const char *attr, int flags)
 {
 	int fd, rc;
-	char *path;
+	char path[44];  /* must hold "/proc/self/task/%d/attr/sockcreate" */
 	pid_t tid;
 
+	static_assert(sizeof(pid_t) <= 4, "content written to path might get truncated");
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

