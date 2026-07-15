Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E73AD525
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134722; cv=none; b=f1E2H1NLdnQJNVfNBVvguxOJMWG8Qs6oCZWfjFIO4XUNJ6CAaboy8DcQmpW4wuXm/e4Evjy8ql1VIySWPvkpdY7Be6Jr3bj2PZPSjzX1PFpJAWKi/nRnlEO/wuqQ/Ar4fphqOipygc1VEe77aMRW4ceQU+DD7wOmJ39tcr+QnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134722; c=relaxed/simple;
	bh=4qDRsQc3xYSFqdOoJL7TD/DIgoVaCMF7lelY4npwFTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPQ9ucofgNrDaPGKs1KV/yA8pF2A6u7QyOirYwE/cFQlDqUkkEFJjqmwZZU8FKbSqZ2rGaj6NK5kE8NLr4v9ZFtiU9Eg6laKXsPPEKWcdZXeJgVb8hK0tlXqwTMdUBqatXA30HNvH/c50kUuXnJ6+jAb1kgWSPZoaeZQujvLVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJlAr8KU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJlAr8KU"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ff20870ac7so42207776d6.1
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784134719; x=1784739519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6NljSlW+xF5jAAxuUMxFX4OQjRFQXt0Ay2yluLmllvY=;
        b=HJlAr8KUVDIbtG21ZYqfmIkNgWLxHL3u4MU2yj6dqmQcHXn7vR8Y2B+l8F6NMX3FZN
         OOy3wdaXokDbCWnhtD7mHmE3ebPQXsc9ozJkv2sVRq7qvENGWCmL/pH+v2FUAhGgcrZv
         FwBwJaZiXup9i3fvgDDyDruWH6sDmq6wY2JEylnqgHc9OVYN9TD+LhOYXQOjuu6ESuM3
         3zCVJoOCIC/lKRLFLFDoCU5YXNgxoZKUJYRrWQiO2s+MvBQMDgMIYWmEQxF1zIcFYoWA
         UpsjVCd0DgGQtPmPgqEESt1ufcGoEZJsvaBGxtbUIkzg9HfbHm+uQ4fqwET8356CP2xT
         yUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784134719; x=1784739519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6NljSlW+xF5jAAxuUMxFX4OQjRFQXt0Ay2yluLmllvY=;
        b=Vogrhtbb/Rkvmv6PX/N9VaON0kT8naigb7uS9DINmPZ1QTEY5JfI4CmZNR+AQoYv0C
         aIthrb74lSpXM5vVYdfEw3gnQ5nDTighigiDdKJ8qKD5M11CfJv4dpNm3zu7y97zm8+e
         3DlGGPUWetjMnQoYvYUPGHdLXoWs9VfLg5SbrKuCuKR5ZzCmMxwgeiJEEpMrPfeDo+TU
         /K/OaPB9UlpxMgVMZm5Xt377DwZnE1+P/8D/uZr3/wxKZuKY3j+4jAkE7weTGJ5KWUto
         WtIFHb2mnV9Hu214vGr9QQrE/tFiRbj52+mKSpmeTg++FWb3LSJuTWMZrvdrK9s+ZpZw
         48KA==
X-Gm-Message-State: AOJu0Yw3EVpqjp1Do+ShvL7opa04LDEXxNcBkXAlo1skb2Up6sBzXT43
	8CYs+gyOwoRJW0PlwOEaUyWl7mzTpLPifuIKjv2R/WSIDVH/l+en9xWzVqyx4g==
X-Gm-Gg: AfdE7ckVMEtceW2/fYpUrwTYKVItDX+KLqDyLqLJdRVyXmgZFwXZYp+RALx2x/f7LJ2
	oO65ZR5gNhm6biKhLZUhRj8Up1t4AnDfelx/pWkXsl1Pt79TUO27E80U3b06qNnx3bL8GJZtpZB
	1Vi+cbEqENCLLOh4442+8z77fNKCSYX9NH55luJrO69ul2jYcyppSzrNO96EmJgfjpQz63rqdFT
	52DZd4ofEvusbp1UWBxiwRRJIV6ouX8MYn2NESrcZMugP/S/NdrnT2bDfqkWwswheN0+qpo7LEY
	XUlNYW5Wm319cTMTMgaOjJTJuq4g/vxVpY9gWu/335NuO/OY4oLK3XKB2gdMWjH+ndDT1+bz1r1
	zgcv/0nPigWbj8JDk5LgiGV8oUiVts7NqnzG6NfAqK85gsvzzkUMYqHp6X78d6oVXFW8lYCKaOi
	uLbYEvlcF6subd8humgekIh+bbnfwCVgU/DZu140ZvB4JA332iXuFYX2Af7avAry2FAvPIBGQ43
	IHmVwaMvBanzyqx
X-Received: by 2002:a05:620a:6019:b0:92e:fe59:d619 with SMTP id af79cd13be357-930868321f2mr727031985a.10.1784134719472;
        Wed, 15 Jul 2026 09:58:39 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a08esm1710274585a.3.2026.07.15.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:58:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: user_base_parse: prevent OOB read on truncated config
Date: Wed, 15 Jul 2026 12:58:24 -0400
Message-ID: <20260715165824.43247-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the configuration file happens to be truncated after the role name
on the last line with no trailing newline, semicolon, or closing
bracket, user_base_parse() will incorrectly advance the pointer beyond
the end of the buffer and dereference it. Only advance the pointer
when a delimiter is actually consumed.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/users_base_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_base_file.c
index 4aa2266b..05904b3e 100644
--- a/libsemanage/src/users_base_file.c
+++ b/libsemanage/src/users_base_file.c
@@ -115,7 +115,8 @@ static int user_base_parse(semanage_handle_t *handle, parse_info_t *info,
 			info->ptr++;
 
 		delim = *(info->ptr);
-		*(info->ptr)++ = '\0';
+		if (delim)
+			*(info->ptr)++ = '\0';
 
 		if (semanage_user_base_add_role(handle, user, start) < 0)
 			goto err;
-- 
2.55.0

