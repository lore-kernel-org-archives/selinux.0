Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE9C4724C
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB5120757
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 13:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a8ursz89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgEANqX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731007AbgEANqV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 09:46:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C18FC061A0C
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 06:46:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k1so11595425wrx.4
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HfBsHhh1nhaffrop3uEhaXcY4NM+NeE+9v5GRNXXzJg=;
        b=a8ursz891VglNre9L64iNznZOnEVOHU+KFzVAa37Kx7AqbYfUomm5fGVOrB75Hgbsm
         BC6P0yvKEF05QnYaKXBglcjtwyEKyx9OXv/XZrEZqSTrHarBECOVkPLZ53ccSfQ9GU5h
         a1T20ThhXOfJwi6YiuvVTvHJ9/Lvf+Jinlbd+7isrDMobReUTFHRM1F5AhTV8WC6zZv+
         /CiP7MZLsgB7Ip+cBMG2hFdgO2fJqEkj+Xy/+5Z63Nker+e9F38BAuz5Cqju5R9btqz/
         HA+hFYnLPlCun7O2hVqcnuCevKQ0IYlXs8Iy/0Nue0CRamnPVlfyz4dF+zD/VZKxC++G
         QTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfBsHhh1nhaffrop3uEhaXcY4NM+NeE+9v5GRNXXzJg=;
        b=CEWH3ovU/Pt0k9bbZzFwCHZxRfvcJsyVU7tR3Z13HlP4kpf3rpgbW5Jw1IjfgOPjKE
         I1o0AaAHF1uYvmfVyEINYr4WLAU3vrKox9DNNvf06opq8JSUcbJdHRlpRX17lkeY/0bh
         Dt/uHQa4F+tAXWIg9VDKi35jNpSQB2hZR9LjZikKbBJLErBlvpVy4eAGSEldzxw7MQ74
         IMS2uKKyJ8PzCwnJWbJIR4YmuXKnIzFL88yEXU+I7RDRzua3B1rqsAHHMKGaJU71CNVf
         p3MnLzGG9edC+IwnduodtLv7kq/qx3ZcU8o1rUlYz/f3vTkPT9b6zFNRB1cK5epl6S9L
         JZag==
X-Gm-Message-State: AGi0Pua8BDR5lEFBEjYRIrIGx8bu6OMJNPxYuApjxgC3lY2DMvdZRCce
        o6eqqCFnQQhMiI7N4QcQoMmWVLQzG0k=
X-Google-Smtp-Source: APiQypImp2OJhpYNHFqhZ3DduQBm+uU4yCqkfLbWyu5xMHh8asswcRcCwrNfSBgF7MCvdEn34rWOUw==
X-Received: by 2002:adf:f684:: with SMTP id v4mr2848706wrp.218.1588340780001;
        Fri, 01 May 2020 06:46:20 -0700 (PDT)
Received: from debianHome.localdomain (x4d0a5ec7.dyn.telefonica.de. [77.10.94.199])
        by smtp.gmail.com with ESMTPSA id m188sm3999411wme.47.2020.05.01.06.46.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 06:46:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] tree-wide: introduce PYTON_SETUP_ARGS to customize setup.py calls on Debian
Date:   Fri,  1 May 2020 15:46:04 +0200
Message-Id: <20200501134604.20070-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200407114514.40253-1-cgzones@googlemail.com>
References: <20200407114514.40253-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Debian the `distutils` module is patched, so `get_python_lib()` returns by default `/usr/lib/python3/dist-packages` (no minor version).

But `setuptools` affecting setup.py is not patched to create the library directory at `/usr/lib/python3/dist-packages` by default, rather than a command line argument `--install-layout deb` is added.

Add PYTON_SETUP_ARGS as argument to affected setup.py calls and add a note in the global ReadMe.

See https://www.debian.org/doc/packaging-manuals/python-policy/packaging_tools.html section B.1.

Fixes: https://github.com/SELinuxProject/selinux/issues/187
---
v2:
  Use env variable PYTON_SETUP_ARGS instead of internal detection logic

 README.md                | 2 ++
 libselinux/src/Makefile  | 2 +-
 python/sepolicy/Makefile | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 974280f9..3c97a5a3 100644
--- a/README.md
+++ b/README.md
@@ -18,6 +18,8 @@ To build and install everything under a private directory, run:
 
     make DESTDIR=~/obj install install-pywrap
 
+Note: On Debian `PYTON_SETUP_ARGS=--install-layout=deb` needs to be set in order to create the correct python directory structure.
+
 To install as the default system libraries and binaries
 (overwriting any previously installed ones - dangerous!),
 on x86_64, run:
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 73303c36..bccc852d 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -174,7 +174,7 @@ install: all
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
+	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTON_SETUP_ARGS)
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 69f29fa9..4ad0d4dc 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -27,7 +27,7 @@ test:
 	@$(PYTHON) test_sepolicy.py -v
 
 install:
-	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
+	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTON_SETUP_ARGS)
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
-- 
2.26.2

