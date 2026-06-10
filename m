Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2F40683A
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094470; cv=none; b=i9ZniIRXf6TSzxRi0o8cLYqSNsNRNRI0Fam0iz6I8cpm/6Ah9cnDcRQahd+Vy2lW1eii6hWGAMhsl4VUmmHzS2kIX99iIElsiCw1/Nmq81paw7V4kKsB/F98U3vdXEy9GuXbgtDKnhQ9j8fXAGFIwLpQqdvc/5GFwByUYH7ab48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094470; c=relaxed/simple;
	bh=rRazuN7sr/8X3z8RrIGWyu+6zaFVIpL6+D0gETWS+94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8619jwT7VUb1fxwguEIj/+u7Is7krRfxNrp6ySAS3jJyhGJsi+LHqA338Bl8T0UfnP7EZNwHAxgAZy7lKhmWqMAVYIjJbQV5QW7VvQKTqcn0TEHF1QK81O8RT+wVnP/z6MQ80G0N88LJBBoAUbmRiPKoUmeDgAjI7BoWj3iIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5xI/mMu; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5xI/mMu"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9156b74006aso482676085a.0
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781094467; x=1781699267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiiUe5+Wcgc7jtB9L61uRV5ZWNXy+vuyxss0kaJQufU=;
        b=e5xI/mMu3v1vPWW8x2r3fGYY3noNyT+HIr827158gT2sAiwPV3jKckSn7SMJhocQtW
         xVsazHTUoV2G5OcyMsGWi4+Jwy/H2aeNtadwY5Z1qVLCwtGXeoXutTvqMbsfV2qcsDhP
         4f6uICT6Hdb+D3IUdH491d0VoDIlEP6oXC+D4gaiY0SKZ4EIaHDlQ7tvRBUFaXb89HEO
         3h6ttGIx/elPyS9CHLZOgrTBZzk+KWKgi09JGpAR2I7wwiWrsJ/7rJHvZ7gvQOztjWuJ
         AgVijcbJVm/YtbaQrJO4peY09Ogj2v6+aoDlbSiLBRtgorEuY9+j+PXOhEI05eY7Zz2J
         1ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094467; x=1781699267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiiUe5+Wcgc7jtB9L61uRV5ZWNXy+vuyxss0kaJQufU=;
        b=P3W7ehvvIAG4rCaubttksSPkiwg2moBMDQTN+PZoX501OWWHlm9P5WB73O+r9gm19x
         dNdpVkBp5eidsgPKR8S9ZZQAsorO+wlAR+DNmOog6Xs3qroU1M2fr1sFuPNrbBHhBFv/
         U1cjiDDezEdBHtqq16ysUpVEjK0UYBsHHjAAHhrSSk5NyiKlMTFMGL4aEGW8hUaIoC88
         S9lmkPthfKq6hwRxoGof6U+ONQphM+TBjgaCOojuL4ynS+eVklZvvRHmDL0nAp5XyxaS
         KHNeEv5HvwnzH2t6oSnm0VzCeyeWoFAke0Fed9+EJJyF8vD8uZjI2vhsmtaOIt6slbud
         o/HQ==
X-Gm-Message-State: AOJu0Ywo1N9IuDc2FSpsAX+zteeIM/a3miyo2xKfB9QI1SFDR/BGv69t
	sgHxlxViFK2jmxxqxfuMkdJGDwHZKSbmK/g5wcHAGfsnfH0IC4cGyKcTQDPMcQ==
X-Gm-Gg: Acq92OGFjOu3OYhZsNAYWzpqz/37pcljvC053JTseiihs16F2X/8IIag7/Kc0et/GyZ
	QK1zQIa8iG1NFCKGTMuUkoFrPu/hVvbaXEhoto6DvMHdNBWMm1c4vIwoyUdlCoVWJ+GK4JPNyOI
	bUFuRPiCEHLZQMxeQmr6wFFVYgrw7PUlJNlpRCvQ2rMLYPAyTa2KQte/jry1OqG6jugMaDvjbJo
	fkXHrZxylmXP5d8cx/4+bIwP2IrMwhTxETo2bPNvw0NCodRhJPjnES8bmDsAr01Jq9qOdYoHMjf
	+yqo/gENUKxKfTVnKpbUi/s6Ce1ydnMdyX3eN6LwKgqQ9gIB+vHI0vCAUH/hwRI5CJjrxDkIZ/p
	N79BcJJCEPASUSxFCuNogpntrMOddXyialy4S5SVe9MqZTiVGMyewX40aLGeb2E4gEmmZmwMPE2
	3l1WUL1OXsyE1174XGeeeDNgc2eKPb3I2hgbRwcEPq7kHueSXdURMmV4OuAyukJ2fZ9MZDG6O86
	oSAFTwlUCBW3213waNHIny094dovDVQPOLV5H90GN7nwkdP
X-Received: by 2002:a05:620a:6cc7:b0:915:8d82:b149 with SMTP id af79cd13be357-915a9ccb099mr4098195485a.27.1781094466574;
        Wed, 10 Jun 2026 05:27:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00840dsm2628964885a.1.2026.06.10.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:27:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] libselinux: avoid out-of-bounds access on zero-length lines
Date: Wed, 10 Jun 2026 08:27:35 -0400
Message-ID: <20260610122735.5486-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

Several helpers read a line with fgets()/fgets_unlocked() and then index
buf[strlen(buf) - 1] to strip the trailing newline without checking the
line is non-empty.  A line beginning with a NUL byte is stored but yields
strlen(buf) == 0, so the index becomes buf[(size_t)-1].  Guard the index
with a non-empty check, matching the form already used in
get_ordered_context_list().

Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 libselinux/src/get_default_type.c     | 2 +-
 libselinux/src/is_customizable_type.c | 3 ++-
 libselinux/src/matchmediacon.c        | 2 +-
 libselinux/src/query_user_context.c   | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
index e2186a19..8955c505 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -38,7 +38,7 @@ static int find_default_type(FILE *fp, const char *role, char **type)
 			errno = EINVAL;
 			return -1;
 		}
-		if (buf[strlen(buf) - 1])
+		if (buf[0] && buf[strlen(buf) - 1])
 			buf[strlen(buf) - 1] = 0;
 
 		ptr = buf;
diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index 0aa790e3..992747fb 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -44,7 +44,8 @@ static void customizable_init(void)
 			i = 0;
 			while (fgets_unlocked(buf, selinux_page_size, fp) &&
 			       i < ctr) {
-				buf[strlen(buf) - 1] = 0;
+				if (buf[0])
+					buf[strlen(buf) - 1] = 0;
 				list[i] = strdup(buf);
 				if (!list[i]) {
 					unsigned int j;
diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediacon.c
index 3e7544b7..ca3d7980 100644
--- a/libselinux/src/matchmediacon.c
+++ b/libselinux/src/matchmediacon.c
@@ -26,7 +26,7 @@ int matchmediacon(const char *media, char **con)
 			fclose(infile);
 			return -1;
 		}
-		if (current_line[strlen(current_line) - 1])
+		if (current_line[0] && current_line[strlen(current_line) - 1])
 			current_line[strlen(current_line) - 1] = 0;
 		/* Skip leading whitespace before the partial context. */
 		ptr = current_line;
diff --git a/libselinux/src/query_user_context.c b/libselinux/src/query_user_context.c
index 0a5e8315..c2196de2 100644
--- a/libselinux/src/query_user_context.c
+++ b/libselinux/src/query_user_context.c
@@ -85,7 +85,7 @@ static void get_field(const char *fieldstr, char *newfield, int newfieldlen)
 		if (fgets(newfield, newfieldlen, stdin) == NULL)
 			continue;
 		fflush(stdin);
-		if (newfield[strlen(newfield) - 1] == '\n')
+		if (newfield[0] && newfield[strlen(newfield) - 1] == '\n')
 			newfield[strlen(newfield) - 1] = '\0';
 
 		if (strlen(newfield) == 0) {
-- 
2.54.0

