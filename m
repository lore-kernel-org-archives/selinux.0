Return-Path: <SRS0=sd8A=UG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F47C2BCA1
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 15:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABAA208C3
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 15:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfFGPf4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:35:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbfFGPfz (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 7 Jun 2019 11:35:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31ED7223893
        for <selinux@vger.kernel.org>; Fri,  7 Jun 2019 15:35:55 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EE9B60C71;
        Fri,  7 Jun 2019 15:35:54 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [RFC] libselinux: Use Python distutils to install SELinux python bindings
Date:   Fri,  7 Jun 2019 17:35:44 +0200
Message-Id: <20190607153544.10046-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 15:35:55 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Follow officially documented way how to build C extension modules using
distutils - https://docs.python.org/3.8/extending/building.html#building

Fixes:

- https://bugzilla.redhat.com/show_bug.cgi?id=1715589 - selinux python module
fails to load when it's built using SWIG-4.0:

>>> import selinux
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/lib64/python3.7/site-packages/selinux/__init__.py", line 13, in <module>
    from . import _selinux
ImportError: cannot import name '_selinux' from 'selinux' (/usr/lib64/python3.7/site-packages/selinux/__init__.py)
>>>

SWIG-4.0 changed (again?) its behavior so that it uses: from . import _selinux
which looks for _selinux module in the same directory as where __init__.py is -
$(PYLIBDIR)/site-packages/selinux. But _selinux module is installed into
$(PYLIBDIR)/site-packages/ since a9604c30a5e2f ("libselinux: Change the location
of _selinux.so").

On the other hand, the module can't be loaded when it's built using older SWIG.
I'd use a symlink from $(PYLIBDIR)/site-packages/selinux to
$(PYLIBDIR)/site-packages/ in order to fix that

- https://bugzilla.redhat.com/show_bug.cgi?id=1715756 - audit2why python module
fails to build with Python 3.8

- https://bugzilla.redhat.com/show_bug.cgi?id=1709576 - selinux python module
doesn't provide any Python metadata

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/.gitignore |  2 +-
 libselinux/src/Makefile   | 37 ++++++++-----------------------------
 libselinux/src/setup.py   | 24 ++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 30 deletions(-)
 create mode 100644 libselinux/src/setup.py

diff --git a/libselinux/src/.gitignore b/libselinux/src/.gitignore
index 4dcc3b3b..428afe5a 100644
--- a/libselinux/src/.gitignore
+++ b/libselinux/src/.gitignore
@@ -1,4 +1,4 @@
 selinux.py
-selinuxswig_wrap.c
+selinuxswig_python_wrap.c
 selinuxswig_python_exception.i
 selinuxswig_ruby_wrap.c
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index e9ed0383..826c830c 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -36,7 +36,7 @@ TARGET=libselinux.so
 LIBPC=libselinux.pc
 SWIGIF= selinuxswig_python.i selinuxswig_python_exception.i
 SWIGRUBYIF= selinuxswig_ruby.i
-SWIGCOUT= selinuxswig_wrap.c
+SWIGCOUT= selinuxswig_python_wrap.c
 SWIGPYOUT= selinux.py
 SWIGRUBYCOUT= selinuxswig_ruby_wrap.c
 SWIGLOBJ:= $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT))
@@ -55,7 +55,7 @@ ifeq ($(LIBSEPOLA),)
         LDLIBS_LIBSEPOLA := -l:libsepol.a
 endif
 
-GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
+GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) $(SWIGCOUT) selinuxswig_python_exception.i
 SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
 
 MAX_STACK_SIZE=32768
@@ -125,25 +125,18 @@ DISABLE_FLAGS+= -DNO_ANDROID_BACKEND
 SRCS:= $(filter-out label_backends_android.c, $(SRCS))
 endif
 
-SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./ $(DISABLE_FLAGS)
-
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
 
 all: $(LIBA) $(LIBSO) $(LIBPC)
 
-pywrap: all $(SWIGFILES) $(AUDIT2WHYSO)
+pywrap: all selinuxswig_python_exception.i
+	CFLAGS="$(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext -I $(DESTDIR)$(INCLUDEDIR) -L $(DESTDIR)$(LIBDIR)
 
 rubywrap: all $(SWIGRUBYSO)
 
-$(SWIGLOBJ): $(SWIGCOUT)
-	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(PYINC) -fPIC -DSHARED -c -o $@ $<
-
 $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
-$(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lselinux $(PYLIBS)
-
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
 	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYLIBS)
 
@@ -161,29 +154,15 @@ $(LIBPC): $(LIBPC).in ../VERSION
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
 
-$(AUDIT2WHYLOBJ): audit2why.c
-	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
-
-$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS) -Wl,-soname,audit2why.so,--version-script=audit2why.map,-z,defs
-
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
 
 %.lo:  %.c policy.h
 	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
-$(SWIGCOUT): $(SWIGIF)
-	$(SWIG) $<
-
-$(SWIGPYOUT): $(SWIGCOUT)
-
 $(SWIGRUBYCOUT): $(SWIGRUBYIF)
 	$(SWIGRUBY) $<
 
-swigify: $(SWIGIF)
-	$(SWIG) $<
-
 install: all 
 	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
 	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
@@ -194,10 +173,8 @@ install: all
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	test -d $(DESTDIR)$(PYTHONLIBDIR)/selinux || install -m 755 -d $(DESTDIR)$(PYTHONLIBDIR)/selinux
-	install -m 755 $(SWIGSO) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
-	install -m 755 $(AUDIT2WHYSO) $(DESTDIR)$(PYTHONLIBDIR)/selinux/audit2why$(PYCEXT)
-	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
+	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
+	install -m 644 selinux.py $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 
 install-rubywrap: rubywrap
 	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL) 
@@ -208,6 +185,8 @@ relabel:
 
 clean-pywrap:
 	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
+	$(PYTHON) setup.py clean
+	-rm -rf build *~ \#* *pyc .#*
 
 clean-rubywrap:
 	-rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
diff --git a/libselinux/src/setup.py b/libselinux/src/setup.py
new file mode 100644
index 00000000..b12e7869
--- /dev/null
+++ b/libselinux/src/setup.py
@@ -0,0 +1,24 @@
+#!/usr/bin/python3
+
+from distutils.core import Extension, setup
+
+setup(
+    name="selinux",
+    version="2.9",
+    description="SELinux python 3 bindings",
+    author="SELinux Project",
+    author_email="selinux@vger.kernel.org",
+    ext_modules=[
+        Extension('selinux._selinux',
+                  sources=['selinuxswig_python.i'],
+                  include_dirs=['../include'],
+                  library_dirs=['.'],
+                  libraries=['selinux']),
+        Extension('selinux.audit2why',
+                  sources=['audit2why.c'],
+                  include_dirs=['../include'],
+                  library_dirs=['.'],
+                  libraries=['selinux'],
+                  extra_link_args=['-l:libsepol.a'])
+    ],
+)
-- 
2.22.0.rc3

