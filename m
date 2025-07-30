Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692081624EA
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861661; cv=none; b=nHYdMJBC59Gc8p6y3dnRKUHSMH+8KJHAr1ngx9xtmwDOJjAhyQvTZqTZIIypIHdHn7IxBFsNGSXIxdP1leBZr0ielDj28JPdQj6ZFNgHYQvNsQEVWLT4hetJzixoHf5f29QPJ/VuMkkhY8KyHU3jgmctXYL+0dbpmUniD+/N1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861661; c=relaxed/simple;
	bh=Ri64aG/N+H53ipJBNHFEW0p5T6EzOKd7e34UgfOFQOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD6TwC3jjOiun1osxKxMdG7fectANuoUoY0l6Y16ac5v+HhtY2t3OUd2WzXy2L72WUw5gxmSyBiecLuNFWjRgvlWXkJEsQwxeqIVceaFKvGqREMM8/MQ5Uv2HkAsz6WEnUXyld0JrJdqV99u5yVu8WnlNiUBH9p2TO/a5WjO/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd4NjoZg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd4NjoZg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so41850645e9.0
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753861657; x=1754466457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKKm/rxrUEsfvGz5XDSXG1iB/jsBJu75M8ZOj3ivkOU=;
        b=gd4NjoZgGe1hM/wTkAcoy1hzuDIQVWD4B9FzXei1VR0CLuTC3lAV+Xp4YqAqYXLlG3
         NUAxEAAffqe5cXHNkVGKdemXmLF2+DMG1fv98KBopfCCHsPfdChYapisryda0znJZUAj
         qjeC1A66lWqMe7kbM4rUE7ubIDojNIRLKK9BVTXvNlv/af99pf0DvnS1FMy6XxGNeJfv
         SOH/cokQ8cNPUElAPhx+4LRmo1+K5cuSfWPhzslEUzBdxkdsqJMEryEd4f5SrNao6+4A
         TYDtsn4DFSbtaLtdw0hyWPWQj0RBSsFu+6v5ASb5fwUfQcsGyKdnYPM0JGaVcOD43JN+
         r9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753861657; x=1754466457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKKm/rxrUEsfvGz5XDSXG1iB/jsBJu75M8ZOj3ivkOU=;
        b=PlJ0yDFAbTGNN5Vh/wb7wGcHlpUWfo7lgBS/UX31RVTMG1HQXWX6kH0wwv+hjsMsER
         CoXAZ0uQZtVfdGoz3B320ufA+vRVfb5dV5Y25QsLHd3sxflFXIPxL9ucGWj48pmtYGQB
         L2YRvX8XWoC9b7m4mNfjNa0UKbxQpHWKM66q6oinlbfkq7WYAxuc/JErwHWRM/cCe1oP
         PHy3J8t5fX8PLpApcvzZRBTHiC3ia9xeIJKynIYhglB+yDfDv+KXYAkpRq8hu2PvDvMs
         K6Sh1kXqJh4/1LwWZcS5Rp2DojOmZh4kdNuz+P2/G/ezV6Uljo1JDbuOe2f+Lnz1pC3j
         fDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRmpuxI8Blgv3Y3xBG5LA/Vf8gVduOHjta7I3XQKg9RB5mwgRzpycZ8L2bMC1vypyAmmNF6Plk@vger.kernel.org
X-Gm-Message-State: AOJu0YzOW5rPTwxPziN7Gbep5kpwORWntEq0n8IXWyk4V+dgc3gmjK7u
	MnY6AiN3pqOztZ8n5LwiogieA8Ty7KPmtfoCfbPpQTCZACeY5q3xZrDN
X-Gm-Gg: ASbGnctXCVwGDSmi8ZcqG2v5ifk912ebwWtrQKIBwsA2aQvRxbRL3bS1Dae/AgIxXbJ
	qbN1mCcF7oEvLqZC6lY12pOw3FzRB3r3yhFj6+/wexmhzwxdBggwqLyZzCj4THHcs0R9taNdUBv
	LXyj/QMGwAnpMWO0pRtm+HL38GUSJfzg06MwEzfEUk/27snWj6KrqPbjxbwAi3WG3398a8x67ed
	bAFdkmD9kCNfOfy88gvJn0zKrbLqBlzHrABgxDcNVSYdl2fgyOPoaGXO12N0GB27tKCm8VYXccf
	nbuhhgC3Wf8TadHazX77I42LN5WHOhH0De9zytFpeaDV0QoXj6fCQaHlcSlbigobwUtlSMHN5E/
	UNRnX1FtkZvG+
X-Google-Smtp-Source: AGHT+IFuCRSyZVLslFfwhUrZJTHFTM5UgT8CAkEeNv5tg/X0a8EwTyQrFbDb6Y8SaUpDMtfmhNe0nw==
X-Received: by 2002:a05:600c:3b02:b0:456:76c:84f2 with SMTP id 5b1f17b1804b1-45892bd6770mr23201625e9.30.1753861656412;
        Wed, 30 Jul 2025 00:47:36 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588dd77cbbsm32367575e9.2.2025.07.30.00.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 00:47:36 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: cgzones@googlemail.com
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH v2] libselinux: refactor selinux_getenforcemode
Date: Wed, 30 Jul 2025 08:47:29 +0100
Message-ID: <20250730074729.936489-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <82e217c7-7124-4d49-ab98-074a6c2535c9@googlemail.com>
References: <82e217c7-7124-4d49-ab98-074a6c2535c9@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invert the check for cfg being a nullptr and early return.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/src/selinux_config.c | 75 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 38 deletions(-)

v2: Don't mark len static.

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 75db14ba..e1bc1b79 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -88,47 +88,46 @@ static const uint16_t file_path_suffixes_idx[NEL] = {
 
 int selinux_getenforcemode(int *enforce)
 {
-	int ret = -1;
 	FILE *cfg = fopen(SELINUXCONFIG, "re");
-	if (cfg) {
-		char *buf;
-		char *tag;
-		int len = sizeof(SELINUXTAG) - 1;
-		buf = malloc(selinux_page_size);
-		if (!buf) {
-			fclose(cfg);
-			return -1;
-		}
-		while (fgets_unlocked(buf, selinux_page_size, cfg)) {
-			if (strncmp(buf, SELINUXTAG, len))
-				continue;
-			tag = buf+len;
-			while (isspace((unsigned char)*tag))
-				tag++;
-			if (!strncasecmp
-			    (tag, "enforcing", sizeof("enforcing") - 1)) {
-				*enforce = 1;
-				ret = 0;
-				break;
-			} else
-			    if (!strncasecmp
-				(tag, "permissive",
-				 sizeof("permissive") - 1)) {
-				*enforce = 0;
-				ret = 0;
-				break;
-			} else
-			    if (!strncasecmp
-				(tag, "disabled",
-				 sizeof("disabled") - 1)) {
-				*enforce = -1;
-				ret = 0;
-				break;
-			}
-		}
+	if (!cfg)
+		return -1;
+
+	char *buf = malloc(selinux_page_size);
+	if (!buf) {
 		fclose(cfg);
-		free(buf);
+		return -1;
 	}
+
+	int ret = -1;
+	const int len = sizeof(SELINUXTAG) - 1;
+	while (fgets_unlocked(buf, selinux_page_size, cfg)) {
+		if (strncmp(buf, SELINUXTAG, len))
+			continue;
+
+		char *tag = buf + len;
+		while (isspace((unsigned char)*tag))
+			tag++;
+
+		if (!strncasecmp(tag, "enforcing", sizeof("enforcing") - 1)) {
+			*enforce = 1;
+			ret = 0;
+			break;
+		} else if (!strncasecmp(tag, "permissive",
+					sizeof("permissive") - 1)) {
+			*enforce = 0;
+			ret = 0;
+			break;
+		} else if (!strncasecmp(tag, "disabled",
+					sizeof("disabled") - 1)) {
+			*enforce = -1;
+			ret = 0;
+			break;
+		}
+	}
+
+	fclose(cfg);
+	free(buf);
+
 	return ret;
 }
 
-- 
2.50.1

