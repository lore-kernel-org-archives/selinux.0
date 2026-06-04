Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52247CC89
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577907; cv=none; b=ftB2GMoh9y+IcnpiktEN9BUqk8E2edlfAqVeYKep1o5JUYOfMSIhQvbVr7lPUcihDafMWauSk7SWZ6jc5YT/wozzVWn6E9ckesndDqzzS/nRELRpbBRLLDi4joiZZK6/epTb2XlyVazpKbLEV1tVHJpG1RaBQyyHkSyVvpvsf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577907; c=relaxed/simple;
	bh=YhmnlQQIfTfDCa7tpucDOCJLcsCh2OYA/hT8rKp2adU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTtiSrKN/+MFffAwzKyQUP1AWlICz1s9pyispgUbQ89LGehqGrKMppdmfyopYvgb4b3CISk9xUz/zzjQ2Qwl6VmTzDPYSuokzzGLwFudAGJ0rm2cHFMooOTU+jcz3LsyWe8BDnfL5rM5HS7DhnfA0+u5RD7wBdaaMlw8M6CtflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1SW7/TL; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1SW7/TL"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91591f19716so86036885a.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577905; x=1781182705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+0YGcLrlHrQD1ZGkwGXAP+rRIOGzwLT6QXSTj4ClWY=;
        b=L1SW7/TLS9ty8QvDr6VSVxj2KjLwDRW038xlm1jJsMdqNg7Pea9Edy4CA/EBOWY+8X
         oHgO1F0mu74PDmvxLpssspwcxb1Anhs8CGc0+dt0KV9ECHWjb8LZ4scz7QBxTjJisY5A
         iRpyZoRYD/9vPc6F00C9DJSJcePMt5U1Th1I9k2FqYQ6uzekVVUwAXXpWxQdkxi0xFBY
         AEmEuL7BkzPAWTem1Q+eJI6KTAoRwkab/1DWV0yFR5O8Md3hQCijIf9d9A3zk8wxjTme
         OvulQ8S/pq/bYr5AXReogLIda56jT+TpuilIyv5d7mRJ834ZsmPlBESr01ejdTDtdqPR
         8Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577905; x=1781182705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+0YGcLrlHrQD1ZGkwGXAP+rRIOGzwLT6QXSTj4ClWY=;
        b=ghPMFmCsjqBVPDhDSOniUmb6uIDomkUp1TUVjwJux+qACrD4D71T6i2u/5ChZ+xfj7
         RZSgU/iyy22Vd7Q0SxNdqeT92NTB7C+8uz2nLKTGoK5qaGJdfTqGRj/JQcCZ3mwvXtdu
         ejrdTaFo92tbtYW2O0Z4AxC+MxGQB3nirsrU294n8yU6vz5aK6GS6zplBBJpOukGs1ip
         0GTV4VP7Y6lPIq9BsEwH4/zPXQb0KIgJn/OWg3Z3eNNsX0PcQtMxULJmDZqR9FV2i7FX
         ERtO9fYWeumfoC6HJthvmTQJtfAORMEh3uN2K8XD23ExfVHxJaWtN/+g0IKFGBkhYCjl
         PtOw==
X-Gm-Message-State: AOJu0YxIc7UxQHg+hMz2mraTJZOi1e1qmyDnwvLFg6iY854vA4ZesNb3
	QW10rdqYSsZLGvY4fx1fo0VYUbvr/tOJjR1ayutDte3h1wEQlwpt9swtKIanfw==
X-Gm-Gg: Acq92OEzU9p5dnvLEm3JGXF1hYuiRBZJPE5wLfJCsnjSL9EKgfANZcyTBV8EociKu+b
	ynFNrvLIAdfG/PkgPehaJfGqSSNYgC1m4deQXOCpJxfMXkgRgXsXBX8/99dXXgCq608amzBYjg0
	Y3VhgeTNTKYhsw9oJe7eqpV6r8eFp37gNsIe6f1Ta0CZe/pWo8/mjniqoW7jpQaXOD0ZzDk6FjG
	z0ZR+O03nrpC8r5RNyU2upneujbqNc2Shk6XurqH1RLwihgDCRQjG9xEGiZlxbYcRrUupys3e4P
	lk6vwkmOREDzrxzm0gyjx+h04geM4Ygg6Yd84lFYSvR8aP6VEIN73LrVUSd4pTGMxfJJhG3Hnqe
	dpZjyPeIS/mvO+JmWa05XjQkQSaOOHMv7LTS1HKIOdQ8bSJLeDhT6jfJxcejQJWU+Um6wBt/LA9
	SPKAPcTZgQye1TgvrbyzqnNE9HJmKyt2FwaFo2yyj1Nvz61ivK4UzB9gOKVNzkYnmAqY34yJEyt
	epHng5GmWXDyOvi9Jchj/FgPjp5OOvNP8oDAjo9lBF+xKgD
X-Received: by 2002:a05:620a:4402:b0:915:9f28:6737 with SMTP id af79cd13be357-9159f287166mr287227085a.17.1780577905498;
        Thu, 04 Jun 2026 05:58:25 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d3a0esm585789085a.40.2026.06.04.05.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:58:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/3] restorecond: pin watched directories
Date: Thu,  4 Jun 2026 08:58:06 -0400
Message-ID: <20260604125806.255648-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604125806.255648-1-stephen.smalley.work@gmail.com>
References: <20260604125806.255648-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inotify_add_watch(...IN_DONT_FOLLOW) will refuse to follow a terminal
symlink but will still follow intermediate ones. To prevent setting
watches on any files resolved via such intermediate symlinks, resolve
via safe_open() and then use the /proc/self/fd/N path for the pinned
fd to set the watch.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/watch.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 44094fd4..b197bdc2 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -168,6 +168,9 @@ static int nofollow_lstat(const char *path, struct stat *sb)
 
 void watch_list_add(int fd, const char *path)
 {
+	char procfd[32];
+	struct stat sb;
+	int dirfd;
 	struct watchList *ptr = NULL;
 	size_t i = 0;
 	struct watchList *prev = NULL;
@@ -217,13 +220,28 @@ void watch_list_add(int fd, const char *path)
 	if (!ptr)
 		exitApp("Out of Memory");
 
-	ptr->wd = inotify_add_watch(fd, dir,
-				    IN_CREATE | IN_MOVED_TO | IN_DONT_FOLLOW);
+	dirfd = safe_open(dir, &sb);
+	if (dirfd < 0 || !S_ISDIR(sb.st_mode)) {
+		if (dirfd >= 0) {
+			close(dirfd);
+			errno = ENOTDIR;
+		}
+		ptr->wd = -1;
+	} else {
+		snprintf(procfd, sizeof(procfd), "/proc/self/fd/%d", dirfd);
+		ptr->wd =
+			inotify_add_watch(fd, procfd, IN_CREATE | IN_MOVED_TO);
+		close(dirfd);
+	}
+
 	if (ptr->wd == -1) {
 		free(ptr);
 		if (!run_as_user)
 			syslog(LOG_ERR, "Unable to watch (%s) %s\n", path,
 			       strerror(errno));
+		else
+			fprintf(stderr, "Unable to watch (%s) %s\n", path,
+				strerror(errno));
 		goto end;
 	}
 
-- 
2.54.0

