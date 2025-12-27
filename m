Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91507263B
	for <selinux@vger.kernel.org>; Sat, 27 Dec 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766846386; cv=none; b=gE7f8E/SNdUQWy/xnZCBGjK8udiuzot5fHbn8n3bMMS9ZJhp2NMfiK43JpcdYsectmwhYzcRNaybtGcMuaBIxb78X+Al4g9U8HpMVyabXrvuDAA9iwZFLOfgEuDfJNQZ9ON70shQIiyZK10CIt5MTGbuoVyM0ByxT7GFEQSfLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766846386; c=relaxed/simple;
	bh=sTwHbwLLgikuDhi7t05xlzZJOqk1D+C1+L2GCrCYnoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q72Bz7sR9llg9HVzClY7lxTBSFy/fFyc77B9NhXPWS+wAQcLQudk1Rvvc04AugBf099C0jliFiAzuW7rR/5ehBYr7Nl53ZQGoNa0bRznQqyvuEIu3JeQPaW6GLjEk58LgQafv7/4RK6LjC1NqGqrd3ejaelL+7wUD4hGQrIM/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hwKWPQwC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hwKWPQwC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B11AD1A249E
	for <selinux@vger.kernel.org>; Sat, 27 Dec 2025 14:39:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 775C360725;
	Sat, 27 Dec 2025 14:39:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05C5311978019;
	Sat, 27 Dec 2025 15:39:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766846371; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2OvZX48WfyPPudzwY6s2JDVeYt3CzLepxOdqxMV9WQo=;
	b=hwKWPQwCOdwKaZqQSCUGZATIdFy48c1gnx4ukxfYAKkJIWgVYWyiV4uwTHhLC2zsbzR6c0
	nrAkGL+olKspU8Tvhy4b5cY0GTUZYZuNAJsyw5Pogzjdf/lD2EBK/+a6nNlxC1fh6MJvOr
	8RTKu2vLZQA5BtRm6H/TWG1v6OTeK8gdQPqbAHh98MqYIhaVapfkVD7Qqe0PW8Co6JrA+r
	JBsCF0NKeLzrUohk+iO+PIqNfMPdgus0PaXQDRyHv7tHTJeG+4mKTqliEv6+0gksuYZXF7
	gEMzjH1XlDVDDh2ml8xRyEFYL2Tnp6Z04M3b9vh+al+Ov7MO26Ax+zBWFUBC9Q==
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Bernd Kuhls <bernd@kuhls.net>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] libselinux/src/Makefile: build python module without isolation
Date: Sat, 27 Dec 2025 15:39:11 +0100
Message-ID: <20251227143911.1630813-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Christian Göttsche <cgzones@googlemail.com>

The "pip install" logic in libselinux/src/Makefile tries to get
setuptools from the network, which is not correct as during the
build/installation, there shouldn't be any network access, or
downloading of arbitrary resources from the network.

This causes build issues in Debian:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1121121

And in Buildroot:

  https://autobuild.buildroot.net/results/0e9/0e9de0c0d8b6ec57eea9f8834f02076b296ba4f1/build-end.log

To fix this, we use the --no-build-isolation pip install argument so
that pip install is allowed to use the system-provided setuptools,
instead of wanting to download this one.

This patch is derived from
https://sources.debian.org/src/libselinux/3.9-4/debian/patches/Build-python-module-without-isolation-Closes-1119155.patch,
with the change that --no-build-isolation is passed unconditionally,
regardless of whether $(DESTDIR) is empty or not.

Signed-off-by: Bernd Kuhls <bernd@kuhls.net>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index f7412cd1..0dbba7f4 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -198,7 +198,7 @@ ifneq ($(DISABLE_SHARED),y)
 endif
 
 install-pywrap: pywrap
-	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
-- 
2.52.0

