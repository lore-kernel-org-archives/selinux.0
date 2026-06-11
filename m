Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272D408627
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187088; cv=none; b=pV1fpEiY7q5A6wly7XvylUsP/NJRAN4IH+rt8SevwWtblbcImI5rIqcoS6nJZ0xw9wts9gub2oF+J3lBLWL+wqakdDbt9hMgGylWri5++LcatYDf1wWTxg/QnXTjvGQ8AJyeYQOwOUfvtL1QuHpQFJvKi7apxtNtX/2Q0Kl9m90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187088; c=relaxed/simple;
	bh=tyyZTtgtMensv5yfz5/z2QK0pJ0OFf/Wd0uhFziNSIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcXd14BL6+5AcoT7DyOtcIUNmnZ+ZjgBINaagfqzlV6Mte2UtUndkKNwu1c5u/wX8fQYxYzzffm1qaU6Z6/ryZyhTuU4PREfVndxRYNXqY3g+i3bbxDbtdTnMQzrOmNfXGYA+/nxFDsl+/0UyMxcNf/uaC9cTPqA7L60/W2H/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtXnTcsI; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtXnTcsI"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517dc520840so23098701cf.3
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781187086; x=1781791886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4L0jUpsmYtg9dUpxVbKcdgEf14yEqW3MQHsIYNv4rs8=;
        b=BtXnTcsIpY0j77QAuHiHLTOigXgFxw24FutrUeCUWJT8MHVKrpuZ+3nmTo42XvVj2K
         Tm5RKPBxDhY+xN4wYTeF9eStGV6P3AiRuHDzEpxlbUhwpUu/JJIUq6/LDODfg88Lyy3X
         7Xfr3y1N3kVLmgz6EOk2ZoGnXu1slT7KGXEC1DUtU6RliuSESakJJdZ2+Nwc5ieMci19
         gIoceiUI2fQg8+4F6AnBYBr5jemMKfKecxmT3a9a+53AfLGpJ8PYV7NQchRwhVVMa1gS
         1R2K0PQaIbY15P81YTgE7ksWjQyjRuRLKsiZqZQ9V/Qj0PSZaFOgP6+wPWpocxHK/8q3
         z7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187086; x=1781791886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4L0jUpsmYtg9dUpxVbKcdgEf14yEqW3MQHsIYNv4rs8=;
        b=ilSOmZ1SS7TfJkmS+7SrSmJsWNqnomGqh23jUjkpMrlWftbnU9jlePRDs5TJWIlrHL
         pIaQQ708dkv+e9fSHbVd4wcSwHhJRcAQjct3xNS0QQHwn7ZdJMqRkZDZCBvnnvpUlnVP
         r5amr+2+dtDfGfnoqaRDRuRuaiEjAvhW19zxYB5Rgbs1dF1xKIJLff+Yjw6pC+QdLlht
         RCMq7B0aOnYthCAlkMV4OisbtsvXzM9LoRpJm6+P0MogXvhFse9GRWs+Nie8mrMelU1E
         PNGzYFZbxD0/v1e0nF6QkepxJtvXehKotGwiLbRAnT6k6Sow53MuZxXwVF2qCuWrPW51
         62Jg==
X-Gm-Message-State: AOJu0YwGgdj12lFg0rTDDTlWLSHfo+46PsCNPvYxsETqXgol3l7Ups4P
	uRNZwKfwZzEPyZs+Glow0k0A2Dtz2GrrEyIQnrvLn9hSc2lnCudXEJUpVTZ4zQ==
X-Gm-Gg: Acq92OGsBimLdp2YmvJHsc2DawtQ1p/zc31kEzLj12ka8GLnZkLjA/yVHNZIt24puK6
	oakkj+AUuwAbZMIpAqsoWJ3nW9Ts1sygFS9lbo+P11utxX9ADGRck61EhGfTGAwSbjFRNpbed1P
	snavtxt1WjjfPpaV5utGmniysUhLI7d50pne5ta7Al0HVBPBqYXpbcumkIUzhBTw7XqnRHJX4SQ
	N9Idmc0vMnDf1CrWIuN0pQ10JPuu/Dge3nfihIl5G29ceL+8MIHzg7rl97Z2TQJsO11dIubRocG
	42vMBtn/vN1uQp/mJym3DM7hVAh08Fd0L0oeyMTiitbKitpbn1hFhbAgMn7gVZ46/jFjqggyYUZ
	HsJEUiqKE7AB0cQs/J9PYitT5enuZskfcczpdortJqz4UeMM/1jsUD0X4lZH1heJh1mrql408rr
	pAjWhPIQBz+EwZHRr+Mrvu9V8AB4jnE93oHv6Gp2Zo8HrUQbu2DsYSMhYk1HuLhNxA732QRf5K3
	TQNSOV+wMLWx8vdOzXYB0g1vUbZT5I/L90cBQ==
X-Received: by 2002:a05:622a:2616:b0:50f:b904:454 with SMTP id d75a77b69052e-517ede3fc7fmr45734391cf.11.1781187085957;
        Thu, 11 Jun 2026 07:11:25 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef620e44sm17844061cf.22.2026.06.11.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:11:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 2/3] restorecond: use openat2 if defined
Date: Thu, 11 Jun 2026 10:11:00 -0400
Message-ID: <20260611141102.17893-3-stephen.smalley.work@gmail.com>
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

Update restorecond's safe_open() helper to use openat2() if defined to
optimize the lookup of the initial pathname. Fall back to the existing
per-component lookup on ENOSYS/EINVAL so that pre-5.6 and
seccomp-filtered environments are unaffected.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/watch.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 25918fd5..18bd90db 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -12,6 +12,10 @@
 #include <glob.h>
 #include <libgen.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
+#ifdef __NR_openat2
+#include <linux/openat2.h>
+#endif
 #include <string.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -72,6 +76,25 @@ static int safe_open(const char *path, struct stat *sb)
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

