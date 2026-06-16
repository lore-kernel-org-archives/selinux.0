Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FBF46AED1
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628125; cv=none; b=XDMCuaBJULXpRUsd+b62BsVmOc5k6o20kZVZp+VuaNAeGGMp7CifCMwy4rnmQBLgs6aA55mAO8kDn1rndxIDc9RtUI2z+sFWCMzPX+VNQunr23yUCm5tIowj37PK3SNX5mZytOCdURRpaRsZ8oG/pxymR5EcvLGgoisxiqaFxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628125; c=relaxed/simple;
	bh=6q3Nart+WuR7JRTVqwjmus8iYi/Ia9WmwNVQuWoK0os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxDj00Ao4ED31Mlj56VlL3dV1+H55LBl4w1J4s4Dt7At8d3pqTvzFTku2B32P2Q2mXNaV6qOBmjHrpwTX+cmPOQJ89Jum91KerezXethh4cG2IuHa/2YFAfY5OHFkc/VgOy8dpT4P57eWtkVwJfQ+yYuhSJ8ZxLeRMzHLfkUdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtcrFXGI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtcrFXGI"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9159477c893so565973285a.0
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781628123; x=1782232923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1g9eqI/0XQkmCozYYts4dp257HaXNhl59X3a7ox/ho=;
        b=WtcrFXGIa3IaIpTeQ+nBZZMfNB3xq50r5qI8WNa+moK+3TVpY9HgY+adh6kB7gbhnu
         n5Jiyg9i1yCI4/HgG+N+DCYmMUH4wv05YGYHpFweVgcKyaN5bCK26E9XOUSn19SBnbif
         KmkD/0gCE+uhY2F0EXJLxrdSLAfk3aCBZSzQf7C1pi7FnN9tgY6kTs/ExAVGYz/fXfqC
         3oTHyR31dJR1ZpXD/2gehaYCmBtHEckK38BUgjKpgyPZ3b5dpzcc5nGweX0zgI+XLqOA
         kvXlEpAVi4KhNS4TEUlOSGsRcERGVOO8RATeXowBAEMrGaNRpcc/9C7fuc30Jh7aKe/k
         XIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628123; x=1782232923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1g9eqI/0XQkmCozYYts4dp257HaXNhl59X3a7ox/ho=;
        b=Spo3KyZtieF9kvfEKwG606gcVtUnFkEMrDly++wsDeLKrhr0l9cMEQG+2xvKEl8r9W
         cYUXnrGk8wsoUrBbAvztyrksh5h9AYDG2WBjXLDhFUhtstRuv6lTCdywN5uh/lgf3AiO
         IEepIUnMA/Vnki0sFcRnEZc7GjwwWFqJhyKZLvVIxaSCflrRmrShabgxK2hDS3D/vLDj
         M2/8GliJ1jliVuG1zGe/uqKO21kmD4bBczYMBEYThc1VR5d1D8/YsfiAPP8zOhnF67RF
         29EB8yr788vDs5zMxIYjIFRAnfXLEbUVjHKFc6uTA0uWmIez7m5eR2jZ1rFeJLge7DXg
         EZBw==
X-Gm-Message-State: AOJu0YzTg1fTYiJesrB0vu0MBvRf9rnacI+dmz1ltDzaM/NNM7V0cni3
	icr9bo8hogWwqEL2i2qVVLq3BLe96R4O8FSNgqzZGz9ZFR+hV7xr6wGx8YvCTw==
X-Gm-Gg: Acq92OGcMCmPMsVTDJzuLZjM8r/ocZQOA8qjs9NjjDJ1pMkzQfQ28ly8xwmk/8hoY0H
	AyNXQNWyg66G9c7FHXjO+Bl0pdi7cyH47lEe8JOtbfGiYU+VFIttL8bAvNPGOefTFmuNgc5fdHD
	2Kx8LAoW0iNs1YMB3VgNGuU517PqQWQ5Bj+E5KkWWzMfDtKMIe2gWxxIvzzrWnC44WZYEzBF7zZ
	9SWJkrNOSGS3tFQjpMsu7grdtO65DE3RUAR8Q4ogiSrRzTL/9K374qpI5KBCn+wDoJzMxSUc+aO
	yGJqMAI2IzUAuWMSHmpkcwiGF83XsS03507bzoPVlTKL+8qIaPbb1oyUeo6ZjDazkguDP2Yy9z2
	mxmslURpGpYl40NJzMBUG94yXCJxcs43X2Bahp3u6myvUY5/KTeOFMlA3hzztpVd9hkJluApZMA
	JoKbjJFTiIWbrQCCMtaleFJOw1RBCTTa89AixPieIxQXna0Q==
X-Received: by 2002:a05:620a:29d5:b0:915:f92e:98 with SMTP id af79cd13be357-91d8856dcf3mr83784885a.8.1781628122880;
        Tue, 16 Jun 2026 09:42:02 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f05fd1sm1516572185a.11.2026.06.16.09.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:42:02 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] secilc: Use fstat instead of stat to avoid TOCTOU issues
Date: Tue, 16 Jun 2026 12:41:48 -0400
Message-ID: <20260616164148.50283-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For secilc, secilcheck, secil2tree, and secil2conf use fstat instead
of stat to avoid TOCTOU issues.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/secil2conf.c | 2 +-
 secilc/secil2tree.c | 2 +-
 secilc/secilc.c     | 2 +-
 secilc/secilcheck.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
index 4046e603..9c028656 100644
--- a/secilc/secil2conf.c
+++ b/secilc/secil2conf.c
@@ -147,7 +147,7 @@ int main(int argc, char *argv[])
 			rc = SEPOL_ERR;
 			goto exit;
 		}
-		rc = stat(argv[i], &filedata);
+		rc = fstat(fileno(file), &filedata);
 		if (rc == -1) {
 			fprintf(stderr, "Could not stat file: %s\n", argv[i]);
 			goto exit;
diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
index f0f02eb3..039d1524 100644
--- a/secilc/secil2tree.c
+++ b/secilc/secil2tree.c
@@ -155,7 +155,7 @@ int main(int argc, char *argv[])
 			rc = SEPOL_ERR;
 			goto exit;
 		}
-		rc = stat(argv[i], &filedata);
+		rc = fstat(fileno(file), &filedata);
 		if (rc == -1) {
 			fprintf(stderr, "Could not stat file: %s\n", argv[i]);
 			goto exit;
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 70359b75..016ffef3 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -282,7 +282,7 @@ int main(int argc, char *argv[])
 			rc = SEPOL_ERR;
 			goto exit;
 		}
-		rc = stat(argv[i], &filedata);
+		rc = fstat(fileno(file), &filedata);
 		if (rc == -1) {
 			fprintf(stderr, "Could not stat file: %s\n", argv[i]);
 			rc = SEPOL_ERR;
diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
index 45176df4..ee141bc0 100644
--- a/secilc/secilcheck.c
+++ b/secilc/secilcheck.c
@@ -148,7 +148,7 @@ static int add_cil_file(const char *filename, struct cil_db *cdb)
 		fprintf(stderr, "Could not open file: %s\n", filename);
 		goto exit;
 	}
-	if (stat(filename, &filedata) < 0) {
+	if (fstat(fileno(file), &filedata) < 0) {
 		fprintf(stderr, "Could not stat file: %s\n", filename);
 		goto exit;
 	}
-- 
2.54.0

