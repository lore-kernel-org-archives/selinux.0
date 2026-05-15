Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E7648B388
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858100; cv=none; b=aRCuorowRf5Sa5tZFQgiD0FP8wVYEPOCiku73M4a3eFNxSpxdTTzHtLzgwNHn1laKgMgOlP3nRB/zjxH1/eloqC+1sMLLtDuLmXwQQZXJf0DNg8coJ2247DXumK5iXnp9q3bjSLdi1cMFgTmhkwwAQBXFj7rfl1bx2JZNV33yr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858100; c=relaxed/simple;
	bh=ZpmDuCf03PSBT/3PkymVtJX66+tLxItweh0OEmkSFIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCyOfeL5lu9Oi/Ru+x9+jBiuVLCri43uKRwqIevM9G4//Po3EfdYITTC9LONTTOYozcWmX+tbZgGOmv2OvE6eZEryTDnRcBnxWoCmXWon2viVHvX5FI8jw3vZf5TBlIcbNQ2S0ZdyGXNk4AUxfxqeuwvkRkbdmZa1jJ7E1wOuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTwHHN6d; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTwHHN6d"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-514ae601e01so62174521cf.1
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778858098; x=1779462898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BH9sMlgGSpUPGRchhZu4gv47jfSCaLFyezW6elBn3/M=;
        b=hTwHHN6dC1MADPjtakywuqRbY5AUCN6rILbGWQ4eBjoudEj3kJizcqRXZNlLSo1szF
         aRp7d6dYDiAr2RUcyEegVK8IYFLvWIclYIetNRPKBxsA9OH1mfzWvidA+8WoCF4Lbe8H
         MS1QXdItcdi2WQGgku64vUBshTE62l2P2Etk75zNJw3cGPzZ0OF/iPdrMmregeutTe/c
         k5euONsMXeIov8ZKIRF0xG4NVJKcZlQcSDYIVFTuXFHwSfVo08fajWY6bFlhQ1z+L2Zf
         lbMNW5PlWV03Rb2GbB/LAJ29Nntqr6+m/++Z6rjaB8uwlD69rZou3QqB2WKYmBD6RsGH
         jH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858098; x=1779462898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BH9sMlgGSpUPGRchhZu4gv47jfSCaLFyezW6elBn3/M=;
        b=qJWR+/wAz0Oz2EYnKjAsIrI8AxN1hLa1p54OYP8pxU+UXIe8HRB3bcSiHWsdpWMyDD
         SkFWM0AzPuLk4yIfgn6ax2JgoF2jjBLVKodZj6q96ZjI+LOv3Xw1VxDEH4YxrHpc5Rcj
         7rA+DaN5JjtObWArbLJS+XGb9Drusoy+BA7OV3j7olr0/4/jVMd2APfcScobTmG9QRjm
         I4WYOm+aq92iIkcAdqR5M+UFVzOJsGJ7QG+k3xo4CNCtJ6Qv4NnMrh32bn9Ee7IEX05R
         +mQUJSu5uqQevo1nZF5Z/CxKUhheEFmLQOcwoMJoG0B9FwRwGJYYagQW4tKNSAlMu13J
         z+4A==
X-Gm-Message-State: AOJu0Yz7SVeQm7ux1TJ6l8ehLbsdg0f9Ozo0TEaHP4zzzgDaaUhFd9rb
	2U9pnLM5NvHJzH8NmSdNx3y4Z3u464qPxi+XKvd7IOu2d1FBu+Xld5WaZMXAZg==
X-Gm-Gg: Acq92OGzxUEUBkAyjOVkyup+UXIr7mb1Lg6QCC6Ld7cfdXQcd92D0aahjzPuNvWp8Ys
	D54727jctedlzMLPiUk8d9WFl9k+5EUIaozGdvzG4V8SBmCcAtP1CoS2zk5+j86SGuT0+b5XNWk
	Pi1rxSplBiHwCGLWkOBadOu8bot7KMHDfrhObLPi8SJPH2snZSPaQ22HoibjhidsYV7S75KOj8H
	j/+dQlr4q34sWTMawbkNU/X+9HET1UymWR6MGA+JpEGR0lO9ZBRlS5jfXcRH3bO3hVJHTgKtQgB
	Ej9Pon8XmeAM8Q9lZGaRIZrCDPaNDEyZG3FGIcMx0/owoBP2K6AQ7j948pCISGKA9ug3YxJQ3wc
	Nx7mW1nBUKfL6onj3qZI8TcYJPt4LdZnyihZ60m6AYeGSVqm2WuHHmtXxGuYT3TbV1NLFjL7ct/
	B0RkV1Km/8jm7FI1k38llF/oJ02XxT0nHLY495nTcw8AnehY6M93aA2sgTm4jOCnnJvj/PY/6ov
	gREXwSdRbkzTRpVT6BnevhqDec=
X-Received: by 2002:ac8:5944:0:b0:50b:2876:586 with SMTP id d75a77b69052e-51659fd9c26mr57877621cf.5.1778858097922;
        Fri, 15 May 2026 08:14:57 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51657269ebfsm31416871cf.0.2026.05.15.08.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:14:57 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: check owner in seunshare_mount_file()
Date: Fri, 15 May 2026 11:14:39 -0400
Message-ID: <20260515151439.66307-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently apply an owner check on directories prior to
calling seunshare_mount() on them. Do the same for
seunshare_mount_file(), but this has to be done inside
of the function since we do not open the source and
destination files until then.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 0e5107e4..1fc9b3db 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -296,11 +296,12 @@ static int seunshare_mount(const char *src, int src_fd,
  * a file named @dst_name in directory @dst_dirfd, creating @dst_name
  * if it doesn't already exist.
  */
-static int seunshare_mount_file(int src_dirfd, const char *src_name,
+static int seunshare_mount_file(uid_t uid, int src_dirfd, const char *src_name,
 				int dst_dirfd, const char *dst_name)
 {
 	char srcprocfd[32], dstprocfd[32];
 	int src_fd = -1, dst_fd = -1, rc = -1;
+	struct stat sb;
 
 	if (verbose)
 		printf(_("Mounting %s on %s\n"), src_name, dst_name);
@@ -311,6 +312,14 @@ static int seunshare_mount_file(int src_dirfd, const char *src_name,
 		goto out;
 	}
 
+	if (fstat(src_fd, &sb) < 0) {
+		fprintf(stderr, _("Failed to stat %s: %m\n"), src_name);
+		goto out;
+
+	}
+	if (check_owner_uid(uid, src_name, &sb))
+		goto out;
+
 	dst_fd = openat(dst_dirfd, dst_name, O_PATH | O_NOFOLLOW | O_CLOEXEC);
 	if (dst_fd < 0 && errno == ENOENT)
 		dst_fd = openat(dst_dirfd, dst_name,
@@ -321,6 +330,14 @@ static int seunshare_mount_file(int src_dirfd, const char *src_name,
 		goto out;
 	}
 
+	if (fstat(dst_fd, &sb) < 0) {
+		fprintf(stderr, _("Failed to stat %s: %m\n"), dst_name);
+		goto out;
+
+	}
+	if (check_owner_uid(uid, dst_name, &sb))
+		goto out;
+
 	snprintf(srcprocfd, sizeof(srcprocfd), "/proc/self/fd/%d", src_fd);
 	snprintf(dstprocfd, sizeof(dstprocfd), "/proc/self/fd/%d", dst_fd);
 
@@ -1080,14 +1097,14 @@ int main(int argc, char **argv) {
 
 		if (runuserdir_s && (wayland_display || pipewire_socket)) {
 			if (wayland_display &&
-			    seunshare_mount_file(fd_runtime_dir,
+				seunshare_mount_file(uid, fd_runtime_dir,
 					    wayland_display,
 					    fd_runuserdir_s,
 					    wayland_display) == -1)
 					goto childerr;
 
 			if (pipewire_socket &&
-			    seunshare_mount_file(fd_runtime_dir,
+				seunshare_mount_file(uid, fd_runtime_dir,
 					    "pipewire-0",
 					    fd_runuserdir_s,
 					    pipewire_socket) == -1)
-- 
2.53.0

