Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FAB19CC1C
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334644; cv=none; b=oApgGjr/8yCs6fk4X2CPXXaGcnSVP6WpUXhqtKOQLLUWC/RVcT08ttqjQXCdH1kpovQSeUzEYs+UBjmH0t0L3mgj4oAZp6HPLOKA3u9Ud0Ipn4RvzmoxPukVVvqftcwuN7cSLLl+lGpSGD5FSuLs239clZQ4jTrgDE6+Ix3oqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334644; c=relaxed/simple;
	bh=8cU5PGK6f2sjoWR5k5DC9/rigj/R0rfGIoW6+M5cf5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppDdJFfWkeYIAAkZ/69qxH1OqPy3CFQNQ7wJtJSj4R8npx3/Ak/LWv//K7T80uQmEyn2D0lZo8yb/ExYiOic0xowG/qXCqMqN1msTwaRexF+tiXYyR0+NZDfxB2wQ12GJwqE1ifC7lqkMZBVUzrMq1XUrH1apeOUd9vK73m+7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VnI20vn4; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VnI20vn4"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334637;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4C9MllQ/dsLPOxpK0SHGLkwloY2UGLglHoKDi5bCzo=;
	b=VnI20vn4o2kbktDHH3rx76v+j4PHT3MFWc9rGXlaOUJrASJXjs5SMP4MudWSudHEk0m9OY
	mdF8qj10dYTtUdTiW7oBExF77gSbeL7w43Z/ey6AkxZGN+/P39EX8XuM39QeAGFFUIhL6t
	rzpjclgjy9KsmIU9Qk+6iRz7kc52fVMUbFg2wqRdX/BdYgZpH8WPO22kTDXqo0Et3EjOuT
	jii6yHSZ3NkXq8Lg5uOvKXzjOrJOowFg7d+7qifqyUt0FE8DLXn6Du8WTJyR/t/i7goVrD
	YhiSYA+dGceHm/midyT17tj77JFAD0MH27Fowhq8Qr7ZukBqRPAogtA3zQheXg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 24/47] libsemanage: check for path formatting failures
Date: Mon, 11 Nov 2024 15:16:43 +0100
Message-ID: <20241111141706.38039-24-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/semanage_store.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index fb3f3cc9..c9bb9c97 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -798,7 +798,7 @@ static int semanage_copy_dir(const char *src, const char *dst)
  * well. Returns 0 on success, -1 on error. */
 static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 {
-	int i, len = 0, retval = -1;
+	int i, len = 0, rc, retval = -1;
 	struct stat sb;
 	struct dirent **names = NULL;
 	char path[PATH_MAX], path2[PATH_MAX];
@@ -822,13 +822,21 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 	}
 
 	for (i = 0; i < len; i++) {
-		snprintf(path, sizeof(path), "%s/%s", src, names[i]->d_name);
+		rc = snprintf(path, sizeof(path), "%s/%s", src, names[i]->d_name);
+		if (rc < 0 || (size_t)rc >= sizeof(path)) {
+			errno = EOVERFLOW;
+			goto cleanup;
+		}
 		/* stat() to see if this entry is a file or not since
 		 * d_type isn't set properly on XFS */
 		if (stat(path, &sb)) {
 			goto cleanup;
 		}
-		snprintf(path2, sizeof(path2), "%s/%s", dst, names[i]->d_name);
+		rc = snprintf(path2, sizeof(path2), "%s/%s", dst, names[i]->d_name);
+		if (rc < 0 || (size_t)rc >= sizeof(path2)) {
+			errno = EOVERFLOW;
+			goto cleanup;
+		}
 		if (S_ISDIR(sb.st_mode)) {
 			mask = umask(0077);
 			if (mkdir(path2, 0700) == -1 ||
@@ -862,7 +870,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 int semanage_remove_directory(const char *path)
 {
 	struct dirent **namelist = NULL;
-	int num_entries, i;
+	int num_entries, i, rc;
 	if ((num_entries = scandir(path, &namelist, semanage_filename_select,
 				   NULL)) == -1) {
 		return -1;
@@ -870,7 +878,11 @@ int semanage_remove_directory(const char *path)
 	for (i = 0; i < num_entries; i++) {
 		char s[PATH_MAX];
 		struct stat buf;
-		snprintf(s, sizeof(s), "%s/%s", path, namelist[i]->d_name);
+		rc = snprintf(s, sizeof(s), "%s/%s", path, namelist[i]->d_name);
+		if (rc < 0 || (size_t)rc >= sizeof(s)) {
+			errno = EOVERFLOW;
+			return -2;
+		}
 		if (stat(s, &buf) == -1) {
 			return -2;
 		}
-- 
2.45.2

