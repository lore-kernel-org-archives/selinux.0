Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BC187553
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731484333; cv=none; b=lvc3dzG0UKRTqdUEID/quK9q6R/qtRsngl5F4BYslR/U6nZRhWGROZProzeO6DeIyYFGAWWA0WPbJUMU0rzvFKr4tbPJATG0npzkBV68tjpCtF9HZ85u2PIOz+IE85zIUXc2hQwmdWSEW4fKAredFXOvqs7cOwesWsPGvTfAYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731484333; c=relaxed/simple;
	bh=a8Z2mzQu+WK1myt6VKqSdTsq/tIo246LQ67NgZxzoik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZA2zTVrpXDmGpH4tfIwmtvugl8O9Mc5WkulpcslMoQOCWW+aarEnOTZAj5Uz2ISGbKeKaM0YmxxuLGrTDd08ZDTIhbDqxx15yDiMp14hxjcf0DQYRcv8XChKgVBpmPbsXkyvfye+UFsGXH8jF1DPtAMipMdRooh0gYuHaxj25rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siderolabs.com; spf=pass smtp.mailfrom=siderolabs.com; dkim=pass (2048-bit key) header.d=siderolabs.com header.i=@siderolabs.com header.b=YVQNjPPN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siderolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siderolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siderolabs.com header.i=@siderolabs.com header.b="YVQNjPPN"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso538409166b.1
        for <selinux@vger.kernel.org>; Tue, 12 Nov 2024 23:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siderolabs.com; s=google; t=1731484329; x=1732089129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vta2hTKUoT8mjgmgJ007gxUyzwfbdEkpwkD8e+YtOik=;
        b=YVQNjPPNyEO58qFyGArG52gDroDLuN1b1uUJ90Ke+pati+ey8k38tgXGFHIopnUYQ1
         8EI2DAwSjFYX7UOOR+BLrrzaPDoIh6lSw5DJr1FqBefXtahrI01zjYMtf39NGQDXCXjJ
         N1qmhBPr1GIWe7L4m6hYN5XYINjRsaNuThOja7dZ9eiWvMYTaFx5xn7qA3/DCZAczK4o
         1xZDBkH50LYozhFw1AnN+l9+dZeqG2+i6SpXH1RvsbHD/cnBCCKD6TZmdjt7pDvcUc33
         PMeYQ5RcojhrW8Cx+UgfQyfttxSPmLMITp4uh3ntvzxbd5NYLRA8p1dwzXYh+wdxc+NH
         jPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731484329; x=1732089129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vta2hTKUoT8mjgmgJ007gxUyzwfbdEkpwkD8e+YtOik=;
        b=DE4EVG7uuIDZ15Je0DoX0Zkc/0OVb4K2dctW02fZtnOrj8orC77x9fnUDzp2k9Qq+N
         jWAwAC3fBM3NPmMYdf8375/O2uTZTUQcu37z0tQNWnsRyf1KUmuwFm0uX7+SiAoqi+rJ
         ulPI8ehexbLKP690FOxMmq6STZcPHh1GajsCbaUs93oKi0EjuQPF+ZTKguh/W2hOLLPv
         ShU6srhdyN0muDlR9Ib0l0RNSDCT04jCkdvLSQKHHt/arULqimJE5DsOJ2a01Z+tCnju
         GXoRo5gFJU+b8+rtXVrbCf/rUZejiBAlsEz82+h0YFfyHazmjX0VVbBGjW74uTkEuBFq
         cCWQ==
X-Gm-Message-State: AOJu0YzJmJq00tziWMRwzHe/meJnjo/b+LMrzQPPKOab8I/AialzCqDd
	Ooj890ZGubRGo5Bc/6HENt52Kykox+a16touadxliksT5ydwsscZSCclAUfjI4HoP5LamQWRf8U
	k
X-Google-Smtp-Source: AGHT+IHMufHaftHFNuGRCV4gRlL1tlBkRmm5hrqv5DSfX34mxIcG29aOOZhdp+9PUFlWbV5j5VqVoA==
X-Received: by 2002:a17:906:c156:b0:a9a:478:2ee3 with SMTP id a640c23a62f3a-aa1f81062bemr159633066b.40.1731484329105;
        Tue, 12 Nov 2024 23:52:09 -0800 (PST)
Received: from localhost.localdomain (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9ee0a188b0sm843073966b.26.2024.11.12.23.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 23:52:08 -0800 (PST)
From: dmitry.sharshakov@siderolabs.com
To: selinux@vger.kernel.org
Cc: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
Subject: [PATCH v1 2/2] libsemanage: allow specifying SUBDIRS when building
Date: Wed, 13 Nov 2024 08:49:31 +0100
Message-ID: <20241113074931.2730415-2-dmitry.sharshakov@siderolabs.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113074931.2730415-1-dmitry.sharshakov@siderolabs.com>
References: <20241113074931.2730415-1-dmitry.sharshakov@siderolabs.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>

Allow building without utils and man for minimalist builds which do not need those.

Also make the Makefile modular as in libselinux.

Signed-off-by: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
---
 libsemanage/Makefile         | 25 ++++++-------------------
 libsemanage/include/Makefile |  2 +-
 libsemanage/man/Makefile     |  2 +-
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/libsemanage/Makefile b/libsemanage/Makefile
index 390176fe..66c45c5a 100644
--- a/libsemanage/Makefile
+++ b/libsemanage/Makefile
@@ -1,5 +1,9 @@
-all: 
-	$(MAKE) -C src all
+SUBDIRS = include src utils man
+
+all install relabel clean distclean indent:
+	@for subdir in $(SUBDIRS); do \
+		(cd $$subdir && $(MAKE) $@) || exit 1; \
+	done
 
 swigify:
 	$(MAKE) -C src swigify
@@ -10,28 +14,11 @@ pywrap:
 rubywrap:
 	$(MAKE) -C src rubywrap
 
-install: 
-	$(MAKE) -C include install
-	$(MAKE) -C src install
-	$(MAKE) -C man install
-	$(MAKE) -C utils install
-
 install-pywrap: 
 	$(MAKE) -C src install-pywrap
 
 install-rubywrap:
 	$(MAKE) -C src install-rubywrap
 
-relabel:
-	$(MAKE) -C src relabel
-
-clean distclean:
-	$(MAKE) -C src $@
-	$(MAKE) -C tests $@
-
-indent:
-	$(MAKE) -C src $@
-	$(MAKE) -C include $@
-
 test: all
 	$(MAKE) -C tests test
diff --git a/libsemanage/include/Makefile b/libsemanage/include/Makefile
index 6e44a28a..c08aafec 100644
--- a/libsemanage/include/Makefile
+++ b/libsemanage/include/Makefile
@@ -2,7 +2,7 @@
 PREFIX ?= /usr
 INCDIR ?= $(PREFIX)/include/semanage
 
-all:
+all relabel clean distclean:
 
 install: all
 	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d $(DESTDIR)$(INCDIR)
diff --git a/libsemanage/man/Makefile b/libsemanage/man/Makefile
index 5e21a65e..88143db8 100644
--- a/libsemanage/man/Makefile
+++ b/libsemanage/man/Makefile
@@ -7,7 +7,7 @@ MAN5SUBDIR ?= man5
 MAN3DIR ?= $(MANDIR)/$(MAN3SUBDIR)
 MAN5DIR ?= $(MANDIR)/$(MAN5SUBDIR)
 
-all:
+all relabel clean distclean indent:
 
 install: all
 	mkdir -p $(DESTDIR)$(MAN3DIR)
-- 
2.47.0

