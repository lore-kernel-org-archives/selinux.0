Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E648095E
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646458; cv=none; b=ZQMDzAKyeuWWrOq0r7xmvB9TWe3h1FNiYhC3lWDydQ24pKvWq16l7QYCvVDT000F9gF+yhn8yaVkafrKntE3KwsppnU7INyOwAU+tNfAsFafU02OULPGJgxt+gEy4hijLQwmrHiPIc/hMs4NMi7jwXb5ZeEU+v8pcQRfkg/xPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646458; c=relaxed/simple;
	bh=d/DPFHcIhvmUOk7lmhya55VhjURQ24Li5LrDb0tSweg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtLLpfarQOLjk23Og0EoZYvU4fHQiSC0ac1JrtQKBJmWdWL8sq0WPGovH5WmwKc7Z5YU7QSZZ/GOQTi6aDedsI4lGRb+7JR/e7RWP15IC5uF6DAVItwH5+UvayhiiCq6eWLrWe0y4vLYILX0/DORKjOqHmAxOVyptRBR7P8OnAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqlEmuwo; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqlEmuwo"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52cd38ddcdfso1695431cf.3
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646456; x=1787251256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUg/FOnTRl193pd2Pk7IXmQaYj10UCdVOvvVXk3xkNo=;
        b=cqlEmuwo3bVv7v8BNecn9wFkXlCcC4DevZxbGBKhqjuDrHv2DXgvw2DL7AxGRExYel
         puoV3+ubKdwrhgybAzg/PSfuEzImY817IjEyipFYsVbdRDAcoqzPJryZ9+e/HIn3h/iE
         zwbyjprssyLa1hE2WRQV7JrNDuThFnJC2ndROb0t3pgBXbzCLbFGql01V+WJS2DXwOhy
         FkG+nk812noQ8OxYtjq6XcytiAVZaxrLLPc206Oh3MdRzCSAeBf5OfI35DkT27+7/FLG
         gMCQkl7s8fas7P8CpXDc0wxxB/QVH4jpiEI0DHV6lM/CyNuanwv1V3AsfJZzD6dza8Md
         bjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646456; x=1787251256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUg/FOnTRl193pd2Pk7IXmQaYj10UCdVOvvVXk3xkNo=;
        b=avRmZfy5oVlIvr2IVZ/Ku4o98BulVRLVJEJ3C7MPitScgjZJmdGcYgs3ASxmeL5Dt3
         0qEVIpliPKRZQGRZXzJKoLsuxXvUp0Qlpz7kpOa+X3VZJZKqMlq7C2Q1o0TZEtsW46gr
         oME+mjF1mvK3c+dcvrSuWk5YLb7uf4Y85u+KcnuxbAgJ2cqomBBEKKwOys2b9u2oIQj0
         Vttd/9/yObAEeZFBWNcw3vFLjqseXb7wuHMcYKIj79ip1GdoYL8CXGPlz6wSGOvHnnXx
         TgSjhQr2iGLj0FjrIat8cK3qu5Bk8US8rT21bj2H6xDg2Ah3pR3qQCBTzYlJ6FBDVvEn
         mEag==
X-Gm-Message-State: AOJu0YzdUP7qEJCwF7xNX9rH1jQhtZNsCMycymicbmfAaQ65lcheB26g
	UbyA/U2J95ZnjyRVmRJ6Bcsg0FyEzCGugGoUUsVddiL/YZ4dt/wolXdapt15RA==
X-Gm-Gg: AR+sD10+OVelQwGNCRsqT7x9uezkzdBOlhsRpYFTemMIvG9aJclmzrVvbv0hKq5qXOm
	NR1+0IFizyHi/D2YjN+GX0P61qNlFabThkZlskvNkRvwec+SgYCCWwxRtyEQFeJNI3nCwNmi1H5
	DKgETryfhYZiqAvWFKUY7DUrZUfvdr0m0ZrXTmKVd1HLxiRKXXFw/KCSVk4lrIf3xITYr7ar85z
	x2qASmV5inTWRaXa54FuOMngSd/cXZ4pV656ffjfXfOVE7IClzxlCfOdH/uiZJ/8gNI50wIPF1H
	ZGGZyzjZhly2nlYhmRSP6G+3rFSZRp77yuXEb5ah/LqZBoqTF2rnYnDt+4Ej5++mbsROqiD4pBo
	QKOGYD7dnwZOu/TdvlRl+3yv1kHnCdOlVD/nY2a0y6Ruox7CZBomPjB9FHC2Ii0DTRnL463YRPd
	iHTaN8glOaatzG0cmrtW7jPPEUqcwKdBOM5HZdJgr498QGicRoT57XJkBctNq3tN0hr8LrlH5wy
	nVBCg/QbEv7hHwqcBPpUDmK/vt3ZLtZJKv6aWpBHblKBkja00kNUfuBgeEXHwgETA36yQ==
X-Received: by 2002:a05:622a:295:b0:52d:2e0a:8ca1 with SMTP id d75a77b69052e-52d73e3c7d5mr72833921cf.39.1786646456134;
        Thu, 13 Aug 2026 11:40:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a81abc67esm21303826d6.48.2026.08.13.11.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:40:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: selinux_check_access: fail cleanly if avc_open() failed
Date: Thu, 13 Aug 2026 14:40:42 -0400
Message-ID: <20260813184042.185689-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

avc_init_once() calls avc_open() but discards a failure result, and a
subsequent selinux_check_access() proceeds to avc_context_to_sid()
which now hits assert(avc_running) and aborts the caller.

Latch the initializer outcome and have selinux_check_access() return
-1/EINVAL when the AVC never came up, so callers see an error rather
than a SIGABRT.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/checkAccess.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index d8f485e9..3cdd2413 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -9,14 +9,13 @@
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static int selinux_enabled;
+static int avc_ok;
 
 static void avc_init_once(void)
 {
 	selinux_enabled = is_selinux_enabled();
-	if (selinux_enabled == 1) {
-		if (avc_open(NULL, 0))
-			return;
-	}
+	if (selinux_enabled == 1 && avc_open(NULL, 0) == 0)
+		avc_ok = 1;
 }
 
 int selinux_check_access(const char *scon, const char *tcon, const char *class,
@@ -33,6 +32,11 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
 	if (selinux_enabled != 1)
 		return 0;
 
+	if (!avc_ok) {
+		errno = EINVAL;
+		return -1;
+	}
+
 	rc = avc_context_to_sid(scon, &scon_id);
 	if (rc < 0)
 		return rc;
-- 
2.55.0

