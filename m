Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F73C2BB1D
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9446D20678
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 11:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rhsqU6Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgDGLpZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:45:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45880 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgDGLpZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 07:45:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id v5so3453661wrp.12
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ioEaUl/s9NHA5qh7qkn/dLhOhW19KIiagRG6TRqJr0I=;
        b=rhsqU6PgmTXEZi12plC0f6yRN7HGNjwLxmcC6WLIig+/FOBIljGXpq65I2qWCjU45Q
         kUKKrySSd/zO2lJRpWQ97wzeHVX2XTfcC3GmJa5w73lvmCHOKH5gZgNt73dMPXQ0du26
         Mgj1PQ+n2GzRM++j0QeBSFbB5x1gRVWtC1Z/lvFy+pAPI67/MG4oojLmTgOyVdFzVBp+
         +fzVKen1SLnj6I3q6gYENSOKYdFX8pmCKB5LQyfyKbUJCl/GMsc2XJvSf35UgkBeKDud
         llYnoGISyc4ETWryx4sewXRcHEo6RfsuGSKqitMSSWs+n2RF+x9oa9SXFwbprpGdENId
         V6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ioEaUl/s9NHA5qh7qkn/dLhOhW19KIiagRG6TRqJr0I=;
        b=ByRM+BoGrIkH6w+IVzSaE/ZiVLKqurI18hmTj6ly9Qu8ZeeHwqtSQPlh6dhND/B/ui
         FTOJpa8v/lq1y0zuDEQkw5cRVQsmqC5t+3RLOs59k0kUKuypGHmvC1SShA4F9J8P7Urf
         1mxjwGJRPAoVBzm6UYuCA3cs6y49JPOFjuaWubjZvbYeSIgm6ZSarmMgwKJc8mca6tHt
         sL09Grb62/g2N7XySBX0ejp29E1jlxv+C0Jvnxi/d67DfZF/uREIpDw1Pzr1F04zhEjN
         hXgPvXkHAQYTsKeIzz/585hIloq9JHMet9Wj7C/E7IYsLd8Aoxg/GA0rGyG9V8p6Qr3y
         i5rQ==
X-Gm-Message-State: AGi0PuZGN/zQ2Aaa79cppO749qOrO1V4SStyI9ADCMekskY12bACrGpk
        uvxafyOYGAn1NsP+/Wuv0AqPART8
X-Google-Smtp-Source: APiQypJoH4dqNHLDisu/yxDpB9BiHDdMbhpKBhcsHys41SSPYZJMD26iiMnziHgLav4gPy0v25QsBw==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr2323783wrm.26.1586259920889;
        Tue, 07 Apr 2020 04:45:20 -0700 (PDT)
Received: from debianHome.localdomain (x4d01eb9e.dyn.telefonica.de. [77.1.235.158])
        by smtp.gmail.com with ESMTPSA id y7sm29576925wrq.54.2020.04.07.04.45.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 04:45:20 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] tree-wide: install python libraries on Debian with appropriate option
Date:   Tue,  7 Apr 2020 13:45:14 +0200
Message-Id: <20200407114514.40253-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Debian the `distutils` module is patched, so `get_python_lib()` returns by default `/usr/lib/python3/dist-packages` (no minor version).

But `setuptools` affecting setup.py is not patched to create the library directory at `/usr/lib/python3/dist-packages` by default, rather than a command line argument `--install-layout deb` is added.

Add this option to `python setup.py install` invocation on Debian.

See https://www.debian.org/doc/packaging-manuals/python-policy/packaging_tools.html section B.1.

Fixes: https://github.com/SELinuxProject/selinux/issues/187

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile  | 2 +-
 python/sepolicy/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 2d1c654e..3efbe3aa 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -173,7 +173,7 @@ install: all
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
+	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` `grep -qxF ID=debian /etc/os-release && echo --install-layout deb`
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 69f29fa9..54cd27ca 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -27,7 +27,7 @@ test:
 	@$(PYTHON) test_sepolicy.py -v
 
 install:
-	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
+	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` `grep -qxF ID=debian /etc/os-release && echo --install-layout deb`
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
-- 
2.26.0

