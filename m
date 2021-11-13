Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF92C433FE
	for <selinux@archiver.kernel.org>; Sat, 13 Nov 2021 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BA2611AE
	for <selinux@archiver.kernel.org>; Sat, 13 Nov 2021 14:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhKMOT0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Nov 2021 09:19:26 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50949 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235634AbhKMOTZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Nov 2021 09:19:25 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 48E243200E51;
        Sat, 13 Nov 2021 09:16:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 13 Nov 2021 09:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=b1Y0P/MB3oA6QdgBPw6TnzEQXX
        Nqt4zfXdVhd7sUWGg=; b=WhhgYEvuSf1X5GrsHcKFPRKC9xMU1Ek6jD6ooBkJ3K
        kzQGjVpJIguiOOOj6t7IPAZmLbOSwqTE5l515VwpEGbjfFHzOxQJmTMFs/bdMJKn
        omGvzIxTtKOy4CRdt7Jkh8pcay8uCQmkqIhFUwlgyvDgZNvoyqwFB5MXAta8ahbc
        MFHckgVJ4/pVz5wP4oUnuWC6aFqY2hoIGgBC2FtAj5dHf3igjxjoADvVF+FhQHsR
        K8RDKWlVq7k7yOMclKl6+eDINq6dxdFk9Xdsc19Lu8tLWgp/V3NxKKyWvsE2uGU0
        b/qdV6N0W2kknj0uNIr+uCCJoEGJVGZJh6tO7UmRpuMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=b1Y0P/
        MB3oA6QdgBPw6TnzEQXXNqt4zfXdVhd7sUWGg=; b=aQ6+y1w8SbPc/Uf/7nx8hh
        TmllMqT1n4AEXjPrHQYUgGCQ3vcQqjANGufwTPn11VUixAegJkfpnpk13lpOZ71i
        bNfJEa7BRbGUwdIdIspJKac6PahF2GThAXPhCLvgclf5XbTK0OXBbds4bYZEsvKB
        NbSaNEOTBovKL9ZmwzhlZYweTDv9MYtfF4HiLyX7uM/rk4emtWQtqY2Tjne4OMIB
        tSaBy+ZTvunG+gzi2l8laNmndm1oDJHq4zBd5jDoierNxv4pdkmoVaKV4K2mWPUN
        JI+olisW6w8sTFbfineUWPeXxjCcdtkUPwHRVKqHXINt4nZ6GSKb+PC+gw5IGr/Q
        ==
X-ME-Sender: <xms:wMiPYVwWdgFO3pClnbi8jz0UiO8Bt1ICw5snNqduIumP2bBsw0Twgw>
    <xme:wMiPYVRJJGQm2O4BWgb8JtoRUjSHQTbK2YbmRS2kjsPB2ZDRnIUPxJRnrhzuBQSqi
    d056TXKjbh--EJ0kw>
X-ME-Received: <xmr:wMiPYfUIJaZBamgvd2o1jbNXJzvNU_B8TpSYWIFlB9mscGYT3JO-M914FwtPm5samELrmfv3A5PD3qJi8ROJ6x1-6Yih9xjsyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdehgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpefgiedtje
    duffdujeeufedvvefflefgffehfedtveefieekhfffueehteeffffgudenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepqhihlhhishhsseigvddvtddrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:wMiPYXhakACwhQGVuGCOv6E2_t9dAm9sUXR2Qb9H06q3mBZ4LItfZQ>
    <xmx:wMiPYXAZoqETy_ZqfZJPHuGiwFdI_bDQfFmZGTSgHYAR88eV-7DSSg>
    <xmx:wMiPYQIRBolE0Z5kQdfj_6RFQjFyPqxfib4572kpSSqgBT70REZ3RA>
    <xmx:wMiPYapvDAqOo6sP2-jASQZzPb0K6jBRHAzFaJ9p9J1r0S-ggdIcAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Nov 2021 09:16:32 -0500 (EST)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id F150348E; Sat, 13 Nov 2021 14:16:30 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     selinux@vger.kernel.org
Cc:     Alyssa Ross <hi@alyssa.is>, Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH v2] Support static-only builds
Date:   Sat, 13 Nov 2021 14:16:16 +0000
Message-Id: <20211113141616.361640-1-hi@alyssa.is>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Sometimes it's useful to have a static-only toolchain.  This can be
due to targetting some weird embedded platform, or it can be because
it ensures that no dynamic libraries are sneaking into a system that's
supposed to be 100% static due to non-cooperative build systems.  Most
build systems support static-only builds, e.g. autoconf provides a
--disable-shared configure option.

selinux's custom make-based build system did not support such an
option, so here I've added one.  Apart from the obvious changes, I had
to make the utilities that use external libraries link against them
manually, because that can't be inferred from the static selinux
libraries.  For downstream users of libselinux using pkg-config, this
shouldn't be a problem, because libselinux.pc already includes the
Requires.private line that specifies libpcre should be linked against
as well.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
Changes since v1:

 • Moved libselinux.a ahead of -lpcre in the linker arguments for
   sefcontext_compile in libselinux/utils/Makefile, as suggested by
   Nicolas Iooss, to hopefully fix CI.

 • Fixed static-only builds of libsemanage and policycoreutils, in
   addition to libsepol and libselinux.  I've also tested building
   checkpolicy and semodule-utils, which worked without any further
   changes.

v1: https://lore.kernel.org/selinux/20211111164229.9711-1-hi@alyssa.is/

 libselinux/src/Makefile              | 11 ++++++++---
 libselinux/utils/Makefile            |  7 ++++++-
 libsemanage/src/Makefile             |  9 +++++++--
 libsepol/src/Makefile                | 11 ++++++++---
 policycoreutils/load_policy/Makefile |  2 +-
 policycoreutils/semodule/Makefile    |  3 ++-
 policycoreutils/setfiles/Makefile    |  2 ++
 policycoreutils/setsebool/Makefile   |  3 ++-
 8 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 52c40f01..814012e1 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -136,7 +136,10 @@ endif
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
 
-all: $(LIBA) $(LIBSO) $(LIBPC)
+all: $(LIBA) $(LIBPC)
+ifneq ($(DISABLE_SHARED),y)
+all: $(LIBSO)
+endif
 
 pywrap: all selinuxswig_python_exception.i
 	CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
@@ -175,11 +178,13 @@ $(SWIGRUBYCOUT): $(SWIGRUBYIF)
 install: all 
 	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
 	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
-	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
-	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
 	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
+ifneq ($(DISABLE_SHARED),y)
+	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
+	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
+endif
 
 install-pywrap: pywrap
 	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 36816155..c58ae6f8 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -52,7 +52,12 @@ else
 TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 endif
 
-sefcontext_compile: LDLIBS += ../src/libselinux.a $(PCRE_LDLIBS) -lsepol
+sefcontext_compile: LDLIBS += ../src/libselinux.a -lsepol
+
+PCRE_USERS = matchpathcon sefcontext_compile selabel_digest \
+	selabel_get_digests_all_partial_matches selabel_lookup \
+	selabel_lookup_best_match selabel_partial_match
+$(PCRE_USERS): LDLIBS += $(PCRE_LDLIBS)
 
 all: $(TARGETS)
 
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index ab6cae51..824910ef 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -66,7 +66,10 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 
-all: $(LIBA) $(LIBSO) $(LIBPC)
+all: $(LIBA) $(LIBPC)
+ifneq ($(DISABLE_SHARED),y)
+all: $(LIBSO)
+endif
 
 pywrap: all $(SWIGSO)
 
@@ -136,11 +139,13 @@ swigify: $(SWIGIF)
 install: all 
 	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
 	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
-	install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
 	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
 	test -f $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION)
+ifneq ($(DISABLE_SHARED),y)
+	install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
 	cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+endif
 
 install-pywrap: pywrap 
 	test -d $(DESTDIR)$(PYTHONLIBDIR) || install -m 755 -d $(DESTDIR)$(PYTHONLIBDIR)
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index dc8b1773..a3623635 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -39,7 +39,10 @@ LDFLAGS += -undefined dynamic_lookup
 LN=gln
 endif
 
-all: $(LIBA) $(LIBSO) $(LIBPC)
+all: $(LIBA) $(LIBPC)
+ifneq ($(DISABLE_SHARED),y)
+all: $(LIBSO)
+endif
 
 
 $(LIBA):  $(OBJS)
@@ -81,11 +84,13 @@ endif
 install: all
 	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
 	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
-	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
-	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
 	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
+ifneq ($(DISABLE_SHARED),y)
+	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
+	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
 	$(LN) -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
+endif
 
 relabel:
 	/sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index c1ba805b..78eec8fa 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -7,7 +7,7 @@ LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-override LDLIBS += -lsepol -lselinux
+override LDLIBS += -lselinux -lsepol
 
 TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index 73801e48..a1220df2 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -5,11 +5,12 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override LDLIBS += -lsepol -lselinux -lsemanage
+override LDLIBS += -lsemanage -lsepol -lselinux
 SEMODULE_OBJS = semodule.o
 
 all: semodule genhomedircon
 
+semodule: LDLIBS += -laudit -lbz2
 semodule: $(SEMODULE_OBJS)
 
 genhomedircon:
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index 63d81850..5d2a815e 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -15,6 +15,8 @@ endif
 
 all: setfiles restorecon restorecon_xattr
 
+restorecon_xattr setfiles: LDLIBS += -lpcre
+
 setfiles: setfiles.o restore.o
 
 restorecon: setfiles
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index 4b55046c..d11a1fc7 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -6,13 +6,14 @@ MANDIR = $(PREFIX)/share/man
 BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
 
 CFLAGS ?= -Werror -Wall -W
-override LDLIBS += -lsepol -lselinux -lsemanage
+override LDLIBS += -lsemanage -lsepol -lselinux
 SETSEBOOL_OBJS = setsebool.o
 
 BASHCOMPLETIONS=setsebool-bash-completion.sh 
 
 all: setsebool
 
+setsebool: LDLIBS += -laudit -lbz2
 setsebool: $(SETSEBOOL_OBJS)
 
 install: all

base-commit: 7f600c40bc18d8180993edcd54daf45124736776
-- 
2.33.0

