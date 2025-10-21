Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC42F12DA
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046603; cv=none; b=u6VXWjZFQpGl+jtAcQspMKNebtDv0PJ0zEl/EKbPLxPYDQ9b5G5TsfAxscV3gJwGl/b85Y9+PT7+0mBnKcMWywsWbwTGeD/u+dkQaVrvwHOnuCcBEtLMKfqo52Ly+G6U5bqKr7xVdoC9VbrQLDpJ2zXqSUpMNe1FY/HK55316Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046603; c=relaxed/simple;
	bh=6G1CyqxWuuBwUI3fgZlclNy5mb5RLGO2yY7w7xOZUfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQ+Mda0zi6fryZO6oBimYoMpUqMpozPk/3PQGqcMQkOK1sCy+YZte5V1mAnkc8B6nJi2voG9wP1nzmJosToRCEr6a8HVPfJSxogF3LhpYgOjctBAmnLuw/p8Yw9fNo1dtYN3YhEDn0yfMsxsRiOrShymeO+hFxN7Rgu7aO0g+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy3V9+lA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy3V9+lA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so30321265e9.2
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 04:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761046599; x=1761651399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ztpgfXqINm1Zei/+2mYvNyc6EweY8/ruX2u08ylhI8=;
        b=Yy3V9+lAUgknpxhiLPqUu1v+NRvnoJEdnRCnvKgFc3otzNbJ1aGTabIRukTudDvS/k
         zHFwBwDAvzEpyiGD5ySg3xVBogu9PS5y7R289cLAbtom2DROFPuVsjburc26X7lksZEm
         xINN2TfP6OQgoz2gPttsOJ5QiOjiNg/tgBphiIjCv07XCZ1TMZEX0h22TXludzYfeSUg
         Wru1ImawwwBrVsjLkRno28N6DXwvXE3ACYE3u70Akclxc07dlDdzaha4TvXaejMuhwQe
         MDpiQZDMzNM7A5y3akeN+LgjvTSW4I4s2JpiaHk6aeb6P2b6Dg+7oop9KeHjq47exMzQ
         45qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046599; x=1761651399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ztpgfXqINm1Zei/+2mYvNyc6EweY8/ruX2u08ylhI8=;
        b=FOKwwtvFyX8ih9KFU6MQYelXSEQhPhpAGJH6DrNsUoSFubRpvtK2OP/ZRGtqfBNN0r
         7rcjdkoIF8/CQi/bvUpR7FvibvbuAbGpWXaqWkhC6ZXZzkit/VufVVhfHOYxxg9RCxIJ
         cdzj3kFk6Ymf/CGgwESKe57nmCsjN/PlcOGNTdMathu5ap9Ao1ENHxIsF7hk/+0xBSNR
         81CyRQxb45/43rqsR7saH5Olmq2g+R+t9+k0+sppBXf9mF+LOPrv4HrboZSavh+00/I8
         GxmNZRNM+XtV7iuKwUG3heaVisSU8g+GZccDSzHBbCGXLIVR9SX+pZigG2e1E3wBur63
         FeBA==
X-Gm-Message-State: AOJu0YwxkZ6ou05qa2NGsSMaLuwo7PdDrlxqgU/yKT29OR18hUInATFj
	8wgUUGdPnteN7ckkl1/3c57kWmk3b0PNg3RTft7ijSRFxQqiqH7zEvqKo6ZhnQ==
X-Gm-Gg: ASbGnctj9sHInXHnztIS1Q4TwLX/RL1YyBaJGUX1kT/jkySg2oeZoRVKsxgFWqXC7Sq
	KK4X8urU353wbiUHdDvov4wU3V4R97T0N5808oTJ0ZDlDEwrFMfarXp8JPzFe8mfvZRCyjRmuxj
	/nLlyGMX3jS15n42Sbug1/DLh6tufqGEpea3WMC+EvoTljRglXlzHxsksiEEsTvkz/L1//xN2zh
	nw6FWGuQd6NdcEZclRYTh57W92cRnqrY34NF9m090wOASQx4P5PzX8M+0uzXjrxWsJscMFu/zql
	P09tILumrvXzu4l4mpIEAL3HvKnlFqOWD+oCEj8u07yDTQ4zN7J9T0fKu54VVGi5QSMqekrro93
	WkjryCWGecyLHliYPXaasTx9g3zup2CIzAMzv1C/kIoUfwUphlhCHfLHOg0PaNDdhS5UERYk8SK
	cOy5JDx3I=
X-Google-Smtp-Source: AGHT+IGWbgpPHF9roImRaJaSMjoSjKxGYnzVCHkfMf/bpAsRz0GF3SA24pJgzGaRSE8Y+oh98B0/zw==
X-Received: by 2002:a05:600c:524f:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-471178a6e99mr113811155e9.17.1761046599194;
        Tue, 21 Oct 2025 04:36:39 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442dbaesm279375315e9.8.2025.10.21.04.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:36:38 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] genhomedircon: cleanup parsing of uid config values
Date: Tue, 21 Oct 2025 12:36:26 +0100
Message-ID: <20251021113626.40772-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parsing KV files with a separator of similar format is fairly similar,
so we may as well add a helper function to make it easier to read.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsemanage/src/genhomedircon.c | 81 +++++++++++++--------------------
 1 file changed, 32 insertions(+), 49 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 34056562..08a22df1 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -308,6 +308,29 @@ done:
 	return retval;
 }
 
+static int parse_uid_config(const char *file, const char *key, const char *sep,
+		uid_t fallback, uid_t *out)
+{
+	char *path = semanage_findval(file, key, sep);
+	if (!path || !*path) {
+		free(path);
+		*out = fallback;
+		return 0;
+	}
+
+	char *endptr;
+	const unsigned long val = strtoul(path, &endptr, 0);
+	free(path);
+
+	if (endptr != path && *endptr == '\0') {
+		*out = (uid_t)val;
+		return 0;
+	}
+
+	*out = fallback;
+	return -1;
+}
+
 static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 {
 	semanage_list_t *homedir_list = NULL;
@@ -315,7 +338,6 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	fc_match_handle_t hand;
 	char *path = NULL;
 	uid_t temp, minuid = 500, maxuid = 60000;
-	int minuid_set = 0;
 	struct passwd *pwbuf;
 	struct stat buf;
 
@@ -362,56 +384,17 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	     "Conversion failed for key " key ", is its value a number?" \
 	     "  Falling back to default value of `%s`.", #val);
 
-	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL);
-	if (path && *path) {
-		char *endptr;
-		const unsigned long val = strtoul(path, &endptr, 0);
-		if (endptr != path && *endptr == '\0') {
-			minuid = (uid_t)val;
-			minuid_set = 1;
-		} else {
-			/* we were provided an invalid value, use defaults.  */
-			genhomedircon_warn_conv_fail("UID_MIN", FALLBACK_MINUID);
-			minuid = FALLBACK_MINUID;
-			minuid_set = 1;
-		}
-	}
-	free(path);
-	path = NULL;
+	if (parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL, FALLBACK_MINUID, &minuid) < 0)
+		genhomedircon_warn_conv_fail("UID_MIN", FALLBACK_MINUID);
 
-	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
-	if (path && *path) {
-		char *endptr;
-		const unsigned long val = strtoul(path, &endptr, 0);
-		if (endptr != path && *endptr == '\0') {
-			maxuid = (uid_t)val;
-		} else {
-			/* we were provided an invalid value, use defaults.  */
-			genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_MAXUID);
-			maxuid = FALLBACK_MAXUID;
-		}
-	}
-	free(path);
-	path = NULL;
+	if (parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL, FALLBACK_MAXUID, &maxuid) < 0)
+		genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_MAXUID);
 
-	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
-	if (path && *path) {
-		char *endptr;
-		const unsigned long val = strtoul(path, &endptr, 0);
-		if (endptr != path && *endptr == '\0') {
-			temp = (uid_t)val;
-		} else {
-			/* we were provided an invalid value, use defaults.  */
-			genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALLBACK_LU_UIDNUMBER);
-			temp = FALLBACK_LU_UIDNUMBER;
-		}
-		if (!minuid_set || temp < minuid) {
-			minuid = temp;
-			minuid_set = 1;
-		}
-	}
-	free(path);
-	path = NULL;
+	if (parse_uid_config(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=", FALLBACK_LU_UIDNUMBER, &temp) < 0)
+		genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALLBACK_LU_UIDNUMBER);
+
+	if (temp < minuid)
+		minuid = temp;
 
 #undef genhomedircon_warn_conv_fail
 
-- 
2.51.0

