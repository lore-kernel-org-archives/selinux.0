Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3477F34
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="at7aU1H0"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42784b919b9so8737921cf.3
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197574; x=1703802374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ9n7fQDf2zh383LFpB4bBs6v9rl1NmY3dKO1sp36gA=;
        b=at7aU1H0VFcINOq9/y1RKp+njicAM9GSBJXNlmxOm0fXBXyz/cPaoQiGIPULQ4U6om
         +cY+UepGEF+nyYga3VApyC1OiEdvbpVHhEO1X7EEOGDKkciLg2BjJtNoPqB320QUkSOx
         5FBz1db+Tf6of+c+6kPHQDJ4jUPNMJNwTJJEkj/8DgpXNnP8KQXaHdhN0MZfPhOgOiyu
         44/2ENTCQYUkMr7NmZySbO02u9Cgs3zICbIRyjX2bWbqXkCEHHW8ig3Z8ujhGv/UA/+j
         /hZQLuIRxt4XGwGM5zZMBLkOtUqlJDwMObtusZ7c2zjwLiHjroa9xOTlkBzXsQSJjjoS
         yteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197574; x=1703802374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ9n7fQDf2zh383LFpB4bBs6v9rl1NmY3dKO1sp36gA=;
        b=FM8b7ut+56taYlKiPR25QoydNwyjcTwuapUFRqxwbnZRlLWmwdDbxX6idlBkBoKNgo
         qKx6mp54fkdK6L6X6nXxPgIAVHOh1E3rx9WUYCibiWyv+FwFHVSdEyKRt5TZI9USodEK
         cRqtVuptB9LwSYQXtFUVYF7FhsAlZHG4itdkfB5vYJLr6kVHHoToEpOTZuO+w1AKZ9zS
         WdbkLB0/dwftB6YwdTuQGVRS81Y/LwFDjwvlsqePGtxbvLPRffFYsbuOUgvXmpFf5oWA
         /M9oMdVhx+DXuDTnzZ375A1LRpcQ+LVS1uJcT/gF+8F/O66Qg+OhoyEWNa55+eD4x3Rc
         KQyw==
X-Gm-Message-State: AOJu0YxVXMDNy5i1oNSbWN+Ea1AKt7m+0HkbZTgGcAvv7MqjvbEqIwfA
	J+sJ5R9rRoJJJ89AKRRcRALDUPNg4yrb8P9LZK4pwHKnjQ==
X-Google-Smtp-Source: AGHT+IHcQLpluxeuT0cCGc7AWZIkEhdmeD0faJivuJtOdSJMKv9zFZR+iZfetcevK2biQzOClslVfg==
X-Received: by 2002:a05:622a:38f:b0:423:93aa:1426 with SMTP id j15-20020a05622a038f00b0042393aa1426mr577072qtx.48.1703197574481;
        Thu, 21 Dec 2023 14:26:14 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id cn10-20020a05622a248a00b00427a4875c14sm437868qtb.86.2023.12.21.14.26.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:14 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 15/15] selinux: fix style issues in security/selinux/include/initial_sid_to_string.h
Date: Thu, 21 Dec 2023 17:18:58 -0500
Message-ID: <20231221222342.334026-32-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; i=paul@paul-moore.com; h=from:subject; bh=vyjuCr1EGTUQ5ZVYKTUxFjQZ3JL14TyimPpxyp0rz7M=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLtsX/BhGdQ3Iwakqw9sVxvcLhNBgVSvjEUdw vVcdxtRemWJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7bAAKCRDqIPLalzeJ c5AUD/9jSdQ78xF4KOzHDbJfvMb5yxRF6hDMNK3KBxYe2T3MV6LleRFL6bh4Vhyku4VJbCs0iqW uVYYzdZHa6nEv2WJO4Rfv7Xb73HIcl9wCaBLdemeeBcwOLE8fp98c3RkNSE47zcaw1+qtSFcF74 ABeO47ieRjoyvH3AMQyPrWyoUIGfEVM9OGd5dqJjL6qiBnolRCAALeLmh8W/sPV6SxkJ51tje8q z9k+9Y4G730XDH2jEB1CUxMTkTG2AK4hjHxIV8pHNS6xmRHRTTkXR9pcsybBDlVXZoN9J9BiIJc LaKl3H+05ftLxNiMu9Q3AOVkuFl6N7/Hue4bYxPV9bdSiYWtteTYEpEHCfYK14Z0J8UsPGXn07c JXZBJKjk/QLio2BJV2g8KFsSgTWGV4cpfUVwk4/bAKXw9+AUiFwUohOWw71sA/8GffGp7b/9D0P xto8yTvwmiNQLs6oNL4l1FCv4luLKUV8VX6+CkDLEIZWo3byCVG8lSQEASglbwc//FoVjO2IyMI xx+rXxrADZ78jZbKceittrZ6W6l9hWlf+vA99D6y1llDfHqrv1B3Uvi4BgbOympjngzngVp63ca F/LNO5y+UHesmUwQO9m3V3gW5bLJFoGIVLqszZ31rnZXFuPVaQ12ZLQ6/worC8cQ+Xct0fqVoPG vRhdGSWD+bnpKqg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index 5e5f0993dac2..99b353b2abb4 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -3,33 +3,32 @@
 #include <linux/stddef.h>
 
 static const char *const initial_sid_to_string[] = {
-	NULL,
-	"kernel",
-	"security",
-	"unlabeled",
-	NULL,
-	"file",
-	NULL,
-	"init",
-	"any_socket",
-	"port",
-	"netif",
-	"netmsg",
-	"node",
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	"devnull",
+	NULL, /* zero placeholder, not used */
+	"kernel", /* kernel / SECINITSID_KERNEL */
+	"security", /* security / SECINITSID_SECURITY */
+	"unlabeled", /* unlabeled / SECINITSID_UNLABELED */
+	NULL, /* fs */
+	"file", /* file / SECINITSID_FILE */
+	NULL, /* file_labels */
+	"init", /* init / SECINITSID_INIT */
+	"any_socket", /* any_socket / SECINITSID_ANY_SOCKET */
+	"port", /* port / SECINITSID_PORT */
+	"netif", /* netif / SECINITSID_NETIF */
+	"netmsg", /* netmsg / SECINITSID_NETMSG */
+	"node", /* node / SECINITSID_NODE */
+	NULL, /* igmp_packet */
+	NULL, /* icmp_socket */
+	NULL, /* tcp_socket */
+	NULL, /* sysctl_modprobe */
+	NULL, /* sysctl */
+	NULL, /* sysctl_fs */
+	NULL, /* sysctl_kernel */
+	NULL, /* sysctl_net */
+	NULL, /* sysctl_net_unix */
+	NULL, /* sysctl_vm */
+	NULL, /* sysctl_dev */
+	NULL, /* kmod */
+	NULL, /* policy */
+	NULL, /* scmp_packet */
+	"devnull", /* devnull / SECINITSID_DEVNULL */
 };
-
-- 
2.43.0

