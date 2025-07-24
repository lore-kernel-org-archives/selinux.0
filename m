Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B02D4B5B
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362326; cv=none; b=YXnkXLmu1+Pc4T6B9l9YwLWmkTOvr2zTEUFt7jc9RI6hpaeQ5Utxl92iY0LW2dFM1gX0KMIqWVFqmh5FOFEdq4bwcUIqvbRJ+ZNqT6DsLr2nwG1uKNKuH7FbTfBimaABx60JuMaMBcZ1pKhs7CQWacETxEIMby/+C3jCVB/4uVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362326; c=relaxed/simple;
	bh=s8sJwjQSu8cswcKYXg/GWrCMlc7aGsZO/5kLBryMxb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Snv6eLiIcrKTi+m8SJSKytWfYLLtIQIdBR4ptJZXj4yAlRqFOFTEhIbYt9XwFv/55rWX8fpjFungdhxnAXAcHJYVNXbUuzrLMN5IkbH0pyf3mzTD6Z9Ml+j0vpW7jPv5FYnhy2AcBeSv4OTUuYUFltPZ5xWTkqjlxQtzxKtPtmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbzXgP/6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbzXgP/6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso10221065e9.3
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753362323; x=1753967123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEOH++169MGS3E+AoFCiyIm2177C/fz2dsmEQs6qHRI=;
        b=DbzXgP/6b5hQs8MvkBMloo2skLMIx4pD3CmntKhBj3MyNtOBwInG4P/OtTLiS2fEqd
         GjsWeEEl8UmQ/1YMqgb40FWuYcM7NksvTQLFsFwiQ+psAVVgM7WIPKHP4I2NZQZFKnOP
         +suxByhfgBE5q36La/GvtajM7pAQ52y4R4D3EziR6MM5UJaBdFVW0FYZYIB9oMF9b5MA
         vHE0Hq5JJaNOBZjz8m66wbMRMUifN6fxaxzCfwPZvBaLj4Vjn5G4AYKB75EZDyT11wV6
         tnKXZelGLZNYFbubEorUXop85vmMxevfnMhg4WwqYwTVx+n+n5TTTu8bLxiL2hG5zlOr
         R/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753362323; x=1753967123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEOH++169MGS3E+AoFCiyIm2177C/fz2dsmEQs6qHRI=;
        b=hdfqzVG8q+CTqeDTM+XSL1PBNjK7JhgwFiYeFU6F2q10TL7b1W0uune9ibT0ZlpLZN
         9PRzECIT9p4xTMOXrDOhsRmIcBcjssJryW9HWw+MB8fGjMkMix7Jak8iFVKHogknR8uM
         eGznreRhxxIzRnNj8IU9b0HkJxVJbjSIrHdFhGkfigIZtXK+rwGmPUkIKCzIl1nq2QME
         xJp1sWCplqcOkYA2omPFjSO7ZGEIOpemNg8QB65zrC3iqKFMA7AeJkgIIOpcMbFkV2uM
         YPMqxVj1hr6//st/NN60prvwV7wfnAkZn0G3jbMwYXc5Z0t3+cAAd7arIOs9vpdYZVEn
         voFg==
X-Forwarded-Encrypted: i=1; AJvYcCWVjTQqY8/059tGFyj1M9EfzaohguNLBtUrEiK26MJT1iXAsHghGRooKuYpcIJ6FxcmQ0vZuN+q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7x1n3z80Qgu5ALdT8NE14u5hwIRAO0FyHshTvCV7GeiMmX/ID
	9Luez6E8OfUl4wSsIUsGJwsmtPiE6yz15xO31tKpnGb/9/bTMytpjDCp
X-Gm-Gg: ASbGncswPxpwaCzLLMHWPifvFb/F+oCdpgR7um0SWilPOs7LuQU9VTzU0M3dDdGKf93
	zJDmbBRLULTWCUfxS7T7Uf1/V+y6XgQybNZ4crLTcV9sYd+OlK5HIHFFLxArJ/ylTjjrAVL9ZBv
	nONX96VqDiakqYwh9hf2KVSE+N5TG/U9BsAFpr7h3TuFeipCYFGJme4dT+VWZg0cem0rxPhZNM0
	lcir0tSK5xe3DDP3D0oswsHyIiu+ry9Im+TTkw0vkcCL9l7AKGAlsimWip10lOzjGOORO1cWL8L
	7t8KdRw/ndAzywPbffhtj6471xZkBCCmE6+4lpc6mUeBDHGqHIyC6P22BocDMo+0kqkwo5W2Wuq
	H3mL42/+l8X6N
X-Google-Smtp-Source: AGHT+IHFom59hXynykVNwuuFps0bE8aDdZaryh06k63RbzkvLsXWnnvjhe0O5YEaGHLTdtIwPM34Bg==
X-Received: by 2002:a05:600c:a408:b0:456:161c:3d61 with SMTP id 5b1f17b1804b1-45869e0e6c2mr38223045e9.22.1753362323006;
        Thu, 24 Jul 2025 06:05:23 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec77799sm19099545e9.2.2025.07.24.06.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:05:22 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: nvraxn@gmail.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org
Subject: [PATCH v3] libselinux: fix parsing of the enforcing kernel cmdline parameter
Date: Thu, 24 Jul 2025 14:05:11 +0100
Message-ID: <20250724130511.317098-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAEjxPJ6AuwTX9soXmHSiJbE2r69mRt8qFTTOQj-FhWUjnnYdQg@mail.gmail.com>
References: <CAEjxPJ6AuwTX9soXmHSiJbE2r69mRt8qFTTOQj-FhWUjnnYdQg@mail.gmail.com>
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

