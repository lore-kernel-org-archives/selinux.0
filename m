Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10B3B6378
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714518; cv=none; b=UEBvyEFyNVO9Fr080dcfVvTnEHjFRGN9MrQTSOBoCKKy+61qEnunrJoOAZjM0Ed+Na9bOULCM+ujgmBCKuHdlzt0Fto0fUEz13hv13aFtmY0UXe9UknHugHZgQQL4Imf5kJBr6wvibX+1enAhXSbYZTLzY3H8H0BjlyDEIsv8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714518; c=relaxed/simple;
	bh=nhxXatEohBl07iwXQsZXWhbZw6ERG2FvQOs4nCcGGWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcrWGnMkgvYu98tF8Qs1olBBNb4X+izoVvrW8LIgjzuuVsycg65M4P4+OdMpw5XS0u3erAk8IFHNjT2g4mn7oANiE/BZRfnCuwuCxoSiyxiXwaheCFmNXnKQaUVPB5VJlVQFmjq16i2K65/vM7bVYoBUtO+qR60kq9NJ5XWCH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULRKY/lB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULRKY/lB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93695893ac1so73718285a.0
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714515; x=1787319315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ark73T4yHQLtsSIyZ0uznk2K+RkumPASa+cxOc8H4zQ=;
        b=ULRKY/lByCDg6e37dzPK4gy9xAgngSVV80NH0LvrwbVv3CXYRH431JsZ8H8eLgK5+d
         m7ZZszlyn1/kf9yBMcWPn5FXeEBUxxzCsHbXATtHWqxDfANvykwCRPH49mFdWNl8Xl77
         LxAhlIjfvNDKFRgdRrmiV9wGpq1wX9dE/FV0ZBcyazbOOPGHao9pRpcko+QLBhnZSqMX
         JMbQ+F4TKQ4fszYtxQJwzZ33ZbLs96W/uwj3iPfyhrTbHz3MIQ99bq0gZdjjCK/itP7Z
         L6CQOOOWy2sN01syLNHc3u8RTsjhtZdPNGcfQlhf7N9Ap+3vR7wbt5kWzI93AsCt68oY
         uxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714515; x=1787319315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ark73T4yHQLtsSIyZ0uznk2K+RkumPASa+cxOc8H4zQ=;
        b=dMEiV0HoOSmIeVmgNBx3FiCADhwIzE4CUzR1Vhhtgfkss90HfD0AveGHw5CmcLu9nY
         FuqHuVQSWFu/s3SL3IoIzsSA43dhVTFUadNKNYubqVVXpSTqLKKKNto65QAjpvEr1Cy6
         WxlXUNsj3Cj9CiVG5UAOdB4CUgfirLRO8oA7WbNeyHe48+gKTebZAyWtDSIpGghS2Yva
         OgeCcsDol/fx9FT/qZJToWCUfITQBORmBO0EcjjwLoBY4s/55bQZS8nmtX0OS5CVX73E
         jBMGC9y/oW1ZGM1e7Z9TdbAsElc0YQIKFdFjiYsn9UdV4asGFll/lmgTqq8lxORm1gn4
         ASnw==
X-Gm-Message-State: AOJu0Yyn0eTVBxxvMKKa1k6U98gHfuxBDaq/Ucxxo2GtdV/eex8/CnOq
	rkfgOZKJ/6T2JXQe4KXec5eG45dtuPaJ66H/e7UghyoViuXTuQ9ZXkUO2OwO0Q==
X-Gm-Gg: AR+sD12gc4j7LcUYsLjRKuI7cGYyi+73Sny3Qp7WI8Ne79/IqMggL18k8xix1bDirZ7
	pXOWJJNfnGp0Rq+iX4gOLHyemGrV/oLwmQTf7Phs6D7aGXH7ZKlrt1f3lVa3w4hCBgnZrwDMPbG
	H7xMKfWyJStdnho2Vpqr88SiXorLlLeVvPI9lHsgADtyTMPCdLYvpU0S9cpedfVqwZZzngw+SlI
	4FmYMJPOCb+Eq2LDyZf0WytUm/zmnlitIZScuxCTR0MzsJ9HC2rZyUmeZyU/U4j9dnwuyFfN4HW
	WZLeVc5GfZrGOkP41oklzd4juYiZhFA8nVWnyi4O8m5S+gIE8o2+VdICZwKnng/GzMGyDIy6vnh
	TPjRPDcaSUsxtnt0WlgF/3sLZqz2ZbLhYS/dEOvq8X5TCvfL3BKT17+JIuCunpWJioGugsCjyFZ
	PVVS4irWC3RzoK3Yx/6rGLzmf7BjQguqrmQEkJ93vcDV9E9OEMOTN6lznsJJUUqYmUL3Ruyn2zC
	oRrkc06ix05nJ37g8HkRMpC8O8unICAlOkocXhlpYhDkAQeHOXEL8PXj37qbAqqbk4UbFhmuCA=
X-Received: by 2002:a05:620a:1b92:b0:932:db43:7286 with SMTP id af79cd13be357-936d2278f3amr670403785a.8.1786714515274;
        Fri, 14 Aug 2026 06:35:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce0b710bsm279542285a.20.2026.08.14.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:35:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Krzesimir Nowak <qdlacz@gmail.com>
Subject: [PATCH 1/2] libselinux: selinux_restorecon: fix error message on intermediate symlinks
Date: Fri, 14 Aug 2026 09:34:55 -0400
Message-ID: <20260814133456.203958-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selinux_restorecon(3) was changed by commit 67bc978bfaf9 ("libselinux:
restorecon: revisit pinning files to avoid TOCTOU issues") to avoid
following intermediate symlinks on the caller-supplied pathname unless
the SELINUX_RESTORECON_REALPATH flag was set in the restorecon_flags
parameter. However, because it calls openat(2) with both O_NOFOLLOW
and O_DIRECTORY, the errno was being set to ENOTDIR and a message was
logged with the pathname being "Not a directory" even if the terminal
node of the path was in fact a directory. Fix the error handling logic
and log message to correctly reflect the intermediate symlink-induced
failure.

Reported-by: Krzesimir Nowak <qdlacz@gmail.com>
Fixes: 67bc978bfaf9 ("libselinux: restorecon: revisit pinning files to avoid TOCTOU issues")
Fixes: https://github.com/SELinuxProject/selinux/issues/540
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 31 ++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 49b8ff7e..fbadf367 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1167,11 +1167,30 @@ static int safe_open(const char *path, struct stat *sb)
 				nfd = openat(dfd, cur,
 					     O_PATH | O_NOFOLLOW | O_DIRECTORY |
 						     O_CLOEXEC);
-				close(dfd);
 				if (nfd < 0) {
+					int err = errno;
+					struct stat st;
+
+					/*
+					 * O_NOFOLLOW | O_DIRECTORY on a
+					 * symlink yields ENOTDIR; report
+					 * ELOOP so the caller can tell an
+					 * unfollowed intermediate symlink
+					 * from a genuine non-directory, and
+					 * so the fallback matches openat2's
+					 * RESOLVE_NO_SYMLINKS.
+					 */
+					if (err == ENOTDIR &&
+					    fstatat(dfd, cur, &st,
+						    AT_SYMLINK_NOFOLLOW) == 0 &&
+					    S_ISLNK(st.st_mode))
+						err = ELOOP;
+					close(dfd);
 					free(copy);
+					errno = err;
 					return -1;
 				}
+				close(dfd);
 				dfd = nfd;
 				cur = next;
 				continue;
@@ -1680,8 +1699,14 @@ static int selinux_restorecon_common(const char *pathname_orig,
 			free(pathname);
 			return 0;
 		} else {
-			selinux_log(SELINUX_ERROR, "open(%s) failed: %m\n",
-				    pathname);
+			if (errno == ELOOP)
+				selinux_log(
+					SELINUX_ERROR,
+					"%s: an intermediate path component is a symbolic link (not followed)\n",
+					pathname);
+			else
+				selinux_log(SELINUX_ERROR,
+					    "open(%s) failed: %m\n", pathname);
 			error = -1;
 			goto cleanup;
 		}
-- 
2.55.0

