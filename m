Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24A175A66
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377509; cv=none; b=qPTF37wlkkJGoeDEXJXFusStAj1Gvzi5m5iJREdi4hDuBc6Glmp3N8lZaqbWQgAwpFfWhnVjuL8U1lc1469pTW4+c7pVITKkPZKCPGKM9ajnC4z1zJ0pIZaCj+J88GeK5jfLstMd4a4SUH6RYjzfvxINrsVI9jVsLoIo5Hs3QrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377509; c=relaxed/simple;
	bh=SH+pJXLEmo+nbK0OoGKVm5E9bY1OHmNpj2frf2blc7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/RfaDUcto5v9u8lt1DHhhbocMlzGBm9Y6Q2eYVoPwn0Ujbc13SNHa6q8z8AqoSMOU7U2Q9CV9lluvdQRbklvjH0rCka85zltv3OJPTCvUWG2f/5xP1BWW7Wfkj9Fw+e8pDzfxiIITN+KyJqrx02nMF6oy1Q+w4LTrZPs1KkAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoxW7To4; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoxW7To4"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so3859610241.0
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779377507; x=1779982307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LcXCXDZdZjvN4Fez9BYBKmMJG/bo8M6/aa7BUCjLhe4=;
        b=hoxW7To4CUh3VemwW0d1RQpIJBgUwhI55ZiInOJLAxk5XexrLPbMToi3QBR741z+DI
         hxZhCKTskHiWVDX7FLJk2UYGno7/SkAHg8MCt72Al0SvP+18zGrW5qUUPTWHaSXTovUq
         oJiST3IOJEKel1XZtiGUNsY3KIs8IBEJNNNm8EmE2cW7pQCJIIXog/zD9ENTBIyawJAc
         Zet7cwHUE19q8rYQF1KbbyXOw2TvBtBImQhETC0oT75l/TKNX+5seWMF0TZHEeCKJzPS
         6saif+LNuac6s8EszLuHTLhyLq22AMMRDa6PvgF/mQydX6GdLiKCmRFiR+aym0pvfLwG
         vpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779377507; x=1779982307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcXCXDZdZjvN4Fez9BYBKmMJG/bo8M6/aa7BUCjLhe4=;
        b=YnZUM+AvjW4lrvJqA/tqICFh5ftFdm5rEgmA7jlR87ts5pOqGNjAuurgZdFHDZAAlv
         1SxPHt3MyzaOI4gU+tjZFXb9iWQSzJgPMpF1gQVw5i6bRYZktjma2OmEZRDJaApCBW4F
         lQW8eQlLrEIRAwKv+KiftvoUpCy7+yYLyfCmiPrNSmvkf4D4C0VM8HhYEnVp8wSVK9rc
         drxtX2qegvH9B2ViDEbruTyy6dB4y1/mGanvvEdbO87yzW6tE3XGBPKXYV4l18ssYFA6
         bwTDDnMNlRvh0lYFaIO4zutIk9KJmUFhEsf0HVkBclFq1Cf4kzDNrrCaF0zmM/PgiL8q
         apgg==
X-Gm-Message-State: AOJu0YwOGWN4LxiMtesp2mJ7pW5COqszNAP0KAdwoSk0wFiU7zZB4FDt
	mpdvRyrY/kQY1awaOVJzlqLUpbl2wmByf5m4vSYWvTpzpzm2j+2AkpvX+CxhaQ==
X-Gm-Gg: Acq92OGq35alzF6tjTeLylDw+KJDRo2EMhmr2iBsp/ui+lmtdXQioPXiYnz1TNGoARt
	2oh/5GP9AlYn+Zncnv8anIKC8rERUMbmB/z6qW/RFttzc8klnvTbgT1jsJLPi9iG2OYsfnT+lFG
	LmAiSZIY73fN/lCO+iizSNT1bb/NouULMig8b+g8k7wUzLWrZfen6GUwULNhhidPbxuM4a7s3sy
	boCSE8xiHZ9uzsJeHBO+JjBWbYgRFGVZOk1e4BUzO3/Ust7lRDNYtoSzBr5s1Wa38uCxr0GHRiU
	fo5IUV6dtTC5FWtLl0QqYf2mPY3ul8fxVpwhrKf0nzyXQjZP32YuHH80alWRbRw4QQVkSXE+Y+D
	FjGVRy8HW9b7SAuhKeEV2D22hkRlF7dvlzqhsB8Qhgk+Nr3aD+VV1z243UvCz8fL50JZH6TW/iq
	7FbzdLOktEoEGAhfVxD4r/tGV2C6e+KP6l69zI3bMIJESsNnocjR3cvU7UmGpdicEMTKonmm6l4
	nhYL9Ea/ZK9rbIMKfEhyoGj2BBqZpue5OsT4w==
X-Received: by 2002:a05:6102:3ec7:b0:631:4580:6a33 with SMTP id ada2fe7eead31-6739960c9acmr2418776137.21.1779377507229;
        Thu, 21 May 2026 08:31:47 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914abb991dasm117280985a.25.2026.05.21.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:31:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: check for errors from parent drop_caps()
Date: Thu, 21 May 2026 11:31:33 -0400
Message-ID: <20260521153133.26631-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure we don't continue processing in the parent if
drop_caps() failed.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 7a4233fb..1d13d261 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -1242,7 +1242,8 @@ childerr:
 		exit(-1);
 	}
 
-	drop_caps();
+	if (drop_caps() == -1)
+		goto err;
 
 	/* parent waits for child exit to do the cleanup */
 	waitpid(child, &status, 0);
-- 
2.54.0

