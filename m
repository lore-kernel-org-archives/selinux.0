Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E13F9F4C
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105623; cv=none; b=Q8orTdQCWTGjiA5MJNE12PICnwTfo+GWDz2pxIFB5COeyW893aVMFMaCw8vZJAu5M/mBsCBa80HGxpMOHkXlud+cNXB4vH1pKrOSyonQXsn0zFtlF8MX3I5QWZpxrZ9mA0irRSsk4828+bGpcdk5bxaZYHPCaOSGR9D0IiJBRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105623; c=relaxed/simple;
	bh=LqerNLiciiHNimQgRaggD3ywbGMNM5jbbmr/jdIveAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjY5rGL3ll2MD8WOo7YFPnxTkc9+Ptj2e/Shjr3UAMk/7Z7rc0/IcmClxby3qacE+b2NSMs3cFAf9p7fbT/8kM9yDubOpTk/MQRk5vt5ieYvQtbwPo9PkU+Dh+5OQT+Nl7ogHLVe9Es/f5B8uNir6SulkZibBlX0gxtv81b8dRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avawsmn/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avawsmn/"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e5eb0fabaso32450121cf.0
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779105617; x=1779710417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxdclqKYXIgo4AXnA2+/MYElwqfunizu9hhDsSUCvo4=;
        b=avawsmn/fw2ReZq2J7me86IeGNDFhTxPSnfBoheAkTc2O7JfTBbFuh8UEyvYApkMYx
         nCMF37ohqj30Z1xtg+0Oc+rTO5DufQLPYgJQl5auk4TzmRS64S69fEIoiAWp16Sm2Bxd
         3S/pQj6D5p5gMKKjAPlpTwJFTkWEepEZxi7/AXlNefk/NhMA9P2Dm/QgfURSDt44ZjJ4
         78kVMBHhtX8DXblbO+uduXOBKWv0bNA/PaLjvHpxfRnDHar/FMn3sq/9I3zhxTPbIsHi
         fm681VK4Vw7eqSGW6H4opscppbOX/DIib78BrZB5bDSuGlctmCfE7GVg9GkRRicrBHOK
         1yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779105617; x=1779710417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZxdclqKYXIgo4AXnA2+/MYElwqfunizu9hhDsSUCvo4=;
        b=iuv5BXc4+FA3PnpVZxXrKDwvqDZFSrP6dJ8Hq14UBHJTVNtYfoH1buBULp0w0aMMWl
         wg7EtuKhxf71E/G006uSbK2Tjwp0zsKWXODNvI9AJWzS3ObVXLzVu8LY9iiEQ0ETDNjX
         G3tMiQbNcrK38MPdRaOC+pFQFQG9gYc7trBd6WDI4CAnD0YQybw1bO7CM6lG3PZoY5kp
         dD7I1By/QVBujoNo6/LERKllELNZToFLXAca3v2bkFb0pnoJzkiilWVuMsyedTZKHtjm
         ViCmYZwTKTSc3cmhOX3ML+8ZrMNXJ3dVpZuvUxL6+8xAq/Lrd1E1hpHthwRYPGFvn8Oq
         cFPg==
X-Gm-Message-State: AOJu0YykHSTObA6nXSXgH98qlrYz5koU9gf46LBYX4uvqpJNtraOPoNd
	D8P0y6kyE4Ids1OQccLBUykKKHGJMcRxYW8xgi1R3BAXaPZhst/z47+IVPozRw==
X-Gm-Gg: Acq92OFmfWF17wT3IDZCi1Vq/136JZCOaAixVlW0N+C0q5X2iet7wEiOfYCuARxkKqW
	cb/o2m7rSrB8BQ6uN4HHReFaeMDhQKjMSdJHaXVlQMr76Z0ewfA+sDFtHC9Vov4cUSYmAuTyP8q
	nGXDou++ELUWRC6zv7hIAbQf9mzFpu6gBAmIX/80eSVsLRwiBz4Iv/RSwHImnXHUvItDe4nk+wF
	kXvglIi+XSF1EsSYXBPwITV17REMxa5+/2dP8VuhGHTSmeQHwFoEu2tRLCK7x54c5mmSYHfVIbm
	uZVXESeF+JQqIO3qybkfjCyMbrlxIyNyPe2fZcP9b9Vv+6/Z1f+Blk7mtOZZB4UxF1s4QzdEG1j
	wZxD9gSi+/BaaS0Z6zaMubwp2RfyLGZVsTlBT/oGZeK6Qg4vyGlyBWF8w1mj9AybOjrjAC64BEg
	8uIuOY8CaIxvsdEDmyZP17607B9jTEvKIxumkYPN/cbCn4hHJqzrkfpwukXc/DbZAYQo9yeKHzb
	IyhgStyu49M8Graa/c29HxER2jofLQ2XN2bMtK8WYI3WvJn0cU6bkI=
X-Received: by 2002:ac8:7f41:0:b0:50d:9cf7:18fc with SMTP id d75a77b69052e-51659fdd595mr209145621cf.11.1779105615948;
        Mon, 18 May 2026 05:00:15 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456df09csm129593391cf.13.2026.05.18.05.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:00:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 2/2] python/sepolicy: update for modern python builds
Date: Mon, 18 May 2026 07:57:44 -0400
Message-ID: <20260518115742.352949-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518115742.352949-2-stephen.smalley.work@gmail.com>
References: <20260518115742.352949-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup.py build is deprecated and no longer working on GitHub
CI runners.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 drops pyproject.toml since it is unused currently.
My earlier attempt to convert setup.py to pyproject.toml failed.
Therefore, just leaving setup.py intact but updating the Makefiles
to invoke the modern python build module.

 python/sepolicy/.gitignore |  1 +
 python/sepolicy/Makefile   | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/python/sepolicy/.gitignore b/python/sepolicy/.gitignore
index 32fb47f9..80824997 100644
--- a/python/sepolicy/.gitignore
+++ b/python/sepolicy/.gitignore
@@ -2,3 +2,4 @@ build
 tmp
 *.bak
 sepolicy.egg-info/
+dist/
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index ccb22fe7..4a4a3512 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -14,11 +14,11 @@ BASHCOMPLETIONS=sepolicy-bash-completion.sh
 all: python-build
 
 python-build:
-	$(PYTHON) setup.py build
+	$(PYTHON) -m pip install build wheel setuptools
+	$(PYTHON) -m build --no-isolation --wheel .
 
 clean:
-	$(PYTHON) setup.py clean
-	-rm -rf build *~ \#* *pyc .#* sepolicy.egg-info/
+	-rm -rf build dist *.egg-info *~ \#* *pyc .#*
 
 sepolgen:
 	ln -sf sepolicy sepolgen
@@ -26,8 +26,8 @@ sepolgen:
 test:
 	@$(PYTHON) test_sepolicy.py -v
 
-install:
-	$(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+install: python-build
+	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` dist/*.whl
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
-- 
2.54.0

