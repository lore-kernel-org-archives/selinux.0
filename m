Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145211F131D
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831992; cv=none; b=L9mP2tZoDZVR+SPJrgQxYqxT2hpvmsZaetMVjN+WLuTOrnOOoe4UOrD8CqaM9IuMdQ4xQbLRv4vLuVagT8MIEZQY0gWcSlvcaVXzJP+FUD9lYggVV5nJtIGiNj/uP4ifj7LMA68BVQZxMJipYBjb8dQqZyY3lU5rdlRPpXhU/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831992; c=relaxed/simple;
	bh=+sLil/roT4dbn1eLPNDuQlPEWa62z7OeutY3YMBoJ8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6XEB8au0q1hHGbl371yoQyxDXz3BKf720ucxFeqFZPqN1tXTGJVi6lgSuuI/FdH9NvtjX04cOTiHHfQKvtU4z3/I1L8xy8cHI22YBTM3divaqCI2ndtv8bS6Kllv2JhlYgNKHDJAGVeSJ2Rha8TXp8/e6wi0CcINUcFSQqo3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=K1uDO9+q; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="K1uDO9+q"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831989;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcfIZ3n4aPR7tyrojIL3ZvPI47PmZsRVuZpIbF19XYc=;
	b=K1uDO9+q1hLDi4LdvZ1WMgZ+0A0eH3Xi4aHkzIWBs7yVvuiwpTiqCfW32TPKfdyfD8NZvg
	j2IxtrOeKBkRxucT9p//SxH55ShnntOA2scp2oHYDdxJ+6YLV1os/BibjL+HcJ7g7xpQuv
	VvWvY4ghVGCEoRIRmbMdlvwq5np3ej8pcx3HFyVxZEnLDU8cCWpFt2+GZX1XgsaznIu9GL
	95vIwBW04wlEWz6Xzc2v+W3a8QUPQSE25sXkR99thYvBm47BIP7nwPwHcHWmWzt5U3KIVu
	5rPsINh2grxW2KBOHFlqtBZOAq/q//IOWCSfivsBjf45LKdbhta3hcxxLpFS4A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] libselinux: avoid dynamic allocation in openattr()
Date: Tue,  5 Nov 2024 19:39:36 +0100
Message-ID: <20241105183936.252530-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241105183936.252530-1-cgoettsche@seltendoof.de>
References: <20241105183936.252530-1-cgoettsche@seltendoof.de>
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
 libselinux/src/procattr.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index ddcc7f8d..ee1f48af 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -86,32 +86,32 @@ static void init_procattr(void)
 static int openattr(pid_t pid, const char *attr, int flags)
 {
 	int fd, rc;
-	char *path;
+	char path[56];  /* must hold "/proc/self/task/%d/attr/sockcreate" */
 	pid_t tid;
 
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

