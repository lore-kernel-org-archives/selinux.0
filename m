Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD62AD2F
	for <selinux@vger.kernel.org>; Sun, 27 Jul 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753630394; cv=none; b=fyxOB1S4JdkvKZj9FAmJC1D+5/epRJGG//PKDLWjAn1kzbVMk+RUoSz/HfBwAQkApLNyDZBcdMfYFrQi/WYvDpqg2Crn8vS7D7FiyOokhskAlZ/mYwz0Yd24cYxscqzLyl6KQAFVuPuMrkKw/mEBv/2Q9Xt+y8DGSP5kNFwG6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753630394; c=relaxed/simple;
	bh=Cm3wjs7S8aNRFW2t+Wvl1ed/iDqwslx5GnggVWjbop0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVS9u+jM1er1vn3ecf+qr3GxdLLcKJFS9v8HoN1Pw2a67CMiNChHMk37ibh6ZbIoo9bQDhCQQo3sXohcSCFYvXX2NOtRo9r9C7U4yFh+CDW8WJ0P2eMOt16KhWQ+T3LAcNrPKDhU+tbYzM1JlfOFP9Lt3PwWumbZQRfIP1a7PnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K35ZUNl/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K35ZUNl/"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7886bee77so203288f8f.0
        for <selinux@vger.kernel.org>; Sun, 27 Jul 2025 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753630391; x=1754235191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9C2oFmN8NuivPOE7MSnRWBW7ukm4KmrVTUXJt1FBj9U=;
        b=K35ZUNl/+fdo/3I3Ty1502mxRWHNmieUmkbqnTr6CMD0p0ZhJAcC3cGqHBn3NbA0Ay
         iJKopDetNG5V+cWiEWfbBqyEu8qoDO0BRUmB2w+6N6cbiblpzsD3KcXkr6t4mUpmXgiF
         O+Wn191atI3jSnR+DWAbf0o28fy20pj4JqHtk9n/y5j0rzSqU6mhc7Tvl1WCIVWW4lwK
         GBpRD9IjvlZpV3/pDnXCiGSVEfd4wIEVyqZq44ueNLOuRn+rM+0Dkn94dfsIv/c0RF/g
         kwszBl+/j4OtfFVplUc2liM7YnRDgyo7/eu5yErUuSpSH7ureg5Desu4xQaQqd6/xgTf
         zM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753630391; x=1754235191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9C2oFmN8NuivPOE7MSnRWBW7ukm4KmrVTUXJt1FBj9U=;
        b=POKkghgTyA6LCrwr5kP19JJ1FGuuZZITWgSgzljAJ7sw4m0fOGN9bRiPFPd0zmrRkq
         QWszs4QMXd6ENfLcSR3IGAIQ2lqSNTwcvFC3mk59LohVQ0738Im7ghbkqfisvzvWnraj
         XSJj4Gg82zly7Vqr4rsAhTDruBErSD7iZqVGTdCqLFMjzHH1E3nDoIHY6845OwTbY+gn
         yg7DH20NEE+6jNaZppfWwA/E4CQc5SCkKE6Q7IZfbj7JkEvQ+hCHJnHODv/XJwwKux2i
         P7p5LcmZFk6tZMyOD4YKTWVt6lg1xcs4dOVR13jS8G8jxlpAFSSifdtneszj5sMA/349
         LM6w==
X-Gm-Message-State: AOJu0YyeMUg5gE3wXmLoNIrK8CRxBzcS9YqckX0J0zoTU1odgK5KefFe
	IMzzMWGxLbLj/oUYa/XcaF9VWk3sxUiimL0HxXO2paBi9ufwFH4EbzEOOgOuvQ==
X-Gm-Gg: ASbGncvED3N85+TgJIyOOoI2v4Fd1OrFstETX9ZeHoe0y0HIFxlJgCHmYSEQpCAYpUT
	KKgsPL/PXKBjAiRDjgCHrLWsRwzis181DHBV2dLRUXeSoIJwrKn2W71/A0xHkvWA3lvGThP2OcG
	aKeDnG7n0KJd/S2W1DzR6dXBYBpV/ZWucy/bO8YauyfOi4nik6Xvym1MW1yfFJ1xPd/xF7/vlyD
	RWcd1Od8bao1LZHJysWEffJ1vEAeMV7amxQA4qb08fKxT9I+seVxP1kL+b3O8OKeaUEXkZiJpCp
	lWulsScVcl7o6tIp27XGCQIA30SY+6akYdOIAGoLrKnck4r/IH3MLnMiquBT1Bu9uW9PFM6usTw
	+VKRUbQtz5mqyYBRcd7K56IM=
X-Google-Smtp-Source: AGHT+IEFHPs1AaIbGQoPEs4zK50r+9vutcqoKiLfn18jb+bZrRCdlN+4CYYg+jb8tmZibXu+QGen9A==
X-Received: by 2002:a05:6000:2405:b0:3a8:6260:ea91 with SMTP id ffacd0b85a97d-3b776667202mr5633835f8f.40.1753630390754;
        Sun, 27 Jul 2025 08:33:10 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eba0e6sm6021561f8f.25.2025.07.27.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 08:33:10 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libselinux: refactor selinux_getenforcemode
Date: Sun, 27 Jul 2025 16:32:50 +0100
Message-ID: <20250727153250.731505-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
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

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 75db14ba..a2335fa9 100644
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
+	static const int len = sizeof(SELINUXTAG) - 1;
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

