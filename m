Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D4364DF
	for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554734; cv=none; b=jiGe6fIdNvNVZftNuv7t+xitw8ynQ1y3ckWMaKN591+OH4W2c1xPebOLZIQxeln1pPOiVT5q4/hoUyZ8GHRtOtcAHy1iV6ZuKTa20rBCAyXHASY1yZFTkI6ze5ysnWA5I1pge7ERKNSIHoLdP/sjrvi9V8oCwrtPyakClFzQ/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554734; c=relaxed/simple;
	bh=WpB9bxZ66HaugTSacIglvhOQfRQY933iuHvFeBKTy3k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Dy/mJQOPFQw0d1NvDC+FKqmfWf0vkNnsv3/LG2OLhIqjw/8drz6IkTjdIWkNOLHFJ3onPlPYIf21PUwf51p0JqWbzoyDR5+p2wJp7hqAik55opoa3WIz6NZc2J4sQ9E2Jr/UVgcdQpcv7AnAqNihFb2uPbEVM8SP2rIZDS7v4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=blaYe8iF; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="blaYe8iF"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e69a9c0eaeso4010898a34.3
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711554731; x=1712159531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vbfIetE4/DiECH1AzHgnndGqarQLHKpkDnkjh7LWOU=;
        b=blaYe8iFlV8hUl2gt5QFmXvIhYpls+Kur/WUlfRduploAS9RYnEl8zqwz1YhCaziaL
         oZHga4AwBn6zClxsNZCJdSM+FaTpgAXQTZp5wqbFPxuXXNPZasxIylUZ0FIgjRWvIS28
         4bRLpA93QAW0cjhgGW6JpsfWIPKUkEUXwCBKrIKokfOvEdYIH5Z/Xdd9MbKXfhf1/Rgm
         OHrQ9Ya+nVLkJIhZCszSo77jgSBo0UFNPV4S9xi7Zg4uZu3rjKGRzqX4S02/TR7zWr1y
         sLYlsF9lUNkn7xuplsdXUqHicSQ15oM0EDWKwFYpRRnQZ3i/s+/6SPNklpnRLA1FnYFC
         SSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711554731; x=1712159531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vbfIetE4/DiECH1AzHgnndGqarQLHKpkDnkjh7LWOU=;
        b=oNYOoXvqnX5GVVB18VrT6wKEzaNDJSX/mK7YqvbyXEpcXWx2Y2xRUgmpPPdhXZh/PU
         b268Osh8GtVEsVpR1JnglEVB1kfcByBG0xft5ybh2txVa114amFouKcmTLXhlMlaJhAm
         GQaRH6V6+q80E2/uRW/4ZSB4Mku3f4FZ/vgaF1zemZobxDEFYmfrXzpfRhqjKY9cDi8g
         u/sxsmKb8BtpQ6lTeuAFslQ/cXyFNDJlPg+xlmwcxqdp5d2wRx5YFwAH8b/WoqXWzBcV
         4Zq/TkQeArdX4qN/k/hcmcXZvENhhIRm2aYEIQYpXvlUJxb177nrGsSO3y43+++jy8Dx
         L6uA==
X-Gm-Message-State: AOJu0YxIxGhJ1nzwZrclEJc4J1ta7PzwysxZZoO2AXz1TNCpjW5b6CEd
	8HfxtMlghlB1Daa2IJiHG/wnnMEvIpEfvmIEUbW9b4sxbNqjHrK+BpE705C00MW8bVhuSR9+Ex4
	=
X-Google-Smtp-Source: AGHT+IGoGzORse2BD2re811demnzx8GdgniVQLXeFQVpHFgFNvnRUma3zkZ6bSq7EOvRAiZG5ClSMA==
X-Received: by 2002:a05:6808:2203:b0:3c3:d2e9:8152 with SMTP id bd3-20020a056808220300b003c3d2e98152mr336867oib.53.1711554731441;
        Wed, 27 Mar 2024 08:52:11 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bw20-20020a05622a099400b00430eb19dd06sm4874222qtb.91.2024.03.27.08.52.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:52:11 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: fix pr_err() format specifier in ebitmap_read()
Date: Wed, 27 Mar 2024 11:52:02 -0400
Message-ID: <20240327155201.117066-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=paul@paul-moore.com; h=from:subject; bh=WpB9bxZ66HaugTSacIglvhOQfRQY933iuHvFeBKTy3k=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBmBECi/gbTVIZxu6Wb+D013gGMcr9800jxm5fPl dX7GUHZFR+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZgRAogAKCRDqIPLalzeJ cxVFEAC4ttV75+qKqB5azujxJJvKZ0+1ZFy9uX1LjoVdKPg9m6E7vsUizBNeT36Xz/Odvic0KT6 sCtmDRvqvgxEpgrzuOrREmJV6r+zJVXBR/fPuySqVJUGZ4AkKtMvZwVY+NUywfmgWRuRufreP5b 6pJvL/LU1z23y2/hqNVGpDTB3LFCg94IRSo9rGigaYy/rnAGYbut+M5D0EAJi63rUq8nhoOhpgv 4y0kqW9K0JMjfviF/2HAHAhuAUk6vIXVClIStdc8TUfTZR8tiUtoogYbV1ymisVDRSkrGe/mopy ObnB655xcFg6h718McFP9y/5Q5V5pSkZHkX8SEIGHh8U6s3uJ8dRmBBQvm3bDNFk8x8VF7DxWQ5 fL+MKIEOZJaUIUrGgPjVxFyuVdjue7F80oYRPBgMzp6cjDCgJ61zrF+qNqrJ4oaq1s+Uw0MPt00 N6k1g+k4Qpclz1O5Hsk2EQWMmt0F2LOlc5Nj4uOaHu38BTd3HdXkSzfclv/ruE/cZNms11FyAqB XFHEWoH8IQ7+TdNDHieXujAIcj6xpus26xB/VS9fx3IS7Dr3RQllf8hbkq55XYULv+uz7yTEnfu 7bE/sVcBeFzKDAAZvUTJ0NRcFd9Olp9iH8+stgIS9UDYb1CTeoRPA72wE8DlS7D6us3wQzNAmeS Rwpou4tNzKScI3Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Correct the use of integer specifiers when printing ebitmap and
ebitmap_node information.

Fixes: 0142c56682fb ("selinux: reject invalid ebitmaps")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/ebitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index f1ba333f127d..13d5fb47a2bb 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -461,7 +461,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	}
 
 	if (n && n->startbit + EBITMAP_SIZE != e->highbit) {
-		pr_err("SELinux: ebitmap: high bit %d is not equal to the expected value %ld\n",
+		pr_err("SELinux: ebitmap: high bit %u is not equal to the expected value %lu\n",
 		       e->highbit, n->startbit + EBITMAP_SIZE);
 		goto bad;
 	}
-- 
2.44.0

