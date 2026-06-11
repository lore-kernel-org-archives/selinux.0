Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C863FF8A3
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187089; cv=none; b=nKBqY7bnL6uNAtiH541oh165KTDJOO5xVZACeaC7kNtUzNa7w6VseHCZ/cPcUpFdrC63qeKyn7pfqyeoCZwcNlCxOORtfKKpFf9NPhfWV1tepLmPH8pWB1UkeG9GJvAJsqYmPTPkgmLr0e3Fs5e3apCZQZIexDGmuS/pFRVT7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187089; c=relaxed/simple;
	bh=AUofH0ZI5WyZd+ANpfN8qf7FJGOwr0WDVZOKT0kZsM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1Yk7Z7zd5lSSVCqE2z/JXPeZNYoBRc9TP/yoMrDh9kGDc2eWswR5TrFYZqGURBNbpKoYDTRLI3td4stCM+UEYxTdCoYAEk6pxc1S91To+9h3x4+umhrukkybIPmHrX/9Ol8FI5x0DcTcKlA/voW6pHZbaOgsRk00eSyTydKxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDcJ/q1i; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDcJ/q1i"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5177b1a7441so110369791cf.3
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781187087; x=1781791887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9V9t/jTrtysf8N1w7xdxgaeata57qvvM6uw4DUzfzY=;
        b=LDcJ/q1iPgrL1YzVFqAUqlRfCa/J7ZL4ZuT7b/OrmQRnccvywQun1xCa71hx3S61Ev
         EoEt1SEVFTTUCYO5QD8A7XBoWqeWluHrtO1XFHmwS/5/FrgqEld9TGeC5GSax9qJD/3U
         QHIiqNTn++trrUSPnQEC0+HNQ1jI+IMDqZeNrG9GuZNhsm06zSgpsQO7taFqCyAPN4+P
         wJyPuvSwyOQXRhedxNXjU6selHdLxjr8s579XQtKLrKfmzeok10YuTmvgAaByRLdG2YR
         /XMwuNjMA2NZa2ADMKPA25x5aM63lqwkTWfnUTFFoXU/2tmOE95occeZzw8EmMbdFxHW
         clgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187087; x=1781791887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9V9t/jTrtysf8N1w7xdxgaeata57qvvM6uw4DUzfzY=;
        b=j9+60j4caOrtdPr1Gg1cl/m0K1c4llsThWamalBVZgF0OMYaPgqNEKZCLWaO6idYMy
         L67UM+uUjrzBauIkrNboPk82LkkZDciwA106NRXoGwgZWfLIcD/EYUeDQ5KiPmskvLQv
         vClyzFgE6MPmAFE9bbngncFZXCAS8mf7R5iqyF/OnBR1NCJEY5y8RNoyWggCFGVg9WJn
         3p/gqtr2S7B+byoA+fuBh8Zrmr5G5ihgSmz7rGQzPMMFfN9/uAlFmtvrbC2xXrUJY/Ba
         qA+736I8/g38i2YQLZ66tQctxAO2orCAuq/m/nmCvhpTBpnqkTXawXZ/ZL4mH5SqR6hZ
         q/kA==
X-Gm-Message-State: AOJu0YzvZ1eFn9qXF18tWJTDQRI/ofQSTGf3+zElFJYSOBqJZErlIEfo
	HvPE/chPVH+2enzRr1CxQoKUyHVpyaJOdLuHl6Jmvh9YJD5O5EEx3XdnNuhdDg==
X-Gm-Gg: Acq92OE/1aai8V3GcyGGbif2b6AMhjTiNKjAHYd+B8HX7+FlDGzdBh7XhzzCADXtrn6
	T9kuO6hPQO/CZlqxfKYL2MGHkh54qxKob/dqeGl23ure/Rupr5j2ghQEY5pzSspp7hqemYc004D
	pJCVf5q5N7GI94wQyalKVGg/sh3Q6Pj1bBz8uHvyu5U6GMshEqfA84KFGwbG/tNd8fyH34G7oyj
	jthFHg+8MHvPUPgZ1GTI0LTSXKvhybxEClGAKQJKtuwa4LvTsH0RvOfStBO3CSA42D7jK82Uqhy
	hmrZMaygGaNx9K8tz5rrgvLM0v769TNiLY84BppXtPDWRokKqvTYeNYjWLyfv9z7VatHtJYGwkc
	33iw+0a3Ia1I4oSUvb958nQ2O2Wadm/ljE4OCIDCr27R4hMN/k+ujz68VW5O4YanYNmv9jpen3M
	o9lwIfqgAql5Blm7R6v6IdS5m9XUrkBHJYMcrcR0Y7yhN+XzdEMjzV6FNJH1W7Rdr9SbUECTN47
	+2J3zLugaz9sCSjT6UHxFo0CtJsBjwEbpnFylWnmImzL+UY
X-Received: by 2002:a05:622a:428a:b0:517:79f0:ae34 with SMTP id d75a77b69052e-517ede80969mr47759701cf.20.1781187086828;
        Thu, 11 Jun 2026 07:11:26 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef620e44sm17844061cf.22.2026.06.11.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:11:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 3/3] sandbox/seunshare: pin_dir: use openat2 if available
Date: Thu, 11 Jun 2026 10:11:01 -0400
Message-ID: <20260611141102.17893-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611141102.17893-1-stephen.smalley.work@gmail.com>
References: <20260611141102.17893-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update seunshare's pin_dir() helper to use openat2() if defined to
optimize the lookup of the directory and prevent following any
intermediate symlinks. Fall back to the existing open() on
ENOSYS/EINVAL so that pre-5.6 and seccomp-filtered environments are
unaffected.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 58baa7ff..829c6289 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -10,8 +10,12 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/syscall.h>
 #include <syslog.h>
 #include <sys/mount.h>
+#ifdef __NR_openat2
+#include <linux/openat2.h>
+#endif
 #include <glob.h>
 #include <pwd.h>
 #include <sched.h>
@@ -219,10 +223,19 @@ static int check_owner_gid(gid_t gid, const char *file, struct stat *st)
  */
 static int pin_dir(const char *dir, struct stat *st_out)
 {
-	int fd;
+	int fd = -1;
 	struct stat sb;
 
-	fd = open(dir, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
+#ifdef __NR_openat2
+	struct open_how how = {
+		.flags = O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC,
+		.resolve = RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLINKS,
+	};
+
+	fd = syscall(__NR_openat2, AT_FDCWD, dir, &how, sizeof(how));
+	if (fd < 0 && (errno == ENOSYS || errno == EINVAL))
+#endif
+		fd = open(dir, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
 	if (fd < 0) {
 		fprintf(stderr, _("Failed to open %s: %m\n"), dir);
 		return -1;
-- 
2.54.0

