Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037C1D149
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JfT661s5"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2331e7058aso403048066b.2
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002220; x=1703607020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLHxr4+k/B+HgYe4zAioi/ys6kENMAzYaMpw+VYSu0U=;
        b=JfT661s5Ojz7cyLfwxju2roT/JLvIhqczA9optBH2QQxN9ANUWXXtlMjZB8EQnP1ng
         /cAX2biV/RbHkmvdFPsBNYCvQgePWo/MSBxd96+8Ju9boCcOWD6+tcCJoo/86s+6ss+n
         6Lq8BmUayg1k2QDFZeyAayDKDjQvVajj2QN9VJTvC8AqSWX+dYQ5RNNPtE2p+Y8/dX/F
         uLTxtl4o80Dcf6Zdy/7HDo7s/LA738uooGzAzniOWkaEXLu2JrLdC1YoafcaDv75bhv2
         8eM8j+xU/O2adV2JZ4v4cnys1NwBe4jy7agFxjZPKmMqfb94TG2K/4ZRGSy0Cw7uSqKq
         Nr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002220; x=1703607020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLHxr4+k/B+HgYe4zAioi/ys6kENMAzYaMpw+VYSu0U=;
        b=OFL7iqbiSr9KzFmDeghMWFJM5Dm4/IWYdWg5NmuT0GV977bCzARLLQ3RFfdJyEmFCl
         Jvl7KgE/pSDqFFLvt7n9ofqu1JVMzlqsELl7e1FxDYw4vEhyWvUB1P9mrWcI5sMIPLKY
         DcvyimBWKY3KqRwSpqXJX6LwQ3Agn4+cCHdjDuRSzGfXw9dOOQfYg7BA0awyB+U47hoD
         Bm420w8PX+B2DiVEbvPKt8gR9xk66nRcBOJuPz3eJo3tpY709LEQkJk9cKH+ywZy94FY
         LhANavz76edmx+4KRkvwhTOs0R+asrwQH57g26j4gl5V/6/MN/VIdVew0BKs70LBZxoK
         ehJw==
X-Gm-Message-State: AOJu0Yy07PjQFK8l90/QV1PYUEw4j88bxc294rmgw+xFJvnE5woSZXqk
	MhgZpR2YbQ8yHBVxtzzMDIIFw7aKbzc=
X-Google-Smtp-Source: AGHT+IGfnJ+R+jaDJG+sHnSQ0YNKZlo9Lnd9VpWx0jjejJR1NTp6KO8Cg2vhlRyEU9jaWBLXvNM/VA==
X-Received: by 2002:a17:906:e8e:b0:a23:5599:2a20 with SMTP id p14-20020a1709060e8e00b00a2355992a20mr858840ejf.85.1703002219906;
        Tue, 19 Dec 2023 08:10:19 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:19 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 11/11] setfiles: avoid unsigned integer underflow
Date: Tue, 19 Dec 2023 17:09:33 +0100
Message-ID: <20231219160943.334370-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While well-defined unsigned integer underflow might signal a logic
mistake or processing of unchecked user input.  Please Clang's undefined
behavior sanitizer:

    restore.c:91:37: runtime error: unsigned integer overflow: 1 - 2 cannot be represented in type 'unsigned long'

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/setfiles/restore.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 6131f46a..d045e948 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -77,8 +77,8 @@ int process_glob(char *name, struct restore_opts *opts, size_t nthreads,
 		 long unsigned *skipped_errors)
 {
 	glob_t globbuf;
-	size_t i = 0;
-	int len, rc, errors;
+	size_t i, len;
+	int rc, errors;
 
 	memset(&globbuf, 0, sizeof(globbuf));
 
@@ -88,10 +88,10 @@ int process_glob(char *name, struct restore_opts *opts, size_t nthreads,
 		return errors;
 
 	for (i = 0; i < globbuf.gl_pathc; i++) {
-		len = strlen(globbuf.gl_pathv[i]) - 2;
-		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len--], "/.") == 0)
+		len = strlen(globbuf.gl_pathv[i]);
+		if (len > 2 && strcmp(&globbuf.gl_pathv[i][len - 2], "/.") == 0)
 			continue;
-		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
+		if (len > 3 && strcmp(&globbuf.gl_pathv[i][len - 3], "/..") == 0)
 			continue;
 		rc = selinux_restorecon_parallel(globbuf.gl_pathv[i],
 						 opts->restorecon_flags,
-- 
2.43.0

