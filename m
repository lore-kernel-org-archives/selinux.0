Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEE20010F
	for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264394; cv=none; b=Zivkf2bDFopqvflRIQc8rBI7fi+ji6OvHe4E1OHzJO4Au44kLGDjim19YxyYZ6QyXQY9nu/nZNHaLRZDeKpUGjlPPt30jTttyqRd8B7BEU5PKMOnCKpyPkVA0ISo67o/tviAA0MPtRD25Qdq90tQXY+I9VjI4XruED7aXj7VMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264394; c=relaxed/simple;
	bh=cooWyQYxODLa73FWqnDldTm3rdd0GA53DwdE5dqLufk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T3MzgXvNqIZfHdMh8+uJeyopJmYr5laEGMi47KNRmm5bPo+Fz6ZBpXhzJN+I4dAOO27oSPzr8XdmnFTn1nBngfNoNbgGALEfT37+TtlmDuFNYgq+C57rzfhKFkSR4YWcsdX04SB0fZEDdTqx3HisY1HeUpCtrwcb1XYFKLS6J48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=TO+Rh6Sd; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="TO+Rh6Sd"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729264387;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8jdytSgGIOtxdBMe+2TJUh7H89Qrv3ZqAWTDHRhfK3c=;
	b=TO+Rh6SdKHWZWZb8008EeEzBok0opV+cZQnAdD9ZP2qSxXKmjmxpoUefKwqz73qPmGboqf
	BGaW4v5IUPYi/NDNjCxC9oh6XTmiw+g77Z9oKa4n9IMXjlzxXVKyNBFjBkL5LkOBxArrtg
	3exn3y59tghXPjqp8LufxzR78KVYY5NIt6Sbntfq6Rrv0t47cTCtavu70aoKTfyHX6RtLu
	z4P3Z79tsQ4EGXAWGGaikdCGtpOcpAk6bQgTVdMwTcN0ODmz7e7GAEKjsvrsRApXs/CDW6
	XtQs3AryUIGkU6H33zWCJdbnglfYSeY8yVZATf6o1oCwygsPfAUWX5+frPGrHg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/4] libselinux: avoid errno modification by fclose(3)
Date: Fri, 18 Oct 2024 17:12:57 +0200
Message-ID: <20241018151300.445618-1-cgoettsche@seltendoof.de>
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

In case fclose(3) might modify the global variable errno, use a wrapper
retaining the errno value.  In the affected cases the success of
fclose(3) itself is not important, since the underlying descriptor is
only read from.

Reported-by: clang-analyzer
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/get_context_list.c |  4 ++--
 libselinux/src/label_file.c       |  4 ++--
 libselinux/src/selinux_internal.h | 11 +++++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 0ad24654..222b54c1 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -438,7 +438,7 @@ int get_ordered_context_list(const char *user,
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
 		rc = get_context_user(fp, con, user, &reachable, &nreachable);
 
-		fclose(fp);
+		fclose_errno_safe(fp);
 		if (rc < 0 && errno != ENOENT) {
 			selinux_log(SELINUX_ERROR,
 				"%s:  error in processing configuration file %s\n",
@@ -451,7 +451,7 @@ int get_ordered_context_list(const char *user,
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
 		rc = get_context_user(fp, con, user, &reachable, &nreachable);
-		fclose(fp);
+		fclose_errno_safe(fp);
 		if (rc < 0 && errno != ENOENT) {
 			selinux_log(SELINUX_ERROR,
 				"%s:  error in processing configuration file %s\n",
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 2fad0c93..40628e2c 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -628,7 +628,7 @@ static int process_file(const char *path, const char *suffix,
 
 		rc = fcontext_is_binary(fp);
 		if (rc < 0) {
-			(void) fclose(fp);
+			fclose_errno_safe(fp);
 			return -1;
 		}
 
@@ -639,7 +639,7 @@ static int process_file(const char *path, const char *suffix,
 			rc = digest_add_specfile(digest, fp, NULL, sb.st_size,
 				found_path);
 
-		fclose(fp);
+		fclose_errno_safe(fp);
 
 		if (!rc)
 			return 0;
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 450a42c2..372837dd 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -2,7 +2,9 @@
 #define SELINUX_INTERNAL_H_
 
 #include <selinux/selinux.h>
+#include <errno.h>
 #include <pthread.h>
+#include <stdio.h>
 
 
 extern int require_seusers ;
@@ -131,4 +133,13 @@ void *reallocarray(void *ptr, size_t nmemb, size_t size);
 #define IGNORE_DEPRECATED_DECLARATION_END
 #endif
 
+static inline void fclose_errno_safe(FILE *stream)
+{
+	int saved_errno;
+
+	saved_errno = errno;
+	(void) fclose(stream);
+	errno = saved_errno;
+}
+
 #endif /* SELINUX_INTERNAL_H_ */
-- 
2.45.2

