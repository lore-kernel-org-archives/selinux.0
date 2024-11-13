Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD461853
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731484330; cv=none; b=bMF0Kvh8+aNPxkT7NATsTqLN+8K40yhQgCx0Wg2joEfSH2g+nHRT09AarMFFpWO06EwKQgTEqHH5BwkGbFbL3KwsSDiu1q5TwPiYyxj2YLq/Hez1eqUkkX7Mv4To5sCrfaIDHrciKd0mG5uIw0V4HTaGZ3TSpcuZUvx10uNLzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731484330; c=relaxed/simple;
	bh=mPHM9bowmFG7PHf2CtF9drkEZOQeIh1gPdDyvziM934=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpvO+YdMEAvMCEgt8OPyg54fZR7lCF8G2HWHC1DGwYWO3dd2m3qdsuaPs5ecsCPesAhejhHEQwiDnyzxXz0Qt9AdiQLmRWOpEKu0/udU0DGMGIxpXK8vCa7oEGGU4HOG0ACWVapO5L+48zR4dP6etjmRkpUYmp2w59q4Zi9MaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siderolabs.com; spf=pass smtp.mailfrom=siderolabs.com; dkim=pass (2048-bit key) header.d=siderolabs.com header.i=@siderolabs.com header.b=Mp1Wa1g3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siderolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siderolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siderolabs.com header.i=@siderolabs.com header.b="Mp1Wa1g3"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a4031f69fso1055199866b.0
        for <selinux@vger.kernel.org>; Tue, 12 Nov 2024 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siderolabs.com; s=google; t=1731484327; x=1732089127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8M8jCCV0g8TEVZia4BDJJEUfgwiZzzq+R0/FoUSfE5A=;
        b=Mp1Wa1g3bHol3CapKwO+ko7fbb5VSmXOfl/loKYRgM9oAHPHYi4gDxkz8MhpT7sZ74
         Xx7nu49G6tITTSMHibTtAlKyo9UFoTr3B1Bd5GZZbjgxrdbiQzHe/DVCPFh7XMuzFb/h
         Mn8BPMOFcH51twhSqoM4fZKU3f0QcHvgPfdp02YZZLinL31c5YCDk4AYBGuSyLntkBoi
         hsYuRKd0v2t/cbsddCQWzLMTBKN20tsA4NBkAXKVe3W/Z4+yLalsUAvYHiK5kxGZw2z/
         yT1c//5goYMpDQ6eVSGGpL+cB3o9h1+LlsW2AxXXRL/0aJ8qSutlcMQ9FApx4MSKqTno
         avEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731484327; x=1732089127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8M8jCCV0g8TEVZia4BDJJEUfgwiZzzq+R0/FoUSfE5A=;
        b=psKXDTtUF1iaeqinTipJZeIHCHHEBDvaIrIQwfx0abZI5UqgyklcVHqqZKYkSqgEwb
         Kxxr7R6vihPp0LpscDM8ab9WmF8wvSrmgrxvip6bLhVD3+w1vXEz1DeUtR46LJ8iZjMc
         isl3zWWJmDMMx0lv5Fmpx1N6Y56A8QHzRrtboErSY8lcwmrzyRq164Ep3Ohhi97QW4p7
         UCgXPYJNXwSXusW69sX4aHIpcVNAeU9dOBz/OLfZA0wZdoMIDgLtuRWdSbZC6QwsexU2
         r4/xch91ajOSuDNkPPrUUdKaF+QSZI+h+8UVtBsuaQK7c4I/7jX+iobmQdGA4kKcMfLr
         PckA==
X-Gm-Message-State: AOJu0YywK758bw18tPEywGKizLI4AtixxDINrBiYEaxcx3J1IV8vMkjX
	SjABmgjRlFGagvx6AA6gjzfUYlvj4zkl6s/9UXr9dtdV4m2gy0GBtBQkVY5DoSCT4vyLtgQTno2
	7
X-Google-Smtp-Source: AGHT+IEb8KnbJgmnYFavbRuM7KjDyOjPReAuH0Pru1WKmixPfyP4dcThWveQdWkQdJ05MVYWkMeDtA==
X-Received: by 2002:a17:907:d8f:b0:a9a:6b4c:a331 with SMTP id a640c23a62f3a-a9ef004e07cmr1866890466b.54.1731484326494;
        Tue, 12 Nov 2024 23:52:06 -0800 (PST)
Received: from localhost.localdomain (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9ee0a188b0sm843073966b.26.2024.11.12.23.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 23:52:06 -0800 (PST)
From: dmitry.sharshakov@siderolabs.com
To: selinux@vger.kernel.org
Cc: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
Subject: [PATCH v1 1/2] libsepol: allow specifying SUBDIRS when building
Date: Wed, 13 Nov 2024 08:49:30 +0100
Message-ID: <20241113074931.2730415-1-dmitry.sharshakov@siderolabs.com>
X-Mailer: git-send-email 2.47.0
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
 libsepol/Makefile         | 27 +++++----------------------
 libsepol/include/Makefile |  2 +-
 libsepol/man/Makefile     |  2 +-
 3 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/libsepol/Makefile b/libsepol/Makefile
index 5b5d03e2..e354d3cb 100644
--- a/libsepol/Makefile
+++ b/libsepol/Makefile
@@ -1,29 +1,12 @@
+SUBDIRS = include src utils man
 DISABLE_CIL ?= n
 
 export DISABLE_CIL
 
-all: 
-	$(MAKE) -C src 
-	$(MAKE) -C utils
-
-install: 
-	$(MAKE) -C include install
-	$(MAKE) -C src install
-	$(MAKE) -C utils install
-	$(MAKE) -C man install
-
-relabel:
-	$(MAKE) -C src relabel
-
-clean:
-	$(MAKE) -C src clean
-	$(MAKE) -C utils clean
-	$(MAKE) -C tests clean
-
-indent:
-	$(MAKE) -C src $@
-	$(MAKE) -C include $@
-	$(MAKE) -C utils $@
+all install relabel clean indent:
+	@for subdir in $(SUBDIRS); do \
+		(cd $$subdir && $(MAKE) $@) || exit 1; \
+	done
 
 test:
 	$(MAKE) -C tests test
diff --git a/libsepol/include/Makefile b/libsepol/include/Makefile
index 1ad4ecab..8d64e846 100644
--- a/libsepol/include/Makefile
+++ b/libsepol/include/Makefile
@@ -3,7 +3,7 @@ PREFIX ?= /usr
 INCDIR = $(PREFIX)/include/sepol
 CILDIR ?= ../cil
 
-all:
+all relabel clean:
 
 install: all
 	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d $(DESTDIR)$(INCDIR)
diff --git a/libsepol/man/Makefile b/libsepol/man/Makefile
index 0b410c19..6017ff51 100644
--- a/libsepol/man/Makefile
+++ b/libsepol/man/Makefile
@@ -7,7 +7,7 @@ MAN8SUBDIR ?= man8
 MAN3DIR ?= $(MANDIR)/$(MAN3SUBDIR)
 MAN8DIR ?= $(MANDIR)/$(MAN8SUBDIR)
 
-all:
+all relabel clean indent:
 
 install: all
 	mkdir -p $(DESTDIR)$(MAN3DIR)
-- 
2.47.0

