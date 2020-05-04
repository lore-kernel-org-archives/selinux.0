Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21B3C47258
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 17:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C578D206B8
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 17:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DuYROHA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgEDRzL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 13:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730215AbgEDRzK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 13:55:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDB8C061A0E
        for <selinux@vger.kernel.org>; Mon,  4 May 2020 10:55:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d15so175449wrx.3
        for <selinux@vger.kernel.org>; Mon, 04 May 2020 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Lbgyhs6A9SXLj4jwL4e3cMnrtCYbtzLjbpMy377dZH0=;
        b=DuYROHA4gvMpa642JsbpcrjX5k3lN1Zdps5AXW2aAwJahCspxxkSFZ+YGos43NeQHg
         LUZf7C+obHPBbzTuD9/0pg9YbowK6XKM6Ex1Ae4Ar5skPajPlivWS2nzC5YZGFSUfzxF
         BK4MjiBVFRfNFjDsCXlkc2jx6w2J/oM/prF9ssEdc/Nt2Hyz+XFlAKxNrKgS/LhMSEb5
         bEmzvLEtviDc9OnMfw7M07bWrndfgBxmhJgcvj6fNxLGYeQ4ZKyNTyLX6xSZ4H0ERnhL
         ayyYUGEx7jArt9ZVHxigevAe70DxBAiE0Dx1WWgjzw8Cq60vmLFbVLnqO3vDNrWwT6d5
         X4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lbgyhs6A9SXLj4jwL4e3cMnrtCYbtzLjbpMy377dZH0=;
        b=kQ78nEy4+fRGzG8h+e0Ph1ue/e3adgcaP8gaNVedg0+OxwsDkAR9kxxe3SXo1rApCR
         VdYSllVHJObGsukb0ni+Rd3QNH1davemPhLi4U5dmvONtlpiOR2gZ2pIN8ezJlnElTux
         vV/ux/mCBu/QxkYElJ8Q7jy3BFFU2gvQYrp7Gx6IqEl3gJq3b/hgKtquRy5kMCfcLB78
         ZOsTkxMHmBa1ZDFA74ld1XI7qbRrhRMBnuyzmBzfGLr2qlMsgcNj95IML0oJ3t0Kh81Q
         Un6QcjFHo5F1omlfft2g/2BcllRup1uErKugRpA4rnIZpD23m1SozbI22zxt1e/5LahL
         fy6A==
X-Gm-Message-State: AGi0PuYDCiv+Fo6knycjeeIEP1X5plZSAEyKMr/DGpxbHRvOV/+u1JJ+
        x9m5c+Ofaw56CQbHqTNfwqZjQZz/
X-Google-Smtp-Source: APiQypJMSl4sehB4h2VW28h0YJSFHT4ycTTWkXTSjvPTtaGSRNAoeORLeqBsTVXEyaaKQH5HKGL8Pw==
X-Received: by 2002:a05:6000:1209:: with SMTP id e9mr451014wrx.45.1588614908607;
        Mon, 04 May 2020 10:55:08 -0700 (PDT)
Received: from debianHome.localdomain (x4d0845b0.dyn.telefonica.de. [77.8.69.176])
        by smtp.gmail.com with ESMTPSA id u2sm18089226wrd.40.2020.05.04.10.55.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:55:08 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3] tree-wide: introduce PYTHON_SETUP_ARGS to customize setup.py calls on Debian
Date:   Mon,  4 May 2020 19:55:01 +0200
Message-Id: <20200504175501.8114-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501134604.20070-1-cgzones@googlemail.com>
References: <20200501134604.20070-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Debian the `distutils` module is patched, so `get_python_lib()`
returns by default `/usr/lib/python3/dist-packages` (no minor version)

But `setuptools` affecting setup.py is not patched to create the library
directory at `/usr/lib/python3/dist-packages` by default, rather than a
command line argument `--install-layout deb` is added

Add PYTHON_SETUP_ARGS as argument to affected setup.py calls and add a
note in the global README.md

See https://www.debian.org/doc/packaging-manuals/python-policy/packaging_tools.html
Section B.1

Fixes: https://github.com/SELinuxProject/selinux/issues/187

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - Correctly spell python
  - wrap commit message

v2:
  Use env variable PYTON_SETUP_ARGS instead of internal detection logic

 README.md                | 2 ++
 libselinux/src/Makefile  | 2 +-
 python/sepolicy/Makefile | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index f3257ef5..9d64f0b5 100644
--- a/README.md
+++ b/README.md
@@ -95,6 +95,8 @@ To build and install everything under a private directory, run:
 
     make DESTDIR=~/obj install install-rubywrap install-pywrap
 
+On Debian `PYTHON_SETUP_ARGS=--install-layout=deb` needs to be set when installing the python wrappers in order to create the correct python directory structure.
+
 To run tests with the built libraries and programs, several paths (relative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PATH` and `$PYTHONPATH`.
 This can be done using [./scripts/env_use_destdir](./scripts/env_use_destdir):
 
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 73303c36..190016e2 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -174,7 +174,7 @@ install: all
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
+	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 69f29fa9..3361be4e 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -27,7 +27,7 @@ test:
 	@$(PYTHON) test_sepolicy.py -v
 
 install:
-	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
+	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
-- 
2.26.2

