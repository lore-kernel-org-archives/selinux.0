Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13435357CE8
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614563; cv=none; b=GQ5ibP6zLMnJlUymRsBbln6TbufY/ZOCUaDdBIewFsxFocKeE7LR2W72TmFJzUUs0ue1ckvRAy+z/CtMcIRZwzmBXpRxOboUkvwqjdSYhxijt5lmC0Jy8MkeBoAtYtsx8kXDZyvCqOCKPAg5TWuWP3gXhwj5xCFaB7Q7DXbW32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614563; c=relaxed/simple;
	bh=2GOcfbtk505WZ2xsptdY7mpyT6slSW3HfZlDASl3sII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VEGM9WophJNjw6TgbT9iZyJ7YEieQLuhKU+ybhZhpAT/twiELj7b1msNgWmi3Ps+wjKhbE2O+4nKhfye1m4P8U+DH7UQS6j7mujWeWoTtgHKef+mRj1f5VU5qBGr8t8fbHLc9bPG4zucbZ+apHsPQzxneaXzNkeHCLKSxSs6X/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMH5B00Y; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMH5B00Y"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-90d042fa745so168003085a.1
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778614561; x=1779219361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DejYuLfHwOgvQmOdxvybLMBLDqXqu5vCQb9QQD0R5Zo=;
        b=hMH5B00YnKxnc0tB4Ij9bCdyR39ySW5Rd9D7Zxg6r/C1MmM/UJ9LSbEyy/GhROpK+Z
         jLIpBrKTA9dL3WLZW4yzkHHnDOiG16C1/sN6cm/NWl8Qq6DwBw558wehz9MGGgj3m7RC
         gvVTUk/o4m0KMrG7qAI2UCnFMjuqTg18AsmLW3UD7hvbPC45mA2NpYfNLiCovRRaxWyA
         JfMcbztYgeL7sX6NILTG71d+bpjt5j18YUmuEqWBSzuixAzGvX0ZkSvGCbeWkV16sd3N
         +jyfvIU1+2kXdq/PczNKmT9sT9LuNpO14SUQoJVfEaAZX0riusp9zICvJ1i4edy2QwsE
         hA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614561; x=1779219361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DejYuLfHwOgvQmOdxvybLMBLDqXqu5vCQb9QQD0R5Zo=;
        b=cZPrBYWfunZvUJpY0k54zmNtqr3hZcbRGstw1wcj+vAF/ZYOR6p9uJtWWYPRmSRv16
         Cu0bsufeFBJk/X9I18ns64NvyvnnvLWbu45jCc2QcH9HJ/rGtV/72Oy4IZ1RPU+CYSs9
         mCWYdyS4KjfRXTt7vzVQWAk/TWtRY7C0paJrOL/m1NciUwochil/9xWfVhWnH4/dI58D
         p/XLk7BLSth+i5rkGj7BkGoAgmQLu8p8sR32EBMa1sR4kJpFBzKLGrcmuFiFpi6hZNGl
         4AZfZcnx3vMLD8k3ytLv4+dSlWjWuLSNGKOaoJ+c2RuopVa1aYGvJaJTlaNzkaVX0gJI
         NOMw==
X-Gm-Message-State: AOJu0Ywqpja90UBOJGoAQCD1XeTUQByqs1E80psMzMLoVP56m5ozliMb
	EnaRNyH7l0p7/1Jg5RMKa0X4EjD5jjZkK3kQT9+UwI0Sn/A4mSBbjhvMYFaRNg==
X-Gm-Gg: Acq92OF5pvidYmH1+qUNKYrBluQDH+VKXVy0mnASfdsDl22iz8DnTMMjQgZDzj8+iqK
	ICYvNU5hn7ndUwSuCIR8k4VLqNLmPsLT9TWLx+pmOQCip3as+gURYLhhjkOIiyyik40z+g+3Osp
	h8LPcgeoG6KBjorVyhQ0SqNweFwexUSJ8tqkTuMnF2yanbzzSSs+X/9gtJv/6zpyMOzh7PaAZWD
	zOo/JKGoslofAy1TRody7+vRr/0/QeiuNxAr8IhglU17N3bIJMfhziGAa+qPnCMSvWQLffhbOBI
	Q40iU1RQGiopLamAeM6pyg3xyMhAGBE5zD/LI/7jr0YbbMwty5Zhnk5fhoCKNrJXDKFXb/FY2KC
	hgmziOFIFbgfVuEvMruMzMtDUCW3amJpMMCvJzakOw7EvS8PisH+bqLhneGJMNoTYDJexRCuZRY
	S6fRDMxo+1Gfbzc+p7fOUTflE+/4asn4eXDV28XoexfwxhzQxu46qTL48u+xW2dmDy0JET4P99J
	f/Fu5SqRMxY1o67edUvHMQd5LvXPrI1us4r+VRZUGbOzSwr8KbNsYU=
X-Received: by 2002:a05:620a:1a15:b0:8fc:96f7:fea5 with SMTP id af79cd13be357-90f88d99c78mr58064285a.20.1778614560713;
        Tue, 12 May 2026 12:36:00 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90d4a0d385fsm244431685a.31.2026.05.12.12.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:36:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: fix error checking for setfsuid()
Date: Tue, 12 May 2026 15:35:53 -0400
Message-ID: <20260512193553.752163-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setfsuid() doesn't reliably set errno or return anything indicating
an error.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 17a727e7..b9c85bf2 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -858,8 +858,8 @@ int main(int argc, char **argv) {
 	/* Changing fsuid is usually required when user-specified directory is
 	 * on an NFS mount.  It's also desired to avoid leaking info about
 	 * existence of the files not accessible to the user. */
-	if (((uid_t)setfsuid(uid) != 0)   && (errno != 0)) {
-		fprintf(stderr, _("Error: unable to setfsuid %m\n"));
+	if ((uid_t)setfsuid(uid) != 0) {
+		fprintf(stderr, _("Error: unable to setfsuid\n"));
 
 		return -1;
 	}
-- 
2.54.0

