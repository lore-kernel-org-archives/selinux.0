Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0FA36084
	for <selinux@vger.kernel.org>; Fri,  5 Jan 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcgRPPFi"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e7bb1e0db8so17462137b3.0
        for <selinux@vger.kernel.org>; Fri, 05 Jan 2024 12:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704485961; x=1705090761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpFUo9OoZyTVJaazwDX/lJeOi/Exe5srA+eOGN9MI5M=;
        b=LcgRPPFi2QIvPUi1ndiPhxZYjpRq+4TV+nWPPJ2we7Tjv34Mdd82pmsufjk7Hq7La/
         c6Vtoe8oTJXOx9h7EA6RFLHY2dUm3M8cgZYCvgp2IO+tgBTL9jtDpwyJ2kpofqAI1drw
         sRIporH6Ga6uaPdsX5kAd54ESBc3kwjYJoAJMhfVikX6q+LcMiGxhtyz3jptu/AQOxIc
         Q7vCmtbIBkERzv2xnGG5kIYjpkFhltyn5Ny5ZeJLD1iznmchBPLZ4NV1yK4wVaEk31Kn
         uWCAJlwB994019LExv0XMTt0PjB8Q8uaD+VImzIR1L1BmE2/RSae3zSafSKEr/aWDQaB
         V3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704485961; x=1705090761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpFUo9OoZyTVJaazwDX/lJeOi/Exe5srA+eOGN9MI5M=;
        b=dDvPJuFa0cRqhCEVkJu6Iud+SBkwgJnM3I8LjyvgdGUF+V3DzHsl5Yge5uq66XD7g4
         owhd3pnDovQKLoNg5D4OYkYD8KElHJnA4sikICtmG/rGZArt7qaouHLaB1faMV7o1s2k
         cTS/l1tdJ1OTLbXqfXRtkcv/aJTYsVziiuAYUpaTTjZmgizHfR0jkGEuLj7i2ce0TlD6
         iF170MzPx15DcTJh0/1+MRdw6t/Y8mFXLyDkSV38ZTCd9PEl9ovHdy5o/L4YID76JV0k
         9wUoIPlbiLH86dcb+Sse/guO0PKxq6fqxoLugGAHoI5yoVwUe28WPPeT2V6OcyRE/K4b
         ssGQ==
X-Gm-Message-State: AOJu0YyMBoppAGZd1erHSwd9J/Z907i0yXMf8dDOEIiS9lSxLgPWoX39
	GbJ4HMing7ooDORdJcWO6+9lmqlqMhg=
X-Google-Smtp-Source: AGHT+IEa4TIdY0oYW8c9YbE/dML9xhSL2oan37gn3RNKEcdpZmILT8P0JT6MUr6v9t6hkXUBeRPMuA==
X-Received: by 2002:a81:628a:0:b0:5ee:94:9be5 with SMTP id w132-20020a81628a000000b005ee00949be5mr34674ywb.34.1704485961481;
        Fri, 05 Jan 2024 12:19:21 -0800 (PST)
Received: from electric.. ([69.140.100.37])
        by smtp.gmail.com with ESMTPSA id a13-20020a0ccdcd000000b0067f3a71ad96sm863300qvn.72.2024.01.05.12.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 12:19:21 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libselinux: Fix ordering of arguments to calloc
Date: Fri,  5 Jan 2024 15:19:17 -0500
Message-ID: <20240105201917.2286119-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of elements should be first and the size of the elements
second.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/audit2why.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 8c4c07d5..ad846cc3 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -148,7 +148,7 @@ static int check_booleans(struct boolean_t **bools)
 		sepol_bool_free(boolean);
 
 	if (fcnt > 0) {
-		*bools = calloc(sizeof(struct boolean_t), fcnt + 1);
+		*bools = calloc(fcnt + 1, sizeof(struct boolean_t));
 		if (!*bools) {
 			PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
 			free(foundlist);
@@ -226,7 +226,7 @@ static int __policy_init(const char *init_path)
 		return 1;
 	}
 
-	avc = calloc(sizeof(struct avc_t), 1);
+	avc = calloc(1, sizeof(struct avc_t));
 	if (!avc) {
 		PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
 		fclose(fp);
-- 
2.43.0

