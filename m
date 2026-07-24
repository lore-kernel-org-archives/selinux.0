Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2135675E
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921328; cv=none; b=FPmW0Cd3+hpPF51vlue9EWgbErCYweKmGcMBG2v0iHUbFDQeZiSfWH2S6/s9HYnAvE00aFfkzbYgcadzYyAh18O00+8wK2CaIaAT+1Fo2CwAiq9UTdBDSqZDr/2+oYNLchvWmBVVd+zeme0+3iKlP8uuWOyk5HlM649yPqQ0JHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921328; c=relaxed/simple;
	bh=Oa6OVG0GvGOOILQvGzP2Y4b08/t//wkAHygX6iZzNgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3ALXQrx72xAQTTag95l+e+HZ6u+x//UaFGw2JmC5xovH2i+gipSO3qlhbvom/pIng6kvt6cJoTyvorKgXzM2ewjrTX5XSy350Bp/QdUcDaYbHSXzqjjmfkFUksC3z7FqUaQl8PCSu4+0hwSTcxSSEjJ6DGus4w9qvNdB6Pk9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJCrZWCZ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJCrZWCZ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f256eaedf8so9315726d6.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921326; x=1785526126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIo7Hkuct2h6oZPpm68XOYy1SHNcOA8uXYk88+/EkO0=;
        b=cJCrZWCZAQ7c0ZvMZZp3RIr0ayZCkPFe7f9qFYapjHnKrtOLTuKVlOYt9RGsDiNzqH
         wD7immQrUc4P+3DppxjgYkAlQfvlYwobLkHByKWquL1YldZ0g7fFaxjWPX6ARycapZc6
         H9NwVJU4eqRyyyOllFPxGiPD85j3MI8TqzysHeIOWYYLDKLJyo/P96L+MEOPBnf41wWL
         JVLmNMwi+pRawarn5KR4/9wyL3TbSEr2EW+G53XSfs4xK1SzMpO8Bri5yR6R3NJEN5Ri
         TqhVFn++RY+2sPu8x57sZ2IXNvimjvnR64jAP5+VmDNM3XJGh2DxlLCRbzOcr0iie4/O
         cO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921326; x=1785526126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIo7Hkuct2h6oZPpm68XOYy1SHNcOA8uXYk88+/EkO0=;
        b=cpN9AtRf41onxsmY3vyRq/lXBSJSQ3FSQ7uNj6bIhJKgaMjxG7H5cNHi8azYAvB/6Y
         iMryAyNOPX9FmvW8364KuFCUJgm7ynu3R9QrdxsJDViRNXfkQtSWdb6Iy3M9tWi8vtQj
         wKoJE2vpedf8ui7ULirmTg2XzxXpgjZ03fSl6UnFKlsmC5d0ha0yz4IRbRkN8CiYA+/z
         cCee81jylxpVLqtjM5IKyk/NMVN3IzI92daHHEuB5ehHlaad+bhWO6B22n/oQvvvmXva
         iIqatYcWlyV2N1VyHIJ51T0DM03l6VNf/5KEi8Po+RaiQidMK8WG/Sz2h6NQvGhiQrYo
         l0iA==
X-Gm-Message-State: AOJu0YzH2vNX+HWh06TV1Rpk4JQRd9W0aWUTCWtRfyooqmtDCvoIzqYh
	RYttepXrf+PAMf0iCL9TpDXg0duWqVtoR7DPtGqLr9TEQnzTMuB++eg5PVxXOg==
X-Gm-Gg: AR+sD10b1HBFU4bkMcYIEXvxmkzUjQjBc7mos8Nd5U8uujbSQo/m1JnTuWCMQxZfSqr
	GrpK+PA4IQ16UWtCkvVezK1p2YjiXlUBNVR/W2EYAj+it/ZD6P37RPQ61RJl63YIhRjsED557/N
	9HdCu1N4bhGvs2q1PlW05gjMf1Hl9G0vc7erbV6gf8bdxukC9Y8m/suVCc8KdTj3IrGNZUrcM/r
	uvjQ6rSTYMJVlED6ozwTrm4+0SPb3zN1a2x6QFqoCxaebPltjxQIhxp6+IuvERb049bJXEU6XzY
	3J+YfGEkEj0eeY9KG3PssAEzT7uMKLsyfxr/WgyeWKdE1Qw/1rvmMfKPx45jhdKdUAJisS//vI/
	6JlaZ1BguZ+l8gRfN6w9QMDY0aMNDNX4ISfQnGeCloIuS35jUWsU957NZYTtxWTqcQA1PvNqtBE
	vyz4TlqEOakcUhECLjUStB2hNT
X-Received: by 2002:a05:620a:1728:b0:92e:c199:e09d with SMTP id af79cd13be357-93103b26d51mr827702285a.73.1784921325528;
        Fri, 24 Jul 2026 12:28:45 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a88b88sm714770385a.42.2026.07.24.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:28:45 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Use size_t for counting bytes in module.c
Date: Fri, 24 Jul 2026 15:28:31 -0400
Message-ID: <20260724192831.106384-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724192831.106384-1-jwcart2@gmail.com>
References: <20260724192831.106384-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use size_t for variables used to count bytes in the functions
read_helper() and write_helper().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 5fcf5870..fdf05f12 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -345,7 +345,7 @@ int sepol_link_packages(sepol_handle_t *handle, sepol_module_package_t *base,
 #define _read_helper_bufsize BUFSIZ
 static int read_helper(char *buf, struct policy_file *file, uint32_t bytes)
 {
-	uint32_t offset, nel, read_len;
+	size_t offset, nel, read_len;
 	int rc;
 
 	offset = 0;
@@ -842,7 +842,7 @@ cleanup:
 
 static int write_helper(char *data, size_t len, struct policy_file *file)
 {
-	int idx = 0;
+	size_t idx = 0;
 	size_t len2;
 
 	while (len) {
-- 
2.55.0

