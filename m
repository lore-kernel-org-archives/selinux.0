Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D795A29
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753989550; cv=none; b=BMKLxoPXSw2LHI2pXqN0Vk6uHwGfR8ZuvzRgwZQzRF288cNCV30BgmZgkfOcl7AY5jWqT/GdAXS102GaUETXV+KpRnHoYzZXShD0/41QFQDY+v8t4wknE4IELrNpuBxmXtUAKvV/TMPpZRoJUsYKXMvtzpZyjjiih0RYvhqrVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753989550; c=relaxed/simple;
	bh=8bGFqUGCYiFJDJCqMt3ZMhEZw6v1dEA/OL120wzpSrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyC22CJvqKCTJHxMU9sOMo5FPxEBznkRqovzQjnMGhBQTqv36ytyQ5r1kBb3EqUSoMs3nGR+HWvFEhGJMlIrSfPyEIUeV4rt6HZy97w4EX2AoPkQpychD/KErsuXctkAUF9gdYeOrHDOPA2QhyRipnM2uilAEyjlWueC/wlmGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZb69ffg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZb69ffg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so13260405e9.3
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753989547; x=1754594347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK0weZGQhde0jEmRQ5ymFaVODx7gysG8RJlJTCxnQfE=;
        b=gZb69ffg69kZeuAmpSr4q8dsq7rcezjqu4rsusjfTNXgqZbkvUfIbMPlI7UvlQCugF
         ej9VhuuKsENDzDqKoeMGtBHAX8eCmzN94ifFrqmHLusGbEzhVf0g5fW8u4S9QQ+oyfah
         PlVtQ/nFwv3fIlIxJYegckuLFh1EFbvBPs6dvTTYopwkgGxamekgWyEXX1pHVV59Qswx
         lIqdBfNTprPYYBiNU1ZogFwX0K456es5a2x/Np+ZJw8buc7RKfnEnECogXUBuxg9vqgf
         R28RdsAKsB/YFtFwfyEYLZ8PqWbjRseXwdizNGGgWwPq4RWuSuJqYdkNR6+MkPzgaVp6
         eYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753989547; x=1754594347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BK0weZGQhde0jEmRQ5ymFaVODx7gysG8RJlJTCxnQfE=;
        b=SyuSJnXBRrrMWPy9ItoSwsPKY9MrCX40U/HeJFRD3dqv8s98BEVV5pLMOpGhtd0cbf
         1DjLI3Atine+QAL1A+HyvMrjwERqv35SBfgIwc717JoxT39Gf5uzXJwaUZWhPxUeNNdi
         hqXmIpoEKxRsycvWCMQde0lAygeYC4wEJDp9EhfmzjCRKHM+MAQ0SGMHuymcx7CS9P21
         /k9fLzI23mHJ6d/4i5ss88IvDGCYOkZD//sKJrJqrJk/WlmSUs0yoEtq1b7pu/mEBLBC
         aIZQyQ4MVhc9xbX6tk91OrfQSMGO0ZUqQx/68YsvGILSBtWT9rqQuepuP3qzYt+AcJrj
         pIqw==
X-Gm-Message-State: AOJu0Yxf/9FtfprmSbcQEw20K6bozFDGxX5taVM2Rk0WrpDW4xkgHx3F
	wo0sJxWkCkMSLtGU1LD0J1as0ulJ5Vz+hPfc9Asp0nAl+kBF46Hclp3u
X-Gm-Gg: ASbGncuOJmQCCTbMF7aec7XBCLY5byrOQhzZGHjjWPWIUdeM6PyylnPqMtcwk34dfC6
	JAk8ANRWK+ww2V05DKsEvK7XnYbj+MujOF4Xb1C4v1x0tW2KfgAK20YbDExqbyvWT4hj3pRQf3G
	+fYdE4WERGrs15j6Yd/qYIPgjar86HVpbfm6MtEaCWfHmBNj2TniH73qWifsptfHgZEKGtdXUr6
	ct9swP5AWKKGbBYI7MOYyiZ3IklRUeohlTK/eYm3GkDyF6rlaxIpwIGKhlx9XqJ37jKqyI78One
	LjHMFSTBVNAZhXEZmKNFd3XHXcogPamX1rz1joMMTOZNm3Lf14M7aPkt7ASkEKhHuJXUEpu5/Pr
	e+g03MQs1oMsJgP2do1TE+es=
X-Google-Smtp-Source: AGHT+IG3IxO5PHreSD9RGZXG+volZyKfMCUF+H7c2MIkAKbFYgvYpl9go3Qi4ricFYHugfh3bsEFLw==
X-Received: by 2002:a05:600c:6099:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-45892bc6d02mr81083415e9.19.1753989546569;
        Thu, 31 Jul 2025 12:19:06 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee4f0f8sm37303265e9.15.2025.07.31.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 12:19:06 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: nvraxn@gmail.com
Cc: selinux@vger.kernel.org
Subject: [PATCH v2] seunshare: fix the frail tmpdir cleanup
Date: Thu, 31 Jul 2025 20:18:59 +0100
Message-ID: <20250731191859.1091884-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731191252.1091439-1-nvraxn@gmail.com>
References: <20250731191252.1091439-1-nvraxn@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason, rm is invoked via system (3) to cleanup the runtime
temp directory.  This really isn't all that robust, *especially* given
that seunshare is supposed to be a security boundry.  Instead do this
using libc, the API designed to be used within C programs.

Also, don't bother trying to delete the contents of the tmpdir and then
trying to delete the parent directory with rmdir later - for some...
undocumented reason currently we attempt to delete the contents of the
dir with dropped perms, *then* elevate perms, *then* delete the tmpdir.

This doesn't really make all that much sense as far as I can tell.  We
should be the only ones using the tmpdir, so we may as well just delete
the entire thing using the rm_rf () function with elevated permissions.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 sandbox/seunshare.c | 70 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

v2: don't use else after return

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 97430535..a245384e 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -403,6 +403,59 @@ err:
 	return rc;
 }
 
+static bool rm_rf(int targetfd, const char *path) {
+	struct stat statbuf;
+
+	if (fstatat(targetfd, path, &statbuf, 0) < 0) {
+		if (errno == ENOENT) {
+			return true;
+		}
+		perror("fstatat");
+		return false;
+	}
+
+	if (S_ISDIR(statbuf.st_mode)) {
+		const int newfd = openat(targetfd, path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (newfd < 0) {
+			perror("openat");
+			return false;
+		}
+
+		DIR *dir = fdopendir(newfd);
+		if (!dir) {
+			perror("fdopendir");
+			close(newfd);
+			return false;
+		}
+
+		struct dirent *entry;
+		int rc = true;
+		while ((entry = readdir(dir)) != NULL) {
+			if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
+				continue;
+			}
+
+			if (rm_rf(dirfd(dir), entry->d_name) != 0) {
+				rc = false;
+			}
+		}
+
+		closedir(dir);
+
+		if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
+			perror("unlinkat");
+			rc = false;
+		}
+
+		return rc;
+	}
+	if (unlinkat(targetfd, path, 0) < 0) {
+		perror("unlinkat");
+		return false;
+	}
+	return true;
+}
+
 /**
  * Clean up runtime temporary directory.  Returns 0 if no problem was detected,
  * >0 if some error was detected, but errors here are treated as non-fatal and
@@ -428,24 +481,17 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		free(cmdbuf); cmdbuf = NULL;
 	}
 
-	/* remove files from the runtime temporary directory */
-	if (asprintf(&cmdbuf, "/bin/rm -r '%s/' 2>/dev/null", tmpdir) == -1) {
-		fprintf(stderr, _("Out of memory\n"));
-		cmdbuf = NULL;
+	if ((uid_t)setfsuid(0) != 0) {
+		/* setfsuid does not return error, but this check makes code checkers happy */
 		rc++;
 	}
-	/* this may fail if there's root-owned file left in the runtime tmpdir */
-	if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) != 0) rc++;
-	free(cmdbuf); cmdbuf = NULL;
 
-	/* remove runtime temporary directory */
-	if ((uid_t)setfsuid(0) != 0) {
-		/* setfsuid does not return error, but this check makes code checkers happy */
+	/* Recursively remove the runtime temp directory.  */
+	if (!rm_rf(AT_FDCWD, tmpdir)) {
+		fprintf(stderr, _("Failed to recursively remove directory %s\n"), tmpdir);
 		rc++;
 	}
 
-	if (pwd->pw_uid != 0 && rmdir(tmpdir) == -1)
-		fprintf(stderr, _("Failed to remove directory %s: %s\n"), tmpdir, strerror(errno));
 	if ((uid_t)setfsuid(pwd->pw_uid) != 0) {
 		fprintf(stderr, _("unable to switch back to user after clearing tmp dir\n"));
 		rc++;
-- 
2.50.1

