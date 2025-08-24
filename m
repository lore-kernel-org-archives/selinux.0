Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53C63CF;
	Sun, 24 Aug 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756040488; cv=none; b=XhEKX4vZZSUlRrXC0sq2mVtJDd3n0kKSQfGWfEjjF9YPOBmdsPor7SDkv+PQbgl7smInUet9TVY/9b189z+Fv8EuVlHzpK/e18fc0T3u6XI76VjnJsh7F5slNAAf4kEHDIOlxbVQoO8cZlJgG8Mqr7wTwFPK9TbBaIouFMXjhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756040488; c=relaxed/simple;
	bh=LvLWkRWsIeOf6NGUdt0kQlLoAKQB76D0gaPoo01bo10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0eDYCHYwTzL0eq25E4shTlGFbYWnP+s14Y7oSxDcai3gD8IZ6su9uwt1a4PWnpWUdBkGNWpt2mt5rDGz5PqyriWtqQMxVWntgaz5PWeicRPW8oqw/0CbKwWG8aqoU7doOOpB9EZPGGyDWaS3sSwtA/9H62ykrn60DxpyEUWiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ257VOE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ257VOE"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49e0686139so238155a12.2;
        Sun, 24 Aug 2025 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756040486; x=1756645286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WdtmoFnhUndDWFNjWRi0T4BWTY/SZFRvyi9P38L7+6U=;
        b=GQ257VOEh0lLkU0oGXQMY8WhJNdJ6zqVGmXWMCtrWvyzgvajKP+aYwoLRbmlaMiRRa
         0dwoVP0URA/BU75anEE80Zxyu0xQZiVQfddndB8vKFujL+Sufsp5NpAvZqv1MppE8c0R
         I0qaHYcIaBw8zDPX5jNB4S8o65dukNei4w9tN4B/7Y8mZxMZ/PRwIjWBVvJNbr6eEFAd
         GH7WU0ksddupWbHvZ5/AZ4bytpkEss0ICpI7YYOADAeqrAP7zZJvgxP8OaZesX2eStoN
         nB2CSn6YXAap5vevVxwg1Hwo9Q1sUYObMAj/ALD5Ymml4sCL8R4/oFxOV6wlxn2ZchMl
         NcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756040486; x=1756645286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdtmoFnhUndDWFNjWRi0T4BWTY/SZFRvyi9P38L7+6U=;
        b=nTfhVEcviK3wporYtB/XUqUhAC3wEFgvBlyHT+34Lz2iPJIRhqspLFfoaXQ8hoHrkl
         P9vkQ6WXmsGxIPoBmwCcMsdLqGY8EU+E+AYinJScc8zCzd6WZo5Myd3k7vcKO3RXaJTY
         Qz6nODnhqvPFzKkezq5yfpZnOEWrHmQOtpRyUJeFL0im7z0u+Pz2jei4sKxj9/WkvKJz
         eqNPFTaH4mTepLp+mOA1+N1D4QMsnDTldxYYfBdWB5QXRS+7Hfm9oIMZn5tQJYZSfPFg
         KChYroWSk16+vYXssyOCsj5Tva19SW1BQheJZlc00gx7tflIMr4E2GFOj60J0S9Dn+mj
         olig==
X-Forwarded-Encrypted: i=1; AJvYcCXLGaCKBaKlRlkYWH6zSGGguIctMBN3QeWIErvORwqaXpqp9MYWoGK/FAxAhC2gw4rKq/InMY7qJl/afEQ=@vger.kernel.org, AJvYcCXSVcdQi+T62bWvTk9k2EXNfzJ36xa8+Xzc/eU6XWGVHY50Miez6w0eYtfdwXD+Mtv6UJSVpZ1rlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfPoazLupZuTcl+BEuXp/As0qUJ6QWoqsc6zOMuPwvSoh57SD4
	pUGSVV0KH6J42kdgAF5XiRiUBfXqMrKzcU49ZzHuoxo7Vh3yVwVb9gH1
X-Gm-Gg: ASbGncugXsdtNqvdrUnuEYZwCY0dlVwiY0duSyytFjmPJS/9/BuIdi2Im7oaFA7z9pp
	fKj0hFf/3fTaOzh1KiNv956VS84zh/rm67RDruM3CNVRbdxV4hX3AdHRj9T4I89/xEOEZSF6JOl
	PJuX9ho6jYtihwCzM8lKEjr+waoH78St8DfscgP1Zki7X7ZuSbDmkF9b6ZMypgbz6ceFMZnvA/J
	BA4kjCBqD6Ait3bUoPDUrWEWG0U4JdI7G3NyB19hlYwOXWLwIOBqKeQ+vtL8d1A8GUTdAmpsWQD
	sLO7+I7pIvXYYvPVarBKdpnh4sUMZHEOFy7niECz05ykZgO5+YKkAmJeoaq9UMQqpfrvIsqnUy5
	LqTFB7GTA7NHO3lQCEpiJVipkEW/VwMrblYJF/a4uqAcZQu/HYvM=
X-Google-Smtp-Source: AGHT+IGfumTqQjdkvrkufL4RuFklj+Ouv1djCdjnelVh71reF++vy2VU0OtgK4LA/aGbQ691FSpOyg==
X-Received: by 2002:a05:6a20:21d8:b0:243:4b5d:5ea6 with SMTP id adf61e73a8af0-2434b5d5f37mr7596962637.26.1756040486060;
        Sun, 24 Aug 2025 06:01:26 -0700 (PDT)
Received: from yugansh-Inspiron-14-5410.. ([2401:4900:1c5c:9483:43fb:2a6d:1506:f2f1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb891a00sm4317861a12.2.2025.08.24.06.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 06:01:25 -0700 (PDT)
From: Yugansh Mittal <mittalyugansh1@gmail.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com
Cc: omosnace@redhat.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mittalyugansh1@gmail.com
Subject: [PATCH 2/2] selinux: make __inode_security_revalidate non-sleeping
Date: Sun, 24 Aug 2025 18:31:06 +0530
Message-ID: <20250824130106.35366-1-mittalyugansh1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the blocking revalidation logic in __inode_security_revalidate()
with a fast, RCU-safe check of the inode security struct.

Previously, the function could invoke inode_doinit_with_dentry() when
may_sleep was true, which might block. With this change we always avoid
sleeping and return -ECHILD if the inode label is invalid, forcing the
caller to retry in a sleepable context.

This ensures that __inode_security_revalidate() can safely run in
non-sleepable contexts while preserving correct retry semantics.

Signed-off-by: Yugansh Mittal <mittalyugansh1@gmail.com>
---
 security/selinux/hooks.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c95a5874b..2bb94794e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -282,19 +282,15 @@ static int __inode_security_revalidate(struct inode *inode,
 	if (!selinux_initialized())
 		return 0;
 
-	if (may_sleep)
-		might_sleep();
-	else
-		return -ECHILD;
-
-	/*
-	 * Check to ensure that an inode's SELinux state is valid and try
-	 * reloading the inode security label if necessary.  This will fail if
-	 * @dentry is NULL and no dentry for this inode can be found; in that
-	 * case, continue using the old label.
-	 */
-	inode_doinit_with_dentry(inode, dentry);
-	return 0;
+	rcu_read_lock();
+        isec = selinux_inode(inode);
+        if (unlikely(!isec || is_label_invalid(isec))) {
+                rcu_read_unlock();
+                return -ECHILD;  /* force caller to handle reload elsewhere */
+        }
+        rcu_read_unlock();
+
+	return 0; /* valid and no sleeping done */
 }
 
 static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
-- 
2.43.0

