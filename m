Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5QGlH6Q022754
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 12:47:18 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 849491A0C0
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 18:46:54 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id dYLhKN_zR-yT for <selinux@tycho.nsa.gov>;
 Mon, 26 Jun 2017 18:46:52 +0200 (CEST)
Received: from valinor.bigon.be (unknown [193.53.238.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id F2C6B1A074
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 18:46:51 +0200 (CEST)
From: bigon@debian.org
To: selinux@tycho.nsa.gov
Subject: [PATCH] Fix consistency of PYTHONLIBDIR variable
Date: Mon, 26 Jun 2017 18:46:51 +0200
Message-Id: <20170626164651.20452-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

PYTHONLIBDIR is currently not consistant, at one place it's influanced
by DESTDIR an at another one it's not.

Fix this and make it consistant
---
 python/semanage/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 60c36a3a..132162bc 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -5,8 +5,8 @@ PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
-PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(1))")
+PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)
 BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
 
 TARGETS=semanage
@@ -20,8 +20,8 @@ install: all
 	-mkdir -p $(SBINDIR)
 	install -m 755 semanage $(SBINDIR)
 	install -m 644 *.8 $(MANDIR)/man8
-	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d $(PYTHONLIBDIR)/site-packages
-	install -m 755 seobject.py $(PYTHONLIBDIR)/site-packages
+	test -d $(PACKAGEDIR) || install -m 755 -d $(PACKAGEDIR)
+	install -m 755 seobject.py $(PACKAGEDIR)
 	-mkdir -p $(BASHCOMPLETIONDIR)
 	install -m 644 $(BASHCOMPLETIONS) $(BASHCOMPLETIONDIR)/semanage
 
-- 
2.13.1
