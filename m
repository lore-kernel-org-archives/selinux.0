Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD00376BD9
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348664; cv=none; b=RgSXH4pGrPM4iPJVOz/pdMA8a1dN9BTMAZXwKX6Y2L4StC1Nvb4IZDFpGYuvGcKj2x0/O4xT0XE0Xa9Y0qtVAiL4Qo8hgg2QOBWXP5qLdb1oXFwel+Zd0mNpTR0R49SGOyWxnVcQTMfDJJtDDbFFd1oG+joDdy+BessoAw99Xco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348664; c=relaxed/simple;
	bh=/nxzBH/jSfckHT+UQRjN84C6XmANvb8UttzNX4nMYMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKMwqrxCDbzk63xZ9/Uk5H7QnprVBCKSkGyeN2kUQwx+JitxzVQXcG5G5tXCuSNrQMODu41U+6MNiW8RF1bQ0usR1Agx+JWjjICdH7RB+Ky+uNm2kB0T2EcTMEGi4e15yNuWzXn4goyz0hVvdABfBRSQhEEITdio5lJNTKzM0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnnDd0cp; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnnDd0cp"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so21879096d6.1
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348662; x=1783953462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vC/af/SjIvFIjUYpWI7aCdo0npLXGjhTNUInme3lDcE=;
        b=WnnDd0cpV50W8ILrafXgvLCa7Pr/rZ6VCbr3ZnO9x+Nlu2DW7Qp1pFr2qQ8/rGbaa0
         8iEG5jbCXk9lIgp4V9WInVPUCVXl4rPhnJVWIyZohZxruIRn9AXpzWe/G7v1MVLhJ7lG
         pjRq5KAUvimUQ1O98UvH5cgiBRL75L4uPpWcX326/zjY1hg2WaMYX5tZA3qOQfWAoppV
         m+jrUiTDzrWxEBYC9YS6lrBYXlhQKXqgz9IGnGRmEQ3wJ3buTkTJhHb3mrQ0pFnajNl4
         ah3q+By1BA5nrXnm9iv1YQAV7JsGHHQulWDO9R05wub6/7XWvZC67HSYOGqiWSZgcRX7
         p2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348662; x=1783953462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vC/af/SjIvFIjUYpWI7aCdo0npLXGjhTNUInme3lDcE=;
        b=qnZmaJKBefB0mKgjKf1Y0tSmxBiyI5kQGrVO14k9MMfdyZVqCmxTLrY8srwdLaniPz
         5j7gwB7cUqDRe8F9JX2gX5eOXCAyIxEov+RsOB1EGgCqYgqbbHsxky8KGc893PXBWwN6
         GyP1NJT5FXhXd+wOafYUNM10+3Xf26qySv/mzb03v52oE5/BUgu1tbB7DApDWPxV9UYk
         B47LEneMR9uy1OTBjN4mcOvbteh3Nn48R+1j1FadQ+YpXmnN0S+WxilzsYGN6YxVmGIv
         wRY4vXB5yNCNNoLsna0xVYbQtZiEywu9m4lM097Zv5jaUraKTb7Dkt5zjce89Kfz6jkv
         JULA==
X-Gm-Message-State: AOJu0YwapV3YF8dDjSfjTDRM0syjVmG5cKWVp2/bwSPjU+K3Kfdr/NGA
	1Ossx7Mf9hfoWNbSNXmIqerfJ9iEPKzxGFEJkioQ9IDHIAlYz/Pt6At+Qh4kdA==
X-Gm-Gg: AfdE7cn0RJ2fvz/h53Vb5mHqfCurkkR6EsU9Oa72TK71UQPVDN8+3q5exdKUF4mc/Wo
	aTE8A1iD0buOxFLx0rnqgzyCzP33rNErWHfm7CS+rV1dbvLXn3tPm45UQcVCJzctr0+x5dFhAyV
	UASvH72qESRsQFIQhtYSQBu6KsEhz4qrY6/Oo3FLL44VJqGloMEOpWFgJkq9fZKCe2tYpn+wjN+
	ByncHLP1351uYvMGdBrc3yAzvQWReGWhvynEzG6WL+Lz/AbI7tr4av8unS/1v4KjBCVkVu3MHPI
	eGmNzPW+SFUgPun7NoKggXM6AiIF0ZjJayvlmG6gL+K2EwlIvHyRXbVO6C2rA9iAqeS0MKwn1+E
	hsXbU+UKC7SLq2N87xAlADTYQbVtipKZMAlHXqrK2jmSpJrhC6g+gUuXXsU6p7i0/ZGfkMT6/8I
	6ld4Kcw3wwFsCWSJbZBC5zQEIJTKOjSVTxMoZQ4qIyFV+k96R4T/LV9ar6pUnteba9JOmllvjuf
	9L0X7zHy0KMttjAOvQlwdfOW0M=
X-Received: by 2002:a05:6214:5704:b0:8e9:f62b:8f90 with SMTP id 6a1803df08f44-8fcb51e3fafmr8493806d6.54.1783348661957;
        Mon, 06 Jul 2026 07:37:41 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f304533sm136972416d6.18.2026.07.06.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:37:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/3] libselinux: selinux_restorecon: use openat2 if defined
Date: Mon,  6 Jul 2026 10:37:24 -0400
Message-ID: <20260706143726.47421-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706143726.47421-1-stephen.smalley.work@gmail.com>
References: <20260706143726.47421-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update selinux_restorecon()'s safe_open() helper to use openat2()
if defined to optimize the lookup of the initial pathname. Fall
back to the existing per-component lookup on ENOSYS/EINVAL so
that pre-5.6 and seccomp-filtered environments are unaffected.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index b34d8e60..30f1b836 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -25,7 +25,11 @@
 #include <sys/vfs.h>
 #include <sys/statvfs.h>
 #include <sys/utsname.h>
+#include <sys/syscall.h>
 #include <linux/magic.h>
+#ifdef __NR_openat2
+#include <linux/openat2.h>
+#endif
 #include <libgen.h>
 #include <syslog.h>
 #include <assert.h>
@@ -1114,6 +1118,25 @@ static int safe_open(const char *path, struct stat *sb)
 		return -1;
 	}
 
+#ifdef __NR_openat2
+	struct open_how how = {
+		.flags = O_PATH | O_NOFOLLOW | O_CLOEXEC,
+		.resolve = RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLINKS,
+	};
+
+	nfd = syscall(__NR_openat2, AT_FDCWD, path, &how, sizeof(how));
+	if (nfd >= 0) {
+		if (fstat(nfd, sb) < 0) {
+			close(nfd);
+			return -1;
+		}
+		return nfd;
+	}
+
+	if (errno != ENOSYS && errno != EINVAL)
+		return -1;
+#endif
+
 	copy = strdup(path);
 	if (!copy)
 		return -1;
-- 
2.54.0

