Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322DB14F70
	for <selinux@vger.kernel.org>; Sun, 20 Jul 2025 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753015961; cv=none; b=flv+VJ9V3k8TYxNKknxro4PBjqTfV7eQmGQ+yWJJy5Olbuihc0LZ4YWU9MQL4cyKKDpPITqhIWJ2bybcumN7iDJYQ4QQoPkHvv9GZ2wEY+W7rdVulxJzW15mJYbm72+FSAW5rNkDu68hclDrrhIEstrqYVm+NCHAs0AIJeQU9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753015961; c=relaxed/simple;
	bh=SAukvWyIMReWR5H40W1upOS3C3N7rtiJfR5kuU7hCkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q++UEL2wtHUcBVJ1+zR3aBY2amrrwmcwpOlSXOd5hIj6vCB2bV0xiIZTUYXqun6XjzOdFOEcFPox6ipzCkZE88Cld5E6Bm/6kcVAomZwdKl0Xkj/n1wImf5fPdl5Kg5x2HHYhHecD6+0gycq9wKQU1asqa6C9ycPfdhfT5MBjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7cfHGma; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7cfHGma"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45629703011so24069145e9.0
        for <selinux@vger.kernel.org>; Sun, 20 Jul 2025 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753015958; x=1753620758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ov1qN3NirKFjJ2j/kcm69bEZNcn/tX4qyaZU9f0GHJU=;
        b=P7cfHGmax3RrCYUett9D/CdXciUoctEvihI44KnhN+wlNPNyBIxudGSFHW31rxBkIy
         Q0k7KcNNff2WeCNHGEyZgtVfst4WZkb8LUKEU7yg3SW4P102zLRvoTNoadBFPfVKzbkO
         lIM/ofowyD/ZkJf0n24Ai//URNMB6mCvyEhdoQxyiy48jZWaDcoq8lo6nlH+3Vr1bEZ/
         iXTgT2XihxsXBdCj7YYo+tWGB/ivnwjP7amvElaln+fCJauPhHnOc9u7ZbX0+OIPpomW
         TVpPAYX099KSeitExNOcGOi4iDZnrteJHWx2VFtz8mqbSnScUshoad01mXsZAyEjy/1G
         nX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753015958; x=1753620758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ov1qN3NirKFjJ2j/kcm69bEZNcn/tX4qyaZU9f0GHJU=;
        b=Df6uAXdIhWGWCBwNPgnEJCdG1iYF9zDyOxlJLhIAiRbyll+2uz/W2F11v+gCG2YhVu
         RgUBQPrbTKGyySvMockj+JQ1GdFhswJWfUP8i10ZuUHvyrPj1TVWRQ5FWObjyOTBnBJ+
         EwwNW+gqhaU08pUqNm36iZ8ieUv5elRa705rJNk1FefakwTwjab0mHUuFn9wlz+uq+Ye
         qjtg5FOMmElegiSAU68aTkyX/NL2Xc2bbz9I5k8Q/Ythnq6zOsRhKr8VuanXofn37DY9
         JG3w/kZBrIBXveJzjy4n63Y1MY4Okzkcom82CtXf4o/+QuWbwAD/oeS5bVhoo3qF0uNz
         E/Gw==
X-Gm-Message-State: AOJu0YzNfwRDBd5NjSsDNOxw023bFk1cVXbBU0N4roBpDAwrtDQHnXeT
	8mNOUVJiTx6Xo0CZyoMlfThEx2XYCJBpta2BMvVF2arqmZu3O7dTp4cTHs+oPw==
X-Gm-Gg: ASbGncuynptRtMuyCi+AxHxcsBJW/FE7G9jxYdye2nMKTnNXC9ze4TBhPxkYA4/GeOg
	1IAbBitwiYShmuuqgYgmE1Gbg2oBcGiA9YboGV+48Fo6+JlSUf7bCGOIBLBBbu73gTsghcpjvAp
	mUpwWip3S9enr7fFDl3Jk1FPBK/CtrPI1o1MN3kTfl2+EMzhRMooqbodQr4coEe3ggHcnNHkaTH
	eJlw7QcXID5BqRWnT9kvM7BdRUn8P50DyhbEKrejbk35/oPgT9OBWahJ/UaZTDmkD4m17Azp7CW
	V4/pzBdtlcTnhgSxb74JAK9iUvcbZN72CviLwtJqH1nW251I/o7Cd8bMWqz4C1HSmyw3vx0VvFX
	9Mz8fEJt6LNzm
X-Google-Smtp-Source: AGHT+IHAPhdNIqrGnUlAdBaMHA32ezwdRjkf1jUfk9MeJAWXD/3LQGmBq1qqq5ZinWE2OHTwX1I3xA==
X-Received: by 2002:a05:600c:699a:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45636ba6679mr147378575e9.10.1753015958203;
        Sun, 20 Jul 2025 05:52:38 -0700 (PDT)
Received: from sierra ([2a0a:ef40:98b:8700:d4ac:8933:92b1:5832])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d7b1sm7605930f8f.71.2025.07.20.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:52:37 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libselinux: fix parsing of the enforcing kernel cmdline parameter
Date: Sun, 20 Jul 2025 13:52:29 +0100
Message-ID: <20250720125229.306644-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Although this patch (intentionally) breaks the case where "enforcing="
is provided with a positive argument that isn't 1, enforcing=2 doesn't
really make much sense, and being strict with the arguments we parse is
a good thing given that SELinux's mode of operation is controlled by
that option.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/src/load_policy.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index dc1e4b6e..9d411b95 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -244,17 +244,26 @@ int selinux_init_load_policy(int *enforce)
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
+					long val = strtol(valstr, &endptr, 10);
+					if (endptr != valstr && errno == 0 && (val == 0 || val == 1)) {
+						secmdline = (int)val;
+					}
+				}
+				/* advance past the current substring, latter arguments take precedence */
+				search = tmp + 1;
 			}
 		}
 		fclose(cfg);
-- 
2.50.1

