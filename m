Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E44248B1
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141375; cv=none; b=akjGOD8skmS4sLSVQGvWUfT9xxxLHElLVrCLnmG+lsYkL2Qwk5YOypWA5sCeIhapWqFuWniAtMogWaNu3DORWE0ZyIE8sXfEGf64eVplMDf95FmUufo6V3wc2A40zl0jWza+9KJ6d4Hjj3bye+LwzulVFq6xToct+RXLQbvaquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141375; c=relaxed/simple;
	bh=3IeYAMWlPretl2BAuDev//c+jO91fKHBaMAIjKzihWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2av2YNEVFwD5C4A4TsrVDETfv4+sv2O8SI9vaIqieSt/BKaMpCgfgkHsEkFo6XD4oxg1RRFTQwbwnbmhRBHOmKK894vyysaOmCAdYqCmSO9kPZI16huBQ9YhZEENev2ym5AAgorQnRKVHQI4SuzPSo+bWuo0fZ/4/6VDGZXNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKvgKKhs; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKvgKKhs"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so52839476d6.3
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784141371; x=1784746171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Ch03QwtKH3Sxtd7LmQcbUMB0NdD4NB1bCjn81J1udw=;
        b=MKvgKKhsNSNgDkGpBrBM8BUdnceUqHm61/Lv3KYvXphgapl94UIG/AOJ7rxmGRStKK
         v4SukJp9/5dvkDXtKWlONfShhNEl878j+MTOSALQ/q4leYp/refJfXGYR+jUA+tytjHI
         HqmCZLJJsOfqYRUiep1UKPsxsNnNg2LGtMXEvESWVIyxMduhO/G3trAcMepADVQzB7Ur
         f900os/KjIhw9VKrv+QDZbgwvGulTkxJ3A4iKGKjmUZwWheyuiKxgLjnYoVZWjd5KoaB
         +J8OPuWVULRT2d3WMt4zwpMdxVW4f/CW5FtfYD6GDQGjochJOGbn5xkfT3Ik1C60QmTH
         s66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141371; x=1784746171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Ch03QwtKH3Sxtd7LmQcbUMB0NdD4NB1bCjn81J1udw=;
        b=SKD9p1sEz9/1EQ3YpCg37KxMIX0jApS2w1Q8VBvpzYxZaquOkTBX5xwni/LGh7UPkQ
         b/hpHwZlXpQ4aOzSePMj2BCODnAepbZaPdH9Ry/UXUl8Yg3qqD7PaMTdRicObresSR9M
         UzSBIrQdixj9pwqio5NqsLd0SpTCbL63bSbGSeXD7XXevA0ryGyzwacFTjmc+9x0wyen
         orRJZ7+Hvp5gynHTC2QTA1ka5eS9mIjP17f3gHuXYI8ZZblzg0bP3bszZOx6c2XuGd8x
         3u+o6EeKQ1w2tVvbAn+9Yq7QlFQmFrFPlsPYkxDLgN5F6G/+vkQv5RD7iwVwWRvEd9/P
         7uJA==
X-Gm-Message-State: AOJu0Yzl7V04QcTnnIfmedAQv/6lF+bmFlj4FIUL5FQxlMlmiR6n+xnS
	Yr/Dra5iwoe6miBKfNaQMx712+rUM25OjGt4U+8efjF792kOJG+9tWYrawg+Yg==
X-Gm-Gg: AfdE7ck3imA7hgEic1V/Q0hi4uYozjeWtrNbpCHMzUwiw87qxUmjhTO7XLvTRdsNsW6
	CLdwqn8DGGR4b/htBq1gc69ivZFfas/mk1XCgCg44j4D1ueat1wRkB7YlzZp9piPurIhsKtwY3b
	ERvADsmDjfkRGHXBp1V09JOjKUF71lDuS47lc0iOUfAuT07CHPKTbIPLwHuR8O4sIbhYH+nnqp6
	+DmD1D0oIFCr4meIbaC9hv1vBICMgtrDoK2z2+3q5IlOV+UYv8hmG3angLRXX4bwMl0y1T+Fp5e
	x7GUlrMVn5yyHXfbx+O+/6Retd/T0+l3lxjRe30eQgYHNaJqjQ1bD2iQxbQeE8XqBXabYkR8UqQ
	ISywZQz6NdAHKmOEGSnplCWZBYbTzzoTJRbLW03soRP8DMOQPmQDiwbSrpPudeEmzIBU1vYH02B
	dNX07hTyKQZsn/7ulNFAMnCqjT+lZ9MAbSgCxTCLqRC8BooI8hS3wZSaKZQ5omwqz7RgCZ5b+z9
	0hMchjajU52SjqV
X-Received: by 2002:a05:6214:4698:b0:8f6:2588:778a with SMTP id 6a1803df08f44-90758cbf79fmr48080616d6.4.1784141370833;
        Wed, 15 Jul 2026 11:49:30 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm198015696d6.42.2026.07.15.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:49:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/5] libselinux: selinux_set_mapping(): reject class tables with too many classes
Date: Wed, 15 Jul 2026 14:49:10 -0400
Message-ID: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent integer overflow while counting the caller-supplied class
table and return an error if the table has more classes than
security_class_t permits.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/mapping.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index ddc11dae..1fd1f04d 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -3,6 +3,7 @@
  */
 
 #include <errno.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -35,8 +36,7 @@ static security_class_t current_mapping_size = 0;
 int selinux_set_mapping(const struct security_class_mapping *map)
 {
 	size_t size = sizeof(struct selinux_mapping);
-	security_class_t i, j;
-	unsigned k;
+	unsigned int i, j, k;
 	bool print_unknown_handle = false;
 	bool reject = (security_reject_unknown() == 1);
 	bool deny = (security_deny_unknown() == 1);
@@ -56,6 +56,10 @@ int selinux_set_mapping(const struct security_class_mapping *map)
 	i = 0;
 	while (map[i].name)
 		i++;
+	if (i >= USHRT_MAX) {
+		errno = EINVAL;
+		goto err;
+	}
 
 	/* Allocate space for the class records, plus one for class zero */
 	current_mapping = (struct selinux_mapping *)calloc(++i, size);
-- 
2.55.0

