Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB3AC433FE
	for <selinux@archiver.kernel.org>; Tue, 29 Nov 2022 16:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiK2QeA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Nov 2022 11:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiK2Qd5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Nov 2022 11:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C85DBA0
        for <selinux@vger.kernel.org>; Tue, 29 Nov 2022 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669739580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vl1iAwcwtC3XoI8rjSUnVfai8n7ruhc/YtcB0BaBaIM=;
        b=fw20MgsrLnAmhEJ2/F1FS4YhPlZ6XKes/eNY3o024zJdufNRMqIF6eP/estcMKqyM8jNcW
        5xrVpQJxWFRTgm9zcwBS/Fl4CrkT1FvG3qWLnZlGW/OCeMNx5QcMs1qdQHell8ogYQBPtr
        P38ECcsdHwNWzFQ8ofqgvYsQTDF6hJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-3Qb8yRGiND2UkowZ_9H4Yg-1; Tue, 29 Nov 2022 11:32:58 -0500
X-MC-Unique: 3Qb8yRGiND2UkowZ_9H4Yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6239D8582B9
        for <selinux@vger.kernel.org>; Tue, 29 Nov 2022 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-192-247.brq.redhat.com [10.40.192.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB9452166B2D;
        Tue, 29 Nov 2022 16:32:57 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2] Use `pip install` instead of `setup.py install`
Date:   Tue, 29 Nov 2022 17:32:50 +0100
Message-Id: <20221129163250.475549-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
    /usr/lib/python3.11/site-packages/setuptools/command/install.py:34: SetuptoolsDeprecationWarning: setup.py install is deprecated. Use build and pip and other standards-based tools.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 README.md                | 8 +++++++-
 libselinux/src/Makefile  | 2 +-
 python/sepolicy/Makefile | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index 529b7e46c871..c272ce89fec5 100644
--- a/README.md
+++ b/README.md
@@ -62,6 +62,9 @@ dnf install \
 # For Python and Ruby bindings
 dnf install \
     python3-devel \
+    python3-pip \
+    python3-setuptools \
+    python3-wheel \
     ruby-devel \
     swig
 ```
@@ -92,6 +95,9 @@ apt-get install --no-install-recommends --no-install-suggests \
 # For Python and Ruby bindings
 apt-get install --no-install-recommends --no-install-suggests \
     python3-dev \
+    python3-pip \
+    python3-setuptools \
+    python3-wheel \
     ruby-dev \
     swig
 ```
@@ -102,7 +108,7 @@ To build and install everything under a private directory, run:
 
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

