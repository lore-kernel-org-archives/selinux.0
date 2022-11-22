Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A3C4332F
	for <selinux@archiver.kernel.org>; Tue, 22 Nov 2022 16:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiKVQN1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Nov 2022 11:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiKVQNB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Nov 2022 11:13:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547BD74CE4
        for <selinux@vger.kernel.org>; Tue, 22 Nov 2022 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669133482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hX7azLuxB98AyAXoSSGuGNZUAp4wp+IetjTbWBOmlhg=;
        b=idZCvgDW1tYzOjMZp4pkaFZ3xrpchXU1thd9Q4+wCXJINsp2juX1Gp/DVxmQmU3nbWdJWd
        13SRQ7GGcI7fwC7BlGyjy/c/2S9zWDiaO23IUM69CZP0IVeTM1RzDlvl1wzykUllnFBlcT
        HIsyRdxFjv73QqBpM4SBFlI/CpA3dJo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-OLbQtpeGOc2lY03jXvmxng-1; Tue, 22 Nov 2022 11:11:20 -0500
X-MC-Unique: OLbQtpeGOc2lY03jXvmxng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FCB138012E0
        for <selinux@vger.kernel.org>; Tue, 22 Nov 2022 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-194-62.brq.redhat.com [10.40.194.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79F3F2024CBE;
        Tue, 22 Nov 2022 16:11:18 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [RFC PATCH] Use `pip install` instead of `setup.py install`
Date:   Tue, 22 Nov 2022 17:11:06 +0100
Message-Id: <20221122161106.55037-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
    /usr/lib/python3.11/site-packages/setuptools/command/install.py:34: SetuptoolsDeprecationWarning: setup.py install is deprecated. Use build and pip and other standards-based tools.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 README.md                | 4 +++-
 libselinux/src/Makefile  | 2 +-
 python/sepolicy/Makefile | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index 529b7e46c871..e11b0028f4ba 100644
--- a/README.md
+++ b/README.md
@@ -62,6 +62,7 @@ dnf install \
 # For Python and Ruby bindings
 dnf install \
     python3-devel \
+    python3-pip \
     ruby-devel \
     swig
 ```
@@ -92,6 +93,7 @@ apt-get install --no-install-recommends --no-install-suggests \
 # For Python and Ruby bindings
 apt-get install --no-install-recommends --no-install-suggests \
     python3-dev \
+    python3-pip \
     ruby-dev \
     swig
 ```
@@ -102,7 +104,7 @@ To build and install everything under a private directory, run:
 
     make DESTDIR=~/obj install install-rubywrap install-pywrap
 
-On Debian `PYTHON_SETUP_ARGS=--install-layout=deb` needs to be set when installing the python wrappers in order to create the correct python directory structure.
+On Debian `PYTHON_SETUP_ARGS='--install-option "--install-layout=deb"'` needs to be set when installing the python wrappers in order to create the correct python directory structure.
 
 To run tests with the built libraries and programs, several paths (relative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PATH` and `$PYTHONPATH`.
 This can be done using [./scripts/env_use_destdir](./scripts/env_use_destdir):
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index dc2848322e4d..0f6396ababa4 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -187,7 +187,7 @@ install: all
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
+	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index d983e409e5e6..57a2e55edbbf 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -27,7 +27,7 @@ test:
 	@$(PYTHON) test_sepolicy.py -v
 
 install:
-	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
+	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
-- 
2.38.1

