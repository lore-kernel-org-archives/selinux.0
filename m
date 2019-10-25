Return-Path: <SRS0=OQXi=YS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19241CA9EBC
	for <selinux@archiver.kernel.org>; Fri, 25 Oct 2019 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E459F20679
	for <selinux@archiver.kernel.org>; Fri, 25 Oct 2019 13:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439700AbfJYNnN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:43:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53591 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504875AbfJYNnN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Oct 2019 09:43:13 -0400
X-Originating-IP: 176.157.204.145
Received: from localhost (static-css-ccs-204145.business.bouyguestelecom.com [176.157.204.145])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CBE2420014;
        Fri, 25 Oct 2019 13:43:10 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     selinux@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH libselinux 2/2] libselinux/src/Makefile: do not use PYCEXT, and rely on the installed file name
Date:   Fri, 25 Oct 2019 15:43:04 +0200
Message-Id: <20191025134304.12666-2-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025134304.12666-1-thomas.petazzoni@bootlin.com>
References: <20191025134304.12666-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

PYCEXT is computed by asking the Python intrepreter what is the
file extension used for native Python modules.

Unfortunately, when cross-compiling, the host Python doesn't give the
proper result: it gives the result matching the build machine, and not
the target machine. Due to this, the symlink has an incorrect name,
and doesn't point to the .so file that was actually built/installed.

To address this and keep things simple, this patch just changes the ln
invocation to rely on the name of the _selinux*.so Python module that
was installed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 libselinux/src/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index dc675a49..3fc535d4 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -15,7 +15,6 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
-PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
@@ -175,7 +174,7 @@ install: all
 install-pywrap: pywrap
 	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
-	cd $(DESTDIR)$(PYTHONLIBDIR) && ln -sf selinux/_selinux$(PYCEXT) _selinux$(PYCEXT)
+	cd $(DESTDIR)$(PYTHONLIBDIR) && ln -sf selinux/_selinux*.so .
 
 install-rubywrap: rubywrap
 	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL) 
-- 
2.21.0

