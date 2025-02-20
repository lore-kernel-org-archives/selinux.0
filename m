Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8221DF735
	for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086003; cv=none; b=hS7Gi2pqTJCDg2jMyM1uTB6sXcPlo+rp8tNF2QUVHl1jEh7qLU3pA+xlyEllC6zP163k1pf9Ru/JBih2zoD55OO2qPLehOV2BfCIBq2sJbOT7Bx3A+vjapzoImOZe0v6vdIOyjNQQlaOggSlRuHSdQ9oFF0tJyGENAuJfegx2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086003; c=relaxed/simple;
	bh=kwaF2DNIph8YhlDyP8NPsyeFoka7CBeWB9CX+t6NcBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhZMt0nQvWEPBrnkOSOXH9hrp9+j2m9y3njrUwQbbNE4AsoanFgNpoE8Kg8k5YcbsamuesjITmcYZmY+q3uet1zBuH7RQsszE9Fu7+AxKi7BNHnosUw0nphdyMSxLuMoTSH1JD4wH4a7HeKgAZqs6rr/Do7IEgq6OO+BIom1V6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ7c0/FE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ7c0/FE"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so825520f8f.2
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 13:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740086000; x=1740690800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVB/89gECu7C9KUBEsEGb+zk43O2sbt6SQ4uAaK2x7I=;
        b=fZ7c0/FE8SfcAW9AOZiyhA6uBTPLvkTdXdp6Mbhr4CrO7mioyRbqkijn/hHoBZCGUG
         bAsBoU3eXm3IhVzSeFnQW+GImg0J1Mdcm2D7DJnflr46PLW674Tid/sFkfIhI3ZT0KLI
         3QdIy6mM9UZRqU3d7Ca10E8peiqttxO1FA+wNDYFAuS9/xOpH+Dv8d8mREeK17vonERC
         jc/xmLSIiLvdr/rmGunbTdNdTdQ/8I2/BHzPI8nqpC+a9EItxV0oRoQAkWuGuAQf2/AH
         DEYnoa5xtstcPBR7lKJTYUCcprMfO715dKADVZTld1kx4CY8M4fJ/4VIaVwYbgfcVJ9T
         ABQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086000; x=1740690800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVB/89gECu7C9KUBEsEGb+zk43O2sbt6SQ4uAaK2x7I=;
        b=pBsXf7Thi3pJTqKe6rmk1Wr778NiXxzYSJ7ub9o9cLDg86//iA66yeBZsZ7B57ZUik
         GfOWP4yXpUnT5SzJtnRYiEaSJ/KAm+YIoV04oJZft+BYkW1sf03PZ0lFsyQP5cW8ZqNy
         42WlsYv3+tYyaqQ8Tlrm3rkXzHbS7MikXFFtB+aAmkTIuVfIU3BjefoLzpd22SZo1um7
         HMKgOrNx17q5epWR9uNSQCLxDtmAvYM+Pd+z1glNG5j7tHh/3ViLL5RofAHuqX7wuUFx
         6EbRjLXpVRyTh6qYGetON73vK3QRoQ6vJQATok0vczRmAGUP3Xr8f5DxNzW9HyTj6wW3
         WY0A==
X-Gm-Message-State: AOJu0YyFEWqjwpjbUl4tJFb8eJQzsWryhh48LtJw9ohvYX4yoObd8qSU
	/FL1UsyF3BLSbtd55+NyMSOJ4dySy3J553Vud2o+XrCLY/jHw59UHziwOXQPxmo=
X-Gm-Gg: ASbGncsHEMbuG733a8RbKfvzYDEfU2mk7yP/yE4qy4i9tbPvtdbrBVvvMnbyng/DREX
	I5hkjMfsGwN7O4Y/hQV0eir+IHRazbogZ4100xRSrWlrj7qjHHmPfDBGBykYTMlgGzEshVFmBKn
	luNdti2JuZshSvynMW68C6vrgbUQN+6dsZIEEEgxWgUMnZ+Nlmb6DpPwtvnoIpSjBjyY791s+c1
	2Q4HoGu0pTEJ0JrYlNdaDkivvnmRutS86mlicXLXwLF+ViD4Am25Tz/3jNltiqZQ+WElh30ctYX
	GKsSJrmScAeCFu9fUhf+iw==
X-Google-Smtp-Source: AGHT+IHF5gFTRPaAZi9O1Jcljz0fzEZ2S8fYpmal5Jt2zt4szcCG3lBVkx7Ag5o0qaTADSQIiq5x3Q==
X-Received: by 2002:a5d:678e:0:b0:38f:3a89:fdb1 with SMTP id ffacd0b85a97d-38f6e982ba0mr479882f8f.30.1740086000314;
        Thu, 20 Feb 2025 13:13:20 -0800 (PST)
Received: from localhost.localdomain ([81.79.13.113])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f25915785sm22219515f8f.58.2025.02.20.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:13:19 -0800 (PST)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libsemanage: define basename macro for non-glibc systems
Date: Thu, 20 Feb 2025 21:12:49 +0000
Message-ID: <20250220211249.574456-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing a const char *path to basename(3) is a glibc specific
extension.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsemanage/src/conf-parse.y | 3 +++
 libsemanage/src/direct_api.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 6cb8a598..97cc5438 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -50,6 +50,9 @@ static external_prog_t *new_external;
 static int parse_errors;
 
 #define PASSIGN(p1,p2) { free(p1); p1 = p2; }
+#if !defined(__GLIBC__)
+#define basename(src) (strrchr(src, '/') ? strrchr(src, '/') + 1 : src)
+#endif
 
 %}
 
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 99cba7f7..4459a7d7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -63,6 +63,9 @@
 #define PIPE_READ 0
 #define PIPE_WRITE 1
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#if !defined(__GLIBC__)
+#define basename(src) (strrchr(src, '/') ? strrchr(src, '/') + 1 : src)
+#endif
 
 static void semanage_direct_destroy(semanage_handle_t * sh);
 static int semanage_direct_disconnect(semanage_handle_t * sh);
-- 
2.48.1

