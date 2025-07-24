Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD5D2FB
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348425; cv=none; b=sDUS177E6w2fX83qpLl6QQvLvgI/Du5V0bO2BAdbp1Ebr0D0PjnBITtsyLD0BJF3pj1BHjOqEQfh3bRzp1owS0QryTxMHgt8HJ9zgL9pjuaCavHxUI8kqV3+QKSU3yS1WJqtKWcfuqPsvwhuIL1KK+CfbrAOXDavEhy06TZ/3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348425; c=relaxed/simple;
	bh=s10VAtuUpTRW9MJRL2pDFUwQ4UR9oq7E73/mLGLTGvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlzSFYELYHLeGugsuRX/CcxbgYunHi50X+t+O+dhqhwjl6SazTB/KYjq4yqP6B3gTx4XFfRdP+27BXvAhnCy1B+/Z1mRaW6zrQOVOfONd8ZqAt55UqnCnr7/A0GeOdCNU1+35EFX1enqwM281ZQnHDySDSDvCrCvgJwiWdboaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3QHA+yQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3QHA+yQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so378081f8f.1
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753348422; x=1753953222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu97f/Dd9uK/tjY/lN1Tm0SQhJvljaSya+XKNPWhByk=;
        b=P3QHA+yQyvCM+SNQ80S4gcxVZUfc8u7dgU+eaKgotdTC07ZaV8T4bj1MUZZXpPX13r
         STpTKJsH+LzIz/0LfngVmGz9V2hrqCm7rZ7arRbhxl8pOHAZmqnwn03idAwWuNoAwHe+
         wrrx9faEOJSxYFpzT227ISlrosVmqzHejB+OZ7RXbLwZEVZpX3xftQHd3E4/Mk+fzlxW
         Kr7eKosSuYUcMEDJNSLC0uHfWMGT8IQK4yuO2KQeZQr4vCaVD0Go4uy7eWNINmjA3bOR
         tUBiyakhUtvKH1jVEP8B/OLIM/GAi5ER1VKXlYMMTFkTCP3W1ncaCstIymTxHnFiSmrp
         GRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753348422; x=1753953222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu97f/Dd9uK/tjY/lN1Tm0SQhJvljaSya+XKNPWhByk=;
        b=DckO2b6oSvZCqr1ZaECDxH7C+3QHHmq4+ZSihO0bQEBMpO7G48/nX+IXv/KgSQjxLM
         ihsJvI1461iItNjUwn+Hr8DtTR4yisQB7byo4bjRL550qvswmbfGI79NZ+OjIHGqt7g2
         +mRYDH5Rkn8Fr5jutbzxfcxX+g2rrGcuKy5vA+IcwBW0zmniHWeH5MT6T2e/Th+9PLQt
         HeixNtx7teb/BJ7UrsARxLa0nxfwIoOoC4cQXOhsh+WaYqvHj19wFPwZ0Pw4NINCnyp4
         JxL1cctQbhaJ/QFbE2APQPG6w6ETcSDE0KY74haFi/SNxUmh13IAZTYFU4LqOOlPfVM0
         3sow==
X-Forwarded-Encrypted: i=1; AJvYcCUKljC6PInnw900HPpPZOc3DKYR0nVt+ZM37UJloTic6wrjlDUmFk35rvsWCJm+0hc3syus+9zE@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKeH+uNoX1Oen8Eof3DSEDaJqbQJNC1Bv70CfnH6Uu/fcVA8G
	0B0diiByM2/uAhcmFz2Ro+NCY9xsxGNmET3SORcoxtrYTb3gZC06B1og
X-Gm-Gg: ASbGncsE7Y3yd+49vi6RiMVVF2LX+EQLxV0i9cdvqISNTbI225wMil8Q12kp1TQF1IU
	8WTDuyWxqhEE9X9T2SigJ4VowRGQ1Ru0TDXdn1OGgP63MR8QPjpas+KKMUaKf0ncow4MdQzKVnj
	LTI+cek3tEvf3JfI1sQKD+wKwJkpPWD+IjZ04Dat9qEJqkXDZrcWn3pOtPblVUtpQF7OsiHCjB3
	oP3fvfVu63YDxjgTxBrXp3DCB6w6FYlCZMHr/U/U9xCLCmH8MmMex8WMxVwIBdDsJvyozLgbRwa
	guY1++Ka1/fNgWYDx0bzP6x11p0CfJn2MNhgxOmW/0swObN2Q7ck5FenBMYMCg6cah9kaldu6wV
	OSu7bWLNQjweX
X-Google-Smtp-Source: AGHT+IGHJSl19aH02baNrMQgZEvF7MfOeJGdqYhC+FGamO0ta4rfLtrtDpeiFVGYn3dk4a6wivNlKA==
X-Received: by 2002:a05:6000:310d:b0:3a4:f7e6:284b with SMTP id ffacd0b85a97d-3b768ecf37bmr4918950f8f.10.1753348421779;
        Thu, 24 Jul 2025 02:13:41 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcace8csm1554460f8f.54.2025.07.24.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:13:41 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: nvraxn@gmail.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: fix parsing of the enforcing kernel cmdline parameter
Date: Thu, 24 Jul 2025 10:13:20 +0100
Message-ID: <20250724091320.228757-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAEjxPJ7ZuzcMLqewoci=wamT-F3Q_CD2iqBR+zMAB+V1hLOrHQ@mail.gmail.com>
References: <CAEjxPJ7ZuzcMLqewoci=wamT-F3Q_CD2iqBR+zMAB+V1hLOrHQ@mail.gmail.com>
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
    then validating that that number is either 0 or 1. If instead we
    get passed an invalid value, we skip over the argument entirely.

  - Looping until the last "enforcing=" in the cmdline. Latter (valid)
    arguments take precedence over previous arguments.

In the case where "enforcing=" is passed an invalid argument (i.e. not
0 or 1), default to enforcing mode (so enforcing=1) as the kernel also
does.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/src/load_policy.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

v2: Follow the same argument parsing behaviour as the kernel does.

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index dc1e4b6e..0d2a16d2 100644
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
+						secmdline = 1;
+					}
+				}
+				/* advance past the current substring, latter arguments take precedence */
+				search = tmp + 1;
 			}
 		}
 		fclose(cfg);
-- 
2.50.1

