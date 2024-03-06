Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014DE7FBDC
	for <selinux@vger.kernel.org>; Wed,  6 Mar 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735698; cv=none; b=T5mz6nwIvwTpbcgM2PtmZs+a1zg9VsdUOYPLpSViWXE/gou4EAnbp9l3cHdK2SucE+GgMQRLg2gcKlz6z4/a/no9auRfqxSVuJRewTj044Iskgwg2g8+vXrpERH3lDjKsF1CkyNY2DbtbBU9b/41cQZ46XlOmuHo3buBJPPcQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735698; c=relaxed/simple;
	bh=xCbHelLmFu+LfIJrn8vZ6+Id7Y2BQwNk2VulJKyzeI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkT741hQPRpnn9uSe02z9PPMbYZlG6isodKHHoutjftgrzBV86VKNQYERJoN7AjcEaryBU5SKxmGV4lC4R7fClj/SssMkHr0vqfP8nac9tnPcIfLhTrzyyBzrdygVRa1sllE9gdEESlTtgfJqlLOb97qk56I8xAlAoLrmiMr7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsZxdtZe; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsZxdtZe"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-781753f52afso478253185a.2
        for <selinux@vger.kernel.org>; Wed, 06 Mar 2024 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709735695; x=1710340495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbJPeLYG11ygp18NhJ8hVYjJ5zA97l6uMQaoqKwYsjM=;
        b=MsZxdtZektV7Q28h/sYZEuql3/mY4ZaN1IWasIOfF+4XOF6AmZAkiuQK+3N/CUlWJu
         jBbbdBc+Y87euQ4JaN14DgO6zGX7AXybtLl7JRqVhKEFUO7S66vud5YGW72AG+hEEUW5
         5ESlmMR6r7EJe/6b5YiYxULtA/5UoyzWPKW+LROAqzlT5luJx7AhVDPYz+ZXFbkDEaZw
         32bXZXMQ3kq4jR9J7+ruWRlHWgNCKEZ6hB9Z1MBodZ24ZNdexgcbUTnoqmntXYD0i5Hd
         hJZsbZ5Zfa8ESxb9F0Ws/DbnPZkGJNtTRdZK+5mkyt88Sb/VcF4pWyu38Haoh6HrQaMb
         EZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735695; x=1710340495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbJPeLYG11ygp18NhJ8hVYjJ5zA97l6uMQaoqKwYsjM=;
        b=A9yiXBc6AwVfc5Nz7EUJgR4RFgYHMPC7ZlKFTo4oj042gvEDY0kpsp3+ilGPxMsT1F
         tq5IMk1+/UXupqyPOxm8y/1Qz4ur2T0nqp2sD4dk+DCteC6sajGWMQS+ioz1wdqTmoqt
         BFVhnhn/p9EHVheGtOf6d7cuQURqeXmSf0GboN7Gr52NvZm7SGak9wLYc7knHg5m2diN
         w9bTsiJGFPWlixshOJH7P2sbTUvIVb08/xfXd1E/s6vbzTNfOwhNwbEGSeEQJGLiIeUF
         c7KXPnzGEILIVScNH3Ni0HhCBFcfupuH3DhQeFsOBVxFlv5YzmxrcaVUTX/L0XPttN+g
         0q5A==
X-Gm-Message-State: AOJu0Yxny3qaQclEcvqlVHB2IRJ6ZbZgO5om9VVBPCNbtyri5Bw/sg5N
	HBa/vxd22RkoFpF2DDd8HtJmOIdtgB4Fhgz1KZAjop8NU1/g5alCB/kS9zMr
X-Google-Smtp-Source: AGHT+IGrlr56bh4wXe5DvpnbT8jBIH3VJqxl2OmlM4E0F2m8a3kKmB/Cfm5G4OYjuqpTv0G1JP43/w==
X-Received: by 2002:a05:620a:4094:b0:788:4240:2af4 with SMTP id f20-20020a05620a409400b0078842402af4mr1216591qko.72.1709735695600;
        Wed, 06 Mar 2024 06:34:55 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id x16-20020a05620a0ed000b00787b95c91d3sm6660965qkm.62.2024.03.06.06.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:34:55 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] checkpolicy/fuzz: Update check_level() to use notdefined field
Date: Wed,  6 Mar 2024 09:34:51 -0500
Message-ID: <20240306143451.2256235-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e16f586 (Fix potential double free of mls_level_t) renamed
the "defined" field to "notdefined", but did not update this use of
it.

Use the new field "notdefined" for the check.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index 0d749a02..a3da0b57 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -135,7 +135,7 @@ static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg __att
 	const level_datum_t *levdatum = (level_datum_t *) datum;
 
 	// TODO: drop member defined if proven to be always set
-	if (!levdatum->isalias && !levdatum->defined) {
+	if (!levdatum->isalias && levdatum->notdefined) {
 		fprintf(stderr,
 			"Error:  sensitivity %s was not used in a level definition!\n",
 			key);
-- 
2.44.0

