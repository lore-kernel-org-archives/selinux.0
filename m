Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6939E2940B
	for <selinux@vger.kernel.org>; Mon,  8 Jan 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RkfQxxDI"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e485c4948so6816315e9.0
        for <selinux@vger.kernel.org>; Mon, 08 Jan 2024 04:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1704715233; x=1705320033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LKAIDteJeUCBboF/T7Nl8Dxy2akoZEnuUhyFEIhNOHk=;
        b=RkfQxxDIsGDYNdynUZ3mTeylXDzd2/BS5+YTm1aYK3Er4Ke3O4pW9qjvC1/SJHOyc/
         pMhsrlNBAwJ90cBGaTwQyQMopYeWIaBzM0ockBADAeDkJmd+udtdlUQiyU5F9i9/Vg7j
         3olIwOoMw01Na/xdFawGOQDg8v2ryoUArhLG8lIHWH3DtVd8FgLvbYLlNtB9bf3aWn1X
         r0KgEFA8uvDY0hgkBLhWg0MYrJodrXILng1cz5QogRP+mHPt+3FSY+eI579qRsCPKN/C
         FTUEvkKoM7n874YUVL2r42lUda2yXvV1tvBNeDdMIb4c3Gmt9/DKDYW6QCGfzgEAex7i
         4sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715233; x=1705320033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKAIDteJeUCBboF/T7Nl8Dxy2akoZEnuUhyFEIhNOHk=;
        b=QytAhcuFFMo3Kmhpk91UiqoC3iMCn9t6BSs/HjXspi1OM8ISArEBUmYSN2vbPGTs5F
         zoza7dhXH2mf0wjPafRHzFx5Rs10jOpzKLP/7t+xikoG5cQMh6f9VUtPPToe6w5np6YQ
         5hwGtohXO3mJEk89OAJcLTJCjzo/YpgME7eMPPv7f7lUEucfGzD6m2e9VKtPiWptUSMj
         roiMOMxBdmzPuzsQ45wF9t6v7mHdV3aYasrFdHIo86BnasceVWxZ0KmckQlAmrObBGYL
         SeKYN8xKBBJr1fTzSHKc+HTCTErUvot1n46x+NqUkrDZW3fjvcYAorLJWvnDZxoSFl12
         0n5g==
X-Gm-Message-State: AOJu0YwrTY1rdm/+8z2ooD96erYzlEjgPjiijqqWUtr1TlCywt3XknWN
	KdYjXTe1iKr+Gl95JDXbrf8ssQz3kfQ=
X-Google-Smtp-Source: AGHT+IGxSaPD2k2iuZzV+4decI9jSjFia93ntW+vgNbeWob1X1g/5RYWm9ohqV2EiPJwdnCq3g5ckQ==
X-Received: by 2002:a05:600c:19d2:b0:40e:3bba:8089 with SMTP id u18-20020a05600c19d200b0040e3bba8089mr1947744wmq.186.1704715233351;
        Mon, 08 Jan 2024 04:00:33 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-006-145-115.77.6.pool.telefonica.de. [77.6.145.115])
        by smtp.gmail.com with ESMTPSA id lw15-20020a170906bccf00b00a26f22dca5asm3838210ejb.0.2024.01.08.04.00.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:00:33 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH] libselinux: disable capturing in fcontext matching
Date: Mon,  8 Jan 2024 13:00:29 +0100
Message-ID: <20240108120029.38816-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The path of a file context definition is compared as a regular
expression against actual pathnames.  Those definitions make frequently
use of groups, like `(/.*)?`, which are capturing by default, causing
the regex engine to extract and save the matched input.  Matching
context definitions against pathnames only cares about whether it's a
match or not, potential captures are never accessed.

Compile regular expressions (in the default PCRE2 variant) with the flag
PCRE2_NO_AUTO_CAPTURE to turn captured groups automatically into non
captured ones, like `(/.*)?` into `(?:/.*)?`.  This saves some cycles
during lookup operations (~1.5%).

Only potential regression would be the advanced usage of backreferences
or recursion/subroutine calls to numbered captures, which would need an
update to use named captures instead.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 88d82fed..87423c48 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -80,7 +80,7 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		return -1;
 
 	(*regex)->regex = pcre2_compile(
-	    (PCRE2_SPTR)pattern_string, PCRE2_ZERO_TERMINATED, PCRE2_DOTALL,
+	    (PCRE2_SPTR)pattern_string, PCRE2_ZERO_TERMINATED, PCRE2_DOTALL | PCRE2_NO_AUTO_CAPTURE,
 	    &errordata->error_code, &errordata->error_offset, NULL);
 	if (!(*regex)->regex) {
 		goto err;
-- 
2.43.0

