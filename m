Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2CA2D
	for <selinux@vger.kernel.org>; Fri,  7 Feb 2025 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738899035; cv=none; b=sDnu/5/ObhxfMh+D9088Gzr38aAsEPgtSBkc/76OzVcmmfd6Rw0qKc6wIkks4U8hS0duGHn+aqSY6NMi5iCmq8KlCETPcFh62bVvcdL6q3rZR2Fb3FruRcqw8r2MAU+UEHGMQVStygXGe2QFkZzJqXc4Ry410hDVGf4+oarx++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738899035; c=relaxed/simple;
	bh=DFqAJ2DO9OkDC3ufc+kZUwj4CLSBT1lLeQe/EbQGSHk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DWKHGn/DPnn/0Q5iBXQbs/6Xbjq2dlNDH77xLsvjqGxi8L+DXgZ7AmTmGGdQuZFpl7KwvEC3Zt4bVOAimLUTEvfGS98od3dBztKteY1g6UF83tqzWbOMXNZl5mJqol614X87FV5vzgaq50EYGNe8mwgfoWDkqjxpijavdhiiKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GCrRKbja; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GCrRKbja"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dfbc45355bso18327156d6.2
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2025 19:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738899032; x=1739503832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQl9SSuxU5fl60LAI+eTj8wVreaokPOLmf8nxgxwFeE=;
        b=GCrRKbjaageHbA6niemZi4ej75IiuU83Nk2jVNJ90udU940XBNu7qiIkU2A8XMYdOx
         zyJT35dgBSipwRD/zqwNmvfbSdgcvoPyJfzWc5BEgvveMq4nJrD1ytRo3tCTXtJebShv
         Ey3Jb7uLd0Lcp2XpI7AUAI2Y8SeWs/3gz5cjtOWLanFhTSJB7tZHOg5vgNnA4zP27FJB
         Hj/v/OGt9ZDvU0kUI7MC+bCT0Wdyn2e7bmpNdqsY8KBtFdX4Rv2B4byiM5BSyLNNz+Hb
         D7QrxbbsOXZzObaQ2frUIeKd86+oUxNKjsSyOHNasjQHLMqnuiLvOrRUt0QeaTprtsus
         emHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738899032; x=1739503832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQl9SSuxU5fl60LAI+eTj8wVreaokPOLmf8nxgxwFeE=;
        b=b85jGvFUgFb8+N+M8JKeoLfodn4YVkEAwVydMPzkyUwlEdd7b/KkRCeyJ+MgeyNnaS
         DRQI1S0tQf7J/WWMmsL+PPNdqR0qx0691cfMHdlZAXrVZ+4+0l0ArTbPLNlFYtcWaTpK
         sD3nyU9JfFu6N59ExpPbA+Zs30rV7N3Fmi+r6yO2YZESH4cTSr+5d6CwEyt53kK1Jf4I
         5wW2V/5jKYNZavwLeaiV7VFiSXfwfFoHqRxHToY9MMIiveOWk+IwWS86h2higrIIDvQz
         f4JMnJ58DN8FTdDkJb2S9uo6rkXLAjZbFQArDnWkqgDR/ZKoAvh8BeuWg3KrEa1q70of
         gErw==
X-Gm-Message-State: AOJu0YzwCGJi16S3VhF9s/9ec0cSTueOw+dV6DLtC742nshQpKJ/Ci9j
	QHtMRbtuw677CLGg+5Z6uddtClrpWWoWwHz9swvxUS8+G7ZdSY54Ap8c1A6REVmniZiYHyCBZ8I
	=
X-Gm-Gg: ASbGncs3PIEDpUcXE1JzECmQOgtlBHASzbzjWX/BC9SI5YKdwnXGplcz3UVKZMj4F4Q
	BD83DPfKOFwyZzBa9eS7GE8WV3WjNv0+oj0e8VLTxc7doVSIr8KxXfDK/Jj+TI/WFAY3lNeryq0
	QIVAG9Earl+iw1Bnxcu6/A0hPsKc3yLRqWEcAky0GooVgxwweJJbJPxzit8yyCeOFH1TQBUWh6K
	shXO00n3ooyBpFiCkrmMk8w32RqSNmQMx6wlltB9BJAwtPP3fAXZKgO7fGlYXXo+ErXQ/Ruumyd
	ur/ZYt6dCA==
X-Google-Smtp-Source: AGHT+IG+wxIJPXe1xdHZ38e4gu9eRFLnPl9ezNG2TTsvAVCraYCyM7eM+/KhPs9FxGGIvzk9crGngA==
X-Received: by 2002:ad4:5f85:0:b0:6e4:3de7:d90b with SMTP id 6a1803df08f44-6e44566e6e4mr24780466d6.25.1738899032476;
        Thu, 06 Feb 2025 19:30:32 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e444b5ad24sm4881266d6.103.2025.02.06.19.30.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 19:30:32 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: always check the file label in selinux_kernel_read_file()
Date: Thu,  6 Feb 2025 22:30:20 -0500
Message-ID: <20250207033019.479292-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=paul@paul-moore.com; h=from:subject; bh=DFqAJ2DO9OkDC3ufc+kZUwj4CLSBT1lLeQe/EbQGSHk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBnpX5L7FiWcZt+soHDhy1McwAr1gN1DYkbjwfhs WWLm0R+w2eJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ6V+SwAKCRDqIPLalzeJ c7m9D/9us7f71QsA6cToqR1rFRukBYmlIQ3OVF/kv1DobM1gRmGykA+E/kWmPeLhnoEBzz1bh7n Q60GM6uWs/0IfrM1IGnXW1xD2qSzL5sEZ6TgdpGNYumN0GjP9+eZ4FyY3Rx4Hi3LDBn48U+/Dhl bw1YHtIGa4t+kM3SqwLwnlBXc9Oh5ZHwwT+oul0tbTHCErsJQaF1zeyK8DYhgYpbbUsfTJappct 4kRbqxlDWkdg7cofcr43ukU+O7h7My8jSwxSfF372X966tdlqQEKUDvQiHkH3QUf70DZWpBUtJu FaMhbE6xuikK2RcjGP5obcG0CrrrZyL6bL4cyUJGqLu6SJhT220NdLSLUWsj5kF1vs9h9+/eZvL 3w/SHq9zSNoCOHI0o/WEAZuul00gbSWz8fpVLa85xblxsFYiY1EWm1jxqMSmLiWnawTGKry7E6P wkCYZfloJNubmtvwfcNcysHKAjmZbtZwjg+LzWHe/CuAHa7RuAfmunU/X+0BEscocyb9ho0V2JT wx2rmW5AaaRIA5czuh6SSh8lUV4pxp+0tzOkjq8nHrufaa4TfZJh83gqTB3VLXh2+URAgeB3Goz r7Jtpe0ej9V96ujyLJGZBnjHc1FcJJhBCzwm0KDa3oxSSKiACHyacXoDgwAeZNJ0kXvUeREw9jF Xowze1jsSc3+vAA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Commit 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
added a new flag to the security_kernel_read_file() LSM hook, "contents",
which was set if a file was being read in its entirety or if it was the
first chunk read in a multi-step process.  The SELinux LSM callback was
updated to only check against the file label if this "contents" flag was
set, meaning that in multi-step reads the file label was not considered
in the access control decision after the initial chunk.

Thankfully the only in-tree user that performs a multi-step read is the
"bcm-vk" driver and it is loading firmware, not a kernel module, so there
are no security regressions to worry about.  However, we still want to
ensure that the SELinux code does the right thing, and *always* checks
the file label, especially as there is a chance the file could change
between chunk reads.

Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..a80e3f01153f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4134,7 +4134,7 @@ static int selinux_kernel_read_file(struct file *file,
 
 	switch (id) {
 	case READING_MODULE:
-		rc = selinux_kernel_module_from_file(contents ? file : NULL);
+		rc = selinux_kernel_module_from_file(file);
 		break;
 	default:
 		break;
-- 
2.48.1

