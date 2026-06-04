Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B989530F803
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600661; cv=none; b=Yh5cn6rJdmUWXBotKdErs+czkM8O0awDD3BdxFujKdAjbt4zYxsR/YTWAlR1Ni8MfP1mPGbzH3azlx2Tgf62orrICh2NMKzy/AwOvgzMYPuL8EAq05xl6xkiFcK5uW9HN88eCsHAcGE1nXOk3mRnDEx69qYOrZfb9xo7OSWqReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600661; c=relaxed/simple;
	bh=zHfBl5DIltGwA4t3MAdjD8Wzsma6f+/gRt89h2epLE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ky3eIhSRgD6vfhGV5DNO++jFvEMY1ac7HGHLloTwAMvXMrBXjO+4/8xM6Ve7SlMtNeqLaMqGzICmFS665NszY2M6klvegCdHKA6qDMJ9CbGqMMem5uFm2HZ/HQv4J1WJuxncmxKFE9p2ll9vNnkldJyDSgJSsHLw23AMqEsUU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb8b4lL4; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb8b4lL4"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8cce77eb087so9351896d6.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780600660; x=1781205460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZgS9B26QsTpHWA8E51iGMnKHjz/LU4T3XSbX16NycY=;
        b=Sb8b4lL4px85hFdUF08Sr8eGUEn4J+A5eTGYzOHcHEsfWUH4x2y+A1zJbtKqjpv/Qo
         oCXGLzuWSPNVTiRJdPlKwIuBjgprHkS5yprP7q6x791P+luXTl4ASLm11BEjaiRxnDP7
         YSZJQ6igyqktDibdm+sYJ1wVryogl+0EIJUo7GY6RIGWuIMg/52aK2T8ShHUt6UQHw72
         WRgg1GseZgvf6Yx2vukgTGqPs0kP5YWkqS/bsugMAwfvK0tvQjfDauXatYO0l6ccBS0z
         s3bbklwadyXRU8SH3rckGg0OdshNbObG2wJXZpM2uVCVk68zAxKBdh44Q8I4imDACvpD
         a5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780600660; x=1781205460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZgS9B26QsTpHWA8E51iGMnKHjz/LU4T3XSbX16NycY=;
        b=NWvtrMX1ecvuy1Csm8r0QYluGo3KelNbOFM5wUXz77xVozDnMwoC3RSD+/EYHh/rmC
         MFZbW4ivVABd+/NYJeYhkgK9MLIK5xPxdAomxGy/sAvXQiorGndtkKfrgm/cInAwmby9
         jIFKCkqumo4vfBQYXmvQSq70wZ5gnK8LFU27G+3eGiuYhi3G3MLUJu62/pBVlgtdiZs2
         z4Ga07OFnty/hA1Q3btL7wFPPqj1NMzFu4DWrthIxuY8Q9PAdhKqohziVCEZrjUTE85g
         wkfBKXgcjEFCdv/uFu+BqB25eS1xx66WfC0JIe6hVMY6ykg0KTZ2VIn70xdfgygPYCt5
         uoJg==
X-Gm-Message-State: AOJu0YzGlLVZpwfSyftVqOjg6gCIZkNqMngGZAlc3o2AjOiIgGE6MIbN
	okgMrVG6Sy0akVw/AYJ54wXU5UycujNEBOg50yrUZSALyXJJsgbrYtd2NMj7Bg==
X-Gm-Gg: Acq92OHU8tZzfwe24iKDTUcyF2xzB35DRuErMP9ES5KssEMzIWLmUgRMDTuBaPz+Snv
	0+3j0ctir7o3CNd4gL5O3pUo3T7mWXhGFMQEtg5JLowwZesVcrAopPGuJ1Ye96wdyh8+IcxVcpV
	K7hf/TkFHgI/80bVXl0PkEqHed4ktDPZo3BCCmShZqILXjaYYK2brpK11mADdJDG3XTMid+SjW8
	hn02bdbtJBaCzYgTCNipgRSZnxtG2j4UAmlYIGV00fS05lfqIvC308uOlb+0CssduoiLcebnl3F
	6LkmL9M2WKgNRnT3qjYebHjf5z8MD77O9wop6VyLZgt6CCI8wknKIcsrZdiFCQuyC13TkzY8gkz
	/ZXUZ9CoRNPL/9LdjRmHzQH93c8D9nB0AYwBw8aeJ+WdLt4Ih9BP4OugdNfF2zgSV/XRflr5Bjq
	xW2CUHD8vgUrk3iXlfWnn0TwOT0fsEnK0EnTNLDnVqahw4DW6tYVnGo6bF
X-Received: by 2002:a05:6214:53c4:b0:8ca:16a6:3d52 with SMTP id 6a1803df08f44-8cee60081cfmr8774096d6.13.1780600659430;
        Thu, 04 Jun 2026 12:17:39 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb93d8sm61444446d6.16.2026.06.04.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:17:39 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol/cil: Add check for too large of file size
Date: Thu,  4 Jun 2026 15:17:27 -0400
Message-ID: <20260604191727.52013-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cil_add_file() add a check for a file size that is too large.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Add '\n' to end of log message

 libsepol/cil/src/cil.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 83377821..18b98fe2 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -549,6 +549,11 @@ int cil_add_file(cil_db_t *db, const char *name, const char *data, size_t size)
 
 	cil_log(CIL_INFO, "Parsing %s\n", name);
 
+	if (size > SIZE_MAX - 2) {
+		cil_log(CIL_ERR, "File size is too large\n");
+		return SEPOL_ERR;
+	}
+
 	buffer = cil_malloc(size + 2);
 	memcpy(buffer, data, size);
 	memset(buffer + size, 0, 2);
-- 
2.54.0

