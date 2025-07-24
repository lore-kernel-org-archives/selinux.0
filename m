Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D32DE709
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365112; cv=none; b=qBlYKXjLRnczAgowgkn8tmbL50xBXlg/9+dI6uR75tCkzaYxSQR2bIyyA60+5UeB+NMgM4wtjdu3SYh+Ge/ChkW0PC/1Z5Fl8hkkhIouaxDQiuYkpBoQeDkN75v8SA2NI6GihKrBVxgfSoJ9+7VZVhe0DBcvHTsHGoqOnQU6lM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365112; c=relaxed/simple;
	bh=FdZezLFnz8PmpMmmjEHUkQRD5b6v+lj0vP5c5HWMd+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNrxn1fMfyVz9RMX5w+5Bhv6nO4ZIa3h3vezycRrRAv9sjrVUUQubO7QOlOWoadu6BV8x3iIdjU1HutxVW9YPww9T6kICIL23gsCPtbpFcxYTSNMtOjADsWs/2xpeYyeATaiQHzaGGH2L8d0cxN25wkhAjD35lBLAUmWfzwzTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYEhvFp5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYEhvFp5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45610582d07so7080955e9.0
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753365109; x=1753969909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhZsL7LbPk/0slhDJGLmKcbXMQp/7JrfB4vJitQnBIo=;
        b=TYEhvFp5LpCdriDCpu0IrBZShkDFTcoiKFCmpsiLdU37n+Db3sIM7cdHWGSr/Py6dp
         xhVVpPQspoph258bMXFANDPIg6vEgWjR6Jbrv+nRIOnEcyukxX4gg6//Yi+yFOvg7f4S
         51PMBK03eRggTSF6e9Jbv2VIVngR7NXiyPZAR44MNNpmu32xofasBVJy0rW7RDa58507
         8FliUmD8+xOszoormOiTFIU0KtowgEZCNPkfzc+g2PKy87SDbpUvKBC3gnYfKYlXvR8b
         PXEmd/vj8+aiLfhj1pW3V3QITRTIMm0IERQEVZSbQwFOTnp2II24tOuhqqdhkNAiMWCc
         1yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365109; x=1753969909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhZsL7LbPk/0slhDJGLmKcbXMQp/7JrfB4vJitQnBIo=;
        b=fvOrn+msdK0iCG/0dOfAza4FQrCFnQYccc25RoypDAwbdmztZTaC8ogajrfnDEw15u
         0B71qXdEztjSZTwqhWA1AG0j97n5UDs52rg43vCFwdYEMlNJL1TkKfp1b6W5xZkBZL+V
         G1B/N+auKpePkCyIIAMq3b75I0K4Xiq2vxplvuShgKpHbhlS2FzDI6zUOWZL27gUACBp
         uPIoDWNPVPdbOLgFvBgaBxw1jhAzu9q1SJTNZEcmdfYLZ3lz3PQbmOqpz4pfoSqj/Gwg
         vSRiOyjyJd97q5F8U44k1KPy+dRaHRnJPTYuHjoTzC8d25qqc4ozTc++oGlU15XP1zvH
         IdNA==
X-Forwarded-Encrypted: i=1; AJvYcCUaZkFGT9Krsm66h/NVZ0Um05TfPy9Y2/D9FY0orL/kPy7iNRD20noqwjzEyaMsCzjeSN6oF1j8@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/7xXV+TwLaN8o37aqK1naXSnbiDFXHXX06d/ko946fVNqydB
	dvB7Yrsca2mYO9+K/lYOWv72SUiA5zB8XjVCF86ab2YrkFBm3p+hDyM0
X-Gm-Gg: ASbGnctaOzCdxRIq4Km21o1q8ErAI8xeb9lEYcJHXH/IG/wsKKguX4exrYzM32OMmlv
	eZ4CB1cGqwg7kNfWCWjR8u1+tPYiZiYwAzOsRifyLPun7XWL3pjIjU4cwznp2qPTUM3ij7bduVI
	cQbNUw+lnYFVqBCullLN6Z00Rt7RsAx61GoMojc+k5uC1hmx7/zvKwellS5coWEevqA6HKtuV5s
	UZIqGVTk2ZILBNJgU3Y6U4W2Zhs0WV+Q6JlE6b/dMb3SKscIUbC27+EC+uiL9NVzrZkIo3tRtQJ
	HZdiu2kyzeJnT3j58Mi021oUmfBjWmOJNGG3LnqWMt/5os0zGe4TeUUlQor05PEZEKfOxaESuN+
	C+vbUS5qGkkRL
X-Google-Smtp-Source: AGHT+IEQVs7pafUEvlCi0n5Tok95a5kwNTdA5PDFAfFmxZto7wqeil+5yP2n7spxBbpIHKUe8djRrA==
X-Received: by 2002:a05:600c:4f51:b0:456:1514:5b04 with SMTP id 5b1f17b1804b1-458721a11acmr6695035e9.21.1753365109109;
        Thu, 24 Jul 2025 06:51:49 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377e5sm21590005e9.7.2025.07.24.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:51:48 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: jwcart2@gmail.com,
	nvraxn@gmail.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	plautrba@redhat.com,
	selinux@vger.kernel.org
Subject: [PATCH v4] libselinux: fix parsing of the enforcing kernel cmdline parameter
Date: Thu, 24 Jul 2025 14:51:38 +0100
Message-ID: <20250724135138.318990-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAEjxPJ5ZqR5wmqV_tpAz6erkrpR-QWFyDmFQiwmVKnO3s3XGqQ@mail.gmail.com>
References: <CAEjxPJ5ZqR5wmqV_tpAz6erkrpR-QWFyDmFQiwmVKnO3s3XGqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, parsing of the cmdline has two issues:
- By using atoi, no error checking is done. What happens if an argument
  that isn't an integer is provided, e.g. enforcing=foo? And as there
  is also no validation that the number provided is actually valid, 1
  or 0, what happens if enforcing=2?

- After the first strstr, no arguments that follow are searched for; if
  I have enforcing=0 enforcing=1, the latter enforcing=1 is not taken
  into account. This is made even worse due to halting searching after
  finding the first "enforcing=" token, meaning that if the cmdline was
  as follows:

  fooenforcing=0 enforcing=0

  the enforcing parameter is entirely ignored.

This patch fixes this by:

  - Using strtol to actually validate that we got passed a number, and
    if not default to 0 (i.e. permissive mode) as per kernel behaviour.
    If given a positive integer that isn't 1, also treat that as 1 (so
    enforcing mode).

  - Looping until the last "enforcing=" in the cmdline. Latter (valid)
    arguments take precedence over previous arguments.

For the case where "enforcing=" is provided with a valid integer, 0 is
treated as permissive mode, and anything else (such as 1 or 2, etc) is
treated as enforcing mode. When "enforcing=" is passed an argument that
is not a valid integer (such as "on"), default to enforcing=0, i.e.
permissive mode. This is in line with how the kernel parses the
enforcing parameter.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/src/load_policy.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

v2: Follow the same argument parsing behaviour as the kernel does.
v3: Actually follow the kernel's behaviour where "enforcing=" is not
    provided with a valid integer...
v3: Update the commit message to also reflect the behaviour above.

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index dc1e4b6e..ec2d5614 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -244,17 +244,28 @@ int selinux_init_load_policy(int *enforce)
 	rc = mount("proc", "/proc", "proc", 0, 0);
 	cfg = fopen("/proc/cmdline", "re");
 	if (cfg) {
-		char *tmp;
 		buf = malloc(selinux_page_size);
 		if (!buf) {
 			fclose(cfg);
 			return -1;
 		}
-		if (fgets(buf, selinux_page_size, cfg) &&
-		    (tmp = strstr(buf, "enforcing="))) {
-			if (tmp == buf || isspace((unsigned char)*(tmp - 1))) {
-				secmdline =
-				    atoi(tmp + sizeof("enforcing=") - 1);
+		if (fgets(buf, selinux_page_size, cfg)) {
+			char *search = buf;
+			char *tmp;
+			while ((tmp = strstr(search, "enforcing="))) {
+				if (tmp == buf || isspace((unsigned char)*(tmp - 1))) {
+					char *valstr = tmp + sizeof("enforcing=") - 1;
+					char *endptr;
+					errno = 0;
+					const long val = strtol(valstr, &endptr, 0);
+					if (endptr != valstr && errno == 0) {
+						secmdline = val ? 1 : 0;
+					} else {
+						secmdline = 0;
+					}
+				}
+				/* advance past the current substring, latter arguments take precedence */
+				search = tmp + 1;
 			}
 		}
 		fclose(cfg);
-- 
2.50.1

