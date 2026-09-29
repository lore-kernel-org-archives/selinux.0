Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C64FDA71
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686736; cv=none; b=seR2HIoVjBOvRQ556Svsg6YsL1WF3z1aOvTT6N+km7A07Mj2ZqHHD0ZPuYQ9C2N3f0/awncm8gIr7ZqHI6vSSFGspSUCd7aT3cWVPpVCjHgeEXae28XJ/IHPtytaKdQLcTex50KhwhptsKzSdafc27OXD+cTC1cV0OqjFFt7jA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686736; c=relaxed/simple;
	bh=vqPfEMWx40Sr5lMhkD5MVKfck7y8AFA+aK4p5UN6dfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7GGOYDKdx3IjEDP9uS2GXHS9bdC9oc44+f2OMRAY1lUq0Ek13Yik9cz32/hxYk6mlUNhjuEWo7EFEMxXXKz+BsiI6YIcAY+5YR6RsPwhgDhECeq9//sPXAe1n1/SeQMSpE2yp1yHsEhigHVM07Lz0JLZyyv1YmKWt+EghY50Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQGVC2rG; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQGVC2rG"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5f63c54eso245182085a.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790686733; x=1791291533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xs5ys7MBEs497tNij0j++W6BKRTOX3MQoVzfI0J0KfA=;
        b=rQGVC2rGCwhpuzYYngdNfbEtXv7MD/zxqaxepm4x59IAn+HQuIn2+K2HAynelGGmSl
         LBVC9Kt0VM1jh65LekBXQsDfYj/WiQLkiqbHp6i0hHqZaiqfqCRxEDF3f0g8AYbdsAvm
         fjU16V9Cc787uMZ7L3bKePWV3Spewemd8xUXY5dejAcKSKmPKt6GOe/9XLnODK4btlym
         v0Mqn/TyI4X7j80ou6u4eK2EuwbRINCIEBSXq6lzPCcn1T1FbdcJElKDLkGu9zNHUrgQ
         DfzIJINZF1esfTheSsLsaZ5noh0TUh7z3060zQy7B/IpT3AzycraJE378FkMxkL9rPse
         wStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790686733; x=1791291533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xs5ys7MBEs497tNij0j++W6BKRTOX3MQoVzfI0J0KfA=;
        b=arajiDpnntptO+mGx7v1pjlsN8cN+kSdmjq3tWwgnSYRev9p9W9zH5+ku7p3uG2aHU
         eTB5MKB9M4TIhiI2awQ1ZV8t8gqnSSk10qtQx/vrGuzOMEqHKym12QWZeZYBe7pYwmrn
         Rabgx/5Ld1GuohQ0Zt/i5Mu7JsHFHEJrKRR5ztsalM26zX3daeNoe2R7Q6rFKH+7IoHm
         +FjAvyTxd4vnuxFtLaR6j85visxCYmzDrgSwb9oJoUfeJe1PhGpGksDKRssuSHWw3Ojz
         jvcliYwYWFSiH0t+Mi/bB0WXr8Yohc8VNire7KvOYeLZuWQke7KjdWcvVtJU/WqGSUOc
         JJNw==
X-Gm-Message-State: AFuF++m1d7jQKVBhEtBG06wDx6I2ZLZSSUa3pxTL7NE7ltua0RiELyMw
	dOC8kJHW99zbn2h4sVegX0JhLZNTbiUtB7FIgeDv7tpdtrmte6GZJfOi5IoR8w==
X-Gm-Gg: AYBFou0KbwVzwlgrEYfeCten5cb7sDWGI8hNRM7pTtae1G2QNhDo2B2G449t+kyySP7
	zM8E0icNiuPkqwijrAQ6XCYZXozNfbpfndL8nRJvmRoun++zaU8BuQ/nAIcvLetSQcaUd56a2Vw
	Lf2H/lqQam6NW8Q5FJ3n3DKXZjN8UEiFELAbo1XLpRcUX3x6fBzjFSvbOUyn1DTYImHtTMrqFbu
	haaP2hWEfsvT6JCrR3QbNn2Y574gHojGkIPhAVMjUMyu9BxrO8f/sHYZssBoUGGEXJVW2fIq28H
	XdBUuWpadXquf73ySOAyCpOmC73jffbl3WNGiYHNrHxPchduwVTyBr59yIJyAaMg9yfIbNb7nEQ
	2NI/+I8idp9Ti31H1TbFAbuaMfAEa46IIVKJw8zyuX3aO/5xytgyzXNAf5FojkYvQfn07GEytwV
	S07wk4T+ecsK9y+4ijsHddXs3hAeKvaWmY1rhqYFyzS5m3HaolIg2jD2sAIQWTJ21kpXw9KaVw8
	240YkV9O1/7cnOeRd+Dmq1Ty0XTOzEBvpOd7feBsJMmgBOTYLcvHpTOmcUadnQ2jK2e6XYG6sLp
	vzWL+tUbkA==
X-Received: by 2002:a05:620a:4614:b0:939:a9d4:50b7 with SMTP id af79cd13be357-93c43be19f7mr2638946185a.26.1790686733341;
        Tue, 29 Sep 2026 05:58:53 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c81423acasm386005985a.27.2026.09.29.05.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:58:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Joe-Ju-Alpha <joe_ju@alphanetworks.com>
Subject: [PATCH] sestatus: avoid self-referential symlink
Date: Tue, 29 Sep 2026 08:58:36 -0400
Message-ID: <20260929125836.90030-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe-Ju-Alpha <joe_ju@alphanetworks.com>

Signed-off-by: Joe-Ju-Alpha <joe_ju@alphanetworks.com>
---
 policycoreutils/sestatus/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index 6f8db774..54082adc 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -28,10 +28,11 @@ install: all
 	[ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/man5
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(SBINDIR)
+ifneq ($(BINDIR),$(SBINDIR))
 	# Some tools hard code /usr/sbin/sestatus ; add a compatibility symlink
-	# install will overwrite a symlink, so create the symlink before calling
-	# install to allow distributions with BINDIR == SBINDIR
+	# install will overwrite a symlink, so create it before installing.
 	ln -sf --relative $(DESTDIR)$(BINDIR)/sestatus $(DESTDIR)$(SBINDIR)
+endif
 	install -m 755 sestatus $(DESTDIR)$(BINDIR)
 	install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
 	install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
-- 
2.55.0

